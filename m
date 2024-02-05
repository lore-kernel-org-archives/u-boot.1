Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD75C48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 21:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB23886EEC;
	Mon,  5 Feb 2024 22:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uLKY1R09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F1686F8E; Mon,  5 Feb 2024 22:10:41 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 761DD80245
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 22:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-603fdc46852so51530997b3.2
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 13:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707167436; x=1707772236; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rvTZVS8TXOHJ6cMHYKi/G6/ZUv5RllBGFzmfYcTfYIc=;
 b=uLKY1R09bP6ILOv4uHezPLUlT5ODjwG+1xpHTlvmA9M11Y7I2CW1O574V33J+yQZUN
 1SXSjWKK1kT1OK47NiYMK6sQ4WC476pwUCGG66Z2sQ25Eq88dBu1+a5a2gcd5yyLbs0y
 U1dI3r/Jr9x9a7q+JM20JjYkov9yPstQmhUQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707167436; x=1707772236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvTZVS8TXOHJ6cMHYKi/G6/ZUv5RllBGFzmfYcTfYIc=;
 b=VCeUKnQWhBqTUEyUYAD06KrdTwa6W4ntJVEhxXMrXhsSCbkNivvqM/+8SDtqyw9Dra
 dybHsVAosqMWVunrSGzwcoCGZDs3kwKIad4Ur03gC6wZFe+E1jcoCEW48Hh5VNdh1uxN
 Go8g9aCyIY7TsvgIqlNEXC7IgWQRgqZTPtT6GJYfb/gMzfMaIFAfyWgfsu4AxfnYFF5o
 uCOjgy5HB97/3nVmlaB/CHhv/QubBZq6BgJo+o7VCKkewwnAkRoaYU+i0sj28y4MgXgg
 Kho0f1/n2KG0J2pg0uzpvgfm78Ux43EynYbKXkCdePVhnNRIUkAf7Ft6bQ9dsXb+3mer
 sCWg==
X-Gm-Message-State: AOJu0YxVfsJfPmMV1eIxk4KoWXzmNxI9BBAtZvGtiE+LazsA2Eh7vp2y
 N1IhfD+0GsfLe4N8SWG05JJbpBzVis/8+TRSUoAmKOrHyv78o//V1Cv7I9hXSGY=
X-Google-Smtp-Source: AGHT+IGDXkw8DIhTZ2XEU0Q/whfj5bIxJCZ+fGl+1cEY3aO5qHdg2vK0R/bpnsnYuSotHhVO7w+D7A==
X-Received: by 2002:a05:690c:e06:b0:602:b343:60c9 with SMTP id
 cp6-20020a05690c0e0600b00602b34360c9mr148799ywb.26.1707167436076; 
 Mon, 05 Feb 2024 13:10:36 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU6Io016Ctk2j4EafW46CHQTGcbFTSy/VazD2WhbsJ8e32Q1t9ULOW8guxPO+dKCz6IMiAGqIKjvwOYmZkpT6+hqR6QVL1F03bPKhevbHfnmasBuGmfLD8whenr0iDyp+dIYCiewiYI
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 y10-20020ac8128a000000b0042a6e6792basm289165qti.69.2024.02.05.13.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 13:10:35 -0800 (PST)
Date: Mon, 5 Feb 2024 16:10:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 0/5] update venice dts
Message-ID: <20240205211033.GM1152441@bill-the-cat>
References: <20240205190858.3076363-1-tharvey@gateworks.com>
 <CAOMZO5CmMDhHKndFbbKsR8e82ShXnSz95yE2nPXqQog_2CpE_Q@mail.gmail.com>
 <CAJ+vNU2XHZBzabTpR=4WG8pQgbdQ5HcOMG1pueAEo0zBfZ7X-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WGAHYKcHstOOfDiW"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2XHZBzabTpR=4WG8pQgbdQ5HcOMG1pueAEo0zBfZ7X-A@mail.gmail.com>
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


--WGAHYKcHstOOfDiW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 12:19:47PM -0800, Tim Harvey wrote:
> On Mon, Feb 5, 2024 at 11:22=E2=80=AFAM Fabio Estevam <festevam@gmail.com=
> wrote:
> >
> > Hi Tim,
> >
> > On Mon, Feb 5, 2024 at 4:09=E2=80=AFPM Tim Harvey <tharvey@gateworks.co=
m> wrote:
> > >
> > > This series brings some recent upstream Linux dt updates into U-Boot =
for
> > > the Gateworks Venice family.
> >
> > Please specify what "some recent upstream Linux dt" means.
> >
> > Is it 6.8-rc, linux-next, or Shawn's tree?
> >
> > Can't you instead sync the imx8mm-venice DTs in U-Boot with this kernel=
 tree?
> >
> > > Tim Harvey (5):
> > >   arm: dts: imx8mm-venice-gw7901: add digital I/O direction control G=
PIO's
> > >   arm: dts: imx8mm-venice-gw7901: add TPM device
> > >   arm: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
> > >   arm: dts: imx8mm-venice-gw71xx: add TPM device
> > >   arm: dts: imx8mp-venice-gw71xx: add TPM device
> > >
> > >  .../dts/imx8mm-venice-gw71xx-0x-u-boot.dtsi   |  7 ++++
> > >  arch/arm/dts/imx8mm-venice-gw71xx.dtsi        | 40 +++++++++--------=
--
> > >  arch/arm/dts/imx8mm-venice-gw7901-u-boot.dtsi | 14 +++++++
> >
> > Why is u-boot.dtsi being touched? Please add a justification.
> >
> > >  arch/arm/dts/imx8mm-venice-gw7901.dts         | 14 ++++++-
> > >  .../dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi   |  9 +++++
> >
> > Same here.
>=20
> Fabio,
>=20
> Ok, makes sense - drop this series. I will send a single patch instead
> with more detail if needed in the commit log.

Can you please look at
https://patchwork.ozlabs.org/project/uboot/list/?series=3D393337&state=3D*
and work on top of that? I would like to pull that in to v2024.04,
still, and that will be a better long term path for your platforms as
well.  And if it looks like it would be a problem, getting that kind of
feedback now is also appreciated. Thanks!

--=20
Tom

--WGAHYKcHstOOfDiW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXBTsYACgkQFHw5/5Y0
tyxIxAv/X6EykYqxSRo65NdGZijgC5ds5BLg8vZVwwniFZ9osdROeVg+KwuTnxLE
RRPQVSQkMOJw/glEQkcBhjrbOG21sZNXjIl2g9PEwjrpB1XgdLJG18oPlBtDlaQz
KacerTKSlsJuj6GJRZmIiZP+JGli1qoTvULIG0nHoS5dQ47wKL9bgOFQ2dy4SqrI
ihWlWJuey519kTmrEGSC5450xFKKYUev1BD29yPOEda3fQLXUzeKLe7ozBH6tXu8
CzZyVNPIajdqpX3wc7rSouzioOD6DbWG7lofX3M2c7wM+JDctK9N7rUFu7AvcinG
1pTuVhwlwSRn7ckJjNI/TA0GgYzfp8kCsS3ZxUFiYqF+BA+VZt9stYggfOTJSnor
y9dpL6Y98+AHsY2/Z2EfYb/8uzoB++iQMVL413NjsHkMO9rit7Vsv3TdszQrK0MV
JAX/H6+0yp9qVzWiKvDxaH3SVzCRKHS7U3IdOSK+1+THkh+qEZ8t+DzE8dVXBX/H
FYWL7zLl
=sxCe
-----END PGP SIGNATURE-----

--WGAHYKcHstOOfDiW--
