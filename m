Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A992CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 11:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC2188C60;
	Tue,  3 Sep 2024 13:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="arHBKPCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6631888AA; Tue,  3 Sep 2024 13:44:27 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD0F488B9F
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 13:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 483BiMAg059543;
 Tue, 3 Sep 2024 06:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725363862;
 bh=17P37fJWvBveiQyqWB/nH1MDTK5jhEcKMWT5OIil0do=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=arHBKPCaaSIraYUA41aMMKX2/VBMcPq+C6dvhlO/plUQE9kNbtS27sWXOjg8vbZMs
 +qGhSltkm3D1E7A0VEJJiaMAFPBFVgW76FoexqwN/GLQ5ofIOM895BNghAL7z6Gulu
 jJu3yNR055kC6rK+nH5ldyfJTqsM6WEDT0PIYG1M=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 483BiMoi013815
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Sep 2024 06:44:22 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 06:44:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 06:44:22 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483Bi2R6056540;
 Tue, 3 Sep 2024 06:44:18 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [RFC PATCH 4/6] drivers: misc: k3_bist: Add K3 BIST driver
Date: Tue, 3 Sep 2024 17:14:00 +0530
Message-ID: <20240903114402.2155740-5-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903114402.2155740-1-n-francis@ti.com>
References: <20240903114402.2155740-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add a driver for the BIST module which currently includes support for
BIST IPs that trigger PBIST (Memory BIST).

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/misc/Kconfig               |   8 +
 drivers/misc/Makefile              |   1 +
 drivers/misc/k3_bist.c             | 507 ++++++++++++++++++++++++++
 drivers/misc/k3_bist_static_data.h | 551 +++++++++++++++++++++++++++++
 4 files changed, 1067 insertions(+)
 create mode 100644 drivers/misc/k3_bist.c
 create mode 100644 drivers/misc/k3_bist_static_data.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6009d55f400..8e28a93d74c 100644
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
index e53d52c47b3..15c5c4810dd 100644
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
index 00000000000..a4728376b73
--- /dev/null
+++ b/drivers/misc/k3_bist.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments' BIST (Built-In Self-Test) driver
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
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
+
+#include "k3_bist_static_data.h"
+
+/* PBIST Timeout Value */
+#define PBIST_MAX_TIMEOUT_VALUE		100000000
+
+/**
+ * struct k3_bist_privdata - K3 BIST structure
+ * @dev: device pointer
+ * @base: base of register set
+ * @instance: PBIST instance number
+ * @intr_num: corresponding interrupt ID of the PBIST instance
+ */
+struct k3_bist_privdata {
+	struct udevice *dev;
+	void *base;
+	u32 instance;
+	u32 intr_num;
+};
+
+static struct k3_bist_privdata *k3_bist_priv;
+
+/**
+ * pbist_run_post_pbist_check() - Check POST results
+ *
+ * Function to check whether HW Power-On Self Test, i.e. POST has run
+ * successfully on the MCU domain.
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+int pbist_run_post_pbist_check(void)
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
+			debug("%s: PBIST was not performed at all on this device for this core\n",
+			      __func__);
+			return -EINVAL;
+		} else {
+			debug("%s: PBIST was attempted but timed out for this section\n", __func__);
+			return -ETIMEDOUT;
+		}
+	} else {
+		/* HW POST: PBIST was completed on this device, check the result */
+		mask = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_FAIL_MASK;
+
+		if ((post_reg_val & mask) != 0) {
+			debug("%s: PBIST was completed, but the test failed\n", __func__);
+			return -EINVAL;
+		} else {
+			debug("%s: HW POST PBIST completed, test passed\n", __func__);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * core_get_by_index() - Configure processor to correct state
+ *
+ * Function to configure processor under test to correct state for SW-initiated
+ * PBIST
+ * @dev: BIST device
+ * @index: corresponding index of the core in the cores-under-test list
+ * @turnoff: true if core is needed to be turned off
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+int core_get_by_index(struct udevice *dev, int index, bool turnoff)
+{
+	struct ofnode_phandle_args args;
+	int ret;
+	struct udevice *dev_core;
+
+	ret = dev_read_phandle_with_args(dev, "cores-under-test", NULL, 0, index, &args);
+	if (ret) {
+		debug("%s: dev_read_phandle_with_args failed: %d\n", __func__,
+		      ret);
+		return ret;
+	}
+	ret =  uclass_get_device_by_ofnode(UCLASS_REMOTEPROC, args.node, &dev_core);
+	if (ret) {
+		debug("%s: uclass_get_device_by_of_offset failed: %d\n",
+		      __func__, ret);
+		return ret;
+	}
+
+	if (turnoff) {
+		struct power_domain pwrdmn;
+		struct clk fclk;
+
+		ret = power_domain_get_by_index(dev_core, &pwrdmn, 0);
+		if (ret) {
+			dev_err(dev, "failed to get power domain for the core %d\n", ret);
+			return ret;
+		}
+
+		ret = clk_get_by_index(dev_core, 0, &fclk);
+		if (ret) {
+			dev_err(dev, "failed to get clock for the core %d\n", ret);
+			return ret;
+		}
+
+		ret = power_domain_off(&pwrdmn);
+		if (ret) {
+			dev_err(dev, "failed to power OFF the core %d\n", ret);
+			return ret;
+		}
+
+		ret = power_domain_free(&pwrdmn);
+		if (ret) {
+			dev_err(dev, "failed to free the core %d\n", ret);
+			return ret;
+		}
+		ret = clk_disable(&fclk);
+		if (ret) {
+			dev_err(dev, "failed to disable clock of the core %d\n", ret);
+			return ret;
+		}
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
+int pbist_self_test(struct pbist_config *config)
+{
+	struct udevice *dev = k3_bist_priv->dev;
+	void *base = k3_bist_priv->base;
+	u32 intr_num = k3_bist_priv->intr_num;
+	bool test_result = true;
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
+	udelay(1000);
+
+	u32 timeout_count = 0;
+
+	while ((!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) &&
+	       (timeout_count++ < PBIST_MAX_TIMEOUT_VALUE))
+		;
+
+	if (!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) {
+		test_result = false;
+		debug("%s(dev=%p): test failed\n", __func__, dev);
+	} else {
+		debug("%s(dev=%p): test passed\n", __func__, dev);
+	}
+
+	writel(0xffffffff, VIM_STS(intr_num));
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
+int pbist_neg_self_test(struct pbist_config_neg *config)
+{
+	struct udevice *dev = k3_bist_priv->dev;
+	void *base = k3_bist_priv->base;
+	u32 intr_num = k3_bist_priv->intr_num;
+	bool test_result = true;
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
+	udelay(1000);
+
+	u32 timeout_count = 0;
+
+	while ((!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) &&
+	       (timeout_count++ < PBIST_MAX_TIMEOUT_VALUE))
+		;
+
+	if (!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) {
+		test_result = false;
+		debug("%s(dev=%p): test failed\n", __func__, dev);
+	} else {
+		debug("%s(dev=%p): test passed\n", __func__, dev);
+	}
+
+	writel(0xffffffff, VIM_STS(intr_num));
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
+int pbist_rom_self_test(struct pbist_config_rom *config)
+{
+	struct udevice *dev = k3_bist_priv->dev;
+	void *base = k3_bist_priv->base;
+	u32 intr_num = k3_bist_priv->intr_num;
+	bool test_result = true;
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
+	udelay(1000);
+
+	u32 timeout_count = 0;
+
+	while ((!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) &&
+	       (timeout_count++ < PBIST_MAX_TIMEOUT_VALUE))
+		;
+
+	if (!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) {
+		test_result = false;
+		debug("%s(dev=%p): test failed\n", __func__, dev);
+	} else {
+		debug("%s(dev=%p): test passed\n", __func__, dev);
+	}
+
+	writel(0xffffffff, VIM_STS(intr_num));
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
+	int ret = 0, num_runs, i, j;
+	struct k3_bist_privdata *priv = dev_get_priv(dev);
+	struct pbist_inst_info *info;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	priv = dev_get_priv(dev);
+	priv->dev = dev;
+
+	k3_bist_priv = priv;
+
+	priv->base = dev_remap_addr_index(dev, 0);
+	if (!priv->base)
+		return -ENODEV;
+
+	ret = dev_read_u32(dev, "ti,bist-instance", &priv->instance);
+	if (!priv->instance)
+		return -ENODEV;
+
+	switch (priv->instance) {
+	case PBIST14_INSTANCE:
+		info = &pbist14_inst_info;
+		priv->intr_num = info->intr_num;
+		break;
+	default:
+		dev_err(dev, "%s: PBIST instance %d not supported\n", __func__, priv->instance);
+		return -ENODEV;
+	};
+
+	/* Probe the cores under test */
+	for (i = 0; ; i++) {
+		ret = core_get_by_index(dev, i, false);
+		if (ret)
+			break;
+	}
+
+	if (!i) {
+		dev_err(dev, "%s: Acquiring the core failed. ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Check whether HW POST successfully completely PBIST on the MCU domain */
+	ret = pbist_run_post_pbist_check();
+	if (ret) {
+		dev_err(dev, "HW POST failed to run successfully %d\n", ret);
+		return ret;
+	}
+
+	/* Run PBIST test */
+	num_runs = info->num_pbist_runs;
+
+	for (j = 0; j < num_runs; j++) {
+		ret = pbist_self_test(&info->pbist_config_run[j]);
+		if (ret) {
+			dev_err(dev, "failed to run PBIST test %d\n", ret);
+			return ret;
+		}
+	}
+
+	/* Run PBIST failure insertion test */
+	ret = pbist_neg_self_test(&info->pbist_neg_config_run);
+	if (ret) {
+		dev_err(dev, "failed to run PBIST negative test %d\n", ret);
+		return ret;
+	}
+
+	/* Run PBIST test on ROM */
+	num_runs = info->num_pbist_rom_test_runs;
+
+	for (j = 0; j < num_runs; j++) {
+		ret = pbist_rom_self_test(&info->pbist_rom_test_config_run[j]);
+		if (ret) {
+			dev_err(dev, "failed to run ROM PBIST test %d\n", ret);
+			return ret;
+		}
+	}
+
+	/* Power off cores under test */
+	while (i--) {
+		ret = core_get_by_index(dev, i, true);
+		if (ret)
+			break;
+	}
+
+	if (i) {
+		dev_err(dev, "%s: Stopping the core failed. ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
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
+	.probe = k3_bist_probe,
+	.priv_auto = sizeof(struct k3_bist_privdata),
+};
diff --git a/drivers/misc/k3_bist_static_data.h b/drivers/misc/k3_bist_static_data.h
new file mode 100644
index 00000000000..f30fb7935b6
--- /dev/null
+++ b/drivers/misc/k3_bist_static_data.h
@@ -0,0 +1,551 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Static Data for Texas Instruments' BIST (Built-In Self-Test) driver
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#ifndef __K3_BIST_STATIC_DATA_H
+#define __K3_BIST_STATIC_DATA_H
+
+#define PBIST_MAX_NUM_RUNS	2
+#define NUM_MAX_PBIST_TEST_ROM_RUNS 13
+#define PBIST14_DFT_PBIST_CPU_0_INTR_NUM 311
+
+/* VIM Registers */
+#define VIM_STS_BASE						  0x40f80404
+#define VIM_RAW_BASE						  0x40f80400
+
+#define VIM_STS(i)			(VIM_STS_BASE + (i) / 32 * 0x20)
+#define VIM_RAW(i)	      (VIM_RAW_BASE + (i) / 32 * 0x20)
+#define VIM_RAW_MASK(i)	 (BIT((i) % 32))
+
+/* PBIST Registers and Flags*/
+#define PBIST_RF0L						    0x00000000
+#define PBIST_RF1L						    0x00000004
+#define PBIST_RF2L						    0x00000008
+#define PBIST_RF3L						    0x0000000C
+#define PBIST_RF4L						    0x0000010
+#define PBIST_RF5L						    0x0000014
+#define PBIST_RF6L						    0x0000018
+#define PBIST_RF7L						    0x000001C
+#define PBIST_RF8L						    0x0000020
+#define PBIST_RF9L						    0x0000024
+#define PBIST_RF10L						   0x0000028
+#define PBIST_RF11L						   0x000002C
+#define PBIST_RF12L						   0x0000030
+#define PBIST_RF13L						   0x0000034
+#define PBIST_RF14L						   0x0000038
+#define PBIST_RF15L						   0x000003C
+#define PBIST_RF0U						    0x0000040
+#define PBIST_RF1U						    0x0000044
+#define PBIST_RF2U						    0x0000048
+#define PBIST_RF3U						    0x000004C
+#define PBIST_RF4U						    0x0000050
+#define PBIST_RF5U						    0x0000054
+#define PBIST_RF6U						    0x0000058
+#define PBIST_RF7U						    0x000005C
+#define PBIST_RF8U						    0x0000060
+#define PBIST_RF9U						    0x0000064
+#define PBIST_RF10U						   0x0000068
+#define PBIST_RF11U						   0x000006C
+#define PBIST_RF12U						   0x0000070
+#define PBIST_RF13U						   0x0000074
+#define PBIST_RF14U						   0x0000078
+#define PBIST_RF15U						   0x000007C
+#define PBIST_A0							    0x0000100
+#define PBIST_A1							    0x0000104
+#define PBIST_A2							    0x0000108
+#define PBIST_A3							    0x000010C
+#define PBIST_L0							    0x0000110
+#define PBIST_L1							    0x0000114
+#define PBIST_L2							    0x0000118
+#define PBIST_L3							    0x000011C
+#define PBIST_D							     0x0000120
+#define PBIST_E							     0x0000124
+#define PBIST_CA0							   0x0000130
+#define PBIST_CA1							   0x0000134
+#define PBIST_CA2							   0x0000138
+#define PBIST_CA3							   0x000013C
+#define PBIST_CL0							   0x0000140
+#define PBIST_CL1							   0x0000144
+#define PBIST_CL2							   0x0000148
+#define PBIST_CL3							   0x000014C
+#define PBIST_I0							    0x0000150
+#define PBIST_I1							    0x0000154
+#define PBIST_I2							    0x0000158
+#define PBIST_I3							    0x000015C
+#define PBIST_RAMT							  0x0000160
+#define PBIST_DLR							   0x0000164
+#define PBIST_CMS							   0x0000168
+#define PBIST_STR							   0x000016C
+#define PBIST_SCR							   0x0000170
+#define PBIST_SCR_LO								0x0000170
+#define PBIST_SCR_HI								0x0000174
+#define PBIST_CSR							   0x0000178
+#define PBIST_FDLY							  0x000017C
+#define PBIST_PACT							  0x0000180
+#define PBIST_PID							   0x0000184
+#define PBIST_OVER							  0x0000188
+#define PBIST_FSPBIST_RF						    0x0000190
+#define PBIST_FSRC							  0x0000198
+#define PBIST_FSRA							  0x00001A0
+#define PBIST_FSRDL0							0x00001A8
+#define PBIST_FSRDL1							0x00001B0
+#define PBIST_MARGIN_MODE						   0x00001B4
+#define PBIST_WRENZ							 0x00001B8
+#define PBIST_PAGE_PGS						      0x00001BC
+#define PBIST_ROM							   0x00001C0
+#define PBIST_ALGO							  0x00001C4
+#define PBIST_RINFO							 0x00001C8
+
+#define PBIST_MARGIN_MODE_PBIST_DFT_WRITE_MASK				0x00000003
+#define PBIST_MARGIN_MODE_PBIST_DFT_READ_SHIFT				0x00000002
+#define PBIST_MARGIN_MODE_PBIST_DFT_READ_MASK				0x0000000C
+#define PBIST_PACT_PACT_MASK						0x00000001
+#define PBIST_DLR_DLR0_ROM_MASK						0x00000004
+#define PBIST_DLR_DLR0_CAM_MASK						0x00000010
+#define PBIST_NOT_DONE							0
+#define PBIST_DONE							1
+
+/* PBIST test mode */
+#define PBIST_TEST_MODE (PBIST_MARGIN_MODE_PBIST_DFT_WRITE_MASK \
+			 | (1 << PBIST_MARGIN_MODE_PBIST_DFT_READ_SHIFT))
+
+/* PBIST Failure Insertion test mode */
+#define PBIST_FAILURE_INSERTION_TEST_MODE (PBIST_MARGIN_MODE_PBIST_DFT_WRITE_MASK \
+					   | PBIST_MARGIN_MODE_PBIST_DFT_READ_MASK)
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
+	struct pbist_config pbist_config_run[PBIST_MAX_NUM_RUNS];
+	struct pbist_config_neg pbist_neg_config_run;
+	u32 num_pbist_rom_test_runs;
+	struct pbist_config_rom pbist_rom_test_config_run[NUM_MAX_PBIST_TEST_ROM_RUNS];
+};
+
+#if IS_ENABLED(CONFIG_SOC_K3_J784S4)
+
+/* WKUP CTRL MMR Registers */
+#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT				0x0000C2C0
+#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_DONE_SHIFT	0x00000008
+#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_TIMEOUT_SHIFT	0x00000009
+#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_FAIL_MASK	0x00008000
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
+#define PBIST14_FAIL_INSERTION_TEST_VECTOR_RAMT			      0x011D2528
+
+static struct pbist_inst_info pbist14_inst_info = {
+	/* Main Pulsar 2 Instance 1 or MAIN_R52_x */
+	.num_pbist_runs = 1,
+	.intr_num = PBIST14_DFT_PBIST_CPU_0_INTR_NUM,
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
+#endif /* CONFIG_SOC_K3_J784S4 */
+#endif /* __TI_SCI_STATIC_DATA_H */
-- 
2.34.1

