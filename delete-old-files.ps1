$Now = Get-Date
$Days = "7"
$TargetFolder = "C:\Users\sanglyb\Documents\"
$Extension = "*"
$LastWrite = $Now.AddDays(-$Days)
$Files = Get-Childitem $TargetFolder -Include $Extension -Recurse | Where{$_.CreationTime -le "$LastWrite" -and $_.LastWriteTime -le "$LastWrite"} | Sort-Object -Descending {$_.FullName.Split('\').Count},FullName
foreach ($File in $Files)
{
 if ($File -ne $NULL -and !$File.PSIsContainer)
 {
  write-host "Deleting File $File" -ForegroundColor "Magenta"
  Remove-Item $File.FullName -Force | out-null
 }
 elseif ($File -ne $NULL -and $File.PSIsContainer)
 {
		$FolderInfo = get-Childitem $File.FullName | Measure-Object
		if ($folderInfo.count -eq 0)
		{
			write-host "Deleting directory - $File" -foregroundcolor "green"
			Remove-Item $File.FullName -Force | out-null
		}
 }
 else
 {
  Write-Host "No more files to delete!" -foregroundcolor "Green"
 }
 } 
 #удаляем пустые папки, не зависимо от времени создания
 $folderInfo=""
 $Folders = Get-Childitem $TargetFolder -Recurse | Where{$_.PSIsContainer} | Sort-Object -Descending {$_.FullName.Split('\').Count},FullName
 foreach ($Folder in $Folders)
 {
	if ($Folder -ne $null)
	{
		$FolderInfo = get-Childitem $Folder.FullName | Measure-Object
		if ($folderInfo.count -eq 0)
		{
			write-host "Deleting directory - $Folder" -foregroundcolor "yellow"
			Remove-Item $Folder.FullName -force | out-null
		}
	}
 }