Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C54CDB483
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 11:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41EA786DF7;
	Thu, 12 Oct 2023 13:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="UdMTll3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7898186DF7; Thu, 12 Oct 2023 13:46:49 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 596B686287
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 13:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
Received: from [IPv6:2a00:23c8:b70a:ae01:ba8c:b93a:20b1:6864] (unknown
 [IPv6:2a00:23c8:b70a:ae01:ba8c:b93a:20b1:6864])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: obbardc)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 87DD56607342;
 Thu, 12 Oct 2023 12:46:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1697111188;
 bh=+NgPhs7Ka5DBC/y1AGPeVHm4k9gF+pw8uvqqIAV5ibs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=UdMTll3rzeJU4/B9pLOYgOhO4SuGWpkWZr+6vpCuzpsqQClEGvukNCCanSqzIt5i1
 PP6wJKG/QHEU4MKIlic2S6fVPAfJZN31UwtKSIxKlOXDe7HJgR5TzCSOsb/43sue9i
 NZCu1wjUzCqkkHtKI3VzuiIQPFbK0zNoFTc8aPJJsAxN8wPZoeRJPba15NV3CibwVH
 dLl9ejYQo/xh3EhTATAPpUSplZIv4Y16BUX14T+NKREPSNalt2tHk8257VTgWIic5x
 tgtLxkrOCFXufzIvWbHcdWsABHtYKtCIaVBCeW99C+07wMVlCaNGo/bqM1uxzJnD0H
 d3dRR3E4XFIQA==
Message-ID: <36a3377463cc2a167534574a096cb5097ea7c242.camel@collabora.com>
Subject: Re: [PATCH 1/5] board: rockchip: Add Pine64 Quartz64-A Board
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
Date: Thu, 12 Oct 2023 12:46:25 +0100
In-Reply-To: <bf74c779670c2dc249278b5a52620d7fcebafe98.camel@collabora.com>
References: <20230723145504.2967971-1-jonas@kwiboo.se>
 <20230723145504.2967971-2-jonas@kwiboo.se>
 <1e3634df-593c-506d-5254-332c44ca7c4d@kwiboo.se>
 <9ba7a208113eed26c61d3373f1659b866c1f8c85.camel@collabora.com>
 <c6acb79a-aa4c-f6e0-648e-7890e75ff714@kwiboo.se>
 <bf74c779670c2dc249278b5a52620d7fcebafe98.camel@collabora.com>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
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

Hi Jonas,

On Thu, 2023-10-12 at 10:51 +0100, Christopher Obbard wrote:
> Hi Jonas,
>=20
> Sorry for the late response, I've been meaning to test this for a while b=
ut not got around to it.
>=20
> On Thu, 2023-08-17 at 23:56 +0000, Jonas Karlman wrote:
> > Hi Christopher,
> >=20
> > On 2023-08-08 16:25, Christopher Obbard wrote:
> > > Hi Jonas,
> > >=20
> > > On Sun, 2023-07-23 at 15:04 +0000, Jonas Karlman wrote:
> > > > On 2023-07-23 16:55, Jonas Karlman wrote:
> > > > > The Pine64 Quartz64 Model A is a single-board computer based on t=
he
> > > > > Rockchip RK3566 SoC. The board features USB3, SATA, PCIe, HDMI, U=
SB2.0,
> > > > > CSI, DSI, eDP, eMMC, SD, and an e-paper parallel port, as well as=
 a
