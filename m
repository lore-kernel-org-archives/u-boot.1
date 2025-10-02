Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAABBCAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 21:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1403E834D4;
	Thu,  2 Oct 2025 23:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aL8RfPZN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3AE483642; Thu,  2 Oct 2025 23:19:17 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B84A833F6
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 23:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-42e726431bdso3994085ab.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759439954; x=1760044754; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h7R/f0DWuBdFawo0KFAzJJQPPr3hiFn/4228bnwtA7I=;
 b=aL8RfPZNlHXm3rZh7BXRt4yp/r3nksR6mINx8hjIwk/kgMo/lOg5ns662eZFOBFx/3
 x75hnr+ns9rYvUOB+FVor90Ve2ZTmYJSAQ9EJD9wvha12r1TSxi3N/s85v+FaQw6c2Hq
 ipu1uRyvzEIWqR+MjKUq5wbULduWVxxW2r0Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759439954; x=1760044754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7R/f0DWuBdFawo0KFAzJJQPPr3hiFn/4228bnwtA7I=;
 b=JLoqcPVFwsST3umMmwVwU021d5S6Zy0dKu+OMSVQeaORYjI8DIEjuem/HGIXOvSyrT
 i+70KHUNV8jqY9wSNGa6/ZSglN4fqLmHaFqGL2ddDbk10sQjpG9Cit3NkRKvqpGFzn++
 bk+pirS/DOlc3tGBNUdwEDI7A7XzygOk953AERcA5UL436oOa+qO2X/Q4pXqXAzVNyPi
 UZxgqjXa6hgL7Tfsz5uF1hCq7OCD3yzwcmdqQopfKShku26KwWlUVmFCAJQagCtgFQFY
 4KevcPXEZX/UzCCUtNIbSbHS2vb1/ye2qgyvSc9KsiBJP5Jk3hCzutSkQfDF1Cj3omds
 pYRA==
X-Gm-Message-State: AOJu0YzHxMRFvLp+mO4Eq2S8mdBPZmaB3214bmRZq1xHloGVVOHklLu3
 x8HCjPTZsEPi98MvNxZM758Tmls/8MlZBj3yINYZnAecac7H1Q54yrxHppNc23N+c/0=
X-Gm-Gg: ASbGnctBitgCCIxGkhOdGWchU3ulDR3N1om11zLRd3q4j8G2R3KGd/cl1FT1n8+rR2K
 VcoOof886mUlWjTzcnIduAjJAaUmfulLF0hZ7tL2RVBjNMD9xt2TAzTn9OJEO0WZUdcmP/cZ6Pf
 BmfdwVajEzhIaIBIb2TRdC2+3Z+qe8qxfhN4GKuzI13t8XmvHyM0Ak0yu4LU4Hjm9bPKRMPigNl
 nJuub/hFbgPPdU75cgOzQjiot8YXAhV7XBHrRBXLy1Em12iZdp9DwMRq0mRVZK4kod9xCjFm/AR
 YaT12lNJN/GX2HPGtWVF9Ls/N8j/Tb4Uwe/lp8EeO+44UoGHWcJZEmDvxXbiNyRDUicdRXLgNZK
 gytjzNWvKIut4jFBhUd92i0mxel43MAl1jyCyPAbYhtKkdCvLwMmkdhXJCA6jHk6QCH04nEZYPP
 Y0JqmlppEttxlt1lb8Vo3G
X-Google-Smtp-Source: AGHT+IHu4zELWoucUPvRlvLPX1k8F5uhqvb/DhpBg1lUdrBUTIUj4xWGvncinIOxFKxu1VhRxvdy0g==
X-Received: by 2002:a05:6e02:1706:b0:425:849c:52fa with SMTP id
 e9e14a558f8ab-42d8b24ad5bmr44185065ab.15.1759439954005; 
 Thu, 02 Oct 2025 14:19:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec5d131sm1190008173.73.2025.10.02.14.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 14:19:13 -0700 (PDT)
Date: Thu, 2 Oct 2025 15:19:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v3 2/5] Image size checks: Use HAS_SIZE_LIMIT consistently
Message-ID: <20251002211910.GR6093@bill-the-cat>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-3-pro@denx.de>
 <20250905141959.GJ124814@bill-the-cat>
 <aNuVyd1aSwdHw1vq@aristophanes>
 <20250930144536.GX6093@bill-the-cat>
 <aN49929JEJpWdOee@aristophanes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZPJp/Y+CeXtuwIOX"
Content-Disposition: inline
In-Reply-To: <aN49929JEJpWdOee@aristophanes>
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


