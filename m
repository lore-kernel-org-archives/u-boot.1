Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0174FE9A03B
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 15:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0956F83CEE;
	Thu, 19 Feb 2026 16:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZeTxQunz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68FA383CF2; Thu, 19 Feb 2026 16:29:36 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28F880050
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 16:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-46391e91e16so633401b6e.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771514972; x=1772119772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ajYPElnFtm7hcYNnEOBLqPYf2IR/7hd6GLXpHwtDOlE=;
 b=ZeTxQunz7XhaO1YJWSSpbsqol2onebHx1nGagb7oKzdqFSAgfi3h/sEQIHi/o8siA4
 YL2R52kwcTUy5CoK4to8vRAXmARvLHAqww+vVYSeE513HvB19rsDRSGlZa/zmjRFiC01
 Ay2aymShnhUYYWFW2MxF+QaqEic4Jrgveh4GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771514972; x=1772119772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ajYPElnFtm7hcYNnEOBLqPYf2IR/7hd6GLXpHwtDOlE=;
 b=XuuegcBkrwWUqt2Tuf2sWgRrcJYPJ1+WAo6QWKPx6/I1hbz9n1DxExguindLPBN817
 0whPh9BKKfzkb1DaDJKpfWDxBKZYKfwoBx0XbULi+b25M7MGBzzQBwKea5fh+rRHCDHW
 1wKNKmDLanmH5OcTpMnKGaG1LHMCaWxEOyBhScqMP2QdT6BdxoNnqettwAMzw18S0h6y
 Uq43MnX6dxF5NLQ/fXepCMefDh5VNyMTnQDyloAoyk2qnLXroJzi7+S+pwRVGuDtKr7x
 nED8uPTQo2hQKuCUm5M+wriN+7SCpzZ36UarDMk21nBr0gMX3846OGINlMmkHccyWN+A
 PFcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXaOXYbxmavwMfPEa/WrPiEer3HRPjeC9+glOIo46N3CAoK81ccp0emG990tAFmSUk7Sdet60=@lists.denx.de
X-Gm-Message-State: AOJu0YwQf6rbBt0XVwKmA4aKDynZHswve6dDtRrnjLUUg/ikD3M0GvYF
 bx2Zr0UaBBVgzHsVBaMxpauqmCTk9k+UZPTWULRjLXzw5ur9UyhBXPsMD1fg3iDDwYk=
X-Gm-Gg: AZuq6aJi4QhrEIsdhcSNfCEGYx6n9e6GYUucQhcCFIpelAAWcXegf37loIe0e+TtHyX
 3bx3L0vpyP9DJtrO6G+jIvo7U2kwux/djjY+1p3iPUNsUHO6p7391+yVTgDXScPRBx+avwJ9cd7
 22dbUG1s0EXLcD1VeR6GBNkw7xoS63GY6vzHa68uvC1dpW7VZPkHvsliUHd6PRKMlvfGkzSOBzr
 v4chciXmF1qlKYQ4LWY3VhMdlHwIpOyY5BJrapv51np2dfxyAwaGbOO48NubQf0OlhPS/79SkJj
 vgvZ6dh9tFPUBt94DLQubfMMFJytQux7x4GwxXdt0g9EYMkKnLS6M1l3jVhETLpwoUHwzI4t1zm
 uZDo5N9F4FePAz+5QIgigBdjfxuo/VlVLs4Qf3zE34fI5CttaEr5W9kDBL5BJnNqDQe6NGJRJrA
 ytM2JZM7WUZBZ8/B8HXqWsBtlAXkFbTU63TDkCbF2FuM3Ayrc/16WW/nex1t/d27UkZ5Fvgt69S
 FzUIds9Kq4xifFs0wqiooZ8/qdhIdLTolGA2RbK0PCHvRq6uCg=
X-Received: by 2002:a05:6808:d52:b0:45c:9a62:91fc with SMTP id
 5614622812f47-46410d601aamr2996465b6e.67.1771514971849; 
 Thu, 19 Feb 2026 07:29:31 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a7720a95sm19742243a34.29.2026.02.19.07.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 07:29:31 -0800 (PST)
Date: Thu, 19 Feb 2026 09:29:27 -0600
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
Message-ID: <20260219152927.GK3233182@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217181358.GE2747538@bill-the-cat>
 <aZTBQykqCt7H8H4W@makrotopia.org>
 <20260217193534.GI2747538@bill-the-cat>
 <aZTYk8E6r4S5zo_Z@makrotopia.org>
 <20260217211853.GJ2747538@bill-the-cat>
 <aZTqyRfqYe1iJ9EY@makrotopia.org>
 <20260218155839.GC3233182@bill-the-cat>
 <aZX2APcJvmU4XSIy@makrotopia.org> <aZZGgCp4WqCLoSLs@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RGTZwHbSkx4TOt/T"
