Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ED0CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 14:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E658839DE;
	Wed,  8 Oct 2025 16:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HtDvO9o0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF9183F6D; Wed,  8 Oct 2025 16:56:29 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA6D0839DD
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 16:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6456dd98f36so3776202eaf.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 07:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759935385; x=1760540185; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QIJUcd5ndvcvrXlJ3hN2SIrf1BKxbd2ln3oN49i6fbk=;
 b=HtDvO9o04nrbWkLFKZAC7grPj+NPe868jTa8UVVRlmmwH7mXiU7244WsTd8mjgNaRz
 qO947KdBFMnhDsNM8nILElPYBkR5OcgvgecTg3yU/QhzhsGOA78R3Fk/OwUezbIa9PeK
 c5my2KXI4l7q+KVRSV2znnm6GrKcIx2sZo9HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759935385; x=1760540185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIJUcd5ndvcvrXlJ3hN2SIrf1BKxbd2ln3oN49i6fbk=;
 b=iQHd90WgSlPSDWGaFKlUm2kVzHspNPHwz+3mmdmuTLVl01h9qZNHltG+i57iS6SyNp
 i6PwOQuz9ED7Ll66DetL8Zw34xs9Dajds0GEdXgixYJTQ6DNWvM1ULPTZ4AR4tHi06/T
 znB0/2iqQOVRgrTt8/xqumRyq1PNRNR49kOltBU5ecPiw5WHhzGpCUGOzwt3oJ2ncE/Z
 W9/ggjiR91mj32pPKaGHU15mSIXl2tKBjBsHTXhzoSBO3y1v8DWM5KzryNdGEX+T6e4J
 c4AhiH/Il5wWNlW+d8hG+Y1INS5I7Ouo/bwgumkOeMYY7XUsjjptZUAJmH6uTRyW3gL9
 NApw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN83RQ2FhStfzGGSUqBKUmeRPi6qOZtGXJxJNJeFzJ/dq0BDKVqPzrk/KNQLbOQJQJLGw+NWQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5DUQXt1YKgNo1Selc2xcUp79u4WlYLBfyqo16p/2ugCw7fyaP
 cO84jicM25uHY6KodVXOzZzywkHlyk/neYcghtBLYgmUmxfnc67YsUsGHxEcPVw/u0M=
X-Gm-Gg: ASbGncvLKWMOpQCtEq8Chgnk9/zRXLl/xZe0S0IfcC0Gg5kEkSBRqfEP6iut06nMCZ7
 mR/vkL2Y2fUQm2pScsWA2cK+9Q/lk2PUuQJjdsaHzVv8a9X8TRHLMRCcV2fGSK/D6XpHvNWGtcF
 gMPcD9Pfz2l8k4miJ0IgXx/BJ+iVFUaMbS3BJfhyWj1dIYgLRKRbApzLkmAjtikuUQURf1AmE39
 kBwtYxrZ6tycQfTgA+xu9nd0Iu2M0dGW9ho8kwKOw32wWqqGA9mmnp4rocQXwuvqWElbyBI4Res
 voG0YS3C01NINpiD5ZkciTl+NxrAjVLFKzVuprkxP2cBtRlDwZw8SVMcqiP5OjLVIoUrRwBEIuY
 3UvlzX2QDrE8Z/rGjJTmz2dhQK/0HDCOQDkbl1NEjNHoW/UKyu9q/osepFsDR9PWDHnnIj/Vhj+
 oHFAhO6Hjfyw==
X-Google-Smtp-Source: AGHT+IGZxHf79C6P9SBCMDxDlcwcM9dokP3m294gw1LblcOPsdyw10cYGMTRPRWuqt3INFdPNApgeA==
X-Received: by 2002:a05:6870:2108:b0:366:891:7be4 with SMTP id
 586e51a60fabf-3c0f6af2834mr2211916fac.15.1759935385600; 
 Wed, 08 Oct 2025 07:56:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab7ce5655dsm6195845fac.13.2025.10.08.07.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 07:56:24 -0700 (PDT)
Date: Wed, 8 Oct 2025 08:56:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>,
 Mugunthan V N <mugunthanvnm@ti.com>
Cc: Dharma Balasubiramani <dharma.b@microchip.com>, u-boot@lists.denx.de,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] ARM: dts: sam9x60ek: select PIT as tick-timer
Message-ID: <20251008145622.GW298503@bill-the-cat>
References: <20251008055636.17462-1-dharma.b@microchip.com>
 <4f2bcf39-2b8b-423c-8b36-db9a65573248@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p2talMQn7pz1G5m+"
Content-Disposition: inline
In-Reply-To: <4f2bcf39-2b8b-423c-8b36-db9a65573248@linaro.org>
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


--p2talMQn7pz1G5m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 10:21:41AM +0300, Eugen Hristev wrote:
>=20
>=20
> On 10/8/25 08:56, Dharma Balasubiramani wrote:
> > U-Boot currently enables the UPLL during boot, which triggers a udelay()
> > call that depends on the system tick timer. Since no explicit tick sour=
ce
> > is defined in the device tree, boot stalls on this board.
> >=20
> > Define the "tick-timer" property under /chosen and point it to the PIT
> > node, ensuring U-Boot uses the PIT as the tick source.
> >=20
> > Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while r=
eparenting")
> > Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> > ---
> >=20
> >  arch/arm/dts/sam9x60ek.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm/dts/sam9x60ek.dts b/arch/arm/dts/sam9x60ek.dts
> > index 6521585ee9c..1c09c92ae18 100644
> > --- a/arch/arm/dts/sam9x60ek.dts
> > +++ b/arch/arm/dts/sam9x60ek.dts
> > @@ -17,6 +17,7 @@
> >  	chosen {
> >  		stdout-path =3D &dbgu;
> >  		i2c0 =3D &flx0;
> > +		tick-timer =3D &pit;
> >  	};
> > =20
> >  	clocks {
>=20
> This property is not in Linux DT and not documented in Linux.
> Please move it to sam9x60ek-u-boot.dtsi

Oof, yeah, that belongs in the -u-boot.dtsi and long term we need to
rename it to u-boot,tick-timer and upstream it.

--=20
Tom

--p2talMQn7pz1G5m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOZ7lgAKCRAr4qD1Cr/k
Cp5eAQCUCpMDn0lgp5qOViaVJ348dyLWRNgxuTp8kPgDI0bQvAD/c3/5e66OHgOS
mcI/niv3yrY5EAB3oA/DfVb1Zfj7BQA=
=xrhk
-----END PGP SIGNATURE-----

--p2talMQn7pz1G5m+--
