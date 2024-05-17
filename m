Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CA6C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E457884E5;
	Fri, 17 May 2024 14:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Yubf0lKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF49C88497; Fri, 17 May 2024 07:28:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0AC883C7
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923697; x=1747459697;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cTr9nmAQwyvXHdj4th0JNXRNqWkwIwVj/nfM015sAho=;
 b=Yubf0lKdBXTiVLI6sYqOPdM+Qsi1ZFjZDF/BFZaC+x/Rqews6dM4b8y0
 5A6qpjVGH8s54IdThMViUh8DyvqsdvqROuRJt6FL0dkXCZkGxpA556hls
 dGLW2F8iIxufI1eIBMgRmnZAD7v3DvTguAfT5dkikBrd+8K2J1O5d2Pi4
 +i+FdGabjDtssV6uI4h2StiQDE+kg21ipNR7+9F44E8Y5dgIelqIiNlN+
 8h6nRMTMFijqtXum4hHkjJ9MQqF/TFRHeJ2D5ZbaEOdNomN4yzmKLJdOE
 lhve0sJnb4RjQ68gkR9D1GKYOLjBcTSfI1A0NbvVBsppd7IlvbSEFnCJR A==;
X-CSE-ConnectionGUID: 3C+P4Z8wT9uX2fskZoDq/g==
X-CSE-MsgGUID: FhEBJXnpRDKIjAUxw+w7xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11930009"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11930009"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:28:13 -0700
X-CSE-ConnectionGUID: 2oVsNAGbSdKrFdiBN8k56Q==
X-CSE-MsgGUID: ZavdHMo2QMas81WlNlCVWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188311"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:28:09 -0700
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
Subject: [Agilex7 M-series Platform Enablement v1 10/16] ddr: altera: Add DDR
 driver for Agilex7 M-series
Date: Fri, 17 May 2024 13:26:55 +0800
Message-Id: <20240517052701.12949-11-tingting.meng@intel.com>
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

This is for new platform enablement for Agilex7 M-series.
Add DDR driver for Agilex7 M-series. This driver is designed to support
DDR and HBM memory. The official HBM handoff is not ready yet, therefore
hardcoded handoff is used for HBM driver validation on mUDV board.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 .../include/mach/base_addr_soc64.h            |   6 +-
 .../include/mach/system_manager_soc64.h       |   7 +-
 drivers/ddr/altera/Makefile                   |   3 +-
 drivers/ddr/altera/sdram_agilex7m.c           | 527 ++++++++++++++++++
 drivers/ddr/altera/sdram_soc64.c              |  15 +-
 drivers/ddr/altera/sdram_soc64.h              |  15 +-
 6 files changed, 565 insertions(+), 8 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_agilex7m.c

diff --git a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
index 65721098b2..1f935fcdec 100644
--- a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
@@ -45,12 +45,15 @@
 #define SOCFPGA_SDR_SCHEDULER_ADDRESS		0xf8000400
 #define SOCFPGA_HMC_MMR_IO48_ADDRESS		0xf8010000
 #define SOCFPGA_SDR_ADDRESS			0xf8011000
+#define SOCFPGA_FW_MPFE_SCR_ADDRESS		0xf8020000
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X) || \
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 #define SOCFPGA_FW_MPU_DDR_SCR_ADDRESS		0xf8020200
 #else
 #define SOCFPGA_FW_MPU_DDR_SCR_ADDRESS		0xf8020100
 #endif
+#define SOCFPGA_F2SDRAM_MGR_ADDRESS		0xf8024000
 #define SOCFPGA_SMMU_ADDRESS			0xfa000000
 #define SOCFPGA_MAILBOX_ADDRESS			0xffa30000
 #define SOCFPGA_UART0_ADDRESS			0xffc02000
@@ -74,6 +77,7 @@
 #define SOCFPGA_FIREWALL_SOC2FPGA		0xffd21200
 #define SOCFPGA_FIREWALL_LWSOC2FPGA		0xffd21300
 #define SOCFPGA_FIREWALL_TCU			0xffd21400
