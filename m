Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8A9CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 13:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C2B83A5D;
	Wed,  5 Nov 2025 14:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XYJaPmOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D50C883A64; Wed,  5 Nov 2025 14:54:13 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E7583A32
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 14:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-65677b3aa4bso3105510eaf.0
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 05:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762350850; x=1762955650; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nQB6MGx5iaPDsX3TUPD1cifywTKrgbSWH9Cb7RFmriU=;
 b=XYJaPmOPUGPQtlRbIuMHwMHEgWHDVyEgQbI07U92Fwk5RVs9SlyjDaLsMZxogQl//G
 EE70JtMSqi9JbsYtUM/wv6QtGIAJAfFH8oAsKQ2JIBTd67gNbGoCxk7I0qOW7PN3N0iR
 gA2AAWCs00R5RqzTjWv0XtJoTc6EwcMU4OAm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762350850; x=1762955650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQB6MGx5iaPDsX3TUPD1cifywTKrgbSWH9Cb7RFmriU=;
 b=tMIX2BEa83IUTO/rtHkOttjgcq8+mJFSfUoeNs/VT4CK+aRUhcpNeVqQMvcWSJ6ovQ
 K1icmp3gz75wsz8/NpGvG7EOS1FXY28z8o81HHAey0lmdqlRbH92uJEv9uJh92vC3vFL
 DPbi3VUdVSmI41yi6fYo1q2Of7GMEp9lI04ddxmSA2HyinpC0VtyA5RyLlspcB2pHKv6
 3aDgHed2LQYN/qkMIMiHywA87dHQ2Oxm/m0YaYrjq5byCI7C1bmKOZpNHu1cz5OPmxQf
 qKyFupQpj6cyFqLjcMsjdYGeIF5bf/rIqnx83xj4hDlYlbxIJFz/uPbJ2Ahvj/+HgyHa
 wEjA==
X-Gm-Message-State: AOJu0Yyd6B8qiVgrjqf871abhjXG0RkdpfiV22+zYxgyCV3G5tI/zyFB
 iMw055FQwswY9eiblRhVXTJ3PV1SwMObCwekqDsjnhvMtKXKqSGaX2NupqcXBNYyxGA=
X-Gm-Gg: ASbGncuZ4AGsjcJp3FKvcN9T2qlnMA/zo0y1PEFL8USvowhwVk/LK6+GlEq/B49khMS
 MzRVEJz7YRpTnZCDIdrx2DDPz+4kqOOTL312SAMbki/JeWLpZU1Im/4LItEunHEoyNEaXtC1eim
 YHSlaoihwlK9K294G5TC48c4+xmT+GQnuTxUDsjHQQ1aTR5QiHBnGFK8ur2eQEx54BNxsHbpIS9
 aHNVnMWURTfoJjigkrYZVuwcWZDqpB/MowZkgdcFRg9ePAK618Rk8IKAkTPlrNggVyL7Z+X97/c
 OVOkcPzLQLLcCTVeRVWKEhb8zCpINwswFNlUw7brYV0tusFRw4Pk2oPRLRSnrg8MxoH/G8l5aAn
 PQzRolHOlHYy4G6qqLrFRBRi8u0mHdL4wrBmWDN/YPuGHqORhxGbx/EfwL74hgaY2Ynzj/jvlYq
 /IqJwsu0MwXQI2AGFr4NlZUw6dMMxrH2OjhKK4Xgk=
X-Google-Smtp-Source: AGHT+IETI8URmzHLexqkU0xWE7HxA5lUNb/wfuko+vdbou28KUYOGWp60aPOjt9okfLuuChCdV6HTw==
X-Received: by 2002:a05:6870:8317:b0:3d8:9e0d:17da with SMTP id
 586e51a60fabf-3e19987f03dmr1275279fac.7.1762350850253; 
 Wed, 05 Nov 2025 05:54:10 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff736d114sm2216166fac.17.2025.11.05.05.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 05:54:09 -0800 (PST)
Date: Wed, 5 Nov 2025 07:54:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Andrew Davis <afd@ti.com>,
 Judith Mendez <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Vignesh R <vigneshr@ti.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH] configs: am65x_usbdfu: add
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT
Message-ID: <20251105135407.GL6688@bill-the-cat>
References: <20251105-am65_dfu_fix-v1-1-acc29111dccf@ti.com>
 <DE0J9DJSVAS3.339E9U0OW3BPI@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+Ha/+sjnyZOuhtKf"
Content-Disposition: inline
In-Reply-To: <DE0J9DJSVAS3.339E9U0OW3BPI@ti.com>
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


--+Ha/+sjnyZOuhtKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 11:35:03AM +0530, Anshul Dalal wrote:

