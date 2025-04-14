Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2396AC369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 13:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 709F48006D;
	Mon, 14 Apr 2025 15:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NmOLorHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A32388211F; Mon, 14 Apr 2025 15:50:03 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C09E8003E
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 15:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EDnt9l2702858
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 08:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744638595;
 bh=6Nu7DzM9fsx1gqJEFvHCG5pKcWTymG1Do/nr/yFzh6s=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=NmOLorHDWqE5MFmlq9K67miqCxkcFam2TqSyGuEUKFz076G4rK2H13Md/M2xJFpjT
 V3d17qRn6i/7upkbM0IgNapj2IbfvIO8Z4ASsY6KvjC06/lMyUmrZKlGaV3Xts26wq
 8MafIiyBxeqDY8H9mfp6Q4KZoTeTkpyMmFy3mfng=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EDntkA056094
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 08:49:55 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 08:49:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 08:49:55 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EDnsfD083058;
 Mon, 14 Apr 2025 08:49:54 -0500
Message-ID: <d0ab9e37-66ff-4198-841b-17563412a678@ti.com>
Date: Mon, 14 Apr 2025 08:49:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] configs: am67a_beagley_ai*: Use saveddefconfig
To: Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Neha
 Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, <u-boot@lists.denx.de>
References: <20250411225717.3117370-1-nm@ti.com>
 <20250411225717.3117370-7-nm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250411225717.3117370-7-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 4/11/25 5:57 PM, Nishanth Menon wrote:
> Drop using j722s_evm defconfig since the evm has numerous features that
> we do not need on BeagleY-AI platform. As new peripherals get added to
> EVM support, we end up having to cleanup after in beagle configurations.

It also has many common config items too, here you add ~200 lines, but
in the next patch only remove 30 uneeded. But yes I agree using the
EVM as a base wasn't correct, most of the common config items are
common for all J722s, not the board. What we will want to do is start
moving these common configs to be selected by SOC_K3_J722S. That way
both these board's defconfig files could be much shorter and we don't
end up fixing things for one, but forgetting to fix in the other.

Until then for this patch,

Acked-by: Andrew Davis <afd@ti.com>

