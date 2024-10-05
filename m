Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3BFCF887E
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 15:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9B888B89;
	Sat,  5 Oct 2024 17:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ogltsJF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0837788CC9; Sat,  5 Oct 2024 17:20:56 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B158D8897F
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 17:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7ae491dacaeso343399085a.0
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728141652; x=1728746452; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4bjazDHlapaTvPKXRN6cowgCuP+odT2I8YYytS7yvhs=;
 b=ogltsJF9vYU3AOz9e9Fy/aCIzhiZp70qXquLlFeGNIK5L7W7DEgNfwWiDJk3T9Sx9x
 Ynn0k0O1FWjR8yRbyeSUL4UvBwg1wX5nsyzX5SljmPhn2AqfKd/8oaXxyvZ3vAE8jF02
 Bop4LL8ZYL28uDf6lIfJSwjo6arFRZGJozkyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141652; x=1728746452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bjazDHlapaTvPKXRN6cowgCuP+odT2I8YYytS7yvhs=;
 b=DKVDwZWP5IV9eoGgp0BDvqGzdVJyiSyGQCT0EV63tR9+GdQ+ix+EJyCmjofZUIcXCe
 YJAdBS0lWd5eS8FYW8nSaxlxcUMZ1chNOpIz4b71kqLTPZEi223dsZ7pJM5SGL41fRIR
 bop2lwfaEeVFOBqdhnir5Gu3MEWcCgnzGq8mPQQxxqeiGF4TEN2aijoOGo1r+9+kytsN
 hT2bJoBtV1ikeS8M3n0z5a6vuj4KloFXMk1q0PfZljgRUe0KA6jXeazcunTnoEp0HUsS
 VaoAN/fWXoRvjj/gxf1H2xYFLTleoUh3BTh7wpD1X+RZ5i+w/LozVITJGaFwgetf1KZ+
 vySg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR/IRTM80ZT+mBLlcbZA+eKGfFs/aVvGpWrijWbJHI4P288wazN5lTiREAXqEEo2AkEluHZVk=@lists.denx.de
X-Gm-Message-State: AOJu0YyE0a04Z5I5/Ug3ioRozIpL1qw0ii6vB37bMOr63UIQr0jl1Z1S
 RxvczKw4zup2PX2uhPT6NnTa5BADSt8RGSk5+KQjeiUWJ80RJHmTgtFC91IwmsI=
X-Google-Smtp-Source: AGHT+IGJttzRPFX+21u1RbWLKEtKj6HlVtQHo83oiivCI9nUWH+bqZ5162XQxkc5IjzlsHKNs97+ag==
X-Received: by 2002:a05:620a:29d2:b0:7a9:bbcb:d39d with SMTP id
 af79cd13be357-7ae6f42cdb8mr1152610785a.4.1728141652481; 
 Sat, 05 Oct 2024 08:20:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da760f2f0sm9170431cf.78.2024.10.05.08.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:20:51 -0700 (PDT)
Date: Sat, 5 Oct 2024 09:20:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: dinesh.maniyam@intel.com, u-boot@lists.denx.de, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: Re: [PATCH 14/19] configs: nand2_defconfig: Enable configs for nand
 boot
Message-ID: <20241005152046.GL4737@bill-the-cat>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
 <20240919035512.13854-15-dinesh.maniyam@intel.com>
 <CAOf5uwmWNC+eMYHu0M1aMjFS9hQMAH=4DE4Ht3jkwmHm9aB2rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="85HEbAwjuJJzq7Ky"
Content-Disposition: inline
In-Reply-To: <CAOf5uwmWNC+eMYHu0M1aMjFS9hQMAH=4DE4Ht3jkwmHm9aB2rA@mail.gmail.com>
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


