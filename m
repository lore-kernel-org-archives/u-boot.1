Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DF2C61D97
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 00:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA02870B5;
	Sat, 25 Nov 2023 01:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3853870B5; Sat, 25 Nov 2023 01:52:57 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BB1A08701F
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 01:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65875FEC;
 Fri, 24 Nov 2023 16:53:40 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 251FA3F73F;
 Fri, 24 Nov 2023 16:52:53 -0800 (PST)
Date: Sat, 25 Nov 2023 00:51:40 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Stephen Graf <stephen.graf@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, linux-sunxi
 <linux-sunxi@lists.linux.dev>, Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: orangepi zero3
Message-ID: <20231125005140.3bafa549@slackpad.lan>
In-Reply-To: <b86e94ac-a469-4b29-81c4-b92dd478295a@gmail.com>
References: <28efed32-ee19-4a89-9c84-defa95c3a963@telus.net>
 <20231123141551.799dc14f@donnerap.manchester.arm.com>
 <dd04a65c-7f99-451b-9c89-b6300cdbf803@gmail.com>
 <20231124000952.6d24df32@slackpad.lan>
 <b86e94ac-a469-4b29-81c4-b92dd478295a@gmail.com>
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

On Fri, 24 Nov 2023 11:04:31 -0800
Stephen Graf <stephen.graf@gmail.com> wrote:

Hi,

> I tested a u-boot build with the emac timing changes you pointed out and=
=20
> with CONFIG_DRAM_CLK=3D792. It looks like this configuration and dts=20
> changes works with both 100Mb and 1Gb switches.

Ah, great, thanks! I will see if I can pull the DT change in sometime
soon.

> I am struggling to get something to actually load. Is there an easy way=20
> to get a debian image onto the sd card so that u-boot can actually load=20
> something.

Userland wise you can use any arm64 image, for instance any of the
cloud images, or you nick it from some existing arm64 installation.
Kernel wise the only requirement would be at least a v6.5 kernel, since
only this one supports the Motorcomm Ethernet PHY and, more
importantly: the PMIC.
Any distro kernel would do, or you bake your own, defconfig should be
enough for booting plus USB and MMC. CONFIG_DWMAC_SUN8I=3Dy and
CONFIG_MOTORCOMM_PHY=3Dy should give you Ethernet on top, I think, but
there might be more needed.

For a quick boot, set the commandline and load and boot the kernel:
=3D> setenv bootargs "console=3DttyS0,115200n8 earlycon root=3D/dev/mmcblk0=
p2 rootwait"
=3D> load mmc 0:1 $kernel_addr_r Image-6.7-rc2
=3D> booti $kernel_addr_r - $fdtcontroladdr

(those are rough instructions, please fill the gaps, or reply with specific=
 questions)

You could even try to install a distro, using the official UEFI
installers many distros provide. This process can be long and
tedious, though, plus you need a v6.5 installer kernel, and would
probably need to play around to get it booted automatically.

> Console output:

This seems to got mangled, but looks like expected: you just have
nothing that would load automatically. A USB stick with an UEFI boot
program should be detected and started, for instance a distro
installer. Still you would need a v6.5 kernel, without the PMIC driver
you won't get far.

Cheers,
Andre

P.S. You can put the whole firmware (U-Boot + TF-A) on the SPI flash,
that gives you more freedom with the SD card. Just follow the
instructions in doc/board/allwinner/sunxi.rst.