--ZPJp/Y+CeXtuwIOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 10:55:19AM +0200, Philip Oberfichtner wrote:
> Hi Tom,
>=20
> Thank you for the clarification.
>=20
> On Tue, Sep 30, 2025 at 08:45:36AM -0600, Tom Rini wrote:
> > On Tue, Sep 30, 2025 at 10:33:13AM +0200, Philip Oberfichtner wrote:
> > > On Fri, Sep 05, 2025 at 08:19:59AM -0600, Tom Rini wrote:
> > > > On Wed, Sep 03, 2025 at 12:56:50PM +0200, Philip Oberfichtner wrote:
> > > >=20
> > > > > Use a consistent logic for image size checks. No functional chang=
e.
> > > > >=20
> > > > > Before this commit, there were two concurrent approaches of how i=
mage
> > > > > size checks are disabled: Whereas BOARD_SIZE_LIMIT was gated thro=
ugh a
> > > > > dedicated Kconfig symbol to achieve this, all the other size chec=
ks were
> > > > > disabled by assigning them a limit of zero bytes.
> > > > >=20
> > > > > By this commit we achieve a consistent logic for size limiting, by
> > > > > introducing CONFIG_HAS_XXX_SIZE_LIMIT for all those options that =
don't
> > > > > have it yet.
> > > > >=20
> > > > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > <...>
> > > > > diff --git a/arch/x86/cpu/apollolake/Kconfig b/arch/x86/cpu/apoll=
olake/Kconfig
> > > > > index 5dd866ffcfe..d70e8def36f 100644
> > > > > --- a/arch/x86/cpu/apollolake/Kconfig
> > > > > +++ b/arch/x86/cpu/apollolake/Kconfig
> > > > > @@ -78,8 +78,11 @@ config MMCONF_BASE_ADDRESS
> > > > >  	hex
> > > > >  	default 0xe0000000
> > > > > =20
> > > > > +config HAS_TPL_SIZE_LIMIT
> > > > > +	default y
> > > > > +
> > > > >  config TPL_SIZE_LIMIT
> > > > > -	default 0x7800
> > > > > +	default 0x7800 if HAS_TPL_SIZE_LIMIT
> > > > > =20
> > > > >  config CPU_ADDR_BITS
> > > > >  	default 39
> > > >=20
> > > > These should be "default y if .." in the main Kconfig entry for the
> > > > option.
> > >=20
> > > Not sure if I'm following you here. So you mean both of the defaults
> > > should be moved to common/spl/Kconfig.tpl? - like
> > >=20
> > > 	config HAS_TPL_SIZE_LIMIT
> > > 		[...]
> > > 		default y if INTEL_APOLLOLAKE
> > >=20
> > >=20
> > > 	config TPL_SIZE_LIMIT
> > > 		[...]
> > > 		default 0x7800 if INTEL_APOLLOLAKE
> >=20
> > Yes, like that.
>=20
> Ok.
>=20
> >=20
> > > > > diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm=
_r5_defconfig
> > > >=20
> > > > The reset of these, to Marek's point, show that we need to also add
> > > > "default y if .." for a number of other platforms too.
> > >=20
> > > Which platforms exactly?
> >=20
> > So the platforms today which have a default ..size.. if SOC should also
> > be listed as default y if SOC, is that I was I believe getting at.
>=20
> Yes, this part is already included as of now.
>=20
> >=20
> > > > At least the ones
> > > > where today we have default limits provided in Kconfig today.
> > >=20
> > > Besides the ones handled above, i.e.
> > > 	arch/arm/mach-socfpga/Kconfig,
> > > 	arch/mips/mach-mtmips/Kconfig and
> > > 	arch/x86/cpu/apollolake/Kconfig,
> > >=20
> > > there aren't any.
> > >=20
> > > I myself am not very fond of changing that many defconfigs, but I sti=
ll
> > > don't see a way of avoiding it. I guess it would become more clear if
> > > you concretely name a few examples.
> >=20
> > So, part of the pattern is that we should take this from
> > common/spl/Kconfig:
> > config SPL_SIZE_LIMIT
> >         hex "Maximum size of SPL image"
> >         default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
> >         default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
> >         default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
> >         default 0x0
> >         help
> > 	  ...
> > And it becomes:
> >=20
> > config HAS_SPL_SIZE_LIMIT
> > 	bool "Enforce a maximum size of the SPL image
> > 	default y if ARCH_MX6 || (ARCH_MVEBU && ARMADA_32BIT) || \
> > 		ARCH_K3
> > 	help
> > 	  .. What we had talked about in earlier threads to be clear about what
> > 	  .. is / isn't checked by this option.
> >=20
> > config SPL_SIZE_LIMIT
> >         hex "Maximum size of SPL image"
> > 	depends on HAS_SPL_SIZE_LIMIT
> >         default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
> >         default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
> >         default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
> > 	help
> > 	  ..
> >=20
>=20
> Ok, I agree until here, but ...
>=20
>=20
> > And note that I've added ARCH_K3 to the list here because from a quick =
grep, TI
> > K3 platforms also set SPL_SIZE_LIMIT and so with this, you won't have t=
o change
> > all of those defconfigs as well.
>=20
> concerning ARCH_K3 I do not yet agree:
>=20
> 	git grep -l ARCH_K3=3Dy configs | wc -l
>=20
> gives me 54 ARCH_K3 platforms. But only 24 of them use SPL_SIZE_LIMITs:
>=20
> 	git grep -l ARCH_K3=3Dy configs | xargs grep -l SIZE_LIMIT | wc -l
>=20
>=20
> So if I'm not mistaken, we cannot set default HAS_SPL_SIZE_LIMIT for
> ARCH_K3.

Some of them use different limits.
$ ./tools/qconfig.py -b
=2E.. wait
$ ./tools/qconfig.py -f ~SPL_SIZE_LIMIT ARCH_K3
0 matches

So no platforms set ARCH_K3 and do not set SPL_SIZE_LIMIT.

--=20
Tom

--ZPJp/Y+CeXtuwIOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaN7sSgAKCRAr4qD1Cr/k
CuN7AP0UAiKVPHYPCIoo+/Gj8QskX+XoxEdVNwoaeRCSegpsnwEAgGur5P6p42R1
wRHRv31LoODK9gXojWeXDMn/WwmiFw8=
=Yuto
-----END PGP SIGNATURE-----

--ZPJp/Y+CeXtuwIOX--
