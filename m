Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECC5C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8661187937;
	Fri, 12 Jan 2024 14:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DHmpkXjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3589D87941; Fri, 12 Jan 2024 14:09:09 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C716F87282
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705064946;
 bh=IGrauBf3NaPMmnojoQCwwnsQW0R5T3qV3V+Qks/SiIo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=DHmpkXjIx617dYB7QUN+/yK7uvaEQbMeYdNqvm1nc1iSTzDzjSSWhkYJJhv55rw14
 PSWP3X/IhePfoKDKC2cQk6U27X++w1AhWKgvtdQM/TjlIrYAG8xrFIdu+gQs9S7NCx
 CPJU7RBEeIRQSxE4gQxW3iX1LeCPb5T3WfTDfbtjQYDONIXSdHDf2vQ/nViUgE1Me0
 023ZL1rKa1+XsQrG4IRS5aXqV848P2polC8kQM9IZwrzrvlVjdGUO3DlvxOMGArxY/
 x9NE0MkmVXjsNH7qxp7YEr7g1Nkn+Zv6TQU2CX100jkVUBL6RX5PCQw/AU1m5SaRdQ
 DRhZI3rFZ0ZGQ==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 421993781FFD;
 Fri, 12 Jan 2024 13:09:06 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id C2B3B9F087AF; Fri, 12 Jan 2024 14:09:05 +0100 (CET)
Message-ID: <a1553b40223d017dc6cc03f35be9b8e07f813b0b.camel@collabora.com>
Subject: Re: [PATCH v4 5/7] configs: am62x_evm_*: Enable USB and DFU support
From: Sjoerd Simons <sjoerd@collabora.com>
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Martyn Welch <martyn.welch@collabora.com>, Roger
 Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>, Dave Gerlach
 <d-gerlach@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Date: Fri, 12 Jan 2024 14:09:05 +0100
In-Reply-To: <20240112123738.v76kpf6bfngtc2kr@zigzagged>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-6-sjoerd@collabora.com>
 <20240112123738.v76kpf6bfngtc2kr@zigzagged>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
MIME-Version: 1.0
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

On Fri, 2024-01-12 at 06:37 -0600, Nishanth Menon wrote:
> On 09:52-20240112, Sjoerd Simons wrote:
> > Enable USB host as well as USB gadget and DFU support for a53; For
> > the
> > r5 due to the smaller available size create a config fragment for
> > DFU
> > supports which disables support for persistent storage to free up
> > space
> > for USB support
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> >=20
> > ---
> >=20
> > Changes in v4:
> > - Move R5 dfu config to a config fragment rather then a full
> > defconfig
> > - Don't enable XHCI for the R5 SPL, unneeded
> >=20
> > Changes in v3:
> > - Run savedefconfig to adjust to more recent u-boot
> >=20
> > Changes in v2:
> > - Create a seperate defconfig for R5
> >=20
> > =C2=A0configs/am62x_evm_a53_defconfig | 30
> > ++++++++++++++++++++++++++++++
> > =C2=A0configs/am62x_r5_usbdfu.config=C2=A0 | 28 +++++++++++++++++++++++=
+++++
> > =C2=A02 files changed, 58 insertions(+)
> > =C2=A0create mode 100644 configs/am62x_r5_usbdfu.config
> >=20
> > diff --git a/configs/am62x_evm_a53_defconfig
> > b/configs/am62x_evm_a53_defconfig
> > index aa96c1b3125..f335eb11e63 100644
> > --- a/configs/am62x_evm_a53_defconfig
> > +++ b/configs/am62x_evm_a53_defconfig
>=20
> Should we make the a53 also a defconfig fragment allowing reuse
> across
> multiple boards?

Pros and cons. having all the various options (USB boot, ETH boot, misc
other) as fragments would allow easier re-use but make it more
complicated for the end-user to get a "full-featured" u-boot.=C2=A0

My personal preference, as i'm coming with a distribution background,
is to always enable as much as possible in a default build to allow
maximum flexibility for end-users; Those that need
space/performance/whatever optimisation can always do custom builds.

It would be great if we could have a level of indirection here where by
default a set of fragments get included such that it's invisible to the
end-user that the underlying config is actually quite modular. But I
don't think that's currently possible, hence preferring a fat defconfig
such that the user/distro can just do `make am62x_evm_a53_defconfig`
(and similar for beagleplay)

Regards,
  Sjoerd

