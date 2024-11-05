Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2694AD328DF
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 18:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A01A88D29;
	Tue,  5 Nov 2024 19:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E4388A0A; Tue,  5 Nov 2024 19:40:17 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3018A8919A
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 19:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 832631F0004B
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:40:13 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 12E9EA44AF5; Tue,  5 Nov 2024 18:40:12 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 0CE82A44AEE;
 Tue,  5 Nov 2024 18:40:11 +0000 (UTC)
Date: Tue, 5 Nov 2024 19:40:09 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 4/5] rockchip: rk3399: allow to handle sysreset-gpio
 in TPL
Message-ID: <ZypmiX2sOVxae-O2@collins>
References: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
 <20241105-rk3399-sysreset-gpio-tpl-v1-4-12caff07a4e4@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VgUrKh3qY8fbXC7e"
Content-Disposition: inline
In-Reply-To: <20241105-rk3399-sysreset-gpio-tpl-v1-4-12caff07a4e4@cherry.de>
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


--VgUrKh3qY8fbXC7e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Tue 05 Nov 24, 16:36, Quentin Schulz a =C3=A9crit :
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> If TPL_GPIO and TPL_PINCTRL_ROCKCHIP are enabled and a sysreset-gpio is
> provided in the TPL Device Tree, this will trigger a system reset
> similar to what's currently been done in SPL whenever the RK3399 "warm"
> boots.
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

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

See a nit below.

Cheers,

Paul

> ---
>  arch/arm/mach-rockchip/rk3399/rk3399.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockc=
hip/rk3399/rk3399.c
> index 7b6a822ed04b8151a5da147056dbf73ffdafd149..26fd04691699d81f5fecd2829=
64c7b3aff999717 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -169,7 +169,7 @@ void board_debug_uart_init(void)
>  }
>  #endif
> =20
> -#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> +#if defined(CONFIG_XPL_BUILD)
>  static void rk3399_force_power_on_reset(void)
>  {
>  	const struct rockchip_cru *cru =3D rockchip_get_cru();
> @@ -195,9 +195,9 @@ static void rk3399_force_power_on_reset(void)
>  	if (cru->glb_rst_st =3D=3D 0)
>  		return;
> =20
> -	if (!IS_ENABLED(CONFIG_SPL_GPIO)) {
> +	if (!CONFIG_IS_ENABLED(GPIO)) {
>  		debug("%s: trying to force a power-on reset but no GPIO "
> -		      "support in SPL!\n", __func__);
> +		      "support in " PHASE_NAME "!\n", __func__);
>  		return;
>  	}
> =20
> @@ -218,6 +218,7 @@ static void rk3399_force_power_on_reset(void)
>  	dm_gpio_set_value(&sysreset_gpio, 1);
>  }
> =20
> +# if !defined(CONFIG_TPL_BUILD)

Coding style in the file doesn't put a space after # (even when nested).

>  void __weak led_setup(void)
>  {
>  }
> @@ -228,4 +229,10 @@ void spl_board_init(void)
> =20
>  	rk3399_force_power_on_reset();
>  }
> -#endif
> +# else  // !defined(CONFIG_TPL_BUILD)

Ditto and also doesn't have such comments.

> +void tpl_board_init(void)
> +{
> +	rk3399_force_power_on_reset();
> +}
> +# endif // !defined(CONFIG_TPL_BUILD)

Ditto.

> +#endif // defined(CONFIG_XPL_BUILD)
>=20
> --=20
> 2.47.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--VgUrKh3qY8fbXC7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcqZokACgkQhP3B6o/u
lQxpBBAAmUA3OZRoduc4o0q9SmrN2HoXxG+hArbwVD1/OhjedoQf6r/+fDsxQy0H
WqzyYuO3lV9QMVSH15T5KzbRkb7+2CEYzPKWJqryemjZ+Tmt1DxgfP7acSbKwd3j
SMUGip9F7rTaxIhBy3FSQWvNOAt+o3Fzpl7OL0TdtuDwkVxp3YYpp0umzU41RnJq
f+Y+VIi7nYH0TVn/1ADbTrnIPgxzO2Lr3ru11lfvgxr+pN+2EWZWd+Z5UVyYaL0P
CLt9Ed73F4r9yK7P3Iba9A1R1Agcg4RGw9jfGNDsUzM9GMMCEwIZpzwYB8Eer14P
puLJMwZojWxd8iDp5WoI34RAdG+6YaVHrLdGZCHSDb+U3jSNE2uAFAuvHZtJXACZ
v/lrD/4/Qzi4MYhjyBM1VQze3k+Bt2oT1oJA2CSfTQA0FuOfERB2HfIPLsVF4iIF
W5xLQzvY5n5OipNEchcnJIM6JFPDlxPSZoEtIKKO/1Zlp2Swbkndk13KSscpg4gf
U+TLGpu7Rw4wnU1GYeBFHk5lOjHTKl/eKpkL7nrtDlOxduLYew+lGtk6/w2cd2ci
9eoYZQnd+rIxuPlxTg/J1VuT2b+BfFfpcbHnPgIASQD3Wv6KD1sMhOwc0SmGMywY
vYU8OiMeE5DOGjO35oC5BEDt5tpxRNt1+h1r30aRg1S5PjQwT/o=
=yMRL
-----END PGP SIGNATURE-----

--VgUrKh3qY8fbXC7e--
