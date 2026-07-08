Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B11C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 06:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1DD88497A;
	Wed,  8 Jul 2026 08:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVgmJyIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A3FB84A3C; Wed,  8 Jul 2026 08:56:50 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62EDD838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 08:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0mzQfO7b2uI9dFhS8Mv/QVflj7dlRubhd84x7D7Fsq8yCUluSjgvos+c1HTlSytPmzhrhh5PzA41YOJZZAGFSWsuYjcrNRX2UYcX2hyHU+fvnAjUNyswydh38oYIabC8t+C5ibLtSjd5k4q0ap0BSKBcoOUVsHy68QwugtsKUJBiimLl/X4GD4qli2/qUKaxNFC7RMF4l9Vw64tPSn+NvzLANivI4g0lusfwMqEx5bftjpHSbKsFfnfkxL8O0jXsCHdeKIpdIYS0H+AV2B8A9Gy8KkzQ9d+WDStHIAZsCogqTtEQ7c8T6zP5OH8v4uGdVHIFCZAlrZmXVgZAtZh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjbrjN3EGMmmB4BcbcLPZTwXN6aK2n2ZdKbam2Wbp3M=;
 b=s5khBcxZyN5yeXmvRhaJRqyb9zr1e51XkSuNlP0WxydRQYO9WJGchIedy95HVY0G8KiSlOOzQlZF7QI5+Wg6P13SIoCH1fLKJP72iYS1BRfP4wxbGK0loY5FEGhkcysnvnSe9D9AtRXoOZXGBKjgY/1W9RrMrXC9uMJq8gPJFOv7l7AoUoLWKX1vtQeLZvMk/D+QWxA3FLlP7sCrmgDDesDTnNTz7XJk1HrqaV1FmZwDW5Lg+0hEnwygXbUSE3qxaGGxI49ahDnurT/gI0kw1Qs2YozG/GDmv3JBH46yor8rnt1N+FgHy8Dwiwz4RLDSXd+bN8PjSp4AOhi1QnEsiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjbrjN3EGMmmB4BcbcLPZTwXN6aK2n2ZdKbam2Wbp3M=;
 b=zVgmJyIRIroTmSsqsuexKfcDguKMJWyL3NEggM4SX27cyvTQTCD2CsbgX7XObO4cnFgiMBhSoPpylw6ggXYtPEiprjq6Bkw9He+8FkkTm5D6vETExTYD8E3s1MrQJxx5/mdB1gjGxOyei20l3gn1+DtqHEOQe2iL+pEp05rIO0w=
Received: from SJ0PR03CA0115.namprd03.prod.outlook.com (2603:10b6:a03:333::30)
 by DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 06:56:42 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::22) by SJ0PR03CA0115.outlook.office365.com
 (2603:10b6:a03:333::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 8
 Jul 2026 06:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 06:56:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 01:54:01 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 01:54:00 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] arm64: versal2: Make hardware.h assembly safe
