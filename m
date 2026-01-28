Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C1DD25B4F
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 12:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B6A83CEA;
	Wed, 28 Jan 2026 13:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FwVXdBqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA85883DA7; Wed, 28 Jan 2026 13:35:11 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E8683C65
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 13:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAMm4jR6Q5nzbjrBniZwCMedQMUdx63unvipLveyiFkuiAhmIV91EZ77v7AUbRNv57XzCj+LvtXQKMncZLxwGEILTFC0J31qfGh6F1jXpfahjc+4GTm6U21fL0uGUimf+WW3mUngRYh9QXexIs9ElDYA87gi2TsgOo3Vv0wSoS5QGLxld9o3S8S4Zmio8AqPtkgpzbiX1fQg3C0T64nQtjuTA2qqZqfAZA08zWMdNLHPAneBkn4/hip9AFVGGZ/zG7k2P95WMIi0Z6egjW1LMe9+Xr0SStWDf8rSX7JdV4eudk8bOXJtbPgNrysyS20sTVkQjWobQO2dJpmzfMjheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jogCNFuqjVDOHH7LfFwXn9xWs9QjKt5zVGhYo+pCHgE=;
 b=QzXU2nN81D5/3Itr0ZENFdNJxGzHoufatjlKbXjVrSb8k2vRGghk0m6iOzxyi9OqkFk6mkGLUJcoj8x+u3A14uELBzqIAOUEreuj4ih+q1+s5xdQU79yTJ8Ms0nzkgQRmUt2Moob47lzWVTHUMo2CSeZgfEtPab2977lHozBLe8Q6L+Z4cZiMy5KyEzKiNlrMnAXk1CX4ilOiyRxhEef+c5GpGKXgBp30tAFZ0RCIkXaFspP8taLLquyKSgZJ2oFLm1EfB/lQlMJC9Nge2GcwMF3A18t2xGlkRYZnpg7Y5LOhcmc7mipy65tfnX9ONw8m5nzpvhwJdz09JlQ2pnLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jogCNFuqjVDOHH7LfFwXn9xWs9QjKt5zVGhYo+pCHgE=;
 b=FwVXdBqd8fCsVDAtbMfjjE9bCUyMU3vHWLZDeYKiTaxdv/drAxwq2WalTHAJPx6SwetoX4xw9BUUvjK1IxN9HRHy+HOsoo1riN3fFBM3qhpVIj8Jh3f61tRl1un9pnwxfEYi7jsVua/D8M31ew/8Tg6g1Zv++pXhkDsEK5oXu6g=
Received: from MN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:52d::15)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 12:35:06 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::f4) by MN0PR04CA0003.outlook.office365.com
 (2603:10b6:208:52d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 12:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 12:35:05 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 06:35:03 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 06:35:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 06:35:03 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60SCZ1SE2356985;
 Wed, 28 Jan 2026 06:35:01 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] arm: mach-k3: r5: j721e: clk-data: manually set the
 main_pll3 frequency
