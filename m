Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C4CC4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 12:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE148723E;
	Sun, 26 Nov 2023 13:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F4187483; Sun, 26 Nov 2023 13:25:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9366086FBD
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 13:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12D74DA7;
 Sun, 26 Nov 2023 04:25:45 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4D9B3F6C4;
 Sun, 26 Nov 2023 04:24:56 -0800 (PST)
Date: Sun, 26 Nov 2023 12:23:42 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Stephen Graf <stephen.graf@gmail.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Piotr
 Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/3] sunxi: H616: Add OrangePi Zero 3 board support
Message-ID: <20231126122342.3944cad5@slackpad.lan>
In-Reply-To: <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Sat, 25 Nov 2023 20:27:05 -0800
Stephen Graf <stephen.graf@gmail.com> wrote:

Hi Stephen,

> I built u-boot with the additional parameter for usb and it works, I thin=
k.  There was one message that might be of concern "
> Card did not respond to voltage select! : -110".

This is a normal, though admittedly confusing message if no SD card is
inserted. The code tries to (unconditionally) access the SD card, and
sees that no card is there, the missing respond to the voltage select
command is just the first real proof of this.

> I am not sure of the details of the boot.cmd. The output below came from
> the supplier image on an SD plugged into a USB card reader. The SD slot o=
f the board was empty.
>=20
> I was able to install u-boot to the SPI flash memory and there is a warni=
ng message from that also: "
> Loading Environment from SPIFlash... jedec_spi_nor flash@0: unrecognized =
JEDEC id bytes: 5e, 40, 18
> *** Warning - spi_flash_probe_bus_cs() failed, using default environment"

So for a start there is no environment on the SPI flash yet, so it
wouldn't do anything. But the "unrecognised JEDEC id bytes" message
doesn't sound right. Can you dig into this? Do you have patch 1/3
applied, which tells U-Boot about 0x5e meaning zBIT?

> Thank you for your advice on getting something to boot. None of the Debia=
n installer images were suitable.  Even SID was at 6.1.
> I built the latest Linux 6.6.2 and wrestled with the rootfs before I got =
it running. I built the tested u-boot with this system,
> as a test of system stability.
>=20
> defconfig used + emac patches
>=20
> CONFIG_ARM=3Dy
> CONFIG_ARCH_SUNXI=3Dy
> CONFIG_DEFAULT_DEVICE_TREE=3D"sun50i-h618-orangepi-zero3"
> CONFIG_SPL=3Dy
> CONFIG_DRAM_SUN50I_H616_DX_ODT=3D0x07070707
> CONFIG_DRAM_SUN50I_H616_DX_DRI=3D0x0e0e0e0e
> CONFIG_DRAM_SUN50I_H616_CA_DRI=3D0x0e0e
> CONFIG_DRAM_SUN50I_H616_ODT_EN=3D0xaaaaeeee
> CONFIG_DRAM_SUN50I_H616_TPR6=3D0x44000000
> CONFIG_DRAM_SUN50I_H616_TPR10=3D0x402f6663
> CONFIG_DRAM_SUN50I_H616_TPR11=3D0x24242624
> CONFIG_DRAM_SUN50I_H616_TPR12=3D0x0f0f100f
> CONFIG_MACH_SUN50I_H616=3Dy
> CONFIG_SUNXI_DRAM_H616_LPDDR4=3Dy
> #
> CONFIG_DRAM_CLK=3D792
> CONFIG_USB1_VBUS_PIN=3D"PC16"
> #
> CONFIG_R_I2C_ENABLE=3Dy
> CONFIG_SPL_SPI_SUNXI=3Dy
> # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> CONFIG_SPL_I2C=3Dy
> CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> CONFIG_SYS_I2C_MVTWSI=3Dy
> CONFIG_SYS_I2C_SLAVE=3D0x7f
> CONFIG_SYS_I2C_SPEED=3D400000
> CONFIG_SPI_FLASH_ZBIT=3Dy
> CONFIG_PHY_MOTORCOMM=3Dy
> CONFIG_SUN8I_EMAC=3Dy
> CONFIG_AXP313_POWER=3Dy
> CONFIG_SPI=3Dy
> CONFIG_USB_EHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_MUSB_GADGET=3Dy
>=20
>=20
> Console Output:
>=20
> U-Boot 2024.01-rc3-00009-g9e53e45292-dirty (Nov 25 2023 - 18:32:16 -0800)=
 Allwinner Technology
