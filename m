Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3248CFD45E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 20:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED5983642;
	Wed, 25 Feb 2026 21:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gSmaZGe5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 470198366F; Wed, 25 Feb 2026 21:05:17 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD7B82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 21:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-66f3e7d9eccso125268eaf.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 12:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772049914; x=1772654714; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OCcYa8vobgmeD+sYirFBcRGwBsmPJH7bXf4XK3wdkv8=;
 b=gSmaZGe5VvsyaU9k7z9yoTmSXLucNzoz3BzhjygV+/gfByW8esfad00ln78wcgVltl
 6GHd4uV5wu/JtX0d/KVvYpJGxhemBMzVaY/hXR9non4uMlHhkwN0+meBFDmgPT1sloNW
 f4htcJWb69CYlLGEi9S8oue4oxxI6uDDEMntg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772049914; x=1772654714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCcYa8vobgmeD+sYirFBcRGwBsmPJH7bXf4XK3wdkv8=;
 b=qO6C8qkpIftb6Jgfd75uktKG842PWAPTGtFH2ewzRyD1ihhydCsu6PrI/iP8T+fUCM
 t7PSFKRGYnCa298abh437p0LMeaRGtBSEXiW9fIYV+GAC58PqlCdHTCC7/9LHJCHctHe
 Jal5c8Llr6Tw59DxzjOg9LbH8xT2B7WNsV9jpOrSjdlJ+wkaxvdu/oCstehANQpi4MRG
 hfDNyGcOX3QZNW0CXtQBt3sRC+Kstse05gLBUntSBfLxIR2peX5y0xl/KAVx6b+bv/DV
 /HrI1B8w9mDU05NMSwB0MT33x7jl44uGAvViMEd//yZAns+uPKxqQ6dyQkWnJ3d39tXE
 RkAA==
X-Gm-Message-State: AOJu0YyYQyW6Nzy3wstWw+xszflOXzdPiWGEwfapAFVgQZtpVdYk+OMC
 jZOgSTM4JYEBiCy7jPsEEMPGDnFVev+XqB3ZQuGRfc61Kt1sFBCXN9GmqCOMp29k6a4=
X-Gm-Gg: ATEYQzxnHzWtH9RT+RfNFYsbk11Qe/eBj6xcAgaqyV4WOxJVkjFqbPhIpeNTnR2fYs/
 Zf58Z4/H8cbN9zGRUG2vJJEFFNI27IlAIsOwEp4vhgMGB3b4ft7FWUiYnb0HOv4wrgbtWMGjNgO
 87pgDqVTeKtDw4qrPjj9PBXKfBLd5J6bTWpNIxrFsqQPM44CceT+G1ot2F6Ql39p5AZCOQS4Frc
 0hP2dPI7oat74DgrWVbhN5RY1cnyiYqD/pKwnOrW1VQI4SmQNbTklADHlkpzDMgYDUaY1IM0R69
 Ss7K2Dy2N56ugKv8shg5UjzEvAVI3S/QynNdpzJPSCeJ7BzVN/v8DtuZVTkLiVilCHQ+2x8RCD9
 WtwRJy+jsy5Sk+ml+VVwCZFgPlinLCRrEBOuBxhXCAMoGwZY3257K5Sw3gtgWZ+56v9TJ/gX2nr
 DzlbJfwLUuDPoVdttij/H0G3GBliw69XKPA87LyZwuyh9VDJhGajrwJiniQhc6lDaadVoBqwAtX
 gCUr0pwzSw+iVnby93ygRbKqPP4dzCNysCGY+Hz6Zv+vP3Kqio=
X-Received: by 2002:a05:6820:c98:b0:662:f8f6:e8d1 with SMTP id
 006d021491bc7-679c4489393mr9333020eaf.6.1772049913737; 
 Wed, 25 Feb 2026 12:05:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2a17bfbsm51416eaf.0.2026.02.25.12.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 12:05:12 -0800 (PST)
Date: Wed, 25 Feb 2026 14:05:10 -0600
From: Tom Rini <trini@konsulko.com>
To: "Nussel, Ludwig" <ludwig.nussel@siemens.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] bootm: fix booting kernel_noload image
Message-ID: <20260225200510.GV1593142@bill-the-cat>
References: <20260224155712.286317-1-ludwig.nussel@siemens.com>
 <20260224170551.GY3233182@bill-the-cat>
 <cd354716b6152c9831d21d70520e3fb06e570166.camel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aN4O8AkXgsv6nC/1"
Content-Disposition: inline
In-Reply-To: <cd354716b6152c9831d21d70520e3fb06e570166.camel@siemens.com>
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


--aN4O8AkXgsv6nC/1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 01:19:12PM +0000, Nussel, Ludwig wrote:
> On Tue, 2026-02-24 at 11:05 -0600, Tom Rini wrote:
> > [...]
> > So one thing I'd like to know is what makes your case different, so that
> > we can catch it in testing in the future.
> > [...]
> > I'm guessing in your failure case we're doing some huge allocation this
> > second time here and that's why there's not space later on for the
> > device tree? But it's also a little odd that in your ramdisk is now
> > being moved around, but perhaps that's because we detected an overlap
> > now? Can you share how exactly you're making this failure happen please?
> > Thanks.
>=20
> The test case I used is u-boot master built with just
> qemu_arm64_defconfig and a simple fit image that contains a gzip
> compressed kernel_noload and a ramdisk to boot=B9. The rpi test case has
> no ramdisk.
> Also I didn't want to specify any load addresses in the fit image to
> make the image generic.
> Yes, there is a huge allocation taking place when loading the ramdisk.
> The qemu default env does not have "initrd_high" set=B2 so=20
> boot_ramdisk_high() stays with "initrd_copy_to_ram =3D 1" and calls
> lmb_alloc_mem() to move the ramdisk.

Thanks for explaining. Yes, the ramdisk being present is what leads to
the failure here, I can see with a test image on the Pi a new LMB
reservation of:
 reserved[1]    [0x1000000-0x39dfffff], 0x38e00000 bytes, flags: none
which means we then get a failure over the ramdisk I added. I'll look at
this more and see if I have suggestions over your initial patch.

--=20
Tom

--aN4O8AkXgsv6nC/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ9V8wAKCRAr4qD1Cr/k
CqQnAQDI7Kg6vqLqWxOeSQzIX+VHv5ryacMO3RVY1fhLQhfGowD/YJhkQMXAdTe6
LXtkwQLADA6XCcg5rQxmDtNhPyVukwQ=
=+Fca
-----END PGP SIGNATURE-----

--aN4O8AkXgsv6nC/1--
