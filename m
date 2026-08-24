Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE5CC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A30580E03;
	Mon, 24 Aug 2026 07:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7t4eet3zW13; Mon, 24 Aug 2026 07:23:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787556182;
	bh=Q8sKI/hODL3A39Cl0rna+fMJ1kbmVYATQRiuhbtpPTc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tg8gM3gD294JvpVsMIVsDW0lF/3SJ+Pi57RC1mIgK7VTunaqLNaKuyYhcMI+uyubq
	 ZI8+vUkRB/5qFg5Oe5y4+11Wo48vM2B3/yMjh2yqFNm+chByxQ+kN8zmc9YZj3FZyh
	 6z3NRVS2C7smKGz8sciYvraXISnckngYdaAnvyNK2+IitbhL6YgQdpSspUQXE5oTfm
	 Xs3D+228T31RbpWHUb5PlIw43CYnhubm7cDlpztdGBF9XofCAXlYDwmzSDVtMDoYt3
	 rIb1+naK8/yp3wU+HVYAVYNT7wq6IcvxTL7ft0EjZ0QpdMszc0nMHE0vcdYL3RVHdQ
	 w/19X9dh4AY5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08EE280DD2;
	Mon, 24 Aug 2026 07:23:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5BE2336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7BD380CBA
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:23:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NavhNbchkkyC for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:22:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4UWyFVJc
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9088580DD2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1C5nVbNLW9942cU/pTuUuoLwU7NVH1y9BzvhkDtd2soSX5FHc4H10qZmQZ1D6GMsonOsObOZjVIznZjoy2rVyg3ecCqJ7zjI10UsthKpcGyVkuYrTFuMf14eQNLU9sfKWSPVWFDglaCG59yY896Sel4pl3F84oGpMhj0N98NRu4xAFCSE2xwjgm95wjzHjQyNwt3k5V2pRv4KqEQsamTjcR9/QAygONzsVCFUESv7LBM7FVc6Ts2+2GRY9Dj9thZDIW1OOqg0oxB0i33lweGx3MGSVD8+hYLa6RP9ZX8vWlrxiqvMIv/g3ZbKDo7hdjDmKO3SH5kwxwzuS/z5tYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8sKI/hODL3A39Cl0rna+fMJ1kbmVYATQRiuhbtpPTc=;
 b=FNeYI5mWFg6MDlIBV/CM6widZ8XeG0q2DRrkKOv11Oc+6CAgfD7BkMxSIQOLwDDGQByxAVqWC1AIGB8Z1YitlP6eZhzy2dEbvmkTk27KA2OLr+RB4GAd9gWgeDIWrRsyeGOhVbPSNBbLQVYwm0fU2ihIl8C+2x4Iq+7WO5YHzsOhTitxMqBZ4WxrBg4CVdgKmpyhUJfbw3/Zw533E7FDMxll7XLH42GrwddJyyWht2FOGWHf++u7DsZlu2qrW4soI448NiOZPoRGJ06X+ekiqI0zPL2cVjxQIVwJKHJR8c2Ff0hEWP7AakI7v8vmC05p9mlnTmTIzP+3s3y+16i4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8sKI/hODL3A39Cl0rna+fMJ1kbmVYATQRiuhbtpPTc=;
 b=4UWyFVJciTc1lJCZgJUO/5vlaKv1biQEbTXKRQ4WatJEj2HqeBDiP8lJ4F87gjQwzUyHR4Gy7fxuZD9MynPOJKdJCSWJqVqiPAhAvqhxC3aevMerAi0IvknuxEh4Zm2q+bXMLOB7+dsFbFo0cIKdfmGgHcY5mkR7056BrO3JL4Q=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:22:53 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::12) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 07:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:22:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:22:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:22:51 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:22:47 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Uday Hegde <udayh@amd.com>, "Tom
 Rini" <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Jerome Forissier <jerome@forissier.org>, Weijie Gao
 <weijie.gao@mediatek.com>, Linus Walleij <linusw@kernel.org>, Yao Zi
 <me@ziyao.cc>, Sean Anderson <seanga2@gmail.com>, Ye Li <ye.li@nxp.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 2/5] pci: Add support for AMD QDMA PL PCIe root port