> > @@ -1,5 +1,6 @@
> > =C2=A0CONFIG_ARM=3Dy
> > =C2=A0CONFIG_ARCH_K3=3Dy
> > +CONFIG_SYS_MALLOC_LEN=3D0x2000000
> > =C2=A0CONFIG_SYS_MALLOC_F_LEN=3D0x8000
> > =C2=A0CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> > =C2=A0CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> > @@ -41,16 +42,23 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> > =C2=A0CONFIG_SPL_STACK_R=3Dy
> > =C2=A0CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
> > =C2=A0CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x1400
> > +CONFIG_SPL_ENV_SUPPORT=3Dy
> > =C2=A0CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot.img"
> > =C2=A0CONFIG_SPL_DM_MAILBOX=3Dy
> > =C2=A0CONFIG_SPL_DM_SPI_FLASH=3Dy
> > =C2=A0CONFIG_SPL_POWER_DOMAIN=3Dy
> > +CONFIG_SPL_RAM_SUPPORT=3Dy
> > +CONFIG_SPL_RAM_DEVICE=3Dy
> > =C2=A0# CONFIG_SPL_SPI_FLASH_TINY is not set
> > =C2=A0CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=3Dy
> > =C2=A0CONFIG_SPL_SPI_LOAD=3Dy
> > =C2=A0CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x280000
> > +CONFIG_SPL_USB_GADGET=3Dy
> > +CONFIG_SPL_DFU=3Dy
> > =C2=A0CONFIG_SPL_YMODEM_SUPPORT=3Dy
> > +CONFIG_CMD_DFU=3Dy
> > =C2=A0CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_USB=3Dy
> > =C2=A0CONFIG_OF_CONTROL=3Dy
> > =C2=A0CONFIG_SPL_OF_CONTROL=3Dy
> > =C2=A0CONFIG_MULTI_DTB_FIT=3Dy
> > @@ -61,10 +69,17 @@ CONFIG_SPL_DM=3Dy
> > =C2=A0CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> > =C2=A0CONFIG_REGMAP=3Dy
> > =C2=A0CONFIG_SPL_REGMAP=3Dy
> > +CONFIG_SYSCON=3Dy
> > +CONFIG_SPL_SYSCON=3Dy
> > =C2=A0CONFIG_SPL_OF_TRANSLATE=3Dy
> > =C2=A0CONFIG_CLK=3Dy
> > =C2=A0CONFIG_SPL_CLK=3Dy
> > =C2=A0CONFIG_CLK_TI_SCI=3Dy
> > +CONFIG_DFU_MMC=3Dy
> > +CONFIG_DFU_RAM=3Dy
> > +CONFIG_DFU_SF=3Dy
> > +CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x5000
> > +CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x800000
> > =C2=A0CONFIG_DMA_CHANNELS=3Dy
> > =C2=A0CONFIG_TI_K3_NAVSS_UDMA=3Dy
> > =C2=A0CONFIG_TI_SCI_PROTOCOL=3Dy
> > @@ -103,4 +118,19 @@ CONFIG_CADENCE_QSPI=3Dy
> > =C2=A0CONFIG_SYSRESET=3Dy
> > =C2=A0CONFIG_SPL_SYSRESET=3Dy
> > =C2=A0CONFIG_SYSRESET_TI_SCI=3Dy
> > +CONFIG_USB=3Dy
> > +CONFIG_DM_USB_GADGET=3Dy
> > +CONFIG_SPL_DM_USB_GADGET=3Dy
> > +CONFIG_USB_XHCI_HCD=3Dy
> > +CONFIG_USB_XHCI_DWC3=3Dy
> > +CONFIG_USB_DWC3=3Dy
> > +CONFIG_USB_DWC3_GENERIC=3Dy
> > +CONFIG_SPL_USB_DWC3_GENERIC=3Dy
> > +CONFIG_SPL_USB_DWC3_AM62=3Dy
> > +CONFIG_USB_DWC3_AM62=3Dy
> > +CONFIG_USB_GADGET=3Dy
> > +CONFIG_USB_GADGET_MANUFACTURER=3D"Texas Instruments"
> > +CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
> > +CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6165
> > +CONFIG_USB_GADGET_DOWNLOAD=3Dy
> > =C2=A0CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
> > diff --git a/configs/am62x_r5_usbdfu.config
> > b/configs/am62x_r5_usbdfu.config
> > new file mode 100644
> > index 00000000000..772bb2ab935
> > --- /dev/null
> > +++ b/configs/am62x_r5_usbdfu.config
> > @@ -0,0 +1,28 @@
> > +CONFIG_SPL_ENV_SUPPORT=3Dy
> > +CONFIG_SYSCON=3Dy
> > +CONFIG_SPL_SYSCON=3Dy
> > +CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x5000
> > +CONFIG_MISC=3Dy
> > +CONFIG_USB=3Dy
> > +CONFIG_DM_USB_GADGET=3Dy
> > +CONFIG_SPL_DM_USB_GADGET=3Dy
> > +CONFIG_USB_DWC3=3Dy
> > +CONFIG_USB_DWC3_GENERIC=3Dy
> > +CONFIG_SPL_USB_DWC3_GENERIC=3Dy
> > +CONFIG_SPL_USB_DWC3_AM62=3Dy
> > +CONFIG_USB_GADGET=3Dy
> > +CONFIG_SPL_USB_GADGET=3Dy
> > +CONFIG_USB_GADGET_MANUFACTURER=3D"Texas Instruments"
> > +CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
> > +CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6165
> > +CONFIG_USB_GADGET_DOWNLOAD=3Dy
> > +CONFIG_SPL_DFU=3Dy
> > +# CONFIG_SPL_MMC is not set
> > +# CONFIG_SPL_FS_FAT is not set
> > +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> > +# CONFIG_SPL_SPI is not set
> > +# CONFIG_SPL_SYS_MALLOC is not set
> > +# CONFIG_CMD_GPT is not set
> > +# CONFIG_CMD_MMC is not set
> > +# CONFIG_CMD_FAT is not set
> > +# CONFIG_MMC_SDHCI is not set
> > --=20
> > 2.43.0
> >=20
>=20

--=20
Sjoerd Simons
Collabora Ltd.
