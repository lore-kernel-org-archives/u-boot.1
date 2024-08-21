Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8328EC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 10:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF28188B3F;
	Wed, 21 Aug 2024 12:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724235022;
	bh=eesf1Y2GRdaquvYlGrt7Gj75csCy58PYnSg2sPw3Bo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QgPDzKJFPS9+TSUTTydZzP9qmfVvG9BeyodbxiKcGpjHNHszTH4SJAquZYfkDG5gy
	 gCyM/26+wqz7gqwzXQkbcXjexRr1gnv9sqxLIcfBHkq60AyouGQIF8XchoQBUxd+Fk
	 BtWoIVkpQx5g3ou5SgmOIczeTcATWgICPgbWnczSPuHDDXYYkkthkppdKcvBAdvxn6
	 eFeIG7ydqIfoxGT5N1SBiB0WRbFYN6US5/UnmhkgnKkrB1sdZ4jKiYxykb6yhcjLWa
	 cZasYh720ebQRh7gj+gQIqdoVz/i2XVMzgIaS3m6obulLSg0MssidjRzcmxMS5UM5y
	 IKQPt+Y29+QIg==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ABECA88AB9;
 Wed, 21 Aug 2024 12:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724235021;
 bh=eesf1Y2GRdaquvYlGrt7Gj75csCy58PYnSg2sPw3Bo8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S3BO3Lq8DGDcuLr0YWXY7tey/FqE/WPI8EV7qE0QC1ToI2AJXXlFZyoSaroUTUG0C
 0z2KWGscSN0hCcyDzJj5Qfjm46jsQOHNucAzuYU5gD0/6k9YxVkc3wS8AO+8dYAVkp
 5nbYKkI3GdfZg8+pbud3JXO6eZ7e3sxaitnzG1+EtDKDIwXvUT5wjK4DVmbsxHx7mU
 vCkWOiWo9d70dlakms5BUjAuLbVno4i3W4Fs0ygzeXpw0YtftkX6gQB5I0evAV/60R
 WouYORxkcs7QDv37LnOgBYlFYELUJ99PiAAby6icuLDiI6TLGEHkePh7t5/s1rUtSA
 WiNKExtM09/Mw==
Date: Wed, 21 Aug 2024 12:10:19 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 "Fabio Estevam" <festevam@gmail.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "Cem Tenruh" <C.Tenruh@phytec.de>, Tom Rini
 <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Yannic
 Moog <Y.Moog@phytec.de>, Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH] config: imx: Add support for Phytec's phycore imx8mm
 running SDP gadget
Message-ID: <20240821121019.3120d93a@wsk>
In-Reply-To: <d7cd0e7f-355c-4034-9d60-6442929b2b4c@phytec.de>
References: <20240815084504.479112-1-lukma@denx.de>
 <0ee18119-98ac-4bc8-931e-50e4ac77be65@phytec.de>
 <20240819163600.65309a9a@wsk>
 <d7cd0e7f-355c-4034-9d60-6442929b2b4c@phytec.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Oavkp5MvSKPyYg1Btep5pOJ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/Oavkp5MvSKPyYg1Btep5pOJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

