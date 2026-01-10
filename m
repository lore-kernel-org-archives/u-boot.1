Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2980D25023
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 20:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC06C83C0C;
	Sat, 10 Jan 2026 21:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mTFfMaR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E6E283C0E; Sat, 10 Jan 2026 21:34:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E3DD83B07
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 21:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6292=7Q=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1768077262;
 bh=+Vj+HnXCQjrW3ZWpqC/zAwMcaBtr8cL2aopVYxCXPeU=;
 b=mTFfMaR449hRhxplsMqSUn0xzAg6V0Q+xxY6NsDlaqfF8O1KwKojRm/vntQFv20avK0HLwcM6
 TsrlAtOOiySmA7zg0DRlFGbcDVWimn5sRdJucAYTsPXm6XsAC5RP384be90eMU/Ti2gAdqNwB5L
 PvWzjArp56jDhaSXxt1BLw4jDEFLfWyremNbIw1bi6WaW5GWWpTnALEf0gmctDvZQD+0sfp1SKc
 nd1AW6NzssriaUFZJIeUtf/JQEZkWGTqKSvsB/m8VL8Az6E1ueUfnsYtFjpZflC5jpRfdI/MPvp
 DkfA78HbWXOVXlCtsFiDwIEeHLxvYvpl6OGYhfHUoGIw==
X-Forward-Email-ID: 6962b7c0729b84f3047b8d39
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <61f99cff-fd7e-433b-9a9d-35e29e927607@kwiboo.se>
Date: Sat, 10 Jan 2026 21:34:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Add support for Radxa E52C
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, heiko@sntech.de, christopher.obbard@linaro.org,
 cnsztl@gmail.com, xuhui.lin@rock-chips.com, u-boot@lists.denx.de
References: <20260110011505.36915-1-naoki@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260110011505.36915-1-naoki@radxa.com>
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

Hi Naoki,

On 1/10/2026 2:15 AM, FUKAUMI Naoki wrote:
> The Radxa E52C is a compact network computer developed by Radxa, based
> on the Rockchip RK3582 SoC. [1]
> 
> Specification:
> - Dual Cortex-A76 and Quad Cortex-A55 cores
> - 5TOPS NPU
> - Up to 8GB LPDDR4x RAM
> - Up to 64GB eMMC
> - microSD card slot
> - USB 3.0 Type-A OTG port
> - USB Type-C debug port (USB-UART)
> - USB Type-C power port (5V)
> - 2x Gigabit Ethernet ports
> - Maskrom and User buttons
> - Aluminum alloy case
> 
> [1] https://dl.radxa.com/e/e52c/radxa_e52c_product_brief.pdf
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> This patch depends on
>  https://patchwork.ozlabs.org/project/uboot/patch/20260107230747.3552391-2-jonas@kwiboo.se/
> ---
>  arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi | 24 +++++++
>  configs/radxa-e52c-rk3582_defconfig        | 77 ++++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst            |  1 +
>  3 files changed, 102 insertions(+)
>  create mode 100644 arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
>  create mode 100644 configs/radxa-e52c-rk3582_defconfig
> 
> diff --git a/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi b/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
> new file mode 100644
> index 00000000000..dd65cdd250f
> --- /dev/null
> +++ b/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2026 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +/ {
> +	leds-0 {
> +		led-1 {
> +			default-state = "on";
> +			gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-2 {
> +			default-state = "on";
> +			gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_LOW>;
> +		};

These leds do not exist in the upstream DT, why are they needed here?

Please drop these and possible also enable the LED_PWM Kconfig option.

> +	};
> +};
> +
> +&sdhci {
> +	mmc-hs200-1_8v;

This can be dropped, the upstream DT already define mmc-hs400-1_8v.

> +};
> diff --git a/configs/radxa-e52c-rk3582_defconfig b/configs/radxa-e52c-rk3582_defconfig
> new file mode 100644
> index 00000000000..5c1056867f2
> --- /dev/null
> +++ b/configs/radxa-e52c-rk3582_defconfig
> @@ -0,0 +1,77 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3582-radxa-e52c"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3582-radxa-e52c.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y

Suggest you add following here:

  CONFIG_CMD_ADC=y

> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +# CONFIG_ADC is not set

Please enable ADC to allow use of e.g. adc buttons.

Also suggest you add following here:

  CONFIG_BUTTON=y
  CONFIG_BUTTON_ADC=y
  CONFIG_BUTTON_GPIO=y

> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_LED=y

Suggest you add following here:

  CONFIG_LED_PWM=y

> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHYLIB=y
> +CONFIG_RTL8169=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y

Suggest you add following here:

  CONFIG_PWM_ROCKCHIP=y

With above fixed this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 7a8532b49fc..2fd7d687d2e 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -160,6 +160,7 @@ List of mainline supported Rockchip boards:
>       - Khadas Edge2 (khadas-edge2-rk3588s)
>       - MNT Reform2 (mnt-reform2-rk3588)
>       - Pine64 QuartzPro64 (quartzpro64-rk3588)
> +     - Radxa E52C (radxa-e52c-rk3582)
>       - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>       - Radxa ROCK 5A (rock5a-rk3588s)
>       - Radxa ROCK 5B/5B+/5T (rock5b-rk3588)

