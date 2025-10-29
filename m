Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA7ACCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 22:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A33D081E13;
	Wed, 29 Oct 2025 23:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A6rMZspB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF73282A9E; Wed, 29 Oct 2025 23:20:40 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2531800B6
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 23:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c2766675adso180451a34.1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 15:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761776437; x=1762381237; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=73199O89No4F94cn9R5QF5JaeXhifk2DF83WswUv8BA=;
 b=A6rMZspBcGauYMwXPcIsjKhAz2Or6ntn533/QonqdQBsTwn0WE1rQzwLIl7HIBQ9MR
 7PgiM7rPaxOgaQbNiIrZpb7uxgXsWuDnD+mdcxD4ydkn66Z6a4H2r/ktGz+7XUOJmIj2
 iAY9v13YTCx524/DYpewsVWeRMF5rLQXwIZf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761776437; x=1762381237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73199O89No4F94cn9R5QF5JaeXhifk2DF83WswUv8BA=;
 b=oz6Ht5QzRK5YmcppfTFRE0f8GQXZspEfguseVOl0cesk1VWz2o0UUotAAFqOuID8Yy
 zXRMLJEtMDi/w1jVDfYfqBWFMtIjtBMJxNbgMZpalDKmJPsrKdnBitGBQf+3H+AYok0p
 L1DdQCJgvY367+mQtMNONaJpFkSSHoOZMmcJXBE+WueHjNsAEYw1ngfxwxKPhQ+VrEno
 ucMpvb7ssMU1sOIwv5k1UlpmBNSZ5FK9+v8FCkS9rO5pcJMZMj04UkQfdRU2Y68R8b5W
 u5X+KAl+Xi6OTlcpzVooCAx+RKKo3ejI4NUJQEXtAoEcGjLkjxwBh73NhJmdyCvudjCv
 0Oaw==
X-Gm-Message-State: AOJu0YxrtTBO4HDvKaFSdvP6sBHtK3ScHO2ScpvFqv/vg22Pl2zUf5In
 4FgOz7aYG6GyF1pKzQYtpsbfZuprG3ku4zXdVEbUBGWy07fhcdHWw+k7xHWkfGHrt0o=
X-Gm-Gg: ASbGnctcxf/gN+DsQnXAL+kmLBC1Ruh+P5CinicczcbogNvSnXrFyTeNjOMjvsVjugC
 JYyDad0XDBQDThHy0j3u+IhsCebA4HC2ZzX+NlY7qrTT7TtvOoC7iw9uyruFG58KXJ+E4jlFTOa
 9YxYBbhs9Qlr+7o84fsx+gtxi3g/hrEOcdPmIOeLlHEn9ZDPSSjl7emDW87kUXjLJBs0wbl8AXj
 2LLPK1PhAdGmGLtaiUrw6KIv0LD38jhs1D3nfeur+Ps4crrDjjRg2o//uw2U0y4xM5vbTnWnbRm
 S8OCTPYvR6GGvxBBMl5IOfcB4c3z5Xmq9KR4rIBjP9Uv1Quhe2fESDlw/NCHePBdqODjYVjszpH
 SJMYdFKwssPum9J7/xUKHskqZaALI9n2FoxbGmpP1Z5MNbqh+9/n+mKcausEs+hb/hpN+5ANweN
 oK0f+l/tAhPhkQr23jpw6zTmHnAi3whOwK+uOqZhc=
X-Google-Smtp-Source: AGHT+IF106lOIf09wisvMoFe0BqWnDUMvrvWfXGB2/aOLBkl5ug5/pLiSPfBGmdCO5dykkCsRK37sw==
X-Received: by 2002:a05:6830:82d4:b0:7ad:d568:6e60 with SMTP id
 46e09a7af769-7c68304e894mr3059119a34.9.1761776437405; 
 Wed, 29 Oct 2025 15:20:37 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c530005afasm4560500a34.0.2025.10.29.15.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 15:20:35 -0700 (PDT)
Date: Wed, 29 Oct 2025 16:20:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Martin Schwan <m.schwan@phytec.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexander Graf <agraf@csgraf.de>,
 Loic Poulain <loic.poulain@linaro.org>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] rsa: always build pss padding
Message-ID: <20251029222032.GP6688@bill-the-cat>
References: <20251029-rsa-pss-always-v1-1-ad2b652e75aa@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uOfIKxd5ovVUkb3I"
Content-Disposition: inline
In-Reply-To: <20251029-rsa-pss-always-v1-1-ad2b652e75aa@cherry.de>
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


--uOfIKxd5ovVUkb3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:28:53PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> One could very well want to verify signed files which aren't a FIT
> image (e.g. via rsa_verify_hash() when $(PHASE_)RSA_VERIFY_WITH_PKEY=3Dy)
> but that is currently only possible if the FIT_SIGNATURE symbol is
> enabled for the stage this signed file needs to be verified.
>=20
> While we could remove the dependency on FIT_SIGNATURE and find a better
> name for the symbol, let's simply always build support for PSS padding
> when RSA is enabled, like we currently do for pkcs-1.5 padding.
>=20
> When $(PHASE_)RSA_VERIFY is enabled on PX30 Ringneck, the difference is
> an additional 904B for the SPL (spl/u-boot-spl.bin) and 1000B for U-Boot
> proper (u-boot-nodtb.bin).
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Another option is to remove the FIT_SIGNATURE dependency. For context, I
> have a system where U-Boot proper verifies the signature of a few
> binaries thanks to rsa_verify_hash() (see CONFIG_RSA_VERIFY_WITH_PKEY)
> with an embedded public key. We do not use FIT images in proper and I
> would like to avoid building code we don't use to limit the attack
> surface, so I was looking at ways to remove the FIT support in proper
> and this dependency makes it impossible as we use PSS padding.
>=20
> The cost of always building all RSA paddings may be too high though, I
> don't know where we should draw the line.

I think the cost of ~900 bytes in SPL for 120 platforms is on the high
side. How about a different symbol? Or would you want this enabled by
default on rockhip and so changing those 120 platforms anyways?

--=20
Tom

--uOfIKxd5ovVUkb3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQKTLQAKCRAr4qD1Cr/k
CrV/AQDagRG8WmIf/aRMUFDm7cNzr85gDK/upS+eoa7i3M1jeQEAnfxLRim5iMrn
Zt5GMRawq7m2e5wrE6Sh08MorT48rAU=
=WWiB
-----END PGP SIGNATURE-----

--uOfIKxd5ovVUkb3I--
