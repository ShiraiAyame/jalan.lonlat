require 'csv'
require 'httparty'

csv_file = "yomikomi_kakuyasu.csv"
CSV.foreach(csv_file) do |row|
	address = row[3]

	begin

		response = HTTParty.get("https://msearch.gsi.go.jp/address-search/AddressSearch?q=#{ERB::Util.url_encode(address)}")
		lonlat = response[0]["geometry"]["coordinates"]

		CSV.open('scrape_kakuyasu_lon_lat.csv','a',:encoding => "utf-8") do |csv|
			csv << [row[0], row[3], lonlat[0], lonlat[1]]
		end

	rescue

		CSV.open('scrape_kakuyasu_lon_lat.csv','a',:encoding => "utf-8") do |csv|
			csv << [row[0], row[3], "", ""]
		end

	end

end

