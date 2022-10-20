param name string
param location string = resourceGroup().location
param dockerimagetag string
param apidefinitionurl string = '' 
param existing_revision string



resource kv 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: 'kv-${name}'
}

module customerapi 'final-customerapi-bluegreen.bicep' = {
  name: 'customerapiDeploy'
  params: {
    db_connectionstring: kv.getSecret('dbconnection')
    dockerimagetag: dockerimagetag
    name:name
    apidefinitionurl: apidefinitionurl
    location: location
    existing_revision: existing_revision
  }
}

