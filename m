Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC44C25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 19:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DD1883EA;
	Tue, 21 May 2024 21:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BfY8nRQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1648B883AF; Tue, 21 May 2024 21:24:01 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6B68836D
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 21:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-de607ab52f4so4093355276.2
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716319437; x=1716924237; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8ZArKD0+FAjux2aqPiw+XygZqO85Y5mf4fjNx+0jGkI=;
 b=BfY8nRQ3LjCXZkH+eYnciXrJ5Sq1EoO7xURNT6HPz+kObITYVlZ9yqymcUKgXJ0jQC
 NLZh/Uvc0DAwdiOZRcIfnoFU3XA0j4VCjqlRimUaplM05uigIyr95HmlUfBMGSFr4J/v
 jchOH4b9s2w4jq/bbFLI8xu5O/+Qh6bd/A/SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716319437; x=1716924237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZArKD0+FAjux2aqPiw+XygZqO85Y5mf4fjNx+0jGkI=;
 b=ql271TELqHYNxB2AlDi+BAx3O01GvqhjGNr5182LFc9AZdBtXuaLjKSNmbuzQs+v1t
 9KIIc96b4RouDFTx8d1vCmOx+ADD7qYcRDQJ7GbjB6rXqz/RAUa2wD66gzszOd0GDJ+W
 VCWIBya8Ddxs8NA/dt9ZEngbeinU3FmCBT04n80cExGPNTFw2uolpGGN9Kdn01HTYfm9
 FFqbPjLId3AV1FFJDwmPEaHRNVuNEDN+Qe6kJG8PoDHSCdiabaxNcSBzSxhHObnpmrBe
 4t08qzHPFEbWk98tqkJ/3Pt23q8bmj6TTHWt4YMDzVl2M39CLF8MZAt1fvKgwcL3+/hG
 l/iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW34FelX0dEzHnI9WJ87fndMkQkoi6/mZrgsdyP/bsioa5FdaxW1K/RN653rXZod/XeYtngJisNtlxBGHT6hhvZWqOYNg==
X-Gm-Message-State: AOJu0YwXh4mLD3VJd2jV/MKhMBwscv7fArENWlLNaFgVUZkPytq+Q8iP
 LpW+xSfCqcpFBGlX/BhyhQoqVP37h1lMO9Y16RKFzcut8Cjsps6TTxH2tUy1qh8=
X-Google-Smtp-Source: AGHT+IHanbU1Ta1FaB2XveP20YU+C5v0/MNztElz50yCvoEqGJ2oa459EcurZj8I9V8ICSF7exxarA==
X-Received: by 2002:a25:ab6f:0:b0:df4:dbb6:c128 with SMTP id
 3f1490d57ef6-df4e0a7a44dmr65006276.12.1716319437591; 
 Tue, 21 May 2024 12:23:57 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f185141sm125850456d6.30.2024.05.21.12.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 12:23:57 -0700 (PDT)
Date: Tue, 21 May 2024 13:23:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, vigneshr@ti.com, nm@ti.com,
 joe.hershberger@ni.com, m-chawdhry@ti.com, afd@ti.com,
 devarsht@ti.com, sjg@chromium.org, emanuele.ghidoli@toradex.com,
 matthias.schiffer@ew.tq-group.com, a-bhatia1@ti.com,
 vitor.soares@toradex.com, danishanwar@ti.com, bmeng.cn@gmail.com,
 mkorpershoek@baylibre.com, s-vadapalli@ti.com, u-boot@lists.denx.de,
 joao.goncalves@toradex.com, hnagalla@ti.com
Subject: Re: [PATCH 0/4] Adding support to load secure firmware for HS devices
Message-ID: <20240521192352.GE2568172@bill-the-cat>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
 <ZkyvvWotyQJQyz9k@smile.fi.intel.com>
 <37ba74bf-21ea-4551-8631-c07d8ff2c0ea@ti.com>
 <ZkzH2Sa4eGAxb2EB@smile.fi.intel.com>
 <20240521162145.GT2568172@bill-the-cat>
 <ZkzNa9TnTIixVnfJ@smile.fi.intel.com>
 <20240521164541.GY2568172@bill-the-cat>
 <ZkzehjK1AQ2tcPpw@smile.fi.intel.com>
 <20240521175247.GB2568172@bill-the-cat>
 <ZkzuF_DIklnGd70_@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2vT2vKfVj89aiYtM"
Content-Disposition: inline
In-Reply-To: <ZkzuF_DIklnGd70_@smile.fi.intel.com>
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


