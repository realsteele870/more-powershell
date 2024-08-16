
function createParserArr {

    $flag = 0
        
    
    while($flag -eq 0){
$flag =1
$user = Read-Host -Prompt "Enter username"
if($user -eq ""){
clear
Write-Host "user does not exist"
$flag = 0
}
else{
try{$parser = Get-ADPrincipalGroupMembership -Identity $user | Select name | Sort-Object name}
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]{
clear
Write-Host "user does not exist"
$flag=0
}
catch{
Write-Host "Error occurred that could not be resolved"
$null= Read-Host -Prompt 'Press any enter to continue...'
exit
}
}
}
    return $parser,$user

}

function formatGroups{
param (
        [Parameter(Mandatory=$true, Position=0)]
        $arr
    )
    $output =""
    $x=1

Foreach($name in $arr){
#Write-Host $name.name +";"
#if($name.name -like "Domain Users"){
#}
#else{

    if($x-lt$arr.length){
        $output = $output + $name+";`n"
    }
     else{
     $output = $output + $name
    }
#}

 $x++
}
    return $output
}


$user1Arr,$user1 =createParserArr
$user2Arr, $user2 = createParserArr




#[System.Object[]] $differenceArr
$difference1Arr=@()
$difference2Arr=@()


foreach($unit in $user1Arr){

    if($user2Arr.name -contains $unit.name ){
        
    }
    else{
            $difference1Arr+=$unit.name
    }
}

#Write-Host $diference1Arr
$difference1Arrout = formatGroups($difference1Arr)
Write-Host "Groups in $user1 that are not in $user2 are:`n $difference1Arrout"

Write-Host "`n`n"
#Write-Host $largerArr.GetType()

foreach($unit in $user2Arr){

    if($user1Arr.name -contains $unit.name ){
        
    }
    else{
            $difference2Arr+=$unit.name
    }
}

$difference2Arr = formatGroups($difference2Arr)
Write-Host "Groups in $user2 that are not in $user1 are:`n $difference2Arr"
Write-Host "`n`n"
#Write-Host $diference2Arr

#$combinedDifference = $difference2Arr + $difference1Arr
#$combinedDifference = formatGroups($combinedDifference)
#Write-Host "missing groups for both users are:`n $combinedDifference"

#Write-Host $combinedDifference




#Write-Host $output



$null= Read-Host -Prompt 'Press any enter to continue...'