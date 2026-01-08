Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E6FD1D460
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB37841E7;
	Thu,  8 Jan 2026 15:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IjVgj8lF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD0084214; Thu,  8 Jan 2026 15:37:21 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA30E8416C
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmahMNTboTE9PLy1y1lGExhy9KL24Y316c5wnvt4O9HHWMDf/DvWsJUFaZu6CK4vg2oH+U0UC9cm3l14O8UMJTjEEiN63b1OFhaWlJwiG9VZV9g/BNXlhkUEsX6ssMsXPpcJaNEiE552d104ste5LXhHD7xpvLvvUIegR+/atMgKj8nL876rHC9UNGuELhgs0cL1NYoLVDk0tOLLncTJ434vE0z+itqEhA/gcn2az/CK1gwUeccDc3ERkA4DcdVyXUCWlpjr6WTB4DIR26pKQY9czab54oG4oyQY4Tv9oagpwwUdwnCE82o7eZXMCOFcQyyll8PPaNdSezCKOIa8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haSGUSMmts0xIrHfrPAD+e/rrJeRorX6x3OmY/HzPHw=;
 b=saznzFMczuccUFS4VhWY90ZoS0sfHUpOiZunUhIrh+d2rzxcgT6xbgH9nYyH3NILVfgUzjtlGI+FOZcQshmsXS7kH6uLj84lvd148Dw3Ew0AOLgqVA/myxLdZMr4GqFWhg01nrM5yyg69GeukGdHSwV94b1/R1lc38Dmcxortp9u/jdFllOP2Gjz96PwcC8+5o7msVkj+QQUEQkPMY8I4wtvro7IvFzMVqs67Mg1ENHfWFAUyQ169jKb5y60odeRKlbPSaJZmUydnNz5X1b1iuCDWrA7lfAD9yHl/J/ZHvmqPNJj/SB1/kQejHZk5shTyDuPnjQIBs/71AyA8mnSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haSGUSMmts0xIrHfrPAD+e/rrJeRorX6x3OmY/HzPHw=;
 b=IjVgj8lFuW8sZjbbjEazJusEFPRjWWfFgY0ugt2RfBDdBsyzcGztPP17wgNMBWmCcaMzzNc3j5BslochiizBPKtl9wU298amS6KWf7NzBoVHvzUYJpy/skWKyhtU5OANhzDM7Ihd0/RQzvPxQsrWQqjw3ZrXyik+qcncqyl9fno=
Received: from SN6PR05CA0016.namprd05.prod.outlook.com (2603:10b6:805:de::29)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:37:15 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::f5) by SN6PR05CA0016.outlook.office365.com
 (2603:10b6:805:de::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Thu, 8
 Jan 2026 14:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:37:15 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:37:14 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:37:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 08:37:14 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608EbEVg2521105;
 Thu, 8 Jan 2026 08:37:14 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 1/4] board: ti: common: Add function for initialization of
 32k crystal
