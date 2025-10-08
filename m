Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935CACAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 19:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA15883976;
	Wed,  8 Oct 2025 21:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jsB6QqCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E83839B7; Wed,  8 Oct 2025 21:46:19 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B175A8394E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 21:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6418c6b8cbdso111451eaf.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759952775; x=1760557575; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wLDfN0FpvkKGJs19/JMsmAlrzfaDfa4w6LhznuXaSas=;
 b=jsB6QqCAwXvBnYEPXbpqq5kztM+zi+hVvH4WIMVhV6rZQ7PeFemcELxDia7q0SatMK
 WW4Pprpm6jTDhSKn1+1HmTZGlL3dCZTeiTxDwEA3jsRDklH3TDfFuldOUArh9z47lmNb
 MVqkxa8QWxBOF2Dn7POPQ28/cVmflx+DjLbNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759952775; x=1760557575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLDfN0FpvkKGJs19/JMsmAlrzfaDfa4w6LhznuXaSas=;
 b=v7ZEqSVOfZmxtlPilfFS6uIevGMbJ4PWG750yKvhGxQSoIITvubJJfbV9JaGSlbpV0
 Ap4EKW2GLfSWtk4Y7Qd4Faefn1VeGydci8A8PYVmSNxWYm6eNcr8Q4xqnjLcahWVUXsW
 wjBapYN2eQsUiTWwt/9b6OI9xoAuBvBIsQLmo/Y6e8ndyAHWcgHwsXtRdvWg8N5j2bzx
 Qip4VDLqdVQUAihFZY5TZQL2RdiOrwqCYRE2ZwByGst4eTxy6TGqAS4/euXsFaGdNBoN
 YsJFR/0KLSEC16l2RWUGuaxFcVqjzkBo5wNZGJg9LYkf9u+rnswtsqdFLv4YA3eDxNQF
 TWhA==
X-Gm-Message-State: AOJu0Yzcd7CwpK+T/aKPzfBjw1Ow+1c0R6roQp2VuYFsMecsghq8wTNa
 sl8ntpTNT7QOdH51eiHTWWenay/PR7usnpNTHaYNtVrMuTDJK0FsvgkRsaGsETpdUKk=
X-Gm-Gg: ASbGncuSsWkjTZ/WDsxRpwuIDWg5XXqxqYfUlIsWbCveMvYB567uTj+zij+ZELO3Vxc
 ACCnXw52PWdi+9L/uvrBOUoQ7SqzXdR7ibBQn2j2LMltT+yBb9iMVD6nW/1lkFHd3dPvzi03ey2
 cvhdPoVwB+fTQLptwu7TVG9t9Lx+Sgf9PGjj+tnf7Uqha4HENHWNddXHLik1FM+4kbZ+T84LCYa
 rIY8LPj6bzlFpBJ10Z7X/k8g6tqF+D28iVfdaIHbGIP0iITNBP8RwFuYMecm71BczbtK+qlJ4pk
 dwLVB4E+3czwnaExiRhssHldjZW3JR3ZMcFjqL7+9oQ8ZTPBfNBOsZ/DrOOVnkAEd50qpijolN4
 RcGlyOKEzOHIz/JVRFbERk7SNceVsafjF62vPr5FoQzeYz944fHabA+N3ND5widlY/jaN30qWEX
 EF1ZPPIy2Pyg==
X-Google-Smtp-Source: AGHT+IFoiNH1fAX0st2aOgGiwVR1F63hQLxctLL5Mk30dzNQl58ijA8oLhY2okqcCGP7xzdNAl0jHA==
X-Received: by 2002:a05:6820:2ac1:b0:643:f2c6:f834 with SMTP id
 006d021491bc7-64fffeb9bc1mr2040770eaf.7.1759952775451; 
 Wed, 08 Oct 2025 12:46:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e1bc7f4e0sm4302465eaf.19.2025.10.08.12.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 12:46:14 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:46:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] cmd/dma: documentation
Message-ID: <20251008194613.GJ298503@bill-the-cat>
References: <20251008174408.381-1-briansune@gmail.com>
 <20251008190713.GH298503@bill-the-cat>
 <CAN7C2SAaia8qV4sx-uMF2Y1GE4GW=WmmgSMHMApW0YoTzTqQOQ@mail.gmail.com>
 <20251008193306.GI298503@bill-the-cat>
 <CAN7C2SDaP65Eu914rAzNdhKG9oAUEeM9EhE-EEh2odONnBjWVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ashOO9L8GqSzATI4"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDaP65Eu914rAzNdhKG9oAUEeM9EhE-EEh2odONnBjWVw@mail.gmail.com>
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


--ashOO9L8GqSzATI4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 03:35:21AM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:33=E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> > > > This needs to be included in doc/usage/index.rst (alphabetically so=
rted
> > > > still) in the shell commands section. Also please do "make htmldocs
> > > > KDOC_WERROR=3D1" and make sure there's no complains for v2, I see s=
ome
> > > > style issues it will trigger. To build the docs a python venv is
>=20
> There is an issue I am not sure it is ok.
> My system is old python 3.10 is not allowed.
> Could I downgrade pip library version to make the require documents?

Probably so, yes. Most of the style issues are things like:
These two lines must be the same length
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

And then the new file not being included in any other file and so an
orphan. If you pushed things through CI before, it will run a test to
catch all of this:
https://docs.u-boot.org/en/latest/develop/ci_testing.html

--=20
Tom

--ashOO9L8GqSzATI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOa/gQAKCRAr4qD1Cr/k
CnISAP4tuNO9rD5hwDslSFwUzdGBYKiKKWMNjO1yZTlP/6AHegD/bT1xRAvzFEpl
YlSR5q2sD9JpCTecdIhh3WBFmmTB9gc=
=bUrx
-----END PGP SIGNATURE-----

--ashOO9L8GqSzATI4--
