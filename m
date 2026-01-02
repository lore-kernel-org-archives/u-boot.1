Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709CCFA374B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 14:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF5184253;
	Fri,  2 Jan 2026 15:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KadlOKAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 632C984255; Fri,  2 Jan 2026 15:55:20 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F74B8424E
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 15:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c7503c73b4so6595447a34.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 06:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767365716; x=1767970516; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RUWDxmt4Ei/JOBa4yClbpFLlILePCjFQSPok5VVPiXk=;
 b=KadlOKAuqz+DIQEVwvdmnOfTvj2T5RaH9JwJyc5XQ5sNw6mWT5Hp1WqbMaSOiWhGI/
 WRQ2x5eGCYTqtNyXRARf6F9kQmAHqbKzAKsD1D889AC/6qYSY02lSY3y8GGZTQ0fOZZM
 /GbaKJzOh4QYCCZB6oqU30kYq6Tb2kXtihC08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767365716; x=1767970516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUWDxmt4Ei/JOBa4yClbpFLlILePCjFQSPok5VVPiXk=;
 b=YEhd8LHgX8UqNCABk6Xz5YEKTlSQNid8NgrSS6Ygxwzq8eIvNQI8w/Wlk3y3ErL6P6
 LF2Za+3xGtCxmBAli1L13royOQkKogXeZNPH01HIZN/TchlRAbi1TwAqAL/pLQ89ipEQ
 XirG4XFtPkL0G126/p81aW6tOqX8yHhTJ7XnN0N6hE4RaJ7rVF7uKs1SYVz9AM8zJN7A
 rOca2a4W62bFapwH2BApcwjJkIlaGo9+mL1AgXZHW5V6Ap0kVA3n/fMeWdFKf3L/b+Bb
 t1RYtDReG232OQuYQJPgsAa8otYqYTJNmHVAeF+NW2T3hXEoNt3z+K0M0pxwRr4YVWUL
 hJfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDdiSLjdNTnnA7fKvqtc/fndwnjYoxxNQfFVkBO+ESgpzmsw9jEkKFDz99+dCui/jcsRfdoNI=@lists.denx.de
X-Gm-Message-State: AOJu0YypmvCQK2u5t5kV7HiYrakSWrEJvzwN25hbeLTop3dVBxVYzRt4
 96YOIoQ0LEfVOyOx6zmWnQG7Dl07rn9as73VsoYL1tFyrigU+yR4VNiN9Up+DmdHCtE=
X-Gm-Gg: AY/fxX7y9Jj6m5vU11iKzcHN/gDoC/e2Js6L6SUtTdUNpoDmt9tcxM5qD+LOIi+YXgg
 rl5mgTiRqxJ4XRCrQY89XmSGEmUYGG/IK5xdHllmdIv0uVgErh4C3uMXu69hXAWXDf5NY/s+vb5
 mWdpH9yXy3e56ONYjlUqF4tTLjQ2Y1Absey4UW6Nx7kl3CU0OV0PZx+p9WplYvVIjFAOQxszD/9
 vYe9lSXJviJc01hukQm35ZxVUhw3EdZQqG+MnfuBlgOsV8epYcry/w3ikMzIp8swVyos9diK+kM
 4nqzkJN2tP0UFxNwLpL/ut//YMwKlrtSHb2wApVRBa2+B/oq6xsIzTBiV65AlNPGqoqQmuQTV/c
 dmDhgGiAD2/crVgxHNqMm7FqyMaoIuZLNOYcTmsxgoPBoylUecSrPxK8EaHadN7iGNyU1HlxjL2
 g1u4x3UTteqUz2aUzwGrtB/odsY0sdiKvIdUPCD2ecY2zWW0I6KSOjtsWn7IWHHZP1pFZrIeJz2
 mJf2v/8ppW96pFmjcpyZy/BFfuuo5I0ccRmAEA=
X-Google-Smtp-Source: AGHT+IHONAMd00V5eR4pvjEc7RPuGPwVPFVxhz9Z4/BlGHIyn0g3u3JlP6+EWT2nB+RVQ4/y6rcAYg==
X-Received: by 2002:a05:6830:91b:b0:743:8af2:1af7 with SMTP id
 46e09a7af769-7cc66a026fbmr22108579a34.23.1767365716095; 
 Fri, 02 Jan 2026 06:55:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9468sm27852114a34.28.2026.01.02.06.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 06:55:15 -0800 (PST)
