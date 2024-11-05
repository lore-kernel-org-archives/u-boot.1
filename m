Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C08D3177E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 18:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD0688D29;
	Tue,  5 Nov 2024 19:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F215D88ED9; Tue,  5 Nov 2024 19:34:51 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ADAA88A0A
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 19:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 313CF1F0004D
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:34:47 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id D7061A44AE6; Tue,  5 Nov 2024 18:34:45 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 9C118A44ADB;
 Tue,  5 Nov 2024 18:34:44 +0000 (UTC)
Date: Tue, 5 Nov 2024 19:34:42 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 1/5] pinctrl: rockchip: allow to build for TPL
Message-ID: <ZyplQnbWjlLDRKgr@collins>
References: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
 <20241105-rk3399-sysreset-gpio-tpl-v1-1-12caff07a4e4@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MYS+CYmdwEn356fD"
Content-Disposition: inline
In-Reply-To: <20241105-rk3399-sysreset-gpio-tpl-v1-1-12caff07a4e4@cherry.de>
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


--MYS+CYmdwEn356fD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Tue 05 Nov 24, 16:36, Quentin Schulz a =C3=A9crit :
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> A later commit will make use of the pinctrl driver in TPL so let's add
> the ability to build the Rockchip pinctrl driver in TPL.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

Just a nit below in case you need to respin.

Cheers,

Paul

> ---
>  drivers/pinctrl/Kconfig          | 8 ++++++++
>  drivers/pinctrl/rockchip/Kconfig | 7 +++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index a1d53cfbdbed5ef1030fff04715e1436f167554b..cff7c3ef45b1c7c29017a4512=
d4970bce4bac26b 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -127,6 +127,14 @@ config SPL_PINCTRL_GENERIC
>  	  This option is an SPL-variant of the PINCTRL_GENERIC option.
>  	  See the help of PINCTRL_GENERIC for details.
> =20
> +config TPL_PINCTRL_GENERIC
> +	bool "Support generic pin controllers in TPL"
> +	depends on TPL_PINCTRL_FULL
> +	default y
> +	help
> +	  This option is an TPL-variant of the PINCTRL_GENERIC option.
> +	  See the help of PINCTRL_GENERIC for details.

Typo: "a TPL-variant".

>  config SPL_PINMUX
>  	bool "Support pin multiplexing controllers in SPL"
>  	depends on SPL_PINCTRL_GENERIC
> diff --git a/drivers/pinctrl/rockchip/Kconfig b/drivers/pinctrl/rockchip/=
Kconfig
> index dc4ba34ae5d581be76786fd05d679d26397fd467..6ad6b189715cee20f0e570d93=
b9b871e5acb99c3 100644
> --- a/drivers/pinctrl/rockchip/Kconfig
> +++ b/drivers/pinctrl/rockchip/Kconfig
> @@ -14,4 +14,11 @@ config SPL_PINCTRL_ROCKCHIP
>  	help
>  	  This option is an SPL-variant of the PINCTRL_ROCKCHIP option.
> =20
> +config TPL_PINCTRL_ROCKCHIP
> +	bool "Support Rockchip pin controllers in TPL"
> +	depends on ARCH_ROCKCHIP && TPL_PINCTRL_GENERIC
> +	default y
> +	help
> +	  This option is an TPL-variant of the PINCTRL_ROCKCHIP option.

Ditto.

> +
>  endif
>=20
> --=20
> 2.47.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--MYS+CYmdwEn356fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcqZUIACgkQhP3B6o/u
lQzsng//U30WIhvS9i29/HKqAUsFaK0gA/GgRWz6O1PlYMVlg6KOtZVGDApkdmLQ
tjqr3hL1Ox3Or5eC+rx8xh88CXEzXNN67frLlTFUjL7HgjQalz3v1hYyO6UDMvjt
Cx+lkae9VTc2iwr9OeFBuyGwuhMOSn6QTAKe3oaxgh7lXaXgF8hPZKnD1xEOTaGH
YJH3uHJKr70mC/KNH1wVPcVCiHS7Q6Iwg2nS9+Yv9JVNvJYux/Hy0CQRveZHzS14
fvGLJVtfqsR9ZNSHnhqisUnl3PFpimoJfVIwn7in9dBC2UERNABp+hqhHMxtQKh+
tGQoabxuR7g4snCTQCAToP2rhZfJ3qWfvEZK5TtFBxuZdwmH4GEmO/nCN4svfjJs
bWKq2EOiRiNE1FpLFWg1t4GBYIB2nWdfHUqIhUNyNCYS4mUnXWzQJuA1eAodrPca
ggaGdMBmzYRBnHqVbKKHN2usReCWZiUVPrTw71IVmFKsvFwrUErCp2cAx5gXgXKh
twwOwTUfY5ZoEyeyv7FZCWoSq8QUAq7aBm0kcbm1fpTphS15o+5UT0lKanw4/Gdh
JuF3z1JiSIQs3wUMWruWmeGuOYVUlNFBFYiqTdlEHeaeTuiGWWQPL45gyXCdNcHp
M0yDYyoQYUUD4JY7ZCGvZUQT8O9diqNdKNOp3X85k+je6KQE7p0=
=bbAi
-----END PGP SIGNATURE-----

--MYS+CYmdwEn356fD--
