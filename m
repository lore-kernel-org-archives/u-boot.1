Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A657AC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 08:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E9A88B68;
	Wed, 21 Aug 2024 10:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724229205;
	bh=3w1OLKdrPZHvtFQtFF+jAk7qCug0RbyQgJnqrd9R/e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WhK2JtmOt8qn8Yif/Web7a8+vSKuSYbLXKUZCjmFo26sj8/c0LtLCv0Lnn/GNpFhm
	 aY0JgUKYuJy7qUdv8L6JlSC7SnDCJyMZuc2d0rmiAJlzQIs9pULeGRdLhykhKOPVYY
	 B0LGxWT37yc3wirId51ur1LuMmt2b6bf6lUSW0Bo1yhpKJXCiy+1ygQLA8243zR6QQ
	 sRAXjjlUe8RK/2WCYAHpjVm5uBga9YRGuVOkgks3LvfQUx5zVLmzKxNz0BjWWOLcRT
	 H+cHD0ZioGCoOMZN+11M5HnLoJI929A8Sz7yfldCGLLpAx5GbCx16ZxyN+wnsc+M1Z
	 q2h8bPivDjW1w==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B49D388B4C;
 Wed, 21 Aug 2024 10:33:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724229205;
 bh=3w1OLKdrPZHvtFQtFF+jAk7qCug0RbyQgJnqrd9R/e8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=w5qxHTZAYmTpzTIHFN8C+ZTfSEoTKToQ/wJ0lPswFi3JFSafDj0WH+oxrVwSeNJhW
 +4tihyWAlva96EoEYjmMUnQrpmms8lL78WKnEPOO8SU8PU0zUfo/tKDFllTmYB6uVw
 3MbPXeJ2xQ2Nf9QhAyDgJBiD/ebH/XxU/nZIr+6xuXHzK8c1o2Sz6GuHv6bZoxBLqi
 1CbpkV1cdznlfP6KZTuKBaPN3hI5m/GYjmcA7QRxW0ZXLcuJc4gjh0fTiYKBWL95RJ
 uR567rjsTybr5i1+/6XclPLMpF8YzL6IfyOb6cAMFhUiIUzw+JHHJpsoz1QjhKRIU2
 uBSmgI55k4dzw==
Date: Wed, 21 Aug 2024 10:33:23 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <T.Remmet@phytec.de>
Cc: "festevam@gmail.com" <festevam@gmail.com>, "sbabic@denx.de"
 <sbabic@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "marcel.ziswiler@toradex.com"
 <marcel.ziswiler@toradex.com>, Cem Tenruh <C.Tenruh@phytec.de>, Yannic Moog
 <Y.Moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] config: imx: Add PHYTEC's phycore-imx8mm-fspi_defconfig
Message-ID: <20240821103323.240527ab@wsk>
In-Reply-To: <951f63db0af4f3a8072e49009cd7a3336d90736c.camel@phytec.de>
References: <20240815084012.477436-1-lukma@denx.de>
 <951f63db0af4f3a8072e49009cd7a3336d90736c.camel@phytec.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cTHRzKDplf9eHYAMpsyaQ+1";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/cTHRzKDplf9eHYAMpsyaQ+1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Teresa,

> Hello Lukasz,
>=20
> Am Donnerstag, dem 15.08.2024 um 10:40 +0200 schrieb Lukasz Majewski:
> > This configuration file provides support for booting phycore module
> > (on e.g. polis-rdk base development board) from QSPI memory.
> >=20
> > Moreover, the SDP SPL gadget is supported, so single flash.bin
> > binary can be used with uuu (with uuu -v -b qspi ~/u-boot/flash.bin)
> > to flash QSPI in the factory or during debricking.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > =C2=A0configs/phycore-imx8mm-fspi_defconfig | 158
> > ++++++++++++++++++++++++++
> > =C2=A01 file changed, 158 insertions(+)
> > =C2=A0create mode 100644 configs/phycore-imx8mm-fspi_defconfig
> >=20
> > diff --git a/configs/phycore-imx8mm-fspi_defconfig
> > b/configs/phycore- imx8mm-fspi_defconfig
> > new file mode 100644
> > index 0000000000..79a2668254
> > --- /dev/null
> > +++ b/configs/phycore-imx8mm-fspi_defconfig
> > @@ -0,0 +1,158 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_ARCH_IMX8M=3Dy
> > +CONFIG_TEXT_BASE=3D0x40200000
> > +CONFIG_SYS_MALLOC_LEN=3D0x2000000
> > +CONFIG_SPL_GPIO=3Dy
> > +CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> > +CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> > +CONFIG_SF_DEFAULT_SPEED=3D80000000
> > +CONFIG_ENV_SIZE=3D0x10000
> > +CONFIG_ENV_OFFSET=3D0x3C0000
> > +CONFIG_IMX_CONFIG=3D"board/freescale/imx8mm_evk/imximage-8mm-lpddr4-
> > fspi.cfg" =20
>=20
> can you create a cfg in the board folder and not use the one from the
> evk?

