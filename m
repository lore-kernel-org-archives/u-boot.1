Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31179C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 10:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A160A8792D;
	Fri, 12 Jan 2024 11:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u5PahWiM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 312D18798C; Fri, 12 Jan 2024 11:41:20 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9FB38764D
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 11:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CBB58CE20CC;
 Fri, 12 Jan 2024 10:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BB3C433C7;
 Fri, 12 Jan 2024 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705056074;
 bh=WfbXsI/XAdHG9GtztxmSJ0pgqn5qNGi7EQ4qLyECrsA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=u5PahWiMe8OxOBdLQIE9Mx2QS8dj2xD7VVTVmW9VJknmMcyNpGnfBw6pQ3TBqK/bA
 gseGPCugH20h32Ln/Z0e+hlJVB5ltJsF1VUh/luV0rUwW22gChIk6hxfOPDALvVjPc
 ZSIkq8x7RI1CvJ5NoHMk/b48wOOsV0jnPI5ajBgzEMRnk7po/zTwB7uDdnIcZLLvtL
 OWMQrVvfgi3pgPP2qk0eErPA/8przMpF7IxRoAAzOWeMugx71YItlzeIFJ9UXxXxNg
 rCuqMcFUK+WQ4vQpDjVSEW4A6LjGMqkh3RLjgPap5bTuElybsKJoy4FdUK1xFSogmC
 w0Yb6UNGL+jOg==
Message-ID: <f43b81c8-1886-4560-b8fe-dfa6a88ea726@kernel.org>
Date: Fri, 12 Jan 2024 12:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] beagleplay: Add DFU support
Content-Language: en-US
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-7-sjoerd@collabora.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240112085317.1866449-7-sjoerd@collabora.com>
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



On 12/01/2024 10:52, Sjoerd Simons wrote:
> DFU mode on a beagleplay can be used via the Type-C connector by holding
> the USR switch while powering on.
> 
> Configuration is only added for the A53 u-boot parts, for R5 the
> am62x_r5_usbdfu.config fragment should be used.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---
> 
> Changes in v4:
> - New patch
> 
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  8 ++++++
>  board/beagle/beagleplay/beagleplay.env       |  1 +
>  configs/am62x_beagleplay_a53_defconfig       | 30 ++++++++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index a723caa5805..0b1e5e70fe2 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -61,6 +61,14 @@
>  	>;
>  };
>  
> +&usbss0 {
> +	bootph-all;
> +};
> +
> +&usb0 {
> +	bootph-all;
> +};
> +
>  #ifdef CONFIG_TARGET_AM625_A53_BEAGLEPLAY
>  
>  #define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
> diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
> index 4f0a94a8113..85c94856017 100644
> --- a/board/beagle/beagleplay/beagleplay.env
> +++ b/board/beagle/beagleplay/beagleplay.env
> @@ -1,6 +1,7 @@
>  #include <env/ti/ti_common.env>
>  #include <env/ti/default_findfdt.env>
>  #include <env/ti/mmc.env>
> +#include <env/ti/k3_dfu.env>
>  
>  name_kern=Image
>  console=ttyS2,115200n8
> diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
> index 0be20045a97..dfe04b71810 100644
> --- a/configs/am62x_beagleplay_a53_defconfig
> +++ b/configs/am62x_beagleplay_a53_defconfig
> @@ -1,5 +1,6 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_K3=y
> +CONFIG_SYS_MALLOC_LEN=0x2000000
>  CONFIG_SYS_MALLOC_F_LEN=0x8000
>  CONFIG_SPL_GPIO=y
>  CONFIG_SPL_LIBCOMMON_SUPPORT=y
> @@ -43,15 +44,20 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>  CONFIG_SPL_STACK_R=y
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
> +CONFIG_SPL_ENV_SUPPORT=y
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
>  CONFIG_SPL_I2C=y
>  CONFIG_SPL_DM_MAILBOX=y
>  CONFIG_SPL_POWER_DOMAIN=y
> +CONFIG_SPL_RAM_SUPPORT=y
> +CONFIG_SPL_RAM_DEVICE=y
>  CONFIG_SPL_YMODEM_SUPPORT=y
> +CONFIG_CMD_DFU=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPIO_READ=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
>  CONFIG_CMD_PMIC=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_OF_CONTROL=y
> @@ -68,6 +74,10 @@ CONFIG_SPL_OF_TRANSLATE=y
>  CONFIG_CLK=y
>  CONFIG_SPL_CLK=y
>  CONFIG_CLK_TI_SCI=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
>  CONFIG_DMA_CHANNELS=y
>  CONFIG_TI_K3_NAVSS_UDMA=y
>  CONFIG_TI_SCI_PROTOCOL=y
> @@ -113,6 +123,26 @@ CONFIG_SOC_TI=y
>  CONFIG_SYSRESET=y
>  CONFIG_SPL_SYSRESET=y
>  CONFIG_SYSRESET_TI_SCI=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y

XHCI features are really not required for DFU
but now I see that we depend on XHCI driver to get
probed even for device mode. lol.

> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_AM62=y
> +CONFIG_USB_DWC3_AM62=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_SPL_DFU=y
>  CONFIG_EXT4_WRITE=y
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>  CONFIG_LZO=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +

-- 
cheers,
-roger