> On 19.08.24 16:36, Lukasz Majewski wrote:
> > Hi Benjamin,
> > =20
> >> Hi Lukasz,
> >> did you test this? It does not work for me. When I try it, the
> >> U-Boot hangs in SPL. Here is what I got:
> >>   From Host:
> >>
> >> bhahn@llp-hahn:~/git-repos/u-boot$ sudo uuu -b spl
> >> build/mini/flash.bin uuu (Universal Update Utility) for nxp imx
> >> chips -- lib1.4.193
> >>
> >> Success 0=C2=A0=C2=A0=C2=A0 Failure 0
> >>
> >>
> >> 7:3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1/ 1 [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D100%=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D] SDP: boot -f
> >> build/mini/flash.bin
> >> =20
> > Please test this branch:
> > https://github.com/lmajewski/u-boot/commits/phycore-imx8mm-qspi-nvme
> >
> > On HOST:
> > uuu -v -b qspi ~/work/DENX/u-boot/flash.bin
> >
> > Stop on u-boot prompt.
> >
> > u-boot=3D> fastboot 0
> >
> > QSPI is flashed via USB - however - I've noticed that there are some
> > flipped bits on USB transmission when I do compare it with tftp
> > transfer.
> >
> > This needs to be investigated, however seems to be an orthogonal
> > problem from QSPI boot support. =20
>=20
> I tested your branch. Your commands seem to work. Here is the log:
>=20
>=20
> U-Boot SPL 2024.10-rc2-g718c0f57cacb (Aug 21 2024 - 10:12:26 +0200)
> WDT:=C2=A0=C2=A0 Started watchdog@30280000 with servicing every 1000ms (6=
0s
> timeout) Trying to boot from USB SDP
> SDP: initialize...
> SDP: handle requests...
> Downloading file of size 984992 to 0x40400000... done
> Jumping to header at 0x40400000
> Header Tag is not an IMX image
> Found header at 0x40424a00
> NOTICE:=C2=A0 BL31: v2.6(release):lf-5.15.71-2.2.1-0-gf4540f956
> NOTICE:=C2=A0 BL31: Built : 06:10:48, Apr 13 2023
>=20
>=20
> U-Boot 2024.10-rc2-g718c0f57cacb (Aug 21 2024 - 10:12:26 +0200)
>=20
> CPU:=C2=A0=C2=A0 Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
> CPU:=C2=A0=C2=A0 Industrial temperature grade (-40C to 105C) at 42C
> Reset cause: POR
> Model: PHYTEC phyBOARD-Polis-i.MX8MM RDK
> DRAM:=C2=A0 2 GiB
> Core:=C2=A0 114 devices, 28 uclasses, devicetree: separate
> WDT:=C2=A0=C2=A0 Started watchdog@30280000 with servicing every 1000ms (6=
0s
> timeout) MMC:=C2=A0=C2=A0 FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... *** Warning - bad CRC, using default=20
> environment
>=20
> Reading from MMC(2)... In:=C2=A0=C2=A0=C2=A0 serial@30880000
> Out:=C2=A0=C2=A0 serial@30880000
> Err:=C2=A0=C2=A0 serial@30880000
> Net:=C2=A0=C2=A0 eth0: ethernet@30be0000
> Hit any key to stop autoboot:=C2=A0 0
> u-boot=3D> fastboot 0
> Starting download of 1194400 bytes
> .........
> downloading of 1194400 bytes finished
> Unknown command 'qspihdr' - try 'help'
> SF: Detected n25q256ax1 with page size 256 Bytes, erase size 64 KiB,=20
> total 32 MiB
> SF: 1245184 bytes @ 0x0 Erased: OK
> device 0 offset 0x0, size 0x1239a0
> SF: 1194400 bytes @ 0x0 Written: OK
>=20

Ok.

>=20
> I noticed this message in the log though:
>=20
> Unknown command 'qspihdr' - try 'help'
>=20

The same "Unknown command...." was also present on my site.

>=20
> Booting over qspi does not work. Probably because it is not a
> dedicated qspi flash image (does not get flashed with the correct
> offset).

Are you using imx8mm or imx8mn ?

Please check if you have:
https://github.com/lmajewski/u-boot/commit/d33a67756c7a29618ececcfd9a9d2def=
3b1f9af0

on your board added.

If possible - you can use tftp to download the flash.bin to your board?

setenv serverip 10.0.0.81;dhcp flash-fspi.bin; sf probe; sf
erase 0x0 0x200000; sf write 0x40480000 0x0 0x200000
sf erase 0x400000 0x100000


>=20
> About some bits getting flipped:
> For me it is not just some bits getting flipped. I read back the
> image from /dev/mtd0 with the dd command and compare the hexdump
> ouput to the original image. Theoretically it should identical, but
> that is not the case. There are not just some flipped bits, but the
> Image flashed via uuu looks like a completely different image.=20

