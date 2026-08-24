Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0BBC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6343A60629;
	Mon, 24 Aug 2026 07:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MKRjT5UmMGJB; Mon, 24 Aug 2026 07:24:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787556254;
	bh=a80eX9Ll+syPmTijlGYAUrIIn+p8X2WAo6kzyfjl3Lo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0GdmzW+AGl2Y7EgTR1iXex6m6Xa7/ZyMGhKLIT9cTnKZ/6f8Dm56kmHiqQOU5P4eD
	 OxbYka0cw0IBy5s0NOF4/MS3ng51fRd04B2EzPstnJgrpnuBrs2kXOxpuuHODaaGrr
	 e7u+VMLQvC4NVpT/r/YfACt3hPg8/wprvfBXdgTHYyZhB/SXYurv0zrm4m+CJwTvgf
	 6tpNMfWSj1DAYMhntHeVzHztPan1ZAQTICirAnRELV9lCskbws9m7rWWUhUhEkHFEo
	 7nEgnnyWtvEN0hxSKMCa67G7ZW4IONZsA5Ss31UW86HW6wpRM6nXEzUoG0sMOlZq0b
	 KB2buMgH69Q/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 469A960631;
	Mon, 24 Aug 2026 07:24:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A45E4396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9636160631
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9VayyrDAYto7 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:24:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::9;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1JZE5oku
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7259760629
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwlt+GjiDmJP1ioXDTcDR/kZPp9C1DGIcSkOFZNQuJx9h02RWppvZrgPM5ST7f0boaMIirgYQKvOQ+Qfze0sACESiInWWOUFsrALjfh4/JC1zVWcMy4OYL8OuaJ7W64g3zxmGv4hJlqSzRO5//vog3OzACjTDyXBCqiRyFyRs+zFG8pu4HS79bEBGldcMRIpyh+hAP0R8lUIlum+O5g3fx68BOs7klseacEfntewNSTcLJ7FWr0vR+SkqLUa6xofOrLAcvxW115UU96frx2V0TMI7xMJiB4fg3Xwj3kD1fcHspE51yIdSvfgXGj6Ex0OPSvFBVkxybeNcTdpkFWVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a80eX9Ll+syPmTijlGYAUrIIn+p8X2WAo6kzyfjl3Lo=;
 b=OC8/Xo1R9GHX+FVqXt9UshHAkOvsBNI75X2tSWc9DhkIZiMMDvK34xDcuxywjFz63YJfI7Xm4Pv5jye5HNEOOHgqJJ6owIRBtyUZLbqiIR0HH1WjRRrNCm5byEfb7UYubML5KKnuADF4Wbte5gDObn10DVsNIDWmRVhNzthb3FqbyovgS32tymdrpVmF1g5e924CuAdC8a8KEoznpTS9XPGQcVV4g9pMb5YQNCbRDfjztU5pCHol8XY985isL6tKWR05F3ZtP8Njb72azPRgJf5QFJCclrd54e1nby3GEsXUArio3j9qgShdcEjPfL8ytKeo46/lg2WtunVfZnOEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a80eX9Ll+syPmTijlGYAUrIIn+p8X2WAo6kzyfjl3Lo=;
 b=1JZE5okuu2Ka0AlVS8+YOUcxAMU8y9f6tPDBXPCPYgjCH+lmVG5WTsPTuGo8WPnqJCy6xRq0LCiOoYNdhQX5ZdN+SIOBsknkrB2ubwDeAzGuCWtH+LTQYdq6aJpuCWMESEiH3jE/Iju6xa8srPUXwL2s3RibDFvzQKZc5chFpNg=
Received: from DS1P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::6) by
 DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 07:24:04 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::28) by DS1P222CA0004.outlook.office365.com
 (2603:10b6:8:454::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:24:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:24:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:24:01 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:23:57 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Uday Hegde <udayh@amd.com>, "Tom
 Rini" <trini@konsulko.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Padmarao Begari <padmarao.begari@amd.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Jerome Forissier
 <jerome@forissier.org>, Linus Walleij <linusw@kernel.org>, Weijie Gao
 <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>, Ye Li <ye.li@nxp.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 3/5] pci: Add support for CPM4 and CPM5 PCIe controllers
