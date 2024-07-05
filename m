Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B54C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 14:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D76882E2;
	Fri,  5 Jul 2024 16:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SNti93fO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADAA887EA; Fri,  5 Jul 2024 16:48:33 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4DA882B6
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 16:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1720190910;
 bh=dOfoX83z6NZcwthmgpDNuSrPprdSgvJyFuVtOgzNt1g=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=SNti93fO9nNiVPvLVzoF7Ilr8dzzJylkQmZQ8qWzh/1cf3bLzXDKfkSzzvgO8LpvH
 KdCN0Ig/Nz+XA8uAAYJfkx/YhFdIAM80S6IRa4JKuOW/DcgCltEyxsZye5P2r7Yfz5
 OY0FY183dh94zUNibPtYiDInCQf2BG5ZDvLxzb4466OoKgddIDTRDOQ8oba6NYNEyT
 0kpqtRvfcuVBd9RWNBEOSm+OZ7BKjsFEiaWlfplb3Pkj9qhQd2af/jdIF7RK++xesY
 +B7YUcd1zkn4JKhWLA7sQogSczZhfrLKC/MJpAezt5UycuJTubKwSDN/73URYY7kwh
 NKRWbhDqdKGtg==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id BCFE93782190;
 Fri,  5 Jul 2024 14:48:29 +0000 (UTC)
Message-ID: <1ac94ef8c4a00738cda6b1464d93223a6b08249b.camel@collabora.com>
Subject: Re: [PATCH 1/5] board: rockchip: Add Pine64 Quartz64-A Board
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Peter Geis <pgwipeout@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>
Date: Fri, 05 Jul 2024 15:48:29 +0100
In-Reply-To: <261d3994b44dc01ed68ea2ed7856caef635c9809.camel@collabora.com>
References: <20230723145504.2967971-1-jonas@kwiboo.se>
 <20230723145504.2967971-2-jonas@kwiboo.se>
 <1e3634df-593c-506d-5254-332c44ca7c4d@kwiboo.se>
 <9ba7a208113eed26c61d3373f1659b866c1f8c85.camel@collabora.com>
 <c6acb79a-aa4c-f6e0-648e-7890e75ff714@kwiboo.se>
 <bf74c779670c2dc249278b5a52620d7fcebafe98.camel@collabora.com>
 <36a3377463cc2a167534574a096cb5097ea7c242.camel@collabora.com>
 <3b496548-04be-a2b2-5b98-6925b96933f0@kwiboo.se>
 <0b4315a9-849a-1b50-d622-1a47be602e3f@kwiboo.se>
 <261d3994b44dc01ed68ea2ed7856caef635c9809.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-1 
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

