Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82DDC61D85
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 00:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5354586F1C;
	Fri, 24 Nov 2023 01:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988FE86F1C; Fri, 24 Nov 2023 01:12:33 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2ECC286BB3
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 01:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DAE61063;
 Thu, 23 Nov 2023 16:13:16 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE9D23F73F;
 Thu, 23 Nov 2023 16:12:28 -0800 (PST)
Date: Fri, 24 Nov 2023 00:11:17 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Stephen Graf <stephen.graf@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, linux-sunxi
 <linux-sunxi@lists.linux.dev>, Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: orangepi zero3
Message-ID: <20231124000952.6d24df32@slackpad.lan>
In-Reply-To: <dd04a65c-7f99-451b-9c89-b6300cdbf803@gmail.com>
References: <28efed32-ee19-4a89-9c84-defa95c3a963@telus.net>
 <20231123141551.799dc14f@donnerap.manchester.arm.com>
 <dd04a65c-7f99-451b-9c89-b6300cdbf803@gmail.com>
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

On Thu, 23 Nov 2023 11:12:25 -0800
Stephen Graf <stephen.graf@gmail.com> wrote:

Hi Stephen,

> Thank you for your reply.

Thanks for coming back. Please keep the list(s) on CC:, as this is also
interesting for others, and more eyes help to find issues faster.
CC:ing Piotr and Mikhail, who were debugging the LPDDR4 DRAM setup
before.

> I built u-boot with the proposed changes and it seems to work. It does=20
> however report "DRAM: 2048 MiB" although I have a board with only 1G.

Ah, that's a good report! I actually saw the same issue (reporting 8GB
instead of 4GB), and my hunch is that it's related to some missing
barriers or delays, as seen on other boards.
Can you try to add a "dsb();" to the beginning of
arch/arm/mach-sunxi/dram_helpers.c:mctl_mem_matches(), before the first wri=
tel()?
I am still not convinced this is the right place to put the barrier,
but it would confirm that this is the issue.
Also I didn't see this effect consistently, so did this happen for you
every time?

Another thing you could try is to increase the voltage to 1150mV, this
is what Piotr needed for reliable operation.

>=20
> When I built u-boot with the config that I used it reported 1G=20
> correctly. The Zunlong distros do have different images for various RAM=20
> configurations.

Yeah, I saw this, and I hope we can avoid this. I am not sure if you
are the first one with a 1GB board, so your testing is definitely
helpful.

> I do not know enough about the details to determine which differences in=
=20
> the two configs result in the change.
>=20
> I am more than willing to test and report if someone can direct me a bit.
>=20
> sysadmin@ubuntu:~/defconfgs$ diff sg.txt andre.txt

(please use "diff -u", that's easier to read and people are more used
to its output style)

> 9d8
> < CONFIG_DRAM_SUN50I_H616_TPR0=3D0x0
> 11,13c10,12
> < CONFIG_DRAM_SUN50I_H616_TPR10=3D0x402f0663
> < CONFIG_DRAM_SUN50I_H616_TPR11=3D0x24242323
> < CONFIG_DRAM_SUN50I_H616_TPR12=3D0x0e0e0e0e
> ---
>  > CONFIG_DRAM_SUN50I_H616_TPR10=3D0x402f6663
>  > CONFIG_DRAM_SUN50I_H616_TPR11=3D0x24242624
>  > CONFIG_DRAM_SUN50I_H616_TPR12=3D0x0f0f100f

I don't think those minor timing differences matter much, but you can
try to experiment with both set of values.

> 16d14
> < CONFIG_DRAM_CLK=3D792

Not specifying DRAM_CLK means it uses the default 720 MHz. In the past
lowering the DRAM frequency was an easy way to stabilise the DRAM
setup, even though this might somewhat paper over other issues.

> 25c23
> < CONFIG_SPI_FLASH_MACRONIX=3Dy
> ---
>  > CONFIG_SPI_FLASH_ZBIT=3Dy

Please double check, but I think all new OrangePi boards now use a zBIT
flash chip? Should have a small "Z" like logo on that 8 pin chip with
the large pins on top.

> 27a26
>  > CONFIG_AXP313_POWER=3Dy =20
> 32,34c31
> < CONFIG_AXP313_POWER=3Dy
> < CONFIG_AXP_DCDC3_VOLT=3D1100

1100mV is the default, so putting exactly this value in doesn't change
anything.

