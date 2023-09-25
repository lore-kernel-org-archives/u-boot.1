Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC83CE7A95
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC80C86C5D;
	Mon, 25 Sep 2023 17:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FxfDqPvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858FF86D44; Mon, 25 Sep 2023 17:21:32 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D3786ADA
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d868d8363e6so3485691276.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695655289; x=1696260089; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7J5xsYWpKn7X3+NtRwMwWbSSyQiHCNhcL/VDJd1F9VI=;
 b=FxfDqPviagLoS7LUMOTZ1j3kuPldRqxWFqSG9C+6zjbIaKOdcCjMJ8EYxFJR7YH4Ak
 5QY9Iw6DrWMVXbTV6ne+hLcGKwRi10E9MYnx39SgggKIQBK+IwQ6+bcZTZxMwZbXqnt3
 nF+yzZLHAG5I0C7QGuQwvl+WYF7v5YgKt4bGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695655289; x=1696260089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7J5xsYWpKn7X3+NtRwMwWbSSyQiHCNhcL/VDJd1F9VI=;
 b=orvMqvWCOGw8X2GkM9BAs9+NkJpdH/K5SZlRPkIwV2ce0COoh4RxP+5VpEo4CcCRyc
 izZuyNM0bBzZzAv7qSEuhc5aPI8Flq3j0PuokQAOMJjmbrX6jLy46i9bqsyJ6QkJJnC4
 x1qGD8AmKtjZiI+qmt0YUUeToafNQXeohHjmUzX3+JgexFTgFpW92Pdi42DeTTtG5pLh
 cN+Pzmq9cyshb1qNYZiIQoRuOVITQ8BhOv9lFsBHYkfFdoLIOS2hjgAOiAu9L21IBjan
 YFRKNrZeNCuCEOT1q6XjJPfh8YBzoutV0sazm1wFcRKkLJsqbksE3szHQHDSKqdTRDcf
 yJzw==
X-Gm-Message-State: AOJu0YxMD8XyLLdzO2Nb5c+OeRjHhugdFvl338jbXtcn10Pc2O1aZYhZ
 ex4s0fp6wu6lhSGLpKZQTd60ZA==
X-Google-Smtp-Source: AGHT+IFhJQfJhNT5a3AtVJAt6HvKjj9MsGSSryjAWsIj53OnaS+mBFY+udIEV5esKak99hahAvp/8g==
X-Received: by 2002:a25:4885:0:b0:d74:cdb:adb8 with SMTP id
 v127-20020a254885000000b00d740cdbadb8mr5682133yba.28.1695655288739; 
 Mon, 25 Sep 2023 08:21:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a255f07000000b00d86694cec9bsm1099806ybb.15.2023.09.25.08.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 08:21:28 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:21:26 -0400
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, patrick.delaunay@foss.st.com,
 sjoerd@collabora.com, u-boot@lists.denx.de, xypron.glpk@gmx.de,
 michal.simek@amd.com, Suman Anna <s-anna@ti.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH] lmb: remove overlapping region with next range
Message-ID: <20230925152126.GC305624@bill-the-cat>
References: <20230924111832.3741245-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bSHCx9uD31QZ8iLV"
Content-Disposition: inline
In-Reply-To: <20230924111832.3741245-1-u-kumar1@ti.com>
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


--bSHCx9uD31QZ8iLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 04:48:32PM +0530, Udit Kumar wrote:

> In case of new memory range to be added is coalesced
> with any already added non last lmb region.
>=20
> And there is possibility that, then region in which new memory
> range added is not adjacent to next region. But have some
> sections are overlapping.
>=20
> So along with adjacency check with next lmb region,
> check for overlap should be done.
>=20
> In case overlap  is found, adjust and merge these two lmb
> region into one.
>=20
> Reported-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

This is good!  I wonder if this addresses the issue that has caused
other platforms to need to set CONFIG_LMB_MAX_REGIONS=3D64 and I'm
wondering if any of the other maintainers I've cc'd here can drop back
to the default number of regions and then re-test their failure case?
Thanks!