On Tue, 2023-10-17 at 10:02 +0100, Christopher Obbard wrote:
> Hi Jonas,
>=20
> On Sat, 2023-10-14 at 21:22 +0200, Jonas Karlman wrote:
> > On 2023-10-14 20:58, Jonas Karlman wrote:
> > > Hi Christopher,
> > >=20
> > > On 2023-10-12 13:46, Christopher Obbard wrote:
> > > > Hi Jonas,
> > > >=20
> > > > On Thu, 2023-10-12 at 10:51 +0100, Christopher Obbard wrote:
> > > > > Hi Jonas,
> > > > >=20
> > > > > Sorry for the late response, I've been meaning to test this for a
> > > > > while but not got around to it.
> > > > >=20
> > > > > On Thu, 2023-08-17 at 23:56 +0000, Jonas Karlman wrote:
> > > > > > Hi Christopher,
> > > > > >=20
> > > > > > On 2023-08-08 16:25, Christopher Obbard wrote:
> > > > > > > Hi Jonas,
> > > > > > >=20
> > > > > > > On Sun, 2023-07-23 at 15:04 +0000, Jonas Karlman wrote:
> > > > > > > > On 2023-07-23 16:55, Jonas Karlman wrote:
> > > > > > > > > The Pine64 Quartz64 Model A is a single-board computer ba=
sed
> > > > > > > > > on the
> > > > > > > > > Rockchip RK3566 SoC. The board features USB3, SATA, PCIe,
> > > > > > > > > HDMI, USB2.0,
> > > > > > > > > CSI, DSI, eDP, eMMC, SD, and an e-paper parallel port, as
> > > > > > > > > well as a
> > > > > > > > > 20 pin GPIO header.
> > > > > > > > >=20
> > > > > > > > > Features tested on a Quartz64-A 8GB v2.0 2021-04-27:
> > > > > > > > > - SD-card boot
> > > > > > > > > - eMMC boot
> > > > > > > > > - PCIe/NVMe/AHCI
> > > > > > > > > - USB host
> > > > > > > > >=20
> > > > > > > > > Device tree is imported from linux v6.4.
> > > > > > > > >=20
> > > > > > > > > Co-developed-by: Nicolas Frattaroli
> > > > > > > > > <frattaroli.nicolas@gmail.com>
> > > > > > > > > Signed-off-by: Nicolas Frattaroli
> > > > > > > > > <frattaroli.nicolas@gmail.com>
> > > > > > > > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > > > > > > > ---
> > > > > > > >=20
> > > > > > > > [...]
> > > > > > > >=20
> > > > > > > > Boot log with ROCKCHIP_TPL=3Drk3566_ddr_1056MHz_v1.17.bin a=
nd
> > > > > > > > BL31=3Drk3568_bl31_v1.43.elf:
> > > > > > > >=20
> > > > > > > > [...]
> > > > > > > >=20
> > > > > > > > U-Boot 2023.07 (Jul 23 2023 - 12:42:18 +0000)
> > > > > > > >=20
> > > > > > > > Model: Pine64 RK3566 Quartz64-A Board
> > > > > > > > DRAM:=C2=A0 8 GiB (effective 7.7 GiB)
> > > > > > > > PMIC:=C2=A0 RK8170 (on=3D0x10, off=3D0x00)
> > > > > > > > Core:=C2=A0 321 devices, 27 uclasses, devicetree: separate
> > > > > > > > MMC:=C2=A0=C2=A0 rockchip_sdhci_probe clk set rate fail!
> > > > > > > > mmc@fe2b0000: 1, mmc@fe2c0000: 2, mmc@fe310000: 0
> > > > > > > > Loading Environment from nowhere... OK
> > > > > > > > In:=C2=A0=C2=A0=C2=A0 serial@fe660000
> > > > > > > > Out:=C2=A0=C2=A0 serial@fe660000
> > > > > > > > Err:=C2=A0=C2=A0 serial@fe660000
> > > > > > > > Model: Pine64 RK3566 Quartz64-A Board
> > > > > > > > Net:=C2=A0=C2=A0 No ethernet found.
> > > > > > > >=20
> > > > > > > > Hit any key to stop autoboot:=C2=A0 0
> > > > > > > > =3D>
> > > > > > >=20
> > > > > > >=20
> > > > > > > I just tried booting U-Boot v2023.10-rc2 with
> > > > > > > ROCKCHIP_TPL=3Drk3566_ddr_1056MHz_v1.17.bin and
> > > > > > > BL31=3Drk3568_bl31_v1.43.elf, on my Quartz64-A but it fails d=
uring
> > > > > > > loading of some parts. I removed the output of the RK TPL fro=
m
> > > > > > > my logs as there were no errors.
> > > > > >=20
> > > > > > Try with latest rk3566_ddr_1056MHz_v1.18.bin and see if that ma=
kes
> > > > > > any
> > > > > > difference.
> > > > >=20
> > > > > No difference.
> > > > >=20
> > > > > I've also checked, there is no other maskrom bootable media such =
as
> > > > > SPI flash connected to the board.
> > > > >=20
> > > > > >=20
> > > > > > > This is when booting from eMMC.
> > > > > >=20
> > > > > > Does it boot with SD-card or other eMMC modules?
> > > > >=20
> > > > > Booting from SD card (without eMMC connected), everything works
> > > > > fine.
> > > > >=20
> > > > > >=20
> > > > >=20
> > > > > > > I also tried building your branch from
> > > > > > > https://github.com/Kwiboo/u-boot-rockchip/tree/rk3568-2023.10=
=C2=A0
> > > > > >=20
> > > > > > Please try with a GitHub actions built u-boot-rockchip.bin base=
d
> > > > > > on my
> > > > > > rk3568-2023.07.02 branch at
> > > > > > https://github.com/Kwiboo/u-boot-build/actions/runs/5777761235
> > > > >=20
> > > > > With that exact artifact, flashed with:
> > > > >=20
> > > > > > rkdeveloptool db rk356x_spl_loader_v1.18.113.bin
> > > > > > rkdeveloptool ef
> > > > > > rkdeveloptool wl 64 u-boot-rockchip.bin
> > > > > > rkdeveloptool rd
> > > > >=20
> > > > > it fails to boot with with:
> > > > >=20
> > > > > > DDR V1.18 f366f69a7d typ 23/07/17-15:48:58
> > > > > > ln
> > > > > > LP4/4x derate en, other dram:1x trefi
> > > > > > SRX
> > > > > > ddrconfig:7
> > > > > > LPDDR4X, 324MHz
> > > > > > BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D17 CS1 Row=3D17 CS=3D2 Die BW=
=3D8 Size=3D8192MB
> > > > > >=20
> > > > > > change to: 324MHz
> > > > > > clk skew:0x60
> > > > > >=20
> > > > > > change to: 528MHz
> > > > > > clk skew:0x58
> > > > > >=20
> > > > > > change to: 780MHz
> > > > > > clk skew:0x58
> > > > > >=20
> > > > > > change to: 1056MHz(final freq)
> > > > > > clk skew:0x32
> > > > > > out
> > > > > >=20
> > > > > > U-Boot SPL 2023.07.02-g09919887 (Aug 06 2023 - 16:59:31 +0000)
> > > > > > Trying to boot from MMC1
> > > > > > spl: mmc init failed with error: -70
> > > > > > Trying to boot from MMC2
> > > > > > Card did not respond to voltage select! : -110
> > > > > > spl: mmc init failed with error: -95
> > > > > > Trying to boot from MMC1
> > > > > > mmc fail to send stop cmd
> > > > > > mmc_load_image_raw_sector: mmc block read error
> > > > > > SPL: failed to boot from all boot devices
> > > > > > ### ERROR ### Please RESET the board ###
> > > > >=20
> > > > > I also tried a second eMMC, but it also failed to boot with the s=
ame
> > > > > "mmc block read error" message.
> > > >=20
> > > >=20
> > > > I tried with your latest branch
> > > > https://github.com/Kwiboo/u-boot-rockchip/commits/rk3568-2023.10
> > > >=20
> > > > and this time a different error message, loading from the eMMC appe=
ars
> > > > to get a bit further:
> > > >=20
> > > > > U-Boot SPL 2023.10-00054-gef68159087 (Oct 12 2023 - 12:14:22 +010=
0)
> > > > > Trying to boot from MMC1
> > > > > ## Checking hash(es) for config config-1 ... OK
> > > > > ## Checking hash(es) for Image atf-1 ... sha256+ OK
> > > > > spl_load_simple_fit: can't load image loadables index 0 (ret =3D =
-5)
> > > > > mmc_load_image_raw_sector: mmc block read error
> > > > > Trying to boot from MMC2
> > > > > Card did not respond to voltage select! : -110
> > > > > spl: mmc init failed with error: -95
> > > > > Trying to boot from MMC1
> > > > > mmc_load_image_raw_sector: mmc block read error
> > > > > SPL: failed to boot from all boot devices
> > > > > ### ERROR ### Please RESET the board ###
> > > >=20
> > > > So this is pointing to an issue reading from the MMC...
> > > >=20
> > > > I found
> > > > https://lists.denx.de/pipermail/u-boot/2023-April/514315.html=C2=A0=
(which
> > > > is applied to your branch) and added the following to defconfig:
> > > >=20
> > > > CONFIG_MMC_SDHCI_SDMA=3Dy
> > > > +# CONFIG_SPL_MMC_SDHCI_SDMA is not set
> > > >=20
> > > > but this seemed to make the loading less reliable:
> > > >=20
> > > > > U-Boot SPL 2023.10-00054-gef68159087-dirty (Oct 12 2023 - 12:23:1=
0
> > > > > +0100)
> > > > > Trying to boot from MMC1
> > > > > ## Checking hash(es) for config config-1 ... OK
> > > > > mmc fail to send stop cmd
> > > > > mmc_load_image_raw_sector: mmc block read error
> > > > > Trying to boot from MMC2
> > > > > Card did not respond to voltage select! : -110
> > > > > spl: mmc init failed with error: -95
> > > > > Trying to boot from MMC1
> > > > > mmc_load_image_raw_sector: mmc block read error
> > > > > SPL: failed to boot from all boot devices
> > > > > ### ERROR ### Please RESET the board ###
> > > >=20
> > > >=20
> > >=20
> > > Thanks for testing different combinations.
> > >=20
> > > I did find an issue with emmc write using ddr52 and hs400 modes on
> > > rk3568. On rk3588 emmc write only worked reliable after hs200 mode ha=
d
> > > been used.
> > >=20
> > > Please try the changes from following commit, or my rk35xx-2024.01
> > > work-in-progress branch:
> > >=20
> > > WIP: rockchip: rk35xx: improve emmc write
> > > https://github.com/Kwiboo/u-boot-rockchip/commit/aa6156179bb2034e8ba2=
6753e05285e276327d78
> > >=20
> > > Most rk356x boards currently default to ddr52 mode, and possible emmc
> > > read is also affected with similar issue as emmc write.
> > >=20
> > > I have also discovered a strange issue on an Amlogic soc related to
> > > U-Boot mmc commands and gcc optimization, please see following patch:
> > > https://patchwork.ozlabs.org/patch/1839392/
> >=20
> > Posted link to wrong patch, I meant the following patch:
> >=20
> > [RFC] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
> > https://patchwork.ozlabs.org/patch/1841495/
>=20
>=20
> I just tried with your branch & this patch on top, it still fails to boot
> and seems to be random how far it gets through the loading phase. Again I=
've
> removed the ddr training log.
> It seems to get further this time though...
>=20
> Boot #1:
> > U-Boot SPL 2023.10-00055-g29313fff30 (Oct 17 2023 - 09:44:21 +0100)
> > Trying to boot from MMC1
> > ## Checking hash(es) for config config-1 ... OK
> > ## Checking hash(es) for Image atf-1 ... sha256+ OK
> > ## Checking hash(es) for Image u-boot ... sha256+ OK
> > <crash>
>=20
>=20
> Boot #2:
> > U-Boot SPL 2023.10-00055-g29313fff30 (Oct 17 2023 - 09:44:21 +0100)
> > Trying to boot from MMC1
> > ## Checking hash(es) for config config-1 ... OK
> > ## Checking hash(es) for Image atf-1 ... sha256+ OK
> > ## Checking hash(es) for Image u-boot ... sha256+ OK
> > ## Checking hash(es) for Image fdt-1 ... sha256+ OK
> > ## Checking hash(es) for Image atf-2 ... sha256+ OK
> > ## Checking hash(es) for Image atf-3 ... sha256+ OK
> > ## Checking hash(es) for Image atf-4 ... sha256+ OK
> > spl_load_simple_fit: can't load image loadables index 4 (ret =3D -5)
> > mmc_load_image_raw_sector: mmc block read error
> > Trying to boot from MMC2
> > Card did not respond to voltage select! : -110
> > spl: mmc init failed with error: -95
> > Trying to boot from MMC1
> > mmc_load_image_raw_sector: mmc block read error
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
>=20
>=20
> Boot #3:
> > U-Boot SPL 2023.10-00055-g29313fff30 (Oct 17 2023 - 09:44:21 +0100)
> > Trying to boot from MMC1
> > ## Checking hash(es) for config config-1 ... OK
> > ## Checking hash(es) for Image atf-1 ... sha256+ OK
> > ## Checking hash(es) for Image u-boot ... sha256+ OK
> > ## Checking hash(es) for Image fdt-1 ... sha256+ OK
> > ## Checking hash(es) for Image atf-2 ... sha256+ OK
> > ## Checking hash(es) for Image atf-3 ... sha256+ OK
> > ## Checking hash(es) for Image atf-4 ... sha256+ OK
> > spl_load_simple_fit: can't load image loadables index 4 (ret =3D -5)
> > mmc_load_image_raw_sector: mmc block read error
> > Trying to boot from MMC2
> > Card did not respond to voltage select! : -110
> > spl: mmc init failed with error: -95
> > Trying to boot from MMC1
> > mmc_load_image_raw_sector: mmc block read error
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
> >=20
>=20
> For reference I am using gcc from Debian unstable:
> > $ aarch64-linux-gnu-gcc --version
> > aarch64-linux-gnu-gcc (Debian 13.2.0-2) 13.2.0
>=20
>=20
> I can test with alternative cross-compiler if that would be useful.


