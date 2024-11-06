Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69041D3E78C
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 09:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC5588DB6;
	Wed,  6 Nov 2024 10:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZhDj5cM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BCD88FA8; Wed,  6 Nov 2024 10:47:59 +0100 (CET)
Received: from mail-m25497.xmail.ntesmail.com (mail-m25497.xmail.ntesmail.com
 [103.129.254.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A2388CD9
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 10:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f70ee77;
 Wed, 6 Nov 2024 17:47:52 +0800 (GMT+08:00)
Message-ID: <bb367033-8148-4b15-b41c-be92177350ab@rock-chips.com>
Date: Wed, 6 Nov 2024 17:47:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: rockchip: Add FriendlyElec NanoPi R2S Plus
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Sergey Bostandzhyan
 <jin@mediatomb.cc>, u-boot@lists.denx.de
References: <20241101222135.3220074-1-jonas@kwiboo.se>
 <20241101222135.3220074-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241101222135.3220074-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0lMTVZDHUxJTk5LSkpISEtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300df933303afkunm1f70ee77
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAw6Qgw*KjIpEjFJCw8wCCg2
 MjMwCzhVSlVKTEhLQ0NNT0xITENNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNS0NCNwY+
DKIM-Signature: a=rsa-sha256;
 b=ZhDj5cM0JNkTpehs5g8egxXkogb34NmwdO48Pn86Zw/2LQdsyWKOrnpk8hU9kkqDO3IVRasuYo7qxWlO9SiAkMXJTLbbACyp9+d+DvIGevdM0TLlQ0l31EVYt4b65ZKm4MkQKAwClHmYpWKwqRnW6YpyDrPlyl3RtzcJhTz7YUs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=VXcmCboVYVZ2n9JDyTltapS8/Z1JxZBYYlA4cT5PXFU=;
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


On 2024/11/2 06:21, Jonas Karlman wrote:
> The FriendlyElec NanoPi R2S Plus is a single-board computer based on
> Rockchip RK3328 SoC. It features e.g. 1 GB DDR4 RAM, 32 GB eMMC,
> SD-card, 2x GbE LAN, optional M.2 SDIO Wi-Fi and 2x USB 2.0 host.
>
> Features tested on a NanoPi R2S Plus 2309:
> - SD-card boot
> - eMMC boot
> - Ethernet
> - USB gadget
> - USB host
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../dts/rk3328-nanopi-r2s-plus-u-boot.dtsi    |   3 +
>   board/rockchip/evb_rk3328/MAINTAINERS         |   6 +
>   configs/nanopi-r2s-plus-rk3328_defconfig      | 108 ++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |   1 +
>   4 files changed, 118 insertions(+)
>   create mode 100644 arch/arm/dts/rk3328-nanopi-r2s-plus-u-boot.dtsi
>   create mode 100644 configs/nanopi-r2s-plus-rk3328_defconfig
>
> diff --git a/arch/arm/dts/rk3328-nanopi-r2s-plus-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2s-plus-u-boot.dtsi
> new file mode 100644
> index 000000000000..2ab32cf00a1d
> --- /dev/null
> +++ b/arch/arm/dts/rk3328-nanopi-r2s-plus-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "rk3328-nanopi-r2s-u-boot.dtsi"
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
> index 8f619e54e0e7..5f81be55b8e0 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -28,6 +28,12 @@ F:      configs/nanopi-r2s-rk3328_defconfig
>   F:      arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
>   F:      arch/arm/dts/rk3328-nanopi-r2s.dts
>   
> +NANOPI-R2S-PLUS-RK3328
> +M:      Jonas Karlman <jonas@kwiboo.se>
> +S:      Maintained
> +F:      configs/nanopi-r2s-plus-rk3328_defconfig
> +F:      arch/arm/dts/rk3328-nanopi-r2s-plus-u-boot.dtsi
> +
>   ORANGEPI-R1-PLUS-RK3328
>   M:      Tianling Shen <cnsztl@gmail.com>
>   S:      Maintained
> diff --git a/configs/nanopi-r2s-plus-rk3328_defconfig b/configs/nanopi-r2s-plus-rk3328_defconfig
> new file mode 100644
> index 000000000000..6e6785fcc882
> --- /dev/null
> +++ b/configs/nanopi-r2s-plus-rk3328_defconfig
> @@ -0,0 +1,108 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=20000000
> +CONFIG_ENV_OFFSET=0x3F8000
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-nanopi-r2s-plus"
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_RK3328=y
> +CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_DEBUG_UART_BASE=0xFF130000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2s-plus.dtb"
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
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_TPL_OF_CONTROL=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_TPL_OF_PLATDATA=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=0
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
> +CONFIG_FASTBOOT_BUF_ADDR=0x800800
> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_MOTORCOMM=y
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
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_SPL_DM_REGULATOR_GPIO=y
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
> +CONFIG_SYSRESET=y
> +# CONFIG_TPL_SYSRESET is not set
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_SPL_TINY_MEMSET=y
> +CONFIG_TPL_TINY_MEMSET=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 7b11a2e0a358..ea0ef0983fe3 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -65,6 +65,7 @@ List of mainline supported Rockchip boards:
>        - FriendlyElec NanoPi R2C (nanopi-r2c-rk3328)
>        - FriendlyElec NanoPi R2C Plus (nanopi-r2c-plus-rk3328)
>        - FriendlyElec NanoPi R2S (nanopi-r2s-rk3328)
> +     - FriendlyElec NanoPi R2S Plus (nanopi-r2s-plus-rk3328)
>        - Pine64 Rock64 (rock64-rk3328)
>        - Radxa ROCK Pi E (rock-pi-e-rk3328)
>        - Xunlong Orange Pi R1 Plus (orangepi-r1-plus-rk3328)
