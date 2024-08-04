Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D4CC3DA7F
	for <u-boot@archiver.kernel.org>; Sun,  4 Aug 2024 10:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38CC088815;
	Sun,  4 Aug 2024 12:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D795D88815; Sun,  4 Aug 2024 12:06:05 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC1888861
 for <u-boot@lists.denx.de>; Sun,  4 Aug 2024 12:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 094411F00047
 for <u-boot@lists.denx.de>; Sun,  4 Aug 2024 10:06:01 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 48F29A13B8C; Sun,  4 Aug 2024 10:06:00 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 9B2BCA13B85;
 Sun,  4 Aug 2024 10:05:59 +0000 (UTC)
Date: Sun, 4 Aug 2024 12:05:57 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Paul Kocialkowski <contact@paulk.fr>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 09/11] board: sniper: convert to DM_I2C
Message-ID: <Zq9ShR3cdTxbCpqQ@collins>
References: <20240803161513.486062-1-agust@denx.de>
 <20240803161513.486062-9-agust@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yPlMWqV70+JSUGXG"
Content-Disposition: inline
In-Reply-To: <20240803161513.486062-9-agust@denx.de>
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


--yPlMWqV70+JSUGXG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Sat 03 Aug 24, 18:15, Anatolij Gustschin a =C3=A9crit :
> Conversion to DM_I2C is mandatory, enable DM_I2C
> to disable board removal warning. Also enable
> OF_UPSTREAM since we do not have a default device
> tree.

Thanks for looking into this, but I already submitted a similar patch just
a few days ago, with additional cleanups!

See https://patchwork.ozlabs.org/project/uboot/patch/20240729204439.429900-=
3-paulk@sys-base.io/

Cheers,

Paul

> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> Cc: Paul Kocialkowski <contact@paulk.fr>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/mach-omap2/omap3/Kconfig | 1 +
>  configs/sniper_defconfig          | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap=
3/Kconfig
> index f15f44fe7d..b56e379ca1 100644
> --- a/arch/arm/mach-omap2/omap3/Kconfig
> +++ b/arch/arm/mach-omap2/omap3/Kconfig
> @@ -115,6 +115,7 @@ config TARGET_SNIPER
>  	select OMAP3_GPIO_5
>  	select OMAP3_GPIO_6
>  	imply CMD_DM
> +	imply OF_UPSTREAM
> =20
>  endchoice
> =20
> diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
> index 0243b15f31..29e783da8a 100644
> --- a/configs/sniper_defconfig
> +++ b/configs/sniper_defconfig
> @@ -7,6 +7,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x400
>  CONFIG_NR_DRAM_BANKS=3D2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
> +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/omap3-sniper"
>  CONFIG_SPL_TEXT_BASE=3D0x40200000
>  CONFIG_TARGET_SNIPER=3Dy
>  CONFIG_SPL_STACK=3D0x4020fffc
> @@ -32,12 +33,13 @@ CONFIG_CMD_GPIO=3Dy
>  CONFIG_CMD_I2C=3Dy
>  CONFIG_CMD_MMC=3Dy
>  # CONFIG_CMD_SETEXPR is not set
> +CONFIG_OF_CONTROL=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_SYS_I2C_LEGACY=3Dy
> +# CONFIG_TI_SYSC is not set
> +CONFIG_DM_I2C=3Dy
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
>  CONFIG_SYS_I2C_SPEED=3D400000
>  CONFIG_TWL4030_INPUT=3Dy
>  CONFIG_MMC_OMAP_HS=3Dy
>  CONFIG_CONS_INDEX=3D3
> -CONFIG_OF_LIBFDT=3Dy
> --=20
> 2.25.1
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expertise in multimedia, graphics and embedded hardware support with Linux.

--yPlMWqV70+JSUGXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmavUoUACgkQhP3B6o/u
lQzrTRAAkqIGFIjrsI9XLh+hf3YVBQwTMIAM+qVIyedYbdzKLnKV7w37EbBdnxKW
WtEHG8xmY2dA5h9HBo8xEvNRSAbMGHpqyaAlnpgBCHdRRE91ie9ycIPMd+QY6oaz
+TpFOi9z1Xe0a9gwymSkWyrjfegf/89MX/zXhIcPqwFoTW241fLRa4VSyONIfZuh
IUR3oIfWGSZ32grFSFjRf4/172jH/UR/mI8h47leShWdnpcxXPaViDtqetHobs/c
DmA31ApDaKdRpze5T8QqBwn7JTuikE8uxwMbv9d924ph8iuVW08rjcSiwIH02UMO
NRctbhfKdGPl+w9g8g7IK9ThpbIaM5NqsPZYTwqlyKYESJQtmdq2bM7hrgScUKLB
+rw3buxbYkLIiTsqG8rtZa8yzbdEnXVXHXyEiGzX1Gp7jEaSiBa6lN8cvR5PcSpV
8j6WMblJAvrkoZd1IIdVoCr9E34OlhdrjE0SP8Sm80mj1vV9CuIJdMB8x24K0SAB
nqjb/dPG44jaI6UqgdVHMfZs9vKTXJiiwY12fRM5+nijkW+mIQjNR7HIPCWgka2h
PPnSTghUQaxK7mON1RyWQSPMOSfcbigwGJPM8E0vPXzt8zHo0s4O3QD6OzL7Uk3X
4eZWhMaQP7YP9CAp06YUxYYhEBukbTQKykHZACgacnMN2Ql4GUc=
=APlU
-----END PGP SIGNATURE-----

--yPlMWqV70+JSUGXG--
