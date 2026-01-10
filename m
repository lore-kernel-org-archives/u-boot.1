Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BA5D277C9
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 02:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9AE1843E6;
	Sat, 10 Jan 2026 03:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226A0843FF; Sat, 10 Jan 2026 03:13:32 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F1984390
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 03:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: esmtpgz15t1768011170t5450dd78
X-QQ-Originating-IP: 0zcCNLIX8TF+AZgh2iTFLpjgGV7YnZwj7ze1o0KaL8w=
Received: from [192.168.254.128] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 10 Jan 2026 10:12:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11470428137326414820
Message-ID: <C38F97F213C4095C+10ffcf3a-9d0c-4179-bda5-00fc5b46286e@radxa.com>
Date: Sat, 10 Jan 2026 11:12:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Add support for Radxa E52C
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, heiko@sntech.de,
 christopher.obbard@linaro.org, cnsztl@gmail.com, xuhui.lin@rock-chips.com
References: <20260110011505.36915-1-naoki@radxa.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20260110011505.36915-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MowohnWo6wX73GR66DuZSIVykkEaKcmkwl10FmTBPGqZ2YnO1E7nrWk5
 XSlFx7sWuF/wjuJ3Ot25R8Wmxj4iSZ3/AuXRrmHBgVwHzu+kHSjBLUM1I2QV5McJ6NCB6na
 cEBjwgaA3TTBYq0IAKSSIcWrYIXQNPCdWEZ2yYvjwDL+S9oKVJNlQTXBZYGGf4nF+V+O8l3
 AMF7VHAZ7dMOXPTIZsJQPtYIfkGF9uxnYasP0L0tOM6THu2v5Jn8ZPW63a/pOhRvKYIJUL0
 diUAic8N7d3AfyQIYlyfmB2eEN6Kj5Qv55kir/4bi+00aixyhwDGA1yqaHojqZ5gbKwL1Fs
 76biAfCvU5z7LS3qttRFVr7gbz8wPuJSKo1q9Wbst8OJ7StIpypc0K+VEkK77gTnvhJOz0Q
 uP65XZ4dcqQGyKdMBctRyltYyezdPs0XzR6JNO06gNKKZBTdnfXnNxO4cmlwgKh772tU35O
 umeCTfuwyLEa+8NdYOZUM+m76XpJOfSrKgmLDPQ8RUZDrdzSgG6huRoRJC7ircpO7I7Iowe
 otu6/nUwjKCqM24tOaNA2Q2KbdDFukMKibYaJ3gI1V0DikACzPNK3i5ebYCyHHE/uB+9c2U
 t8RBH0DrlQIzwTTD19o9CX8FHnGmgf4V7R7a3uPeZlkGdFNBhz2S7RZaYEcLX+7ceafVAAR
 4Aj0E/fBEylB6ThJRIMlctZXnUed2BaWtKoSNDUzZAmlVRrgtP1nymM4be4X5zRM1TLWdmy
 vGPbxgopTsFXtrInLtV2iZPvz70hzCZ1BpHjMttrcx6IEIw0RoOSZyCGVY7FfWSKqXAUcND
 WHWdAqIzfIRUY/Kj0eWOxJ6r4MHaN/IwgEn+K1yC87q/ne2048cFZTsOzmlRLr6F1GGTEhT
 IrXpVkZwvOZJPlt+UrSHndztiJpeF0qwyqVzU7gtr2OjGevIWQ02UiyIRCmBHCqByzfiPMC
 sqZ0vShn4NGfaK4HYXPsEXFjH
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
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

Oops...

On 1/10/26 10:15, FUKAUMI Naoki wrote:
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

- 2x 2.5Gigabit Ethernet ports
      ^^^

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> - Maskrom and User buttons
> - Aluminum alloy case
> 
> [1] https://dl.radxa.com/e/e52c/radxa_e52c_product_brief.pdf
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
> ---
> This patch depends on
>   https://patchwork.ozlabs.org/project/uboot/patch/20260107230747.3552391-2-jonas@kwiboo.se/
> ---
>   arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi | 24 +++++++
>   configs/radxa-e52c-rk3582_defconfig        | 77 ++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |  1 +
>   3 files changed, 102 insertions(+)
>   create mode 100644 arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
>   create mode 100644 configs/radxa-e52c-rk3582_defconfig
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
> +	};
> +};
> +
> +&sdhci {
> +	mmc-hs200-1_8v;
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
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_LED=y
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
>        - Khadas Edge2 (khadas-edge2-rk3588s)
>        - MNT Reform2 (mnt-reform2-rk3588)
>        - Pine64 QuartzPro64 (quartzpro64-rk3588)
> +     - Radxa E52C (radxa-e52c-rk3582)
>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
>        - Radxa ROCK 5B/5B+/5T (rock5b-rk3588)


