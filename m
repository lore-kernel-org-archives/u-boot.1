Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC8BCDD1B2
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 14:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C0A88FDA;
	Fri, 27 Sep 2024 15:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nKtOi2A9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1355A8910A; Fri, 27 Sep 2024 15:59:49 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25F389089
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 15:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBm5jBs8v0unpQDStwloF65KBLXUlnBsu1SB523+K7+PYhGtVTaBq8ZbUYJEuPJ5x88hZ44Zhi9tT5+fg6x+2Yh+ykaBjxu++oG5OwFi6dVH4PGlNX4oorOMfHKx0a++2aEVfDRXz03yE5ZKXjFsDQbPaU9XX9uGZtyRKQOUAf3yrXOoj5pxGXuvoQQ6RlYObzU6rnUhDVqn4pNedALoG2WGitf619Luh7eMXub8PNbIKP84RD4MuSdaTnKD8Ml7j7Pb5xRz2sLR7gqn6LHBKwe2lqYu5Zn9TcfVE8/HIs2vlBOy1/VT9Ce55gEdm6far1/IR48Ey8ltt0fVmxhMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqMHwb7Jc1rCjDiz73l2CtjY8/NjLZc9hTxj0O2z01c=;
 b=HhfB+YiszsywxJjMwh3PAPMU0WaytReg8KcOwXN7IAbQUAzz4u6RoAkcEctAzpGRxlvUGfpyTlqxjVo6jGEadSZlxw7q+UVfhB9e5RfOPbeIxn34mgCRBTloFtfA9M1HkOgS8w4Qws3hCuC6VSC4JY1LPPjIJfR17a2qXHwQMQmfgLFdWlYT/JvW5+ueMNvc5lvGZQsmvvHHe17VTdamaqnUh48G82D7+zBonWxwegJDWhiLKv7o6lqz1f59moOWQPtcUO0tHqnvZIhUvdTCuILE1MuoqhL1TehPUY3stB8fyjxqg9P3yqkayghPfGEpeRuTiSMsRyk24RhK9XZBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqMHwb7Jc1rCjDiz73l2CtjY8/NjLZc9hTxj0O2z01c=;
 b=nKtOi2A9UfD2Cc4VNmCt6/Hu71iJWO2GZwtG4o7pyZP6L0S9T6/P7PIVbalu+iwZdSn3ztxn4bYvsFRomJhF9I2VighykpiwWSc22vDClaCE4fX767/gUIic80QaLm344bnJGSkLwESJlgUp1JedxLhTUXmpAUsVzKkQT6jG/G0=
Received: from BN0PR04CA0176.namprd04.prod.outlook.com (2603:10b6:408:eb::31)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Fri, 27 Sep
 2024 13:59:41 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::c4) by BN0PR04CA0176.outlook.office365.com
 (2603:10b6:408:eb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23 via Frontend
 Transport; Fri, 27 Sep 2024 13:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 13:59:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 08:59:39 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 08:59:37 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <git-dev@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH 2/2] arm64: zynqmp: Fix tcminit mode value based on argv
