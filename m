Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29A8D2A52E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 15:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40EAE88CC5;
	Wed, 16 Oct 2024 17:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YWX2xA/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D61088D72; Wed, 16 Oct 2024 17:56:29 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D948188CAE
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 17:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4607d5932aaso8935431cf.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729094186; x=1729698986; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pe1mXgPG3ntct5PJnaJkfc8Z6ny8kwklZwl230fJ/i0=;
 b=YWX2xA/gsmpxvTOVzMbjYHQeXk1YlOT2O1ZrSF32w+0qc4FcuFDcG9/s6Ekc35JxdG
 vCmxUEkBB2E2egacTXZQjiwv6sJN0Tpk+DsBrZsz3caQKI1Y0w4xoSK4HnxUlw9wJpZw
 BS2PQXw9bB4r7+b0xOylhSTmoS4gkP4inp8M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729094186; x=1729698986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pe1mXgPG3ntct5PJnaJkfc8Z6ny8kwklZwl230fJ/i0=;
 b=vVdpQk2f34k0oHNGnjnXOo0PjYcskej4fBuCLgwqoG3xQ+usgDH6MUfptPcAqAbUFq
 T0bSV/xJFjknDnBKikNZU5nTBMvnef6MLkwkNL1vNTRS22GFkpX6M3gwaRLW4yOrgJlt
 EQtDLRt8PwnFNxkQKnXlaZNoXIzm+gV016BdSxa3sGajmIcBO40jIMpL2ncEIPqzkM1z
 AuFvX3r2wlTEIvb53yTeQCtJl1A+T/UXs2JLgzn6Y13+YInAYRcARSvdbdDpuIzI+QuK
 pyMFs0RULQssbzL4AcdxK30SiMamzt48aXNkyik7YuF3awe/ngY/y97aSgotzMv2QsA7
 KEsg==
X-Gm-Message-State: AOJu0YzkJAXFmxDhNRZwkFHiuV+CLzZ6p/Fv36AAHDwHeiNhk7ZCZ1b9
 I5MKOcYWIloQCuGHkGMEddsxOCtJavxXkM5aqE+aULWpzUiekPPFCHIpCvXBke0CfeSuB1/8P6z
 F+mQ=
X-Google-Smtp-Source: AGHT+IGLuKubotcrqED2smWEL91YUnB90krqsrvG/Am0H7tq2NK8wJLWSWK+qSUzt/tCrhhf2gr72w==
X-Received: by 2002:a05:622a:1982:b0:460:8d84:7aec with SMTP id
 d75a77b69052e-4609b4cfe72mr995991cf.21.1729094185583; 
 Wed, 16 Oct 2024 08:56:25 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607b394a7csm18558301cf.92.2024.10.16.08.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 08:56:24 -0700 (PDT)
Date: Wed, 16 Oct 2024 09:56:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, emkan@prevas.dk,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH] envtools: make them build again
Message-ID: <20241016155621.GF6412@bill-the-cat>
References: <20241016151035.709351-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lMtAu+AkD0tCF30W"
Content-Disposition: inline
In-Reply-To: <20241016151035.709351-1-ravi@prevas.dk>
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


--lMtAu+AkD0tCF30W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 05:10:35PM +0200, Rasmus Villemoes wrote:

> In v2024.10, "make envtools" is broken for at least these defconfigs:
>=20
>    am335x_evm_defconfig
>    rpi_3_defconfig
>    rpi_4_defconfig
>    mx7dsabresd_defconfig
>    wandboard_defconfig
>    imx8mp_evk_defconfig
>=20
> The only defconfig we use for which it is not broken is
> stm32mp13_defconfig. They all work just fine in v2024.07.
>=20
> The symptoms are slightly different, but all related to the fact that
> some transitively included header uses IS_ENABLED or CONFIG_IS_ENABLED
> without linux/kconfig.h having already been included.
>=20
> A simple git bisect doesn't produce anything sensible, it ends up at
> 3a9f642ca94 (crypto: nuvoton: npcm_sha: Support SHA 384/512) which
> clearly has nothing to do with this. But digging deeper, one
> eventually finds 0f92fa45603 ("env: Remove <common.h> and add needed
> includes").
>=20
> So at first I tried adding "#include <linux/kconfig.h>" in
> include/env_default.h and include/env_flags.h. That fixes it for some,
> but not all, of the above. For example rpi_3_defconfig still fails,
> then in log.h complaining about BIT() and u8 not being defined. At
> least BIT() is should have gotten from bitops.h, except that that's
> behind ifdef __KERNEL__, so not set for the envtools build.
>=20
> It turns out that the envtools source code in fw_env_private.h already
> has some hackery to deal with all this, in the form of the __ASSEMBLY__
> games it plays before including config.h. It seems that if we just
> make sure to do that include early enough, so that config.h is indeed
> parsed with that __ASSEMBLY__ hackery in place, everything builds
> fine.
>=20
> Fixes: 0f92fa45603 ("env: Remove <common.h> and add needed includes")
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Oh wow, good work.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--lMtAu+AkD0tCF30W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcP4h4ACgkQFHw5/5Y0
tyzvjAv9HF/+AwCPbve+dr90YsZAQ8KRh5H/b6qyxvF43bSY5xmQkDgDYGk5jd16
YfIgmnJqoVTNGGKCswaWPu/u12HtqehlstOqcC/KMOVFlysYuzJS3Vmp7YGN5Le0
S4cc+H6ltU9398KaqRO1fTDBL+F/+on8+whYyOa/153ubkDqjcq1rJO5nRSEXtVn
Clo6KjzTacCZhIL3fMFsUnTK4mHY2vnfBPBXyRDAMGsaBthyUErzjlcTesouosOD
3ick+hHDgFdDdGyfZA+LviZeJofdAQf4P7rJPMQmrKLFWRVJ2XamR6SwA+5HeWr4
R+71OLMzpAfB30GwAi00Iw494n+qf1qH2z1IFrVJGj3MWhhEuqjPbXmpIfGSNsd1
h23R2skNNPdG7+O/GqEEoUL5hN9aPLzlETZPkfDvpzrGjD1/m1Mwql1tUzZ39hKl
KAAoqQpmumt4F5qxrXq/G+q67yGER/4nfXyPXzPiuwbfQ5Vn0WYUK+yWNmMOHbVm
2alj3mOE
=Sow+
-----END PGP SIGNATURE-----

--lMtAu+AkD0tCF30W--
