# Octave 4.0.0, Fri Nov 6 2:42:51 2015 Eastern Daylight Time <unknown@Rupanta-PC>

# Name          : RUPANTA RWITEEJ DUTTA
# Creation Date : Fri Nov 6 2:42:51 2015 Eastern Daylight Time

# Input image files Start
Img1 = imread ("Lena256.bmp");
Img2 = imread ("airplane256.bmp");
# Input image files End

# Define Horizontal and Vertical templates Start
Horizontal_template = [-1 0 1];
Vertical_template = [-1; 0; 1];
# Define Horizontal and Vertical templates End 

# Calculate Horizontal Gradients Start
Horizontal_gradient1 = Img1.*0;
Horizontal_gradient1 = double(Horizontal_gradient1);mHorizontal_gradient2 = Img2.*0;
Horizontal_gradient2 = double(Horizontal_gradient2);
for i = 1:256
  for j = 1:254
    Horizontal_gradient1(i,j+1) = (det(Img1(i,j))*Horizontal_template(1,1)) + (det(Img1(i,j+1))*Horizontal_template(1,2)) + (det(Img1(i,j+2))*Horizontal_template(1,3));
    Horizontal_gradient2(i,j+1) = (det(Img2(i,j))*Horizontal_template(1,1)) + (det(Img2(i,j+1))*Horizontal_template(1,2)) + (det(Img2(i,j+2))*Horizontal_template(1,3));   
  endfor
endfor  
for i = 1:255:256
  for j = 1:256
    Horizontal_gradient1(i,j) = 0;
    Horizontal_gradient2(i,j) = 0;
  endfor
endfor
for j = 1:255:256
  for i = 1:256
    Horizontal_gradient1(i,j) = 0;
    Horizontal_gradient2(i,j) = 0;
  endfor
endfor
# Calculate Horizontal Gradients End

# Calculate Vertical Gradients Start
Vertical_gradient1 = Img1.*0;
Vertical_gradient1 = double(Vertical_gradient1);
Vertical_gradient2 = Img2.*0;
Vertical_gradient2 = double(Vertical_gradient2);
for j = 1:256
  for i = 1:254
    Vertical_gradient1(i+1,j) = (det(Img1(i,j))*Vertical_template(1,1)) + (det(Img1(i+1,j))*Vertical_template(2,1)) + (det(Img1(i+2,j))*Vertical_template(3,1));
    Vertical_gradient2(i+1,j) = (det(Img2(i,j))*Vertical_template(1,1)) + (det(Img2(i+1,j))*Vertical_template(2,1)) + (det(Img2(i+2,j))*Vertical_template(3,1));
  endfor
endfor
for i = 1:255:256
  for j = 1:256
    Vertical_gradient1(i,j) = 0;
    Vertical_gradient2(i,j) = 0;
  endfor
endfor
for j = 1:255:256
  for i = 1:256
    Vertical_gradient1(i,j) = 0;
    Vertical_gradient2(i,j) = 0;
  endfor
endfor
# Calculate Vertical Gradients End

# Calculate Edge Magnitudes Start
Edge_magnitude1 = round(((((Horizontal_gradient1).^2) .+ ((Vertical_gradient1).^2)).^0.5) .* (1/(2^0.5)));
Edge_magnitude2 = round(((((Horizontal_gradient2).^2) .+ ((Vertical_gradient2).^2)).^0.5) .* (1/(2^0.5)));
for i = 1:255:256
  for j = 1:256
    Edge_magnitude1(i,j) = 0;
    Edge_magnitude2(i,j) = 0;
  endfor
endfor
for j = 1:255:256
  for i = 1:256
    Edge_magnitude1(i,j) = 0;
    Edge_magnitude2(i,j) = 0;
  endfor
endfor
# Calculate Edge Magnitudes End

# Output Edge Magnitude to File Start
OutputImage1=Edge_magnitude1;
OutputImage1=uint8(OutputImage1);
imwrite(OutputImage1, "edge_Lena256.bmp")
OutputImage2=Edge_magnitude2;
OutputImage2=uint8(OutputImage2);
imwrite(OutputImage2, "edge_Airplane256.bmp")
# Output OutEdge Magnitude to File End

# Calculate Gradient Angles Start
Gradient_angle1 = Img1.*0;
Gradient_angle1 = double(Gradient_angle1);
Gradient_angle2 = Img2.*0;
Gradient_angle2 = double(Gradient_angle2);
for i = 1:256
  for j = 1:256
    if Horizontal_gradient1(i,j) == 0
      if Vertical_gradient1(i,j) == 0
        Gradient_angle1(i,j) = 0;
      elseif Vertical_gradient1(i,j) < 0
        Gradient_angle1(i,j) = -90;
      elseif Vertical_gradient1(i,j) > 0
        Gradient_angle1(i,j) = 90;
      endif
    elseif (Horizontal_gradient1(i,j)<0) || (Horizontal_gradient1(i,j)>0)
      Gradient_angle1(i,j) = atand(Vertical_gradient1(i,j) / Horizontal_gradient1(i,j));
    endif
  endfor
