Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE35C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45B483321;
	Tue,  8 Apr 2025 05:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IRZQXbZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A339B82CE7; Tue,  8 Apr 2025 05:25:10 +0200 (CEST)
Received: from mail-m1973186.qiye.163.com (mail-m1973186.qiye.163.com
 [220.197.31.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 155448333D
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 11022a8b7;
 Tue, 8 Apr 2025 11:25:03 +0800 (GMT+08:00)
Message-ID: <030d320a-a5c5-491b-9645-fc49f380d9af@rock-chips.com>
Date: Tue, 8 Apr 2025 11:25:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/30] board: rockchip: Add Radxa E20C
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-31-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-31-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNOSVZIQ0hKTkMZS0IdSUpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136e13dd03afkunm11022a8b7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MEk6LSo6UTJCA0I#EU0BFh46
 EBcaCVFVSlVKTE9PS0NJTEtPTUhLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSE9PNwY+
DKIM-Signature: a=rsa-sha256;
 b=IRZQXbZEsPPFOwjCjwwKkV79vLvEFYZRvSWkdY3meDhmctRKvjnQyZYtW47B1fdXH4+HT8nNcZ8Is66oyFeLjOCcmlnxW3WCUkX6tDbF4IwqivSjz6zz/A1eSqnuyFMQz7iA1z+3G9lJ3DFguH0p0saTiZg4KS2WNC0XE5OUoQI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=jQ9SzpA7uO8cNpSlVyHWLM7ZG2kffNu76/+AUcC/Ofc=;
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


On 2025/4/8 06:47, Jonas Karlman wrote:
> The Radxa E20C is an ultra-compact network computer with a RK3528A SoC
> that offers a wide range of networking capabilities.
>
> Features tested on a Radxa E20C v1.104:
> - SD-card boot
> - eMMC boot
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - Drop sdhci from board u-boot.dtsi
> - Update sdmmc node to latest mainline Linux patch
> - Enable options for DT nodes added to dts/upstream DT
>
> This also enables options for GMAC, PWM-regulators and USB 2.0. Features
> that have been tested but are currently missing the necessary DT nodes.
> ---
>   arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 12 +++++
>   arch/arm/mach-rockchip/rk3528/MAINTAINERS  |  6 +++
>   configs/radxa-e20c-rk3528_defconfig        | 56 ++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |  1 +
>   4 files changed, 75 insertions(+)
>   create mode 100644 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
>   create mode 100644 configs/radxa-e20c-rk3528_defconfig
>
> diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> new file mode 100644
> index 000000000000..9c2f03a786cf
> --- /dev/null
> +++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3528-u-boot.dtsi"
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	vmmc-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> index cfdc92d770c1..f343f71cf7f6 100644
> --- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> @@ -3,3 +3,9 @@ M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	arch/arm/dts/rk3528-generic*
>   F:	configs/generic-rk3528_defconfig
> +
> +RADXA-E20C
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	arch/arm/dts/rk3528-radxa-e20c*
> +F:	configs/radxa-e20c-rk3528_defconfig
> diff --git a/configs/radxa-e20c-rk3528_defconfig b/configs/radxa-e20c-rk3528_defconfig
> new file mode 100644
> index 000000000000..08f3a13af3b2
> --- /dev/null
> +++ b/configs/radxa-e20c-rk3528_defconfig
> @@ -0,0 +1,56 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-radxa-e20c"
> +CONFIG_ROCKCHIP_RK3528=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFF9F0000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-radxa-e20c.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
> +CONFIG_BUTTON_GPIO=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index c636d33b47c1..f7d4f2a66860 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
>   
>   * rk3528
>        - Generic RK3528 (generic-rk3528)
> +     - Radxa E20C (radxa-e20c-rk3528)
>   
>   * rk3566
>        - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
