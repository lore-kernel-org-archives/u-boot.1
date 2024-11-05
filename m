Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70394D33A20
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 18:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2A10891C0;
	Tue,  5 Nov 2024 19:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B27C88A0A; Tue,  5 Nov 2024 19:40:38 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65325891C0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 19:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 025411F0004D
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:40:34 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 51DF2A44AF6; Tue,  5 Nov 2024 18:40:34 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 50132A44AEC;
 Tue,  5 Nov 2024 18:40:33 +0000 (UTC)
Date: Tue, 5 Nov 2024 19:40:30 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 5/5] rockchip: configs: puma-rk3399: do the system
 reset in TPL
Message-ID: <ZypmnjLPPZ9aC26c@collins>
References: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
 <20241105-rk3399-sysreset-gpio-tpl-v1-5-12caff07a4e4@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AoOHWfSgUji7zac5"
Content-Disposition: inline
In-Reply-To: <20241105-rk3399-sysreset-gpio-tpl-v1-5-12caff07a4e4@cherry.de>
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


--AoOHWfSgUji7zac5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Tue 05 Nov 24, 16:36, Quentin Schulz a =C3=A9crit :
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> RK3399 Puma can trigger a full system reset at runtime by toggling a
> GPIO. This is done whenever the system has NOT cold booted (i.e. from a
> power cycle). For RK3399 Puma, this is currently done in SPL but only
> because when this was implemented TPL wasn't used on RK3399 (or at least
> not Puma). Now that we have TPL on RK3399 (and Puma), it makes sense to
> trigger this reset as early as possible, so let's enable the drivers
> required in TPL (Rockchip GPIO and pinctrl).
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

Cheers,

Paul

> ---
>  configs/puma-rk3399_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>=20
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

--AoOHWfSgUji7zac5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcqZp4ACgkQhP3B6o/u
lQzOYw/7BD3D0acVd3G9gR0eJEaHDiomxjQDRUeBNwVoZSDAOrPAQXQ2CSrmG8qL
MOMp5IYchXMG0m0bGprIsI/UWfQZTGXMLhtEjPYjh9e+kcJmt2PiLuq2GgR7g/2O
Ahh02iJGDmgLbDLjNFiIG8MWt0arx3OAwdJt3pNFD1mr/Kc/HijIEqpj0BZOETG6
8YSh4qGEIHO8g+LvUFXC0UJQqD5fKALLNc9EYE2Ie2ylkpPclQUc4kzvbzugY4z8
dxlWANVqSdcwyEIr7FpVVKRxGfn/mx6Cb3ujRHzh2+RABEEIGP4e2tnAdCnNnl6Y
bQL6VgYpLa8zPMzYBqa1KPMX6o19OJp4WHQ1uMHE5bxVArPYbNvqN5FcapOQISS3
CqoOWQrUNIy/n1ca/vnHCpmAlipwu7NX0LjEkFDzWfPqSN2NgW2JA0CSIRzvLuIQ
n/4aviP/QzzTgz7gWxvdNURLvr9VV8VZmq8nD3o2TcKRifuHvb4o7s2skVgIZaf0
HaZ5QsTSUUDGWjvgGKRZDkAkRZhVwnXWoYD1/G/03LYSnkjRHspkBA0aWPx40sPF
nR9cEuETZjj+kS3YUHNupSRNAwGSFw1NP+uyn7maURgCa17X9/7vst7AGcVXj9Pa
8Gk5zMMgRqTOI8cuHueuGZRRgrUh2U7Kcul5m66WPcaTNRGtMc8=
=pNnT
-----END PGP SIGNATURE-----

--AoOHWfSgUji7zac5--
