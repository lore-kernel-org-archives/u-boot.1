Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8921BD1D461
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D25AE8423F;
	Thu,  8 Jan 2026 15:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wllOhkeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E78841CD; Thu,  8 Jan 2026 15:37:25 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B864184221
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjmJztTOHCiIjUluEQzrkdi6rRbjf66B5VKBVf8GGAcm05oUpacbneV+vS5OIbYQ7DS8pMB8xorXbrdhsEQ6d9ZnFCCBTLGXMVhUbr7kwhWdeNaRF+dilZIC0ixPSIIz8XoQOdC7PKaxO/yHz2NxXaaIngUQez0A07mGv4umOzivR2U5NYA/gX3QOR+oyjYQUx+X8msgBOKgBIt/m+pRcZJIi6Tr/i42zI0s6r6UYmrpv7DGOvCUvUwA7/TjMkJlqqn10P3Ewot0iZiCqO23zvnYNsZFctaIYqxE1zWy1OrC8ri+hj9FhujFIbR7m7ues6bi+evXFKVWHsp84EzjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpc7n0CIJgCV7R80onxoFPNPPf4rwmQBvGFhEcB7zDo=;
 b=Q1KJAjRoKQXxFu0kAMnRaxQDyAwKSYOgoiIHnZexGoW3l+yg0jqvoFM3fo4GNUOL9oDTwHDYSY6q52Q6pO82hsddUryR47jHOGEhuU29bYz6VP9tCH0xrpKRHhJUJJso4GLutXCpXYLWHJfwqFZEqCWVhYZsUk02i0jaPtI3+tA8OURNmPXWPVp5iYXs1vlAg1knG5ldBJdwFGzU0xXQ6BudoS+pshga9GfNv2R6Q37NhkngIj+HPSSjjyjzftI64Lcl0sHqDtdOStvpjCLZBbRnzNzIgxeEsoiUftKiASaqGTf4UK74HEabGtwE0sqYiJWiVbrPCgYzU9q/FZjS0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpc7n0CIJgCV7R80onxoFPNPPf4rwmQBvGFhEcB7zDo=;
 b=wllOhkeJ3O3yzkh9IWxOJJYVJaRa63JJNBBiPazI58XdkqXfAUn3pvLPSJb1AhWwRjSs1hIr3GiqQouFJ95fSCF/VBTac/muAUy6VJbMnZ49s2lXA5K9dAt2s47zskXIXXq79i3A7cDUSvfjPrtv4sOdlcBK+F8jlvhX6mXDm3k=
Received: from SN6PR16CA0060.namprd16.prod.outlook.com (2603:10b6:805:ca::37)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:37:19 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::66) by SN6PR16CA0060.outlook.office365.com
 (2603:10b6:805:ca::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:37:17 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:37:14 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:37:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 08:37:14 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608EbEVj2521105;
 Thu, 8 Jan 2026 08:37:14 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 4/4] board: ti: am62px: Enable 32k crystal on the board
