Function Get-EmptyFolders()
{
    <#
    .SYNOPSIS
    Function to return all folders that do not have any content in them (empty)
    
    .DESCRIPTION
    Function to return all folders that do not have any content in them (empty). The values that are returned is an array containing the full path to the empty folders.
    
    .PARAMETER StartPath
    String to indicate what to starting point is
    
    .PARAMETER LogToScreen
    Should a message be displayed on the screen while enumerating files. All empty found folders are displayed
    
    .EXAMPLE
    $Results = Get-EmptyFolders "c:\temp"

    .EXAMPLE
    Get-EmptyFolders c:\temp | %{rm -literalPath $_ force}

    List all empty folders and remove them. 
    
    .NOTES
    General notes
    #>
    
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $StartPath,
        [boolean]
        $LogToScreen=$true
    )

    $targetFolders = Get-ChildItem -literalpath $StartPath -Recurse
    $EmpytReturns=@()
    Foreach ($TargetFolder in $targetFolders)
    {
        $FolderEmpty=$false
        if ($TargetFolder.psiscontainer -eq $true)
            {
                if ((Get-ChildItem -literalpath $TargetFolder.fullname) -eq $null){
                    $FolderEmpty=$true
                    if ($LogToScreen)
                    {
                        write-host $TargetFolder.FullName -ForegroundColor cyan
                    }
                    $EmpytReturns += $TargetFolder.FullName
                }
            }
    }
    $EmpytReturns
}