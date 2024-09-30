Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7CCCE8356
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 14:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE3288DA9;
	Mon, 30 Sep 2024 16:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PYpXgZRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DFE88DE6; Mon, 30 Sep 2024 16:57:45 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0F2A88D86
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 16:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE/hfl5mfEJKZv2wdv2j1HrxV8mS1JY06TuYWZvP+hkTWpae76G4SR4awB/zMe2MO/dxJhTCe+xkVZpV0eFYzepu8mQQAaSrgowrFnsNzt+qa1ojKnoCzQgKAs9+enJKuCnD5u+wBFZDN5f3+5MEI6VH09FtWao3u91cjQ81868qrUPRHcQONn00wWETTocdG44XmjTsytksxZlGGBt8LyOHtM7NwPXbUBwQp/Jcoc+AweISLUCiShCtmVTxTefs5mElchEXvsxJPV6UOkcgAG57gnp0DLHiS37LkiV3Y5X3/6H69wXotnAplTI22XLpoOAmgsjzHTqW0u0qkKBgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFNtj+tbzQSjGfb7DN0oQIWaofXRYOp5/tEhudMH8xQ=;
 b=nm2H7XWBdbHcyhuNzgk3i0yrYovVLYoWpnF5O5uHJW5pX0kLzHZf6f+aG6RfEIbSP7QDEFR4Yd0YOgIMQopQ1wjR/zAP+4jhpYnGYLscIatRzyWgFAQWY8bgXthpKGiHVKE770Rdah+ZSqGk25S1WKVYlkTrgvn6tRl5gYli4uIMZl4qOi/MZJ6F5s9UDs4ZuprFVxofEwc1To+R1bZPHgd0h2W0jp7Zn/yCweColaQJqJx0e4BcuzfB73kWXfkWMx9ComiCrINFEsmxC63Gez3A4v28Krv+r0PI6qXj3PqUDnx+anBf9clNjJv5bVmR1Rbc4aWVCrCmmJflraJv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFNtj+tbzQSjGfb7DN0oQIWaofXRYOp5/tEhudMH8xQ=;
 b=PYpXgZRd1uO5FNSbSjvVAYZX5amXxiImVq+y5f56IlB2fnEp7Zq5Ao7LC5e0lfDZBOTb1XOvhvelPgQYlrClhZwNjeKd6ZmqPJI4MoHIeS6PyW24Oqsf3zjgF+uzifp/qKxz1l0J9GpWxmGLn/sOA6tpIXZ7g50Rxgg0E42utwo=
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Mon, 30 Sep
 2024 14:57:35 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::bd) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 14:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 14:57:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 09:57:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 09:55:25 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 09:55:23 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH] xilinx: common: fix board_late_init() for Microblaze
