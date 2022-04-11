targetScope = 'subscription'

param myResourceGroup string = 'rg-test007'




@description('Name of new or existing vnet to which Azure Bastion should be deployed')
param vnetName string = 'vnet01'

@description('IP prefix for available addresses in vnet address space')
param vnetIpPrefix string = '10.0.0.0/16'

@description('Specify whether to provision new vnet or deploy to existing vnet')
@allowed([
  'new'
  'existing'
])
param vnetNewOrExisting string = 'new'

@description('Bastion subnet IP prefix MUST be within vnet IP prefix address space')
param bastionSubnetIpPrefix string = '10.0.1.0/27'

@description('Name of Azure Bastion resource')
param bastionHostName string = 'Bastion-Test'

@description('Azure region for Bastion and virtual network')
param location string = 'swedencentral'



//Create Resource Group 

resource myRG01 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: myResourceGroup
  location: location

}





module myBastion 'bastion.bicep' = {
  name: 'myBastionDeploy'
  scope: myRG01
  params: {
    vnetName: vnetName
    vnetNewOrExisting: vnetNewOrExisting
    vnetIpPrefix: vnetIpPrefix
    location: location
    bastionHostName: bastionHostName
    bastionSubnetIpPrefix: bastionSubnetIpPrefix
  }

}

