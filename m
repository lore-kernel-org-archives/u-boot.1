Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17475FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 13:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D8F84855;
	Wed, 29 Apr 2026 15:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 670EE84843; Wed, 29 Apr 2026 15:08:25 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E566484857
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 8583F1F8004F
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 13:08:21 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 76DD0B404A2; Wed, 29 Apr 2026 13:08:20 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 5AD55B4049D;
 Wed, 29 Apr 2026 13:08:19 +0000 (UTC)
Date: Wed, 29 Apr 2026 15:08:16 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/3] sunxi: configs: enable power LEDs on 32-bit boards
Message-ID: <afICwNHV2rY4sO5H@shepard>
References: <20260429092828.3076719-1-andre.przywara@arm.com>
 <20260429092828.3076719-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pmiThV5x9vjF8zfe"
Content-Disposition: inline
In-Reply-To: <20260429092828.3076719-3-andre.przywara@arm.com>
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


--pmiThV5x9vjF8zfe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On Wed 29 Apr 26, 11:28, Andre Przywara wrote:
> We recently gained a simple way to enable a power LED very early in the
> SPL boot, through simple Kconfig variables.
>=20
> Add those symbols to those boards' defconfigs where the DT indicates a
> default-on power LED. The number used is <port bank> * 32 + <pin no>,
> an active low setup means CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH must be
> undefined. Since its default is "high", we can skip the symbol in the
> defconfig in this case.
>=20
> This will light up the power LED very early in the (SPL) boot phase on
> those 32-bit boards.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

All the best,

Paul

