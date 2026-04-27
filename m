Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B346BFF8867
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 19:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BFD683693;
	Mon, 27 Apr 2026 21:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nNuwugIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F5E83693; Mon, 27 Apr 2026 21:54:12 +0200 (CEST)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40F8805D7
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-404254ffe8aso7700615fac.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777319648; x=1777924448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XGe08UAlctOb5cI6CBsBfT09qsUBGAMof0/tMiDLKAU=;
 b=nNuwugIcx1M7Mkhzl5PFEsgLwHbGjHxe9euj6SeLiWG5U3m+TJJQeHhyzQPIZ2wLba
 kRmxuTAretHnoDSWYgdG5oolKIDgYArLfbbqjFT8RW+zXULZXdgy4xy4hB6RT9m4f4q7
 sxxNrvH1JF2YOYp4MNfd88qtKGF2bdT5k7gqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777319648; x=1777924448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGe08UAlctOb5cI6CBsBfT09qsUBGAMof0/tMiDLKAU=;
 b=Zmvg75IFHb0eVt9wjxQiZEh+fiaYC5JgMMA7rGrDXWBR82uguPrS5E6xew74dyRtwK
 YBhMAD8mhn3jwVgoSGQDTHFTnDAKjvoDSpfTVEHoESO32qUorKiULSAWraIEqUIe+TUe
 7BNuK/aQjNsQtHbfoKezfkQBxtIEbwaaz1QrkvrP8JKOltOZFNYlQ+lE68Z0Z4VlwuKv
 D1uhTCISTApHgiv6GOEV5N0aHCP4A1QR17dk58sLjyiSC0TBStnpnCGCWwwnutM2FtJv
 JEyZVJ9fyUefJUD2RUq94USMS5tajOjvj9VY+YJewGvfuTBFs0FNObgaMMZ2aak/jbs5
 CcCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8etL6ki2xKlT0mRBNyZri6NEJ9zCkpjyo875w9YhOrx6imUn9uX0wzT06W2LML/JVHjF4ry2k=@lists.denx.de
X-Gm-Message-State: AOJu0YxEGNH4tFvgDhV9FtxXWtwJeQclVMSFgwwldJhB2uAM4LEsyQjz
 +hZxBJtkym9qbl3JwoXfTXQylnRjZWl9S+nTVsjN9TSJtu7OZane6MqMJWrxgvJc0CQOqszbi+Y
 5fCyLJEZGws4r
X-Gm-Gg: AeBDievtZDgHNMsHNfU/0votKjlDxrvrwfR0BMjoWKm/7cATge2kXAyTy30jPdnw4iJ
 y0Ob3rmC9YOD+UobCd8N92LdPxPaukyuKvZTEKxHKrxTl3UUT/8ogtohpMWu3nERgixfU2xnlT2
 r+cB0e0JXUAaPemUjB9/vUSZjrt1OovCxh9icC737owde7jeU0Ug2pOvboptlFC+KnyD+M665Ic
 HcpgjeIeTw4w9MvwTGiFlLnaqb2K488hnWT7c+8TwR+uKRyXeHgPi1T/wlgKDR27/lDIrTT1UKV
 EOdsRjaBYbcrw0KQswNFtSmwRDhCPhiCLn9bqj67C+I8alATYrBkptx32cIsZRnqEAyEKTQjehK
 Oy8FksLtLfkCDnPMUVxp1U9GNLq7d1/4MPHMKn1ywJu4YBMKPJf182DrI84Niaza1wtPXlzRHv5
 ThN5yKN+fuGAUCWVxZBYj9c9QIc84BLhtp34usKY2X8XhAwoHb0YmKrKjDCuUDSagmBlLikrgAI
 BQV2qs3yCswfZcvH4fCznbp9ZOJ5N+NAhPPwcrAAK23MMOk/nP5nGTG/MMxIQ==
X-Received: by 2002:a05:6870:2107:b0:424:801:49fe with SMTP id
 586e51a60fabf-433f1e430d0mr50908fac.8.1777319648576; 
 Mon, 27 Apr 2026 12:54:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-433effc0118sm223065fac.17.2026.04.27.12.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:54:07 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:54:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>, Simon Glass <sjg@chromium.org>
Cc: afd@ti.com, bb@ti.com, anshuld@ti.com, hnagalla@ti.com, jm@ti.com,
 nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4 01/11] spl: Use FIT data address as fallback when
 'load' property is absent
Message-ID: <20260427195405.GL41863@bill-the-cat>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-2-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/00clepF1yYtoyU5"
Content-Disposition: inline
In-Reply-To: <20260425033742.1519298-2-b-padhi@ti.com>
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


--/00clepF1yYtoyU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 09:07:32AM +0530, Beleswar Padhi wrote:
> In cases where the 'load' property is not defined in a FIT image node,
> fallback to using the data address returned by `fit_image_get_data()`.
> This enables FIT images to omit the 'load' property during FIT creation.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>=20
> v4: Changelog:
> 1. None
>=20
> Link to v3:
> https://lore.kernel.org/all/20251231173621.1069988-2-b-padhi@ti.com/
>=20
> v3: Changelog:
> 1. None
>=20
> Link to v2:
> https://lore.kernel.org/all/20250506104202.16741-3-b-padhi@ti.com/
>=20
> v2: Changelog:
> 1. New patch. Add support to load images without 'load' property.
>=20
>  common/spl/spl_fit.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 46ebcabe56a..87d01b8b8e6 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -799,6 +799,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_im=
age,
>  {
>  	struct spl_image_info image_info;
>  	struct spl_fit_info ctx;
> +	const void *fit_image_loadaddr;
> +	size_t fit_image_size;
>  	int node =3D -1;
>  	int ret;
>  	int index =3D 0;
> @@ -889,7 +891,19 @@ int spl_load_simple_fit(struct spl_image_info *spl_i=
mage,
>  		if (firmware_node =3D=3D node)
>  			continue;
> =20
> -		image_info.load_addr =3D 0;
> +		/*
> +		 * If the 'load' property is not present in the image node,
> +		 * use the FIT image's data address as the fallback load
> +		 * address. This allows flexibility in omitting the load address
> +		 * during FIT creation time.
> +		 */
> +		ret =3D fit_image_get_data(ctx.fit, node,
> +					 &fit_image_loadaddr, &fit_image_size);
> +		if (ret < 0)
> +			panic("Error accessing node =3D %d in FIT (%d)\n", node,
> +			      ret);
> +
> +		image_info.load_addr =3D (ulong)fit_image_loadaddr;
>  		ret =3D load_simple_fit(info, offset, &ctx, node, &image_info);
>  		if (ret < 0 && ret !=3D -EBADSLT) {
>  			printf("%s: can't load image loadables index %d (ret =3D %d)\n",

I guess the real question here is, does the spec allow this to be
omitted like that?

--=20
Tom

--/00clepF1yYtoyU5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCae++2gAKCRAr4qD1Cr/k
CrozAP9i1vBNw1xb96TfNIziktgwMh8MYgY4Vo8Sjdzqv60QgwEA4BZNI1iWnYAa
tfvfmA3pQEooC6Jwo4ANvwyCUcNuEAA=
=9Klz
-----END PGP SIGNATURE-----

--/00clepF1yYtoyU5--
