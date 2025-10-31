Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ED1CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A36D8391E;
	Fri, 31 Oct 2025 16:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XXqoXX4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7839183927; Fri, 31 Oct 2025 16:00:30 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ADA8836F0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TV8MbjaTq/2THtt+rSxvMUJXtE87D/Ip/9rTigQFBiduAV57SZhf0Ih974VjkmAeqV2WNB3vAvulR4phcnRy+twVvWyexyVPbgI67ImFXzN+CFPXPe1AI7m/mpSKUHT1Dwij3+dxdTFvfgatIbi3GztxuRToBipmWackphrvwwjgz3gouI5NKWQZSKjPlzHH5XnL1qC1EggLZjcbOFLuL+F1f9l0KyfTMY2mO3kq8nIV8F09ZPOEGxme2n6COi3RGRMtzApen8m6BGl9Xh0duK2CVV084JezamURVfwr7ac2ZiBEpGbFI0NgpQZ3m6BC+3NywD6uETwWQEh5tEjbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9BBl/HlKuhgcyiRocsRTJrIq+iu4GCFLe7M3oBgeSc=;
 b=UhR65H28XQGX6/gvyS+7gZKIFk/9LW7Q6YyuzswcBICd3pFIaAScUUA3ZUzoXFP8K1bdAMKV9onhd4UFlQ1YH7kNLcKStZO6pCfoidS57miSydaT6WkfXJp/u/YwkeCAbRe4kuL/ac9V2D28DWTOSIyat0ynjUis3qI4MpbTNrG2kXaIObBgCcepz05tNiODyCV9Rbq/YheqENUvr5CRduWwO2remwNHkPi3eK+j7GEyq6oUNUmH9zi2K4Iupv9IGUE9HVcKOsrhD48TwHQtP1CphBJsVAnAoNThvNUi7AdPKdC6BlQfJrK48YY2aEF8FetmkvTHfFVYFko/+M5dSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9BBl/HlKuhgcyiRocsRTJrIq+iu4GCFLe7M3oBgeSc=;
 b=XXqoXX4BXgdCfM5A/Tm/N+fOZBcdR8Ayb/7gHocwmQFlUU6uH20fHG4kTpo9IcvxoMenz2ml3WzfL4AWc4Rnq7BMrlRC0FtweUqZH4RJ9Eh2Jrndixbl9zNz1djIRdsd2fHfHuyKLuoQZzNHB4x15pGN206eizX/8yW7rbxS0shqhCFlc7t6A9eOHPHxQaotQnP2za4Qa2o/Y9qBTZVsey1Urcxf3woM/s24LRX6cGQCHVWDG2ZPTgH9jR7zoTz0YozBa4mxGjj1e88KkjcnoVP6xbwd0E3yEZiKlgJbEjBqaecWjN6aVP7Ai1X3lql/fiMoCmva0OiKvJwFCqhf2g==