endfor
for i = 1:256
  for j = 1:256
    if Horizontal_gradient2(i,j) == 0
      if Vertical_gradient2(i,j) == 0
        Gradient_angle2(i,j) = 0;
      elseif Vertical_gradient2(i,j) < 0
        Gradient_angle2(i,j) = -90;
      elseif Vertical_gradient2(i,j) > 0
        Gradient_angle2(i,j) = 90;
      endif
    elseif (Horizontal_gradient2(i,j)<0) || (Horizontal_gradient2(i,j)>0)
      Gradient_angle2(i,j) = atand(Vertical_gradient2(i,j) / Horizontal_gradient2(i,j));
    endif
  endfor
endfor
for i = 1:255:256
  for j = 1:256
    Gradient_angle1(i,j) = -1;
    Gradient_angle2(i,j) = -1;
  endfor
endfor
for j = 1:255:256
  for i = 1:256
    Gradient_angle1(i,j) = -1;
    Gradient_angle2(i,j) = -1;
  endfor
endfor
# Calculate Gradient Angles End

# Calcuate Negative of Gradient Angles Start
Neg_gradient_angle1 = Gradient_angle1 .* (-1);
Neg_gradient_angle2 = Gradient_angle2 .* (-1);
for i = 1:256
  for j = 1:256
    if Neg_gradient_angle1(i,j)<0
      Neg_gradient_angle1(i,j) = Neg_gradient_angle1(i,j) + 360;
    elseif Neg_gradient_angle1(i,j) == -0
      Neg_gradient_angle1(i,j) = 0;
    endif
    if Neg_gradient_angle2(i,j)<0
      Neg_gradient_angle2(i,j) = Neg_gradient_angle2(i,j) + 360;
    elseif Neg_gradient_angle2(i,j) == -0
      Neg_gradient_angle2(i,j) = 0;
    endif
  endfor
endfor
for i = 1:255:256
  for j = 1:256
    Neg_gradient_angle1(i,j) = -1;
    Neg_gradient_angle2(i,j) = -1;
  endfor
endfor
for j = 1:255:256
  for i = 1:256
    Neg_gradient_angle1(i,j) = -1;
    Neg_gradient_angle2(i,j) = -1;
  endfor
endfor
# Calcuate Negative of Gradient Angles End

