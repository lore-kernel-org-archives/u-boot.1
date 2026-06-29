Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06164C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 09:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35DAC849EF;
	Mon, 29 Jun 2026 11:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3CBk8p0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62587849F0; Mon, 29 Jun 2026 11:33:53 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A164B849EE
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpaTnNgz6o8T1GrjUTd3QhMPNKHS5fUf+Ham3uVgsrrjuUMTcg1lMxXWSt9/4q7IV6y4PH7QYbGni7eZ7JTOeR/RrMCCiLLzBLDqy75veHpB+Y58IBBCryDmXhoHAjtZBE1rZKYOfw4ktAkbykpGwx9F2lUf1L1rs/7HZPiJduycVqK/vw0H9Zl/sXQBH77iZlQEYPTmV7oZu19WX2QX3Fi5e6RgNa3AUbVKNSNsdE0tYZqu680Xn5gcJWH1I1AmVHQDrkDGyvf/3sEar8hNjy2b2yj4lJnl2SkpNLbK0nhQ2vbTMmKqWP6CpzBIbtqeLxu5cFguOdpovUP/ib9z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lpm1ZtftJN6damhMSQGZnptHWdENORz8FVdB8OLoJQ=;
 b=j3/z0sc1q+tfxbVBzXXZZ7Fczo/QqG81SZTKcrGCSoEzWvhhFiA0JvHGCPLDSnIigokGzoseRLA34jU+RAklvKfl8TfwARg1yTgjKiIVldGyktug/H1+N5BJftXrVrUtlt11XBH/UX7r4XJyXyLy0T7IjgRzMx8oauvGYuagoflTMkzFz4g11l2qSeEXU2CyiOjvUTVEnjhobu0czsZ8iMZSTWeA3ftckcn6pWFdq7XFOgd07r8hKSdMLgcb0dx3xGt92/jL1WXtIi8tePKjNjTG19H8Pl8vp3q2VX/WVSdni7Aa4/mlcXylELk9KPIVoZugoU2rpuwl6pROLwwMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lpm1ZtftJN6damhMSQGZnptHWdENORz8FVdB8OLoJQ=;
 b=3CBk8p0q50NsYriWM0vrNpgefKAwwRt0sBvCyuF+hM7SidFCUnicnBZCcpOq+rBPm3gBPmDQ5HLmqjo8CR1asfh6pSG6kUUbZQIKrx0oN7cXND56YerMGltLjIJ7GJ+u1sXpsC/J1fpnKoxG9Ncm+whP9JTup6hYlFSBVMn+9Oo=
