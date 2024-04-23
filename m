Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68492C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9EBE885B1;
	Tue, 23 Apr 2024 13:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="im74Lj9C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA19885AD; Tue, 23 Apr 2024 13:11:49 +0200 (CEST)
Received: from mail-m15591.qiye.163.com (mail-m15591.qiye.163.com
 [101.71.155.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507DE884F0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=im74Lj9C24xDk/Jkr8HSOtq192HPTATTbgL9f7lq+k6my3lVASmh3wmzABu+YsKc4eg7zjWfrI7ORtuYz+WRkzs+DrHuU755blnSRFI4JxOuVrLfFWm78MWVuoccDL0+yVXedNyY9GL2gk6h6Q9ReLJFazy/tx/ChG6yptW9bA8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=+sDAN9Ewraft8+Fdwk04bg3ChTWQaIMmNQBDNPdo50M=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E05F990031F;
 Tue, 23 Apr 2024 19:11:30 +0800 (CST)
Message-ID: <f8bddfa0-6138-4419-877f-f155d512f7f0@rock-chips.com>
Date: Tue, 23 Apr 2024 19:11:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/31] rockchip: rk3399-orangepi: Sync device tree from
 linux v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-24-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-24-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkxDGlYdHUJCThpDQxpMTxlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f0aa75c7603a9kunme05f990031f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ok06Szo*DDNWKj1WAjISHj8Z
 LxxPCUNVSlVKTEpIQ0xLTUJKQ09OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTEJONwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> Sync rk3399-orangepi device tree from linux v6.8.
>
> Add DM_RESET=y to support reset signals.
>
> Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.
>
> Add ROCKCHIP_IODOMAIN=y to configure io-domain voltage.
>
> Add MMC_SDHCI_SDMA=y to use DMA transfer for eMMC.
>
> Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.
>
> Add PHY_ROCKCHIP_INNO_USB2=y and PHY_ROCKCHIP_TYPEC=y to support USB PHY.
>
> Remove SPL_TINY_MEMSET=y to use full memset in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-orangepi.dts  | 12 +++++++-----
>   configs/orangepi-rk3399_defconfig | 10 ++++++++--
>   2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-orangepi.dts b/arch/arm/dts/rk3399-orangepi.dts
> index 04b54abea3cc..e7551449e718 100644
> --- a/arch/arm/dts/rk3399-orangepi.dts
> +++ b/arch/arm/dts/rk3399-orangepi.dts
> @@ -7,6 +7,7 @@
>   
>   #include "dt-bindings/pwm/pwm.h"
>   #include "dt-bindings/input/input.h"
> +#include <dt-bindings/interrupt-controller/irq.h>
>   #include "dt-bindings/usb/pd.h"
>   #include "rk3399.dtsi"
>   #include "rk3399-opp.dtsi"
> @@ -16,6 +17,7 @@
>   	compatible = "rockchip,rk3399-orangepi", "rockchip,rk3399";
>   
>   	aliases {
> +		ethernet0 = &gmac;
>   		mmc0 = &sdio0;
>   		mmc1 = &sdmmc;
>   		mmc2 = &sdhci;
> @@ -51,13 +53,13 @@
>   			press-threshold-microvolt = <300000>;
>   		};
>   
> -		back {
> +		button-back {
>   			label = "Back";
>   			linux,code = <KEY_BACK>;
>   			press-threshold-microvolt = <985000>;
>   		};
>   
> -		menu {
> +		button-menu {
>   			label = "Menu";
>   			linux,code = <KEY_MENU>;
>   			press-threshold-microvolt = <1314000>;
> @@ -77,7 +79,7 @@
>   		compatible = "gpio-keys";
>   		autorepeat;
>   
> -		power {
> +		key-power {
>   			debounce-interval = <100>;
>   			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
>   			label = "GPIO Power";
> @@ -166,12 +168,12 @@
>   	vdd_log: vdd-log {
>   		compatible = "pwm-regulator";
>   		pwms = <&pwm2 0 25000 1>;
> +		pwm-supply = <&vcc_sys>;
>   		regulator-name = "vdd_log";
>   		regulator-always-on;
>   		regulator-boot-on;
>   		regulator-min-microvolt = <800000>;
>   		regulator-max-microvolt = <1400000>;
> -		vin-supply = <&vcc_sys>;
>   	};
>   };
>   
> @@ -735,7 +737,7 @@
>   		reg = <1>;
>   		compatible = "brcm,bcm4329-fmac";
>   		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-names = "host-wake";
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&wifi_host_wake_l>;
> diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
> index 703732ad15f0..2d0c9b77e584 100644
> --- a/configs/orangepi-rk3399_defconfig
> +++ b/configs/orangepi-rk3399_defconfig
> @@ -6,6 +6,7 @@ CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-orangepi"
> +CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
> @@ -14,7 +15,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-orangepi.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> @@ -31,12 +32,18 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_SPL_DM_REGULATOR_FIXED=y
> @@ -58,5 +65,4 @@ CONFIG_USB_ETHER_ASIX88179=y
>   CONFIG_USB_ETHER_MCS7830=y
>   CONFIG_USB_ETHER_RTL8152=y
>   CONFIG_USB_ETHER_SMSC95XX=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
