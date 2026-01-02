Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F79FA3748
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 14:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69075841E6;
	Fri,  2 Jan 2026 15:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cS4uIdc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8179A84241; Fri,  2 Jan 2026 15:47:17 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19145839DF
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 15:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3ec96ee3dabso9574549fac.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 06:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767365234; x=1767970034; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LWTyDwghnQ2DVQu0fBrjY+3gyjPx5AGY2sCQ47Sbhg4=;
 b=cS4uIdc8aNq6BxJ5f3T8nY/Hdd4kMJsdfZOKgVuF3vWDxqdY23xbEP6Cbki2gE/NuH
 nUGWt//BWumQXlSGdRQgpA+PhXAWnTvTCunMQBMdfMYXuo5iP5qjMbk70Ml1hhv8e5Hg
 6Fm1xViyMZNrRY1oulfCOzBLby3eAQDGAoUvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767365234; x=1767970034;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWTyDwghnQ2DVQu0fBrjY+3gyjPx5AGY2sCQ47Sbhg4=;
 b=MVEvcCoa64WWCm9gcpZXzw7iJL4N2JJTVIxQpqe91ix5Fm6884pv3iz0I8Zrq1n816
 ci4JPgYBQoSligsdol6XF+dNWRwymCL33uJUZgyZ1HsAxUFQZUmxLrrT9+WXP8Jqj+1N
 4khEPu29p0yNa5/0Bma/qCkJ93c5pIDWI/K9w6VcffWcfk1wbBSSVHXvkSqkQQDpLuf7
 GOj/mwWRf7C/tKZHms1wMUy5TrHs/UtxSUHjs0irimOskAJAHf+YX2AvzZHjfh4DsO6k
 sIoD+PdzHf7PhU4/zOpz7Wc4wxQNxr3Fd2PmKZh+57HtLBJm8/FbWN9X400YAvbTcjQK
 E/qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQJzi4eAvf6GOwq1v3+x2LruEqHLMf0fe7UAK/YSqqrVYxMfQhQJCcLHFTi+3zJUyqwqzEQ88=@lists.denx.de
X-Gm-Message-State: AOJu0YzYusTOz5JCtIXo6SVVg2FyzFDN1DUyEzqHB2KyT/Tljpnpxklp
 nh+xSFLxbanIbRemo6CrYv/XbpKIVbwnME+xORc6eAH84oERRklpYahw10NjtTYBggw=
X-Gm-Gg: AY/fxX5jYlGTMxpb67VZxWIL1+okLGR7WHx5tJi2ODMyEs8qfH0GylqCgcyZF5VdpCq
 D3Fh839ZjFaxQSEi9+hyxLBCZF3QR2Qc7ZZ+xKOewEi6HxsiLBMBG+5CxwtqefaMlCmSZo7FYCG
 9LhN5Qv5XEfY+bAjnTxj1H0GGOfGLTewIVOb7CWiBj9xwOewdXoijU2ufntGEan3pAvCPBCkQBX
 Q4Ws8+UCfN88IBRu16szcdMeCJ3xkCME1RBTqd48Pg2J1AUERbkI+iXyy/J6Vt5VF+WkHT1BBys
 XQ4xWa1DqrZ7lHdGgR/nuXyUTNvIVbsIULfgfkb3jUOROv5G8x3yD2gFhmdbusl8u9pC8PkOnBC
 rGrXen4brE2LGZ9iwKFspWOCllcRV3+DnBBaFOfISScxHdfhKs6UKNGgK8j+iolzpksRU1y77+1
 zW9vw6ZBPkjlU6db4a+NE8WzN8rZnfUk3xZt3KM2jscbBzRNLCyjBXGPM6WYvGSMqo8m1xMAZvu
 NI52xs4E29uZzObYoeErRnPO0ChetaqXq35tBM=
X-Google-Smtp-Source: AGHT+IHxzDG3y35ok6PvS99WXtmV/qqdeg+GKzdsWid+UH1RYiy1JFTz89d3shcF9s405A+u/amr3w==
X-Received: by 2002:a05:6820:f029:b0:65c:f9c1:cb9f with SMTP id
 006d021491bc7-65d0ea9d732mr21278001eaf.34.1767365233777; 
 Fri, 02 Jan 2026 06:47:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f69ae7esm25345267eaf.9.2026.01.02.06.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 06:47:13 -0800 (PST)
Date: Fri, 2 Jan 2026 08:47:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, bb@ti.com, anshuld@ti.com, hnagalla@ti.com, jm@ti.com,
 nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 01/11] spl: Use FIT data address as fallback when
 'load' property is absent
Message-ID: <20260102144710.GB6124@bill-the-cat>
References: <20251231173621.1069988-1-b-padhi@ti.com>
 <20251231173621.1069988-2-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1t8jBBG+VWA4R3mw"
Content-Disposition: inline
In-Reply-To: <20251231173621.1069988-2-b-padhi@ti.com>
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


--1t8jBBG+VWA4R3mw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 11:06:11PM +0530, Beleswar Padhi wrote:

> In cases where the 'load' property is not defined in a FIT image node,
> fallback to using the data address returned by `fit_image_get_data()`.
> This enables FIT images to omit the 'load' property during FIT creation.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
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
> index a588d13eb40..c18c98b2959 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -803,6 +803,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_im=
age,
>  {
>  	struct spl_image_info image_info;
>  	struct spl_fit_info ctx;
> +	const void *fit_image_loadaddr;
> +	size_t fit_image_size;
>  	int node =3D -1;
>  	int ret;
>  	int index =3D 0;
> @@ -893,7 +895,19 @@ int spl_load_simple_fit(struct spl_image_info *spl_i=
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

What's the IH_TYPE here? Saying to use something in-place is not always
safe.

--=20
Tom

--1t8jBBG+VWA4R3mw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVfabgAKCRAr4qD1Cr/k
CgMdAQC2Xxjrte/iB2Rc6iFVlytampm9YVGhTHEnFgMpFLJtmwD/cG9f7TctuDJ+
IBV1V6/mrnGluIFzy3i8zLMjL8UjNgU=
=hR35
-----END PGP SIGNATURE-----

--1t8jBBG+VWA4R3mw--
