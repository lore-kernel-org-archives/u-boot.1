Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686FE10D148A
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 23:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E99B583C5E;
	Sun, 29 Mar 2026 00:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O6WHeExq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558F083CD3; Sun, 29 Mar 2026 00:01:02 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6D7883C14
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 00:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d86eb7c854so1770061a34.3
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 16:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774738858; x=1775343658; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tcdzzEJjpnNZrkNFJQUbAPO7Tuyj9RFeKs8GLCyh2mk=;
 b=O6WHeExq+s1Vk9NSZC3R0J9+16HkuH8YS/3K99HxUITagAgwb8l6FnHsYtcQC3mEvT
 64cNe4KhBC2ibk00ngveG+e4uFZBT3Q3KebmubWY+n+ZxT/5QJaQqt/fFFffkBvd3K7W
 v6QVsuwavRP4Rf43XAACNHLKRw9NnexLMXGxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774738858; x=1775343658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcdzzEJjpnNZrkNFJQUbAPO7Tuyj9RFeKs8GLCyh2mk=;
 b=Yj1xyGDg/iZFLlpFG5AkrS/Ffb4GKercK0T0UJkvxUJ9exdwyfdYrncwbSRyDbAEsM
 eo28KIymETUCXdxfQAJbuNI/syZaGk6o+B+vE3KseYAj2R6SeAtPyV3Ol+MU0h19Rsvx
 oY4XOBKq9gzeBf10LDo+8OQ7TDgvPE5EFISWJjDB18MvMz7UGowDDQypLfayrcmZMafo
 rKrpVZtvliaRMnNN1KCGcnRGTys6yK3/OHvr1VhO9x+qP+suog0ReKftt5P97wIGrOuI
 BQll2cj4AtElJa9rLh2osJ+BF4sFjhRZ/XH9lqD4fDuGA/iv9GT+/0wSIWHCtoXGJSHb
 EK3g==
X-Gm-Message-State: AOJu0Yx/9JqfE4Rs9VBhccXv9QqTZnycMQa56K1lRCT1XpxIz4wP7ovi
 SwRa1kUCAqBfLfX7lNS6BC/BdPBbPQdHA1eRySJmkmLX6urnqb7RPTIJlue9Az4AYYQ=
X-Gm-Gg: ATEYQzxIbcj612RUe0je1UZNAEkZGAcG8YHAhFPAUvAd5ZIYpnN2KHFl3LHwmBFeP3h
 BIs2xQShVsFfunGxjjHYCy/j36Rbu/LVuc5zqUISM+fXo2p3Nvx3cA7bTr22J9dybtj69oLqpJ2
 HQm3g4x3A92rtpemLGdRgNzOoRogRlrcfxCPDdXqzeYb274hHNCFz4efINDNxIo9eyKkLraLhOC
 QTQ1+GaLrUbwwI1dgVBCV6q1PtkM2FffxAOkB+yCVmU4ojM2JMr89vxohLMQ2YStxWEzC6eKw6h
 2E1gLr4Vsmql/E7W2jvSZwccHMBY4n4/avVgPJfaRPYJhGOIYfHO1Jts8kRCTBV8SSZywYm1L85
 8sUUUrIoYXgD3Hm4wRu0Jk+7ZvihYi80/MkCPZBKKb4jXd4krbK/mqBVSxX8Z8YlggMWJLx0urI
 SaXYmh6/DdDjkl6G05YhZCGJpcKSdDR86htpf2mfuCixNq1Dmj4HH/jSvD6TMQW6GwN1N6hexFv
 /UdByHHobSEhgMBAvQiltU3SB0+r6aVZdIhwzOO4yUcwdTq
X-Received: by 2002:a05:6830:6c11:b0:7d7:5818:66bc with SMTP id
 46e09a7af769-7d9fadda96emr3889241a34.10.1774738858553; 
 Sat, 28 Mar 2026 16:00:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a7b62dfsm2728943a34.16.2026.03.28.16.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 16:00:57 -0700 (PDT)
