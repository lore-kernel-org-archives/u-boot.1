Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF67E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 16:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF7B80196;
	Thu, 19 Dec 2024 17:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="he4GffLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D8A8021A; Thu, 19 Dec 2024 17:38:01 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F428007D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 17:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b6ea711805so92459085a.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 08:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734626278; x=1735231078; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n1Eh5Vv/aDjwEAlJr56yCom5HSPZKJiXoPUl/h7wgHo=;
 b=he4GffLXcRuWUTpwIYmkZIILzYLJL+uVSNELDyNWYL/3Ptvbt2DCRqta24BgGraHw+
 nk2hoe7jpJDerk0MPCJ1xcC40SoQSCS3jNqAJY9/ENDK4RbmQpvHGdOK1U5YhKjmDTva
 LnQoKdUHFOS8PD5pi1AzmBQNgRBTeAUM5yQWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734626278; x=1735231078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1Eh5Vv/aDjwEAlJr56yCom5HSPZKJiXoPUl/h7wgHo=;
 b=oKjRD2d8QVOmtnpmqa0wp65+Z833ZwFyzpYyINB6aNzea/gwpTvvqCxs4MtEW0TwuW
 /8e2TYIPMny5bNtLsVXgwRfs/aoWROb1qfEPBM8Q6NswEWHuVhGPjtRQ4jYM+JrniZMe
 G6kUNhgDLlwGB11r5DjrsSzAmeiwBpZiXV/fKNbr0PsbeN2ME95HpI/qx8vzzyX0eUvs
 ES8j8QCr3e/7oCEc+3MD//BV8wkV5IBh2RFjHw3TVhHaJ4gWSoSXZ3nwtU9A0hsBRsXn
 Q5QCft2fmmYGlFfgWoxD4O+p3QaAdvl8BGBOme9e78WMgVrfoiATrOmj0a0nypG2uJ46
 C7jQ==
X-Gm-Message-State: AOJu0YxXN65WhBj0LcVUAU2WtNXRpatI+zahMJOb7ZVicQueyOqj0jLJ
 CShFUmVPN1hRtsIHXFv4vkE23lSqWS4w//R+AOA8uM9xaG+xWMcEoSqdZfxJ/8Hk/jfAdidLpzm
 /
X-Gm-Gg: ASbGnctt1l0DbLyfMhr1T2zv6Idc6r+AdDiyjBD3Sq3qkH8XYPjPH3/3MQSfAGARld3
 g53Wxk1yGOiw1wOBZoPuDNK4lEjYJKPn8CWzeB5JXCjwa7MN0TGv6e7iw6n3H/WbPoNaPCeI2xD
 Uhd/XCSq6Ac9HHe0K/Ko3sjqSjOuQIDEzSYDXraQu5YakIMFT64kIo5g4f4BXfR/UpoWfsC5N3O
 v0xPje2FhK4rpw88GT+OWUqx+iQeDxLZmkpvUbKg/w0itGVhJBeAhoN
X-Google-Smtp-Source: AGHT+IHkHDoAwz2bOe48srPRA3BuQofJifBKlJl8P28ZVO9ZJhuIKc83g+K1s0/UsF1bRFNT0/TM2A==
X-Received: by 2002:a05:620a:4154:b0:7b7:142d:53d2 with SMTP id
 af79cd13be357-7b9aa9ab83fmr560677685a.41.1734626278093; 
 Thu, 19 Dec 2024 08:37:58 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bc101sm63050685a.3.2024.12.19.08.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 08:37:57 -0800 (PST)
Date: Thu, 19 Dec 2024 10:37:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>
Subject: Re: [PATCH] buildman: Add a way to build a particular target
Message-ID: <20241219163754.GW1505244@bill-the-cat>
References: <20241217132616.3708573-1-sjg@chromium.org>
 <20241217142016.GK1505244@bill-the-cat>
 <CAFLszTjfxxseCJUvUXPgZQWQYNrL+yT3u8qZ9OieJHxaC=dfDg@mail.gmail.com>
 <20241217195348.GQ1505244@bill-the-cat>
 <CAFLszTgaLn-xO104gw2meFTHBfVdWjPu+AiSXkYcSLM=uYWdrA@mail.gmail.com>
 <20241217235411.GV1505244@bill-the-cat>
 <CAFLszTgyScyRrV0pNksMYB5r1RxGN1dnJFO-96XaLtn=NLZu+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CRQIbSFXlPALr29W"
