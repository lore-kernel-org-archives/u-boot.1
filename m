Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1669FC3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 02:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A143820EB;
	Thu,  8 May 2025 04:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NgwG3+AG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DDA48211F; Thu,  8 May 2025 04:27:08 +0200 (CEST)
Received: from mail-m83149.xmail.ntesmail.com (mail-m83149.xmail.ntesmail.com
 [156.224.83.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28CEF81FAB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 04:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.223] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 145060aab;
 Thu, 8 May 2025 10:26:59 +0800 (GMT+08:00)
Message-ID: <be1e09f1-fa57-4c51-9094-d918289dcc19@rock-chips.com>
Date: Thu, 8 May 2025 10:26:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] board: rockchip: Add minimal generic RK3576 board
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, u-boot@lists.denx.de
References: <20250422211216.3727559-1-jonas@kwiboo.se>
 <20250422211216.3727559-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250422211216.3727559-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNJTlZKHUtNTh4ZHk5OSx1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96adb7b4dc03afkunm145060aab
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxg6NCo4KDJMEQg5F0gzEhc3
 Ej0KCzdVSlVKTE9NTUxKSUlKT0NIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTUtLNwY+
DKIM-Signature: a=rsa-sha256;
 b=NgwG3+AG15UCnMHXHDWkygezcVU4QQupvN8ksfuRjGj9mG9Ios/cweWSYTcK46Cw/t3dP+veG9FLPasRwME78gLNOQYLW3SMvlSa5OXuQCiw18DvSCzZIY0TKdrI7fEII4r9aUUrchSW/x8XfR9BSYSNUu7fP2djxuSk46zAgd4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=42Htqh/B8yYHqHy7lm7p2iUF5HSf6LC0tDXr2vl7emo=;
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


On 2025/4/23 05:12, Jonas Karlman wrote:
> Add a minimal generic RK3576 board that only have eMMC and SDMMC
> enabled. This defconfig can be used to boot from eMMC or SD-card on most
> RK3576 boards that follow reference board design.
>
> eMMC and SD-card boot tested on:
> - ArmSoM Sige5
> - Toybrick TB-RK3576D
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3576-generic-u-boot.dtsi   |  3 ++
>   arch/arm/dts/rk3576-generic.dts           | 45 +++++++++++++++++++++++
>   arch/arm/mach-rockchip/rk3576/MAINTAINERS |  5 +++
>   configs/generic-rk3576_defconfig          | 41 +++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst           |  1 +
>   5 files changed, 95 insertions(+)
>   create mode 100644 arch/arm/dts/rk3576-generic-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3576-generic.dts
>   create mode 100644 arch/arm/mach-rockchip/rk3576/MAINTAINERS
>   create mode 100644 configs/generic-rk3576_defconfig
>
> diff --git a/arch/arm/dts/rk3576-generic-u-boot.dtsi b/arch/arm/dts/rk3576-generic-u-boot.dtsi
> new file mode 100644
> index 000000000000..632fabb6af56
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-generic-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3576-u-boot.dtsi"
> diff --git a/arch/arm/dts/rk3576-generic.dts b/arch/arm/dts/rk3576-generic.dts
> new file mode 100644
> index 000000000000..c4d64307ee99
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-generic.dts
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Minimal generic DT for RK3576 with eMMC and SD-card enabled
> + */
> +
> +/dts-v1/;
> +#include "rk3576.dtsi"
> +
> +/ {
> +	model = "Generic RK3576";
> +	compatible = "rockchip,rk3576";
> +
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:1500000n8";
> +	};
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	no-mmc;
> +	no-sdio;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0m0_xfer>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> new file mode 100644
> index 000000000000..b5190c818468
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> @@ -0,0 +1,5 @@
> +GENERIC-RK3576
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	arch/arm/dts/rk3576-generic*
> +F:	configs/generic-rk3576_defconfig
> diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
> new file mode 100644
> index 000000000000..8a688b775d1c
> --- /dev/null
> +++ b/configs/generic-rk3576_defconfig
> @@ -0,0 +1,41 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rk3576-generic"
> +CONFIG_ROCKCHIP_RK3576=y
> +CONFIG_SYS_LOAD_ADDR=0x40c00800
> +CONFIG_DEBUG_UART_BASE=0x2AD40000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +# CONFIG_BOOTMETH_VBE is not set
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-generic.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_NO_NET=y
> +# CONFIG_ADC is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index b06f87b137cd..69c8fbf3b948 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -134,6 +134,7 @@ List of mainline supported Rockchip boards:
>   
>   * rk3576
>        - Firefly ROC-RK3576-PC (roc-pc-rk3576)
> +     - Generic RK3576 (generic-rk3576)
>   
>   * rk3588
>        - ArmSoM Sige7 (sige7-rk3588)
