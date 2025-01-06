Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549ADE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C2EB80137;
	Mon,  6 Jan 2025 10:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fSRymtxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D905801DE; Mon,  6 Jan 2025 10:06:51 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A1D8007D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3GMcZzGfA/RMyszhSSpVpi0xy8VDQsarZzAiqY20J/Ix6QU4IevQKqO67y5jOrNGGEc8Fq5vpcyhE9MyjU/FG6YCjcaFeyV9XtqWL0tq9czuiBEVCWFJ4hgDdR8f1Pi9gRs9tfkWhSCPDYuBlrLkHg9ckab/NzFXtrcAc/crqYIA0mJ6NEhV7/j8eNnCv6UJ/oyWOYasIpq19xVD8R+4XgWU7HBeYZN35MhjGOaPzx9Qh8X+11OCz875ufhw5msAh+N18dwZQtEggjJYQSPb8O4jMWEOfxnnNTMcJlP6JXA0kiTKMsinmipwealuc/XHqc6AgPVPpkfOXl3+P6pVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTp7C3YQ1uayQDcbQpu2+AM21lqRJOz075IcUDDWi78=;
 b=JRu5qnOMz+Z9M3HcpGV78Bdi3HQx2zl+VSN2uZVrQqE/8/TAv2fMg8hWjShvKrEEeHl0OKMTxuiHAT2pZ20L8t3mjQu3vh0LAHR29ufAHQhfW0cEBvsVHhg9Mw69m61ZAD+b7t2uaR/FMoZwUqVVro4BJ7QqpyrDxj1GYeXw6L2GyGAi9ajeSPlhTXbQwzf+31g7vZ5XjhY23/hA3qEepaczdG4uOgnGe+jwSiR/IH6MrV5bwPOUgT0nwxtFpbI8neB+yZo2J0H5qFl7Wj2XOcMcxWB43cqY1Rs9aT7zLx58aQwTxy2C3xPo55BiRFTMrQMrVOhxReY3VkkiKwCkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTp7C3YQ1uayQDcbQpu2+AM21lqRJOz075IcUDDWi78=;
 b=fSRymtxq3NutLMdy/NZ6sFoRq1GgOwGe/8FJ6XJ3Y43/YNTXaCmT+T97y+vvSrlOnCU9TimtGdm748w99UCjhwqDwfj5WKtIp8p5dq2yUdJyqFjwFgv7nwNSd04k8REBW7i/h/zvzCgmLs+3nGAMGO7FjnMD4iMms8s3ttbwZdg=
Received: from CH2PR07CA0061.namprd07.prod.outlook.com (2603:10b6:610:5b::35)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 09:06:41 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::1b) by CH2PR07CA0061.outlook.office365.com
 (2603:10b6:610:5b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 09:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 09:06:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 03:06:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 03:06:38 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 6 Jan 2025 03:06:37 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH v2] board: xilinx: Add missing prototype for set_dfu_alt_info
