def lookup2d(x, y, z, xi, yi):
    """
    Interpolates a two dimensional data table.
    
    Arguments:
    x:  Axes of the table - is the coordinate for the rows of the z table
    y:  Axes of the table - is the coordinate for the columns of the z table
    z:  The data at each (x,y) coordinate
    xi & yi:  The input values at which to interpolate the data
    
    Returns:
    zi: The values of the interpolation
    
    """
    
    # Import the required libraries
    import numpy as np
    from scipy.interpolate import RegularGridInterpolator

    # Set up the interpolator object
    RGI = RegularGridInterpolator((x, y), z, method='linear', bounds_error=False, fill_value=None)

    # Now use the object to interpolate the data
    zi = RGI((xi, yi))

    return zi

# Use example
import numpy as np
# Provide the data
x = [0, 1, 2, 3]
y = [0, 2, 3, 4, 5]

z = np.array([[1, 1.1, 1.2, 1.3, 1.4],
              [2, 2.1, 2.2, 2.3, 2.4],
              [3, 3.1, 3.2, 3.3, 3.4],
              [4, 4.1, 4.2, 4.3, 4.4]])

# Define the interpolation inputs
xi = 1
yi = 3.5

zi = lookup2d(x, y, z, xi, yi)

print(zi)