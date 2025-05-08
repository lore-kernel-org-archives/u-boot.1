Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D970C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DDE982905;
	Thu,  8 May 2025 17:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GdUpmTz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115E682928; Thu,  8 May 2025 17:27:17 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAEE5828BC
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72b0626c785so968660a34.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746718033; x=1747322833; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PBBCiycTeOJjCYqJ9PogWfcLPGPY7eRY//ozNPXG5sA=;
 b=GdUpmTz5cFrmS1ajLoMCSBZUE/kvB+Hk1yuyD7e6iyI/gxhdPcetmT0p7R0CIC6X76
 JqaOPwRRgnOM6qgENgWp6FrFeZImKjK0iQk0pmBHO+DXBFPfqDx8IiWTp0/k1lO87z+5
 USaQrNg+GDmXBqAoE0zBX2o2+Zncc1MAt/Auc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746718033; x=1747322833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBBCiycTeOJjCYqJ9PogWfcLPGPY7eRY//ozNPXG5sA=;
 b=vv55Q1kJIGHptpSetLVZhKmbAUce+04G5UJCqFYa7mgSEgBkCjMH4+3FUwuagATipV
 rw8b3UShGvIwgRl/bGLK3IE5pGjQ9gBfu5EtDN8pUansXeiGAWMrAQ1Qiy+l3LitSPfc
 gtINml3a6UdP2nokCJT6GMNpI/efxB5+nisiLx1z3eNvrVKaiAJ9yPbF4UEvExjz/Hrh
 rlu1AYXKFfymc7FDLbBc627NLfG0v/2tnxTgeU7fz4ypH3hDASzBk/NE6ZFMXY2/fwth
 qJht78Pwvtcy6rF/wE/Y+X/Hb20VM1rIHw6O0Wyap/WbEWmehjbIUVIRmqa/AeU0atGn
 pw3A==
X-Gm-Message-State: AOJu0YxHatZn2Z1Wncxqe2UK+KYarf1QSSbQMMMa7i472p+dSKZRHSOW
 r0q0fgX1EEocOlDrb2JH95fPxW+TYhz0M74I8zgkbRlv/1PQHceAvPj/Oj+Y6I8=
X-Gm-Gg: ASbGncsfyeaRcuIEcjY0smlg0NFFgxHaupSm1h3k0s/VpT8C30tftSPIM/OLIG28MvR
 8VDrtf4mC272BaWS2Qp6x3oGik1pJeWtryb2iJFprK+b1xo4c4oZI3CY9zdAgM5zVFXquae1Uhf
 O7bwDQ6SUfpQ+zBExuCzjJnHKBOeFIlIfCmHtt6SRZxhJrwARBXc3/nddT8JJs3BMJ7FRWEKnoB
 zSABnEkdnD5CZZgkUTNkQul2P4hQrO3VIfbFzofrzWLkfS1uL/+85oCpcJPOTgtXvJLG2EU0e4I
 rU67I3V+m8b85nFqtD2VT3EZk+vF5vUSx/I+uajNw1i/wM6jWgYr1b13Jm4y6v8OMUHgk2r4yQJ
 ZDw==
X-Google-Smtp-Source: AGHT+IE1kJNDhJ4l/U/384v5qhmZmZainkhjqUwd1fjoifp19UnMemT9QOtD61938NQVobqK5kk/Cw==
X-Received: by 2002:a05:6830:661c:b0:72b:9bac:c044 with SMTP id
 46e09a7af769-7322680b043mr125260a34.0.1746718033491; 
 Thu, 08 May 2025 08:27:13 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732264b0ad2sm45129a34.26.2025.05.08.08.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 08:27:12 -0700 (PDT)
Date: Thu, 8 May 2025 09:27:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, joe.hershberger@ni.com, sjg@chromium.org,
 d.schultz@phytec.de
Subject: Re: [PATCH 2/2] mtd: bootdev: Add Kconfig option for defining script
 parameters
Message-ID: <20250508152710.GA603748@bill-the-cat>
References: <20250508131641.2561876-1-w.egorov@phytec.de>
 <20250508131641.2561876-3-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bnStMSMykRMUe4MJ"
Content-Disposition: inline
In-Reply-To: <20250508131641.2561876-3-w.egorov@phytec.de>
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


