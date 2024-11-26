Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC931D5A6EA
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 07:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3E489C4C;
	Tue, 26 Nov 2024 08:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S4nberMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0433589C2D; Tue, 26 Nov 2024 08:06:27 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E7BA89651
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ76Lp8043876;
 Tue, 26 Nov 2024 01:06:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732604781;
 bh=guHk5vIVzYgluYO3z1X+yYbF4S7F3MSS9AQveIYAm08=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=S4nberMvNdldN5q5xKxBnrcV61qY9IgSuvVmXsiTK5I8x6+f3iOlEfWaDyiJ8WUbc
 tpinatmVK7Q6sj8z5viNK+/WJGf4vRAy29FDlNXQ5Tem+hmKdV2ITDq0GiIXYp8zWQ
 iHwUgE4Vp5EY9+VH/FE14l623tFfxOPRc8WXQI4A=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ76LkR024525
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Nov 2024 01:06:21 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 01:06:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 01:06:20 -0600
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com
 [10.24.72.175])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ76Jf2093035;
 Tue, 26 Nov 2024 01:06:20 -0600
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <bb@ti.com>
CC: <vaishnav.a@ti.com>, <afd@ti.com>, <n-francis@ti.com>, <seanga2@gmail.com>,
 <francesco.dolcini@toradex.com>, <sjg@chromium.org>,
 <w.egorov@phytec.de>, <devarsht@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v2 2/4] arm: mach-k3: am62p: Add QoS support for DSS
Date: Tue, 26 Nov 2024 12:36:12 +0530
Message-ID: <20241126070614.47136-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126070614.47136-1-j-choudhary@ti.com>
References: <20241126070614.47136-1-j-choudhary@ti.com>
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

Enable Quality of Service (QoS) blocks for Display SubSystem (DSS), by
servicing the DSS - DDR traffic from the Real-Time (RT) queue. This is
done by setting the DSS DMA orderID to greater than 7.

DDR intensive software applications can overwhelm the DSS's access to
the DDR because of their higher frequency DDR accesses. This can cause
flickering in display with certain applications running parallely if
the DSS traffic is being serviced through non-RT queue.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c        |  2 +
 arch/arm/mach-k3/r5/am62px/Makefile          |  1 +
 arch/arm/mach-k3/r5/am62px/am62p_qos.h       | 42 ++++++++++++++
 arch/arm/mach-k3/r5/am62px/am62p_qos_uboot.c | 58 ++++++++++++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 arch/arm/mach-k3/r5/am62px/am62p_qos.h
 create mode 100644 arch/arm/mach-k3/r5/am62px/am62p_qos_uboot.c

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 34ed01cd78..2d35a7ce77 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -159,6 +159,8 @@ void board_init_f(ulong dummy)
 	}
 
 	spl_enable_cache();
+
+	setup_qos();
 	debug("am62px_init: %s done\n", __func__);
 }
 
diff --git a/arch/arm/mach-k3/r5/am62px/Makefile b/arch/arm/mach-k3/r5/am62px/Makefile
index 091d4fa5b4..066c3cef8d 100644
--- a/arch/arm/mach-k3/r5/am62px/Makefile
+++ b/arch/arm/mach-k3/r5/am62px/Makefile
@@ -4,3 +4,4 @@
 
 obj-y += clk-data.o
 obj-y += dev-data.o