+#define SOCFPGA_FIREWALL_PRIV_MEMORYMAP_PRIV	0xffd24800
 #define SOCFPGA_DMANONSECURE_ADDRESS		0xffda0000
 #define SOCFPGA_DMASECURE_ADDRESS		0xffda1000
 #define SOCFPGA_OCRAM_ADDRESS			0xffe00000
diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index a8009664fe..815bdf8ce1 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2019-2021 Intel Corporation <www.intel.com>
+ * Copyright (C) 2019-2024 Intel Corporation <www.intel.com>
  */
 
 #ifndef _SYSTEM_MANAGER_SOC64_H_
@@ -103,6 +103,11 @@ void populate_sysmgr_pinmux(void);
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_MASK	(BIT(29) | BIT(28))
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_SHIFT	28
 
+#define ALT_SYSMGR_SCRATCH_REG_8_DDR_DBE_MASK		BIT(31)
+#define ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK	BIT(30)
+#define ALT_SYSMGR_SCRATCH_REG_8_OCRAM_DBE_MASK		BIT(29)
+#define ALT_SYSMGR_SCRATCH_REG_8_IO96B_HPS_MASK		GENMASK(28, 27)
+
 #define SYSMGR_SDMMC				SYSMGR_SOC64_SDMMC
 
 #define SYSMGR_ROMCODEGRP_CTRL_WARMRSTCFGPINMUX	BIT(0)
diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index 9fa5d85a27..1dac088b39 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 # (C) Copyright 2010, Thomas Chou <thomas@wytron.com.tw>
-# Copyright (C) 2014-2021 Altera Corporation <www.altera.com>
+# Copyright (C) 2014-2024 Altera Corporation <www.altera.com>
 
 ifdef CONFIG_$(SPL_)ALTERA_SDRAM
 obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
@@ -12,4 +12,5 @@ obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
+obj-$(CONFIG_TARGET_SOCFPGA_AGILEX7M) += sdram_soc64.o sdram_agilex7m.o iossm_mailbox.o uibssm_mailbox.o
 endif