Date: Mon, 24 Aug 2026 12:51:47 +0530
Message-ID: <529f1b16b05ee843cb89045798631cae6361db6b.1787554549.git.pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787554549.git.pranav.sanwal@amd.com>
References: <cover.1787554549.git.pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 58aef095-8758-4f86-1653-08df01b0ad04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: J/9hF8Rkz/gPRoUB0/xzk4LuPFFSJUyZdLRzPJHiitnA7xPZa1FO73OfqHctiA2KVmEUyEnVSUE28pc5+nkmLWXC7+hvOVi9V5/7emR+DPbr7yh1s0Iy7flPjy1ohTDI/9Pf81wPnG4Lzk9jW8HM9gnJu/A8DlhIrsdQ/1oGVLvlTYw1JTt+qKeLjO7x7hWJEZwKNDVpSIj8napEpJh2qtjTyOMqVfhTIKGDEKCg/x5/45gxFW55OsQcA6tsfwgAXNatPBF34AvT3DCbX+hBiDQsHNJnpxnMq5Km9q8g1Gy+EJ/RMVhCTMwYbzX2WNM/ukcpfGOdSNNH2Z+ASYkkKSvVa+g/f/uQivBXVN12VAzadPef0Y4ve9D7yaBF8XoQ3uc1r2QO9C289UBd4IHNyD8xsE0zXlL/lcJJNWPg5NZhMREhiwB014yald/+K+qAIxlV02f8nIT4AgW8AuUoMBBOR9gT1+l2ETFPeEzwG20EUyle9k6KV/HkMAlWhVUgtn10GW5NK/bUkO5YlgvRSPTckum8FDlAehlR0rNtTpGXLaJptsY2adNY2x4Z/clRtOWKHqCcvUIFCdyB/pvPFEQHzJoNfwroV5lp01IgmViHXYnxgFabxk84L6MyhJJbSZSsrfvapV1lkcJX+yMxSScgI/QdF/bEHhmMK6mzP0INwYyD4J1b57xaMJ9ZvCESaHT4S1PfA64qwzLARsCLQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dN0Xf5D/vBp1U5KZvmfLR8bhoVqF6xhhKA5mNvdn7mU21ATpIFkw6lhft4aiGz00ohib8vT4zJEBC6Aj+kZSXiARyTJAxiglZAN1qvx/PZFnaI6gYejT//grxjWSt1oEsZpFZW4COjb31PMnujJzWunzQZ5D6Ph1Kt1QhvejKKrPCoDvnUAtcMbnUpvrMZ+jSw8jitQTLI6m7JHmuUwDH4GM81jb9q6rCnIotT+Y1QnAQz/3+0essFtiopoFrD1A3MqJBsSODCWYlI1f4SIhZeKn4hGq9D7vy1iqIz9rRPU2QYr3QknvwlvXrhVt/JH3x7dHxfSVTqBGsptFgdXo39EmLNSCZyq4cRBB8uQ42Cxpqtzc6CwWEYtptWstA4yl+kmM7mGnvoa3OrJ8Fqpdf9YkY2pnJuRrrHeAj1OrMHB2t1rVXzvQzPJuTx9N7aFA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:24:03.7844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58aef095-8758-4f86-1653-08df01b0ad04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add a host controller driver for the AMD Versal CPM4 and CPM5 PCIe
bridges, selected via the DT compatible string and enabled with
CONFIG_PCIE_AMD_CPM. The driver maps the bridge/ECAM regions,
services ECAM-based config space accesses, masks off all local
interrupts, and brings up the root port bridge. CPM5 variants also
support an optional PERST#-driven IP reset sequence ahead of link
bring-up.

Co-developed-by: Uday Hegde <udayh@amd.com>
Signed-off-by: Uday Hegde <udayh@amd.com>
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 MAINTAINERS                |   5 +
 drivers/pci/Kconfig        |   9 +
 drivers/pci/Makefile       |   1 +
 drivers/pci/pcie_amd_cpm.c | 363 +++++++++++++++++++++++++++++++++++++
 4 files changed, 378 insertions(+)
 create mode 100644 drivers/pci/pcie_amd_cpm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f184a39a9d..0cc8670cfe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -71,6 +71,11 @@ F:	include/alist.h
 F:	lib/alist.c
 F:	test/lib/alist.c
 