+obj-y += am62p_qos_uboot.o
diff --git a/arch/arm/mach-k3/r5/am62px/am62p_qos.h b/arch/arm/mach-k3/r5/am62px/am62p_qos.h
new file mode 100644
index 0000000000..99e2ee4856
--- /dev/null
+++ b/arch/arm/mach-k3/r5/am62px/am62p_qos.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Keystone3 Quality of service endpoint definitions
+ * Auto generated by K3 Resource Partitioning Tool
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#define PULSAR_UL_WKUP_0_CPU0_RMST	0x45D14000
+#define PULSAR_UL_WKUP_0_CPU0_WMST	0x45D14400
+#define PULSAR_UL_WKUP_0_CPU0_PMST	0x45D14800
+#define PULSAR_UL_MAIN_0_CPU0_RMST	0x45D15000
+#define PULSAR_UL_MAIN_0_CPU0_WMST	0x45D15400
+#define PULSAR_UL_MAIN_0_CPU0_PMST	0x45D15800
+#define PULSAR_ULS_MCU_0_CPU0_RMST	0x45D18000
+#define PULSAR_ULS_MCU_0_CPU0_WMST	0x45D18400
+#define PULSAR_ULS_MCU_0_CPU0_PMST	0x45D18800
+#define SAM62A_A53_512KB_WRAP_MAIN_0_A53_QUAD_WRAP_CBA_AXI_R	0x45D20400
+#define SAM62A_A53_512KB_WRAP_MAIN_0_A53_QUAD_WRAP_CBA_AXI_W	0x45D20800
+#define DEBUGSS_K3_WRAP_CV0_MAIN_0_VBUSMW	0x45D21800
+#define DEBUGSS_K3_WRAP_CV0_MAIN_0_VBUSMR	0x45D21C00
+#define GIC500SS_1_4_MAIN_0_MEM_WR_VBUSM	0x45D22000
+#define GIC500SS_1_4_MAIN_0_MEM_RD_VBUSM	0x45D22400
+#define EMMCSD4SS_MAIN_0_EMMCSDSS_RD	0x45D23000
+#define EMMCSD4SS_MAIN_0_EMMCSDSS_WR	0x45D23400
+#define EMMCSD4SS_MAIN_1_EMMCSDSS_WR	0x45D23800
+#define EMMCSD4SS_MAIN_1_EMMCSDSS_RD	0x45D23C00
+#define SA3SS_AM62A_MAIN_0_CTXCACH_EXT_DMA	0x45D25400
+#define K3_VPU_WAVE521CL_MAIN_0_PRI_M_VBUSM_R_ASYNC	0x45D26800
+#define K3_VPU_WAVE521CL_MAIN_0_PRI_M_VBUSM_W_ASYNC	0x45D26C00
+#define K3_VPU_WAVE521CL_MAIN_0_SEC_M_VBUSM_R_ASYNC	0x45D27000
+#define K3_VPU_WAVE521CL_MAIN_0_SEC_M_VBUSM_W_ASYNC	0x45D27400
+#define SAM67_GPU_BXS464_WRAP_MAIN_0_M_VBUSM_W_SYNC	0x45D29800
+#define SAM67_GPU_BXS464_WRAP_MAIN_0_M_VBUSM_R_SYNC	0x45D2A000
+#define K3_DSS_UL_MAIN_0_VBUSM_DMA	0x45D30000
+#define K3_DSS_UL_MAIN_1_VBUSM_DMA	0x45D30400
+#define USB2SS_16FFC_MAIN_0_MSTR0	0x45D34000
+#define USB2SS_16FFC_MAIN_0_MSTW0	0x45D34400
+#define EMMC8SS_16FFC_MAIN_0_EMMCSS_WR	0x45D34800
+#define EMMC8SS_16FFC_MAIN_0_EMMCSS_RD	0x45D34C00
+#define USB2SS_16FFC_MAIN_1_MSTR0	0x45D35000
+#define USB2SS_16FFC_MAIN_1_MSTW0	0x45D35400
diff --git a/arch/arm/mach-k3/r5/am62px/am62p_qos_uboot.c b/arch/arm/mach-k3/r5/am62px/am62p_qos_uboot.c
new file mode 100644
index 0000000000..d25512a038
--- /dev/null
+++ b/arch/arm/mach-k3/r5/am62px/am62p_qos_uboot.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am62p Quality of Service (QoS) Configuration Data
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/arch/k3-qos.h>
+#include "am62p_qos.h"
+
+struct k3_qos_data qos_data[] = {
+	/* modules_qosConfig0 - 1 endpoints, 4 channels */
+	{
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_0_VBUSM_DMA, 0),
+		.val = K3_QOS_VAL(0, 15, 0, 0, 0, 0),
+	},
+	{
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_0_VBUSM_DMA, 1),
+		.val = K3_QOS_VAL(0, 15, 0, 0, 0, 0),
+	},
+	{
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_0_VBUSM_DMA, 2),
+		.val = K3_QOS_VAL(0, 15, 0, 0, 0, 0),
+	},
+	{
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_0_VBUSM_DMA, 3),
+		.val = K3_QOS_VAL(0, 15, 0, 0, 0, 0),
+	},
+
+	/* modules_qosConfig1 - 1 endpoints, 4 channels */
+	{
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_1_VBUSM_DMA, 0),
+		.val = K3_QOS_VAL(0, 15, 0, 0, 0, 0),
+	},
+	{
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_1_VBUSM_DMA, 1),
+		.val = K3_QOS_VAL(0, 15, 0, 0, 0, 0),
+	},
+	{
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_1_VBUSM_DMA, 2),
+		.val = K3_QOS_VAL(0, 15, 0, 0, 0, 0),
+	},
+	{
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_1_VBUSM_DMA, 3),
+		.val = K3_QOS_VAL(0, 15, 0, 0, 0, 0),
+	},
+
+	/* Following registers set 1:1 mapping for orderID MAP1/MAP2
+	 * remap registers. orderID x is remapped to orderID x again
+	 * This is to ensure orderID from MAP register is unchanged
+	 */
+
+	/* K3_DSS_UL_MAIN_0_VBUSM_DMA - 0 groups */
+
+	/* K3_DSS_UL_MAIN_1_VBUSM_DMA - 0 groups */
+};
+
+u32 qos_count = ARRAY_SIZE(qos_data);
-- 
2.34.1