Content-Disposition: inline
In-Reply-To: <aZZGgCp4WqCLoSLs@makrotopia.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 19 Feb 2026 16:57:37 +0100
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


--RGTZwHbSkx4TOt/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 11:08:48PM +0000, Daniel Golle wrote:
> On Wed, Feb 18, 2026 at 05:25:29PM +0000, Daniel Golle wrote:
> > On Wed, Feb 18, 2026 at 09:58:39AM -0600, Tom Rini wrote:
> > > On Tue, Feb 17, 2026 at 10:25:13PM +0000, Daniel Golle wrote:
> > > > [...]
> > > > As the existing code expects the whole image to reside in RAM and o=
nly
> > > > take care of validation, decompression and relocation, I had to ext=
end
> > > > image-fit.c to use the image_loader to only load the parts *from
> > > > storage* which are actually needed, and if possible, load them dire=
ctly
> > > > to where they are supposed to go. Imho, the code is simple enough to
> > > > just look at it:
> > > >=20
> > > > https://patchwork.ozlabs.org/project/uboot/patch/ab7837536e4567b90d=
7cb662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org/
> > > >=20
> > > > At this stage (because I first wanted to discuss the general approa=
ch)
> > > > the patch still skips some parts of image-fit.c, which is obviously=
 not
> > > > acceptable for upstream inclusion, but good enough to demonstrate t=
he
> > > > idea and also try it in practise.
> > > >=20
> > > > Ie. the 'goto storage_loaded' has to go away and all of image-fit.c=
 has
> > > > to be changed to equally work on RAM-backed or storage-backed image=
s.
> > >=20
> > > I was talking with Marek to recall some of the details about what we =
can
> > > and can't (easily..) do today with external data and he remidned me of
> > > something. So one big concern here is that we have to be care to not
> > > re-open things like:
> > > https://nvd.nist.gov/vuln/detail/CVE-2023-39902
> > > or otherwise allow for mix-and-match type attacks by having some sort=
 of
> > > partial reads allowed.
> > >=20
> > > So a specialized partial-read of FIT images, in full U-Boot (not just
> > > SPL), is something to figure out, but may also invalidate one of your
> > > design goals because you do have to authenticate the whole image, unl=
ess
> > > there's something both secure and clever I'm missing.
> >=20
> > The idea here is to have one or more IH_TYPE_FILESYSTEM subimages which
> > do not have hash-* subnodes at all, hence, if there is anyway nothing to
> > validate and they do not need to be loaded to RAM (ie. no load address),
> > they can be skipped entirely, even if listed as 'loadable' (which is how
> > the parser in the kernel currently knows which filesystem image to map;
> > we could introduce a new property different from 'loadables', of course=
).
> > Everything else which is part of the selected configuration node of
> > course has to be loaded and authenticated.
>=20
> Thinking about this a bit more I think that it would still be good
> to have a way to validate the whole image also within U-Boot, but
> add a way to mark the image as "no need to authenticate at boot" using
> a new property in ITS, eg. containing the dm-vierty root hash which is
> passed on to Linux via cmdline.
> This would have the advantage that U-Boot can still authenticate the
> whole image because hash-* and sign-* nodes are, eg. when loading it via =
TFTP and before writing it flash
> during firmware recovery.
>=20
> What do you think?
>=20
> Do you agree that having 'dm-verity-root-hash =3D "....."' in addition to
> the existing 'hash-*' and/or 'signature-*' properties would be a good
> idea, and that then allowing to skip authenticating that specific
> subimage at boot (but not in other cases, eg. 'iminfo' should still
> always authenticate the whole image).

It's a question that requires a bit of thought. As part of the thing is
that we have to validate the FIT as a whole (excluding external data)
before we can move on to working with the contents of the FIT. After
that, what is stored in the config nodes and so forth is a separate
question, and at-rest security provides its own challenges that also
depend on what the hardware can/can't provide for us too.

--=20
Tom

--RGTZwHbSkx4TOt/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZcsVAAKCRAr4qD1Cr/k
ChCrAQCvuptlrXr4MBaWXbWLo3Z5mL/sxwkwmGGVcdgqEPhGDQD+OkQ5lCAPETF2
0FJ4yTGzcWmCTuqEfuVXwOl3R6xNYAA=
=6yYW
-----END PGP SIGNATURE-----

--RGTZwHbSkx4TOt/T--
