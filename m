Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B540C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 10:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7488F8792D;
	Fri, 12 Jan 2024 11:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fSJCsI75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE23879C0; Fri, 12 Jan 2024 11:44:20 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0968764D
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 11:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705056258;
 bh=56SjH3SkLD+OAmL0p4iVToYaFd4Bnv185rlSEpN2+ys=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=fSJCsI75ThByV3Y+JAbdjbcxeaNFagWiq/RGVH3h0wSNatiZeVh3f/hhIJ2xQjM2N
 hf0AVhwsUeKndZgwewfz14LBVsDvFXJB/U0P0WmPOZsJB2hRB0vbXY/N/QMCHqtu8w
 on0wAg3XVaAdL51iKFloI7Z+gTRDbk/IRx3ityDyZA3ougbRXR6zGnF00Md/oYc0Es
 Kq+u4d/+jHEN3prfHppGK5Zlpblw+FC14zmJmFRJ1bzvhl/GZvEmevXPUnw+cmEXT2
 qmLxTtI2QlqAKPHfozh8ENB98XThAc2dl/AC49RZE/YFvZd9BVMPOKulGYph/edSSl
 44JLqqLRGRkVQ==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2C8953781FED;
 Fri, 12 Jan 2024 10:44:18 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id A488C9F06F61; Fri, 12 Jan 2024 11:44:17 +0100 (CET)
Message-ID: <2cd97e2cd89597760eb8c1567be37f78445e1978.camel@collabora.com>
Subject: Re: [PATCH v4 5/7] configs: am62x_evm_*: Enable USB and DFU support
From: Sjoerd Simons <sjoerd@collabora.com>
To: Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Nishanth Menon <nm@ti.com>, 
 Andrew Davis <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>,  Manorit Chawdhry <m-chawdhry@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Nikhil M Jain <n-jain1@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>
Date: Fri, 12 Jan 2024 11:44:17 +0100
In-Reply-To: <57e0d59d-ea1d-4396-ae63-2440e0c89eb9@kernel.org>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-6-sjoerd@collabora.com>
 <57e0d59d-ea1d-4396-ae63-2440e0c89eb9@kernel.org>
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

On Fri, 2024-01-12 at 11:58 +0200, Roger Quadros wrote:
> Hi Sjoerd,
>=20
> On 12/01/2024 10:52, Sjoerd Simons wrote:
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
>=20
> Why do we need USB DFU support at R5 SPL stage?
> What is the use case?

So we can load the A53 SPL over DFU ? There is no way to get a full DFU
bootchain without the R5 also taking part=20


--=20
Sjoerd Simons
Collabora Ltd.
