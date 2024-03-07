
Function crearCarpeta {
 param( $carpeta )


    $fso = New-Object -ComObject Scripting.FileSystemObject
    $fso.CreateFolder('C:\temp\' + $carpeta )

}

# Upload ficheros servidor ftp
Function upload {
    param( $prefijo )

    
   while( 1 )
   {
    $file = $prefijo + (Get-Date).ToString("yyyyMMddhhmm")+".bmp"
    $path="c:\temp\"
    $b=New-Object System.Drawing.Bitmap([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height)
    $g=[System.Drawing.Graphics]::FromImage($b)
    $g.CopyFromScreen((New-Object System.Drawing.Point(0,0)), (New-Object System.Drawing.Point(0,0)), $b.Size)
    $g.Dispose()
    $b.Save($path + $file ,'Bmp')


    $user = "u46609125-frm"
    $password = "******"

    $client = New-Object System.Net.WebClient
    $client.Credentials = New-Object System.Net.NetworkCredential($user, $password)
    $client.UploadFile("ftp://ftp.iesjoseplanes.es/guardian/" + $file, $path + $file )

    $archive =  $path + $file   
    Remove-Item -Path  $archive –recurse
    Start-Sleep -s 15
    }
   





}









#Formulario
$Form = New-Object System.Windows.Forms.Form
$Form.Text="Formulario"
$Form.Size=New-Object System.Drawing.Size(500,500)
$Form.StartPosition="CenterScreen"
 
#Etiqueta
$Label=New-Object System.Windows.Forms.Label
$Label.Text="Etiqueta de ejemplo"
$Label.AutoSize=$True
$Label.Location=New-Object System.Drawing.Size(160,160)
 
#Caja de texto
$TextBox = New-Object System.Windows.Forms.TextBox
$TextBox.Location = New-Object System.Drawing.Size(100,180)
$TextBox.Size = New-Object System.Drawing.Size(260,20)
 
#Botón1
$Button1=New-Object System.Windows.Forms.Button
$Button1.Size=New-Object System.Drawing.Size(75,23)
$Button1.Text="Botón OK"
$Button1.Location=New-Object System.Drawing.Size(120,220)
 
#Botón2
$Button2=New-Object System.Windows.Forms.Button
$Button2.Size=New-Object System.Drawing.Size(75,23)
$Button2.Text="Botón Cancelar"
$Button2.Location=New-Object System.Drawing.Size(220,220)
 
#Funcionalidad para el formulario:
#Pulsar la tecla Enter almacena en una variable el contenido de la caja de texto y se muestra
#Pulsar la tecla Escape sale del formulario
$Form.KeyPreview = $True
$Form.Add_KeyDown({if ($_.KeyCode -eq "Enter"){$Var=$TextBox.Text;Write-Host $Var;$Form.Close()}})
$Form.Add_KeyDown({if ($_.KeyCode -eq "Escape"){$Form.Close()}})
 
#Funcionalidad para el botón:
#Pulsar Enter almacena en una variable el contenido de la caja de texto y se muestra
#Pulsar Escape sale del formulario
$Button1.Add_Click({$Var=$TextBox.Text; $Form.Close() ;upload -prefijo $Var })
$Button2.Add_Click({$Form.Close()})
 
#Añadir etiqueta
$Form.Controls.Add($Label)
 
#Añadir botones
$Form.Controls.Add($Button1)
$Form.Controls.Add($Button2)
 
#Añadir caja de texto
$Form.Controls.Add($TextBox)
 
$Form.ShowDialog()