>=20
> CPU:   Allwinner H616 (SUN50I)
> Model: OrangePi Zero3
> DRAM:  1 GiB
> Core:  57 devices, 25 uclasses, devicetree: separate
> WDT:   Not starting watchdog@30090a0
> MMC:   mmc@4020000: 0
> Loading Environment from SPIFlash... jedec_spi_nor flash@0: unrecognized =
JEDEC id bytes: 5e, 40, 18
> *** Warning - spi_flash_probe_bus_cs() failed, using default environment
>=20
> Loading Environment from FAT... Card did not respond to voltage select! :=
 -110
> ** Bad device specification mmc 0 **
> In:    serial@5000000
> Out:   serial@5000000
> Err:   serial@5000000
> Allwinner mUSB OTG (Peripheral)
> Net:   eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1in STATUS =
ep2in
> MAC de:ad:be:ef:00:01
> HOST MAC de:ad:be:ef:00:00
> RNDIS ready
> , eth1: usb_ether
> starting USB...
> Bus usb@5200000: USB EHCI 1.00
> Bus usb@5200400: USB OHCI 1.0
> scanning bus usb@5200000 for devices... Device NOT ready
>     Request Sense returned 02 3A 00
> Device NOT ready
>     Request Sense returned 02 3A 00
> Device NOT ready
>     Request Sense returned 02 3A 00
> 2 USB Device(s) found
> scanning bus usb@5200400 for devices... 1 USB Device(s) found
>         scanning usb for storage devices... 1 Storage Device(s) found
> Hit any key to stop autoboot:  0
> Card did not respond to voltage select! : -110
>=20
> Device 0: Vendor: Generic- Rev: 1.00 Prod: SD/MMC
>              Type: Removable Hard Disk
>              Capacity: 15193.5 MB =3D 14.8 GB (31116288 x 512)
> ... is now current device
> Scanning usb 0:1...
> Found U-Boot script /boot/boot.scr
> 3636 bytes read in 1 ms (3.5 MiB/s)
> ## Executing script at 4fc00000
> U-boot loaded from SD
> Boot script loaded from usb
> 205 bytes read in 1 ms (200.2 KiB/s)
> Failed to load '/boot/dtb/allwinner/sun50i-h618-orangepi-zero3.dtb'
> libfdt fdt_check_header(): FDT_ERR_BADMAGIC
> No FDT memory address configured. Please configure
> the FDT address via "fdt addr <address>" command.
> Aborting!
> 4203 bytes read in 4 ms (1 MiB/s)
> Applying kernel provided DT fixup script (sun50i-h616-fixup.scr)
> ## Executing script at 45000000
> 7088139 bytes read in 325 ms (20.8 MiB/s)
> 9419107 bytes read in 430 ms (20.9 MiB/s)
>     Uncompressing Kernel Image
> Moving Image from 0x40080000 to 0x40200000, end=3D41800000
> ## Loading init Ramdisk from Legacy Image at 4ff00000 ...
>     Image Name:   uInitrd
>     Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
>     Data Size:    7088075 Bytes =3D 6.8 MiB
>     Load Address: 00000000
>     Entry Point:  00000000
>     Verifying Checksum ... OK
> ERROR: Did not find a cmdline Flattened Device Tree

OK, so this is because you don't have the OPi Zero3 DTB on your image.
And this is frankly not needed, because U-Boot carries this very DTB
already.
In general this is some old school boot sequence, with a uImage
wrapped initrd and the DTB loaded from disk. The wrapped initrd is
mostly an small annoyance from a developers point of view, so this is
fine.
But can you tweak the boot script to use "$fdtcontroladdr", instead of
trying load a DTB from "disk"?
So remove (or ignore) the "load .... $fdt_addr_r ..." line, and change
the booti command to use "$fdtcontroladdr" instead of "$fdt_addr_r".
That should be all you need.

