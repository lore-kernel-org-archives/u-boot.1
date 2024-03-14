Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31536C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 03:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 633F187D98;
	Thu, 14 Mar 2024 04:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ABkZFJOa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7B987DE3; Thu, 14 Mar 2024 04:28:34 +0100 (CET)
Received: from mail-m32104.qiye.163.com (mail-m32104.qiye.163.com
 [220.197.32.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B2587D42
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 04:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ABkZFJOaGMY0niIzV3EW2V4rEKNeCqv3hmpVDPdEp4WLnONbbpdAMQHG+0R1KYNNPKOXeEg9t2lC55uCalndeUgks2+gzvNwFUCID4We6YIPOlWfJqEMiAq9fupRXdRKFzmGZZO/UZaRuEov05VjJF7jcwjB0SDDd2YJ5MU9vYU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=nb58VDQdfTyMjWRHmpboxrPHmQDzDleNzX3Gb3OoTPE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DEED69001AF;
 Thu, 14 Mar 2024 11:28:23 +0800 (CST)
Message-ID: <18fc5e14-edeb-4eff-afd4-dd8b49783d74@rock-chips.com>
Date: Thu, 14 Mar 2024 11:28:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] rockchip: rk3328-evb: Update defconfig
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217002304.2141064-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUoeQlYYTk4dGRpMTRgaH0NVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e3b00fce103a9kunmdeed69001af
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MT46Tyo5PTMXGihWDTMITzQD
 DC8aFCxVSlVKTEpLSENNQktPQ0tCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSU1ONwY+
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


On 2024/2/17 08:22, Jonas Karlman wrote:
> Update defconfig for rk3328-evb with new defaults.
>
> Add DM_RESET=y to support using reset signals.
>
> Remove the xPL_DRIVERS_MISC=y option, no misc driver is used in xPL.
>
> Add CONFIG_SPL_FIT_SIGNATURE=y to let SPL verify an auto generated hash
> of FIT images. This help indicate if there is an issue loading any of
> the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=y to keep
> support for scripts.
>
> Add CMD_GPIO=y and CMD_REGULATOR=y to add the helpful gpio and regulator
> commands.
>
> Add MISC_INIT_R=y, ROCKCHIP_EFUSE=y and remove NET_RANDOM_ETHADDR=y,
> ethaddr and eth1addr is set based on cpuid read from eFUSE.
>
> Remove pinctrl-0 and pinctrl-names from CONFIG_OF_SPL_REMOVE_PROPS,
> SPL need to configure pinctrl for e.g. SD-card.
>
> Add SPL_DM_SEQ_ALIAS=y option to use alias sequence number in SPL.
>
> Add DM_ETH_PHY=y, PHY_MOTORCOMM=y and PHY_REALTEK=y to support common
> ethernet PHYs.
>
> Remove REGULATOR_PWM=y, the pwm-regulator compatible is not used.
>
> Add RNG_ROCKCHIP=y and DM_RNG=y options to support the onboard random
> generator.
>
> Add SYSINFO=y to support the sysinfo uclass.
>
> Also add missing device tree files to MAINTAINERS and remove the
> obsolete README file.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Add DM_RESET, CMD_GPIO, CMD_REGULATOR, PHY_GIGE and SYSINFO
> - Remove REGULATOR_PWM
> ---
>   board/rockchip/evb_rk3328/MAINTAINERS |  2 +
>   board/rockchip/evb_rk3328/README      | 70 ---------------------------
>   configs/evb-rk3328_defconfig          | 22 ++++++---
>   3 files changed, 18 insertions(+), 76 deletions(-)
>   delete mode 100644 board/rockchip/evb_rk3328/README
>
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
> index 5fc114a63f6c..dc750bd69426 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -4,6 +4,8 @@ S:      Maintained
>   F:      board/rockchip/evb_rk3328
>   F:      include/configs/evb_rk3328.h
>   F:      configs/evb-rk3328_defconfig
> +F:      arch/arm/dts/rk3328-evb.dts
> +F:      arch/arm/dts/rk3328-evb-u-boot.dtsi
>   
>   NANOPI-R2C-RK3328
>   M:      Tianling Shen <cnsztl@gmail.com>
> diff --git a/board/rockchip/evb_rk3328/README b/board/rockchip/evb_rk3328/README
> deleted file mode 100644
> index 6cbb66a4cf87..000000000000
> --- a/board/rockchip/evb_rk3328/README
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -Introduction
> -============
> -
> -RK3328 key features we might use in U-Boot:
> -* CPU: ARMv8 64bit quad-core Cortex-A53
> -* IRAM: 36KB
> -* DRAM: 4GB-16MB dual-channel
> -* eMMC: support eMMC 5.0/5.1, suport HS400, HS200, DDR50
> -* SD/MMC: support SD 3.0, MMC 4.51
> -* USB: USB2.0 EHCI host port *2
> -* Display: RGB/HDMI/DP/MIPI/EDP
> -
> -evb key features:
> -* regulator: pwm regulator for CPU B/L
> -* PMIC: rk808
> -* debug console: UART2
> -
> -In order to support Arm Trust Firmware(ATF), we need to use the
> -miniloader from rockchip which:
> -* do DRAM init
> -* load and verify ATF image
> -* load and verify U-Boot image
> -
> -Here is the step-by-step to boot to U-Boot on rk3328.
> -
> -Get the Source and prebuild binary
> -==================================
> -
> -  > mkdir ~/evb_rk3328
> -  > cd ~/evb_rk3328
> -  > git clone https://github.com/ARM-software/arm-trusted-firmware.git
> -  > git clone https://github.com/rockchip-linux/rkbin
> -  > git clone https://github.com/rockchip-linux/rkflashtool
> -
> -Compile ATF
> -===============
> -
> -  > cd arm-trusted-firmware
> -  > make realclean
> -  > make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3328 bl31
> -
> -Compile U-Boot
> -==================
> -
> -  > cd ../u-boot
> -  > make CROSS_COMPILE=aarch64-linux-gnu- evb-rk3328_defconfig all
> -
> -Compile rkflashtool
> -=======================
> -
> -  > cd ../rkflashtool
> -  > make
> -
> -Package image for miniloader
> -================================
> -  > cd ..
> -  > cp arm-trusted-firmware/build/rk3328/release/bl31.bin rkbin/rk33
> -  > ./rkbin/tools/trust_merger rkbin/tools/RK3328TRUST.ini
> -  > ./rkbin/tools/loaderimage --pack --uboot u-boot/u-boot-dtb.bin uboot.img
> -  > mkdir image
> -  > mv trust.img ./image/
> -  > mv uboot.img ./image/rk3328evb-uboot.bin
> -
> -Flash image
> -===============
> -Power on(or reset with RESET KEY) with MASKROM KEY preesed, and then:
> -
> -  > ./rkflashtool/rkflashloader rk3328evb
> -
> -You should be able to get U-Boot log message in console/UART2 now.
> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
> index b9c541a92a1f..5a5f59c04b3b 100644
> --- a/configs/evb-rk3328_defconfig
> +++ b/configs/evb-rk3328_defconfig
> @@ -9,11 +9,11 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3328-evb"
> +CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_TPL_LIBCOMMON_SUPPORT=y
>   CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_SPL_STACK_R_ADDR=0x4000000
>   CONFIG_SPL_STACK=0x400000
>   CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
> @@ -25,10 +25,13 @@ CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-evb.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> @@ -41,22 +44,23 @@ CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL_SYS_MALLOC_SIMPLE=y
> -CONFIG_TPL_DRIVERS_MISC=y
>   CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_TIME=y
> +CONFIG_CMD_REGULATOR=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_TPL_OF_CONTROL=y
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_TPL_OF_PLATDATA=y
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SYS_MMC_ENV_DEV=1
> -CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_TPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_REGMAP=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_TPL_REGMAP=y
> @@ -70,8 +74,13 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
> +CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_PHY_GIGE=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> @@ -79,17 +88,18 @@ CONFIG_PINCTRL=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_RK8XX=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM=y
>   CONFIG_SPL_RAM=y
>   CONFIG_TPL_RAM=y
> +CONFIG_DM_RNG=y
> +CONFIG_RNG_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
> -CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSINFO=y
>   CONFIG_SYSRESET=y
>   # CONFIG_TPL_SYSRESET is not set
>   CONFIG_USB=y
