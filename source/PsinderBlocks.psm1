using namespace System.Management.Automation.Language

$functionFolders = @('Enums', 'Classes', 'Public', 'Private' )
ForEach ($folder in $functionFolders) {
    $folderPath = Join-Path -Path $PSScriptRoot -ChildPath $folder
    If (Test-Path -Path $folderPath) {
        Write-Verbose -Message "Importing from $folder"
        $FunctionFiles = Get-ChildItem -Path $folderPath -Filter '*.ps1' -Recurse |
            Where-Object { $_.Name -notmatch '\.tests{0,1}\.ps1' }
        ForEach ($FunctionFile in $FunctionFiles) {
            Write-Verbose -Message "  Importing $($FunctionFile.BaseName)"
            . $($FunctionFile.FullName)
        }
    }
}

Export-ModuleMember -Function *
