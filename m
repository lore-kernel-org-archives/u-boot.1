Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C828C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 11:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD4388845;
	Wed, 22 May 2024 13:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xTwC3AUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C67F88845; Wed, 22 May 2024 13:37:42 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 123BE88831
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 13:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44MBbYhQ101456;
 Wed, 22 May 2024 06:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716377854;
 bh=otdTBcoRtCf34svglGda5Bqj/C4r182/VDZ6a7KyUac=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xTwC3AUIevbjU1rEaYGRkyJSnrjzvVvTxuG5O9DDzfs+kSV/kw/k2PwfwWSyNO8f5
 JqCE7JfGoi9Zx/+3n1DoyYYn4qRGDR+bzZGImcnqKFqN2CWA/0kMdfR9d5PwXqMHT7
 AgGOTvHPUqJwgK38CTNDLPmJ6/ZQWGLSbmA/uSgk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44MBbYNE055234
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 06:37:34 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 06:37:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 06:37:34 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.6])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44MBbX9i078484;
 Wed, 22 May 2024 06:37:34 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <j-choudhary@ti.com>
CC: <a-bhatia1@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <joao.goncalves@toradex.com>, <afd@ti.com>, <j-humphreys@ti.com>,
 <d.haller@phytec.de>, <hnagalla@ti.com>, <bb@ti.com>,
 <seanga2@gmail.com>, <sjg@chromium.org>, <clamor95@gmail.com>,
 <martyn.welch@collabora.com>, <m-chawdhry@ti.com>, <a-limaye@ti.com>
Subject: [PATCH 4/7] arm: mach-k3: j784s4: Enable QoS for DSS
Date: Wed, 22 May 2024 17:07:23 +0530
Message-ID: <20240522113726.302908-5-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522113726.302908-1-j-choudhary@ti.com>
References: <20240522113726.302908-1-j-choudhary@ti.com>
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

Enable Quality of Service (QoS) blocks for Display SubSystem (DSS), by
servicing the DSS - DDR traffic from the Real-Time (RT) queue. This is
done by setting the DSS DMA orderID to greater than 9.
ATYPE 3 is selected so that the traffic takes non-coherent path and does
not have a conflict with coherent traffic from C7x (deep-learning
applications).
Before setting up the QoS, the ORDERID needs to be mapped to VBUSM sources
using setup_navss_nb() function call that sets the threadmap for NBSS
registers. (Section 10.2.9.2.10 "Quality of Service" in TRM[0])

Section 3.2.1 "Quality of Service (QoS)" in the TRM[0] provide more
details.

[0]: https://www.ti.com/lit/zip/spruj52

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c         |  30 +++++
 arch/arm/mach-k3/r5/j784s4/Makefile           |   1 +
 arch/arm/mach-k3/r5/j784s4/j784s4_qos.h       |  83 +++++++++++++
 arch/arm/mach-k3/r5/j784s4/j784s4_qos_uboot.c | 109 ++++++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 arch/arm/mach-k3/r5/j784s4/j784s4_qos.h
 create mode 100644 arch/arm/mach-k3/r5/j784s4/j784s4_qos_uboot.c

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 1ce13e0f49..07b5d7d750 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -23,6 +23,24 @@
 
 #define J784S4_MAX_DDR_CONTROLLERS	4
 
+/* NAVSS North Bridge (NB) */
+#define NAVSS0_NBSS_NB0_CFG_MMRS		0x03702000
+#define NAVSS0_NBSS_NB1_CFG_MMRS		0x03703000
+#define NAVSS0_NBSS_NB0_CFG_NB_THREADMAP	(NAVSS0_NBSS_NB0_CFG_MMRS + 0x10)
+#define NAVSS0_NBSS_NB1_CFG_NB_THREADMAP	(NAVSS0_NBSS_NB1_CFG_MMRS + 0x10)
+/*
+ * Thread Map for North Bridge Configuration
+ * Each bit is for each VBUSM source.
+ * Bit[0] maps orderID 0-3 to VBUSM.C thread number
+ * Bit[1] maps orderID 4-9 to VBUSM.C thread number
+ * Bit[2] maps orderID 10-15 to VBUSM.C thread number
+ * When bit has value 0: VBUSM.C thread 0 (non-real time traffic)
+ * When bit has value 1: VBUSM.C thread 2 (real time traffic)
+ */
+#define NB_THREADMAP_BIT0				BIT(0)
+#define NB_THREADMAP_BIT1				BIT(1)
+#define NB_THREADMAP_BIT2				BIT(2)
+
 struct fwl_data infra_cbass0_fwls[] = {
 	{ "PSC0", 5, 1 },
 	{ "PLL_CTRL0", 6, 1 },
@@ -94,6 +112,13 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(CTRL_MMR0_BASE, 7);
 }
 
