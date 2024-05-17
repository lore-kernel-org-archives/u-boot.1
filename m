Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A87BC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E07E78850B;
	Fri, 17 May 2024 14:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YGzGaLPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49DE188490; Fri, 17 May 2024 07:28:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D508C882D9
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923720; x=1747459720;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y8A48WNWylTjOebkjg91AiH4Gd6XyWwPosGRn9j46jM=;
 b=YGzGaLPzRJjTHgkzwuk8dyMdUbp9qcwNksgHRCBe4yfihx2nEGHy6g2e
 ncBaR7RK8Cyf+RscUaibqkl9fUQgpXKkvqFtVwn4O85v8O/S7T8i1h6dx
 YxYW1fP5K8QJHulZxhMNuBpd8vS761qxLaFU202qYymxVNY8k2JlvKf4s
 fVm8m4yGzqitZ10noEBgEa1MYgZBSlAFy0IYJrx2tasWlg57J8leEM0hw
 qw7xA/RoC25Ye05zHl/qZ4QP3JjlxW+/o/cWhYH41xgp0zPOFLjvBsAb3
 U2wKsdT3Ke2kd/kcLx3/eALSpR3ctnCTIHKQ/m44Z4hAThbGEkQf2zSr1 w==;
X-CSE-ConnectionGUID: 114yGmOiSZSUUh2qET+8bQ==
X-CSE-MsgGUID: eCK8NydlSuKj51ih0DV12w==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11930074"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11930074"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:28:39 -0700
X-CSE-ConnectionGUID: 204sq+iBRsyLcus6RM2pdw==
X-CSE-MsgGUID: k3akPkfvSM2YGQXYDuoSew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188505"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:28:35 -0700
From: tingting.meng@intel.com
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 16/16] configs: Add
 defconfig for Agilex7 M-series
Date: Fri, 17 May 2024 13:27:01 +0800
Message-Id: <20240517052701.12949-17-tingting.meng@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517052701.12949-1-tingting.meng@intel.com>
References: <20240517052701.12949-1-tingting.meng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 May 2024 14:50:41 +0200
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

From: Wan Yee Lau <wan.yee.lau@intel.com>

Add defconfig for Agilex7 M-series.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 ...onfig => socfpga_agilex7m_sdmmc_defconfig} | 110 +++++++++---------
 1 file changed, 54 insertions(+), 56 deletions(-)
 copy configs/{socfpga_agilex5_defconfig => socfpga_agilex7m_sdmmc_defconfig} (56%)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex7m_sdmmc_defconfig
similarity index 56%
copy from configs/socfpga_agilex5_defconfig
copy to configs/socfpga_agilex7m_sdmmc_defconfig
index f39954aea8..12414e2e5f 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex7m_sdmmc_defconfig
@@ -1,50 +1,69 @@
 CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=400000000
 CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
 CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x80200000
+CONFIG_TEXT_BASE=0x200000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x04100000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
-CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=y
-CONFIG_IDENT_STRING="socfpga_agilex5"
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex7m_socdk"
+CONFIG_SPL_TEXT_BASE=0xFFE00000
+CONFIG_TARGET_SOCFPGA_AGILEX7M_SOCDK=y
+CONFIG_IDENT_STRING="socfpga_agilex7m"
 CONFIG_SPL_FS_FAT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
+CONFIG_SYS_LOAD_ADDR=0x02000000
 # CONFIG_USE_SPL_FIT_GENERATOR is not set
-CONFIG_QSPI_BOOT=y
+# CONFIG_NAND_BOOT is not set
+# CONFIG_QSPI_BOOT is not set
 CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS0,115200 initrd=0x90000000 root=/dev/ram0 rw init=/sbin/init ramdisk_size=10000000 earlycon panic=-1 nosmp kvm-arm.mode=nvhe"
-CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_BOOTARGS="earlycon panic=-1"
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x3ff00000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK=0xffe3f000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
+CONFIG_CUSTOM_SPL_SYS_MALLOC_ADDR=0x3fa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
+CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_SPL_CRC32=y
+CONFIG_SPL_MTD_SUPPORT=y
+# CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
-CONFIG_SYS_PROMPT="SOCFPGA_AGILEX5 # "
+CONFIG_SYS_PROMPT="SOCFPGA_AGILEX7M # "
 CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
-CONFIG_CMD_SF=y
-CONFIG_DOS_PARTITION=y
-CONFIG_SPL_DOS_PARTITION=y
-CONFIG_SPL_SYS_DISABLE_DCACHE_OPS=y
+CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+# CONFIG_CMD_NAND_TRIMFFS is not set
+# CONFIG_CMD_NAND_LOCK_UNLOCK is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPI_FLASH_MTD=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_MTDIDS_DEFAULT="nand0=ffb90000.nand.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=ffb90000.nand.0:2m(u-boot),-(root)"
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_CMD_UBI=y
 CONFIG_CMD_UBIFS=y
 CONFIG_MTD_UBI=y
@@ -53,9 +72,8 @@ CONFIG_MTD_UBI_BEB_LIMIT=20
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_OF_LIST=""
-CONFIG_ENV_IS_IN_UBI=y
-CONFIG_ENV_UBI_PART="root"
-CONFIG_ENV_UBI_VOLUME="env"
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
@@ -65,52 +83,32 @@ CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_MISC=y
+CONFIG_MMC_DW=y
+CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+# CONFIG_NAND_DENALI_DT is not set
+# CONFIG_SYS_NAND_U_BOOT_LOCATIONS is not set
+CONFIG_SYS_NAND_U_BOOT_OFFS=0x0
+CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=0x100000
+CONFIG_SPL_NAND_FRAMEWORK=y
 CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_UBI_SILENCE_MSG=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH=y
-CONFIG_RGMII=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MII=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
-CONFIG_CADENCE_QSPI=y
-CONFIG_DESIGNWARE_SPI=y
+# CONFIG_CADENCE_QSPI is not set
+# CONFIG_DESIGNWARE_SPI is not set
 CONFIG_USB=y
+CONFIG_DM_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_UBIFS_SILENCE_MSG=y
+CONFIG_DESIGNWARE_WATCHDOG=y
+CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_WDT=y
-CONFIG_CMD_WDT=y
-CONFIG_DESIGNWARE_WATCHDOG=y
-CONFIG_SPL_WDT=y
-CONFIG_WATCHDOG_AUTOSTART=n
-CONFIG_TIMER=y
-CONFIG_DESIGNWARE_APB_TIMER=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
-CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xbff00000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_STACK=0x7f000
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xbfa00000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
-CONFIG_SPL_BSS_MAX_SIZE=0x100000
-# CONFIG_EFI_LOADER is not set
-CONFIG_I3C=y
-CONFIG_DW_I3C_MASTER=y
-CONFIG_CMD_I3C=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_TIMER=y
-# CONFIG_BOOTFILE="Image" is not set for CONFIG_SPL_ATF=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="kernel.itb"
-- 
2.25.1

