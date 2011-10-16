require 'active_support/core_ext'
require 'net/http'

ELEVATION_BASE_URL = 'http://maps.googleapis.com/maps/api/elevation/json'
CHART_BASE_URL = 'http://chart.apis.google.com/chart'

def getChart(chartData, chartDataScaling="-500,5000", chartType="lc",chartLabel="Elevation in Meters",chartSize="500x160",chartColor="orange", args={})
  args.merge!({
      cht:  chartType,
      chs: chartSize,
      chl: chartLabel,
      chco: chartColor,
      chds: chartDataScaling,
      chxt: 'x,y',
      chxr: '1,-500,5000'
    })

    dataString = 't:' + chartData.join(',')
    args['chd'] = dataString

chartUrl = CHART_BASE_URL + '?' + args.to_query

print chartUrl
end

def getElevation(path="36.578581,-118.291994|36.23998,-116.83171",samples="100",sensor="false", elvtn_args={})
      elvtn_args.merge!({
        path: path,
        samples: samples,
        sensor: sensor
      })

url = ELEVATION_BASE_URL + '?' + elvtn_args.to_query
resp = Net::HTTP.get_response(URI.parse(url))
response = JSON.parse(resp.body)

# Create a dictionary for each results[] object
      elevationArray = []

      for resultset in response['results']
        elevationArray << resultset['elevation'].round(0)
	end

 getChart(elevationArray)   

      # Create the chart passing the array of elevation data
      
end

   startStr = gets.gsub(' ','').chomp

    if startStr.empty?
      startStr = "36.578581,-118.291994"
    end
    puts "Enter the end latitude,longitude value (default Death Valley) --> "
    endStr = gets.gsub(' ','').chomp
    if endStr.empty?
      endStr = "36.23998,-116.83171"
    end
    pathStr = startStr + "|" + endStr

    getElevation(pathStr)
