Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0711D33A28
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 18:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D625B891D1;
	Tue,  5 Nov 2024 19:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A4688ED9; Tue,  5 Nov 2024 19:44:42 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1BFD88A0A
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 19:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 332551F0004F
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:44:38 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 83D99A44AF8; Tue,  5 Nov 2024 18:44:35 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 84074A44AF0;
 Tue,  5 Nov 2024 18:44:34 +0000 (UTC)
Date: Tue, 5 Nov 2024 19:44:32 +0100
From: Paul Kocialkowski <contact@paulk.fr>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Paul Kocialkowski <paulk@sys-base.io>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 4/5] rockchip: rk3399: allow to handle sysreset-gpio
 in TPL
Message-ID: <ZypnkPnQd9L2L_uw@collins>
References: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
 <20241105-rk3399-sysreset-gpio-tpl-v1-4-12caff07a4e4@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q3WSI7IFB7TtzfQg"
Content-Disposition: inline
In-Reply-To: <20241105-rk3399-sysreset-gpio-tpl-v1-4-12caff07a4e4@cherry.de>
X-Mailman-Approved-At: Tue, 05 Nov 2024 19:45:54 +0100
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


--q3WSI7IFB7TtzfQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

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

Just one other thing here: you could as well remove the call in spl_board_i=
nit.
There's just one user of this currently (the Puma board) so I don't think we
need to keep backwards-compatibility in the SPL.

Cheers,

Paul

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
>  void __weak led_setup(void)
>  {
>  }
> @@ -228,4 +229,10 @@ void spl_board_init(void)
> =20
>  	rk3399_force_power_on_reset();
>  }
> -#endif
> +# else  // !defined(CONFIG_TPL_BUILD)
> +void tpl_board_init(void)
> +{
> +	rk3399_force_power_on_reset();
> +}
> +# endif // !defined(CONFIG_TPL_BUILD)
> +#endif // defined(CONFIG_XPL_BUILD)
>=20
> --=20
> 2.47.0
>=20

--=20
Paul Kocialkowski,

Free software developer - https://www.paulk.fr/
Independent contractor - sys-base - https://www.sys-base.io/

Contributor to fully free software support for selected hardware.

--q3WSI7IFB7TtzfQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcqZ5AACgkQhP3B6o/u
lQyC7w/9EvFANcvCsBsKPj08eT13+rCVTcbm2tqQGXUXkiHWcDMi9kuSF+36pff5
ZwD5rFF7doDnu7LbHMLAWNwr3BsCAV2+b+pBCkWnon1wMHHaCnSFw1Ve3yG/u6rW
UzKNJrKceWpyj2AsfJ9df8VZVdkONhrWPYLXJRUeLam2tbf4yP9Jw7wlu5PZeH5O
1b+7k+/4ERTMf7BMkgASEqiAjm+4wVwXfZ3UcARgV71yWLIobKMXWYmosU3NYgHk
+5ofoiE6e9bYN3Linoe5uxlQhaRRxkvY4u5Azacr6Zqy1h91Ve3X/I3zziaQZxTs
fvcR1KkFyk9PkioG+HBi3sePIEeNZ96uE2rYCF0d++x+sDbH9lV6ik663OJ+8Wbc
giGvGBXVwKkH4aqNnnfdZ1m8+T1YiLDM3Ru8AQ03h2dyRS3+1uizjCoPFphZF5t4
IjYxfZiMMOam71FezgDzJCBOVdLBoHMxtkXnMMzMUGSm08sOHoa6bTo4UCIbGFhe
xjdXHKJUB0eWdF/Kon8JnUbyYraLJygMaBk9d/QG56s6X3lNtx7GSiDtJJESDkxl
0T5V5irYs2birmeSBtguCl9ayGfwKKGWDC7rSds9RcLZSQBDU5DNLatBIiQlAKu/
fP3WFebYjh0ekCQSEojgHjbjFWE02tR+3kEw63VT4xWcNGQuV2s=
=30ph
-----END PGP SIGNATURE-----

--q3WSI7IFB7TtzfQg--
