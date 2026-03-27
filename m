Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6044110ED660
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B457783FD9;
	Fri, 27 Mar 2026 13:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wYGiBapN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0396283FA7; Fri, 27 Mar 2026 13:10:42 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 521C183FAF
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHqHj1YKHSLdNWFDoNOGlzEJ0w9H8am+G6joa/66Q37wF0aUT3SMocPBwOwAmBWQHr0MzHIoUT0CUzUt2MjvxJ8N1s3KvIquJ62rlEW5vRwHZtwr4zqChVmQpc/o+5xFAKFMSHy0ByGcJ4ZZHHOP3HPHaDJLJ8y+AB1/vQyuJNbJfPYNEp6I5curMO788ha93lUqvj02KjvPWYSeCUm+cTs0ghzs4/3QQpsVYv5uuc1FCjuAKm0Fq04wNwqKbpFWvL1FgLV9X8ay4InGhritUay1w5/O8NaH5z/oDbqrTI/2QgKqHsAmGXaLEsKVwmgmhv/FxlngSKUoMFH8mUHgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcS/fBEgQi6FIcyECMQHRH+MiaIcWCH5vqzN26jYxLk=;
 b=lOVh+v6CRyOjMz6hPoBfe+yedhkLO6UFyIM/0BEaR33C/N0OpQ0JhE4zSOO3XPQ2BKuBEHBykbPbuznO3kVX3/bYeqdMsieq+ktrJJ2AlBgC6hmhye1ZrPc7Rn/sTTaz7YOHsjSikJ0TJVzPMOjRMP/zs3nEUIhpoglWkTwJ8kNSSO4zdFEHZCgFOuvIfWGBSMxdto9jQj2GetOtrXd1zTkCExKNp0J/GqF+Z/2Nv0yx1pdC7Oq+MkPVwf4wq078p1GrfhMY/ljZUK0sNHe+MpqIYnq1poTm2GyNVbB32NZr03kBBlrcU2TwGsX0YyvTO9gX7kNdYkepReWv6StA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcS/fBEgQi6FIcyECMQHRH+MiaIcWCH5vqzN26jYxLk=;
 b=wYGiBapNslg+x5kXwd6dt48srvqDwScG5zE1b/XstYsZsd61O0MVfwtBqu0is2LL9S0S/zA6+511LEhpCczAjz0BLE/nQupe5++G39n35XBtfAyAFCNmjbtSa/l50I3p0UxGHU/aSD5PnZZUwvv/G6ZTtfY0iwam+2bxQz/9Fqs=
