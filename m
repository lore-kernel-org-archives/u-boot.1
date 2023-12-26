Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826D5C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07FEB86FCE;
	Tue, 26 Dec 2023 16:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f3QgWw28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E83D086F87; Tue, 26 Dec 2023 16:50:11 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EB6F87855
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dbd029beef4so4143824276.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703605808; x=1704210608; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C9chyKigqgeT4b/oJBSvqn+luF90w7w8ht9G3XNrQ0Y=;
 b=f3QgWw28Tb9SzRMF/RzaSq5Mn7PmmA6LEzoUZudizOqE5DmPRqf6PDwYE+YLVVeDwh
 VSowFTzIz6DSfjqJ2QmRx/5NBvDAdRl3UqqcHo55qUXoIfX4T3dKtdZBspB6jPG+1rX1
 OrXYAxU/0ap4VEufO1leoCsNuHbA/yhC/N3es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605808; x=1704210608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9chyKigqgeT4b/oJBSvqn+luF90w7w8ht9G3XNrQ0Y=;
 b=uIYZ+I6liqbQyjAwMu6ZvgyBMz5dkxBsxwx3bJ1sQ7SjRn7mY3s4Kl9stBkxPL5r5/
 m8xG/VbDBnOimd4svJeZwhgTG4Zb0BKpGl74B7P93n3VL0s9VlyTbwR4sR1PZp0OgG5f
 OfhABUGEYIKYzVHcoHzNPQj8rDrprACNfbhp6EYIthgnVWo8xlBpahSbcbjyeFQi2+fr
 JZgPBmBadvI0YURg+6PKpEvI1jQUs8P6RhU36sUbVdzUmeeoM/dlKLTmT/CPj7vUnN4r
 sTKWC9zceukD0T8CKKg19kH5L8Xc9ZM7zqbDLIaxMA4Sj9iyQwtXpUGFdeQ9I3tV+iVi
 I3zA==
X-Gm-Message-State: AOJu0Yww1JnFwZjkL7b4G+m6NosM0eU74y5kXcdo7j8iS9m7hlb+sMBS
 N1uwUWHGPWqXbTgL+/uoOEAuTvUiEnzADw==
X-Google-Smtp-Source: AGHT+IFCbKP6+CzZ2BtbQXHQ/cEYAmPumvQmPpEQ9EKOt/Lq3mW5G/JDeM6UqaVP74y8wrcL5RBlnQ==
X-Received: by 2002:a25:ab4d:0:b0:dbd:b205:407b with SMTP id
 u71-20020a25ab4d000000b00dbdb205407bmr5466542ybi.55.1703605807944; 
 Tue, 26 Dec 2023 07:50:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 k3-20020a0dfa03000000b005e7535a3303sm5583150ywf.91.2023.12.26.07.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:50:07 -0800 (PST)
Date: Tue, 26 Dec 2023 10:50:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, lukma@denx.de, git@xilinx.com
Subject: Re: [PATCH v9 8/8] axm/taurus: Disable the SPL_SPI config
Message-ID: <20231226155005.GM2652760@bill-the-cat>
References: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
 <20231226114453.577589-9-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l39dRzIHp/sgvSMu"
Content-Disposition: inline
In-Reply-To: <20231226114453.577589-9-venkatesh.abbarapu@amd.com>
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


--l39dRzIHp/sgvSMu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 05:14:53PM +0530, Venkatesh Yadav Abbarapu wrote:

