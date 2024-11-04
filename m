Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD4FD132B8
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C005D88C9C;
	Mon,  4 Nov 2024 13:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2XdaY42b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E374A88CBA; Mon,  4 Nov 2024 13:28:06 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94BE688009
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 13:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlBAgg9f33uWrLlehjEkAM7EZ7apRZ9FajDTAG+o3LiIM+yxx7HfBb5hAQRYaAxVGQq/9nKeimzCoD5V8ovcatey6FxQhTh8lIqQFgmxZt+y3Ijh8w+g/rNdZM3iXwpgRwx/YvzSctGqENIWEp1K7E7xFcuIfisBrURPXv9T0c7YNLNCahuwvCFJfWAiRuI+ihnoW6OliwHD6i54zT+BOlHBgxaseGEwsqUZ3aKoc4qK9Dr7oEveIMU4EUETGCT5tGHALjXNCliLLZVTUX5WzNTLyMQMzjBoxU3nvzwN/JSxDHrmaPJtE8NSRhomYWAi+CaZdTOrPFMMEyGe2H8x6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddmGuvEOjRSklNv1sZ5Y3A9+mtSNMSWtJBnBgDAqAbc=;
 b=nToDmdKtBt/imP6FImMYajXKkCPxUrSgNaPJ+PQ2O1DiYBMrRhPiSBz8eZ5rwJaMikghnGqvF/Qi70lvF/mp+NLKgHDdnvmzOVcIMgaX8E9aLcn6QEpF33EAs5fNWuayXEWhXiu8Pc6wH/frXHwsQiKPIZash4WTLlr6qWVh0k/JlWvhdkiUyvBkCuAhEr8CghAfiGny1e0z+iReRJVXmv/T3c77mBzeGSmKP7Z9rVefMgsOfZTgJ8SCITjiQhbDfu2r3/agJgqSTfYTHsnN5/7ZBCOCgG7Q9gZn/WnnslZ3BLT8Nv8l3xocek/UjYD8GFCTOPpGYDu+Dt50Eh5nsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddmGuvEOjRSklNv1sZ5Y3A9+mtSNMSWtJBnBgDAqAbc=;
 b=2XdaY42bevfPpoZcw8ROFMDRQrhmMBCEYDtcMxt0caSiAoWPb3pQ8R6Z/KCXAjkPXsqVtZxuPpakIVRS0BznTwoUYrndCW+6AdZQbmTFjLeUSBypFSs/9Q2XSPp5xfGqKIuAnL6CJ8+dHTDqAA0DHTE348NsufWWMCxYjL2Ys74=
Received: from PH7P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::10)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 12:28:01 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::35) by PH7P221CA0042.outlook.office365.com
 (2603:10b6:510:33c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 12:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 12:28:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 06:27:59 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 06:27:58 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 4 Nov 2024 06:27:56 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH] arm64: zynqmp: Fix r5 mode for cpu release command
