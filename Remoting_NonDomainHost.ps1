#Remoting to Non-Domain member 

#test remoting - should fail 
test-wsman -computername Server1 

$cred = get-credential Server1\administrator
#test with local admin creds 
test-wsman -computername Server1 -credential $cred -authentication Negotiate

# Add host to trustedhosts file 
get-item -path wsman:\\localhost\client\trustedhosts\
set-item -path WSMan:\\localhost\client\trustedhosts\ -Value Server1
dir WSM:\\localhost\client 

#test after adding 
test-wsman -computername Server1 -credential $cred -authentication Negotiate

invoke-command {get-service} -computername Server1 -credential $cred

#to remove from trustedhosts
set-item -path WSMan:\localhost\client\trustedhosts -Value "" -force
