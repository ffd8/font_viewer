/*
font_viewer v1.0
 teddavis.org 2017
 */

PFont font;
String fontPath = "FreeSans.ttf";

import drop.*;
SDrop drop;
MyDropListener dropList;

import controlP5.*;
ControlP5 cp5;
String defaultValue = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
String textValue = defaultValue;
String displayValue = defaultValue;
//String textValue = "12345";
Textfield myTextfield;

int fontS = 48;

void setup() {
  size(500, displayHeight);
  background(0);
  pixelDensity(displayDensity());
  frameRate(5);
  drop = new SDrop(this);
  dropList = new MyDropListener();
  drop.addDropListener(dropList);

  cp5 = new ControlP5(this);

  cp5.addTextfield("textValue")
    .setPosition(10, 10)
    .setSize(floor(width*.75), 30)
    .setValue(textValue)
    .setFocus(true)
    .setLabel("")
    ;
    
    cp5.addBang("clear")
     .setPosition(floor(width*.75)+15,10)
     .setSize(50,30)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ; 
     
     cp5.addBang("abc")
     .setPosition(floor(width*.75)+70,10)
     .setSize(50,30)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ; 
     
     cp5.addSlider("fontS")
     .setPosition(10,50)
     .setSize(floor(width*.75),20)
     .setRange(5,150)
     .setLabel("")
     ;
}
void draw() {
  background(0);
  fill(255);
  try {
    font = createFont(fontPath, fontS);
    textFont(font);
    displayValue = cp5.get(Textfield.class, "textValue").getText();
  } catch (Exception e) {
    font = null;
    displayValue = "KILLED FONT!";
    //noLoop();
    
    //e.printStackTrace();
    //line = null;
  }
  
  text(displayValue, 10, 100, width-20, height-110);
}

void dropEvent(DropEvent theDropEvent) {
}
// a custom DropListener class.
class MyDropListener extends DropListener {

  int myColor;

  MyDropListener() {
    myColor = color(255, 0);
    // set a target rect for drop event.
    setTargetRect(0, 0, width, height);
  }

  void draw() {
    fill(myColor);
    noStroke();
    rect(0, 0, width, height);
  }

  void dropEnter() {
    myColor = color(0, 255, 0, 80);
  }

  void dropLeave() {
    myColor = color(255, 0);
  }

  void dropEvent(DropEvent theDropEvent) {
    boolean dirCheck = false;
    if (theDropEvent.isFile()) {
      File myFile = theDropEvent.file();
      if (myFile.isDirectory()) {
        dirCheck = true;
      }
    }

    if (theDropEvent.isFile() && !dirCheck) {      
      fontPath = theDropEvent.filePath();
      loop();
    }
  }
}

public void clear() {
  cp5.get(Textfield.class,"textValue").clear();
}

public void abc() {
  cp5.get(Textfield.class,"textValue").setText(defaultValue);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    Textfield t = (Textfield)theEvent.getController();

    println("controlEvent: accessing a string from controller '"
      +t.getName()+"': "+t.getStringValue()
      );
  }
}