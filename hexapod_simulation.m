
clc;
clear;
close all;

%% Hexapod Robot Parameters

bodyLength = 2;
bodyWidth = 1.2;
bodyHeight = 0.3;

upperLeg = 0.9;
lowerLeg = 1.0;

figure('Color','white');
axis equal;
grid on;
view(3);
xlabel('X Axis');
ylabel('Y Axis');
zlabel('Z Axis');
title('3D Hexapod Robot Simulation');

axis([-3 3 -3 3 0 3]);

%% Animation Loop

for t = 0:0.1:20

    cla;
    hold on;

    %% Robot Body

    [X,Y,Z] = cylinder([0.7 0.7],6);
    Z = Z * bodyHeight + 1.5;
    X = X * bodyLength/2;
    Y = Y * bodyWidth/2;

    surf(X,Y,Z,'FaceColor',[0.1 0.3 0.8], ...
        'EdgeColor','black');

    %% Six Legs
    
    for i = 1:6

        % Leg position around body
        angle = (i-1)*pi/3;

        hipX = cos(angle)*bodyLength/2;
        hipY = sin(angle)*bodyWidth/2;
        hipZ = 1.5;

        % Tripod gait phase
        if mod(i,2)==0
            phase = 0;
        else
            phase = pi;
        end

        % Leg movement
        swing = 0.35*cos(2*pi*t + phase);
        lift = 0.25*max(0,sin(2*pi*t + phase));

        % Foot position
        footX = hipX + cos(angle)*(upperLeg+lowerLeg) + swing;
        footY = hipY + sin(angle)*(upperLeg+lowerLeg);
        footZ = 0.2 + lift;

        % Knee position
        kneeX = hipX + cos(angle)*upperLeg;
        kneeY = hipY + sin(angle)*upperLeg;
        kneeZ = 0.8 + lift/2;

        % Upper leg
        plot3([hipX kneeX],[hipY kneeY], ...
            [hipZ kneeZ],'r','LineWidth',5);

        % Lower leg
        plot3([kneeX footX],[kneeY footY], ...
            [kneeZ footZ],'k','LineWidth',4);

        % Foot marker
        plot3(footX,footY,footZ,'bo', ...
            'MarkerFaceColor','b','MarkerSize',6);

    end

    %% Ground
    plot3([-3 3 3 -3 -3], ...
        [-3 -3 3 3 -3], ...
        [0 0 0 0 0],'g--');

    hold off;
    drawnow;
    pause(0.03);

end
