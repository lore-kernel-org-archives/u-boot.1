Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE93D2A53C
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C14F88DA0;
	Wed, 16 Oct 2024 20:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PScUWdqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF3588D91; Wed, 16 Oct 2024 20:20:44 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5A7E88DD1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4603aced3a5so1187041cf.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729102840; x=1729707640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HvZttBRVJOc2cby1b1nKYJS1Ak2QtMvlBcpXQpzesZI=;
 b=PScUWdqtjITP846OnkJamkPL8dGHGVsUfRmYavpzx0zfrkDbmZnih5Fx93kJQ4g7Yf
 fRkH48j9fE9MnN6zQAhU+izJwxlMFYf7fQsIpi82gC0Kk/hncz7KoNur5+u0vrF6lrIG
 o4/V/t/tN5WhxrP3JvEOhmBBTjfr94TArcLCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729102840; x=1729707640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvZttBRVJOc2cby1b1nKYJS1Ak2QtMvlBcpXQpzesZI=;
 b=i/4QWW1TPlCqxfAEpLlA7SPGRzPrOkYVKtk10O2b6QFiI2gcay1x7aAHnpfQQYZ2mv
 Ki+4GCE5nQY9fAJZMiW6xcRs6AoXCyMVYgVUgwG25NVKmWESQTuPLJryUu4dccgvv4kL
 XBYWT3oZ7u/KRD4b0AFSJSGSbLH/Qp6oXeENSKuD/mAH+5tdvEXrFc1UP/4Kw8JHAVLP
 Lahi22kjaNVK2SKKg6rS5wFwoRQ+HXTERBoWOEEbZxPsYgnlh+V+NxDPHzVaW1bUkxlD
 LKaYgZKEcfq48nGrrUVKciALQiu3FvFe0i8EBTYvxdFcsSidteHR68Ix5r8taTGyhL1/
 klOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzhwRDUklPIcffa1aZrjGsJ4uJZKeLliDM16aPV9cfwP0VgEoSywJX8vJKFN2P03XoNaESvMk=@lists.denx.de
X-Gm-Message-State: AOJu0YwDcxFzVGUaGLP3RLhHww5upo0cVbTE2vB7bItmnqX/fjL9/5Zq
 Nod9BBr2dJihlxQ0xIx54PD0tdN8TXFGw3U/xQHACeh0Ymuhw+vVAI/BQp2mTac=
X-Google-Smtp-Source: AGHT+IEhy5b3WRdFRJ1vslHjTkcxkQxsQmNvVJwSg1agcGPjOk5AH85ZHxzSGDHbn3xLHKh8+pCFBg==
X-Received: by 2002:a05:622a:1a22:b0:460:94ab:859c with SMTP id
 d75a77b69052e-46094ab87femr28820521cf.5.1729102839686; 
 Wed, 16 Oct 2024 11:20:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607b0a68c0sm20210981cf.12.2024.10.16.11.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 11:20:38 -0700 (PDT)
Date: Wed, 16 Oct 2024 12:20:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH 13/17] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Message-ID: <20241016182035.GE4959@bill-the-cat>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <20241016-imx95-v1-13-f640c8f3bc1b@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jISF7WWpPLFqSfjN"
Content-Disposition: inline
In-Reply-To: <20241016-imx95-v1-13-f640c8f3bc1b@oss.nxp.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--jISF7WWpPLFqSfjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 03:18:06PM +0800, Alice Guo wrote:
> From: Alice Guo <alice.guo@nxp.com>
>=20
> i.MX95 only supports low power boot, which means A55 is kicked by M33.
> There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
> for i.MX95.
>=20
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm/mach-imx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 134e42028c3787d78e28af03d40c41a8b2b1981b..56577b9ade349740b6d98ab93=
3797d7072985de0 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -179,7 +179,7 @@ config DDRMC_VF610_CALIBRATION
>  	  the ddrmc_cr_setting on relevant board file.
> =20
>  config IMX8_ROMAPI
> -	def_bool y
> +	def_bool y if (!IMX95)
>  	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
> =20
>  config SPL_IMX_ROMAPI_LOADADDR

If we're going to add parens here, it should be:
depends on IMX8MN || IMX8MP || IMX8ULP || (IMX9 && !IMX95)

And if down the line there's more IMX9 exclusions, the i.MX9 family that
does use this needs it own symbol so it can be here just like how all of
the i.MX8 families are spelled out, thanks.

--=20
Tom

--jISF7WWpPLFqSfjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcQA+wACgkQFHw5/5Y0
tyx1FAwAqifqJartP+KdBkhnuHXQy14+UeBF0TmzvvudVz/M/VyUvUMx9NYqv66q
U0CXqvbwICTR0iXAFL7L275PzXe0QXiv6Huj79bip7pbcRHD0XqR6LcZJkvAq9RH
em7L5ZEDj4SYxbYHCDZdJDhKIF5kXKrRVx1ZBJG7t7yCipyVEfW5C3rt+0K8KG27
kea0DlNV+Kkg8Fiv6GHpaa59MOk6YEJ5aAfylsTnU86wPdJYo1UqfqvtnmkYU/V/
SDiWznc+6byaDv6FeLNiv2SO2Nvna5GgkJUWwxttC5YW2debIM9eYK2CY3SmWtcG
rura3b4P5QBt9hctEJHCilxtpAqIhXdbBH4VHWiZhNId6h7rIBjGpyYgd4LeRmlZ
2hwSsQpi5N1awaNU6Fuv4YYVjiXFAy1azDZbKpaNHNAFR22h3MeLjBY4FHX3bntE
6XR5PDlIuZckMxGWbpLa0ShELZMmXu0oj7G6bimUlfwFOMk+BvVmjKo5VaGaJhWI
aPpvfk0y
=9Z/Q
-----END PGP SIGNATURE-----

--jISF7WWpPLFqSfjN--