I wanted to avoid code duplication - as the same file (from EVK) is
used by other boards already...

>=20
> > +CONFIG_DM_GPIO=3Dy
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"freescale/imx8mm-phyboard-polis-rdk"
> > +CONFIG_SPL_TEXT_BASE=3D0x7E2000
> > +CONFIG_TARGET_PHYCORE_IMX8MM=3Dy
> > +CONFIG_DM_RESET=3Dy
> > +CONFIG_SYS_MONITOR_LEN=3D524288
> > +CONFIG_SPL_MMC=3Dy
> > +CONFIG_SPL_SERIAL=3Dy
> > +CONFIG_SPL_DRIVERS_MISC=3Dy
> > +CONFIG_SPL_STACK=3D0x920000
> > +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> > +CONFIG_SPL_BSS_START_ADDR=3D0x910000
> > +CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> > +CONFIG_SPL=3Dy
> > +CONFIG_ENV_OFFSET_REDUND=3D0x3E0000
> > +CONFIG_SYS_LOAD_ADDR=3D0x40480000
> > +CONFIG_PCI=3Dy
> > +# CONFIG_ANDROID_BOOT_IMAGE is not set
> > +CONFIG_FIT=3Dy
> > +CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
> > +CONFIG_SPL_LOAD_FIT=3Dy
> > +CONFIG_OF_SYSTEM_SETUP=3Dy
> > +CONFIG_USE_BOOTCOMMAND=3Dy
> > +CONFIG_BOOTCOMMAND=3D"mmc dev ${mmcdev}; if mmc rescan; then if run
> > loadimage; then run mmcboot; else run netboot; fi; fi;"
> > +CONFIG_DEFAULT_FDT_FILE=3D"oftree"
> > +CONFIG_SYS_CBSIZE=3D2048
> > +CONFIG_SYS_PBSIZE=3D2074
> > +CONFIG_BOARD_LATE_INIT=3Dy
> > +CONFIG_SPL_MAX_SIZE=3D0x25000 =20
>=20
> This line
>=20
> > +CONFIG_SPL_PAD_TO=3D0x0 =20
>=20
> and this one is not available in phycore-imx8mm_defconfig.
> Why have you added them here?

I think that I've followed ./configs/imx8mm_beacon_fspi_defconfig as a
starting point.

I would need to check if removing them would make any harm.

>=20
> > +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > +CONFIG_SPL_SYS_MALLOC=3Dy
> > +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
> > +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x42200000
> > +CONFIG_SPL_SYS_MALLOC_SIZE=3D0x80000
> > +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
> > +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
> > +CONFIG_SPL_I2C=3Dy
> > +CONFIG_SPL_NOR_SUPPORT=3Dy
> > +CONFIG_SPL_POWER=3Dy
> > +CONFIG_SPL_SPI_FLASH_MTD=3Dy
> > +CONFIG_SPL_WATCHDOG=3Dy
> > +CONFIG_HUSH_PARSER=3Dy
> > +CONFIG_SYS_PROMPT=3D"u-boot=3D> "
> > +# CONFIG_CMD_EXPORTENV is not set
> > +# CONFIG_CMD_IMPORTENV is not set =20
>=20
> Here is
>=20
> CONFIG_CMD_ERASEENV=3Dy
>=20
> missing. Which was added with 60e01c6d9f892bfa088a0453cd19d6a418b00add
> for phycore-imx8mm_defconfig. Why did you not add it?
>=20