diff --git a/drivers/ddr/altera/sdram_agilex7m.c b/drivers/ddr/altera/sdram_agilex7m.c
new file mode 100644
index 0000000000..4d585501e6
--- /dev/null
+++ b/drivers/ddr/altera/sdram_agilex7m.c
@@ -0,0 +1,527 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#include <dm.h>
+#include <hang.h>
+#include <log.h>
+#include <ram.h>
+#include <reset.h>
+#include <wait_bit.h>
+#include <asm/arch/system_manager.h>
+#include <linux/bitfield.h>
+#include "iossm_mailbox.h"
+#include "uibssm_mailbox.h"
+#include "sdram_soc64.h"
+
+/* NOCPLL register */
+#define SYSMGR_HMC_CLK		0xB4
+#define SYSMGR_HMC_CLK_NOCPLL	BIT(8)
+
+/* MPFE NOC registers */
+#define F2SDRAM_SIDEBAND_FLAGOUTSET0	0x50
+#define F2SDRAM_SIDEBAND_FLAGOUTSTATUS0	0x58
+#define SIDEBANDMGR_FLAGOUTSET0_REG	SOCFPGA_F2SDRAM_MGR_ADDRESS +\
+					F2SDRAM_SIDEBAND_FLAGOUTSET0
+#define SIDEBANDMGR_FLAGOUTSTATUS0_REG	SOCFPGA_F2SDRAM_MGR_ADDRESS +\
+					F2SDRAM_SIDEBAND_FLAGOUTSTATUS0
+
+#define SIDEBANDMGR_FLAGOUTSET0_REG_MULTICHANNEL	BIT(4)
+#define SIDEBANDMGR_FLAGOUTSET0_REG_INTERLEAVING	BIT(5)
+
+/* Reset type */
+enum reset_type {
+	POR_RESET,
+	WARM_RESET,
+	COLD_RESET,
+	NCONFIG,
+	JTAG_CONFIG,
+	RSU_RECONFIG
+};
+
+phys_addr_t io96b_csr_reg_addr[] = {
+	0xf8400000, /* IO96B_0 CSR registers address */
+	0xf8800000  /* IO96B_1 CSR registers address */
+};
+
+phys_addr_t uib_csr_reg_addr[] = {
+	0xf8400000, /* UIB_0 CSR registers address */
+	0xf8410000, /* UIB_1 CSR registers address */
+	0xf8420000, /* UIB_2 CSR registers address */
+	0xf8430000, /* UIB_3 CSR registers address */
+	0xf8440000, /* UIB_4 CSR registers address */
+	0xf8450000, /* UIB_5 CSR registers address */
+	0xf8460000, /* UIB_6 CSR registers address */
+	0xf8470000  /* UIB_7 CSR registers address */
+};
+
+static enum reset_type get_reset_type(u32 reg)
+{
+	return FIELD_GET(ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_MASK, reg);
+}
+
+bool is_ddr_init_hang(void)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+
+	debug("%s: 0x%x\n", __func__, reg);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK)
+		return true;
+
+	return false;
+}
+
+void ddr_init_inprogress(bool start)
+{
+	if (start)
+		setbits_le32(socfpga_get_sysmgr_addr() +
+			     SYSMGR_SOC64_BOOT_SCRATCH_COLD8,
+			     ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK);
+	else
+		clrbits_le32(socfpga_get_sysmgr_addr() +
+			     SYSMGR_SOC64_BOOT_SCRATCH_COLD8,
+			     ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK);
+}
+
+static const char *memory_type_in_use(struct udevice *dev)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+
+	return (plat->mem_type == DDR_MEMORY ? "DDR" : "HBM");
+}
+
+static bool is_ddr_in_use(struct udevice *dev)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+
+	return (plat->mem_type == DDR_MEMORY ? true : false);
+}
+
+void update_uib_assigned_to_hps(u8 num_uib_instance)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+
+	reg = reg & ~ALT_SYSMGR_SCRATCH_REG_8_IO96B_HPS_MASK;
+
+	writel(reg | FIELD_PREP(ALT_SYSMGR_SCRATCH_REG_8_IO96B_HPS_MASK, num_uib_instance),
+	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+}
+
+void update_io96b_assigned_to_hps(u8 num_io96b_instance)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+
+	reg = reg & ~ALT_SYSMGR_SCRATCH_REG_8_IO96B_HPS_MASK;
+
+	writel(reg | FIELD_PREP(ALT_SYSMGR_SCRATCH_REG_8_IO96B_HPS_MASK, num_io96b_instance),
+	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+}
+
+int populate_ddr_handoff(struct udevice *dev, struct io96b_info *io96b_ctrl,
+			 struct uib_info *uib_ctrl)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+	int i;
+	u8 count = 0;
+	u32 len = SOC64_HANDOFF_DDR_LEN;
+	u32 handoff_table[len];
+
+	/* Read handoff for DDR configuration */
+	socfpga_handoff_read((void *)SOC64_HANDOFF_DDR_BASE, handoff_table, len);
+
+	/* Interleaving Mode */
+	if (handoff_table[0] & SOC64_HANDOFF_DDR_INTERLEAVING_MODE_MASK)
+		plat->multichannel_interleaving = true;
+	else
+		plat->multichannel_interleaving = false;
+
+	debug("%s: MPFE-EMIF is in %s mode\n", __func__,
+	      plat->multichannel_interleaving ? "interleaving" : "multichannel");
+
+	/* Memory type */
+	if (handoff_table[2] & SOC64_HANDOFF_DDR_MEMORY_TYPE_MASK)
+		plat->mem_type = HBM_MEMORY;
+	else
+		plat->mem_type = DDR_MEMORY;
+
+	debug("%s: Memory type is %s\n", __func__, plat->mem_type ? "HBM" : "DDR");
+
+	if (plat->mem_type == HBM_MEMORY) {
+		/* Assign UIB CSR base address if it is valid */
+		for (i = 0; i < MAX_UIB_SUPPORTED; i++) {
+			if (handoff_table[3] & BIT(i)) {
+				uib_ctrl->uib[i].uib_csr_addr = uib_csr_reg_addr[i];
+
+				debug("%s: UIB 0x%llx CSR enabled\n", __func__,
+				      uib_ctrl->uib[i].uib_csr_addr);
+
+				count++;
+			}
+		}
+
+		uib_ctrl->num_instance = count;
+		update_uib_assigned_to_hps(count);
+
+		debug("%s: returned num_instance 0x%x\n", __func__, uib_ctrl->num_instance);
+
+		/*
+		 * HBM memory size
+		 * 1 UIB channel has 2 pseudo channels
+		 * 1 pseudo channel is 1GB, hence 1 UIB channel is 2GB
+		 */
+		uib_ctrl->overall_size = uib_ctrl->num_instance * SZ_2G;
+
+		/* UIB ECC status */
+		uib_ctrl->ecc_status = handoff_table[4];
+
+		debug("%s: ECC status 0x%x\n", __func__, uib_ctrl->ecc_status);
+	} else {
+		/* Assign IO96B CSR base address if it is valid */
+		for (i = 0; i < MAX_IO96B_SUPPORTED; i++) {
+			if (handoff_table[1] & BIT(i)) {
+				io96b_ctrl->io96b[i].io96b_csr_addr = io96b_csr_reg_addr[i];
+
+				debug("%s: IO96B 0x%llx CSR enabled\n", __func__,
+				      io96b_ctrl->io96b[i].io96b_csr_addr);
+
+				count++;
+			}
+		}
+
+		io96b_ctrl->num_instance = count;
+
+		update_io96b_assigned_to_hps(count);
+
+		debug("%s: returned num_instance 0x%x\n", __func__, io96b_ctrl->num_instance);
+	}
+
+	return 0;
+}
+
+int config_mpfe_sideband_mgr(struct udevice *dev)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+	u32 reg, mask;
+	int ret = 0;
+
+	if (plat->multichannel_interleaving) {
+		mask = SIDEBANDMGR_FLAGOUTSET0_REG_INTERLEAVING;
+		setbits_le32(SIDEBANDMGR_FLAGOUTSET0_REG, mask);
+	} else {
+		mask = SIDEBANDMGR_FLAGOUTSET0_REG_MULTICHANNEL;
+		setbits_le32(SIDEBANDMGR_FLAGOUTSET0_REG, mask);
+	}
+
+	reg = readl(SIDEBANDMGR_FLAGOUTSTATUS0_REG);
+
+	debug("%s: F2SDRAM_SIDEBAND_FLAGOUTSTATUS0: 0x%x\n", __func__, reg);
+
+	if ((reg & mask) == SIDEBANDMGR_FLAGOUTSET0_REG_INTERLEAVING)
+		debug("%s: Interleaving bit is set\n", __func__);
+	else if ((reg & mask) == SIDEBANDMGR_FLAGOUTSET0_REG_MULTICHANNEL)
+		debug("%s: Multichannel bit is set\n", __func__);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
+bool hps_ocram_dbe_status(void)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_8_OCRAM_DBE_MASK)
+		return true;
+
+	return false;
+}
+
+bool ddr_ecc_dbe_status(void)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_8_DDR_DBE_MASK)
+		return true;
+
+	return false;
+}
+
+int sdram_mmr_init_full(struct udevice *dev)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+	struct altera_sdram_priv *priv = dev_get_priv(dev);
+	struct io96b_info *io96b_ctrl = malloc(sizeof(*io96b_ctrl));
+	struct uib_info *uib_ctrl = malloc(sizeof(*uib_ctrl));
+	struct bd_info bd = {0};
+	bool full_mem_init = false;
+	phys_size_t hw_size;
+	int ret = 0;
+	int i;
+	u32 reg = readl(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
+	enum reset_type reset_t = get_reset_type(reg);
+
+	/* Populating DDR handoff data */
+	debug("DDR: Populating DDR handoff\n");
+
+	ret = populate_ddr_handoff(dev, io96b_ctrl, uib_ctrl);
+	if (ret) {
+		printf("DDR: Failed to populate DDR handoff\n");
+
+		goto err;
+	}
+
+	debug("%s: Address MPFE 0x%llx\n", memory_type_in_use(dev), plat->mpfe_base_addr);
+
+	/* DDR initialization progress status tracking */
+	bool is_ddr_hang_be4_rst = is_ddr_init_hang();
+
+	printf("%s: SDRAM init in progress ...\n", memory_type_in_use(dev));
+
+	ddr_init_inprogress(true);
+
+	if (is_ddr_in_use(dev)) {
+		/* Configure if polling is needed for IO96B GEN PLL locked */
+		io96b_ctrl->ckgen_lock = false;
+
+		/* Ensure calibration status passing */
+		init_mem_cal(io96b_ctrl);
+	}
+
+	/* Configuring MPFE sideband manager registers - multichannel or interleaving */
+	debug("%s: MPFE configuration in progress ...\n", memory_type_in_use(dev));
+
+	ret = config_mpfe_sideband_mgr(dev);
+	if (ret) {
+		printf("%s: Failed to configure multichannel/interleaving mode\n",
+		       memory_type_in_use(dev));
+
+		goto err;
+	}
+
+	debug("%s: MPFE configuration completed\n", memory_type_in_use(dev));
+
+	debug("%s: Waiting for NOCPLL locked ...\n", memory_type_in_use(dev));
+
+	/* Ensure NOCPLL locked */
+	ret = wait_for_bit_le32((const void *)socfpga_get_sysmgr_addr() + SYSMGR_HMC_CLK
+				, SYSMGR_HMC_CLK_NOCPLL, true, TIMEOUT, false);
+	if (ret) {
+		printf("%s: NOCPLL is not locked\n", memory_type_in_use(dev));
+
+		goto err;
+	}
+
+	debug("%s: NOCPLL locked\n", memory_type_in_use(dev));
+
+	debug("%s: Checking calibration...\n", memory_type_in_use(dev));
+
+	if (is_ddr_in_use(dev)) {
+		/* Initiate IOSSM mailbox */
+		io96b_mb_init(io96b_ctrl);
+
+		/* Need to trigger re-calibration for DDR DBE */
+		if (ddr_ecc_dbe_status()) {
+			for (i = 0; i < io96b_ctrl->num_instance; i++)
+				io96b_ctrl->io96b[i].cal_status = false;
+
+			io96b_ctrl->overall_cal_status &= io96b_ctrl->io96b[i].cal_status;
+		}
+
+		/* Trigger re-calibration if calibration failed */
+		if (!(io96b_ctrl->overall_cal_status)) {
+			printf("DDR: Re-calibration in progress...\n");
+
+			trig_mem_cal(io96b_ctrl);
+		}
+
+		printf("DDR: Calibration success\n");
+
+		/* DDR type */
+		ret = get_mem_technology(io96b_ctrl);
+		if (ret) {
+			printf("DDR: Failed to get DDR type\n");
+
+			goto err;
+		}
+
+		/* DDR size */
+		ret = get_mem_width_info(io96b_ctrl);
+		if (ret) {
+			printf("DDR: Failed to get DDR size\n");
+
+			goto err;
+		}
+	} else {
+		/* Ensure calibration status passing */
+		uib_init_mem_cal(uib_ctrl);
+
+		/* Need to trigger re-calibration for HBM DBE */
+		if (ddr_ecc_dbe_status()) {
+			for (i = 0; i < uib_ctrl->num_instance; i++)
+				uib_ctrl->uib[i].cal_status = false;
+
+			uib_ctrl->overall_cal_status = false;
+		}
+
+		/* Trigger re-calibration if calibration failed */
+		if (!(uib_ctrl->overall_cal_status)) {
+			printf("HBM: Re-calibration in progress...\n");
+
+			uib_trig_mem_cal(uib_ctrl);
+		}
+
+		if (!(uib_ctrl->overall_cal_status)) {
+			printf("HBM: Retry calibration failed & not able to re-calibrate\n");
+
+			ret = -EINVAL;
+			goto err;
+		}
+
+		debug("HBM: Setting Error Mask Register\n");
+
+		/* Responder Error Mask Register */
+		for (i = 0; i < uib_ctrl->num_instance; i++) {
+			clrsetbits_le32(uib_ctrl->uib[i].uib_csr_addr +
+					UIB_R_ERRMSK_PSEUDO_CH0_OFFSET,
+					UIB_DRAM_SBE_MSK | UIB_INTERNAL_CORR_ERR_MSK,
+					UIB_DRAM_SBE(0x1) | UIB_INTERNAL_CORR_ERR(0x1));
+
+			debug("HBM: Error Mask Pseudo CH0 addr: 0x%llx\n",
+			      uib_ctrl->uib[i].uib_csr_addr +
+			      UIB_R_ERRMSK_PSEUDO_CH0_OFFSET);
+
+			debug("HBM: Error Mask Pseudo CH0 value: 0x%x\n",
+			      readl(uib_ctrl->uib[i].uib_csr_addr +
+			      UIB_R_ERRMSK_PSEUDO_CH0_OFFSET));
+
+			clrsetbits_le32(uib_ctrl->uib[i].uib_csr_addr +
+					UIB_R_ERRMSK_PSEUDO_CH1_OFFSET,
+					UIB_DRAM_SBE_MSK | UIB_INTERNAL_CORR_ERR_MSK,
+					UIB_DRAM_SBE(0x1) | UIB_INTERNAL_CORR_ERR(0x1));
+
+			debug("HBM: Error Mask Pseudo CH1 addr: 0x%llx\n",
+			      uib_ctrl->uib[i].uib_csr_addr +
+			      UIB_R_ERRMSK_PSEUDO_CH1_OFFSET);
+
+			debug("HBM: Error Mask Pseudo CH1 value: 0x%x\n\n",
+			      readl(uib_ctrl->uib[i].uib_csr_addr +
+			      UIB_R_ERRMSK_PSEUDO_CH1_OFFSET));
+		}
+
+		printf("HBM: Calibration success\n");
+	}
+
+	/* Get bank configuration from devicetree */
+	ret = fdtdec_decode_ram_size(gd->fdt_blob, NULL, 0, NULL,
+				     (phys_size_t *)&gd->ram_size, &bd);
+	if (ret) {
+		printf("%s: Failed to decode memory node\n", memory_type_in_use(dev));
+
+		goto err;
+	}
+
+	if (!is_ddr_in_use(dev))
+		hw_size = uib_ctrl->overall_size;
+	else
+		hw_size = (phys_size_t)io96b_ctrl->overall_size * SZ_1G / SZ_8;
+
+	if (gd->ram_size != hw_size) {
+		printf("%s: Warning: DRAM size from device tree (%lld MiB)\n",
+		       memory_type_in_use(dev), gd->ram_size >> 20);
+		printf(" mismatch with hardware (%lld MiB).\n",
+		       hw_size >> 20);
+	}
+
+	if (gd->ram_size > hw_size) {
+		printf("%s: Error: DRAM size from device tree is greater\n",
+		       memory_type_in_use(dev));
+		printf(" than hardware size.\n");
+
+		hang();
+	}
+
+	printf("%s: %lld MiB\n", (is_ddr_in_use(dev) ? io96b_ctrl->ddr_type : "HBM"),
+	       gd->ram_size >> 20);
+
+	if (is_ddr_in_use(dev)) {
+		/* ECC status */
+		ret = ecc_enable_status(io96b_ctrl);
+		if (ret) {
+			printf("DDR: Failed to get DDR ECC status\n");
+
+			goto err;
+		}
+
+		/*
+		 * Is HPS cold or warm reset? If yes, Skip full memory initialization if ECC
+		 * enabled to preserve memory content
+		 */
+		if (io96b_ctrl->ecc_status) {
+			full_mem_init = hps_ocram_dbe_status() | ddr_ecc_dbe_status() |
+					is_ddr_hang_be4_rst;
+			if (full_mem_init || !(reset_t == WARM_RESET || reset_t == COLD_RESET)) {
+				debug("%s: Needed to fully initialize DDR memory\n",
+				      io96b_ctrl->ddr_type);
+
+				ret = bist_mem_init_start(io96b_ctrl);
+				if (ret) {
+					printf("%s: Failed to fully initialize DDR memory\n",
+					       io96b_ctrl->ddr_type);
+
+					goto err;
+				}
+			}
+		}
+	} else {
+		debug("HBM: ECC enable status: %d\n", uib_ctrl->ecc_status);
+
+		/*
+		 * Is HPS cold or warm reset? If yes, Skip full memory initialization if ECC
+		 * enabled to preserve memory content
+		 */
+		if (uib_ctrl->ecc_status) {
+			full_mem_init = hps_ocram_dbe_status() | ddr_ecc_dbe_status() |
+					is_ddr_hang_be4_rst;
+			if (full_mem_init || !(reset_t == WARM_RESET || reset_t == COLD_RESET)) {
+				debug("HBM: Needed to fully initialize HBM memory\n");
+
+				ret = uib_bist_mem_init_start(uib_ctrl);
+				if (ret) {
+					printf("HBM: Failed to fully initialize HBM memory\n");
+
+					goto err;
+				}
+			}
+		}
+	}
+
+	/* Ensure sanity memory test passing */
+	sdram_size_check(&bd);
+
+	printf("%s: size check success\n", (is_ddr_in_use(dev) ? io96b_ctrl->ddr_type : "HBM"));
+
+	sdram_set_firewall(&bd);
+
+	printf("%s: firewall init success\n", (is_ddr_in_use(dev) ? io96b_ctrl->ddr_type : "HBM"));
+
+	priv->info.base = bd.bi_dram[0].start;
+	priv->info.size = gd->ram_size;
+
+	/* Ending DDR driver initialization success tracking */
+	ddr_init_inprogress(false);
+
+	printf("%s init success\n", (is_ddr_in_use(dev) ? io96b_ctrl->ddr_type : "HBM"));
+
+err:
+	free(io96b_ctrl);
+	free(uib_ctrl);
+
+	return ret;
+}
diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 4716abfc9a..a0cc9be25e 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2016-2022 Intel Corporation <www.intel.com>
- *
+ * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
  */
 
 #include <common.h>
