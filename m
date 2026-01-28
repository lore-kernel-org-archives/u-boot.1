Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F4FD35661
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 00:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 989A58422D;
	Wed, 28 Jan 2026 01:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FQz40Xps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5CD484236; Wed, 28 Jan 2026 01:55:06 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BFCF8422D
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 01:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2UWiorlDh2ewXj9s1YhU7tmVl33HAyqiYvRESTH7tQjNdw3zYUzJTNLALEhUNXFmsh+LpK6B9kGB1sPaoomT28oT8D3XWQXxW3IQYRtdNF83ulwJS6Fsgj/Onky7+jLerhIpbxUcuq0GWjV8WAd6vKsV3BDSuZJ9dHcQcgFSGkj9MVXRPTBX2hUxVbWU50rIm2l5FirDeJ6DNF/vXzZH8aizN/Td3SGIpXc5GdPp4QC9JCIjIQU3dOuO60NMn5+OQ6PJYGIm1YF6DdBhnXw0BGQY1N8sb4UhZAotdi828jvVR332G97pgL1ASPMkHSx448mNeIQYb5jJZkhR9ttww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sjR+eSglwMKjRY0zwMLhD3OU9PcrppEBuH6qFZae1Y=;
 b=low9LR0aknYo9BVizJ7UKncIgW5efeWZ5NDdDYHaY2Zp5fbUsUqBMmZCBXrY9M99yqevqM7SlxD4CcU7AFruca90AR05Jm2ht3zMu4Tr+18rVZnYDOVDrdU9+QjZ5A0tRbYMEdLdSO7TtMQuUBRh/DUD2CmsBcovJX1Y+VJz3y6oqcfENEgdJdQvCtZuZUURB5SCW4I6cZjtHt6QYa0u5jk19zIM8rDX/ad66sDw4qpaKzY4hN5tG0P8hejxgCutDslQOsTUSIQzgp/lzmWjCgMXpX86A3PFxXwIymf5Wfb/qGWzaIupP5ObkzRIyYRL4NQY8kUEVlRphHi9hYqIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sjR+eSglwMKjRY0zwMLhD3OU9PcrppEBuH6qFZae1Y=;
 b=FQz40XpsfHDXVBAC75Al/0vCVmK3zmSnBr95/s2mBQ74pA6h47gQMdezmD3DCxXV3lPkgUrmAPyX90cYPsEFFWTvo9tPs/lRGE3cnZ6hQmx2cukSKd29N5xiEhS5LG6T6EoPsCUnCFv9eiwiaX5q0o3xGXCRPtCOZWDOq77FNdk=
