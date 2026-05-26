Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5A8CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 16:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A27168469F;
	Tue, 26 May 2026 18:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BIT+w57p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB0D846B4; Tue, 26 May 2026 18:17:55 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7870784659
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-43b70c501a7so2614737fac.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779812270; x=1780417070; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vPAp9XrxElnuFjj+mKwaLOyuZrIvrQ7oFSOEV2vtluI=;
 b=BIT+w57poltcEExQlFqav/KzO7BB2XULj3fi8qjccg+mQp4X1YpV0J0XtmFkMMTyOz
 SSsE4a+GCJRB6DTMuvc9lGI/FHNrTJtyX3AN5Om6pykCmCOFlozqdTOx7LyCecdJH5M2
 axCkeS3J7yXj1Ev/SO/soVa4GPodMiApUGtz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779812270; x=1780417070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPAp9XrxElnuFjj+mKwaLOyuZrIvrQ7oFSOEV2vtluI=;
 b=i8JtA/ZoYT+B6cQYhShqYLPMN6kH5HDJfcUM5kzdXNv9/FLr50Bw+LhX5Sdss391Cv
 4gfvMQImLxNO9s4mZ4AOl70UFZ1lXKI2QGtBDGnQce5VMDwcjLCFPVT1miJb6aoxFPe5
 s3lIVpwNQFgH3UoXSsqxChyN+0TIz/+rPsIrOhkT7jbmRplmcjsXKQaC7oJuSeMyHcyp
 /fLuEvwKq+zMtb6EvfgRBGqNygHQGOreh7f9rvdAB0ST36tK0w0RO5oTSaZKkDvheCn3
 2myaoPtHZNceRqlWiC8JgZ042O/40elpztXWVKBj2Fh57KOuuck8XG9HaNZ2cINTxvUj
 7K1A==
X-Gm-Message-State: AOJu0YyJ0Kky+M2FukmXAiJvIHWQ1o83/Q/OeEkD6nlX726k28b0cK84
 e/R3Z0cj+fJzUfCN1Djua2fh9RDWsob6jx2l7Fa2kpV160g3ak77Na3CB95DfJIehnM=
X-Gm-Gg: Acq92OGyves6wo8XEa3qXZwiq0UYlRrBCnvBmOc0Y8KxInfRSzJeqwofZqUg24P0fGQ
 rohMnlQPiNZ/9SVYArFvJZxS5zSi/hC2gI43FNglDlC+knK4h4xFHb3drR5avktW8xI7ejRiCBt
 N1DlG/yFgSY4XEsbnUjI2a9cLaduaOm7XfrERK3M1BIolaZPw1hrO4oO43JOIjDkyb5X7o2kP+o
 Oj/Feg9sYluHhETdQAkjAfvUyKYjenL8FA9PpPapHfgFP5yEMDxikI7+0rBEQbnPCabUGZBlXhT
 O9tdl0VF9S7qjyHJ+ChdoWCnfXnwnRjaoVu/mJqMQMLwFc+akZIXm7gPqQTu2LCVLLJdWh5mips
 dsroOgIm+x2G/VmF2/fWZocqbdaWEGx6AY21tZq5FKMTIgEuwOwfgTf09N65WoY9bhDEtik/b3k
 V+bID+kChbucoVqIjS7PGDNKYEXT7/lXo48izy+bfNeukMh02EVVl54g5T73e0TvbQz8+9ya67m
 IRibaxice76or/n2BEAzET5gSBb9LBaOIzT2lTVVuJKgWNnubly28tLpLb/Buvs2gk=
X-Received: by 2002:a05:6871:339f:b0:433:d14c:2416 with SMTP id
 586e51a60fabf-43b5aa375ecmr11495907fac.7.1779812270077; 
 Tue, 26 May 2026 09:17:50 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b63976d57sm13820809fac.9.2026.05.26.09.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 09:17:44 -0700 (PDT)
Date: Tue, 26 May 2026 10:17:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Siddarth Gore <gores@marvell.com>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marex@denx.de>, Richard Weinberger <richard@nod.at>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Adriana Nicolae <adriana@arista.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Javen Xu <javen_xu@realsil.com.cn>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Francois Berder <fberder@outlook.fr>
Subject: Re: [PATCH v1 1/1] treewide: prefer __func__ over __FUNCTION__ and
 __PRETTY_FUNCTION__
Message-ID: <20260526161741.GX1858239@bill-the-cat>
References: <20260526014144.3519-1-aristo.chen@canonical.com>
 <20260526014144.3519-2-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2FojF/pm5rsDePIX"
Content-Disposition: inline
In-Reply-To: <20260526014144.3519-2-aristo.chen@canonical.com>
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


--2FojF/pm5rsDePIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 01:41:40AM +0000, Aristo Chen wrote:

> __FUNCTION__ and __PRETTY_FUNCTION__ are gcc extensions that predate
> the C99 __func__ identifier. scripts/checkpatch.pl emits a warning
> for any new use of __FUNCTION__ and recommends __func__ instead. In
> C (unlike C++) __PRETTY_FUNCTION__ is identical to __func__ because
> C function names do not carry signature information, so the
> distinction has no behavioural effect here. The majority of the tree
> already uses __func__, but a handful of older files in arch/, board/,
> boot/, drivers/, examples/ and include/ still carry the gcc spellings
> (55 occurrences of __FUNCTION__ across 19 files plus one
> __PRETTY_FUNCTION__ in drivers/usb/musb-new/omap2430.c). Convert
> them all to the C99 form so the tree is consistent and new patches
> in these areas do not have to follow an outdated local style.
>=20
> Ten "Unnecessary ftrace-like logging - prefer using ftrace" warnings
> remain on the printf("%s\n", __func__) and dbg("%s\n", __func__)
> function-entry traces in drivers/net/rtl8169.c (behind DEBUG_RTL8169*
> preprocessor guards) and drivers/usb/host/ohci-hcd.c. checkpatch
> matches the literal "%s\n", __func__ shape regardless of the wrapper,
> so silencing those warnings would require changing the debug message
> text or removing the traces entirely.
>=20
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Thanks for doing the cleanup here!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--2FojF/pm5rsDePIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahXHpQAKCRAr4qD1Cr/k
CoEbAQC3I3zOJpqKQzitGI+4/ybXR5o1ZTwzPlTPxjheQ8E4ngEAsSZbONyDhioy
qCfIgIJpjFlALdzpdYnVIWlyuJh/1Ac=
=hQay
-----END PGP SIGNATURE-----

--2FojF/pm5rsDePIX--
