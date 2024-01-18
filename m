Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE5EC4725D
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 03:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E02E87AB9;
	Thu, 18 Jan 2024 04:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TJH7XBft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E5BD87A07; Thu, 18 Jan 2024 04:22:46 +0100 (CET)
Received: from mail-m25498.xmail.ntesmail.com (mail-m25498.xmail.ntesmail.com
 [103.129.254.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 353FD87971
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 04:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=TJH7XBftNEFQzI9teojnBnhgMaHdvgu/TMjS/6uPg67q3CDuEQEJ+KMxrHPEoWvoe06n3YQ9lh9sNZvlbLWVhSTEPqEOPYxf/JEEUBid/O0h04wOHrLPOlKkc88HEXrNax35+I8uitkOruCuqKertrjIzt7viTAtVOZR4FfwyfY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=CCn4R453/DoJqJcHMaME3PGskEvVjESxRiA0gv1b+1w=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id D0704900251;
 Thu, 18 Jan 2024 11:22:32 +0800 (CST)
Message-ID: <9192a84e-c763-4226-96b0-cd214f2e074f@rock-chips.com>
Date: Thu, 18 Jan 2024 11:22:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add support for FriendlyARM NanoPi R2C
 Plus
Content-Language: en-US
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>
Cc: u-boot@lists.denx.de
References: <20231223040007.72997-1-cnsztl@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231223040007.72997-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNITlZPGRpMGR4ZTENDSUJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1DTExPVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1a9780b82eafkusnd0704900251
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRQ6PQw5DTwtCBEhTSovAk0J
 FA4wCQ5VSlVKTEtOTk9DSk5ITEtLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTktNNwY+
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


On 2023/12/23 12:00, Tianling Shen wrote:
> The NanoPi R2C Plus is a small variant of NanoPi R2C with a on-board
> eMMC flash (8G) included.
>
> The device tree is taken from the kernel v6.5.
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   .../dts/rk3328-nanopi-r2c-plus-u-boot.dtsi    |   9 ++
>   arch/arm/dts/rk3328-nanopi-r2c-plus.dts       |  33 +++++
>   board/rockchip/evb_rk3328/MAINTAINERS         |   6 +
>   configs/nanopi-r2c-plus-rk3328_defconfig      | 114 ++++++++++++++++++
>   5 files changed, 163 insertions(+)
>   create mode 100644 arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3328-nanopi-r2c-plus.dts
>   create mode 100644 configs/nanopi-r2c-plus-rk3328_defconfig
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 9d28a485bec..6909f95e084 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -126,6 +126,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3308) += \
>   dtb-$(CONFIG_ROCKCHIP_RK3328) += \
>   	rk3328-evb.dtb \
>   	rk3328-nanopi-r2c.dtb \
> +	rk3328-nanopi-r2c-plus.dtb \
>   	rk3328-nanopi-r2s.dtb \
>   	rk3328-orangepi-r1-plus.dtb \
>   	rk3328-orangepi-r1-plus-lts.dtb \
> diff --git a/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> new file mode 100644
> index 00000000000..f8adb9e5e1f
> --- /dev/null
> +++ b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "rk3328-nanopi-r2c-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3328-nanopi-r2c-plus.dts b/arch/arm/dts/rk3328-nanopi-r2c-plus.dts
> new file mode 100644
> index 00000000000..16a1958e457
> --- /dev/null
> +++ b/arch/arm/dts/rk3328-nanopi-r2c-plus.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 FriendlyElec Computer Tech. Co., Ltd.
> + * (http://www.friendlyarm.com)
> + *
> + * Copyright (c) 2023 Tianling Shen <cnsztl@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include "rk3328-nanopi-r2c.dts"
> +
> +/ {
> +	model = "FriendlyElec NanoPi R2C Plus";
> +	compatible = "friendlyarm,nanopi-r2c-plus", "rockchip,rk3328";
> +
> +	aliases {
> +		mmc1 = &emmc;
> +	};
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	max-frequency = <150000000>;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
> +	vmmc-supply = <&vcc_io_33>;
> +	vqmmc-supply = <&vcc18_emmc>;
> +	status = "okay";
> +};
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
> index 8a19eb373d0..5fc114a63f6 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -11,6 +11,12 @@ S:      Maintained
>   F:      configs/nanopi-r2c-rk3328_defconfig
>   F:      arch/arm/dts/rk3328-nanopi-r2c-u-boot.dtsi
>   
> +NANOPI-R2C-PLUS-RK3328
> +M:      Tianling Shen <cnsztl@gmail.com>
> +S:      Maintained
> +F:      configs/nanopi-r2c-plus-rk3328_defconfig
> +F:      arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> +
>   NANOPI-R2S-RK3328
>   M:      David Bauer <mail@david-bauer.net>
>   S:      Maintained
> diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
> new file mode 100644
> index 00000000000..320ed8b434a
> --- /dev/null
> +++ b/configs/nanopi-r2c-plus-rk3328_defconfig
> @@ -0,0 +1,114 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00200000
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
> +CONFIG_SF_DEFAULT_SPEED=20000000
> +CONFIG_ENV_OFFSET=0x3F8000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2c-plus"
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_RK3328=y
> +CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_TPL_LIBCOMMON_SUPPORT=y
> +CONFIG_TPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
> +CONFIG_DEBUG_UART_BASE=0xFF130000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_DEBUG_UART=y
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c-plus.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_MISC_INIT_R=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x2000000
> +CONFIG_SPL_BSS_MAX_SIZE=0x2000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_TPL_SYS_MALLOC_SIMPLE=y
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_TIME=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_TPL_OF_CONTROL=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_TPL_OF_PLATDATA=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=1
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_TPL_DM=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_TPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_TPL_SYSCON=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x800800
> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_RAM=y
> +CONFIG_SPL_RAM=y
> +CONFIG_TPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSRESET=y
> +# CONFIG_TPL_SYSRESET is not set
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC2=y
> +CONFIG_USB_DWC3=y
> +# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_SPL_TINY_MEMSET=y
> +CONFIG_TPL_TINY_MEMSET=y
> +CONFIG_ERRNO_STR=y
