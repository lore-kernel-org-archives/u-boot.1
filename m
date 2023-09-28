Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAADCE7B08
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 07:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0364586844;
	Thu, 28 Sep 2023 09:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fvc6luaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D2B986A26; Thu, 28 Sep 2023 09:54:43 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A1286784
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 09:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S7sb6w122686;
 Thu, 28 Sep 2023 02:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695887677;
 bh=mhOS6VQjo81BeADWqHbxgo4HYDIpD7HsCGJVMrfk8Gk=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=fvc6luaw6uf0B7UxWc6qDEe7tQ/aYCS5ZgpOEQKeHGmChtdBnT7khzigAZXxNqk1z
 37Ewn97bnbEKVUo8QspLpI5WSGhKwKXeAkBnMMOYWLRpwOK0RK/3KdMAJics7/+Tbh
 aP/eDj3blEd94JbtgkdZ/GaKWpdAV/se4PM7CR0c=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S7sbfO076482
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Sep 2023 02:54:37 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 02:54:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 02:54:36 -0500
Received: from [10.24.68.216] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S7sYFj034199;
 Thu, 28 Sep 2023 02:54:35 -0500
Message-ID: <b420800e-1584-75ca-7375-5e44cdbce8ce@ti.com>
Date: Thu, 28 Sep 2023 13:24:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] configs: am65x: Merge the HS and non-HS defconfigs
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
References: <20230803145441.315515-1-afd@ti.com>
 <20230804050511.maw7b63rjafucrnh@ula0497581>
Content-Language: en-US
In-Reply-To: <20230804050511.maw7b63rjafucrnh@ula0497581>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Andrew,

On 04/08/23 10:35, Manorit Chawdhry wrote:
> Hi Andrew,
>
> On 09:54-20230803, Andrew Davis wrote:
>> K3 devices have runtime type board detection. Make the default defconfig
>> include the secure configuration. Then remove the HS specific config.
>>
>> Non-HS devices will continue to boot due to runtime device type detection.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>  MAINTAINERS                           |   2 -
>>  configs/am65x_evm_a53_defconfig       |   3 +-
>>  configs/am65x_evm_r5_defconfig        |   1 +
>>  configs/am65x_evm_r5_usbdfu_defconfig |   1 +
>>  configs/am65x_evm_r5_usbmsc_defconfig |   1 +
>>  configs/am65x_hs_evm_a53_defconfig    | 158 --------------------------
>>  configs/am65x_hs_evm_r5_defconfig     | 135 ----------------------
>>  7 files changed, 5 insertions(+), 296 deletions(-)
>>  delete mode 100644 configs/am65x_hs_evm_a53_defconfig
>>  delete mode 100644 configs/am65x_hs_evm_r5_defconfig
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 47581cf6fbb..d3b9f4cc6c4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1506,8 +1506,6 @@ F:	configs/k2hk_hs_evm_defconfig
>>  F:	configs/k2e_hs_evm_defconfig
>>  F:	configs/k2g_hs_evm_defconfig
>>  F:	configs/k2l_hs_evm_defconfig
>> -F:	configs/am65x_hs_evm_r5_defconfig
>> -F:	configs/am65x_hs_evm_a53_defconfig
> While merging these defconfigs for other boards I had faced an issue
> where the multi DTB detection wasn't working for HS devices and we were
> hitting a firewall exception while trying to access the EEPROM
> Scratchpad before the firewalls were opened. I see that AM65x still uses
> the old Scratchpad address in the Kconfig which had triggered exceptions
> for other K3 devices.
>
> config SYS_K3_MCU_SCRATCHPAD_BASE
> 	hex
> 	default 0x40280000 if SOC_K3_AM654
> 	default 0x41cff9fc if SOC_K3_J721S2
> 	default 0x41cff9fc if SOC_K3_J721E
>
> Can you double check if this also needs a change along with the merged
> defconfigs?
>
> Regards,
> Manorit

