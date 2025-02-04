Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D921CC02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 18:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EC6D805A1;
	Tue,  4 Feb 2025 19:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B9D806DC; Tue,  4 Feb 2025 19:20:41 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA9080562
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 19:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id A9CE41F00050
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:20:36 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 58F78AA3AB1; Tue,  4 Feb 2025 18:20:35 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id E8F6EAA37B1;
 Tue,  4 Feb 2025 18:20:33 +0000 (UTC)
Date: Tue, 4 Feb 2025 19:20:31 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: u-boot@lists.denx.de, Chen-Yu Tsai <wens@csie.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] rockchip: rk3399: grf: Fix enum typos for UART2
Message-ID: <Z6Jab9lFB_dp5hyb@collins>
References: <20250204172954.3364927-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="90xsElKNktZcmYoz"
Content-Disposition: inline
In-Reply-To: <20250204172954.3364927-1-wens@kernel.org>
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


--90xsElKNktZcmYoz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chen-Yu,

Le Wed 05 Feb 25, 01:29, Chen-Yu Tsai a =C3=A9crit :
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> In the GRF header file, some instances of UART2 pinmux are prefixed with
> "GRF_UART2DBG" while others have "GRF_UART2DGB".
>=20
> Since UART2 is the default console UART and used for debugging, it is
> more likely the name should be UART2DBG.
>=20
> Fix the ones that are wrong.
>=20
> Fixes: a2c08df3813b ("pinctrl: add driver for rk3399")
> Fixes: fa72de10452c ("rockchip: arm64: rk3399: move grf register definiti=
ons to grf_rk3399.h")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Good catch!

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

> ---
>=20
>  arch/arm/include/asm/arch-rockchip/grf_rk3399.h | 6 +++---
>  arch/arm/mach-rockchip/rk3399/rk3399.c          | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/arch-rockchip/grf_rk3399.h b/arch/arm/i=
nclude/asm/arch-rockchip/grf_rk3399.h
> index dd89cd205056..e6125d6bf540 100644
> --- a/arch/arm/include/asm/arch-rockchip/grf_rk3399.h
> +++ b/arch/arm/include/asm/arch-rockchip/grf_rk3399.h
> @@ -466,18 +466,18 @@ enum {
>  	/*  GRF_GPIO4C_IOMUX */
>  	GRF_GPIO4C0_SEL_SHIFT   =3D 0,
>  	GRF_GPIO4C0_SEL_MASK    =3D 3 << GRF_GPIO4C0_SEL_SHIFT,
> -	GRF_UART2DGBB_SIN       =3D 2,
> +	GRF_UART2DBGB_SIN       =3D 2,
>  	GRF_HDMII2C_SCL         =3D 3,
>  	GRF_GPIO4C1_SEL_SHIFT   =3D 2,
>  	GRF_GPIO4C1_SEL_MASK    =3D 3 << GRF_GPIO4C1_SEL_SHIFT,
> -	GRF_UART2DGBB_SOUT      =3D 2,
> +	GRF_UART2DBGB_SOUT      =3D 2,
>  	GRF_HDMII2C_SDA         =3D 3,
>  	GRF_GPIO4C2_SEL_SHIFT   =3D 4,
>  	GRF_GPIO4C2_SEL_MASK    =3D 3 << GRF_GPIO4C2_SEL_SHIFT,
>  	GRF_PWM_0               =3D 1,
>  	GRF_GPIO4C3_SEL_SHIFT   =3D 6,
>  	GRF_GPIO4C3_SEL_MASK    =3D 3 << GRF_GPIO4C3_SEL_SHIFT,
> -	GRF_UART2DGBC_SIN       =3D 1,
> +	GRF_UART2DBGC_SIN       =3D 1,
>  	GRF_GPIO4C4_SEL_SHIFT   =3D 8,
>  	GRF_GPIO4C4_SEL_MASK    =3D 3 << GRF_GPIO4C4_SEL_SHIFT,
>  	GRF_UART2DBGC_SOUT      =3D 1,
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockc=
hip/rk3399/rk3399.c
> index 1ce43c6f0d40..562d666ea092 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -136,7 +136,7 @@ void board_debug_uart_init(void)
>  	/* Enable early UART2 channel C on the RK3399 */
>  	rk_clrsetreg(&grf->gpio4c_iomux,
>  		     GRF_GPIO4C3_SEL_MASK,
> -		     GRF_UART2DGBC_SIN << GRF_GPIO4C3_SEL_SHIFT);
> +		     GRF_UART2DBGC_SIN << GRF_GPIO4C3_SEL_SHIFT);
>  	rk_clrsetreg(&grf->gpio4c_iomux,
>  		     GRF_GPIO4C4_SEL_MASK,
>  		     GRF_UART2DBGC_SOUT << GRF_GPIO4C4_SEL_SHIFT);
> --=20
> 2.39.5
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--90xsElKNktZcmYoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmeiWm8ACgkQhP3B6o/u
lQyDYQ//VxUL2pG+Y1iO82KVi0c1z4sU0R5FXkU87qp4BNAmjTnW3imooBGfcvZH
wP49nYhXLlFJ/vlJw063SvwJHEAU6OZiGjoByoFzmKKCRcyKPycmGZ3AJXG0NJ6F
zdiObeyFhF7eY9cTZh5Of5Wormn5AJMoSQY345e7x26bHobWBMCk5XWbU1tKa+hP
zI+lX75nAVQAY0myb/AKdJrdvjt+sFvUlTnDVXFDo38EjET1wM4AQ/2CHssFVuQe
Jc1wfZD7lrnBdTrdLGBJQtwKEXTd/qdP4sRkEFjAHQkOGw/0LAnQ/NN61DKiOipZ
AmaCn2p9uERtM1HHuEhyzfQXG9KZEEjjhjfubpbIdyidprjPFWnYARuqrqOXtBFE
QifTDCcwm0mjPqXe43rVxpsFE2nhc9xdB6GVYIi6mWOkAgXq4J/cinaxdSRXqG9z
Q+fSsXBrSXRts4XWgraP11Dt+2MltPbsCsof29/KbnktO0rrQqNvqf594+F5Mhzz
TNSKux6oMp9Fh7x7/rHdrMrkbVgselStDMQsWRPOynjgJVVjqECUnPSakR8qTCvr
SqhuH/vn0aWi4cYEA3XwfcilQuis3Actg0tJRYLBDEcM6wa0EaO0pxxjfF3q4kmK
eHIB49kMCG0a76ok1NZWhpKAHu/OvYzIMaK7w4hHQPdfWjJBdP0=
=7xkI
-----END PGP SIGNATURE-----

--90xsElKNktZcmYoz--
