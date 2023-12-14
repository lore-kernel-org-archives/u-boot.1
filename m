Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7380CC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 10:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E051387A6E;
	Thu, 14 Dec 2023 11:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qsJDlmq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E2087A72; Thu, 14 Dec 2023 11:41:35 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D77E86308
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 11:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id A91DEB82180;
 Thu, 14 Dec 2023 10:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F15EC433C8;
 Thu, 14 Dec 2023 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702550491;
 bh=I5X0tOoWIrA/lZPcHgkcp5TAQ2F3YfAOPhNFpAm8Lgc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qsJDlmq9UPl9xu0ZjoWQyDv6+i0LdSR7RC0jHdRnvrfaCrReRLAo40WxOeqBK9lkc
 1hBoBseaHOwt64nzKPxGt6F0Iczl/x8ZTWHrrPS1ctd82BR+OqmS10OR255hFfohb9
 P1WAyGbEkGSZ6Giqfr2xuJ71sxAJpw3jRT/Q5Xtbqqjd3TrUhwMDPz5ron2imCFNq/
 LGatk7WvEfPAgLSyvD4A9FhRt8XW6/WQDmiPtxMVYkEKBU2BQD8/vKTN0IAxnsyXjO
 akrp3/cFD4zbkRIyzaXz2934NhrFIxd7RONeda+zD2yvUc8AkxmbYLoKrSckbCaPen
 I45Zag2Zt9k5Q==
Message-ID: <6b121abf-7124-4f54-9f8b-eeeba1420e35@kernel.org>
Date: Thu, 14 Dec 2023 12:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] configs: am62x_evm_*: Enable USB and DFU support
Content-Language: en-US
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Nishanth Menon <nm@ti.com>, Martyn Welch <martyn.welch@collabora.com>,
 Bryan Brattlof <bb@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
References: <20231212210234.509309-1-sjoerd@collabora.com>
 <20231212210234.509309-5-sjoerd@collabora.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231212210234.509309-5-sjoerd@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 12/12/2023 23:02, Sjoerd Simons wrote:
