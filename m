Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EAAC4706C
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 19:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC5F8786E;
	Tue,  9 Jan 2024 20:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eBTpwSYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A644B877F9; Tue,  9 Jan 2024 20:48:13 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7582C876F6
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 20:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bbbc6e51d0so2480391b6e.3
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 11:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704829690; x=1705434490; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3zUFCxcEeIKaI0lwBaaEXoDbycIHWJWRIo+A+RTUs4w=;
 b=eBTpwSYLVMwdr4XA3I4X9ydHQvt5VsL5/3ivcMyFRpNW119BoC5uMR9m8nDytwX2+q
 cUZ8rHlawAL/t5hmuKRe0waV+6NvF+7yG2eDWJxLfxUonAd8WzzPCd2nRuZCLLK0scPl
 CiLj0dP6Zd44izh4REoepc9XxpPgXW97jI834=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704829690; x=1705434490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zUFCxcEeIKaI0lwBaaEXoDbycIHWJWRIo+A+RTUs4w=;
 b=j8XEQ0vuLjPgdhSPabFC38nLphWcuOzpb6Awlw01gW2LgmiABleLclIQQ2gVeNZxI1
 mUOkjV20MDykmXaXOIpPnp3Ki6z3k4FFtyJPFBm9HLwWk1I36wMXk+WfZaRvGnfNwW5T
 1unghsKbJMCUtpgWjixIDQzcP7k8HqOtDtyxhWkF8Ff7EAj+eb+nhDNipz8GjsvJckx6
 9GwpjEu2LBMA8I3dzT5PZ1Du/1aTPE4leMJ9Cj6vOErhbn9Hexsh0B8hlzgxF+7aWWI6
 3gn31l382S1fJTscGLYrPVPXc/XlaxUZD9WKrE9Q8iFm0jQxzFbHwJN9l00XYoIEJxYJ
 ZAUg==
X-Gm-Message-State: AOJu0Yzq6raS80Xle66jLy9Eqt+oKlLosI7URCq1ST58xO0ImL/tN+9B
 cztBuTosV/uvmqtvpbFDiqfZ1WCrZtt2mg==
X-Google-Smtp-Source: AGHT+IHDv6zH4vD56zfdzKKAsH7kYjjYcrD3PZQjgFYTIy5f3op6Mb1Wk9ErY5se8b44iaPV+oKtPA==
X-Received: by 2002:a05:6808:f07:b0:3bd:452c:f2bf with SMTP id
 m7-20020a0568080f0700b003bd452cf2bfmr243610oiw.105.1704829690071; 
 Tue, 09 Jan 2024 11:48:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 qp28-20020a05620a389c00b0077d66e5b2e6sm1050508qkn.3.2024.01.09.11.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 11:48:09 -0800 (PST)
Date: Tue, 9 Jan 2024 14:48:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, afd@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, r-gunasekaran@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] configs: am64x_evm_a53_defconfig: Enable NAND
Message-ID: <20240109194807.GX1610741@bill-the-cat>
References: <20240109122605.51951-1-rogerq@kernel.org>
 <20240109122605.51951-5-rogerq@kernel.org>
 <20240109191627.jn2b4nsczlsynik2@carpenter>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x5Cn0tEf6orMUP/o"
Content-Disposition: inline
In-Reply-To: <20240109191627.jn2b4nsczlsynik2@carpenter>
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


