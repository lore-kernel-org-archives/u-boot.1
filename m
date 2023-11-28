Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D4C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 01:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 429E8871DA;
	Tue, 28 Nov 2023 02:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60097874DC; Tue, 28 Nov 2023 02:39:05 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D189A870AB
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 02:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6224C15;
 Mon, 27 Nov 2023 17:39:49 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3A853F6C4;
 Mon, 27 Nov 2023 17:39:00 -0800 (PST)
Date: Tue, 28 Nov 2023 01:37:46 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Stephen Graf <stephen.graf@gmail.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Piotr
 Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/3] sunxi: H616: Add OrangePi Zero 3 board support
Message-ID: <20231128013746.23648d39@slackpad.lan>
In-Reply-To: <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
 <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
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

On Mon, 27 Nov 2023 14:31:19 -0800
Stephen Graf <stephen.graf@gmail.com> wrote:

Hi,

> Since the last test I rebuilt u-boot without the
> "CONFIG_DRAM_CLK=3D792" in the defconfig and got the wrong DRAM size=20
> problem (showing 2G instead of 1G). I had to do a power down/up to see th=
is.
> Are you planning to add this parameter to your patch?

This symptom is pretty surely not directly related to the DRAM
frequency, it's caused by a missing barrier or delay *somewhere*.
People report that this is fixed by adding another "dsb();" at the
beginning of the mctl_mem_matches() function, but I don't have a good
explanation why exactly there, and would like to avoid submitting
patches that "just seem to work (TM)".

If I find some time, I will try to setup some automated environment
where I can run some experiments with different barrier locations.
I can offer some rationale for putting it at the end of the function(s)
that call mctl_mem_matches(), so hope that this fixes it.

Cheers,
Andre