Date: Wed, 28 Jan 2026 18:06:21 +0530
Message-ID: <20260128123623.2737451-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SJ0PR10MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d8b3c7-644a-4e29-6498-08de5e69aa43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8iKXrm3wGDteYKtf1RDUIf0HRDtlCTyrrTrzCU1AalifdZ7Gv2fqYpUbsxcb?=
 =?us-ascii?Q?I/0LOZyeZeHVOsklEoBnl2UJh7jIGrNAndZ20zsbXxchVM4a9OBZGSwgHcms?=
 =?us-ascii?Q?O8qcE2lV6tF40dwLDT33YugmYNTYwA9pISOe+hc+XlrGKwvl9o7ENMKJaPRn?=
 =?us-ascii?Q?Tk/tBjkgvqCDGr5ZM4ElCfCucyfd4cfyH5Z3L9GYckP2HQDy6OhJZ5t+Qvl2?=
 =?us-ascii?Q?42Mo2g0vBb1NmA3gK4ZGAiXeIENCNMZOLdPx92PAAS941am8+sqe5fOF8Lz3?=
 =?us-ascii?Q?kEyz8+bd5IEPnMo9yHaFEMa0JCWsd4Vim8/fh1SYd5Vm1GUQM1zbIkMEl65a?=
 =?us-ascii?Q?roAAWCY4XacV6p01FrrtPNEhGr+eKTxF7TclqT5MWttm0w5MslO+RNbPx/lm?=
 =?us-ascii?Q?rFZ7Wcrw5Z98QYGmPbXxqCbjHQHAO7J2pxQ86JO688rBtpG1JOGUlQkYbkUz?=
 =?us-ascii?Q?RSpQnP4OpGCPya+/qgCrSlyoZHYnPkWHE2WRBG0mjS9a/WFzi/vwtNrjDA6C?=
 =?us-ascii?Q?uZYnJbLql/WcJsT0Cg1O2CYtaQlMQAgjzPydWziw9m237HZwq9HzjyETjSKZ?=
 =?us-ascii?Q?Nj6sj/y6CI+MH0Q7Rd67bApVEgGKcB/HrLmBv5UXKfC3VB1lZtPioiSdnMR9?=
 =?us-ascii?Q?jNOuOKic4IcVcG+0TDVAAH3ySGYOg9ofpRlub+gKq5ggvKHa6BFEzAzt6Q1O?=
 =?us-ascii?Q?qC3WMDgo2PTJrDYq1eZ0yOiR2722MjIBOim98ui2RG+U1az7hNqlThQj5qku?=
 =?us-ascii?Q?+BAso+8JLxoldDYleIuG/GgYX3nUY1jTLcPdQL2fxEysFNsEpg59sSl1wePy?=
 =?us-ascii?Q?I0fYYUyWK8K5nuzzLdtsihO9sd1u1/8F4c6Yqc58MdnQal9kWST8i1PPns1p?=
 =?us-ascii?Q?7AUqSADV0R8BOjpPIVg9qN0CZk38fe1l1NgPR2OHHGARuJFZ5nDFedKbj7bz?=
 =?us-ascii?Q?qUQmVQTT87eS7TWCGb7M6wTzENut8FqI/kmktsZnEAZfAPiBPlnMM6UdbxaS?=
 =?us-ascii?Q?k1z9jBwJuZvMqWweY+d45nOEgd3mWpnuE1L7chk/B3klF1R9hEdEcjeyEPhA?=
 =?us-ascii?Q?rspHdS6t6nyuugLpJ0d5CtaWEbVevcaQ4/68h7cgRP4eRXf/p89CrTHMrKOl?=
 =?us-ascii?Q?Kslkam3R1h+apzUXVPPwUxnen+bH0EHPme9/OR7DcO3mZQJzy9uJxXfhhvb1?=
 =?us-ascii?Q?5/3tr/+y5kLA0N5oQcRuiGvbMk/kTaQOWNLajvqS98GwWMsnKt1c/5NmhjyR?=
 =?us-ascii?Q?f/TwEUTme538lTmkgEGEmgFLR+qeL/yPbKRqLuzmEEYiLPew8cOYEwk/ByNS?=
 =?us-ascii?Q?2Vl3klgvMqFZBb6Fk66o+9BHZqpfl/UTIl5DH6igfyWC2XwmxSJf7ZRq9MSS?=
 =?us-ascii?Q?tiDZ/1SLWtpmkKow6iaoPngen1/+V2rLx6SQd1H0/JzAmEPOfs4ZtBnpnSlf?=
 =?us-ascii?Q?3L3Tk4CU+T04lmdxEFhMcX7+JDDHtsoUHsQPoHgX1Cow7UiveWEoE8DROZdT?=
 =?us-ascii?Q?NWWcwT9YodP3qiE4/lNP0xY1dLp4YOToNRb573Wtf+C+GKn8BeSFLqvgr4Eo?=
 =?us-ascii?Q?suy1J8/NyyWuLwomLcRQdQ+gRIOYswTZfHvTGNHQz6oyEidivqKYMITTgCXe?=
 =?us-ascii?Q?asKtbXhHQZNAMApcckRUI1DGpy4jjC2WkhMz8sExMFWopDu/yYCNKOms9n0H?=
 =?us-ascii?Q?BIq10g=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 12:35:05.3192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d8b3c7-644a-4e29-6498-08de5e69aa43
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
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

From: Bryan Brattlof <bb@ti.com>

Moving forward, DM firmware will no longer mess with the MAIN_PLL3.
This means MAIN_PLL3 will need to be manually set to 2GHz in order for
the CPSW9G HSDIV to have the correct 250MHz output for RGMII.

Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

v1 of this patch is at:
https://lore.kernel.org/r/20260128122604.2735602-1-s-vadapalli@ti.com/
Changes since v1:
- Fixed the $subject of the patch.

Patch is based on commit
431f1ce46bb Revert a number of incorrect commits
of the master branch of U-Boot.

Regards,
Siddharth.

 arch/arm/mach-k3/r5/j721e/clk-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/r5/j721e/clk-data.c b/arch/arm/mach-k3/r5/j721e/clk-data.c
index e4511092c86..bb7f61901b4 100644
--- a/arch/arm/mach-k3/r5/j721e/clk-data.c
+++ b/arch/arm/mach-k3/r5/j721e/clk-data.c
@@ -539,7 +539,7 @@ static const struct clk_data clk_list[] = {
 	CLK_PLL("pllfrac2_ssmod_16fft_main_2_foutvcop_clk", "main_pll_hfosc_sel_out2", 0x682000, 0),
 	CLK_PLL("pllfrac2_ssmod_16fft_main_23_foutvcop_clk", "main_pll_hfosc_sel_out23", 0x697000, 0),
 	CLK_PLL("pllfrac2_ssmod_16fft_main_25_foutvcop_clk", "main_pll25_hfosc_sel_out0", 0x699000, 0),
-	CLK_PLL("pllfrac2_ssmod_16fft_main_3_foutvcop_clk", "main_pll_hfosc_sel_out3", 0x683000, 0),
+	CLK_PLL_DEFFREQ("pllfrac2_ssmod_16fft_main_3_foutvcop_clk", "main_pll_hfosc_sel_out3", 0x683000, 0, 2000000000),
 	CLK_PLL("pllfrac2_ssmod_16fft_main_5_foutvcop_clk", "main_pll_hfosc_sel_out5", 0x685000, 0),
 	CLK_PLL("pllfrac2_ssmod_16fft_main_6_foutvcop_clk", "main_pll_hfosc_sel_out6", 0x686000, 0),
 	CLK_PLL("pllfrac2_ssmod_16fft_main_7_foutvcop_clk", "main_pll_hfosc_sel_out7", 0x687000, 0),
-- 
2.51.1

