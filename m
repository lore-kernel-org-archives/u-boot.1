Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884C0E677EF
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 16:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD1CC83B99;
	Mon, 22 Dec 2025 17:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rKhl5p+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D8E683D1A; Mon, 22 Dec 2025 17:20:32 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62E6183B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 17:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3ec5df386acso3035228fac.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766420429; x=1767025229; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U9RvC4nlHs12D9i171XV9Mnuvk921hcXcV/MRhS3ekc=;
 b=rKhl5p+qvnFUz+9Dik13iAPITYkt/iJWH7623RL2LFA5TOxJoxK2MireAEq2mmWU2c
 fYTejgGnRqoZQSmhE3pz8u48AyUOZYlR5pM9EnRaZnlWDBYwGffoNVqjiwmH5ARb89+x
 DkqEe3/lKiekoqEqXhzxKBs8NqrmlWembtKV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766420429; x=1767025229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9RvC4nlHs12D9i171XV9Mnuvk921hcXcV/MRhS3ekc=;
 b=OhJGJOckNGy7D1zPnT0SschKHwBiWSTdtJ3OdykcGVG0U7vx1oGDr1I3dLGSTsvTUR
 bHJ5WikucvCYPVes2qNHr0uCKkv5aBN1gC29ucSkU12TCJ7YtyMTqIwocBludCoyLibT
 x5F7tA/ujoxn/JIQLOZDpLl3LYFCrG/EgMQKzgvSm6ma4pRByGqwHKHjJWdqjsSZdXcu
 6V+N8Gb6F+RCKSPrSC2kl0usGmf0Sq+CGe5bMzF/NYUBVeGYu8wuauPkjLcWiKE0tOSJ
 +QTv3kqHmulbiqtlG32u/M17QQaNpEdUY080Rf1YUnaKqjbCIQDGfxaQ73A5bYwd7qNq
 Mj2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmkjyVn3fmAQJSs4wsAs5wTz3cnNLYGuLhOZnsU7fCiSmPQTMuFgFQ9tBwa6D7/wIjfUHBKkI=@lists.denx.de
X-Gm-Message-State: AOJu0YxZr+arrVQmAxyB7Jni4pLi+9pnyxfaluJWS4bP4zOKLcCYZ61B
 zg9RBJ7241s9nHcWeet2PpOZw04oSTU8pSpwDruvWkrJhw0lReAFztciyZkvqjugHc8tjUC06V8
 dncNlZDE=
X-Gm-Gg: AY/fxX4Xz8QV9er02HFsZ7VhaHvndfj3dnUOsQczmiMmxE4QF6/b80wuQ/2ypJD92Yx
 oklnfSahIUmEQE2029ESUfgU12H2YP4zfoir7c2B4D7ooCXPAsvKRrcCFPRe2Mm1GJdq5hpV/Sl
 Ol6j09e4nB84ln867KvA1s/AXV14I627YPeNEGbpgMyewyzNs/kWKEkivmG0EKtEBiOrP0A0no8
 oglqO8N8bp0vWDbDJ5Kp+KDYdFXRXvhfYiuecK08X1NMM1iEV7KzLB2lCztTflcX5WFEGPeE1m4
 V2WaD8OFvOnqRbgTY16OJC/1/uUDwOM8e6GukCi8r0mKvRrouEiSDMvn92KkX+OtlxVf0ID6m0B
 iyy3CmXEwFocxsgR1/lOK4gCo35duPS+hg5eOucLPs256oKG9dEbCYgOmOEqAo55OcDd9JcrwEp
 RaHi1Ytac0KJ/TIbG3VV0Ha732TlzV3DFmIycKJaq3tBoSNJksQQ==
X-Google-Smtp-Source: AGHT+IELT2rXECrlRsZnm2VavYphaQ+14/AjDt/AzK8WHEFuZwJ6KHj7/WKkXsKc6DOGTrH/JADKgQ==
X-Received: by 2002:a05:6870:2149:b0:3d2:ddfa:dfdb with SMTP id
 586e51a60fabf-3fda5238100mr5324879fac.13.1766420429012; 
 Mon, 22 Dec 2025 08:20:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d4521sm6963047fac.4.2025.12.22.08.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 08:20:28 -0800 (PST)
Date: Mon, 22 Dec 2025 10:20:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] m68k: Add support for M68040 CPU
Message-ID: <20251222162026.GA847766@bill-the-cat>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-3-visitorckw@gmail.com>
 <20251218190032.GL303283@bill-the-cat>
 <aUbSHO5Z1w86MG1e@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7akBX0SNifFuLPn8"
Content-Disposition: inline
In-Reply-To: <aUbSHO5Z1w86MG1e@google.com>
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


--7akBX0SNifFuLPn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 12:43:08AM +0800, Kuan-Wei Chiu wrote:
> Hi Tom,
>=20
> On Thu, Dec 18, 2025 at 01:00:32PM -0600, Tom Rini wrote:
> > On Thu, Dec 18, 2025 at 06:52:51PM +0000, Kuan-Wei Chiu wrote:
> > > Add support for the Motorola 68040 architecture. Currently, m68k
> > > support in U-Boot is primarily focused on ColdFire (MCF5xxx) variants.
> > > Introduce the necessary infrastructure to support the classic M680x0
> > > series, specifically targeting the M68040 as emulated by QEMU.
> > >=20
> > > The implementation includes exception vectors, early startup code, and
> > > minimal CPU initialization and relocation stubs. It also defines the
> > > standard m68k boot information structure used for passing hardware
> > > information to the operating system. To ensure compatibility, ColdFir=
e-
> > > specific library objects such as cache and interrupt handling are
> > > excluded from the build when M68040 is selected.
> > >=20
> > > Additionally, apply a specific workaround during the early memory
> > > reservation stage. Use a manual loop to clear global data instead of
> > > the standard memset() function, as utilizing memset() at this point w=
as
> > > observed to cause a hang on the QEMU platform.
> > >=20
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > [snip]
> > > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > > index 8ade6f7b9d1..a41c375f6be 100644
> > > --- a/arch/m68k/Kconfig
> > > +++ b/arch/m68k/Kconfig
> > > @@ -56,6 +56,9 @@ config MCF5441x
> > >          select DM_SERIAL
> > >  	bool
> > > =20
> > > +config M68040
> > > +    bool
> > > +
> >=20
> > The file is unfortunately inconsistent about tabs vs spaces, but all the
> > new options should be tab-indent only, and no extra blank lines added.
>=20
> I'll fix this in v2.
>=20
> BTW, do you think it would be helpful to add a check in checkpatch.pl
> to warn about space indentation in Kconfig files?

I checked and the linux kernel has many space-not-tab in Kconfig files,
so it would be a change to add it to the U-Boot specific tests part of
checkpatch.pl, and a patch to do so would be welcome, thanks!

--=20
Tom

--7akBX0SNifFuLPn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUlvxgAKCRAr4qD1Cr/k
CsUlAP9RvYRL/lvJUiIPiQtEB2S8RQgFRKqlu65HuFXSsa+JHwEA6SpvG1v6u/gt
SR0/5UJ5VtPRyNsc7ei87kWfcp6zFwM=
=7XSF
-----END PGP SIGNATURE-----

--7akBX0SNifFuLPn8--