> < CONFIG_CMD_BOOTZ=3Dy

Why do you need bootz? I don't think this doing anything useful in
mainline U-Boot. Don't know if OrangePi was just confused and had an
actual use case for this.


> ---
>  > =20
>=20
> A second issue that I discovered with both builds is that the Ethernet=20
> does not come up on a 1Gb switch, but works on a 100Mb switch.

There is a pending patch for mainline Linux, can you try to apply those
DT changes to U-Boot's DT copy and see if that helps?
https://lore.kernel.org/linux-sunxi/2303336.ElGaqSPkdT@jernej-laptop/T/#m77=
ee30923cb0351f2d701a463a940dc7c00fa8b7

Cheers,
Andre


>=20
> Output from the patch defconfig (1Gb LAN):
>=20
> U-Boot SPL 2024.01-rc3-00009-g9e53e45292-dirty (Nov 23 2023 - 18:08:24=20
> +0000)
> DRAM: 2048 MiB
> Trying to boot from MMC1
> NOTICE:=C2=A0 BL31: v2.10.0=C2=A0 (debug):v2.10.0
> NOTICE:=C2=A0 BL31: Built : 18:07:18, Nov 23 2023
> NOTICE:=C2=A0 BL31: Detected Allwinner H616 SoC (1823)
> NOTICE:=C2=A0 BL31: Found U-Boot DTB at 0x4a0b2750, model: OrangePi Zero3
> INFO:=C2=A0=C2=A0=C2=A0 ARM GICv2 driver initialized
> INFO:=C2=A0=C2=A0=C2=A0 Configuring SPC Controller
> INFO:=C2=A0=C2=A0=C2=A0 PMIC: Probing AXP305 on RSB
> ERROR:=C2=A0=C2=A0 RSB: set run-time address: 0x10003
> INFO:=C2=A0=C2=A0=C2=A0 Could not init RSB: -65539
> INFO:=C2=A0=C2=A0=C2=A0 BL31: Platform setup done
> INFO:=C2=A0=C2=A0=C2=A0 BL31: Initializing runtime services
> INFO:=C2=A0=C2=A0=C2=A0 BL31: cortex_a53: CPU workaround for erratum 8558=
73 was applied
> INFO:=C2=A0=C2=A0=C2=A0 BL31: cortex_a53: CPU workaround for erratum 1530=
924 was applied
> INFO:=C2=A0=C2=A0=C2=A0 PSCI: Suspend is unavailable
> INFO:=C2=A0=C2=A0=C2=A0 BL31: Preparing for EL3 exit to normal world
> INFO:=C2=A0=C2=A0=C2=A0 Entry point address =3D 0x4a000000
> INFO:=C2=A0=C2=A0=C2=A0 SPSR =3D 0x3c9
> INFO:=C2=A0=C2=A0=C2=A0 Changed devicetree.
>=20
>=20
> U-Boot 2024.01-rc3-00009-g9e53e45292-dirty (Nov 23 2023 - 18:08:24=20
> +0000) Allwinner Technology
>=20
> CPU:=C2=A0=C2=A0 Allwinner H616 (SUN50I)
> Model: OrangePi Zero3
> DRAM:=C2=A0 2 GiB
> Core:=C2=A0 57 devices, 25 uclasses, devicetree: separate
> WDT:=C2=A0=C2=A0 Not starting watchdog@30090a0
> MMC:=C2=A0=C2=A0 mmc@4020000: 0
> Loading Environment from FAT... Unable to use mmc 0:1...
> In:=C2=A0=C2=A0=C2=A0 serial@5000000
> Out:=C2=A0=C2=A0 serial@5000000
> Err:=C2=A0=C2=A0 serial@5000000
> Allwinner mUSB OTG (Peripheral)
> Net:=C2=A0=C2=A0 eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1=
in STATUS=20
> ep2in
> MAC de:ad:be:ef:00:01
> HOST MAC de:ad:be:ef:00:00
> RNDIS ready
> , eth1: usb_ether
> starting USB...
> Bus usb@5200000: USB EHCI 1.00
> Bus usb@5200400: USB OHCI 1.0
> scanning bus usb@5200000 for devices... 1 USB Device(s) found
> scanning bus usb@5200400 for devices... 1 USB Device(s) found
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scanning usb for storage devices...=
 0 Storage Device(s) found