Content-Disposition: inline
In-Reply-To: <CAFLszTgyScyRrV0pNksMYB5r1RxGN1dnJFO-96XaLtn=NLZu+g@mail.gmail.com>
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


--CRQIbSFXlPALr29W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 08:07:22AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Dec 2024 at 16:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 17, 2024 at 04:42:30PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 17 Dec 2024 at 12:53, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Dec 17, 2024 at 12:45:29PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 17 Dec 2024 at 07:20, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Dec 17, 2024 at 06:26:16AM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > At present buildman only supports building the default target=
=2E Generally
> > > > > > > this is what is wanted, but in some cases boards erroneously =
have a
> > > > > > > different target for product extra files.
> > > > > > >
> > > > > > > Add a --target option to help. Also add a comment indicating =
which
> > > > > > > letters are free for new options.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > How do you use this? It would be nice to be able to do "--target
> > > > > > u-boot-initial-env" for example for converting and verifying the
> > > > > > conversion of boards to plain text environment. Except the list=
 of
> > > > > > artifacts that are kept isn't updated with that string as well.=
 And
> > > > > > FWIW, is this for a case not solved by CONFIG_BUILD_TARGET?
> > > > >
> > > > > It's related to the problem where colibri-imx8 doesn't actually b=
uild
> > > > > an image with the default boot target.
> > > >
> > > > I don't recall if there's a good reason for imx8 not setting
> > > > CONFIG_BUILD_TARGET to something, but that sounds like how to solve=
 this
> > > > problem. "make all" should work, normally.
> > >
> > > Even if it did, the build fails the first time. It just needs to be f=
ixed/
> >
> > Yes, there's both the problem of CONFIG_BUILD_TARGET not being set and
> > then whatever issues there are with configuring access to the blobs
> > especially when they exist and aren't faked via BINMAN_ALLOW_MISSING.
> > IIRC Toradex does weekly builds of top of tree, via OpenEmbedded / Yocto
> > so there's not some bitrot here to be fixed, just smoothing out
> > integration.
>=20
> To me, BUILD_TARGET is a pre-Binman construction and we should just
> use binman to make sure that the default target builds a bootable
> image.

Well, no. Assuming that doc/board/toradex/colibri-imx8x.rst is correct
then CONFIG_BUILD_TARGET should be set to "u-boot-dtb.imx" so that
"make" just works like other platforms. If there's some other target
actually in use, that should be what's put in CONFIG_BUILD_TARGETS and
in turn binman will get invoked as needed.

--=20
Tom

--CRQIbSFXlPALr29W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdkS+IACgkQFHw5/5Y0
tyy0lwv9GnAPeGHB3p7T5Rq4RR48pnS5BAyUfW3sVKw9U0i6qanax13tu6+Do60n
3OJdiNc5Q8VTyRHCMG+hRYVG/C2bG+P8AgTFphZo0NdY72LOWvgHRnF6xZxmez9s
vrxC3v4WqZaCF8PGxSD9MKhJg51XMfxD+5ik1MIgsU1r6LEckUOIgjc/v2vuYX1E
jTuYXMZ/Ij8jaw26BTfYEIK11nt4zmdgIPHCW9oOcBFutApouSNlEBWUeoUeGqnK
y8GktwzaFbnkTR5QZCit5zuhxoq50bKnXdbtsBJwK024Gi3cu3jFVyHYmaQGRoXR
U9pdvXm5ZmdwfoaPlvWgz/L3t+efhwatSjQAp3pQfmMPn828itlWvOAW3RZhbQHP
WqG9lpIt1OGDtlnsD8e+euOFFz1DQAik7NAbOHCscZmLT7TAV15loEdp7gSySNUx
bM4wIQ3QNHroEBgJtMUAEQ9/r95WtO1NsoLPTZ+o8hH/A7ycBge1alUpsQBniBrp
Iq+sFwjE
=mKp+
-----END PGP SIGNATURE-----

--CRQIbSFXlPALr29W--