--x5Cn0tEf6orMUP/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 01:16:27PM -0600, Nishanth Menon wrote:
> On 14:26-20240109, Roger Quadros wrote:
> > Enables configuration required for NAND in SPL and u-boot.
> >=20
> > Enable MTD Driver model and MTD + UBI command line utilities.
> >=20
> > Add mtdids/mtdparts for NAND as it is required for u-boot's
> > MTD subsystem commands to recognize NAND partitions.
> >=20
> > Add u-boot partition location.
> >=20
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > ---
> >  configs/am64x_evm_a53_defconfig | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >=20
> > diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_de=
fconfig
> > index 05e35a8db6..e22153a958 100644
> > --- a/configs/am64x_evm_a53_defconfig
> > +++ b/configs/am64x_evm_a53_defconfig
> > @@ -66,10 +66,15 @@ CONFIG_CMD_DFU=3Dy
> >  CONFIG_CMD_GPT=3Dy
> >  CONFIG_CMD_I2C=3Dy
> >  CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_MTD=3Dy
> >  CONFIG_CMD_USB=3Dy
> >  CONFIG_CMD_TIME=3Dy
> >  CONFIG_CMD_PMIC=3Dy
> >  CONFIG_CMD_REGULATOR=3Dy
> > +CONFIG_CMD_MTDPARTS=3Dy
> > +CONFIG_MTDIDS_DEFAULT=3D"nand0=3Domap2-nand.0"
> > +CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Domap2-nand.0:2m(NAND.tiboot3),2m=
(NAND.tispl),2m(NAND.tiboot3.backup),4m(NAND.u-boot),256k(NAND.u-boot-env),=
256k(NAND.u-boot-env.backup),-(NAND.file-system)"
> > +CONFIG_CMD_UBI=3Dy
> >  CONFIG_OF_CONTROL=3Dy
> >  CONFIG_SPL_OF_CONTROL=3Dy
> >  CONFIG_OF_LIST=3D"k3-am642-evm k3-am642-sk"
> > @@ -107,6 +112,9 @@ CONFIG_MMC_SDHCI=3Dy
> >  CONFIG_MMC_SDHCI_ADMA=3Dy
> >  CONFIG_SPL_MMC_SDHCI_ADMA=3Dy
> >  CONFIG_MMC_SDHCI_AM654=3Dy
> > +CONFIG_MTD=3Dy
> > +CONFIG_SPL_MTD=3Dy
> > +CONFIG_DM_MTD=3Dy
> >  CONFIG_DM_SPI_FLASH=3Dy
> >  CONFIG_SPI_FLASH_SPANSION=3Dy
> >  CONFIG_SPI_FLASH_STMICRO=3Dy
> > @@ -161,3 +169,27 @@ CONFIG_USB_GADGET_DOWNLOAD=3Dy
> >  CONFIG_USB_FUNCTION_MASS_STORAGE=3Dy
> >  CONFIG_SPL_DFU=3Dy
> >  CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
> > +CONFIG_MEMORY=3Dy
> > +CONFIG_SPL_MEMORY=3Dy
> > +CONFIG_TI_GPMC=3Dy
> > +CONFIG_MTD_RAW_NAND=3Dy
> > +CONFIG_NAND_OMAP_GPMC=3Dy
> > +CONFIG_CMD_NAND=3Dy
> > +CONFIG_NAND_OMAP_ELM=3Dy
> > +CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW=3Dy
> > +CONFIG_SYS_NAND_BLOCK_SIZE=3D0x40000
> > +CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> > +CONFIG_SYS_NAND_PAGE_SIZE=3D0x1000
> > +CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> > +CONFIG_SYS_NAND_OOBSIZE=3D0x100
> > +CONFIG_SPL_NAND_SUPPORT=3Dy
> > +CONFIG_SPL_NAND_DRIVERS=3Dy
> > +CONFIG_SPL_NAND_BASE=3Dy
> > +CONFIG_SPL_NAND_IDENT=3Dy
> > +CONFIG_SPL_NAND_ECC=3Dy
> > +CONFIG_SYS_NAND_MAX_CHIPS=3D1
> > +CONFIG_SYS_MAX_NAND_DEVICE=3D1
> > +# CONFIG_SPL_NAND_AM33XX_BCH is not set
> > +CONFIG_SPL_MTD_SUPPORT=3Dy
> > +CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> > +CONFIG_SYS_NAND_U_BOOT_OFFS=3D0x600000
> > --=20
> > 2.34.1
> >=20
>=20
> Why not a config fragment?

To me, this makes sense to keep in the main config. It can be turned off
as needed, and at run time if it's not present, it's safe.

--=20
Tom

--x5Cn0tEf6orMUP/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWdovEACgkQFHw5/5Y0
tywtSAv/bRHVkKaoLynOaMonCvkEqQiJ0aChyb443KpdNk9pLzLBeHBLVdCKarD8
Yz56I1flGoqKYp4VNztvIwLZKT2czIrdv2E99Jn4a0WGPug+zm2wCU3UzB4/gmwB
6iVZgqUD/p0yaPw+zfAZx24UmH9OVZKzReJw9qK+wwnUZQe97RbE59yLKH1u7a5A
+Nu97yC2otHRQn4FHna/jzdI51pPLn5rsqzlXQ/TQdzdKP5PAPYkfgkD6PBnG3x5
Lx+0C69C5y4C7l8OsPrthBBGbDIsFUYmh3VhZopHfQPXtDAhNbZhPO5v/L1rAQqS
jwyUviaWUjMdrOiXsI0Ui3e48NHqV08gzOLD3wIHhVZG4k2sNmM5O0sJn9NWwvsL
9VkJCopPycPalzhqLqRO0dLiyLAj0c6XBy+EsDFoghaFbk4J93LWFIzCkBUyzJUX
uxY51ae3wH1o85NVtL/yvamINNy9LhIQ3fHYkIFnfig8/jxmrzQ0zMxaE3M0Jeo8
+9M6omnE
=dAac
-----END PGP SIGNATURE-----

--x5Cn0tEf6orMUP/o--