Date: Sat, 28 Mar 2026 17:00:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] arm: relocate: Introduce data-only relocation mode
Message-ID: <20260328230055.GA41863@bill-the-cat>
References: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
 <20260316145027.GK502704@bill-the-cat>
 <b1f8bc9f-13fe-4931-a6b3-ae494632dd77@mailbox.org>
 <20260316171026.GN502704@bill-the-cat>
 <23cb1b70-1657-474f-ad02-8b49db12d0de@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FGapwLNtDRdZBPja"
Content-Disposition: inline
In-Reply-To: <23cb1b70-1657-474f-ad02-8b49db12d0de@mailbox.org>
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


--FGapwLNtDRdZBPja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 01:03:15AM +0100, Marek Vasut wrote:
> On 3/16/26 6:10 PM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > > > > +config SKIP_RELOCATE_CODE
> > > > > +	bool "Skips relocation of U-Boot code to end of RAM"
> > > > > +	help
> > > > > +	  Skips relocation of U-Boot code to the end of RAM, but still =
does
> > > > > +	  relocate data to the end of RAM. This is mainly meant to relo=
cate
> > > > > +	  data to read-write portion of the RAM, while the code remains=
 in
> > > > > +	  read-only portion of the RAM from which it is allowed to exec=
ute.
> > > > > +	  This split configuration is present on various secure cores.
> > > >=20
> > > > Is this really configurable, or is this determined by the SoC? This
> > > > feels like something a board should be select'ing rather than
> > > > configuring and I do worry about boards abusing this in the same of=
 some
> > > > possibly dubious speed-up rather than the intented and valid use ca=
se.
> > >=20
> > > On R-Car X5H, the Cortex-M core U-Boot port selects this, the Cortex-=
A core
> > > U-Boot port does NOT select this. So, this is neither SoC level
> > > configuration nor board level configuration, this is SoC CPU core lev=
el
> > > configuration. I can definitely hide this symbol and conditionally se=
lect it
> > > on SoC level.
> >=20
> > At the high level, this sounds similar to the TI K3 platforms where we
> > have a Cortex-R build and a Cortex-A build and so (ARCH_K3 && CPU_V7R)
> > is valid in Kconfig. I assume there something similar in this situation,
> > so yes please, thanks.
> >=20
> > > > [snip]
> > > > > diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
> > > > > index 6ee58f4edfe..b6a648708f4 100644
> > > > > --- a/arch/arm/lib/relocate.S
> > > > > +++ b/arch/arm/lib/relocate.S
> > > > > @@ -79,6 +79,15 @@ ENDPROC(relocate_vectors)
> > > > >    ENTRY(relocate_code)
> > > > >    relocate_base:
> > > > >    	adr	r3, relocate_base
> > > > > +
> > > > > +#ifdef CONFIG_SKIP_RELOCATE_CODE
> > > > > +	mov r4,	#CONFIG_SKIP_RELOCATE_CODE_DATA_OFFSET
> > > >=20
> > > > Spacing. But if there's no other comments and propmting the user is
> > > > correct, I can fix when applying.
> > > Fixed in V2 .
> >=20
> > Thanks.
> Either drop this patch and wait for V2, or I will send a follow up ?

Sigh, I forgot about my own feedback here even, I'll revert this in next
shortly, sorry.

--=20
Tom

--FGapwLNtDRdZBPja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCachdoAAKCRAr4qD1Cr/k
CsSPAQDlwrR77qQ/G4FBcHLlxs6ZKsoxqqo+gTMHNGPNtBTq8AEA1tRgqptzOabl
4fIprCCCbIus+K+zhT5FzYfz7P4N0gM=
=U4i8
-----END PGP SIGNATURE-----

--FGapwLNtDRdZBPja--
