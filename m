Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7493BC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 07:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64A83885EB;
	Fri, 12 Jul 2024 09:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Ti01HGQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E82FD87FF7; Fri, 12 Jul 2024 09:51:18 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A28888725
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1720770676;
 bh=7l6MUfH8CIxGsViX/Dllh+7sPyFuYQXdcLzfhaM6YpI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=Ti01HGQoUAf9ayH9uhC28Uw6/rtZvldI0dGaXSvHC9eQrmcZN3/uWntuFsTox5FCH
 9S5cjHdBWiVwbkWCyG9alXN/1dy9yg7AdDuTng1RhVKx7PcgCIAaAVNw8yLU3/DnT8
 4NEySsbdGhUAHkrpzhWDefbxdUSwzWibsl2n6aOUOecuKR1UAME2xXj3YgBlRTzABt
 sqsXPwUrTk2ZJ0LHlgIu2v470cUmvGS6h8FJXrcUWjJuKWC7EKey0WcmrOyWeslHDS
 5mOgsirS3bjiUX28zFXvi9b1PfWhS4IFr5OZ/kqg/5G7cEuUmhzHJdaLr46DEMmbGJ
 X/EGEbFDMkEvA==
Received: from [100.117.211.133]
 (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: martyn)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 91EF43780BDB;
 Fri, 12 Jul 2024 07:51:15 +0000 (UTC)
Message-ID: <1a6f8adec5928ee618350a1132daee2d073ff33e.camel@collabora.com>
Subject: Re: [PATCH v5 4/6] configs: am62x_evm_*: Enable USB and DFU support
From: Martyn Welch <martyn.welch@collabora.com>
To: Jon Humphreys <j-humphreys@ti.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Date: Fri, 12 Jul 2024 08:51:14 +0100
In-Reply-To: <86r0bztxn6.fsf@udb0321960.dhcp.ti.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
 <20240506143846.1252377-5-martyn.welch@collabora.com>
 <86h6eocmvo.fsf@udb0321960.dhcp.ti.com>
 <960ce74500b53f9bdd7e608afecc9c1bb8b790e4.camel@collabora.com>
 <86ttgvtzyj.fsf@udb0321960.dhcp.ti.com>
 <86r0bztxn6.fsf@udb0321960.dhcp.ti.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2-2 
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

