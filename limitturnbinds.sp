#include <sourcemod>
#include <sdktools>

public Plugin myinfo = 
{
    name = "Limit Turn Binds",
    author = "Bonner",
    description = "Limit the use of turnbinds",
    version = "1.0",
    url = "https://github.com/Bonner1337/limitturnbinds",
}

bool left;
bool right;
float fAngles[3] = 0.0;

public Action OnPlayerRunCmd(client, &buttons, &impulse, float vel[3], float angles[3])
{
    if (buttons & IN_LEFT)
    {
        left = true;
    }
    if (buttons & IN_RIGHT)
    {
        right = true;
    }
    
    if (GetEntityFlags(client) & FL_ONGROUND)
    {
        left = false;
        right = false;
        
        //Can't +left or +right if on ground. But you can use in air.
        if (buttons & IN_RIGHT || buttons & IN_LEFT)
        {
            TeleportEntity(client, NULL_VECTOR, fAngles, NULL_VECTOR);
            return Action:0;
        }
    }
    
    //+left & +right in a single jump. Fucks your angles.
    if (left, right == true)
    {
        TeleportEntity(client, NULL_VECTOR, fAngles, NULL_VECTOR);
        return Action:0;
    }
    return Action:0;
}
