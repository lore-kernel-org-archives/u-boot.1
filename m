Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC988CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59FE281D6A;
	Tue, 30 Sep 2025 16:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JLqPIcM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CED183335; Tue, 30 Sep 2025 16:45:44 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1841B802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-911afafcc20so201228539f.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759243541; x=1759848341; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S0hPT+rjo8KSS/QFsQm2tov8QvGgXXvDi6DNVmEI89Q=;
 b=JLqPIcM8hygizTSKvFEqoLLmZbd5J/1m9+20dDJs1y8GXtv8ypPr/+EZI2tJpqvEC8
 G4fH9eul5u06PB36ccMxV1wXWN58+k+r7S7mOBXPeXfHVl/Is824R5s/nG/md919b6PP
 xtxKehl/gUKq5ht8oVhjawrOOg0ZMO8IPlPm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759243541; x=1759848341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0hPT+rjo8KSS/QFsQm2tov8QvGgXXvDi6DNVmEI89Q=;
 b=rpRn4CeSD73sVyH2FwRE6Ab5wU/bw5ay05yWMiTbMer02NtKVudhgQvrzcI0Ve/4Cz
 3/A497GPbu8kv9aWJx/hOjLFPLsukDYJj3eBaRn2JsY/kNHrhlf0qKL9Jfb6SrVr5wGa
 zdbRM8ccD+abK4evg8pK3cP81unHzDnpTxjmj1yYytR/eOe9fRgQeJ2b1cVGRKtWVqHT
 yAeeZVM+8FPPrFPLUGgXAe6mzH8mWcHa5paC/GF7oOBdYf6nhD1yWvVHdSs8q1oyOD1p
 pEcifWH5gyabP3A8A4GQmW3Wmlrso011+DGADl4chRtrL2wIQAVZ9p+uo+yGFyMW8can
 9jxQ==
X-Gm-Message-State: AOJu0Ywks9MCu12AjcIPgeweS6kVAFt0OlQlZJ7S+XZB9YpNARxBaDhc
 H47e8TV+j6EAEN8iIte2FibygYIwqjItaok56ldcVjwnWfIw4hAgtz6h9+sdgTGTFHw=
X-Gm-Gg: ASbGnctFuZC8vj92FyBm+Pb6Bs97EZ9x5IULp6ojx7qkwHovQ1mfP5Jf6P5A7CvC35g
 5O0ELhxpI0E5R2J9A5VltXPTRExlWrw0l/KSP+GhNKW/oTQk5NnGUb2PkZ7nxHxMMCOf7EidfNK
 zAIYF29pFSb2DKeskOfVMWJVu5rwq7JpLW8/vsDUl37ihZmDczuIY7lA9Va17Hbmxr3VbQxW7c5
 gJN82j81UafFK/R0nrCNyE4x7rN2DPHQwQT48E+u0zILyBTRorTg8BNT/TAZa64Ov0GiJe7y3NT
 aE5b9T8rdqvw0n4g1RCV5289kcOFRVcBg+u5B40a29zCk7CFlKcKTQnEz6AY5FBnQKIR2ch/wr/
 1ARa9zZ1rSoGk/loTSD468ll6Y7DPQLR9dMxqXJ96N6XC+lIs3sKgcW8Nrxs9QFp0Zhgmg8immb
 P84afX
X-Google-Smtp-Source: AGHT+IH/67dpbotRVVd7QnWBoWMgeh5Fs1qW6/wid4bNpxHCa5qyz2h12bY6vF4yDUAZ15O6zUghXA==
X-Received: by 2002:a05:6602:1505:b0:929:a709:911d with SMTP id
 ca18e2360f4ac-937a70ef909mr5225639f.2.1759243540679; 
 Tue, 30 Sep 2025 07:45:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-936ededd218sm17843939f.6.2025.09.30.07.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 07:45:39 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:45:36 -0600
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
Message-ID: <20250930144536.GX6093@bill-the-cat>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-3-pro@denx.de>
 <20250905141959.GJ124814@bill-the-cat>
 <aNuVyd1aSwdHw1vq@aristophanes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vBskLS24AYTLESrz"
Content-Disposition: inline
In-Reply-To: <aNuVyd1aSwdHw1vq@aristophanes>
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


