
# Setting up oh-my-posh and external module
oh-my-posh init pwsh --config 'C:\Users\wilsonchen\AppData\Local\Programs\oh-my-posh\themes\night-owl.omp.json' | Invoke-Expression
# "multiverse-neon.omp.json"
# "night-owl"
# "multiverse-neon"
# "catppuccin"
# "catppuccin_frappe"
Import-Module Terminal-Icons
Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -chord "Tab" -Function MenuComplete
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Functions
function FuzzyCopy {
    param(
        [string]$p,
        [string]$d,
        [string]$r
    )
    Get-ChildItem -Path $p  | Where-Object { 
        ($_.Name -match $r) -or ($_.PSIsContainer) } | ForEach-Object { 
        $destinationPath = $_.FullName.Replace($p, $d).Replace($_.Name, "") ; Copy-Item -Path $_.FullName -Destination $destinationPath
    }

}
function FuzzyFind {
    param(
        [string]$p,
        [string]$r
    )
    Get-ChildItem -Path $p | Where-Object { 
        ($_.Name -match $r) -or ($_.PSIsContainer) } 
}

function FuzzyOpen {
    param(
        [string]$p,
        [string]$r
    )
    FuzzyFind $p $r  | ForEach-Object {
        exe $_
    }
}
function MyCopyItem {
    param (
        [string]$p,
        [string]$d
    )
    Copy-Item -Path $p -Destination $d
}
function exe {
    param(
        [string]$Path
    )
    explorer.exe $Path
}

# function RunHeadlessNeovide {
#     param (
#         [string]$f
#     )
#         if (!$args) {
#             neovide --frame none
#         }
#         else {
#             neovide $f --frame none
#         }
# }



$fcst = "C:\Users\wilsonchen\OneDrive - Microsoft\General\T2 Metrix Database\T2 FCST\Current Week"
$data = "C:\Users\wilsonchen\OneDrive - Microsoft\General\T2 Metrix Database"
$dsm = "C:\Users\wilsonchen\OneDrive - Microsoft\General\T2 Metrix Database\DSM\Current Week"
$cost = "C:\Users\wilsonchen\OneDrive - Microsoft\Shared Documents - (new)TPE T2 SUSTAINING TEAM\ODM & Categories\IC\BOM database dev\Database"
$desk = "C:\Users\wilsonchen\OneDrive - Microsoft\Desktop"
$vim = "C:\Users\wilsonchen\AppData\Local\nvim"
$down = "C:\Users\wilsonchen\Downloads"
# Setting up alias
Set-Alias -Name cpy -Value MyCopyItem
Set-Alias -Name vd -Value visidata
Set-Alias -Name fcp -Value FuzzyCopy
Set-Alias -Name ff -Value FuzzyFind 
Set-Alias -Name fo -Value FuzzyOpen 
Set-Alias -Name rm -Value Remove-Item
Set-Alias -Name grep -Value Select-String
Set-Alias -Name rn -Value Rename-Item
Set-Alias -Name vim -Value nvim
Set-Alias -Name v -Value nvim
Set-Alias -Name nvide -Value neovide 
Invoke-Expression (& { (zoxide init powershell | Out-String) })