> On Wed Nov 5, 2025 at 11:32 AM IST, Anshul Dalal wrote:
> > Since the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
> > with an extra Kconfig"), SPL_USE_TINY_PRINTF_POINTER_SUPPORT has been
> > made mandatory in order to use %p which would earlier have defaulted to
> > a 'long' print.
> >
> > Without this config symbol, k3_sysfw_dfu_download fails to set the
> > correct value for the DFU string with:
> >
> >  sprintf(dfu_str, "sysfw.itb ram 0x%p 0x%x", addr,
> >    CONFIG_K3_SYSFW_IMAGE_SIZE_MAX);
> >
> > The value we get "sysfw.itb ram 0x? 0x41c29d40" causes a boot failure.
> >
> > Therefore this patch sets SPL_USE_TINY_PRINTF_POINTER_SUPPORT for the
> > usbdfu defconfig and also cleans up the usage of "CONFIG_*=3Dn".
> >
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > ---
> > Not sure if a 'Fixes' tag is appropriate here since the commit
> > 1e24e84db41a ("tiny-printf: Handle formatting of %p with an extra
> > Kconfig") did cause a regression though I think the problem existed with
> > the usage of "%p" with TINY_PRINTF set to begin with.
> > ---
> >  configs/am65x_evm_r5_usbdfu_defconfig | 63 ++++++++++++++++++---------=
--------
> >  1 file changed, 32 insertions(+), 31 deletions(-)
> >
> > diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_=
r5_usbdfu_defconfig
> > index f9161f1fe111ff97f7aa79f10b21c3b0ab1dad32..b3def7946b3eb799582f04c=
c522725cb3f9a6eb1 100644
> > --- a/configs/am65x_evm_r5_usbdfu_defconfig
> > +++ b/configs/am65x_evm_r5_usbdfu_defconfig
> > @@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x57000
> >  CONFIG_SPL_GPIO=3Dy
> >  CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> >  CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> > +CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT=3Dy
> >  CONFIG_SOC_K3_AM654=3Dy
> >  CONFIG_K3_EARLY_CONS=3Dy
> >  CONFIG_TARGET_AM654_R5_EVM=3Dy
> > @@ -41,34 +42,34 @@ CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
> >  CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6162
> >  CONFIG_USB_GADGET_DOWNLOAD=3Dy
> >  CONFIG_SPL_DFU=3Dy
> > -CONFIG_MMC=3Dn
> > -CONFIG_SPL_DM_SPI=3Dn
> > -CONFIG_SPL_MMC=3Dn
> > -CONFIG_SPL_FS_FAT=3Dn
> > -CONFIG_SPL_SPI_FLASH_SUPPORT=3Dn
> > -CONFIG_SPL_SPI=3Dn
> > -CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dn
> > -CONFIG_SPL_DM_SPI_FLASH=3Dn
> > -CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=3Dn
> > -CONFIG_SPL_SPI_LOAD=3Dn
> > -CONFIG_CMD_MMC=3Dn
> > -CONFIG_ENV_OVERWRITE=3Dn
> > -CONFIG_ENV_IS_IN_FAT=3Dn
> > -CONFIG_DMA_CHANNELS=3Dn
> > -CONFIG_TI_K3_NAVSS_UDMA=3Dn
> > -CONFIG_SUPPORT_EMMC_BOOT=3Dn
> > -CONFIG_MMC_HS200_SUPPORT=3Dn
> > -CONFIG_SPL_MMC_HS200_SUPPORT=3Dn
> > -CONFIG_MMC_SDHCI=3Dn
> > -CONFIG_SPL_MMC_SDHCI_ADMA=3Dn
> > -CONFIG_MMC_SDHCI_AM654=3Dn
> > -CONFIG_MTD=3Dn
> > -CONFIG_DM_SPI_FLASH=3Dn
> > -CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dn
> > -CONFIG_SPI_FLASH_STMICRO=3Dn
> > -CONFIG_SOC_DEVICE=3Dn
> > -CONFIG_SOC_DEVICE_TI_K3=3Dn
> > -CONFIG_SOC_TI=3Dn
> > -CONFIG_SPI=3Dn
> > -CONFIG_DM_SPI=3Dn
> > -CONFIG_CADENCE_QSPI=3Dn
> > +# CONFIG_MMC is not set
> > +# CONFIG_SPL_DM_SPI is not set
> > +# CONFIG_SPL_MMC is not set
> > +# CONFIG_SPL_FS_FAT is not set
> > +# CONFIG_SPL_SPI_FLASH_SUPPORT is not set
> > +# CONFIG_SPL_SPI is not set
> > +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
> > +# CONFIG_SPL_DM_SPI_FLASH is not set
> > +# CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT is not set
> > +# CONFIG_SPL_SPI_LOAD is not set
> > +# CONFIG_CMD_MMC is not set
> > +# CONFIG_ENV_OVERWRITE is not set
> > +# CONFIG_ENV_IS_IN_FAT is not set
> > +# CONFIG_DMA_CHANNELS is not set
> > +# CONFIG_TI_K3_NAVSS_UDMA is not set
> > +# CONFIG_SUPPORT_EMMC_BOOT is not set
> > +# CONFIG_MMC_HS200_SUPPORT is not set
> > +# CONFIG_SPL_MMC_HS200_SUPPORT is not set
> > +# CONFIG_MMC_SDHCI is not set
> > +# CONFIG_SPL_MMC_SDHCI_ADMA is not set
> > +# CONFIG_MMC_SDHCI_AM654 is not set
> > +# CONFIG_MTD is not set
> > +# CONFIG_DM_SPI_FLASH is not set
> > +# CONFIG_SPI_FLASH_SFDP_SUPPORT is not set
> > +# CONFIG_SPI_FLASH_STMICRO is not set
> > +# CONFIG_SOC_DEVICE is not set
> > +# CONFIG_SOC_DEVICE_TI_K3 is not set
> > +# CONFIG_SOC_TI is not set
> > +# CONFIG_SPI is not set
> > +# CONFIG_DM_SPI is not set
> > +# CONFIG_CADENCE_QSPI is not set

That second half is unrelated and should be dropped.

--=20
Tom

--+Ha/+sjnyZOuhtKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQtW/AAKCRAr4qD1Cr/k
CsUhAQD/dXK813g1ea1JXtRpMs1ODcbkIOJSFOU0ovc/3Et1oQEAsup1kHH3u+Rv
VRNTt+q3mMfkGF3l9UDph+JgEk9pqwM=
=vuuC
-----END PGP SIGNATURE-----

--+Ha/+sjnyZOuhtKf--