> U-Boot 2024.01-rc3-00012-g1fcf078f54-dirty (Nov 27 2023 - 12:25:33=20
> -0800) Allwin                                                      ner=20
> Technology
>=20
> CPU:   Allwinner H616 (SUN50I)
> Model: OrangePi Zero3
> DRAM:  2 GiB
>=20
>=20
> On 2023-11-27 12:21 p.m., Stephen Graf wrote:
> > Yes I forgot about the zBIT patch. With this patch also included I buil=
t=20
> > and retested u-boot loaded from SPI flash.=C2=A0 The two warning/error=
=20
> > messages disappeared and the flash worked properly and booted from a US=
B=20
> > device.
> >=20
> > There was one message that I did not understand:
> > "Loading Environment from SPIFlash... SF: Detected zb25vq128 with page=
=20
> > size 256 Bytes, erase size 4 KiB, total 16 MiB
> > *** Warning - bad CRC, using default environment"
> >=20
> > I tried to follow the u-boot documentation on writing the SPI flash but=
=20
> > had problems with the write command.=C2=A0 When issued it returned=20
> > immediately. The erase command took about 5 sec to execute. I researche=
d=20
> > use of mtd commands and got a suggestion to use cat instead, which work=
ed.
> >=20
> > "root@orangepizero3:~# mtdinfo
> > Count of MTD devices:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1
> > Present MTD devices:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mtd0
> > Sysfs interface supported:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes
> > root@orangepizero3:~# mtd_debug erase /dev/mtd0 0 0xf0000
> > Erased 983040 bytes from address 0x00000000 in flash
> > root@orangepizero3:~# mtd_debug write /dev/mtd0 0 0xf0000=20
> > /home/sysadmin/u-boot-sunxi-with-spl.bin
> > file_to_flash: fread, size 0xf0000, n 0xf0000
> > fread(): Success
> > root@orangepizero3:~# cat /home/sysadmin/u-boot-sunxi-with-spl.bin >=20
> > /dev/mtd0
> >=20
> >=20
> > Console log of boot:
> >=20
> > U-Boot SPL 2024.01-rc3-00012-g1fcf078f54-dirty (Nov 27 2023 - 10:17:46=
=20
> > -0800)
> > DRAM: 1024 MiB
> > Trying to boot from sunxi SPI
> > NOTICE:=C2=A0 BL31: v2.10.0=C2=A0 (debug):v2.10.0
> > NOTICE:=C2=A0 BL31: Built : 18:07:18, Nov 23 2023
> > NOTICE:=C2=A0 BL31: Detected Allwinner H616 SoC (1823)
> > NOTICE:=C2=A0 BL31: Found U-Boot DTB at 0x4a0b2798, model: OrangePi Zer=
o3
> > INFO:=C2=A0=C2=A0=C2=A0 ARM GICv2 driver initialized
> > INFO:=C2=A0=C2=A0=C2=A0 Configuring SPC Controller
> > INFO:=C2=A0=C2=A0=C2=A0 PMIC: Probing AXP305 on RSB
> > ERROR:=C2=A0=C2=A0 RSB: set run-time address: 0x10003
> > INFO:=C2=A0=C2=A0=C2=A0 Could not init RSB: -65539
> > INFO:=C2=A0=C2=A0=C2=A0 BL31: Platform setup done
> > INFO:=C2=A0=C2=A0=C2=A0 BL31: Initializing runtime services
> > INFO:=C2=A0=C2=A0=C2=A0 BL31: cortex_a53: CPU workaround for erratum 85=
5873 was applied
> > INFO:=C2=A0=C2=A0=C2=A0 BL31: cortex_a53: CPU workaround for erratum 15=
30924 was applied
> > INFO:=C2=A0=C2=A0=C2=A0 PSCI: Suspend is unavailable
> > INFO:=C2=A0=C2=A0=C2=A0 BL31: Preparing for EL3 exit to normal world
> > INFO:=C2=A0=C2=A0=C2=A0 Entry point address =3D 0x4a000000
> > INFO:=C2=A0=C2=A0=C2=A0 SPSR =3D 0x3c9
> > INFO:=C2=A0=C2=A0=C2=A0 Changed devicetree.
> >=20
> >=20
> > U-Boot 2024.01-rc3-00012-g1fcf078f54-dirty (Nov 27 2023 - 10:17:46=20
> > -0800) Allwinner Technology
> >=20
> > CPU:=C2=A0=C2=A0 Allwinner H616 (SUN50I)
> > Model: OrangePi Zero3
> > DRAM:=C2=A0 1 GiB
> > Core:=C2=A0 57 devices, 25 uclasses, devicetree: separate
> > WDT:=C2=A0=C2=A0 Not starting watchdog@30090a0
> > MMC:=C2=A0=C2=A0 mmc@4020000: 0
> > Loading Environment from SPIFlash... SF: Detected zb25vq128 with page=20
> > size 256 Bytes, erase size 4 KiB, total 16 MiB
> > *** Warning - bad CRC, using default environment
> >=20
> > Loading Environment from FAT... Card did not respond to voltage select!=
=20
> > : -110
> > ** Bad device specification mmc 0 **
> > In:=C2=A0=C2=A0=C2=A0 serial@5000000
> > Out:=C2=A0=C2=A0 serial@5000000
> > Err:=C2=A0=C2=A0 serial@5000000
> > Allwinner mUSB OTG (Peripheral)
> > Net:=C2=A0=C2=A0 eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN e=
p1in STATUS=20
> > ep2in
> > MAC de:ad:be:ef:00:01
> > HOST MAC de:ad:be:ef:00:00
> > RNDIS ready
> > , eth1: usb_ether
> > starting USB...
> > Bus usb@5200000: USB EHCI 1.00
> > Bus usb@5200400: USB OHCI 1.0
> > scanning bus usb@5200000 for devices... Device NOT ready
> >  =C2=A0=C2=A0 Request Sense returned 02 3A 00
> > Device NOT ready
> >  =C2=A0=C2=A0 Request Sense returned 02 3A 00
> > Device NOT ready
> >  =C2=A0=C2=A0 Request Sense returned 02 3A 00
> > 2 USB Device(s) found
> > scanning bus usb@5200400 for devices... 1 USB Device(s) found
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scanning usb for storage devices.=
.. 1 Storage Device(s) found
> > Hit any key to stop autoboot:=C2=A0 0
> > Card did not respond to voltage select! : -110
> >=20
> > Device 0: Vendor: Generic- Rev: 1.00 Prod: SD/MMC
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Typ=
e: Removable Hard Disk
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cap=
acity: 3828.0 MB =3D 3.7 GB (7839744 x 512)
> > ... is now current device
> > Scanning usb 0:1...
> > Found U-Boot script /boot.scr
> > 1575 bytes read in 1 ms (1.5 MiB/s)
> > ## Executing script at 4fc00000
> > Mainline u-boot / new-style environment detected.
> > This installer medium does not contain a suitable device-tree file for
> > this system (allwinner/sun50i-h618-orangepi-zero3.dtb). Aborting boot=20
> > process.
> > SCRIPT FAILED: continuing...
> > Found U-Boot script /boot/boot.scr
> > 621 bytes read in 2 ms (302.7 KiB/s)
> > ## Executing script at 4fc00000
> > 19472 bytes read in 3 ms (6.2 MiB/s)
> > Working FDT set to 4fa00000
> > 7088139 bytes read in 326 ms (20.7 MiB/s)
> > 22491144 bytes read in 1031 ms (20.8 MiB/s)
> > Moving Image from 0x40080000 to 0x40200000, end=3D41800000
> > ## Loading init Ramdisk from Legacy Image at 4ff00000 ...
> >  =C2=A0=C2=A0 Image Name:=C2=A0=C2=A0 uInitrd
> >  =C2=A0=C2=A0 Image Type:=C2=A0=C2=A0 AArch64 Linux RAMDisk Image (gzip=
 compressed)
