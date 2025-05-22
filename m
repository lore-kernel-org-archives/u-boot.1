Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C00C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF945830B4;
	Thu, 22 May 2025 16:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dx0kEm+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80ED7830E3; Thu, 22 May 2025 16:35:18 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A57483082
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so3964925fac.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747924515; x=1748529315; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Y/XVCRV/iPtVicStnQJFDNl+2OF2hmsMw6qeej4PiM=;
 b=Dx0kEm+8NzliENliTDS2kmNReU6K3DkaY0vO1LK1kfvIaMJDvC9AcwSBIQCCYZxfrs
 EDxos4abYDLVdLAJpEgHJESRniUjAVlo+uolp6s2oK3JilUx/8fNADgbl2t8jqOwN+zd
 kGzNG8Ca88O38W4OgnJdebZqFE7UoYDNu9O1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747924515; x=1748529315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Y/XVCRV/iPtVicStnQJFDNl+2OF2hmsMw6qeej4PiM=;
 b=BQh+vlgg4qThHg6EP3KJVZsQuCrmBoLSdOGJ35fsqM1c3eC7B0Hb+Kf2mumvlEGB7r
 gxiBR/VpiWEhxYoUAKpdvPRtq5W6ofz68WZCr1bPLWJO4650Zbs1cG8NvFijo1VwH2Va
 RgjmW6FM64kWg3F26jPFrgjr7mjWkghaZ19ZjmzXj1ittsTcDH90xt+K+3lYQm9/W2RS
 48ZhT3+Uei+3xl54Hv3+iy9vt3Wjmsfo0DVoUhKwY9LERQQZvJVRLUV5zyTW3UqvYtep
 gH5uirG9CymFOeM5P6CqiZUCKrWen1CNAE1G4guptc8PmgUmhxmq3ZcvfKNQZzM3OaPK
 amYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGjPu5nGkE1JpjH3Llqlwdh7mxnD1lDJRgos/tP6Ey5oa+HH7CK8XZbSErYHMaW2yVQOwIXFY=@lists.denx.de
X-Gm-Message-State: AOJu0YzvFqzkEUEB2OEGqZhJF55+sEpBohgYb0+82fZrbdFUkDh12B5c
 SHsGFZSRftsAxRsE2Dv5GPxs1Afjf0tsLnjKhM2HHqJ4GKtvwPmh0g8gtYYSa851RTw=
X-Gm-Gg: ASbGnctAdPOX9kSuCK0Brdq7/V/M+vXJmGcaARiMidHAMb9rHXgy1VN/c+ozY4QXeaP
 dFZ5olEQqDVV0u8euRkEV9wMjioXZSV5CxH/7FFR23qs05azudCvX3wOxKkVV/MWcnJgWViyjov
 kRKf2a90VKm0A9pdnOeBqq9NZo1mTnifrLWbs3l52pZXnZ2Dane++SzpxeWbEutNJm0EknfZUGc
 cDwpcxDh6nxe4CMA4h1Z4xsbzkhGE7l09UUwJ9SYWYrN1kzejY0r++nJeSye7J3Fbw70v/qeV13
 BkIZ++8ZVXZ94yEGcG9Ob8BJYVYz37jhjqUb93gNTr4zIUg4PI5yXH3sRT3jsdcpkxtgVwQe8HY
 wxiQEni4NqQ5f
X-Google-Smtp-Source: AGHT+IGql3TcRFUaoCxdTGn6Dph6x0wVrxQp0jR4l5tL9G/E3+pZIbzxexiHZEIZc3U//hpg3+cErg==
X-Received: by 2002:a05:6870:3313:b0:2d5:4e7:1cf0 with SMTP id
 586e51a60fabf-2e39bf24cfamr17824696fac.13.1747924515063; 
 Thu, 22 May 2025 07:35:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c075a8ecsm3046434fac.26.2025.05.22.07.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 07:35:14 -0700 (PDT)
Date: Thu, 22 May 2025 08:35:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v4 2/3] fastboot: blk: switch emmc to use the block
 helpers
Message-ID: <20250522143512.GI100073@bill-the-cat>
References: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
 <20250522-topic-fastboot-blk-v4-2-af7f7f30564d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BGjIL2tHqaJu6NCS"
Content-Disposition: inline
In-Reply-To: <20250522-topic-fastboot-blk-v4-2-af7f7f30564d@linaro.org>
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


--BGjIL2tHqaJu6NCS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 02:37:06PM +0200, Neil Armstrong wrote:
> From: Dmitrii Merkurev <dimorinny@google.com>
>=20
> Switch the mmc backend to this new shared block helpers,
> reducing block logic and only leaving MMC specific logic.
>=20
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/fastboot/Kconfig  |   4 +-
>  drivers/fastboot/Makefile |   3 +-
>  drivers/fastboot/fb_mmc.c | 210 +++-------------------------------------=
------
>  3 files changed, 16 insertions(+), 201 deletions(-)
>=20
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 70207573de2bd0d56b4b7fa6f7e17fdc5803ba15..33825ee408fbd9aff26cd390a=
140421c7c98ecc3 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -91,7 +91,7 @@ config FASTBOOT_USB_DEV
>  config FASTBOOT_FLASH
>  	bool "Enable FASTBOOT FLASH command"
>  	default y if ARCH_SUNXI || ARCH_ROCKCHIP
> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
>  	select IMAGE_SPARSE
>  	help
>  	  The fastboot protocol includes a "flash" command for writing
> @@ -113,7 +113,7 @@ choice
> =20
>  config FASTBOOT_FLASH_MMC
>  	bool "FASTBOOT on MMC"
> -	depends on MMC
> +	depends on MMC && BLK
> =20
>  config FASTBOOT_FLASH_NAND
>  	bool "FASTBOOT on NAND"

OK, this logic is odd. For a little while now at least, MMC select's
BLK. So neither of these are needed. And I bet the first hunk is what
causes the issue of some platform getting stuck at a prompt when
configuring in CI because it enabled FASTBOOT, enables BLK, but did not
enable FASTBOOT_FLASH before now.

--=20
Tom

--BGjIL2tHqaJu6NCS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgvNiAACgkQFHw5/5Y0
tywxrAv/YNymJLizUQoOw257PNQTFHklHbR0x5LyFzOcl/hvdpF+yTKO3tCp9m0v
iN4hq5Y8K+eY5CwgAkb+tyFJd8xmpXETB+3py17dgDtE1ABVuxe8Te4RN7lsioGa
RAPVeMnilM1JWfR+LbHSfEdUXREDGqewsQEgEK+fGZ6LcKF6e5hk7IW1P4T8MW7N
OvuQDbBgokjFemoXGMbM0CqD4NzA+MWAEyHscPJpbb+bBVh0aHTJmsfBJ3DlXHxe
6TCEfZIKV7SUbG/i4mPpHHJs/hR91jLaKV+FXjQVavtba3gM3kldnYok+UTq4wIg
KVPiHSXOHKI9ubtgWQBMW7tgpOFrcA1zDwV/AY1daq7eZp9lpqi5nz5GJua45ziz
TaXFz60CM2JPZCj1d8DbN4BIZW5sR9mouJRM+OxO0MJ4AJRq+Sp50ieSmHjkERqR
B8z4EQefAYQMzzT1etDqbhOlGGsCw/qpXNx6WQ1zaFx7AH7pPjtVyF5xtpipAfjK
3jlFny+o
=LcM1
-----END PGP SIGNATURE-----

--BGjIL2tHqaJu6NCS--