Date: Thu, 8 Jan 2026 08:37:13 -0600
Message-ID: <20260108143713.1130054-5-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108143713.1130054-1-vishalm@ti.com>
References: <20260108143713.1130054-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ec30a0-6548-412e-1b39-08de4ec36c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|34020700016|82310400026|36860700013|34070700014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?78ZSDLkmCAyPwWHDJjwG67gstXlx2OYtKTnKr7ELbAq0FO3gmzjBwqeIB+g0?=
 =?us-ascii?Q?1nlSIxt/pHxblJ114DVCmMzeTwZzYSJt14G3LJ2wcgAcxReofoTnZSoe1HUc?=
 =?us-ascii?Q?i633N4B+4suqffSooC7Pr5Rgrqu0xpX1MuN3Oaac7Ze2GR5UK23VPs5+EJWw?=
 =?us-ascii?Q?5wEG7nuGvrX3JdKXryUovctj6sGiP3Tviv0LeEhga319TFlGUH0+r/ldfm4w?=
 =?us-ascii?Q?JoCIyVLa9wuXjlI4ZvqJcmoJ+y7FpnEK4DP0nVqdgb/mxsu+pofEpyfI9lqG?=
 =?us-ascii?Q?rHn5DgolnkhwCLLPzX4ZkB0AQuA53REORuUPuup0N3X3iOhb8jw0l6Z6LPfu?=
 =?us-ascii?Q?XSCcrXe9ddW0lO/AUYs2cY2trBv+8dixku+xreWvqnGBN21ZZGPNXU/dqS3n?=
 =?us-ascii?Q?dMNJDVxL/R5huDJ3GxMlQonXAYre7DcHc1q4POY0n5b/MXY74H7bqLzKSSsM?=
 =?us-ascii?Q?EaWxdB2TLyEFwodbK7n9/P3nACXTKexEyNJbuP9aRcY+vGzNDijMpZLFHUst?=
 =?us-ascii?Q?gbh7z2CxCzSFGKePACD8BfQhnL0ivX2YBsmFr9jgw/bovDR1MIxH5Ck8kHtO?=
 =?us-ascii?Q?5UVA+7h4L/Wmaz27aQfWlYr+4gA7jENqjpECCd2GjRsTLABUo/+mxobBvRnk?=
 =?us-ascii?Q?y7pisLrUPS7OKkIwP5PGdShmbUl/KIzYDMODhv7t7cVXxtnC2MPHolqIZwPL?=
 =?us-ascii?Q?nptbIA/VCHPDxrHN1bkn7HQjT8OPFriM9npafuGbzH3YXJ95PIOBvsHzaKgQ?=
 =?us-ascii?Q?9EjlLPb7ITkQbhQ73gmEg2NFA/O8sQb7dlvmmZv+SYZdVFQ+UtJsc7X8BDzH?=
 =?us-ascii?Q?gReFzMFGdgOTRMBa5jqqQ8FG3ocDWkfaQ3CwuCdipFKb2PlBAR95bbYaeU4Q?=
 =?us-ascii?Q?Cd2sTE06nvat1b2SKbV6n83/8aoydApGpGpGp2PgA5vLZlNW/q8Y+HL9TuPs?=
 =?us-ascii?Q?5mx+GTTM8X+zYdoVMnlZD28TES4Zek3KL+i3MRh0N3bEclCsuZWA/9MxoPDr?=
 =?us-ascii?Q?khjR3lelNXU6cdassJGFM0udCLXEZxLDgQ0I+cXyvNKHDLa6u4Yh5wF994yo?=
 =?us-ascii?Q?qmwi+MLyArYCofbe09JcbkraQv9KmF/oXL/3A3/FrYG3ztV/FJqAX0T/7ae2?=
 =?us-ascii?Q?fojy6ijqf8iFdWAe3Ox9xys+qMgmP+Lv+aegA/yRCxrW5Q0fL2JPIr//unue?=
 =?us-ascii?Q?A2MLtmCmnFaipxHZyBXNrQ7hOgi5cc5gaFFc77ur4MIXhDbA8ZChk2JOspOb?=
 =?us-ascii?Q?otirJwTFQSS/8PqJW+cFHWfdXO5sbKHJb1SdYYs54413HCt5ei/Yg/XAFeLC?=
 =?us-ascii?Q?ONu7yyYafG/n/EK5Ner5hVp7zm6GNQ1j0QaO3Fs5gKl5mftdYDnXvmo37H48?=
 =?us-ascii?Q?O778wfLCP4xBMTvWi1jcg3zUjvsRj1KuIGuGY0SOtJB0wjwxK3HThqQKPsxM?=
 =?us-ascii?Q?2pwT07r18wxygthy2g9bHL4N8x2rQLybPgVsGm6Vxzv/5BViLJSqGnrGJtIR?=
 =?us-ascii?Q?IpOtwptH9rBv7ZLsfvjzGVwWMw0D9U+/fbaTD8c3mBa23Bnp0emyl7+tDsHq?=
 =?us-ascii?Q?k8t3zuTOaF/Du+HE3xw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(34020700016)(82310400026)(36860700013)(34070700014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:37:17.3406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ec30a0-6548-412e-1b39-08de4ec36c2e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
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

Enable 32k crystal on the board. If external 32k source is not
used, 32k rc-osc comes into play, which is accurate to +-20%.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62px/evm.c           | 4 ++++
 configs/am62px_evm_r5_defconfig | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
index 85c332b9339..8fde47fb1be 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -16,6 +16,7 @@
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
 #include "../common/fdt_ops.h"
+#include "../common/k3_32k_lfosc.h"
 
 struct efi_fw_image fw_images[] = {
 	{
@@ -45,6 +46,9 @@ struct efi_capsule_update_info update_info = {
 #if IS_ENABLED(CONFIG_SPL_BUILD)
 void spl_board_init(void)
 {
+	if (IS_ENABLED(CONFIG_TI_K3_BOARD_LFOSC))
+		enable_32k_lfosc();
+
 	enable_caches();
 }
 #endif
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index 48ee2aad8f4..02f358d35de 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -121,3 +121,5 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_TI_K3_BOARD_LFOSC=y
-- 
2.34.1

