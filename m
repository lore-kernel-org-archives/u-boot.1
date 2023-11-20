Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F740C2BB3F
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 15:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CADB087250;
	Mon, 20 Nov 2023 16:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZRzmsCJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F079B874FC; Mon, 20 Nov 2023 16:26:55 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D749D86C72
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 16:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5c8c8f731aaso27955657b3.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700494012; x=1701098812; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6pbGJtoYCHpgc88IhGYumigZMMzZRR0tsWBBPZNtvQQ=;
 b=ZRzmsCJ3ZOYoxtthvBO7BYK+CGMaCtfA/cK/uTgD7mdJRDLlQ2GK7C2D+eM/iV5oLP
 2wjDgTLv3qBVFi7/EBOZOA8Ob9ncrpVz9CxsrQ5zEssBm/Lrdm1rAtdS+p9zN0blt1So
 zdyE21jiDLpUlayvoDMpvn73lTgHPyzq9MaEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700494012; x=1701098812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pbGJtoYCHpgc88IhGYumigZMMzZRR0tsWBBPZNtvQQ=;
 b=sYRiAuvGeOdqTf+FtQ6Yv38I9ePyyu3TO3bVaxCpFhRV/IiMS+c7vcRFz1fO1QgDcB
 mxKxhvlG8ywhyAKkdEPSfEEOBzTBYOjI7az7sMtUzxZcmGx0+F2LAKkghNo/HcSefYCS
 csdzPAegwvTIW0w2FKKjRBwDRcEcMrzTzTWduc45sVx5LwJ46TGgtSjkwC2QOEYNhuO2
 zR5R3eTc1BNyI2fSsE4kiCiFbfPOhB5HxBy4F6eOnm8OIRMpSqT0LuhR+A2hEjohlA0U
 R/Q4WBm1UD19qixj0q8V44KIdGvj8O2FllQ8h9Q7k4Yji0Kj+H9Jhn+6Cq4+t1+JY2Jk
 YrxA==
X-Gm-Message-State: AOJu0YxlPTi1LYC7ggUBTeD8kOt+FEmexM1/xfLSYa9tYQphm4Ah4gX5
 B993Ah+VqBJbhY4RaEcvZcO9/g==
X-Google-Smtp-Source: AGHT+IE3y/PyKN6fhdW361N6pPQvCkKXYFtNzoTgC9Yutm8aTLjAJxzq9euPJio/1sKiYlP/tWk1Wg==
X-Received: by 2002:a05:690c:a11:b0:5cb:464c:ad23 with SMTP id
 cg17-20020a05690c0a1100b005cb464cad23mr450906ywb.42.1700494012530; 
 Mon, 20 Nov 2023 07:26:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6bdd-4a9c-acaa-1ce1.res6.spectrum.com.
 [2603:6081:7b00:6400:6bdd:4a9c:acaa:1ce1])
 by smtp.gmail.com with ESMTPSA id
 d184-20020a0df4c1000000b0057087e7691bsm2423449ywf.56.2023.11.20.07.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:26:51 -0800 (PST)
Date: Mon, 20 Nov 2023 10:26:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] configs: keystone2: Do not include hardware.h
Message-ID: <20231120152649.GI2513409@bill-the-cat>
References: <20231117223829.346652-1-afd@ti.com>
 <20231117223829.346652-2-afd@ti.com>
 <20231117224044.GD170968@bill-the-cat>
 <5fc3cee0-5b79-4cd2-a153-94b25c37e5f8@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PMsDkGqdEYiGGBWl"
Content-Disposition: inline
In-Reply-To: <5fc3cee0-5b79-4cd2-a153-94b25c37e5f8@ti.com>
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


--PMsDkGqdEYiGGBWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 08:49:32AM -0600, Andrew Davis wrote:
> On 11/17/23 4:40 PM, Tom Rini wrote:
> > On Fri, Nov 17, 2023 at 04:38:28PM -0600, Andrew Davis wrote:
> >=20
> > > This is a hacky way to have this file included in all source files th=
at
> > > include common.h, instead just include from the files that need it.
> > >=20
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > ---
> > >   drivers/memory/ti-aemif.c            | 1 +
> > >   drivers/soc/ti/keystone_serdes.c     | 1 +
> > >   include/configs/ti_armv7_keystone2.h | 1 -
> > >   3 files changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
> > > index c4bc88c1510..41325eb0f94 100644
> > > --- a/drivers/memory/ti-aemif.c
> > > +++ b/drivers/memory/ti-aemif.c
> > > @@ -7,6 +7,7 @@
> > >    */
> > >   #include <common.h>
> > > +#include <asm/arch/hardware.h>
> > >   #include <asm/ti-common/ti-aemif.h>
> > >   #define AEMIF_WAITCYCLE_CONFIG		(KS2_AEMIF_CNTRL_BASE + 0x4)
> > > diff --git a/drivers/soc/ti/keystone_serdes.c b/drivers/soc/ti/keysto=
ne_serdes.c
> > > index 2ece1a8f647..0e1bf8ff39d 100644
> > > --- a/drivers/soc/ti/keystone_serdes.c
> > > +++ b/drivers/soc/ti/keystone_serdes.c
> > > @@ -8,6 +8,7 @@
> > >   #include <errno.h>
> > >   #include <common.h>
> > > +#include <asm/io.h>
> > >   #include <asm/ti-common/keystone_serdes.h>
> > >   #include <linux/bitops.h>
> >=20
> > Is there going to be a follow-up to remove common.h from these files
> > then? Thanks.
>=20
> Yes I can take a look at that next.
>=20
> Wasn't there some automation around this? Dropping headers from common.h
> one at a time until it disappears IIRC.

Simon has posted a python tool he wrote that partially did this, but I
wasn't quite happy with the results at the time. It might work out
better now, or on top of the series I posted to remove it from include/

--=20
Tom

--PMsDkGqdEYiGGBWl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVberYACgkQFHw5/5Y0
tyzSPAv+OEqQKC7pnRDHvP100ONi282OLP7fkeCjnamKconY1/tD6zTbYdReFIAT
vjhyo4pSrbIc/zlewttunqkaGr2+hJDGgKR4TxjXbsH1ECj5sihqe22H6c3kOtoy
/sot7C03Ewrn7Q3yyGZu6opk5DJZpcFZKJn7+YqRAFGdqALi77N+scU8vg3MruXh
mkfOwwpZ3tUFo5fQ6fYrQlnqE9PxwkBFl7Y7S7MlLws0BLt1uS7Op6Fe70Uy6GWc
sDxrfx4IZCB6Gys1dQByksXZ4ClobmBErJkvKyy1HgJN5bsUuOwr9OV8XWDyBAON
sM17W4/ia1lXtYkNOLpTtjGJkj4skYYYLJyySf9lURFaVwcxEA18aXEyds8clO2S
2pyA4pVou42wJvc/IgfrZZWVOWhUddmICURHpoY9MI12pTFQCgOEO8STDrvCB6wg
H9I5gfApe2e3ukv6wKDHB2Y6FVbJG2T0zwdAHuVBX5jJdQ8tTzs6wn6+NErkrWXy
NmD4o0JG
=6jAU
-----END PGP SIGNATURE-----

--PMsDkGqdEYiGGBWl--
