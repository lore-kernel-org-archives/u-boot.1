Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B7CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA6E86B2E;
	Mon, 25 Sep 2023 16:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SSFN1n4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BD486BAE; Mon, 25 Sep 2023 16:08:44 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3025869BC
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59f630612a4so38530217b3.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695650920; x=1696255720; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ubPHeOzgHAEnUKcxC1DehVTEDN2dVsOomP/YBZNV6uA=;
 b=SSFN1n4fg5mTZyMfZRoeslvMO71UL9QFHNaGVDrwoMr7u8ZRk14iOPZeS5NTP8KVmp
 E+RHYQs+VUjmDviYV5nBvFG+JGEZ9mkKgms7JO/yjeIXJlkzUiqb/R6hwbuPeHiUD0g6
 ljwZtRD74k09HgghFmuzXHWiM/WHlKv7vVj2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695650920; x=1696255720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubPHeOzgHAEnUKcxC1DehVTEDN2dVsOomP/YBZNV6uA=;
 b=Lhf4BJLp+T8QEBztUPcJgSTRRgqX53DsKkwgY3UBLbtdB0glh90KSj6jeA9A8l7y/h
 L0r6aCyvueUdn+4xhPor6WqRwgznaJWGPWHQKZPsUpjj/U5/OGlAPc/s/7VMdpR0Zx9Q
 MOILT0tDajgyS8NbPzcWGMoxjqD0oTBGra5ealjGcHD3thHTR1qHCZaz81qln+TRCWx/
 0pdDpVAsNnohyH9KLcsZYGx/dh7L+acPfo5qHLu2cWyAYwQv0/aTWrpXcEVeWcMzeB6e
 dKCLaIJk8osMnMXF8AoJYhNnc3G2lkj66ziG9OtrfGDDnteIsqztqlz2stxNJyMWgfmv
 s57Q==
X-Gm-Message-State: AOJu0Yz4EW5o4KOKBuf8+A8ta73vDzGHajLXpj6DGm0QCYbrGBYG150o
 PO/a9rzulLI/CkhT8OzFwhTvQjIn00AEp5YPlq6Z6Q==
X-Google-Smtp-Source: AGHT+IETFm4M1t017DIEyZY7UShF4hYT4cHgGr54uTvavgNk7/sWboxZlwAAB/ke3JJzRwMEUvHPLQ==
X-Received: by 2002:a0d:cb93:0:b0:583:7545:2f2e with SMTP id
 n141-20020a0dcb93000000b0058375452f2emr6848498ywd.7.1695650920721; 
 Mon, 25 Sep 2023 07:08:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 n185-20020a8172c2000000b0059c01bcc363sm2424359ywc.49.2023.09.25.07.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:08:40 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:08:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] common: Remove a few more header files
Message-ID: <20230925140838.GV305624@bill-the-cat>
References: <20230925023958.1913268-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XDuCP/6k/tmydYic"
Content-Disposition: inline
In-Reply-To: <20230925023958.1913268-1-sjg@chromium.org>
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


--XDuCP/6k/tmydYic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 08:39:49PM -0600, Simon Glass wrote:

> This series removes two more header files from the common.h header. It
> also tidies up code style for time.h functions, to simplify similar
> maintenance in future.
>=20
>=20
> Simon Glass (3):
>   Fix code style for time functions
>   common: Drop time.h from common header
>   common: Drop linux/string.h from common header
[snip]
>  1709 files changed, 1854 insertions(+), 34 deletions(-)

This is where I start to get worried we're possibly taking the wrong
approach to the problem.  Perhaps it would be better to:
1. Start finding headers which include <common.h>, remove and fixup the
breakage directly.
2. Move on to removing <common.h> from files, a directory at a time.

--=20
Tom

--XDuCP/6k/tmydYic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURlGYACgkQFHw5/5Y0
tyxVeQv6ArbGZFuQOmdZxFSVy0psxqNO986HsfAarATyuvk38FVa+V8QCvoLGCAx
o36qtALEqapDzNPYfmjWjWK2c3EJSQiYzv+Yd5Xr+mOOwn1cnvvC70b1Uapr0FU4
Cq82aTMoY+Gpwh+13OA2YSXcSLp3IXKtmwMtUigRZIfzv+2+ioL4g1WVweSKgyT/
/7FozsLMIdWYwv0Nv5Ik4nJUXtA7Qeq/eyTnI5/OXxQV14fesBr3ATbWcpqLszbt
y8LTDHcFV88sE9sFpoRhUXtPjSQNHzAsEETPIIAnpHV2F2fq5r6aLtB2SE+ZyNxq
TEIyHdlk3Dby82JnulzwNv+jFLgUPMlGovZ1D6p+AhDxeQ2xLF+g7gXtncuCT1na
P79bWIGE5PAqTVuyoFWKr1WbaFOYfnRn1c/1n6AUzaU3pPwAR8MLTkqHWD6Sxboq
DqwBYhvQVdW08gTYCemIF4eKE4i1VPI16LfTI58Zwit7Lf7xURT1qL3FvBPdHMLR
8/gIF3kf
=/dsP
-----END PGP SIGNATURE-----

--XDuCP/6k/tmydYic--
