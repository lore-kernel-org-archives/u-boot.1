Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BCDE9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 20:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA8DE83AA9;
	Wed, 18 Feb 2026 21:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ICrx755+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2945283AA9; Wed, 18 Feb 2026 21:33:23 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 733D283A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 21:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d195166b2cso206953a34.3
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 12:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771446798; x=1772051598; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ds/xr4IijoB26jD9HGmEmY7Llz+YZmeaOkPu9rmVh80=;
 b=ICrx755+Rvl+0YkKJ39Y0vnIVnHglexbCp0vxnWf36W+46j15hQ9VHuRXmDIFfTiZk
 DbRBozajeyXuvg9TFOm/fiX3dR1WZ1422TIOFa/ZrFG8OrcAY2fWtK5qyErI951FHKvR
 RXczl1F0APdgVkLQIVE335LjRc7cXR3ZQz5s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771446798; x=1772051598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ds/xr4IijoB26jD9HGmEmY7Llz+YZmeaOkPu9rmVh80=;
 b=ns6OitlmOz03aWD2jotHRJNep3W/0ILHfb5jYLKcRImizDoHzta8/Zk6pH6/ub55rx
 KnU1V7cqHh8KYDfldG8npDTFQn4zNtSve4VROD1gR130T9XIZ7PLPXjRwLyG3Z5S2H0F
 OvG6MHV16mkr5w3ezG/dXXaD+GUkhr+dtGmV/vSZrtRvMpIDi1jtyfixnDXqIahpuelm
 nEFhp7QiufTvzTWMkR6t+0mmiO5GIztSCL+7+JWJBVa7B2Ccvm0/rUoVlGyCVWL2bTHc
 VXlK7HTkEOSKd9H0X/DynIhw6kUdhSj3R8T9H/+O3I6r6+7FGGVDMAuSNtgmrQySmCaC
 sXng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZyjgq23Xd/pnyEzPru7ZoAbVSVW1CyE1FRhWDvabz2qKdiVYjs6rxdTv46nDz4fTdiPgYdqg=@lists.denx.de
X-Gm-Message-State: AOJu0YxLU2QcQ0E91te8I2Zpsr7x5GeyOwyl6e7zOAnhhV/2CiecYN6o
 275Jy6QbAqIa8IPY2qrFeBVOdM/YKIsM3O3Wr8dUXfMi8P+tJ6h1E1WpFwC2u9APuv8=
X-Gm-Gg: AZuq6aL7eCI2R1gRXjfnyQSdwrgx+NsVObdKQr2lt2P+f2DExmF4leMI0eFEmBDCZol
 XI3AFaIl8k6ylKOGHvZUUGx5UcBqR2Z0ZtpllYEMeDsQr8wIZ0B7J+crPByV4PD/MHuz+bwrHNH
 z54idkrKEFdYtFHfE3QkvOY2JyLsUPLcYc9e+hLEtWo0/suuNT6y70Z/KELw+rxftrmzp7/453i
 gn1CgwLLuEciNJskzf6R8U7+GBQexpcW0UehqSsJhbrWMrqKA8ZvHiD1op0MNi4ODXvaLbIOTyL
 P7qHTfw36SRgZoQB3usS0uBLWtY9Jx3WE+G0416pGD+YIFEXl/38mnoneQk29zPbUPZ9Gb79q2c
 Lu25x3PlPw/Wa44qQSBp3zT+IhS0fcjwWTtj0engvLW3HpDbZM2VWDAToOT84zk5r0QqpVa0o9x
 2THxBtl/3ce1mvv1dDmPAkCC2U0w0TegB91KXa1ecMZxYuJfD7ZKGeOV6Ck0iGj+VXWnh8WNwA7
 +Oxhc15qfPhXM7l65cDVs6PWt5Aj4NfuKrfGoV1F78EanEwnqM=
X-Received: by 2002:a05:6830:7317:b0:7d1:853c:83e3 with SMTP id
 46e09a7af769-7d4c2fe6949mr11596208a34.2.1771446798076; 
 Wed, 18 Feb 2026 12:33:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4d1e6ff70sm11846359a34.16.2026.02.18.12.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 12:33:17 -0800 (PST)
Date: Wed, 18 Feb 2026 14:33:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <20260218203314.GG3233182@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217181358.GE2747538@bill-the-cat>
 <aZTBQykqCt7H8H4W@makrotopia.org>
 <20260217193534.GI2747538@bill-the-cat>
 <aZTYk8E6r4S5zo_Z@makrotopia.org>
 <20260217211853.GJ2747538@bill-the-cat>
 <aZTqyRfqYe1iJ9EY@makrotopia.org>
 <20260218155839.GC3233182@bill-the-cat>
 <aZX2APcJvmU4XSIy@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dkvDSEqaIpC9/6+N"
