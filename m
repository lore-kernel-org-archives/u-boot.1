Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10887CCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 06:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4531783B30;
	Thu,  6 Nov 2025 07:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t8hJ6On5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF19D83B0E; Thu,  6 Nov 2025 07:39:41 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFF883B2C
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 07:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhyYsLs+UnRT5y/apZQn6DeeEuvVvTzlQ4+4O2VmayMWwJLzeuVmuWFJQrB9hHzO0EeIFQQkyy0T7dgMUoLCRLejk2C6tA3pU0+rtC4WBXAsXfXwZ3Paef+qBP3co3F8RFqRxy2Yw25JxCKVPMxTYF4ExViQebaf7e0kS9ulbK5xVwb+y5ZZ0rbicTXNQMw1SrqIdDl1Xa0kHdA0jzfv6JgsyKiUHT63SsqSmh7pqesUlHsvPIdVCGWW0iYoYBVLKRD2jH1IiAGylo3nKtjDtbqbW9sP3A6YkDSDoFjzhqqCl+YoYfRS/c/V10Xlc7g21TgZ3ShLaI6qkU7Ma84Crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9jnsO5MwZgT/Hz7Qs8TViTTKNBEI649uOXvB/SOo4o=;
 b=cRB2dY9G9giF51WnIlNhfuLCnvFMce9IgQ1IO50UIK3Ep0f1zVbl0e2g9ENwmA1Bw2zXKCCuJGX7uYl3lvvsXI76ZWJXzEAcYqciM9Cu5zK/YqMrKe/JS+mH/Jds6afatLGFxU7hSEBNl48hYcVOrCB6CiVoFkJkrAFrivsZd/DKkCEnHybGv8xC1eyS14Qi/2t7zLcYn/1U3A78Qujf7uMj056KPBxOqYs+mpeikdqAAYqDqe+3dpngVTYDPy6xKzYNMb/dVOoFNLFj88I9a6jz+N9MVfRv3dIadMmmwzTDX3fwqI2k7gWi+j13Bg2aFAFZG7gE5jC9mt2wray+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9jnsO5MwZgT/Hz7Qs8TViTTKNBEI649uOXvB/SOo4o=;
 b=t8hJ6On5WOgjWGvzA6TbA/p5X4pxbGoOIrfOYA0bHw7F9kfLhad5tABYrTyAbMD0T8YBFzwdlodcF76lvCW3KOni/G9Yn2N0zhwUnNWrUM5tkH8OqEjMvf90uCV8VbF2W1u3NC5rtjJ/0nohJAY+2CMY+l62zqlsD5nZJJtJPr0=
Received: from MN0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:208:52c::27)
 by IA0PR10MB7160.namprd10.prod.outlook.com (2603:10b6:208:409::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 06:39:36 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::7) by MN0PR05CA0030.outlook.office365.com
 (2603:10b6:208:52c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.5 via Frontend Transport; Thu, 6
 Nov 2025 06:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:39:36 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:39:35 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:39:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 00:39:34 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A66dTjJ765811;
 Thu, 6 Nov 2025 00:39:32 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <b-padhi@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <gehariprasath@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 1/2] arch: mach-k3: j721s2_init: Add workaround for errata
 i2437