Date: Mon, 24 Aug 2026 12:51:46 +0530
Message-ID: <24e0671496322ea483c359d586107c00d7006ce6.1787554549.git.pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787554549.git.pranav.sanwal@amd.com>
References: <cover.1787554549.git.pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e666ad6-645a-4731-037c-08df01b082d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|30052699003|36860700016|82310400026|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 3OeKaGal+0GrasF/sFm3DFcHddRlpjWr8I2dv7fk09ZP62fG48FJRCgivay5udDyxWpUFGVZPhWYIkV7A1LYxe6M09DZ4gHGOEi9MOyU6BnjwardSK0uIp59I8EO3oBq9dBD5wqXFOdPpVQEGu7K2teuWAi9/VDdq+lGEqpSMr2Ys6D+S6CAmu0aqJFFBtmZcwM/kMVT2Pi7m1FiygosXk6TqgtZq7WBimmLj0Htlq1cWv335RQKIiCEw2B7UksrhDu5v6mU5+XTm0avJkmPwWQMcRyHFCDxIHDHwesp6FIApJlEmmDRlPTT5W1KcEOKWv5353hol25q2kndoOoDnceMgvw+XWIFoxZx3eNZNGqwo6IykuN+uwpr+YVzMhbjzntRoTgUZhCxM0JfeOAE307tGLD77kE2nU518CTVFNFuUO7I2DJ1mKA/k3um0glrZPmguI7JNBbOSW0XnqczDFvYgcJ4bYQVgswDYa9x4z+iYS5uvjDDTMdMY+r2dqueKhsDLs5aN/yzC6CSU8PzXc18BWXnAwnpUunDdgOAT7dD1icJusztBIODX2bKiuIAHRQ6UmahGVV/m3gSL9vVG8RH+arcl+0jbVa52oBBBRrD1L6LbtN9lA5YXNjCBp8FNd9EqIPchwEB3wfz+PXZJTmAcg9jmAa3DuKdO5oXnMyAeI+ghtQ7zfTKeQZ7yEZaX4oKH3W8Czo43dOg/fu3Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(30052699003)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KIdAGgq3I4FJfFNKUyCup7R9ojw7YW9Vo7CePZxlySfaa+jYCLD8oF/hCWhLsLH6+z4O6lhwMGYasv4CnGEAFZyMDFrnVg1vRPonvbBWJ3FX7aPFkDX7s7w3JlZ3ux7yPWgmSyU5MvoyL7foO+djtOk6H47G6+MnKQm3WSAMSru2uR4VBB6JJqzYGLR4h+w8hOkZefpIwEecSS6uoSYxYbzNov6aEGMQqMMHoK24R3PbAwoSJ7jV4aKiv9VXHWc2ifAor7N3W8KMbJBfgb54IhPZ1hM6Zx8WsFfHg3/zr4NaArvqPNrOER4x3kwwHIPA7hspLCQ6Zj0qCjHOShoNtF780VZNzBpUvJNZ0Y2lOcQUyasbP0dkGJp5UQrvWE2e+WvV76Dd9DzJDQHjj2cu2UQmlaVP0gn6pfwg1oM6qIYSy+lIGZIfVcsUd1YU9Xs6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:22:52.9171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e666ad6-645a-4731-037c-08df01b082d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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

Add PCIe host bridge driver for AMD QDMA PL (Programmable Logic) soft
IP PCIe5 controller. This driver enables PCIe root port functionality
for QDMA IP instantiated in the PL fabric.

Co-developed-by: Uday Hegde <udayh@amd.com>
Signed-off-by: Uday Hegde <udayh@amd.com>
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 MAINTAINERS                    |   5 +
 drivers/pci/Kconfig            |  10 ++
 drivers/pci/Makefile           |   1 +
 drivers/pci/pcie_amd_qdma_pl.c | 205 +++++++++++++++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 drivers/pci/pcie_amd_qdma_pl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eb48eea55c5..4f184a39a9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -71,6 +71,11 @@ F:	include/alist.h
 F:	lib/alist.c
 F:	test/lib/alist.c
 
+AMD QDMA PL PCIE DRIVER
+M:	Pranav Sanwal <pranav.sanwal@amd.com>
+S:	Maintained
+F:	drivers/pci/pcie_amd_qdma_pl.c
+
 AMD VERSAL2 PCIE DRIVER
 M:	Pranav Sanwal <pranav.sanwal@amd.com>
 S:	Maintained
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2b2ccdf4745..da2bebafe9a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -444,6 +444,16 @@ config PCIE_XILINX_NWL
 	  Say 'Y' here if you want support for Xilinx / AMD NWL PCIe
 	  controller as Root Port.
 
