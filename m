Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B718AC8303C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 00:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34FDD82063;
	Thu,  3 Jul 2025 02:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CM8jRhAg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D778206E; Thu,  3 Jul 2025 02:42:35 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C068681FEE
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 02:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2f75f1c7206so383743fac.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751503350; x=1752108150; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8nZQknevAX3/7Xqu82HBsRmo4GPATwUufaCsecnru7Q=;
 b=CM8jRhAgV3lXQxrz+mRCVYjSCeE1V84W3V3PSkPg/AlJcFbQhpPpqbatXmEXD8lwdd
 VFnPrbmxA2COampPWHSJBpTryHn05+01y2KokR1CzKIeo40SarkrJO/anc36MC8hOpQd
 z2SVENnynONvySbK7IXSRqCL6CpfPNV2WwFQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751503350; x=1752108150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nZQknevAX3/7Xqu82HBsRmo4GPATwUufaCsecnru7Q=;
 b=RPBKKyVTM8mrCRFw9KSno5TnVZdjXJgBUIs4Aj4alzuKQEWbmk41QS0Z4qVjFdSfFp
 hGvRaB7J+QzlMehWGSob/gVdkgA2mFWQgAW4qmi2YwVlWqyfGToYQvfILYQleMAUkkqh
 9GWXze0+rNA29WiN1KJQPjuVWwHBvV1sWWfZNmVNFXjGj+PpgNTAt7oC00+b8yvg9MDJ
 dXrsIb5Lg2ZPuu8SOhSMdS5ZYLWjfL9CXcl43sn6A5XP8q94UwZXPrQUtBZDKS/CKQBj
 osMuZik5Ou+dqxeo+9jfnmPod9D4rT2D4xWFIRTY+TLf2xiVI54wVx3u8pcaUcCaOfZt
 Lv6w==
X-Gm-Message-State: AOJu0YxdMheuiK8bmez6ZJh3y6SKJoO4vkmRvq/r76qrqUCLjUy0HOgf
 lHjWqmhfELMWxgot17k85KLgmj8GvrHmpQ+3WNmUUI5U50Lf6pi6KWBZmpbjcwgEOoAsy8JobLL
 1vN0NPb4=
X-Gm-Gg: ASbGnctekOSSSVtBkOsn2550YnhmaUchKWLZUh4PQ74oqyxywKh35XqrMvw0kT+mvO2
 FOrJ8K4hMlqcEriByXsWd2hGwai3X/7ydSUKwJBP/jl3kmvscAV6lNtVIeC7W7hyNb4cLyPpdGo
 Ztf3hviwYCmkH3UQ53aSDC24Vk6zwxpj3itQOKMu+LwEFMz4/YNYEkoM4YfNFwVhrhX3Xks2Lj1
 d2ESGFX+lLVkxFN2SvjqioAoCQxL0p1j9A8CQAxnHwZMU7Myj6/k/3WfrxXlwPLN27410nr69gb
 Q5TRoy46FK7mK/+vAXDIDGhTiFTA+cr3Ldt1nC0N/D7OxNiBPVuOyl9qAmX0J5D7Cf8hOChSgDH
 NCX6rxiT+/828EAA0Y2rO
X-Google-Smtp-Source: AGHT+IHXYEaAXCVzxiMeXZt25GgQYfOfrgmmAPH0jksOtPuRB8xkeEmd13H5LIElQXkIbbT7UukVyA==
X-Received: by 2002:a05:6870:828d:b0:2e8:f5d4:607f with SMTP id
 586e51a60fabf-2f76c9d1bb9mr1171242fac.26.1751503350374; 
 Wed, 02 Jul 2025 17:42:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eaafdbsm4233240fac.7.2025.07.02.17.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 17:42:29 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:42:27 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] i2c: Kconfig: Tighten some i2c driver dependencies
Message-ID: <20250703004227.GA2881698@bill-the-cat>
References: <20250702010359.18747-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eA4RpxNc5jgNzoiJ"
Content-Disposition: inline
In-Reply-To: <20250702010359.18747-1-trini@konsulko.com>
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


--eA4RpxNc5jgNzoiJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2025 at 07:03:59PM -0600, Tom Rini wrote:

> A few i2c drivers cannot build without access to some platform specific
> header files. Express those requirements in Kconfig as well.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
[snip]
> @@ -314,6 +316,7 @@ config SYS_I2C_MICROCHIP
> =20
>  config SYS_I2C_MXC
>  	bool "NXP MXC I2C driver"
> +	depends on MACH_IMX
>  	help
>  	  Add support for the NXP I2C driver. This supports up to four bus
>  	  channels and operating on standard mode up to 100 kbits/s and fast

I didn't look hard enough at my logs, this dependency is too tight and
misses at least ARCH_LS1012A. I'll v2 this at some point.

--=20
Tom

--eA4RpxNc5jgNzoiJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhl0fMACgkQFHw5/5Y0
tyyM5Av+Mdfo8+90NaPMBgrbeKkCDxF28KBtiIiOyp08hT3a9L0JdaMkzwL/Iq0V
Ffck+iuwUaku+dfPb2EFRND1Ks6VdyTjL6ZMra7rmqC+rJ1HcdxhYUyPgNiLwzWb
GHOX0HWpEDd1DTmy+gkh2r9EgVxdUQkYOe0XPALlP0L2CvEsMQUzN8gd856GKAEL
BDZ/bTBYZx24Aa9opNGw+nUS4chk27YyslA6ocIzigucFHObrUqs9w7/XJg2yhwh
av8r8G2rFIeMsuRj+HUDxTXgzjVscs+93lTjaFCWGYjEFFiwtJ2YDGtu2yXy/1Nr
wpzFLja34yOs6z6cnGma2HAKVOC1sDvwH3+rDgMRVP1U1EMa9tjM7rQxDs1gZqnM
kkD79YgRBlH+cIarVtgScECyURsU9BeZECFJwm46ICzpONN50f2jvIejZ+Nt/ek/
DsRMPt11JCWACGNf4yyghJvRhrvDWLQVGABLzGttcGHsxsxT6vNh0YrFFZ1VDpLH
/BGICJFS
=8T+I
-----END PGP SIGNATURE-----

--eA4RpxNc5jgNzoiJ--
