PImage error;
import ddf.minim.*;
int currentScene = 1;

Minim minim;
AudioPlayer player;
ArrayList<Particle> particles;
boolean burstMode = false;

void setup() {
  size(750, 750);
  background(0);
  minim = new Minim(this);
  player = minim.loadFile("music.mp3");
  player.play();
  error = loadImage("error.jpg");
  particles = new ArrayList<Particle>();
}

void draw() { // Fade background slowly
 if(currentScene == 1){ 
   fill(0, 10);
   rect(0, 0, width, height);

  // Draw chaotic mouse trail
  stroke(random(255), random(255), random(255));
  strokeWeight(2);
  line(pmouseX, pmouseY, mouseX, mouseY);

  // Update and display particles
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.display();
    if (p.isDead()) {
      particles.remove(i);
    }
    }
  }
  if(currentScene == 2){ //error
  image(error,125,125);
  }
}

void mousePressed() {
  background(random(255), random(255), random(255));
}

void mouseDragged() {
  // Create burst of particles
  for (int i = 0; i < 5; i++) {
    particles.add(new Particle(mouseX, mouseY));
  }
}

void keyPressed() {
  if(key == '1'){
    currentScene = 1;
  }
  if(key == '2'){
    currentScene = 2;
  }
   if(key == 'b'){
    filter(INVERT);
  }
  // Toggle burst mode
  burstMode = !burstMode;
}

class Particle {
  PVector pos, vel;
  float lifespan;

  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    vel.mult(random(1, 4));
    lifespan = 255;
  }

  void update() {
    pos.add(vel);
    vel.rotate(random(-0.1, 0.1)); // chaotic spin
    lifespan -= 2;
  }

  void display() {
    stroke(map(vel.mag(), 0, 4, 100, 255), lifespan, 255 - lifespan);
    strokeWeight(2);
    point(pos.x, pos.y);
  }

  boolean isDead() {
    return lifespan < 0;
  }
}
