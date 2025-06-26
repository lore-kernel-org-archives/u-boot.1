Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD217C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 23:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E0481F66;
	Fri, 27 Jun 2025 01:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H8833wL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834D982B34; Fri, 27 Jun 2025 01:47:30 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 510DD80E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 01:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2eaf96c7579so1143843fac.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 16:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750981640; x=1751586440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LB5lUSHfDNrZQfLCdxrZWCsQhBzDcTa+DYSf6GH0yxc=;
 b=H8833wL7Fd3ZZoKV85NLgblGWdnTpjpHgUEEl/sKvnI4Tp6TfML4rfVcry7N1y/cOC
 EV6u/N+ID+IF13Icgx6rByEixN/hFXIxWrtVOmDODtRBfL4A61zVocrdl+K/dfiSnE88
 lWIRB02dpL1UIU1Z8TwWj1VQix/wzrzqk5ET4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750981640; x=1751586440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LB5lUSHfDNrZQfLCdxrZWCsQhBzDcTa+DYSf6GH0yxc=;
 b=n75ja30QyXxh8gN1zOFIbXgWKXXLGSCxYHxA7QJ1gvYEl8SmDCqR35Pfah/RQEBAYn
 hOWaU+QM/DYMQaIMuy6GEiL8+pOop+J5B7DZRUA2ufV1Y1Ij7GfRikJrYqC7JDuC3xtz
 lVAlU45jpPP6cmuv7twkgmFuYzqPD3OaIWP0NDj1JTlVGawNSxy2Nt24in/WDf8s/hIg
 EdVXb+JKxVxoMJSacLiq6Yk8q7werwpiqI8D88jHzNOSoxiEGBCYOIS0yHcCHWUNYCDQ
 O81QxK4WLGgB5d8DIef3hcwoO57RrgoDFJwvGhugbDg06CU1kbG3IDmUb+9SPsBhApTO
 fZRQ==
X-Gm-Message-State: AOJu0YywqegygxjYd3tnymSCMhlj2XzNmgZCvQUNfESMt7tSO3snw7iR
 kOKYptTyGTAzXeH/y/Uia3+R4VMygz3dAsQ+6VMQohzOwy0RLEAHPn+GxM04x5Cvwo0=
X-Gm-Gg: ASbGncsSbjK+SSQSfFF4tK1liorkHj41aqxFrdTSf66fGv/u1IJNxam61Z8ChNCXOGY
 nIWNJF6soS4ZMc6UKptOJTC4GDcHSRBle9ajNpNdAY/SfhOH/DafTC1pXIhN821ksoDE3S7d/bb
 rOrXg+oNW1QxE+U2EvzKF+GXXmKhks/JZlcYbIfAl1f9jBwvznnB0l0qZwF7ePJSq8YQ5+qlkkQ
 bBqBIKinUKIXH4v9cu5EuS9rT9joFS/4Qxbn48lxRv3mk9SZHR5fNJE8GC30n2KmzrVMQKy9mtF
 PQ2r3cgK8Lr/Pvxmeea4t+wiytP+ckzWanW2B2oEUH/Siund1x5EvDD9xSCN9dNKZPPfItiGkuR
 TomiTstTFsEVG+zcrUrHC/rw=
X-Google-Smtp-Source: AGHT+IFSjs5IDSMtAuyExfEYs0ntqvNRTS/F5wQCriDmfdeKReg3ggMo+pz8EEt46J+F5NNPYtnUJw==
X-Received: by 2002:a05:6870:f213:b0:2d5:4f51:37fa with SMTP id
 586e51a60fabf-2efed73e954mr696346fac.31.1750981640011; 
 Thu, 26 Jun 2025 16:47:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ef7024sm607074fac.13.2025.06.26.16.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 16:47:18 -0700 (PDT)
Date: Thu, 26 Jun 2025 17:47:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [RFC PATCH v1 1/4] spl: Kconfig: add SPL_SECURE_OS_BOOT config
 symbol
Message-ID: <20250626234716.GY4003484@bill-the-cat>
References: <20250626120443.1405409-1-anshuld@ti.com>
 <20250626120443.1405409-2-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qqy6rYaAWoTgTGez"
Content-Disposition: inline
In-Reply-To: <20250626120443.1405409-2-anshuld@ti.com>
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


--Qqy6rYaAWoTgTGez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 05:34:39PM +0530, Anshul Dalal wrote:

> This patch adds the new SPL_SECURE_OS_BOOT symbol that enables secure boo=
t flow
> in falcon mode.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  common/spl/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 880192043c4..8d153c2e9c9 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1196,6 +1196,13 @@ config SPL_OS_BOOT
>  	  Enable booting directly to an OS from SPL.
>  	  for more info read doc/README.falcon
> =20
> +config SPL_SECURE_OS_BOOT
> +	bool "Activate Secure Falcon Mode"
> +	depends on SPL_OS_BOOT
> +	help
> +	  Enables support for secure boot in falcon mode by restricting the SPL=
 to
> +	  only loading a fitImage instead of raw kernel images or DTBs.

The base symbol here is SPL_OS_BOOT so this should become
SPL_OS_BOOT_SECURE and say something like "Allow Falcon Mode on secure
devices" with the help text saying that this allows for using Falcon
Mode on devices where general security features such as signature
verification are enabled and this will then disallow some inherently
non-securable options.

--=20
Tom

--Qqy6rYaAWoTgTGez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhd3AEACgkQFHw5/5Y0
tyxAJgv/TksTPOcqAdOqetpH05XIgGF7vfvG4owt1ggRiyVBzgaf2jwsERFD5B4l
kQc51h6C4khlxqqOKLZcBYx7IZxlOjVcskWFpQx4o7bASzPKa115+Nstmcpi6U4K
FQ92VUthclHqjReWhRJTRPSDG3qygxdhInI6LU4QhI+T/uwDq7u7p1Zn1YNUqFiG
hFFIvdEPP5S7978PCHy6TZ16rq6avuofs2isqMuG2a4Hfui/PJkQxiUmCzDo7ErW
AljnC0Jgk4XAoACQQgpoYr+ciZyKMPHUtG8Qek1OQJTsnLmFiEJTYp2Ql4kebz6P
YV885ktRkJbOlar5iHms7/vL5zZ7nbT+lDFD1FO1co0wX30VwVlFS8N79G8mfKbj
L4Lurf6k6tokI0sIzkxrgk5wVcihCwTaCtPdO2i5fFgFy0Vp9XMiTYvJ0fq9Xn1Q
r3NSzIO0fYfUd5TyxTNuqYYrfenv66KHK2dnwHL2aGbYrWMs2XEITXDden6hCD42
OQHGvlNQ
=2nZY
-----END PGP SIGNATURE-----

--Qqy6rYaAWoTgTGez--
