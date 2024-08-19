Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A3FC52D6F
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 14:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04AC88ADB;
	Mon, 19 Aug 2024 16:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724078163;
	bh=CIMS3MaZ4XcuZDIQXygfaRRA5srvgyvjzzAFJhvRGp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XckhYrFVNuNwlbPJ+lztSYVQIuaRWtfFkVzkRQzF2fCrHC8fIxg8RDRSS6x/UvgX8
	 1f09weRj/dH2S0SMviWk0KwEVgx1ceX3pKjZHcHFkIw/JCLujhkqi6l8gKKPBvjuHE
	 GY5HVKTJhNy+iHyk8W06SlpPnCLdzk19Kwwys3QvupdvnyKltCC2ZLVvUf0kzq0G3Q
	 abQ3ztRlnnYcVK15vlEHMVV0CyS8Yq1kOCHdZml5qkyni6aqYgtoAaO1z6Xtlqac/3
	 Kd6NtYzUgA18ga/flq5uZTRLlySIvCD/XqWOGpe7P/tVQ45ybU7qGYlajwOuoLQ6P5
	 E7EfaGcPd9AQw==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9C26C88815;
 Mon, 19 Aug 2024 16:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724078162;
 bh=CIMS3MaZ4XcuZDIQXygfaRRA5srvgyvjzzAFJhvRGp0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZF86xenvqIG/tN53PX+yxNpj9ykAb6gr3jPPP543JeAqgUYML/F4njLPPtYlHdiNb
 Sf4vw8gkHlsseNOy8gKUAKNQBRCGrLFGZrGEnrtF4uvH3+u9ZsLOJBgFxppbVXVhdW
 usik27LrxPCjHL3FsdFTcoAE7ybjSs/t+2EN8Y8CffgqUP7eV6IRfWYTVSWcPB8Wgl
 TJ1auoKwMvHW/E/Ps6V32l6fJGw4MRAO5U83uY4TUAgyi6EVqvivhPuLdFJxs1mg2n
 ObY6yQgOdY4Fwc9Gs30A+tf+0Sm8M5faz7GffK4wsCyXLbrj1XFjzOcCLhQ/LVZzyf
 4+VtSWld0IjrA==
Date: Mon, 19 Aug 2024 16:36:00 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, Cem Tenruh <C.Tenruh@phytec.de>, Tom Rini
 <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Yannic
 Moog <Y.Moog@phytec.de>, Svyatoslav Ryhel <clamor95@gmail.com>, "Simon
 Glass" <sjg@chromium.org>
Subject: Re: [PATCH] config: imx: Add support for Phytec's phycore imx8mm
 running SDP gadget
Message-ID: <20240819163600.65309a9a@wsk>
In-Reply-To: <0ee18119-98ac-4bc8-931e-50e4ac77be65@phytec.de>
References: <20240815084504.479112-1-lukma@denx.de>
 <0ee18119-98ac-4bc8-931e-50e4ac77be65@phytec.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZDf35t3PWGBAUR3poKs5pFp";
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

--Sig_/ZDf35t3PWGBAUR3poKs5pFp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

> Hi Lukasz,
> did you test this? It does not work for me. When I try it, the U-Boot=20
> hangs in SPL. Here is what I got:
>  From Host:
>=20
> bhahn@llp-hahn:~/git-repos/u-boot$ sudo uuu -b spl
> build/mini/flash.bin uuu (Universal Update Utility) for nxp imx chips
> -- lib1.4.193
>=20
> Success 0=C2=A0=C2=A0=C2=A0 Failure 0
>=20
>=20
> 7:3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1/ 1 [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D100%=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] =
SDP: boot -f=20
> build/mini/flash.bin
>=20

Please test this branch:
https://github.com/lmajewski/u-boot/commits/phycore-imx8mm-qspi-nvme

On HOST:
uuu -v -b qspi ~/work/DENX/u-boot/flash.bin

Stop on u-boot prompt.

u-boot=3D> fastboot 0

QSPI is flashed via USB - however - I've noticed that there are some
flipped bits on USB transmission when I do compare it with tftp
transfer.

This needs to be investigated, however seems to be an orthogonal
problem from QSPI boot support.

