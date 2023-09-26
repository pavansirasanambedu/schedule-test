# write-output Apigee Artifacts
$token = $env:TOKEN
$org = $env:manualorg
$git_token = $env:git_token
# $baseURL = "https://apigee.googleapis.com/v1/organizations/"
$baseURL = "https://httpbin.org/get"
$headers = @{Authorization = "Bearer $token"}
$workflowmethod = $env:run

Write-Host $workflowmethod
Write-Host $env:manualorg

# Initialize $org with a default value
$org = $env:org

if ($workflowmethod -eq "manual"){
    Write-Host "Entered into Manual...!"
    # No need to reassign $org in the "manual" branch
    Write-Host $org
}
else{
    Write-Host "Entered into Schedule...!"
    $orgs = $env:org -split ","
    Write-Host $orgs
    foreach ($org in $orgs){
        Write-Host $org
    }
}

Write-Host "Exited out of the IF with: $org"

$path = $baseURL
Invoke-RestMethod -Uri "https://apigee.googleapis.com/v1/organizations/$org/apis" -Method 'GET' -Headers $headers -ContentType "application/json" -ErrorAction:Stop -TimeoutSec 60 -OutFile "test.json"
