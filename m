Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3CFC83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 17:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DCE82E52;
	Tue, 15 Jul 2025 19:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D5krVDUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128908309E; Tue, 15 Jul 2025 19:50:32 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA76882E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 19:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-41baecbdd36so334881b6e.3
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 10:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752601828; x=1753206628; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1iUteqE+q6dhMz1FTiaJGaqb8RMUediQnyZE7GdtD/8=;
 b=D5krVDUZGp17DeA7MiTYHkV+ErXVV1OzSo04cx6ovPuxkdAZdivQCY+BKC25BjCSsO
 4KAdiK4geAiTfVeoaACJ72IBAFxHb2EoufQ2VfTT0SFoeLeC948KENSsu7OP0zH9sx3/
 qo1jRSbDI++yRyfDynXjVo7crxgigOxu1Qsek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752601828; x=1753206628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iUteqE+q6dhMz1FTiaJGaqb8RMUediQnyZE7GdtD/8=;
 b=dNDsnbpDCbdHI0bDyLrSzTdYzQ+faPvWaUsVEvraKiMCNpiOhDBudKkQLLJTqVjbKE
 yqNUL4O12PU6RoFrLTbDFsoNsx6HKlskUqQ+KyVwSO0y7rM4w+AVaoQTa7cvquOf7s5c
 7XQ6av1opApzsqnLaDlvP2y3tYCPK+kuaW8o171eohJ0EwsujFN82eHpbSH+TP+1nW3Y
 QmiJEdsXoSvcuqFavZvoSPD0mCR9zJ6wo7j1Vtukj64wHv4hGHmmYPFnccJT+1AwwLOY
 YxGcVkzGRJBWvEYCr0QiCXMG+/WAPPmegVc0NH/rBsnPEJL9QZfUD9rIZNXAakWpIFej
 TgzA==
X-Gm-Message-State: AOJu0YwBgjRFdWxZowWlQpiRKPvB813lveUQGVYCD8IgM0u0PYV16Lt4
 8hg0rfqUim4WcLniJtMcJuniZCkdpe6cT++PFLeXJl0U2CQuzPmQpYiTtQxqvaAl+uI=
X-Gm-Gg: ASbGncuq9FnRpgJKRLz2+nraWk3TwYHAowAOj17ZkRiuMye0MepVp7u4KrGzgJwO2rL
 UIihrPbhxV/TrvyaYM5bQhLVLeQQyn3hz8ePsTYF/2lKGebX1Lrkokn1K0hYC+e7VBH5TbKcOkQ
 1mb2rhfVvmQI8m7wEW+gzi3yIDuZHNVgGHTHssnMfWNfU3X/SbQsx99KfcRingRRmJ/uZFT4fvg
 KbUYnsTmZTeVH/Jtp/fm0nrsL80BfDJ5xzILSsQLIVRktFkQ6sqWZqNveqXpzxqcQnBb2erE1iJ
 7c7yX/bwjfE326Fa2/Whzp8Ml/VB7D2M7WTwP4AHcZjk0zJTr8eBVCkUA0VVxwDVA2x6LfH8ZLS
 60VhEL3DUgPxQ1xHuacZDOS+OFokTldAxT7xYxFz44XoKOkEbER3nT3ww
X-Google-Smtp-Source: AGHT+IFVjgpSmSvnfhlsUnZpQEeT6wt3tpc6oPeUefUs1E7sbkNEfNjEgVJU9sUQG6XSQScxnbA7xQ==
X-Received: by 2002:a05:6808:1a02:b0:406:677b:dfb0 with SMTP id
 5614622812f47-41baaecf786mr2313227b6e.29.1752601828534; 
 Tue, 15 Jul 2025 10:50:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141cb795c4sm2191883b6e.47.2025.07.15.10.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 10:50:27 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:50:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: u-boot@lists.denx.de, mkorpershoek@kernel.org,
 jerome.forissier@linaro.org, patrice.chotard@foss.st.com,
 ilias.apalodimas@linaro.org, andre.przywara@arm.com,
 casey.connolly@linaro.org, mwalle@kernel.org
Subject: Re: [PATCH] drivers: fastboot: Add support for SPI flash memory
Message-ID: <20250715175025.GG193579@bill-the-cat>
References: <20250715172311.265716-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XS9/TuoPq28eLEAT"
Content-Disposition: inline
In-Reply-To: <20250715172311.265716-1-ariel.dalessandro@collabora.com>
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


--XS9/TuoPq28eLEAT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 02:23:11PM -0300, Ariel D'Alessandro wrote:

> Fastboot currently supports MMC and NAND flash devices. Similarly,
> extend the support to SPI flash memories.
>=20
> Note that in this initial implementation, partitions on the device are
> not supported yet, but raw partitions can be set in u-boot environment.
>=20
> To define a raw partition descriptor, add an environment variable
> similar to the MMC case:
>=20
> ```
> fastboot_raw_partition_<raw partition name>=3D<offset> <size>
> ```
>=20
> for example:
>=20
> ```
> fastboot_raw_partition_boot=3D0x0 0x1000000
> ```
>=20
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  drivers/fastboot/Kconfig        |   7 +-
>  drivers/fastboot/Makefile       |   1 +
>  drivers/fastboot/fb_command.c   |   8 +
>  drivers/fastboot/fb_getvar.c    |   6 +
>  drivers/fastboot/fb_spi_flash.c | 266 ++++++++++++++++++++++++++++++++
>  include/fb_spi_flash.h          |  40 +++++
>  6 files changed, 327 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/fastboot/fb_spi_flash.c
>  create mode 100644 include/fb_spi_flash.h
>=20
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 70207573de2..0cf955ef53d 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -91,7 +91,8 @@ config FASTBOOT_USB_DEV
>  config FASTBOOT_FLASH
>  	bool "Enable FASTBOOT FLASH command"
>  	default y if ARCH_SUNXI || ARCH_ROCKCHIP
> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || \
> +			(SPI_FLASH || DM_SPI_FLASH)

Why do we need to support the non-DM_SPI_FLASH case? It's legacy and we
shouldn't add new features for it.

--=20
Tom

--XS9/TuoPq28eLEAT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh2lN0ACgkQFHw5/5Y0
tyw4tAwApB1duhXiGqr1XyftYOw9MkhvDz3+08ecNDt3YfFrLWpjgYxGtl0ms3V0
V5T1K0DXWWh4R7JYE6RSPWTt4RDe/sLLkYw7uHbV0ArclAbK1ujwwF0yv1FJZ2Wr
GAmcFJe4R77CxIHAp4bgS3VISZtSUpF9JpkkTrNPC3LjaTglVL1z+6s0aIgtyP+b
F1e8MG4EbZWX3Ot/647obmqYuXLMSmRRg1ELwLsb3IsdFOa6u4Uv3t0CWd53hndN
c4SYPRyja2N0Uxidnzi/lsIOmR+lj12qvivPxejPKTpAGkKtUhy5KLYD2gd5r4YS
Qw9E4NRsoJiDGNKvwboAgMUQEAGHs2jD8IFAIFVCdcayaxxa5dKgHgd9fBTnhlJl
yZpv9wKz9Q4RvYsrGa2qbYg9L8oyq43Zzh2XSNLuqeM5XTX0zWHynhaGPJ8e/b8X
9Zhbl7z4Zha0Ot446zvXcOb3J02oEkWmyIgnIdRi00TFRFYhZWMALFKhlTCCLanM
OQUNBnex
=Zqvj
-----END PGP SIGNATURE-----

--XS9/TuoPq28eLEAT--
