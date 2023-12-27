Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB1BC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 13:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1297D87866;
	Wed, 27 Dec 2023 14:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FpUD4ccK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FBB8789A; Wed, 27 Dec 2023 14:20:40 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C21876FF
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 14:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dbdb2433800so3659034276.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703683236; x=1704288036; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lt8BO5Uui/0Tg5e+NpDWxgaShaoE086aDrSe5Xc3nKY=;
 b=FpUD4ccKnWTfelyDfwBtK8/HFlkwJ2092SqrV6zKComOPua7UJmKvPRBAJL6pJC6yK
 FlKNTyOkle1hFchPDctkGaiqx1R3NSaZFyFOGgjzVDEnNFQKrTndURWuGoAbOdGnPSml
 GVSD7jMqbmSWOvG5fOgRv5P0D7DyCo+2ceMC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703683236; x=1704288036;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt8BO5Uui/0Tg5e+NpDWxgaShaoE086aDrSe5Xc3nKY=;
 b=jtmgguqP/mWM5hVHddfU4v+r8vhzOWJNAv/+swGgETCKwV3EDNUuIoNhsIi9NvFdvD
 KL6E7mGmpVUNqm6h+kWz7KMz6+QSH+DJcqLBKIRq+vmflHB9dlff7Fp3zgOGQygQTwtK
 t/1cOBmsycuYaUdi6hlfdH5v9wJ3qEsoMiis+d+W6z9cyFrMJLzF4boC/xrHBvjoqq1m
 e3764Ggc1SGrnTkwfS+Z33u4N9sdhMkro9qtYBNcuA+aUl5W0CDPZW8ZStLXJNnjoNpl
 Yqi5+cLzSPRfYtOqv905v6K2R7OUUPtVb4hFELeE4F42EGN9gqMLxOTJm9zgesci2kNu
 IZtg==
X-Gm-Message-State: AOJu0Yyx6E0pGVqn5c5yDOmr1yd0376LTl6rOxWW0j4hiXM57HTINXGc
 tEZiWuLrKGzroaUFSjzC9d2xou2JnHb6fA==
X-Google-Smtp-Source: AGHT+IEQVxR3KHMA5ZcXf1ilHX115tffCV1PytrS+UG7ZIbhw6J4L05niRcbDssi/gKqR9uv7A7fZw==
X-Received: by 2002:a05:6902:1106:b0:db7:dacf:61fc with SMTP id
 o6-20020a056902110600b00db7dacf61fcmr3820705ybu.78.1703683236279; 
 Wed, 27 Dec 2023 05:20:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 s103-20020a25aa70000000b00dbd0d4cca6bsm5273617ybi.58.2023.12.27.05.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 05:20:35 -0800 (PST)
Date: Wed, 27 Dec 2023 08:20:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 1/9] microblaze: dts: Use the normal build rule
Message-ID: <20231227132033.GP2652760@bill-the-cat>
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227082405.2202246-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QqhfLm6KXCQp4qxi"
Content-Disposition: inline
In-Reply-To: <20231227082405.2202246-2-sjg@chromium.org>
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


--QqhfLm6KXCQp4qxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 08:23:57AM +0000, Simon Glass wrote:
> Build devicetree files using the normal SoC-generic rule. For
> microblaze there is actually only one SoC and one board.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  arch/microblaze/dts/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makefile
> index 427a8f9aaca..adc76ddf21f 100644
> --- a/arch/microblaze/dts/Makefile
> +++ b/arch/microblaze/dts/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0+
> =20
> -dtb-y +=3D $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
> +dtb-$(CONFIG_MICROBLAZE) +=3D microblaze-generic.dtb
> =20
>  include $(srctree)/scripts/Makefile.dts

This (and nios2 and perhaps a few other arches) show that it would be
easier to just drop the dts- line as it adds nothing over what
scripts/Makefile.dts gives us. I wonder how this will interact with
OF_UPSTREAM and how it compares with arch/microblaze/boot/dts/system.dts
in the linux kernel.

--=20
Tom

--QqhfLm6KXCQp4qxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWMJJ0ACgkQFHw5/5Y0
tyzoDQv/QNgtq2CCBTK6AyA4EXpuU88wS3hOeBfI/YNBVhV/3yayMh2wqjXezLPO
F45743jZ/7afPTzp31tSM5ggBYcCkkYjIHGnfnqeuQUeYEc6dZHa668ku5YsnpFY
4Jx+8pH0KKldPSkEMz7C4tDTu+q5imx8wCahLmGvqmoyNyWOzkNczbwFK1pk4ylu
xAmTylShd9a/M1JW3+WqqYIDzTrwX6sGNB8aTDrouQGbJ4ihBX0/GAO2TkXO0abN
n18/wmx/WE+CdnIu79zUbG7uAqY85DZQU9Fnn11/VoEhEK9tVXiPEaCLd0HN/HOL
RSj8pAifC2oBxRRPIBXl5MRxsTPUQ/uMiCukOPs5t36XkLM+QKEzsECi1WobH8us
2OwFd98YB6gBipAX1Q0CWPw4IeVdsRrioHA6XomKZC+6m/EzPyJ3CPhWEjJBN23x
jiN2mCdxnplriU8+ls9TP7HyMSLgEV++k8bm5CDg5OFUhNMhV/o7a8vzIwjhqmKe
ynmEaTQb
=HykE
-----END PGP SIGNATURE-----

--QqhfLm6KXCQp4qxi--
