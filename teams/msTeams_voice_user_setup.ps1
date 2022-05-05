<#
Script actions:
    - Loops through a CSV file 'users.csv'
    - Creates a UPN with the 'username' in CSV and specified domain suffix ($upn)
    - Assigns a phone number in +E164 format from the 'phoneNumber' field in CSV ($phone)
    - Enables user for Enterprise Voice and Direct Routing
    - Assigns Direct Routing Voice Routing Policy ($voiceroutingpolicy) 
    - Assigns Direct Routing Emergency Call Routing Policy ($emergencypolicy) 

    CSV Format:
    username,phoneNumber
    joe.bloggs,+44203001001
#>

# Connect to MicrosoftTeams

Connect-MicrosoftTeams 

# Import the CSV
$usersCSV = Import-Csv .\users.csv -Delimiter ","
$usersCSV | Format-Table

# Assign Teams policies to the users in CSV
ForEach ($user in $usersCSV) {
        $uname = $user.username
        $phone = $user.phoneNumber
        $upn = $uname + "@<domain name>"
        $voiceroutingpolicy = "UK_SBC_Voice_Routing_Policy"
        $emergencypolicy = "UK_SBC_Emergency_Policy"
        Write-Host "Updated user with username $uname and added phonenumber $phone"
        if ($user) {
            try{
            Set-CsPhoneNumberAssignment -Identity $upn -PhoneNumber $phone -PhoneNumberType DirectRouting
            Grant-CsOnlineVoiceRoutingPolicy -Identity $upn -PolicyName $voiceroutingpolicy
            Grant-CsTeamsEmergencyCallRoutingPolicy -Identity $upn -PolicyName $emergencypolicy
            } catch {
            $FailedUsers += $upn
            Write-Warning "$upn user found, but FAILED to update."
            }
        }
        else {
            Write-Warning "$upn not found, skipped"
            $SkippedUsers += $upn
        }
}        