+config PCIE_AMD_QDMA_PL
+	bool "AMD QDMA PL PCIe host bridge support"
+	depends on ARCH_VERSAL
+	select SYS_PCI_64BIT
+	help
+	  Say 'Y' here if you want support for the Xilinx/AMD QDMA
+	  PL PCIe host bridge. The controller is a Soft IP instantiated
+	  in the PL fabric which can act as a PCIe Root Port. It provides
+	  ECAM-based configuration space access for device enumeration.
+
 config PCIE_PLDA_COMMON
 	bool
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index e6d71fd172b..a6891154e9e 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_PCIE_OCTEON) += pcie_octeon.o
 obj-$(CONFIG_PCIE_DW_SIFIVE) += pcie_dw_sifive.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie_uniphier.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
+obj-$(CONFIG_PCIE_AMD_QDMA_PL) += pcie_amd_qdma_pl.o
 obj-$(CONFIG_PCIE_PLDA_COMMON) += pcie_plda_common.o
 obj-$(CONFIG_PCIE_STARFIVE_JH7110) += pcie_starfive_jh7110.o
 obj-$(CONFIG_PCIE_DW_AMD) += pcie_dw_amd.o
diff --git a/drivers/pci/pcie_amd_qdma_pl.c b/drivers/pci/pcie_amd_qdma_pl.c
new file mode 100644
index 00000000000..2143b0a1a27
--- /dev/null
+++ b/drivers/pci/pcie_amd_qdma_pl.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe host bridge driver for AMD QDMA PL PCIe bridge (no XDMA support)
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#define LOG_CATEGORY UCLASS_PCI
+
+#include <dm.h>
+#include <pci.h>
+
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+
+/* Register definitions */
+#define AMD_QDMA_REG_IDR			0x138
+#define AMD_QDMA_REG_IMR			0x13c
+#define AMD_QDMA_REG_PSCR			0x144
+#define AMD_QDMA_REG_RPSC			0x148
+
+#define AMD_QDMA_IMR_ALL_MASK		0x0ff30fe9
+#define AMD_QDMA_IDR_ALL_MASK		0xffffffff
+
+/* Root Port Status/control Register definitions */
+#define AMD_QDMA_REG_RPSC_BEN		BIT(0)
+
+/* Phy Status/Control Register definitions */
+#define AMD_QDMA_REG_PSCR_LNKUP		BIT(11)
+#define QDMA_BRIDGE_BASE_OFF			0xcd8
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES			10
+#define LINK_WAIT_DELAY_US			90000
+
+/**
+ * struct amd_qdma_pcie - AMD QDMA PL PCIe bridge private data
+ * @dev: PCIe host bridge device
+ * @breg_base: Bridge register base address
+ * @ecam_base: ECAM configuration space base address
+ */
+struct amd_qdma_pcie {
+	struct udevice *dev;
+	void __iomem *breg_base;
+	void __iomem *ecam_base;
+};
+
+static inline u32 amd_qdma_pcie_read(struct amd_qdma_pcie *pcie, u32 reg)
+{
+	u32 val = readl(pcie->breg_base + reg + QDMA_BRIDGE_BASE_OFF);
+
+	dev_dbg(pcie->dev, "rd reg 0x%03x = 0x%08x\n", reg, val);
+
+	return val;
+}
+
+static inline void amd_qdma_pcie_write(struct amd_qdma_pcie *pcie, u32 val,
+				       u32 reg)
+{
+	dev_dbg(pcie->dev, "wr reg 0x%03x = 0x%08x\n", reg, val);
+	writel(val, pcie->breg_base + reg + QDMA_BRIDGE_BASE_OFF);
+}
+
+static bool amd_qdma_pcie_link_up(struct amd_qdma_pcie *pcie)
+{
+	return !!(amd_qdma_pcie_read(pcie, AMD_QDMA_REG_PSCR) &
+		  AMD_QDMA_REG_PSCR_LNKUP);
+}
+
+static int amd_qdma_pcie_config_address(const struct udevice *bus,
+					pci_dev_t bdf, uint offset,
+					void **paddress)
+{
+	struct amd_qdma_pcie *priv = dev_get_priv(bus);
+	u32 busnum = PCI_BUS(bdf) - dev_seq(bus);
+	void *addr;
+
+	if (busnum == 0) {
+		if (PCI_DEV(bdf) > 0 || PCI_FUNC(bdf) > 0)
+			return -ENODEV;
+	} else {
+		if (!amd_qdma_pcie_link_up(priv))
+			return -ENODEV;
+	}
+
+	addr = priv->ecam_base;
+	addr += PCIE_ECAM_OFFSET(busnum, PCI_DEV(bdf), PCI_FUNC(bdf), offset);
+	*paddress = addr;
+
+	return 0;
+}
+
+static int amd_qdma_pcie_read_config(const struct udevice *bus,
+				     pci_dev_t bdf, uint offset,
+				     ulong *valuep, enum pci_size_t size)
+{
+	return pci_generic_mmap_read_config(bus, amd_qdma_pcie_config_address,
+					     bdf, offset, valuep, size);
+}
+
+static int amd_qdma_pcie_write_config(struct udevice *bus, pci_dev_t bdf,
+				      uint offset, ulong value,
+				      enum pci_size_t size)
+{
+	/*
+	 * The QDMA PL bridge's config space only decodes 32-bit accesses;
+	 * narrower writes must be promoted to a 32-bit read-modify-write.
+	 */
+	return pci_generic_mmap_write_config32(bus, amd_qdma_pcie_config_address,
+						bdf, offset, value, size);
+}
+
+static const struct dm_pci_ops amd_qdma_pcie_ops = {
+	.read_config = amd_qdma_pcie_read_config,
+	.write_config = amd_qdma_pcie_write_config,
+};
+
+static int amd_qdma_pcie_bridge_init(struct amd_qdma_pcie *pcie)
+{
+	int retries;
+	u32 val;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (amd_qdma_pcie_link_up(pcie))
+			break;
+		udelay(LINK_WAIT_DELAY_US);
+	}
+
+	if (retries >= LINK_WAIT_MAX_RETRIES) {
+		dev_warn(pcie->dev, "PHY link never came up\n");
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(pcie->dev, "PCIe Link is UP\n");
+
+	/* Disable all interrupts */
+	amd_qdma_pcie_write(pcie, ~AMD_QDMA_IDR_ALL_MASK, AMD_QDMA_REG_IMR);
+
+	/* Clear pending interrupts */
+	val = amd_qdma_pcie_read(pcie, AMD_QDMA_REG_IDR) & AMD_QDMA_IMR_ALL_MASK;
+	amd_qdma_pcie_write(pcie, val, AMD_QDMA_REG_IDR);
+
+	/* Set the Bridge enable bit */
+	val = amd_qdma_pcie_read(pcie, AMD_QDMA_REG_RPSC);
+	amd_qdma_pcie_write(pcie, val | AMD_QDMA_REG_RPSC_BEN, AMD_QDMA_REG_RPSC);
+
+	return 0;
+}
+
+static int amd_qdma_pcie_parse_dt(struct amd_qdma_pcie *priv)
+{
+	struct udevice *dev = priv->dev;
+
+	priv->breg_base = dev_read_addr_name_ptr(dev, "breg");
+	if (!priv->breg_base) {
+		dev_err(dev, "failed to get breg address\n");
+		return -EINVAL;
+	}
+
+	priv->ecam_base = dev_read_addr_name_ptr(dev, "cfg");
+	if (!priv->ecam_base) {
+		dev_err(dev, "failed to get cfg address\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int amd_qdma_pcie_probe(struct udevice *dev)
+{
+	struct amd_qdma_pcie *priv = dev_get_priv(dev);
+	int err;
+
+	priv->dev = dev;
+
+	err = amd_qdma_pcie_parse_dt(priv);
+	if (err) {
+		dev_err(dev, "Parsing DT failed\n");
+		return err;
+	}
+
+	err = amd_qdma_pcie_bridge_init(priv);
+	if (err) {
+		dev_err(dev, "HW Initialization failed\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id amd_qdma_pcie_of_match[] = {
+	{ .compatible = "xlnx,qdma-host-3.00", },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(amd_qdma_pcie) = {
+	.name = "amd_qdma_pcie",
+	.id = UCLASS_PCI,
+	.of_match = amd_qdma_pcie_of_match,
+	.probe = amd_qdma_pcie_probe,
+	.priv_auto = sizeof(struct amd_qdma_pcie),
+	.ops = &amd_qdma_pcie_ops,
+};
-- 
2.43.7