> > > > > 20 pin GPIO header.
> > > > >=20
> > > > > Features tested on a Quartz64-A 8GB v2.0 2021-04-27:
> > > > > - SD-card boot
> > > > > - eMMC boot
> > > > > - PCIe/NVMe/AHCI
> > > > > - USB host
> > > > >=20
> > > > > Device tree is imported from linux v6.4.
> > > > >=20
> > > > > Co-developed-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com=
>
> > > > > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > > > ---
> > > >=20
> > > > [...]
> > > >=20
> > > > Boot log with ROCKCHIP_TPL=3Drk3566_ddr_1056MHz_v1.17.bin and
> > > > BL31=3Drk3568_bl31_v1.43.elf:
> > > >=20
> > > > [...]
> > > >=20
> > > > U-Boot 2023.07 (Jul 23 2023 - 12:42:18 +0000)
> > > >=20
> > > > Model: Pine64 RK3566 Quartz64-A Board
> > > > DRAM:=C2=A0 8 GiB (effective 7.7 GiB)
> > > > PMIC:=C2=A0 RK8170 (on=3D0x10, off=3D0x00)
> > > > Core:=C2=A0 321 devices, 27 uclasses, devicetree: separate
> > > > MMC:=C2=A0=C2=A0 rockchip_sdhci_probe clk set rate fail!
> > > > mmc@fe2b0000: 1, mmc@fe2c0000: 2, mmc@fe310000: 0
> > > > Loading Environment from nowhere... OK
> > > > In:=C2=A0=C2=A0=C2=A0 serial@fe660000
> > > > Out:=C2=A0=C2=A0 serial@fe660000
> > > > Err:=C2=A0=C2=A0 serial@fe660000
> > > > Model: Pine64 RK3566 Quartz64-A Board
> > > > Net:=C2=A0=C2=A0 No ethernet found.
> > > >=20
> > > > Hit any key to stop autoboot:=C2=A0 0
> > > > =3D>
> > >=20
> > >=20
> > > I just tried booting U-Boot v2023.10-rc2 with ROCKCHIP_TPL=3Drk3566_d=
dr_1056MHz_v1.17.bin and BL31=3Drk3568_bl31_v1.43.elf, on my Quartz64-A but=
 it fails during
> > > loading of some parts. I removed the output of the RK TPL from my log=
s as there were no errors.
> >=20
> > Try with latest rk3566_ddr_1056MHz_v1.18.bin and see if that makes any
> > difference.
>=20
> No difference.
>=20
> I've also checked, there is no other maskrom bootable media such as SPI f=
lash connected to the board.
>=20
> >=20
> > > This is when booting from eMMC.
> >=20
> > Does it boot with SD-card or other eMMC modules?
>=20
> Booting from SD card (without eMMC connected), everything works fine.
>=20
> >=20
>=20
> > > I also tried building your branch from https://github.com/Kwiboo/u-bo=
ot-rockchip/tree/rk3568-2023.10=C2=A0and=20
> >=20
> > Please try with a GitHub actions built u-boot-rockchip.bin based on my
> > rk3568-2023.07.02 branch at
> > https://github.com/Kwiboo/u-boot-build/actions/runs/5777761235
>=20
> With that exact artifact, flashed with:
>=20
> > rkdeveloptool db rk356x_spl_loader_v1.18.113.bin
> > rkdeveloptool ef
> > rkdeveloptool wl 64 u-boot-rockchip.bin
> > rkdeveloptool rd
>=20
> it fails to boot with with:
>=20
> > DDR V1.18 f366f69a7d typ 23/07/17-15:48:58
> > ln
> > LP4/4x derate en, other dram:1x trefi
> > SRX
> > ddrconfig:7
> > LPDDR4X, 324MHz
> > BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D17 CS1 Row=3D17 CS=3D2 Die BW=3D8 Siz=
e=3D8192MB
> >=20
> > change to: 324MHz
> > clk skew:0x60
> >=20
> > change to: 528MHz
> > clk skew:0x58
> >=20
> > change to: 780MHz
> > clk skew:0x58
> >=20
> > change to: 1056MHz(final freq)
> > clk skew:0x32
> > out
> >=20
> > U-Boot SPL 2023.07.02-g09919887 (Aug 06 2023 - 16:59:31 +0000)
> > Trying to boot from MMC1
> > spl: mmc init failed with error: -70
> > Trying to boot from MMC2
> > Card did not respond to voltage select! : -110
> > spl: mmc init failed with error: -95
> > Trying to boot from MMC1
> > mmc fail to send stop cmd
> > mmc_load_image_raw_sector: mmc block read error
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
>=20
> I also tried a second eMMC, but it also failed to boot with the same "mmc=
 block read error" message.


I tried with your latest branch https://github.com/Kwiboo/u-boot-rockchip/c=
ommits/rk3568-2023.10

and this time a different error message, loading from the eMMC appears to g=
et a bit further:

> U-Boot SPL 2023.10-00054-gef68159087 (Oct 12 2023 - 12:14:22 +0100)
> Trying to boot from MMC1
> ## Checking hash(es) for config config-1 ... OK
> ## Checking hash(es) for Image atf-1 ... sha256+ OK
> spl_load_simple_fit: can't load image loadables index 0 (ret =3D -5)
> mmc_load_image_raw_sector: mmc block read error
> Trying to boot from MMC2
> Card did not respond to voltage select! : -110
> spl: mmc init failed with error: -95
> Trying to boot from MMC1
> mmc_load_image_raw_sector: mmc block read error
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###

So this is pointing to an issue reading from the MMC...

I found https://lists.denx.de/pipermail/u-boot/2023-April/514315.html (whic=
h is applied to your branch) and added the following to defconfig:

CONFIG_MMC_SDHCI_SDMA=3Dy
+# CONFIG_SPL_MMC_SDHCI_SDMA is not set

but this seemed to make the loading less reliable:

> U-Boot SPL 2023.10-00054-gef68159087-dirty (Oct 12 2023 - 12:23:10 +0100)
> Trying to boot from MMC1
> ## Checking hash(es) for config config-1 ... OK
> mmc fail to send stop cmd
> mmc_load_image_raw_sector: mmc block read error
> Trying to boot from MMC2
> Card did not respond to voltage select! : -110
> spl: mmc init failed with error: -95
> Trying to boot from MMC1
> mmc_load_image_raw_sector: mmc block read error
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###


...

> >=20
> > What happens if you write u-boot-rockchip.bin to eMMC module usinga USB=
 adapter:
> >=20
> > =C2=A0 dd if=3Du-boot-rockchip.bin of=3D/dev/<device> bs=3D32k seek=3D1=
 conv=3Dfsync
> >=20
> > or using U-Boot cmd when booted from a SD-card?
> >=20
> > =C2=A0 # Read u-boot-rockchip.bin from first partition of a SD card
> > =C2=A0 load mmc 1:1 10000000 u-boot-rockchip.bin
> >=20
> > =C2=A0 # Change to eMMC
> > =C2=A0 mmc dev 0
> >=20
> > =C2=A0 # Write 10 MiB (0x5000 blocks) at sector 64 (0x40)
> > =C2=A0 mmc write $fileaddr 40 5000
> >=20
> > Does that make any difference?
>=20
> I don't think I have an eMMC writer for Pine64 eMMCs, I will try to get h=
old of one this week.

I have two USB writers. Anyway, the first boot, it fails with:

> U-Boot SPL 2023.10-00054-gef68159087 (Oct 12 2023 - 12:30:14 +0100)
> Trying to boot from MMC1
> ## Checking hash(es) for config config-1 ... OK
> ## Checking hash(es) for Image atf-1 ... sha256+ OK
> ## Checking hash(es) for Image u-boot ... sha256+ OK
> <hang>


Then again after a reset:

> U-Boot SPL 2023.10-00054-gef68159087 (Oct 12 2023 - 12:30:14 +0100)
> Trying to boot from MMC1
> mmc fail to send stop cmd
> mmc_load_image_raw_sector: mmc block read error
> Trying to boot from MMC2
> Card did not respond to voltage select! : -110
> spl: mmc init failed with error: -95
> Trying to boot from MMC1
> mmc_load_image_raw_sector: mmc block read error
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###