Content-Disposition: inline
In-Reply-To: <aZX2APcJvmU4XSIy@makrotopia.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 18 Feb 2026 21:39:04 +0100
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


--dkvDSEqaIpC9/6+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 05:25:20PM +0000, Daniel Golle wrote:
> On Wed, Feb 18, 2026 at 09:58:39AM -0600, Tom Rini wrote:
> > On Tue, Feb 17, 2026 at 10:25:13PM +0000, Daniel Golle wrote:
> > > [...]
> > > As the existing code expects the whole image to reside in RAM and only
> > > take care of validation, decompression and relocation, I had to extend
> > > image-fit.c to use the image_loader to only load the parts *from
> > > storage* which are actually needed, and if possible, load them direct=
ly
> > > to where they are supposed to go. Imho, the code is simple enough to
> > > just look at it:
> > >=20
> > > https://patchwork.ozlabs.org/project/uboot/patch/ab7837536e4567b90d7c=
b662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org/
> > >=20
> > > At this stage (because I first wanted to discuss the general approach)
> > > the patch still skips some parts of image-fit.c, which is obviously n=
ot
> > > acceptable for upstream inclusion, but good enough to demonstrate the
> > > idea and also try it in practise.
> > >=20
> > > Ie. the 'goto storage_loaded' has to go away and all of image-fit.c h=
as
> > > to be changed to equally work on RAM-backed or storage-backed images.
> >=20
> > I was talking with Marek to recall some of the details about what we can
> > and can't (easily..) do today with external data and he remidned me of
> > something. So one big concern here is that we have to be care to not
> > re-open things like:
> > https://nvd.nist.gov/vuln/detail/CVE-2023-39902
> > or otherwise allow for mix-and-match type attacks by having some sort of
> > partial reads allowed.
> >=20
> > So a specialized partial-read of FIT images, in full U-Boot (not just
> > SPL), is something to figure out, but may also invalidate one of your
> > design goals because you do have to authenticate the whole image, unless
> > there's something both secure and clever I'm missing.
>=20
> The idea here is to have one or more IH_TYPE_FILESYSTEM subimages which
> do not have hash-* subnodes at all, hence, if there is anyway nothing to
> validate and they do not need to be loaded to RAM (ie. no load address),
> they can be skipped entirely, even if listed as 'loadable' (which is how
> the parser in the kernel currently knows which filesystem image to map;
> we could introduce a new property different from 'loadables', of course).
> Everything else which is part of the selected configuration node of
> course has to be loaded and authenticated.
>=20
> To compensate for the authentication of IH_TYPE_FILESYSTEM subimages not
> done by U-Boot before launching Linux, the dm-verity root hash passed to
> Linux via cmdline should be part of the signed configuration, eg. by
> including an image of IH_TYPE_SCRIPT modifying 'bootargs', or by coming
> up with a new image type specifically for that purpose. Or, even better
> but a bit more involved, include the dm-verity roothash in the ITS spec
> instead of the hash-* nodes.
>=20
> In terms of security, anyway only dm-verity makes sense, as there is no
> point in validating the filesystem subimage if what is validated then
> isn't also what is used -- one could quickly swap the storage device
> after U-Boot has launched the kernel and before Linux mounts the rootfs
> (from storage!) ending up with a different rootfs than what U-Boot had
> previously validated when authenticating the image.

Right, OK. What I was thinking about, but Marek corrected me on, is
about where we may or may not have problems about authentication. So
long as we start by reading in the whole of the FIT (which excludes
external data, being external) and start the authentication with that,
we should be fine.

I have some other questions / concerns still, but there's also still a
number of other emails I sent that're outstanding. So, can you please
link to an itb that would be making use of your proposed feature? Being
able to examine that would help me be more precise in my own questions,
thanks.

--=20
Tom

--dkvDSEqaIpC9/6+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZYiBgAKCRAr4qD1Cr/k
CtQfAQCjTkkePFTjzMhRYadesd+dnu9ymP7/uuikcNsB0EFpegD+LWZtN3nUmRgN
iAsquqq6WXyZjX09FOyVX4qdSonwMwA=
=Dn/6
-----END PGP SIGNATURE-----

--dkvDSEqaIpC9/6+N--
