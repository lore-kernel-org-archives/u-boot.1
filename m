Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C8CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92F5B86B58;
	Mon, 25 Sep 2023 17:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aqgKa4+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B97486C06; Mon, 25 Sep 2023 17:13:46 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE6186ADA
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59c0d002081so80006707b3.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695654823; x=1696259623; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t4I5nuprwZKxjzk98u4ihpqEhN4arfxjski9csSW4DU=;
 b=aqgKa4+3Hmpwrw25kWhYgTsaFsWdV8vgPYQ0oR+J8xpblpxaNiWe8KpRNhjtmDhngc
 DHaVufW4nltewD+D60fvlni7UL3MRckiBwk0BHcM8LgRBENj6DMKNGO4A58IMHHAipHZ
 YA9c78itRTQgtOQnV7d3Hz4Zs89/JkpHLyGFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695654823; x=1696259623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4I5nuprwZKxjzk98u4ihpqEhN4arfxjski9csSW4DU=;
 b=K0csLCzLRbZXGNSGsbPHpwAs+Q8vtPMr1O3tBsiwcOANnpoIbB5mDL/HngVr4M0hNV
 chgUWQ1ZRPItIewNlChrFuz5ol6rGg4ywHV5VKIdsG6VZq+Z6tu1w8mrqEA5PRYOs0ku
 JMA1AZEA6uacX1LCGiWFFO4ioYR3Dxy0AbwSnfwEkeZRbh2pGhPYqFcfue1rLzmMuYuX
 DmoRJ+2a5RfOgTWgVgdWsjzmGaJqIDCe3dJAaTd56QLQsf9vkcrr3D7knZvLx3BInEsL
 waOOGXL3fwNnNZyL8NeLOjWRvvmZPnK9gNwjsXb58TZEuDLGb3em16T4WLeSBZ3PWWHf
 y78A==
X-Gm-Message-State: AOJu0Yz38f157w3ZiWjawaDrN7kwt7Cci3uJ37/ic9f7Nvrg4XZO7ThZ
 45Emesg7dF7+wmOBe5DRneIwDQ==
X-Google-Smtp-Source: AGHT+IHHi9NO9PEcJtBJ/Em7d+ZrPLCT47FTfXL1pO91UrvdsQJBHojM/1KxHic6fvBc2MC/7miivA==
X-Received: by 2002:a05:690c:360d:b0:59c:682:78e5 with SMTP id
 ft13-20020a05690c360d00b0059c068278e5mr6737087ywb.18.1695654822772; 
 Mon, 25 Sep 2023 08:13:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a0de504000000b0054bfc94a10dsm2454753ywe.47.2023.09.25.08.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 08:13:42 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:13:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] common: Remove a few more header files
Message-ID: <20230925151340.GB305624@bill-the-cat>
References: <20230925023958.1913268-1-sjg@chromium.org>
 <20230925140838.GV305624@bill-the-cat>
 <CAPnjgZ2gBRWt6v1i21Mq+bnqScnHYKATCURMtJ6E7DGspOdpnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zy+o5aPHmm5TUv0R"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2gBRWt6v1i21Mq+bnqScnHYKATCURMtJ6E7DGspOdpnw@mail.gmail.com>
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


--Zy+o5aPHmm5TUv0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 08:35:44AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 25 Sept 2023 at 08:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Sep 24, 2023 at 08:39:49PM -0600, Simon Glass wrote:
> >
> > > This series removes two more header files from the common.h header. It
> > > also tidies up code style for time.h functions, to simplify similar
> > > maintenance in future.
> > >
> > >
> > > Simon Glass (3):
> > >   Fix code style for time functions
> > >   common: Drop time.h from common header
> > >   common: Drop linux/string.h from common header
> > [snip]
> > >  1709 files changed, 1854 insertions(+), 34 deletions(-)
> >
> > This is where I start to get worried we're possibly taking the wrong
> > approach to the problem.  Perhaps it would be better to:
> > 1. Start finding headers which include <common.h>, remove and fixup the
> > breakage directly.
> > 2. Move on to removing <common.h> from files, a directory at a time.
> >
>=20
> The bigger question is whether you want common.h gone or not?

Yes, I'd like it gone.

> I shared my script with you so you can see what it is doing. But if a
> board uses memcmp(), for example, then it needs linux/string.h
> included. We can discuss why so many files use string functions, or
> whether the script is not perfect, but ultimately that is the
> question.
>=20
> Just these simple queries give you a sense of the scale:
>=20
>  git grep -l strcat |wc
>      45      45    1134
> git grep -l memcpy |wc
>     834     834   21643
>=20
> If you are suggesting that we add fewer includes for now, relying on
> transitive includes in header files, then I don't think that is very
> useful in the end. I had a series a few years back which removed
> common.h entirely and it foundered on this same issue.

The problem I see with the approach you're taking now is that it's quite
hard to provide meaningful review.  Looking at the time.h patch here, I
assume you agree it would be better to just remove=20
arch/arm/include/asm/arch-tegra/timer.h as it's just a single prototype
already found in include/time.h.  And the example where time.h was
included inside a comment block is a tooling issue.  But then looking at
the printk.h patch I did just apply, I had to drop a few files because
they introduced seemingly random changes to the resulting build on some
platforms.  And something like that is much easier to deal with and
explain _why_ it's happening if we're removing the header file by file,
rather than world-wide move-a-header.

--=20
Tom

--Zy+o5aPHmm5TUv0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURo6QACgkQFHw5/5Y0
tyxJ7gwAmEfACa74Z99AlGJcIdPB2tUi6eWazHzIgQoqgahKOiCQMXWpL32B/9Ms
OuStsSZaRZho7sDJuFq7GWBp3wTd73SVAhpHUciM2eCsRpf5VpPVNrswmvyXKVre
FadMqMrztGpMcdUd7bm4uqodqFZuOtvMhdK+KMy/u/jrnFE3W0+LZTr2umuJsipd
8i/VIvxn+h1HZQR09HOqdEd4a5MrEsB61j56FKc2ZiH/IENrH9HZSbnkCF8Z8LLP
LwPK1O8e2CYdlCxdQF+XvybaAWgRH0cxZRVIHtxXq8b0krcsdqN4PHGZE7fKuIaC
V+RUqBriwieMqz+r52cdcn4V0xt4yqu9zLoSRkLWJnDJd3kBybArBeinGzT42iqy
wjbqqrrNa4mgGv+0bbIwjbMuKHXzdCNAaJjwlDscI5c0piOuoHrK7MJVykVFLRR1
rZki5+cuHSFNwx6Oij5vQO7+ZttmRZzG/JtB1uJLEiPk5x3da8JEOaMYKcRRrNw8
4eg/9QKv
=q52K
-----END PGP SIGNATURE-----

--Zy+o5aPHmm5TUv0R--
