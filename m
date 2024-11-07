Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBD4D43358
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 12:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44A9E8926E;
	Thu,  7 Nov 2024 13:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15DFA8926A; Thu,  7 Nov 2024 13:30:20 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D8389229
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 13:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 134D41F0004D
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 12:30:15 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id ADF20A451B7; Thu,  7 Nov 2024 12:30:14 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id BEB45A451B0;
 Thu,  7 Nov 2024 12:30:13 +0000 (UTC)
Date: Thu, 7 Nov 2024 13:30:11 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next v2 4/4] rockchip: rk3399: move sysreset-gpio logic
 to TPL
Message-ID: <Zyyy08igQdwI1dp5@collins>
References: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
 <20241106-rk3399-sysreset-gpio-tpl-v2-4-22aa82189eb6@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qbBuOmx090JJSNPl"
Content-Disposition: inline
In-Reply-To: <20241106-rk3399-sysreset-gpio-tpl-v2-4-22aa82189eb6@cherry.de>
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


--qbBuOmx090JJSNPl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Wed 06 Nov 24, 12:29, Quentin Schulz a =C3=A9crit :
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> If TPL_GPIO and TPL_PINCTRL_ROCKCHIP are enabled and a sysreset-gpio is
> provided in the TPL Device Tree, this will trigger a system reset
> similar to what's currently been done in SPL whenever the RK3399 "warm"
> boots. Because there's currently only one user of sysreset-gpio logic,
> and TPL is enabled on that board, so let's migrate the logic and that
> board to do it in TPL.
>=20
> There are three reasons for moving this earlier:
> - faster boot time as we don't need to reach SPL to be able to reset the
>   system on a condition we know is already met in TPL,
> - have less code to be impacted by the issue this system reset works
>   around (that is, "unclean" SoC registers after a reboot),
> - less confusion around the reason for restarting. Indeed when done from
>   SPL, the following log can be observed:
>=20
> """
> U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
> Channel 0: DDR3, 666MHz
> BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D16 CS=3D1 Die BW=3D16 Size=3D2048MB
> Channel 1: DDR3, 666MHz
> BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D16 CS=3D1 Die BW=3D16 Size=3D2048MB
> 256B stride
> Trying to boot from BOOTROM
> Returning to boot ROM...
>=20
> U-Boot SPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45 =
+0100)
> Trying to boot from MMC2
>=20
> U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
> """
>=20
> possibly hinting at an issue within the SPL when loading the fitImage
> from MMC2 instead of the normal course of events (a system reset).
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks for keeping it only in TPL!

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

With just one small nit below:

> ---
>  arch/arm/mach-rockchip/rk3399/rk3399.c | 15 ++++++++++-----
>  configs/puma-rk3399_defconfig          |  3 +++
>  2 files changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockc=
hip/rk3399/rk3399.c
> index 7b6a822ed04b8151a5da147056dbf73ffdafd149..0c28241c603e343c5140322f2=
778678e95fa84fd 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -169,7 +169,8 @@ void board_debug_uart_init(void)
>  }
>  #endif
> =20
> -#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> +#if defined(CONFIG_XPL_BUILD)
> +#if defined(CONFIG_TPL_BUILD)
>  static void rk3399_force_power_on_reset(void)
>  {
>  	const struct rockchip_cru *cru =3D rockchip_get_cru();
> @@ -195,9 +196,9 @@ static void rk3399_force_power_on_reset(void)
>  	if (cru->glb_rst_st =3D=3D 0)
>  		return;
> =20
> -	if (!IS_ENABLED(CONFIG_SPL_GPIO)) {
> +	if (!IS_ENABLED(CONFIG_TPL_GPIO)) {
>  		debug("%s: trying to force a power-on reset but no GPIO "
> -		      "support in SPL!\n", __func__);
> +		      "support in TPL!\n", __func__);
>  		return;
>  	}
> =20
> @@ -218,6 +219,11 @@ static void rk3399_force_power_on_reset(void)
>  	dm_gpio_set_value(&sysreset_gpio, 1);
>  }
> =20
> +void tpl_board_init(void)
> +{
> +	rk3399_force_power_on_reset();
> +}
> +# else

No whitespace before "else" here.

>  void __weak led_setup(void)
>  {
>  }
> @@ -225,7 +231,6 @@ void __weak led_setup(void)
>  void spl_board_init(void)
>  {
>  	led_setup();
> -
> -	rk3399_force_power_on_reset();
>  }
>  #endif
> +#endif
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 67c0ee72c925cdd49066980b0fde4131c86a99a8..7a180b1413036234d83477377=
8f6c0f0a7e85380 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -30,6 +30,7 @@ CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_POWER=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_TPL=3Dy
> +CONFIG_TPL_GPIO=3Dy
>  # CONFIG_BOOTM_NETBSD is not set
>  # CONFIG_BOOTM_PLAN9 is not set
>  # CONFIG_BOOTM_RTEMS is not set
> @@ -78,6 +79,8 @@ CONFIG_ETH_DESIGNWARE=3Dy
>  CONFIG_GMAC_ROCKCHIP=3Dy
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
>  CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
> +CONFIG_TPL_PINCTRL=3Dy
> +CONFIG_TPL_PINCTRL_FULL=3Dy
>  CONFIG_DM_PMIC_FAN53555=3Dy
>  CONFIG_PMIC_RK8XX=3Dy
>  CONFIG_SPL_PMIC_RK8XX=3Dy
>=20
> --=20
> 2.47.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--qbBuOmx090JJSNPl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcsstMACgkQhP3B6o/u
lQxGCw/6A9pbtyJmiKmjmPvOcMK0WkcIYYtzxzsIYt+yyCg219m+0lgKnaMk7mAB
3DplgyJTSkm2UF4y/D4w73rd0IjKC34+q0a9Tu53qlxUdL2qwsazes1n88+NJPR0
Lxrk4G2x1BzhEYGd+CQsFsFyLD/V1gnQIK10hg+aj8qLhHaTNKKJkbXmIaSYzDmE
e2txMRJ4RiHTj9ER3nIcwAWo3hDUhSwVY56rxtX2ARa2gRWZsO9rZC05gWxvG4fC
HMWzI/4pmErDtn/gUItwAeHlaXDRtdyGSR/R7npzja2389DX6ka3kchDWVyoqa8H
dhrYHFkpIKRwfzb+VqxyfKoFvnxaGelnFBCIqFxCkF+bGamRvwqbCO0oCMR8uCe4
5ezfeqxhFg+PMzdYEMkhHbh5bP0s56tjYwogQD/cbMDTr0L9wNbfSlBe/WBZ4oPm
1UG+HjHZDnTQh709EI/qBChqVnXumEvMIZhYvI4EslaEZ1GeU/f72z6WLZPDKLed
KYDIxFgQa7mJbd8MXj02eDeSnNFvAI9PKE+c4aMlgO5fIyoN0KRKwDN8YiyxRocb
nyO/PdNOREaBH/NfS8d+DRmSktG9EkTmwhNTuSQ8SWmDRcKlK52hlMuSFJUZAL55
YrWIbhqi8Z8EMFVwgueaundtHrSV4Z5LWPRVvR8p4xkoD4mABCU=
=js0+
-----END PGP SIGNATURE-----

--qbBuOmx090JJSNPl--
