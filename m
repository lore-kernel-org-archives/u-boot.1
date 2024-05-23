Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5CDC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 20:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD97885FB;
	Thu, 23 May 2024 22:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mxwn6xco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF07885C5; Thu, 23 May 2024 22:08:20 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065778861D
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 22:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NK8BJs126696;
 Thu, 23 May 2024 15:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716494891;
 bh=SL8A7RsFds/Y3POyHElILpCCRr4XT1SJBo4otYsTdWc=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=mxwn6xcogPVZ1vIasvve+AxGu9WtxM62VKyqAO8DJiUFQdxibIGrjk2OjmHq8FLGe
 tih/eOoh52G+j4LH5rEAnGJhRmsmItPTbOgx4RNCbopXnaXAl/4vY5iFx0D0xkI0IR
 EpKY2g9mOPSirBjbOSALGanW42CCrfj8LtRM0x6g=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NK8Bc0022814
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 May 2024 15:08:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 15:08:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 15:08:11 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NK8BeX119940;
 Thu, 23 May 2024 15:08:11 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Martyn Welch <martyn.welch@collabora.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
CC: Sjoerd Simons <sjoerd@collabora.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 4/6] configs: am62x_evm_*: Enable USB and DFU support
In-Reply-To: <20240506143846.1252377-5-martyn.welch@collabora.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
 <20240506143846.1252377-5-martyn.welch@collabora.com>
Date: Thu, 23 May 2024 15:08:11 -0500
Message-ID: <86h6eocmvo.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Martyn Welch <martyn.welch@collabora.com> writes:

> From: Sjoerd Simons <sjoerd@collabora.com>
>
> Provide config fragments to enable USB host as well as USB gadget and DFU
> support for a53 and r5. This relevant fragment is included into the
> am62x EVM a53 defconfig. For the r5, due to the smaller available size,
> the config fragment also disables support for persistent storage to free
> up space for USB support. This fragment needs to be included is DFU
> booting is desired.
>
> The CONFIG_DFU_SF option is placed in the defconfig rather than the
> fragment as this is known not to be supported on all boards that can
> support DFU.
>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> Changes in v5:
> - Switch to config fragment for a53 most DFU configuration
>
> Changes in v4:
> - Move R5 dfu config to a config fragment rather then a full defconfig
> - Don't enable XHCI for the R5 SPL, unneeded
>
> Changes in v3:
> - Run savedefconfig to adjust to more recent u-boot
>
> Changes in v2:
> - Create a seperate defconfig for R5
>
>
>
>  configs/am62x_a53_usbdfu.config | 30 ++++++++++++++++++++++++++++++
>  configs/am62x_evm_a53_defconfig |  2 ++
>  configs/am62x_r5_usbdfu.config  | 28 ++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 configs/am62x_a53_usbdfu.config
>  create mode 100644 configs/am62x_r5_usbdfu.config
>
> diff --git a/configs/am62x_a53_usbdfu.config b/configs/am62x_a53_usbdfu.config
> new file mode 100644
> index 0000000000..3a19cf2328
> --- /dev/null
> +++ b/configs/am62x_a53_usbdfu.config
> @@ -0,0 +1,29 @@
> +CONFIG_SYS_MALLOC_LEN=0x2000000
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_RAM_SUPPORT=y
> +CONFIG_SPL_RAM_DEVICE=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_SPL_DFU=y
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_USB=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_AM62=y
> +CONFIG_USB_DWC3_AM62=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
> +CONFIG_USB_GADGET_DOWNLOAD=y
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
> index 6c708dcb05..16294a6a79 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -68,6 +68,7 @@ CONFIG_SPL_OF_TRANSLATE=y
>  CONFIG_CLK=y
>  CONFIG_SPL_CLK=y
>  CONFIG_CLK_TI_SCI=y
> +CONFIG_DFU_SF=y
>  CONFIG_DMA_CHANNELS=y
>  CONFIG_TI_K3_NAVSS_UDMA=y
>  CONFIG_TI_SCI_PROTOCOL=y
> @@ -111,3 +112,5 @@ CONFIG_SPL_SYSRESET=y
>  CONFIG_SYSRESET_TI_SCI=y
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>  CONFIG_EFI_SET_TIME=y
> +
> +#include <configs/am62x_a53_usbdfu.config>
> diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.config
> new file mode 100644
> index 0000000000..772bb2ab93
> --- /dev/null
> +++ b/configs/am62x_r5_usbdfu.config
> @@ -0,0 +1,28 @@
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
> +CONFIG_MISC=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_AM62=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_SPL_DFU=y
> +# CONFIG_SPL_MMC is not set
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +# CONFIG_SPL_SPI is not set
> +# CONFIG_SPL_SYS_MALLOC is not set
> +# CONFIG_CMD_GPT is not set
> +# CONFIG_CMD_MMC is not set
> +# CONFIG_CMD_FAT is not set
> +# CONFIG_MMC_SDHCI is not set
> -- 
> 2.43.0

Hi all, it appears that this patch breaks OSPI DFU on the board.  In
particular, changing the CONFIG_SYS_DFU_DATA_BUF_SIZE seems to be the
culprit.

I see the error as a DFU timeout when applying capsules.

  SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, total 64 MiB
  ############jedec_spi_nor flash@0: flash operation timed out
  #DFU write failed

Jon
