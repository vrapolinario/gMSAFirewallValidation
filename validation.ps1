# Run PowerShell as an administrator and execute the following command
Write-Host "Validating the network connectivity to the domain controller..."
Add-WindowsFeature RSAT-AD-PowerShell | Out-Null

# Import the Active Directory module
Import-Module ActiveDirectory

# Get the domain controller
$DomainController = Get-ADDomainController -Discover -Service PrimaryDC

# Write the name of the domain controller being used by the pod
Write-Host "Domain Controller: $($DomainController.HostName)"

# Define the target host and ports
$targetHost = $DomainController.HostName
$targetTcpPorts = 53, 88, 139, 389, 636

# Loop through each port
foreach ($targetPort in $targetTcpPorts) {
    # Test the connection
    $connectionTest = Test-NetConnection -ComputerName $targetHost -Port $targetPort

    # Check if the port is open
    if ($connectionTest.TcpTestSucceeded) {
        Write-Output "TCP port $targetPort is open on $targetHost."
    } else {
        Write-Output "TCP port $targetPort is not open on $targetHost."
    }
}

# Define the target host and ports
$targetHost = $DomainController.HostName
$targetUdpPorts = 53, 88, 389

# Loop through each port
foreach ($targetPort in $targetUdpPorts) {
    # Test UDP connection
    try {
        $udpClient = New-Object System.Net.Sockets.UdpClient($targetHost, $targetPort)
        Write-Output "UDP port $targetPort is open on $targetHost."
    } catch {
        Write-Output "UDP port $targetPort is not open on $targetHost."
    } finally {
        if ($udpClient) {
            $udpClient.Close()
        }
    }
}

# Shows kerberos ticket information
Write-Host "Kerberos ticket information:"
klist get krbtgt