Sorry to revive an old thread, but I managed to do some more testing with t=
his
board. I found that my Quartz64-a booting from eMMC is still broken with U-
Boot main branch, as well as your WIP branches on GitHub. It fails with e.g=
:

  U-Boot SPL 2024.07-rc4-00480-g51c2936ec989 (Jul 05 2024 - 15:30:33 +0100)
  Trying to boot from MMC1
  spl: mmc init failed with error: -110
  Trying to boot from MMC2
  Card did not respond to voltage select! : -110
  spl: mmc init failed with error: -95
  Trying to boot from MMC1
  spl: mmc init failed with error: -70
  SPL: failed to boot from all boot devices
  ### ERROR ### Please RESET the board ###



The only thing which I have found to work, is pgwipeout's U-Boot branch, wi=
th
the following binary blobs (The same U-Boot branch doesn't seem to work wit=
h
the latest version of the BL31 blob. Seems to need that specific BL31. This=
 is
very, very strange to me.)

The DDR bin seems to be unaffected, but I included a working version below
anyway.
https://github.com/rockchip-linux/rkbin/raw/6186debcac95553f6b311cee10669e1=
2c9c9963d/bin/rk35/rk3568_bl31_v1.28.elf

https://github.com/rockchip-linux/rkbin/raw/ddf03c1d80b33dac72a33c4f732fc58=
49b47ff99/bin/rk35/rk3568_ddr_1560MHz_v1.13.bin