+AMD CPM PCIE DRIVER
+M:	Pranav Sanwal <pranav.sanwal@amd.com>
+S:	Maintained
+F:	drivers/pci/pcie_amd_cpm.c
+
 AMD QDMA PL PCIE DRIVER
 M:	Pranav Sanwal <pranav.sanwal@amd.com>
 S:	Maintained
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index da2bebafe9a..64bab2b9dd6 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -444,6 +444,15 @@ config PCIE_XILINX_NWL
 	  Say 'Y' here if you want support for Xilinx / AMD NWL PCIe
 	  controller as Root Port.
 
+config PCIE_AMD_CPM
+	bool "AMD Versal CPM PCIe host bridge support"
+	depends on ARCH_VERSAL
+	depends on DM_GPIO
+	select SYS_PCI_64BIT
+	help
+	  Say 'Y' here if you want support for the AMD Versal
+	  CPM PCIe host bridge.
+
 config PCIE_AMD_QDMA_PL
 	bool "AMD QDMA PL PCIe host bridge support"
 	depends on ARCH_VERSAL
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index a6891154e9e..3873f357a45 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_PCIE_OCTEON) += pcie_octeon.o
 obj-$(CONFIG_PCIE_DW_SIFIVE) += pcie_dw_sifive.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie_uniphier.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
+obj-$(CONFIG_PCIE_AMD_CPM) += pcie_amd_cpm.o
 obj-$(CONFIG_PCIE_AMD_QDMA_PL) += pcie_amd_qdma_pl.o
 obj-$(CONFIG_PCIE_PLDA_COMMON) += pcie_plda_common.o
 obj-$(CONFIG_PCIE_STARFIVE_JH7110) += pcie_starfive_jh7110.o
