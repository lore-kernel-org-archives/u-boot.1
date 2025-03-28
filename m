Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C16FC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344888070C;
	Fri, 28 Mar 2025 13:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R8b3/NVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A3AB81DDF; Fri, 28 Mar 2025 13:31:44 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49897810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52SCVa6U2147783
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Mar 2025 07:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743165096;
 bh=lU6nKmjFZnNoX2O2XG5I2Ok7GFg3lDlrBwBEwBga6Wc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=R8b3/NVkzO4fMI1iUvMVRI+j0/xJJAAX+B+yrRoj1JFFyjBjmczVBXkLT/oPIgdxy
 tND69Qo0meXCYVbFaQGXtOIK6kp/4Yb4TZEDpSSmD1fCsB675RAZVZMdmevhGaEwQN
 QJe23yD3/Us8zPUoiDLmftQpWYVAKdYu41Hp/ttw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52SCVaq2125563
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Mar 2025 07:31:36 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Mar 2025 07:31:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Mar 2025 07:31:36 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SCVSY0020922;
 Fri, 28 Mar 2025 07:31:32 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v3 1/3] drivers: misc: k3_bist: Add K3 BIST driver
Date: Fri, 28 Mar 2025 18:01:25 +0530
Message-ID: <20250328123127.497971-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328123127.497971-1-n-francis@ti.com>
References: <20250328123127.497971-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add a driver for the BIST module that support triggering of both PBIST
(Memory BIST) and LBIST (Logic BIST) tests. Also expose the relevant
operations and functions that would be required for an end user to
trigger the tests.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Changes since v2:
- code cleanup and minor optimizations
- reorder patch with DONOTMERGE at the end

 drivers/misc/Kconfig                      |   8 +
 drivers/misc/Makefile                     |   1 +
 drivers/misc/k3_bist.c                    | 805 ++++++++++++++++++++++
 drivers/misc/k3_bist_static_data.h        | 673 ++++++++++++++++++
 drivers/misc/k3_j784s4_bist_static_data.h | 388 +++++++++++
 include/k3_bist.h                         |  44 ++
 6 files changed, 1919 insertions(+)
 create mode 100644 drivers/misc/k3_bist.c
 create mode 100644 drivers/misc/k3_bist_static_data.h
 create mode 100644 drivers/misc/k3_j784s4_bist_static_data.h
 create mode 100644 include/k3_bist.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index da84b35e804..1ab4aecf6b3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -664,6 +664,14 @@ config ESM_K3
 	help
 	  Support ESM (Error Signaling Module) on TI K3 SoCs.
 
+config K3_BIST
+	bool "Enable K3 BIST driver"
+	depends on ARCH_K3
+	help
+	  Support BIST (Built-In Self Test) module on TI K3 SoCs. This driver
+	  supports running both PBIST (Memory BIST) and LBIST (Logic BIST) on
+	  a region or IP in the SoC.
+
 config MICROCHIP_FLEXCOM
 	bool "Enable Microchip Flexcom driver"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index dac805e4cdd..c9100c93c3c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_JZ4780_EFUSE) += jz4780_efuse.o
 obj-$(CONFIG_MICROCHIP_FLEXCOM) += microchip_flexcom.o
 obj-$(CONFIG_K3_AVS0) += k3_avs.o
 obj-$(CONFIG_ESM_K3) += k3_esm.o
+obj-$(CONFIG_K3_BIST) += k3_bist.o
 obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
 obj-$(CONFIG_SL28CPLD) += sl28cpld.o
 obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
