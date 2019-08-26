# Azure Function Infrastructure for Python
This repository contains an ARM template and an Azure Pipelines config file that will deploy the
infrastructure needed to host a Python function as an Azure Function.

## Requirements
To use this this template and pipeline, you must have an Azure subscription with a resource group
you intend to use as the target of the infrastructure deployment.

## ARM template
The ARM template will deploy the following resources:

* General purpose v2 storage account with the following configuration set:
  * Standard LRS
  * Encryption enabled on blobs using Microsoft provided encryption keys
  * HTTPS traffic enforced
* Application Insights instance configured to receive telemetry from Azure Functions.
* Azure Functions function app configured to run Python functions under the consumption plan.

The template takes in the following parameters:

* Storage account name
* Application Insights instance name
* Function app name

## Deployment script
The deployment script wraps the template deployment. It is what Azure Pipelines calls to initiate
the deployment. It takes the same parameters as the ARM template and simply forwards them. Read the
script's help comments for more information.

## Azure Pipelines config
The Azure Pipeline defined in this repository is configured to run a single job on the latest
Ubuntu agents. It uses the Azure PowerShell task to connect to the subscription the infrastructure
will be deployed into an then call the deployment script.

When creating the pipeline in Azure DevOps, you must create an ARM service connection to the target
subscription. Additionally, the following pipeline variables need to be defined:

* AppInsightsName
* ArmConnectionName
* FunctionAppName
* ResourceGroupName
* StorageAccountName

For more information on what these variables represent, see the documentation in the Azure Pipelines
config file.
