Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CFBC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 23:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EC1182E05;
	Fri, 27 Jun 2025 01:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uWvqU5Jn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3603E82E40; Fri, 27 Jun 2025 01:47:49 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDE682CEB
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 01:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73afbe149afso208628a34.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750981664; x=1751586464; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7CEj7975XUxE+4WJ72Ikw5ipYYymgRAlGkOzm+Rf7p8=;
 b=uWvqU5JnVxXrb5t1jUG1cGzL+zYYPRw7uHE8pUxRcwFXpIT5gQ4U9efUMhRjfoakVj
 Uj6G8E8d9qJKz3MuMyg7R5ylCiznlz5/KF51oFBPVSDUy+fQ32gNmtYfU1qM2AYWkpuN
 pJKk2TlMbZHLyBX+Vkzw3SfWbBiOnS/qlGJrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750981664; x=1751586464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CEj7975XUxE+4WJ72Ikw5ipYYymgRAlGkOzm+Rf7p8=;
 b=OsE/7T0bgmMtTUOlBIVDBS+5/3uZe4livT36bFUyMWecxqgmSjt7Fyq3NPUYYP8J2t
 XoWN5h4BLGom4j5hKWI7gReGTn9dJtSI2cKGVLcmsaNr7dQRVWDkVsNltzEfysBOPsgK
 rBBL7qM7fObmHWiDq0M6YNOIi2x+lINNdFaNb1qEcWok8fXfEJ/BHdR5inEZ6IXdK00p
 T6uUCLtHtuA9p2htPzzVS1o9PgrHENGp5Ry2Ar+r3FAOUwP1vLBPQGLXEG7710xuCVez
 yIi4VyEgb9jBFI48h3ppwvzCVWpbLOr9xsDpD0RdTbFZRdsvzlyuSR9r/WGZY+zuyLBX
 466w==
X-Gm-Message-State: AOJu0YzYkQrHrZvkUU3lScac0VvG4aoCDYVhi4r8SMpdXRTcoZPiFz74
 e2fiQ7mcjozdsbKWzwn6ca/g1T/7zNNt12QfUFLFcTBGPM+UGsUtqfJFboO3h73nOfc=
X-Gm-Gg: ASbGncudBUcC6IHwFRWMKM0cLBfIHicNc7ArRVLQLvq+tgBqLNeZrwAFb+VFj0OlYKk
 nj4NCmJex/bQX8sT8nuebVqM7Xi+qeacHMWEsSQPa+nKO2Kb564jndIQYiQ0a4SUjJI9EdDCBEv
 cmMJc7h2nF9N8axb0g1tlsjlzx5jEuyat2JiSgG43S9xtpHNTJQt8sgvOsqKBLT1Ao67pSL7DE4
 pvi2zloRnIl3tnF7K0wmJaxrqPwWKOAiw7/6vGqQvmGuFiIytcLSf7RfNZk2napmfm84OZj2/le
 b9lMPV+hwIVJUZ5roEAq/rw4zE1AAu0TT8C5tSyIxWBh4oZw/4Qy5gF9Ml14Nz4Jncg9Q92iaib
 z28eDdqFP7KkaJgO1IkasAak=
X-Google-Smtp-Source: AGHT+IHho0q5lKmxuKSAJBEFDMwVvRKGFRH/A7Ia1+mlQD+mEwRg0re9gMtsEQz28XV8KzOLKSFrHw==
X-Received: by 2002:a05:6830:8216:b0:72b:a064:fab0 with SMTP id
 46e09a7af769-73afc3dbdd4mr652021a34.3.1750981664045; 
 Thu, 26 Jun 2025 16:47:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff2429sm166326a34.7.2025.06.26.16.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 16:47:43 -0700 (PDT)
Date: Thu, 26 Jun 2025 17:47:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [RFC PATCH v1 4/4] cmd: Kconfig: disable loading raw images in
 secure os boot
Message-ID: <20250626234741.GB4003484@bill-the-cat>
References: <20250626120443.1405409-1-anshuld@ti.com>
 <20250626120443.1405409-5-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cQZOBY5t4k+GwlDc"
Content-Disposition: inline
In-Reply-To: <20250626120443.1405409-5-anshuld@ti.com>
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


--cQZOBY5t4k+GwlDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 05:34:42PM +0530, Anshul Dalal wrote:

> Raw kernel images can not be authenticated so disable loading such
> binaries in secure falcon mode. This change restricts the falcon mode
> SPL to FIT as the only viable boot image which can be authenticated.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  cmd/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ed741d43cea..8eb55dd7f6e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -353,12 +353,13 @@ config BOOTM_ELF
> =20
>  config CMD_BOOTZ
>  	bool "bootz"
> +	depends on !SPL_SECURE_OS_BOOT
>  	help
>  	  Boot the Linux zImage
> =20
>  config CMD_BOOTI
>  	bool "booti"
> -	depends on ARM64 || RISCV || SANDBOX
> +	depends on (ARM64 || RISCV || SANDBOX) && !SPL_SECURE_OS_BOOT
>  	default y
>  	help
>  	  Boot an AArch64 Linux Kernel image from memory.

This is just pushing things too far and we need to step back and fix it,
sorry. We need BOOTZ_IMAGE_FORMAT and BOOTI_IMAGE_FORMAT to go with
LEGACY_IMAGE_FORMAT, and then SPL_... variants too, and then use those
symbols.

--=20
Tom

--cQZOBY5t4k+GwlDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhd3B0ACgkQFHw5/5Y0
tyzwQAwAtjD1sn7pCJkvxoqUDheB9X5nk7amEuBGpc5/DzYq/llo2Fq5N+NBbZxc
iTMyY5XyhKLodfjDs+vy8jZQrSiHYM1mnxd3R+X1BYQTwub8DM944DmJPQfXiEmh
vvqODNV2Y+24mdY8icTuFRvHwSsUAleHiRYgA0AzeiAK2cOMxSkCblE0wp/eTLc0
tYfBL2w/2W7ZLDcz71m12bgQvtV+c/oizAshBqiLTh1+AkhCWzvzqR1Nn5B4uPUu
lEt01fHrheR7frPVW6UGsXzE18JYxD3aV93mWNZhIQdNuHVahllqCPgkVIPAArAH
hIIEkG9wu3ysXrKFe4YejRZZmbsKnCYzRaQpJvg7cN80Dt7Fr8MzPw0dGJHd3h2o
cYP80w1R2lhFQ4RpPwh0WRDjqh4pm7oiFhSQvQLiYkYGd2iMS75O5ZLz5xm2LHNb
4b+jZaoSxvaSRXybUvZZTP+rQwbTQiDGXOv62ykmuF1x2qwhWvVOPxt5fAJ2CH7x
M5G5aD5D
=SNJN
-----END PGP SIGNATURE-----

--cQZOBY5t4k+GwlDc--