> ---
>  configs/A13-OLinuXinoM_defconfig         | 2 ++
>  configs/Bananapi_M2_Ultra_defconfig      | 2 ++
>  configs/Bananapi_m2m_defconfig           | 3 +++
>  configs/Mele_A1000G_quad_defconfig       | 2 ++
>  configs/Mele_A1000_defconfig             | 2 ++
>  configs/Mele_M9_defconfig                | 2 ++
>  configs/bananapi_m1_plus_defconfig       | 2 ++
>  configs/bananapi_m2_berry_defconfig      | 2 ++
>  configs/bananapi_m2_zero_defconfig       | 3 +++
>  configs/beelink_x2_defconfig             | 2 ++
>  configs/icnova-a20-adb4006_defconfig     | 2 ++
>  configs/nanopi_duo2_defconfig            | 2 ++
>  configs/nanopi_neo_air_defconfig         | 2 ++
>  configs/orangepi_2_defconfig             | 2 ++
>  configs/orangepi_lite_defconfig          | 2 ++
>  configs/orangepi_one_defconfig           | 2 ++
>  configs/orangepi_pc_defconfig            | 2 ++
>  configs/orangepi_zero_defconfig          | 2 ++
>  configs/orangepi_zero_plus2_h3_defconfig | 2 ++
>  19 files changed, 40 insertions(+)
>=20
> diff --git a/configs/A13-OLinuXinoM_defconfig b/configs/A13-OLinuXinoM_de=
fconfig
> index f547635302f..6c5a1b33194 100644
> --- a/configs/A13-OLinuXinoM_defconfig
> +++ b/configs/A13-OLinuXinoM_defconfig
> @@ -10,6 +10,8 @@ CONFIG_VIDEO_VGA_VIA_LCD=3Dy
>  CONFIG_VIDEO_VGA_VIA_LCD_FORCE_SYNC_ACTIVE_HIGH=3Dy
>  CONFIG_VIDEO_LCD_POWER=3D"PB10"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D201
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SYS_I2C_MVTWSI=3Dy
>  CONFIG_SYS_I2C_SLAVE=3D0x7f
> diff --git a/configs/Bananapi_M2_Ultra_defconfig b/configs/Bananapi_M2_Ul=
tra_defconfig
> index 375b0063c1a..750868033be 100644
> --- a/configs/Bananapi_M2_Ultra_defconfig
> +++ b/configs/Bananapi_M2_Ultra_defconfig
> @@ -5,6 +5,8 @@ CONFIG_DRAM_CLK=3D576
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_R40=3Dy
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D244
>  # CONFIG_HAS_ARMV7_SECURE_BASE is not set
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> diff --git a/configs/Bananapi_m2m_defconfig b/configs/Bananapi_m2m_defcon=
fig
> index 0c20cce49ea..f75e3e09d03 100644
> --- a/configs/Bananapi_m2m_defconfig
> +++ b/configs/Bananapi_m2m_defconfig
> @@ -7,6 +7,9 @@ CONFIG_MACH_SUN8I_A33=3Dy
>  CONFIG_DRAM_ZQ=3D15291
>  CONFIG_DRAM_ODT_EN=3Dy
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D355
> +# CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/Mele_A1000G_quad_defconfig b/configs/Mele_A1000G_qua=
d_defconfig
> index 1f4739e0005..ee6c902970a 100644
> --- a/configs/Mele_A1000G_quad_defconfig
> +++ b/configs/Mele_A1000G_quad_defconfig
> @@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"sun6i-a31-mele-a1000g-quad"
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN6I=3Dy
>  CONFIG_DRAM_ZQ=3D120
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D237
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
> diff --git a/configs/Mele_A1000_defconfig b/configs/Mele_A1000_defconfig
> index 93e73ebe3f1..48679265650 100644
> --- a/configs/Mele_A1000_defconfig
> +++ b/configs/Mele_A1000_defconfig
> @@ -5,6 +5,8 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN4I=3Dy
>  CONFIG_VIDEO_VGA=3Dy
>  CONFIG_VIDEO_COMPOSITE=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D244
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/Mele_M9_defconfig b/configs/Mele_M9_defconfig
> index 9b1bb97eedd..293e00db1b0 100644
> --- a/configs/Mele_M9_defconfig
> +++ b/configs/Mele_M9_defconfig
> @@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"sun6i-a31-m9"
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN6I=3Dy
>  CONFIG_DRAM_ZQ=3D120
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D237
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
> diff --git a/configs/bananapi_m1_plus_defconfig b/configs/bananapi_m1_plu=
s_defconfig
> index 22b69aa88cb..14ecaf759b5 100644
> --- a/configs/bananapi_m1_plus_defconfig
> +++ b/configs/bananapi_m1_plus_defconfig
> @@ -6,6 +6,8 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN7I=3Dy
>  CONFIG_VIDEO_COMPOSITE=3Dy
>  CONFIG_GMAC_TX_DELAY=3D3
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D249
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/bananapi_m2_berry_defconfig b/configs/bananapi_m2_be=
rry_defconfig
> index b406d519684..b9975211362 100644
> --- a/configs/bananapi_m2_berry_defconfig
> +++ b/configs/bananapi_m2_berry_defconfig
> @@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"sun8i-v40-bananapi-m2-berry"
>  CONFIG_DRAM_CLK=3D576
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_R40=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D244
>  # CONFIG_HAS_ARMV7_SECURE_BASE is not set
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> diff --git a/configs/bananapi_m2_zero_defconfig b/configs/bananapi_m2_zer=
o_defconfig
> index 337bafecd47..5041802ea8c 100644
> --- a/configs/bananapi_m2_zero_defconfig
> +++ b/configs/bananapi_m2_zero_defconfig
> @@ -4,4 +4,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"sun8i-h2-plus-bananapi-m2-z=
ero"
>  CONFIG_DRAM_CLK=3D408
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D362
> +# CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> diff --git a/configs/beelink_x2_defconfig b/configs/beelink_x2_defconfig
> index 3b0be26f063..16a37da521d 100644
> --- a/configs/beelink_x2_defconfig
> +++ b/configs/beelink_x2_defconfig
> @@ -5,6 +5,8 @@ CONFIG_DRAM_CLK=3D567
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D362
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/icnova-a20-adb4006_defconfig b/configs/icnova-a20-ad=
b4006_defconfig
> index 507e330612e..dcb6457fe71 100644
> --- a/configs/icnova-a20-adb4006_defconfig
> +++ b/configs/icnova-a20-adb4006_defconfig
> @@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"sun7i-a20-icnova-a20-adb400=
6"
>  CONFIG_DRAM_CLK=3D384
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN7I=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D245
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/nanopi_duo2_defconfig b/configs/nanopi_duo2_defconfig
> index 41b5502d24e..9b0fbecff60 100644
> --- a/configs/nanopi_duo2_defconfig
> +++ b/configs/nanopi_duo2_defconfig
> @@ -5,6 +5,8 @@ CONFIG_DRAM_CLK=3D408
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
>  # CONFIG_VIDEO_DE2 is not set
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D362
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/nanopi_neo_air_defconfig b/configs/nanopi_neo_air_de=
fconfig
> index 3b8cbbfcdba..110bb1e864c 100644
> --- a/configs/nanopi_neo_air_defconfig
> +++ b/configs/nanopi_neo_air_defconfig
> @@ -5,6 +5,8 @@ CONFIG_DRAM_CLK=3D408
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
>  # CONFIG_VIDEO_DE2 is not set
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D362
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/orangepi_2_defconfig b/configs/orangepi_2_defconfig
> index 88433808538..43f3ab512f1 100644
> --- a/configs/orangepi_2_defconfig
> +++ b/configs/orangepi_2_defconfig
> @@ -5,6 +5,8 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"sun8i-h3-orangepi-2"
>  CONFIG_DRAM_CLK=3D672
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D362
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> diff --git a/configs/orangepi_lite_defconfig b/configs/orangepi_lite_defc=
onfig
> index ea1548f0fcd..499ffd8ace5 100644
> --- a/configs/orangepi_lite_defconfig
> +++ b/configs/orangepi_lite_defconfig
> @@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"sun8i-h3-orangepi-lite"
>  CONFIG_DRAM_CLK=3D672
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D362
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_OHCI_HCD=3Dy
> diff --git a/configs/orangepi_one_defconfig b/configs/orangepi_one_defcon=
fig
> index e4de13de26b..637eb41207e 100644
> --- a/configs/orangepi_one_defconfig
> +++ b/configs/orangepi_one_defconfig
> @@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"sun8i-h3-orangepi-one"
>  CONFIG_DRAM_CLK=3D672
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D362
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/orangepi_pc_defconfig b/configs/orangepi_pc_defconfig
> index f857d7fa203..01195b68621 100644
> --- a/configs/orangepi_pc_defconfig
> +++ b/configs/orangepi_pc_defconfig
> @@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"sun8i-h3-orangepi-pc"
>  CONFIG_DRAM_CLK=3D624
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D362
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> diff --git a/configs/orangepi_zero_defconfig b/configs/orangepi_zero_defc=
onfig
> index e128f5fcdb3..49a1f4d03da 100644
> --- a/configs/orangepi_zero_defconfig
> +++ b/configs/orangepi_zero_defconfig
> @@ -6,6 +6,8 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
>  # CONFIG_VIDEO_DE2 is not set
>  CONFIG_SPL_SPI_SUNXI=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D362
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_MTD=3Dy
> diff --git a/configs/orangepi_zero_plus2_h3_defconfig b/configs/orangepi_=
zero_plus2_h3_defconfig
> index caf515c7026..63335b404da 100644
> --- a/configs/orangepi_zero_plus2_h3_defconfig
> +++ b/configs/orangepi_zero_plus2_h3_defconfig
> @@ -6,6 +6,8 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
>  # CONFIG_DRAM_ODT_EN is not set
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
> +CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D362
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> --=20
> 2.43.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--pmiThV5x9vjF8zfe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmnyAsAACgkQhP3B6o/u
lQxduA//aQ6UvrsQxh2H5dKECR4524f6gLIsSrRRZDKbpZxMprHXEBxo3IrBvgW5
1FxPGNWhr1HLGMfhTmWYnuNkRpZ0lPaA7gep1B3JRkjEtQvPEA2YwFfQy7os2kx8
puVewRLm6Balni+hhrqnZdTGDqnDExOWDjERJkHIsR1Prz0VrhwjBA8miIRfUe5P
dkFNVOPRf8eD9UYu3qvaDidYCo+zuAofBesSOIjsjIlMUHyvwQtWSUGmpDW4qe4a
7fBdwAPSow8Os44LuBFvRP9WiRYNcbWFxSwPkvBkpe7/XnGNJ7ArI43q8FndSWei
+XILzIsNvdGu2ld6r/SQPzxCI9aFlJ57zFCrPbvppBr9y0dpYFo02t+dxP7fGV1S
2n+NagXUE49fCGiql6AJjspBYTbKeVvGm16W6EiuIEJx/Wm6VFSZVTbVIywTNOTB
4pNa6CfYw86CQcNgaL/UGgYokJP6q/7AO0F3wJDA+4q40II4ILypQbxMI9wbqTT+
P2Xrw80SUGPPFq6kS9fgPt1xILxwtYj+rSaMdL0ljQMvLsg92L9OgegLc3AFAQwI
Hulg+zeraVMveQQiWGz7jYsIRfxG5Wd+4EeVvYfgcIulTU4jRBM9K0VnOkS4Tcv9
xG6AV6oEpqZ8OCIJJa4bAwnb9N8YHPz3d7WseyH/Bf5L2v7luEc=
=3cCq
-----END PGP SIGNATURE-----

--pmiThV5x9vjF8zfe--
