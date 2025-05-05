Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC4CC3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 21:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1263820E8;
	Mon,  5 May 2025 23:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W7X2utaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C76820EB; Mon,  5 May 2025 23:28:23 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2CCE80050
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 23:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72ec926e828so1363547a34.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746480499; x=1747085299; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wl+G6jEZQ7CmetayKnvlMcXWa9AK04KUZ8PDfRIlbjY=;
 b=W7X2utaJDOw5F/HfHqTWOfnQCSmmThV9vflmhJt2es2jC7TVj2VbkofFraVPiRUPZS
 4voD3mA5bwULx2w9+WoMAdUJxP4r+2f6WKtLHxxFqcNVgkAVIN7ac8pd2QAkNzOSl0IS
 u3TvYZVbZlJPrKO2WJ0o0z5vwKfPRMmh9CsEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746480499; x=1747085299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wl+G6jEZQ7CmetayKnvlMcXWa9AK04KUZ8PDfRIlbjY=;
 b=m+Wsp8mHqGJx4glz8457LPpoKHMpJPnekpxvsb0cQ+sL3yp+l+e1az28BGUPPayBXw
 CncCO0HUvuOsipRJqyg6AtJxlP/O00TOoL+uGI7g0NNyLyIcoyKpyJU9lj4ejl/CYSXD
 AEL9PFeO6fYmIcd1rTosNltxUq+e9HfhvObB6UMH9mOAuAEZP9yWvNT/NnEvsnzMK0JT
 Co4qbW1oSOH97Okqjg/Ylz03WJm6OTj9lyGPCGq0FXtnEhdZcdWYo6jTNmpceG9h/84Z
 C0iEvXnYAbbiQNnGUlzN5tFcYc0GAlX1IS1ub3v7SvKp0EyA1ZjJGkmBLDTtd8feNLp4
 cKjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc46LozSjCOQR6i9Y+z4uq+IHbvd8ZJrGKZanHJHJAwJEgRhXBUVvrOp3N29b2zLDev0OJ7D0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+EXjXsaeokWH91X5LgUqT2BE1RB7eorVmF/UfB7sy3YQbznkh
 uwwhATeXFrGImm9OFdBU5CE4iRHGktn0xB5puFS43MrvIlgN6slc+nOhGRTHxOY=
X-Gm-Gg: ASbGncuja6oP9grvm3uXxEdWL7uDLN/0p09sykskF0PvkRIAqZFEd1+JMRNKzGZMwg6
 YV+kDclYJS8RGi1BsO7JNnVGlx47WtJgtvb+iZtM9Aix96ykfujTShO/DiCOs0me6YhCDjjhL2W
 sNNbw7aOcz3FNkeySrvSxtW0YT4XNwohJmD1SSVeza5Ez4X+slMgpRI9jUz1HN/ic1wsdqiT+ZR
 vAz2Ot8/WrbJ86QUFwUmo19P/J6g/rRhsOzwAACE9n5ujKGwx1WRio/1+dfxsn7ufmJamfEb8wj
 cFxqImjkYwkwv4yWesPiu1C36SpAGOyIy5uAR9VJ/nMkwpXen72vnTY1SH9vQyZR0DA/J01tf5F
 xuw==
X-Google-Smtp-Source: AGHT+IG4RePttt7gt6Nv78fVaZMMlel9xL/RESyCWXRU8llLMz92sYFIIFSPCUJJyqUWM9GGnNxwZg==
X-Received: by 2002:a05:6830:6282:b0:731:cb3d:67e4 with SMTP id
 46e09a7af769-731eae448b9mr7856020a34.21.1746480499378; 
 Mon, 05 May 2025 14:28:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31cb7e1sm1713864a34.27.2025.05.05.14.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 14:28:18 -0700 (PDT)
Date: Mon, 5 May 2025 15:28:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: ravi@prevas.dk, brunosampaioleite@gmail.com, u-boot@lists.denx.de,
 probinson@gmail.com, mbrugger@suse.com, clast@prevas.dk,
 brule@prevas.dk, pbrobinson@gmail.com
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
Message-ID: <20250505212816.GP5430@bill-the-cat>
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
 <20250502144031.GT1261075@bill-the-cat> <87frhj5r32.fsf@prevas.dk>
 <20250505134843.GK1261075@bill-the-cat>
 <87zffq95f7.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="laa0f/CUZtYAwCnf"
Content-Disposition: inline
In-Reply-To: <87zffq95f7.fsf@bloch.sibelius.xs4all.nl>
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


