*** Settings ***
Documentation     A test suite with multiple tests for Selenium Practice
...
...               This test follows the example using keywords from
...               the SeleniumLibrary
Resource         resources.robot

*** Test Cases ***
Successful User Login
    Open Browser To Login Page
    Input Username     ${VALID USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open
    [Teardown]     Close Browser    

Unsuccessful user log in by a locked out user
    Open Browser To Login Page
    Input Username     ${LOCKED OUT USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    # Error message is "Epic sadface: Sorry, this user has been locked out."
    Element Text Should Be    xpath://*[@id="login_button_container"]/div/form/div[3]/h3    Epic sadface: Sorry, this user has been locked out.
    [Teardown]     Close Browser    

Typed wrong password
    Open Browser To Login Page
    Input Username    ${VALID USER}
    Input Pass    ${INVALID PASSWORD}
    Submit Credentials
    # Error message is "Epic sadface: Username and password do not match any user in this service"
    Element Text Should Be    xpath://*[@id="login_button_container"]/div/form/div[3]/h3    Epic sadface: Username and password do not match any user in this service
    [Teardown]     Close Browser  
Logged in as problem user and sees a broken inventory page
    Open Browser To Login Page
    Input Username    ${PROBLEM USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    # All images should be a cute dog (check first and last)
    Element Text Should Be    xpath:/html/body/div/div/div/div[2]/div/div/div/div[1]/div[1]/a/img    ${undefined}
    Element Text Should Be    xpath:/html/body/div/div/div/div[2]/div/div/div/div[6]/div[1]/a/img    ${undefined}
    [Teardown]     Close Browser
    
Sort product name (A to Z)
    Open Browser To Login Page
    Input Username     ${VALID USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open
    # Check First and Last product (low level test)
    Element Text Should Be    xpath:/html/body/div/div/div/div[2]/div/div/div/div[1]/div[2]/div[1]/a/div    Sauce Labs Backpack 
    Element Text Should Be    xpath:/html/body/div/div/div/div[2]/div/div/div/div[6]/div[2]/div[1]/a/div    Test.allTheThings() T-Shirt (Red)
    [Teardown]     Close Browser    

Sort product name (Z to A)
    Open Browser To Login Page
    Input Username     ${VALID USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open
    # Select from dropdown, select Z TO A
    Select From List By Value    xpath:/html/body/div/div/div/div[1]/div[2]/div[2]/span/select    za
    Element Text Should Be    xpath:/html/body/div/div/div/div[2]/div/div/div/div[1]/div[2]/div[1]/a/div    Test.allTheThings() T-Shirt (Red)
    Element Text Should Be    xpath:/html/body/div/div/div/div[2]/div/div/div/div[6]/div[2]/div[1]/a/div    Sauce Labs Backpack 
    [Teardown]     Close Browser    

Sort product price (low to high)
    Open Browser To Login Page
    Input Username     ${VALID USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open
    Select From List By Value    xpath:/html/body/div/div/div/div[1]/div[2]/div[2]/span/select    lohi
    Element Text Should Be    xpath:/html/body/div/div/div/div[2]/div/div/div/div[1]/div[2]/div[2]/div    $7.99
    Element Text Should Be    xpath:/html/body/div/div/div/div[2]/div/div/div/div[6]/div[2]/div[2]/div    $49.99
    [Teardown]     Close Browser    

Sort product price (high to low)
    Open Browser To Login Page
    Input Username     ${VALID USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open
    Select From List By Value    xpath:/html/body/div/div/div/div[1]/div[2]/div[2]/span/select    hilo
    Element Text Should Be    xpath:/html/body/div/div/div/div[2]/div/div/div/div[1]/div[2]/div[2]/div    $49.99
    Element Text Should Be    xpath:/html/body/div/div/div/div[2]/div/div/div/div[6]/div[2]/div[2]/div    $7.99
    [Teardown]     Close Browser    