+/* Setup North Bridge registers to map ORDERID 10-15 to RT traffic */
+static void setup_navss_nb(void)
+{
+	writel(NB_THREADMAP_BIT1, (uintptr_t)NAVSS0_NBSS_NB0_CFG_NB_THREADMAP);
+	writel(NB_THREADMAP_BIT2, (uintptr_t)NAVSS0_NBSS_NB1_CFG_NB_THREADMAP);
+}
+
 /*
  * This uninitialized global variable would normal end up in the .bss section,
  * but the .bss is cleared between writing and reading this variable, so move
@@ -210,6 +235,11 @@ void board_init_f(ulong dummy)
 {
 	k3_spl_init();
 	k3_mem_init();
+
+	if (IS_ENABLED(CONFIG_CPU_V7R))
+		setup_navss_nb();
+
+	setup_qos();
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
diff --git a/arch/arm/mach-k3/r5/j784s4/Makefile b/arch/arm/mach-k3/r5/j784s4/Makefile
index 9ce88305f5..0fd6cabd3f 100644
--- a/arch/arm/mach-k3/r5/j784s4/Makefile
+++ b/arch/arm/mach-k3/r5/j784s4/Makefile
@@ -5,3 +5,4 @@
 
 obj-y += clk-data.o
 obj-y += dev-data.o
+obj-y += j784s4_qos_uboot.o
diff --git a/arch/arm/mach-k3/r5/j784s4/j784s4_qos.h b/arch/arm/mach-k3/r5/j784s4/j784s4_qos.h
new file mode 100644
index 0000000000..5851f889fe
--- /dev/null
+++ b/arch/arm/mach-k3/r5/j784s4/j784s4_qos.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Keystone3 Quality of service endpoint definitions
+ * Auto generated by K3 Resource Partitioning Tool
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#define SMS_WKUP_0_TIFS_VBUSP_M	0x45D00000
+#define SMS_WKUP_0_HSM_VBUSP_M	0x45D00400
+#define PULSAR_SL_MCU_0_CPU0_RMST	0x45D10000
+#define PULSAR_SL_MCU_0_CPU0_WMST	0x45D10400
+#define PULSAR_SL_MCU_0_CPU0_PMST	0x45D10800
+#define PULSAR_SL_MCU_0_CPU1_RMST	0x45D11000
+#define PULSAR_SL_MCU_0_CPU1_WMST	0x45D11400
+#define PULSAR_SL_MCU_0_CPU1_PMST	0x45D11800
+#define SA3SS_AM62_MCU_0_CTXCACH_EXT_DMA	0x45D13000
+#define PULSAR_SL_MAIN_0_PBDG_RMST0	0x45D78000
+#define PULSAR_SL_MAIN_0_PBDG_WMST0	0x45D78400
+#define PULSAR_SL_MAIN_0_PBDG_RMST1	0x45D78800
+#define PULSAR_SL_MAIN_0_PBDG_WMST1	0x45D78C00
+#define EMMCSD4SS_MAIN_0_EMMCSDSS_RD	0x45D82800
+#define EMMCSD4SS_MAIN_0_EMMCSDSS_WR	0x45D82C00
+#define COMPUTE_CLUSTER_J7AHP_MAIN_0_GIC_MEM_RD_VBUSM	0x45D86000
+#define COMPUTE_CLUSTER_J7AHP_MAIN_0_GIC_MEM_WR_VBUSM	0x45D86400
+#define PCIE_G3X4_128_MAIN_0_PCIE_MST_RD	0x45D98400
+#define PCIE_G3X4_128_MAIN_0_PCIE_MST_WR	0x45D98C00
+#define PCIE_G3X4_128_MAIN_1_PCIE_MST_RD	0x45D99400
+#define PCIE_G3X4_128_MAIN_1_PCIE_MST_WR	0x45D99C00
+#define USB3P0SS_16FFC_MAIN_0_MSTR0	0x45D9A000
+#define USB3P0SS_16FFC_MAIN_0_MSTW0	0x45D9A400
+#define UFSHCI2P1SS_16FFC_MAIN_0_UFSHCI_VBM_MST_RD	0x45D9AC00
+#define UFSHCI2P1SS_16FFC_MAIN_0_UFSHCI_VBM_MST_WR	0x45D9B000
+#define EMMC8SS_16FFC_MAIN_0_EMMCSS_WR	0x45D9B400
+#define EMMC8SS_16FFC_MAIN_0_EMMCSS_RD	0x45D9B800
+#define SA2_UL_MAIN_0_CTXCACH_EXT_DMA	0x45D9BC00
+#define VUSR_DUAL_MAIN_0_V0_M	0x45D9C000
+#define VUSR_DUAL_MAIN_0_V1_M	0x45D9C400
+#define PCIE_G3X4_128_MAIN_2_PCIE_MST_RD	0x45D9CC00
+#define PCIE_G3X4_128_MAIN_3_PCIE_MST_WR	0x45D9D400
+#define PCIE_G3X4_128_MAIN_2_PCIE_MST_WR	0x45D9D800
+#define PCIE_G3X4_128_MAIN_3_PCIE_MST_RD	0x45D9DC00
+#define DEBUGSS_K3_WRAP_CV0_MAIN_0_VBUSMR	0x45DA0000
+#define DEBUGSS_K3_WRAP_CV0_MAIN_0_VBUSMW	0x45DA0400
+#define PULSAR_SL_MAIN_1_CPU0_RMST	0x45DA8000
+#define PULSAR_SL_MAIN_1_CPU0_WMST	0x45DA8400
+#define PULSAR_SL_MAIN_1_CPU1_RMST	0x45DA8800
+#define PULSAR_SL_MAIN_1_CPU1_WMST	0x45DA8C00
+#define PULSAR_SL_MAIN_2_CPU0_RMST	0x45DA9000
+#define PULSAR_SL_MAIN_2_CPU0_WMST	0x45DA9400
+#define PULSAR_SL_MAIN_2_CPU1_RMST	0x45DA9800
+#define PULSAR_SL_MAIN_2_CPU1_WMST	0x45DA9C00
+#define DMPAC_TOP_MAIN_0_DATA_MST	0x45DC0000
+#define K3_VPU_WAVE521CL_MAIN_0_SEC_M_VBUSM_R_ASYNC	0x45DC0C00
+#define K3_VPU_WAVE521CL_MAIN_0_SEC_M_VBUSM_W_ASYNC	0x45DC1000
+#define VPAC_TOP_MAIN_0_DATA_MST_0	0x45DC1400
+#define VPAC_TOP_MAIN_0_DATA_MST_1	0x45DC1800
+#define VPAC_TOP_MAIN_0_LDC0_M_MST	0x45DC1C00
+#define K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA	0x45DC2000
+#define K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC	0x45DC2400
+#define VPAC_TOP_MAIN_1_LDC0_M_MST	0x45DC2800
+#define VPAC_TOP_MAIN_1_DATA_MST_0	0x45DC2C00
+#define VPAC_TOP_MAIN_1_DATA_MST_1	0x45DC3000
+#define K3_VPU_WAVE521CL_MAIN_0_PRI_M_VBUSM_R_ASYNC	0x45DC3400
+#define K3_VPU_WAVE521CL_MAIN_0_PRI_M_VBUSM_W_ASYNC	0x45DC3800
+#define K3_VPU_WAVE521CL_MAIN_1_SEC_M_VBUSM_R_ASYNC	0x45DC3C00
+#define K3_VPU_WAVE521CL_MAIN_1_SEC_M_VBUSM_W_ASYNC	0x45DC4000
+#define K3_VPU_WAVE521CL_MAIN_1_PRI_M_VBUSM_R_ASYNC	0x45DC4400
+#define K3_VPU_WAVE521CL_MAIN_1_PRI_M_VBUSM_W_ASYNC	0x45DC4800
+#define J7AEP_GPU_BXS464_WRAP_MAIN_0_M_VBUSM_R_SYNC	0x45DC5000
+#define J7AEP_GPU_BXS464_WRAP_MAIN_0_M_VBUSM_W_SYNC	0x45DC5800
+#define PULSAR_SL_MAIN_0_CPU0_RMST	0x45DC8000
+#define PULSAR_SL_MAIN_0_CPU0_WMST	0x45DC8400
+#define PULSAR_SL_MAIN_0_CPU1_RMST	0x45DC8800
+#define PULSAR_SL_MAIN_0_CPU1_WMST	0x45DC8C00
+#define PULSAR_SL_MAIN_1_PBDG_RMST0	0x45DCA000
+#define PULSAR_SL_MAIN_1_PBDG_WMST0	0x45DCA400
+#define PULSAR_SL_MAIN_1_PBDG_RMST1	0x45DCA800
+#define PULSAR_SL_MAIN_1_PBDG_WMST1	0x45DCAC00
+#define PULSAR_SL_MAIN_2_PBDG_RMST0	0x45DCB000
+#define PULSAR_SL_MAIN_2_PBDG_WMST0	0x45DCB400
+#define PULSAR_SL_MAIN_2_PBDG_RMST1	0x45DCB800
+#define PULSAR_SL_MAIN_2_PBDG_WMST1	0x45DCBC00
diff --git a/arch/arm/mach-k3/r5/j784s4/j784s4_qos_uboot.c b/arch/arm/mach-k3/r5/j784s4/j784s4_qos_uboot.c
new file mode 100644
index 0000000000..2713741733
--- /dev/null
+++ b/arch/arm/mach-k3/r5/j784s4/j784s4_qos_uboot.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * j784s4 Quality of Service (QoS) Configuration Data
+ * Auto generated from K3 Resource Partitioning tool
+ */
+
+#include <asm/arch/k3-qos.h>
+#include "j784s4_qos.h"
+
+struct k3_qos_data qos_data[] = {
+	/* DSS_PIPE_VID1 - 2 endpoints, 2 channels */
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0x100 + 0x4 * 0,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0x100 + 0x4 * 1,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC + 0x100 + 0x4 * 0,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC + 0x100 + 0x4 * 1,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+
+	/* DSS_PIPE_VIDL1 - 2 endpoints, 2 channels */
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0x100 + 0x4 * 2,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0x100 + 0x4 * 3,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC + 0x100 + 0x4 * 2,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC + 0x100 + 0x4 * 3,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+
+	/* DSS_PIPE_VID2 - 2 endpoints, 2 channels */
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0x100 + 0x4 * 4,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0x100 + 0x4 * 5,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC + 0x100 + 0x4 * 4,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC + 0x100 + 0x4 * 5,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+
+	/* DSS_PIPE_VIDL2 - 2 endpoints, 2 channels */
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0x100 + 0x4 * 6,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0x100 + 0x4 * 7,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC + 0x100 + 0x4 * 6,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC + 0x100 + 0x4 * 7,
+		.val = ATYPE_3 | ORDERID_15,
+	},
+
+	/* Following registers set 1:1 mapping for orderID MAP1/MAP2
+	 * remap registers. orderID x is remapped to orderID x again
+	 * This is to ensure orderID from MAP register is unchanged
+	 */
+
+	/* K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA - 1 groups */
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0,
+		.val = 0x76543210,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 4,
+		.val = 0xfedcba98,
+	},
+
+	/* K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC - 1 groups */
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC + 0,
+		.val = 0x76543210,
+	},
+	{
+		.reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_FBDC + 4,
+		.val = 0xfedcba98,
+	},
+};
+
+u32 qos_count = ARRAY_SIZE(qos_data);
-- 
2.25.1