To make Peter's branch build, you need to set BL31 and move the DDR bin to
ram_init.bin

I tried to forward-port some of the changes to U-Boot mainline, but the sam=
e
error.

@Peter, can you try and confirm the error booting from eMMC on Quartz64-A w=
ith
mainline U-Boot ?



>=20
> Thanks,
> Chris
>=20
> >=20
> > Regards,
> > Jonas
> >=20
> > >=20
> > > Please try with CONFIG_MMC_TRACE=3Dy to see what commands fails on yo=
ur
> > > device.
> > >=20
> > > If above patches does not work also try with following options applie=
d:
> > >=20
> > > CONFIG_MMC_HS200_SUPPORT=3Dy
> > > CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
> > >=20
> > > Use of HS200 seem to be the most reliable option on rk35xx based on m=
y
> > > limited testing.
> > >=20
> > > > ...
> > > >=20
> > > > > >=20
> > > > > > What happens if you write u-boot-rockchip.bin to eMMC module
> > > > > > usinga USB adapter:
> > > > > >=20
> > > > > > =C2=A0 dd if=3Du-boot-rockchip.bin of=3D/dev/<device> bs=3D32k =
seek=3D1
> > > > > > conv=3Dfsync
> > > > > >=20
> > > > > > or using U-Boot cmd when booted from a SD-card?
> > > > > >=20
> > > > > > =C2=A0 # Read u-boot-rockchip.bin from first partition of a SD =
card
> > > > > > =C2=A0 load mmc 1:1 10000000 u-boot-rockchip.bin
> > > > > >=20
> > > > > > =C2=A0 # Change to eMMC
> > > > > > =C2=A0 mmc dev 0
> > > > > >=20
> > > > > > =C2=A0 # Write 10 MiB (0x5000 blocks) at sector 64 (0x40)
> > > > > > =C2=A0 mmc write $fileaddr 40 5000
> > > > > >=20
> > > > > > Does that make any difference?
> > > > >=20
> > > > > I don't think I have an eMMC writer for Pine64 eMMCs, I will try =
to
> > > > > get hold of one this week.
> > > >=20
> > > > I have two USB writers. Anyway, the first boot, it fails with:
> > > >=20
> > > > > U-Boot SPL 2023.10-00054-gef68159087 (Oct 12 2023 - 12:30:14 +010=
0)
> > > > > Trying to boot from MMC1
> > > > > ## Checking hash(es) for config config-1 ... OK
> > > > > ## Checking hash(es) for Image atf-1 ... sha256+ OK
> > > > > ## Checking hash(es) for Image u-boot ... sha256+ OK
> > > > > <hang>
> > > >=20
> > > >=20
> > > > Then again after a reset:
> > > >=20
> > > > > U-Boot SPL 2023.10-00054-gef68159087 (Oct 12 2023 - 12:30:14 +010=
0)
> > > > > Trying to boot from MMC1
> > > > > mmc fail to send stop cmd
> > > > > mmc_load_image_raw_sector: mmc block read error
> > > > > Trying to boot from MMC2
> > > > > Card did not respond to voltage select! : -110
> > > > > spl: mmc init failed with error: -95
> > > > > Trying to boot from MMC1
> > > > > mmc_load_image_raw_sector: mmc block read error
> > > > > SPL: failed to boot from all boot devices
> > > > > ### ERROR ### Please RESET the board ###
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > > But it fails to write to the eMMC with:
> > > > >=20
> > > > > > =3D> load mmc 1:2 10000000 u-boot-rockchip.bin
> > > > > > 9510400 bytes read in 791 ms (11.5 MiB/s)
> > > > > >=20
> > > > > > =3D> mmc dev 0
> > > > > > switch to partitions #0, OK
> > > > > > mmc0(part 0) is current device
> > > > > >=20
> > > > > >=20
> > > > > > =3D> mmc write $fileaddr 40 5000
> > > > > > MMC write: dev # 0, block # 64, count 20480 ... mmc write faile=
d
> > > > > > 0 blocks written: ERROR
> > > > > >=20
> > > > > > =3D> mmc info
> > > > > > Device: mmc@fe310000
> > > > > > Manufacturer ID: 45
> > > > > > OEM: 0
> > > > > > Name: DF4016=20
> > > > > > Bus Speed: 52000000
> > > > > > Mode: MMC DDR52 (52MHz)
> > > > > > Rd Block Len: 512
> > > > > > MMC version 5.1
> > > > > > High Capacity: Yes
> > > > > > Capacity: 14.7 GiB
> > > > > > Bus Width: 8-bit DDR
> > > > > > Erase Group Size: 512 KiB
> > > > > > HC WP Group Size: 8 MiB
> > > > > > User Capacity: 14.7 GiB WRREL
> > > > > > Boot Capacity: 4 MiB ENH
> > > > > > RPMB Capacity: 4 MiB ENH
> > > > >=20
> > > > > I think this points to some issue with the mmc driver in U-Boot, =
or
> > > > > possibly some issue with my board. But I find that hard to believ=
e
> > > > > because the Rockchip usbloader seems to write to the eMMC
> > > > > just
> > > > > fine ?
> > >=20
> > > Probably related to sdhci driver and rx/tx tap and/or delay num etc.
> > >=20
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > Boot log (v2023.10-rc2):
> > > > > > >=20
> > > > > > > U-Boot SPL 2023.10-rc2 (Aug 08 2023 - 14:02:34 +0100)
> > > > > > > rockchip_sdhci_probe clk set rate fail!
> > > > > > > Trying to boot from MMC1
> > > > > > > spl: mmc init failed with error: -110
> > > > > > > Trying to boot from MMC2
> > > > > > > Card did not respond to voltage select! : -110
> > > > > > > spl: mmc init failed with error: -95
> > > > > > > Trying to boot from MMC1
> > > > > >=20
> > > > > > Strange that second try of eMMC (MMC1) gets little bit longer.
> > > > > >=20
> > > > > > > ## Checking hash(es) for config config-1 ... OK
> > > > > > > ## Checking hash(es) for Image atf-1 ... sha256+ OK
> > > > > > > spl_load_simple_fit: can't load image loadables index 0 (ret =
=3D -
> > > > > > > 5)
> > > > > > > mmc_load_image_raw_sector: mmc block read error
> > > > > > > SPL: failed to boot from all boot devices
> > > > > > > ### ERROR ### Please RESET the board ###
> > > > > > >=20
> > > > > > >=20
> > > > > > > Boot log (your branch):
> > > > > > >=20
> > > > > > > U-Boot SPL 2023.10-rc1-00368-g16cb31d427 (Aug 08 2023 - 15:17=
:35
> > > > > > > +0100)
> > > > > > > Trying to boot from MMC1
> > > > > > > spl: mmc init failed with error: -70
> > > > > > > Trying to boot from MMC2
> > > > > > > Card did not respond to voltage select! : -110
> > > > > > > spl: mmc init failed with error: -95
> > > > > > > Trying to boot from MMC1
> > > > > > > ## Checking hash(es) for config config-1 ... OK
> > > > > > > mmc_load_image_raw_sector: mmc block read error
> > > > > > > SPL: failed to boot from all boot devices
> > > > > > > ### ERROR ### Please RESET the board ###
> > > > > >=20
> > > > > > I have not been able to reproduce this kind of issue on any of =
my
> > > > > > two
> > > > > > Quartz64-A boards, tested with different eMMC modules.
> > > > > >=20
> > > > > > Does your eMMC module have some compatibility issue?
> > > > > > Do you have any more details on the eMMC module you have tested
> > > > > > with?
> > > > >=20
> > > > > I have two eMMCs, one from FORESEE which came with a Pine64 and o=
ne
> > > > > marked SanDisk (which I posted the mmc info for above).
> > >=20
> > > My eMMC modules is also FORESEE or SanDisk, from Pine64, Radxa and
> > > Hardkernel.
> > >=20
> > > > >=20
> > > > > My hardware is marked Quartz64-RK3399-V2.0 2021-04-27
> > > > > Maybe there is some difference with your board?
> > >=20
> > > Should match my board, I have the hw revision where SATA port is
> > > removed.
> > > (boards with/without SATA have same version silk on the board)
> > >=20
> > > > >=20
> > > > > I will also try an image with vendor u-boot as a next step.
> > > >=20
> > > > I tried latest Armbian (which seems to use ) from
> > > > https://github.com/armbian/build/releases/=C2=A0and flashed the eMM=
C with
> > > > the USB writer. It ended up booting to Linux, which proves that the
> > > > hardware I
> > > > have is most likey in a good working order ;-)!
> > >=20
> > > Hopefully the issue is related to the peephole2 optimization issue or
> > > the use of a not fully supported ddr52 mode.
> > >=20
> > > Regards,
> > > Jonas
> > >=20
> > > >=20
> > > >=20
> > > > > U-Boot SPL 2022.10-rc4-armbian (Feb 11 2023 - 22:25:16 +0000)
> > > > > saradc@fe720000: Can't update Vdd. Error: -38saradc@fe720000: Can=
't
> > > > > update Vss. Error: -38can't get vref-supply: -38
> > > > > rockchip_dnl_key_pressed: adc_channel_single_shot fail!
> > > > > Trying to boot from MMC2
> > > > > INFO:=C2=A0=C2=A0=C2=A0 Preloader serial: 2
> > > > > NOTICE:=C2=A0 BL31: v2.3():v2.3-152-g4e725b15f:cl
> > > > > NOTICE:=C2=A0 BL31: Built : 10:51:13, Jul 15 2021
> > > > > INFO:=C2=A0=C2=A0=C2=A0 GICv3 without legacy support detected.
> > > > > INFO:=C2=A0=C2=A0=C2=A0 ARM GICv3 driver initialized in EL3
> > > > > INFO:=C2=A0=C2=A0=C2=A0 pmu v1 is valid
> > > > > INFO:=C2=A0=C2=A0=C2=A0 dfs DDR fsp_param[0].freq_mhz=3D 1560MHz
> > > > > INFO:=C2=A0=C2=A0=C2=A0 dfs DDR fsp_param[1].freq_mhz=3D 324MHz
> > > > > INFO:=C2=A0=C2=A0=C2=A0 dfs DDR fsp_param[2].freq_mhz=3D 528MHz
> > > > > INFO:=C2=A0=C2=A0=C2=A0 dfs DDR fsp_param[3].freq_mhz=3D 780MHz
> > > > > INFO:=C2=A0=C2=A0=C2=A0 Using opteed sec cpu_context!
> > > > > INFO:=C2=A0=C2=A0=C2=A0 boot cpu mask: 0
> > > > > INFO:=C2=A0=C2=A0=C2=A0 BL31: Initializing runtime services
> > > > > WARNING: No OPTEE provided by BL2 boot loader, Booting device
> > > > > without OPTEE initialization. SMC`s destined for OPTEE will retur=
n
> > > > > SMC_UNK
> > > > > ERROR:=C2=A0=C2=A0 Error initializing runtime service opteed_fast
> > > > > INFO:=C2=A0=C2=A0=C2=A0 BL31: Preparing for EL3 exit to normal wo=
rld
> > > > > INFO:=C2=A0=C2=A0=C2=A0 Entry point address =3D 0xa00000
> > > > > INFO:=C2=A0=C2=A0=C2=A0 SPSR =3D 0x3c9
> > > > >=20
> > > > >=20
> > > > > U-Boot 2022.10-rc4-armbian (Feb 11 2023 - 22:25:16 +0000)
> > > > >=20
> > > > > Model: Pine64 RK3566 Quartz64-A Board
> > > > > DRAM:=C2=A0 2 GiB
> > > > > PMIC:=C2=A0 RK8170 (on=3D0x10, off=3D0x00)
> > > > > Core:=C2=A0 266 devices, 21 uclasses, devicetree: separate
> > > > > MMC:=C2=A0=C2=A0 mmc@fe2b0000: 1, mmc@fe310000: 0
> > > > > Loading Environment from nowhere... OK
> > > > > In:=C2=A0=C2=A0=C2=A0 serial@fe660000
> > > > > Out:=C2=A0=C2=A0 serial@fe660000
> > > > > Err:=C2=A0=C2=A0 serial@fe660000
> > > > > Model: Pine64 RK3566 Quartz64-A Board
> > > > > can't get vref-supply: -2
> > > > > rockchip_dnl_key_pressed: adc_channel_single_shot fail!
> > > > > Net:=C2=A0=C2=A0 No ethernet found.
> > > > > Hit any key to stop autoboot:=C2=A0 0=20
> > > > > starting USB...
> > > > > Bus usb@fcc00000: Port not available.
> > > > > Bus usb@fd000000: Port not available.
> > > > > Bus usb@fd800000: USB EHCI 1.00
> > > > > Bus usb@fd840000: USB OHCI 1.0
> > > > > Bus usb@fd880000: USB EHCI 1.00
> > > > > Bus usb@fd8c0000: USB OHCI 1.0
> > > > > scanning bus usb@fd800000 for devices... 1 USB Device(s) found
> > > > > scanning bus usb@fd840000 for devices... ERROR:=C2=A0 USB-error:
> > > > > DEVICENOTRESPONDING: Device did not respond to token (IN) or did
> > > > > not provide a handshake (OUT) (5)
> > > > > ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to
> > > > > token (IN) or did
> > > > > not provide a handshake (OUT) (5)
> > > > > unable to get device descriptor (error=3D-1)
> > > > > 1 USB Device(s) found
> > > > > scanning bus usb@fd880000 for devices... 1 USB Device(s) found
> > > > > scanning bus usb@fd8c0000 for devices... 1 USB Device(s) found
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scanning usb for storage dev=
ices... 0 Storage Device(s) found
> > > > >=20
> > > > > Device 0: unknown device
> > > > > Card did not respond to voltage select! : -110
> > > > > switch to partitions #0, OK
> > > > > mmc0(part 0) is current device
> > > > > Scanning mmc 0:1...
> > > > > Found /boot/extlinux/extlinux.conf
> > > > > Retrieving file: /boot/extlinux/extlinux.conf
> > > > > 1:	Armbian
> > > > > Retrieving file: /boot/uInitrd
> > > > > Retrieving file: /boot/Image
> > > > > append: root=3DUUID=3D7f9c9970-93ba-46ca-9f03-f3241712ead8
> > > > > console=3DttyS02,1500000 console=3Dtty0 rw no_console_suspend
> > > > > consoleblank=3D0 fsck.fix=3Dyes fsck.repair=3Dyes net.ifnames=3D0=
 splash
> > > > > plymouth.ignore-
> > > > > serial-consoles
> > > > > Retrieving file: /boot/dtb/rockchip/rk3566-quartz64-a.dtb
> > > > > Moving Image from 0x2080000 to 0x2200000, end=3D3de0000
> > > > > ## Loading init Ramdisk from Legacy Image at 0a200000 ...
> > > > > =C2=A0=C2=A0 Image Name:=C2=A0=C2=A0 uInitrd
> > > > > =C2=A0=C2=A0 Image Type:=C2=A0=C2=A0 AArch64 Linux RAMDisk Image =
(gzip compressed)
> > > > > =C2=A0=C2=A0 Data Size:=C2=A0=C2=A0=C2=A0 34402446 Bytes =3D 32.8=
 MiB
> > > > > =C2=A0=C2=A0 Load Address: 00000000
> > > > > =C2=A0=C2=A0 Entry Point:=C2=A0 00000000
> > > > > =C2=A0=C2=A0 Verifying Checksum ... OK
> > > > > ## Flattened Device Tree blob at 0a100000
> > > > > =C2=A0=C2=A0 Booting using the fdt blob at 0xa100000
> > > > > =C2=A0=C2=A0 Loading Ramdisk to 7be16000, end 7dee508e ... OK
> > > > > =C2=A0=C2=A0 Loading Device Tree to 000000007bdf7000, end 0000000=
07be158e2 ...
> > > > > OK
> > > > >=20
> > > > > Starting kernel ...
> > > > >=20
> > > > > efi_free_pool: illegal free 0x000000007cee7040
> > > > > efi_free_pool: illegal free 0x000000007cee4040
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Booting Linux on physical CPU 0x000=
0000000
> > > > > [0x412fd050]
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 6.2.0-rc6-media (root=
@d00a59921686)
> > > > > (aarch64-linux-gnu-gcc (GNU Toolchain for the A-profile Architect=
ure
> > > > > 8.3-2019.03 (arm-rel-8.36)) 8.3.0, GNU ld (GNU Toolchain
> > > > > for the
> > > > > A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 2.32.0.2019032=
1)
> > > > > #trunk.0252 SMP PREEMPT_DYNAMIC Sat Feb 11 22:41:21 UTC 2023
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Machine model: Pine64 RK3566 Quartz=
64-A Board
> > > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > Thanks!
> > > >=20
> > > > Chris
> > >=20
> >=20