>=20
> U-Boot SPL 2024.01-rc3-00009-g9e53e45292-dirty (Nov 24 2023 - 18:47:11=20
> +0000) DRAM: 1024 MiB Trying to boot from MMC1 NOTICE: BL31: v2.10.0=20
> (debug):v2.10.0 NOTICE: BL31: Built : 18:07:18, Nov 23 2023 NOTICE:=20
> BL31: Detected Allwinner H616 SoC (1823) NOTICE: BL31: Found U-Boot DTB=20
> at 0x4a0b2750, model: OrangePi Zero3 INFO: ARM GICv2 driver initialized=20
> INFO: Configuring SPC Controller INFO: PMIC: Probing AXP305 on RSB=20
> ERROR: RSB: set run-time address: 0x10003 INFO: Could not init RSB:=20
> -65539 INFO: BL31: Platform setup done INFO: BL31: Initializing runtime=20
> services INFO: BL31: cortex_a53: CPU workaround for erratum 855873 was=20
> applied INFO: BL31: cortex_a53: CPU workaround for erratum 1530924 was=20
> applied INFO: PSCI: Suspend is unavailable INFO: BL31: Preparing for EL3=
=20
> exit to normal world INFO: Entry point address =3D 0x4a000000 INFO: SPSR =
=3D=20
> 0x3c9 INFO: Changed devicetree. U-Boot=20
> 2024.01-rc3-00009-g9e53e45292-dirty (Nov 24 2023 - 18:47:11 +0000)=20
> Allwinner Technology CPU: Allwinner H616 (SUN50I) Model: OrangePi Zero3=20
> DRAM: 1 GiB Core: 57 devices, 25 uclasses, devicetree: separate WDT: Not=
=20
> starting watchdog@30090a0 MMC: mmc@4020000: 0 Loading Environment from=20
> FAT... Unable to read "uboot.env" from mmc0:1... In: serial@5000000 Out:=
=20
> serial@5000000 Err: serial@5000000 Allwinner mUSB OTG (Peripheral) Net:=20
> eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1in STATUS ep2in=20
> MAC de:ad:be:ef:00:01 HOST MAC de:ad:be:ef:00:00 RNDIS ready , eth1:=20
> usb_ether starting USB... Bus usb@5200000: USB EHCI 1.00 Bus=20
> usb@5200400: USB OHCI 1.0 scanning bus usb@5200000 for devices... 1 USB=20
> Device(s) found scanning bus usb@5200400 for devices... 1 USB Device(s)=20
> found scanning usb for storage devices... 0 Storage Device(s) found Hit=20
> any key to stop autoboot: 0 switch to partitions #0, OK mmc0 is current=20
> device Scanning mmc 0:1... No EFI system partition No EFI system=20
> partition Failed to persist EFI variables BootOrder not defined EFI boot=
=20
> manager: Cannot load any image Device 0: unknown device BOOTP broadcast=20
> 1 DHCP client bound to address 192.168.1.63 (4 ms) *** Warning: no boot=20
> file name; using 'C0A8013F.img' Using ethernet@5020000 device TFTP from=20
> server 192.168.1.253; our IP address is 192.168.1.63 Filename=20
> 'C0A8013F.img'. Load address: 0x42000000 Loading: T T T
>=20
> On 2023-11-23 4:11 p.m., Andre Przywara wrote:
> > On Thu, 23 Nov 2023 11:12:25 -0800
> > Stephen Graf<stephen.graf@gmail.com>  wrote:
> >
> > Hi Stephen,
> > =20
> >> Thank you for your reply. =20
> > Thanks for coming back. Please keep the list(s) on CC:, as this is also
> > interesting for others, and more eyes help to find issues faster.
> > CC:ing Piotr and Mikhail, who were debugging the LPDDR4 DRAM setup
> > before.
> > =20
> >> I built u-boot with the proposed changes and it seems to work. It does
> >> however report "DRAM: 2048 MiB" although I have a board with only 1G. =
=20
> > Ah, that's a good report! I actually saw the same issue (reporting 8GB
> > instead of 4GB), and my hunch is that it's related to some missing
> > barriers or delays, as seen on other boards.
> > Can you try to add a "dsb();" to the beginning of
> > arch/arm/mach-sunxi/dram_helpers.c:mctl_mem_matches(), before the first=
 writel()?
