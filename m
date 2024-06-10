Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA051C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB3E8865D;
	Mon, 10 Jun 2024 18:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="opV/0YIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A48788641; Mon, 10 Jun 2024 18:56:03 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3240088653
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f96f7465a6so1211405a34.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718038560; x=1718643360; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qEN3ZaSGx0Cr/GYmuZbzj9KLwMM+Y3QyIVaPXqiyN5o=;
 b=opV/0YIanqMz3Xav+ADSaVCcFa4dFxbuNm1XtJEh2SZZVD3k6U1W87R3+w9WH9kKaX
 NyFfKPr16AgKqMaMwM4iXnXvW+dMhV7ePSURxtwVyGB/MrkD+s9scoy/di+zC1D/ciwt
 Sh9JeD1ZPtItVg6LIzpDNNm1mmPO6FxeBcOcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718038560; x=1718643360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEN3ZaSGx0Cr/GYmuZbzj9KLwMM+Y3QyIVaPXqiyN5o=;
 b=wgy/o1NrAV3m+AGjH7xTFMoKhksH2DDmZqva9p3tPXKlM0l9PZZmUg1Czsj8K42GzC
 k6w8G7rsg5mfB55qKh4b3e3ccCBsIa2B5YLRW9JurCrgMzg5Mh6/6TkcKHoyfoc3IHKv
 RSC4+O7v11rrKcWvvCu3MU4Pltl3EP+vEaLAx93T7Hb2sJlQLQ5in4MeXapIJonno7ed
 11wJXHrzByzFCNNxBRN8EMMHNxwOLdAFRO/UtDFhtOT67Nu05ivLac2SrJiyl3yy2ZEn
 JHgp/cV4eliQr9Nh+ZEs/MSY1u4SwZyuulMaYgx9ZlfDQh0L462FgplqdI8ZIbPSIMtD
 cyEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCDSZbNG8XS7qy6UQhryLJ/uoFDQ8qtyJ8h1YPjflDvKx1oNUhhApCvQXysoPFYAZvKok/9B4Bs4u8dZDIJI6Ia7FfOQ==
X-Gm-Message-State: AOJu0YzL7xY934Lqt8SCPFE5hdkLo18gE85hqMDTHwzuK35rjFXs6Frh
 Vhrg24IL/mXKtLEZAtP7wXCiC288/9pKlvUNtGtQZj/C8SLCDySAC/n78WoeCXU=
X-Google-Smtp-Source: AGHT+IFSfI/rVEuq//7si+t3hILUbvRAW3s9ZhdcvwSkWaSLVKrec8KdEnREt1ch7ea4NdqNllkf6Q==
X-Received: by 2002:a05:6830:1e29:b0:6f9:d2ce:7627 with SMTP id
 46e09a7af769-6f9e9693b85mr121894a34.3.1718038559746; 
 Mon, 10 Jun 2024 09:55:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f99dd99ac9sm671687a34.81.2024.06.10.09.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:55:59 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:55:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 03/31] lmb: make the lmb reservations persistent
Message-ID: <20240610165557.GS68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-4-sughosh.ganu@linaro.org>
 <ZmdtVFiA835wvFV3@hades>
 <990cff94-f908-4058-9e19-dea8e0a05429@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JmbWF3OUFaJzJaRZ"
Content-Disposition: inline
In-Reply-To: <990cff94-f908-4058-9e19-dea8e0a05429@gmx.de>
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


--JmbWF3OUFaJzJaRZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 01:23:49PM +0200, Heinrich Schuchardt wrote:
> On 1/1/70 01:00, Ilias Apalodimas wrote:
> > Hi Sughosh
> >=20
> > [...]
> >=20
> > >   #define LMB_ALLOC_ANYWHERE	0
> > >=20
> > > +#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > > +struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> > > +struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
> > > +#endif
> > > +
> > > +struct lmb lmb =3D {
> > > +#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > > +	.memory.max =3D CONFIG_LMB_MAX_REGIONS,
> > > +	.reserved.max =3D CONFIG_LMB_MAX_REGIONS,
> > > +#else
> > > +	.memory.max =3D CONFIG_LMB_MEMORY_REGIONS,
> > > +	.reserved.max =3D CONFIG_LMB_RESERVED_REGIONS,
> > > +	.memory.region =3D memory_regions,
> > > +	.reserved.region =3D reserved_regions,
> >=20
> > This is probably a good opportunity to look into why
> > CONFIG_LMB_MEMORY_REGIONS was introduced.  Since we are moving towards
> > static allocations, do we still need it? Or allocating the size dynamic=
ally
> > covers all our cases.
>=20
> Up to now we used static arrays for saving memory allocations in LMB:
>=20
> include/lmb.h:67:
> struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
>=20
> As the EFI sub-system can produce any number of non-coalescable memory
> regions we should use a linked list instead.

I think it's some historic flexibility that's I believe no longer really
relevant to how we use LMB today, let alone once this patch series is
complete. We should probably (I'm doing my size check thing now..) move
to just following Heinrich's suggestion.

--=20
Tom

--JmbWF3OUFaJzJaRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnMB0ACgkQFHw5/5Y0
tyymQgv/W/QnqN/fZRxJNpmwbqTOeMo02anNk1YFgkeTLATGOu+oEnEzsW2I2r5E
zsSiyTr2xVQ34vXaAbeLDgX/WfFJSQZ4KZXSuT/w6U1OJf1uPVlOTSPeN8fGCTUD
esp/LHAjWKQ3cf50OeKOrkLvT9qWiktSkY0sOV+UzBXPAS/gHg0Z7SUCwHgnHF8B
na3qq0MXeQHC1jYq3ixSxcbHacZNiov5OxCRHRx7EuSmyRZp+bYEdwPkkcRmDE/z
4xTTIqvkTSzpfMDRttVqxN7oE2caRIfyY0ToUJaSaK6dQWi7tQFqTOXcssi1zcI4
d06sC4fxXtFIlqvz6sJXN2JBzfEQPJDcexAM0+4+D4Bn/B53prTV8HxiywQ7J8MR
gWadzkpX8VmaGPFHZqMk7yCjoM+5BwXOqi3OFYwy7GMDHnIQLei6wasIm9EFYQsU
UFNPwQ9cbiEhPWqJBlhDnkTyLcUKVdBEYGNbHieumXQQ5IS0iwdBtZUfDQ27urji
kKDtwhhg
=70CO
-----END PGP SIGNATURE-----

--JmbWF3OUFaJzJaRZ--
