Import-Module posh-docker
Import-Module posh-git
Import-Module PowerShellGet
Import-Module PSReadLine

Import-GitPrompt
Import-VisualStudioConfiguration

# Custom Git prompt
function prompt
{
    $origLastExitCode = $LASTEXITCODE
    Write-Host $ExecutionContext.SessionState.Path.CurrentLocation -nonewline -ForegroundColor Green
    Write-VcsStatus
    $LASTEXITCODE = $origLastExitCode
    "$('>' * ($nestedPromptLevel + 1)) "
}

# PowerShell parameter completion shim for the dotnet CLI 
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}