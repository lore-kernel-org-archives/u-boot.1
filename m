Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEE2C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 17:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4442C803CB;
	Sat, 18 Jan 2025 18:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k1pcQelH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88218063E; Sat, 18 Jan 2025 18:15:29 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB4E80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 18:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-467b955e288so36948751cf.1
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 09:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737220526; x=1737825326; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kWLfIT55HyvLjnro1XkBxYGtrO221v2zZMB241YAmlE=;
 b=k1pcQelHnn3VN2rqdUlbtOyj5Tnu4548daIUjKW6nkOPDQDHS894vy0M4qqr/Tkc2j
 tom5q+s862cpHZnYOk4QMHBtrS4TDtSZCuZIBUAhZe/3pBZRqYtiSI+eiL5d1wLkme1k
 ii4U0UVJuEAsT3r2aP0nkMjqJ/CaJVGRtKqSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737220526; x=1737825326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWLfIT55HyvLjnro1XkBxYGtrO221v2zZMB241YAmlE=;
 b=r6i7fqlNtkvrbA1MzYGGqAWuLjQidPbTZqRvVbzpJU46tez2he1vhnc3BWIIMvzj6f
 c7vIeYwBS91XNmfS5OrTAdF5hISuKMrJbanposmApuEuEdFqjim9P3DP+utIMY9mVnU+
 R9J6uxZMoht7c5lKeA5o5RCkn/cFQzPnameQGMN9SWg0djxvLDkocymP5PuD/nASziHN
 FEekKOZ/Kz3+WMbTF3GqJPjHInG3GdDkUooH7QLUv8W5peG5LVJn3vHN7ojHQLqrWp2T
 z8DbmoVNoMzgtWUnNeDXgB58Qy4cigyX3sxXY5QObZNVLOg0u0AA7oRTCHO+qmVoX+XG
 slfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL1bXcr49eVW2RzruVO8jMvZgUztqotPwCowACGQfYpy4ZBPXyHncrbtoK0ahqRQTuX0xfnV4=@lists.denx.de
X-Gm-Message-State: AOJu0YwmkEYdyaXrLsLXvZXa3bOn4svu15swHR1mC4ekvft7KZq7ByOC
 6rDHcNvrMZI2hqkICQ7JImmMOqZFhrQyaMxNQwuuh/wqNPSM+8ChZaFhm/PP9ys=
X-Gm-Gg: ASbGncu9wjqEO3rZzRdxNHP+Z1KtCN55waKdmRqWGvFV9W9GeR3mbB3p6n3BZnt0oxm
 dRXbc+X2iBY1iTkj4TsKEoLvgm4dvICF6HggVt1UKPURAeR9tstiIQheCwoGLpg1NG35KuekRDg
 ynOzmC6F7HMe8/zHHvJYIEm7IBRU20VV379ATZ80Wbh2oRFjqWknxZv4T/p9gLaVndyJ2Zkwx9x
 lvqSPYWPovMlGob8LonBx+kE+i3vcOKV/zND47cT2l0HARgraxhwb8TiMnWYKyKm5U=
X-Google-Smtp-Source: AGHT+IGhDlsanC5dP4WHR3kxfG96IeucZf378TRxtxJPtsdzBsC88iQZ5b5+dS4rt9XxscdxPt6XYg==
X-Received: by 2002:ac8:5794:0:b0:466:8cc1:6221 with SMTP id
 d75a77b69052e-46e12bc6108mr122216271cf.50.1737220526174; 
 Sat, 18 Jan 2025 09:15:26 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd3859sm23356126d6.74.2025.01.18.09.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 09:15:24 -0800 (PST)
