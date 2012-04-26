# Below is an XML feed of all flares within a 24 hr period GOES class > B5
# http://www.lmsal.com/hek/her?cmd=search&type=column&event_type=fl&event_region=all&event_coordsys=helioprojective&x1=-5000&x2=5000&y1=-5000&y2=5000&result_limit=120&event_starttime=2012-04-23T17:00:00&event_endtime=2012-04-24T00:00:00&param0=FL_GOESCls&op0=%3E&value0=B5&cosec=1

# info link for more information:
# http://www.lmsal.com/hek/her?cmd=export-voevent&cosec=1&ivorn=
# http://www.lmsal.com/hek/her?cmd=export-voevent&cosec=1&ivorn=ivo://helio-informatics.org/FL_SSWLatestEvents_20120423_113210_051
# http://www.lmsal.com/hek/her?cmd=view-voevent&ivorn=ivo://helio-informatics.org/FL_SSWLatestEvents_20120423_113210_051

class SpaceWeather


	require 'nokogiri'
	require 'open-uri'

	t = Time.new
	y = t-86400
	url = "http://www.lmsal.com/hek/her?cmd=search&type=column&event_type=fl&event_region=all&event_coordsys=helioprojective&x1=-5000&x2=5000&y1=-5000&y2=5000&result_limit=120&event_starttime=#{y.strftime("%Y-%m-%dT%H:%M:%S")}&event_endtime=#{t.strftime("%Y-%m-%dT%H:%M:%S")}&param0=FL_GOESCls&op0=%3E&value0=B5&cosec=1"

	report = Nokogiri::XML(open(url))

	puts "\n\nThere have been #{report.xpath("//result").count.to_s} events in the last 24h"

	report.xpath("//result").each_with_index do |result,i|


		peak = result.xpath("param[@name = 'event_peaktime']")
		scale =	result.xpath("param[@name = 'fl_goescls']")
		link  =	result.xpath("param[@name = 'kb_archivid']") 	#puts "More data here: http://www.lmsal.com/hek/her?cmd=view-voevent&ivorn=#{link.text}"

		puts "#{(i+1).to_s}) #{scale.text[0]} flare of magnitude #{scale.text[1..3]} peaked at #{peak.text}." 

	end
	puts

	#http://www.lmsal.com/hek/her?cmd=view-voevent&ivorn=ivo://helio-informatics.org/FL_SSWLatestEvents_20110809_013817_504
	#http://www.lmsal.com/hek/her?cmd=view-voevent&ivorn=ivo://helio-informatics.org/FL_SECstandard_20110907_163058_20110809074800

	#image link to LASCO C3
	#http://sohowww.nascom.nasa.gov//data/REPROCESSING/Completed/2012/c3/20120416/20120416_2354_c3_512.jpg


end

# Initalise the class and run the script.
mySpaceWeather = SpaceWeather.new