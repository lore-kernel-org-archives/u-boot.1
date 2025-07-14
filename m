Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63122C83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 17:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D842F82F14;
	Mon, 14 Jul 2025 19:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JV0HKx6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1795F8309A; Mon, 14 Jul 2025 19:13:35 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5344982E37
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40d1169ff43so1955456b6e.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752513211; x=1753118011; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5ErzYppVlQtGicxCeqpP2z8Erbh6P/28k5ZfXZDq1Hk=;
 b=JV0HKx6bgIwYLtEQ86mM+WpKEksDq7DQ3TsD1EuwDtF0ep9+k+ffu0dWOyELXSR8wH
 hUtGXMo2pooqIgm0Y6t6vTkzy0zjdV5/GoykTfvkxccppLJrmRjPq6pet8YL7OzyIdKO
 MhQFKBsaaUJQ0TfLns/IZ7jEwwjCWeIJSoTbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752513211; x=1753118011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ErzYppVlQtGicxCeqpP2z8Erbh6P/28k5ZfXZDq1Hk=;
 b=rrW0jdrdfAKzhujlIB6QZBn84nD5Nw+YJxe0jaKcatqsKCSTJ64ezZW2bf0+iJcYKP
 E3Uq7Uj3l4H6fPmixOSaPT9ArL9kjXr1c1wALbGosraCPqc4hGtlOWuDV+oFOozgDMQP
 YEHxh2qjZJ9SE+8cVAGM7/XSUzE4KvaXvUuD7oB8bFwM6zpVCiaWcyUOLsiHIOrmA6NS
 4VirhkpGnFAp0bTf6i36rq4LIsrPN4B2Wujuu4hsGEMJ75HwcU3E86NjfJB1jSTlukbG
 ARaWPDJh8Ew4JOO3AaBhHGuOVZJTnDDsf/3GwofnlE3rnRwrIjYrfga4zbRdOpP8xlmY
 VboQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNB9ALSLhKLlnP3qNK4z+yFnrYUnboCaozWGAouMWR1tTrxDwaJ+3JufhtoZ6J3Wt8Dlr5z94=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2MT+TckAsKloIYvkc3xzxL88HUinFzB468CujxEnfKrtFgAKj
 ga0QrwYQ0V9wfGuoQPDykZDvMnVqLztlEfvZ5bO1O+DwebxO6R3RBbsi0cxqzbOVq4k=
X-Gm-Gg: ASbGnctkxGnb6ndx06Dwhr3VCvPMUXVDgfJBQ1jb9Xld/G3JLwq8KSXS8VoVgVQP5pB
 c26DJoDaXYV/J2kEyyrocJD9M9Mn97peoFyUaVjbkhabMb5IuL8eLeNTPovaTle0ogNN1Htl9M5
 6D1arrauIISF2yX1KTCwhv2m2f+yFk2B44D802R6RKhSfagxYwuPps7ZaOns+5Igb1D9xRnflAf
 gX+nWfLoNTbe9PQCRpbjhROFATfHL6iWjpOtSZCcoe7w451U9tMZVSCUs4AEdlcrz/NM5sC6Ta0
 czw/jUxdM7Jt+2no9ZA3E0KojuQRN+sHs0lWtpY9EVp86tlyqb2hBz1rXfPP1Lh3MyMqGjmv02o
 aRl4PKuzOgAeIPHQS0LDpH3NheZ8d8amYJNqu3GWxD1wL4wUGI9MPTzCG
X-Google-Smtp-Source: AGHT+IEETirRFrz/oiULUYijS7pwL+U/1T/XNY/uj8IESpldi/L0TzbwTc6rBDCZdkeYs0NNaGvvdA==
X-Received: by 2002:a05:6808:4fe9:b0:403:56f4:8780 with SMTP id
 5614622812f47-4150fd907camr10015485b6e.9.1752513210835; 
 Mon, 14 Jul 2025 10:13:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c58febcsm1560401b6e.41.2025.07.14.10.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 10:13:29 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:13:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>, Yannic Moog <Y.Moog@phytec.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2] binman: Fix typing for python >= 3.5
Message-ID: <20250714171327.GJ13084@bill-the-cat>
References: <20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de>
 <20250714120228.hkxkjzlxapyo4mmw@bryanbrattlof.com>
 <86c6b776c425e422290f72830d6a568123f740b5.camel@phytec.de>
 <20250714135657.fpa35alz45otqyj2@bryanbrattlof.com>
 <20250714142920.GE13084@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lA7Hr/NsakJ+eYfC"
Content-Disposition: inline
In-Reply-To: <20250714142920.GE13084@bill-the-cat>
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


