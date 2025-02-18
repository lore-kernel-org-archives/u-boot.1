Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EB9C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 862EB80BAE;
	Tue, 18 Feb 2025 09:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mgDkCXJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD488043C; Tue, 18 Feb 2025 09:35:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BDE1809A4
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867722; x=1771403722;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AebtSrK3f43qqqYvorxXdDR078f0RiTz4mhJDwU8Upc=;
 b=mgDkCXJ2W2UUjLjtJOoNccJ9xzrpz7InmmfJ9nbtEbN58KBUhbg4KrBr
 8KR48iyu44Bi1yxSG7fre7v2uk6oknqRTpIIoCfSHBHcdPUZA/jlLjBsK
 240kicP6zxtvY4rTA29cjh5VgYsudN55BYeRh8e3E8Vgq3wclqPtgJo41
 tj35tTLq09Mmh1jbQzlHAI5+icqsYa1zpKdhs/n4hDkj41ROmb3tINph/
 /KnX0zE1BTNrDt8YhP/n8enbAhqU5xIpF1EUAxES/pAiVo+vO3JF8kNHr
 FC8G9hToW7nRkhqVGJ06QQ/5BJZ2+Km31Q3KUU9UmTnqXGk+D1zgWf6i7 A==;
X-CSE-ConnectionGUID: xNb9YuPERUK/voBvvRoLeA==
X-CSE-MsgGUID: b+DjtYj4S1imTySuZWrYOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028093"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028093"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:21 -0800
X-CSE-ConnectionGUID: BpcsVNTAS7ewrIgZBX0cBw==
X-CSE-MsgGUID: gzv4sBVNQ4Kri/gmQLhQHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237649"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:19 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model for
 system manager in Agilex5
Date: Tue, 18 Feb 2025 16:34:46 +0800
Message-Id: <20250218083511.29249-2-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

Initial creation of new system manager driver.

Add supports for the SOCFPGA System Manager Register block which
aggregates different peripheral function into one area.
On 64 bit ARM parts, the system manager only can be accessed during
EL3 mode, this driver model provide user the high level access
to system register and abstract user from low level access.

The base address of system manager can be retrieved
using DT framework through the System Manager driver.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>

---

v1->v2
- Implement system manager driver to move towards DT probing
---
 arch/arm/mach-socfpga/Makefile                |   3 +-
 arch/arm/mach-socfpga/altera-sysmgr.c         | 113 ++++++++++++++++
 .../mach-socfpga/include/mach/altera-sysmgr.h |  16 +++
 arch/arm/mach-socfpga/include/mach/misc.h     |   2 +
 .../include/mach/system_manager_soc64.h       | 128 ++++++++++++------
 arch/arm/mach-socfpga/misc.c                  |  18 ++-
 board/intel/agilex5-socdk/Makefile            |   7 +
 board/intel/agilex5-socdk/socfpga.c           |  12 ++
 configs/socfpga_agilex5_defconfig             |   1 +
 9 files changed, 250 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/altera-sysmgr.c
 create mode 100644 arch/arm/mach-socfpga/include/mach/altera-sysmgr.h
 create mode 100644 board/intel/agilex5-socdk/Makefile
 create mode 100644 board/intel/agilex5-socdk/socfpga.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 5fc61b4a5c6..edf2356c411 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -3,12 +3,13 @@
 # (C) Copyright 2000-2003
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
-# Copyright (C) 2012-2017 Altera Corporation <www.altera.com>
+# Copyright (C) 2012-2025 Altera Corporation <www.altera.com>
 # Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
 
 obj-y	+= board.o
 obj-y	+= clock_manager.o
 obj-y	+= misc.o
+obj-y	+= altera-sysmgr.o
 
 ifdef CONFIG_TARGET_SOCFPGA_GEN5
 obj-y	+= clock_manager_gen5.o