# Qunatize Angles
for i = 1:256
  for j = 1:256
    if ((Neg_gradient_angle1(i,j) >= 0) && (Neg_gradient_angle1(i,j) < 20)) || ((Neg_gradient_angle1(i,j) >= 180) && (Neg_gradient_angle1(i,j) < 200))
      Quantize_angle1(i,j) = 1;
    elseif ((Neg_gradient_angle1(i,j) >= 20) && (Neg_gradient_angle1(i,j) < 40)) || ((Neg_gradient_angle1(i,j) >= 200) && (Neg_gradient_angle1(i,j) < 220))
      Quantize_angle1(i,j) = 2;
    elseif ((Neg_gradient_angle1(i,j) >= 40) && (Neg_gradient_angle1(i,j) < 60)) || ((Neg_gradient_angle1(i,j) >= 220) && (Neg_gradient_angle1(i,j) < 240))
      Quantize_angle1(i,j) = 3;
    elseif ((Neg_gradient_angle1(i,j) >= 60) && (Neg_gradient_angle1(i,j) < 80)) || ((Neg_gradient_angle1(i,j) >= 240) && (Neg_gradient_angle1(i,j) < 260))
      Quantize_angle1(i,j) = 4;
    elseif ((Neg_gradient_angle1(i,j) >= 80) && (Neg_gradient_angle1(i,j) < 100)) || ((Neg_gradient_angle1(i,j) >= 260) && (Neg_gradient_angle1(i,j) < 280))
      Quantize_angle1(i,j) = 5;  
    elseif ((Neg_gradient_angle1(i,j) >= 100) && (Neg_gradient_angle1(i,j) < 120)) || ((Neg_gradient_angle1(i,j) >= 280) && (Neg_gradient_angle1(i,j) < 300))
      Quantize_angle1(i,j) = 6;
    elseif ((Neg_gradient_angle1(i,j) >= 120) && (Neg_gradient_angle1(i,j) < 140)) || ((Neg_gradient_angle1(i,j) >= 300) && (Neg_gradient_angle1(i,j) < 320))
      Quantize_angle1(i,j) = 7;
    elseif ((Neg_gradient_angle1(i,j) >= 140) && (Neg_gradient_angle1(i,j) < 160)) || ((Neg_gradient_angle1(i,j) >= 320) && (Neg_gradient_angle1(i,j) < 340))
      Quantize_angle1(i,j) = 8;
    elseif ((Neg_gradient_angle1(i,j) >= 160) && (Neg_gradient_angle1(i,j) < 180)) || ((Neg_gradient_angle1(i,j) >= 340) && (Neg_gradient_angle1(i,j) < 360))
      Quantize_angle1(i,j) = 9;  
    else
      Quantize_angle1(i,j) = -1;
    endif
    if ((Neg_gradient_angle2(i,j) >= 0) && (Neg_gradient_angle2(i,j) < 20)) || ((Neg_gradient_angle2(i,j) >= 180) && (Neg_gradient_angle2(i,j) < 200))
      Quantize_angle2(i,j) = 1;
    elseif ((Neg_gradient_angle2(i,j) >= 20) && (Neg_gradient_angle2(i,j) < 40)) || ((Neg_gradient_angle2(i,j) >= 200) && (Neg_gradient_angle2(i,j) < 220))
      Quantize_angle2(i,j) = 2;
    elseif ((Neg_gradient_angle2(i,j) >= 40) && (Neg_gradient_angle2(i,j) < 60)) || ((Neg_gradient_angle2(i,j) >= 220) && (Neg_gradient_angle2(i,j) < 240))
      Quantize_angle2(i,j) = 3;
    elseif ((Neg_gradient_angle2(i,j) >= 60) && (Neg_gradient_angle2(i,j) < 80)) || ((Neg_gradient_angle2(i,j) >= 240) && (Neg_gradient_angle2(i,j) < 260))
      Quantize_angle2(i,j) = 4;
    elseif ((Neg_gradient_angle2(i,j) >= 80) && (Neg_gradient_angle2(i,j) < 100)) || ((Neg_gradient_angle2(i,j) >= 260) && (Neg_gradient_angle2(i,j) < 280))
      Quantize_angle2(i,j) = 5;  
    elseif ((Neg_gradient_angle2(i,j) >= 100) && (Neg_gradient_angle2(i,j) < 120)) || ((Neg_gradient_angle2(i,j) >= 280) && (Neg_gradient_angle2(i,j) < 300))
      Quantize_angle2(i,j) = 6;
    elseif ((Neg_gradient_angle2(i,j) >= 120) && (Neg_gradient_angle2(i,j) < 140)) || ((Neg_gradient_angle2(i,j) >= 300) && (Neg_gradient_angle2(i,j) < 320))
      Quantize_angle2(i,j) = 7;
    elseif ((Neg_gradient_angle2(i,j) >= 140) && (Neg_gradient_angle2(i,j) < 160)) || ((Neg_gradient_angle2(i,j) >= 320) && (Neg_gradient_angle2(i,j) < 340))
      Quantize_angle2(i,j) = 8;
    elseif ((Neg_gradient_angle2(i,j) >= 160) && (Neg_gradient_angle2(i,j) < 180)) || ((Neg_gradient_angle2(i,j) >= 340) && (Neg_gradient_angle2(i,j) < 360))
      Quantize_angle2(i,j) = 9;  
    else
      Quantize_angle2(i,j) = -1;
    endif
  endfor
endfor
for i = 1:255:256
  for j = 1:256
    Quantize_angle1(i,j) = -1;
    Quantize_angle2(i,j) = -1;
  endfor
endfor
for j = 1:255:256
  for i = 1:256
    Quantize_angle1(i,j) = -1;
    Quantize_angle2(i,j) = -1;
  endfor
endfor
# Qunatize Angles End

# Calculate LEOH and Write to File Start
fid = fopen( 'LEOH_Lena256.txt', 'wt' );
  fprintf(fid, '%s\n\n', "LEOH for Image Lena256.bmp");
