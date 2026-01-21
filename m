Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79988C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 19:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A272D83AE9;
	Wed, 21 Jan 2026 20:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mj5F6bZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A5B283AC5; Wed, 21 Jan 2026 20:53:50 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2594A839DF
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 20:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZwpF5WhvhLs5mOAX8RaO5HpE0rfSVEde8U2tlGXzbXymp789FUuqX3++C11Dc/qC1JO1w35dQBNr+ksbxxpqEfnfEP4lk7FUG/bDgE4sW0xi52SeUGjDk6g1akI/IP/gQFL27jfDSkgc1Bb6aA/kEJeqNoNY+tLWswpCpbFGfm5TETKslA0kmUSpD/MSpP8K6gJ+JFXfW/jvngsCJBUFxgPquTq4VXaxhyfMvwod5mDJgUg9UG8kOmtc4A4piLxVra8DWGklYVfHBhkzV2mkVp5DLs2bp5JWByUt3QxxCYAj6tm6wcykviB3LxAq+Tniyo2kA0t2cvkPQuR8kv1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haSGUSMmts0xIrHfrPAD+e/rrJeRorX6x3OmY/HzPHw=;
 b=lQyCdjSlduqOH9femT9bBt5YmKy8kWS+gfjT1/jFDAeQJ04ZhFtutj7yPpd/bVKe2Cvr5kxSW9WrLyBh/cz4+/7Z1iZ8++KSptoPrdw82tfYJ24SNOEZmnx1mnvS4Y2N4qI1Lt+iMn/QKQCHtb+WCib9cWnrSXDBrXXomcxnaa3i5gfGGCGagvgN9fdMsDk4goBWPhfQsHL/1Xp9B7o0aLWUQSSqunMBnUcY1bLB3gfUTwBhRxUsgMWtONTLLKwsV/+1WyL381Rf0NhDedHz6yqkIqJL1y8TZeh/ZWABx2ZKemLGA5OUG3XV83rMyYjpDZikSosqBvoC6e1fip5KRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haSGUSMmts0xIrHfrPAD+e/rrJeRorX6x3OmY/HzPHw=;
 b=Mj5F6bZpKb+i+Sff1acT4jaQQUAz40tMEsa7Bap/BOjYWuNMCdxu/OrE2lUuxZylMpOM5jdVYjwqdIMvjDZF7rD+PdugMYLnG+JTL6u8NuwtOHQB2U3V4RmqVtydaA7m62sP4HD1c/q2iR9uAzCraUzCwjQZrzqZOxEs3yKqw4w=
Received: from BL1PR13CA0279.namprd13.prod.outlook.com (2603:10b6:208:2bc::14)
 by SJ2PR10MB7039.namprd10.prod.outlook.com (2603:10b6:a03:4c4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 19:53:44 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::9b) by BL1PR13CA0279.outlook.office365.com
 (2603:10b6:208:2bc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 19:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 19:53:43 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:53:41 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:53:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 13:53:41 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LJre8E3424431;
 Wed, 21 Jan 2026 13:53:41 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 1/4] board: ti: common: Add function for initialization of
 32k crystal
