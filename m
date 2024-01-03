Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD49C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 17:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F628783B;
	Wed,  3 Jan 2024 18:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C8NENPNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE92B8783C; Wed,  3 Jan 2024 18:58:21 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42AD28775A
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 18:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403Hw852109792;
 Wed, 3 Jan 2024 11:58:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704304688;
 bh=JgYpYAOTRRkylVsTpbFzCEIZSjkGzlmPDNUxBhU6Fks=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=C8NENPNydktU2+JOObC5MtFF/dx+r6m8kdfJBwHNe5PINJ/STfGVYqRhiAz9seAzU
 VOe4MOMEjrIeyx1V7CQsr7vWeywbMhfqZ8QYtnKHZJkT7wjNslghWyZmSDQwwoQSE2
 54fzK/Xb/XQHkB1HREabKUcf6IbTFQLkg4hnAU90=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403Hw8ik026972
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 11:58:08 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 11:58:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 11:58:07 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403Hw7oj028141;
 Wed, 3 Jan 2024 11:58:07 -0600
Date: Wed, 3 Jan 2024 11:58:07 -0600
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v7 14/17] configs: j784s4_evm: Add defconfig for j784s4
 evm board
Message-ID: <20240103175807.caft45rmlbqwbgn4@ravishing>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-15-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219191537.4039361-15-a-nandan@ti.com>
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

On 00:45-20231220, Apurva Nandan wrote:
> Add defconfigs for building R5 U-Boot SPL and A72 U-Boot.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  configs/j784s4_evm_a72_defconfig | 180 +++++++++++++++++++++++++++++++
>  configs/j784s4_evm_r5_defconfig  | 163 ++++++++++++++++++++++++++++
>  2 files changed, 343 insertions(+)
>  create mode 100644 configs/j784s4_evm_a72_defconfig
>  create mode 100644 configs/j784s4_evm_r5_defconfig
> 
> diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
> new file mode 100644
> index 0000000000..ae392f51cd
> --- /dev/null
> +++ b/configs/j784s4_evm_a72_defconfig

Have you really trimmed this down to minimum? there seems to be a lot of
stuff that you might want to look at. (DSP, R5, UFS..UBI etc) - please
keep this as minimal as possible for emmc/mmc/uart boot, other options
could be config fragments to apply on top.