Date: Fri, 27 Sep 2024 19:29:26 +0530
Message-ID: <20240927135926.438450-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927135926.438450-1-padmarao.begari@amd.com>
References: <20240927135926.438450-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: c2880f92-ae99-41f8-1e45-08dcdefca259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?75VA82b4EyMxQPO0lUh4tb2N0/HHFlh5CcQbETiluViHjQDpr0kdsSE/ecBr?=
 =?us-ascii?Q?+df2PTSn5w4maQn5PG9do72tKkuYB1AO5hHH6UcafhkePY9lgbH+YyJlf0NE?=
 =?us-ascii?Q?sAwUJIDC1nFek4BjX5zx66rXg4O3VnF/QOkaSU2oSzHGVYAwovOsVJOTSloJ?=
 =?us-ascii?Q?ThRI4dKLYSLp9SjKkK+xLd9pFnsX6W5vzqJumvanzo9J02+rDYAxXUeDNp1c?=
 =?us-ascii?Q?5r3+MaXChW8dzwcCjS2DBFVCLo+a9rUGNEAv/WKtONBLp1k6Fp3Z7HZbrHxE?=
 =?us-ascii?Q?mpqGDfymCXlNdSLw/gEfIfjAOvZYmFkW2909Es7TLbu7jSRHw1S8e9k1AO40?=
 =?us-ascii?Q?mVLvLSR+3tPFKBoL9kH1bTPZecArrYtziFMOebYWc5fIke4zVN9XSzpvHCIw?=
 =?us-ascii?Q?GZK9lFJ+/Kk7Dt5D++UYNLYR+7FTtmJPKxh0SiGNEgE3l6iNNDWZpQrT4LZZ?=
 =?us-ascii?Q?FpbMOF38dVIk4Ou7uan5ime2AZT2X6Odyu5IfYKAKpmM/Bmna8alNl9CVWZP?=
 =?us-ascii?Q?mymbJM5FLDWPYKuod6ogal9ohkH5Wh9C05i0kecEV++zapDNr5oJqH4vSL08?=
 =?us-ascii?Q?8WoHsyPjtI5u3n78HWG5VIV3CBX7dXL15Mx6VFw4zW+XBam72e6NGJ0xh7/z?=
 =?us-ascii?Q?tdtIwvUMtaHmyTzzcMBSAgukh+l85YaPIWyYFDQOQw7nqGs64/AEabYeVPVI?=
 =?us-ascii?Q?jWrLN2RI5XcaxmAU9NBgKPth7iRM+9HrABaivUfIzk2TvPge1s7dBbfbv/jY?=
 =?us-ascii?Q?HaBk+HXfvgpyBXfvE+mcLRhoeB9zhfEWabq+bZIgwCbHmy7iEjK7r9TZU7rr?=
 =?us-ascii?Q?2/MQdap30dgtsoGooVWvXD0EVgfB03TNuNFZwoDdDBtyQHnEm4cJiTpri+2k?=
 =?us-ascii?Q?YIvRqZVfg1kBu8ee+ts0mAZzl7RpFKDtSART+W6OcZrI4F7syD85V25yaf48?=
 =?us-ascii?Q?pjEsat+K/3lXNiWijpsxfL/tPuF4A9yD/aYjv1UO+nQMaZ6r8g6K1Nxpyp8E?=
 =?us-ascii?Q?IUL77CpVB3lobERgR6OOAcCJWDY30ofzVlWDMaGox3VUDWK66fknMwrlTqgA?=
 =?us-ascii?Q?vOuBRCqbbihL7sSQt+1cO9x5HX+Dlu5Qa/zbjpiy+Mm0QgFMY6GLFcfP954b?=
 =?us-ascii?Q?B0tJ92OAH7Sxl3Dl15vJZktzgNhlFZtOoj0JNEGH6EvtHug/mKmLVwQyGrBQ?=
 =?us-ascii?Q?X4uYl7dFMp6NKClI0AJkEUUCHXrRJ2xBG1fGjlrYHa6LtoSWjPKFuSm/Ehri?=
 =?us-ascii?Q?CprbcikDvCjjWeKBErRFgSoBX99mQqsK6Vy6rigjG1zVKNyHs+m2ip57ClB2?=
 =?us-ascii?Q?Z3um83rCgtfI82pPEBsfL/lMoTmV+G7A2DmdqRTE+/PjEZqxST9QAttUN3Ok?=
 =?us-ascii?Q?OrOyiep4Uhp5UFnY8/9lJ6n2neSD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:59:41.5860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2880f92-ae99-41f8-1e45-08dcdefca259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282
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

The RPU pytest introduced by commit d5970290691b
("test/py: zynqmp_rpu: Add test for loading RPU apps") expects
3rd parameter as string not a number that's why extend command
to actually handle both. The issue with existing code is that
when any non number string is passed hextoul returns 0. For
backward compatibility zynqmp tcminit 0/1 can be still used but
it is recommended to use strings instead.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 arch/arm/mach-zynqmp/zynqmp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index bf39c5472e..bea29bb4c6 100644
--- a/arch/arm/mach-zynqmp/zynqmp.c
+++ b/arch/arm/mach-zynqmp/zynqmp.c
@@ -151,14 +151,12 @@ static int do_zynqmp_tcm_init(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (argc != cmdtp->maxargs)
 		return CMD_RET_USAGE;
 
-	if (strcmp(argv[2], "lockstep") && strcmp(argv[2], "split")) {
-		printf("mode param should be lockstep or split\n");
-		return CMD_RET_FAILURE;
-	}
-
-	mode = hextoul(argv[2], NULL);
-	if (mode != TCM_LOCK && mode != TCM_SPLIT) {
-		printf("Mode should be either 0(lock)/1(split)\n");
+	if (!strcmp(argv[2], "lockstep") || !strcmp(argv[2], "0")) {
+		mode = TCM_LOCK;
+	} else if (!strcmp(argv[2], "split") || !strcmp(argv[2], "1")) {
+		mode = TCM_SPLIT;
+	} else {
+		printf("Mode should be either lockstep/split\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -403,7 +401,7 @@ U_BOOT_LONGHELP(zynqmp,
 	"		       initialized before accessing to avoid ECC\n"
 	"		       errors. mode specifies in which mode TCM has\n"
 	"		       to be initialized. Supported modes will be\n"
-	"		       lock(0)/split(1)\n"
+	"		       lockstep(0)/split(1)\n"
 #endif
 	"zynqmp pmufw address size - load PMU FW configuration object\n"
 	"zynqmp pmufw node <id> - load PMU FW configuration object, <id> in dec\n"
-- 
2.25.1