Date: Thu, 6 Nov 2025 12:09:28 +0530
Message-ID: <20251106063929.2232788-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106063929.2232788-1-n-francis@ti.com>
References: <20251106063929.2232788-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA0PR10MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 4752d29d-69ff-422c-ec23-08de1cff40d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ESFmNHVYBJf/SMDzip472perETquT2gzeD0oofk7nxK4whlc5DhoGUXYQM8c?=
 =?us-ascii?Q?FQRqHS2b+S0ZymytfGlSvI0F7SGmgClHlvXr1bWaqMjZvHuto6hTZOJfa6Zc?=
 =?us-ascii?Q?sMcogwJhmTpwmuyDcds0FPz/8mkYonyCeH9yNFS3U+g/ysjCC1PdPqMNE5xx?=
 =?us-ascii?Q?EGHJpW/tM2rXAEVnHDq52EU32YOzBFR3QO0ZgJ+jKxfAC3XH9gkvyrQFvLdb?=
 =?us-ascii?Q?uxlzYblp0p7ng0ygsj+vPvi6U8qjHWfnkw0mEXDammOGDJ11UX3vjIkSxLsf?=
 =?us-ascii?Q?P/TgeswfRQE/SzSIMmuz/uC2p6xRwCNMqem3tU4UbsuSSDT0dp18LOX4gpzX?=
 =?us-ascii?Q?4YnVTtUWPtOYLirwZtNAM4oQg5s/OEKbk7AlJe4GMHJBkc4DBV5afRi+tK6K?=
 =?us-ascii?Q?HjX2ybYfggBfBbGTGkoglxF/iNLAzoPBhHi2/cBG2vgJU0uO1Tuzbl55Iks4?=
 =?us-ascii?Q?QK5SA+AFTSZP+Q3tZSuFxe4YclkIb6puZmsqguS79HDYKvErjryt3IAf6jC8?=
 =?us-ascii?Q?jZLBVxaWrSyrEcNvQLsXArewuZdR44G4kaggdPhO+44gRZM2k455GuZP3MGS?=
 =?us-ascii?Q?mVrfGPjz2cRN6a/wx77dVDFOrWOg/zpLrLYGtRDeXDJiYp+r95RWArAaOInI?=
 =?us-ascii?Q?qE1FEf6+62ZN6bH0w7UM/8UsH6qqIFuvyX1cN6hNOwVujqUnzCMpL8fFPPNq?=
 =?us-ascii?Q?FVwU29zW4J5tTebG6W1AYaDNxphkM+9ROWwVx5uZQAvDtvTgV5t6MV2OtARu?=
 =?us-ascii?Q?cxo7CPMCzG/xXUK1SqwNFwuhr7WnoPb3K2zqo8C57xGfjjOn46oeiwhgkwAY?=
 =?us-ascii?Q?RmG25VafRKk9A4zo+lGYMv8fMMWjw6nq3cpm8iLx6IZxqOOtioKq5fAOaXxK?=
 =?us-ascii?Q?bLU76Fdz++tOqnSLzsHCAbTmGPvJ7i3u0825kynjR5fSdULQfhqQVJM7y2s8?=
 =?us-ascii?Q?1ElYrFL2LCyxvmQ4vxS7ciOplPN20G+NLDcyW/uwDQ1bYIMI2Hom080txsvy?=
 =?us-ascii?Q?Pgntpg//2qUUe2ZTq2uZlCyKKpUNQPEqZhFzo67DZnHugM+rtRlD4rz2onGJ?=
 =?us-ascii?Q?88aSpcI23gplxwCbR8/inZrZXH+n1GYoYNVK5zkj9ShHFy4zFEXEbgyxagiX?=
 =?us-ascii?Q?L9qhVweoAMGMrNog0XviD5TN+XIbL+S0V3JxIGgiTTYOSN4JGzj6uq4tPKn2?=
 =?us-ascii?Q?14atdP0RM4S67nf2D8jd9Ed2NafMJiRQdNs5L+NWmDnXZkGAS7uYK/uHxoHL?=
 =?us-ascii?Q?8Dmao0XKWprgjC6tBqFqyoYanX5MEZp64rI90C0zuaLNfNqJtmb7fUh3UGJV?=
 =?us-ascii?Q?H0u+Dr3waRSS0IbLRwMOEjjHcukmTMJwN1Vcpi1rpSdpJL1X2MhQ1ZjZ9XsA?=
 =?us-ascii?Q?9PCNry+EV4TNbPyKouHQjI/+aCClMP5ZYyed81/e2nvavl6W5VEWMC2S4/4o?=
 =?us-ascii?Q?DDWcElViiTNxZYWTRqZ5Wn7dVwMZNsuMYYQI2ncb2kf0bbYYMHPO1Y4I9Pu9?=
 =?us-ascii?Q?yup2LTByL5Nv+YA4E6X2bbfnQt0mwF2IfTTIhRw3uqZ2OMWSpg2JRji4Ve6w?=
 =?us-ascii?Q?uLaBBctFLqhNWVytis8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:39:36.1840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4752d29d-69ff-422c-ec23-08de1cff40d4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7160
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

Add the workaround proposed for J721S2 errata i2437 (link) for SE
clock-gating turning off too early. Without this, a hardware bug present
in C7120 leads to C7120 CPU hanging.

Link: https://www.ti.com/lit/pdf/sprz530
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/mach-k3/j721s2/j721s2_init.c | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index eee3d0440ac..ecc4cbf1df8 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -40,6 +40,15 @@
 #define NB_THREADMAP_BIT1				BIT(1)
 #define NB_THREADMAP_BIT2				BIT(2)
 
+/*
+ * RAT mapping for errata ID: i2437
+ */
+#define RAT_ERRATA2437_BASE_REGION0		0x40f90000
+#define RAT_ERRATA2437_IN_ADDR			0xc0000000
+#define RAT_ERRATA2437_OUT_ADDR_U		0x0000004d
+#define RAT_ERRATA2437_OUT_ADDR_L		0x21000000
+#define RAT_ERRATA2437_CTRL			0x80000010
+
 struct fwl_data cbass_hc_cfg0_fwls[] = {
 	{ "PCIE0_CFG", 2577, 7 },
 	{ "EMMC8SS0_CFG", 2579, 4 },
@@ -346,6 +355,36 @@ void board_init_f(ulong dummy)
 		if (ret)
 			printf("AVS init failed: %d\n", ret);
 	}
+
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		/*
+		 * Errata ID i2437: SE Clock-Gating Turning Off Too Early
+		 *
+		 * A hardware bug is present in the C7120 Streaming Engine top level
+		 * clock gating logic that can lead to the C7120 CPU hanging.
+
+		 * Workaround: The DSP_<COREID>_DEBUG_CLKEN_OVERRIDE fields of the
+		 * COMPUTE_CLUSTER_CFG_WRAP_0_CC_CNTRL register (where COREID is the
+		 * name of the specific C7120 core) must be enabled before power-up
+		 * of the C7120 core to override all clock-gating.
+		 */
+
+		/* Setup RAT mapping */
+		debug("Errata i2437: Use RAT for COMPUTE_CLUSTER_CFG_WRAP_0_CC_CNTRL register\n");
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x24) = RAT_ERRATA2437_IN_ADDR;
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x28) = RAT_ERRATA2437_OUT_ADDR_L;
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x2c) = RAT_ERRATA2437_OUT_ADDR_U;
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x20) = RAT_ERRATA2437_CTRL;
+
+		/* Enable DSP_X_DEBUG_CLKEN_OVERRIDE for C71x cores */
+		*(unsigned int *)(RAT_ERRATA2437_IN_ADDR + 0x200) = 0x00000300;
+
+		/* Clear RAT mapping */
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x20) = 0x0;
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x24) = 0x0;
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x28) = 0x0;
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x2c) = 0x0;
+	}
 }
 #endif
 
-- 
2.34.1

