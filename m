Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBB9C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABC581CA4;
	Wed, 12 Mar 2025 19:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AoeGM1++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF798169D; Wed, 12 Mar 2025 19:23:23 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2F4807D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6e91d323346so2272016d6.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741803799; x=1742408599; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VHt11LqNXlzf7bOrx67kbBtZg27ZFAxjWVCGQGgj7mo=;
 b=AoeGM1++wnvVMZKdXP/LIEJ2gWXm3vADnEpDPipRa1yjCeKwv+SZNx7Kw65IRRrfIb
 gdYaxL7rM1IckXAwzkcb9k036HGuhZiNNw5Znps3aBEHUPYaQpQ8+1Pm6w6SL3io+37R
 OPWOWjbE0baKN0N3e2yqXFiV3XU1EQEFCb5a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803799; x=1742408599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHt11LqNXlzf7bOrx67kbBtZg27ZFAxjWVCGQGgj7mo=;
 b=WKJ8MJ5kjwu0dv8uiXMp0Q7nNT6KoDCDr1PyhDWEp2yNMiu4q0xHBtZ5VQNzPVb1fS
 75IUDDREBJOZCYsrPgwOdLDE6cdqUzboutDcg5z300aJFIGYfKLhuc2c4hcNd5ElQLBW
 /NUzJGXdDop7Nogcu3Byg4Sz5HYkNdmJSZ423/JtL/uTGnll1OmMfWzA14LpQWdfJS/2
 ElMOQxvLLEvqVE1CuFo/H4ytZVTGV7DiUjUNydfGG1w8D07rIFVldlL/9N9z3a9RYxUM
 dtwIRnn7v/1Nh+/IlIsAg3nQ+1I5LXi59kx1JLAAgw4fMJFcaHi6cwf6ENsq8A1akL1Z
 8+Sg==
X-Gm-Message-State: AOJu0Yyg/lB0Jpqe0tcytgJWK+kqcLM7X8faPoxyIYnq0/Pe4NG3EH/S
 JSOXbZSn3vxLUy5Q7doBLJ907ZUTLpOThYJNkMLfVhImpdHtYHdWXyZkPQEJpb0=
X-Gm-Gg: ASbGncsMOtBEx33djGWeTe5PNwtknDi19XmeVbQVqv47NcaDdhhdFGZJ0czHBh3hRik
 mUAaUSFComg14Q19oPSaERdzqwpQGn1yF6vdo8U6889fQ3x5EaDRPlX0AgeSpVNIhYfNEMl/AdK
 Q1RnFfl/+9QUOT6LmkPngEY3s0st1AghF7x0bLHX1DnNyLg1asR8hBr3g0gk6sCC/8Sm6KRVWQy
 2LVmt1iUfcawGc84x+NxtnsP+4FJMzya0PaqXK/iWFqqtJBefK8Rg9eLyNQ0X3bCn6u3EMFglcn
 G1RwHPHmyXcODKTK9uMDkIwr9wmInJc5uVoJsW/mOvK8JA==
X-Google-Smtp-Source: AGHT+IFWIR6Qt6iWxPj1XndGoJanlrxwhOsaadVKO2YG2vZekDimF2eL431gz7PxBO+5TlGcjdZgEQ==
X-Received: by 2002:a05:6214:3288:b0:6e8:8e91:fb2 with SMTP id
 6a1803df08f44-6eadb2cd296mr11653686d6.0.1741803799475; 
 Wed, 12 Mar 2025 11:23:19 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f707c61csm87646386d6.4.2025.03.12.11.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:23:18 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:23:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v3] spl: remove usage of CMD_BOOT[IZ] from image parsing
Message-ID: <20250312182316.GX2640854@bill-the-cat>
References: <20250312124757.789013-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tIicPfH2/jIsQj33"
Content-Disposition: inline
In-Reply-To: <20250312124757.789013-1-anshuld@ti.com>
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


--tIicPfH2/jIsQj33
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 06:17:56PM +0530, Anshul Dalal wrote:

> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> patch replaces the checks for CMD_BOOT[IZ] with newly added configs
> SPL_HAS_BOOT[IZ].
>=20
> An imply clause has been added for CMD_BOOTZ to avoid breaking configs
> that rely on CMD_BOOTZ in falcon boot. There is no such need for
> CMD_BOOTI since it's already enabled by default for the platforms that
> support the image format.
>=20
> More info:
> https://lore.kernel.org/u-boot/20250310135544.GV2640854@bill-the-cat/
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Changes in v3:
>  * Add imply clause for CMD_BOOTZ to enable SPL_HAS_BOOTZ
>  * Fix broken check for bootz_setup
> v2: https://lore.kernel.org/u-boot/20250312094241.629707-1-anshuld@ti.com/
> Changes in v2:
>  * Add SPL_HAS_BOOT[IZ] configs
> v1: https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.co=
m/
> ---
>  arch/arm/lib/Makefile |  4 ++--
>  cmd/Kconfig           |  1 +
>  common/spl/Kconfig    | 13 +++++++++++++
>  common/spl/spl.c      |  5 +++--
>  4 files changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 1c95dd6fed2..e857adddd03 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -36,8 +36,8 @@ obj-$(CONFIG_CMD_BOOTZ) +=3D bootm.o zimage.o
>  else
>  obj-$(CONFIG_$(PHASE_)FRAMEWORK) +=3D spl.o
>  ifdef CONFIG_SPL_FRAMEWORK
> -obj-$(CONFIG_CMD_BOOTI) +=3D image.o
> -obj-$(CONFIG_CMD_BOOTZ) +=3D zimage.o
> +obj-$(CONFIG_SPL_HAS_BOOTI) +=3D image.o
> +obj-$(CONFIG_SPL_HAS_BOOTZ) +=3D zimage.o
>  endif

This Makefile hunk is weird and not quite correct today, and this change
makes it more odd. We should drop the CONFIG_SPL_FRAMEWORK check because
we're already in an CONFIG_XPL_BUILD check, and since we're making
needing these objects explicit now the very rare case of
ARM+SPL+!SPL_FRAMEWORK won't try and include these when not required.

> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index a04fcaa0e08..9f2ba4d02f8 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -352,6 +352,7 @@ config BOOTM_ELF
> =20
>  config CMD_BOOTZ
>  	bool "bootz"
> +	imply SPL_HAS_BOOTZ
>  	help
>  	  Boot the Linux zImage
> =20

We don't need this hunk at all, we already (should) be getting the right
file via the current logic in arch/arm/lib/Makefile

> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 21a5cefee7a..e0e804ae8dc 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1153,6 +1153,19 @@ config SPL_OS_BOOT
>  	  Enable booting directly to an OS from SPL.
>  	  for more info read doc/README.falcon
> =20
> +config SPL_HAS_BOOTZ
> +	bool "Allow booting to kernel zimage from SPL"

How about:
"Allow booting a zImage style Linux kernel from SPL"

> +	depends on SPL_OS_BOOT
> +	help
> +	  Boot a linux zimage from memory in falcon boot.
> +
> +config SPL_HAS_BOOTI
> +	bool "Allow booting to kernel image from SPL"

How about:
"Allow booting an Image style Linux kernel from SPL"

> +	depends on SPL_OS_BOOT
> +	default y if ARM64 || RISCV || SANDBOX

Do we need SANDBOX here?

--=20
Tom

--tIicPfH2/jIsQj33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfR0RQACgkQFHw5/5Y0
tyxfVAv+MM6qpNrZFwVMggEvmKwF9gruF1npVXNHYx76YWzh8+CEhMPk8ZDdGF1c
cRlyZTQPfmx1NSwfXD0gwotghAJGf8sGCdQsgyzDQDXCJ0J+5UuefyGYMSibUD9v
o5h/zVZEuULDvmTyLckFHkF1iNrOts0I3EysBrriMzaNQa/wzv5ASaa1Oqefq8VA
mqdRoL5qO/fLBDBphOErPrICPv4nvqrpH4WyuHBois3HECGAHCAWRu/7iKWGLnA5
WpSdW8aAgUTuW2I5dUGZDNgHeeXMis6wTvUt+jAW7WqGtUW17lxFbVMyj56R+H9B
2A9PLXdAYE9k1TB5OtlLj+/vo+IVetscf2ISTX9478FBF94cpUIRKDIL985oPwp6
CU83toVGYenoQS/+bQegCmeAoOH9Ju+LCWgRO4/xGXjrrnEtXq137W2eB7Jd4tY+
mzn08VMUlyDxRSPna57HvK6Wy3L6SncZb4NETFWqbtrq30m/wiaW7hJ13CWmot6k
hBHpymSi
=WnaD
-----END PGP SIGNATURE-----

--tIicPfH2/jIsQj33--