--85HEbAwjuJJzq7Ky
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2024 at 05:16:33PM +0200, Michael Nazzareno Trimarchi wrote:
> Hi
>=20
> On Thu, Sep 19, 2024 at 5:56=E2=80=AFAM <dinesh.maniyam@intel.com> wrote:
> >
> > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> >
> > This patch is to enable configs for nand boot.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > ---
> >  configs/socfpga_agilex5_nand2_defconfig | 169 ++++++++++++++++++++++++
> >  1 file changed, 169 insertions(+)
> >  create mode 100644 configs/socfpga_agilex5_nand2_defconfig
> >
> > diff --git a/configs/socfpga_agilex5_nand2_defconfig b/configs/socfpga_=
agilex5_nand2_defconfig
> > new file mode 100644
> > index 0000000000..9e5a75194a
> > --- /dev/null
> > +++ b/configs/socfpga_agilex5_nand2_defconfig
> > @@ -0,0 +1,169 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_SPL_LDSCRIPT=3D"arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
> > +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x04000000
> > +CONFIG_ARCH_SOCFPGA=3Dy
> > +CONFIG_TEXT_BASE=3D0x80200000
> > +CONFIG_SYS_MALLOC_F_LEN=3D0x4000
> > +CONFIG_NR_DRAM_BANKS=3D2
> > +CONFIG_ENV_SIZE=3D0x2000
> > +CONFIG_ENV_OFFSET=3D0x04100000
> > +CONFIG_DM_GPIO=3Dy
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
> > +CONFIG_SPL_MMC=3Dy
> > +CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=3Dy
> > +CONFIG_TARGET_SOCFPGA_AGILEX5_NAND2=3Dy
> > +CONFIG_QPDS_HPS_HANDOFF=3Dy
> > +CONFIG_IDENT_STRING=3D"socfpga_agilex5"
> > +CONFIG_SPL_FS_FAT=3Dy
> > +CONFIG_DISTRO_DEFAULTS=3Dy
> > +CONFIG_FIT=3Dy
> > +CONFIG_SPL_FIT_SIGNATURE=3Dy
> > +CONFIG_SPL_LOAD_FIT=3Dy
> > +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x82000000
> > +# CONFIG_USE_SPL_FIT_GENERATOR is not set
> > +CONFIG_QSPI_BOOT=3Dy
> > +CONFIG_BOOTDELAY=3D5
> > +CONFIG_USE_BOOTARGS=3Dy
> > +CONFIG_BOOTARGS=3D"earlycon panic=3D-1 root=3D${nandroot} rw rootwait =
rootfstype=3Dubifs ubi.mtd=3D1"
> > +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +CONFIG_SPL_CRC32=3Dy
> > +CONFIG_SPL_CACHE=3Dy
> > +CONFIG_SPL_ATF=3Dy
> > +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> > +CONFIG_SYS_PROMPT=3D"SOCFPGA_AGILEX5 # "
> > +CONFIG_CMD_NVEDIT_SELECT=3Dy
> > +CONFIG_CMD_MEMTEST=3Dy
> > +CONFIG_CMD_GPIO=3Dy
> > +CONFIG_CMD_I2C=3Dn
> > +CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_SF=3Dy
> > +CONFIG_PHY=3Dy
> > +CONFIG_SPL_PHY=3Dy
> > +CONFIG_NOP_PHY=3Dy
> > +CONFIG_SPL_NOP_PHY=3Dy
> > +CONFIG_PHY_CADENCE_COMBOPHY=3Dn
> > +CONFIG_SPL_PHY_CADENCE_COMBOPHY=3Dn
> > +CONFIG_MMC=3Dy
> > +CONFIG_MMC_WRITE=3Dy
> > +# CONFIG_MMC_BROKEN_CD is not set
> > +CONFIG_DM_MMC=3Dy
> > +CONFIG_SPL_DM_MMC=3Dy
> > +CONFIG_MMC_SDHCI_ADMA_HELPERS=3Dy
> > +# CONFIG_ARM_PL180_MMCI is not set
> > +CONFIG_MMC_QUIRKS=3Dy
> > +CONFIG_SYS_MMC_MAX_BLK_COUNT=3D65535
> > +CONFIG_MMC_HW_PARTITIONING=3Dy
> > +# CONFIG_SUPPORT_EMMC_RPMB is not set
> > +# CONFIG_SUPPORT_EMMC_BOOT is not set
> > +# CONFIG_MMC_IO_VOLTAGE is not set
> > +# CONFIG_MMC_HS400_ES_SUPPORT is not set
> > +# CONFIG_MMC_HS400_SUPPORT is not set
> > +# CONFIG_MMC_HS200_SUPPORT is not set
> > +CONFIG_MMC_VERBOSE=3Dn
> > +CONFIG_MMC_TRACE=3Dn
> > +# CONFIG_MMC_DW is not set
> > +# CONFIG_MMC_MXC is not set
> > +# CONFIG_MMC_PCI is not set
> > +# CONFIG_MMC_OMAP_HS is not set
> > +CONFIG_MMC_SDHCI=3Dy
> > +# CONFIG_MMC_SDHCI_SDMA is not set
> > +CONFIG_MMC_SDHCI_ADMA=3Dy
> > +CONFIG_SPL_MMC_SDHCI_ADMA=3Dy
> > +# CONFIG_MMC_SDHCI_BCMSTB is not set
> > +CONFIG_MMC_SDHCI_CADENCE=3Dy
> > +CONFIG_CMD_FAT=3Dy
> > +CONFIG_DOS_PARTITION=3Dy
> > +CONFIG_SPL_DOS_PARTITION=3Dy
> > +CONFIG_SPL_SYS_DISABLE_DCACHE_OPS=3Dy
> > +CONFIG_CMD_MTD=3Dy
> > +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> > +CONFIG_CMD_NAND_TRIMFFS=3Dy
> > +CONFIG_CMD_NAND_LOCK_UNLOCK=3Dy
> > +CONFIG_CMD_SPI=3Dy
> > +CONFIG_CMD_USB=3Dy
> > +CONFIG_CMD_CACHE=3Dy
> > +CONFIG_SPL_SPI_FLASH_MTD=3Dy
> > +CONFIG_SPI_FLASH_MTD=3Dy
> > +CONFIG_SPL_MTD_SUPPORT=3Dy
> > +CONFIG_MTDIDS_DEFAULT=3D"nand0=3D10b80000.nand.0"
> > +CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3D10b80000.nand.0:2m(u-boot),-(roo=
t)"
> > +CONFIG_CMD_UBI=3Dy
> > +CONFIG_CMD_UBIFS=3Dy
> > +CONFIG_MTD_UBI=3Dy
> > +CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> > +CONFIG_MTD_UBI_BEB_LIMIT=3D20
> > +# CONFIG_ISO_PARTITION is not set
> > +# CONFIG_EFI_PARTITION is not set
> > +CONFIG_OF_LIST=3D""
> > +CONFIG_ENV_IS_IN_UBI=3Dy
> > +CONFIG_ENV_UBI_PART=3D"root"
> > +CONFIG_ENV_UBI_VOLUME=3D"env"
> > +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> > +CONFIG_NET_RANDOM_ETHADDR=3Dy
> > +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> > +CONFIG_SPL_ALTERA_SDRAM=3Dy
> > +CONFIG_FPGA_INTEL_PR=3Dy
> > +CONFIG_DWAPB_GPIO=3Dy
> > +CONFIG_DM_I2C=3Dn
> > +CONFIG_SYS_I2C_DW=3Dn
> > +CONFIG_MISC=3Dy
> > +CONFIG_MISC_INIT_R=3Dy
> > +CONFIG_MTD=3Dy
> > +CONFIG_DM_MTD=3Dy
> > +CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> > +CONFIG_SYS_NAND_U_BOOT_OFFS=3D0x0
> > +CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=3D0x100000
> > +CONFIG_SF_DEFAULT_MODE=3D0x2003
> > +CONFIG_SPI_FLASH_SPANSION=3Dy
> > +CONFIG_SPI_FLASH_STMICRO=3Dy
> > +CONFIG_UBI_SILENCE_MSG=3Dy
> > +CONFIG_PHY_MARVELL=3Dy
> > +CONFIG_DM_ETH=3Dy
> > +CONFIG_DWC_ETH_XGMAC=3Dy
> > +CONFIG_RGMII=3Dy
> > +CONFIG_DM_RESET=3Dy
> > +CONFIG_SYS_NS16550_MEM32=3Dy
> > +CONFIG_SPI=3Dy
> > +CONFIG_CADENCE_QSPI=3Dy
> > +CONFIG_DESIGNWARE_SPI=3Dy
> > +CONFIG_USB=3Dy
> > +CONFIG_USB_DWC2=3Dn
> > +CONFIG_USB_DWC3=3Dy
> > +CONFIG_USB_XHCI_HCD=3Dy
> > +CONFIG_USB_XHCI_DWC3=3Dy
> > +CONFIG_UBIFS_SILENCE_MSG=3Dy
> > +# CONFIG_SPL_USE_TINY_PRINTF is not set
> > +CONFIG_PANIC_HANG=3Dy
> > +CONFIG_SPL_SPI_LOAD=3Dy
> > +CONFIG_SYS_LOAD_ADDR=3D0x82000000
> > +CONFIG_WDT=3Dn
> > +CONFIG_CMD_WDT=3Dn
> > +CONFIG_DESIGNWARE_WATCHDOG=3Dn
> > +CONFIG_SPL_WDT=3Dn
> > +CONFIG_WATCHDOG_AUTOSTART=3Dn
> > +CONFIG_TIMER=3Dn
> > +CONFIG_DESIGNWARE_APB_TIMER=3Dn
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80300000
> > +CONFIG_SPL_MAX_SIZE=3D0x40000
> > +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> > +CONFIG_SPL_BSS_START_ADDR=3D0xbff00000
> > +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > +CONFIG_SPL_STACK=3D0x73000
> > +CONFIG_SYS_SPL_MALLOC=3Dy
> > +CONFIG_HAS_CUSTOM_SPL_MALLOC_START=3Dy
> > +CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=3D0xbfa00000
> > +CONFIG_SYS_SPL_MALLOC_SIZE=3D0x500000
> > +CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> > +# CONFIG_EFI_LOADER is not set
> > +CONFIG_I3C=3Dn
> > +CONFIG_DW_I3C_MASTER=3Dn
> > +CONFIG_CMD_I3C=3Dn
> > +CONFIG_MTD_RAW_NAND=3Dy
> > +CONFIG_NAND_CADENCE=3Dy
> > +CONFIG_SPL_NAND_SUPPORT=3Dy
> > +CONFIG_SPL_NAND_FRAMEWORK=3Dy
> > +CONFIG_SPL_NAND_CADENCE=3Dy
> > +CONFIG_SYS_MAXARGS=3D32
> > +CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> > --
> > 2.26.2
> >
>=20
> Please add Manteiner support for this board