Received: from AS4P195CA0018.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::15)
 by DU0P195MB1724.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 15:00:26 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::f1) by AS4P195CA0018.outlook.office365.com
 (2603:10a6:20b:5d6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 15:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 15:00:25 +0000
Received: from llp-stoidner.fritz.box (172.25.39.157) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 31 Oct
 2025 16:00:24 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Date: Fri, 31 Oct 2025 15:59:51 +0100
Message-ID: <20251031145951.535376-1-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.157]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A798:EE_|DU0P195MB1724:EE_
X-MS-Office365-Filtering-Correlation-Id: f47f9634-a45b-43ed-03ed-08de188e38d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tvh/RcuIiy1YyX3QIuhMJPEk5fZk930cp5zlaLT5A7qj/gh1YBIaXFjlZv8g?=
 =?us-ascii?Q?E0A7c3OB684AbXwvCORVtQMVq/I8nmM76sSYQ01hWEHqwwEvs0LpXs6Hjs1d?=
 =?us-ascii?Q?cyqwuGJKbxUvsKY8Q4Of1feVGh3AVE4hl3p+vuaxR6gpMtbEs1twPkh8Rgq5?=
 =?us-ascii?Q?+BLMyGT9nig9eX6CYQsnuKF6DQr2GU0RI9aaS5mJ6cgpl+ky4T4AoZCJdArg?=
 =?us-ascii?Q?NNbX0Myd8jW5IVlAjM9jJL/9g2eTW0GlRFowhxUblkT9f26kBgBTdNzsGO1X?=
 =?us-ascii?Q?9nSsUaTyktbIP/pA2NPAQnCiIsonlvc4zeaLi1k7x0ZN5iC6UssrNzXJ4WHy?=
 =?us-ascii?Q?avLiDwjbJtWuBeO8FC19PZynqtN4gfnX8zL6zqxybtbKcKaYLGMH/TUhiwy+?=
 =?us-ascii?Q?91yfvI53OZ70C890Ec7ud9EbO71930dNJCmUj5iI26XBMBC3eRLk4Z+S2qo2?=
 =?us-ascii?Q?5C1BtrXYV55HsVUpJ295mBBgxyZ2Ti4cJFOqYAljoM0PsATo6OKtqa1Wk1ay?=
 =?us-ascii?Q?FPp4pcwzofbMN0ZkLVQYxsp9o8onS8NPlAfAYCe/eWV67DeYM4pjMpMcNmF+?=
 =?us-ascii?Q?Y0kJE6VEdhveIjgDufMaNWJAKEvh02LOP7XswIMcHKBrCo2ZwEqMreUZEaAC?=
 =?us-ascii?Q?ppXrSQ1SafwoAQRcbfSEWCHS+oeEbjTYdQhKkdgCDD/INffjQ1THrHf7gJqa?=
 =?us-ascii?Q?E1766ZyuEsBDP3ahBaSuN5cZoL2nahmnet9EdOaotxtQZ/mXf8/XxX8/fPQb?=
 =?us-ascii?Q?GlEdNIg6wf54oChO/xtMy9Ho5laPF2YUl0keuWCjrm6dBiw2wbynQcwq7Jtd?=
 =?us-ascii?Q?Y3RkUfNKsUoSWctfl4PhLgRo9OVa88DN087FfhfYrqSGmRzoJ9CsxkWI09ha?=
 =?us-ascii?Q?Ef4ws6xhjhSRrtyESxIYE18E91ZeGqQbYGGyj/kITqCHzEoFBN42C8I9jNXD?=
 =?us-ascii?Q?dyONoODkKN0QFTHby9yB/a09h6qw285IyGGwEPVG6rn7vSbjrWC6h2liJcvK?=
 =?us-ascii?Q?EYIiAd2tNO5SrrILoI2c0e987QpEUcCJFpYtHoNMebk6ZDfjyWyaW6RTDLAx?=
 =?us-ascii?Q?+loOahCLaKG2jc9hnj99/C65CbQaUYqkQuK3sZr1ESOyM3dif0UMSKZeN2c7?=
 =?us-ascii?Q?HyVvGBPrxLPaTg+f9vHc+ze2Qe9oFwu1Bf3R74kPB0l8KwFqEKRnk74P+JQT?=
 =?us-ascii?Q?6ysaaDmpHL06y6oPkCQ7ig09djjAIuhkEg7YJKgEgF0MgMelfDh6cFVjCxXC?=
 =?us-ascii?Q?lS1uM43d4w34QVt9r9hN6hxdeO+LZiE9K/eaEpBqhz87Z/JmWZrKf2SFIvzb?=
 =?us-ascii?Q?z4zPTBOaEZtOAEVne3Dto89P+/RtLceI8IOa3d3ig5pAlduNHxkWXLgeSe8j?=
 =?us-ascii?Q?aUT/YiDd+LcTkBPhR+xIBLkgT2tIrRbI1DImyqnPbuHwpbRkuLaQAx2MctOX?=
 =?us-ascii?Q?w82uKh9YI4MmDHJjLH8ha5yGzUfwvAZSZOEO11YezzQrlJtGMCbkpK2++yHC?=
 =?us-ascii?Q?RYxuC0ZkjPYZ1Qe2KG+dKlWbw6PtwH+tagig3pfn8We0Dqh4jgklK52wru5i?=
 =?us-ascii?Q?LAol+kN2mzMxYWLgyBw=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 15:00:25.0668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47f9634-a45b-43ed-03ed-08de188e38d5
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1724
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

mmc/sd specification requires a 1 ms delay (stable supply voltage)
after vdd was enabled and before issuing first command.

For most sdcard/soc combinations, the missing delay seems to be not a
problem because the processing time between enabling vdd and the first
command is often hundreds of microseconds or more. However, in our
specific case, some sdcards were not detected by u-boot:
* soc: NXP i.MX 93
* sdcards: SanDisk Ultra, 64GB micro SDXC 1,
           MediaRange, 8GB, SDHC
* measured time between vdd and first command: approx. 784us
* symptom: both sdcards did not respond at all to first commands,
           u-boot mmc subsystem ran into timeout and stops to
           initialize the cards

Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/mmc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index ec61ed92e86..2093d169094 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2878,11 +2878,18 @@ static int mmc_power_cycle(struct mmc *mmc)
 		return ret;
 
 	/*
-	 * SD spec recommends at least 1ms of delay. Let's wait for 2ms
-	 * to be on the safer side.
+	 * SD spec recommends at least 1ms of 'power on' delay.
+	 * Let's wait for 2ms to be on the safer side.
 	 */
 	udelay(2000);
-	return mmc_power_on(mmc);
+	ret = mmc_power_on(mmc);
+
+	/*
+	 * SD spec recommends at least 1ms of 'stable supply voltage' delay.
+	 * Let's wait for 2ms to be on the safer side.
+	 */
+	udelay(2000);
+	return ret;
 }
 
 int mmc_get_op_cond(struct mmc *mmc, bool quiet)
-- 
2.43.0

