Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0196CC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D100848BF;
	Thu,  2 Jul 2026 22:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PrOpiWH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC6784A5F; Thu,  2 Jul 2026 22:57:35 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3AEE843B6
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e9ed64d490so951938a34.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783025852; x=1783630652; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HAH1ypOcGINf2ytWAy0ntPR2Lb4z2qd7gLdWFFtqqTI=;
 b=PrOpiWH6g5zYSRmUW2lJhst88lwFO3CU3VG+EyGKR2QSeXFkGLgKuES9sr+BCYx44e
 01PKlSylpAepq6PWKBVO2KiLl32r2NanX505gRphG280+bJvRq8ZlAf3PX8gEez9/2zG
 KA7SGqypQxgoUT7F+aQYKqiyd2BFHJoySwqlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025852; x=1783630652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAH1ypOcGINf2ytWAy0ntPR2Lb4z2qd7gLdWFFtqqTI=;
 b=gUI6yJ/+dlESrF16JRPJH3DbHbLPCOZh4am8eod2BCtwxbwtQPI3LtMUGraMIP1sDc
 xkfYe29BhP4IK1MTi4zHTM7ptI2oc/hkN78uwAe8gLt6DTFzB+c46jb1W5tqv4G4WVnZ
 L7So1bJQdP2HcKmwXbL2lyFn4yWV8S0F0ZcQ/ZLzixOftMydMlqLJepIC5YcvxmrEkU1
 sopINR7stQKegsLnWkCRjsWexKm6/Kv1Byeyleody+aPzqwVGL+i4q60vpmoHXAgl3vT
 A8Ui3YiX96kraPEM2v6t1qJS7OTdFnMCd1lQ25qO6PpGkl6lkpAiJkpJyp2yVo7tfWbw
 1ZjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fyC7NIL/8CLECjduOUPCYSKB0BrdsRM8c8zpm3i6kJBrNWmLK4y2ihUNjCCuUVEnj7zUfOPU=@lists.denx.de
X-Gm-Message-State: AOJu0YxxWWb143LtR793SGl8N7WvN2CObIxSscYAjKlPXQzBpv8U2xMk
 mCgn5I7imZzig6HslOaLeZBfTsD7yPup21DdR9WcFStT0h4DZvtZEulqsZYskzSRiHo=
X-Gm-Gg: AfdE7clBGHtTyGw/2/CxSsO0p96mwoL1/C//kmO90ikqALK8qGQ6f6I+idkcyFj64ji
 EfTyogPSibf1y9XGAjkhfVz8ZGXI3EMocA/7fddCjXOM3wFLmDNb+ehJJTjqzNZmpZdVZ996WY6
 yGNQz6l+aDi61UMZZQr50XtG9aD4VVdruaxaWySJpmOQY8172LVH8vfyoV4+QvvqV3KsxbQhL2j
 1/pW0gTlT0PlXSsqBIXvWYvhRqPZkO14jGq+KVzqZEQHSP947Av8tUlTocMDwVbpp5PBxuYr28N
 Q5R7TkOTP4ykfG7/hcWIvh1/wrbpsJz/UJRJkln0f8IieOIJrH3kG5laKscy3nK44R9EEa/84pu
 +2Mzp+FLfOsM6QC7ea/mmjNcKRuMHWa2dO79yaaQLgSGguIzYC3tdfFwSgpQ6NnuilPjxh+l01n
 0D2B4cx4wWaqTgGc4yLY4RPVqPP0Gn+65YfDDjQWCYfe+ukxvbl8mAlGzZ0P67Co86V5yLu9ay2
 qV0Qnli7d0DXS4rlgdw3COGB8y2Zm0wp3JxOkhMFPQSYEYI
X-Received: by 2002:a05:6830:83b5:b0:7d9:f50f:96ad with SMTP id
 46e09a7af769-7eb4cc4fd87mr5080845a34.24.1783025852310; 
 Thu, 02 Jul 2026 13:57:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54291227sm3417937a34.3.2026.07.02.13.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:57:31 -0700 (PDT)
Date: Thu, 2 Jul 2026 14:57:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 06/16] LoongArch: skeleton and headers
Message-ID: <20260702205729.GF749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-7-me@ziyao.cc>
 <20260701174700.GO749385@bill-the-cat> <akbMS_bAY2s0AL7l@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ne5/UMWSBE1kMnbD"
Content-Disposition: inline
In-Reply-To: <akbMS_bAY2s0AL7l@pie>
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


--ne5/UMWSBE1kMnbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 08:40:24PM +0000, Yao Zi wrote:
> On Wed, Jul 01, 2026 at 11:47:00AM -0600, Tom Rini wrote:
> > On Wed, Jul 01, 2026 at 11:17:58AM +0000, Yao Zi wrote:
> >=20
> > > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >=20
> > > Commit for directories, Kconfig, Makefile and headers
> > >=20
> > > Some of them are copied from linux, some of them are derived
> > > from other architectures, the rest are wriiten on my own.
> > >=20
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > > ---
> > >=20
> > > Hi Heinrich,
> > >=20
> > > I kept the naming of CONFIG_ARCH_LA64 (instead of using the full name
> > > ARCH_LOONGARCH64) since it's shorter, and we already have similar
> > > CONFIG_ARCH_RV64I, and etc. in U-Boot. Is is okay for you?
> >=20
> > We should use CONFIG_LOONGARCH here, to mirror the kernel I think. The
> > CONFIG_ARCH_ namespace in U-Boot maps more to the usage of CONFIG_ARCH_
> > in the kernel, for ARM (and ARM64) platforms rather than describing a
> > CPU level architectural feature.
>=20
> Oops, to make it clear, we do have a CONFIG_LOONGARCH symbol to
> indicate LoongArch platforms, and CONFIG_ARCH_LA64 is for
> distinguishing LA64 with LA32 and LA32R variants which would be
> introduced in the future, just like the case of CONFIG_ARCH_RV32I and
> CONFIG_ARCH_RV64I. Does this make sense for you?

Ah, OK, yes, that makes sense, thanks for explaining.

--=20
Tom

--ne5/UMWSBE1kMnbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakbQuQAKCRAr4qD1Cr/k
CmErAP0ROxvZEfA6pDDww3DBtpGXIwGEEUvL0L5/Cs+O3g9rOgD+IjQO0M+SAIUi
1BsyH8k/r5zurDlYTmMS3E8D6MbceAU=
=WhEC
-----END PGP SIGNATURE-----

--ne5/UMWSBE1kMnbD--
