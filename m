Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AC9C3ABC3
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 03:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7598820EB;
	Thu,  8 May 2025 05:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="S9kVIbJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 101B08210D; Thu,  8 May 2025 05:10:36 +0200 (CEST)
Received: from mail-m49235.qiye.163.com (mail-m49235.qiye.163.com
 [45.254.49.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D32A981FAB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 05:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1452200d0;
 Thu, 8 May 2025 11:10:28 +0800 (GMT+08:00)
Message-ID: <06f9b9bd-9439-47c2-9408-071a14b8c72e@rock-chips.com>
Date: Thu, 8 May 2025 11:10:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: Add LCKFB TaishanPi RK3566 Board
To: Jiehui He <jiehui.he@foxmail.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, chenjh@rock-chips.com,
 jonas@kwiboo.se
References: <tencent_93CD49DECE6851B4BCA7C46427864CB0340A@qq.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <tencent_93CD49DECE6851B4BCA7C46427864CB0340A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0IdVh5KSEgZS0wZQh9OHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96addf84a903afkunm1452200d0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhQ6SCo6HjIBNwg8MCg5Az5P
 TzdPCSlVSlVKTE9NTUxIQ0hLSU9LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU1KQ0I3Bg++
DKIM-Signature: a=rsa-sha256;
 b=S9kVIbJEnOxRqamlUwYU34aNtimfGZvqwUsbyshKFraF0rgpwIdHUCRGL5a52yXD0FOIza8K8j1ZMObtgI2CGqhqG39etiLleOFFsgAma5svQm1PaktKKqD6dBVb3xJUsuykIP4xsE4R0JFawsRIhBea3gtiJdIBFroaNTJYlN0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=7sgF2Co+UOukPqhNL72TGelq9uV2IqSrxx62Uwpga9U=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/4/15 15:36, Jiehui He wrote:
> The LCKFB TaishanPi is a single-board computer based on the RK3566 SoC.
>
> Specification:
> - 1/2 Gib RAM
> - Optinal EMMC
> - SD-Card
> - HDMI / MIPI CSI / MIPI DSI
> - USB 2.0 Host (Type-A)
> - USB 2.0 Host / OTG (Type-C)
> - No Ethernet
>
> This patch adds U-Boot support for the LCKFB TaishanPi RK3566 board, including:
> - U-Boot device tree
> - Default defconfig
> - Board documentation
> - MAINTAINERS entry
>
> Changes in v2:
> - Removed unused configs from `lckfb-tspi-rk3566_defconfig`
> - Reordered TaishanPi entry in `doc/board/rockchip/rockchip.rst` alphabetically
>
> Link to v1:
> https://lore.kernel.org/u-boot/tencent_95ED0C0545D87B6A8C4B62EC045D53AD2406@qq.com/
>
> Signed-off-by: Jiehui He <jiehui.he@foxmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi | 11 +++
>   board/rockchip/evb_rk3568/MAINTAINERS      |  6 ++
>   configs/lckfb-tspi-rk3566_defconfig        | 78 ++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |  1 +
>   4 files changed, 96 insertions(+)
>   create mode 100644 arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
>   create mode 100644 configs/lckfb-tspi-rk3566_defconfig
>
> diff --git a/arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi b/arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
> new file mode 100644
> index 00000000000..0c8e7018f13
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +&rgb_led_r {
> +	default-state = "off";
> +};
> +
> +&rgb_led_b {
> +	default-state = "off";
> +};
> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index b2780401a39..6cf568ad150 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -89,3 +89,9 @@ M:	Maxim Moskalets <maximmosk4@gmail.com>
>   S:	Maintained
>   F:	arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
>   F:	configs/rock-3c-rk3566_defconfig
> +
> +LCKFB-TaishanPi
> +M:	Jiehui He <jiehui.he@foxmail.com>
> +S:	Maintained
> +F:	configs/lckfb-tspi-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
> diff --git a/configs/lckfb-tspi-rk3566_defconfig b/configs/lckfb-tspi-rk3566_defconfig
> new file mode 100644
> index 00000000000..bc54be5ca53
> --- /dev/null
> +++ b/configs/lckfb-tspi-rk3566_defconfig
> @@ -0,0 +1,78 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-lckfb-tspi"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-lckfb-tspi.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_FAN53555=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_GENERIC=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 1407080f1f4..abffbf36f40 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
>        - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
>        - FriendlyElec NanoPi R3S (nanopi-r3s-rk3566)
>        - Hardkernel ODROID-M1S (odroid-m1s-rk3566)
> +     - LCKFB TaishanPi (lckfb-tspi-rk3566)
>        - Pine64 PineTab2 (pinetab2-rk3566)
>        - Pine64 Quartz64-A Board (quartz64-a-rk3566)
>        - Pine64 Quartz64-B Board (quartz64-b-rk3566)