I might used either the older ./configs/phycore-imx8mm_defconfig or the
above mentioned "beacon".

>=20
> > +# CONFIG_CMD_CRC32 is not set
> > +CONFIG_CMD_EEPROM=3Dy
> > +CONFIG_SYS_I2C_EEPROM_ADDR_LEN=3D2
> > +CONFIG_SYS_EEPROM_SIZE=3D4096
> > +CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3D5
> > +CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=3D5 =20
>=20
> And I also miss
>=20
> # CONFIG_CMD_BIND is not set
> CONFIG_FASTBOOT_BUF_SIZE=3D0x20000000
>=20
> which you did set in your=20
>=20
> "config: imx: Add support for Phytec's phycore imx8mm running SDP
> gadget"
>=20
> patch for phycore-imx8mm_defconfig. Are they not required for fspi
> image?

IIRC this value has default value set in drivers/fastboot/Kconfig

With QSPI setup I did not needed it so big, as the flash.bin was small
enough.

With phycore-imx8mm_defconfig I've set it to larger value - as one my
update with it SD/eMMC memory with fastboot gadget.

>=20
> Teresa
>=20
> > +CONFIG_CMD_CLK=3Dy
> > +CONFIG_CMD_FUSE=3Dy
> > +CONFIG_CMD_GPIO=3Dy
> > +CONFIG_CMD_I2C=3Dy
> > +CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_PCI=3Dy
> > +CONFIG_CMD_SF_TEST=3Dy
> > +CONFIG_CMD_DHCP=3Dy
> > +CONFIG_CMD_MII=3Dy
> > +CONFIG_CMD_PING=3Dy
> > +CONFIG_CMD_CACHE=3Dy
> > +CONFIG_CMD_REGULATOR=3Dy
> > +CONFIG_CMD_EXT2=3Dy
> > +CONFIG_CMD_EXT4=3Dy
> > +CONFIG_CMD_EXT4_WRITE=3Dy
> > +CONFIG_CMD_FAT=3Dy
> > +CONFIG_OF_CONTROL=3Dy
> > +CONFIG_SPL_OF_CONTROL=3Dy
> > +CONFIG_ENV_OVERWRITE=3Dy
> > +CONFIG_ENV_IS_IN_MMC=3Dy
> > +CONFIG_SYS_REDUNDAND_ENVIRONMENT=3Dy
> > +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> > +CONFIG_SYS_MMC_ENV_DEV=3D2
> > +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
> > +CONFIG_SPL_DM=3Dy
> > +CONFIG_SPL_CLK_COMPOSITE_CCF=3Dy
> > +CONFIG_CLK_COMPOSITE_CCF=3Dy
> > +CONFIG_SPL_CLK_IMX8MM=3Dy
> > +CONFIG_CLK_IMX8MM=3Dy
> > +CONFIG_USB_FUNCTION_FASTBOOT=3Dy
> > +CONFIG_FASTBOOT_BUF_ADDR=3D0x42800000
> > +CONFIG_FASTBOOT_UUU_SUPPORT=3Dy
> > +CONFIG_MXC_GPIO=3Dy
> > +CONFIG_DM_I2C=3Dy
> > +CONFIG_MISC=3Dy
> > +CONFIG_I2C_EEPROM=3Dy
> > +CONFIG_SYS_I2C_EEPROM_ADDR=3D0x51
> > +CONFIG_SUPPORT_EMMC_BOOT=3Dy
> > +CONFIG_MMC_IO_VOLTAGE=3Dy
> > +CONFIG_MMC_UHS_SUPPORT=3Dy
> > +CONFIG_MMC_HS400_ES_SUPPORT=3Dy
> > +CONFIG_MMC_HS400_SUPPORT=3Dy
> > +CONFIG_FSL_USDHC=3Dy
> > +CONFIG_MTD=3Dy
> > +CONFIG_DM_MTD=3Dy
> > +CONFIG_DM_SPI_FLASH=3Dy
> > +CONFIG_SF_DEFAULT_BUS=3D3
> > +CONFIG_SPI_FLASH_BAR=3Dy
> > +CONFIG_SPI_FLASH_MACRONIX=3Dy
> > +CONFIG_SPI_FLASH_SPANSION=3Dy
> > +CONFIG_SPI_FLASH_STMICRO=3Dy
> > +CONFIG_SPI_FLASH_SST=3Dy
> > +CONFIG_SPI_FLASH_WINBOND=3Dy
> > +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> > +CONFIG_SPI_FLASH_MTD=3Dy
> > +CONFIG_PHYLIB=3Dy
> > +CONFIG_PHY_TI_DP83867=3Dy
> > +CONFIG_PHY_GIGE=3Dy
> > +CONFIG_FEC_MXC=3Dy
> > +CONFIG_MII=3Dy
> > +CONFIG_NVME_PCI=3Dy
> > +CONFIG_PCIE_DW_IMX=3Dy
> > +CONFIG_PHY_IMX8M_PCIE=3Dy
> > +CONFIG_PINCTRL=3Dy
> > +CONFIG_SPL_PINCTRL=3Dy
> > +CONFIG_PINCTRL_IMX8M=3Dy
> > +CONFIG_POWER_DOMAIN=3Dy
> > +CONFIG_IMX8M_POWER_DOMAIN=3Dy
> > +CONFIG_DM_REGULATOR_FIXED=3Dy
> > +CONFIG_DM_REGULATOR_GPIO=3Dy
> > +CONFIG_DM_SERIAL=3Dy
> > +CONFIG_MXC_UART=3Dy
> > +CONFIG_SPI=3Dy
> > +CONFIG_DM_SPI=3Dy
> > +CONFIG_NXP_FSPI=3Dy
> > +CONFIG_SYSRESET=3Dy
> > +CONFIG_SPL_SYSRESET=3Dy
> > +CONFIG_SYSRESET_PSCI=3Dy
> > +CONFIG_SYSRESET_WATCHDOG=3Dy
> > +CONFIG_DM_THERMAL=3Dy
> > +CONFIG_IMX_TMU=3Dy
> > +CONFIG_USB=3Dy
> > +CONFIG_SPL_USB_HOST=3Dy
> > +CONFIG_USB_EHCI_HCD=3Dy
> > +CONFIG_MXC_USB_OTG_HACTIVE=3Dy
> > +CONFIG_USB_GADGET=3Dy
> > +CONFIG_SPL_USB_GADGET=3Dy
> > +CONFIG_USB_GADGET_VENDOR_NUM=3D0x0525
> > +CONFIG_USB_GADGET_PRODUCT_NUM=3D0xa4a5
> > +CONFIG_CI_UDC=3Dy
> > +CONFIG_SDP_LOADADDR=3D0x40400000
> > +CONFIG_SPL_USB_SDP_SUPPORT=3Dy
> > +CONFIG_IMX_WATCHDOG=3Dy
> > +CONFIG_FSPI_CONF_HEADER=3Dy
> > +CONFIG_FSPI_CONF_FILE=3D"fspi_header.bin" =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/cTHRzKDplf9eHYAMpsyaQ+1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbFplMACgkQAR8vZIA0
zr1kYgf9GRe16Pk4rx2Veyq3ACxW0nE3c8qGWjxfSh9czdCCMmi20U+vks5vESaQ
n20Hr385PdEjGzSgrwv9UQRoelN5T9gXOZWLcWeYpf6ZRZpLef/grWW/7js44FDl
XtgoanuslEVvE5VG1moryatZpRuL1wstnSojxNVfFcgLYRr6X666OBtsRh1L1pHY
W/rmmuBd0HyPnFp8CPSrNbyZR7D3JlD/x3mRPVMg3sZWx/3ingOqVkgVj5hrkHLm
8XQvb3j7dQSXS8oMOU6ZE7AO/lmb3Or3DKaxpLzz5nItpR2Uz2Wpx/xgJpiqQ/ku
prw3xSUT/gaJ4+RRsK9EQKel4CSxpw==
=VHzy
-----END PGP SIGNATURE-----

--Sig_/cTHRzKDplf9eHYAMpsyaQ+1--
