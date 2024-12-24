$input = Get-Content .\input
$stringInput = $input -replace '(\d)\s+(\d)','$1,$2'

[System.Collections.ArrayList]$col1 = @()
[System.Collections.ArrayList]$col2 = @()

[System.Collections.ArrayList]$resultArr = @()

#$stringInput 

#minus 1 for null-indexed array
0..(($stringInput.Length) -1) | ForEach-Object {
    $int = $PSItem
    #cast to int for å kunne søke med indexof
    $col1.Add([int]$stringInput[$int].Split(',')[0])
    $col2.Add([int]$stringInput[$int].Split(',')[1])
}

foreach ($item in $col1.Length)
{
    #Write-Host "Getting lowest from col1"
    [int]$col1Lowest    = ($col1 | Measure-Object -Minimum).Minimum
    Write-Host "Lowest from col1 $($col1Lowest)"
    $col1LowestIndex    = [Array]::IndexOf($col1, $col1Lowest)
    $col1.Remove($col1[$col1LowestIndex])

    #Write-Host "Getting lowest from col2"
    [int]$col2Lowest    = ($col2 | Measure-Object -Minimum).Minimum
    Write-Host "Lowest from col2 $($col2Lowest)"
    $col2LowestIndex    = [Array]::IndexOf($col2, $col2Lowest)
    $col2.Remove($col2[$col2LowestIndex])

    $colDiff    = $col1Lowest - $col2Lowest
    #absolute value fordi 2-4=-2 men absolutt verdi av -2 er 2
    $colDiff    = [System.Math]::Abs($colDiff)
    Write-Host "diff on column values = $($colDiff)"

    $resultArr.Add($colDiff) | Out-Null
}

$finalResult = ($resultArr | Measure-Object -Sum).Sum