diff --git a/drivers/pci/pcie_amd_cpm.c b/drivers/pci/pcie_amd_cpm.c
new file mode 100644
index 00000000000..8377e772792
--- /dev/null
+++ b/drivers/pci/pcie_amd_cpm.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCIe host controller driver for AMD CPM
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#define LOG_CATEGORY UCLASS_PCI
+
+#include <dm.h>
+#include <pci.h>
+
+#include <asm/gpio.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+
+/*
+ * End of conventional reset (PERST# de-asserted) to first configuration
+ * request (device able to respond with a "Request Retry Status" completion),
+ * from PCIe r6.0, sec 6.6.1.
+ */
+#define PCIE_T_RRS_READY_MS	100
+
+/*
+ * "PERST# active time", as per Table 2-10: Power Sequencing and Reset
+ * Signal Timings of the PCIe Electromechanical Specification,
+ * Revision 6.0, symbol "T_PERST".
+ */
+#define PCIE_T_PERST_US		100
+
+/* Register definitions */
+#define AMD_CPM_PCIE0_RST		0x00000308
+#define AMD_CPM5_PCIE0_RST		0x00000318
+#define AMD_CPM5_PCIE1_RST		0x0000031C
+
+#define AMD_CPM_PCIE_REG_IDR		0x00000E10
+#define AMD_CPM_PCIE_REG_IMR		0x00000E14
+#define AMD_CPM_PCIE_REG_PSCR		0x00000E1C
+#define AMD_CPM_PCIE_REG_RPSC		0x00000E20
+
+/* Interrupt registers definitions */
+#define AMD_CPM_INTR_LINK_DOWN		0
+#define AMD_CPM_INTR_HOT_RESET		3
+#define AMD_CPM_INTR_CFG_PCIE_TIMEOUT	4
+#define AMD_CPM_INTR_CFG_TIMEOUT	8
+#define AMD_CPM_INTR_CORRECTABLE	9
+#define AMD_CPM_INTR_NONFATAL		10
+#define AMD_CPM_INTR_FATAL		11
+#define AMD_CPM_INTR_CFG_ERR_POISON	12
+#define AMD_CPM_INTR_PME_TO_ACK_RCVD	15
+#define AMD_CPM_INTR_INTX		16
+#define AMD_CPM_INTR_PM_PME_RCVD	17
+#define AMD_CPM_INTR_MSI		17
+#define AMD_CPM_INTR_SLV_UNSUPP		20
+#define AMD_CPM_INTR_SLV_UNEXP		21
+#define AMD_CPM_INTR_SLV_COMPL		22
+#define AMD_CPM_INTR_SLV_ERRP		23
+#define AMD_CPM_INTR_SLV_CMPABT		24
+#define AMD_CPM_INTR_SLV_ILLBUR		25
+#define AMD_CPM_INTR_MST_DECERR		26
+#define AMD_CPM_INTR_MST_SLVERR		27
+#define AMD_CPM_INTR_SLV_PCIE_TIMEOUT	28
+
+#define IMR(x) BIT(AMD_CPM_INTR_ ##x)
+
+#define AMD_CPM_PCIE_IMR_ALL_MASK		\
+	(IMR(LINK_DOWN)		| \
+	 IMR(HOT_RESET)		| \
+	 IMR(CFG_PCIE_TIMEOUT)	| \
+	 IMR(CFG_TIMEOUT)	| \
+	 IMR(CORRECTABLE)	| \
+	 IMR(NONFATAL)		| \
+	 IMR(FATAL)		| \
+	 IMR(CFG_ERR_POISON)	| \
+	 IMR(PME_TO_ACK_RCVD)	| \
+	 IMR(INTX)		| \
+	 IMR(PM_PME_RCVD)	| \
+	 IMR(SLV_UNSUPP)	| \
+	 IMR(SLV_UNEXP)		| \
+	 IMR(SLV_COMPL)		| \
+	 IMR(SLV_ERRP)		| \
+	 IMR(SLV_CMPABT)	| \
+	 IMR(SLV_ILLBUR)	| \
+	 IMR(MST_DECERR)	| \
+	 IMR(MST_SLVERR)	| \
+	 IMR(SLV_PCIE_TIMEOUT))
+
+#define AMD_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
+
+#define AMD_CPM_PCIE_REG_RPSC_BEN		BIT(0)
+
+#define AMD_CPM_PCIE_REG_PSCR_LNKUP		BIT(11)
+
+enum amd_cpm_version {
+	AMD_CPM_VER_1,
+	AMD_CPM_VER_5_HOST0,
+	AMD_CPM_VER_5_HOST1,
+};
+
+/**
+ * struct amd_cpm_variant - CPM variant information
+ * @version: CPM version
+ * @cpm_pcie_rst: Offset for the PCIe IP reset
+ */
+struct amd_cpm_variant {
+	enum amd_cpm_version version;
+	u32 cpm_pcie_rst;
+};
+
+/**
+ * struct amd_cpm_pcie - AMD CPM PCIe bridge private data
+ * @dev: PCIe host bridge device
+ * @reg_base: Bridge register base address
+ * @cfg_base: ECAM configuration space base address
+ * @crx_base: CPM5 reset control base address (optional)
+ * @variant: CPM version check pointer
+ */
+struct amd_cpm_pcie {
+	struct udevice *dev;
+	void __iomem *reg_base;
+	void __iomem *cfg_base;
+	void __iomem *crx_base;
+	const struct amd_cpm_variant *variant;
+};
+
+static inline u32 amd_cpm_pcie_read(struct amd_cpm_pcie *pcie, u32 reg)
+{
+	u32 val = readl(pcie->reg_base + reg);
+
+	dev_dbg(pcie->dev, "rd reg 0x%03x = 0x%08x\n", reg, val);
+
+	return val;
+}
+
+static inline void amd_cpm_pcie_write(struct amd_cpm_pcie *pcie,
+				      u32 val, u32 reg)
+{
+	dev_dbg(pcie->dev, "wr reg 0x%03x = 0x%08x\n", reg, val);
+	writel(val, pcie->reg_base + reg);
+}
+
+static bool amd_cpm_pcie_link_up(struct amd_cpm_pcie *pcie)
+{
+	return !!(amd_cpm_pcie_read(pcie, AMD_CPM_PCIE_REG_PSCR) &
+		  AMD_CPM_PCIE_REG_PSCR_LNKUP);
+}
+
+static int amd_cpm_pcie_config_address(const struct udevice *bus,
+				       pci_dev_t bdf, uint offset,
+				       void **paddress)
+{
+	struct amd_cpm_pcie *priv = dev_get_priv(bus);
+	u32 busnum = PCI_BUS(bdf) - dev_seq(bus);
+	void *addr;
+
+	addr = priv->cfg_base;
+	addr += PCIE_ECAM_OFFSET(busnum, PCI_DEV(bdf), PCI_FUNC(bdf), offset);
+	dev_dbg(priv->dev, "cfg bdf=%02x:%02x.%x offset=0x%x addr=%p\n",
+		PCI_BUS(bdf), PCI_DEV(bdf), PCI_FUNC(bdf), offset, addr);
+	*paddress = addr;
+
+	return 0;
+}
+
+/*
+ * The root port's own function (bus 0, device 0, function 0) reports a
+ * bogus 64-bit BAR0 that autoconfig can never place. Mask it off so it
+ * always reads back as not implemented.
+ */
+static bool amd_cpm_pcie_is_own_bar(const struct udevice *bus, pci_dev_t bdf,
+				    uint offset)
+{
+	u32 busnum = PCI_BUS(bdf) - dev_seq(bus);
+
+	return busnum == 0 && PCI_DEV(bdf) == 0 && PCI_FUNC(bdf) == 0 &&
+	       offset >= PCI_BASE_ADDRESS_0 && offset < PCI_BASE_ADDRESS_2;
+}
+
+static int amd_cpm_pcie_read_config(const struct udevice *bus,
+				    pci_dev_t bdf, uint offset,
+				    ulong *valuep, enum pci_size_t size)
+{
+	if (amd_cpm_pcie_is_own_bar(bus, bdf, offset)) {
+		*valuep = 0;
+		return 0;
+	}
+
+	return pci_generic_mmap_read_config(bus, amd_cpm_pcie_config_address,
+					    bdf, offset, valuep, size);
+}
+
+static int amd_cpm_pcie_write_config(struct udevice *bus, pci_dev_t bdf,
+				     uint offset, ulong value,
+				     enum pci_size_t size)
+{
+	if (amd_cpm_pcie_is_own_bar(bus, bdf, offset))
+		return 0;
+
+	return pci_generic_mmap_write_config(bus, amd_cpm_pcie_config_address,
+					     bdf, offset, value, size);
+}
+
+static const struct dm_pci_ops amd_cpm_pcie_ops = {
+	.read_config = amd_cpm_pcie_read_config,
+	.write_config = amd_cpm_pcie_write_config,
+};
+
+static int amd_cpm_pcie_host_init(struct amd_cpm_pcie *pcie)
+{
+	const struct amd_cpm_variant *variant = pcie->variant;
+	struct udevice *dev = pcie->dev;
+	struct gpio_desc *reset_gpio;
+	u32 val;
+
+	if (pcie->crx_base) {
+		reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_IS_OUT |
+						     GPIOD_IS_OUT_ACTIVE);
+		if (reset_gpio) {
+			/* Assert the PCIe IP reset */
+			writel(BIT(0), pcie->crx_base + variant->cpm_pcie_rst);
+
+			udelay(PCIE_T_PERST_US);
+
+			/* Deassert the PCIe IP reset */
+			writel(0, pcie->crx_base + variant->cpm_pcie_rst);
+
+			/* Deassert the reset signal */
+			dm_gpio_set_value(reset_gpio, 0);
+			mdelay(PCIE_T_RRS_READY_MS);
+		}
+	}
+
+	dev_dbg(dev, "PCIe link %s\n",
+		amd_cpm_pcie_link_up(pcie) ? "up" : "down");
+
+	/* Disable all interrupts */
+	amd_cpm_pcie_write(pcie, ~AMD_CPM_PCIE_IDR_ALL_MASK,
+			   AMD_CPM_PCIE_REG_IMR);
+
+	/* Clear pending interrupts */
+	val = amd_cpm_pcie_read(pcie, AMD_CPM_PCIE_REG_IDR);
+	amd_cpm_pcie_write(pcie, val & AMD_CPM_PCIE_IMR_ALL_MASK,
+			   AMD_CPM_PCIE_REG_IDR);
+
+	/* Enable root port bridge */
+	val = amd_cpm_pcie_read(pcie, AMD_CPM_PCIE_REG_RPSC);
+	amd_cpm_pcie_write(pcie, val | AMD_CPM_PCIE_REG_RPSC_BEN,
+			   AMD_CPM_PCIE_REG_RPSC);
+
+	return 0;
+}
+
+static int amd_cpm_pcie_map_res(struct udevice *dev, const char *name,
+				void __iomem **map)
+{
+	struct resource res;
+	int ret;
+
+	ret = dev_read_resource_byname(dev, name, &res);
+	if (ret)
+		return ret;
+
+	*map = devm_ioremap(dev, res.start, resource_size(&res));
+	if (!*map)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int amd_cpm_pcie_parse_dt(struct amd_cpm_pcie *pcie)
+{
+	struct udevice *dev = pcie->dev;
+	int ret;
+
+	ret = amd_cpm_pcie_map_res(dev, "cfg", &pcie->cfg_base);
+	if (ret)
+		return ret;
+
+	if (pcie->variant->version == AMD_CPM_VER_1) {
+		/*
+		 * On original CPM the ECAM and bridge registers share the same
+		 * region; cfg_base and reg_base both point into it.
+		 */
+		pcie->reg_base = pcie->cfg_base;
+	} else {
+		ret = amd_cpm_pcie_map_res(dev, "cpm_csr", &pcie->reg_base);
+		if (ret)
+			return ret;
+	}
+
+	/* cpm_crx is optional; absence means no PCIe IP reset sequence */
+	amd_cpm_pcie_map_res(dev, "cpm_crx", &pcie->crx_base);
+
+	return 0;
+}
+
+static int amd_cpm_pcie_probe(struct udevice *dev)
+{
+	struct amd_cpm_pcie *priv = dev_get_priv(dev);
+	int err;
+
+	priv->dev = dev;
+	priv->variant = (const struct amd_cpm_variant *)dev_get_driver_data(dev);
+	if (!priv->variant)
+		return -EINVAL;
+
+	err = amd_cpm_pcie_parse_dt(priv);
+	if (err) {
+		dev_err(dev, "failed to parse DT: %d\n", err);
+		return err;
+	}
+
+	err = amd_cpm_pcie_host_init(priv);
+	if (err) {
+		dev_err(dev, "failed to initialize host: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static const struct amd_cpm_variant cpm_host = {
+	.version = AMD_CPM_VER_1,
+	.cpm_pcie_rst = AMD_CPM_PCIE0_RST,
+};
+
+static const struct amd_cpm_variant cpm5_host = {
+	.version = AMD_CPM_VER_5_HOST0,
+	.cpm_pcie_rst = AMD_CPM5_PCIE0_RST,
+};
+
+static const struct amd_cpm_variant cpm5_host1 = {
+	.version = AMD_CPM_VER_5_HOST1,
+	.cpm_pcie_rst = AMD_CPM5_PCIE1_RST,
+};
+
+static const struct udevice_id amd_cpm_pcie_of_match[] = {
+	{
+		.compatible = "xlnx,versal-cpm-host-1.00",
+		.data = (ulong)&cpm_host,
+	},
+	{
+		.compatible = "xlnx,versal-cpm5-host",
+		.data = (ulong)&cpm5_host,
+	},
+	{
+		.compatible = "xlnx,versal-cpm5-host1",
+		.data = (ulong)&cpm5_host1,
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(amd_cpm_pcie) = {
+	.name = "amd_cpm_pcie",
+	.id = UCLASS_PCI,
+	.of_match = amd_cpm_pcie_of_match,
+	.probe = amd_cpm_pcie_probe,
+	.priv_auto = sizeof(struct amd_cpm_pcie),
+	.ops = &amd_cpm_pcie_ops,
+};
-- 
2.43.7

