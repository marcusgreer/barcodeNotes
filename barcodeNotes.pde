
//String song = "AAACDDDEFFEDEAABCCDEAACBBCAB";//pirates
String song = "E E E C E G g C g e a B B* a g E G A F G E C D B ";


HashMap<String,Float> noteFrequencies = new HashMap<String, Float>();

int indexInSong = 0;

boolean currentSignalPending = false; //won't start recieving signal until finger lifted and ready to input
int signalStartFrame = 0;//start of the finger pressed down for 'beep'
int signalEndFrame = 0;//release of finger, is the end of 'beep'

int rhythmFrames = 60/4;

/* for sound effects */
import processing.sound.*;
SinOsc sine;
float sinFreq = 466.16;
void setup(){
  size(800,800);
  PFont mono;
  // The font ttf file must be located in the sketch's "data" directory to load successfully
  mono = createFont("RubikMonoOne-Regular.ttf", 32);
  textFont(mono);
  /* for sound effects */  
  sine = new SinOsc(this);
  sine.freq(sinFreq);
  
  noteFrequencies.put("c ",523.25);
  noteFrequencies.put("d ",587.33);
  noteFrequencies.put("e ",329.63);
  noteFrequencies.put("f ",349.23);
  noteFrequencies.put("g ",392.00);
  noteFrequencies.put("a ",466.16);
  
  noteFrequencies.put("B*",466.16);
  noteFrequencies.put("B ",493.88);
  noteFrequencies.put("C ",523.25);
  noteFrequencies.put("D ",587.33);
  noteFrequencies.put("E ",659.25);
  noteFrequencies.put("F ",698.46);
  noteFrequencies.put("G ",783.99);
  noteFrequencies.put("A ",466.16);
  
  
  
}
void draw(){ 
  background(225,90,70);
  int currentFrame = frameCount;
  
  
  float elapsedFrames = frameCount - signalStartFrame+1;
  playNote(elapsedFrames);
  displayCurrentDot(elapsedFrames);
  
  //if(currentSignalPending){//if we're in a middle of a dignal, the sound should play
  //  float elapsedFrames = frameCount - signalStartFrame+1;
  //  //soundEffect(signalStartFrame, elapsedFrames);
  //  displayCurrentDot(elapsedFrames);
  //  playNote(elapsedFrames);
  //}
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
//void mousePressed(){
//  currentSignalPending = true;
//  sine.play();
  
//  signalStartFrame = frameCount;
//  int sinceLastInput = signalStartFrame - signalEndFrame;
  

//}

void mousePressed(){
  String currentNote = song.substring(indexInSong,indexInSong+1);
  float currentFreq = noteFrequencies.get(currentNote);
  
  signalStartFrame = frameCount;
  sine.freq(currentFreq);
  sine.play();
  
  //other rhythm stuff
  currentSignalPending = true;
  signalStartFrame = frameCount;
  
}

void mouseReleased(){
  //sinFreq += 29.37;
  //sine.stop();
  
  indexInSong += 2;
  indexInSong = indexInSong % song.length();
  
  //
}

//void mouseReleased() {
//  sine.stop();
  
//  signalEndFrame = frameCount;
//  currentSignalPending = false;
  
//  int signalElapsed = signalEndFrame - signalStartFrame; 
//}
