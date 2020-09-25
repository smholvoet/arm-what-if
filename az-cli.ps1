# Login & select subscription
az login
az account list --output table
az account set --subscription "Visual Studio Enterprise"
az account show

# Create resource group
az account list-locations | findStr 'europe'
az group create --name rg-arm `
                --location westeurope

# Execute what-if operation on empty resource group
az deployment group what-if --name 'initialDeploy' `
                            --resource-group rg-arm `
                            --template-file .\azuredeploy.json `
                            --parameters .\azuredeploy.parameters.json

# Deploy initial template
az deployment group create  --name 'initialDeploy' `
                            --resource-group rg-arm `
                            --template-file .\azuredeploy.json `
                            --parameters .\azuredeploy.parameters.json


# Execute what-if operation again using updated template
az deployment group create  --name 'updateStorageSKU' `
                            --resource-group rg-arm `
                            --template-file .\azuredeploy_update.json `
                            --parameters .\azuredeploy.parameters.json