> ---
> logs
> https://gist.github.com/uditkumarti/5d08c34442235ad270cfa863792ebcdc
> seqeunce : line 1 to 13
> without fix : line 96-100
> with fix : line 199-202
>=20
>  lib/lmb.c | 37 +++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/lmb.c b/lib/lmb.c
> index b2c233edb6..2580d01d90 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -74,6 +74,16 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys=
_size_t size1,
>  	return 0;
>  }
> =20
> +static long lmb_regions_overlap(struct lmb_region *rgn, unsigned long r1,
> +				unsigned long r2)
> +{
> +	phys_addr_t base1 =3D rgn->region[r1].base;
> +	phys_size_t size1 =3D rgn->region[r1].size;
> +	phys_addr_t base2 =3D rgn->region[r2].base;
> +	phys_size_t size2 =3D rgn->region[r2].size;
> +
> +	return lmb_addrs_overlap(base1, size1, base2, size2);
> +}
>  static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r=
1,
>  				 unsigned long r2)
>  {
> @@ -81,7 +91,6 @@ static long lmb_regions_adjacent(struct lmb_region *rgn=
, unsigned long r1,
>  	phys_size_t size1 =3D rgn->region[r1].size;
>  	phys_addr_t base2 =3D rgn->region[r2].base;
>  	phys_size_t size2 =3D rgn->region[r2].size;
> -
>  	return lmb_addrs_adjacent(base1, size1, base2, size2);
>  }
> =20
> @@ -105,6 +114,23 @@ static void lmb_coalesce_regions(struct lmb_region *=
rgn, unsigned long r1,
>  	lmb_remove_region(rgn, r2);
>  }
> =20
> +/*Assmptuon : base addr of region 1 < base addr of region 2*/
> +static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned lo=
ng r1,
> +				     unsigned long r2)
> +{
> +	phys_addr_t base1 =3D rgn->region[r1].base;
> +	phys_size_t size1 =3D rgn->region[r1].size;
> +	phys_addr_t base2 =3D rgn->region[r2].base;
> +	phys_size_t size2 =3D rgn->region[r2].size;
> +
> +	if (base1 + size1 > base2 + size2) {
> +		printf("This will not be a case any time\n");
> +		return;
> +	}
> +	rgn->region[r1].size =3D base2 + size2 - base1;
> +	lmb_remove_region(rgn, r2);
> +}
> +
>  void lmb_init(struct lmb *lmb)
>  {
>  #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> @@ -249,7 +275,6 @@ static long lmb_add_region_flags(struct lmb_region *r=
gn, phys_addr_t base,
>  		phys_size_t rgnflags =3D rgn->region[i].flags;
>  		phys_addr_t end =3D base + size - 1;
>  		phys_addr_t rgnend =3D rgnbase + rgnsize - 1;
> -
>  		if (rgnbase <=3D base && end <=3D rgnend) {
>  			if (flags =3D=3D rgnflags)
>  				/* Already have this region, so we're done */
> @@ -278,10 +303,14 @@ static long lmb_add_region_flags(struct lmb_region =
*rgn, phys_addr_t base,
>  		}
>  	}
> =20
> -	if ((i < rgn->cnt - 1) && lmb_regions_adjacent(rgn, i, i + 1)) {
> -		if (rgn->region[i].flags =3D=3D rgn->region[i + 1].flags) {
> +	if (i < rgn->cnt - 1 && rgn->region[i].flags =3D=3D rgn->region[i + 1].=
flags)  {
> +		if (lmb_regions_adjacent(rgn, i, i + 1)) {
>  			lmb_coalesce_regions(rgn, i, i + 1);
>  			coalesced++;
> +		} else if (lmb_regions_overlap(rgn, i, i + 1)) {
> +			/* fix overlapping area */
> +			lmb_fix_over_lap_regions(rgn, i, i + 1);
> +			coalesced++;
>  		}
>  	}
> =20
> --=20
> 2.34.1
>=20

--=20
Tom

--bSHCx9uD31QZ8iLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURpXUACgkQFHw5/5Y0
tyzzPQv/UjtLLKN1VkBZZrxoDoKJg3+OcLAfGb/mijtdsHB3aGTsTGm8W32eyggm
dVmjGMxcXpumyRg0bJ5jk5mSmEEDNsNwpf5XGXMF9/a1/elIhgIOG1DFbl1daJ8m
03juYUtrEBwXVuKfmZpP07joedtptaBnpmvnBWSCNCvRogbqzlOr+NwX9E0NChOc
X1HltE8oc+Eo4sLT5/7u2FVvnoSaZIWopvL0EprkpTFxULJEFf2T19zRz0PmonTk
KnF3cmsuaaJzMyaJuUXCzQ3I9mFnnBkaC2B2pUllCFKkTL9V/f0YXjehitv4H5Y8
HLUjDs2eGIhbfUHVQNH2H4WUlSn7nYS1bBz2IovZCbmRosJ1UAF6Bxv16qnFMUGn
ZoEYcYy6Yyre/cv68yKHc1+JWi6xKVJp1qyrjjgHJCIgjWUZFXfxihi3QFMt22tc
xhKujeS3xSYUthBEQ3DfCpnS2Xq2308MfIxilBpLREVLrUTHDAGUvruK8K1Qj4Rk
FiUnLGem
=UsyM
-----END PGP SIGNATURE-----

--bSHCx9uD31QZ8iLV--