> @@ -0,0 +1,180 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_TI_SECURE_DEVICE=y
> +CONFIG_SYS_MALLOC_F_LEN=0x8000
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_SOC_K3_J784S4=y
> +CONFIG_TARGET_J784S4_A72_EVM=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
> +CONFIG_SF_DEFAULT_SPEED=25000000
> +CONFIG_ENV_SIZE=0x20000
> +CONFIG_DM_GPIO=y
> +CONFIG_SPL_DM_SPI=y
> +CONFIG_DEFAULT_DEVICE_TREE="k3-j784s4-evm"
> +CONFIG_SPL_TEXT_BASE=0x80080000
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK_R_ADDR=0x82000000
> +CONFIG_SPL_FS_FAT=y
> +CONFIG_SPL_LIBDISK_SUPPORT=y
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +# CONFIG_PSCI_RESET is not set
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
> +CONFIG_LOGLEVEL=7
> +CONFIG_SPL_MAX_SIZE=0xc0000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x80a00000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SYS_SPL_MALLOC=y
> +CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_DM_MAILBOX=y
> +CONFIG_SPL_MTD_SUPPORT=y
> +CONFIG_SPL_DM_SPI_FLASH=y
> +CONFIG_SPL_DM_RESET=y
> +CONFIG_SPL_POWER_DOMAIN=y
> +CONFIG_SPL_RAM_SUPPORT=y
> +CONFIG_SPL_RAM_DEVICE=y
> +# CONFIG_SPL_SPI_FLASH_TINY is not set
> +CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
> +CONFIG_SPL_THERMAL=y
> +CONFIG_SPL_YMODEM_SUPPORT=y
> +CONFIG_SYS_MAXARGS=64
> +CONFIG_CMD_ASKENV=y
> +CONFIG_CMD_DFU=y
> +# CONFIG_CMD_FLASH is not set
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_REMOTEPROC=y
> +CONFIG_CMD_UFS=y
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_CMD_UBI=y
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_SPL_EFI_PARTITION is not set
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_SPL_MULTI_DTB_FIT=y
> +CONFIG_OF_LIST="k3-j784s4-evm k3-am69-sk"
> +CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_CLK_CCF=y
> +CONFIG_CLK_TI_SCI=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
> +CONFIG_DMA_CHANNELS=y
> +CONFIG_TI_K3_NAVSS_UDMA=y
> +CONFIG_TI_SCI_PROTOCOL=y
> +CONFIG_DA8XX_GPIO=y
> +CONFIG_DM_PCA953X=y
> +CONFIG_DM_I2C=y
> +CONFIG_DM_I2C_GPIO=y
> +CONFIG_SYS_I2C_OMAP24XX=y
> +CONFIG_DM_MAILBOX=y
> +CONFIG_K3_SEC_PROXY=y
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_SPL_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_AM654=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_NOR_FLASH=y
> +CONFIG_CFI_FLASH=y
> +CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
> +CONFIG_FLASH_CFI_MTD=y
> +CONFIG_SYS_FLASH_CFI=y
> +CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SOFT_RESET=y
> +CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_MULTIPLEXER=y
> +CONFIG_MUX_MMIO=y
> +CONFIG_PHY_TI_DP83867=y
> +CONFIG_PHY_FIXED=y
> +CONFIG_TI_AM65_CPSW_NUSS=y
> +CONFIG_PHY=y
> +CONFIG_SPL_PHY=y
> +CONFIG_PHY_CADENCE_TORRENT=y
> +CONFIG_PHY_J721E_WIZ=y
> +CONFIG_PINCTRL=y
> +# CONFIG_PINCTRL_GENERIC is not set
> +CONFIG_SPL_PINCTRL=y
> +# CONFIG_SPL_PINCTRL_GENERIC is not set
> +CONFIG_PINCTRL_SINGLE=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_TI_SCI_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_RAM=y
> +CONFIG_SPL_RAM=y
> +CONFIG_REMOTEPROC_TI_K3_DSP=y
> +CONFIG_REMOTEPROC_TI_K3_R5F=y
> +CONFIG_RESET_TI_SCI=y
> +CONFIG_SCSI=y
> +CONFIG_DM_SCSI=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SOC_DEVICE=y
> +CONFIG_SOC_DEVICE_TI_K3=y
> +CONFIG_SOC_TI=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_CADENCE_QSPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SPL_SYSRESET=y
> +CONFIG_SYSRESET_TI_SCI=y
> +CONFIG_DM_THERMAL=y
> +CONFIG_UFS=y
> +CONFIG_CADENCE_UFS=y
> +CONFIG_TI_J721E_UFS=y
> diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
> new file mode 100644
> index 0000000000..b0ffadd499
> --- /dev/null
> +++ b/configs/j784s4_evm_r5_defconfig

Same comment about trimming this down.

