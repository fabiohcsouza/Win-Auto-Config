using namespace System.Management.Automation
using namespace System.Collections.ObjectModel

function install_packages($filepath) {
    # Verifica se o winget está instalado. 
    if (!Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Error "Winget is not installad. Please install winget before running this script."
        return
    }
    
    # Abre o arquivo e lê cada linha
    $packages = Get-Content $filepath
    # Instala cada pacote usando o winget 
    $packages | ForEach-Object {
        winget install -e --id$_
    }
}

if ($args.Count -eq 1 -and $args[0] -eq "-I") {
    install_packages("packages.txt")
} else {
    Write-Error "Invalid command. Please use -I to install packages"
}
