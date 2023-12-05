Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12B5C10DCE
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 18:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32CA486EF6;
	Tue,  5 Dec 2023 19:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C44A86F42; Tue,  5 Dec 2023 19:30:58 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4DD8E86DD1
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 19:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E5B139F;
 Tue,  5 Dec 2023 10:31:42 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 242E63F762;
 Tue,  5 Dec 2023 10:30:54 -0800 (PST)
Date: Tue, 5 Dec 2023 18:30:47 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Stephen Graf <stephen.graf@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Mikhail
 Kalashnikov <iuncuim@gmail.com>, Piotr Oniszczuk
 <piotr.oniszczuk@gmail.com>, Bob McChesney <bob@electricworry.net>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 0/3] sunxi: add OrangePi Zero 3 board support
Message-ID: <20231205183047.467aa14c@donnerap.manchester.arm.com>
In-Reply-To: <1f373e2d-c71a-412f-819a-27b82fc254f4@gmail.com>
References: <20231204005954.13201-1-andre.przywara@arm.com>
 <1f373e2d-c71a-412f-819a-27b82fc254f4@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Sun, 3 Dec 2023 21:57:51 -0800
Stephen Graf <stephen.graf@gmail.com> wrote:

Hi Stephen,

> I have tested a newly built u-boot with the patches you provided and it works well.
> It is the same configuration as what I have been testing with for the last few weeks.
> 
> I loaded the U-boot to SPI flash and tested with the SD card removed from the system
> and put in a USB card reader. The output for that test is below.

thanks for your testing efforts! Is it OK if I convert this statement into
a "Tested-by:" tag with your email, to become part of the commit?

Cheers,
Andre


> For completeness you might want to mention that another difference between the zero2
> and zero3 is the emac phy going from Realtek to Motorcomm.
> 
> Thank you for fixing my patch attempt. It is the first one I have ever done.
> Thank you also for your patience with my fumbling attempts. I have learned a lot
> from you in the last two weeks.
> 
> U-Boot SPL 2024.01-rc3-00043-g5c4e9d0c74-dirty (Dec 03 2023 - 18:21:41 -0800)
> DRAM: 1024 MiB
> Trying to boot from sunxi SPI
> NOTICE:  BL31: v2.10.0  (debug):v2.10.0
> NOTICE:  BL31: Built : 18:07:18, Nov 23 2023
> NOTICE:  BL31: Detected Allwinner H616 SoC (1823)
> NOTICE:  BL31: Found U-Boot DTB at 0x4a0b2828, model: OrangePi Zero3
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
> U-Boot 2024.01-rc3-00043-g5c4e9d0c74-dirty (Dec 03 2023 - 18:21:41 -0800) Allwinner Technology
> 
> CPU:   Allwinner H616 (SUN50I)
> Model: OrangePi Zero3
> DRAM:  1 GiB
> Core:  57 devices, 25 uclasses, devicetree: separate
> WDT:   Not starting watchdog@30090a0
> MMC:   mmc@4020000: 0
> Loading Environment from SPIFlash... SF: Detected zb25vq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
> OK
> In:    serial@5000000
> Out:   serial@5000000
> Err:   serial@5000000
> Allwinner mUSB OTG (Peripheral)
> Net:   eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1in STATUS ep2in
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
>              Capacity: 15193.5 MB = 14.8 GB (31116288 x 512)
> ... is now current device
> Scanning usb 0:1...
> Found U-Boot script /boot/boot.scr
> 1052 bytes read in 1 ms (1 MiB/s)
> ## Executing script at 4fc00000
> Card did not respond to voltage select! : -110
> ** Bad device specification mmc 0 **
> 19472 bytes read in 3 ms (6.2 MiB/s)
> No FDT memory address configured. Please configure
> the FDT address via "fdt addr <address>" command.
> Aborting!
> 7088139 bytes read in 324 ms (20.9 MiB/s)
> 22491144 bytes read in 1025 ms (20.9 MiB/s)
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
>     Loading Device Tree to 0000000049935000, end 000000004993cc0f ... OK
> Working FDT set to 49935000
> 
> Starting kernel ...
> 
> 
> Welcome to Debian GNU/Linux 12 (bookworm)!
> 
> 
> 
> On 2023-12-03 4:59 p.m., Andre Przywara wrote:
> > A small update for the OrangePi Zero 3 support series. This fixes
> > USB support, and upgrades the DRAM clock to 792, for better stability
> > (as the other DRAM parameters were tailored to that frequency). I added
> > the tags on the way.
> > Please test!
> > 
> > =================
> > The OrangePi Zero 3 is a small development board featuring the Allwinner
> > H618 SoC. Compared to its predecessor OrangePi Zero 2, the new board uses
> > LPDDR4 DRAM instead of DDR3 DRAM, and an X-Powers AXP313 PMIC instead of
> > the AXP305.
> > U-Boot gained support for both LPDDR4 DRAM and the new PMIC just
> > recently, so add a user for those features by adding a defconfig for the
> > new board.
> > To make this work, patch 1/3 introduces support for zBIT SPI NOR flash
> > chip, and patch 2/3 removes the default AXP305 PMIC selection when
> > compiling for H616 SoCs.
> > Patch 3/3 then adds the defconfig. The DT was already synced from the
> > Linux kernel repo a few weeks ago.
> > 
> > Cheers,
> > Andre
> > 
> > Changelog v1 .. v2:
> > - add tags
> > - set DRAM clock to 792 MHz (from the default 720 MHz)
> > - fix USB support by supplying USB VBUS enable GPIO
> > 
> > Andre Przywara (3):
> >    mtd: spi-nor: Add support for zBIT ZB25VQ128
> >    sunxi: H616: remove default AXP305 selection
> >    sunxi: H616: Add OrangePi Zero 3 board support
> > 
> >   arch/arm/dts/Makefile            |  1 +
> >   board/sunxi/MAINTAINERS          |  5 +++++
> >   configs/orangepi_zero2_defconfig |  1 +
> >   configs/orangepi_zero3_defconfig | 32 ++++++++++++++++++++++++++++++++
> >   configs/x96_mate_defconfig       |  1 +
> >   drivers/mtd/spi/Kconfig          |  5 +++++
> >   drivers/mtd/spi/spi-nor-ids.c    |  5 +++++
> >   drivers/power/Kconfig            |  1 -
> >   8 files changed, 50 insertions(+), 1 deletion(-)
> >   create mode 100644 configs/orangepi_zero3_defconfig
> >   