Date: Fri, 2 Jan 2026 08:55:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, bb@ti.com, anshuld@ti.com, hnagalla@ti.com, jm@ti.com,
 nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 01/11] spl: Use FIT data address as fallback when
 'load' property is absent
Message-ID: <20260102145512.GC6124@bill-the-cat>
References: <20251231173621.1069988-1-b-padhi@ti.com>
 <20251231173621.1069988-2-b-padhi@ti.com>
 <20260102144710.GB6124@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IV8jd8HaYctWYL7n"
Content-Disposition: inline
In-Reply-To: <20260102144710.GB6124@bill-the-cat>
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


--IV8jd8HaYctWYL7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2026 at 08:47:10AM -0600, Tom Rini wrote:
> On Wed, Dec 31, 2025 at 11:06:11PM +0530, Beleswar Padhi wrote:
>=20
> > In cases where the 'load' property is not defined in a FIT image node,
> > fallback to using the data address returned by `fit_image_get_data()`.
> > This enables FIT images to omit the 'load' property during FIT creation.
> >=20
> > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> >=20
> > v3: Changelog:
> > 1. None
> >=20
> > Link to v2:
> > https://lore.kernel.org/all/20250506104202.16741-3-b-padhi@ti.com/
> >=20
> > v2: Changelog:
> > 1. New patch. Add support to load images without 'load' property.
> >=20
> >  common/spl/spl_fit.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > index a588d13eb40..c18c98b2959 100644
> > --- a/common/spl/spl_fit.c
> > +++ b/common/spl/spl_fit.c
> > @@ -803,6 +803,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_=
image,
> >  {
> >  	struct spl_image_info image_info;
> >  	struct spl_fit_info ctx;
> > +	const void *fit_image_loadaddr;
> > +	size_t fit_image_size;
> >  	int node =3D -1;
> >  	int ret;
> >  	int index =3D 0;
> > @@ -893,7 +895,19 @@ int spl_load_simple_fit(struct spl_image_info *spl=
_image,
> >  		if (firmware_node =3D=3D node)
> >  			continue;
> > =20
> > -		image_info.load_addr =3D 0;
> > +		/*
> > +		 * If the 'load' property is not present in the image node,
> > +		 * use the FIT image's data address as the fallback load
> > +		 * address. This allows flexibility in omitting the load address
> > +		 * during FIT creation time.
> > +		 */
> > +		ret =3D fit_image_get_data(ctx.fit, node,
> > +					 &fit_image_loadaddr, &fit_image_size);
> > +		if (ret < 0)
> > +			panic("Error accessing node =3D %d in FIT (%d)\n", node,
> > +			      ret);
> > +
> > +		image_info.load_addr =3D (ulong)fit_image_loadaddr;
> >  		ret =3D load_simple_fit(info, offset, &ctx, node, &image_info);
> >  		if (ret < 0 && ret !=3D -EBADSLT) {
> >  			printf("%s: can't load image loadables index %d (ret =3D %d)\n",
>=20
> What's the IH_TYPE here? Saying to use something in-place is not always
> safe.

Looking at the rest of the series, and then going back to v1 and:
https://lore.kernel.org/all/b6bc14fc-c823-4376-939f-2c0e6b120a2c@ti.com/
we're IH_TYPE_STANDALONE which *does* require a load address (see
boot/image-fit.c). You might need to look in to a new type or see if
another type is reasonable, that doesn't already expect a load address
set.

--=20
Tom

--IV8jd8HaYctWYL7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVfcUAAKCRAr4qD1Cr/k
CmB+AP9Iv1+IaaGpH5G5UqM0DsSGQKxVE0t2SVvewzMGCYoJaAEAm0vdoy41I+Q2
4F5hJU3FT3qYKbqqQygtSQgrIKhqOwA=
=LxXy
-----END PGP SIGNATURE-----

--IV8jd8HaYctWYL7n--
