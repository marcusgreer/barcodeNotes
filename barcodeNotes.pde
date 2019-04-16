/* for sound effects */
import processing.sound.*;

//String song = "AAACDDDEFFEDEAABCCDEAACBBCAB";//pirates
String song = "nE5 nE5 nE5 nC5 nE5 nG5 nG4 nC5 nG4 nE3 nA4 nB4 #A4 nA4 " + 
              "nG4 nE5 nG5 nA5 nF5 nG5 nE5 nC5 nD5 nB5 ";


HashMap<String,Integer> noteFrequencies = new HashMap<String, Integer>();
int indexInSong = 0;

boolean currentSignalPending = false; //won't start recieving signal until finger lifted and ready to input
int signalStartFrame = 0;             //start of the finger pressed down for 'beep'
int signalEndFrame = 0;               //release of finger, is the end of 'beep'
int rhythmFrames = 60/4;


SinOsc sine;
float sinFreq = 466.16;



void setup(){
  size(800,800);
  PFont mono;
  // The font ttf file must be located in the sketch's "data" directory to load successfully
  // mono = createFont("RubikMonoOne-Regular.ttf", 32);
  // textFont(mono);
  /* for sound effects */  
  sine = new SinOsc(this);
  sine.freq(sinFreq);
  
  noteFrequencies.put("nC3 ", -21); // (130.81);
  noteFrequencies.put("#C3 ", -20); // (138.59); // or D-flat
  noteFrequencies.put("nD3 ", -19); // (146.83);
  noteFrequencies.put("#D3 ", -18); // (155.56); // or E-flat
  noteFrequencies.put("nE3 ", -17); // (164.81);
  noteFrequencies.put("nF3 ", -16); // (174.61); 
  noteFrequencies.put("#F3 ", -15); // (185.00); // or G-flat
  noteFrequencies.put("nG3 ", -14); // (196.00); 
  noteFrequencies.put("#G3 ", -13); // (207.65); // or A-flat
  noteFrequencies.put("nA3 ", -12); // (220.00);
  noteFrequencies.put("#A3 ", -11); // (233.08); // or B-flat
  noteFrequencies.put("nB3 ", -10); // (246.94);
  
  noteFrequencies.put("nC4 ", -9); // (261.63); // Middle C
  noteFrequencies.put("#C4 ", -8); // (277.18); // or D-flat
  noteFrequencies.put("nD4 ", -7); // (293.66);
  noteFrequencies.put("#D4 ", -6); // (311.13); // or E-flat
  noteFrequencies.put("nE4 ", -5); // (329.63);
  noteFrequencies.put("nF4 ", -4); // (349.23); 
  noteFrequencies.put("#F4 ", -3); // (369.99); // or G-flat
  noteFrequencies.put("nG4 ", -2); // (392.00);
  noteFrequencies.put("#G4 ", -1); // (415.30); or A-flat
  noteFrequencies.put("nA4 ", 0);  // (440.00);
  noteFrequencies.put("#A4 ", 1);  // (466.16); // or B-flat
  noteFrequencies.put("nB4 ", 2);  // (493.88);
  
  noteFrequencies.put("nC5 ", 3);  // (523.25); 
  noteFrequencies.put("#C5 ", 4);  // (554.37); // or D-flat
  noteFrequencies.put("nD5 ", 5);  // (587.33);
  noteFrequencies.put("#D5 ", 6);  // (622.25); // or E-flat
  noteFrequencies.put("nE5 ", 7);  // (659.25);
  noteFrequencies.put("nF5 ", 8);  // (698.46); 
  noteFrequencies.put("#F5 ", 9);  // (739.99); // or G-flat
  noteFrequencies.put("nG5 ", 10); // (783.99); 
  noteFrequencies.put("#G5 ", 11); // (830.61); // or A-flat
  noteFrequencies.put("nA5 ", 12); // (880.00);
  noteFrequencies.put("#A5 ", 13); // (932.33); // or B-flat
  noteFrequencies.put("nB5 ", 14); // (987.77);
  
  noteFrequencies.put("nC6 ", 15);  // (523.25); 
  noteFrequencies.put("#C6 ", 16);  // (554.37); // or D-flat
  noteFrequencies.put("nD6 ", 17);  // (587.33);
  noteFrequencies.put("#D6 ", 18);  // (622.25); // or E-flat
  noteFrequencies.put("nE6 ", 19);  // (659.25);
  noteFrequencies.put("nF6 ", 20);  // (698.46); 
  noteFrequencies.put("#F6 ", 21);  // (739.99); // or G-flat
  noteFrequencies.put("nG6 ", 22); // (783.99); 
  noteFrequencies.put("#G6 ", 23); // (830.61); // or A-flat
  noteFrequencies.put("nA6 ", 24); // (880.00);
  noteFrequencies.put("#A6 ", 25); // (932.33); // or B-flat
  noteFrequencies.put("nB6 ", 26); // (987.77);
  
}



void draw(){ 
  background(225,90,70);
  float elapsedFrames = frameCount - signalStartFrame+1;
  playNote(elapsedFrames);
  displayCurrentDot(elapsedFrames);
}

void displayCurrentDot(float elapsedFrames){
  float sizeOfDot = 0.08*width;
  strokeCap(ROUND);
  strokeWeight(sizeOfDot);
  stroke(183, 255, 249);
  //float lengthOfSignal = pow(elapsedFrames, 1/4)/2;
  float lengthOfSignal = constrain(pow(1.5*(float) Math.cbrt(elapsedFrames-5), 4), 0,width*0.055);
  line(width/2-lengthOfSignal, height/2, width/2+lengthOfSignal,height/2);
}

void soundEffect(int startFrame, float elapsedFrames){
  float newFreq = 1/(elapsedFrames/40)*20+sinFreq;
  sine.amp(0.8);
  sine.freq(newFreq);
}

void playNote(float elapsed){
  if(elapsed < 10){
    sine.play();
  }else{
    sine.stop();
  }
}

float noteToFreq(String note, int octaveChange) {
  System.out.println(note);
  Integer noteOffset = noteFrequencies.get(note);
  System.out.println(noteOffset);
  float freq = 440 * pow(2,(float(noteOffset)/12)); // offset to frequency formula
  System.out.println(freq);
  return freq;
}

void mousePressed(){
  String currentNote = song.substring(indexInSong,indexInSong+4);
  float currentFreq = noteToFreq(currentNote, 0);
  signalStartFrame = frameCount;
  sine.freq(currentFreq);
  sine.play();
  
  //other rhythm stuff
  currentSignalPending = true;
  signalStartFrame = frameCount;
  
}

void mouseReleased(){
  indexInSong += 4;
  indexInSong = indexInSong % song.length();
}
