require 'ferrum'
require 'dotenv/load'

SCRAPERAPI_KEY = ENV['SCRAPERAPI_KEY']
proxy_url = "http://render=true&api_key=#{SCRAPERAPI_KEY}"

browser = Ferrum::Browser.new(browser_options: { 'proxy-server': proxy_url })

browser.goto('https://news.ycombinator.com/')

puts "\nTop 5 Hacker News Headlines:\n\n"

browser.css('.athing .titleline a').first(5).each_with_index do |link, index|
  puts "#{index + 1}. #{link.text.strip}"
end

# Save output to HTML file for browser inspection
File.write('hn_output.html', browser.body)
puts "\nSaved result to hn_output.html"

browser.quit

# Optional: open the file in Chrome
system("open -a 'Google Chrome' hn_output.html")


