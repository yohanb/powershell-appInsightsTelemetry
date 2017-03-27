function Import-Assembly {
    $null = [Reflection.Assembly]::LoadFile('{0}\Microsoft.ApplicationInsights.dll' -f $PSScriptRoot)
}

function Add-ApplicationInsightsMetric {
  param(
    [Parameter(Mandatory)]
    [string]
    $InstrumentationKey,
    [Parameter(Mandatory)]
    [string]
    $MetricName,
    [Parameter(Mandatory)]
    [double]
    $MetricValue
  )
  
  Import-Assembly
  
  $client = New-Object -TypeName 'Microsoft.ApplicationInsights.TelemetryClient'
  $client.InstrumentationKey = $InstrumentationKey
  
  $metric = New-Object -TypeName 'Microsoft.ApplicationInsights.DataContracts.MetricTelemetry' -ArgumentList $MetricName, $MetricValue

  $client.TrackMetric($metric)
  $client.Flush()
}

function Add-ApplicationInsightsEvent {
  param(
    [Parameter(Mandatory)]
    [string]
    $InstrumentationKey,
    [Parameter(Mandatory)]
    [string]
    $EventName,
    [Parameter(Mandatory)]
    [object]
    $EventData
  )
  
  Import-Assembly
    
  $client = New-Object -TypeName 'Microsoft.ApplicationInsights.TelemetryClient'
  $client.InstrumentationKey = $InstrumentationKey
  
  $event = New-Object -TypeName 'Microsoft.ApplicationInsights.DataContracts.EventTelemetry' -ArgumentList $EventName
  
  $client.TrackEvent($event)
  $client.Flush()
}

Export-ModuleMember -Function Add-ApplicationInsightsMetric, Add-ApplicationInsightsEvent