On Thu, 2024-07-11 at 16:41 -0500, Jon Humphreys wrote:
> Jon Humphreys <j-humphreys@ti.com> writes:
>=20
> > Martyn Welch <martyn.welch@collabora.com> writes:
> >=20
> > > On Thu, 2024-05-23 at 15:08 -0500, Jon Humphreys wrote:
> > > > Martyn Welch <martyn.welch@collabora.com> writes:
> > > >=20
> > > > > From: Sjoerd Simons <sjoerd@collabora.com>
> > > > >=20
> > > > > Provide config fragments to enable USB host as well as USB
> > > > > gadget
> > > > > and DFU
> > > > > support for a53 and r5. This relevant fragment is included
> > > > > into the
> > > > > am62x EVM a53 defconfig. For the r5, due to the smaller
> > > > > available
> > > > > size,
> > > > > the config fragment also disables support for persistent
> > > > > storage to
> > > > > free
> > > > > up space for USB support. This fragment needs to be included
> > > > > is DFU
> > > > > booting is desired.
> > > > >=20
> > > > > The CONFIG_DFU_SF option is placed in the defconfig rather
> > > > > than the
> > > > > fragment as this is known not to be supported on all boards
> > > > > that
> > > > > can
> > > > > support DFU.
> > > > >=20
> > > > > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > > > > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > > > > ---
> > > > > Changes in v5:
> > > > > - Switch to config fragment for a53 most DFU configuration
> > > > >=20
> > > > > Changes in v4:
> > > > > - Move R5 dfu config to a config fragment rather then a full
> > > > > defconfig
> > > > > - Don't enable XHCI for the R5 SPL, unneeded
> > > > >=20
> > > > > Changes in v3:
> > > > > - Run savedefconfig to adjust to more recent u-boot
> > > > >=20
> > > > > Changes in v2:
> > > > > - Create a seperate defconfig for R5
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > =C2=A0configs/am62x_a53_usbdfu.config | 30
> > > > > ++++++++++++++++++++++++++++++
> > > > > =C2=A0configs/am62x_evm_a53_defconfig |=C2=A0 2 ++
> > > > > =C2=A0configs/am62x_r5_usbdfu.config=C2=A0 | 28
> > > > > ++++++++++++++++++++++++++++
> > > > > =C2=A03 files changed, 60 insertions(+)
> > > > > =C2=A0create mode 100644 configs/am62x_a53_usbdfu.config
> > > > > =C2=A0create mode 100644 configs/am62x_r5_usbdfu.config
> > > > >=20
> > > > > diff --git a/configs/am62x_a53_usbdfu.config
> > > > > b/configs/am62x_a53_usbdfu.config
> > > > > new file mode 100644
> > > > > index 0000000000..3a19cf2328
> > > > > --- /dev/null
> > > > > +++ b/configs/am62x_a53_usbdfu.config
> > > > > @@ -0,0 +1,29 @@
> > > > > +CONFIG_SYS_MALLOC_LEN=3D0x2000000
> > > > > +CONFIG_SPL_ENV_SUPPORT=3Dy
> > > > > +CONFIG_SPL_RAM_SUPPORT=3Dy
> > > > > +CONFIG_SPL_RAM_DEVICE=3Dy
> > > > > +CONFIG_SPL_USB_GADGET=3Dy
> > > > > +CONFIG_SPL_DFU=3Dy
> > > > > +CONFIG_CMD_DFU=3Dy
> > > > > +CONFIG_CMD_USB=3Dy
> > > > > +CONFIG_SYSCON=3Dy
> > > > > +CONFIG_SPL_SYSCON=3Dy
> > > > > +CONFIG_DFU_MMC=3Dy
> > > > > +CONFIG_DFU_RAM=3Dy
> > > > > +CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x5000
> > > > > +CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x800000
> > > > > +CONFIG_USB=3Dy
> > > > > +CONFIG_DM_USB_GADGET=3Dy
> > > > > +CONFIG_SPL_DM_USB_GADGET=3Dy
> > > > > +CONFIG_USB_XHCI_HCD=3Dy
> > > > > +CONFIG_USB_XHCI_DWC3=3Dy
> > > > > +CONFIG_USB_DWC3=3Dy
> > > > > +CONFIG_USB_DWC3_GENERIC=3Dy
> > > > > +CONFIG_SPL_USB_DWC3_GENERIC=3Dy
> > > > > +CONFIG_SPL_USB_DWC3_AM62=3Dy
> > > > > +CONFIG_USB_DWC3_AM62=3Dy
> > > > > +CONFIG_USB_GADGET=3Dy
> > > > > +CONFIG_USB_GADGET_MANUFACTURER=3D"Texas Instruments"
> > > > > +CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
> > > > > +CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6165
> > > > > +CONFIG_USB_GADGET_DOWNLOAD=3Dy
> > > > > diff --git a/configs/am62x_evm_a53_defconfig
> > > > > b/configs/am62x_evm_a53_defconfig
> > > > > index 6c708dcb05..16294a6a79 100644
> > > > > --- a/configs/am62x_evm_a53_defconfig
> > > > > +++ b/configs/am62x_evm_a53_defconfig
> > > > > @@ -68,6 +68,7 @@ CONFIG_SPL_OF_TRANSLATE=3Dy
> > > > > =C2=A0CONFIG_CLK=3Dy
> > > > > =C2=A0CONFIG_SPL_CLK=3Dy
> > > > > =C2=A0CONFIG_CLK_TI_SCI=3Dy
> > > > > +CONFIG_DFU_SF=3Dy
> > > > > =C2=A0CONFIG_DMA_CHANNELS=3Dy
> > > > > =C2=A0CONFIG_TI_K3_NAVSS_UDMA=3Dy
> > > > > =C2=A0CONFIG_TI_SCI_PROTOCOL=3Dy
> > > > > @@ -111,3 +112,5 @@ CONFIG_SPL_SYSRESET=3Dy
> > > > > =C2=A0CONFIG_SYSRESET_TI_SCI=3Dy
> > > > > =C2=A0CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
> > > > > =C2=A0CONFIG_EFI_SET_TIME=3Dy
> > > > > +
> > > > > +#include <configs/am62x_a53_usbdfu.config>
> > > > > diff --git a/configs/am62x_r5_usbdfu.config
> > > > > b/configs/am62x_r5_usbdfu.config
> > > > > new file mode 100644
> > > > > index 0000000000..772bb2ab93
> > > > > --- /dev/null
> > > > > +++ b/configs/am62x_r5_usbdfu.config
> > > > > @@ -0,0 +1,28 @@
> > > > > +CONFIG_SPL_ENV_SUPPORT=3Dy
> > > > > +CONFIG_SYSCON=3Dy
> > > > > +CONFIG_SPL_SYSCON=3Dy
> > > > > +CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x5000
> > > > > +CONFIG_MISC=3Dy
> > > > > +CONFIG_USB=3Dy
> > > > > +CONFIG_DM_USB_GADGET=3Dy
> > > > > +CONFIG_SPL_DM_USB_GADGET=3Dy
> > > > > +CONFIG_USB_DWC3=3Dy
> > > > > +CONFIG_USB_DWC3_GENERIC=3Dy
> > > > > +CONFIG_SPL_USB_DWC3_GENERIC=3Dy
> > > > > +CONFIG_SPL_USB_DWC3_AM62=3Dy
> > > > > +CONFIG_USB_GADGET=3Dy
> > > > > +CONFIG_SPL_USB_GADGET=3Dy
> > > > > +CONFIG_USB_GADGET_MANUFACTURER=3D"Texas Instruments"
> > > > > +CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
> > > > > +CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6165
> > > > > +CONFIG_USB_GADGET_DOWNLOAD=3Dy
> > > > > +CONFIG_SPL_DFU=3Dy
> > > > > +# CONFIG_SPL_MMC is not set
> > > > > +# CONFIG_SPL_FS_FAT is not set
> > > > > +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> > > > > +# CONFIG_SPL_SPI is not set
> > > > > +# CONFIG_SPL_SYS_MALLOC is not set
> > > > > +# CONFIG_CMD_GPT is not set
> > > > > +# CONFIG_CMD_MMC is not set
> > > > > +# CONFIG_CMD_FAT is not set
> > > > > +# CONFIG_MMC_SDHCI is not set
> > > > > --=20
> > > > > 2.43.0
> > > >=20
> > > > Hi all, it appears that this patch breaks OSPI DFU on the
> > > > board.=C2=A0 In
> > > > particular, changing the CONFIG_SYS_DFU_DATA_BUF_SIZE seems to
> > > > be the
> > > > culprit.
> > > >=20
> > > > I see the error as a DFU timeout when applying capsules.
> > > >=20
> > > > =C2=A0 SF: Detected s28hs512t with page size 256 Bytes, erase size
> > > > 256
> > > > KiB, total 64 MiB
> > > > =C2=A0 ############jedec_spi_nor flash@0: flash operation timed out
> > > > =C2=A0 #DFU write failed
> > > >=20
> > >=20
> > > I'm not seeing this failure using the `-next` branch from
> > > yesterday
> > > (2f96033923).
> > >=20
> > > I've attempted to use both the `uboot-capsule.bin` produced with
> > > and
> > > without the DFU config enabled whilst booting the SK-AM62 via DFU
> > > and
> > > from an SD card. I seem to be consistently getting the following:
> > >=20
> > > =3D> ext2ls mmc
> > > 1:1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=20
> > > <DIR>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
> > > .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=20
> > > <DIR>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
> > > ..=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
> > > <DIR>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384
> > > lost+found=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1132791 uboot-
> > > capsule.bin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> > > =3D> load mmc 1:1 ${loadaddr} /uboot-
> > > capsule.bin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> > > 1132791 bytes read in 57 ms (19
> > > MiB/s)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > =3D> efidebug capsule update
> > > ${loadaddr}=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > ** File not found ubootefi.var
> > > **=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > Failed to load EFI
> > > variables=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > ** Unable to write file ubootefi.var
> > > **=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > Failed to persist EFI
> > > variables=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > ** Unable to write file ubootefi.var
> > > **=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > Failed to persist EFI
> > > variables=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > ** Unable to write file ubootefi.var
> > > **=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > Failed to persist EFI
> > > variables=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > ** Unable to write file ubootefi.var
> > > **=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > Failed to persist EFI
> > > variables=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > ** Unable to write file ubootefi.var
> > > **=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > Failed to persist EFI
> > > variables=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > SF: Detected s28hs512t with page size 256 Bytes, erase size 256
> > > KiB,
> > > total 64 Mi
> > > B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=20
> > > ########################################################=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=20
> > > ** Unable to write file ubootefi.var
> > > **=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > Failed to persist EFI
> > > variables=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > =3D>
> > >=20
> > > TBH, I'm not sure if this is good or bad at this point, but I'm
> > > not
> > > seeing the error that you reported. As can be seen above, I don't
> > > have
> > > a `ubootefi.var` file, but then I don't boot using EFI
> > > mechanisms, so I
> > > guess that's expected?
> > >=20
> > > But then, the commands I've used above aren't applying the
> > > capsule
> > > either right?
> > >=20
> > > Martyn
> > >=20
> > > > Jon
> >=20
> > Hi Martyn, against upstream/next, I no longer see the failure.=C2=A0
> > Thanks for
> > looking into it.
> >=20
> > Jon
>=20
> Sorry, I wasn't running what I thought I was.=C2=A0 I can confirm that I
> see the failure when I build against 2f960339235.
>=20
> Here are my steps:
>=20
> =3D> ls mmc 1
> =C2=A0=C2=A0 288978=C2=A0=C2=A0 tiboot3.bin
> =C2=A0 1017959=C2=A0=C2=A0 tispl.bin
> =C2=A0 1130635=C2=A0=C2=A0 u-boot.img
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 307=C2=A0=C2=A0 uEnv.txt
> =C2=A0 1133143=C2=A0=C2=A0 uboot-capsule.bin
>=20
> 5 file(s), 0 dir(s)
>=20
> =3D> load mmc 1:1 ${loadaddr} /uboot-capsule.bin
> 1133143 bytes read in 60 ms (18 MiB/s)
> =3D> efidebug capsule update ${loadaddr}
> Cannot read EFI system partition
> Cannot read EFI system partition
> Failed to persist EFI variables
> Cannot read EFI system partition
> Failed to persist EFI variables
> Cannot read EFI system partition
> Failed to persist EFI variables
> Cannot read EFI system partition
> Failed to persist EFI variables
> Cannot read EFI system partition
> Failed to persist EFI variables
> SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB,
> total 64 MiB
> ############jedec_spi_nor flash@0: flash operation timed out
> #DFU write failed
> Firmware update failed: <NULL>
> Cannot handle a capsule at 0000000082000000
> =3D>=20
>=20
> What board rev of the sk-am62 are you using?=C2=A0 I am using PROC142A.
>=20
>=20

Hi Jon,

The board I have here is PROC114E3.

Martyn

> Jon
>=20