Date: Wed, 21 Jan 2026 13:53:37 -0600
Message-ID: <20260121195340.3041549-2-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121195340.3041549-1-vishalm@ti.com>
References: <20260121195340.3041549-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SJ2PR10MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: e13e0f1f-2821-4396-201b-08de5926c838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l3/T9kY8RxlPf+fzHzCrOEv31vmEOOUkaLkiqRMJLNRQxuss3AEbJxW4oWty?=
 =?us-ascii?Q?ozq5cu1jdBCwqLo1sFdunL/iMGK6P1kct0oeiSm9N9N1lPrAKd68uSrdpDi4?=
 =?us-ascii?Q?rwJWU442q/QjY4wL46wRm3ciz3hwZKgWS2XD03B8S3W01RglFIf++LvV/M7C?=
 =?us-ascii?Q?V5eq4dG/pLA7deHzVM+xOTEBmbqInHAH5zmZbruzi6Z+2K9/QmmP3Ot5ugnL?=
 =?us-ascii?Q?XLaLHebloW5E/pSWx7jXADxgwS70LwJ0e6DNmF9XAFom1YAhy6DD3Y96PXS/?=
 =?us-ascii?Q?jCoM9qzI0i+uefK7JgzxCYiTR4pY1KEvoOi0OSB4I+99YnSXEfmTjIAz2QFx?=
 =?us-ascii?Q?sAKzg1R4v0Esglsdh/ifP91/xNDcsFbWSPP6TSxuzN2QsSZThrDTBCwx0Dml?=
 =?us-ascii?Q?v3MpzncYmsAZTrdDLtbo/F6CNDBuKmC7XCyaIPp77HqoGqggl7P3Ez7V9Vha?=
 =?us-ascii?Q?jNxKHoCtjWwgxu/UZo0nyn4qvXns9I9/ZewxWnsBaR1RD04DqlgOrdlfHdr6?=
 =?us-ascii?Q?6qJiAViduyWsgAnBvsWtEQmWjxQcC6dFhoUbyj6lMBGyFiEYIBfkZlVqTcWc?=
 =?us-ascii?Q?yEpHsOvJ1snsH6E+uGzyuYG4t2OD2Zmp/PHN8+JH2Jgh2lYXWce26tfuZ9qi?=
 =?us-ascii?Q?Dh1WkXQ3BJzDBaz/bxCna/Xd/vr53MEowEZ4mikv8h+6B4kE2L9K2oZtv/nH?=
 =?us-ascii?Q?+FYhpdPjQPAG+jyIjG+u/4K53amuyY0WrWy53sez3ZWX6dEuUsN05Bg9DmXq?=
 =?us-ascii?Q?yzk1VKwFYKZPzMGyrgQ8RK9wRfzA5gQ9AZtAkvsgQtCuYj1zhTOxslfV8aKV?=
 =?us-ascii?Q?v2qAxsgHTjD+LuPSu5mngGC6mqp0K31corIiK8HgFvCSiuE7qnnHFjiiz095?=
 =?us-ascii?Q?9O0TVUQoOneWGUxDDuphaKIglqRPlvXFbvtIFSeCTw32yDyCSxygDumez+D1?=
 =?us-ascii?Q?7OmvYQBxnqqN1KnhHH5aQFJvKQ/2FRSuc61cq6qukPtHs+QcLW4xfkP9CYgf?=
 =?us-ascii?Q?ZkU8TLdtuiipdL0eYOTftfmZQwsgF3yvRCOl0eL1Jux0ZIpyee1S7ccyOXg3?=
 =?us-ascii?Q?yGoCXBcPMRhsdaRxGWFtsoee5hhRPqUdgstLDnBIGrzLpjknW50CYIWLut+8?=
 =?us-ascii?Q?28hfUwhfa4HQJt626Vzhay7mdCoMJAd4EMdlUcBmg8EN1Z92iQ49rwiIY54c?=
 =?us-ascii?Q?JwmgnEaPCLCuyoBTwVJAoAcWuzRvYxvAvrzBR/xFTBzwIw+qNtl80N29ZO28?=
 =?us-ascii?Q?rhy51lLTrSDampaJuuTDtS4udM+4BdAogvtVW3sACfiprOc0ASYmDs39/YRQ?=
 =?us-ascii?Q?bzrKQbO1ajoPL5zFrmJrVkxVLQn8nkoOxC3aofEzpZ6tQLHanQvSy6BUXM82?=
 =?us-ascii?Q?WSQv9eAB25AYBaatMSFcS+Kad72ohJxKR2qoJIfryik0/g1W+hJ2QY1XVt95?=
 =?us-ascii?Q?7wUVuCtYyvc10Jcv3TmlUtmhI0xOBROPmzt4fJHBPQ7ZNmGv44SznLUlQxwX?=
 =?us-ascii?Q?M2wc6idfSnWPnpWDQKxEscUIYM9gfWVvhEKcoU4qMHAy3kqhBxOapw5LkyJb?=
 =?us-ascii?Q?9RHqv6lJhcFiB2xUpo7UEPUq8wAA6+a8i3IMQHWoqJGkV+bVZId+N/biNY+i?=
 =?us-ascii?Q?mA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 19:53:43.4664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13e0f1f-2821-4396-201b-08de5926c838
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7039
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

