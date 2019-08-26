<#
.SYNOPSIS
Deploys the infrastructure needed to host a Python Azure Function.

.DESCRIPTION
This deploys the Azure infrastructure needed to host Python functions deployed to Azure Functions.
This will provision the Application Insights instance Azure Functions uses when sending telemetry
data. This assumes you have already logged into an Azure account with Azure PowerShell using the
Connect-AzAccount cmdlet.

.PARAMETER ResourceGroupName
Name of the resource group to deploy the function app infrastructure into.

.PARAMETER StorageAccountName
Name to use for the storage account provisioned for the function app.

.PARAMETER AppInsightsName
Name to use for the Application Insights instance provisioned for the function app.

.PARAMETER FunctionAppName
Name to use for the provisioned function app.

#>
[CmdletBinding()]
param(
    [Parameter( Mandatory )]
    [string] $ResourceGroupName,

    [Parameter( Mandatory )]
    [string] $StorageAccountName,

    [Parameter( Mandatory )]
    [string] $AppInsightsName,

    [Parameter( Mandatory )]
    [string] $FunctionAppName
)

$ErrorActionPreference = "Stop"

Write-Host "Deploying function app '$FunctionAppName' to resource group '$ResourceGroupName'."

$templateParams = @{
    storageAccountName = $StorageAccountName
    appInsightsName = $AppInsightsName
    functionAppName = $FunctionAppName
}

New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName `
    -TemplateFile $PSScriptRoot\template.json `
    -TemplateParameterObject $templateParams | Out-Host

    Write-Host "Deployed function app '$FunctionAppName' to resource group '$ResourceGroupName'."
