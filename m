Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4993C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 14:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1322082CFA;
	Mon, 14 Jul 2025 16:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cx2gBNFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510C482E37; Mon, 14 Jul 2025 16:29:27 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD5082BA7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-736f9e352cbso2327037a34.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752503363; x=1753108163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d9Qd6tVj5mlB2GaKjHo1Xt0DVe0nLSxQJhzt7sB3ygg=;
 b=cx2gBNFSPmn1jI+FO0sy7siHhYIiK338EBOVq3RggsmvzNSuP6FqAiTWNAkkO63D4/
 4dsYIX615Hmooy9pBmd8409xGoXrs5Mpr3lmHUO4wrVbAcyZH69w4kQOekMtrxmrIjeQ
 xtwid+48GOw4lv+khPvRHC7giCMrU9mQI10l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752503363; x=1753108163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9Qd6tVj5mlB2GaKjHo1Xt0DVe0nLSxQJhzt7sB3ygg=;
 b=nYWdvBOI1wDxXPo6mhrntT3dCDUVy3wmAg/NDF9NhvEPbjJJIvpZl31/fRS34O1Mue
 We0JbXP5om4KY8YHFD5sYWbK+Rxg3rHN8/xpYhJW8AL3NeXhePJGrd/Ib6vZdumr2wq5
 4cyCMimTNKo42YtXY2KF3/92V5wDD7RdZeUtxY8obe15NBc/w/UCKHKf8n1QODmwAem7
 QbrqfF4wQrCwyWhX7BeVfMaUUI8fxNuyJ6AU/Z2a0Nz00Oe6PGv2C4yl8sMgjnK6+73g
 sk255VbB6bDzLQO2G9RWtZ8cmEwrkvdRDlFNPLYVtrS20auNEnSSzQFxUdv6SjraWZCu
 bqQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+HxcO9Taz3AmT6b5p+7flZQSDFxAZOPYfyBWIIT9RtFXv8grUcWI4m7jd6niTZd68qR2Yfe4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9JCOqibsrTQ1qM9bo+O+t0XpxEwZXSbt9axfNdzTH+dbpQNDr
 CFxcPetp4fHKuqxsjfv6nGTT3b96agIHImk/nbXOOHODVZX/bUDxQQELB2UxaUDqlyo=
X-Gm-Gg: ASbGnctNQU6Sw3ZOD73hqRJwONsC1h//3dZVlJdpf0nYhwXERScJacEkJZtJ/8HtISo
 +taMd0RzU4XPysUu7g2QodX0KEb4HIDVzZJyuYIZjmVYrFE3OL9A60mDLT/5fUad0qWWfzfws18
 F36DyXQDFUmxrIsKQ+esdmUhpIg62WRfN+fQBa85Q16/93QY5FYT51ERNu4NhITxifHdRfXt5Ci
 6hKyahwDlScLugNTOVAPNp13vUbMtvhkDQ54Elj+kl4eCm+5rmWlQKzI50g9+E1QCcRj3WurCqF
 aMPITrc3+tQFzU1MT6lJCVJ5o2xwm4jPRTn9ggbpnGE/0eO1Zg4lg9FeZv+JvYc7o8UMKnMLaWQ
 +ztFAngtVYWO1Oiltnyv/hfTrXtYk72XQ6LRaBgBrP8EMrO+T2MJqQwql
X-Google-Smtp-Source: AGHT+IGTNs0A1UyXzzMb1APklYD7O2+5375MXLpLvv/k54wUYc0V++dUdytcaA99qJ+0I7yVGONXHg==
X-Received: by 2002:a05:6830:2813:b0:73c:e9dd:cc5f with SMTP id
 46e09a7af769-73cf9f333eemr10251154a34.22.1752503363067; 
 Mon, 14 Jul 2025 07:29:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12a6340sm1569117a34.54.2025.07.14.07.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 07:29:22 -0700 (PDT)
Date: Mon, 14 Jul 2025 08:29:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Yannic Moog <Y.Moog@phytec.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2] binman: Fix typing for python >= 3.5
Message-ID: <20250714142920.GE13084@bill-the-cat>
References: <20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de>
 <20250714120228.hkxkjzlxapyo4mmw@bryanbrattlof.com>
 <86c6b776c425e422290f72830d6a568123f740b5.camel@phytec.de>
 <20250714135657.fpa35alz45otqyj2@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hXM1pY3Ga3QldwzZ"
Content-Disposition: inline
In-Reply-To: <20250714135657.fpa35alz45otqyj2@bryanbrattlof.com>
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


