Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C389FFF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 13:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F17D3846FD;
	Wed, 29 Apr 2026 15:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEFE84707; Wed, 29 Apr 2026 15:08:09 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820CF846FA
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 626201F8005A
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 13:08:04 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 95869B404A0; Wed, 29 Apr 2026 13:08:02 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id BC82BB4049D;
 Wed, 29 Apr 2026 13:08:00 +0000 (UTC)
Date: Wed, 29 Apr 2026 15:07:58 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/3] sunxi: spl: fix SPL_SUNXI_LED active low
 configuration
Message-ID: <afICrnsK3Frmp7Hp@shepard>
References: <20260429092828.3076719-1-andre.przywara@arm.com>
 <20260429092828.3076719-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l3/hIRm247/+OaIU"
Content-Disposition: inline
In-Reply-To: <20260429092828.3076719-2-andre.przywara@arm.com>
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


--l3/hIRm247/+OaIU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On Wed 29 Apr 26, 11:28, Andre Przywara wrote:
> The newly introduced Allwinner SPL LED "framework" defined a
> SPL_SUNXI_LED_STATUS_STATE Kconfig symbol, that was supposed to denote
> the active-low vs. active-high polarity of the LED. However this is
> a bool symbol, so it will simply vanish if not defined, and we cannot use
> it directly inside a C statement.
>=20
> Filter the symbol through the IS_ENABLED() macro, which will return 0 if
> the symbol is not defined, which is the intended value here.
>=20
> Since the STATUS_STATE name is a bit confusing, rename it to ACTIVE_HIGH
> on the way, because that is its real meaning. Also the LED_STATUS_BIT
> name for the GPIO number is similarly a remnant of the old status LED
> code, so rename it to LED_STATUS_GPIO as well.
>=20
> This fixes configuring LEDs with active-low polarity.
>
> Fixes: 256557dd9aae ("sunxi: remove usage of legacy LED API")
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Thanks for your work!

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

All the best,

Paul

> ---
>  arch/arm/mach-sunxi/Kconfig | 10 ++++++----
>  board/sunxi/board.c         |  4 ++--
>  configs/pinephone_defconfig |  3 +--
>  3 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 89f0e77bcdb..07d7ea2b7ad 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1245,15 +1245,17 @@ config SPL_SUNXI_LED_STATUS
> =20
>  if SPL_SUNXI_LED_STATUS
> =20
> -config SPL_SUNXI_LED_STATUS_BIT
> +config SPL_SUNXI_LED_STATUS_GPIO
>  	int "GPIO number for GPIO status LED"
>  	help
>  	  GPIO number for the GPIO controlling the GPIO status LED in SPL.
> =20
> -config SPL_SUNXI_LED_STATUS_STATE
> -	bool "GPIO status LED initial state is on"
> +config SPL_SUNXI_LED_STATUS_ACTIVE_HIGH
> +	bool "GPIO status LED is active high"
> +	default y
>  	help
> -	  Whether the initial state of the status LED in SPL must be on or off.
> +	  Whether the GPIO of the status LED must be set high or low to turn
> +	  the LED on.
> =20
>  endif # SPL_SUNXI_LED_STATUS
> =20
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index d7722d1858a..3d1afec7c66 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -563,8 +563,8 @@ static void sunxi_spl_store_dram_size(phys_addr_t dra=
m_size)
>  static void status_led_init(void)
>  {
>  #if CONFIG_IS_ENABLED(SUNXI_LED_STATUS)
> -	unsigned int state =3D CONFIG_SPL_SUNXI_LED_STATUS_STATE;
> -	unsigned int gpio =3D CONFIG_SPL_SUNXI_LED_STATUS_BIT;
> +	unsigned int state =3D IS_ENABLED(CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HI=
GH);
> +	unsigned int gpio =3D CONFIG_SPL_SUNXI_LED_STATUS_GPIO;
> =20
>  	gpio_request(gpio, "gpio_led");
>  	gpio_direction_output(gpio, state);
> diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> index ed7dbc1852b..3a4f4ec51cf 100644
> --- a/configs/pinephone_defconfig
> +++ b/configs/pinephone_defconfig
> @@ -9,8 +9,7 @@ CONFIG_DRAM_ZQ=3D3881949
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_PINEPHONE_DT_SELECTION=3Dy
>  CONFIG_SPL_SUNXI_LED_STATUS=3Dy
> -CONFIG_SPL_SUNXI_LED_STATUS_BIT=3D114
> -CONFIG_SPL_SUNXI_LED_STATUS_STATE=3Dy
> +CONFIG_SPL_SUNXI_LED_STATUS_GPIO=3D114
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CMD_PSTORE=3Dy
>  CONFIG_CMD_PSTORE_MEM_ADDR=3D0x61000000
> --=20
> 2.43.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--l3/hIRm247/+OaIU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmnyAq4ACgkQhP3B6o/u
lQweBw/9FExtC6hps+5dTSc7XP1GphCFA5ObGS/SHeBB6FX0e6x1owTrMo2tgo1t
Ecxeosenphxj4fxYmiV50f+7dgRz238ox3wHNq3QKXFpm0Gb8bLxEBFFG6YwiSwv
crIVfQtFIiQ5Ii5mipHRG3fsha/p30Og1XuhCVw6Wps/bLJx1HDj2PHlcwWLv8nH
4RWAgqDYv5LogStjo+j4GWPm2CHF6oCcNYYAs9cc3zJYGbLSjCDgQgx9E/DUM9lQ
FX/cBXqepZ/XoclFkmVugXl68MAK8lMGfCJpPFtqL6rGE/Cx8aAbJ2SclpolKna+
AAsZekQtmYT49HZT6F3ghR8ydx/9ZIJj1I8FZ5/aNSu94QFhnQ26lpPy0XiwPC78
TfxRaI7e4k0UPjbiBEva9SM3ZqW0cwA3yx+3dt7uUVUTdd59mo1IwjdSKNgYaHWM
R2m+qqswg3qzChrYd9qZ9HEUIm/9rxKGrT1saKCG4iEKHiQfP3CuGt32TwUK4sg7
7qlDO2EzDCf0mEAqEMUrHr/oKoxcu1fPGxqIM4iPS8gjHpxfQPF3IGKv7KsdfCHH
/ecNiG5BjO8DZshJOA4TH1ds+xkDHOHR0ojQNmUGhNB+agEaC7VX5uisvSslsnp8
zUJSsw8KST+Be7QaXJ3tNhADKvRS3O9yKNT4d9hTL0F2/awjGmg=
=JYf0
-----END PGP SIGNATURE-----

--l3/hIRm247/+OaIU--