> Enable USB host as well as USB gadget and DFU support for a53; For the
> r5 due to the smaller available size create a new config just for
> DFU support
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---
> 
> Changes in v3:
> - Run savedefconfig to adjust to more recent u-boot
> 
> Changes in v2:
> - Create a seperate defconfig for R5
> 
>  configs/am62x_evm_a53_defconfig       |  31 ++++++-
>  configs/am62x_evm_r5_usbdfu_defconfig | 111 ++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+), 1 deletion(-)
>  create mode 100644 configs/am62x_evm_r5_usbdfu_defconfig
> 
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
> index df2511546ea..1bd8f0fd9ec 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -1,5 +1,6 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_K3=y
> +CONFIG_SYS_MALLOC_LEN=0x2000000
>  CONFIG_SYS_MALLOC_F_LEN=0x8000
>  CONFIG_SPL_LIBCOMMON_SUPPORT=y
>  CONFIG_SPL_LIBGENERIC_SUPPORT=y
> @@ -40,17 +41,23 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>  CONFIG_SPL_STACK_R=y
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
> +CONFIG_SPL_ENV_SUPPORT=y
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
>  CONFIG_SPL_DM_MAILBOX=y
>  CONFIG_SPL_DM_SPI_FLASH=y
>  CONFIG_SPL_POWER_DOMAIN=y
> +CONFIG_SPL_RAM_SUPPORT=y
> +CONFIG_SPL_RAM_DEVICE=y
>  # CONFIG_SPL_SPI_FLASH_TINY is not set
>  CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
>  CONFIG_SPL_SPI_LOAD=y
>  CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_SPL_DFU=y
>  CONFIG_SPL_YMODEM_SUPPORT=y
> -CONFIG_SYS_BOOTM_LEN=0x800000
> +CONFIG_CMD_DFU=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_MULTI_DTB_FIT=y
> @@ -61,10 +68,17 @@ CONFIG_SPL_DM=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_REGMAP=y
>  CONFIG_SPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
>  CONFIG_SPL_OF_TRANSLATE=y
>  CONFIG_CLK=y
>  CONFIG_SPL_CLK=y
>  CONFIG_CLK_TI_SCI=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
>  CONFIG_DMA_CHANNELS=y
>  CONFIG_TI_K3_NAVSS_UDMA=y
>  CONFIG_TI_SCI_PROTOCOL=y
> @@ -103,4 +117,19 @@ CONFIG_CADENCE_QSPI=y
>  CONFIG_SYSRESET=y
>  CONFIG_SPL_SYSRESET=y
>  CONFIG_SYSRESET_TI_SCI=y
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
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> diff --git a/configs/am62x_evm_r5_usbdfu_defconfig b/configs/am62x_evm_r5_usbdfu_defconfig
> new file mode 100644
> index 00000000000..14bc08f60a4
> --- /dev/null
> +++ b/configs/am62x_evm_r5_usbdfu_defconfig
> @@ -0,0 +1,111 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SYS_MALLOC_LEN=0x08000000
> +CONFIG_SYS_MALLOC_F_LEN=0x9000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_SOC_K3_AM625=y
> +CONFIG_TARGET_AM625_R5_EVM=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c3a7f0
> +CONFIG_ENV_SIZE=0x20000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-sk"
> +CONFIG_SPL_TEXT_BASE=0x43c00000
> +CONFIG_DM_RESET=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK_R_ADDR=0x82000000
> +CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
> +CONFIG_SPL_SIZE_LIMIT=0x3A7F0
> +CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
> +CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
> +CONFIG_SPL_MAX_SIZE=0x3B000
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x43c3b000
> +CONFIG_SPL_BSS_MAX_SIZE=0x3000
> +CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_SEPARATE_BSS=y
> +CONFIG_SPL_EARLY_BSS=y
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_DM_MAILBOX=y
> +CONFIG_SPL_DM_RESET=y
> +CONFIG_SPL_POWER_DOMAIN=y
> +CONFIG_SPL_RAM_SUPPORT=y
> +CONFIG_SPL_RAM_DEVICE=y
> +CONFIG_SPL_REMOTEPROC=y
> +CONFIG_SPL_YMODEM_SUPPORT=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_ASKENV=y
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_REMOTEPROC=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_TIME=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_SPL_MULTI_DTB_FIT=y
> +CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_SPL_CLK_CCF=y
> +CONFIG_SPL_CLK_K3_PLL=y
> +CONFIG_SPL_CLK_K3=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
> +CONFIG_TI_SCI_PROTOCOL=y
> +CONFIG_DA8XX_GPIO=y
> +CONFIG_DM_MAILBOX=y
> +CONFIG_K3_SEC_PROXY=y
> +CONFIG_MISC=y
> +CONFIG_ESM_K3=y
> +CONFIG_PINCTRL=y
> +# CONFIG_PINCTRL_GENERIC is not set
> +CONFIG_SPL_PINCTRL=y
> +# CONFIG_SPL_PINCTRL_GENERIC is not set
> +CONFIG_PINCTRL_SINGLE=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_TI_POWER_DOMAIN=y
> +CONFIG_K3_SYSTEM_CONTROLLER=y
> +CONFIG_REMOTEPROC_TI_K3_ARM64=y
> +CONFIG_RESET_TI_SCI=y
> +CONFIG_SPECIFY_CONSOLE_INDEX=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SOC_DEVICE=y
> +CONFIG_SOC_DEVICE_TI_K3=y
> +CONFIG_SOC_TI=y
> +CONFIG_TIMER=y
> +CONFIG_SPL_TIMER=y
> +CONFIG_OMAP_TIMER=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y

Do you need XHCI support for DFU mode?

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
> +CONFIG_LIB_RATIONAL=y
> +CONFIG_SPL_LIB_RATIONAL=y

-- 
cheers,
-roger
