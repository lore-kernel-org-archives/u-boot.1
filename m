Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F84C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E227A843E3;
	Thu,  7 Aug 2025 10:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF8B83C53; Thu,  7 Aug 2025 10:33:05 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E99843E3
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 10:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id E43011F00050
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 08:32:58 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 585EDB01279; Thu,  7 Aug 2025 08:32:57 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id CB356B01279;
 Thu,  7 Aug 2025 08:32:55 +0000 (UTC)
Date: Thu, 7 Aug 2025 10:32:53 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v2 06/11] sunxi: Add support for I2C1 on PB pins for the
 V3/V3s
Message-ID: <aJRktaxWjmVDEHpF@collins>
References: <20250805174827.3696191-1-paulk@sys-base.io>
 <20250805174827.3696191-7-paulk@sys-base.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vz/rhglIVHJ4i9+W"
Content-Disposition: inline
In-Reply-To: <20250805174827.3696191-7-paulk@sys-base.io>
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


--Vz/rhglIVHJ4i9+W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Tue 05 Aug 25, 19:48, Paul Kocialkowski a =C3=A9crit :
> From: Paul Kocialkowski <contact@paulk.fr>
>=20
> Both the V3 and V3s support I2C1 on PB pins, which is often used to
> connect an AXP209 PMIC on V3 boards.

Actually this appears to be wrong. I had this patch around for a while but
I was mistaken about the AXP209, which is typically connected to I2C0, not
I2C1.

So I think this patch could be dropped, it won't be directly useful for our
supported boards anyway.

All the best,

Paul

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  board/sunxi/board.c  | 4 ++++
>  include/sunxi_gpio.h | 1 +
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 6520636ffab5..72aa86cd752d 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -98,6 +98,10 @@ void i2c_init_board(void)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPH(16), SUN6I_GPH_TWI1);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPH(17), SUN6I_GPH_TWI1);
>  	clock_twi_onoff(1, 1);
> +#elif defined(CONFIG_MACH_SUN8I_V3_V3S)
> +	sunxi_gpio_set_cfgpin(SUNXI_GPB(8), SUN8I_V3S_GPB_TWI1);
> +	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_V3S_GPB_TWI1);
> +	clock_twi_onoff(1, 1);
>  #elif defined(CONFIG_MACH_SUN8I)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPH(4), SUN8I_GPH_TWI1);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPH(5), SUN8I_GPH_TWI1);
> diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
> index 12b54c8dda4d..e166b9758f44 100644
> --- a/include/sunxi_gpio.h
> +++ b/include/sunxi_gpio.h
> @@ -110,6 +110,7 @@ enum sunxi_gpio_number {
>  #define SUN4I_GPB_TWI1		2
>  #define SUN5I_GPB_TWI1		2
>  #define SUN8I_V3S_GPB_TWI0	2
> +#define SUN8I_V3S_GPB_TWI1	2
>  #define SUN4I_GPB_UART0		2
>  #define SUN5I_GPB_UART0		2
>  #define SUN8I_GPB_UART2		2
> --=20
> 2.49.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--Vz/rhglIVHJ4i9+W
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmiUZLUACgkQhP3B6o/u
lQxZtw//QHmK8dvNHp3ESMuplB2FyQcsxxJIkkgqB8YeUwaydqCM4+N5TEYrrcwE
QfVr/E1RMGD44H7iT0VYR4zFNXe+m2LqWMdfX6fA7dfyIQ//1tbzkLO0YGfCG+vR
I2hwX86oSMObYWXBuX1GsN+cBjEBs9TN0qmke8B8VXG3eRchU+9EjpN1fIR915Wp
fYSjPRs8iMGFE+/ZldKx/UT43wl2GHlYBz+eOe/fNxbYtlo4Q82oR2KVvAnP9ucH
/EuAjNtUvKCv7CKEoLvYjKvmUIwILLEGHxsJQ7YfhAAOSeFY2iHz0vW+9jft0dn8
uv35MuC32NcV5TXCwfykO/BDB4S8BfzMOOGOGoCentYgdOmXCRtDIBlEICNELa1V
mEAz7cbPy400cfcITOoM01LQEk3XJLsTc6xTH9+ct0DkfpIRaZiEzl9Qzmn3YuQV
jvIH0+gdtPGwEc6kg8uFp9pNLcEqtwNdbn2bhfd8AnGAa+kfm8IhfTBprsjBwc+6
PoBFP/x9zWm8QPHAObjoI3beWt4Eo3V8TW0sO7/oxrUiRJJOH+SKgGivWVt09zYc
SSzGMIzS2lRqkQRN20ly0qdiCo/3newQxGcUZvsWY5p0nqLCUDdyNaBVK79EbJWm
6pmHD/lQivsdelnJRBFek+uCEUxa8+JWeyOPoEKfwyZhyEf34B8=
=i493
-----END PGP SIGNATURE-----

--Vz/rhglIVHJ4i9+W--