> Hit any key to stop autoboot:=C2=A0 0
> switch to partitions #0, OK
> mmc0 is current device
>=20
> Device 0: unknown device
> BOOTP broadcast 1
> BOOTP broadcast 2
> BOOTP broadcast 3
> BOOTP broadcast 4
> BOOTP broadcast 5
> BOOTP broadcast 6
> BOOTP broadcast 7
> BOOTP broadcast 8
> BOOTP broadcast 9
> BOOTP broadcast 10
> BOOTP broadcast 11
> BOOTP broadcast 12
>=20
> Retry time exceeded; starting again
> missing environment variable: pxeuuid
> Retrieving file: pxelinux.cfg/01-02-00-d5-13-4f-ba
> *** ERROR: `serverip' not set
>=20
>=20
> Output from the defconfig that I had used (100Mb LAN):
>=20
> U-Boot SPL 2024.01-rc3-00009-g9e53e45292-dirty (Nov 23 2023 - 18:56:18=20
> +0000)
> DRAM: 1024 MiB
> Trying to boot from MMC1
> NOTICE:=C2=A0 BL31: v2.10.0=C2=A0 (debug):v2.10.0
> NOTICE:=C2=A0 BL31: Built : 18:07:18, Nov 23 2023
> NOTICE:=C2=A0 BL31: Detected Allwinner H616 SoC (1823)
> NOTICE:=C2=A0 BL31: Found U-Boot DTB at 0x4a0b3b68, model: OrangePi Zero3
> INFO:=C2=A0=C2=A0=C2=A0 ARM GICv2 driver initialized
> INFO:=C2=A0=C2=A0=C2=A0 Configuring SPC Controller
> INFO:=C2=A0=C2=A0=C2=A0 PMIC: Probing AXP305 on RSB
> ERROR:=C2=A0=C2=A0 RSB: set run-time address: 0x10003
> INFO:=C2=A0=C2=A0=C2=A0 Could not init RSB: -65539
> INFO:=C2=A0=C2=A0=C2=A0 BL31: Platform setup done
> INFO:=C2=A0=C2=A0=C2=A0 BL31: Initializing runtime services
> INFO:=C2=A0=C2=A0=C2=A0 BL31: cortex_a53: CPU workaround for erratum 8558=
73 was applied
> INFO:=C2=A0=C2=A0=C2=A0 BL31: cortex_a53: CPU workaround for erratum 1530=
924 was applied
> INFO:=C2=A0=C2=A0=C2=A0 PSCI: Suspend is unavailable
> INFO:=C2=A0=C2=A0=C2=A0 BL31: Preparing for EL3 exit to normal world
> INFO:=C2=A0=C2=A0=C2=A0 Entry point address =3D 0x4a000000
> INFO:=C2=A0=C2=A0=C2=A0 SPSR =3D 0x3c9
> INFO:=C2=A0=C2=A0=C2=A0 Changed devicetree.
>=20
>=20
> U-Boot 2024.01-rc3-00009-g9e53e45292-dirty (Nov 23 2023 - 18:56:18=20
> +0000) Allwinner Technology
>=20
> CPU:=C2=A0=C2=A0 Allwinner H616 (SUN50I)
> Model: OrangePi Zero3
> DRAM:=C2=A0 1 GiB
> Core:=C2=A0 57 devices, 25 uclasses, devicetree: separate
> WDT:=C2=A0=C2=A0 Not starting watchdog@30090a0
> MMC:=C2=A0=C2=A0 mmc@4020000: 0
> Loading Environment from FAT... Unable to use mmc 0:1...
> In:=C2=A0=C2=A0=C2=A0 serial@5000000
> Out:=C2=A0=C2=A0 serial@5000000
> Err:=C2=A0=C2=A0 serial@5000000
> Allwinner mUSB OTG (Peripheral)
> Net:=C2=A0=C2=A0 eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1=
in STATUS=20
> ep2in
> MAC de:ad:be:ef:00:01
> HOST MAC de:ad:be:ef:00:00
> RNDIS ready
> , eth1: usb_ether
> starting USB...
> Bus usb@5200000: USB EHCI 1.00
> Bus usb@5200400: USB OHCI 1.0
> scanning bus usb@5200000 for devices... 1 USB Device(s) found
> scanning bus usb@5200400 for devices... 1 USB Device(s) found
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scanning usb for storage devices...=
 0 Storage Device(s) found
> Hit any key to stop autoboot:=C2=A0 0
> switch to partitions #0, OK
> mmc0 is current device
>=20
> Device 0: unknown device
> BOOTP broadcast 1
> DHCP client bound to address 192.168.1.63 (5 ms)
> *** Warning: no boot file name; using 'C0A8013F.img'
> Using ethernet@5020000 device
> TFTP from server 192.168.1.253; our IP address is 192.168.1.63
> Filename 'C0A8013F.img'.
> Load address: 0x42000000
> Loading: T T T
>=20
> defconfig used:
>=20
> CONFIG_ARM=3Dy
> CONFIG_ARCH_SUNXI=3Dy
> CONFIG_DEFAULT_DEVICE_TREE=3D"sun50i-h618-orangepi-zero3"
> CONFIG_SPL=3Dy
> CONFIG_DRAM_SUN50I_H616_DX_ODT=3D0x07070707
> CONFIG_DRAM_SUN50I_H616_DX_DRI=3D0x0e0e0e0e
> CONFIG_DRAM_SUN50I_H616_CA_DRI=3D0x0e0e
> CONFIG_DRAM_SUN50I_H616_ODT_EN=3D0xaaaaeeee
> CONFIG_DRAM_SUN50I_H616_TPR0=3D0x0
> CONFIG_DRAM_SUN50I_H616_TPR6=3D0x44000000
> CONFIG_DRAM_SUN50I_H616_TPR10=3D0x402f0663
> CONFIG_DRAM_SUN50I_H616_TPR11=3D0x24242323
> CONFIG_DRAM_SUN50I_H616_TPR12=3D0x0e0e0e0e
> CONFIG_MACH_SUN50I_H616=3Dy
> CONFIG_SUNXI_DRAM_H616_LPDDR4=3Dy
> CONFIG_DRAM_CLK=3D792
> CONFIG_R_I2C_ENABLE=3Dy
> CONFIG_SPL_SPI_SUNXI=3Dy
> # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> CONFIG_SPL_I2C=3Dy
> CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> CONFIG_SYS_I2C_MVTWSI=3Dy
> CONFIG_SYS_I2C_SLAVE=3D0x7f
> CONFIG_SYS_I2C_SPEED=3D400000
> CONFIG_SPI_FLASH_MACRONIX=3Dy
> CONFIG_PHY_MOTORCOMM=3Dy
> CONFIG_SUN8I_EMAC=3Dy
> CONFIG_SPI=3Dy
> CONFIG_USB_EHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_MUSB_GADGET=3Dy
> CONFIG_AXP313_POWER=3Dy
> CONFIG_AXP_DCDC3_VOLT=3D1100
> CONFIG_CMD_BOOTZ=3Dy
>=20
>=20
> On 2023-11-23 6:15 a.m., Andre Przywara wrote:
> > On Tue, 21 Nov 2023 21:52:12 -0800
> > Stephen Graf <s_graf@telus.net> wrote:
> >
> > Hi Stephen,
> > =20
> >> I have been able to build a working (on my orangepi zero3 1G) u-boot f=
or
> >> the orangepi zero3 with the following defconfig. Would it be possible =
to =20
> > thanks for your interest in contributing and for reaching out!
> > As Peter already mentioned, you would need to send a patch, as generated
> > by "git format-patch". "git send-email" would help you with sending this
> > out.
> >
> > But actually I sent a small series already last week:
> > https://lore.kernel.org/u-boot/20231114013106.31336-1-andre.przywara@ar=
m.com/
> >
> > If you could apply these patches and test it on your board, I'd be
> > grateful. If it works for you and you are happy, please reply to patch =
3/3
> > and add a "Tested-by: Your Name <your@email.com>" line.
> > For instructions how to reply, check "Reply instructions" at the end of
> > that mailing list archive web page above.
> >
> > I was just waiting for confirmations by other people before merging it.
> >
> > Cheers,
> > Andre
> >
> > =20
> >> add this config to the working boards.=C2=A0 I would test it again wit=
h an
> >> official build. The dtb/dts is in linux and in u-boot.
> >>
> >> The H618 processor is software compatible with the H616 and the zero3
> >> board is very similar to the zero2 with the exception of DDR3 replaced
> >> with LPDDR4 and the Realtek phy with Motorcomm.
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
> >> =20

