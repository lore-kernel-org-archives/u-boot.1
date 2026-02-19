Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA009E9A04A
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 14:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17FEA83CF2;
	Thu, 19 Feb 2026 15:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CEPTf15o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 567D083CF2; Thu, 19 Feb 2026 15:00:11 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA50883CEE
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 15:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45f171cb842so673950b6e.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 06:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771509606; x=1772114406; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DiCmrbnUple/yMq9ozuuD6BfwlECspkAHiKYX71AdBs=;
 b=CEPTf15o7j/lD0/xZ4VGXqQWWY7NYRyPB8S1vyStW93HfoYLQTCqWupqylraERyNPW
 iYc7j9BhD2RVT5OgA1LAgzqCHr+MRWfxltrHcVpsqE7MaJ9ZEzP1mqvJljuU7AHPaDD4
 vgFDEmOiJXE38mI4Dj1HX+wMwmb2GGeWScb5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771509606; x=1772114406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiCmrbnUple/yMq9ozuuD6BfwlECspkAHiKYX71AdBs=;
 b=Lsz4+b5nHylzcPcVfF0Cvqx7Lf0cujneNjRC4HZeBNybvd8dDzbDkf247ec7C2YsM/
 P7nFSSpUlSK8Bkl3DA5gaN7t2Anz9eAAHeyLoTarBCf5qky0GiEThCyxDME/r/iRblV7
 dPspBp3449m0K4OTBp0oT6Azyce3MnBXV0y9rehbXSQ9PFB2P/RfZsAdMLbfPxk+3UAH
 scJot0M+XcCxHLwSu8KOav32WhyfjP2wE8NIDuygnqm5viZ25BYBLFQTruoI3MJoNTbm
 MjxMm89RBxM8IBp6ALEu4xJMlg6cSm6Ue5ybdT6JwD6Jm/KX4OYeg53lnCVqUAMjsLOd
 AhsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4ztxaY/rwDvS3J4pycnm7OIy9MOSdPLXDGid+vHiS+4T8wGEq3XqZp49Jl5QiY1s9TgBgkPo=@lists.denx.de
X-Gm-Message-State: AOJu0YxBXrl3XhodRcDxmyqjtzTzTIBZ7HqmMUSjTG2MLkAzfy1NouIY
 lOMEEGqvchhFXCz50gQ++bjMUmS/v4UKH/AvAkIagoVB9RABWmP64YX1f8f6m1kMMpM=
X-Gm-Gg: AZuq6aIJTVPJr3IE9yIbgY24fi6IQqGBu19txRblP2zId55yncKIj1F0JpJbFmi1JfU
 Ll0ZqJUD0B6RSn+QFXB9dkkkxloyc9NkkOSeyiuDlEUODEm+oDgXS6+BA5/tbaADVevQ+1GxAWO
 OvNanDrx6P6q9hZUH1mhOWmOPgb10RogCI3vSNnQFK5NZFc1pychBFKMcd7iaZFJmcHF6VUbaaa
 Ju3Kp4JlKq5Fa4m2e0UAb1+KqU7GVoHMDw/O0DzWQweTOqfClJJm1Nx62uXiCVaqEckOn6eHGcV
 Z7EuvFXcud4+CNCP8E86p8PsTaMSE8DGZKEP6YVNMKR3AsnADIUpVu5BVHbjw6OiLULmu1DHwso
 tgFTfSOyJEw/YWUjWZEVKh1HPOtDbGPGq1ts/3G4+BVyN7gOHv4DazzvaoPa5y32DWuQ9L+XMFd
 RZErvkSxr3PjYF2SAxggmIWBhsJGpsx6yLtD1sn7x3VUsbFuZBPwuWv4CK+8kHyuM1UEErLS8TJ
 6nqVLZuYq57MJ5QHqHAVgBgcEO7r4w58l5kOWzRugUyoYUk6E4=
X-Received: by 2002:a05:6808:1a1b:b0:45f:1840:11f2 with SMTP id
 5614622812f47-464275b24b5mr816166b6e.22.1771509606345; 
 Thu, 19 Feb 2026 06:00:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c22d11a3sm15753171a34.6.2026.02.19.06.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:00:05 -0800 (PST)
Date: Thu, 19 Feb 2026 08:00:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
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
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 13/20] boot: bootmeth: add OpenWrt boot method skeleton
Message-ID: <20260219140002.GI3233182@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <46dcab5fc58e9116ca017a63ed07922ae3093913.1771275704.git.daniel@makrotopia.org>
 <CAFLszTiE82Bo1PbvK7Lx7P4Gq=-z+hhgLcgXORtSrYha4R7sBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kGYa9jQ5+Uef0qj3"
Content-Disposition: inline
In-Reply-To: <CAFLszTiE82Bo1PbvK7Lx7P4Gq=-z+hhgLcgXORtSrYha4R7sBg@mail.gmail.com>
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


--kGYa9jQ5+Uef0qj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 06:09:28AM -0700, Simon Glass wrote:
> On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > Add the initial bootmeth_openwrt driver with:
> >
> > - UCLASS_BOOTMETH driver, compatible "u-boot,openwrt"
> > - check(): accept block devices via bootflow_iter_check_blk()
> > - bind(): set BOOTMETHF_ANY_PART so bootstd iterates all partitions
> >   without requiring a filesystem
> > - read_bootflow(): stub returning -ENOENT
> > - boot(): stub returning -ENOSYS
> > - Kconfig: CONFIG_BOOTMETH_OPENWRT depending on FIT, BOOTSTD,
> >   BOOTM_STORAGE
>=20
> We don't normally write out this much detail in the code

I assume you mean the commit message? And yes, this reads like an
AI genreated (then human proof-read) commit message. Which is something
I wanted to address, once done with the open questions I still have in
the cover letter.

--=20
Tom

--kGYa9jQ5+Uef0qj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZcXXwAKCRAr4qD1Cr/k
Clf8AP0fZp5Dj9d54Mgr/6X+a8Jmxe3pAcCvqUJIO9bOLVy7AAEA81zeWK+iDmcT
x8LOidV3w0t6oZMnjyeFddwHBS0rxgw=
=Cv+I
-----END PGP SIGNATURE-----

--kGYa9jQ5+Uef0qj3--