> Disabling the CONFIG_SPL_SPI for the axm and taurus defconfigs,
> as facing the SPL size issue "SPL image too big".
>=20
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  board/siemens/taurus/taurus.c | 4 +++-
>  configs/axm_defconfig         | 7 ++-----
>  configs/taurus_defconfig      | 7 ++-----
>  3 files changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
> index ad44a7c0d2..ac1ce8acf4 100644
> --- a/board/siemens/taurus/taurus.c
> +++ b/board/siemens/taurus/taurus.c
> @@ -135,11 +135,12 @@ void spl_board_init(void)
> =20
>  	/* check for recovery mode */
>  	if (at91_is_recovery() =3D=3D 1) {
> -		struct spi_flash *flash;
> =20
>  		puts("Recovery button pressed\n");
>  		nand_init();
>  		spl_nand_erase_one(0, 0);
> +#if defined(CONFIG_SPL_SPI)
> +		struct spi_flash *flash;
>  		flash =3D spi_flash_probe(CONFIG_SF_DEFAULT_BUS,
>  					0,
>  					CONFIG_SF_DEFAULT_SPEED,
> @@ -151,6 +152,7 @@ void spl_board_init(void)
>  			spi_flash_erase(flash, 0,
>  					CFG_SYS_NAND_U_BOOT_SIZE);
>  		}
> +#endif
>  	}
>  }
> =20
> diff --git a/configs/axm_defconfig b/configs/axm_defconfig
> index e1a01b24b8..4d439832d7 100644
> --- a/configs/axm_defconfig
> +++ b/configs/axm_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT_ONLY=3Dy
>  CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=3Dy
>  CONFIG_SPL_SYS_DCACHE_OFF=3Dy
>  CONFIG_ARCH_CPU_INIT=3Dy
> -CONFIG_SYS_THUMB_BUILD=3Dy
>  # CONFIG_SPL_USE_ARCH_MEMCPY is not set
>  # CONFIG_SPL_USE_ARCH_MEMSET is not set
>  CONFIG_ARCH_AT91=3Dy
> @@ -26,14 +25,14 @@ CONFIG_SPL=3Dy
>  CONFIG_DEBUG_UART_BASE=3D0xfffff200
>  CONFIG_DEBUG_UART_CLOCK=3D18432000
>  CONFIG_ENV_OFFSET_REDUND=3D0x180000
> -CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> -CONFIG_SPL_SPI=3Dy
>  CONFIG_SYS_LOAD_ADDR=3D0x22000000
>  CONFIG_DEBUG_UART=3Dy
>  CONFIG_NAND_BOOT=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run flash_self"
> +CONFIG_SYS_CBSIZE=3D256
> +CONFIG_SYS_PBSIZE=3D281
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x3e00
> @@ -57,8 +56,6 @@ CONFIG_SPL_NAND_BASE=3Dy
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_PROMPT=3D"U-Boot> "
> -CONFIG_SYS_CBSIZE=3D256
> -CONFIG_SYS_PBSIZE=3D281
>  # CONFIG_CMD_BDI is not set
>  CONFIG_CMD_BOOTZ=3Dy
>  # CONFIG_CMD_IMI is not set
> diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
> index 9be30c8d8a..7d71262d1a 100644
> --- a/configs/taurus_defconfig
> +++ b/configs/taurus_defconfig
> @@ -4,7 +4,6 @@ CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=3Dy
>  CONFIG_SPL_SYS_ICACHE_OFF=3Dy
>  CONFIG_SPL_SYS_DCACHE_OFF=3Dy
>  CONFIG_ARCH_CPU_INIT=3Dy
> -CONFIG_SYS_THUMB_BUILD=3Dy
>  # CONFIG_SPL_USE_ARCH_MEMCPY is not set
>  # CONFIG_SPL_USE_ARCH_MEMSET is not set
>  CONFIG_ARCH_AT91=3Dy
> @@ -28,8 +27,6 @@ CONFIG_SPL=3Dy
>  CONFIG_DEBUG_UART_BASE=3D0xfffff200
>  CONFIG_DEBUG_UART_CLOCK=3D18432000
>  CONFIG_ENV_OFFSET_REDUND=3D0x180000
> -CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> -CONFIG_SPL_SPI=3Dy
>  CONFIG_SYS_LOAD_ADDR=3D0x22000000
>  CONFIG_DEBUG_UART=3Dy
>  CONFIG_NAND_BOOT=3Dy
> @@ -38,6 +35,8 @@ CONFIG_USE_BOOTARGS=3Dy
>  CONFIG_BOOTARGS=3D"console=3DttyS0,115200 earlyprintk mtdparts=3Datmel_n=
and:256k(bootstrap)ro,512k(uboot)ro,256k(env),256k(env_redundant),256k(spar=
e),512k(dtb),6M(kernel)ro,-(rootfs) root=3D/dev/mtdblock7 rw rootfstype=3Dj=
ffs2"
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"nand read 0x22000000 0x200000 0x300000; bootm"
> +CONFIG_SYS_CBSIZE=3D256
> +CONFIG_SYS_PBSIZE=3D281
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x3e00
> @@ -61,8 +60,6 @@ CONFIG_SPL_NAND_BASE=3Dy
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_PROMPT=3D"U-Boot> "
> -CONFIG_SYS_CBSIZE=3D256
> -CONFIG_SYS_PBSIZE=3D281
>  # CONFIG_SYS_XTRACE is not set
>  # CONFIG_CMD_BDI is not set
>  CONFIG_CMD_BOOTZ=3Dy

This patch seems wrong. You're disabling thumb (and thumb in SPL) which
increases size and then removing specifically enabled functionality.
Please figure out how to add the functionality you're wanting to add,
but allow it to be disabled so that we have minimal (or if possible, no)
size growth on platforms that can't and won't use that functionality,
thanks.

--=20
Tom

--l39dRzIHp/sgvSMu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWK9ioACgkQFHw5/5Y0
tyzWdQv/TpO7mDFUBga3t5nItJWs5FFQn+Gzy1cy0rSYK3FXzMtlX5oF8z0Ze079
eYgfFHdcANxRpRtwNpoPuylr7YPd5b0rCjovj9kZKEqXEMpjx6lEKSyhYp5AWnfS
Io7cbgLvnU5y+Xcp+cN5CQCNEcvRJMmUG7CtvDkBHfC70Ru3I/8z2cXTGvE8jXPn
FqUNzjvrjabV6HzlASUwjJOEYu/ioLjF4p6BE06buAxjqAHLLcKFmuXr9YopAaAa
yOn+eX7b9vqJ4fKddCIctiIqlJWwUKXWUsBLbZfs+v0UTCHHAYfA/c/hiu7CSDS0
oql1YeE5GGS6wZ0KVXKVuNs4DYmKs6ONfYkeG5dGtzE9d+CoT6+vEhMd2xdTr9QF
pJc21naLFjhPDkxpQPFo3ySzZgjXCyX9OJNtjM/m/MOeG5IDKtACqpk0HuOVFMkU
MrnDVSdxbXF3OeTk0Eqjm948jABiZsNlr9GWxjvSPmCh0yGltogDBkry9FlG50Oa
lktQXZb6
=DQ2H
-----END PGP SIGNATURE-----

--l39dRzIHp/sgvSMu--