Received: from PH2PEPF00003847.namprd17.prod.outlook.com (2603:10b6:518:1::64)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 12:10:30 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH2PEPF00003847.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 12:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:10:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 07:10:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 05:10:25 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 07:10:24 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 1/3] pci: Add AMD Versal2 DW PCIe host controller driver
Date: Fri, 27 Mar 2026 17:40:13 +0530
Message-ID: <20260327121015.996806-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327121015.996806-1-pranav.sanwal@amd.com>
References: <20260327121015.996806-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: cf10cecd-3fc8-4d30-ffed-08de8bf9d6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: QORnMj7SpVy+9+ksyNpriOxvhb1o1YPtgdYoGH5tILCXro9EKsVBvk4AzWY50nOC83L6aOyULwX3VO1DifpLSd4WRFHm+Hgeb513CpSv/wwEvDMZ9uUWErj7k4U0+SvLHyZUcQUYJJjjFAsavELy6+UvgvwfsuD1s4CYqkrmkBOHr27hU6jhY26R7VdSBRAsFSiz5GrxlocvBFvoKzQSqkXeJ3U4Cbh+KroEuqDx7iIXoBqwLykU12QZxWHCni/PPx4Zo9cUyG2qLpQaC/fThRB/N1vSagzlcrp8QRkgAa4CKMQphIaFRmcqnlcAtEuCvLypSsjdIzv4G+4nPCfTZKBtEyKX+jhAuS2A/WKILHxLwa5LH9HbBTdSZjISUHDhIhxe8ibYdWuGPda1It8SGrL4RbummdO/2r4BfFM/R8aE2PEPpeAZ1VfzJnqhfJekrZWb5KLH3NVqnlNH6WqB9k5qRwf8Rw4sRZvK4OGVBGI+5IaTKspzwOtCJnVVbYovpS6a2YeeHKaImW9KBhBAvl4i4/DP2pg1RRz2ObLINVCYWmICxyEKOAfGdzg5EVbaeEOejlog6uDR5EdhSBymfmPG74sBx84rnWFqOGl5g7OV77D9PrlErKGvsCMROid4wrd4AOCjX9AG/PX0ZcAunmBTJYAH8BZGTzJuhraJL8+tw+cFnZ2nNTYWrTPcWDwHdlz2ufjXEg9qDe9qrqblWIn4jncAGvUrxWVxo1nGkmc9RY9qkiC+FIhu4ApCD7guDV6/wsaOii33YBdWXibPzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g2dsR1n2m9PzvpStFwdLXrwRfEO3o+bigIlkaDnKDXkE/m6bRdHdz6AfjJcF3DtRX+R29HiTKxz3o4Af/nG6ne6xRG/Q0VHzub4K3ZtaOw1jwOY45v70iBgN35KkLs2joPNony7PlZGK9zFX3Jmpp+4VM8bfHMj7vXWK7UFsbT7kS85zym8WMZDtoLEWle+Vjc0CuIYkMtjNP8i3w/Gje1K9IYtErQNBvRAXPM2lPAsV23NEmPaCx4o4aDHz4MvgK6CuKSfCn+pW5M6YlbCVE4XWZCaltmVGVhGhsIK1hLvOlwCsHFqUhInx+6TOo24fMqtnYzt5KMFS01/yLG1sm6M7sICFg2jWwnoukc9OajsVYXQGY9HsR6FDEQrlPxXOm5Oshzf0K+s+PrrMITh7taj78hcWvDzuceZXt9TmAYtHcyWCBxqeJElryCIFbt8M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:10:29.8843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf10cecd-3fc8-4d30-ffed-08de8bf9d6c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794
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

Add support for the DesignWare-based PCIe host controller found in
AMD Versal2 SoCs. This enables PCIe functionality (e.g. NVMe storage)
on boards such as the VEK385.

The driver builds on the existing pcie_dw_common infrastructure and
adds Versal2-specific handling: it maps the SLCR register region to
mask and clear TLP interrupt status bits, parses dbi/config/atu/slcr
register regions from device tree, and supports an optional PERST#
GPIO on child nodes for endpoint reset sequencing. The outbound iATU
is programmed for the non-prefetchable memory window from device tree
ranges.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 MAINTAINERS               |   5 +
 drivers/pci/Kconfig       |  11 ++
 drivers/pci/Makefile      |   1 +
 drivers/pci/pcie_dw_amd.c | 250 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 267 insertions(+)
 create mode 100644 drivers/pci/pcie_dw_amd.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d168349ae6..a51586d5759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -65,6 +65,11 @@ F:	include/alist.h
 F:	lib/alist.c
 F:	test/lib/alist.c
 
+AMD VERSAL2 PCIE DRIVER
+M:	Pranav Sanwal <pranav.sanwal@amd.com>
+S:	Maintained
+F:	drivers/pci/pcie_dw_amd.c
+
 ANDROID AB
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 R:	Igor Opaniuk <igor.opaniuk@gmail.com>
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 8fc57895a78..39df0e776df 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -456,6 +456,17 @@ config PCIE_STARFIVE_JH7110
 	  Say Y here if you want to enable PLDA XpressRich PCIe controller
 	  support on StarFive JH7110 SoC.
 
