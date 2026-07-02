Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D55AC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB881848BF;
	Thu,  2 Jul 2026 22:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gy3niW/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C7484A3A; Thu,  2 Jul 2026 22:59:04 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7977843B6
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6a19a5691bbso1509594eaf.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783025940; x=1783630740; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5q0yNdM6fZfeHTmv9dzhklJDbloRFiCJwEbAbLMrm/Y=;
 b=gy3niW/hO+5LfJoqHczLF9Kibqcd7vBNzCY4/WleOQ2Jk8l68AP+AoV8R/RmE4bMOD
 HKp67reGSWR1pwvYiBmgtyUO8T1gKW4AEhThDbjFy0/eXTv/+2uiT4thxFCRbOtRz5yX
 GDfzfij5QV/G2YcBn7olfFtJo8xoZR4pPmHB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025940; x=1783630740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5q0yNdM6fZfeHTmv9dzhklJDbloRFiCJwEbAbLMrm/Y=;
 b=f3azF3C7T+e6eQK763MPtaaykkDmBLzWJRGB7tswGmcxTd9PiWrTVzly+69cVS2eWs
 CMXXsyZkSavJdDdmg4BwiL4+2e2XlKHmqrYNoQ/wOEATm0Fhiw0zTseVJ1GlG9rhEEiF
 0NxxfUnGNUyvOJHjbWr9gpvPyaheTuw320IW03nYAg62dd6wJAE+Ph9DKAiak9mYjkUX
 nSScpSUufGialqS/Ou+3a2hXJQa6qBdKx0wYVUpL60xEA5mp7jaY7P9j7Ln+ppDtbfMP
 syrY/9VEEGUObQwnUt6nOyKhOZy6EkXgP7EwtG3UKqmGDAy1gnhd8aT9efrzH4tUcDfh
 LTCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GiNPLxWXC7LgLP3Fr65yA42yYt8uOvrkVzx+Mjkl+wB/m8212jYz2TG8s3IKFt0PJA8E2oyI=@lists.denx.de
X-Gm-Message-State: AOJu0YwdNrVz0MJh6dklWCFru5zrNtY/EZky8zqLNea+v8oAsUx+WmK1
 +PhXh2IVOnyuffpfhiDQcDIrOObddHJ9dp0gqS4Ga6abwcRmu5IGpCtCeFfzRyEMUZg=
X-Gm-Gg: AfdE7cm21U9IhfU1fGX13JQWreJJrqkgQixn/hdV6IIRiPewQqkhH+mMlylTs8PA/zT
 Y5PHygp68AgSN5xeyP69ptXi3KXBWz/AFhP0OOiRf9z9cWtm3JNOit96P1DayCpotGhJjWfWOCO
 oNo0O1KWa87dpUBFrfEjcr47gXLTBpsiVJJEagy9xPSn1Lh1PLmV+SGOxSXuyBqDBbyz8laoN3t
 lCRR531UQfpyWtLO4tzafGY8QKoQ/Crk7kZYBTRO+JQqfIErK7imMPPYOfq81994P2kl3y8ngdB
 EusCZybuk7sCUA6y6b7QVOVXruOC535PE0EqBqUng1KkeSfSseh7I9EpPCtKINysOH96AWoQC9y
 5kSu1OErRW7ciCpSdFvEWZ+iIIVHNIi1zV7Y8YZMzm/MsJ24jZPgbh3XNHj84Kukxw5k1qvkJ3d
 fdYaBvub5IH0xhJiZgPIrJayTkbkpAh7RUmAZsfOe+dEUU6VrbyjzrBdk+rtY2/cFUJeGAQcviD
 cw4/y7xv1enwQDyJ1ju4xyTjCjX91eEYJS6rIjLCDaUntHX
X-Received: by 2002:a05:6820:1a08:b0:6a0:b429:443e with SMTP id
 006d021491bc7-6a30d7c9b08mr3745668eaf.23.1783025939635; 
 Thu, 02 Jul 2026 13:58:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54292d5fsm3435360a34.6.2026.07.02.13.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:58:59 -0700 (PDT)
Date: Thu, 2 Jul 2026 14:58:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 07/16] LoongArch: lib: General routines
Message-ID: <20260702205857.GG749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-8-me@ziyao.cc>
 <20260701174940.GP749385@bill-the-cat>
 <1c9f6db6-4307-4860-851e-be46ce2382d6@app.fastmail.com>
 <20260702140708.GX749385@bill-the-cat> <akbQjpFwVPkwTE4p@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WiCxhUVEWrpZg91m"
Content-Disposition: inline
In-Reply-To: <akbQjpFwVPkwTE4p@pie>
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


--WiCxhUVEWrpZg91m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 08:56:46PM +0000, Yao Zi wrote:
> On Thu, Jul 02, 2026 at 08:07:08AM -0600, Tom Rini wrote:
> > On Thu, Jul 02, 2026 at 10:24:28AM +0100, Jiaxun Yang wrote:
> > >=20
> > >=20
> > > On Wed, 1 Jul 2026, at 6:49 PM, Tom Rini wrote:
> > > > On Wed, Jul 01, 2026 at 11:17:59AM +0000, Yao Zi wrote:
> > > >
> > > >> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > >>=20
> > > >> Add some common library routines for the architecture.
> > > >>=20
> > > >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > >> Signed-off-by: Yao Zi <me@ziyao.cc>
> > > > [snip]
> > > >> +#define CACHE_MAX_LEVEL		3
> > > >> +#define CACHE_MAX_INDEX		6
> > > >> +#define CACHE_OP		GENMASK(4, 3)
> > > >> +#define  CACHE_INDEX_INVWB	0x1
> > > >> +#define  CACHE_HIT_INVWB	0x2
> > > >> +#define CACHE_INDEX		GENMASK(2, 0)
> > > >
> > > > I was expecting checkpatch.pl to catch the double space here, but it
> > > > didn't. It did warn about a few other things in macros, which shoul=
d be
> > > > checked out at least. And that comment applies for the whole series,
> > > > along with a manual check for other spacing issues, thanks!
> > >=20
> > > Those style issues are mostly copied over Linux kernel counterparts, =
should
> > > we leave them as is to ease kernel rebasing effort, or fix them for c=
onsistency
> > > with rest of the U-Boot?
> >=20
> > Ah, OK then yes, we can leave those if it's a match-up with the kernel,
> > but should make note of that in the commit message when applicable, not
> > just the cover letter. It will make finding that reasoning easier in the
> > future.
>=20
> Yes, most style issues are in files copied from the kernel side, before
> sending v2, I do have a brief look and fix some of them (for example,
> mixed TAB/space and multiple empty lines).
>=20
> But the diff quoted here isn't copied from kernel side, it's written by
> myself. I consider the double space meaningful since these two macros
> are two possible values of CACHE_OP, and found similar styles in
> tools/zynqmqimage.h (PART_ATTR_*) and kernel side, do you think it's
> acceptable?

We have 178 other files doing this, so, it's not a NAK if it's really
helpful to you.

--=20
Tom

--WiCxhUVEWrpZg91m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakbREAAKCRAr4qD1Cr/k
CluDAP9ZCsJHw8yx3olOCLGvCma8WAYQZ/Zh2V/5JKqq52qxsQD9GO6wghRZZFI9
H3hxv6LpAgHvuuDWJiwzQ5i/IxdPCA4=
=N0Yy
-----END PGP SIGNATURE-----

--WiCxhUVEWrpZg91m--
