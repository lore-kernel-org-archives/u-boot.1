Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA6ACE8D49
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60EC890C2;
	Thu, 19 Sep 2024 05:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hhpfsYEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67936890C2; Thu, 19 Sep 2024 05:56:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0383F890C3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718200; x=1758254200;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=garSdGHRT5A2Ko4GAbmK77pnLUx0XHEQkid3YiR35Io=;
 b=hhpfsYEgGOImNzfRY2GpOcpNuB4xFakPLp4JMhz/D/W4IvvMzq0orMxN
 VMXVe8eugnFqtAn5EazG7KpMVMnYknChMI8prNpoUhXMNmdZg9JtyNquc
 ntiejgm+zKydiFTayWF6fiUfLpSIrqnGe45M7MB/ct5OXRsqLUp4vVosG
 JRda5c6F27aMjbsMkecSfjoO3Vm5Wy3Pd1Mq1K4h8yzURB2Zlrm+1XeAf
 8DC9e8+1evR0Imav3ULp7+swTnPBkHVehHWrdHGp85GA5eXih5/cKyr/W
 /X00v+OFxEu9EqXMhOEr2IHmhtDwv3MBfMw8a8vUB2W6lgpr1dbA3TMCJ w==;
X-CSE-ConnectionGUID: XnFssJ57TkOy4B3cB/0+jw==
X-CSE-MsgGUID: fiGOVSCgT76i9IKc7fsOVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178094"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178094"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:39 -0700
X-CSE-ConnectionGUID: MWIjqKJYQFKU8vw2DA2deQ==
X-CSE-MsgGUID: +ounjwtcRP6jYEP+vg7KXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253898"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:34 -0700
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 14/19] configs: nand2_defconfig: Enable configs for nand boot
Date: Thu, 19 Sep 2024 11:55:07 +0800
Message-Id: <20240919035512.13854-15-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

This patch is to enable configs for nand boot.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 configs/socfpga_agilex5_nand2_defconfig | 169 ++++++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 configs/socfpga_agilex5_nand2_defconfig

diff --git a/configs/socfpga_agilex5_nand2_defconfig b/configs/socfpga_agilex5_nand2_defconfig
new file mode 100644
index 0000000000..9e5a75194a
--- /dev/null
+++ b/configs/socfpga_agilex5_nand2_defconfig
@@ -0,0 +1,169 @@
+CONFIG_ARM=y
+CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_TEXT_BASE=0x80200000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x04100000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
+CONFIG_SPL_MMC=y
+CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=y
+CONFIG_TARGET_SOCFPGA_AGILEX5_NAND2=y
+CONFIG_QPDS_HPS_HANDOFF=y
+CONFIG_IDENT_STRING="socfpga_agilex5"
+CONFIG_SPL_FS_FAT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
+# CONFIG_USE_SPL_FIT_GENERATOR is not set
+CONFIG_QSPI_BOOT=y
+CONFIG_BOOTDELAY=5
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="earlycon panic=-1 root=${nandroot} rw rootwait rootfstype=ubifs ubi.mtd=1"
+CONFIG_LEGACY_IMAGE_FORMAT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_CRC32=y
+CONFIG_SPL_CACHE=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SYS_PROMPT="SOCFPGA_AGILEX5 # "
+CONFIG_CMD_NVEDIT_SELECT=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=n
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SF=y
+CONFIG_PHY=y
+CONFIG_SPL_PHY=y
+CONFIG_NOP_PHY=y
+CONFIG_SPL_NOP_PHY=y
+CONFIG_PHY_CADENCE_COMBOPHY=n
+CONFIG_SPL_PHY_CADENCE_COMBOPHY=n
+CONFIG_MMC=y
+CONFIG_MMC_WRITE=y
+# CONFIG_MMC_BROKEN_CD is not set
+CONFIG_DM_MMC=y
+CONFIG_SPL_DM_MMC=y
+CONFIG_MMC_SDHCI_ADMA_HELPERS=y
+# CONFIG_ARM_PL180_MMCI is not set
+CONFIG_MMC_QUIRKS=y
+CONFIG_SYS_MMC_MAX_BLK_COUNT=65535
+CONFIG_MMC_HW_PARTITIONING=y
+# CONFIG_SUPPORT_EMMC_RPMB is not set
+# CONFIG_SUPPORT_EMMC_BOOT is not set
+# CONFIG_MMC_IO_VOLTAGE is not set
+# CONFIG_MMC_HS400_ES_SUPPORT is not set
+# CONFIG_MMC_HS400_SUPPORT is not set
+# CONFIG_MMC_HS200_SUPPORT is not set
+CONFIG_MMC_VERBOSE=n
+CONFIG_MMC_TRACE=n
+# CONFIG_MMC_DW is not set
+# CONFIG_MMC_MXC is not set
+# CONFIG_MMC_PCI is not set
+# CONFIG_MMC_OMAP_HS is not set
+CONFIG_MMC_SDHCI=y
+# CONFIG_MMC_SDHCI_SDMA is not set
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+# CONFIG_MMC_SDHCI_BCMSTB is not set
+CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_CMD_FAT=y
+CONFIG_DOS_PARTITION=y
+CONFIG_SPL_DOS_PARTITION=y
+CONFIG_SPL_SYS_DISABLE_DCACHE_OPS=y
+CONFIG_CMD_MTD=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_CMD_NAND_LOCK_UNLOCK=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_CACHE=y
+CONFIG_SPL_SPI_FLASH_MTD=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_MTDIDS_DEFAULT="nand0=10b80000.nand.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=10b80000.nand.0:2m(u-boot),-(root)"
+CONFIG_CMD_UBI=y
+CONFIG_CMD_UBIFS=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_LIMIT=20
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_OF_LIST=""
+CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_UBI_PART="root"
+CONFIG_ENV_UBI_VOLUME="env"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_ALTERA_SDRAM=y
+CONFIG_FPGA_INTEL_PR=y
+CONFIG_DWAPB_GPIO=y
+CONFIG_DM_I2C=n
+CONFIG_SYS_I2C_DW=n
+CONFIG_MISC=y
+CONFIG_MISC_INIT_R=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0x0
+CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=0x100000
+CONFIG_SF_DEFAULT_MODE=0x2003
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_UBI_SILENCE_MSG=y
+CONFIG_PHY_MARVELL=y
+CONFIG_DM_ETH=y
+CONFIG_DWC_ETH_XGMAC=y
+CONFIG_RGMII=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_DESIGNWARE_SPI=y
+CONFIG_USB=y
+CONFIG_USB_DWC2=n
+CONFIG_USB_DWC3=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_UBIFS_SILENCE_MSG=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_PANIC_HANG=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_WDT=n
+CONFIG_CMD_WDT=n
+CONFIG_DESIGNWARE_WATCHDOG=n
+CONFIG_SPL_WDT=n
+CONFIG_WATCHDOG_AUTOSTART=n
+CONFIG_TIMER=n
+CONFIG_DESIGNWARE_APB_TIMER=n
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xbff00000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK=0x73000
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
+CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xbfa00000
+CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_BSS_MAX_SIZE=0x100000
+# CONFIG_EFI_LOADER is not set
+CONFIG_I3C=n
+CONFIG_DW_I3C_MASTER=n
+CONFIG_CMD_I3C=n
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_CADENCE=y
+CONFIG_SPL_NAND_SUPPORT=y
+CONFIG_SPL_NAND_FRAMEWORK=y
+CONFIG_SPL_NAND_CADENCE=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_SYS_NAND_ONFI_DETECTION=y
-- 
2.26.2