--hXM1pY3Ga3QldwzZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 08:56:57AM -0500, Bryan Brattlof wrote:
> On July 14, 2025 thus sayeth Yannic Moog:
> > Am Montag, dem 14.07.2025 um 07:02 -0500 schrieb Bryan Brattlof:
> > > On July 14, 2025 thus sayeth Yannic Moog:
> > > > To make it work with python 3.5 and 3.6, need type hints from the
> > > > typing module.
> > > >=20
> > > > Reported-by: Tim Harvey <tharvey@gateworks.com>
> > > > Fixes: 21bc3433a43d ("binman: rework dropping absent entries from p=
ackaged
> > > > image")
> > > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > > ---
> > > > Changes in v2:
> > > > - drop newline changes
> > > > - Link to v1:
> > > > https://lore.kernel.org/r/20250711-binman-typing-fix-v1-1-66ab07501=
5ac@phytec.de
> > > > ---
> > > > =A0tools/binman/etype/cbfs.py=A0=A0=A0 | 3 ++-
> > > > =A0tools/binman/etype/mkimage.py | 3 ++-
> > > > =A0tools/binman/etype/section.py | 3 ++-
> > > > =A03 files changed, 6 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
> > > > index
> > > > 5879f377231bf94697bea97c3cfc3a2515665b8f..c5e77f3a0df22ff768aa7254e=
4dd9ecbe6
> > > > f81684 100644
> > > > --- a/tools/binman/etype/cbfs.py
> > > > +++ b/tools/binman/etype/cbfs.py
> > > > @@ -6,6 +6,7 @@
> > > > =A0#
> > > > =A0
> > > > =A0from collections import OrderedDict
> > > > +from typing import Dict
> > >=20
> > > It's been a while from my Python days so I'm still trying to understa=
nd=20
> > > what's going on, but my understanding is the 'typing' module is=20
> > > considered deprecated after Python 3.9 with PEP 589[0]
> >=20
> > That is correct. Afaik it is supposed to be removed with 3.14. (Source:=
 Fluent
> > Python 2nd Edition).
> > Python 3.6 (and 3.5) does not have access to __futures__.annotations, t=
hat is
> > why I asked if we strive for python >=3D 3.5 support or >=3D 3.7.
> >=20
> > So it seems to me there are two paths:
> >=20
> > - remove type annotations again.
> > - when this typing module gets removed, migrate and require python >=3D=
 3.7
> >=20
> > What do you think is the best course of action?
> >=20
>=20
> Grepping around some more it looks like mbedtls is still using the=20
> typing module so it's probably fine for now. Though I think 3.14 will=20
> be available by October this year and just in time for this next=20
> release :/
>=20
> Going off Python's version status page[0] it looks like we're safe to=20
> move the minimum requirement to 3.6 or 3.7. Python 3.5 isn't even=20
> listed as end-of-life anymore.
>=20
> Debian's oldstable (bullseye) seems to be using 3.9[1]
> Ubuntu's 22.04 (Jammy) seems to use 3.10[2]
> Yocto's Dunfell is using 3.8[3]
>=20
> I seem remember Rocky 8 using 3.6 but I can't find a source for that.
>=20
> It seems like we should look into bumping the minimum version but I=20
> tend to refresh my system a little more often so I don't know what=20
> pain this would cause others
>=20
> [0] https://devguide.python.org/versions/
> [1] https://wiki.debian.org/Python
> [2] https://packages.ubuntu.com/search?keywords=3Dpython3
> [3] https://github.com/openembedded/openembedded-core/blob/c4fb7d1f0f157f=
fafd9f907f49ea74b93b2c1d40/meta/recipes-devtools/python/python3_3.8.18.bb#L=
67

We partly hit this because Ubuntu 20.04 is on, uh, I forget what Tim
said now. But I really like to be able to say we work on the oldest
still supported common LTS distributions. We may have to bump to 3.7 or
newer after v2025.10 so that we don't run in to too many problems with
bleeding edge distributions instead.

--=20
Tom

--hXM1pY3Ga3QldwzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh1FDwACgkQFHw5/5Y0
tyxTkwv/cC00Wiwu2dPKiTZm2OlbfVFdlXFJrvwOk45jOye+UVCCZzH0ynt3Laau
xNNUN0i4TB6Duper7tAI5q1WzUNJ2hDlhgh/enM3m/KeN8HsYlGVD/RwC2b6jJip
Hgn68/LSqWiKfC0fgNFnP29kJykTYVPpEyfz7WBi1cbk5+aFWR+Ngd7ZuXU2aHUm
w7VZP2r7i/k/s4Bx3RdOxOmS/hNpZkl9rCoqYBMMa83UzzRrPsdKej3KSAZtwboe
J9lSfkU8RChepY4gLOw2tQNrRI146IbCIQSJtZaTAke9Q43qx1/7BYMvJT+jMMoe
6YQKswnx2avHQSXWK7xifaCLBOj+Rwe6S4TKxZK55Ti91lbu9dp7frVKcix+yQ6g
uS7WqPdLNzz8rLwP2ysNoB7VMcnTr/fvAKXlMw/iGMhwKNT1TZJw0AKJjkQOYeH2
quTk3H3OCVYTRz1ntf3yyTZZjy1j+Bv+rqOFlq5mQH5F0crZHH1SkYzr26gZdx9V
hgX4Hq+2
=VjCY
-----END PGP SIGNATURE-----

--hXM1pY3Ga3QldwzZ--
