#import simplejson
#import urllib

ELEVATION_BASE_URL = 'http://maps.googleapis.com/maps/api/elevation/json'
CHART_BASE_URL = 'http://chart.apis.google.com/chart'

def getChart(chartData, chartDataScaling="-500,5000", chartType="lc",chartLabel="Elevation in Meters",chartSize="500x160",chartColor="orange", *args)
  args.merge!({
      cht:  chartType,
      chs: chartSize,
      chl: chartLabel,
      chco: chartColor,
      chds: chartDataScaling,
      chxt: 'x,y',
      chxr: '1,-500,5000'
    })
end