Date: Wed, 8 Jul 2026 08:53:53 +0200
Message-ID: <de4de47ea457b285c5870e7ba25b4baf554561e7.1783493630.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3878; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=v+Lvzbjbtvhp/K655FEsDE4sOuwMSVduOK51Ex+ubfY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT5fmE6J3LEwjO0TeCM2+PijqQ9254uq1+pKd3ouzkja
 6rEx/XhHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRuc0Mf4VSGNqjb5z9vezh
 iS6JmmUdOmElCvPenZH2ETiQb+Gy6QXD/xjDxOrdl8+aRHbze3fsnqRz+fE9todzWhf4N6nOesf
 IxQIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS4PR12MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: d186b20b-35d2-4cf0-2568-08dedcbe111f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: CLnolMLReTvGnG/aJ4jtudRGEofDCzqqvFYDFOJ/ws7YmdTx3DSikZCY6SovN53Dj7yMJeT0gDuQR3gAlryVUrmYkTfUV0o2z5OZdFKCQ9OQXlgnlJoR/+G/3aBT90Q1PpgESI4b/ugih9yD++IvMWpVrHLgbysp/seO3CoTsj4KZhthHQbDNr7+NUNKpNDFfQDfx6goKUTg5E1ZKKo63u+Eswlq1+ls8emJqcfav4AtJWNXtDDJZaD5N8qxcHS81qANb+A/TRfHtSP19REEsnzbpby3JK2XLB4QDcAo40K9FYBcNG4TZBeYQKaC075euHcSHpRLSUy5kKG94wj0vLZU8c3EVY2yo+0tejDch83nXuTdBw1Sx42COCwR5jpcgkeRzT5XvGr+aWOsFc2amlw2UoDhZdL5NE0DoEFCd/t0bEZ6nbds/NKsmDTjzWrZs0mVjm+jMODwpFdjM78P7BiZl8VwvgzWmDM2NliG6gDdRKy3SyTN7IOgpIDOF18RunZYU+impQDe5sV3kP4vNO2OujHVbNie0UbEdyErCUQTljEU2V9oRresBSBD/P8gmJPWYVlaVGl7rsgqk6h3SPhB9VCeoXeexU8EYFPOTcQ1RbSAhq26dpGkCNTGqVl1YL598WXwQWqs4lldoLvqHxLs+ruYX18JU8syr49JEFFfNbK0h9isIofAkhFHrQpfXqZPMrBc7qwYx0hbiedOhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7bwW+AUwCEWTKVykgvYz35c2kpJZtmowva49oQUPbc+YLpm7yXnHjj1+Gov76/Gg5l9MDbzo6bKDlW6PQJu1RnBz0n/OAJbPavsAwPCvw812lCHOfgx67inFVi6/dgZk4BD9GZxg/Gu8XSDvnnw3b/oWqq2NuR5IyIi797IP2Wb7UCQunvwxdr0udYfYUOrZLVEAmPZHEdlyT497G6EW7NvkcOPtxYmueijq3pOftep9UOMEsIe8VXNHnWl52n83IpZHhzgR4dczeSRm/htl8rDl+JuCtooA5bbnNR2KRZZxjrXGCiT+z8OdVKXTu8zUHpxyAk7qHGF4OM7P6m/UzHvzgIrBYD+8ILCuuAdWE1n+3MNczgmU3ptUN3E/pCE8vq7KaAzpRlDkBgMhn7FAmfvYd4pyQo7CEriwjAAr9d9d4J+92OSRicFJjgY66GvS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:56:42.0983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d186b20b-35d2-4cf0-2568-08dedcbe111f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9708
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

The register address and bootmode defines in this header are useful from
early assembly (e.g. lowlevel_init reading PMC_TAP_IDCODE), but the file
could not be included from .S because the C-only declarations were not
guarded.

Reorder the header so all plain address/value defines are visible to both
C and assembly, and move every C-only construct (the linux/bitops.h
include, the register structs, the base pointer-cast macros and the
platform enum) into a single #ifndef __ASSEMBLY__ block.

No functional change for C consumers.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- new patch in series

 arch/arm/mach-versal2/include/mach/hardware.h | 82 +++++++++----------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
index 1bebf20910a0..7977529fd6c1 100644
--- a/arch/arm/mach-versal2/include/mach/hardware.h
+++ b/arch/arm/mach-versal2/include/mach/hardware.h
@@ -4,34 +4,6 @@
  * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
  */
 