> > I am still not convinced this is the right place to put the barrier,
> > but it would confirm that this is the issue.
> > Also I didn't see this effect consistently, so did this happen for you
> > every time?
> >
> > Another thing you could try is to increase the voltage to 1150mV, this
> > is what Piotr needed for reliable operation.
> > =20
> >> When I built u-boot with the config that I used it reported 1G
> >> correctly. The Zunlong distros do have different images for various RAM
> >> configurations. =20
> > Yeah, I saw this, and I hope we can avoid this. I am not sure if you
> > are the first one with a 1GB board, so your testing is definitely
> > helpful.
> > =20
> >> I do not know enough about the details to determine which differences =
in
> >> the two configs result in the change.
> >>
> >> I am more than willing to test and report if someone can direct me a b=
it.
> >>
> >> sysadmin@ubuntu:~/defconfgs$ diff sg.txt andre.txt =20
> > (please use "diff -u", that's easier to read and people are more used
> > to its output style)
> > =20
> >> 9d8
> >> < CONFIG_DRAM_SUN50I_H616_TPR0=3D0x0
> >> 11,13c10,12
> >> < CONFIG_DRAM_SUN50I_H616_TPR10=3D0x402f0663
> >> < CONFIG_DRAM_SUN50I_H616_TPR11=3D0x24242323
> >> < CONFIG_DRAM_SUN50I_H616_TPR12=3D0x0e0e0e0e
> >> --- =20
> >>   > CONFIG_DRAM_SUN50I_H616_TPR10=3D0x402f6663
> >>   > CONFIG_DRAM_SUN50I_H616_TPR11=3D0x24242624
> >>   > CONFIG_DRAM_SUN50I_H616_TPR12=3D0x0f0f100f =20
> > I don't think those minor timing differences matter much, but you can
> > try to experiment with both set of values.
> > =20
> >> 16d14
> >> < CONFIG_DRAM_CLK=3D792 =20
> > Not specifying DRAM_CLK means it uses the default 720 MHz. In the past
> > lowering the DRAM frequency was an easy way to stabilise the DRAM
> > setup, even though this might somewhat paper over other issues.
> > =20
> >> 25c23
> >> < CONFIG_SPI_FLASH_MACRONIX=3Dy
> >> --- =20
> >>   > CONFIG_SPI_FLASH_ZBIT=3Dy =20
> > Please double check, but I think all new OrangePi boards now use a zBIT
> > flash chip? Should have a small "Z" like logo on that 8 pin chip with
> > the large pins on top.
> > =20
> >> 27a26 =20
> >>   > CONFIG_AXP313_POWER=3Dy =20
> >> 32,34c31
> >> < CONFIG_AXP313_POWER=3Dy
> >> < CONFIG_AXP_DCDC3_VOLT=3D1100 =20
> > 1100mV is the default, so putting exactly this value in doesn't change
> > anything.
> > =20
> >> < CONFIG_CMD_BOOTZ=3Dy =20
> > Why do you need bootz? I don't think this doing anything useful in
> > mainline U-Boot. Don't know if OrangePi was just confused and had an
> > actual use case for this.
> >
> > =20
> >> --- =20
> >>   > =20
> >>
> >> A second issue that I discovered with both builds is that the Ethernet
> >> does not come up on a 1Gb switch, but works on a 100Mb switch. =20
> > There is a pending patch for mainline Linux, can you try to apply those
> > DT changes to U-Boot's DT copy and see if that helps?
> > https://lore.kernel.org/linux-sunxi/2303336.ElGaqSPkdT@jernej-laptop/T/=
#m77ee30923cb0351f2d701a463a940dc7c00fa8b7
> >
> > Cheers,
> > Andre
> >
> > =20
> >> Output from the patch defconfig (1Gb LAN):
> >>
> >> U-Boot SPL 2024.01-rc3-00009-g9e53e45292-dirty (Nov 23 2023 - 18:08:24
> >> +0000)
> >> DRAM: 2048 MiB
> >> Trying to boot from MMC1
> >> NOTICE:=C2=A0 BL31: v2.10.0=C2=A0 (debug):v2.10.0
> >> NOTICE:=C2=A0 BL31: Built : 18:07:18, Nov 23 2023
> >> NOTICE:=C2=A0 BL31: Detected Allwinner H616 SoC (1823)
> >> NOTICE:=C2=A0 BL31: Found U-Boot DTB at 0x4a0b2750, model: OrangePi Ze=
ro3
> >> INFO:=C2=A0=C2=A0=C2=A0 ARM GICv2 driver initialized
> >> INFO:=C2=A0=C2=A0=C2=A0 Configuring SPC Controller
> >> INFO:=C2=A0=C2=A0=C2=A0 PMIC: Probing AXP305 on RSB
> >> ERROR:=C2=A0=C2=A0 RSB: set run-time address: 0x10003
> >> INFO:=C2=A0=C2=A0=C2=A0 Could not init RSB: -65539
> >> INFO:=C2=A0=C2=A0=C2=A0 BL31: Platform setup done
> >> INFO:=C2=A0=C2=A0=C2=A0 BL31: Initializing runtime services
> >> INFO:=C2=A0=C2=A0=C2=A0 BL31: cortex_a53: CPU workaround for erratum 8=
55873 was applied
> >> INFO:=C2=A0=C2=A0=C2=A0 BL31: cortex_a53: CPU workaround for erratum 1=
530924 was applied
> >> INFO:=C2=A0=C2=A0=C2=A0 PSCI: Suspend is unavailable
> >> INFO:=C2=A0=C2=A0=C2=A0 BL31: Preparing for EL3 exit to normal world
> >> INFO:=C2=A0=C2=A0=C2=A0 Entry point address =3D 0x4a000000
> >> INFO:=C2=A0=C2=A0=C2=A0 SPSR =3D 0x3c9
> >> INFO:=C2=A0=C2=A0=C2=A0 Changed devicetree.
> >>
> >>
> >> U-Boot 2024.01-rc3-00009-g9e53e45292-dirty (Nov 23 2023 - 18:08:24
> >> +0000) Allwinner Technology
> >>
> >> CPU:=C2=A0=C2=A0 Allwinner H616 (SUN50I)
> >> Model: OrangePi Zero3
> >> DRAM:=C2=A0 2 GiB
> >> Core:=C2=A0 57 devices, 25 uclasses, devicetree: separate
> >> WDT:=C2=A0=C2=A0 Not starting watchdog@30090a0
> >> MMC:=C2=A0=C2=A0 mmc@4020000: 0
> >> Loading Environment from FAT... Unable to use mmc 0:1...
> >> In:=C2=A0=C2=A0=C2=A0 serial@5000000
> >> Out:=C2=A0=C2=A0 serial@5000000
> >> Err:=C2=A0=C2=A0 serial@5000000
> >> Allwinner mUSB OTG (Peripheral)
> >> Net:=C2=A0=C2=A0 eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN =
ep1in STATUS
> >> ep2in
> >> MAC de:ad:be:ef:00:01
> >> HOST MAC de:ad:be:ef:00:00
> >> RNDIS ready
> >> , eth1: usb_ether
> >> starting USB...
> >> Bus usb@5200000: USB EHCI 1.00
> >> Bus usb@5200400: USB OHCI 1.0
> >> scanning bus usb@5200000 for devices... 1 USB Device(s) found
> >> scanning bus usb@5200400 for devices... 1 USB Device(s) found
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scanning usb for storage device=
s... 0 Storage Device(s) found
> >> Hit any key to stop autoboot:=C2=A0 0
> >> switch to partitions #0, OK
> >> mmc0 is current device
> >>
> >> Device 0: unknown device
> >> BOOTP broadcast 1
> >> BOOTP broadcast 2
> >> BOOTP broadcast 3
> >> BOOTP broadcast 4
> >> BOOTP broadcast 5
> >> BOOTP broadcast 6
> >> BOOTP broadcast 7
> >> BOOTP broadcast 8
> >> BOOTP broadcast 9
> >> BOOTP broadcast 10
> >> BOOTP broadcast 11
> >> BOOTP broadcast 12
> >>
> >> Retry time exceeded; starting again
> >> missing environment variable: pxeuuid
> >> Retrieving file: pxelinux.cfg/01-02-00-d5-13-4f-ba
> >> *** ERROR: `serverip' not set
> >>
> >>
> >> Output from the defconfig that I had used (100Mb LAN):
> >>
> >> U-Boot SPL 2024.01-rc3-00009-g9e53e45292-dirty (Nov 23 2023 - 18:56:18
> >> +0000)
> >> DRAM: 1024 MiB
> >> Trying to boot from MMC1
> >> NOTICE:=C2=A0 BL31: v2.10.0=C2=A0 (debug):v2.10.0
> >> NOTICE:=C2=A0 BL31: Built : 18:07:18, Nov 23 2023
> >> NOTICE:=C2=A0 BL31: Detected Allwinner H616 SoC (1823)
> >> NOTICE:=C2=A0 BL31: Found U-Boot DTB at 0x4a0b3b68, model: OrangePi Ze=
ro3
> >> INFO:=C2=A0=C2=A0=C2=A0 ARM GICv2 driver initialized
> >> INFO:=C2=A0=C2=A0=C2=A0 Configuring SPC Controller
> >> INFO:=C2=A0=C2=A0=C2=A0 PMIC: Probing AXP305 on RSB
> >> ERROR:=C2=A0=C2=A0 RSB: set run-time address: 0x10003
> >> INFO:=C2=A0=C2=A0=C2=A0 Could not init RSB: -65539
> >> INFO:=C2=A0=C2=A0=C2=A0 BL31: Platform setup done
> >> INFO:=C2=A0=C2=A0=C2=A0 BL31: Initializing runtime services
> >> INFO:=C2=A0=C2=A0=C2=A0 BL31: cortex_a53: CPU workaround for erratum 8=
55873 was applied
> >> INFO:=C2=A0=C2=A0=C2=A0 BL31: cortex_a53: CPU workaround for erratum 1=
530924 was applied
> >> INFO:=C2=A0=C2=A0=C2=A0 PSCI: Suspend is unavailable
> >> INFO:=C2=A0=C2=A0=C2=A0 BL31: Preparing for EL3 exit to normal world
> >> INFO:=C2=A0=C2=A0=C2=A0 Entry point address =3D 0x4a000000
> >> INFO:=C2=A0=C2=A0=C2=A0 SPSR =3D 0x3c9
> >> INFO:=C2=A0=C2=A0=C2=A0 Changed devicetree.
> >>
> >>
> >> U-Boot 2024.01-rc3-00009-g9e53e45292-dirty (Nov 23 2023 - 18:56:18
> >> +0000) Allwinner Technology
> >>
> >> CPU:=C2=A0=C2=A0 Allwinner H616 (SUN50I)
> >> Model: OrangePi Zero3
> >> DRAM:=C2=A0 1 GiB
> >> Core:=C2=A0 57 devices, 25 uclasses, devicetree: separate
> >> WDT:=C2=A0=C2=A0 Not starting watchdog@30090a0
> >> MMC:=C2=A0=C2=A0 mmc@4020000: 0
> >> Loading Environment from FAT... Unable to use mmc 0:1...
> >> In:=C2=A0=C2=A0=C2=A0 serial@5000000
> >> Out:=C2=A0=C2=A0 serial@5000000
> >> Err:=C2=A0=C2=A0 serial@5000000
> >> Allwinner mUSB OTG (Peripheral)
> >> Net:=C2=A0=C2=A0 eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN =
ep1in STATUS
> >> ep2in
> >> MAC de:ad:be:ef:00:01
> >> HOST MAC de:ad:be:ef:00:00
> >> RNDIS ready
> >> , eth1: usb_ether
> >> starting USB...
> >> Bus usb@5200000: USB EHCI 1.00
> >> Bus usb@5200400: USB OHCI 1.0
> >> scanning bus usb@5200000 for devices... 1 USB Device(s) found
> >> scanning bus usb@5200400 for devices... 1 USB Device(s) found
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scanning usb for storage device=
s... 0 Storage Device(s) found
> >> Hit any key to stop autoboot:=C2=A0 0
> >> switch to partitions #0, OK
> >> mmc0 is current device
> >>
> >> Device 0: unknown device
> >> BOOTP broadcast 1
> >> DHCP client bound to address 192.168.1.63 (5 ms)
> >> *** Warning: no boot file name; using 'C0A8013F.img'
> >> Using ethernet@5020000 device
> >> TFTP from server 192.168.1.253; our IP address is 192.168.1.63
> >> Filename 'C0A8013F.img'.
> >> Load address: 0x42000000
> >> Loading: T T T
> >>
> >> defconfig used:
> >>
> >> CONFIG_ARM=3Dy
> >> CONFIG_ARCH_SUNXI=3Dy
> >> CONFIG_DEFAULT_DEVICE_TREE=3D"sun50i-h618-orangepi-zero3"
> >> CONFIG_SPL=3Dy
> >> CONFIG_DRAM_SUN50I_H616_DX_ODT=3D0x07070707
> >> CONFIG_DRAM_SUN50I_H616_DX_DRI=3D0x0e0e0e0e
> >> CONFIG_DRAM_SUN50I_H616_CA_DRI=3D0x0e0e
> >> CONFIG_DRAM_SUN50I_H616_ODT_EN=3D0xaaaaeeee
> >> CONFIG_DRAM_SUN50I_H616_TPR0=3D0x0
> >> CONFIG_DRAM_SUN50I_H616_TPR6=3D0x44000000
> >> CONFIG_DRAM_SUN50I_H616_TPR10=3D0x402f0663
> >> CONFIG_DRAM_SUN50I_H616_TPR11=3D0x24242323
> >> CONFIG_DRAM_SUN50I_H616_TPR12=3D0x0e0e0e0e
> >> CONFIG_MACH_SUN50I_H616=3Dy
> >> CONFIG_SUNXI_DRAM_H616_LPDDR4=3Dy
> >> CONFIG_DRAM_CLK=3D792
> >> CONFIG_R_I2C_ENABLE=3Dy
> >> CONFIG_SPL_SPI_SUNXI=3Dy
> >> # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> >> CONFIG_SPL_I2C=3Dy
> >> CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> >> CONFIG_SYS_I2C_MVTWSI=3Dy
> >> CONFIG_SYS_I2C_SLAVE=3D0x7f
> >> CONFIG_SYS_I2C_SPEED=3D400000
> >> CONFIG_SPI_FLASH_MACRONIX=3Dy
> >> CONFIG_PHY_MOTORCOMM=3Dy
> >> CONFIG_SUN8I_EMAC=3Dy
> >> CONFIG_SPI=3Dy
> >> CONFIG_USB_EHCI_HCD=3Dy
> >> CONFIG_USB_OHCI_HCD=3Dy
> >> CONFIG_USB_MUSB_GADGET=3Dy
> >> CONFIG_AXP313_POWER=3Dy
> >> CONFIG_AXP_DCDC3_VOLT=3D1100
> >> CONFIG_CMD_BOOTZ=3Dy
> >>
> >>
> >> On 2023-11-23 6:15 a.m., Andre Przywara wrote: =20
> >>> On Tue, 21 Nov 2023 21:52:12 -0800
> >>> Stephen Graf<s_graf@telus.net>  wrote:
> >>>
> >>> Hi Stephen,
> >>>    =20
> >>>> I have been able to build a working (on my orangepi zero3 1G) u-boot=
 for
> >>>> the orangepi zero3 with the following defconfig. Would it be possibl=
e to =20
> >>> thanks for your interest in contributing and for reaching out!
> >>> As Peter already mentioned, you would need to send a patch, as genera=
ted
> >>> by "git format-patch". "git send-email" would help you with sending t=
his
> >>> out.
> >>>
> >>> But actually I sent a small series already last week:
> >>> https://lore.kernel.org/u-boot/20231114013106.31336-1-andre.przywara@=
arm.com/
> >>>
> >>> If you could apply these patches and test it on your board, I'd be
> >>> grateful. If it works for you and you are happy, please reply to patc=
h 3/3
> >>> and add a "Tested-by: Your Name<your@email.com>" line.
> >>> For instructions how to reply, check "Reply instructions" at the end =
of
> >>> that mailing list archive web page above.
> >>>
> >>> I was just waiting for confirmations by other people before merging i=
t.
> >>>
> >>> Cheers,
> >>> Andre
> >>>
> >>>    =20
> >>>> add this config to the working boards.=C2=A0 I would test it again w=
ith an
> >>>> official build. The dtb/dts is in linux and in u-boot.
> >>>>
> >>>> The H618 processor is software compatible with the H616 and the zero3
> >>>> board is very similar to the zero2 with the exception of DDR3 replac=
ed
> >>>> with LPDDR4 and the Realtek phy with Motorcomm.
> >>>>
> >>>> CONFIG_ARM=3Dy
> >>>> CONFIG_ARCH_SUNXI=3Dy
> >>>> CONFIG_DEFAULT_DEVICE_TREE=3D"sun50i-h618-orangepi-zero3"
> >>>> CONFIG_SPL=3Dy
> >>>> CONFIG_DRAM_SUN50I_H616_DX_ODT=3D0x07070707
> >>>> CONFIG_DRAM_SUN50I_H616_DX_DRI=3D0x0e0e0e0e
> >>>> CONFIG_DRAM_SUN50I_H616_CA_DRI=3D0x0e0e
> >>>> CONFIG_DRAM_SUN50I_H616_ODT_EN=3D0xaaaaeeee
> >>>> CONFIG_DRAM_SUN50I_H616_TPR0=3D0x0
> >>>> CONFIG_DRAM_SUN50I_H616_TPR6=3D0x44000000
> >>>> CONFIG_DRAM_SUN50I_H616_TPR10=3D0x402f0663
> >>>> CONFIG_DRAM_SUN50I_H616_TPR11=3D0x24242323
> >>>> CONFIG_DRAM_SUN50I_H616_TPR12=3D0x0e0e0e0e
> >>>> CONFIG_MACH_SUN50I_H616=3Dy
> >>>> CONFIG_SUNXI_DRAM_H616_LPDDR4=3Dy
> >>>> CONFIG_DRAM_CLK=3D792
> >>>> CONFIG_R_I2C_ENABLE=3Dy
> >>>> CONFIG_SPL_SPI_SUNXI=3Dy
> >>>> # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> >>>> CONFIG_SPL_I2C=3Dy
> >>>> CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> >>>> CONFIG_SYS_I2C_MVTWSI=3Dy
> >>>> CONFIG_SYS_I2C_SLAVE=3D0x7f
> >>>> CONFIG_SYS_I2C_SPEED=3D400000
> >>>> CONFIG_SPI_FLASH_MACRONIX=3Dy
> >>>> CONFIG_PHY_MOTORCOMM=3Dy
> >>>> CONFIG_SUN8I_EMAC=3Dy
> >>>> CONFIG_SPI=3Dy
> >>>> CONFIG_USB_EHCI_HCD=3Dy
> >>>> CONFIG_USB_OHCI_HCD=3Dy
> >>>> CONFIG_USB_MUSB_GADGET=3Dy
> >>>> CONFIG_AXP313_POWER=3Dy
> >>>> CONFIG_AXP_DCDC3_VOLT=3D1100
> >>>> CONFIG_CMD_BOOTZ=3Dy
> >>>>    =20

