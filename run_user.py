import sys
import time

from selenium import webdriver
from selenium.webdriver.chrome.service import Service


def visit(url):
  options = webdriver.ChromeOptions()

  options.add_argument('--no-sandbox')
  options.add_argument('--window-size=800,600')
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')

  driver = webdriver.Chrome(service=Service('/chromedriver'), options=options)

  #RJW: We need to make a request to the site before setting the cookie. Otherwise,
  # the driver throws an exception about an invalid cookie domain. 
  driver.get(url + "/404")
  driver.add_cookie({"name": "key", "value": "value"})

  driver.get(url)

  driver.quit()


def main():
    # The simulated user will make requests every 10 seconds for up to an hour.
    for x in range(360):
        visit("http://127.0.0.1")

        #RJW: You can use this requestcatcher to see if the simulated user 
        # is properly making requests
        # visit("http://cakelab.requestcatcher.com/simulated_user_challenge")

        time.sleep(10)

if __name__ == "__main__":
  main()
