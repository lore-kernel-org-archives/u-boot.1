Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AEDE7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AEF286AF7;
	Wed, 27 Sep 2023 04:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CCqEdmAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEEEE86C13; Wed, 27 Sep 2023 04:53:44 +0200 (CEST)
Received: from mail-m127214.xmail.ntesmail.com
 (mail-m127214.xmail.ntesmail.com [115.236.127.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D505803AE
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=CCqEdmAbtIjTU+YIw8G8ovA+VE+BSwT8LT+42DMoF1IeClC6V8pemJj89+ZrMdvTD2QZBo6dJL2DxoQjBT0tpLjsE/FxojIWa9826il2Mn9mwJmSIRZ56Ux+rwsrQR4dvxFUWhkCeZryKfXnT/i8jmg1jb11dUEyLpdb/94ujk0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=LXYstgmu3TqxPPOoq4/IgOdSSvoT94ob6tJ2Mz36S2Y=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id DE4A0400311;
 Wed, 27 Sep 2023 10:53:32 +0800 (CST)
Message-ID: <8823bb4c-9758-f472-029f-2f00972aa315@rock-chips.com>
Date: Wed, 27 Sep 2023 10:53:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] rockchip: rk3568-nanopi-r5: Update defconfig for
 NanoPi R5C and R5S
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Tianling Shen <cnsztl@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
References: <20230802194940.2974158-1-jonas@kwiboo.se>
 <20230802194940.2974158-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230802194940.2974158-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0gdSlYdSUtKT0lMGE1ITUNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad48e57e42eb3kusnde4a0400311
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjI6Izo6EDw*GDY5Sig*MQM2
 AxJPCytVSlVKTUJOTENISUpITkJNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDS0lLNwY+
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


On 2023/8/3 03:49, Jonas Karlman wrote:
> Update and sync Kconfig options for NanoPi R5C and NanoPi R5S with other
> RK3568 boards.
>
> SPL_FIT_SIGNATURE is enabled to add a checksum validation of the FIT
> payload, also add LEGACY_IMAGE_FORMAT to keep boot scripts working.
>
> OF_SPL_REMOVE_PROPS, SPL_DM_SEQ_ALIAS and SPL_PINCTRL change ensure
> pinctrl for eMMC, SD-card and UART2 is applied in SPL.
>
> MMC_HS200_SUPPORT and SPL counterpart is enabled to speed up eMMC load
> times from on-board eMMC 5.1 modules.
>
> Drop remaining unused or unsupported options to sync with other RK3568
> boards.
>
> Also sync device tree from linux v6.4 and drop u-boot,spl-boot-order and
> use the default from rk356x-u-boot.dtsi.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> The addition of SPL_FIT_SIGNATURE add an important integrity check that
> slow down boot time by a second or two. Enabled D-cache in SPL make the
> added boot time negligible, see RFC patch [1].
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230702110055.3686457-1-jonas@kwiboo.se/
>
>   arch/arm/dts/rk3568-nanopi-r5c.dts         |  2 +-
>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi |  6 +++++-
>   configs/nanopi-r5c-rk3568_defconfig        | 13 +++++++------
>   configs/nanopi-r5s-rk3568_defconfig        | 13 +++++++------
>   4 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/dts/rk3568-nanopi-r5c.dts b/arch/arm/dts/rk3568-nanopi-r5c.dts
> index f70ca9f0470a..c718b8dbb9c6 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5c.dts
> +++ b/arch/arm/dts/rk3568-nanopi-r5c.dts
> @@ -106,7 +106,7 @@
>   
>   	rockchip-key {
>   		reset_button_pin: reset-button-pin {
> -			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>;
>   		};
>   	};
>   };
> diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> index 0ecca85b2067..094e5af6a757 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> @@ -11,7 +11,6 @@
>   / {
>   	chosen {
>   		stdout-path = &uart2;
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;
>   	};
>   };
>   
> @@ -29,3 +28,8 @@
>   	bootph-all;
>   	status = "okay";
>   };
> +
> +&vcc5v0_usb_host {
> +	/delete-property/ regulator-always-on;
> +	/delete-property/ regulator-boot-on;
> +};
> diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
> index 201b21ad77e3..badac5805ddb 100644
> --- a/configs/nanopi-r5c-rk3568_defconfig
> +++ b/configs/nanopi-r5c-rk3568_defconfig
> @@ -20,7 +20,9 @@ CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-nanopi-r5c.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -43,8 +45,9 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_SPL_DM_WARN=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> @@ -52,19 +55,18 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> -CONFIG_POWER_DOMAIN=y
> +CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_RK8XX=y
> -CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
> @@ -72,7 +74,6 @@ CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
> -CONFIG_SYSRESET_PSCI=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
> diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
> index 67b28430709e..fdcb0c266d83 100644
> --- a/configs/nanopi-r5s-rk3568_defconfig
> +++ b/configs/nanopi-r5s-rk3568_defconfig
> @@ -20,7 +20,9 @@ CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-nanopi-r5s.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -43,8 +45,9 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_SPL_DM_WARN=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> @@ -52,19 +55,18 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> -CONFIG_POWER_DOMAIN=y
> +CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_RK8XX=y
> -CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
> @@ -72,7 +74,6 @@ CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
> -CONFIG_SYSRESET_PSCI=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