Date: Sat, 18 Jan 2025 11:15:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
Message-ID: <20250118171521.GA3476@bill-the-cat>
References: <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
 <CAFLszTgWe7-zDejNzn1+QDLhjAHz8e=m+r5zYSmf91RAY=ZkTQ@mail.gmail.com>
 <20250108191457.GQ3476@bill-the-cat>
 <CAFLszTh8BZGEpTs_gxo89dMdd6v3PmuFtTMHxmfGXDUwmdaMfQ@mail.gmail.com>
 <20250109165121.GZ3476@bill-the-cat>
 <CAFLszThGNgH2rtLK5d+YEj4-p+cFpVLtMu_+Z_SHYbU8vp6Wkw@mail.gmail.com>
 <20250110164829.GJ3476@bill-the-cat>
 <CAFLszThVjiDgi5_V0yRbWo2pbbv3LEZA4TM=dkiJTd8D6gTe=g@mail.gmail.com>
 <20250113202026.GC3476@bill-the-cat>
 <CAFLszThscvJzBrnSovQsrMr5ie75NVc1yUss0-c_WZLksC7Rcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vIhON1QN6op+mTJ2"
Content-Disposition: inline
In-Reply-To: <CAFLszThscvJzBrnSovQsrMr5ie75NVc1yUss0-c_WZLksC7Rcg@mail.gmail.com>
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


--vIhON1QN6op+mTJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 08:35:42PM -0800, Simon Glass wrote:

[snip]
> > > At present 'ut all' fails so I am going to take a look at that. Quite
> > > a bit of clean-up needed in test system, though. Ideally we could run
> > > the tests in random order so we can find and fix the dependencies. For
> > > driver model we reinit as needed, but that's not the case for EFI, for
> > > example.
> >
> > Personally, for making pytest faster I'd look at the general
> > recommendations various blog posts about "make your pytest run faster"
> > and then go from there.
>=20
> I think the problem is that you are looking at the C tests through a Pyth=
on
> lens, so everything seems a bit slow.
>=20
> 'ut all' takes about 18 seconds for me.

Yes, and the "ut" tests just via pytest do take longer. And it would be
good to have more testing in CI, and for tests to be as fast as
possible.

Looking at the run I just did on HW:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 202 pass=
ed, 426 skipped in 48.76s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 202 passed, 426 skipped=
 in 80.04s (0:01:20) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 206 passed, 422 skipped=
 in 128.74s (0:02:08) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 206 passed, 422 skipped=
 in 118.15s (0:01:58) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 206 passed, 422 skipped=
 in 128.65s (0:02:08) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 206 passed, 422 skipped=
 in 123.76s (0:02:03) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 205 passed, 423 skipped=
 in 128.22s (0:02:08) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 198 passed, 429 skipped=
 in 106.92s (0:01:46) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 192 passed, 431 skipped=
 in 87.95s (0:01:27) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

That could be better, but it's not unreasonable and part of that is
tftp'ing an 83MB kernel image.

I think if I had a point around here before, it was this. C is a
terrible language for processing strings. Python is a reasonable
language for processing strings. Neither of these statements should be
controversial. The controversy is that I'm saying tests that parse
output for results shouldn't be written in C.

--=20
Tom

--vIhON1QN6op+mTJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeL4aUACgkQFHw5/5Y0
tywzHQwAjOqip4j5wXXdPhfnF769eK2NxGMimtazxn/91mJcmeQil/P9qniN+ASj
WhehFYHE0j9QZNafOXkkbsA58GCryO5CS5/G6MWRCgXT85vknGpbjxnLCKqnrucy
HZEODRdtxMC8546o/DVAjmpzymbqdXJNAp48viRLEY/vniPqPOqKoRUnYrXfvN8F
Xz/DxkCVOnEMTTlUmzlV/ARjPJ9rn0Y8V/osl5TXLWEJ3/WdrVdtgE0YqSa2jd2i
DjRfuDQRUok0x5OoFctG6wIWbwbo1O3WV9J9X2rm34pBUWxBKnfoD+C6v4tmIYMc
HxkGuTgP2p6ewwIOhd9oKDdt2QcOBad0y7B154bYQ4DKYatOKkWrscaKra3JWAgB
HYEZqPQqf3EGb862ehRoUuDEMWDxOz60/ITkgSlzsMZFBQ9I4r0iiXIc3vIjYTp2
coceJqMIpEqVTnI1x7lVFNXP+oNI8ZGW3i8CeCL7rZBoUCs2eKzntiHX5whgMgY6
A3EaANOU
=nZ5b
-----END PGP SIGNATURE-----

--vIhON1QN6op+mTJ2--