>=20
> Log on target:
>=20
> U-Boot SPL 2024.10-rc2-00131-g0303f2240376 (Aug 19 2024 - 15:18:36
> +0200) WDT:=C2=A0=C2=A0 Started watchdog@30280000 with servicing every 10=
00ms
> (60s timeout) Trying to boot from USB SDP
>=20
> U-Boot SPL 2024.10-rc2-00131-g0303f2240376 (Aug 19 2024 - 15:18:36
> +0200) WDT:=C2=A0=C2=A0 Started watchdog@30280000 with servicing every 10=
00ms
> (60s timeout) Trying to boot from USB SDP
>=20
> To me it looks like there are some changes missing to get this
> feature to work.
> You can take a look at my commits where I added this feature for
> imx8mp. 199229e28b2b2da57c52ee46452f930785cf6002 ("phycore-imx8mp:
> add USB mass storage support")
> 8dcf1df48dff339b172d1bce2a38a965ee4aafca ("phycore-imx8mp: add
> support for booting and flashing emmc via UUU")
>=20
>=20
> Here are the changes I needed to do on top of your patch to get this=20
> feature to work for mini:
>=20
> diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi=20
> b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> index 516e52e1f5de..cdaff2f8da9b 100644
> --- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> @@ -69,3 +69,8 @@
>  =C2=A0&wdog1 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootph-pre-ram;
>  =C2=A0};
> +
> +&usbotg1 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dr_mode =3D "peripheral";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot,dm-spl;
> +};
> diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c=20
> b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> index 06cffbca3a69..00fdd4edbe36 100644
> --- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> +++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> @@ -45,6 +45,10 @@ int board_late_init(void)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MMC3_BOOT:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 env_set_ulong("mmcdev", 2);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case USB_BOOT:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 printf("Detect USB boot. Will enter fastboot
> mode!\n");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 env_set_ulong("dofastboot", 1);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 break;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> diff --git a/configs/phycore-imx8mm_defconfig=20
> b/configs/phycore-imx8mm_defconfig
> index beb2f1e9f031..e8d3ffe8c05d 100644
> --- a/configs/phycore-imx8mm_defconfig
> +++ b/configs/phycore-imx8mm_defconfig
> @@ -31,7 +31,7 @@ CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
>  =C2=A0CONFIG_SPL_LOAD_FIT=3Dy
>  =C2=A0CONFIG_OF_SYSTEM_SETUP=3Dy
>  =C2=A0CONFIG_USE_BOOTCOMMAND=3Dy
> -CONFIG_BOOTCOMMAND=3D"mmc dev ${mmcdev}; if mmc rescan; then if run=20
> loadimage; then run mmcboot; else run netboot; fi; fi;"
> +CONFIG_BOOTCOMMAND=3D"if test ${dofastboot} =3D 1; then fastboot 0; fi;
> mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run
> mmcboot; else run netboot; fi; fi;"
>  =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"oftree"
>  =C2=A0CONFIG_SYS_CBSIZE=3D2048
>  =C2=A0CONFIG_SYS_PBSIZE=3D2074
> @@ -153,3 +153,11 @@ CONFIG_CI_UDC=3Dy
>  =C2=A0CONFIG_SDP_LOADADDR=3D0x40400000
>  =C2=A0CONFIG_SPL_USB_SDP_SUPPORT=3Dy
>  =C2=A0CONFIG_IMX_WATCHDOG=3Dy
> +CONFIG_CMD_USB_SDP=3Dy
> +CONFIG_FASTBOOT_FLASH=3Dy
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=3D2
> +CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=3Dy
> +CONFIG_FASTBOOT_MMC_BOOT1_NAME=3D"mmc2boot0"
> +CONFIG_FASTBOOT_MMC_BOOT2_NAME=3D"mmc2boot1"
> +CONFIG_FASTBOOT_MMC_USER_SUPPORT=3Dy
> +CONFIG_FASTBOOT_MMC_USER_NAME=3D"mmc2"
> diff --git a/include/configs/phycore_imx8mm.h=20
> b/include/configs/phycore_imx8mm.h
> index dd7cfdba52d2..f3a750089dd5 100644
> --- a/include/configs/phycore_imx8mm.h
> +++ b/include/configs/phycore_imx8mm.h
> @@ -26,6 +26,11 @@
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fdt_addr=3D0x48000000\0" \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fdt_file=3D" CONFIG_DEFAULT_=
FDT_FILE "\0" \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ip_dyn=3Dyes\0" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dofastboot=3D0\0" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fastboot_raw_partition_bootloader=
=3D66 8128\0" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fastboot_raw_partition_all=3D0 419=
4304\0" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "emmc_dev=3D2\0" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sd_dev=3D1\0" \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmcdev=3D" __stringify(CONFI=
G_SYS_MMC_ENV_DEV) "\0" \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmcpart=3D1\0" \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmcroot=3D2\0" \
>=20
>=20
> With these changes booting via SDP with uuu and flashing emmc with
> uuu should work. Sadly I did not find a way to be able to flash eMMC
> and SD-Card over uuu with the same bootloader because it was
> necessary for me to specify the device to flash in
> CONFIG_FASTBOOT_FLASH_MMC_DEV.
>=20
> with kind regards,
> Benjamin
>=20
> On 15.08.24 10:45, Lukasz Majewski wrote:
> > After this change it would be possible to boot SDP gadget when
> > Phytec's Phycore imx8mm module has USB ROM boot selected.
> >
> > With this change it shall be possible to flash eMMC/SD card content
> > with uuu program.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >   configs/phycore-imx8mm_defconfig | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/configs/phycore-imx8mm_defconfig
> > b/configs/phycore-imx8mm_defconfig index 6748e6fafb..beb2f1e9f0
> > 100644 --- a/configs/phycore-imx8mm_defconfig
> > +++ b/configs/phycore-imx8mm_defconfig
> > @@ -25,6 +25,7 @@ CONFIG_SPL=3Dy
> >   CONFIG_ENV_OFFSET_REDUND=3D0x3E0000
> >   CONFIG_SYS_LOAD_ADDR=3D0x40480000
> >   CONFIG_PCI=3Dy
> > +# CONFIG_ANDROID_BOOT_IMAGE is not set
> >   CONFIG_FIT=3Dy
> >   CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
> >   CONFIG_SPL_LOAD_FIT=3Dy
> > @@ -57,6 +58,7 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=3D2
> >   CONFIG_SYS_EEPROM_SIZE=3D4096
> >   CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3D5
> >   CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=3D5
> > +# CONFIG_CMD_BIND is not set
> >   CONFIG_CMD_CLK=3Dy
> >   CONFIG_CMD_FUSE=3Dy
> >   CONFIG_CMD_GPIO=3Dy
> > @@ -86,6 +88,10 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=3Dy
> >   CONFIG_CLK_COMPOSITE_CCF=3Dy
> >   CONFIG_SPL_CLK_IMX8MM=3Dy
> >   CONFIG_CLK_IMX8MM=3Dy
> > +CONFIG_USB_FUNCTION_FASTBOOT=3Dy
> > +CONFIG_FASTBOOT_BUF_ADDR=3D0x42800000
> > +CONFIG_FASTBOOT_BUF_SIZE=3D0x20000000
> > +CONFIG_FASTBOOT_UUU_SUPPORT=3Dy
> >   CONFIG_MXC_GPIO=3Dy
> >   CONFIG_DM_I2C=3Dy
> >   CONFIG_MISC=3Dy
> > @@ -116,7 +122,6 @@ CONFIG_FEC_MXC=3Dy
> >   CONFIG_MII=3Dy
> >   CONFIG_NVME_PCI=3Dy
> >   CONFIG_PCIE_DW_IMX=3Dy
> > -CONFIG_PHY=3Dy
> >   CONFIG_PHY_IMX8M_PCIE=3Dy
> >   CONFIG_PINCTRL=3Dy
> >   CONFIG_SPL_PINCTRL=3Dy
> > @@ -136,4 +141,15 @@ CONFIG_SYSRESET_PSCI=3Dy
> >   CONFIG_SYSRESET_WATCHDOG=3Dy
> >   CONFIG_DM_THERMAL=3Dy
> >   CONFIG_IMX_TMU=3Dy
> > +CONFIG_USB=3Dy
> > +CONFIG_SPL_USB_HOST=3Dy
> > +CONFIG_USB_EHCI_HCD=3Dy
> > +CONFIG_MXC_USB_OTG_HACTIVE=3Dy
> > +CONFIG_USB_GADGET=3Dy
> > +CONFIG_SPL_USB_GADGET=3Dy
> > +CONFIG_USB_GADGET_VENDOR_NUM=3D0x0525
> > +CONFIG_USB_GADGET_PRODUCT_NUM=3D0xa4a5
> > +CONFIG_CI_UDC=3Dy
> > +CONFIG_SDP_LOADADDR=3D0x40400000
> > +CONFIG_SPL_USB_SDP_SUPPORT=3Dy
> >   CONFIG_IMX_WATCHDOG=3Dy =20
>=20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ZDf35t3PWGBAUR3poKs5pFp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbDWFAACgkQAR8vZIA0
zr31TQf/VM8PUx4zg/yPJHAsklsPnz7H7dEV/RqlHoJ92sirMeJxvTQwOse1YHc0
VzEEv9f/vICghla1E8ScvmdbYcUejI1aOAso7wKCnSznl6r81ksd1H6ZcqCGarU1
HUQtpybonVO0O1BUBxdwjKx9C+cVFr8DpnT4Xsed9r53hLXCP6Im8hARxQhorNeZ
Lcapalv0l/6Vm6iDMGtLtbzFHy5AGdbcJYHtRAO9nPra5/9uLDII2JvA7mVkdOSe
XfBVOvpnBjwF+5UIhK6ng0Mrn9RgOqTRyqA2zZDL/p42F2XzTATg7RzwhzY9mPCL
NWV9gB5h1Z0ZcExvANxpypEhaAgmnA==
=bgmG
-----END PGP SIGNATURE-----

--Sig_/ZDf35t3PWGBAUR3poKs5pFp--