fclose(fid);
for i = 1:16:241
  for j = 1:16:241
    avg = 0.0;
    h1 = 0.0;
    h2 = 0.0;
    h3 = 0.0;
    h4 = 0.0;
    h5 = 0.0;
    h6 = 0.0;
    h7 = 0.0;
    h8 = 0.0;
    h9 = 0.0;
    count = 0; 
    for r = i:i+15
      for c = j:j+15
        if Quantize_angle1(r,c) > 0
          count = count + 1;
        endif
      endfor
    endfor
    for r = i:i+15
      for c = j:j+15
        if Quantize_angle1(r,c) > 0
          avg = avg + (Edge_magnitude1(r,c)/count);
        endif
      endfor
    endfor
    for r = i:i+15
      for c = j:j+15
        if Quantize_angle1(r,c) == 1
          h1 = h1 + (Edge_magnitude1(r,c)/avg);
        elseif Quantize_angle1(r,c) == 2
          h2 = h2 + (Edge_magnitude1(r,c)/avg);
        elseif Quantize_angle1(r,c) == 3
          h3 = h3 + (Edge_magnitude1(r,c)/avg);
        elseif Quantize_angle1(r,c) == 4
          h4 = h4 + (Edge_magnitude1(r,c)/avg);
        elseif Quantize_angle1(r,c) == 5
          h5 = h5 + (Edge_magnitude1(r,c)/avg);
        elseif Quantize_angle1(r,c) == 6
          h6 = h6 + (Edge_magnitude1(r,c)/avg);
        elseif Quantize_angle1(r,c) == 7
          h7 = h7 + (Edge_magnitude1(r,c)/avg);
        elseif Quantize_angle1(r,c) == 8
          h8 = h8 + (Edge_magnitude1(r,c)/avg);
        elseif Quantize_angle1(r,c) == 9
          h9 = h9 + (Edge_magnitude1(r,c)/avg);
        endif
      endfor
    endfor
    h1 = (round(h1));
    h2 = (round(h2));
    h3 = (round(h3));
    h4 = (round(h4));
    h5 = (round(h5));
    h6 = (round(h6));
    h7 = (round(h7));
    h8 = (round(h8));
    h9 = (round(h9));
    fid = fopen( 'LEOH_Lena256.txt', 'at' );
    fprintf(fid, '%d  %d  %d  %d  %d  %d  %d  %d  %d\n', h1, h2, h3, h4, h5, h6, h7, h8, h9);
    fclose(fid);
  endfor
endfor
fid = fopen( 'LEOH_airplane256.txt', 'wt' );
  fprintf(fid, '%s\n\n', "LEOH for Image airplane256.bmp");
fclose(fid);
for i = 1:16:241
  for j = 1:16:241
    avg = 0.0;
    h1 = 0.0;
    h2 = 0.0;
    h3 = 0.0;
    h4 = 0.0;
    h5 = 0.0;
    h6 = 0.0;
    h7 = 0.0;
    h8 = 0.0;
    h9 = 0.0;
    count = 0;
    for r = i:i+15
      for c = j:j+15
        if Quantize_angle2(r,c) > 0
          count = count + 1;
        endif
      endfor
    endfor
    for r = i:i+15
      for c = j:j+15
        if Quantize_angle2(r,c) > 0
          avg = avg + (Edge_magnitude2(r,c)/count);
        endif
      endfor
    endfor
    for r = i:i+15
      for c = j:j+15
        if Quantize_angle2(r,c) == 1
          h1 = h1 + (Edge_magnitude2(r,c)/avg);
        elseif Quantize_angle2(r,c) == 2
          h2 = h2 + (Edge_magnitude2(r,c)/avg);
        elseif Quantize_angle2(r,c) == 3
          h3 = h3 + (Edge_magnitude2(r,c)/avg);
        elseif Quantize_angle2(r,c) == 4
          h4 = h4 + (Edge_magnitude2(r,c)/avg);
        elseif Quantize_angle2(r,c) == 5
          h5 = h5 + (Edge_magnitude2(r,c)/avg);
        elseif Quantize_angle2(r,c) == 6
          h6 = h6 + (Edge_magnitude2(r,c)/avg);
        elseif Quantize_angle2(r,c) == 7
          h7 = h7 + (Edge_magnitude2(r,c)/avg);
        elseif Quantize_angle2(r,c) == 8
          h8 = h8 + (Edge_magnitude2(r,c)/avg);
        elseif Quantize_angle2(r,c) == 9
          h9 = h9 + (Edge_magnitude2(r,c)/avg);
        endif
      endfor
    endfor
    h1 = (round(h1));
    h2 = (round(h2));
    h3 = (round(h3));
    h4 = (round(h4));
    h5 = (round(h5));
    h6 = (round(h6));
    h7 = (round(h7));
    h8 = (round(h8));
    h9 = (round(h9));
    fid = fopen( 'LEOH_Airplane256.txt', 'at' );
    fprintf(fid, '%d  %d  %d  %d  %d  %d  %d  %d  %d\n', h1, h2, h3, h4, h5, h6, h7, h8, h9);
    fclose(fid);
  endfor
endfor
# Calculate LEOH and Write to File End
printf("Program Ended Successfully!!!");