Date: Mon, 30 Sep 2024 20:25:16 +0530
Message-ID: <20240930145516.755826-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: f6160b64-32b2-4b25-b0e2-08dce16037ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wkrjKvN4qY0MtuK09TG6mD//5TcRsyO16l0Q7ONMy7s4Wt8Bp1Q2WsnV/Shm?=
 =?us-ascii?Q?88ytZYr8koVXHg62PJNXK30YYw40ZBtXWz9FUfAa59EZLx8VKZu5iylTE56y?=
 =?us-ascii?Q?q0fePJFMlnoshVvxj46Abq514urvfXvONbfxFfVFCC/ow2snTvf4n7pxt8zi?=
 =?us-ascii?Q?hr/jRYrPtFJ32qYeAsw3HYCYdkKHx3wf6wW1CRx0+oauEBztYWenCcb1afg/?=
 =?us-ascii?Q?xUaZtrKch3RfK5R3URDFIHZyJXSjBX9YEtRhiJfDW8XpcaOjNyiE0m4ZzOcZ?=
 =?us-ascii?Q?Z1LzzJdMnlG+H2SnmAaYaTMCLAWPe+wce4krD7zY9z3O9vft090dsUoTim5e?=
 =?us-ascii?Q?UDnNmgrb4AS56M2vHt4Efv7g2YBqHRBE9TdvxIrZhEm/CRqT06N0bCk59bxa?=
 =?us-ascii?Q?oKMsv7yI+fdsgOiBv64Z4uI+mJbEcmACAwjeBPj3YYEHc/70xBYqP8e2/ddH?=
 =?us-ascii?Q?ENKtatXFiYzdHN0C5ad0FKu3HeRBopF4tlr2fW+UqGQGE8B0xR5H+1aXXXnz?=
 =?us-ascii?Q?Y/R/4c/TRusRwInJwOz1MJ0xUoJYKe/1pibEo/aY9zG26YvGKUKrNzwIr4qW?=
 =?us-ascii?Q?3WE/HluqREY+E5tttaZX3H9bqGJkn885Ih4ASReDVOpZBr9+jGQ4Hm51plZG?=
 =?us-ascii?Q?/IjC+RJrZekD8nugPGAwIXo8OSJ8K+E/JoqAzaX40/BKC5GVOmFpM3xZyjV1?=
 =?us-ascii?Q?ttRSC31CSpEUxw5/DKoLCcGn95J5LRu6TIDI1Dz/DFd/k4euAvxc6FFATIAc?=
 =?us-ascii?Q?gV5pXcYBo2/P86OU6rsYcuA7D6/0k2ZPAIVMCcLpSm9eEO2D7hB63jWQyjdQ?=
 =?us-ascii?Q?sXV98NAQxYr/u9eos1enP2T3EzzUCr5LjF56ptWYsCf1yPHn/dMum6eKmr8B?=
 =?us-ascii?Q?xUbqv6kuGYTc5Ltjut9es6a35IvluhpVmHomijZRNkLu1poB381RgPkW+pNU?=
 =?us-ascii?Q?Nplg7MPzcIgQr5zh6mOfkwHlRWNhIyj+U1ajMIK7nEwCkiEZNhJ2mlnjE1pF?=
 =?us-ascii?Q?Iy2elgiKwCRBX9b8BoPXGrazbR4USvZVGpHufG70I7HD0imzjb6kQrLUEM1q?=
 =?us-ascii?Q?+q9iWi+sscbCDJlfkYs9evkh/3cowWC83Gnn9/H1kNBqyurPn4A9ub4iSxNg?=
 =?us-ascii?Q?V+xlfMra6+oyySYIdDnm6SQ4s3mTF+E0zP7B5fgaPrM+54WqyOEL8JbJqNw8?=
 =?us-ascii?Q?Ci0a0dBXiMCaPnbITtndygg9mEu6ZaUD6MWB02etAj7PrC2gyTEaX39CCAOv?=
 =?us-ascii?Q?42Dd1JMpWtmotEocSqIiwqcyUCba+5rRUdgromoo0nQaA1yvDf24gUHW8r1w?=
 =?us-ascii?Q?G6GL+MN1hheIyrW89QbjofhYowkm4AE0XZAKqC30ce1rEXVPjTT+uZilWQJH?=
 =?us-ascii?Q?Sf1nnoO3derPULssd42pKgWAnok2g9mOmu9bAbpYoCoQ8KwkfDM1nLRTF+19?=
 =?us-ascii?Q?Qzyycx0huG0UXXDaNTpKQc1hxxw3a1Z4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 14:57:34.9795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6160b64-32b2-4b25-b0e2-08dce16037ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
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

Fix the issue introduced by commit 067e0294806e
("board: xilinx: Remove conditional check for Microblaze").
The scriptaddr should be physical location not really offset
from start of DDR. It is assigned initially with offset.
When U-Boot is not found boot.scr script address in device tree,
then it is calculated based on offset and ram base address for
Microblaze in board_late_init_xilinx() function.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/xilinx/microblaze-generic/microblaze-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/xilinx/microblaze-generic/microblaze-generic.c b/board/xilinx/microblaze-generic/microblaze-generic.c
index 2b035d5358..356b247aec 100644
--- a/board/xilinx/microblaze-generic/microblaze-generic.c
+++ b/board/xilinx/microblaze-generic/microblaze-generic.c
@@ -56,6 +56,7 @@ int board_late_init(void)
 
 	max_size = gd->start_addr_sp - CONFIG_STACK_SIZE;
 	max_size = round_down(max_size, SZ_16M);
+	max_size -= gd->ram_base;
 
 	status |= env_set_hex("scriptaddr", max_size + SZ_2M);
 
-- 
2.25.1