Received: from DM6PR04CA0029.namprd04.prod.outlook.com (2603:10b6:5:334::34)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:33:46 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::a4) by DM6PR04CA0029.outlook.office365.com
 (2603:10b6:5:334::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:33:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:33:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:33:44 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 04:33:43 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Maheedhar Bollapalli <maheedharsai.bollapalli@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal2: Select GIC redistributor base at runtime
Date: Mon, 29 Jun 2026 11:33:31 +0200
Message-ID: <3819bbedb39a31a0f872540dac5ed6076d39c026.1782725609.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3227; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tXZhcyLjARNsrE1WrhHkUEGXV/8B1UBgRwSOvnMbMIQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ5WX/c5TTf4HM+z1wzRwXVYofvyl2p88palWLulTgoT
 dpWtP5vRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEwkTIqR4ebjCoZrAvcu3zFv
 NrbLLZ4Tu6lvh9q8lc+V0hi2WL0M+s/wP9WIR2zxgZBpJ3r70noP/uBr4+gw3ZLscvGWT/jngwW
 LmQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 685ee9c1-e709-4f16-6ac1-08ded5c1848a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 2+Bey+LNW4+EihD28rHQffdzH5aTH6W9N8K4WOrSKJdIAmOrxGR/cGIM6IGCW9arTm4g/O0v1Oy+nyyOL0QgkfrNysBSPTTmWnlJYitGjKaKL+azz6lC4YIYsRRoQLjZAty1YnRJXSLBTD8kxqkz1KO/DLGEj5eNDzfdPo/NzTsodf8RRHqp2cTrymCJEzF7Zq45/hhqLB4v+xv03/TueMfdGLXjw0dMB1mtfO2mfT0shHoDEjB7Eq9+DxTtZpYKu0DZeGaZ5mlqRZGVnJRdRp06mhMZYUR0gXLAy0Ypz4wh9EPf0OXMca5WewtvaMoeHXxCld+qW4+sRy3DyZl3RHZD1L9YA3t88uuWS0GUc/cXgTubEbaR4sJObWlOVIcHAmRsAaVJjQlLO3bMZeyRVRqmYUerWJFHdq96z7zGZavDoTwuD+cpD3lmMRolZ7XvbvsAU7ugHc6+BLA3i6UKeOT/7tufwmsATdBxiX1PWSJCvpTquAY/SZ2ikKE1ayr88wuhxGU3kwMnBXlox3UDU226/XOLjDKs1+5Tse8JlwLQsmullly4Hsr66ZDd9P8ZtbyzzlM9LA1HPM2W/OZRHckCBMHbwhi6GfOU7WDn5gu/ptUMzmq/5CReaZXNMQBlwMVui5NGE73+esMQZBU/hQngr9aJFwNPwMKFgCrc3vUJJ00GoUZGFkgwtvKba0xsmxN8cligaDOUFxS4c4wZNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WZnSdeSQPh3eiMrrAAhwnB99pnFfDC8b4RWiUQw0Yec1+r6Z3HqenN3dwrpnRVWiAbLJCOcNdW4Z0YCjoDZYgk+YXYOH7Gbk8rk0gzAHMrUDvWHCr1tV7bXv6K/0HRXB+YnVnWMySGjFaJKO0R/CzCLN9hKPOQrTzSoZlq/U/MbzPzm/BRodHNruE1kt3U7OtwM8QT1VIgmHJMrkuvPbJBGG1/b04n6kAVZuZ3qxRaJ6uTyE9puSQk+C/vTDBp1xQbsaIiBQS30uBKMrbVqPaOFZSi7yNnADsX/q6Bjhj00Nh07WPYSUUYgRw11E7LnWatsLMWW1xkm0ezfL5+PUEMkhoDwYiF6/uD1Xvo/5p9Uh/J56Q7SJG91J9xyGX3XnNhwWjb7LWHm9U3ARg1h7kx5x5ikspuXldIjobDmNCzP+A9VZLmwfAWmX22GN8Aq9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:33:46.1883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 685ee9c1-e709-4f16-6ac1-08ded5c1848a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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

The GIC redistributor base address depends on the part: the 2VM3654
device has 4 APU cores and 3 GIC ITS blocks, which shifts the
redistributor region up compared to the base 8 core / single ITS part.
A single U-Boot binary must therefore pick the right base at runtime
instead of relying on the compile-time GICR_BASE used by the generic
lowlevel_init().

Add a SoC specific lowlevel_init() that reads the PMC TAP IDCODE and
selects GICR_BASE_2VM3654 for the 2VM3654 device, otherwise keeps the
default GICR_BASE. CONFIG_ARMV8_MULTIENTRY is not supported on Versal
Gen 2 so the generic slave handling is intentionally dropped.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/Makefile        |  1 +
 arch/arm/mach-versal2/lowlevel_init.S | 40 +++++++++++++++++++++++++++
 include/configs/amd_versal2.h         |  9 ++++++
 3 files changed, 50 insertions(+)
 create mode 100644 arch/arm/mach-versal2/lowlevel_init.S

diff --git a/arch/arm/mach-versal2/Makefile b/arch/arm/mach-versal2/Makefile
index 96497b1dfd0a..73b3c8a6f357 100644
--- a/arch/arm/mach-versal2/Makefile
+++ b/arch/arm/mach-versal2/Makefile
@@ -8,3 +8,4 @@
 
 obj-y	+= clk.o
 obj-y	+= cpu.o
+obj-y	+= lowlevel_init.o
diff --git a/arch/arm/mach-versal2/lowlevel_init.S b/arch/arm/mach-versal2/lowlevel_init.S
new file mode 100644
index 000000000000..8bfe50b806e3
--- /dev/null
+++ b/arch/arm/mach-versal2/lowlevel_init.S
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SoC specific lowlevel_init for AMD Versal Gen 2
+ *
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <asm-offsets.h>
+#include <config.h>
+#include <linux/linkage.h>
+#include <asm/macro.h>
+#include <asm/arch/hardware.h>
+
+ENTRY(lowlevel_init)
+	mov	x29, lr			/* Save LR */
+
+#if defined(CONFIG_GICV3)
+	branch_if_slave x0, 1f
+	ldr	x0, =GICD_BASE
+	bl	gic_init_secure
+1:
+	/*
+	 * Pick the redistributor base for this part. Default to GICR_BASE
+	 * and switch to GICR_BASE_2VM3654 when the PMC TAP IDCODE matches
+	 * the 2VM3654 device.
+	 */
+	ldr	x0, =GICR_BASE
+	ldr	x1, =PMC_TAP_IDCODE
+	ldr	w1, [x1]
+	ldr	w2, =GICR_IDCODE_2VM3654
+	cmp	w1, w2
+	b.ne	3f
+	ldr	x0, =GICR_BASE_2VM3654
+3:
+	bl	gic_init_secure_percpu
+#endif
+
+	mov	lr, x29			/* Restore LR */
+	ret
+ENDPROC(lowlevel_init)
diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
index a07e12bd1468..00627dcd9433 100644
--- a/include/configs/amd_versal2.h
+++ b/include/configs/amd_versal2.h
@@ -19,6 +19,15 @@
 #define GICD_BASE	0xe2000000
 #define GICR_BASE	0xe2060000
 
+/*
+ * The 2VM3654 part has 4 APU cores and 3 GIC ITS blocks (vs 8 cores and a
+ * single ITS on the base part), which moves the redistributor region up by
+ * the two extra ITS blocks. The right base is selected at runtime in
+ * lowlevel_init() based on the PMC TAP IDCODE.
+ */
+#define GICR_BASE_2VM3654	0xe20a0000
+#define GICR_IDCODE_2VM3654	0x04d98093
+
 /* Serial setup */
 #define CFG_SYS_BAUDRATE_TABLE \
 	{ 4800, 9600, 19200, 38400, 57600, 115200 }
---
base-commit: e01bb5b8ad09464b8cbf9c4186683e998c2d40fe
branch: debian-sent3

-- 
2.43.0

