%TRANSMITTER

% video extracting
s1=VideoReader('Original.avi');
filename=strcat('f',num2str(1),'.jpeg');
s2=read(s1,200);
imwrite(s2,filename);

%Data Encryption begins
x1=imread('f1.jpeg');
y=x1;
a=size(x1);
m=a(1,1);
n=a(1,2);
prompt='enter passowrd for encryption ';
c1=input(prompt,'s');
prompt='enter secret text  ';
c2=input(prompt,'s');
e1=uint8(c1);
binary1=de2bi(e1);
binary1=transpose(binary1);
binary1=binary1(:);
r1=length(binary1);
e2=uint8(c2);
binary2=transpose(de2bi(e2));
binary2=binary2(:);
r2=length(binary2);
for i=1:m
    for j=1:n
        i1=x1(i,j);
        i2=de2bi(i1);
        i2(1,1)=binary1(j,1);
        i3=bi2de(i2);
        y(i,j)=i3;
        if j>=r1
            break
        end
    end
    if j>=r1
        break
    end
end

for i=2:m
    for j=1:n
        i1=x1(i,j);
        i2=de2bi(i1);
        i2(1,1)=binary2(j,1);
        i3=bi2de(i2);
        y(i,j)=i3;
        if j>=r2
            break
        end
    end
    if j>=r2
        break
    end
end


%Again Video frame replacing with image
imwrite(y,'f2.jpeg');
nv1=VideoReader('Original.avi');
nv2=VideoWriter('New.avi');
v1=imread('f2.jpeg');
open(nv2)
counter=0;
while hasFrame(nv1)
    counter=counter+1;
    video=readFrame(nv1);
    if counter==200
        writeVideo(nv2,v1);
    else
        writeVideo(nv2,video);
    end
end
close(nv2)


% RECIEVER
s4=VideoReader('New.avi');
filename=strcat('f',num2str(3),'.jpeg');
s5=read(s4,200);
imwrite(s5,filename);
y1=imread('f3.jpeg');


%Password decryption
prompt='enter passowrd for decryption ';
c3=input(prompt,'s');
e3=uint8(c3);y1=y;
binary3=de2bi(e3);
binary3=transpose(binary3);
binary3=binary3(:);
r3=length(binary3);

if r1==r3
    for i=1:m
        for j=1:n
            i4=y1(i,j);
            i5=de2bi(i4);
            if j>r3
                break
            end
            t1=i5(1,1);
            t2=binary3(j,1);
            if t1==t2
                z1=1;
            else
                q1=msgbox('wrong passoword');
                z1=0;
                break
            end
        end
        if j>r3
            break
        end
    end
else
    q2=msgbox('Wrong password');
    z1=0;
end



% Data Decryption
if z1==1
    for i=2:m
        for j=1:n
            i6=y1(i,j);
            i7=de2bi(i6);
            i8(j,1)=i7(1,1);
            if j>=r2
                break
            end
        end
        if j>=r2
            break
        end  
    end
end
i9=reshape(i8,[7,length(e2)]);
i11=transpose(i9);
c4=size(i11);
m1=c4(1,1);
for i=1:m1
        i12=i11(i,:);
        i13=bi2de(i12);
        i14(1,i)=i13;
end
i15=char(i14);
if z1==1
    msgbox(['Secret msg is = ',num2str(i15)]);
end