I just noticed that the multi fit configs were already enabled in HS defconfig
before the merge
so ig merging the configs shouldn't bring the problem I was suspecting.

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

>>  
>>  TPM DRIVERS
>>  M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
>> index 4301553af8d..55c1b23c8db 100644
>> --- a/configs/am65x_evm_a53_defconfig
>> +++ b/configs/am65x_evm_a53_defconfig
>> @@ -1,6 +1,7 @@
>>  CONFIG_ARM=y
>>  CONFIG_SKIP_LOWLEVEL_INIT=y
>>  CONFIG_ARCH_K3=y
>> +CONFIG_TI_SECURE_DEVICE=y
>>  CONFIG_SYS_MALLOC_LEN=0x2000000
>>  CONFIG_SYS_MALLOC_F_LEN=0x8000
>>  CONFIG_SPL_LIBCOMMON_SUPPORT=y
>> @@ -34,7 +35,7 @@ CONFIG_SPL_LOAD_FIT=y
>>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
>>  CONFIG_OF_SYSTEM_SETUP=y
>>  CONFIG_DISTRO_DEFAULTS=y
>> -CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd; run init_${boot}; run boot_rprocs; run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern"
>> +CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd; run init_${boot}; run boot_rprocs; if test ${boot_fit} -eq 1; then run get_fit_${boot}; run get_overlaystring; run run_fit; else; run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern; fi;"
>>  CONFIG_LOGLEVEL=7
>>  CONFIG_CONSOLE_MUX=y
>>  CONFIG_SPL_MAX_SIZE=0x58000
>> diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
>> index d5196c2024e..b9b69b921be 100644
>> --- a/configs/am65x_evm_r5_defconfig
>> +++ b/configs/am65x_evm_r5_defconfig
>> @@ -1,5 +1,6 @@
>>  CONFIG_ARM=y
>>  CONFIG_ARCH_K3=y
>> +CONFIG_TI_SECURE_DEVICE=y
>>  CONFIG_SYS_MALLOC_LEN=0x2000000
>>  CONFIG_SYS_MALLOC_F_LEN=0x55000
>>  CONFIG_SPL_GPIO=y
>> diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
>> index 88f68aa70e4..fb93024bda9 100644
>> --- a/configs/am65x_evm_r5_usbdfu_defconfig
>> +++ b/configs/am65x_evm_r5_usbdfu_defconfig
>> @@ -1,5 +1,6 @@
>>  CONFIG_ARM=y
>>  CONFIG_ARCH_K3=y
>> +CONFIG_TI_SECURE_DEVICE=y
>>  CONFIG_SYS_MALLOC_LEN=0x2000000
>>  CONFIG_SYS_MALLOC_F_LEN=0x55000
>>  CONFIG_SPL_GPIO=y
>> diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
>> index 8da49c78c82..931b756ab52 100644
>> --- a/configs/am65x_evm_r5_usbmsc_defconfig
>> +++ b/configs/am65x_evm_r5_usbmsc_defconfig
>> @@ -1,5 +1,6 @@
>>  CONFIG_ARM=y
>>  CONFIG_ARCH_K3=y
>> +CONFIG_TI_SECURE_DEVICE=y
>>  CONFIG_SYS_MALLOC_LEN=0x2000000
>>  CONFIG_SYS_MALLOC_F_LEN=0x55000
>>  CONFIG_SPL_GPIO=y
>> diff --git a/configs/am65x_hs_evm_a53_defconfig b/configs/am65x_hs_evm_a53_defconfig
>> deleted file mode 100644
>> index 3f9626e4550..00000000000
>> --- a/configs/am65x_hs_evm_a53_defconfig
>> +++ /dev/null
>> @@ -1,158 +0,0 @@
>> -CONFIG_ARM=y
>> -CONFIG_SKIP_LOWLEVEL_INIT=y
>> -CONFIG_ARCH_K3=y
>> -CONFIG_TI_SECURE_DEVICE=y
>> -CONFIG_SYS_MALLOC_LEN=0x2000000
>> -CONFIG_SYS_MALLOC_F_LEN=0x8000
>> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
>> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> -CONFIG_NR_DRAM_BANKS=2
>> -CONFIG_SOC_K3_AM654=y
>> -CONFIG_TARGET_AM654_A53_EVM=y
>> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
>> -CONFIG_ENV_SIZE=0x20000
>> -CONFIG_ENV_OFFSET=0x680000
>> -CONFIG_DM_GPIO=y
>> -CONFIG_SPL_DM_SPI=y
>> -CONFIG_DEFAULT_DEVICE_TREE="k3-am654-base-board"
>> -CONFIG_SPL_TEXT_BASE=0x80080000
>> -CONFIG_OF_LIBFDT_OVERLAY=y
>> -CONFIG_DM_RESET=y
>> -CONFIG_SPL_MMC=y
>> -CONFIG_SPL_SERIAL=y
>> -CONFIG_SPL_DRIVERS_MISC=y
>> -CONFIG_SPL_STACK_R_ADDR=0x82000000
>> -CONFIG_ENV_OFFSET_REDUND=0x6A0000
>> -CONFIG_SPL_FS_FAT=y
>> -CONFIG_SPL_LIBDISK_SUPPORT=y
>> -CONFIG_SPL_SPI_FLASH_SUPPORT=y
>> -CONFIG_SPL_SPI=y
>> -# CONFIG_PSCI_RESET is not set
>> -CONFIG_PCI=y
>> -# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>> -CONFIG_SPL_LOAD_FIT=y
>> -CONFIG_OF_SYSTEM_SETUP=y
>> -CONFIG_DISTRO_DEFAULTS=y
>> -CONFIG_BOOTCOMMAND="run findfdt; run envboot; run init_${boot}; run get_fit_${boot}; run get_overlaystring; run run_fit"
>> -CONFIG_LOGLEVEL=7
>> -CONFIG_CONSOLE_MUX=y
>> -CONFIG_SPL_MAX_SIZE=0x58000
>> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> -CONFIG_SPL_BSS_START_ADDR=0x80a00000
>> -CONFIG_SPL_BSS_MAX_SIZE=0x80000
>> -CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>> -CONFIG_SPL_STACK_R=y
>> -CONFIG_SYS_SPL_MALLOC=y
>> -CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
>> -CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>> -CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
>> -CONFIG_SPL_DMA=y
>> -CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
>> -CONFIG_SPL_I2C=y
>> -CONFIG_SPL_DM_MAILBOX=y
>> -CONFIG_SPL_MTD_SUPPORT=y
>> -CONFIG_SPL_DM_SPI_FLASH=y
>> -CONFIG_SPL_DM_RESET=y
>> -CONFIG_SPL_POWER_DOMAIN=y
>> -# CONFIG_SPL_SPI_FLASH_TINY is not set
>> -CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
>> -CONFIG_SPL_SPI_LOAD=y
>> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
>> -CONFIG_SPL_YMODEM_SUPPORT=y
>> -CONFIG_SYS_MAXARGS=64
>> -CONFIG_CMD_ASKENV=y
>> -CONFIG_CMD_DFU=y
>> -CONFIG_CMD_GPT=y
>> -CONFIG_CMD_I2C=y
>> -CONFIG_CMD_MMC=y
>> -CONFIG_CMD_PCI=y
>> -CONFIG_CMD_REMOTEPROC=y
>> -CONFIG_CMD_USB=y
>> -CONFIG_CMD_TIME=y
>> -CONFIG_MTDIDS_DEFAULT="nor0=47040000.spi.0"
>> -CONFIG_MTDPARTS_DEFAULT="mtdparts=47040000.spi.0:512k(ospi.tiboot3),2m(ospi.tispl),4m(ospi.u-boot),128k(ospi.env),128k(ospi.env.backup),1m(ospi.sysfw),-@8m(ospi.rootfs)"
>> -CONFIG_CMD_UBI=y
>> -# CONFIG_ISO_PARTITION is not set
>> -CONFIG_OF_CONTROL=y
>> -CONFIG_SPL_OF_CONTROL=y
>> -CONFIG_SPL_MULTI_DTB_FIT=y
>> -CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
>> -CONFIG_ENV_OVERWRITE=y
>> -CONFIG_ENV_IS_IN_MMC=y
>> -CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>> -CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> -CONFIG_SYS_MMC_ENV_PART=1
>> -CONFIG_NET_RANDOM_ETHADDR=y
>> -CONFIG_SPL_DM=y
>> -CONFIG_SPL_DM_SEQ_ALIAS=y
>> -CONFIG_SPL_REGMAP=y
>> -CONFIG_SPL_OF_TRANSLATE=y
>> -CONFIG_CLK=y
>> -CONFIG_SPL_CLK=y
>> -CONFIG_CLK_TI_SCI=y
>> -CONFIG_DFU_MMC=y
>> -CONFIG_DFU_RAM=y
>> -CONFIG_DFU_SF=y
>> -CONFIG_SYS_DFU_DATA_BUF_SIZE=0x20000
>> -CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
>> -CONFIG_DMA_CHANNELS=y
>> -CONFIG_TI_K3_NAVSS_UDMA=y
>> -CONFIG_TI_SCI_PROTOCOL=y
>> -CONFIG_DM_PCA953X=y
>> -CONFIG_DM_I2C=y
>> -CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
>> -CONFIG_SYS_I2C_OMAP24XX=y
>> -CONFIG_DM_MAILBOX=y
>> -CONFIG_K3_SEC_PROXY=y
>> -CONFIG_MMC_SDHCI=y
>> -CONFIG_MMC_SDHCI_ADMA=y
>> -CONFIG_SPL_MMC_SDHCI_ADMA=y
>> -CONFIG_MMC_SDHCI_AM654=y
>> -CONFIG_MTD=y
>> -CONFIG_DM_MTD=y
>> -CONFIG_DM_SPI_FLASH=y
>> -CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>> -CONFIG_SPI_FLASH_STMICRO=y
>> -# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>> -CONFIG_SPI_FLASH_MTD=y
>> -CONFIG_PHY_TI_DP83867=y
>> -CONFIG_PHY_FIXED=y
>> -CONFIG_E1000=y
>> -CONFIG_CMD_E1000=y
>> -CONFIG_TI_AM65_CPSW_NUSS=y
>> -CONFIG_PCI_KEYSTONE=y
>> -CONFIG_PHY=y
>> -CONFIG_AM654_PHY=y
>> -CONFIG_OMAP_USB2_PHY=y
>> -CONFIG_PINCTRL=y
>> -# CONFIG_PINCTRL_GENERIC is not set
>> -CONFIG_SPL_PINCTRL=y
>> -# CONFIG_SPL_PINCTRL_GENERIC is not set
>> -CONFIG_PINCTRL_SINGLE=y
>> -CONFIG_POWER_DOMAIN=y
>> -CONFIG_TI_SCI_POWER_DOMAIN=y
>> -CONFIG_REMOTEPROC_TI_K3_R5F=y
>> -CONFIG_RESET_TI_SCI=y
>> -CONFIG_DM_SERIAL=y
>> -CONFIG_SOC_DEVICE=y
>> -CONFIG_SOC_DEVICE_TI_K3=y
>> -CONFIG_SOC_TI=y
>> -CONFIG_SPI=y
>> -CONFIG_DM_SPI=y
>> -CONFIG_CADENCE_QSPI=y
>> -CONFIG_SYSRESET=y
>> -CONFIG_SPL_SYSRESET=y
>> -CONFIG_SYSRESET_TI_SCI=y
>> -CONFIG_USB=y
>> -CONFIG_DM_USB_GADGET=y
>> -CONFIG_USB_XHCI_HCD=y
>> -CONFIG_USB_XHCI_DWC3=y
>> -CONFIG_USB_DWC3=y
>> -CONFIG_USB_DWC3_GENERIC=y
>> -CONFIG_USB_KEYBOARD=y
>> -CONFIG_USB_GADGET=y
>> -CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
>> -CONFIG_USB_GADGET_VENDOR_NUM=0x0451
>> -CONFIG_USB_GADGET_PRODUCT_NUM=0x6162
>> -CONFIG_USB_GADGET_DOWNLOAD=y
>> diff --git a/configs/am65x_hs_evm_r5_defconfig b/configs/am65x_hs_evm_r5_defconfig
>> deleted file mode 100644
>> index 0c7b53ca2c0..00000000000
>> --- a/configs/am65x_hs_evm_r5_defconfig
>> +++ /dev/null
>> @@ -1,135 +0,0 @@
>> -CONFIG_ARM=y
>> -CONFIG_ARCH_K3=y
>> -CONFIG_TI_SECURE_DEVICE=y
>> -CONFIG_SYS_MALLOC_LEN=0x2000000
>> -CONFIG_SYS_MALLOC_F_LEN=0x55000
>> -CONFIG_SPL_GPIO=y
>> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
>> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> -CONFIG_NR_DRAM_BANKS=2
>> -CONFIG_SOC_K3_AM654=y
>> -CONFIG_K3_EARLY_CONS=y
>> -CONFIG_TARGET_AM654_R5_EVM=y
>> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41c7effc
>> -CONFIG_ENV_SIZE=0x20000
>> -CONFIG_DM_GPIO=y
>> -CONFIG_SPL_DM_SPI=y
>> -CONFIG_DEFAULT_DEVICE_TREE="k3-am654-r5-base-board"
>> -CONFIG_SPL_TEXT_BASE=0x41c00000
>> -CONFIG_DM_RESET=y
>> -CONFIG_SPL_MMC=y
>> -CONFIG_SPL_SERIAL=y
>> -CONFIG_SPL_DRIVERS_MISC=y
>> -CONFIG_SPL_STACK_R_ADDR=0x82000000
>> -CONFIG_SPL_FS_FAT=y
>> -CONFIG_SPL_LIBDISK_SUPPORT=y
>> -CONFIG_SPL_SPI_FLASH_SUPPORT=y
>> -CONFIG_SPL_SPI=y
>> -# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>> -CONFIG_SPL_LOAD_FIT=y
>> -CONFIG_USE_BOOTCOMMAND=y
>> -# CONFIG_DISPLAY_CPUINFO is not set
>> -CONFIG_SPL_MAX_SIZE=0x58000
>> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> -CONFIG_SPL_BSS_START_ADDR=0x41c7effc
>> -CONFIG_SPL_BSS_MAX_SIZE=0xc00
>> -CONFIG_SPL_STACK_R=y
>> -CONFIG_SPL_SEPARATE_BSS=y
>> -CONFIG_SYS_SPL_MALLOC=y
>> -CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
>> -CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
>> -CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
>> -CONFIG_SPL_EARLY_BSS=y
>> -CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>> -CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
>> -CONFIG_SPL_DMA=y
>> -CONFIG_SPL_I2C=y
>> -CONFIG_SPL_DM_MAILBOX=y
>> -CONFIG_SPL_DM_SPI_FLASH=y
>> -CONFIG_SPL_DM_RESET=y
>> -CONFIG_SPL_POWER_DOMAIN=y
>> -CONFIG_SPL_RAM_SUPPORT=y
>> -CONFIG_SPL_RAM_DEVICE=y
>> -CONFIG_SPL_REMOTEPROC=y
>> -# CONFIG_SPL_SPI_FLASH_TINY is not set
>> -CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
>> -CONFIG_SPL_SPI_LOAD=y
>> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
>> -CONFIG_SPL_YMODEM_SUPPORT=y
>> -CONFIG_HUSH_PARSER=y
>> -CONFIG_SYS_MAXARGS=64
>> -CONFIG_CMD_BOOTZ=y
>> -CONFIG_SYS_BOOTM_LEN=0x4000000
>> -CONFIG_CMD_ASKENV=y
>> -CONFIG_CMD_GPT=y
>> -CONFIG_CMD_I2C=y
>> -CONFIG_CMD_MMC=y
>> -CONFIG_CMD_REMOTEPROC=y
>> -# CONFIG_CMD_SETEXPR is not set
>> -CONFIG_CMD_TIME=y
>> -CONFIG_CMD_FAT=y
>> -CONFIG_OF_CONTROL=y
>> -CONFIG_SPL_OF_CONTROL=y
>> -CONFIG_SPL_MULTI_DTB_FIT=y
>> -CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
>> -CONFIG_ENV_OVERWRITE=y
>> -CONFIG_ENV_IS_IN_FAT=y
>> -CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
>> -CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> -CONFIG_SPL_DM=y
>> -CONFIG_SPL_DM_SEQ_ALIAS=y
>> -CONFIG_REGMAP=y
>> -CONFIG_SPL_REGMAP=y
>> -CONFIG_SPL_OF_TRANSLATE=y
>> -CONFIG_CLK=y
>> -CONFIG_SPL_CLK=y
>> -CONFIG_CLK_TI_SCI=y
>> -CONFIG_DMA_CHANNELS=y
>> -CONFIG_TI_K3_NAVSS_UDMA=y
>> -CONFIG_TI_SCI_PROTOCOL=y
>> -CONFIG_DA8XX_GPIO=y
>> -CONFIG_DM_I2C=y
>> -CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
>> -CONFIG_SYS_I2C_OMAP24XX=y
>> -CONFIG_DM_MAILBOX=y
>> -CONFIG_K3_SEC_PROXY=y
>> -CONFIG_K3_AVS0=y
>> -CONFIG_MMC_SDHCI=y
>> -CONFIG_SPL_MMC_SDHCI_ADMA=y
>> -CONFIG_MMC_SDHCI_AM654=y
>> -CONFIG_DM_SPI_FLASH=y
>> -CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>> -CONFIG_SPI_FLASH_STMICRO=y
>> -# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>> -CONFIG_PINCTRL=y
>> -# CONFIG_PINCTRL_GENERIC is not set
>> -CONFIG_SPL_PINCTRL=y
>> -# CONFIG_SPL_PINCTRL_GENERIC is not set
>> -CONFIG_PINCTRL_SINGLE=y
>> -CONFIG_POWER_DOMAIN=y
>> -CONFIG_TI_SCI_POWER_DOMAIN=y
>> -CONFIG_DM_REGULATOR=y
>> -CONFIG_SPL_DM_REGULATOR=y
>> -CONFIG_DM_REGULATOR_GPIO=y
>> -CONFIG_SPL_DM_REGULATOR_GPIO=y
>> -CONFIG_DM_REGULATOR_TPS62360=y
>> -CONFIG_RAM=y
>> -CONFIG_SPL_RAM=y
>> -CONFIG_K3_SYSTEM_CONTROLLER=y
>> -CONFIG_REMOTEPROC_TI_K3_ARM64=y
>> -CONFIG_RESET_TI_SCI=y
>> -CONFIG_DM_SERIAL=y
>> -CONFIG_SOC_DEVICE=y
>> -CONFIG_SOC_DEVICE_TI_K3=y
>> -CONFIG_SOC_TI=y
>> -CONFIG_SPI=y
>> -CONFIG_DM_SPI=y
>> -CONFIG_CADENCE_QSPI=y
>> -CONFIG_SYSRESET=y
>> -CONFIG_SPL_SYSRESET=y
>> -CONFIG_SYSRESET_TI_SCI=y
>> -CONFIG_TIMER=y
>> -CONFIG_SPL_TIMER=y
>> -CONFIG_OMAP_TIMER=y
>> -CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>> -- 
>> 2.39.2
>>