@@ -28,6 +27,7 @@
 
 #define PGTABLE_OFF	0x4000
 
+#if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 u32 hmc_readl(struct altera_sdram_plat *plat, u32 reg)
 {
 	return readl(plat->iomhc + reg);
@@ -99,6 +99,7 @@ int emif_reset(struct altera_sdram_plat *plat)
 	debug("DDR: %s triggered successly\n", __func__);
 	return 0;
 }
+#endif
 
 #if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 int poll_hmc_clock_status(void)
@@ -322,7 +323,12 @@ static int altera_sdram_of_to_plat(struct udevice *dev)
 	/* These regs info are part of DDR handoff in bitstream */
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 	return 0;
-#endif
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
+	addr = dev_read_addr_index(dev, 0);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	plat->mpfe_base_addr = addr;
+#else
 
 	addr = dev_read_addr_index(dev, 0);
 	if (addr == FDT_ADDR_T_NONE)
@@ -338,7 +344,7 @@ static int altera_sdram_of_to_plat(struct udevice *dev)
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 	plat->hmc = (void __iomem *)addr;
-
+#endif
 	return 0;
 }
 
@@ -385,6 +391,7 @@ static const struct udevice_id altera_sdram_ids[] = {
 	{ .compatible = "altr,sdr-ctl-s10" },
 	{ .compatible = "intel,sdr-ctl-agilex" },
 	{ .compatible = "intel,sdr-ctl-n5x" },
+	{ .compatible = "intel,sdr-ctl-agilex7m" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
index 87a70a861b..02019ac9e5 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2017-2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
  */
 
 #ifndef	_SDRAM_SOC64_H_
@@ -13,11 +13,24 @@ struct altera_sdram_priv {
 	struct reset_ctl_bulk resets;
 };
 
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
+enum memory_type {
+	DDR_MEMORY = 0,
+	HBM_MEMORY
+};
+
+struct altera_sdram_plat {
+	fdt_addr_t mpfe_base_addr;
+	bool multichannel_interleaving;
+	enum memory_type mem_type;
+};
+#else
 struct altera_sdram_plat {
 	void __iomem *hmc;
 	void __iomem *ddr_sch;
 	void __iomem *iomhc;
 };
+#endif
 
 /* ECC HMC registers */
 #define DDRIOCTRL			0x8
-- 
2.25.1

