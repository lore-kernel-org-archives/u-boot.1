Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B45CF6ABC
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 10:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1324783B87;
	Thu,  8 Jan 2026 11:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y9grJW8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE57840A9; Thu,  8 Jan 2026 11:09:02 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A7A83A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 11:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRA0BNbiVk7xGzhzbYOYrBjQXdOWTxUK0ODMPOIkNrBG9Y8FtTu4681LdPNdrO/YHxFe22T7k9VIfiHgo1fyOlD+AY27iD+xXE3NCoDp6s7IVvUnkGwSHU3s1oeaaq6FOrNK/FOpUhSjJoihrCAKpuAEu+Y4pfWkHsxDESarn/NHkWSt6AxfI3GEdts2CvXGsMrh08/B21WMf/i/p2FnOR+IudWEmXR3+Bz4XAxe5BSHMhsxRXFtrjYSouV75G3ve6JtZ5F95v5OyC9ssKoBhJi+zAIa8FNJA9gaFF173KreW7nbpExSZxHUxq5Vy1X0yT50eezfCjAC3Tj17oWouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=295SXxF2FcrcN0KG4QHj6iI4sNfu3Zq7I+8CTl2/n0s=;
 b=w3rRDlnVaynpWW/T5JIWa2fyE5NvAlBf+4MXyjJZlQdp19w1w+B8t3/hpR6IOhMbAeCgU+Af7rVj9tZADMqmxqla86Qc0arlwbLFohoFOLHtAC4pwRzcL3yCc1sLLcOd1Vz3apldztvNMAh4fMIilBaF8fBFxlIQSq4yUdwTQnOo7eBRe+/qZ4XhhMdd7WI7rzH+DVBMc5IzbfvsaewEUP6fj0lDEpdwoISbuJLUGOP1CqPungaHlFdiZEeh2XNfcS2rId+r+Fxp1R26ZpYrmBQcTjHkvfgdtdy0zMIo8bSwDcYzYOEKae3DDzHHPUDQTH1zMvCAATVU1vNfjAic9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=295SXxF2FcrcN0KG4QHj6iI4sNfu3Zq7I+8CTl2/n0s=;
 b=y9grJW8J+LUdIJp3/HNCmhKn1hNFc+gA9CGmnlP5cYAJaPPoqVsb9VZ/kj+O0rNOotcDX2b60/2ypWlly65sCEBpTjvo9P8cSQcBXpAjdy7xQujUgok9MIE6/Fak3jyoo6XXyDTsCM9C/cMhfAMIS0u/nFORNrfz5DWD4EwI18Y=
