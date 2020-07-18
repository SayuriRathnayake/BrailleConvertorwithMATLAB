function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 16-Apr-2020 01:41:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%fname--- file name
%pname---path name

[fname,pname]= uigetfile({'*.png';'*.jpg';'*.bmp';'*.jpeg'},'Select an Image');
if isequal(fname,0) || isequal(pname,0)
    uiwait(msgbox('User cancle the action','failed','modal'))
  
    hold off;
else
    uiwait(msgbox('Image added Successfully','success','modal'))
    hold off;
    originalImagePath= strcat(pname,fname);
    im1 = imread(originalImagePath);
    imshow(im1,'Parent',handles.axes1) 
end
handles.im1 = im1;
guidata(hObject,handles);






% --- Executes on button press in enhanced.
function enhanced_Callback(hObject, eventdata, handles)
% hObject    handle to enhanced (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


im1=handles.im1;
imshow(im1,'Parent',handles.axes1)

%convert image into gray scale 
grayImage = rgb2gray(im1);

%imtool(grayImage);

%calculate the threshold value using otsu methods
threshold = graythresh(grayImage);

%convet to black and white
binary = im2bw(grayImage,threshold);
%imtool(binary);

%remove the noice of the background
filtImage=medfilt2(binary);
%imtool(filtImage);

%improve the image boundary line----------
%create structuring element
se = strel('disk',4);
im = imerode(filtImage, se);

imshow(im,'Parent',handles.axes2) 



handles.im = im;
guidata(hObject,handles);



% --- Executes on button press in letterIdentification.
function letterIdentification_Callback(hObject, eventdata, handles)
% hObject    handle to letterIdentification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


im=handles.im;
imshow(im,'Parent',handles.axes2)



%% Find the class the test image belongs
Ftest=FeatureStatistical(im);
%% Compare with the feature of training image in the database
load database.mat
Ftrain=database(:,1:2);
Ctrain=database(:,3);
for (i=1:size(Ftrain,1))
    dist(i,:)=sum(abs(Ftrain(i,:)-Ftest));
end  



m=find(dist==min(dist),1);
det_class=Ctrain(m);%take class number


%load the braille image in separate folder called "braille"
        D = 'braille';
        S = dir(fullfile(D,'braille_*.png')); % pattern to match filenames.

switch(det_class)
    case 1
        
        letterNew = 'A';
        %imshow('braille_1.png');
        %display the relevent braille image
            for k = 1
                F = fullfile(D,S(k).name);
                I = imread(F);
              
            end
        
   
    case 2
        
        letterNew = 'B';
            for k = 2
                F = fullfile(D,S(k).name);
                I = imread(F);
                  
            end
        
       
    case 3
        
        
        letterNew = 'C';
            for k = 3
                F = fullfile(D,S(k).name);
                I = imread(F);
                  
            end
        
     case 4
        
        
        letterNew = 'D';
            for k = 4
                F = fullfile(D,S(k).name);
                I = imread(F);
               
            end
            
     case 5
       
            letterNew = 'E';
            for k = 5
                F = fullfile(D,S(k).name);
                I = imread(F);
                
            end
    case 6
        
            letterNew = 'F';
            for k = 6
                F = fullfile(D,S(k).name);
                I = imread(F);
                     
            end
            
    case 7
        
            letterNew = 'G';
            for k = 7
                F = fullfile(D,S(k).name);
                I = imread(F);
                   
            end
    case 8
        
        
            letterNew = 'H';
            for k = 8
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
    case 9
        
           letterNew = 'I';
           for k = 9
               F = fullfile(D,S(k).name);
               I = imread(F);
                   
           end
           
    case 10
       
            letterNew = 'J';
            for k = 10
                F = fullfile(D,S(k).name);
                I = imread(F);
                 
            end
           
     case 11
        
            letterNew = 'K';
            for k = 11
                F = fullfile(D,S(k).name);
                I = imread(F);
                 
            end
            
     case 12
            
            letterNew = 'L';
            for k = 12
                F = fullfile(D,S(k).name);
                I = imread(F);
                  
            end
            
     case 13
      
            letterNew = 'M';
            for k = 13
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 14
        
            letterNew = 'N';
            for k = 14
                F = fullfile(D,S(k).name);
                I = imread(F);
                 
            end
            
     case 15
       
            letterNew = 'O';
            for k = 15
                F = fullfile(D,S(k).name);
                I = imread(F);
                   
            end
            
     case 16
        
            letterNew = 'P';
            for k = 16
                F = fullfile(D,S(k).name);
                I = imread(F);
                 
            end
            
     case 17
        
            letterNew = 'Q';
            for k = 17
                F = fullfile(D,S(k).name);
                I = imread(F);
                     
            end
            
     case 18
        
            letterNew = 'R';
            for k = 18
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 19
        
            letterNew = 'S';
            for k = 19
                F = fullfile(D,S(k).name);
                I = imread(F);
                 
            end
            
     case 20
        
            letterNew = 'T';
            for k = 20
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 21
        
            letterNew = 'U';
            for k = 21
                F = fullfile(D,S(k).name);
                I = imread(F);
                   
            end
            
     case 22
        
            letterNew = 'V';
            for k = 22
                F = fullfile(D,S(k).name);
                I = imread(F);
                  
            end
            
     case 23
        
            letterNew = 'W';
            for k = 23
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 24
        
            letterNew = 'X';
            for k = 24
                F = fullfile(D,S(k).name);
                I = imread(F);
                     
            end
            
     case 25
        
            letterNew = 'Y';
            for k = 25
                F = fullfile(D,S(k).name);
                I = imread(F);
                
            end
            
     case 26
        
            letterNew = 'Z';
            for k = 26
                F = fullfile(D,S(k).name);
                I = imread(F);
                   
            end
            
     case 27
       
            letterNew = 'a';
            for k = 1
                F = fullfile(D,S(k).name);
                I = imread(F);
                   
            end
            
     case 28
       
            letterNew = 'b';
            for k = 2
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 29
        
            letterNew = 'd';
            for k = 4
                F = fullfile(D,S(k).name);
                I = imread(F);
                 
            end
            
     case 30
        
            letterNew = 'e';
            for k = 5
                F = fullfile(D,S(k).name);
                I = imread(F);
                     
            end
            
     case 31
       
            letterNew = 'g';
            for k = 7
                F = fullfile(D,S(k).name);
                I = imread(F);
                     
            end
            
     case 32
        
            letterNew = 'h';
            for k = 8
                F = fullfile(D,S(k).name);
                I = imread(F);
                  
            end
            
     case 33
       
            letterNew = 'i';
            for k = 9
                F = fullfile(D,S(k).name);
                I = imread(F);
                  
            end
            
     case 34
       
            letterNew = 'j';
            for k = 10
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 35
        
            letterNew = 'l';
            for k = 12
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 36
        
            letterNew = 'm';
            for k = 13
                F = fullfile(D,S(k).name);
                I = imread(F);
                  
            end
            
     case 37
        
            letterNew = 'n';
            for k = 14
                F = fullfile(D,S(k).name);
                I = imread(F);
                   
            end
            
     case 38
        
            letterNew = 'q';
            for k = 17
                F = fullfile(D,S(k).name);
                I = imread(F);
                     
            end
            
    case 39
        
            letterNew = 'r';
            for k = 18
                F = fullfile(D,S(k).name);
                I = imread(F);
                   
            end
            
    
            
     case 40
       
            letterNew = 't';
            for k = 20
                F = fullfile(D,S(k).name);
                I = imread(F);
                   
            end
            
     case 41
        
            letterNew = '0';
            for k = 27
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 42
        
            letterNew = '1';
            for k = 28
                F = fullfile(D,S(k).name);
                I = imread(F);
                  
            end
            
     case 43
        
            letterNew = '2';
            for k = 29
                F = fullfile(D,S(k).name);
                I = imread(F);
                     
            end
            
     case 44
            
            letterNew = '3';
            for k = 30
                F = fullfile(D,S(k).name);
                I = imread(F);
                
            end
            
     case 45
        
            letterNew = '4';
            for k = 31
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 46
        
            letterNew = '5';
            for k = 32
                F = fullfile(D,S(k).name);
                I = imread(F);
                
            end
            
     case 47
       
            letterNew = '6';
            for k = 33
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 48
       
            letterNew = '7';
            for k = 34
                F = fullfile(D,S(k).name);
                I = imread(F);
                    
            end
            
     case 49
         
            letterNew = '8';
            for k = 35
                F = fullfile(D,S(k).name);
                I = imread(F);
                  
            end
            
     case 50
       
            letterNew = '9';
            for k = 36
                F = fullfile(D,S(k).name);
                I = imread(F);
                     
            end
            
     case 51
       
            letterNew = 'f';
            for k = 6
                F = fullfile(D,S(k).name);
                I = imread(F);
                     
            end
       
        
end


imshow(I,'Parent',handles.axes3)


handles.letterNew=letterNew;
set(handles.edit1, 'String', letterNew);
guidata(hObject,handles);


%msgbox(strcat('Detected Class=',num2str(det_class)));





function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

user_response = modaldlg('Title','Confirm Close the Process');
switch user_response
case 'No'
	% take no action
case 'Yes'
	% Prepare to close application window
	delete(ImageReader)
end



% --- Executes on button press in Rest.
function Rest_Callback(hObject, eventdata, handles)
% hObject    handle to Rest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.edit1, 'String','');



cla(handles.axes1,'reset'); 
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');
