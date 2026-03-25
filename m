Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C1D109C047
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20716838BB;
	Wed, 25 Mar 2026 17:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fk/gqo1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 396F683A1B; Wed, 25 Mar 2026 17:52:39 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033D481E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4673790ab85so3005091b6e.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774457556; x=1775062356; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mmAKhmYOCvWQV5TV6/R0rfezilzDC9hCq1eVUDY/UR4=;
 b=Fk/gqo1mDEDGXqAYXnMSBskeGUIDqdzy2wCkyv8ejTl/r8hegQwalztHNaNxl6eDLF
 AM0s+tnuNbzfq+tWjta2I2WB2O5DlZfrjUpwIuSYPIWxX/yVhbqtJz1NfiXO9ZzIMppr
 QA4OAfISawSvlIFIv0GE/VmeHmgDJRyupqoWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457556; x=1775062356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmAKhmYOCvWQV5TV6/R0rfezilzDC9hCq1eVUDY/UR4=;
 b=neV5kGmHmfVusibgwq86zU7g5SSpClFL5g3IWNyvK+m1niIeDKlwvRFVK5x4n3RN2o
 BUkalFjE7ojwFFoAF2x0VjRdgRMO2EyIS9RHItm1neW/4niLrusV+hf61FVpmxcU8EcX
 lhomeDr2a31akjT9I50cpvpQIXFD4dWZB3ZOXKPgfztWa2UVc0HSXs2HET3tLT0OsvuA
 Br2AnT1bOagnU7v9aUK/l7PR7VFt7iYw0nuR0M6odSMWJcs2R49E3sG28Jw7ZradFzYz
 nj61jJd4lxnycNLF/UjX2O6MbcE4UjHXQ627jZm/XJFnamo9jTcvBYJ7gAxMCL+sxMM8
 i7lQ==
X-Gm-Message-State: AOJu0YxKACCf7Q5KHnP0MlRU4f864Ry2FJAb/gk6V7OP2d0iwbwwZ5tM
 yn2/xGYNpG+w0YJ4+Z5hwKnNQobNrDucq5IAuUa0BT3EbS3WMa8He1F2aIaC51fwiwM=
X-Gm-Gg: ATEYQzzxqxo0AOLuGVG5NP6rxlTZRfs7H9Sx9BnP3O4YSRQ7AshAGt1V2MIQAicNdHB
 P+QtIacuDhUfo9N6ehNonBYuvWFci0Yl82WPiY/UOVt33GpemSu4q0xrCSgPFHiZAFYc+8Jv2pI
 yQayEnfSTJ2H6YgIPY2RDEc3u0oOM0PgHebhMUKPVYRg/JTrUBRUq1OKVXcan4Tj56LPvqxkCE+
 uhFcL+rubAqs2wIZysQdjcTP+97waA4lUyCHaEIYxtJjUsE1pBeBz5TeCixVNfUaoelJ/mfqnm8
 rblpTRiV6HdNjCnlBOwU4y/QHReSYg7mRmQVniS/QvOm3zxYIwDZcBRqdcdSkWCW/Bds4mwzP0a
 NGglrC+xocRqnb6/O8jLqZyDh08MkZ7o9TRDaD1K59O/iG8Q8Ci5WKIXshpc5kNnim+1B69wp30
 /sFoPvusEvZngfeHeSFx025Ric2+YvOJJaL/CRVoxY875ok5048YYqjiMAQI3YGOdClEmtMNBBE
 gZWNcXlkI1DG/etmn3sbvQx25pODr0IDgN1s9fhmJuQ7PXdy4XoYXM9OLw=
X-Received: by 2002:a05:6808:14d0:b0:467:281e:3d85 with SMTP id
 5614622812f47-46a5c70e809mr1872094b6e.29.1774457555547; 
 Wed, 25 Mar 2026 09:52:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099decdsm24959b6e.13.2026.03.25.09.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:52:34 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:52:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Teresa Remmet <t.remmet@phytec.de>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Marco Franchi <marcofrk@gmail.com>,
 Alifer Moraes <alifer.wsdm@gmail.com>,
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>,
 Heiko Thiery <heiko.thiery@gmail.com>, Marek Vasut <marex@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, upstream@lists.phytec.de
Subject: Re: U-Boot and legacy SPL power control on modern platforms
Message-ID: <20260325165231.GS502704@bill-the-cat>
References: <20260320214518.GD502704@bill-the-cat> <acPEoC0W8DJMnYfd@shlinux89>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lyKk6WI1o6rvA4Cq"
Content-Disposition: inline
In-Reply-To: <acPEoC0W8DJMnYfd@shlinux89>
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


--lyKk6WI1o6rvA4Cq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 07:18:56PM +0800, Peng Fan wrote:
> Hi Tom,
>=20
> On Fri, Mar 20, 2026 at 03:45:18PM -0600, Tom Rini wrote:
> >Hello,
> >
> >As part of the work I've been doing on clarifying Kconfig dependencies
> >I've stumbled on to a number of modern boards[1] that are using the
> >SPL_POWER_LEGACY symbol. Can the maintainers please update these to use
> >DM_PMIC, DM_REGULATOR (and SPL variants) as needed so that they use the
> >modern architecture, or let me know what's missing here? Thanks!
>=20
> For i.MX8MQ, I think we may need to leave with SPL_POWER_LEGACY,
> the board has 256KB TCM, but u-boot-spl-ddr.bin is almost using all
> of them if enabling SPL_DM, other SPL_OF_CONTROL and other DM drivers.
>=20
> u-boot-spl.bin itself is 90KB+, but ddr firmware and hdmi.bin are packed
> in u-boot-spl-ddr.bin, the image is a bit large.

Ugh. Does CONFIG_SPL_OPTIMIZE_INLINING=3Dy win us enough space here to
matter? Changing CONFIG_SPL_LOGLEVEL rarely is enough of a win to
matter, so I don't think that'll help. Turning off CONFIG_MMC_VERBOSE
sometimes helps, but only a little.

If we really can't make it all fit, then renaming some options needs to
be done once we remove the legacy portion from full U-Boot (of which
there's a much smaller number of semi-modern platforms enabling it).
Thanks for checking on this.

--=20
Tom

--lyKk6WI1o6rvA4Cq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacQSzAAKCRAr4qD1Cr/k
CliyAQC/H1KHPgXi+m4olF/AvwjNUVQmH3vIvXMUwe4WejZPPQEAnVLorGav0HxK
BLVoCR1WBF+2LstuUZs/eiWABusRBw0=
=XtSv
-----END PGP SIGNATURE-----

--lyKk6WI1o6rvA4Cq--
