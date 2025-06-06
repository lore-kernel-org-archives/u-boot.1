Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3CAC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0140581F0D;
	Fri,  6 Jun 2025 21:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nsT8+CZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4248B81FEE; Fri,  6 Jun 2025 21:06:32 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B11F807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7303d9d5edeso703906a34.1
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749236789; x=1749841589; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kv2vnGEMusTGZn38NWDD7UUBVDxnSyFYexIHNECxhEc=;
 b=nsT8+CZxwwMmIgjngAu2PiuYo0V7GfEiC93XUhoLBJ8r8dGWlQe7381MDvQXLkZGbZ
 UlKS99zfnu3xa/rhOo78Xu35V5Vip4RBSnX0OYupaaoCkD1LWNfiyM92+j9BFuHzHydA
 +3H2TsUMTjhaiZWpo7DwBXoBrKxHKGYSbdbKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749236789; x=1749841589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kv2vnGEMusTGZn38NWDD7UUBVDxnSyFYexIHNECxhEc=;
 b=upMr0/WIqSIaGRmA2a2i7k01zo4xM1uKEwIti45v3OwBvGk5PK3Cx3QLJ+MC6mZkVH
 1Pu2r4bE1xqAadHoHgj+P6eGzbYR+E8auaShWszW/AET5f80vNxKEDGaIrSBN9h7Dc9y
 wEXYpSUXss+tNxAQhID84LvlEVAd8YNcoX3++rkJs5EO9Iw9JWBr0mKHSze97hUMCUaH
 mPnC0twm2bwlNx/aFWyVKeddJYX3KxQcpr7EtBAHFc1Yy0hYl9Pe08VG00i6vHIbXn7u
 EvjNPwWdaDQz1b4QuXTXgJciNWfYEqcJa2p4FW8gbZyftvuQi0/4jkKTE3MJfHHIUtat
 xvbg==
X-Gm-Message-State: AOJu0YyDQ5bAPcIOsEJiDvYTS8LsLmr1EDQZK93aS8WOOm1gvS202c+B
 nfDKimZFQLPWb8x94FmZMDbxX+M2cDJPMBzpxRR19JsjrK2oOmeaiEhtrjc0Hq+0bwk=
X-Gm-Gg: ASbGncuW6h5Lhl5MV4roChGbEw6sE6bOwKmCa2pKC0+ATbVWrID6NlvHP4CBbFHKhgr
 aJ9n1qjARonmwB4y86rUi+9a66/yGGp0L+GbXHPaQgUlXQ43pJtj7YB7IdxIy1ocufgXxGd6Jew
 /wGxK6Dlijq1p6RgQmBg0FCzKfPHbLg38f/H76OXeujCsHmOim1KqG1egCa5qqnQeI6M3hw2ct8
 BJeOjVyp+awODXrtDkAAAtGGBTLGreiC6rfhJjuo5jjYGZE4+w5Z8kOsE3wjgqkCiBU4SeDRQoX
 ySufoScnkHtQYYRiVfxrwI52S3vYltwU2BszxLrcfviUkieQIiDtdQh0Z6Eid3NnD/5h83TjgP2
 +T25yynQIvjJj
X-Google-Smtp-Source: AGHT+IFRXikMUl4kVNikk8J3rUyCX45ZFtyeZBdcccsl3njdfRcsQzP2Kp76pCOEOYHoOWankYFphg==
X-Received: by 2002:a05:687c:2f0c:b0:2bb:841a:4fd with SMTP id
 586e51a60fabf-2ea015161damr2747144fac.32.1749236788790; 
 Fri, 06 Jun 2025 12:06:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea073407f6sm462915fac.37.2025.06.06.12.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:06:28 -0700 (PDT)
Date: Fri, 6 Jun 2025 13:06:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 01/10] spl: Kconfig: allow K3 devices to use falcon mode
Message-ID: <20250606190625.GZ1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-2-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5P3H6Ch6bxZCCedW"
Content-Disposition: inline
In-Reply-To: <20250603142452.2707171-2-anshuld@ti.com>
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


--5P3H6Ch6bxZCCedW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 07:54:41PM +0530, Anshul Dalal wrote:

> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
> HS devices and can be enabled on K3 devices.
>=20
> For secure boot, the kernel with x509 headers can be packaged in a fit
> container (fitImage) signed with TIFS keys for authentication.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  common/spl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 77cf04d38ed..bc5a334a1c5 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1190,7 +1190,7 @@ config SPL_ONENAND_SUPPORT
> =20
>  config SPL_OS_BOOT
>  	bool "Activate Falcon Mode"
> -	depends on !TI_SECURE_DEVICE
> +	depends on !TI_SECURE_DEVICE || ARCH_K3
>  	help
>  	  Enable booting directly to an OS from SPL.
>  	  for more info read doc/README.falcon

I wonder if overloading ARCH_K3 like this isn't a great idea. Or perhaps
TI_SECURE_DEVICE is too generic a name. I kind of want to introduce
something that means TI Secure Boot is supported but also Falcon is
supported, and then use that as how we disable in Kconfig various
insecure options. And I assume that it's a matter of effort not
technical restrictions for supporting falcon mode on older HS parts?

--=20
Tom

--5P3H6Ch6bxZCCedW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhDPDEACgkQFHw5/5Y0
tyxuLQv/cKHo3nINV8dYcf2f6e27e97BJPHdPbPPJiGh8M19xtQmk4eozYDZdiKe
/P7b5MSUQMy2U0N+3i0nKAhDzvjaRdTiExrhVCRJpNC5ANL+CNWwQEy2SVeEd8A6
C33oY9PzEma2dqv5t3wKltBca2MKKOYP0Sd4h3etYsfzF31iIQm3VW7z/eSh67mw
6vW8LIhxjS7ne4oOcH1dfZ4SNdgKJga+YBzR7quMEYxImaig4ismW3R5i2srqCk8
ajT5tEub0NiZj90CQDBk+wo4YIJuZqsocxxtva6Be030NK0bqGlwAcVeZS29rArW
TjtndFD/Ct/DUuAjtyxZklVDAS11G5INmiEgVWEWxEEgQCc/p7cL4FBd2TNEvDmr
/18kZSLlt6/TUL6+ozE/CmfAsrv+gqDrTF3vQbZA6S1jdiYr+BRn1N3LzPsXghs5
v7pFAtpoaHNGqO068tLAFt7AOneJWF1B3CizDFIFd3Kg8UpQTzHF/Y+teIdFALk9
vnhsu3lb
=TImB
-----END PGP SIGNATURE-----

--5P3H6Ch6bxZCCedW--
