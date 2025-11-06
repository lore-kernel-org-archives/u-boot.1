Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83103CCF9F8
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 06:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8814B83B2C;
	Thu,  6 Nov 2025 07:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pXPjqXNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497AF83B4A; Thu,  6 Nov 2025 07:39:44 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E5A83B22
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 07:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0bZSk6jPc6YmMUdRfDr28pio7FR7l5UzMchZttXD92jf/dZucNelFxvlZBypb97/7V7LlNrOiFbRppZmps7D6lHWueDIxOAfULHEUrCekYob5Zy6K4XHTnmYqBE+P4aBtyATP2KA8SJBCHMyogT6cjfCwR1oz4O+V1cW8Ysr84z631RdUputYEDKX7JB88NiqoIk0+6F0OM+KxbmUI3l04sWyXlUspfCbEyTSSNcJvvIoK8eWDxOGnrl8Fri7gRQx+DuyWvoHCbFV6a4DZIrXxw0hZ/Fe796Pn9XIxAvgxFvo+hTOoNvgkw9ynPHm8XEBpx261tzBgSYNx+PTwntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvMwx3MUbH+RJWjlNSYf/sNs4zuCEai8sKRpDuCSvRQ=;
 b=Cy5fveBVpLgyOHmZK6EMnGUHhkv9HA5vRXHXv3RsaN9EsNQ/bkyxulLxt+dcqTwxfu9iBwA6iy8kkJJL9iWaK8RTiJTRE4bpFuzx95nxnK5wjwxuDEk2V1ocBk76r1zZml2YRrg2HuePDxw0KEbiPLgZQoSQf2m6VCG4eOjS7saSlNdgndOM+OwWilmxwhhI9PSvAVMslJLf3li60Tl4SYo5aSDGzXtlQaR5s10/C13wdVlO0kiIkiTA4eTZnvzfTgihrXT2FX7Eozv5+9/4crRXF1DnHThFA0TK9N3Nh8eoZfoPYzlxrwmUpqhYFxe0pxqRS/i7VxvL+S99IaNoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvMwx3MUbH+RJWjlNSYf/sNs4zuCEai8sKRpDuCSvRQ=;
 b=pXPjqXNjaEbY7N10iaVxap32nV1Lf7eSgLpInrnv+IbrGioV2zMIU8zfaQnlkN1Q5K95ufxD//gIBBsSQPh5kqLf+7nEpAE3ZXvPqY0APTkHjUdCwWH+RZW/776kGAxwAja5u0c/KyhWiecAKIsI78z2IQRmrZSZm//5We22Sqk=
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by BY5PR10MB4212.namprd10.prod.outlook.com (2603:10b6:a03:200::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 06:39:38 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::84) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Thu,
 6 Nov 2025 06:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:39:38 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:39:37 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:39:37 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 00:39:37 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A66dTjK765811;
 Thu, 6 Nov 2025 00:39:35 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <b-padhi@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <gehariprasath@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 2/2] arch: mach-k3: j784s4_init: Add workaround for errata
 i2437