Also you should strongly consider using the #include mechanism (see
configs/am62x_lpsk_a53_defconfig and configs/am62x_evm_a53_defconfig for
example and note the CONFIG_ARM and similar lines are required for
buildman to work still and so CI) to make long term support for this
variant of the board easier.

--=20
Tom

--85HEbAwjuJJzq7Ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcBWUcACgkQFHw5/5Y0
tyyPugwAr6iUae0wbSpalOhcIxL9BQr5j7RJuMMG2BJo3jrrBqNVrLGTTE8unMgo
mESK/FuQ+q7Da+RRfZfH+6fnXOfbTHh5qxnf/Fdztyj7EUxZmzvkhLwy+csH0ld2
yqWTsh/rGHhVKgyZ047a2U7SM6FuU5qf29+lbv72JxiOu65wrgUd7NQinWOfNdQr
D9dkxdnVxvSl0r1L8U1SXcl6lIWaIi7z5+KxsvnTcWiiKT955cRhWMGMqCU6j/93
7dYuDtfs+X7s5Xy0C5j9NDys61IMLLykXoPI5aAPzigR5wjzbOFVxIeRLsrzaR1L
P2u2QCruzoRZLkF71qiCcfa5zcKvvAUBPkpwSr7FXM+RxAhqaJM9qWZ5qzAjaFSc
/YBmDqaM2oKx/LFzTGMsYyTmm8zOxEZgymYE+wnX74/StUUIgPBrDYGUDvN3gUIY
8+eFEBgBdDGG+tdDqwNqFWhyGP6dxwR97Ygo3KPi4/SjLdJtz2fbBR7s0q2NGWyn
SgHJoHZS
=IAhP
-----END PGP SIGNATURE-----

--85HEbAwjuJJzq7Ky--