--2vT2vKfVj89aiYtM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 09:55:19PM +0300, Andy Shevchenko wrote:
> On Tue, May 21, 2024 at 11:52:47AM -0600, Tom Rini wrote:
> > On Tue, May 21, 2024 at 08:48:54PM +0300, Andy Shevchenko wrote:
> > > On Tue, May 21, 2024 at 10:45:41AM -0600, Tom Rini wrote:
> > > > On Tue, May 21, 2024 at 07:35:55PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, May 21, 2024 at 10:21:45AM -0600, Tom Rini wrote:
> > > > > > On Tue, May 21, 2024 at 07:12:09PM +0300, Andy Shevchenko wrote:
> > > > > > > On Tue, May 21, 2024 at 08:59:17PM +0530, Kumar, Udit wrote:
> > > > > > > > On 5/21/2024 7:59 PM, Andy Shevchenko wrote:
> > > > > > > > > On Tue, May 21, 2024 at 04:26:44PM +0530, Udit Kumar wrot=
e:
>=20
> ...
>=20
> > > > > > > > > Are you Cc'ing random people with this?
> > > > > > > > > Please don't do it.
> > > > > > > >=20
> > > > > > > > I used names names popped up while running get_maintainer.p=
l script of
> > > > > > > > u-boot
> > > > > > > >=20
> > > > > > > > your email id was there for patch-3 of this series
> > > > > > >=20
> > > > > > > Nice, the tool is broken. Please, work with the respective pe=
ople to fix a tool
> > > > > > > or to tune it to avoid such mistakes in the future.
> > > > > > >=20
> > > > > > > (Hint: I would first disable Git fallback completely)
> > > > > >=20
> > > > > > So you were cc'd thanks to:
> > > > > > commit 5e541a05f70296dbad07fc1f4e8678ad207bb476
> > > > > > Author: Simon Glass <sjg@chromium.org>
> > > > > > Date:   Sun Jul 30 21:01:45 2023 -0600
> > > > > >=20
> > > > > >     env: Use include/env for text-environment includes
> > > > > >    =20
> > > > > >     The 'environment' word is too long. We mostly use 'env' in =
U-Boot, so use
> > > > > >     that as the name of the include directory too.
> > > > > >    =20
> > > > > >     Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel=
=2Ecom> # Intel Edison
> > > > >=20
> > > > > Yeah, and it even explicitly stated what I reviewed from that cod=
e...
> > > > >=20
> > > > > >     Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > >=20
> > > > > > And, I'm sorry because there are other contributors who get ups=
et when git
> > > > > > fallback doesn't find them (because it also ages out after a ye=
ar).
> > > > > > In this case there's not even a "tweak the threshold" option si=
nce
> > > > > > there's only a single commit to the file so you're in 100% of t=
hem.
> > > > >=20
> > > > > Just an example of false positive by get_maintainer.pl :-(
> > > > > And a confirmation of what I said =E2=80=94 tool is broken.
> > > >=20
> > > > It's an imperfect tool, yes. A quick check shows that if you never =
want
> > > > to be cc'd from a git tag, you can add yourself to
> > > > .get_maintainer.ignore and you will still be matched for things you=
 have
> > > > an explicit MAINTAINER entry for.
> > >=20
> > > But this will kill me being a maintainer of U-Boot parts (regarding to
> > > a certain platform) which is not what I want.
> >=20
> > With a quick local test, no, it still reported you for edison stuff
> > since that's not where the ignore list comes in.
>=20
> I see. Still looking at the rate of false positives so far from U-Boot pr=
oject
> I don't see that a big hammer, like the proposed one, should be used. Bet=
ter to
> teach people on how to use/tune the tool, it will be helpful in a long-te=
rm.

Long term, it would be best if nearly everything had a real MAINTAINERS
entry. Short term, I don't know how to reconcile "I don't want to be
found via git history" with "Why wasn't I cc'd on a patch? Oh, because I
touched it more than a year ago? I don't like that!" in a way other
than:
- Encouraging people to add themselves to / expand existing MAINTAINERS
  entries.
- Add themselves to the ignore list if they don't want to be found for
  other contributions they made.

--=20
Tom

--2vT2vKfVj89aiYtM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZM9MEACgkQFHw5/5Y0
tyyGVgv7Brp+ADQj3L4ISDosUn1Z7vBrqM07n+nK3/GBWdQjJYlWCNw5rauAN/Xp
CtnWBA/xgJ79fG0OBO4NDwePIN3u79CGHK6NJLMa68vuoBYkZymvtpu1lnrs8CD9
hlOqX5SN0QoFhNqfrhFSt+OA6DZPUeaM7lCDVgNyUAfK2e2GBdgJEe24Hn2pMghp
PFItYXTbC2ENeJneAENPJDtRzZqVrUt9KQd9F4yGPh7RDMRiuqT3OgRHRO8lQ3Kk
Xylz5kJpauHsETsYYQ565vPI6ki7kNk1F28BQcImA3+M+mrGXbWvUONLana0lblO
V81d3l15m0UAQ2yp2nvsJs2X8g18XavR0i/AcPu2rBuohEDAuRdBbHvY1wvriZyn
hlz06GuiNSPkJt8fiDrrYGIriQVywbZvBsTxWwKTmCypOOtAh2H5bfiJJc6OZpU0
YbMnOK+3xoXDhKqptG/igO0SARqwe61sVMVLTcRM/yKPlofhBYlovK10ouHiFZuV
CGRWgb1F
=Exu0
-----END PGP SIGNATURE-----

--2vT2vKfVj89aiYtM--