--lA7Hr/NsakJ+eYfC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 08:29:20AM -0600, Tom Rini wrote:
> On Mon, Jul 14, 2025 at 08:56:57AM -0500, Bryan Brattlof wrote:
> > On July 14, 2025 thus sayeth Yannic Moog:
> > > Am Montag, dem 14.07.2025 um 07:02 -0500 schrieb Bryan Brattlof:
> > > > On July 14, 2025 thus sayeth Yannic Moog:
> > > > > To make it work with python 3.5 and 3.6, need type hints from the
> > > > > typing module.
> > > > >=20
> > > > > Reported-by: Tim Harvey <tharvey@gateworks.com>
> > > > > Fixes: 21bc3433a43d ("binman: rework dropping absent entries from=
 packaged
> > > > > image")
> > > > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > > > ---
> > > > > Changes in v2:
> > > > > - drop newline changes
> > > > > - Link to v1:
> > > > > https://lore.kernel.org/r/20250711-binman-typing-fix-v1-1-66ab075=
015ac@phytec.de
> > > > > ---
> > > > > =A0tools/binman/etype/cbfs.py=A0=A0=A0 | 3 ++-
> > > > > =A0tools/binman/etype/mkimage.py | 3 ++-
> > > > > =A0tools/binman/etype/section.py | 3 ++-
> > > > > =A03 files changed, 6 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs=
=2Epy
> > > > > index
> > > > > 5879f377231bf94697bea97c3cfc3a2515665b8f..c5e77f3a0df22ff768aa725=
4e4dd9ecbe6
> > > > > f81684 100644
> > > > > --- a/tools/binman/etype/cbfs.py
> > > > > +++ b/tools/binman/etype/cbfs.py
> > > > > @@ -6,6 +6,7 @@
> > > > > =A0#
> > > > > =A0
> > > > > =A0from collections import OrderedDict
> > > > > +from typing import Dict
> > > >=20
> > > > It's been a while from my Python days so I'm still trying to unders=
tand=20
> > > > what's going on, but my understanding is the 'typing' module is=20
> > > > considered deprecated after Python 3.9 with PEP 589[0]
> > >=20
> > > That is correct. Afaik it is supposed to be removed with 3.14. (Sourc=
e: Fluent
> > > Python 2nd Edition).
> > > Python 3.6 (and 3.5) does not have access to __futures__.annotations,=
 that is
> > > why I asked if we strive for python >=3D 3.5 support or >=3D 3.7.
> > >=20
> > > So it seems to me there are two paths:
> > >=20
> > > - remove type annotations again.
> > > - when this typing module gets removed, migrate and require python >=
=3D 3.7
> > >=20
> > > What do you think is the best course of action?
> > >=20
> >=20
> > Grepping around some more it looks like mbedtls is still using the=20
> > typing module so it's probably fine for now. Though I think 3.14 will=
=20
> > be available by October this year and just in time for this next=20
> > release :/
> >=20
> > Going off Python's version status page[0] it looks like we're safe to=
=20
> > move the minimum requirement to 3.6 or 3.7. Python 3.5 isn't even=20
> > listed as end-of-life anymore.
> >=20
> > Debian's oldstable (bullseye) seems to be using 3.9[1]
> > Ubuntu's 22.04 (Jammy) seems to use 3.10[2]
> > Yocto's Dunfell is using 3.8[3]
> >=20
> > I seem remember Rocky 8 using 3.6 but I can't find a source for that.
> >=20
> > It seems like we should look into bumping the minimum version but I=20
> > tend to refresh my system a little more often so I don't know what=20
> > pain this would cause others
> >=20
> > [0] https://devguide.python.org/versions/
> > [1] https://wiki.debian.org/Python
> > [2] https://packages.ubuntu.com/search?keywords=3Dpython3
> > [3] https://github.com/openembedded/openembedded-core/blob/c4fb7d1f0f15=
7ffafd9f907f49ea74b93b2c1d40/meta/recipes-devtools/python/python3_3.8.18.bb=
#L67
>=20
> We partly hit this because Ubuntu 20.04 is on, uh, I forget what Tim
> said now. But I really like to be able to say we work on the oldest
> still supported common LTS distributions. We may have to bump to 3.7 or
> newer after v2025.10 so that we don't run in to too many problems with
> bleeding edge distributions instead.

Ah, I should have looked this up as I see:
https://wiki.ubuntu.com/FocalFossa/ReleaseNotes#Python3_by_default

This says Ubuntu 20.04 is Python 3.8. Sorry for all the reworking here
Yannic. Given the removal of this in 3.14 which will come out in time
for us to get bug reports after the release, and also that the oldest
LTS still otherwise supported is using Python 3.8, I asked you to
support too far back and we should aim for 3.7 or newer in a way that
won't cause problems with 3.14 as soon as that comes out.

--=20
Tom

--lA7Hr/NsakJ+eYfC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh1OrMACgkQFHw5/5Y0
tyxxagv/ZuTmubr3dgr1SB9XMSdIrqCgOeP++w4ygyCBXn4vNZ7HIqXYMTlrCoQi
cZ1E/mvyj+740rA/HlyQQVotH732HhxJ1w5B1CMt0LKLswVicDXbGRhsVu6KnAzT
odWodYbgW9+L4fGnGM0DYadrbYCED0tY9/5ZMZHTOOQkTQUKe9/otAQpVb734Rmf
y42m3De4950Vl5JEapprMkVLFYnx83hrUWvulKxvs2drQ/E6DTbsB1QeUrm2Kzq2
bF8NFjvob2ASgZPE9uamSGGPvckmQahNl55YY0PtO+iI8Ouiz35hZXrJlqJx+yxX
TsXYjsujiI/GQuSRcCH8MjZH9/58zdsd00fVMrS09jqEeg3GDL7VuX/ci08k8dNB
IPSS5n8OLQiGvZq2mKiPEaJy1kWmteqnHqt99s8RIjeahOg6H2egRlpQgaAGk3c2
oZ/O+Qynj4tj8HwGE/c5qoV9aEQbSpYGmRkoGC+ko3sJfQF6aeqUt54snICHuNWI
zRAC1H1N
=nnIH
-----END PGP SIGNATURE-----

--lA7Hr/NsakJ+eYfC--
