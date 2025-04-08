Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5E6C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDCA833AD;
	Tue,  8 Apr 2025 05:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="b5S0Urfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E66383321; Tue,  8 Apr 2025 05:25:04 +0200 (CEST)
Received: from mail-m21470.qiye.163.com (mail-m21470.qiye.163.com
 [117.135.214.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A8582CE7
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 11022a88e;
 Tue, 8 Apr 2025 11:24:57 +0800 (GMT+08:00)
Message-ID: <918d1cf8-6197-48d8-92d4-b4fb65bd4a54@rock-chips.com>
Date: Tue, 8 Apr 2025 11:24:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/30] board: rockchip: Add minimal generic RK3528 board
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-30-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-30-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhpJHlZKSxpCGB9NHR8aQ05WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136dfcf203afkunm11022a88e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46Kyo4IjJMMUI4L01WFjka
 FBJPFBlVSlVKTE9PS0NJTUJCS0hOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNSUpPNwY+
DKIM-Signature: a=rsa-sha256;
 b=b5S0UrfjO//lqcFIz5uygXhi63Pr4/CCE13FGmYp5IMbNr5YRuCZYTh/Q65gjazcAYRvKnST3ZvOjZDkx1ypRGdDgval4U40srx7xr3/MR8UO1y7hFqAMQbZFLbbQyI73+Dd81h6pSnrqvtxq6U3Av2sEHsSb8CdxB0+WxCpVLI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=M1Kw+qOJZy3Sw8IbsgLDL/WeC6KwbExvG8z1mXd4vUk=;
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
> Add a minimal generic RK3528 board that only have eMMC and SD-card
> enabled. This defconfig can be used to boot from eMMC or SD-card on most
> RK3528 boards that follow reference board design.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - Move sdhci node to main .dts-file
> - Enable meminfo cmd
>
> Tested on:
> - FriendlyElec NanoPi Zero2
> - Radxa ROCK 2A
> - Radxa ROCK 2F
> ---
>   arch/arm/dts/rk3528-generic-u-boot.dtsi   | 12 +++++++
>   arch/arm/dts/rk3528-generic.dts           | 31 ++++++++++++++++++
>   arch/arm/mach-rockchip/rk3528/MAINTAINERS |  5 +++
>   configs/generic-rk3528_defconfig          | 40 +++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst           | 12 +++++++
>   5 files changed, 100 insertions(+)
>   create mode 100644 arch/arm/dts/rk3528-generic-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3528-generic.dts
>   create mode 100644 arch/arm/mach-rockchip/rk3528/MAINTAINERS
>   create mode 100644 configs/generic-rk3528_defconfig
>
> diff --git a/arch/arm/dts/rk3528-generic-u-boot.dtsi b/arch/arm/dts/rk3528-generic-u-boot.dtsi
> new file mode 100644
> index 000000000000..cc830b514567
> --- /dev/null
> +++ b/arch/arm/dts/rk3528-generic-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3528-u-boot.dtsi"
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	no-mmc;
> +	no-sdio;
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528-generic.dts
> new file mode 100644
> index 000000000000..792d3e04a4cb
> --- /dev/null
> +++ b/arch/arm/dts/rk3528-generic.dts
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Minimal generic DT for RK3528 with eMMC enabled
> + */
> +
> +/dts-v1/;
> +#include "rk3528.dtsi"
> +
> +/ {
> +	model = "Generic RK3528";
> +	compatible = "rockchip,rk3528";
> +
> +	chosen {
> +		stdout-path = "serial0:1500000n8";
> +	};
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0m0_xfer>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> new file mode 100644
> index 000000000000..cfdc92d770c1
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> @@ -0,0 +1,5 @@
> +GENERIC-RK3528
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	arch/arm/dts/rk3528-generic*
> +F:	configs/generic-rk3528_defconfig
> diff --git a/configs/generic-rk3528_defconfig b/configs/generic-rk3528_defconfig
> new file mode 100644
> index 000000000000..e19c7bc4801d
> --- /dev/null
> +++ b/configs/generic-rk3528_defconfig
> @@ -0,0 +1,40 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rk3528-generic"
> +CONFIG_ROCKCHIP_RK3528=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFF9F0000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +# CONFIG_BOOTMETH_VBE is not set
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-generic.dtb"
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
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 5a029afae305..c636d33b47c1 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -99,6 +99,9 @@ List of mainline supported Rockchip boards:
>        - Rockchip Evb-RK3399 (evb_rk3399)
>        - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
>   
> +* rk3528
> +     - Generic RK3528 (generic-rk3528)
> +
>   * rk3566
>        - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
>        - FriendlyElec NanoPi R3S (nanopi-r3s-rk3566)
> @@ -260,6 +263,15 @@ To build rk3399 boards:
>           make evb-rk3399_defconfig
>           make CROSS_COMPILE=aarch64-linux-gnu-
>   
> +To build rk3528 boards:
> +
> +.. code-block:: bash
> +
> +        export BL31=../rkbin/bin/rk35/rk3528_bl31_v1.18.elf
> +        export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3528_ddr_1056MHz_v1.10.bin
> +        make generic-rk3528_defconfig
> +        make CROSS_COMPILE=aarch64-linux-gnu-
> +
>   To build rk3568 boards:
>   
>   .. code-block:: bash
