Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE583C3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 03:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28D1887CFE;
	Tue, 16 Jul 2024 05:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q/MReL8X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D9EB807EC; Tue, 16 Jul 2024 05:07:04 +0200 (CEST)
Received: from mail-m12827.netease.com (mail-m12827.netease.com
 [103.209.128.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E32807EC
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 05:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Q/MReL8X1cNsOmjWSs85Q1VZd5jESzlnDa7scOSeDIrIF6Qr/oQAiQA4IjB7VXQTgWOHzGIWuEr7VQDtH9JfNuxTXjfrOZ7ygHCdS1zFM3qz9TvC2DZkQ27emQjD9kCR7NdCHqhpscZ8/Nhc0ycIbEMNjA/RbRYy0Wrui2+iC50=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=iYmwuYzZPlMom5sCskziwl1p3UvWbTm096YWOJeP3/w=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 014BE900212;
 Tue, 16 Jul 2024 11:06:48 +0800 (CST)
Message-ID: <6e70673b-c6ff-49ff-95e1-3a6693d8aa82@rock-chips.com>
Date: Tue, 16 Jul 2024 11:06:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: add support for Radxa ROCK Pi E v3.0
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, banglang.huang@foxmail.com,
 jonas@kwiboo.se
References: <20240624204529.34742-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240624204529.34742-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhhKTlZPT0geHR0eSENDSBpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b981ca5103a9kunm014be900212
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6GBw4DTIxSR8oOj8YIxET
 Cg0wCy5VSlVKTElKS0JCSUtCQkpDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTk5JNwY+
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


On 2024/6/25 04:45, FUKAUMI Naoki wrote:
> ROCK Pi E v3.0 uses DDR4 SDRAM instead of DDR3 SDRAM used in v1.2x.
>
> prepare new rk3328-rock-pi-e-v3.dts in u-boot which just includes
> upstream rk3328-rock-pi-e.dts.
>
> defconfig still uses
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
>
> because v3.0 and prior are compatible.
>
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   ...dtsi => rk3328-rock-pi-e-base-u-boot.dtsi} |  1 -
>   arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi     | 47 +--------
>   arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi  |  4 +
>   arch/arm/dts/rk3328-rock-pi-e-v3.dts          |  4 +
>   board/rockchip/evb_rk3328/MAINTAINERS         |  4 +-
>   configs/rock-pi-e-v3-rk3328_defconfig         | 97 +++++++++++++++++++
>   6 files changed, 111 insertions(+), 46 deletions(-)
>   copy arch/arm/dts/{rk3328-rock-pi-e-u-boot.dtsi => rk3328-rock-pi-e-base-u-boot.dtsi} (94%)
>   rewrite arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi (88%)
>   create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3.dts
>   create mode 100644 configs/rock-pi-e-v3-rk3328_defconfig
>
> diff --git a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> similarity index 94%
> copy from arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
> copy to arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> index d314bfad6f..39bb66c4fc 100644
> --- a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> @@ -4,7 +4,6 @@
>    */
>   
>   #include "rk3328-u-boot.dtsi"
> -#include "rk3328-sdram-ddr3-666.dtsi"
>   
>   / {
>   	smbios {
> diff --git a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
> dissimilarity index 88%
> index d314bfad6f..8e82f6a6f1 100644
> --- a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
> @@ -1,43 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2020 Radxa
> - */
> -
> -#include "rk3328-u-boot.dtsi"
> -#include "rk3328-sdram-ddr3-666.dtsi"
> -
> -/ {
> -	smbios {
> -		compatible = "u-boot,sysinfo-smbios";
> -
> -		smbios {
> -			system {
> -				manufacturer = "radxa";
> -				product = "rock-pi-e_rk3328";
> -			};
> -
> -			baseboard {
> -				manufacturer = "radxa";
> -				product = "rock-pi-e_rk3328";
> -			};
> -
> -			chassis {
> -				manufacturer = "radxa";
> -				product = "rock-pi-e_rk3328";
> -			};
> -		};
> -	};
> -};
> -
> -&u2phy_host {
> -	phy-supply = <&vcc_host_5v>;
> -};
> -
> -&vcc_host_5v {
> -	/delete-property/ regulator-always-on;
> -	/delete-property/ regulator-boot-on;
> -};
> -
> -&vcc_sd {
> -	bootph-pre-ram;
> -};
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3328-rock-pi-e-base-u-boot.dtsi"
> +#include "rk3328-sdram-ddr3-666.dtsi"
> diff --git a/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
> new file mode 100644
> index 0000000000..4d89ae54e6
> --- /dev/null
> +++ b/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3328-rock-pi-e-base-u-boot.dtsi"
> +#include "rk3328-sdram-ddr4-666.dtsi"
> diff --git a/arch/arm/dts/rk3328-rock-pi-e-v3.dts b/arch/arm/dts/rk3328-rock-pi-e-v3.dts
> new file mode 100644
> index 0000000000..f1c1c36a99
> --- /dev/null
> +++ b/arch/arm/dts/rk3328-rock-pi-e-v3.dts
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +#include "rk3328-rock-pi-e.dts"
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
> index 675b72dd06..8f619e54e0 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -64,5 +64,5 @@ M:      Banglang Huang <banglang.huang@foxmail.com>
>   R:      Jonas Karlman <jonas@kwiboo.se>
>   S:      Maintained
>   F:      configs/rock-pi-e-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-rock-pi-e.dts
> -F:      arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
> +F:      configs/rock-pi-e-v3-rk3328_defconfig
> +F:      arch/arm/dts/rk3328-rock-pi-e*
> diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
> new file mode 100644
> index 0000000000..4c6cc634bd
> --- /dev/null
> +++ b/configs/rock-pi-e-v3-rk3328_defconfig
> @@ -0,0 +1,97 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=20000000
> +CONFIG_ENV_OFFSET=0x3F8000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock-pi-e-v3"
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_RK3328=y
> +CONFIG_DEBUG_UART_BASE=0xFF130000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_POWER=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_TPL_OF_CONTROL=y
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_TPL_OF_PLATDATA=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=1
> +CONFIG_TPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_TPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_TPL_SYSCON=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_RAM=y
> +CONFIG_SPL_RAM=y
> +CONFIG_TPL_RAM=y
> +CONFIG_DM_RNG=y
> +CONFIG_RNG_ROCKCHIP=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
> +CONFIG_SYSRESET=y
> +# CONFIG_TPL_SYSRESET is not set
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_TINY_MEMSET=y
> +CONFIG_TPL_TINY_MEMSET=y
> +CONFIG_ERRNO_STR=y
