// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:css_animation/css_animation.dart';

import 'package:route_hierarchical/client.dart';

Set<Element> hoverEnabled;

void main() {
  
  hoverEnabled = new Set();

  
  
  querySelectorAll('.main-icon').onClick.listen( (MouseEvent event) {
    createRightMenu();
    setSelectedItem(event.target);
    } );

  
  querySelectorAll('.main-icon').onMouseOver.listen( (MouseEvent event) {
    animateIcon(event.target);
  } );

  querySelectorAll('.main-icon').onMouseOut.listen( (MouseEvent event) {
    inanimateIcon(event.target);
  } );


}

void inanimateIcon(Element elm)
{
  hoverEnabled.remove(elm);
  if(elm.parent.parent.classes.contains("sidebar") && !elm.parent.classes.contains("selected"))
  {
    elm.style.opacity="0.5";
  }
}

void animateIcon(Element elm)
{
  hoverEnabled.add(elm);
  var animation = new CssAnimation.properties(
    { 'border-width': 30},
    { 'border-width': 0}
  );

  if(elm.parent.parent.classes.contains("sidebar"))
  {
    elm.style.opacity="1";
  }
  
  animation.apply(elm, 
      alternate: true, 
      duration: 400, 
      iterations: 2, 
      onComplete: (){
        if(hoverEnabled.contains(elm)){
          animateIcon(elm);
        }
      }
  );
}

void createRightMenu(){
  
  var desiredWidth = "83%";
  
  if(querySelector(".main").style.width != desiredWidth)
  {
    var barAnimation = new CssAnimation('width', "100%", desiredWidth);
    //var sidebarAnimation = new CssAnimation('display', "none", "inline-block");
    querySelectorAll('.main .main-icon-container').style.display = "none";
      
    barAnimation.apply(querySelector(".main"), 
        duration: 500,
        onComplete: (){
          querySelector(".sidebar").style.display = "inline-block";
          querySelector(".article").classes.remove("invisible");
        }
    );
    
    
    
    //sidebarAnimation.apply(querySelector(".sidebar"), 500);
    
    
    
    
  }
}

void setSelectedItem(Element elm)
{
  var sidebar = querySelector(".sidebar");
  
  var children = sidebar.querySelectorAll(".main-icon-container");
  
  var selected = sidebar.querySelector("." + elm.parent.classes.toString().replaceAll(" ", "."));
  
  children.classes.remove("selected");
  
  for(var child in children)
    {
      child.querySelector(".main-icon").style.opacity = "0.5";
    }
  
  selected.classes.add("selected");
  
  selected.querySelector(".main-icon").style.opacity = "1";
}

void showAbout(RouteEvent e) {
  // Extremely simple and non-scalable way to show different views.
  querySelector('#home').style.display = 'none';
  querySelector('#about').style.display = '';
}

void showHome(RouteEvent e) {
  querySelector('#home').style.display = '';
  querySelector('#about').style.display = 'none';
}
