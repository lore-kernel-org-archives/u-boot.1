Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0F5C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9783A828D0;
	Mon,  5 May 2025 15:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rJ5ncJF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BDE8212B; Mon,  5 May 2025 15:38:44 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC2DB82A25
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so1042565a34.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746452320; x=1747057120; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8elGrtCz0q8OGJIYzrG4x1cEHgx2Fv7+3wWTzjzb/98=;
 b=rJ5ncJF9MBzQbqFSz01bv4K4k31T4kI9L6YfXN96EX9OsAEPPRThcjCu41T2x3MG9C
 2Uyd1y4fqO9B3qzaAVRNsYGtELsz/w1mVfhYXH5x91sb3m9nfy5mn5cwawn9t1+HOjDO
 NAKKAKsBT3iJ7544B4APTTsY/Jyy2oaOhEZWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746452320; x=1747057120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8elGrtCz0q8OGJIYzrG4x1cEHgx2Fv7+3wWTzjzb/98=;
 b=vFxeeSp27YoZyHjVOj8rqQYY+zicQhrJm6821vsdqSKl9NDb7BhwxNLpW6guLT+eRx
 l44dv55uAuiK4meWgmARSJIbCfLrtRkhfVdrNACAd1KkJEAyRNs9ElXNpHJdSaW4fk//
 0kgsYBQs8XGJDZ3cHEZacSUo+WTrsI9/73A35CP9Te10n2rWVwSOSriF+fWZooGhuhrm
 ER7c+KwSj/01jI0VhghBIuMoSgytbYjDG1OurwlpBdHhWwZnYPOToF5xiRlalvjOYl+I
 bja8YD4omh7NgKug9AKZwbAtgIaWWXbI1Lx+tk2vRb+w0PUJgjBv3xvc/+ENlcV8md6s
 qBCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVESnsPENbhyq4iDyrFeYVx+H+4ws66tFGbfEeP9C4Y10AsdmwxVlFnRxgLLHOSPyOx/Zcm7Mg=@lists.denx.de
X-Gm-Message-State: AOJu0YyYbUDJZfBxu8I+Hjxi2c+OvSg0PjSEidvfTEDOz/MYm8Z1J+Ic
 xSq1rt/7q1LzqiQ+RKZhfztyvab0U2OfGS0yveD+HvDHLhVxMyhliMyh8VZQRZo=
X-Gm-Gg: ASbGncsHcXBkjwIX69zIhMsQMleiBinH7RwskkPEBTN5UN+9ZJktaq0a0jWQa3wt1YA
 KgIzS+MKcEsnRI49X/EBMQN6FgNeHznm0l0u+XFuBjM6PNcx95Ks2Wl6P40nx+h4RajeFZpLCdB
 rMC6uZ/5vIElM/a+jDC3uJ/9Jjm/AGnK07FiXmf62znaqRjfiHModO1o2yILLTVzmid9ycFReUW
 LrvZRPzSABih3DGtGAb5BOXh11qQ91b3AtYlnrUKkalnXa61nxCkALzstf+TeW2qS+f4YPCkE1N
 f/nGXE7yuzW4FVQM4AZbfrao2DMgBq3kJDqssBmSIMvWUZp+7ORs/ct9AX0N4U0AQjcJVTP3IvA
 ZzA==
X-Google-Smtp-Source: AGHT+IGYBkmxFjYE0rGr42QpYBQhl5ldzHkbTGrqhc2+y890Hu4UEJ7+j1JxBZ1uk4C9U6+TpU/ojA==
X-Received: by 2002:a05:6830:470c:b0:72b:a3f3:deb6 with SMTP id
 46e09a7af769-731ead6592bmr4310749a34.4.1746452320629; 
 Mon, 05 May 2025 06:38:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa126a466sm1959188fac.46.2025.05.05.06.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 06:38:40 -0700 (PDT)
Date: Mon, 5 May 2025 07:38:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Subject: Re: Convert xtfpga U-Boot platform to DM_SERIAL
Message-ID: <20250505133838.GG1261075@bill-the-cat>
References: <20250501230349.GM1261075@bill-the-cat>
 <aBg7QQlJiV8FftqG@octofox.metropolis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XfTw3ghimvAeFoHa"
Content-Disposition: inline
In-Reply-To: <aBg7QQlJiV8FftqG@octofox.metropolis>
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


--XfTw3ghimvAeFoHa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 04, 2025 at 09:14:57PM -0700, Max Filippov wrote:

> Hi Tom,
>=20
> On Thu, May 01, 2025 at 05:03:49PM -0600, Tom Rini wrote:
> > Does anyone have time and knowledge to convert the xtfpga platform to
> > using DM_SERIAL in U-Boot? It wasn't just a trivial enable
> > CONFIG_DM_SERIAL and have success so I didn't look harder than that yet.
>=20
> I was able to build working u-Boot for the kc705 xtfpga variant with the
> change below. I can submit a proper patch If it looks correct:
> --8<--
> From f0b6e632da8b72f0437a39dc1769b740fef04cf6 Mon Sep 17 00:00:00 2001
> From: Max Filippov <jcmvbkbc@gmail.com>
> Date: Sun, 4 May 2025 18:40:44 -0700
> Subject: [PATCH] WIP: xtensa: enable DM_SERIAL
>=20
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/Kconfig             | 1 +
>  configs/xtfpga_defconfig | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 9bb3fe22402f..8d469a395f8c 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -361,6 +361,7 @@ config X86
>  config XTENSA
>  	bool "Xtensa architecture"
>  	select CREATE_ARCH_SYMLINK
> +	select DM_SERIAL
>  	select HAVE_PRIVATE_LIBGCC
>  	select SUPPORT_LITTLE_ENDIAN
>  	select SUPPORT_OF_CONTROL
> diff --git a/configs/xtfpga_defconfig b/configs/xtfpga_defconfig
> index b96dc10d85be..68656949660a 100644
> --- a/configs/xtfpga_defconfig
> +++ b/configs/xtfpga_defconfig
> @@ -4,6 +4,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x40000
>  CONFIG_SYS_MALLOC_F_LEN=3D0x400
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_SECT_SIZE=3D0x20000
> +CONFIG_DEFAULT_DEVICE_TREE=3D"kc705"
>  CONFIG_SYS_MONITOR_LEN=3D262144
>  CONFIG_SYS_LOAD_ADDR=3D0x02000000
>  CONFIG_ENV_ADDR=3D0xF7FE0000
> @@ -28,6 +29,8 @@ CONFIG_CMD_SAVES=3Dy
>  CONFIG_CMD_DHCP=3Dy
>  CONFIG_CMD_PING=3Dy
>  CONFIG_CMD_DIAG=3Dy
> +CONFIG_OF_CONTROL=3Dy
> +CONFIG_OF_EMBED=3Dy
>  CONFIG_ENV_IS_IN_FLASH=3Dy
>  CONFIG_USE_BOOTFILE=3Dy
>  CONFIG_BOOTFILE=3D"uImage"
> @@ -46,7 +49,5 @@ CONFIG_SYS_FLASH_CFI=3Dy
>  CONFIG_SYS_MAX_FLASH_SECT=3D1027
>  CONFIG_PHYLIB=3Dy
>  CONFIG_ETHOC=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_SYS_NS16550=3Dy
>  CONFIG_SYSRESET=3Dy
> -CONFIG_OF_LIBFDT=3Dy

Looks about right to me, thanks!

--=20
Tom

--XfTw3ghimvAeFoHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgYv1oACgkQFHw5/5Y0
tyy8KQv/dsPgRTzD8X7NKb8Jnvc91PHu52r0xvvf2ZD77CQz24M8t0UZqphw3Pf6
dZFoar6Z5KxNEWs5tCyw+BTFhlxB+/f+PiwaghR3QFMmsmA5hVMFFiatjUPh5S5L
E7q+v82l/fzwX0Fg/1FQtcJosRmY8VD2Zz/tViJjn1nD3TSTKxcO0kiCzUY4s+6i
7BpLo7YACLccddsjiUsJIO0s6Vv+HQ5NRT73IsYqPs0YzFsllvHrzSCQWbiMQqFc
1wFrKu8fb/wWpBU9HZZeK4DxeDCwsjueiTOehK+9sw8LowCNQhxAUrtMAjKzscYp
+cNu74S3N3atR5ry5rGhA3a7GoEmgazDqEHScOyrdcrOUkzZ+nQqO41H+5Npf9qf
f7ye1nWy/DaN1Hfu/d+31WQADnB7Eyzx7Xq2sN6Wpynnnzz/InQN8zxv06Xpwvfz
xFK3y74xzttBfTGNQHkEO9JKT6IVh162oxFOs/rxDcC4g7yv4Kvlej/VAXEQBVCN
h0zRBhmg
=Vlau
-----END PGP SIGNATURE-----

--XfTw3ghimvAeFoHa--
