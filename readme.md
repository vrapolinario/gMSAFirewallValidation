# gMSA Firewall validation for Windows Pods

This repository contains scripts and resources for validating Group Managed Service Accounts (gMSA) in a Kubernetes environment. The validation ensures that Windows pods can successfully communicate with the Active Directory Domain Controller (AD DC) over specific ports.

## Overview

In a Kubernetes environment, Windows pods may need to authenticate to an Active Directory Domain Controller for various operations. This repository provides a validation mechanism to ensure that the required ports are open for communication between the Windows pods and the AD DC.

The validation is performed using PowerShell scripts that test TCP and UDP connectivity to the AD DC on the required ports.

## Usage

1. Run the PowerShell scripts on the Windows pods that need to communicate with the AD DC.

The scripts will output whether each port is open or not for both TCP and UDP protocols.

## Note

The UDP test only checks if a UDP port can be opened. It does not test if data can be sent or received on the port, as UDP is a connectionless protocol.

## Contributing

Contributions are welcome. Please submit a pull request or open an issue to discuss the changes you want to make.