Received: from SJ0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:33a::9)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 10:08:54 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::3a) by SJ0PR03CA0004.outlook.office365.com
 (2603:10b6:a03:33a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 10:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 10:08:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 04:08:53 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 02:08:52 -0800
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <igor.opaniuk@foundries.io>,
 <tomas.melin@vaisala.com>, Neal Frager <neal.frager@amd.com>
Subject: [PATCH v6 1/1] board: zynqmp: add cmd for getting boot auth state
Date: Thu, 8 Jan 2026 10:08:50 +0000
Message-ID: <20260108100850.544009-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 322a3f95-05c2-4940-4768-08de4e9dedd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D6PbxpDQdCbEmi7PoF7a/XROcGyMC7qCyOjwKYgGg0tubFzTsfCLh4sAE17+?=
 =?us-ascii?Q?t3/+rZkiRXo1K6yVbMf9wNMx+80/G/otjz5tuW40QO6p03EuyZ1U/4nwwESM?=
 =?us-ascii?Q?RNkHTFy+wr3CMN62zwJCIrHNPXiZUQPzwOg5Q5rsypfFrrfLG2oMK13pywII?=
 =?us-ascii?Q?ph6iGXdBmxzdLca7QG22EsPYLfaLHvXGcANk3rQ3TkJeQKwePKEuKD7uN52s?=
 =?us-ascii?Q?pLLAQaRwir1xrpaIm+DMaRSNrABFIYkImGRYqESnir1Wnqvfgi/7P1v6qrv+?=
 =?us-ascii?Q?6boZuRcDjHdOIYDIVnv70h7foKuEmFZfGrYoGycu/B+UlBuMDpstfIak5pZg?=
 =?us-ascii?Q?+7VXvqrL92Tfrw88Y9kk3D+HbHYM6egPOaqT9wcM1qwJfQ0ErQpAlHK8elM0?=
 =?us-ascii?Q?MM2yzVutF1o60PN2Rx9D5L4YJ1L3K/g+3XqRDRqsuNZg1eZX6wOSgZxDcR4y?=
 =?us-ascii?Q?DvaFRdvBFssckbsacJgHFOYh4ffC14KEzzVAQO1OTu5386HZ9ytakr9XzHK/?=
 =?us-ascii?Q?2LwYFDoUJOM4baP0f/M1xGCeGYArhzIk/BrtO33zvaFbLWPlLZd510JO8obT?=
 =?us-ascii?Q?SlYT2LFMsX2Dn8EOZExvdPdwFXAD8HpNLFq9WOlrM6n0DVCuNVxOh9GMxOk2?=
 =?us-ascii?Q?B7kJBbGz85/vMUt3ZjOyvLQPc7+/TZqxXE/CrkR7bL3GYa/Dwp6RbDkXknBW?=
 =?us-ascii?Q?ZnowMOOpejD45vn7ie6JIdbJHSwiZzvZ8/T60FA2VVHtZTF0u92hFONYqrU5?=
 =?us-ascii?Q?jNxcLReCmmaXREK28OmemU2is/QH8opXdziKBaKMgqvtlgK0DgUmu9nblhzH?=
 =?us-ascii?Q?m/LmyJavN01xae9oOQVX/47frTvXUmuJQzsNGhF4ku3tRwV7T4HuALX6nqxi?=
 =?us-ascii?Q?15PSrUJRHo3pQv7rk0GjA17t96FX1GkmrtXntpKJ4XV72DaFpRB47s2kZ7Hq?=
 =?us-ascii?Q?yc1T7q0pMlVvVGbZ2N6fSG+eGhR3ciqoqnwl7b+0IMTd2oGVHzDqpVhSzcqN?=
 =?us-ascii?Q?8NJH87uPz62lOqjaNdRr3Hrki7BTOdIhOGffjTs1UPxafCBLXN5NRpRes5f2?=
 =?us-ascii?Q?AKEhIN67FC2b0qqXy+zbO1AYibOT6GC3oq8Ft8OQwxgbIaJ/wHcJcauu5qUs?=
 =?us-ascii?Q?P7lgRuKAnR/FPfBzodxvEeeDGgRLOuDA+Dfl8T5ixQbpmtsDXUe83ZlWZ2O/?=
 =?us-ascii?Q?zqEOi5vSMR8/5GEq4sJyBwVEqwWdKj4PSWmU9Fa16MegA44nnmdcZKLJqvc6?=
 =?us-ascii?Q?cYmVSSgX74CaHj7355swY3J5BYsMhLv6mebyWiTNlWvSNE1P+Yb+SNW34kJJ?=
 =?us-ascii?Q?6PE1vuqKt6EQpQxMRxelOveUGFO7qn5NzkzUX7fzAUi7ffR0HbO+EkLOVIjU?=
 =?us-ascii?Q?QVWA6UYPpJiK4xWhpnEuZEAa2uGC5BluROSifwQgrjcFkKtLeAWjtZREUqxc?=
 =?us-ascii?Q?YZV7cc112wrIi22z6nCgEAyGUIy2hYCGJOV0BH9VEzDmYFXpw24sj9SHB7Tn?=
 =?us-ascii?Q?NKAOTh73lwiZX+xt8DL91YlpNXKKlTcvCuXo29GYoX/zwZaZJ9yUI6ZYtF+N?=
 =?us-ascii?Q?wLA40x+A1gGTxnaKgVE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7142099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 10:08:53.8526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 322a3f95-05c2-4940-4768-08de4e9dedd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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
Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>
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
V4->V5:
- added newline to zynqmp_mmio_read error msg
V5->V6:
- changed printf statements to debug
- simplied status check in if statement
---
 arch/arm/mach-zynqmp/zynqmp.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index c0398a466ff..42a72ea2de8 100644
--- a/arch/arm/mach-zynqmp/zynqmp.c
+++ b/arch/arm/mach-zynqmp/zynqmp.c
@@ -362,6 +362,35 @@ static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
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
+		printf("Can't obtain boot auth state\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (status & ZYNQMP_CSU_STATUS_AUTHENTICATED) {
+		debug("Boot is authenticated\n");
+
+		ret = env_set("boot_auth", "1");
+		if (ret)
+			return CMD_RET_FAILURE;
+	} else {
+		debug("Boot is not authenticated\n");
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
@@ -371,6 +400,7 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
 	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
 	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
 	U_BOOT_CMD_MKENT(reboot, 3, 0, do_zynqmp_reboot, "", ""),
+	U_BOOT_CMD_MKENT(verify_auth, 2, 0, do_zynqmp_verify_auth, "", ""),
 #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
 	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
 #endif
@@ -446,10 +476,12 @@ U_BOOT_LONGHELP(zynqmp,
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