Date: Thu, 6 Nov 2025 12:09:29 +0530
Message-ID: <20251106063929.2232788-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106063929.2232788-1-n-francis@ti.com>
References: <20251106063929.2232788-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|BY5PR10MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 87896a7d-7ae9-4ad7-5406-08de1cff4211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lH0ypNPJeZt1MOtR9zTjnvid+M27JoLmTafEfBhMS15EfrOVhyVVPizcG32X?=
 =?us-ascii?Q?wQjrxpSY+xx9Vk7G4YB9CKeSmrlBZQ4AmcHYOlrjALQddn2H9pBCndhtir2v?=
 =?us-ascii?Q?59dOjvRwFseB2z7IkeplQfvx9s1jie5c1fYO/mugKeWItdYwrSLeXsybcJay?=
 =?us-ascii?Q?q1AAjlVTjYHau708Y+nQU+niuf/9G3G1smWdd2voAXwPBxYlArd3wPfPFpyP?=
 =?us-ascii?Q?ddZy/MVkg/6P5dLcAnz0iCLhQJy27mFokmyLXeYYEdkyWk3RkacRZkO/nU5a?=
 =?us-ascii?Q?3jGNaRprBDGdg9j1X89cH0FBLYNjtcyOu+ST2nWdyTMoBmefU8/9ClAuKdMR?=
 =?us-ascii?Q?h8QdkWDe8/4HC5fovrxsxLgEzbsNJUhvXsmkaw/+NUQx3W5g4sHIlkBLhiMZ?=
 =?us-ascii?Q?xdsj+h2rKZw6kqAGkE6VXZpI3YFv/ha3rp4oGGkGRkK+//xX5A2YHZEfa5r5?=
 =?us-ascii?Q?3vo/ubv+L7pGV0pZK85/OEf+LvjI/OUNhHyXlgMgXwZGKARMLcbA0d2tUZKV?=
 =?us-ascii?Q?j6CahdwWWRiGePmsImVyk7CODYTGaTz5SL7PNIOgK2rNTCFtXjWqlDklfuXs?=
 =?us-ascii?Q?mIVaMvV1MO8EkNuIlVkv+l+Wj4R76/jf2U6xw9qeDWionR4ri4pYdkykxwQB?=
 =?us-ascii?Q?lbvebiP3wMY7wuhsxZmc2HxYugqortRW3JqS+0WPlkEBuWqHSVJa8Si9dVS1?=
 =?us-ascii?Q?48R+XPqylSDsChqzRi2RjQ+HF6PcRH8bSRNHLMK/3w1LJjmltOXE4MyAFpe1?=
 =?us-ascii?Q?EgzkkRzGeT2fu27rED5tcfyqHqWF9wjctqpoYTOuXYbnp/FZoVr0uEc7BF/l?=
 =?us-ascii?Q?dfT0/Zhm7zldqNR1ZfuggdP94CgiO5TbueUJE0x0gFkpGqkjyB0QBnsTZChi?=
 =?us-ascii?Q?94TnPSzxlqjtEuBNyyCdb2dBac1eDbAF9TeQk2cbTzW8BhcReix0UhmKMrfC?=
 =?us-ascii?Q?3cGUBewog7kHKphl5LqUX4D+KjVqYhkGbzRDxRrNIfKT0RPrtWdelMiukOyu?=
 =?us-ascii?Q?gZTtGKV5mlmod+aOs4QTRrScv/ZCIkse3YKOuaKBY1g46QnQNE/+oT6x3lSO?=
 =?us-ascii?Q?Ioehf/hBquGw/j7FmXL0F/X0P8fa0JIioKnSs/fmADw0bl9og7ccTX422OBs?=
 =?us-ascii?Q?YXzzuz1TET56DkIFjKXjkjkgGGmaVsmmooZEHNFZ8XnsW4m9r4EPirRZFcsj?=
 =?us-ascii?Q?bJUenAd5Hui08QbTLBgAuqSq0FboJZznVgIh5rgvapZjip9GbbnHj8cO3JVz?=
 =?us-ascii?Q?8E/MOHHsbJSy7yvxbAQLHBjitYe5meYx5CkFCa/E5apszdOchFMyfPRFWTbd?=
 =?us-ascii?Q?qw6MfPGe/PHApoBrodlG8YoFHDdcHPxIf++xPgHxAO91U7bxAz431EPnYgb5?=
 =?us-ascii?Q?Vn56D5e39xIQk/om/yhKE7Qj+S/V6RX2dfwDG8YTGk3lQL40vf6kxwsK4ype?=
 =?us-ascii?Q?zLESA8seXYXjM1AQq+6XHs6wVnDqmV+OfKYAUWn2+rssgSJUDhn8JF87pTcD?=
 =?us-ascii?Q?CwtZH2VaTZmw2cyd2azsPps3vQEYt3qmnI3bxl5xevaXotDsXm4TXCflKIZF?=
 =?us-ascii?Q?DBSRybFs8kbiF80zA/U=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(34020700016)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:39:38.3192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87896a7d-7ae9-4ad7-5406-08de1cff4211
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4212
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

Add the workaround proposed for J784S4 errata i2437 (link) for SE
clock-gating turning off too early. Without this, a hardware bug present
in C7120 leads to C7120 CPU hanging.

Link: https://www.ti.com/lit/pdf/sprz536
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 53f152ccd9c..d5147b420c5 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -45,6 +45,15 @@
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
 struct fwl_data infra_cbass0_fwls[] = {
 	{ "PSC0", 5, 1 },
 	{ "PLL_CTRL0", 6, 1 },
@@ -322,6 +331,36 @@ void board_init_f(ulong dummy)
 		setup_navss_nb();
 
 	setup_qos();
+
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		/*
+		 * Errata ID i2437 SE Clock-Gating Turning Off Too Early
+		 *
+		 * A hardware bug is present in the C7120 Streaming Engine top level
+		 * clock gating logic thatcan lead to the C7120 CPU hanging.
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
+		*(unsigned int *)(RAT_ERRATA2437_IN_ADDR + 0x200) = 0x00000F00;
+
+		/* Clear RAT mapping */
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x20) = 0x0;
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x24) = 0x0;
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x28) = 0x0;
+		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x2c) = 0x0;
+	}
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
-- 
2.34.1