diff --git a/drivers/misc/k3_bist.c b/drivers/misc/k3_bist.c
new file mode 100644
index 00000000000..2e2483240a4
--- /dev/null
+++ b/drivers/misc/k3_bist.c
@@ -0,0 +1,805 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments' BIST (Built-In Self-Test) driver
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ *      Neha Malcom Francis <n-francis@ti.com>
+ *
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <clk.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <asm/arch/hardware.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include <remoteproc.h>
+#include <power-domain.h>
+#include <k3_bist.h>
+
+#include "k3_bist_static_data.h"
+
+/* PBIST Timeout Value */
+#define PBIST_MAX_TIMEOUT_VALUE		100000000
+
+/**
+ * struct k3_bist_privdata - K3 BIST structure
+ * @dev: device pointer
+ * @pbist_base: base of register set for PBIST
+ * @instance: PBIST instance number
+ * @intr_num: corresponding interrupt ID of the PBIST instance
+ * @lbist_ctrl_mmr: base of CTRL MMR register set for LBIST
+ */
+struct k3_bist_privdata {
+	struct udevice *dev;
+	void *pbist_base;
+	u32 instance;
+	u32 intr_num;
+	void *lbist_ctrl_mmr;
+	struct pbist_inst_info *pbist_info;
+	struct lbist_inst_info *lbist_info;
+};
+
+static struct k3_bist_privdata *k3_bist_priv;
+
+/**
+ * check_post_pbist_result() - Check POST results
+ *
+ * Function to check whether HW Power-On Self Test, i.e. POST has run
+ * successfully on the MCU domain.
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static int check_post_pbist_result(void)
+{
+	bool is_done, timed_out;
+	u32 mask;
+	u32 post_reg_val, shift;
+
+	/* Read HW POST status register */
+	post_reg_val = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT);
+
+	/* Check if HW POST PBIST was performed */
+	shift = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_DONE_SHIFT;
+	is_done = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? (bool)true : (bool)false;
+
+	if (!is_done) {
+		/* HW POST: PBIST not completed, check if it timed out */
+		shift = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_TIMEOUT_SHIFT;
+		timed_out = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? (bool)true : (bool)false;
+
+		if (!timed_out) {
+			printf("%s: PBIST was not performed at all on this device for this core\n",
+			       __func__);
+			return -EINVAL;
+		}
+		printf("%s: PBIST was attempted but timed out for this section\n",
+		       __func__);
+		return -ETIMEDOUT;
+
+	} else {
+		/* HW POST: PBIST was completed on this device, check the result */
+		mask = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_FAIL_MASK;
+
+		if ((post_reg_val & mask) != 0) {
+			printf("%s: PBIST was completed, but the test failed\n", __func__);
+			return -EINVAL;
+		}
+		debug("%s: HW POST PBIST completed, test passed\n", __func__);
+	}
+
+	return 0;
+}
+
+/**
+ * check_post_lbist_result() - Check POST results
+ *
+ * Function to check whether HW Power-On Self Test, i.e. POST has run
+ * successfully on the MCU domain.
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static int check_post_lbist_result(void)
+{
+	bool is_done, timed_out;
+	u32 post_reg_val, shift;
+	u32 calculated_misr;
+
+	/* Read HW POST status register */
+	post_reg_val = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT);
+
+	/* Check if HW POST LBIST was performed */
+	shift = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_LBIST_DONE_SHIFT;
+	is_done = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? (bool)true : (bool)false;
+
+	if (!is_done) {
+		/* HW POST: PBIST not completed, check if it timed out */
+		shift = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_LBIST_TIMEOUT_SHIFT;
+		timed_out = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? (bool)true : (bool)false;
+
+		if (!timed_out) {
+			printf("%s: PBIST was not performed at all on this device for this core\n",
+			       __func__);
+			return -EINVAL;
+		}
+		printf("%s: PBIST was attempted but timed out for this section\n",
+		       __func__);
+		return -ETIMEDOUT;
+
+	} else {
+		/* Get the output MISR and the expected MISR which 0 for MCU domain */
+		lbist_get_misr((void *)MCU_LBIST_BASE, &calculated_misr);
+
+		if (calculated_misr) {
+			/* HW POST: LBIST was completed, but the test failed for this core */
+			printf("%s: calculated MISR != expected MISR\n", __func__);
+			debug("%s: calculated MISR = %x\n", __func__, calculated_misr);
+			return -EINVAL;
+		}
+		debug("%s: HW POST LBIST completed, test passed\n", __func__);
+	}
+	return 0;
+}
+
+/**
+ * pbist_self_test() - Run PBIST_TEST on specified cores
+ * @config: pbist_config structure for PBIST test
+ *
+ * Function to run PBIST_TEST
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static int pbist_self_test(struct pbist_config *config)
+{
+	void *base = k3_bist_priv->pbist_base;
+
+	/* Turns on PBIST clock in PBIST ACTivate register */
+	writel(PBIST_PACT_PACT_MASK, base + PBIST_PACT);
+
+	/* Set Margin mode register for Test mode */
+	writel(PBIST_TEST_MODE, base + PBIST_MARGIN_MODE);
+
+	/* Zero out Loop counter 0 */
+	writel(0x0, base + PBIST_L0);
+
+	/* Set algorithm bitmap */
+	writel(config->algorithms_bit_map, base + PBIST_ALGO);
+
+	/* Set Memory group bitmap */
+	writel(config->memory_groups_bit_map, base + PBIST_RINFO);
+
+	/* Zero out override register */
+	writel(config->override, base + PBIST_OVER);
+
+	/* Set Scramble value - 64 bit*/
+	writel(config->scramble_value_lo, base + PBIST_SCR_LO);
+	writel(config->scramble_value_hi, base + PBIST_SCR_HI);
+
+	/* Set DLR register for ROM based testing and Config Access */
+	writel(PBIST_DLR_DLR0_ROM_MASK
+	| PBIST_DLR_DLR0_CAM_MASK, base + PBIST_DLR);
+
+	/* Allow time for completion of test*/
+	udelay(1000);
+
+	if (readl(base + PBIST_FSRF)) {
+		printf("%s: test failed\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * pbist_neg_self_test() - Run PBIST_negTEST on specified cores
+ * @config: pbist_config_neg structure for PBIST negative test
+ *
+ * Function to run PBIST failure insertion test
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static int pbist_neg_self_test(struct pbist_config_neg *config)
+{
+	void *base = k3_bist_priv->pbist_base;
+
+	/* Turns on PBIST clock in PBIST ACTivate register */
+	writel(PBIST_PACT_PACT_MASK, base + PBIST_PACT);
+
+	/* Set Margin mode register for Test mode */
+	writel(PBIST_FAILURE_INSERTION_TEST_MODE, base + PBIST_MARGIN_MODE);
+
+	/* Zero out Loop counter 0 */
+	writel(0x0, base + PBIST_L0);
+
+	/* Set DLR register */
+	writel(0x10, base + PBIST_DLR);
+
+	/* Set Registers*/
+	writel(0x00000001, base + PBIST_RF0L);
+	writel(0x00003123, base + PBIST_RF0U);
+	writel(0x0513FC02, base + PBIST_RF1L);
+	writel(0x00000002, base + PBIST_RF1U);
+	writel(0x00000003, base + PBIST_RF2L);
+	writel(0x00000000, base + PBIST_RF2U);
+	writel(0x00000004, base + PBIST_RF3L);
+	writel(0x00000028, base + PBIST_RF3U);
+	writel(0x64000044, base + PBIST_RF4L);
+	writel(0x00000000, base + PBIST_RF4U);
+	writel(0x0006A006, base + PBIST_RF5L);
+	writel(0x00000000, base + PBIST_RF5U);
+	writel(0x00000007, base + PBIST_RF6L);
+	writel(0x0000A0A0, base + PBIST_RF6U);
+	writel(0x00000008, base + PBIST_RF7L);
+	writel(0x00000064, base + PBIST_RF7U);
+	writel(0x00000009, base + PBIST_RF8L);
+	writel(0x0000A5A5, base + PBIST_RF8U);
+	writel(0x0000000A, base + PBIST_RF9L);
+	writel(0x00000079, base + PBIST_RF9U);
+	writel(0x00000000, base + PBIST_RF10L);
+	writel(0x00000001, base + PBIST_RF10U);
+	writel(0xAAAAAAAA, base + PBIST_D);
+	writel(0xAAAAAAAA, base + PBIST_E);
+
+	writel(config->CA2, base + PBIST_CA2);
+	writel(config->CL0, base + PBIST_CL0);
+	writel(config->CA3, base + PBIST_CA3);
+	writel(config->I0, base + PBIST_I0);
+	writel(config->CL1, base + PBIST_CL1);
+	writel(config->I3, base + PBIST_I3);
+	writel(config->I2, base + PBIST_I2);
+	writel(config->CL2, base + PBIST_CL2);
+	writel(config->CA1, base + PBIST_CA1);
+	writel(config->CA0, base + PBIST_CA0);
+	writel(config->CL3, base + PBIST_CL3);
+	writel(config->I1, base + PBIST_I1);
+	writel(config->RAMT, base + PBIST_RAMT);
+	writel(config->CSR, base + PBIST_CSR);
+	writel(config->CMS, base + PBIST_CMS);
+
+	writel(0x00000009, base + PBIST_STR);
+
+	/* Start PBIST */
+	writel(0x00000001, base + PBIST_STR);
+
+	/* Allow time for completion of test*/
+	udelay(1000);
+
+	if (readl(base + PBIST_FSRF) == 0) {
+		printf("%s: test failed\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * pbist_rom_self_test() - Run PBIST_ROM_TEST on specified cores
+ * @config: pbist_config_rom structure for PBIST negative test
+ *
+ * Function to run PBIST test of ROM
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static int pbist_rom_self_test(struct pbist_config_rom *config)
+{
+	void *base = k3_bist_priv->pbist_base;
+
+	/* Turns on PBIST clock in PBIST ACTivate register */
+	writel(0x1, base + PBIST_PACT);
+
+	/* Set Margin mode register for Test mode */
+	writel(0xf, base + PBIST_MARGIN_MODE);
+
+	/* Zero out Loop counter 0 */
+	writel(0x0, base + PBIST_L0);
+
+	/* Set DLR register */
+	writel(0x310, base + PBIST_DLR);
+
+	/* Set Registers*/
+	writel(0x00000001, base + PBIST_RF0L);
+	writel(0x00003123, base + PBIST_RF0U);
+	writel(0x7A400183, base + PBIST_RF1L);
+	writel(0x00000060, base + PBIST_RF1U);
+	writel(0x00000184, base + PBIST_RF2L);
+	writel(0x00000000, base + PBIST_RF2U);
+	writel(0x7B600181, base + PBIST_RF3L);
+	writel(0x00000061, base + PBIST_RF3U);
+	writel(0x00000000, base + PBIST_RF4L);
+	writel(0x00000000, base + PBIST_RF4U);
+
+	writel(config->D, base + PBIST_D);
+	writel(config->E, base + PBIST_E);
+	writel(config->CA2, base + PBIST_CA2);
+	writel(config->CL0, base + PBIST_CL0);
+	writel(config->CA3, base + PBIST_CA3);
+	writel(config->I0, base + PBIST_I0);
+	writel(config->CL1, base + PBIST_CL1);
+	writel(config->I3, base + PBIST_I3);
+	writel(config->I2, base + PBIST_I2);
+	writel(config->CL2, base + PBIST_CL2);
+	writel(config->CA1, base + PBIST_CA1);
+	writel(config->CA0, base + PBIST_CA0);
+	writel(config->CL3, base + PBIST_CL3);
+	writel(config->I1, base + PBIST_I1);
+	writel(config->RAMT, base + PBIST_RAMT);
+	writel(config->CSR, base + PBIST_CSR);
+	writel(config->CMS, base + PBIST_CMS);
+
+	writel(0x00000009, base + PBIST_STR);
+
+	/* Start PBIST */
+	writel(0x00000001, base + PBIST_STR);
+
+	/* Allow time for completion of test*/
+	udelay(1000);
+
+	if (readl(base + PBIST_FSRF)) {
+		printf("%s: test failed\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * lbist_program_config() - Program LBIST config
+ * @config: lbist_config structure for LBIST test
+ */
+static void lbist_program_config(struct lbist_config *config)
+{
+	void *base = k3_bist_priv->lbist_ctrl_mmr;
+
+	lbist_set_clock_delay(base, config->dc_def);
+	lbist_set_divide_ratio(base, config->divide_ratio);
+	lbist_clear_load_div(base);
+	lbist_set_load_div(base);
+	lbist_set_num_stuck_at_patterns(base, config->static_pc_def);
+	lbist_set_num_set_patterns(base, config->set_pc_def);
+	lbist_set_num_reset_patterns(base, config->reset_pc_def);
+	lbist_set_num_chain_test_patterns(base, config->scan_pc_def);
+	lbist_set_seed(base, config->prpg_def_l, config->prpg_def_u);
+}
+
+/**
+ * lbist_enable_isolation() - LBIST Enable Isolation
+ * @config: lbist_config structure for LBIST test
+ */
+void lbist_enable_isolation(void)
+{
+	void *base = k3_bist_priv->lbist_ctrl_mmr;
+	u32 reg_val;
+
+	reg_val = readl(base + LBIST_SPARE0);
+	writel(reg_val | (LBIST_SPARE0_LBIST_SELFTEST_EN_MASK), base + LBIST_SPARE0);
+}
+
+/**
+ * lbist_disable_isolation() - LBIST Disable Isolation
+ * @config: lbist_config structure for LBIST test
+ */
+void lbist_disable_isolation(void)
+{
+	void *base = k3_bist_priv->lbist_ctrl_mmr;
+	u32 reg_val;
+
+	reg_val = readl(base + LBIST_SPARE0);
+	writel(reg_val & (~(LBIST_SPARE0_LBIST_SELFTEST_EN_MASK)), base + LBIST_SPARE0);
+}
+
+/**
+ * lbist_enable_run_bist_mode() - LBIST Enable run BIST mode
+ * @config: lbist_config structure for LBIST test
+ */
+static void lbist_enable_run_bist_mode(struct lbist_config *config)
+{
+	void *base = k3_bist_priv->lbist_ctrl_mmr;
+	u32 reg_val;
+
+	reg_val = readl(base + LBIST_CTRL);
+	writel(reg_val | (LBIST_CTRL_RUNBIST_MODE_MAX << LBIST_CTRL_RUNBIST_MODE_SHIFT),
+	       base + LBIST_CTRL);
+}
+
+/**
+ * lbist_start() - Start LBIST test
+ * @config: lbist_config structure for LBIST test
+ */
+static void lbist_start(struct lbist_config *config)
+{
+	struct udevice *dev = k3_bist_priv->dev;
+	void *base = k3_bist_priv->lbist_ctrl_mmr;
+	u32 reg_val;
+	u32 timeout_count = 0;
+
+	reg_val = readl(base + LBIST_CTRL);
+	writel(reg_val | (LBIST_CTRL_BIST_RESET_MAX << LBIST_CTRL_BIST_RESET_SHIFT),
+	       base + LBIST_CTRL);
+
+	reg_val = readl(base + LBIST_CTRL);
+	writel(reg_val | (LBIST_CTRL_BIST_RUN_MAX << LBIST_CTRL_BIST_RUN_SHIFT),
+	       base + LBIST_CTRL);
+
+	reg_val = readl(base + LBIST_STAT);
+	if ((reg_val & LBIST_STAT_BIST_RUNNING_MASK) != 0)
+		debug("%s(dev=%p): LBIST is running\n", __func__, dev);
+
+	while (((!(readl(base + LBIST_STAT) & LBIST_STAT_BIST_DONE_MASK))) &&
+	       (timeout_count++ < PBIST_MAX_TIMEOUT_VALUE)) {
+	}
+
+	if (!(readl(base + LBIST_STAT) & LBIST_STAT_BIST_DONE_MASK))
+		printf("%s(dev=%p): test failed\n", __func__, dev);
+}
+
+/**
+ * lbist_check_result() - Check LBIST test result
+ * @config: lbist_config structure for LBIST test
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static int lbist_check_result(struct lbist_config *config)
+{
+	void *base = k3_bist_priv->lbist_ctrl_mmr;
+	struct lbist_inst_info *info = k3_bist_priv->lbist_info;
+	u32 calculated_misr;
+	u32 expected_misr;
+
+	lbist_get_misr(base, &calculated_misr);
+	expected_misr = info->expected_misr;
+	lbist_clear_run_bist_mode(base);
+	lbist_stop(base);
+	lbist_reset(base);
+
+	if (calculated_misr != expected_misr) {
+		printf("calculated_misr != expected_misr\n %x %x\n",
+		       calculated_misr, expected_misr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int k3_run_lbist(void)
+{
+	/* Check whether HW POST successfully completely LBIST on the MCU domain */
+	struct lbist_inst_info *info_lbist = k3_bist_priv->lbist_info;
+
+	lbist_program_config(&info_lbist->lbist_conf);
+	lbist_enable_isolation();
+	lbist_reset(&info_lbist->lbist_conf);
+	lbist_enable_run_bist_mode(&info_lbist->lbist_conf);
+	lbist_start(&info_lbist->lbist_conf);
+	if (lbist_check_result(&info_lbist->lbist_conf)) {
+		printf("%s: test failed\n", __func__);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int k3_run_lbist_post(void)
+{
+	if (check_post_lbist_result()) {
+		printf("HW POST LBIST failed to run successfully\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int k3_run_pbist_post(void)
+{
+	/* Check whether HW POST successfully completely PBIST on the MCU domain */
+	if (check_post_pbist_result()) {
+		printf("HW POST failed to run successfully\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int k3_run_pbist(void)
+{
+	/* Run PBIST test */
+	struct pbist_inst_info *info = k3_bist_priv->pbist_info;
+	int num_runs = info->num_pbist_runs;
+
+	for (int j = 0; j < num_runs; j++) {
+		if (pbist_self_test(&info->pbist_config_run[j])) {
+			printf("failed to run PBIST test\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int k3_run_pbist_neg(void)
+{
+	/* Run PBIST failure insertion test */
+	struct pbist_inst_info *info = k3_bist_priv->pbist_info;
+
+	if (pbist_neg_self_test(&info->pbist_neg_config_run)) {
+		printf("failed to run PBIST negative test\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int k3_run_pbist_rom(void)
+{
+	/* Run PBIST test on ROM */
+	struct pbist_inst_info *info = k3_bist_priv->pbist_info;
+	int num_runs = info->num_pbist_rom_test_runs;
+
+	for (int j = 0; j < num_runs; j++) {
+		if (pbist_rom_self_test(&info->pbist_rom_test_config_run[j])) {
+			printf("failed to run ROM PBIST test\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int prepare_pbist(struct ti_sci_handle *handle)
+{
+	struct ti_sci_proc_ops *proc_ops = &handle->ops.proc_ops;
+	struct ti_sci_dev_ops *dev_ops = &handle->ops.dev_ops;
+	struct pbist_inst_info *info_pbist = k3_bist_priv->pbist_info;
+	struct core_under_test *cut = info_pbist->cut;
+
+	if (proc_ops->proc_request(handle, cut[0].proc_id)) {
+		printf("%s: requesting primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (proc_ops->proc_request(handle, cut[1].proc_id)) {
+		printf("%s: requesting secondary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->set_device_resets(handle, cut[0].dev_id, 0x1)) {
+		printf("%s: local reset primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->set_device_resets(handle, cut[1].dev_id, 0x1)) {
+		printf("%s: local reset secondary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->get_device(handle, cut[0].dev_id)) {
+		printf("%s: power on primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->get_device(handle, cut[1].dev_id)) {
+		printf("%s: power on secondary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->get_device(handle, info_pbist->dev_id)) {
+		printf("%s: power on PBIST failed\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int deprepare_pbist(struct ti_sci_handle *handle)
+{
+	struct ti_sci_proc_ops *proc_ops = &handle->ops.proc_ops;
+	struct ti_sci_dev_ops *dev_ops = &handle->ops.dev_ops;
+	struct pbist_inst_info *info_pbist = k3_bist_priv->pbist_info;
+	struct core_under_test *cut = info_pbist->cut;
+
+	if (dev_ops->put_device(handle, info_pbist->dev_id)) {
+		printf("%s: power off PBIST failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->put_device(handle, cut[1].dev_id)) {
+		printf("%s: power off secondary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->put_device(handle, cut[0].dev_id)) {
+		printf("%s: power off primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->set_device_resets(handle, cut[0].dev_id, 0)) {
+		printf("%s: putting primary core out of local reset failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->set_device_resets(handle, cut[1].dev_id, 0)) {
+		printf("%s: putting secondary core out of local reset failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->put_device(handle, cut[0].dev_id)) {
+		printf("%s: power off primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->put_device(handle, cut[1].dev_id)) {
+		printf("%s: power off secondary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (proc_ops->proc_release(handle, cut[0].proc_id)) {
+		printf("%s: release primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (proc_ops->proc_release(handle, cut[1].proc_id)) {
+		printf("%s: release secondary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int prepare_lbist(struct ti_sci_handle *handle)
+{
+	struct ti_sci_proc_ops *proc_ops = &handle->ops.proc_ops;
+	struct ti_sci_dev_ops *dev_ops = &handle->ops.dev_ops;
+	struct lbist_inst_info *info_lbist = k3_bist_priv->lbist_info;
+	struct core_under_test *cut = &info_lbist->cut;
+
+	if (proc_ops->proc_request(handle, cut->proc_id)) {
+		printf("%s: requesting primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->set_device_resets(handle, cut->dev_id, 0x3)) {
+		printf("%s: module and local reset primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->idle_device(handle, cut->dev_id)) {
+		printf("%s: putting primary core into retention failed\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int deprepare_lbist(struct ti_sci_handle *handle)
+{
+	struct ti_sci_proc_ops *proc_ops = &handle->ops.proc_ops;
+	struct ti_sci_dev_ops *dev_ops = &handle->ops.dev_ops;
+	struct lbist_inst_info *info_lbist = k3_bist_priv->lbist_info;
+	struct core_under_test *cut = &info_lbist->cut;
+
+	if (dev_ops->put_device(handle, 0)) {
+		printf("%s: power off secondary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->put_device(handle, cut->dev_id)) {
+		printf("%s: power off primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	lbist_disable_isolation();
+
+	if (dev_ops->idle_device(handle, cut->dev_id)) {
+		printf("%s: retention primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->idle_device(handle, 0)) {
+		printf("%s: retention secondary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->put_device(handle, 0)) {
+		printf("%s: power off secondary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->put_device(handle, cut->dev_id)) {
+		printf("%s: power off primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_ops->set_device_resets(handle, cut->dev_id, 0)) {
+		printf("%s: putting primary core out of local reset failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (proc_ops->proc_release(handle, cut->proc_id)) {
+		printf("%s: release primary core failed\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * k3_bist_probe() - Basic probe
+ * @dev: corresponding BIST device
+ *
+ * Parses BIST info from device tree, and configures the module accordingly.
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+static int k3_bist_probe(struct udevice *dev)
+{
+	int ret = 0;
+	struct k3_bist_privdata *priv = dev_get_priv(dev);
+	struct pbist_inst_info *info;
+	struct lbist_inst_info *info_lbist;
+	void *reg;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	priv = dev_get_priv(dev);
+	priv->dev = dev;
+
+	k3_bist_priv = priv;
+
+	reg = dev_read_addr_name_ptr(dev, "cfg");
+	if (!reg) {
+		dev_err(dev, "No reg property for BIST\n");
+		return -EINVAL;
+	}
+	priv->pbist_base = reg;
+
+	reg = dev_read_addr_name_ptr(dev, "ctrl_mmr");
+	if (!reg) {
+		dev_err(dev, "No reg property for CTRL MMR\n");
+		return -EINVAL;
+	}
+	priv->lbist_ctrl_mmr = reg;
+
+	ret = dev_read_u32(dev, "ti,bist-under-test", &priv->instance);
+	if (!priv->instance)
+		return -ENODEV;
+
+	/* Obtain the BIST ID by mapping the device ID under it's control */
+	priv->instance = get_bist_instance(priv->instance);
+
+	switch (priv->instance) {
+	case PBIST14_INSTANCE:
+		priv->pbist_info = &pbist14_inst_info;
+		priv->lbist_info = &lbist_inst_info_main_r5f2_x;
+		info = priv->pbist_info;
+		info_lbist = priv->lbist_info;
+		priv->intr_num = info->intr_num;
+		break;
+	default:
+		dev_err(dev, "%s: PBIST instance %d not supported\n", __func__, priv->instance);
+		return -ENODEV;
+	};
+
+	return 0;
+}
+
+static const struct bist_ops k3_bist_ops = {
+	.run_lbist = k3_run_lbist,
+	.run_lbist_post = k3_run_lbist_post,
+	.run_pbist = k3_run_pbist,
+	.run_pbist_post = k3_run_pbist_post,
+	.run_pbist_neg = k3_run_pbist_neg,
+	.run_pbist_rom = k3_run_pbist_rom,
+};
+
+static const struct udevice_id k3_bist_ids[] = {
+	{ .compatible = "ti,j784s4-bist" },
+	{}
+};
+
+U_BOOT_DRIVER(k3_bist) = {
+	.name = "k3_bist",
+	.of_match = k3_bist_ids,
+	.id = UCLASS_MISC,
+	.ops = &k3_bist_ops,
+	.probe = k3_bist_probe,
+	.priv_auto = sizeof(struct k3_bist_privdata),
+};
diff --git a/drivers/misc/k3_bist_static_data.h b/drivers/misc/k3_bist_static_data.h
new file mode 100644
index 00000000000..af371d83724
--- /dev/null
+++ b/drivers/misc/k3_bist_static_data.h
@@ -0,0 +1,673 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Static Data for Texas Instruments' BIST (Built-In Self-Test) driver
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#ifndef __K3_BIST_STATIC_DATA_H
+#define __K3_BIST_STATIC_DATA_H
+
+/*
+ * Registers and functions related to PBIST
+ */
+
+#define PBIST_MAX_NUM_RUNS			2
+#define NUM_MAX_PBIST_TEST_ROM_RUNS		13
+#define PBIST14_DFT_PBIST_CPU_0_INTR_NUM	311
+
+/* VIM Registers */
+#define VIM_STS_BASE				0x40f80404
+#define VIM_RAW_BASE				0x40f80400
+
+#define VIM_STS(i)	(VIM_STS_BASE + (i) / 32 * 0x20)
+#define VIM_RAW(i)	(VIM_RAW_BASE + (i) / 32 * 0x20)
+#define VIM_RAW_MASK(i)	(BIT((i) % 32))
+
+/* PBIST Registers and Flags*/
+#define PBIST_RF0L						0x00000000
+#define PBIST_RF1L						0x00000004
+#define PBIST_RF2L						0x00000008
+#define PBIST_RF3L						0x0000000C
+#define PBIST_RF4L						0x0000010
+#define PBIST_RF5L						0x0000014
+#define PBIST_RF6L						0x0000018
+#define PBIST_RF7L						0x000001C
+#define PBIST_RF8L						0x0000020
+#define PBIST_RF9L						0x0000024
+#define PBIST_RF10L						0x0000028
+#define PBIST_RF11L						0x000002C
+#define PBIST_RF12L						0x0000030
+#define PBIST_RF13L						0x0000034
+#define PBIST_RF14L						0x0000038
+#define PBIST_RF15L						0x000003C
+#define PBIST_RF0U						0x0000040
+#define PBIST_RF1U						0x0000044
+#define PBIST_RF2U						0x0000048
+#define PBIST_RF3U						0x000004C
+#define PBIST_RF4U						0x0000050
+#define PBIST_RF5U						0x0000054
+#define PBIST_RF6U						0x0000058
+#define PBIST_RF7U						0x000005C
+#define PBIST_RF8U						0x0000060
+#define PBIST_RF9U						0x0000064
+#define PBIST_RF10U						0x0000068
+#define PBIST_RF11U						0x000006C
+#define PBIST_RF12U						0x0000070
+#define PBIST_RF13U						0x0000074
+#define PBIST_RF14U						0x0000078
+#define PBIST_RF15U						0x000007C
+#define PBIST_A0						0x0000100
+#define PBIST_A1						0x0000104
+#define PBIST_A2						0x0000108
+#define PBIST_A3						0x000010C
+#define PBIST_L0						0x0000110
+#define PBIST_L1						0x0000114
+#define PBIST_L2						0x0000118
+#define PBIST_L3						0x000011C
+#define PBIST_D						0x0000120
+#define PBIST_E						0x0000124
+#define PBIST_CA0						0x0000130
+#define PBIST_CA1						0x0000134
+#define PBIST_CA2						0x0000138
+#define PBIST_CA3						0x000013C
+#define PBIST_CL0						0x0000140
+#define PBIST_CL1						0x0000144
+#define PBIST_CL2						0x0000148
+#define PBIST_CL3						0x000014C
+#define PBIST_I0						0x0000150
+#define PBIST_I1						0x0000154
+#define PBIST_I2						0x0000158
+#define PBIST_I3						0x000015C
+#define PBIST_RAMT						0x0000160
+#define PBIST_DLR						0x0000164
+#define PBIST_CMS						0x0000168
+#define PBIST_STR						0x000016C
+#define PBIST_SCR						0x0000170
+#define PBIST_SCR_LO						0x0000170
+#define PBIST_SCR_HI						0x0000174
+#define PBIST_CSR						0x0000178
+#define PBIST_FDLY						0x000017C
+#define PBIST_PACT						0x0000180
+#define PBIST_PID						0x0000184
+#define PBIST_OVER						0x0000188
+#define PBIST_FSRF						0x0000190
+#define PBIST_FSRC						0x0000198
+#define PBIST_FSRA						0x00001A0
+#define PBIST_FSRDL0						0x00001A8
+#define PBIST_FSRDL1						0x00001B0
+#define PBIST_MARGIN_MODE					0x00001B4
+#define PBIST_WRENZ						0x00001B8
+#define PBIST_PAGE_PGS						0x00001BC
+#define PBIST_ROM						0x00001C0
+#define PBIST_ALGO						0x00001C4
+#define PBIST_RINFO						0x00001C8
+
+#define PBIST_MARGIN_MODE_PBIST_DFT_WRITE_MASK			0x00000003
+#define PBIST_MARGIN_MODE_PBIST_DFT_READ_SHIFT			0x00000002
+#define PBIST_MARGIN_MODE_PBIST_DFT_READ_MASK			0x0000000C
+#define PBIST_PACT_PACT_MASK					0x00000001
+#define PBIST_DLR_DLR0_ROM_MASK				0x00000004
+#define PBIST_DLR_DLR0_CAM_MASK				0x00000010
+#define PBIST_NOT_DONE						0
+#define PBIST_DONE						1
+
+/* PBIST test mode */
+#define PBIST_TEST_MODE (PBIST_MARGIN_MODE_PBIST_DFT_WRITE_MASK \
+			 | (1 << PBIST_MARGIN_MODE_PBIST_DFT_READ_SHIFT))
+
+/* PBIST Failure Insertion test mode */
+#define PBIST_FAILURE_INSERTION_TEST_MODE (PBIST_MARGIN_MODE_PBIST_DFT_WRITE_MASK \
+					   | PBIST_MARGIN_MODE_PBIST_DFT_READ_MASK)
+
+/**
+ * struct core_under_test - structure for a core under a BIST test
+ * @dev_id: Device ID of the core
+ * @proc_id: Processor ID of the core
+ */
+struct core_under_test {
+	u32 dev_id;
+	u32 proc_id;
+};
+
+/*
+ * struct pbist_config - Structure for different configuration used for PBIST
+ * @override: Override value for memory configuration
+ * @algorithms_bit_map: Bitmap to select algorithms to use for test
+ * @memory_groups_bit_map: Bitmap to select memory groups to run test on
+ * @scramble_value_lo: Lower scramble value to be used for test
+ * @scramble_value_hi: Higher scramble value to be used for test
+ */
+struct pbist_config {
+	u32 override;
+	u32 algorithms_bit_map;
+	u64 memory_groups_bit_map;
+	u32 scramble_value_lo;
+	u32 scramble_value_hi;
+};
+
+/*
+ * struct pbist_config_neg - Structure for different configuration used for PBIST
+ * for the failure insertion test to generate negative result
+ * @CA0: Failure insertion value for CA0
+ * @CA1: Failure insertion value for CA1
+ * @CA2: Failure insertion value for CA2
+ * @CA3: Failure insertion value for CA3
+ * @CL0: Failure insertion value for CL0
+ * @CL1: Failure insertion value for CL1
+ * @CL2: Failure insertion value for CL2
+ * @CL3: Failure insertion value for CL3
+ * @CMS: Failure insertion value for CMS
+ * @CSR: Failure insertion value for CSR
+ * @I0: Failure insertion value for I0
+ * @I1: Failure insertion value for I1
+ * @I2: Failure insertion value for I2
+ * @I3: Failure insertion value for I3
+ * @RAMT: Failure insertion value for RAMT
+ */
+struct pbist_config_neg {
+	u32 CA0;
+	u32 CA1;
+	u32 CA2;
+	u32 CA3;
+	u32 CL0;
+	u32 CL1;
+	u32 CL2;
+	u32 CL3;
+	u32 CMS;
+	u32 CSR;
+	u32 I0;
+	u32 I1;
+	u32 I2;
+	u32 I3;
+	u32 RAMT;
+};
+
+/*
+ * struct pbist_config_neg - Structure for different configuration used for PBIST
+ * test of ROM
+ * @D: ROM test value for D
+ * @E: ROM test value for E
+ * @CA2: ROM test value for CA2
+ * @CL0: ROM test value for CL0
+ * @CA3: ROM test value for CA3
+ * @I0: ROM test value for I0
+ * @CL1: ROM test value for CL1
+ * @I3: ROM test value for I3
+ * @I2: ROM test value for I2
+ * @CL2: ROM test value for CL2
+ * @CA1: ROM test value for CA1
+ * @CA0: ROM test value for CA0
+ * @CL3: ROM test value for CL3
+ * @I1: ROM test value for I1
+ * @RAMT: ROM test value for RAMT
+ * @CSR: ROM test value for CSR
+ * @CMS: ROM test value for CMS
+ */
+struct pbist_config_rom {
+	u32 D;
+	u32 E;
+	u32 CA2;
+	u32 CL0;
+	u32 CA3;
+	u32 I0;
+	u32 CL1;
+	u32 I3;
+	u32 I2;
+	u32 CL2;
+	u32 CA1;
+	u32 CA0;
+	u32 CL3;
+	u32 I1;
+	u32 RAMT;
+	u32 CSR;
+	u32 CMS;
+};
+
+/*
+ * struct pbist_inst_info - Structure for different configuration used for PBIST
+ * @num_pbist_runs: Number of runs of PBIST test
+ * @intr_num: Interrupt number triggered by this PBIST instance to MCU R5 VIM
+ * @pbist_config_run: Configuration for PBIST test
+ * @pbist_neg_config_run: Configuration for PBIST negative test
+ * @num_pbist_rom_test_runs: Number of runs of PBIST test on ROM
+ * @pbist_rom_test_config_run: Configuration for PBIST test on ROM
+ */
+struct pbist_inst_info {
+	u32 num_pbist_runs;
+	u32 intr_num;
+	u32 dev_id;
+	struct core_under_test cut[2];
+	struct pbist_config pbist_config_run[PBIST_MAX_NUM_RUNS];
+	struct pbist_config_neg pbist_neg_config_run;
+	u32 num_pbist_rom_test_runs;
+	struct pbist_config_rom pbist_rom_test_config_run[NUM_MAX_PBIST_TEST_ROM_RUNS];
+};
+
+/*
+ * Registers and functions related to LBIST
+ */
+
+#define LBIST_CTRL_DIVIDE_RATIO_MASK            0x0000001F
+#define LBIST_CTRL_DIVIDE_RATIO_SHIFT           0x00000000
+#define LBIST_CTRL_DIVIDE_RATIO_MAX             0x0000001F
+
+#define LBIST_CTRL_LOAD_DIV_MASK                0x00000080
+#define LBIST_CTRL_LOAD_DIV_SHIFT               0x00000007
+#define LBIST_CTRL_LOAD_DIV_MAX                 0x00000001
+
+#define LBIST_CTRL_DC_DEF_MASK                  0x00000300
+#define LBIST_CTRL_DC_DEF_SHIFT                 0x00000008
+#define LBIST_CTRL_DC_DEF_MAX                   0x00000003
+
+#define LBIST_CTRL_RUNBIST_MODE_MASK            0x0000F000
+#define LBIST_CTRL_RUNBIST_MODE_SHIFT           0x0000000C
+#define LBIST_CTRL_RUNBIST_MODE_MAX             0x0000000F
+
+#define LBIST_CTRL_BIST_RUN_MASK                0x0F000000
+#define LBIST_CTRL_BIST_RUN_SHIFT               0x00000018
+#define LBIST_CTRL_BIST_RUN_MAX                 0x0000000F
+
+#define LBIST_CTRL_BIST_RESET_MASK              0x80000000
+#define LBIST_CTRL_BIST_RESET_SHIFT             0x0000001F
+#define LBIST_CTRL_BIST_RESET_MAX               0x00000001
+
+/* LBIST_PATCOUNT */
+
+#define LBIST_PATCOUNT_SCAN_PC_DEF_MASK         0x0000000F
+#define LBIST_PATCOUNT_SCAN_PC_DEF_SHIFT        0x00000000
+#define LBIST_PATCOUNT_SCAN_PC_DEF_MAX          0x0000000F
+
+#define LBIST_PATCOUNT_RESET_PC_DEF_MASK        0x000000F0
+#define LBIST_PATCOUNT_RESET_PC_DEF_SHIFT       0x00000004
+#define LBIST_PATCOUNT_RESET_PC_DEF_MAX         0x0000000F
+
+#define LBIST_PATCOUNT_SET_PC_DEF_MASK          0x00000F00
+#define LBIST_PATCOUNT_SET_PC_DEF_SHIFT         0x00000008
+#define LBIST_PATCOUNT_SET_PC_DEF_MAX           0x0000000F
+
+#define LBIST_PATCOUNT_STATIC_PC_DEF_MASK       0x3FFF0000
+#define LBIST_PATCOUNT_STATIC_PC_DEF_SHIFT      0x00000010
+#define LBIST_PATCOUNT_STATIC_PC_DEF_MAX        0x00003FFF
+
+/* LBIST_SEED0 */
+
+#define LBIST_SEED0_PRPG_DEF_MASK               0xFFFFFFFF
+#define LBIST_SEED0_PRPG_DEF_SHIFT              0x00000000
+#define LBIST_SEED0_PRPG_DEF_MAX                0xFFFFFFFF
+
+/* LBIST_SEED1 */
+
+#define LBIST_SEED1_PRPG_DEF_MASK               0x001FFFFF
+#define LBIST_SEED1_PRPG_DEF_SHIFT              0x00000000
+#define LBIST_SEED1_PRPG_DEF_MAX                0x001FFFFF
+
+/* LBIST_SPARE0 */
+
+#define LBIST_SPARE0_LBIST_SELFTEST_EN_MASK     0x00000001
+#define LBIST_SPARE0_LBIST_SELFTEST_EN_SHIFT    0x00000000
+#define LBIST_SPARE0_LBIST_SELFTEST_EN_MAX      0x00000001
+
+#define LBIST_SPARE0_PBIST_SELFTEST_EN_MASK     0x00000002
+#define LBIST_SPARE0_PBIST_SELFTEST_EN_SHIFT    0x00000001
+#define LBIST_SPARE0_PBIST_SELFTEST_EN_MAX      0x00000001
+
+#define LBIST_SPARE0_SPARE0_MASK                0xFFFFFFFC
+#define LBIST_SPARE0_SPARE0_SHIFT               0x00000002
+#define LBIST_SPARE0_SPARE0_MAX                 0x3FFFFFFF
+
+/* LBIST_SPARE1 */
+
+#define LBIST_SPARE1_SPARE1_MASK                0xFFFFFFFF
+#define LBIST_SPARE1_SPARE1_SHIFT               0x00000000
+#define LBIST_SPARE1_SPARE1_MAX                 0xFFFFFFFF
+
+/* LBIST_STAT */
+
+#define LBIST_STAT_MISR_MUX_CTL_MASK            0x000000FF
+#define LBIST_STAT_MISR_MUX_CTL_SHIFT           0x00000000
+#define LBIST_STAT_MISR_MUX_CTL_MAX             0x000000FF
+
+#define LBIST_STAT_OUT_MUX_CTL_MASK             0x00000300
+#define LBIST_STAT_OUT_MUX_CTL_SHIFT            0x00000008
+#define LBIST_STAT_OUT_MUX_CTL_MAX              0x00000003
+
+#define LBIST_STAT_BIST_RUNNING_MASK            0x00008000
+#define LBIST_STAT_BIST_RUNNING_SHIFT           0x0000000F
+#define LBIST_STAT_BIST_RUNNING_MAX             0x00000001
+
+#define LBIST_STAT_BIST_DONE_MASK               0x80000000
+#define LBIST_STAT_BIST_DONE_SHIFT              0x0000001F
+#define LBIST_STAT_BIST_DONE_MAX                0x00000001
+
+/* LBIST_MISR */
+
+#define LBIST_MISR_MISR_RESULT_MASK             0xFFFFFFFF
+#define LBIST_MISR_MISR_RESULT_SHIFT            0x00000000
+#define LBIST_MISR_MISR_RESULT_MAX              0xFFFFFFFF
+
+#define CTRL_MMR0_CFG0_BASE                     0x00100000
+#define MAIN_CTRL_MMR_CFG0_MCU2_LBIST_CTRL      0x0000C1A0
+#define MAIN_R5F2_LBIST_BASE         (CTRL_MMR0_CFG0_BASE +\
+	MAIN_CTRL_MMR_CFG0_MCU2_LBIST_CTRL)
+
+#define LBIST_CTRL                              0x00000000
+#define LBIST_PATCOUNT                          0x00000004
+#define LBIST_SEED0                             0x00000008
+#define LBIST_SEED1                             0x0000000C
+#define LBIST_SPARE0                            0x00000010
+#define LBIST_SPARE1                            0x00000014
+#define LBIST_STAT                              0x00000018
+#define LBIST_MISR                              0x0000001C
+
+#define MAIN_CTRL_MMR_CFG0_MCU2_LBIST_SIG       0x0000C2C0
+#define MAIN_R5F2_LBIST_SIG         (CTRL_MMR0_CFG0_BASE +\
+	MAIN_CTRL_MMR_CFG0_MCU2_LBIST_SIG)
+#define MCU_R5FSS0_CORE0_INTR_LBIST_BIST_DONE_0	    284
+
+/* Lbist Parameters */
+#define LBIST_DC_DEF                   0x3
+#define LBIST_DIVIDE_RATIO             0x02
+#define LBIST_STATIC_PC_DEF            0x3ac0
+#define LBIST_RESET_PC_DEF             0x0f
+#define LBIST_SET_PC_DEF               0x00
+#define LBIST_SCAN_PC_DEF              0x04
+#define LBIST_PRPG_DEF_L		0xFFFFFFFF
+#define LBIST_PRPG_DEF_U               0x1FFFFF
+
+/*
+ * LBIST setup parameters for each core
+ */
+
+#define LBIST_MAIN_R5_STATIC_PC_DEF    LBIST_STATIC_PC_DEF
+#define LBIST_C7X_STATIC_PC_DEF        0x3fc0
+#define LBIST_A72_STATIC_PC_DEF        0x3fc0
+#define LBIST_DMPAC_STATIC_PC_DEF      0x1880
+#define LBIST_VPAC_STATIC_PC_DEF       0x3fc0
+#define LBIST_A72SS_STATIC_PC_DEF      0x13c0
+
+/*
+ * LBIST expected MISR's (using parameters above)
+ */
+
+#define MAIN_R5_MISR_EXP_VAL           0x71d66f87
+#define A72_MISR_EXP_VAL               0x14df0200
+#define C7X_MISR_EXP_VAL               0x57b0478f
+#define VPAC_MISR_EXP_VAL              0xec6abe22
+#define VPAC0_MISR_EXP_VAL             0x5c43b468
+#define DMPAC_MISR_EXP_VAL             0x53e1ef7b
+#define A72SS_MISR_EXP_VAL             0x87da5a92
+
+/**
+ * lbist_set_clock_delay() - Set seed for LBIST
+ * @ctrl_mmr_base: CTRL MMR base
+ * @clock_delay: clock delay
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_set_clock_delay(void *ctrl_mmr_base, u32 clock_delay)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base);
+	writel(reg_val & LBIST_CTRL_DC_DEF_MASK, ctrl_mmr_base);
+
+	reg_val = readl(ctrl_mmr_base);
+	writel(reg_val | ((clock_delay & LBIST_CTRL_DC_DEF_MAX)
+	       << LBIST_CTRL_DC_DEF_SHIFT), ctrl_mmr_base);
+}
+
+/**
+ * lbist_set_seed() - Set seed for LBIST
+ * @config: lbist_config structure for LBIST test
+ * @seed: seed
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_set_seed(void *ctrl_mmr_base, u32 seed_l, u32 seed_u)
+{
+	writel(seed_l & LBIST_SEED0_PRPG_DEF_MASK, ctrl_mmr_base + LBIST_SEED0);
+	writel(seed_u & LBIST_SEED1_PRPG_DEF_MASK, ctrl_mmr_base + LBIST_SEED1);
+}
+
+/**
+ * set_num_chain_test_patterns() - Set chain test patterns
+ * @ctrl_mmr_base: CTRL MMR base
+ * @chain_test_patterns: chain test patterns
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_set_num_chain_test_patterns(void *ctrl_mmr_base, u32 chain_test_patterns)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base + LBIST_PATCOUNT);
+	writel(reg_val & (~(LBIST_PATCOUNT_SCAN_PC_DEF_MASK)),
+	       ctrl_mmr_base + LBIST_PATCOUNT);
+
+	reg_val = readl(ctrl_mmr_base + LBIST_PATCOUNT);
+	writel(reg_val | ((chain_test_patterns & LBIST_PATCOUNT_SCAN_PC_DEF_MAX)
+	       << LBIST_PATCOUNT_SCAN_PC_DEF_SHIFT), ctrl_mmr_base + LBIST_PATCOUNT);
+}
+
+/**
+ * set_num_reset_patterns() - Set reset patterns
+ * @ctrl_mmr_base: CTRL MMR base
+ * @reset_patterns: reset patterns
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_set_num_reset_patterns(void *ctrl_mmr_base, u32 reset_patterns)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base + LBIST_PATCOUNT);
+	writel(reg_val & (~(LBIST_PATCOUNT_RESET_PC_DEF_MASK)),
+	       ctrl_mmr_base + LBIST_PATCOUNT);
+
+	reg_val = readl(ctrl_mmr_base + LBIST_PATCOUNT);
+	writel(reg_val | ((reset_patterns & LBIST_PATCOUNT_RESET_PC_DEF_MAX)
+	       << LBIST_PATCOUNT_RESET_PC_DEF_SHIFT), ctrl_mmr_base + LBIST_PATCOUNT);
+}
+
+/**
+ * set_num_set_patterns() - Set patterns
+ * @ctrl_mmr_base: CTRL MMR base
+ * @set_patterns: set patterns
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_set_num_set_patterns(void *ctrl_mmr_base, u32 set_patterns)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base + LBIST_PATCOUNT);
+	writel(reg_val & (~(LBIST_PATCOUNT_SET_PC_DEF_MASK)),
+	       ctrl_mmr_base + LBIST_PATCOUNT);
+
+	reg_val = readl(ctrl_mmr_base + LBIST_PATCOUNT);
+	writel(reg_val | ((set_patterns & LBIST_PATCOUNT_RESET_PC_DEF_MAX)
+	       << LBIST_PATCOUNT_SET_PC_DEF_SHIFT), ctrl_mmr_base + LBIST_PATCOUNT);
+}
+
+/**
+ * set_num_stuck_at_patterns() - Set
+ * @ctrl_mmr_base: CTRL MMR base
+ * @stuck_at_patterns: set patterns
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_set_num_stuck_at_patterns(void *ctrl_mmr_base, u32 stuck_at_patterns)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base + LBIST_PATCOUNT);
+	writel(reg_val & (~(LBIST_PATCOUNT_STATIC_PC_DEF_MASK)),
+	       ctrl_mmr_base + LBIST_PATCOUNT);
+
+	reg_val = readl(ctrl_mmr_base + LBIST_PATCOUNT);
+	writel(reg_val | ((stuck_at_patterns & LBIST_PATCOUNT_STATIC_PC_DEF_MAX)
+	       << LBIST_PATCOUNT_STATIC_PC_DEF_SHIFT), ctrl_mmr_base + LBIST_PATCOUNT);
+}
+
+/**
+ * set_divide_ratio() - Set divide ratio
+ * @ctrl_mmr_base: CTRL MMR base
+ * @divide_ratio: divide ratio
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_set_divide_ratio(void *ctrl_mmr_base, u32 divide_ratio)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base + LBIST_CTRL);
+	writel(reg_val & (~(LBIST_CTRL_DIVIDE_RATIO_MASK)), ctrl_mmr_base + LBIST_CTRL);
+
+	reg_val = readl(ctrl_mmr_base + LBIST_CTRL);
+	writel(reg_val | (divide_ratio & LBIST_CTRL_DIVIDE_RATIO_MASK),
+	       ctrl_mmr_base + LBIST_CTRL);
+}
+
+/**
+ * clear_load_div() - Clear load div
+ * @ctrl_mmr_base: CTRL MMR base
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_clear_load_div(void *ctrl_mmr_base)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base + LBIST_CTRL);
+	writel(reg_val & (~(LBIST_CTRL_LOAD_DIV_MASK)), ctrl_mmr_base + LBIST_CTRL);
+}
+
+/**
+ * set_load_div() - Set load div
+ * @ctrl_mmr_base: CTRL MMR base
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_set_load_div(void *ctrl_mmr_base)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base + LBIST_CTRL);
+	writel(reg_val | (LBIST_CTRL_LOAD_DIV_MASK), ctrl_mmr_base + LBIST_CTRL);
+}
+
+/* MACRO DEFINES */
+#define LBIST_STAT_MISR_MUX_CTL_COMPACT_MISR            0x0
+
+#define LBIST_STAT_OUT_MUX_CTL_CTRLMMR_PID              0x0
+#define LBIST_STAT_OUT_MUX_CTL_CTRL_ID                  0x1
+#define LBIST_STAT_OUT_MUX_CTL_MISR_VALUE_1             0x2
+#define LBIST_STAT_OUT_MUX_CTL_MISR_VALUE_2             0x3
+
+/**
+ * lbist_get_misr() - Get MISR
+ * @ctrl_mmr_base: CTRL MMR base
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_get_misr(void *ctrl_mmr_base, u32 *p_misr_val)
+{
+	u32 reg_val;
+	u32 mux_val;
+
+	reg_val = LBIST_STAT_MISR_MUX_CTL_COMPACT_MISR;
+	mux_val = LBIST_STAT_OUT_MUX_CTL_MISR_VALUE_1;
+	reg_val |= (mux_val << LBIST_STAT_OUT_MUX_CTL_SHIFT);
+	writel(reg_val, ctrl_mmr_base + LBIST_STAT);
+	*p_misr_val = readl(ctrl_mmr_base + LBIST_MISR);
+}
+
+/**
+ * lbist_clear_run_bist_mode() - Clear RUN_BIST_MODE
+ * @ctrl_mmr_base: CTRL MMR base
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_clear_run_bist_mode(void *ctrl_mmr_base)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base + LBIST_CTRL);
+	writel(reg_val & (~(LBIST_CTRL_RUNBIST_MODE_MAX << LBIST_CTRL_RUNBIST_MODE_SHIFT)),
+	       ctrl_mmr_base + LBIST_CTRL);
+}
+
+/**
+ * lbist_stop() - Stop running LBIST
+ * @ctrl_mmr_base: CTRL MMR base
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_stop(void *ctrl_mmr_base)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base + LBIST_CTRL);
+	writel(reg_val & (~(LBIST_CTRL_BIST_RUN_MAX << LBIST_CTRL_BIST_RUN_SHIFT)),
+	       ctrl_mmr_base + LBIST_CTRL);
+}
+
+/**
+ * lbist_reset() - Reset LBIST
+ * @ctrl_mmr_base: CTRL MMR base
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+static void lbist_reset(void *ctrl_mmr_base)
+{
+	u32 reg_val;
+
+	reg_val = readl(ctrl_mmr_base + LBIST_CTRL);
+	writel(reg_val & (~(LBIST_CTRL_BIST_RESET_MAX << LBIST_CTRL_BIST_RESET_SHIFT)),
+	       ctrl_mmr_base + LBIST_CTRL);
+}
+
+/*
+ * struct lbist_config - Structure containing different configuration used for LBIST
+ * @dc_def: Clock delay after scan_enable switching
+ * @divide_ratio: LBIST clock divide ratio
+ * @static_pc_def: Bitmap of stuck-at patterns to run
+ * @set_pc_def: Bitmap of set patterns to run
+ * @reset_pc_def: Bitmap of reset patterns to run
+ * @scan_pc_def: Bitmap of chain test patterns to run
+ * @prpg_def: Initial seed for Pseudo Random Pattern generator (PRPG)
+ */
+struct lbist_config {
+	u32 dc_def;
+	u32 divide_ratio;
+	u32 static_pc_def;
+	u32 set_pc_def;
+	u32 reset_pc_def;
+	u32 scan_pc_def;
+	u32 prpg_def_l;
+	u32 prpg_def_u;
+};
+
+/*
+ * struct lbist_inst_info - Structure for different configuration used for LBIST
+ * @lbist_signature: Pointer to LBIST signature
+ * @intr_num: Interrupt number triggered by this LBIST instance to MCU R5 VIM
+ * @expected_misr: Expected signature
+ * @lbist_config: Configuration for LBIST test
+ */
+struct lbist_inst_info {
+	u32 *lbist_signature;
+	u32 intr_num;
+	u32 expected_misr;
+	struct lbist_config lbist_conf;
+	struct core_under_test cut;
+};
+
+#if IS_ENABLED(CONFIG_SOC_K3_J784S4)
+
+#include "k3_j784s4_bist_static_data.h"
+
+#endif /* CONFIG_SOC_K3_J784S4 */
+#endif /* __K3_BIST_STATIC_DATA_H */
diff --git a/drivers/misc/k3_j784s4_bist_static_data.h b/drivers/misc/k3_j784s4_bist_static_data.h
new file mode 100644
index 00000000000..87826465815
--- /dev/null
+++ b/drivers/misc/k3_j784s4_bist_static_data.h
@@ -0,0 +1,388 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Static Data for Texas Instruments' BIST logic for J784S4
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+/* Device IDs of IPs that can be tested under BIST */
+#define TISCI_DEV_MCU_R5FSS2_CORE0		343
+#define TISCI_DEV_MCU_R5FSS2_CORE1		344
+#define TISCI_DEV_RTI32					365
+#define TISCI_DEV_RTI33					366
+
+/* WKUP CTRL MMR Registers */
+#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT				0x0000C2C0
+#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_DONE_SHIFT	0x00000008
+#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_LBIST_DONE_SHIFT	0x00000001
+#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_TIMEOUT_SHIFT	0x00000009
+#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_LBIST_TIMEOUT_SHIFT	0x00000005
+#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_FAIL_MASK	0x00008000
+
+/* MCU CTRL MMR Register */
+#define MCU_CTRL_MMR0_CFG0_BASE					0x40f00000
+#define MCU_CTRL_MMR_CFG0_MCU_LBIST_CTRL				0x0000c000
+#define MCU_LBIST_BASE			(MCU_CTRL_MMR0_CFG0_BASE + \
+					 MCU_CTRL_MMR_CFG0_MCU_LBIST_CTRL)
+
+/* Properties of PBIST instances in: PBIST14 */
+#define PBIST14_INSTANCE					      14
+#define PBIST14_NUM_TEST_VECTORS				      0x1
+#define PBIST14_ALGO_BITMAP_0					      0x00000003
+#define PBIST14_MEM_BITMAP_0					      0x000CCCCC
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CA0			      0x00000000
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CA1			      0x000001FF
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CA2			      0x000001FF
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CA3			      0x00000000
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CL0			      0x0000007F
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CL1			      0x00000003
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CL2			      0x00000008
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CL3			      0x000001FF
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CMS			      0x00000000
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CSR			      0x20000000
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_I0			      0x00000001
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_I1			      0x00000004
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_I2			      0x00000008
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_I3			      0x00000000
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_RAMT		      0x011D2528
+
+/**
+ * get_bist_instance() - Returns the BIST instance for a given device ID.
+ * @dev_id: The device ID.
+ *
+ * Return: The BIST instance, else -1 if the device ID is not found.
+ */
+int get_bist_instance(int dev_id)
+{
+	switch (dev_id) {
+	case TISCI_DEV_MCU_R5FSS2_CORE0:
+	case TISCI_DEV_MCU_R5FSS2_CORE1:
+	case TISCI_DEV_RTI32:
+	case TISCI_DEV_RTI33:
+		return PBIST14_INSTANCE;
+	}
+
+	return -1;
+}
+
+static struct pbist_inst_info pbist14_inst_info = {
+	/* Main Pulsar 2 Instance 1 or MAIN_R52_x */
+	.num_pbist_runs = 1,
+	.intr_num = PBIST14_DFT_PBIST_CPU_0_INTR_NUM,
+	.dev_id = TISCI_DEV_PBIST14,
+	.cut = {
+		{
+			.dev_id = TISCI_DEV_R5FSS2_CORE0,
+			.proc_id = PROC_ID_MCU_R5FSS2_CORE0,
+		},
+		{
+			.dev_id = TISCI_DEV_R5FSS2_CORE1,
+			.proc_id = PROC_ID_MCU_R5FSS2_CORE1,
+		}
+	},
+	.pbist_config_run = {
+		{
+			.override = 0,
+			.algorithms_bit_map = PBIST14_ALGO_BITMAP_0,
+			.memory_groups_bit_map = PBIST14_MEM_BITMAP_0,
+			.scramble_value_lo = 0x76543210,
+			.scramble_value_hi = 0xFEDCBA98,
+		},
+		{
+			.override = 0,
+			.algorithms_bit_map = 0,
+			.memory_groups_bit_map = 0,
+			.scramble_value_lo = 0,
+			.scramble_value_hi = 0,
+		},
+	},
+	.pbist_neg_config_run = {
+		.CA0   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CA0,
+		.CA1   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CA1,
+		.CA2   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CA2,
+		.CA3   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CA3,
+		.CL0   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CL0,
+		.CL1   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CL1,
+		.CL2   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CL2,
+		.CL3   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CL3,
+		.CMS   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CMS,
+		.CSR   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CSR,
+		.I0    = PBIST14_FAIL_INSERTION_TEST_VECTOR_I0,
+		.I1    = PBIST14_FAIL_INSERTION_TEST_VECTOR_I1,
+		.I2    = PBIST14_FAIL_INSERTION_TEST_VECTOR_I2,
+		.I3    = PBIST14_FAIL_INSERTION_TEST_VECTOR_I3,
+		.RAMT  = PBIST14_FAIL_INSERTION_TEST_VECTOR_RAMT
+	},
+	.num_pbist_rom_test_runs = 1,
+	.pbist_rom_test_config_run = {
+		{
+			.D = 0xF412605Eu,
+			.E = 0xF412605Eu,
+			.CA2 = 0x7FFFu,
+			.CL0 = 0x3FFu,
+			.CA3 = 0x0u,
+			.I0 = 0x1u,
+			.CL1 = 0x1Fu,
+			.I3 = 0x0u,
+			.I2 = 0xEu,
+			.CL2 = 0xEu,
+			.CA1 = 0x7FFFu,
+			.CA0 = 0x0u,
+			.CL3 = 0x7FFFu,
+			.I1 = 0x20u,
+			.RAMT = 0x08002020u,
+			.CSR = 0x00000001u,
+			.CMS = 0x01u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+		{
+			.D = 0x0u,
+			.E = 0x0u,
+			.CA2 = 0x0u,
+			.CL0 = 0x0u,
+			.CA3 = 0x0u,
+			.I0 = 0x0u,
+			.CL1 = 0x0u,
+			.I3 = 0x0u,
+			.I2 = 0x0u,
+			.CL2 = 0x0u,
+			.CA1 = 0x0u,
+			.CA0 = 0x0u,
+			.CL3 = 0x0u,
+			.I1 = 0x0u,
+			.RAMT = 0x0u,
+			.CSR = 0x0u,
+			.CMS = 0x0u
+		},
+	},
+};
+
+static struct lbist_inst_info lbist_inst_info_main_r5f2_x = {
+	/* Main Pulsar 2 Instance 1 or MAIN_R52_x */
+	.lbist_signature = (u32 *)(MAIN_R5F2_LBIST_SIG),
+	.intr_num = MCU_R5FSS0_CORE0_INTR_LBIST_BIST_DONE_0,
+	.expected_misr = MAIN_R5_MISR_EXP_VAL,
+	.lbist_conf = {
+		.dc_def        = LBIST_DC_DEF,
+		.divide_ratio  = LBIST_DIVIDE_RATIO,
+		.static_pc_def = LBIST_MAIN_R5_STATIC_PC_DEF,
+		.set_pc_def    = LBIST_SET_PC_DEF,
+		.reset_pc_def  = LBIST_RESET_PC_DEF,
+		.scan_pc_def   = LBIST_SCAN_PC_DEF,
+		.prpg_def_l      = LBIST_PRPG_DEF_L,
+		.prpg_def_u      = LBIST_PRPG_DEF_U,
+	},
+	.cut = {
+		.dev_id = TISCI_DEV_R5FSS2_CORE0,
+		.proc_id = PROC_ID_MCU_R5FSS2_CORE0,
+	},
+};
diff --git a/include/k3_bist.h b/include/k3_bist.h
new file mode 100644
index 00000000000..cc650f5a8c4
--- /dev/null
+++ b/include/k3_bist.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Texas Instruments' BIST (Built-In Self-Test) driver
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ *      Neha Malcom Francis <n-francis@ti.com>
+ *
+ */
+
+#ifndef _INCLUDE_BIST_H_
+#define _INCLUDE_BIST_H_
+
+#define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
+#define PROC_ID_MCU_R5FSS2_CORE0		0x0A
+#define PROC_ID_MCU_R5FSS2_CORE1		0x0B
+#define PROC_BOOT_CTRL_FLAG_R5_LPSC		0x00000002
+
+#define TISCI_DEV_PBIST14 237
+#define TISCI_DEV_R5FSS2_CORE0 343
+#define TISCI_DEV_R5FSS2_CORE1 344
+
+#define TISCI_MSG_VALUE_DEVICE_SW_STATE_AUTO_OFF 0
+#define TISCI_MSG_VALUE_DEVICE_SW_STATE_RETENTION 1
+#define TISCI_MSG_VALUE_DEVICE_SW_STATE_ON 2
+
+#define TISCI_BIT(n)  ((1) << (n))
+
+struct bist_ops {
+	int (*run_lbist)(void);
+	int (*run_lbist_post)(void);
+	int (*run_pbist_post)(void);
+	int (*run_pbist_neg)(void);
+	int (*run_pbist_rom)(void);
+	int (*run_pbist)(void);
+};
+
+void lbist_enable_isolation(void);
+void lbist_disable_isolation(void);
+int prepare_pbist(struct ti_sci_handle *handle);
+int deprepare_pbist(struct ti_sci_handle *handle);
+int prepare_lbist(struct ti_sci_handle *handle);
+int deprepare_lbist(struct ti_sci_handle *handle);
+
+#endif /* _INCLUDE_BIST_H_ */
-- 
2.34.1

