Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B131D3177E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 18:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BBEC88D29;
	Tue,  5 Nov 2024 19:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A55689099; Tue,  5 Nov 2024 19:37:05 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251D788A0A
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 19:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id AA80A1F0004F
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:36:59 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 55F1EA44AEC; Tue,  5 Nov 2024 18:36:56 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 1FEF3A44AE5;
 Tue,  5 Nov 2024 18:36:56 +0000 (UTC)
Date: Tue, 5 Nov 2024 19:36:53 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 2/5] rockchip: rk3399: merge CRU check within
 rk3399_force_power_on_reset
Message-ID: <ZyplxTZvoyd9r_v9@collins>
References: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
 <20241105-rk3399-sysreset-gpio-tpl-v1-2-12caff07a4e4@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xtk7vT6nN+phxUn+"
Content-Disposition: inline
In-Reply-To: <20241105-rk3399-sysreset-gpio-tpl-v1-2-12caff07a4e4@cherry.de>
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


--xtk7vT6nN+phxUn+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Tue 05 Nov 24, 16:36, Quentin Schulz a =C3=A9crit :
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> To prepare to support forcing power on reset from TPL which would have
> the exact same logic, just in an earlier stage, let's merge the CRU
> check that triggers the power on reset with the rest of the logic.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

Cheers,

Paul

> ---
>  arch/arm/mach-rockchip/rk3399/rk3399.c | 43 +++++++++++++++++-----------=
------
>  1 file changed, 21 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockc=
hip/rk3399/rk3399.c
> index edccb2a3980d0e3921aa4073b67aea6a00f18b8d..7b6a822ed04b8151a5da14705=
6dbf73ffdafd149 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -172,9 +172,29 @@ void board_debug_uart_init(void)
>  #if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
>  static void rk3399_force_power_on_reset(void)
>  {
> +	const struct rockchip_cru *cru =3D rockchip_get_cru();
>  	ofnode node;
>  	struct gpio_desc sysreset_gpio;
> =20
> +	/*
> +	 * The RK3399 resets only 'almost all logic' (see also in the
> +	 * TRM "3.9.4 Global software reset"), when issuing a software
> +	 * reset. This may cause issues during boot-up for some
> +	 * configurations of the application software stack.
> +	 *
> +	 * To work around this, we test whether the last reset reason
> +	 * was a power-on reset and (if not) issue an overtemp-reset to
> +	 * reset the entire module.
> +	 *
> +	 * While this was previously fixed by modifying the various
> +	 * places that could generate a software reset (e.g. U-Boot's
> +	 * sysreset driver, the ATF or Linux), we now have it here to
> +	 * ensure that we no longer have to track this through the
> +	 * various components.
> +	 */
> +	if (cru->glb_rst_st =3D=3D 0)
> +		return;
> +
>  	if (!IS_ENABLED(CONFIG_SPL_GPIO)) {
>  		debug("%s: trying to force a power-on reset but no GPIO "
>  		      "support in SPL!\n", __func__);
> @@ -206,27 +226,6 @@ void spl_board_init(void)
>  {
>  	led_setup();
> =20
> -	if (IS_ENABLED(CONFIG_SPL_GPIO)) {
> -		struct rockchip_cru *cru =3D rockchip_get_cru();
> -
> -		/*
> -		 * The RK3399 resets only 'almost all logic' (see also in the
> -		 * TRM "3.9.4 Global software reset"), when issuing a software
> -		 * reset. This may cause issues during boot-up for some
> -		 * configurations of the application software stack.
> -		 *
> -		 * To work around this, we test whether the last reset reason
> -		 * was a power-on reset and (if not) issue an overtemp-reset to
> -		 * reset the entire module.
> -		 *
> -		 * While this was previously fixed by modifying the various
> -		 * places that could generate a software reset (e.g. U-Boot's
> -		 * sysreset driver, the ATF or Linux), we now have it here to
> -		 * ensure that we no longer have to track this through the
> -		 * various components.
> -		 */
> -		if (cru->glb_rst_st !=3D 0)
> -			rk3399_force_power_on_reset();
> -	}
> +	rk3399_force_power_on_reset();
>  }
>  #endif
>=20
> --=20
> 2.47.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--xtk7vT6nN+phxUn+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcqZcUACgkQhP3B6o/u
lQzDRw/+MMRCscyMWkWULNhMa19pxVLyK6hCQr2pL7mJQOqT3OBjsI2fdxgkV1OR
E6d/z2+tQd/17NYcUuBxAW9pq1Por1I2Aq46bVLo4S8fSPdOXQftM/bSjsTA7MC3
vtu6dS9RUYy0ld9XGSK2Fsc8gYustSznWIDMzdi/Lm5eNJwlAEXDetK496YmeSHE
R0CvsvmiyNFxIzkN9Wu2kQhkCDDw3Hb87yjO0PAgtKF67c340niavwfN39x90F+Q
QbkaZ3+j0RVplMRpJjJL8NMIOxonY8XRR2iTexfODxvwAbHhnmGM6NVYGspgbdwW
2Sc8Revb/JxPyR00wARaZF8LEVAJCmOxo8cqXk2WPzCu5aPfkykVawxEfKM6gCFE
2QeKfq/Oi2nq3erw9lEPViFCSUBMRSYkE6cIx64zIrbqIoD+jOMoauU46n/xVkHU
LMC4RAorqp8yUc/h5u4EYITGHfbcf/lWu8YlDY+I3Kf84tO1TqBH4YdUVC0P/mOR
o2LuDkY2IJP8fpOLhM+tIXW27fzOxC/Pt1bgyQD971Zoo+/YpxhNQeygM961JPLP
8dCz47sNhQSYUqCpmITM9MbuP2f4QMzni6dx9CDjsztH0wL4UPgWSXq8aYVUu5Iw
FTp/z9VdVeovoPX3t0fgrrx808HjxZzZbRwM7VX8wYP8YYk19r8=
=oGje
-----END PGP SIGNATURE-----

--xtk7vT6nN+phxUn+--
