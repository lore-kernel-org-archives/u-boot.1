Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2EDC25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 11:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB8D8883B;
	Wed, 22 May 2024 13:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Nv2GqNAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB3588837; Wed, 22 May 2024 13:37:41 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F0058882F
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 13:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44MBbXIM083643;
 Wed, 22 May 2024 06:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716377853;
 bh=9Y8GZv+TG1KU9dM2DEWdqG6znJLDGiV9V/sXf8HJPGQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Nv2GqNAuQR7R4n0MIISJhkqCtOD9U/QOV3Fz0VEiEn1OF39YqwVBc6MNTr/A/eaCf
 KdcYBU6wLQCR4UdBslOOTvHt/k15pcMVLvhaNcUyArpexfm3kyLG4YUT6y5eoMlq0k
 R6tu+KHSKdAGSiGL8kwrU0uOwzMCsyfl5jWVWcr0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44MBbXGt007772
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 06:37:33 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 06:37:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 06:37:32 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.6])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44MBbWPC078469;
 Wed, 22 May 2024 06:37:32 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <j-choudhary@ti.com>
CC: <a-bhatia1@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <joao.goncalves@toradex.com>, <afd@ti.com>, <j-humphreys@ti.com>,
 <d.haller@phytec.de>, <hnagalla@ti.com>, <bb@ti.com>,
 <seanga2@gmail.com>, <sjg@chromium.org>, <clamor95@gmail.com>,
 <martyn.welch@collabora.com>, <m-chawdhry@ti.com>, <a-limaye@ti.com>
Subject: [PATCH 3/7] arm: mach-k3: j721s2: Enable QoS for DSS
Date: Wed, 22 May 2024 17:07:22 +0530
Message-ID: <20240522113726.302908-4-j-choudhary@ti.com>
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

[0]: https://www.ti.com/lit/zip/spruj28

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm/mach-k3/j721s2/j721s2_init.c         |  30 +++++
 arch/arm/mach-k3/r5/j721s2/Makefile           |   1 +
 arch/arm/mach-k3/r5/j721s2/j721s2_qos.h       |  79 +++++++++++++
 arch/arm/mach-k3/r5/j721s2/j721s2_qos_uboot.c | 109 ++++++++++++++++++
 4 files changed, 219 insertions(+)
 create mode 100644 arch/arm/mach-k3/r5/j721s2/j721s2_qos.h
 create mode 100644 arch/arm/mach-k3/r5/j721s2/j721s2_qos_uboot.c

diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index fe9766e9b4..05453fcad4 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -22,6 +22,24 @@
 #include "../sysfw-loader.h"
 #include "../common.h"
 
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
 struct fwl_data cbass_hc_cfg0_fwls[] = {
 	{ "PCIE0_CFG", 2577, 7 },
 	{ "EMMC8SS0_CFG", 2579, 4 },
@@ -123,6 +141,13 @@ void k3_mmc_restart_clock(void)
 	}
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
@@ -295,6 +320,11 @@ void board_init_f(ulong dummy)
 	do_dt_magic();
 #endif
 	k3_mem_init();
+
+	if (IS_ENABLED(CONFIG_CPU_V7R))
+		setup_navss_nb();
+
+	setup_qos();
 }
 #endif
 
diff --git a/arch/arm/mach-k3/r5/j721s2/Makefile b/arch/arm/mach-k3/r5/j721s2/Makefile
index 8588c5e4c3..89c0284b56 100644
--- a/arch/arm/mach-k3/r5/j721s2/Makefile
+++ b/arch/arm/mach-k3/r5/j721s2/Makefile
@@ -3,3 +3,4 @@
 # Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
 obj-y += clk-data.o
 obj-y += dev-data.o
+obj-y += j721s2_qos_uboot.o
diff --git a/arch/arm/mach-k3/r5/j721s2/j721s2_qos.h b/arch/arm/mach-k3/r5/j721s2/j721s2_qos.h
new file mode 100644
index 0000000000..ab3e4773a4
--- /dev/null
+++ b/arch/arm/mach-k3/r5/j721s2/j721s2_qos.h
@@ -0,0 +1,79 @@
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
diff --git a/arch/arm/mach-k3/r5/j721s2/j721s2_qos_uboot.c b/arch/arm/mach-k3/r5/j721s2/j721s2_qos_uboot.c
new file mode 100644
index 0000000000..e8ad87bdac
--- /dev/null
+++ b/arch/arm/mach-k3/r5/j721s2/j721s2_qos_uboot.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * j721s2 Quality of Service (QoS) Configuration Data
+ * Auto generated from K3 Resource Partitioning tool
+ */
+
+#include <asm/arch/k3-qos.h>
+#include "j721s2_qos.h"
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