Date: Thu, 8 Jan 2026 08:37:10 -0600
Message-ID: <20260108143713.1130054-2-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108143713.1130054-1-vishalm@ti.com>
References: <20260108143713.1130054-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SJ0PR10MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 8654e450-b547-46ee-f11f-08de4ec36af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|34020700016|34070700014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?85MamCNgV0Pa2h9pTQk9s3I4chEqIuoqCDdL3Hf3J/BanoE0kEyNpg+ATZi7?=
 =?us-ascii?Q?J2s9zViU8f9C6Qc+LgKjimkHr0z0Du5MHrLC/EHVRU6P30IuHUnHo9XimRIV?=
 =?us-ascii?Q?ka47EuOAAn0oaxdK3sJo4DH5L4sZRB/jF+0ifUIxQE3bSEkKmiMASKCrlBWd?=
 =?us-ascii?Q?sjOlT5Ptl+yOV9BUHwsUSWtU60nzbcmoQmVhXzPperkpr8nOXP4OF4S2CYoq?=
 =?us-ascii?Q?pcsfannkTT44mH1VQTIPSazOJXr5yeE4Le+X3+4ciJsLIBYLAJWauq83+K6H?=
 =?us-ascii?Q?59lMLuYT7AvQrZrAuWnfWKmUAMpdeTjbxB0VvLWF+OwMMgKRmVJfiqyA+Owo?=
 =?us-ascii?Q?oNMWhGUjXYWjmnwJhPT9HrDrLLMSjUNDUM3P8FQHyPiHAepMXKNbikJVe4qe?=
 =?us-ascii?Q?L+/kdjM9+GQccea6ORv34bXgMrjP22gE3an1/DCO3dNfuaUnSTZ7XxHMmXsk?=
 =?us-ascii?Q?+vn1zuviJL6bisD9FcefjfRDUuJThjN1hzt53gkfU1U+ly6gfctX1EDs37pr?=
 =?us-ascii?Q?YA4cpkEMfDwIMrpx+k+lcrbWYXlE3cqh+kTMdkh0XBzgcZAuC85kkQoyo+HG?=
 =?us-ascii?Q?m20VVsXmIkQ2NZBi2vMpogZI+zXUH+W4VZZGJhgBGkGqkV1zCgWZA5LtnIyk?=
 =?us-ascii?Q?Q9Vz0oxrwJRYiyF4IJIPZSJGVwc2/+OjrG0m5v4i0Qcz6dNlC396Matj2Lzv?=
 =?us-ascii?Q?2FsbRCi5mZKx+Jlfc+jneoSjfTrJuYQxFqcNvxlT0aU/7wJJmUReFgK82fSB?=
 =?us-ascii?Q?uSHtmtIRTkYAbON3J6zZh3b9OvKcLWXYt1g8JjaxcPSXma8at7fYxPLm82n5?=
 =?us-ascii?Q?7Oseve6zdK+LnwnxlExGliHF6FPOR4IzPeL4mCTE1B2byKB49NymNz3S1FBr?=
 =?us-ascii?Q?OI0IfYw7p6iInkOtsXZrlGbd9q2DD0NaaVNnzt1meyCN8GaCHbILXjy46rR6?=
 =?us-ascii?Q?Mc3Wn7bQbqmAH8Z4Om8S+i5KubRImUNl/5aZtgkHZT8prRfCISmu/GHuAgGq?=
 =?us-ascii?Q?6SsRXBewPrwQMQuKRaaQ4MSwBWjd+32kBIAwKLiHx1IUgeDsfQJgc4o1XD4V?=
 =?us-ascii?Q?ar8BoqIEUM6Px81z9HVy6Il2UMCohFsOz+wZCVW2ywvZ3l1N2IfMVgt70xl8?=
 =?us-ascii?Q?QluP0Dp2l41T9qicRh7FK2uWf9tEAJ78DJ9sR+OH6+w7731mJY1z614srSHn?=
 =?us-ascii?Q?tfDc7RGwqmE5ECHQGrRXcXgblq0fPxs+tZHpxMF59aXuux7AvI7/Xk23sN35?=
 =?us-ascii?Q?BmLV4WlfT23jBk6f/RtbkTVJrA+xmXAzEjP/0a40aejn3D8r/1G8How4zksM?=
 =?us-ascii?Q?QTJXy0U6Cb+pfFvnVBh9Iv2OX/iLw83thHMniRuocwKe3/k0T6c1gimuXycr?=
 =?us-ascii?Q?uE8GzdEJ31p7KJp22/1VMBk8+tCPyCfkMSVvjPvew5s5N2V/3FkcWkh7BooU?=
 =?us-ascii?Q?GjF7oaxa2UbXfNprTAFXodQ8RSO0mX5drRlvddcL+qsAXBg4VVoG2Ot/R9N/?=
 =?us-ascii?Q?aDe/hsNuPeNDi08=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(34020700016)(34070700014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:37:15.3300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8654e450-b547-46ee-f11f-08de4ec36af9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
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

Add a common helper function for doing the basic configuration
required for enabling the 32k crystal on some of the TI boards.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/common/Kconfig        |  5 +++++
 board/ti/common/Makefile       |  1 +
 board/ti/common/k3_32k_lfosc.c | 22 ++++++++++++++++++++++
 board/ti/common/k3_32k_lfosc.h | 15 +++++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 board/ti/common/k3_32k_lfosc.c
 create mode 100644 board/ti/common/k3_32k_lfosc.h

diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index 3dd2852e6b0..409454813f3 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -22,6 +22,11 @@ config CAPE_EEPROM_BUS_NUM
 	default 2
 	depends on SUPPORT_EXTENSION_SCAN
 
+config TI_K3_BOARD_LFOSC
+	bool "Initialize 32k LFOSC"
+	help
+	  Enable the 32k LFOSC on the device
+
 config TI_COMMON_CMD_OPTIONS
 	bool "Enable cmd options on TI platforms"
 	imply CMD_ASKENV
diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
index f58935b4103..b40c93cf312 100644
--- a/board/ti/common/Makefile
+++ b/board/ti/common/Makefile
@@ -5,3 +5,4 @@ obj-${CONFIG_TI_I2C_BOARD_DETECT} += board_detect.o
 obj-${CONFIG_$(PHASE_)SUPPORT_EXTENSION_SCAN} += cape_detect.o
 obj-${CONFIG_OF_LIBFDT} += fdt_ops.o
 obj-${CONFIG_ARCH_K3} += k3-ddr.o
+obj-${CONFIG_TI_K3_BOARD_LFOSC} += k3_32k_lfosc.o
diff --git a/board/ti/common/k3_32k_lfosc.c b/board/ti/common/k3_32k_lfosc.c
new file mode 100644
index 00000000000..24c5bad76b9
--- /dev/null
+++ b/board/ti/common/k3_32k_lfosc.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Library to support LFOSC operations common to some of the K3 devices
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/arch/hardware.h>
+
+void enable_32k_lfosc(void)
+{
+	u32 val;
+
+	/* We have 32k crystal, so lets enable it */
+	val = readl(MCU_CTRL_LFXOSC_CTRL);
+	val &= ~(MCU_CTRL_LFXOSC_32K_DISABLE_VAL);
+	writel(val, MCU_CTRL_LFXOSC_CTRL);
+	/* Add any TRIM needed for the crystal here.. */
+	/* Make sure to mux up to take the SoC 32k from the crystal */
+	writel(MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL,
+	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
+}
diff --git a/board/ti/common/k3_32k_lfosc.h b/board/ti/common/k3_32k_lfosc.h
new file mode 100644
index 00000000000..08752033f2e
--- /dev/null
+++ b/board/ti/common/k3_32k_lfosc.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Library to support LFOSC operations common to some of the K3 devices
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+#ifndef __32K_LFOSC_OPS_H
+#define __32K_LFOSC_OPS_H
+
+/**
+ * enable_32k_lfosc - Do basic initialization of the 32k crystal
+ */
+void enable_32k_lfosc(void);
+
+#endif /* __32K_LFOSC_OPS_H */
-- 
2.34.1

