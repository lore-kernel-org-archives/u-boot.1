Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CF4C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 01:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356C186FB4;
	Tue, 28 Nov 2023 02:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62C078759B; Tue, 28 Nov 2023 02:31:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E226486F6D
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 02:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA4AB2F4;
 Mon, 27 Nov 2023 17:31:51 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C22893F6C4;
 Mon, 27 Nov 2023 17:31:02 -0800 (PST)
Date: Tue, 28 Nov 2023 01:29:48 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Stephen Graf <stephen.graf@gmail.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Piotr
 Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/3] sunxi: H616: Add OrangePi Zero 3 board support
Message-ID: <20231128012948.3124e7d2@slackpad.lan>
In-Reply-To: <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 27 Nov 2023 12:21:44 -0800
Stephen Graf <stephen.graf@gmail.com> wrote:

Hi Stephen!

> Yes I forgot about the zBIT patch. With this patch also included I built 
> and retested u-boot loaded from SPI flash.  The two warning/error 
> messages disappeared and the flash worked properly and booted from a USB 
> device.

Great!

> There was one message that I did not understand:
> "Loading Environment from SPIFlash... SF: Detected zb25vq128 with page 
> size 256 Bytes, erase size 4 KiB, total 16 MiB
> *** Warning - bad CRC, using default environment"

This is because there is no environment saved on the SPI flash (yet).
You just copied the U-Boot image, the environment is in a separate
area (behind that), defined by CONFIG_ENV_OFFSET, which is 64K below
1MB. There could be any kind of garbage there, initially, and U-Boot
fortunately protects the environment with a checksum, so detects that
this is not valid data, and falls back to the built-in environment.
And frankly this is probably all you ever need, I think these days
there is little that needs to be saved in the environment.
If you want to give it a try, type "saveenv" on the U-Boot prompt. On
the next boot U-Boot would detect this now properly initialised data
region and you will probably not see the message anymore.
But again this really only makes sense if you *change* something in the
environment and want that preserved across reboots.

> I tried to follow the u-boot documentation on writing the SPI flash but 
> had problems with the write command.  When issued it returned 
> immediately. The erase command took about 5 sec to execute. I researched 
> use of mtd commands and got a suggestion to use cat instead, which worked.

Mmh, can you elaborate on that? Did you mean you piped in the data into
the mtd_debug command? Or did you write directly to /dev/mtd0, using
cat? And which version of mtd_debug was this, exactly? I guess the
official one from Debian Bookworm?

Cheers,
Andre


