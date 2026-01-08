Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D243BD148A3
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 07:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A94839DE;
	Thu,  8 Jan 2026 08:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sq+QqNPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E1D183A26; Thu,  8 Jan 2026 08:39:52 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D63B839B7
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 08:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqN4dPFNbAGWVR70mm4/Q9vsSrAdMoV4e7h0HPS/3g7wJbRdSY8oU2XReQKKKxg4cpmYgZeWWhXzNjeFKTG2AOoBP3PXajyvxTbLwhu2bRyVaDyoYEt+Cea+Q3WdTy33mkoJwmzqy8Jn6qzQ+GKP/8gxkRqrdk1+UW+mMDUu8hGIXv7IKjet4ryleznREO+z0i6IMRXx47pihAyipufbGIKA7SVIot8Hohf5QfjFnCbSc+2BmR5HIf5qIQcG05arxPMb+lWGyXuK5FI9CqW5AaGPLiLk8toCmCPY38v1Lf0at+TrLtPzvaCE+mz9zaSa2DT5qWuMxBj0oDyrl9142w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYyhug0UMljROAdKHm8xWyWJEJH0OjXLIb28tSMQ8ls=;
 b=dAFzHYLSiavjf6uXrMaaN4N9zYVQ20v9y0yGBzjFL8h8Chx6ixZGfjbAaZ3kok7DUWI5kRLicXn8iRgr5yi6tIY4gA9hScyeR/krba/3AGUjBrCslBCXzKh+PRc/KxxEiPBLG9Y/Uf3BKSGdd9YuzAvblcEXJ0b4FQOLr2VpEaMoKxJDSDhpwRZ9M+BMLyMDtrOIQO2cNtNPAWCvEn5E8B+v+D3gCUxPFUJeTfDijykSLvbJhRRm87HFvEwJu2HIDyAhP5KQ96Fkq7hdIjzsgkGuyhT4puuz9x/+Z9Wua5Vz2N53Pu5ZkadaAEngFissT0zQn8XsuhqUJLiiCdgTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYyhug0UMljROAdKHm8xWyWJEJH0OjXLIb28tSMQ8ls=;
 b=Sq+QqNPelLZhrN4WJSDb9LDVo9blqHk66GppztRDs7owYvOt7RP8QB7+/HuOl3XJunJ6i3NVKXDDqX6vexYmgOND17622EeU9VkVTAMSaFshNd8op5a6sqnsbAJyceWK26Zj9POpmvjzSsjVt1uPgZDO53CggDBzXC+GXm58yUc=
