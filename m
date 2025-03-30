Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFBFC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 11:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1624B8129B;
	Sun, 30 Mar 2025 13:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Aws2wOV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EBEB8144A; Sun, 30 Mar 2025 13:27:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7857C80FF7
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 13:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743334073;
 bh=0l+nCvlgQW7/0tOOas+g8kXGgrE7GdG1PtCdeP3kfvY=;
 b=Aws2wOV8cn/dUa2fTwq08hDhLjgVBbW9MgMvV6ISpUAckBd0dL7BlDtZeeuqVrafK1pGeMWNn
 guXjsLlD1QjuAFh+HpuckiPeDFP322t9V6g4+NNJeFtnrzuefoz4CbDe1vFIK+Jh4r3fw3pGZes
 i++5WV21T9L3ujR0avf/mGuWIDOqNivj65Zqzvo3CF0lUJ+L32NjQAItT1Bq/honp7UREmPBpbg
 9kY4qexa+lmBS3ZCC7nEWL0TwX2m2izd0XJwYWdnQ0dwymXEfDeuDvuR3ogY+ZuFjesgaVZjq4A
 SC7+O8tmc/hvcksSi85MPiIzl2h2X66OVinzZb/us3Cw==
X-Forward-Email-ID: 67e92ab60286204565e94b0d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <97b55630-1a02-4e0c-9b0a-d90dd867618f@kwiboo.se>
Date: Sun, 30 Mar 2025 13:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add LCKFB TaishanPi RK3566 Board
To: jiehui.he@foxmail.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, trini@konsulko.com, chenjh@rock-chips.com
References: <tencent_95ED0C0545D87B6A8C4B62EC045D53AD2406@qq.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <tencent_95ED0C0545D87B6A8C4B62EC045D53AD2406@qq.com>
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

Hi,

On 2025-03-10 15:00, jiehui.he@foxmail.com wrote:
> From: Jiehui He <jiehui.he@foxmail.com>
> 
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
> This patch adds U-Boot support for the LCKFB TaishanPi RK3566 board.
> It includes:
> - Device tree file for U-Boot
> - Default configuration
> - Documentation update
> - MAINTAINERS update
> 
> Signed-off-by: Jiehui He <jiehui.he@foxmail.com>
> ---
>  arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi | 11 +++
>  board/rockchip/evb_rk3568/MAINTAINERS      |  6 ++
>  configs/lckfb-tspi-rk3566_defconfig        | 84 ++++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst            |  1 +
>  4 files changed, 102 insertions(+)
>  create mode 100644 arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
>  create mode 100644 configs/lckfb-tspi-rk3566_defconfig
> 
> diff --git a/arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi b/arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
> new file mode 100644
> index 00000000..0c8e7018
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
> index b2780401..6cf568ad 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -89,3 +89,9 @@ M:	Maxim Moskalets <maximmosk4@gmail.com>
>  S:	Maintained
>  F:	arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
>  F:	configs/rock-3c-rk3566_defconfig
> +
> +LCKFB-TaishanPi
> +M:	Jiehui He <jiehui.he@foxmail.com>
> +S:	Maintained
> +F:	configs/lckfb-tspi-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
> diff --git a/configs/lckfb-tspi-rk3566_defconfig b/configs/lckfb-tspi-rk3566_defconfig
> new file mode 100644
> index 00000000..126ede37
> --- /dev/null
> +++ b/configs/lckfb-tspi-rk3566_defconfig
> @@ -0,0 +1,84 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y

The SPL control FDT is not including any gpio related nodes, this could
be dropped.

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
> +CONFIG_SPL_POWER=y

The SPL control FDT is not including any power related nodes, this could
be dropped.

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
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y

It does not look like the device tree enable any Ethernet devices, these
two could be dropped.

> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_FAN53555=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y

The SPL control FDT is not including any fixed regulators, these two
could be dropped.

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
> index 1407080f..ae9a8c8a 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -112,6 +112,7 @@ List of mainline supported Rockchip boards:
>       - Radxa ROCK 3C (rock-3c-rk3566)
>       - Radxa ZERO 3W/3E (radxa-zero-3-rk3566)
>       - Xunlong Orange Pi 3B (orangepi-3b-rk3566)
> +     - LCKFB TaishanPi (lckfb-tspi-rk3566)

Please add this line in correct alphabetical order and not at the bottom.

Regards,
Jonas

>  
>  * rk3568
>       - Rockchip Evb-RK3568 (evb-rk3568)

