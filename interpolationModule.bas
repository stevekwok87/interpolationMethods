Attribute VB_Name = "Module1"
' One dimensional interpolation function
'----------------------------------


Function Interp1D(x As Double, xRange As Range, yRange As Range) As Double
    Dim i As Long
    Dim x1 As Double, x2 As Double
    Dim y1 As Double, y2 As Double

    ' Ensure xRange and yRange are of equal size
    If xRange.Cells.Count <> yRange.Cells.Count Then
        Interp1D = CVErr(xlErrValue)
        Exit Function
    End If

    ' Find the interval where x falls
    For i = 1 To xRange.Cells.Count - 1
        If x >= xRange.Cells(i, 1).Value And x <= xRange.Cells(i + 1, 1).Value Then
            x1 = xRange.Cells(i, 1).Value
            x2 = xRange.Cells(i + 1, 1).Value
            y1 = yRange.Cells(i, 1).Value
            y2 = yRange.Cells(i + 1, 1).Value
            Exit For
        End If
    Next i

    ' If x is outside the range, return an error
    If x < xRange.Cells(1, 1).Value Or x > xRange.Cells(xRange.Cells.Count, 1).Value Then
        Interp1D = CVErr(xlErrNA)
        Exit Function
    End If

    ' Perform linear interpolation
    Interp1D = y1 + (x - x1) * (y2 - y1) / (x2 - x1)
End Function

' Two dimensional interpolation
'--------------------------

'Explanation:
'----------

' x and y: The input values for which you want the interpolated result.
' xRange: A vertical range of x values corresponding to rows of the Z table.
' yRange: A horizontal range of y values corresponding to columns of the Z table.
' zRange: The 2D table of Z values where z(i, j) represents the value at xRange(i) and yRange(j).
' This implementation uses bilinear interpolation to estimate the value of Z for the given x and y by interpolating across four neighboring points. Make sure that x, y, and z values are ordered correctly in your Excel sheet.
' i = rows
' j = cols

Function Interp2D(x As Double, y As Double, xRange As Range, yRange As Range, zRange As Range) As Double
    Dim x1 As Double, x2 As Double, y1 As Double, y2 As Double
    Dim z11 As Double, z12 As Double, z21 As Double, z22 As Double
    Dim i As Long, j As Long

    ' Ensure ranges are proper
    If xRange.Columns.Count <> 1 Or yRange.Rows.Count <> 1 Then
        Interp2D = CVErr(xlErrValue)
        Exit Function
    End If
    If zRange.Rows.Count <> yRange.Columns.Count Or zRange.Columns.Count <> xRange.Rows.Count Then
        Interp2D = CVErr(xlErrValue)
        Exit Function
    End If

    ' Find indices for x
    For i = 1 To xRange.Rows.Count - 1
        If x >= xRange.Cells(i, 1).Value And x <= xRange.Cells(i + 1, 1).Value Then
            x1 = xRange.Cells(i, 1).Value
            x2 = xRange.Cells(i + 1, 1).Value
            Exit For
        End If
    Next i

    ' Find indices for y
    For j = 1 To yRange.Columns.Count - 1
        If y >= yRange.Cells(1, j).Value And y <= yRange.Cells(1, j + 1).Value Then
            y1 = yRange.Cells(1, j).Value
            y2 = yRange.Cells(1, j + 1).Value
            Exit For
        End If
    Next j

    ' Get z values
    z11 = zRange.Cells(i, j).Value
    z12 = zRange.Cells(i, j + 1).Value
    z21 = zRange.Cells(i + 1, j).Value
    z22 = zRange.Cells(i + 1, j + 1).Value

    ' Perform bilinear interpolation
    Interp2D = ((x2 - x) / (x2 - x1)) * ((y2 - y) / (y2 - y1)) * z11 + _
               ((x - x1) / (x2 - x1)) * ((y2 - y) / (y2 - y1)) * z21 + _
               ((x2 - x) / (x2 - x1)) * ((y - y1) / (y2 - y1)) * z12 + _
               ((x - x1) / (x2 - x1)) * ((y - y1) / (y2 - y1)) * z22
End Function


