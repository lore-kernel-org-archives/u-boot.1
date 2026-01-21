Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA11C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 14:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EAE58341A;
	Wed, 21 Jan 2026 15:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KsDfiwre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E928397D; Wed, 21 Jan 2026 15:51:42 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F22683015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 15:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45c838069e5so3808215b6e.0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769007098; x=1769611898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wcdxnd5IbXmkqHfdt+Uui/ZYliWJEqhBgDVQUK8NBe0=;
 b=KsDfiwreqv5KTFFCLSSyawVR2J8s/AjwJabOfCDHq7AkTPEUqH6JpHSeb1S+8hedG1
 ySDOh0AF6DjLE4YcB5HlLnn+p8FJQX7YlMX9qBlwvJvK0qEnfJYw4fC6SIt7x1awNEeg
 EDsocgVVdAF+lAggBbfEBzk7z87qZXYKRM5mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769007098; x=1769611898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wcdxnd5IbXmkqHfdt+Uui/ZYliWJEqhBgDVQUK8NBe0=;
 b=CyRhgL/RrhP9fyOmKRM/8M0ZPUBEf899a1vB1daW4oSKCXo33p569/d5WoW1iu0d59
 4qAtd/DVpbjnd0SzotMmraa9QrKlexVy6E0Ny6loV43/Uz/CY+Q5wOWCAn0OoDsChxqS
 B3o1iTh6bk51WuAzEFE6SSKLYiMjuXlQ3C0U4JFEir1LWCUC2wpuAzVfvSd83CqN6tdX
 8u/ek7RK165Uxu9zYCipMFywAhXO7IiJ55tKblwtn9WXZfbro5Y4i2kpr3m8FJTOGoaw
 FG8ZQJ5eaphWJB4cLdFrvgMfuUEVgEUGY4EmMkMHO/Q0f6lAQHueSnmJBPuvMOCylSP7
 xbSg==
X-Gm-Message-State: AOJu0Yzy3u2HWbucvcjXG52OvnSwdJ4QYY6T/l9a1xz3fT6aOkFWCPHE
 7QwCkIFV0c43lTJi9NcZMRAnb6vE2ZBsK7HshWty+RpDdYPpkEYETuPbZ3h6oyCyzDo=
X-Gm-Gg: AZuq6aImaTc8rwvDrDOstfpsb8K5pvt+GLGrFC1ZOHGdV0BAXV5Svpg0ciysStUNcXO
 bnT0UGsptdwu4LmoyTHLzxWac5HJP60omgU8xWDnqUTv7FPhYVweiB8GIO+pRxJTDnxHlzj92BU
 n7HXqGXxY+zvJ1OrlDeLkj1i3IePVzNXdHvNweSlSx+++4d+8Rbxi2JxWgATSCNkcwdjj8HRY+V
 ZfReiJSL5ae5pqLbvazoG6fC3ro7m6zxzT36YrsI42Ofn1y7TRaupT0DK5D9StSeljFPh7tn04x
 3i8D2x6SCND34XbecvYco7SX5UHD5xlgSBZR6JpbV3mkfPx++mgV/St4plfjK9iSR8ARhYRB9RY
 e/1e05biUI4KZ4zP9jLp0SwAHnFJTN0zBWS0TC0OV9XbxUO8dXRxI1TVF6qPodYZSc4y4TxDvyG
 S8TTFIpNFdxMo34sTOrKTYjOJOG7AQJgt421DrS4NxEd93znSU//zBdvmoJ9/K27fH6VQ+cCo3t
 s5yfkI/fVZxdhZsQWEQfYb4GxA1JQKWChJZ5Zw=
X-Received: by 2002:a05:6808:23c6:b0:45c:8526:b56a with SMTP id
 5614622812f47-45c9bebd566mr7444720b6e.3.1769007098246; 
 Wed, 21 Jan 2026 06:51:38 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9e03e924sm8311684b6e.19.2026.01.21.06.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 06:51:37 -0800 (PST)
Date: Wed, 21 Jan 2026 08:51:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/5] doc: develop: process: Make "Work flow of a
 Custodian" a subsection
Message-ID: <20260121145135.GS3416603@bill-the-cat>
References: <20260120223405.469050-1-trini@konsulko.com>
 <20260120223405.469050-3-trini@konsulko.com>
 <CAOf5uwkkkehBhMdHEKwbr00DCDJ2B+qe18kBRUJ=chox0NKLLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S1fR5XyEnNW6MRUx"
Content-Disposition: inline
In-Reply-To: <CAOf5uwkkkehBhMdHEKwbr00DCDJ2B+qe18kBRUJ=chox0NKLLA@mail.gmail.com>
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


--S1fR5XyEnNW6MRUx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 10:44:42AM +0100, Michael Nazzareno Trimarchi wrote:
> Hi Tom
>=20
> On Tue, Jan 20, 2026 at 11:35=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > Make the "Work flow of a Custodian" section be a subsection of the
> > Custodioans section.
> >
>=20
> You have just a typo here

Heinrich, can you fix this when applying please?

>=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  doc/develop/process.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> > index 3bda5e6b51dd..f436a98433a7 100644
> > --- a/doc/develop/process.rst
> > +++ b/doc/develop/process.rst
> > @@ -233,7 +233,7 @@ feedback to the submitter of a patch about what is =
going on:
> >      apply cleanly.
> >
> >  Work flow of a Custodian
> > -------------------------
> > +^^^^^^^^^^^^^^^^^^^^^^^^
> >
> >  The normal flow of work in the U-Boot development process will look
> >  like this:
> > --
> > 2.43.0
> >
>=20
> I'm fine with it
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

--=20
Tom

--S1fR5XyEnNW6MRUx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXDn9AAKCRAr4qD1Cr/k
Cg1iAP9DGxL7s/F56d+1bCtNk1i0vOlEPzcTji8A824Y3QiBUgEAyvX/KfB58IMC
njB/7FULJSIC+qeNrG1iRVzkqtqY8wo=
=Tw/0
-----END PGP SIGNATURE-----

--S1fR5XyEnNW6MRUx--