Received: from MN0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:208:530::21)
 by IA1PR10MB6098.namprd10.prod.outlook.com (2603:10b6:208:3ad::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 00:55:02 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::84) by MN0PR02CA0001.outlook.office365.com
 (2603:10b6:208:530::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 00:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 00:55:00 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 18:55:00 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 18:55:00 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 18:55:00 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60S0sxJZ1448447;
 Tue, 27 Jan 2026 18:54:59 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <t-pratham@ti.com>, <nm@ti.com>, <v-singh1@ti.com>
Subject: [PATCH v2 1/1] arm: dts: k3-am62d-evm-binman: Fix device tree
 reference
Date: Wed, 28 Jan 2026 06:24:53 +0530
Message-ID: <20260128005453.1387483-2-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128005453.1387483-1-p-bhagat@ti.com>
References: <20260128005453.1387483-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA1PR10MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: df7864b4-8d41-415e-d3d7-08de5e07dd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iKepMcJF0zmivaVvUJ4s/rZ3F7ShIr6TB9UppkHqXi6qpkFxx2pbpEHgaz3j?=
 =?us-ascii?Q?lJ9kCnENiLb3Pa4PdG2hOTARiqBYxiXE7vUB5tr2bCqfIRzjTqvwh+AEaAAd?=
 =?us-ascii?Q?LRBKoYtCKKCBWhcKVN7l7D3NeaZ8D/qDAHBTNy82Z/fUvEhCm234B1zEaIrF?=
 =?us-ascii?Q?3gBOmsjyjR2oVXntezYm1iJhBNkrZvT4/dRzTDgjVy636fwElC16/+n+8p94?=
 =?us-ascii?Q?BOpuvlPrgh/UkdgkMKahMys4cF5UPsLE2UZphHY1+IHVrx0nkHpTawShLZu/?=
 =?us-ascii?Q?Q14tZnK3oTl3qluqq8SeVZ5qWIAxc0R+v+77PG0n0J/e2l9De9UAceaSB1xb?=
 =?us-ascii?Q?VBL5mHgDEAiASUSdesqIJUUIBN2YGtcZHsMctvL0TUKvLjGukXP1KWfVce8d?=
 =?us-ascii?Q?2SuVXxxwxOuUdj8gszZ/V8po99Rlxnt6lprS1jCLB+1N2T7VVlnqHhoJ3oy6?=
 =?us-ascii?Q?xtk3AjcdNQ536XKu8YJDqCAYqbJ7F1idlZEoeq7Xn2o3CMvyFOAvZ0HcDWgu?=
 =?us-ascii?Q?8sXA9sk32mfutjp1uJ8u0saiTUqITowozg0mvi8Qb9OVG33LEwGy0G09MQDP?=
 =?us-ascii?Q?uVscd2wLwaWatKBpres0LxNb7k1PdlyK/RdUvSWT9OiuQreyZP03D3VuY9Aj?=
 =?us-ascii?Q?hEE0hXe4NXyllygRHlSo2FFha588eSAUEF4MzuUtYsZhXL+BPgtNKWXTmVC/?=
 =?us-ascii?Q?Ofl5JxskcEBxjgNmsetWDpVhexYe9gqb8De+X5e95Z7HPIzXSABiSmw/HfHy?=
 =?us-ascii?Q?JXW5eaUJZlS1QaRDrGvBy3rMajHbPUM80SQh4o0Vjsuxv+Sut5HDYqr8PxO8?=
 =?us-ascii?Q?WXAEAoeb2JbN2LShPd+drNQ4hOpiDHfPDjpskpYSaPBR0eSnzeCbRioi/pdN?=
 =?us-ascii?Q?kPwvvLxJbmMsvx94Dt6a01DF41O1GmripWh7blhU011IijSGdnuHs4USamuH?=
 =?us-ascii?Q?V7h6Pv4qGd9sxWoL2CLqADh1VIiLI2WNq//GjM2dBA6yajsMAdvgRLxQzHbx?=
 =?us-ascii?Q?3R2MWZZLuwjop2V4Daemka9KBmT/uEpAMOOvkeOW8qqWthBGqUoS/1Or/rBp?=
 =?us-ascii?Q?3MKFEAonetelD/f9E/vAA13uyWVxnHDPlyzmOifa/elne1S6VS4B3lru386f?=
 =?us-ascii?Q?XcoJWBKrt1egADUxbk1Vf+kgyi3jGqWrBdodhufWQqup9eCYQE3Ad5j9G5KE?=
 =?us-ascii?Q?0mYHdWpxZs1Pf4tEOfI1xlZu0VkBHFhrM/voYPijQDmUp3H8NnkkasMDG/MZ?=
 =?us-ascii?Q?vKb7l9Ko/YAiABRxWpXl7tkA/w9PNI/KfqG5OcV5wJW0ChI3O2zpnvieA1to?=
 =?us-ascii?Q?8jvS58bTMiZBEM1Q5FUjjia36iUzY6NHUyZGnxU3s6qw/N41UCpYwF/sQOxy?=
 =?us-ascii?Q?N+yofpCuhhIAYMjz8UNDO7xshjeoyC6tBsTbkZLnE+BNJAdffpvFcEpjJNwV?=
 =?us-ascii?Q?ZF7zJ+2Cm4AH4y2iJtJpPDRhs4UOJaeogR5ztL+9OXBz1BsLkgjmEUDjCgdM?=
 =?us-ascii?Q?XE4U9IhCHk44BOZkrcRugokZDQGzyecMYuq/JlRUWDuw4DHHjGHoMn7R//Y9?=
 =?us-ascii?Q?9tGCR7mHqZHhWMB3XepbcRdZUIGrGgVhuAmx4q1VKRxEc1UhCqA+z+vlVwC6?=
 =?us-ascii?Q?3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 00:55:00.6967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7864b4-8d41-415e-d3d7-08de5e07dd90
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6098
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

Fix ti-secure content reference from spl_am62a7_sk_dtb to
spl_am62d2_evm_dtb or AM62d dtb. Also remove redundant k3-binman.dtsi
include.

Fixes: 14dfa6b86187 ("Add initial support for AM62D2-EVM")
Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/dts/k3-am62d-evm-binman.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62d-evm-binman.dtsi
index 3a0ab9f8b2b..41c8746cf08 100644
--- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
+++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
@@ -3,7 +3,6 @@
  * Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include "k3-binman.dtsi"
 #include "k3-am62a-sk-binman.dtsi"
 
 #ifdef CONFIG_TARGET_AM62D2_R5_EVM
@@ -72,7 +71,7 @@
 	description = "k3-am62d2-evm";
 
 	ti-secure {
-		content = <&spl_am62a7_sk_dtb>;
+		content = <&spl_am62d2_evm_dtb>;
 		keyfile = "custMpk.pem";
 	};
 
-- 
2.34.1

