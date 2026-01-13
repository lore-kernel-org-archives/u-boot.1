Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F50D2F345
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9632880433;
	Tue, 13 Jan 2026 17:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RHBS0la6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9149680433; Tue, 13 Jan 2026 17:47:05 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE9180077
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4507605e19aso5174552b6e.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768322820; x=1768927620; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sUgLET4mUVaE8NJgngKGV2gxZ8z4SNumdzv/b+9v0ak=;
 b=RHBS0la6XhlO8WG2K+7UMWvdaQU4KzYb8mGpksxZ2+pVYAMoRlQvSPIS5gfstGgsnZ
 g4QUkRyIcTD/bReWFkGnt6ta+MguIbRhCdtKXVhT1ywqTnyBFJpcrVGg94AxfqCpuptf
 G5snPPM15KC/Cmmxpjma/DhFLy07IO5hyltH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768322820; x=1768927620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sUgLET4mUVaE8NJgngKGV2gxZ8z4SNumdzv/b+9v0ak=;
 b=rhK2Gs7Yd49L9Y/AvsQcwslmCh7tAE+Ed30EkLw70mJlBdCn/z7leF9N1XUK2ViOKx
 Y6ImCs3QK+Et1eMQTWi/Zdj3Zvm0JK9WhJ7WmvzC/t3MEX2JY8dzZhrYio72lhVBJuWk
 Itc1IdaAv6LBkwdjt66IXYzSYzlhr+1s2H8+wlNc1T5pg0vZdQ03OwHa1SU+HGUDcH1W
 odnigUbMZVb/7qefKK6CUCKkOJ+TrzxlAQlm5wpmVVvcOJ1wNROgTKYTL0EJsSJweLA4
 LJhcrbx4VjooLl9zJkFIgPBxoCM3+0LAmtLpXA9NqzNO5RTjG+BUR0N3GEd+9dMWpY78
 Dq2Q==
X-Gm-Message-State: AOJu0YwYwdVVjkPySL5CrXWlIUpHiVVNkXYs9NJLbdXm7DfKHSjx5txg
 iTpKdE+WgWxh7wupZYopvUnb4FhDSOMhKZyQkotm9iko+dlkW+bHILRI0obb0fF9uG4=
X-Gm-Gg: AY/fxX725EDB/B0inGBkH0C2XUWYzRSCQX39WL4uclOD7ID1AXlYPQdSJewsys0folm
 cRoGdwGlT1tpLtp7roWcvxKNSB9hGMm8TtPy4mP4zZyzKD4f1Z1/zQgeLYXSgZYqRti7trAa0Ps
 srth4ggdLunO3wC8hX2mOrHkH/Lf4X0iR8Ti7lVZwYlYhtJGaalrjDceALFKqzo800NnAmraf9v
 DoMylQaLkXBBe1jZwAC9OKJWfih4QXVkPF/UDkLR1I+LoYh1vZaq5EapHqvpbYcmUY0/A3HtOiy
 WSfO8/ZRMMbqbeNEADxZ3BMF4NyGEih6ELEnKsGAB6NNtTZe/TAdjggf4VxgGGOH7h7NOUDmDFE
 RUiK5wUgdOcBLEwQLaRrR+hh8TDUvoHrAda8c2crgXBKhw4JSt+O1kPxBSSJhAKaHdUPZQaFnUH
 dzMZB33lNiJ62Qlx8a4Hs9+WYwR38Lm0xkbaJ5gzYPt1km5iag0bma74tQPQDY98pZqZXFPsKSf
 8trfsovV02TX3PVfXYkqV/Fi1rteTgjrV0Z/4A=
X-Google-Smtp-Source: AGHT+IE+8WpiDf78WywNl9WP8yN6lKruaw7pOFBlJzosqt3pbgWxgAyGfxssMAEow4+3g/p0uKM7mw==
X-Received: by 2002:a05:6808:3c43:b0:450:d590:50d with SMTP id
 5614622812f47-45a6be89d26mr11454272b6e.46.1768322820227; 
 Tue, 13 Jan 2026 08:47:00 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a76abe858sm7737522b6e.9.2026.01.13.08.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 08:46:59 -0800 (PST)
Date: Tue, 13 Jan 2026 10:46:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, jerome@forissier.org
Subject: Re: [PATCH] net: tftpput: Rework to exclude code from xPL phases
Message-ID: <20260113164657.GY3416603@bill-the-cat>
References: <20251225153721.1217202-1-trini@konsulko.com>
 <7030eca6-457f-48c7-9729-40f0b684edad@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g53UQGRntO4VTcuL"
Content-Disposition: inline
In-Reply-To: <7030eca6-457f-48c7-9729-40f0b684edad@cherry.de>
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


--g53UQGRntO4VTcuL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 05:30:55PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 12/25/25 4:37 PM, Tom Rini wrote:
> > Given how the support for CONFIG_CMD_TFTPPUT is woven through the
> > support for the tftp protocol we currently end up including "put"
> > support in xPL phases, if enabled. This in turn can lead to size
> > overflow on those platforms as xPL tends to be constrained. To resolve
> > this, use "CMD_TFTPPUT" in the code to check for both CONFIG_CMD_TFTPPUT
> > being true and not being in an xPL build phase.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Jerome Forissier <jerome.forissier@arm.com>
> > ---
> >   net/tftp.c | 31 ++++++++++++++++++++-----------
> >   1 file changed, 20 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/net/tftp.c b/net/tftp.c
> > index 3b0f4cd2006e..78ec44159c1b 100644
> > --- a/net/tftp.c
> > +++ b/net/tftp.c
> > @@ -22,6 +22,15 @@
> >   DECLARE_GLOBAL_DATA_PTR;
> > +/*
> > + * We cannot use the 'tftpput' command in xPL phases. Given how the
> > + * support is integrated in the code, this is how we disable that supp=
ort
> > + * in xPL.
> > + */
> > +#if defined(CONFIG_CMD_TFTPPUT) && !defined(CONFIG_XPL_BUILD)
> > +#define CMD_TFTPPUT
> > +#endif
> > +
>=20
> Doesn't
>=20
> #if CONFIG_IS_ENABLED(CMD_TFTPPUT)
>=20
> work?
>=20
> Of course, CONFIG_SPL_CMD_TFTPPUT, TPL_, VPL_, ... will never exist, so t=
hat
> should tackle it properly and be more consistent with the reset of the
> (recent) code base?

That probably works too but is getting too clever and obfuscates the
problem I feel. It makes a certain amount of sense to use *IS_ENABLED
macros in the more recent portions of the code base where we've more
generally split cmd processing from protocol implementation as well more
cleanly sharing code between phases, but here I prefer something more
clear especially since for CMD it really should never be valid in xPL
phases, but I think we still do end up with a funny spot or two.

--=20
Tom

--g53UQGRntO4VTcuL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWZ2/QAKCRAr4qD1Cr/k
Cl6tAPwOWpxp2ptTvjhzEOtPPAX8BXwucNrMctjMTdna/XTbyAD9FqePHRJrzwbg
DoX/C8gbH66lK4OZE8OAzG0bxxLKwwI=
=mrTG
-----END PGP SIGNATURE-----

--g53UQGRntO4VTcuL--