--laa0f/CUZtYAwCnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 10:19:24PM +0200, Mark Kettenis wrote:
> > Date: Mon, 5 May 2025 07:48:43 -0600
> > From: Tom Rini <trini@konsulko.com>
> >=20
> > On Mon, May 05, 2025 at 11:45:05AM +0200, Rasmus Villemoes wrote:
> > > On Fri, May 02 2025, Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > > On Fri, May 02, 2025 at 01:34:33PM +0200, Bruno Leite wrote:
> > > >
> > > >> From: Bruno Leite <brule@prevas.dk>
> > > >>=20
> > > >>=20
> > > >> Currently rpi5 uses a generic rpi_arm64_defconfig file that builds=
 rpi4
> > > >> devicetree. Add a defconfig that is specific to the rpi5 building =
the
> > > >> now available upstream dts for that board. The defconfig makes use=
 of
> > > >> defconfig including that is now available and only changes the DTS
> > > >> related config.
> > > >>=20
> > > >> It is also necessary to add a more specific u-boot.dtsi to rpi5, s=
ince
> > > >> due to the ARCH_BCM283X config it will try to build the
> > > >> bcm283x-u-boot.dtsi and break.
> > > >
> > > > My question is, can we not adjust rpi_arm64_defconfig to be generic
> > > > enough and not have a problem on Pi 5 due to the default device tre=
e?
> > >=20
> > > Not really.
> > >=20
> > > What we want is to have CONFIG_DEFAULT_DEVICE_TREE to point at the
> > > rpi5's .dts file, because we really want to build that and not some
> > > "random" dts file that doesn't have anything to do with the hardware.=
 I
> > > know that kinda works for the setups where the .dtb built in U-Boot is
> > > not used for anything, but in our case, we really do want to use the
> > > .dtb from the U-Boot build - we inject various U-Boot specific stuff =
via
> > > the EXTRA_DTSI mechanism, e.g. public key for kernel verification.
> > >=20
> > > And due to CONFIG_SYS_SOC being bcm283x, and bcm283x-u-boot.dtsi
> > > referencing nodes that simply don't exist when building
> > > bcm2712-rpi-5-b.dts, the build breaks.
> > >=20
> > > Perhaps the real problem is CONFIG_SYS_SOC being bcm283x for rpi5? I
> > > don't really know why rpi4 is both bcm2711 and bcm2835 and what the
> > > difference is, but rpi5 only seems to include a bcm2712.dtsi which do=
es
> > > not include further dtsi files.
> > >=20
> > > If rpi5 has nothing to do with bcm283x, then perhaps a better approach
> > > is to ensure that CONFIG_SYS_SOC is bcm2712 when building for
> > > rpi5. Something like adding a CONFIG_TARGET_RPI_5 choice and adding a
> > > 'default "bcm2712" if TARGET_RPI_5' ?
> >=20
> > OK, so I guess my next question is, is rpi_arm64 useful enough in the
> > end for Pi 3 and Pi 4? I would have expected that it doesn't matter what
> > tree we build in to U-Boot as we would be using the one passed to us by
> > the prior stage firmware, and then update that at run-time as needed.
>=20
> Works well enough for us on OpenBSD.  And it would be nice if
> rpi_arm64 would work for the Pi 5 as well.

But that gets back to my first question. Can we correct the code such
that we do whatever is required at run time, as the previous stage will
have assembled and passed a correct device tree already?

--=20
Tom

--laa0f/CUZtYAwCnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZLXAACgkQFHw5/5Y0
tyx04wwAqUxdU8SzLM2Sjmpvs/OwQGusFA2rk7JKGglopj8ZAONBkwyAJjVaNDMH
Ro5BJejU5+dqYb5cddsClzFq08VJ8O2ev3h/PSZYceV+tbCFdUIeVWER2alznFms
VUM2ZF46/MoaSEhm4cLKbBxnB8pMTIEU4Nd6Pa/QBldnj3nnu4Pjhf7OR7CXPTY4
mC/mUGaJswhtkqVXOaejTlfaxmTOn6fqVU4tmfUrsSS2+5tcyCeavz7+77Ln8Azx
Ct8tNnLrs4SWVLS9Q2OKt3y0UZ5I9IRnVz+XfjEhyiXwF12sa3JIyKxI5km38PIb
WErQamdcmZgL4/X4HLlmZiXUtXow4kQz0+Ztyvh1c2Zao5PLhRAM4Bk8rC3dN+ym
gkyFwmBN2g510TAomDdKN2yDygm+hekuAWIiB0imOuI0T2uaVSAQ2E7jfxN8wzuM
p1YC9CFgLsaUAMce8+YOgu5LbWLAAV+QCZYzRnaX6pFejJVkFK40dBmEPe4IBQgB
+CGDLhfJ
=sX/7
-----END PGP SIGNATURE-----

--laa0f/CUZtYAwCnf--