Received: from BL1PR13CA0140.namprd13.prod.outlook.com (2603:10b6:208:2bb::25)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:39:40 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::c4) by BL1PR13CA0140.outlook.office365.com
 (2603:10b6:208:2bb::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Thu, 8
 Jan 2026 07:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Thu, 8 Jan 2026 07:39:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 01:39:40 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 23:39:39 -0800
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <igor.opaniuk@foundries.io>,
 <tomas.melin@vaisala.com>, Neal Frager <neal.frager@amd.com>
Subject: [PATCH v4 1/1] board: zynqmp: add cmd for getting boot auth state
Date: Thu, 8 Jan 2026 07:39:37 +0000
Message-ID: <20260108073937.490046-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f317bea-7a58-4240-8985-08de4e89153a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Qnq9exFrInwCPEzg94BY7g/l14BNBFLJWaicbRs9tSzOGlMK/hVTGDzd7LA?=
 =?us-ascii?Q?d/6oieq/CpWE/SdVACTjfT92eNZebQ3sKHQ2JuRYEQ4YqHfUQmTu/ejkPZ7q?=
 =?us-ascii?Q?RMmDnfQpjv7ffMDG7JgCtLQoAuVxYlq/GWO+SsAfI7Kh9DSpTwcXpIrSFGM/?=
 =?us-ascii?Q?Yuds2gSBTZOmZ22BJ7Pa+EPVURukoUtzOXZInQsrL6VCNyf309HT0H8lg5DS?=
 =?us-ascii?Q?854pYVnY22x40/HslrCdUevGnCKGrcwKJtXCcqfxg8U6iRfhXf8uWkB1AgcK?=
 =?us-ascii?Q?LvkBmrfRUqOc4IIymobwsTYpxUy+7f7JBaCZ9NU9bY19iFOVBwjkWzyvSmwb?=
 =?us-ascii?Q?oVQD6dBI9d4Mnq/k+C3UYoFQIpMuFfl2kkyKMqgVypLWGyYmBsvtRFRKNXoq?=
 =?us-ascii?Q?A0DFsPyl3BdYbp/7M1PPCpY/y5aCASLZw0ZJhpUSp6OPln72KrreX45O4lZK?=
 =?us-ascii?Q?B4vpiYCQqfhuy6m8PhJiGQdJYV2pnWfKsDG/5VRuHe2tWHwSS12nyOIdMYbe?=
 =?us-ascii?Q?2b9f6uobrllyLjVIVx0D1zMrf7/ayMI5q9VHf1o6AZzMVyJdbK+R8Owyu7ee?=
 =?us-ascii?Q?sQ58eU8oOLtL+0HxubbXzpem/2yJryibbPA6oTlDXQKDvzYxAC4SCQw9MEdw?=
 =?us-ascii?Q?V+ryAof3eat71CiADBeJzpo1ryyd4QcLv3+uQfqluuqqVgy212mboKgCgILw?=
 =?us-ascii?Q?7WKnoRPulxDON4LIT2QdPznKCiBJMxLlUGDfV+dVZIY51LOsBosz1toQuTiu?=
 =?us-ascii?Q?J7kYr24lWMfxb4A8Vh2eWwjQehJ0JdX51eU7Kli9mhfEqkORhNGYTfKRlgUc?=
 =?us-ascii?Q?pN/drN8ygZWQbMPnX2AqOBvDLa+vD89BLaoiK0LNFNff6pH8ZiYrlR253NBg?=
 =?us-ascii?Q?RR9qsyIPfnSW3PEzqGQCPUD+nsbwz4zsmEnUjFUX5veOTrPGVElEbW6pObQp?=
 =?us-ascii?Q?sdAGqHYQzAl8LwPsu8IM+Ci/9qOALBNb04AOGfEz6d6LFh2cr61FPt7KefCZ?=
 =?us-ascii?Q?9tr0tLFuBQllJCHpuBmFeNzMP5tLKUyv0XsQ0mD0Ia1OIbz0OzkbbPL9ofV+?=
 =?us-ascii?Q?F+pD3MY3Gp/GX0rrKMEwBOFVB+S6BYtRESp3mIdhFOo+I2kIwBcQScbyVhZZ?=
 =?us-ascii?Q?QUO+fMlUFzHc+5OSU+KGpxFgxLgi5s8n8bmFH2EIHK7SRAnc+TeY1yom1Mul?=
 =?us-ascii?Q?DSHP19GIbeswi2V/pz8Ww2SwSVN5Ax02D0SKn0GWSf0RcaMQzdS+8lvk5Wqz?=
 =?us-ascii?Q?8vCjszjkRcvn8lMya3Mtg3jzM8qMCab3K6vqKVduhmgVUNsOVTqyIwQh8qZ/?=
 =?us-ascii?Q?1S3jOSwWYjyxKRTpV8nCD3XI6L64K4Rg3rqJUH5t/oBz3uleNMvw+qYUA+GR?=
 =?us-ascii?Q?zlo6h56Kb/M4sBE3bB8NOhN0s/y0TGznzD9hVnI6QYJKaeX4jyHJNNyuRMH2?=
 =?us-ascii?Q?str1Wz5OWsb08l39r6qgkhq55QU2zotTi3o28Kg5Q3GutL45W/C/PFv78D1U?=
 =?us-ascii?Q?7veB4d3vHrgXysqoMHOiDrn2C2tA+oOgwE858aeFI+H4/TR0cJ0ZseREgAo7?=
 =?us-ascii?Q?+UfbWsY3Wp/ZxBI2EgY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7142099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:39:40.6396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f317bea-7a58-4240-8985-08de4e89153a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464
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

Add command for checking if boot was authenticated.

Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Signed-off-by: Neal Frager <neal.frager@amd.com>
---
V1->V2:
- extended zynqmp command with verify_auth sub-command
- changed return value, so it can be used with scripts
V2->V3:
- separated status and ret values
- replaced BIT(0) with ZYNQMP_CSU_STATUS_AUTHENTICATED
- changed env variable name to "boot_auth"
V3->V4:
- removed unnecessary zynqmp_verify_auth function
---
 arch/arm/mach-zynqmp/zynqmp.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index c0398a466ff..71f9751083f 100644
--- a/arch/arm/mach-zynqmp/zynqmp.c
+++ b/arch/arm/mach-zynqmp/zynqmp.c
@@ -362,6 +362,36 @@ static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_zynqmp_verify_auth(struct cmd_tbl *cmdtp, int flag,
+				 int argc, char * const argv[])
+{
+	u32 status;
+	int ret;
+
+	ret = zynqmp_mmio_read((ulong)&csu_base->status, &status);
+	if (ret) {
+		printf("Can't obtain boot auth state");
+		return CMD_RET_FAILURE;
+	}
+
+	status &= ZYNQMP_CSU_STATUS_AUTHENTICATED;
+	if (status) {
+		printf("Boot is authenticated\n");
+
+		ret = env_set("boot_auth", "1");
+		if (ret)
+			return CMD_RET_FAILURE;
+	} else {
+		printf("Boot is not authenticated\n");
+
+		ret = env_set("boot_auth", "0");
+		if (ret)
+			return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
 static struct cmd_tbl cmd_zynqmp_sub[] = {
 	U_BOOT_CMD_MKENT(secure, 5, 0, do_zynqmp_verify_secure, "", ""),
 	U_BOOT_CMD_MKENT(pmufw, 4, 0, do_zynqmp_pmufw, "", ""),
@@ -371,6 +401,7 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
 	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
 	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
 	U_BOOT_CMD_MKENT(reboot, 3, 0, do_zynqmp_reboot, "", ""),
+	U_BOOT_CMD_MKENT(verify_auth, 2, 0, do_zynqmp_verify_auth, "", ""),
 #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
 	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
 #endif
@@ -446,10 +477,12 @@ U_BOOT_LONGHELP(zynqmp,
 	"	48 bytes hash value into srcaddr\n"
 	"	Optional key_addr can be specified for saving sha3 hash value\n"
 	"	Note: srcaddr/srclen should not be 0\n"
+	"zynqmp verify_auth - verifies if boot.bin was authenticated\n"
+	"	Returns boot_auth : 0 not authenticated, 1 authenticated\n"
 	);
 
 U_BOOT_CMD(
-	zynqmp, 9, 1, do_zynqmp,
+	zynqmp, 10, 1, do_zynqmp,
 	"ZynqMP sub-system",
 	zynqmp_help_text
 );
-- 
2.25.1