> But it fails to write to the eMMC with:
>=20
> > =3D> load mmc 1:2 10000000 u-boot-rockchip.bin
> > 9510400 bytes read in 791 ms (11.5 MiB/s)
> >=20
> > =3D> mmc dev 0
> > switch to partitions #0, OK
> > mmc0(part 0) is current device
> >=20
> >=20
> > =3D> mmc write $fileaddr 40 5000
> > MMC write: dev # 0, block # 64, count 20480 ... mmc write failed
> > 0 blocks written: ERROR
> >=20
> > =3D> mmc info
> > Device: mmc@fe310000
> > Manufacturer ID: 45
> > OEM: 0
> > Name: DF4016=20
> > Bus Speed: 52000000
> > Mode: MMC DDR52 (52MHz)
> > Rd Block Len: 512
> > MMC version 5.1
> > High Capacity: Yes
> > Capacity: 14.7 GiB
> > Bus Width: 8-bit DDR
> > Erase Group Size: 512 KiB
> > HC WP Group Size: 8 MiB
> > User Capacity: 14.7 GiB WRREL
> > Boot Capacity: 4 MiB ENH
> > RPMB Capacity: 4 MiB ENH
>=20
> I think this points to some issue with the mmc driver in U-Boot, or possi=
bly some issue with my board. But I find that hard to believe because the R=
ockchip usbloader seems to write to the eMMC just
> fine ?
>=20
> >=20
> > >=20
> > > Boot log (v2023.10-rc2):
> > >=20
> > > U-Boot SPL 2023.10-rc2 (Aug 08 2023 - 14:02:34 +0100)
> > > rockchip_sdhci_probe clk set rate fail!
> > > Trying to boot from MMC1
> > > spl: mmc init failed with error: -110
> > > Trying to boot from MMC2
> > > Card did not respond to voltage select! : -110
> > > spl: mmc init failed with error: -95
> > > Trying to boot from MMC1
> >=20
> > Strange that second try of eMMC (MMC1) gets little bit longer.
> >=20
> > > ## Checking hash(es) for config config-1 ... OK
> > > ## Checking hash(es) for Image atf-1 ... sha256+ OK
> > > spl_load_simple_fit: can't load image loadables index 0 (ret =3D -5)
> > > mmc_load_image_raw_sector: mmc block read error
> > > SPL: failed to boot from all boot devices
> > > ### ERROR ### Please RESET the board ###
> > >=20
> > >=20
> > > Boot log (your branch):
> > >=20
> > > U-Boot SPL 2023.10-rc1-00368-g16cb31d427 (Aug 08 2023 - 15:17:35 +010=
0)
> > > Trying to boot from MMC1
> > > spl: mmc init failed with error: -70
> > > Trying to boot from MMC2
> > > Card did not respond to voltage select! : -110
> > > spl: mmc init failed with error: -95
> > > Trying to boot from MMC1
> > > ## Checking hash(es) for config config-1 ... OK
> > > mmc_load_image_raw_sector: mmc block read error
> > > SPL: failed to boot from all boot devices
> > > ### ERROR ### Please RESET the board ###
> >=20
> > I have not been able to reproduce this kind of issue on any of my two
> > Quartz64-A boards, tested with different eMMC modules.
> >=20
> > Does your eMMC module have some compatibility issue?
> > Do you have any more details on the eMMC module you have tested with?
>=20
> I have two eMMCs, one from FORESEE which came with a Pine64 and one marke=
d SanDisk (which I posted the mmc info for above).
>=20
> My hardware is marked Quartz64-RK3399-V2.0 2021-04-27
> Maybe there is some difference with your board?
>=20
> I will also try an image with vendor u-boot as a next step.

I tried latest Armbian (which seems to use ) from https://github.com/armbia=
n/build/releases/ and flashed the eMMC with the USB writer. It ended up boo=
ting to Linux, which proves that the hardware I
have is most likey in a good working order ;-)!


