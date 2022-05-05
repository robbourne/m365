# Microsoft Teams Enterprise Voice Bulk User Update Script

## Overview

Microsoft PowerShell script to enable Azure Active Directory users with:

- Enterprise Voice
- Direct Routing
- Phone Number assignment (number managed online)
- Voice Routing Policy 
- Emergency Call Routing Policy

## Pre-requisites

- Assign E5 or E3 with 'Phone System' add-on license
- Complete SBC, Emergency Call Routing and Voice Routing Policy configuration
- Teams Administrator or higher level access to run scripts
- Download ps1 and users.csv to a local folder
- Install latest MS Teams PowerShell Module

## Instructions

1. Update the CSV with usernames in firstName.lastName eg. joe.bloggs
2. Update the CSV with phone numbers in +E164 format eg. +44203001001
3. Update ps1 script param $upn domain suffix with your domain name eg. 

```powershell
$upn = $uname + "@<domain name>"   >>>>    $upn = $uname + "@acme.com"
```
4. Update $voiceroutingpolicy with your configured Voice Routing Policy name
5. Update $emergencypolicy with your configured Emergency Call Routing Policy name
6. Connect to Teams tenant and run script