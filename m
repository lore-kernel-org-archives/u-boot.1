Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69607D5B845
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 23:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFDC89058;
	Tue, 29 Oct 2024 00:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t2RADrXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230D4890E7; Tue, 29 Oct 2024 00:12:03 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96C2489043
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 00:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b14554468fso369646485a.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730157117; x=1730761917; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l+N0/H/jKGrnQrN1CroK6oF5hj6UmvW0HIEBi0mEv5U=;
 b=t2RADrXXAUUWLantxqezVrqic74C6ENbiKzw7V+SYu1bh+a1X+JiWHZs6l6UbfamzA
 yfGIy189rCm4G+de4ANK98qqa8W3LHGQ+uUFzF2TqksYYohVS6DkCrQKKQgwKWhnDU71
 514SSSWlc5dbkrWtjKA4iVO1IKwbMJNS/L6Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730157117; x=1730761917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+N0/H/jKGrnQrN1CroK6oF5hj6UmvW0HIEBi0mEv5U=;
 b=YJ3pviaAPCr10pbHBo+A9MW5tuqBPPiakaQdgPIj2f6E9dM27U+ODkdYv1KIwyl7l4
 3DZsMzzB0ftPJjUngi7cdIG+GFGwJQ0+OzTpYATeXTxl7x7sqVrxcqhCzh2YWSCzpDOF
 PE9CCNpD5aMrs0V0n7AvCUVqR7FxmdEo+JsLjyTv9wzmIm1fP4h3msMtbEhLxuE5wqpG
 1LytfOxAyi9jQZ5d2oYHT20jy/3Rdy3p/smvHocFk4CAt8g+GNhXw1xSRAALxrdQCRt5
 EcSVNegrnKThAeMy2zTnAo/Td01HBCN/HS0DdleMbVhU4tNY40VvPT+q4g713zKd3crw
 qXsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq3AVQD9OS4SY8pGJXddkMz6G1onmaxWKjX4o/zg8vmnV9RKhbVO8AdoDMrYyar3PmZ7BExH4=@lists.denx.de
X-Gm-Message-State: AOJu0YyGHwdHVJVVwjcmEnud//iPwvPgnYkEAoyHZg7i/AiIHWKAM5iq
 Da8SZPmZxb5mkoUG6dhfarjD5G9WQj+cnlvgaJzrt7skdJWpucF9b1HK1DTVkhc=
X-Google-Smtp-Source: AGHT+IGzXN+tp+hLq6tlHe+9ZQNrcZnU1jfnLsDXp+ejUq5epoZU7u3Hzqdk8LngyytECV6+iCBjbQ==
X-Received: by 2002:a05:620a:178d:b0:7ae:64a2:be61 with SMTP id
 af79cd13be357-7b193eff6a3mr1609027085a.36.1730157116942; 
 Mon, 28 Oct 2024 16:11:56 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d344bedsm362194185a.115.2024.10.28.16.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 16:11:55 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:11:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Janne Grunau <janne@jannau.net>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>, asahi@lists.linux.dev
Subject: Re: [PATCH v4 05/27] lmb: make LMB memory map persistent and global
Message-ID: <20241028231151.GV4959@bill-the-cat>
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-6-sughosh.ganu@linaro.org>
 <ZyAAJsnV4uz2Btwy@robin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xrpsQgvBZ8fO+3q/"
Content-Disposition: inline
In-Reply-To: <ZyAAJsnV4uz2Btwy@robin>
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