Date: Mon, 6 Jan 2025 14:36:30 +0530
Message-ID: <20250106090630.209938-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a9942f-8918-43b1-dcf4-08dd2e316ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TQHETUo2SJPwIQf3ND74RktZ4L/n+A6vwl0AycR1QF1QxO5aNVIptGB0MVVe?=
 =?us-ascii?Q?gPUZCUEOTVc5dRkh/oAy2Qp0Zo8e45MjBDM3kp4WuPA187SSjw8BllLLAsQu?=
 =?us-ascii?Q?GcUTVpiyZ8cIMqmliFr8Wcbh9WjdGifsAqiCzKeSR9jOnRhpRDZ9Kb6GwAz8?=
 =?us-ascii?Q?pIJOlfY1781iOBWo9gMHI4gAqrAeZ3EKRRI7cmzK2yLw0CIFyAe7NnGbTIma?=
 =?us-ascii?Q?125q84VvvSVIlyplS2CjnfZ96ArKp2tqwmKxolKnKO9Wy20Nytje59uEeU7i?=
 =?us-ascii?Q?3wtijHuc18WsqArzQBVxjIHY7rqpFU3J98G/JAL0OTo3TofJNJW8TNwaLuLq?=
 =?us-ascii?Q?MIdNqqshcu4PzcytOG/0gVzUMZP23jkEYgh5xgmhd79YlfwJQh4adlIzwRW/?=
 =?us-ascii?Q?VtsLcL1mAhcrZ6STGRaCRcYcU0sN+AqruN4kZqsIcPGqt3Zwthkj4/leMEpE?=
 =?us-ascii?Q?xZz8WCNqLPyh+8fWALy+uCWRvY8/CpqAUbvH/WCsovGXtmDg2KwM+gfKSU0H?=
 =?us-ascii?Q?0gA2gN/yVH6akxXh9Umv6Sfq76KcSp04jC4yAiuWwwuhw3Cd2aUfaEwzy1ge?=
 =?us-ascii?Q?xQ74LSAJkpDlPK410u4fVTll3HmEU5fmU3M2RYFhe/tI6HsQGNudb1mx1xKs?=
 =?us-ascii?Q?HxBV15G684MB6H0HYsEWhVDGNbcPVG7gpRuyvnusC5+DKAWlzxgnIvyZWndv?=
 =?us-ascii?Q?m7rchdmkuz4yE1Fn5OWBZjYWqoDWyNsU1bR3yVJ6RBkbpY7aLlT1StkmQYug?=
 =?us-ascii?Q?j0TeibLC6cF7/EvGodr+31znmdFqsdSciCC2iJOPBqEFhoO6FCJtdXIbyMOa?=
 =?us-ascii?Q?7vXoQLxfkCTRPPL98S7gEeiNsdDa1Uy9V2uYgGW+BE2AyjZI3EMEFs4qZ36U?=
 =?us-ascii?Q?mgfHhQWNUEGUwgGJXTXUFZGzQrbHDH17440Qath102pjKZ4jLpMl0MjYMjJy?=
 =?us-ascii?Q?OnKc65V1aA/T/944Brt5PhmPkUXjTJ0eU9ISACvAbM/EDX1aeDwosxCvxlv7?=
 =?us-ascii?Q?xrMJw7Jw9jr6kKHaYPkItDn2VyAshwcffWmt9VHWYnItSBGIXPLJoi1Qrwdn?=
 =?us-ascii?Q?5Ff3ZXVJtOMw6X1iJLuzGx5kR7rl/wVHdPUkUem5QbHDsPICYUJJBXxKm6nc?=
 =?us-ascii?Q?w1bZiCmVvlD/7qLikxLX0K+Ddr+ZW7MAK7yDC1ZfFtEATqyfC4+xD+B1to6a?=
 =?us-ascii?Q?yGHuNHYnLSylj66xbicgXkWL8qJ/Yq/fH6Hi3CarRNXDXTOA7J+SVJpG+U+I?=
 =?us-ascii?Q?U/1kikherPjYBa9d9kiuaTq0twSqN8pfVR0P80XaQcVCrPQ2283MN6xSS5CO?=
 =?us-ascii?Q?ZBhbyUILxj+R7l5vX7ba2C+kHqk6BVfttGOCfpapxae37TSvIOxzVNNfAx39?=
 =?us-ascii?Q?zE10oZLa948GLKFnj4mACMc0oJWwnJ939MoGSzpCrvRkoFb9GUCtT/ls+cWF?=
 =?us-ascii?Q?Na5yAb2ivrGfeP5j09Sr1Br8/fLtj6JQjzgwa7I2Ag7JYkHeO/+7WCJ3+553?=
 =?us-ascii?Q?gAfC59P6c6fIQCc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 09:06:40.3088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a9942f-8918-43b1-dcf4-08dd2e316ecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605
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

Add missing prototype to fix the sparse warning,
warning: no previous prototype for 'set_dfu_alt_info'
[-Wmissing-prototypes].

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Include dfu.h and remove the set_dfu_alt_info declaration from board.h.
---
 board/xilinx/versal/board.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index fd5c6ced79..c0477e6574 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -6,6 +6,7 @@
 
 #include <command.h>
 #include <cpu_func.h>
+#include <dfu.h>
 #include <env.h>
 #include <fdtdec.h>
 #include <init.h>
-- 
2.34.1