-#ifndef __ASSEMBLY__
-#include <linux/bitops.h>
-#endif
-
-struct crlapb_regs {
-	u32 reserved0[67];
-	u32 cpu_r5_ctrl;
-	u32 reserved;
-	u32 iou_switch_ctrl; /* 0x114 */
-	u32 reserved1[13];
-	u32 timestamp_ref_ctrl; /* 0x14c */
-	u32 reserved3[108];
-	u32 rst_cpu_r5;
-	u32 reserved2[17];
-	u32 rst_timestamp; /* 0x348 */
-};
-
-struct iou_scntrs_regs {
-	u32 counter_control_register; /* 0x0 */
-	u32 reserved0[7];
-	u32 base_frequency_id_register; /* 0x20 */
-};
-
-struct crp_regs {
-	u32 reserved0[128];
-	u32 boot_mode_usr;	/* 0x200 */
-};
-
 #define VERSAL2_CRL_APB_BASEADDR		0xEB5E0000
 #define VERSAL2_CRP_BASEADDR			0xF1260000
 #define VERSAL2_IOU_SCNTR_SECURE		0xEC920000
@@ -41,10 +13,6 @@ struct crp_regs {
 #define IOU_SWITCH_CTRL_DIVISOR0_SHIFT		8
 #define IOU_SCNTRS_CONTROL_EN			1
 
-#define crlapb_base ((struct crlapb_regs *)VERSAL2_CRL_APB_BASEADDR)
-#define crp_base ((struct crp_regs *)VERSAL2_CRP_BASEADDR)
-#define iou_scntr_secure ((struct iou_scntrs_regs *)VERSAL2_IOU_SCNTR_SECURE)
-
 #define PMC_TAP	0xF11A0000
 
 #define PMC_TAP_IDCODE		(PMC_TAP + 0)
@@ -76,15 +44,6 @@ struct crp_regs {
 #define PMC_MULTI_BOOT_REG	0xF1110004
 #define PMC_MULTI_BOOT_MASK	0x1FFF
 
-enum versal2_platform {
-	VERSAL2_SILICON = 0,
-	VERSAL2_SPP = 1,
-	VERSAL2_EMU = 2,
-	VERSAL2_QEMU = 3,
-	VERSAL2_SPP_MMD = 5,
-	VERSAL2_EMU_MMD = 6,
-};
-
 #define VERSAL2_SLCR_BASEADDR	0xF1060000
 #define VERSAL_AXI_MUX_SEL	(VERSAL2_SLCR_BASEADDR + 0x504)
 #define VERSAL_OSPI_LINEAR_MODE	BIT(1)
@@ -108,3 +67,44 @@ enum versal2_platform {
 
 #define PMC_GLOBAL_PGGS3_REG	0xF111005C
 #define PMC_GLOBAL_PGGS4_REG	0xF1110060
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+
+struct crlapb_regs {
+	u32 reserved0[67];
+	u32 cpu_r5_ctrl;
+	u32 reserved;
+	u32 iou_switch_ctrl; /* 0x114 */
+	u32 reserved1[13];
+	u32 timestamp_ref_ctrl; /* 0x14c */
+	u32 reserved3[108];
+	u32 rst_cpu_r5;
+	u32 reserved2[17];
+	u32 rst_timestamp; /* 0x348 */
+};
+
+struct iou_scntrs_regs {
+	u32 counter_control_register; /* 0x0 */
+	u32 reserved0[7];
+	u32 base_frequency_id_register; /* 0x20 */
+};
+
+struct crp_regs {
+	u32 reserved0[128];
+	u32 boot_mode_usr;	/* 0x200 */
+};
+
+#define crlapb_base ((struct crlapb_regs *)VERSAL2_CRL_APB_BASEADDR)
+#define crp_base ((struct crp_regs *)VERSAL2_CRP_BASEADDR)
+#define iou_scntr_secure ((struct iou_scntrs_regs *)VERSAL2_IOU_SCNTR_SECURE)
+
+enum versal2_platform {
+	VERSAL2_SILICON = 0,
+	VERSAL2_SPP = 1,
+	VERSAL2_EMU = 2,
+	VERSAL2_QEMU = 3,
+	VERSAL2_SPP_MMD = 5,
+	VERSAL2_EMU_MMD = 6,
+};
+#endif /* __ASSEMBLY__ */
---
base-commit: 3278a671cb521d898e6f49d35f6bc034b2ac4d46
branch: debian-sent3

-- 
2.43.0