> 
> Instead of doing that, just split up BeagleY's configuration
> independently out.
> 
> NOTE: no cleanup has been done to this configuration to allow for
> reproducibility. The cleanups are done in follow on patches
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   configs/am67a_beagley_ai_a53_defconfig | 163 ++++++++++++++++++++-----
>   configs/am67a_beagley_ai_r5_defconfig  | 132 ++++++++++++++++++--
>   2 files changed, 258 insertions(+), 37 deletions(-)
> 
> diff --git a/configs/am67a_beagley_ai_a53_defconfig b/configs/am67a_beagley_ai_a53_defconfig
> index b0903b6ae8f1..295ff1740b78 100644
> --- a/configs/am67a_beagley_ai_a53_defconfig
> +++ b/configs/am67a_beagley_ai_a53_defconfig
> @@ -1,37 +1,144 @@
> -#include <configs/j722s_evm_a53_defconfig>
> -
>   CONFIG_ARM=y
>   CONFIG_ARCH_K3=y
> +CONFIG_SYS_MALLOC_F_LEN=0x8000
> +CONFIG_TI_COMMON_CMD_OPTIONS=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_SOC_K3_J722S=y
>   CONFIG_TARGET_J722S_A53_BEAGLEY_AI=y
> -
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
> +CONFIG_ENV_SIZE=0x40000
> +CONFIG_DM_GPIO=y
> +CONFIG_SPL_DM_SPI=y
>   CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am67a-beagley-ai"
> -CONFIG_SPL_OF_LIST="ti/k3-am67a-beagley-ai"
> -CONFIG_OF_LIST="ti/k3-am67a-beagley-ai"
> -
> -CONFIG_BOOTCOMMAND="run findfdt; run envboot; run distro_bootcmd"
> -CONFIG_EXT4_WRITE=y
> -CONFIG_LZO=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x82000000
> +CONFIG_SPL_TEXT_BASE=0x80080000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x80a00000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_FS_FAT=y
> +CONFIG_SPL_LIBDISK_SUPPORT=y
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> +CONFIG_BOOTSTD_FULL=y
>   CONFIG_AUTOBOOT_KEYED=y
>   CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
>   CONFIG_AUTOBOOT_DELAY_STR="d"
>   CONFIG_AUTOBOOT_STOP_STR=" "
> -CONFIG_TI_I2C_BOARD_DETECT=n
> -CONFIG_SPL_SPI=n
> -CONFIG_SPL_SPI_FLASH_SUPPORT=n
> -CONFIG_SPL_DM_SPI_FLASH=n
> -CONFIG_SPL_MTD_SUPPORT=n
> -CONFIG_SPL_MTD_SUPPORT=n
> -CONFIG_DM_SPI_FLASH=n
> -CONFIG_SPI_FLASH=n
> -CONFIG_MTD=n
> -CONFIG_MTD_PARTITIONS=n
> -CONFIG_DM_MTD=n
> -CONFIG_MTD_UBI=n
> -CONFIG_CMD_UBIFS=n
> -CONFIG_CMD_UBI=n
> -CONFIG_DFU_SF=n
> -CONFIG_DM_SPI=n
> -CONFIG_SPL_SPI_LOAD=n
> -CONFIG_SPL_MTD=n
> -CONFIG_CMD_SPI=n
> +CONFIG_BOOTCOMMAND="run findfdt; run envboot; run distro_bootcmd"
> +CONFIG_BOARD_LATE_INIT=y
> +CONFIG_SPL_MAX_SIZE=0x58000
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_DM_MAILBOX=y
> +CONFIG_SPL_POWER_DOMAIN=y
> +CONFIG_SPL_RAM_DEVICE=y
> +CONFIG_SPL_THERMAL=y
> +CONFIG_SPL_YMODEM_SUPPORT=y
> +CONFIG_CMD_CLK=y
> +# CONFIG_CMD_SPI is not set
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_MULTI_DTB_FIT=y
> +CONFIG_SPL_MULTI_DTB_FIT=y
> +CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_DEVICE_REMOVE=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_CLK_TI_SCI=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
> +CONFIG_DMA_CHANNELS=y
> +CONFIG_TI_K3_NAVSS_UDMA=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0xC0000000
> +CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
> +CONFIG_TI_SCI_PROTOCOL=y
> +CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
> +CONFIG_DA8XX_GPIO=y
> +CONFIG_DM_PCA953X=y
> +CONFIG_SPL_DM_PCA953X=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_OMAP24XX=y
> +CONFIG_DM_MAILBOX=y
> +CONFIG_K3_SEC_PROXY=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_SPL_I2C_EEPROM=y
> +CONFIG_FS_LOADER=y
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_SPL_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_SPL_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_AM654=y
> +CONFIG_PHY_TI_DP83867=y
> +CONFIG_TI_AM65_CPSW_NUSS=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PINCTRL_SINGLE=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_TI_SCI_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_SPL_DM_REGULATOR_GPIO=y
> +CONFIG_K3_SYSTEM_CONTROLLER=y
> +CONFIG_RESET_TI_SCI=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SOC_DEVICE=y
> +CONFIG_SOC_DEVICE_TI_K3=y
> +CONFIG_SOC_TI=y
> +CONFIG_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SPL_SYSRESET=y
> +CONFIG_SYSRESET_TI_SCI=y
> +CONFIG_DM_THERMAL=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_SPL_USB_HOST=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_AM62=y
> +CONFIG_USB_DWC3_AM62=y
> +CONFIG_SPL_USB_STORAGE=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
> +CONFIG_SPL_DFU=y
> +CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> +CONFIG_LZO=y
> diff --git a/configs/am67a_beagley_ai_r5_defconfig b/configs/am67a_beagley_ai_r5_defconfig
> index 5380747fe3ca..35c77e57e104 100644
> --- a/configs/am67a_beagley_ai_r5_defconfig
> +++ b/configs/am67a_beagley_ai_r5_defconfig
> @@ -1,14 +1,128 @@
> -#include <configs/j722s_evm_r5_defconfig>
> -
>   CONFIG_ARM=y
>   CONFIG_ARCH_K3=y
> +CONFIG_SYS_MALLOC_F_LEN=0x9000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_SOC_K3_J722S=y
> +CONFIG_K3_QOS=y
>   CONFIG_TARGET_J722S_R5_BEAGLEY_AI=y
> -
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c4a7f0
> +CONFIG_SF_DEFAULT_SPEED=25000000
> +CONFIG_SF_DEFAULT_MODE=0
> +CONFIG_ENV_SIZE=0x20000
> +CONFIG_ENV_OFFSET=0x680000
> +CONFIG_SPL_DM_SPI=y
>   CONFIG_DEFAULT_DEVICE_TREE="k3-am67a-r5-beagley-ai"
> -CONFIG_SPL_OF_LIST="k3-am67a-r5-beagley-ai"
> -CONFIG_OF_LIST="k3-am67a-r5-beagley-ai"
> -
> -CONFIG_TI_I2C_BOARD_DETECT=n
> -CONFIG_SPL_DM_SPI_FLASH=n
> -CONFIG_SPL_MTD_SUPPORT=n
> +CONFIG_DM_RESET=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK_R_ADDR=0x82000000
> +CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
> +CONFIG_SPL_TEXT_BASE=0x43c00000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x43c7b000
> +CONFIG_SPL_BSS_MAX_SIZE=0x3000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_SIZE_LIMIT=0x3C000
> +CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x5000
> +CONFIG_SPL_FS_FAT=y
> +CONFIG_SPL_LIBDISK_SUPPORT=y
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
> +CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
> +CONFIG_SPL_MAX_SIZE=0x6ce00
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +CONFIG_SPL_SEPARATE_BSS=y
> +CONFIG_SPL_EARLY_BSS=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_DM_MAILBOX=y
> +CONFIG_SPL_DM_RESET=y
> +CONFIG_SPL_POWER_DOMAIN=y
> +CONFIG_SPL_RAM_DEVICE=y
> +# CONFIG_SPL_SPI_FLASH_TINY is not set
> +CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
> +CONFIG_SPL_THERMAL=y
> +CONFIG_SPL_YMODEM_SUPPORT=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_ASKENV=y
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_FAT=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_ENV_IS_NOWHERE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_PART=1
> +CONFIG_NO_NET=y
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_DEVICE_REMOVE=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_SPL_CLK_CCF=y
> +CONFIG_SPL_CLK_K3_PLL=y
> +CONFIG_SPL_CLK_K3=y
> +CONFIG_DMA_CHANNELS=y
> +CONFIG_TI_K3_NAVSS_UDMA=y
> +CONFIG_TI_SCI_PROTOCOL=y
> +# CONFIG_GPIO is not set
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_OMAP24XX=y
> +CONFIG_DM_MAILBOX=y
> +CONFIG_K3_SEC_PROXY=y
> +CONFIG_ESM_K3=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_SPL_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_AM654=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_SPI_NAND=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SOFT_RESET=y
> +CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_PINCTRL=y
> +# CONFIG_PINCTRL_GENERIC is not set
> +CONFIG_SPL_PINCTRL=y
> +# CONFIG_SPL_PINCTRL_GENERIC is not set
> +CONFIG_PINCTRL_SINGLE=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_TI_POWER_DOMAIN=y
> +CONFIG_K3_SYSTEM_CONTROLLER=y
> +CONFIG_RESET_TI_SCI=y
> +CONFIG_SPECIFY_CONSOLE_INDEX=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SOC_DEVICE=y
> +CONFIG_SOC_DEVICE_TI_K3=y
> +CONFIG_SOC_TI=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_CADENCE_QSPI=y
> +CONFIG_TIMER=y
> +CONFIG_SPL_TIMER=y
> +CONFIG_OMAP_TIMER=y
> +CONFIG_LIB_RATIONAL=y
> +CONFIG_SPL_LIB_RATIONAL=y
