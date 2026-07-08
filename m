Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B892C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 06:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A1F84A3E;
	Wed,  8 Jul 2026 08:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3QnImRCE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E206838D7; Wed,  8 Jul 2026 08:56:50 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516EB8497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 08:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgF0ZtEKuwR8KGnYXfxdC97LKZ2pWwr1gholTuflGrIEDTYSNYh9aEBOdXf6vdZUUjNi2SZPTMhEL3v0jnqCJ/jTIuJAYwRlN/sFlTfMKh1Ru1Yn9OWVtIHW7CHV50zj+TLg2+Is199tdbK60FxqimVrWTFjNnRz0EQQr1aPjyImk5fAFTer0pJPTHXn+3O7ZOfcfalyiVeaVJ1tKi7qpW2G/s9gBfytzCqXPtwx7/n6qYImoVRoLItAjDEVlrbx4veEzlyMHaM6nyk14xXr7C81pd5iIOK9500/NEtsSNi+yj9eOOjBkc4N2L4ypR3ILS8V+IoTyGw92/j2Rak/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVt0Z4O15PFZcbMTMZ2HiIHfGo7YlSxWLozqjF1KCOc=;
 b=pokEzgWhFSXZfzHZzUeCYi8ZAh8rRQwXD3FztE3OWeNZUllU114P6J+CN0Dp/iBTxdL7/Mmny0S8wNZWXTI6UYoRQrs6pIeq3FCSGK/EEXjR34Je8ZLvGwUZUIeOY/C/4ZSpnyMA+CoJ5AbuI97b9HXg7CXtI6wJbqrHyO18hyBeNJp/foI8/8Eph8TFr9yfU6nLLqogidwf9tE8NX32mKSwripLR2kOiMxPmWl0TjT9TlDxosP26Km8QO/iAKyfMUAYU5KMNJvHTTgEt1KRbwMgvAEz2f5Uil/IiQrTpexp4osX8woL5G9VKGBYXvWHoukwZEK+hcqHr4ekjQ25Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVt0Z4O15PFZcbMTMZ2HiIHfGo7YlSxWLozqjF1KCOc=;
 b=3QnImRCEWZ9fzpkXRHgbLFPe/hmvJZmeFVPZWnkV7TyeiLyfBUlScn2D5qjND5Q7bPAr73VlZxMR+PYHipa1MGV+VF9ljksA+T/J0yTLitsBVrfdFwtSxjIoYDQnyVfMAtqdvPs6G9ogLcHisKGPQL+r6kssJYu2JyhfvB34LDM=
Received: from SJ0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:a03:333::9)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 06:56:42 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::98) by SJ0PR03CA0094.outlook.office365.com
 (2603:10b6:a03:333::9) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 06:56:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 01:56:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 01:55:11 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 01:55:11 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Maheedhar Bollapalli <maheedharsai.bollapalli@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 2/2] arm64: versal2: Select GIC redistributor base at
 runtime
Date: Wed, 8 Jul 2026 08:53:54 +0200
Message-ID: <4c0dc2b6e29d300db15be0844879ab4d028d98a9.1783493630.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <de4de47ea457b285c5870e7ba25b4baf554561e7.1783493630.git.michal.simek@amd.com>
References: <de4de47ea457b285c5870e7ba25b4baf554561e7.1783493630.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3283; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=UGo02TCSJuKGqdR2XLy5+K4k2u4yZYfY8LzHDmE4yQg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT5fmHTP9yz6FJ+tA23cs7cshmCqxS8lidUFCdq1jnEn
 pH9+6K0o5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACZSGczwTznF51yhq/rHmX21
 zosYHeWtroa83CBzfHrkn2/f7hhejWBkWNP9z0Xi3er7vXOk7mcxNiQZ531kFeWsCU6IOXlo56G
 v7AA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 68df2186-6ec2-404e-0b2a-08dedcbe10ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +nBWnZC0wMGOAARc5UdGOlq7B+Udpy/K1DsEn3RoElUEQiBf/+/WFVSbRCEq6oDFJyzZ22XwAspP5KD0Tyyi3bNgKF6/DHjz2yiZh6A0+4mTzkPGCQ0ULbSkoluIlJuELC1D+vHpPr8x2Niq8nMxEDqc6z/2VMKV0JTWfG3l6WbpJTDi7xrlLUtR/bUdQx4s1pt+cnNXSRsr+TfH+mo7VF9GQY5HH1iWy7uIlX3fYKaBfZfKFZAXTmfwMjcwC09v9NG5zAzlMZ2KqDg37TDvw4tZsCmxlAA3WGNUQ1swunefxYWFBEBj4kRLDcxqJIaCqH/0G44WMR+1gDczw+J3vPE08gSGFhTiBXTYeaq4VUybQ8ah8iZc+SpFRRTfhbq9Pdz1S+2FVZjwYq5yob496NseYv7oSK39BaKPbY07u4F+EdSOafNWfjAo0b5nL/KvKJ1t6Zb2P/i9WHCp5Fyo69QS4wp0hNkKJ17mgATHeMAp119jbbag8B6zvFzdWHNZldwdhBtDIvKoNfdtJ3bdSgkHOvgQdq1lnq3VDFK6m28nUSsGWQkGXCeNGl1ORuIFkbqOSHtgkc5+xTK7/fma5rXiapKLUfEFGf0TrgDk3KYWd/dovsMGnQrUfgKU7duIHnouFnNWmJ5e48dkrk7JSenq7YufLvjxz6YpZ9hmCwsHCGYKUHdrHvMUStT5ssXpio4BwKrHvevdpOCTbjE9mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0xK2dFIeJQ3b9GImt3lsLH6P5BZVwcA36LHBthUsr7Wz6uw2b4FtxhzEASLFf16akJ1BHDzagAAQ0Js2PFtvrweTgbk/P7fK/GiqfE9cGRXZhyGd0u4Ut7JBMTIye6a9cRbKZGZs815T6BTUDYP4pHLGwmxGz10iQmOAXMwtA2Jjsvcfaf02z4lVJ2SbpmTVAuMxBdaVvJYxM7bCn95aDbH0Hyy1tL2eFLf0Bc93p1Z6HrQNcdUPqw42zMLbxuB27cQF2SgkxHi0HoIZAhTuJKuTqpUOJO6yONtFBaBZmUJUEo+5HsTO6IBWQngZkdWOkWm5UcnUUsPQlLa64LdejCyc8zj7sAyWbsvI3T3ysHuRLI7IHmrbInSQMb3p4jh0Xc+G1wAxj4RyqmxbHRaBiHKr76wjfJrLNsJjkgjdyYfRrtnwha95NHxaLLAuF0Zu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:56:41.8879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68df2186-6ec2-404e-0b2a-08dedcbe10ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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

Changes in v2:
- Also make hardware.h assembly safe

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
base-commit: 3278a671cb521d898e6f49d35f6bc034b2ac4d46
branch: debian-sent3

-- 
2.43.0