diff --git a/arch/arm/mach-socfpga/altera-sysmgr.c b/arch/arm/mach-socfpga/altera-sysmgr.c
new file mode 100644
index 00000000000..ca3f5ca7dd5
--- /dev/null
+++ b/arch/arm/mach-socfpga/altera-sysmgr.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+/*
+ * This driver supports the SOCFPGA System Manager Register block which
+ * aggregates different peripheral function into one area.
+ * On 64 bit ARM parts, the system manager only can be accessed during
+ * EL3 mode. At lower exception level a SMC call is required to perform
+ * the read and write operation.
+ */
+
+#define LOG_CATEGORY UCLASS_NOP
+
+#include <dm.h>
+#include <log.h>
+#include <misc.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/arch/altera-sysmgr.h>
+#include <asm/arch/smc_api.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/intel-smc.h>
+
+static int altr_sysmgr_read_generic(struct udevice *dev, u32 *addr, u32 *value)
+{
+	u64 args[1];
+	u64 ret_arg;
+	int ret = 0;
+
+	debug("%s: %s(dev=%p, addr=0x%lx):\n", __func__,
+	      dev->name, dev, (uintptr_t)addr);
+
+	if (current_el() == 3) {
+		ret_arg = readl((uintptr_t)addr);
+	} else {
+		if (!(IS_ENABLED(CONFIG_SPL_BUILD)) && IS_ENABLED(CONFIG_SPL_ATF)) {
+			args[0] = (u64)(uintptr_t)addr;
+			ret = invoke_smc(INTEL_SIP_SMC_REG_READ, args, 1, &ret_arg, 1);
+		} else {
+			pr_err("%s Failed to read system manager at lower privilege and without BL31\n",
+			       dev->name);
+			return -EPROTONOSUPPORT;
+		}
+	}
+
+	*value = (u32)ret_arg;
+	return ret;
+}
+
+static int altr_sysmgr_write_generic(struct udevice *dev, u32 *addr, u32 value)
+{
+	u64 args[2];
+	int ret = 0;
+
+	debug("%s: %s(dev=%p, addr=0x%lx, val=0x%x):\n", __func__,
+	      dev->name, dev, (uintptr_t)addr, value);
+
+	if (current_el() == 3) {
+		writel(value, (uintptr_t)addr);
+	} else {
+		if (!(IS_ENABLED(CONFIG_SPL_BUILD)) && IS_ENABLED(CONFIG_SPL_ATF)) {
+			args[0] = (u64)(uintptr_t)(addr);
+			args[1] = value;
+			ret = invoke_smc(INTEL_SIP_SMC_REG_WRITE, args, 2, NULL, 0);
+		} else {
+			pr_err("%s Failed to write to system manager at lower privilege and without BL31\n",
+			       dev->name);
+			return -EPROTONOSUPPORT;
+		}
+	}
+
+	return ret;
+}
+
+static int altr_sysmgr_probe(struct udevice *dev)
+{
+	fdt_addr_t addr;
+	struct altr_sysmgr_priv *altr_priv = dev_get_priv(dev);
+
+	debug("%s: %s(dev=%p):\n", __func__, dev->name, dev);
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE) {
+		pr_err("%s dev_read_addr() failed\n", dev->name);
+		return -ENODEV;
+	}
+
+	altr_priv->regs = (void __iomem *)addr;
+	return 0;
+}
+
+static const struct altr_sysmgr_ops sysmgr_ops = {
+	.read = altr_sysmgr_read_generic,
+	.write = altr_sysmgr_write_generic,
+};
+
+static const struct udevice_id altr_sysmgr_ids[] = {
+	{ .compatible = "altr,sys-mgr-s10" },
+	{ .compatible = "altr,sys-mgr" },
+	{ },
+};
+
+U_BOOT_DRIVER(altr_sysmgr) = {
+	.name	= "altr_sysmgr",
+	.id	= UCLASS_NOP,
+	.of_match = altr_sysmgr_ids,
+	.probe	= altr_sysmgr_probe,
+	.ops	= &sysmgr_ops,
+	.priv_auto = sizeof(struct altr_sysmgr_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/arch/arm/mach-socfpga/include/mach/altera-sysmgr.h b/arch/arm/mach-socfpga/include/mach/altera-sysmgr.h
new file mode 100644
index 00000000000..8516617efe5
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/altera-sysmgr.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+struct altr_sysmgr_ops {
+	int (*read)(struct udevice *dev, u32 *addr, u32 *value);
+	int (*write)(struct udevice *dev, u32 *addr, u32 value);
+};
+
+struct altr_sysmgr_priv {
+	void __iomem *regs;
+};
+
+#define altr_sysmgr_get_ops(dev)        ((struct altr_sysmgr_ops *)(dev)->driver->ops)
+#define altr_sysmgr_get_priv(dev)	((struct altr_sysmgr_priv *)(dev_get_priv(dev)))
diff --git a/arch/arm/mach-socfpga/include/mach/misc.h b/arch/arm/mach-socfpga/include/mach/misc.h
index 8460acb00d9..ab46415168f 100644
--- a/arch/arm/mach-socfpga/include/mach/misc.h
+++ b/arch/arm/mach-socfpga/include/mach/misc.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2016-2021 Intel Corporation
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #ifndef _SOCFPGA_MISC_H_
@@ -51,6 +52,7 @@ bool is_periph_program_force(void);
 void set_regular_boot(unsigned int status);
 void socfpga_pl310_clear(void);
 void socfpga_get_managers_addr(void);
+void socfpga_get_sys_mgr_addr(const char *compat);
 int qspi_flash_software_reset(void);
 
 #endif /* _SOCFPGA_MISC_H_ */
diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index a8009664fee..0266dc82bd5 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2019-2021 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #ifndef _SYSTEM_MANAGER_SOC64_H_
@@ -11,22 +12,43 @@ void sysmgr_pinmux_init(void);
 void populate_sysmgr_fpgaintf_module(void);
 void populate_sysmgr_pinmux(void);
 
-#define SYSMGR_SOC64_WDDBG			0x08
-#define SYSMGR_SOC64_DMA			0x20
-#define SYSMGR_SOC64_DMA_PERIPH			0x24
-#define SYSMGR_SOC64_SDMMC			0x28
-#define SYSMGR_SOC64_SDMMC_L3MASTER		0x2c
-#define SYSMGR_SOC64_EMAC_GLOBAL		0x40
-#define SYSMGR_SOC64_EMAC0			0x44
-#define SYSMGR_SOC64_EMAC1			0x48
-#define SYSMGR_SOC64_EMAC2			0x4c
-#define SYSMGR_SOC64_EMAC0_ACE			0x50
-#define SYSMGR_SOC64_EMAC1_ACE			0x54
-#define SYSMGR_SOC64_EMAC2_ACE			0x58
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define SYSMGR_SOC64_SILICONID_1		0x00
+#define SYSMGR_SOC64_SILICONID_2		0x04
+#define SYSMGR_SOC64_MPU_STATUS			0x10
+#define SYSMGR_SOC64_COMBOPHY_DFISEL		0xfc
+#define SYSMGR_SOC64_COMBOPHY_DFISEL_SDMMC	0x1
+#define SYSMGR_SOC64_NANDGRP_L3MASTER		0x34
+#define SYSMGR_SOC64_USB0_L3MASTER		0x38
+#define SYSMGR_SOC64_USB1_L3MASTER		0x3c
+#define SYSMGR_SOC64_DMAC0_L3_MASTER		0x74
+#define SYSMGR_SOC64_ETR_L3_MASTER		0x78
+#define SYSMGR_SOC64_DMAC1_L3_MASTER		0x7C
+#define SYSMGR_SOC64_SEC_CTRL_SLT		0x80
+#define SYSMGR_SOC64_OSC_TRIM			0x84
+#define SYSMGR_SOC64_DMAC0_CTRL_STATUS_REG	0x88
+#define SYSMGR_SOC64_DMAC1_CTRL_STATUS_REG	0x8C
+#define SYSMGR_SOC64_ECC_INTMASK_VALUE		0x90
+#define SYSMGR_SOC64_ECC_INTMASK_SET		0x94
+#define SYSMGR_SOC64_ECC_INTMASK_CLR		0x98
+#define SYSMGR_SOC64_ECC_INTMASK_SERR		0x9C
+#define SYSMGR_SOC64_ECC_INTMASK_DERR		0xA0
+#define SYSMGR_SOC64_MPFE_CONFIG		0x228
+#define SYSMGR_SOC64_BOOT_SCRATCH_POR0		0x258
+#define SYSMGR_SOC64_BOOT_SCRATCH_POR1		0x25C
+#define SYSMGR_SCRATCH_REG_0_QSPI_REFCLK_MASK		GENMASK(31, 0)
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_RESET_TYPE_MASK	GENMASK(31, 29)
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_RESET_TYPE_SHIFT	29
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_PORT_INFO_MASK	BIT(27)
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_EMIF_INFO_MASK	BIT(28)
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_PORT_EMIF_INFO_MASK	GENMASK(28, 27)
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_DBE_MASK	BIT(1)
+#define ALT_SYSMGR_SCRATCH_REG_3_OCRAM_DBE_MASK	BIT(0)
+#define ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK	BIT(0)
+#define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_USER_MODE_MASK	BIT(0)
+#define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_MASK	BIT(1)
+#else
 #define SYSMGR_SOC64_NAND_AXUSER		0x5c
-#define SYSMGR_SOC64_FPGAINTF_EN1		0x68
-#define SYSMGR_SOC64_FPGAINTF_EN2		0x6c
-#define SYSMGR_SOC64_FPGAINTF_EN3		0x70
 #define SYSMGR_SOC64_DMA_L3MASTER		0x74
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 #define SYSMGR_SOC64_DDR_MODE			0xb8
@@ -34,39 +56,56 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_HMC_CLK			0xb4
 #define SYSMGR_SOC64_IO_PA_CTRL			0xb8
 #endif
-#define SYSMGR_SOC64_NOC_TIMEOUT		0xc0
-#define SYSMGR_SOC64_NOC_IDLEREQ_SET		0xc4
-#define SYSMGR_SOC64_NOC_IDLEREQ_CLR		0xc8
-#define SYSMGR_SOC64_NOC_IDLEREQ_VAL		0xcc
-#define SYSMGR_SOC64_NOC_IDLEACK		0xd0
-#define SYSMGR_SOC64_NOC_IDLESTATUS		0xd4
-#define SYSMGR_SOC64_FPGA2SOC_CTRL		0xd8
-#define SYSMGR_SOC64_FPGA_CONFIG		0xdc
 #define SYSMGR_SOC64_IOCSRCLK_GATE		0xe0
 #define SYSMGR_SOC64_GPO			0xe4
 #define SYSMGR_SOC64_GPI			0xe8
 #define SYSMGR_SOC64_MPU			0xf0
-/*
- * Bits[31:28] reserved for N5X DDR retention, bits[27:0] reserved for SOC 64-bit
- * storing qspi ref clock (kHz)
- */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD0		0x200
-/* store osc1 clock freq */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD1		0x204
-/* store fpga clock freq */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD2		0x208
-/* reserved for customer use */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD3		0x20c
-/* store PSCI_CPU_ON value */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD4		0x210
-/* store PSCI_CPU_ON value */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD5		0x214
-/* store VBAR_EL3 value */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD6		0x218
-/* store VBAR_EL3 value */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD7		0x21c
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD8		0x220
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD9		0x224
+#define SYSMGR_SCRATCH_REG_0_QSPI_REFCLK_MASK	GENMASK(27, 0)
+#endif /*CONFIG_TARGET_SOCFPGA_AGILEX5*/
+
+#define SYSMGR_SOC64_DMA			0x20
+#define SYSMGR_SOC64_DMA_PERIPH			0x24
+#define SYSMGR_SOC64_WDDBG			0x08
+#define SYSMGR_SOC64_SDMMC			0x28
+#define SYSMGR_SOC64_SDMMC_L3MASTER		0x2C
+#define SYSMGR_SOC64_FPGAINTF_EN1		0x68
+#define SYSMGR_SOC64_FPGAINTF_EN2		0x6C
+#define SYSMGR_SOC64_FPGAINTF_EN3		0x70
+#define SYSMGR_SOC64_NOC_TIMEOUT		0xC0
+#define SYSMGR_SOC64_NOC_IDLEREQ_SET		0xC4
+#define SYSMGR_SOC64_NOC_IDLEREQ_CLR		0xC8
+#define SYSMGR_SOC64_NOC_IDLEREQ_VAL		0xCC
+#define SYSMGR_SOC64_NOC_IDLEACK		0xd0
+#define SYSMGR_SOC64_NOC_IDLESTATUS		0xD4
+#define SYSMGR_SOC64_FPGA2SOC_CTRL		0xD8
+#define SYSMGR_SOC64_FPGA_CONFIG		0xDC
+
+#define SYSMGR_SOC64_TSN_GLOBAL			0x40
+#define SYSMGR_SOC64_TSN_0			0x44
+#define SYSMGR_SOC64_TSN_1			0x48
+#define SYSMGR_SOC64_TSN_2			0x4C
+#define SYSMGR_SOC64_TSN_0_ACE			0x50
+#define SYSMGR_SOC64_TSN_1_ACE			0x54
+#define SYSMGR_SOC64_TSN_2_ACE			0x58
+#define SYSMGR_SOC64_EMAC_GLOBAL	SYSMGR_SOC64_TSN_GLOBAL
+#define SYSMGR_SOC64_EMAC0		SYSMGR_SOC64_TSN_0
+#define SYSMGR_SOC64_EMAC1		SYSMGR_SOC64_TSN_1
+#define SYSMGR_SOC64_EMAC2		SYSMGR_SOC64_TSN_2
+#define SYSMGR_SOC64_EMAC0_ACE		SYSMGR_SOC64_TSN_0_ACE
+#define SYSMGR_SOC64_EMAC1_ACE		SYSMGR_SOC64_TSN_1_ACE
+#define SYSMGR_SOC64_EMAC2_ACE		SYSMGR_SOC64_TSN_2_ACE
+
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD0	0x200
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD1	0x204
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD2	0x208
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD3	0x20C
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD4	0x210
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD5	0x214
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD6	0x218
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD7	0x21C
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD8	0x220
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD9	0x224
+
 #define SYSMGR_SOC64_PINSEL0			0x1000
 #define SYSMGR_SOC64_IOCTRL0			0x1130
 #define SYSMGR_SOC64_EMAC0_USEFPGA		0x1300
@@ -97,7 +136,6 @@ void populate_sysmgr_pinmux(void);
  * Bits[31:28] reserved for DM DDR retention, bits[27:0] reserved for SOC 64-bit
  * storing qspi ref clock (kHz)
  */
-#define SYSMGR_SCRATCH_REG_0_QSPI_REFCLK_MASK		GENMASK(27, 0)
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_RETENTION_MASK	BIT(31)
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_SHA_MASK		BIT(30)
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_MASK	(BIT(29) | BIT(28))
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 46f9c82bbb2..9d464307665 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -248,10 +248,6 @@ void socfpga_get_managers_addr(void)
 	if (ret)
 		hang();
 
-	ret = socfpga_get_base_addr("altr,sys-mgr", &socfpga_sysmgr_base);
-	if (ret)
-		hang();
-
 #ifdef CONFIG_TARGET_SOCFPGA_AGILEX
 	ret = socfpga_get_base_addr("intel,agilex-clkmgr",
 				    &socfpga_clkmgr_base);
@@ -265,6 +261,20 @@ void socfpga_get_managers_addr(void)
 		hang();
 }
 
+void socfpga_get_sys_mgr_addr(const char *compat)
+{
+	int ret;
+	struct udevice *sysmgr_dev;
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, compat, &sysmgr_dev);
+	if (ret) {
+		printf("Altera system manager init failed: %d\n", ret);
+		hang();
+	} else {
+		socfpga_sysmgr_base = (phys_addr_t)dev_read_addr(sysmgr_dev);
+	}
+}
+
 phys_addr_t socfpga_get_rstmgr_addr(void)
 {
 	return socfpga_rstmgr_base;
diff --git a/board/intel/agilex5-socdk/Makefile b/board/intel/agilex5-socdk/Makefile
new file mode 100644
index 00000000000..306a8cf5f0b
--- /dev/null
+++ b/board/intel/agilex5-socdk/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2025 Altera Corporation <www.altera.com>
+#
+# SPDX-License-Identifier:	GPL-2.0
+#
+
+obj-y	:= socfpga.o
diff --git a/board/intel/agilex5-socdk/socfpga.c b/board/intel/agilex5-socdk/socfpga.c
new file mode 100644
index 00000000000..d6628cfc696
--- /dev/null
+++ b/board/intel/agilex5-socdk/socfpga.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <asm/arch/misc.h>
+
+int board_early_init_f(void)
+{
+	socfpga_get_sys_mgr_addr("sysmgr@10d12000");
+	return 0;
+}
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 8577ac610c2..60e625ea805 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -88,3 +88,4 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+CONFIG_BOARD_EARLY_INIT_F=y
-- 
2.25.1