+config PCIE_DW_AMD
+	bool "AMD Versal2 DW PCIe host controller"
+	depends on ARCH_VERSAL2
+	depends on DM_GPIO
+	select PCIE_DW_COMMON
+	select SYS_PCI_64BIT
+	help
+	  Say Y here to enable support for the AMD Versal Gen 2 PCIe
+	  host controller. This is a DesignWare-based PCIe controller
+	  used in AMD Versal Gen 2 SoCs.
+
 config PCIE_DW_IMX
 	bool "i.MX DW PCIe controller support"
 	depends on ARCH_IMX8M || ARCH_IMX9
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 98f3c226f63..e6d71fd172b 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -56,4 +56,5 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie_uniphier.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
 obj-$(CONFIG_PCIE_PLDA_COMMON) += pcie_plda_common.o
 obj-$(CONFIG_PCIE_STARFIVE_JH7110) += pcie_starfive_jh7110.o
+obj-$(CONFIG_PCIE_DW_AMD) += pcie_dw_amd.o
 obj-$(CONFIG_PCIE_DW_IMX) += pcie_dw_imx.o
diff --git a/drivers/pci/pcie_dw_amd.c b/drivers/pci/pcie_dw_amd.c
new file mode 100644
index 00000000000..c5a30cd324a
--- /dev/null
+++ b/drivers/pci/pcie_dw_amd.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal2 DesignWare PCIe host controller driver
+ *
+ * Copyright (C) 2025-2026 Advanced Micro Devices, Inc.
+ * Author: Pranav Sanwal <pranav.sanwal@amd.com>
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <pci.h>
+#include <wait_bit.h>
+
+#include <asm/gpio.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <linux/delay.h>
+
+#include "pcie_dw_common.h"
+
+/*
+ * SLCR (System Level Control Register) Interrupt Register Offsets
+ * These are relative to the SLCR base address from device tree
+ */
+#define AMD_DW_TLP_IR_STATUS_MISC	0x4c0
+#define AMD_DW_TLP_IR_DISABLE_MISC	0x4cc
+
+/* Interrupt bit definitions */
+#define AMD_DW_PCIE_INTR_CMPL_TIMEOUT		15
+#define AMD_DW_PCIE_INTR_PM_PME_RCVD		24
+#define AMD_DW_PCIE_INTR_PME_TO_ACK_RCVD	25
+#define AMD_DW_PCIE_INTR_MISC_CORRECTABLE	26
+#define AMD_DW_PCIE_INTR_NONFATAL		27
+#define AMD_DW_PCIE_INTR_FATAL			28
+
+#define AMD_DW_PCIE_INTR_INTX_MASK		GENMASK(23, 16)
+
+#define AMD_DW_PCIE_IMR_ALL_MASK	\
+	(BIT(AMD_DW_PCIE_INTR_CMPL_TIMEOUT)	| \
+	 BIT(AMD_DW_PCIE_INTR_PM_PME_RCVD)	| \
+	 BIT(AMD_DW_PCIE_INTR_PME_TO_ACK_RCVD)	| \
+	 BIT(AMD_DW_PCIE_INTR_MISC_CORRECTABLE)	| \
+	 BIT(AMD_DW_PCIE_INTR_NONFATAL)		| \
+	 BIT(AMD_DW_PCIE_INTR_FATAL)		| \
+	 AMD_DW_PCIE_INTR_INTX_MASK)
+
+/* DW PCIe Debug Registers (in DBI space) */
+#define AMD_DW_PCIE_PORT_DEBUG1			0x72c
+#define AMD_DW_PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
+#define AMD_DW_PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
+#define AMD_DW_PCIE_DBI_64BIT_MEM_DECODE		BIT(0)
+
+/* Link training timeout */
+#define LINK_WAIT_MSLEEP_MAX		1000
+
+/* PCIe spec timing requirements */
+#define PCIE_RESET_CONFIG_WAIT_MS	100
+#define PCIE_T_PERST_WAIT_MS		1
+
+/**
+ * struct amd_dw_pcie - AMD DesignWare PCIe controller private data
+ * @dw: DesignWare PCIe common structure
+ * @slcr_base: System Level Control Register base (for interrupts)
+ */
+struct amd_dw_pcie {
+	struct pcie_dw dw;
+	void __iomem *slcr_base;
+};
+
+static void amd_dw_pcie_init_port(struct amd_dw_pcie *pcie)
+{
+	u32 val;
+
+	if (!pcie->slcr_base)
+		return;
+
+	/* Disable all TLP interrupts */
+	writel(AMD_DW_PCIE_IMR_ALL_MASK,
+	       pcie->slcr_base + AMD_DW_TLP_IR_DISABLE_MISC);
+
+	/* Clear any pending TLP interrupts */
+	val = readl(pcie->slcr_base + AMD_DW_TLP_IR_STATUS_MISC);
+	val &= AMD_DW_PCIE_IMR_ALL_MASK;
+	writel(val, pcie->slcr_base + AMD_DW_TLP_IR_STATUS_MISC);
+}
+
+static void amd_dw_pcie_start_link(struct amd_dw_pcie *pcie)
+{
+	void __iomem *reg = pcie->dw.dbi_base + AMD_DW_PCIE_PORT_DEBUG1;
+	struct udevice *dev = pcie->dw.dev;
+	struct pcie_dw *pci = &pcie->dw;
+	int ret;
+
+	ret = wait_for_bit_le32(reg, AMD_DW_PCIE_PORT_DEBUG1_LINK_UP,
+				true, LINK_WAIT_MSLEEP_MAX,
+				false);
+	if (!ret)
+		ret = wait_for_bit_le32(reg,
+					AMD_DW_PCIE_PORT_DEBUG1_LINK_IN_TRAINING,
+					false, LINK_WAIT_MSLEEP_MAX, false);
+	if (ret)
+		dev_warn(dev, "PCIE-%d: Link down\n", dev_seq(dev));
+	else
+		dev_dbg(dev, "PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n",
+			dev_seq(dev), pcie_dw_get_link_speed(pci),
+			pcie_dw_get_link_width(pci), pci->first_busno);
+}
+
+static void amd_dw_pcie_host_init(struct amd_dw_pcie *pcie)
+{
+	struct pcie_dw *pci = &pcie->dw;
+
+	/*
+	 * Set 64-bit prefetchable memory decode capability. U-Boot's pci_auto.c
+	 * reads this bit before assigning prefetchable BARs. If cleared, it skips
+	 * PCI_PREF_BASE_UPPER32 programming, causing 64-bit BAR assignment to fail.
+	 */
+	dw_pcie_dbi_write_enable(pci, true);
+	setbits_le32(pci->dbi_base + PCI_PREF_MEMORY_BASE,
+		     AMD_DW_PCIE_DBI_64BIT_MEM_DECODE);
+	dw_pcie_dbi_write_enable(pci, false);
+
+	amd_dw_pcie_init_port(pcie);
+	pcie_dw_setup_host(pci);
+}
+
+static void amd_dw_pcie_request_gpio(struct udevice *dev)
+{
+	struct gpio_desc perst_gpio;
+	ofnode child_node;
+	int ret;
+
+	/*
+	 * PERST# reset GPIO is optional. Child PCI endpoint nodes may carry a
+	 * 'reset-gpios' property to toggle the endpoint reset signal during
+	 * initialization. If absent, the endpoint is assumed to be already
+	 * released from reset.
+	 */
+	ofnode_for_each_subnode(child_node, dev_ofnode(dev)) {
+		ret = gpio_request_by_name_nodev(child_node, "reset-gpios", 0,
+						 &perst_gpio, GPIOD_IS_OUT);
+		if (!ret) {
+			dev_dbg(dev, "Found reset-gpios in child node %s\n",
+				ofnode_get_name(child_node));
+			dm_gpio_set_value(&perst_gpio, 1);
+			mdelay(PCIE_T_PERST_WAIT_MS);
+			dm_gpio_set_value(&perst_gpio, 0);
+			mdelay(PCIE_RESET_CONFIG_WAIT_MS);
+			dm_gpio_free(dev, &perst_gpio);
+		}
+	}
+}
+
+static int amd_dw_pcie_of_to_plat(struct udevice *dev)
+{
+	struct pci_region *io_region, *mem_region, *pref_region;
+	struct amd_dw_pcie *pcie = dev_get_priv(dev);
+	struct pcie_dw *pci = &pcie->dw;
+	int ret;
+
+	pci->dev = dev;
+
+	pci->dbi_base = dev_read_addr_name_ptr(dev, "dbi");
+	if (!pci->dbi_base) {
+		dev_err(dev, "Missing 'dbi' register region\n");
+		return -EINVAL;
+	}
+
+	pci->cfg_base = dev_read_addr_size_name_ptr(dev, "config", &pci->cfg_size);
+	if (!pci->cfg_base) {
+		dev_err(dev, "Missing 'config' register region\n");
+		return -EINVAL;
+	}
+
+	pci->atu_base = dev_read_addr_name_ptr(dev, "atu");
+	if (!pci->atu_base) {
+		dev_dbg(dev, "No 'atu' region, using default offset from DBI\n");
+		pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+	}
+
+	pcie->slcr_base = dev_read_addr_name_ptr(dev, "slcr");
+	if (!pcie->slcr_base)
+		dev_dbg(dev, "No 'slcr' region, interrupt features disabled\n");
+
+	ret = pci_get_regions(dev, &io_region, &mem_region, &pref_region);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get PCI regions: %d\n", ret);
+		return ret;
+	}
+
+	if (mem_region)
+		pci->mem = *mem_region;
+
+	return 0;
+}
+
+static int amd_dw_pcie_probe(struct udevice *dev)
+{
+	struct amd_dw_pcie *pcie = dev_get_priv(dev);
+	struct pcie_dw *pci = &pcie->dw;
+
+	/* Set first bus number */
+	pci->first_busno = dev_seq(dev);
+
+	amd_dw_pcie_request_gpio(dev);
+	amd_dw_pcie_host_init(pcie);
+	amd_dw_pcie_start_link(pcie);
+
+	if (pci->mem.size) {
+		dev_dbg(dev, "Programming ATU region 0 for MEM: phys=0x%llx bus=0x%llx size=0x%llx\n",
+			(unsigned long long)pci->mem.phys_start,
+			(unsigned long long)pci->mem.bus_start,
+			(unsigned long long)pci->mem.size);
+		pcie_dw_prog_outbound_atu_unroll(pci,
+						 PCIE_ATU_REGION_INDEX0,
+						 PCIE_ATU_TYPE_MEM,
+						 pci->mem.phys_start,
+						 pci->mem.bus_start,
+						 pci->mem.size);
+	} else {
+		dev_warn(dev, "No MEM region configured!\n");
+	}
+
+	dev_dbg(dev, "dbi: 0x%lx | config: 0x%lx | atu: 0x%lx | slcr: 0x%lx\n",
+		(long)pci->dbi_base, (long)pci->cfg_base,
+		(long)pci->atu_base, (long)pcie->slcr_base);
+
+	return 0;
+}
+
+static const struct dm_pci_ops amd_dw_pcie_ops = {
+	.read_config	= pcie_dw_read_config,
+	.write_config	= pcie_dw_write_config,
+};
+
+static const struct udevice_id amd_dw_pcie_ids[] = {
+	{ .compatible = "amd,versal2-mdb-host" },
+	{ }
+};
+
+U_BOOT_DRIVER(pcie_dw_amd) = {
+	.name		= "pcie_dw_amd",
+	.id		= UCLASS_PCI,
+	.of_match	= amd_dw_pcie_ids,
+	.ops		= &amd_dw_pcie_ops,
+	.of_to_plat	= amd_dw_pcie_of_to_plat,
+	.probe		= amd_dw_pcie_probe,
+	.priv_auto	= sizeof(struct amd_dw_pcie),
+};
-- 
2.34.1