> U-Boot SPL 2022.10-rc4-armbian (Feb 11 2023 - 22:25:16 +0000)
> saradc@fe720000: Can't update Vdd. Error: -38saradc@fe720000: Can't updat=
e Vss. Error: -38can't get vref-supply: -38
> rockchip_dnl_key_pressed: adc_channel_single_shot fail!
> Trying to boot from MMC2
> INFO:    Preloader serial: 2
> NOTICE:  BL31: v2.3():v2.3-152-g4e725b15f:cl
> NOTICE:  BL31: Built : 10:51:13, Jul 15 2021
> INFO:    GICv3 without legacy support detected.
> INFO:    ARM GICv3 driver initialized in EL3
> INFO:    pmu v1 is valid
> INFO:    dfs DDR fsp_param[0].freq_mhz=3D 1560MHz
> INFO:    dfs DDR fsp_param[1].freq_mhz=3D 324MHz
> INFO:    dfs DDR fsp_param[2].freq_mhz=3D 528MHz
> INFO:    dfs DDR fsp_param[3].freq_mhz=3D 780MHz
> INFO:    Using opteed sec cpu_context!
> INFO:    boot cpu mask: 0
> INFO:    BL31: Initializing runtime services
> WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPT=
EE initialization. SMC`s destined for OPTEE will return SMC_UNK
> ERROR:   Error initializing runtime service opteed_fast
> INFO:    BL31: Preparing for EL3 exit to normal world
> INFO:    Entry point address =3D 0xa00000
> INFO:    SPSR =3D 0x3c9
>=20
>=20
> U-Boot 2022.10-rc4-armbian (Feb 11 2023 - 22:25:16 +0000)
>=20
> Model: Pine64 RK3566 Quartz64-A Board
> DRAM:  2 GiB
> PMIC:  RK8170 (on=3D0x10, off=3D0x00)
> Core:  266 devices, 21 uclasses, devicetree: separate
> MMC:   mmc@fe2b0000: 1, mmc@fe310000: 0
> Loading Environment from nowhere... OK
> In:    serial@fe660000
> Out:   serial@fe660000
> Err:   serial@fe660000
> Model: Pine64 RK3566 Quartz64-A Board
> can't get vref-supply: -2
> rockchip_dnl_key_pressed: adc_channel_single_shot fail!
> Net:   No ethernet found.
> Hit any key to stop autoboot:  0=20
> starting USB...
> Bus usb@fcc00000: Port not available.
> Bus usb@fd000000: Port not available.
> Bus usb@fd800000: USB EHCI 1.00
> Bus usb@fd840000: USB OHCI 1.0
> Bus usb@fd880000: USB EHCI 1.00
> Bus usb@fd8c0000: USB OHCI 1.0
> scanning bus usb@fd800000 for devices... 1 USB Device(s) found
> scanning bus usb@fd840000 for devices... ERROR:  USB-error: DEVICENOTRESP=
ONDING: Device did not respond to token (IN) or did
> not provide a handshake (OUT) (5)
> ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token (I=
N) or did
> not provide a handshake (OUT) (5)
> unable to get device descriptor (error=3D-1)
> 1 USB Device(s) found
> scanning bus usb@fd880000 for devices... 1 USB Device(s) found
> scanning bus usb@fd8c0000 for devices... 1 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
>=20
> Device 0: unknown device
> Card did not respond to voltage select! : -110
> switch to partitions #0, OK
> mmc0(part 0) is current device
> Scanning mmc 0:1...
> Found /boot/extlinux/extlinux.conf
> Retrieving file: /boot/extlinux/extlinux.conf
> 1:	Armbian
> Retrieving file: /boot/uInitrd
> Retrieving file: /boot/Image
> append: root=3DUUID=3D7f9c9970-93ba-46ca-9f03-f3241712ead8 console=3DttyS=
02,1500000 console=3Dtty0 rw no_console_suspend consoleblank=3D0 fsck.fix=
=3Dyes fsck.repair=3Dyes net.ifnames=3D0 splash plymouth.ignore-
> serial-consoles
> Retrieving file: /boot/dtb/rockchip/rk3566-quartz64-a.dtb
> Moving Image from 0x2080000 to 0x2200000, end=3D3de0000
> ## Loading init Ramdisk from Legacy Image at 0a200000 ...
>    Image Name:   uInitrd
>    Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
>    Data Size:    34402446 Bytes =3D 32.8 MiB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 0a100000
>    Booting using the fdt blob at 0xa100000
>    Loading Ramdisk to 7be16000, end 7dee508e ... OK
>    Loading Device Tree to 000000007bdf7000, end 000000007be158e2 ... OK
>=20
> Starting kernel ...
>=20
> efi_free_pool: illegal free 0x000000007cee7040
> efi_free_pool: illegal free 0x000000007cee4040
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x412fd050]
> [    0.000000] Linux version 6.2.0-rc6-media (root@d00a59921686) (aarch64=
-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 8.3-2019.03 (a=
rm-rel-8.36)) 8.3.0, GNU ld (GNU Toolchain for the
> A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 2.32.0.20190321) #trun=
k.0252 SMP PREEMPT_DYNAMIC Sat Feb 11 22:41:21 UTC 2023
> [    0.000000] Machine model: Pine64 RK3566 Quartz64-A Board
>=20




Thanks!

Chris