> "root@orangepizero3:~# mtdinfo
> Count of MTD devices:           1
> Present MTD devices:            mtd0
> Sysfs interface supported:      yes
> root@orangepizero3:~# mtd_debug erase /dev/mtd0 0 0xf0000
> Erased 983040 bytes from address 0x00000000 in flash
> root@orangepizero3:~# mtd_debug write /dev/mtd0 0 0xf0000 
> /home/sysadmin/u-boot-sunxi-with-spl.bin
> file_to_flash: fread, size 0xf0000, n 0xf0000
> fread(): Success
> root@orangepizero3:~# cat /home/sysadmin/u-boot-sunxi-with-spl.bin > 
> /dev/mtd0
> 
> 
> Console log of boot:
> 
> U-Boot SPL 2024.01-rc3-00012-g1fcf078f54-dirty (Nov 27 2023 - 10:17:46 
> -0800)
> DRAM: 1024 MiB
> Trying to boot from sunxi SPI
> NOTICE:  BL31: v2.10.0  (debug):v2.10.0
> NOTICE:  BL31: Built : 18:07:18, Nov 23 2023
> NOTICE:  BL31: Detected Allwinner H616 SoC (1823)
> NOTICE:  BL31: Found U-Boot DTB at 0x4a0b2798, model: OrangePi Zero3
> INFO:    ARM GICv2 driver initialized
> INFO:    Configuring SPC Controller
> INFO:    PMIC: Probing AXP305 on RSB
> ERROR:   RSB: set run-time address: 0x10003
> INFO:    Could not init RSB: -65539
> INFO:    BL31: Platform setup done
> INFO:    BL31: Initializing runtime services
> INFO:    BL31: cortex_a53: CPU workaround for erratum 855873 was applied
> INFO:    BL31: cortex_a53: CPU workaround for erratum 1530924 was applied
> INFO:    PSCI: Suspend is unavailable
> INFO:    BL31: Preparing for EL3 exit to normal world
> INFO:    Entry point address = 0x4a000000
> INFO:    SPSR = 0x3c9
> INFO:    Changed devicetree.
> 
> 
> U-Boot 2024.01-rc3-00012-g1fcf078f54-dirty (Nov 27 2023 - 10:17:46 
> -0800) Allwinner Technology
> 
> CPU:   Allwinner H616 (SUN50I)
> Model: OrangePi Zero3
> DRAM:  1 GiB
> Core:  57 devices, 25 uclasses, devicetree: separate
> WDT:   Not starting watchdog@30090a0
> MMC:   mmc@4020000: 0
> Loading Environment from SPIFlash... SF: Detected zb25vq128 with page 
> size 256 Bytes, erase size 4 KiB, total 16 MiB
> *** Warning - bad CRC, using default environment
> 
> Loading Environment from FAT... Card did not respond to voltage select! 
> : -110
> ** Bad device specification mmc 0 **
> In:    serial@5000000
> Out:   serial@5000000
> Err:   serial@5000000
> Allwinner mUSB OTG (Peripheral)
> Net:   eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1in STATUS 
> ep2in
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
> 
> Device 0: Vendor: Generic- Rev: 1.00 Prod: SD/MMC
>              Type: Removable Hard Disk
>              Capacity: 3828.0 MB = 3.7 GB (7839744 x 512)
> ... is now current device
> Scanning usb 0:1...
> Found U-Boot script /boot.scr
> 1575 bytes read in 1 ms (1.5 MiB/s)
> ## Executing script at 4fc00000
> Mainline u-boot / new-style environment detected.
> This installer medium does not contain a suitable device-tree file for
> this system (allwinner/sun50i-h618-orangepi-zero3.dtb). Aborting boot 
> process.
> SCRIPT FAILED: continuing...
> Found U-Boot script /boot/boot.scr
> 621 bytes read in 2 ms (302.7 KiB/s)
> ## Executing script at 4fc00000
> 19472 bytes read in 3 ms (6.2 MiB/s)
> Working FDT set to 4fa00000
> 7088139 bytes read in 326 ms (20.7 MiB/s)
> 22491144 bytes read in 1031 ms (20.8 MiB/s)
> Moving Image from 0x40080000 to 0x40200000, end=41800000
> ## Loading init Ramdisk from Legacy Image at 4ff00000 ...
>     Image Name:   uInitrd
>     Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
>     Data Size:    7088075 Bytes = 6.8 MiB
>     Load Address: 00000000
>     Entry Point:  00000000
>     Verifying Checksum ... OK
> ## Flattened Device Tree blob at 4fa00000
>     Booting using the fdt blob at 0x4fa00000
> Working FDT set to 4fa00000
>     Loading Ramdisk to 4993d000, end 49fff7cb ... OK
>     Loading Device Tree to 00000000498cf000, end 000000004993cfff ... OK
> Working FDT set to 498cf000
> 
> Starting kernel ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version 6.6.2 (orangepi@orangepizero3) (gcc (Debian 
> 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP Sat Nov 
> 25 18:37:47 UTC 2023
> 
> 
> On 2023-11-26 4:23 a.m., Andre Przywara wrote:
> > On Sat, 25 Nov 2023 20:27:05 -0800
> > Stephen Graf <stephen.graf@gmail.com> wrote:
> > 
> > Hi Stephen,
> >   
> >> I built u-boot with the additional parameter for usb and it works, I think.  There was one message that might be of concern "
> >> Card did not respond to voltage select! : -110".  
> > 
> > This is a normal, though admittedly confusing message if no SD card is
> > inserted. The code tries to (unconditionally) access the SD card, and
> > sees that no card is there, the missing respond to the voltage select
> > command is just the first real proof of this.
> >   
> >> I am not sure of the details of the boot.cmd. The output below came from
> >> the supplier image on an SD plugged into a USB card reader. The SD slot of the board was empty.
> >>
> >> I was able to install u-boot to the SPI flash memory and there is a warning message from that also: "
> >> Loading Environment from SPIFlash... jedec_spi_nor flash@0: unrecognized JEDEC id bytes: 5e, 40, 18
> >> *** Warning - spi_flash_probe_bus_cs() failed, using default environment"  
> > 
> > So for a start there is no environment on the SPI flash yet, so it
> > wouldn't do anything. But the "unrecognised JEDEC id bytes" message
> > doesn't sound right. Can you dig into this? Do you have patch 1/3
> > applied, which tells U-Boot about 0x5e meaning zBIT?
> >   
> 

