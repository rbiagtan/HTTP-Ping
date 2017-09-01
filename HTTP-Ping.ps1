<#
.DESCRIPTION
This tool will perform a HTTP GET looking for a RESPONSE value of 200 indicating the website is up.
A timestamped YES or NO is written to a log file. The script will run in an infinite loop.

Toolmakers: Rod Biagtan, William Yang
Date: August 30, 2017
Version: 0.2

Things that would improve the tool:
    - Variable for website
    - Option to ping infinitely or set number
    - Option to store the log file in desired directory
    - Create the log file if it doesn't exist
    - Variable for Start-Sleep
#>


#The site we are requesting
$Site = 'www.google.com'

# First we create the request
$HTTP_Request = [System.Net.WebRequest]::Create($Site)

# We then get a response from the site
$HTTP_Response = $HTTP_Request.GetResponse()

# We then get the HTTP code as an integer
$HTTP_Status = [int]$HTTP_Response.StatusCode


Add-Content C:\b4all\Utilities\HTTP_request_ping_log.txt ("Pinging " + $Site) 
while($true)
{
    $i++
    
    # Variables
    $startTime = Get-Date
    
    # Valid response
    If ($HTTP_Status -eq 200) { 
        Write-Host $startTime Hit successful
        Add-Content C:\b4all\Utilities\HTTP_request_ping_log.txt ([string]$startTime + " YES - the site is OK!") 
    # Clean up the http request by closing it
    $HTTP_Response.Close()
    }
    # Invalid response
    Else {
        Write-Host $startTime Hit unsuccessful
        Add-Content C:\b4all\Utilities\HTTP_request_ping_log.txt ([string]$startTime + " NO - the site may be DOWN!")
    }

    
    # Wait a set number of seconds before looping
    start-sleep -Seconds 1
}
