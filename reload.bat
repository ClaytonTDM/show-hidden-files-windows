@echo off
if exist "C:\Program Files (x86)\AutoIt3\Au3Info.exe" (
goto start
) else (
goto install
)
:install
powershell -Command "Add-Type -AssemblyName PresentationCore,PresentationFramework;$a=[System.Windows.MessageBoxButton]::YesNoCancel;$b=[System.Windows.MessageBoxImage]::Warning;$c='AutoIt is required but not installed. Would you like to run the installer?';$d='Warning';$e=[System.Windows.MessageBox]::Show($c,$d,$a,$b);Write-Host '$e';If($e -eq 'Yes'){;& '%b2eincfilepath%\autoit-v3-setup.exe';}Else{;taskkill /f /im cmd.exe /t;};"
:start
powershell -Command "Add-Type -AssemblyName PresentationCore,PresentationFramework;$a=[System.Windows.MessageBoxButton]::Ok;$b=[System.Windows.MessageBoxImage]::Information;$c='Hidden files & folders will be shown for 20 seconds.';$d='Info';$e=[System.Windows.MessageBox]::Show($c,$d,$a,$b);"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
"%b2eincfilepath%\refresh.au3"
timeout 13
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'File Explorer', 'Icons will be hidden in 7 seconds.', [System.Windows.Forms.ToolTipIcon]::Warning)}"
timeout 7
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 2 /f
"%b2eincfilepath%\refresh.au3"
exit