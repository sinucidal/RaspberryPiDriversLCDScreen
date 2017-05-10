# RaspberryPiDriversLCDScreen
A series of drivers to allow easy interfacing with an I2C LCD screen over command line

These commands are designed to be used in a shell script to allow for more efficient hardware usage as compared to an equivalent 
Python script. The beatiful thing about command line scripts is they dont need any software except the already present OS to run, and the files take up as much memory as the letters they contain.

<b>Prerequisites:</b>
-An operational Raspberry Pi(any model)
-An installed OS preferably Debian based(this system worked on Moebius which can be downloaded from sourceforge)
-Wiring Pi is a must have because the core commands are based off that package. Luckily it is available in most repos.
-sufficient power supply. The screen may be powered by the computer and if your power supply is not able to handle it,
 the device may malfunction.
 
 <b>Setting up:</b>
 The I2C module will have four connections (+5, GND, SCL, SDA). Normally just connecting these to the corresponding GPIO pins
 will be adequate, but it is recommended to pull the SDA and SCL lines high with pull up resistors. There are two !2C busses on 
 the RPI but this code was written for the second bus (bus 1). For most screens the logic level is five volts so pulling the 
 lines to the five volt rail will work. An area that may cause a problem is the aforementioned logic level. The Raspberry pi is 
 3.3v logic while the LCD is 5v. In my testing this presented no issues but it would not hurt to have a logic level shifter
 available to use in your project. Im not going to go into detail for how to set them up as there are numerous guides on the 
 internet. Once your all setup, its time to write your script.
 
 <b>The script:</b>
 There are several key commands defined in the drivers. 
 
 The setup command must be called first to initialize the display. The command structure is as follows: "./setup N F" where "N" 
 is the number of lines and "F" is the font. The number of lines does not restrict operation but does change the way the screen 
 data addresses are defined, and may be a 1 or 2. Font can either be "5x8" or "5x10" which refers to the dimensions of the dot 
 matrix. This command can only be called once per screen reset so to change it you must cut then reestablish power to the 
 screen.
 
 The write command from this point forward will be the key command to unlock everything else. It is used as: "./write COMMAND 
 TYPE" where "COMMAND" is the command you are trying the write and it's parameters and "TYPE" is the command type. There are two 
 types of commands, data commands (dat) and command commands (cmd). The text function is the only data command.
 
 The next command that needs to be called is the display command which is called from the write command (eg. ./write $(./display 
 on on on) cmd). The display command turns on or off the display, cursor, and cursor blink in that order for the parameters. The 
 parameter values can be "on" or "off". This command may be called several times without having to reset the screen.
 
 Another command is entryMode. By default the screen will increment the cursor position one space to the right, but if you want 
 it move to the left or for the screen to shift this command makes it possible. Remember to use it within a write command as 
 follows: ./write $(./entryMode CURS SHIFT) cmd where "CURS" indicates cursor direction (l for left or r for right) and SHIFT 
 toggles screen shift on(1) or off(0). This command may be called as often as needed.
 
 The move command will place the cursor at a user defined position. It's usage is: ./write $(./move ROW COL) cmd where "ROW" is 
 the row number and "COL" is the column number. While this command seems straight forward it has only been tested on a 4x20 
 display in 2 line mode(see setup function above) so far.
 
 Backlight command is a simple command that toggles the backlight on or off. It is used as: ./write $(./backlight TOG) cmd where 
 "TOG" can be "on", "ON", "1", "off", "OFF", or "0".
 
 The next two commands do not have nor do they accept parameters. The home and clear command are as straight forward as a 
 command can get. They can be used as: ./write $(./home) cmd or ./write $(./clear) cmd.
 
 The most important command to make this display do what it does is the text command. The only parameter is the text you want to 
 write. ./write $(./text "hello world!") dat (don't forget to use "dat" instead of "cmd"). First, the quotes as written will not 
 show up in the output but the parameter can be written within single quotes so double quote may be used. Do not try to embed 
 quotes as this will exit the parameter and cause an unexpected output. Another option for quotes is to add an escape sequence 
 like the driver uses for the degree symbol on line 27. These sequences use a "^" to start them and are followed by a two digit 
 code for the character(you decide). Do not worry though the driver has a function to detect if just a "^" is present and will 
 print it as is. Other than these special characters, anything you have within the quotes will print on the display. If you need 
 the hex values for the special characters you can get the binary value from page 15 <a href="https://cdn-shop.adafruit.com
 /datasheets/TC2004A-01.pdf">here</a> and convert it to hex using any online convertor you choose.