Ok - strange...

Then uuu (and USB) needs to be debugged.

> I also
> tested flashing with dd in linux and in U-Boot with loading the image
> via fatload from the sdcard and flashing it with "sf update
> ${loadaddr} 0 ${filesize}". With those two flashing methods I get an
> Image that is identical to the original Image when I read it back, as
> I would expect.

Ok.

Just to be 100% sure - are you able to boot from QSPI with the
flash.bin build from
https://github.com/lmajewski/u-boot/commits/phycore-imx8mm-qspi-nvme

>=20
> Benjamin
>=20
> > =20
> >> Log on target:
> >>
> >> U-Boot SPL 2024.10-rc2-00131-g0303f2240376 (Aug 19 2024 - 15:18:36
> >> +0200) WDT:=C2=A0=C2=A0 Started watchdog@30280000 with servicing every=
 1000ms
> >> (60s timeout) Trying to boot from USB SDP
> >>
> >> U-Boot SPL 2024.10-rc2-00131-g0303f2240376 (Aug 19 2024 - 15:18:36
> >> +0200) WDT:=C2=A0=C2=A0 Started watchdog@30280000 with servicing every=
 1000ms
> >> (60s timeout) Trying to boot from USB SDP
> >>
> >> To me it looks like there are some changes missing to get this
> >> feature to work.
> >> You can take a look at my commits where I added this feature for
> >> imx8mp. 199229e28b2b2da57c52ee46452f930785cf6002 ("phycore-imx8mp:
> >> add USB mass storage support")
> >> 8dcf1df48dff339b172d1bce2a38a965ee4aafca ("phycore-imx8mp: add
> >> support for booting and flashing emmc via UUU")
> >>
> >>
> >> Here are the changes I needed to do on top of your patch to get
> >> this feature to work for mini:
> >>
> >> diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> >> b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> >> index 516e52e1f5de..cdaff2f8da9b 100644
> >> --- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> >> +++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> >> @@ -69,3 +69,8 @@
> >>   =C2=A0&wdog1 {
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootph-pre-ram;
> >>   =C2=A0};
> >> +
> >> +&usbotg1 {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dr_mode =3D "peripheral";
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot,dm-spl;
> >> +};
> >> diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> >> b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> >> index 06cffbca3a69..00fdd4edbe36 100644
> >> --- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> >> +++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> >> @@ -45,6 +45,10 @@ int board_late_init(void)
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MMC3_BOOT:
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 env_set_ulong("mmcdev", 2);
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case USB_BOOT:
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 printf("Detect USB boot. Will enter fastboot
> >> mode!\n");
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 env_set_ulong("dofastboot", 1);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> diff --git a/configs/phycore-imx8mm_defconfig
> >> b/configs/phycore-imx8mm_defconfig
> >> index beb2f1e9f031..e8d3ffe8c05d 100644
> >> --- a/configs/phycore-imx8mm_defconfig
> >> +++ b/configs/phycore-imx8mm_defconfig
> >> @@ -31,7 +31,7 @@ CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
> >>   =C2=A0CONFIG_SPL_LOAD_FIT=3Dy
> >>   =C2=A0CONFIG_OF_SYSTEM_SETUP=3Dy
> >>   =C2=A0CONFIG_USE_BOOTCOMMAND=3Dy
> >> -CONFIG_BOOTCOMMAND=3D"mmc dev ${mmcdev}; if mmc rescan; then if run
> >> loadimage; then run mmcboot; else run netboot; fi; fi;"
> >> +CONFIG_BOOTCOMMAND=3D"if test ${dofastboot} =3D 1; then fastboot 0;
> >> fi; mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then
> >> run mmcboot; else run netboot; fi; fi;"
> >>   =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"oftree"
> >>   =C2=A0CONFIG_SYS_CBSIZE=3D2048
> >>   =C2=A0CONFIG_SYS_PBSIZE=3D2074
> >> @@ -153,3 +153,11 @@ CONFIG_CI_UDC=3Dy
> >>   =C2=A0CONFIG_SDP_LOADADDR=3D0x40400000
> >>   =C2=A0CONFIG_SPL_USB_SDP_SUPPORT=3Dy
> >>   =C2=A0CONFIG_IMX_WATCHDOG=3Dy
> >> +CONFIG_CMD_USB_SDP=3Dy
> >> +CONFIG_FASTBOOT_FLASH=3Dy
> >> +CONFIG_FASTBOOT_FLASH_MMC_DEV=3D2
> >> +CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=3Dy
> >> +CONFIG_FASTBOOT_MMC_BOOT1_NAME=3D"mmc2boot0"
> >> +CONFIG_FASTBOOT_MMC_BOOT2_NAME=3D"mmc2boot1"
> >> +CONFIG_FASTBOOT_MMC_USER_SUPPORT=3Dy
> >> +CONFIG_FASTBOOT_MMC_USER_NAME=3D"mmc2"
> >> diff --git a/include/configs/phycore_imx8mm.h
> >> b/include/configs/phycore_imx8mm.h
> >> index dd7cfdba52d2..f3a750089dd5 100644
> >> --- a/include/configs/phycore_imx8mm.h
> >> +++ b/include/configs/phycore_imx8mm.h
> >> @@ -26,6 +26,11 @@
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fdt_addr=3D0x48000000\0"=
 \
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fdt_file=3D" CONFIG_DEFA=
ULT_FDT_FILE "\0" \
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ip_dyn=3Dyes\0" \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dofastboot=3D0\0" \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fastboot_raw_partition_bootload=
er=3D66 8128\0" \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fastboot_raw_partition_all=3D0 =
4194304\0" \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "emmc_dev=3D2\0" \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sd_dev=3D1\0" \
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmcdev=3D" __stringify(C=
ONFIG_SYS_MMC_ENV_DEV) "\0" \
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmcpart=3D1\0" \
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmcroot=3D2\0" \
> >>
> >>
> >> With these changes booting via SDP with uuu and flashing emmc with
> >> uuu should work. Sadly I did not find a way to be able to flash
> >> eMMC and SD-Card over uuu with the same bootloader because it was
> >> necessary for me to specify the device to flash in
> >> CONFIG_FASTBOOT_FLASH_MMC_DEV.
> >>
> >> with kind regards,
> >> Benjamin
> >>
> >> On 15.08.24 10:45, Lukasz Majewski wrote: =20
> >>> After this change it would be possible to boot SDP gadget when
> >>> Phytec's Phycore imx8mm module has USB ROM boot selected.
> >>>
> >>> With this change it shall be possible to flash eMMC/SD card
> >>> content with uuu program.
> >>>
> >>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >>> ---
> >>>    configs/phycore-imx8mm_defconfig | 18 +++++++++++++++++-
> >>>    1 file changed, 17 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/configs/phycore-imx8mm_defconfig
> >>> b/configs/phycore-imx8mm_defconfig index 6748e6fafb..beb2f1e9f0
> >>> 100644 --- a/configs/phycore-imx8mm_defconfig
> >>> +++ b/configs/phycore-imx8mm_defconfig
> >>> @@ -25,6 +25,7 @@ CONFIG_SPL=3Dy
> >>>    CONFIG_ENV_OFFSET_REDUND=3D0x3E0000
> >>>    CONFIG_SYS_LOAD_ADDR=3D0x40480000
> >>>    CONFIG_PCI=3Dy
> >>> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> >>>    CONFIG_FIT=3Dy
> >>>    CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
> >>>    CONFIG_SPL_LOAD_FIT=3Dy
> >>> @@ -57,6 +58,7 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=3D2
> >>>    CONFIG_SYS_EEPROM_SIZE=3D4096
> >>>    CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3D5
> >>>    CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=3D5
> >>> +# CONFIG_CMD_BIND is not set
> >>>    CONFIG_CMD_CLK=3Dy
> >>>    CONFIG_CMD_FUSE=3Dy
> >>>    CONFIG_CMD_GPIO=3Dy
> >>> @@ -86,6 +88,10 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=3Dy
> >>>    CONFIG_CLK_COMPOSITE_CCF=3Dy
> >>>    CONFIG_SPL_CLK_IMX8MM=3Dy
> >>>    CONFIG_CLK_IMX8MM=3Dy
> >>> +CONFIG_USB_FUNCTION_FASTBOOT=3Dy
> >>> +CONFIG_FASTBOOT_BUF_ADDR=3D0x42800000
> >>> +CONFIG_FASTBOOT_BUF_SIZE=3D0x20000000
> >>> +CONFIG_FASTBOOT_UUU_SUPPORT=3Dy
> >>>    CONFIG_MXC_GPIO=3Dy
> >>>    CONFIG_DM_I2C=3Dy
> >>>    CONFIG_MISC=3Dy
> >>> @@ -116,7 +122,6 @@ CONFIG_FEC_MXC=3Dy
> >>>    CONFIG_MII=3Dy
> >>>    CONFIG_NVME_PCI=3Dy
> >>>    CONFIG_PCIE_DW_IMX=3Dy
> >>> -CONFIG_PHY=3Dy
> >>>    CONFIG_PHY_IMX8M_PCIE=3Dy
> >>>    CONFIG_PINCTRL=3Dy
> >>>    CONFIG_SPL_PINCTRL=3Dy
> >>> @@ -136,4 +141,15 @@ CONFIG_SYSRESET_PSCI=3Dy
> >>>    CONFIG_SYSRESET_WATCHDOG=3Dy
> >>>    CONFIG_DM_THERMAL=3Dy
> >>>    CONFIG_IMX_TMU=3Dy
> >>> +CONFIG_USB=3Dy
> >>> +CONFIG_SPL_USB_HOST=3Dy
> >>> +CONFIG_USB_EHCI_HCD=3Dy
> >>> +CONFIG_MXC_USB_OTG_HACTIVE=3Dy
> >>> +CONFIG_USB_GADGET=3Dy
> >>> +CONFIG_SPL_USB_GADGET=3Dy
> >>> +CONFIG_USB_GADGET_VENDOR_NUM=3D0x0525
> >>> +CONFIG_USB_GADGET_PRODUCT_NUM=3D0xa4a5
> >>> +CONFIG_CI_UDC=3Dy
> >>> +CONFIG_SDP_LOADADDR=3D0x40400000
> >>> +CONFIG_SPL_USB_SDP_SUPPORT=3Dy
> >>>    CONFIG_IMX_WATCHDOG=3Dy =20
> >> =20
> >
> >
> >
> > Best regards,
> >
> > Lukasz Majewski
> >
> > --
> >
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de =20
>=20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Oavkp5MvSKPyYg1Btep5pOJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbFvQsACgkQAR8vZIA0
zr0zbwf/fZf0g1D8xg4pxXLl9+cEg2TpsNgJuEhugH+T2iNVj0iaWJZoPxngc2/b
fpgQgar8RijUxmne8sz3o8SiM8XuT86cRnZaYJcgqWjKj9qQVe0cCDNkcKA6pd8B
gdpCs84nJnlgUslnMoOy2ipcnM6CTawMoP8q3s88lAqtlZ01NGI0yn3KXIAdZ2ir
uv8TUsRo12uUa1XEphcAE8pdpMfWIIvVJbV2gyp5zHzhFJCVCFkyF5UahIkaTeTE
a+tmocZXbZyRJl1JEmPrbJhRXDCOxYic+5vOlDckA4dpO+iaISkG1WU+eGw/Mnk+
GLI6f1ggzhj6S6G3QeTDBULDUeeJdQ==
=qGg1
-----END PGP SIGNATURE-----

--Sig_/Oavkp5MvSKPyYg1Btep5pOJ--