Good luck!

Cheers,
Andre
=20
> On 2023-11-25 4:23 p.m., Andre Przywara wrote:
> > On Sat, 25 Nov 2023 20:43:12 +0300
> > Mikhail Kalashnikov<iuncuim@gmail.com>  wrote:
> >
> > Hi Mikhail,
> > =20
> >> Hi Andre!
> >> Thanks for your patches. I started checking and noticed that USB stora=
ge
> >> was not working:
> >> =20
> >> =3D> usb reset =20
> >> resetting USB...
> >> Bus usb@5200000: USB EHCI 1.00
> >> Bus usb@5200400: USB OHCI 1.0
> >> scanning bus usb@5200000 for devices... 1 USB Device(s) found
> >> scanning bus usb@5200400 for devices... 1 USB Device(s) found
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scanning usb for storage devices... 0=
 Storage Device(s) found =20
> >> =3D> usb storage =20
> >> No storage devices, perhaps not 'usb start'ed..? =20
> > Ah, thanks for the report, seems I didn't even test this!
> > So digging around I figured it's working in Linux, and it's the right
> > USB port, but we are missing the VBUS power switch, which is a GPIO
> > controlled regulator. There are pending patches to pick this from the
> > devicetree[1], but we are not there yet, so we need:
> > CONFIG_USB1_VBUS_PIN=3D"PC16"
> > in the defconfig, for now. I will update the file. The same is
> > actually missing from the OrangePi Zero2 defconfig, I will send a patch
> > ASAP.
> >    =20
> >> Otherwise my OpiZero3 (4GB) board looks working.
> >> Ethernet works with my 10 Mbps usb-dongle.
> >>
> >> sf probe detect spi nor flash: =20
> >> =3D> sf probe =20
> >> SF: Detected zb25vq128 with page size 256 Bytes, erase size 4 KiB, tot=
al
> >> 16 MiB
> >>
> >> Loading the kernel and running the operating system (from microsd) also
> >> without problems.
> >>
> >> Tested-by: Mikhail Kalashnikov<iuncuim@gmail.com> =20
> > Great, thanks for the tag!
> >
> > Cheers,
> > Andre
> > =20
> >> On 14.11.2023 04:31, Andre Przywara wrote: =20
> >>> The OrangePi Zero 3 is a small development board featuring the Allwin=
ner
> >>> H618 SoC, shipping with up to 4GB of DRAM, Gigabit Ethernet, a micro-=
HDMI
> >>> connector and two USB sockets.
> >>> The board uses LPDDR4 DRAM and an X-Powers AXP313a PMIC, support for
> >>> which was recently added to U-Boot.
> >>>
> >>> Add a defconfig file selecting the right drivers and DRAM options.
> >>> Since the .dts file was synced from the Linux kernel repo already, we
> >>> just need to add one line to the Makefile to actually build the .dtb.
> >>>
> >>> The DRAM parameters were derived from the values found in the BSP DRAM
> >>> drivers on the SPI NOR flash.
> >>>
> >>> Signed-off-by: Andre Przywara<andre.przywara@arm.com>
> >>> ---
> >>>    arch/arm/dts/Makefile            |  1 +
> >>>    board/sunxi/MAINTAINERS          |  5 +++++
> >>>    configs/orangepi_zero3_defconfig | 30 ++++++++++++++++++++++++++++=
++
> >>>    3 files changed, 36 insertions(+)
> >>>    create mode 100644 configs/orangepi_zero3_defconfig
> >>>
> >>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> >>> index 1be08c5fdc2..5fc888680b3 100644
> >>> --- a/arch/arm/dts/Makefile
> >>> +++ b/arch/arm/dts/Makefile
> >>> @@ -835,6 +835,7 @@ dtb-$(CONFIG_MACH_SUN50I_H6) +=3D \
> >>>    	sun50i-h6-tanix-tx6-mini.dtb
> >>>    dtb-$(CONFIG_MACH_SUN50I_H616) +=3D \
> >>>    	sun50i-h616-orangepi-zero2.dtb \
> >>> +	sun50i-h618-orangepi-zero3.dtb \
> >>>    	sun50i-h616-x96-mate.dtb
> >>>    dtb-$(CONFIG_MACH_SUN50I) +=3D \
> >>>    	sun50i-a64-amarula-relic.dtb \
> >>> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> >>> index 00614372119..f556857a391 100644
> >>> --- a/board/sunxi/MAINTAINERS
> >>> +++ b/board/sunxi/MAINTAINERS
> >>> @@ -455,6 +455,11 @@ M:	Jernej Skrabec<jernej.skrabec@siol.net>
> >>>    S:	Maintained
> >>>    F:	configs/orangepi_zero2_defconfig
> >>>   =20
> >>> +ORANGEPI ZERO 3 BOARD
> >>> +M:	Andre Przywara<andre.przywara@arm.com>
> >>> +S:	Maintained
> >>> +F:	configs/orangepi_zero3_defconfig
> >>> +
> >>>    ORANGEPI PC 2 BOARD
> >>>    M:	Andre Przywara<andre.przywara@arm.com>
> >>>    S:	Maintained
> >>> diff --git a/configs/orangepi_zero3_defconfig b/configs/orangepi_zero=
3_defconfig
> >>> new file mode 100644
> >>> index 00000000000..e59044f6639
> >>> --- /dev/null
> >>> +++ b/configs/orangepi_zero3_defconfig
> >>> @@ -0,0 +1,30 @@
> >>> +CONFIG_ARM=3Dy
> >>> +CONFIG_ARCH_SUNXI=3Dy
> >>> +CONFIG_DEFAULT_DEVICE_TREE=3D"sun50i-h618-orangepi-zero3"
> >>> +CONFIG_SPL=3Dy
> >>> +CONFIG_DRAM_SUN50I_H616_DX_ODT=3D0x07070707
> >>> +CONFIG_DRAM_SUN50I_H616_DX_DRI=3D0x0e0e0e0e
> >>> +CONFIG_DRAM_SUN50I_H616_CA_DRI=3D0x0e0e
> >>> +CONFIG_DRAM_SUN50I_H616_ODT_EN=3D0xaaaaeeee
> >>> +CONFIG_DRAM_SUN50I_H616_TPR6=3D0x44000000
> >>> +CONFIG_DRAM_SUN50I_H616_TPR10=3D0x402f6663
> >>> +CONFIG_DRAM_SUN50I_H616_TPR11=3D0x24242624
> >>> +CONFIG_DRAM_SUN50I_H616_TPR12=3D0x0f0f100f
> >>> +CONFIG_MACH_SUN50I_H616=3Dy
> >>> +CONFIG_SUNXI_DRAM_H616_LPDDR4=3Dy
> >>> +CONFIG_R_I2C_ENABLE=3Dy
> >>> +CONFIG_SPL_SPI_SUNXI=3Dy
> >>> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> >>> +CONFIG_SPL_I2C=3Dy
> >>> +CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> >>> +CONFIG_SYS_I2C_MVTWSI=3Dy
> >>> +CONFIG_SYS_I2C_SLAVE=3D0x7f
> >>> +CONFIG_SYS_I2C_SPEED=3D400000
> >>> +CONFIG_SPI_FLASH_ZBIT=3Dy
> >>> +CONFIG_PHY_MOTORCOMM=3Dy
> >>> +CONFIG_SUN8I_EMAC=3Dy
> >>> +CONFIG_AXP313_POWER=3Dy
> >>> +CONFIG_SPI=3Dy
> >>> +CONFIG_USB_EHCI_HCD=3Dy
> >>> +CONFIG_USB_OHCI_HCD=3Dy
> >>> +CONFIG_USB_MUSB_GADGET=3Dy =20