> >  =C2=A0=C2=A0 Data Size:=C2=A0=C2=A0=C2=A0 7088075 Bytes =3D 6.8 MiB
> >  =C2=A0=C2=A0 Load Address: 00000000
> >  =C2=A0=C2=A0 Entry Point:=C2=A0 00000000
> >  =C2=A0=C2=A0 Verifying Checksum ... OK
> > ## Flattened Device Tree blob at 4fa00000
> >  =C2=A0=C2=A0 Booting using the fdt blob at 0x4fa00000
> > Working FDT set to 4fa00000
> >  =C2=A0=C2=A0 Loading Ramdisk to 4993d000, end 49fff7cb ... OK
> >  =C2=A0=C2=A0 Loading Device Tree to 00000000498cf000, end 000000004993=
cfff ... OK
> > Working FDT set to 498cf000
> >=20
> > Starting kernel ...
> >=20
> > [=C2=A0=C2=A0=C2=A0 0.000000] Booting Linux on physical CPU 0x000000000=
0 [0x410fd034]
> > [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 6.6.2 (orangepi@orangepizer=
o3) (gcc (Debian=20
> > 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP Sat No=
v=20
> > 25 18:37:47 UTC 2023
> >=20
> >=20
> > On 2023-11-26 4:23 a.m., Andre Przywara wrote: =20
> >> On Sat, 25 Nov 2023 20:27:05 -0800
> >> Stephen Graf <stephen.graf@gmail.com> wrote:
> >>
> >> Hi Stephen,
> >> =20
> >>> I built u-boot with the additional parameter for usb and it works, I=
=20
> >>> think.=C2=A0 There was one message that might be of concern "
> >>> Card did not respond to voltage select! : -110". =20
> >>
> >> This is a normal, though admittedly confusing message if no SD card is
> >> inserted. The code tries to (unconditionally) access the SD card, and
> >> sees that no card is there, the missing respond to the voltage select
> >> command is just the first real proof of this.
> >> =20
> >>> I am not sure of the details of the boot.cmd. The output below came f=
rom
> >>> the supplier image on an SD plugged into a USB card reader. The SD=20
> >>> slot of the board was empty.
> >>>
> >>> I was able to install u-boot to the SPI flash memory and there is a=20
> >>> warning message from that also: "
> >>> Loading Environment from SPIFlash... jedec_spi_nor flash@0:=20
> >>> unrecognized JEDEC id bytes: 5e, 40, 18
> >>> *** Warning - spi_flash_probe_bus_cs() failed, using default=20
> >>> environment" =20
> >>
> >> So for a start there is no environment on the SPI flash yet, so it
> >> wouldn't do anything. But the "unrecognised JEDEC id bytes" message
> >> doesn't sound right. Can you dig into this? Do you have patch 1/3
> >> applied, which tells U-Boot about 0x5e meaning zBIT?
> >> =20
>=20