Date: Mon, 4 Nov 2024 17:57:50 +0530
Message-ID: <20241104122750.96251-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b85805-e205-4591-0421-08dcfccc1f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E5ioI6c6Y0ae/Ba3zVWbOBcmTy1uZneMpzAIHPtuwG1a/XrxZnOcOoe0xvAg?=
 =?us-ascii?Q?Mkck+e8qciQs9KurBiqTF9vi9S3lhYbMJDwVHUh8j0lipaOFFOBeFQa85x2T?=
 =?us-ascii?Q?glsfPOO6tgsbSDWy3OEuOmHgkmMH2NmITM6jt7s2MDwBPl6vcOHKJUIlU22d?=
 =?us-ascii?Q?cItUZ8SdkbrE5K6LKPNnBrzaloTobzO8WJrovqgofScIkbJIrz3y7B05vXMy?=
 =?us-ascii?Q?+UuubHFIn/IeXn9VX9i93Tx+tM+n3t3B67TUvKPMwB5EghtAyNKtb/WHKBPL?=
 =?us-ascii?Q?BfRHM3BGKGVHHBzOXGYreyw2vm2mq8x5Z/r/AXfJoj66tN62Kpl0wZgcC9gq?=
 =?us-ascii?Q?56WnN5nD9gBzRfREYZe79bPyLH5NNdQdoL3ZOMsJjZLy7UYMBHdRRvcT3GLQ?=
 =?us-ascii?Q?dx4c2yNGE/SinosjQix+vzH7zbWP7wT7OH4JV/a+alD8i+RREWrx7kU98u1y?=
 =?us-ascii?Q?OR9iBg8vudK9LZmh2liCC4E1Li2fpVTMzcn3ewLi6Bx6L/xkvz/ZQ8sAhsr9?=
 =?us-ascii?Q?xkTPKCPEieVUgLejxuf2rqZC0JvxO+GuUP98s4oGJqFgEEnVoeqybTCm7x9X?=
 =?us-ascii?Q?Aw+ru6zeyAOmq1W+MGUAAqhVc0y2X7gP6Bbxi/ApSIXICK5z6B/ENCuUwbgq?=
 =?us-ascii?Q?ZuBkXxnlZ0CZ0o3NWgs9asITK2YFM8gTxhwtmv7IpwsU2WWLSeAEPMJf5EcA?=
 =?us-ascii?Q?dgBBzZIYVU1bzYJjTChc9u1y3hq1KggvUwDOmBIUmvrDf7XoQV/Z/oZo8xwr?=
 =?us-ascii?Q?zOznc4vdjn6Yl5EKa4F+YlDPlQA7y7T2Nd7pktLK8B3ztjfgHLQF/qTirq5u?=
 =?us-ascii?Q?xjclfpViM/E2O0Ty5jz8sGVWNX7T5XigFpFCdCmGJI4srPggP9k4ck71+YLp?=
 =?us-ascii?Q?0gkBiglGk0z0PC8YVFZlHR/bGchJ3yvOxHJWWWxboLovjofqV68aufnTkoli?=
 =?us-ascii?Q?Bu8hmmaNiE9Rr/sZ0yYyGYgG+Q560GuMRDEn9rl5iPWb1sVdxctFODJUNkop?=
 =?us-ascii?Q?krw2Y+rrU5H34/6235ATgyxc2Bu34b46mE5T9aZNZdtRD0l7NFMmyhp9Y+CW?=
 =?us-ascii?Q?KzgPEEElQTCKMsNSWV2HIXfywRMLc8X23rcvdUPvZExEpH+86bitti0oDvL3?=
 =?us-ascii?Q?G22D5XCGoo+lHIFzw2fuSuU57W+hCeuvhq8deOLHL51/luuh+e8iMaNKc0J2?=
 =?us-ascii?Q?LXP3qK7iqgCS+o9MpmSjtm4R2G1wMUrrH0GTb39Vv1CcLayB4w8BjuYuIoxG?=
 =?us-ascii?Q?lK7yLXjYOVxry+VoGE/Wt2JrjKz853En7w8vHPevzh/oWRY/Rmaw+90Kq86O?=
 =?us-ascii?Q?ptEUjg5xh9hnm5rGIgnlAP8yestnil7K6wR13NX3hbfWCQd4Uw721+RBFCqw?=
 =?us-ascii?Q?3tO59JkPj4Pkbskopul9VAVevuWKK7WviLxPLg0PpjqLjxyFQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 12:28:00.5734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b85805-e205-4591-0421-08dcfccc1f3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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

The cpu release command for r5 mode (lockstep/split) argument
accepts only string. But the zynqmp tcminit command accepts
string or number for r5 mode (lockstep/split or 0/1) argument.
To fix the r5 mode argument, the common argument (lockstep/split
or 0/1) is used across different u-boot commands. Use the strcmp()
instead of strncmp() to make uniform the r5 mode (lockstep/split
or 0/1) for the zynqmp tcminit and cpu release command.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 arch/arm/mach-zynqmp/mp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynqmp/mp.c b/arch/arm/mach-zynqmp/mp.c
index 6e6da8008f..448bc53286 100644
--- a/arch/arm/mach-zynqmp/mp.c
+++ b/arch/arm/mach-zynqmp/mp.c
@@ -352,7 +352,7 @@ int cpu_release(u32 nr, int argc, char *const argv[])
 		 */
 		flush_dcache_all();
 
-		if (!strncmp(argv[1], "lockstep", 8)) {
+		if (!strcmp(argv[1], "lockstep") || !strcmp(argv[1], "0")) {
 			if (nr != ZYNQMP_CORE_RPU0) {
 				printf("Lockstep mode should run on ZYNQMP_CORE_RPU0\n");
 				return 1;
@@ -369,7 +369,7 @@ int cpu_release(u32 nr, int argc, char *const argv[])
 			dcache_enable();
 			set_r5_halt_mode(nr, RELEASE, LOCK);
 			mark_r5_used(nr, LOCK);
-		} else if (!strncmp(argv[1], "split", 5)) {
+		} else if (!strcmp(argv[1], "split") || !strcmp(argv[1], "1")) {
 			printf("R5 split mode\n");
 			set_r5_reset(nr, SPLIT);
 			set_r5_tcm_mode(SPLIT);
-- 
2.25.1