--bnStMSMykRMUe4MJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 03:16:41PM +0200, Wadim Egorov wrote:
> Introduce USE_SPI_FLASH_SCRIPT Kconfig option to enable setting default
> environment values for loading boot scripts from SPI flash. When enabled,
> SPI_FLASH_SCRIPT_OFFSET and SPI_FLASH_SCRIPT_SIZE define the default
> script_offset_f and script_size_f variables.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  drivers/mtd/spi/Kconfig | 26 ++++++++++++++++++++++++++
>  include/env_default.h   |  4 ++++
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
> index ca60a425ba3..fc154ec89d7 100644
> --- a/drivers/mtd/spi/Kconfig
> +++ b/drivers/mtd/spi/Kconfig
> @@ -89,6 +89,32 @@ config BOOTDEV_SPI_FLASH
> =20
>  	  If unsure, say N
> =20
> +config USE_SPI_FLASH_SCRIPT
> +	bool "Enable default SPI flash script parameters"
> +	depends on BOOTDEV_SPI_FLASH
> +	help
> +	  Enable this option to provide default values for SPI flash script loa=
ding.
> +	  These values will be assigned to the 'script_offset_f' and 'script_si=
ze_f'
> +	  environment variables at boot time if not already defined in the envi=
ronment.
> +
> +	  If unsure, say N.
> +
> +config SPI_FLASH_SCRIPT_OFFSET
> +	hex "Offset for SPI flash script (script_offset_f)"
> +	depends on USE_SPI_FLASH_SCRIPT
> +	help
> +	  This option sets the default value for the 'script_offset_f' environm=
ent
> +	  variable. It specifies the offset (in bytes) in SPI flash from which
> +	  the boot script should be loaded.
> +
> +config SPI_FLASH_SCRIPT_SIZE
> +	hex "Size of SPI flash script (script_size_f)"
> +	depends on USE_SPI_FLASH_SCRIPT
> +	help
> +	  This option sets the default value for the 'script_size_f' environment
> +	  variable. It specifies the number of bytes to read from SPI flash to
> +	  load the boot script.
> +
>  config SPI_FLASH_SFDP_SUPPORT
>  	bool "SFDP table parsing support for SPI NOR flashes"
>  	depends on !SPI_FLASH_BAR
> diff --git a/include/env_default.h b/include/env_default.h
> index c72cf123004..9f2f222519d 100644
> --- a/include/env_default.h
> +++ b/include/env_default.h
> @@ -127,6 +127,10 @@ const char default_environment[] =3D {
>  #ifdef CONFIG_BOOTSCRIPT_DHCP
>  	"boot_script_dhcp=3D"	CONFIG_BOOTSCRIPT_DHCP	"\0"
>  #endif
> +#ifdef USE_SPI_FLASH_SCRIPT
> +	"script_offset_f=3D"	__stringify(CONFIG_SPI_FLASH_SCRIPT_OFFSET)"\0"
> +	"script_size_f=3D"	__stringify(CONFIG_SPI_FLASH_SCRIPT_SIZE)"\0"
> +#endif

This should be CONFIG_... yes? Did that just get missed in uplifting
this from, I assume, an internal tree?

--=20
Tom

--bnStMSMykRMUe4MJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgczUoACgkQFHw5/5Y0
tyx5Agv/YS+3/NepO9tLj5JNYx8fCKfI4Vl+GaHDcvlfpb7EN1SWHi+npsmaENUU
er9UBA3Vkz+9Gf4+gxrTkXIyz4o6EES/s/3ZYfoDuM5joWjvjf/u/fozj/EAHJqv
WpblX8T7G1+Oh8yL6Uj81kLvhsLfKbEY+UEivU5+/1mkTa68hySDbJHF5RPBUSp3
l0NAVX7LmOcs+EuPaEiNKkGb3RAGDJe5fZbC7biRpAy8LIRe9Hixcx4Ypuilba9J
r7Fs1yLIsC7J6IY8vUtvw2jFLoS1dLEYBZ1d8lPoVY69+b7g6OZ1nL8LNiIPMsU6
8+WuXGuIMqarJvYsSITLsd7+2jJW2fepXhWxQ0FP28oiyVOjPr6adNNVSX3y0r3E
WTvLzbKhdSF7TJdtXxnG3CLDkSo+VfQYQsss14GkrUeQG6g8jbq5nE/sjPMrJEqX
hMF3LNvznntF9AkicWIyGtGxpeo5RiwmTpTvAk8C87BKGvPwvWoU4MDPvijDgj3V
g6Ki86IC
=4cCE
-----END PGP SIGNATURE-----

--bnStMSMykRMUe4MJ--
