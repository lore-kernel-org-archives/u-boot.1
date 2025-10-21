Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B51CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 17:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0888B802C1;
	Tue, 21 Oct 2025 19:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NWTMgBqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A97DD82B20; Tue, 21 Oct 2025 19:08:14 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BDA80107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 19:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-449409cc2f1so100862b6e.1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761066491; x=1761671291; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rPsfNj58VAzTdaU6PdD2ehLnZUyMzQvdea/nVtE9mfw=;
 b=NWTMgBqGAE7FKepsWWIwbjyNoukGYjgK/6vjZly9kYcOUTr/1MDZQ7AXDFFV34WZL/
 iEmAun0+/iUMi8JYego+rRamJvfSURQHicrxPH7+MRKkwLJkoNGu067/Ts5+kpzOQM68
 PBwdWHTh7YNu6DMNTU29G8BJ6PVAGMbFTA/lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761066491; x=1761671291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPsfNj58VAzTdaU6PdD2ehLnZUyMzQvdea/nVtE9mfw=;
 b=ccbXxO91S3nJen4TPoYBH92MXR6Y8A2Gr6OKCHyrTJojQMqa3+kZhb06i6GnOtv0/H
 MUDK/RgtOMtAMmhpjkmjnapvrIGKSS1+Mlq9AjdSkaHr8mqagwhRcEwriOC6quhos0g5
 YWHe0hX+w9vn0p6038aB586qMu5JO2euvsX78sz2VRKokX2a0I4O+SwIjxoNmPXDoZbD
 vxauTkXo1fGQchqqDSEIzgqbIPA5xOQH8QE6jT7844V7az+eLl+FdhNeZ4p940tVmxva
 QUvvNfhZTg45lJM/MUOJzAz3eVaVydB4iUsA8L2P7b5gNjjEdxeP3/HQL5pneJjiKJmD
 uPQw==
X-Gm-Message-State: AOJu0Yx5uXZnoZyU7l1MqkC9dSCY+5kkCMElRGtOClzSKifsixvqioEt
 uj3j4gxpAC/uFcF00MGDV9AoapYHtacg5oSWjunW7xKHChzF45FGaKrMmCi06ghxXM0=
X-Gm-Gg: ASbGnctPoKRvlvo6CFTX12mYpb/L2ns5AyiTsDdppMzHZ4xKHF6WSbzhbv40FmlxNCh
 Fbzf6iCGk/Puxf456cnvCm17PiJFjSL5eNTb9Flzzd0U1tjuXKyIo4gL+laln5cobgpgjqjAakh
 /CYSizCN0z6+veC6lIjHqPk8Hsx9Uxfk8qjapZPGykyHB0cJn8sb0kSur3JDCsg/ur1I0n9RzrM
 /DDgKS23YpjcwiS3dgnIFjuPH5LjxWta+mM7941i3fyMQrDtS5ZrER+WTVqze2FO+iD6nPC9WBf
 XDUH6mR0YCdlubBJCSW4aUqQzkEKVzi1hKu5Mal+YNzm+zL+f86v8xLx6BQbMfC0kDHAQtToG7I
 bG9mcD+1EAhUwRbPb19RPnHMPAVAhr2q0uMED9Tj8gQEXCpP2pCmVBsWsDd6RiutvvyK3gKSkb1
 cX2BjyDvbah9fyPsjBxcgCDMXnZ7JDSpB61LRLeJ5gmuZcsgBYYA==
X-Google-Smtp-Source: AGHT+IHIsM1+0y0lpv3FOAaTM8V1PS9BM3k2b33m2URV/hzMxfAlR3FI5IpTzxbIjwAdbUzjsiovqQ==
X-Received: by 2002:a05:6808:3a14:b0:438:3d81:b25b with SMTP id
 5614622812f47-443a30b2fafmr8506096b6e.41.1761066491104; 
 Tue, 21 Oct 2025 10:08:11 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443debfe8f0sm2801333b6e.15.2025.10.21.10.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 10:08:09 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:08:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] gpio: search gpio-line-names property in
 dm_gpio_lookup_name
Message-ID: <20251021170807.GA28509@bill-the-cat>
References: <20251016092355.1569173-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3jGK73Wh9XGvi0iR"
Content-Disposition: inline
In-Reply-To: <20251016092355.1569173-1-ravi@prevas.dk>
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


--3jGK73Wh9XGvi0iR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:23:55AM +0200, Rasmus Villemoes wrote:

> In scripts as well as interactively, it's much nicer to be able to
> refer to GPIOs via their names defined in the device tree property
> "gpio-line-names", instead of the rather opaque names derived from the
> bank name with a _xx suffix. E.g.
>=20
>   gpio read factory_reset FACTORY_RESET
>   if test $factory_reset =3D 1 ; then ...
>=20
> versus
>=20
>   gpio read factory_reset gpio@481ac000_16
>   if test $factory_reset =3D 1 ; then ...
>=20
> This is also consistent with the move on the linux/userspace side towards
> using line names instead of legacy chip+offset or the even more legacy
> global gpio numbering in sysfs.
>=20
> As this seems to only add about ~50 bytes of code to U-Boot proper,
> and dm_gpio_lookup_name() most often ends up being GC'ed for SPL, so
> adds no overhead there, adding yet another config knob (or two, if it
> also needed an SPL variant) for this does not seem warranted.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>=20
> v2: guard the the dev_read_stringlist_search() call by
> CONFIG_IS_ENABLED(OF_CONTROL) to avoid link failure on !OF_CONTROL
> platforms.

Frustratingly this is still a failure to build for imx28_btt3 and
imx28_xea, in SPL.

--=20
Tom

--3jGK73Wh9XGvi0iR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPe99AAKCRAr4qD1Cr/k
Cp2fAQCLzp6WbKm3wfdEOtq7LR1IvwIFxmubV5yGpJislxW/gAEAhmES2aFuxCLs
Itt8Q8uIUV6SgbjAjR7yG5cDtUHmvgY=
=oO7P
-----END PGP SIGNATURE-----

--3jGK73Wh9XGvi0iR--