--xrpsQgvBZ8fO+3q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 10:20:38PM +0100, Janne Grunau wrote:
> On Mon, Aug 26, 2024 at 05:29:18PM +0530, Sughosh Ganu wrote:
> > The current LMB API's for allocating and reserving memory use a
> > per-caller based memory view. Memory allocated by a caller can then be
> > overwritten by another caller. Make these allocations and reservations
> > persistent using the alloced list data structure.
> >=20
> > Two alloced lists are declared -- one for the available(free) memory,
> > and one for the used memory. Once full, the list can then be extended
> > at runtime.
> >=20
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [sjg: Optimise the logic to add a region in lmb_add_region_flags()]
> > [sjg: Use a stack to store pointer of lmb struct when running lmb tests]
> > ---
> > Changes since V3:
> > * Fix checkpatch warnings of spaces between function name and
> >   open parantheses.
> > * s/uint64_t/u64 as suggested by checkpatch.
> > * Remove unneccessary parantheses in lmb.c as suggested by checkpatch.
> > * Fix alignment in test/cmd/bdinfo.c as suggested by checkpatch.
>=20
> [...]
> =20
> >  drivers/iommu/apple_dart.c           |   8 +-
>=20
> [...]
>=20
> > diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> > index 9327dea1e3..611ac7cd6d 100644
> > --- a/drivers/iommu/apple_dart.c
> > +++ b/drivers/iommu/apple_dart.c
> > @@ -70,7 +70,6 @@
> > =20
> >  struct apple_dart_priv {
> >  	void *base;
> > -	struct lmb lmb;
> >  	u64 *l1, *l2;
> >  	int bypass, shift;
> > =20
> > @@ -124,7 +123,7 @@ static dma_addr_t apple_dart_map(struct udevice *de=
v, void *addr, size_t size)
> >  	off =3D (phys_addr_t)addr - paddr;
> >  	psize =3D ALIGN(size + off, DART_PAGE_SIZE);
> > =20
> > -	dva =3D lmb_alloc(&priv->lmb, psize, DART_PAGE_SIZE);
> > +	dva =3D lmb_alloc(psize, DART_PAGE_SIZE);
> > =20
> >  	idx =3D dva / DART_PAGE_SIZE;
> >  	for (i =3D 0; i < psize / DART_PAGE_SIZE; i++) {
> > @@ -160,7 +159,7 @@ static void apple_dart_unmap(struct udevice *dev, d=
ma_addr_t addr, size_t size)
> >  			   (unsigned long)&priv->l2[idx + i]);
> >  	priv->flush_tlb(priv);
> > =20
> > -	lmb_free(&priv->lmb, dva, psize);
> > +	lmb_free(dva, psize);
> >  }
> > =20
> >  static struct iommu_ops apple_dart_ops =3D {
> > @@ -213,8 +212,7 @@ static int apple_dart_probe(struct udevice *dev)
> >  	priv->dvabase =3D DART_PAGE_SIZE;
> >  	priv->dvaend =3D SZ_4G - DART_PAGE_SIZE;
> > =20
> > -	lmb_init(&priv->lmb);
> > -	lmb_add(&priv->lmb, priv->dvabase, priv->dvaend - priv->dvabase);
> > +	lmb_add(priv->dvabase, priv->dvaend - priv->dvabase);
>=20
> no. This breaks everything. apple_dart is an iommu and used struct lmb
> to manage the IO virtual address space. This has nothing to do
> with system memory.
> Depending on the allocation strategy this will cause all sorts of
> problems since the IO and the physical memory address space does not
> overlap on apple silicon devices. IOVA is for many devices only 32-bit
> but physical memory starts at 0x10_0000_0000 or 0x100_0000_0000.
> Every device has its own iommu / IOVA space so sharing the space between
> all of them is another problem. I'd assume only theoretical due to the
> limited driver support and memory use in u-boot.
>=20
> My current plan to fix this is to resurrect the old lmb code under a
> different name.
>=20
> Not sure about the same change in sandbox_iommu but I guess it could be
> ok as there is no sandbox.

Oh damn, sorry. Perhaps it can be brought back in the iommu framework
more directly? I asked Caleb and they said snapdragon doesn't need
something like this.

--=20
Tom

--xrpsQgvBZ8fO+3q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcgGjMACgkQFHw5/5Y0
tywfjwv+J2FIGg7fOM2FX1HkVAYTAk6DuqX+s0/GjIE/Xiq7AbRy+qFKHZLS8xTK
13cQDgx65ad98dXwbb0J84OPkSAP0BHQYSCXwWGkbK8vG+NhL8vuz5Vpdd1AA2HG
+1OTixg9YnXLQOfrKpxOEbkfc/CZoX9I2wNTEQHg3yA/J/t4lhxMva3zCBdMPMy7
SHwuWO7Yl0Dgl5qT2HqHJx9OcUxa5rhDYWKhH6kAKNqkUv6UAKDOuEpwLygIodk0
mnIXti8o+sVJs0PeUrVap+QSeD+Oo+kjIxN7WYsd11qNdy316YtosaZObl42xUAZ
Hz4vN0mEG/du+niCcOqhYtXuJuZS3hjcoRe5xS926+MvMBNNqOyiDdZdQeOzOxk5
VWHjVGN2LDsXRYgzsqodVBMdo7Rt6U9/STN8lvZewqROaHkxzVUeYJe8VzBtp4VP
Qi/rw/CTSWm+kSw7cZKHDCkaSUyWbnfbVNlj+8AemUpfCWZ29SZnJCbwUcTqIVBm
OqpBWCuW
=w1BV
-----END PGP SIGNATURE-----

--xrpsQgvBZ8fO+3q/--