--vBskLS24AYTLESrz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 10:33:13AM +0200, Philip Oberfichtner wrote:
> On Fri, Sep 05, 2025 at 08:19:59AM -0600, Tom Rini wrote:
> > On Wed, Sep 03, 2025 at 12:56:50PM +0200, Philip Oberfichtner wrote:
> >=20
> > > Use a consistent logic for image size checks. No functional change.
> > >=20
> > > Before this commit, there were two concurrent approaches of how image
> > > size checks are disabled: Whereas BOARD_SIZE_LIMIT was gated through a
> > > dedicated Kconfig symbol to achieve this, all the other size checks w=
ere
> > > disabled by assigning them a limit of zero bytes.
> > >=20
> > > By this commit we achieve a consistent logic for size limiting, by
> > > introducing CONFIG_HAS_XXX_SIZE_LIMIT for all those options that don't
> > > have it yet.
> > >=20
> > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> <...>
> > > diff --git a/arch/x86/cpu/apollolake/Kconfig b/arch/x86/cpu/apollolak=
e/Kconfig
> > > index 5dd866ffcfe..d70e8def36f 100644
> > > --- a/arch/x86/cpu/apollolake/Kconfig
> > > +++ b/arch/x86/cpu/apollolake/Kconfig
> > > @@ -78,8 +78,11 @@ config MMCONF_BASE_ADDRESS
> > >  	hex
> > >  	default 0xe0000000
> > > =20
> > > +config HAS_TPL_SIZE_LIMIT
> > > +	default y
> > > +
> > >  config TPL_SIZE_LIMIT
> > > -	default 0x7800
> > > +	default 0x7800 if HAS_TPL_SIZE_LIMIT
> > > =20
> > >  config CPU_ADDR_BITS
> > >  	default 39
> >=20
> > These should be "default y if .." in the main Kconfig entry for the
> > option.
>=20
> Not sure if I'm following you here. So you mean both of the defaults
> should be moved to common/spl/Kconfig.tpl? - like
>=20
> 	config HAS_TPL_SIZE_LIMIT
> 		[...]
> 		default y if INTEL_APOLLOLAKE
>=20
>=20
> 	config TPL_SIZE_LIMIT
> 		[...]
> 		default 0x7800 if INTEL_APOLLOLAKE

Yes, like that.

> > > diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_=
defconfig
> >=20
> > The reset of these, to Marek's point, show that we need to also add
> > "default y if .." for a number of other platforms too.
>=20
> Which platforms exactly?

So the platforms today which have a default ..size.. if SOC should also
be listed as default y if SOC, is that I was I believe getting at.

> > At least the ones
> > where today we have default limits provided in Kconfig today.
>=20
> Besides the ones handled above, i.e.
> 	arch/arm/mach-socfpga/Kconfig,
> 	arch/mips/mach-mtmips/Kconfig and
> 	arch/x86/cpu/apollolake/Kconfig,
>=20
> there aren't any.
>=20
> I myself am not very fond of changing that many defconfigs, but I still
> don't see a way of avoiding it. I guess it would become more clear if
> you concretely name a few examples.

So, part of the pattern is that we should take this from
common/spl/Kconfig:
config SPL_SIZE_LIMIT
        hex "Maximum size of SPL image"
        default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
        default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
        default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
        default 0x0
        help
	  ...
And it becomes:

config HAS_SPL_SIZE_LIMIT
	bool "Enforce a maximum size of the SPL image
	default y if ARCH_MX6 || (ARCH_MVEBU && ARMADA_32BIT) || \
		ARCH_K3
	help
	  .. What we had talked about in earlier threads to be clear about what
	  .. is / isn't checked by this option.

config SPL_SIZE_LIMIT
        hex "Maximum size of SPL image"
	depends on HAS_SPL_SIZE_LIMIT
        default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
        default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
        default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
	help
	  ..

And note that I've added ARCH_K3 to the list here because from a quick grep=
, TI
K3 platforms also set SPL_SIZE_LIMIT and so with this, you won't have to ch=
ange
all of those defconfigs as well.

--=20
Tom

--vBskLS24AYTLESrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNvtEAAKCRAr4qD1Cr/k
Cs9kAPwJHFADbuIIfZalF9EuoTjLjogFdcpbob0h855NJBy/lwD/Zskr1JSS9u4Y
vG0oQ8K/a93VPh2e6GHQXabQT4K/wAM=
=csqz
-----END PGP SIGNATURE-----

--vBskLS24AYTLESrz--
