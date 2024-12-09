Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D36E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3853896FD;
	Mon,  9 Dec 2024 16:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cjPSF4EX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34B8896FE; Mon,  9 Dec 2024 16:51:34 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C5A896F9
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6dd0347dbso19157085a.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733759491; x=1734364291; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yaIlHpVM0IL2rgku/2fLYCWWKrwc5lSbKpy3YlcK/zs=;
 b=cjPSF4EXyS0W5nuSarpe06wU7WcYJXE5oYV3Vd71konUfk1B4Yku/9Gna6lj1J5pdQ
 3meJIa/H5DDAT+Qiqe6CqTJ7xr45sf4dU89s2qma+/mCoHlYPCn83RZStJB6elVgNKri
 ymjMeYzsbjSUnfk6Ew2I63Fn9ET/9rZMoa5iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733759491; x=1734364291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaIlHpVM0IL2rgku/2fLYCWWKrwc5lSbKpy3YlcK/zs=;
 b=oNOsTRb0RMsYOhhmcmKdy41awIEINnFjp3h9hYnJwscYzl1trEiUBP1buC7PQv5oiJ
 cujufI2zlFag0SV0an7u6/kH6eJqj8uC4Q0XkGzpkKZ2xXqZ6ndiRH0q2LQn50VmXoOT
 /akvOynIwk5nbozFtBALqchpJVYdQ7ub0EgUGWYl+ZaDc+UMaKoxqTpW6WKfZZoqo+BT
 BjjUjjDyZ7IU8Au5Jlyh4jVvDZ9ld/XXiaM6MrUYaM4eAb2shvndNhXtBg7Z8OyT3SyG
 UyjBVukNu9sbbHc0EYMGaTdhAyJMarOoEXU5EeDyIR988IfdlCc6VTtCWx2WRX7Mt193
 z3UA==
X-Gm-Message-State: AOJu0Yzi5rgIwy3kRqa1Z/qMYoEO+NgrZSxJ9iLZc5kJx26NnHoticA6
 vwX7oZug+AQLZtLrF/AAqOH8hHFWGH9y00i5GzleLhp9pediwnKU6Q4qwgQTPNw=
X-Gm-Gg: ASbGncuqjP5qIyKDqvgxv+BBG6EZOg7rvEsrrN1hy8TtAR4vVkla+GTQKCOy030/HBU
 ZEo5xdVpWn6hvIj6uwcbYr5tUBt9rRby8GeVDu6uANUhioXfCDexETg34rch1zuGKH4EsTZzm2y
 SziZFX6X8GMyHjOEB5DL3s8ldpL4lfciCFjED0V+I9D2ouyEUYk5CjSQLVWCrlY66n4y0FlvMjC
 5Pr5VYyCBTaXIGHARQVwK9yw9bMowX9sBSYXE9zq2G8WDyp6u0=
X-Google-Smtp-Source: AGHT+IFo+8ln7BMWjWV7QkjU5zmIej35KlsLBVuEMvFdAv0Q55ZOgPrz/hP/RjPCZgq1YYTipnBWiA==
X-Received: by 2002:a05:620a:4084:b0:7b6:d9d2:d265 with SMTP id
 af79cd13be357-7b6d9d2dd99mr315008085a.57.1733759490973; 
 Mon, 09 Dec 2024 07:51:30 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a468b9sm453409085a.13.2024.12.09.07.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 07:51:29 -0800 (PST)
Date: Mon, 9 Dec 2024 09:51:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 3/9] GitLab CI: Make wider use of tags
Message-ID: <20241209155126.GK2457179@bill-the-cat>
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-4-trini@konsulko.com>
 <CAFLszTjyqf0bctZ0aY2r2+kQD07q1fnJ38E0DjuKcqU9+B6skA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="auh+95ugju+eGw6w"
Content-Disposition: inline
In-Reply-To: <CAFLszTjyqf0bctZ0aY2r2+kQD07q1fnJ38E0DjuKcqU9+B6skA@mail.gmail.com>
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


--auh+95ugju+eGw6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 08:00:42AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 8 Dec 2024 at 12:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > First, introduce DEFAULT_ALL_TAG, DEFAULT_ARM64_TAG, DEFAULT_AMD64_TAG
> > and DEFAULT_FAST_AMD64_TAG and remove the previous DEFAULT_TAG (as
> > anyone making use of that will need to adjust their jobs). This allows
> > us to say that some jobs can run on amd64 or arm64 hosts under the all
> > tag, while some jobs must run on amd64 (the Xtensa jobs due to
> > binary-only toolchains and sandbox for now) Then we rework the world
> > build stage to only run on our very fast amd64 hosts, or our arm64 hosts
> > (which are also very fast). This should result in a similar overall
> > build time but also a much more consistent overall build time as we
> > won't have the two big world jobs possibly run on our slower build
> > nodes.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  .gitlab-ci.yml | 74 ++++++++++++++++++--------------------------------
> >  1 file changed, 27 insertions(+), 47 deletions(-)
>=20
> I'd prefer fast_amd64 to avoid spaces

I don't see a reason to avoid spaces here.

> What is the run time for this new, unified 'world' build? I just
> wonder whether splitting it might make the runs go faster?

It's about the same at the worst case of ~40-45min, but it's more
consistent now, by excluding the older / slower amd64 hosts.

--=20
Tom

--auh+95ugju+eGw6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXEfsACgkQFHw5/5Y0
tyxHIAwAkLF86jQ52f0kb3Ey6Q5pvS9T3oAJjJ7jiJ0uBqPK7a7K0Wovs57sQ9OL
e2+1Yb6qSoY34bN196BzloJJy5um5Z5jH/kFBCAyv19JQMG9UiIcxmSOvR32e4BO
Du6l1cJwc2EAMow8wqwh17JpyN1dVLTDYX/BnCaP3PMIMeSCK4np1i/tiFB29+eW
KBFzZ40HUGzVd5hDCWM2i7cGMTyU9W9QZO0G9chviJiqDkwgRiu9wc+zleJGgHz+
Bk34f00XV33yqxi+jq/kE1CwFG5GaRTC/bgd6/Go75BsljkcdYtRF5SmRarHchYT
ieSEP/nwwf61x/vW7vsYTJ+3c7bflSUSnfK/P/48bDPMa6MBD0oFmnFybk3fexzW
Dsrx4j2mBih3Wo3LL6kjRlYDTwCQfk3DOpX2Bxq4D0+DBY8e6sZOSxURkvQ/g/XB
bhDJvwNOv7oNnyid16Bs7lmIxCD97Ijfjnm3zmgzvTdkN1gyNRG/NV8JBT23BKx9
jVZiMu79
=a/Wi
-----END PGP SIGNATURE-----

--auh+95ugju+eGw6w--