> @@ -0,0 +1,163 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_TI_SECURE_DEVICE=y
> +CONFIG_SYS_MALLOC_F_LEN=0x10000
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SOC_K3_J784S4=y
> +CONFIG_K3_EARLY_CONS=y
> +CONFIG_TARGET_J784S4_R5_EVM=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41c76000
> +CONFIG_SF_DEFAULT_SPEED=25000000
> +CONFIG_ENV_SIZE=0x20000
> +CONFIG_DM_GPIO=y
> +CONFIG_SPL_DM_SPI=y
> +CONFIG_DEFAULT_DEVICE_TREE="k3-j784s4-r5-evm"
> +CONFIG_SPL_TEXT_BASE=0x41c00000
> +CONFIG_DM_RESET=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK_R_ADDR=0x82000000
> +CONFIG_SPL_SIZE_LIMIT=0x80000
> +CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
> +CONFIG_SPL_FS_FAT=y
> +CONFIG_SPL_LIBDISK_SUPPORT=y
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
> +CONFIG_USE_BOOTCOMMAND=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
> +CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
> +CONFIG_SPL_MAX_SIZE=0xc0000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x41c76000
> +CONFIG_SPL_BSS_MAX_SIZE=0xa000
> +CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x140000
> +CONFIG_SPL_SEPARATE_BSS=y
> +CONFIG_SYS_SPL_MALLOC=y
> +CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
> +CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
> +CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
> +CONFIG_SPL_EARLY_BSS=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_FS_EXT4=y
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_DM_MAILBOX=y
> +CONFIG_SPL_MTD_SUPPORT=y
> +CONFIG_SPL_DM_SPI_FLASH=y
> +CONFIG_SPL_DM_RESET=y
> +CONFIG_SPL_POWER_DOMAIN=y
> +CONFIG_SPL_RAM_SUPPORT=y
> +CONFIG_SPL_RAM_DEVICE=y
> +CONFIG_SPL_REMOTEPROC=y
> +# CONFIG_SPL_SPI_FLASH_TINY is not set
> +CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
> +CONFIG_SPL_THERMAL=y
> +CONFIG_SPL_YMODEM_SUPPORT=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_SYS_MAXARGS=64
> +CONFIG_SYS_BOOTM_LEN=0x4000000
> +CONFIG_CMD_DFU=y
> +# CONFIG_CMD_FLASH is not set
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_REMOTEPROC=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_FAT=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_SPL_MULTI_DTB_FIT=y
> +CONFIG_SPL_OF_LIST="k3-j784s4-r5-evm k3-am69-r5-sk"

NAK - drop am69-r5-sk here. you should NOT need that for an evm only build.

> +CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_SPL_CLK_CCF=y
> +CONFIG_SPL_CLK_K3_PLL=y
> +CONFIG_SPL_CLK_K3=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
> +CONFIG_DMA_CHANNELS=y
> +CONFIG_TI_K3_NAVSS_UDMA=y
> +CONFIG_TI_SCI_PROTOCOL=y
> +CONFIG_DA8XX_GPIO=y
> +CONFIG_DM_PCA953X=y
> +CONFIG_DM_I2C=y
> +CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
> +CONFIG_SYS_I2C_OMAP24XX=y
> +CONFIG_DM_MAILBOX=y
> +CONFIG_K3_SEC_PROXY=y
> +CONFIG_FS_LOADER=y
> +CONFIG_SPL_FS_LOADER=y
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_SPL_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_AM654=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_NOR_FLASH=y
> +CONFIG_CFI_FLASH=y
> +CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
> +CONFIG_FLASH_CFI_MTD=y
> +CONFIG_SYS_FLASH_CFI=y
> +CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SOFT_RESET=y
> +CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
> +CONFIG_PINCTRL=y
> +# CONFIG_PINCTRL_GENERIC is not set
> +CONFIG_SPL_PINCTRL=y
> +# CONFIG_SPL_PINCTRL_GENERIC is not set
> +CONFIG_PINCTRL_SINGLE=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_TI_POWER_DOMAIN=y
> +CONFIG_K3_SYSTEM_CONTROLLER=y
> +CONFIG_REMOTEPROC_TI_K3_ARM64=y
> +CONFIG_RESET_TI_SCI=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SOC_DEVICE=y
> +CONFIG_SOC_DEVICE_TI_K3=y
> +CONFIG_SOC_TI=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_CADENCE_QSPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SPL_SYSRESET=y
> +CONFIG_SYSRESET_TI_SCI=y
> +CONFIG_DM_THERMAL=y
> +CONFIG_TIMER=y
> +CONFIG_SPL_TIMER=y
> +CONFIG_OMAP_TIMER=y
> +CONFIG_FS_EXT4=y
> +CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> +CONFIG_PANIC_HANG=y
> +CONFIG_LIB_RATIONAL=y
> +CONFIG_SPL_LIB_RATIONAL=y

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
