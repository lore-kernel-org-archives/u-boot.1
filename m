Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05179CE9D74
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3157B83F5D;
	Tue,  6 Jan 2026 17:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yz472YPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAAB183F66; Tue,  6 Jan 2026 17:16:00 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A49383F01
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b48Knkv/4jvMST560YeEc282rkO6Wpkibs5RszvA0GzKW678flY0MfP1HxrPSTSEDpVJrnyx4WbSZTP5NT8aZXgr6oT7MtlxT4y32OIckmrOzUYBnr9l/bXBPorY4dNbHiH+hly2viteT5O9qBcyDyl3PjfZvpm1FV0DePTWd6gjM1pvx3mMDBcSAxgCdczevGzzfeSx6RR21IL097fGRj/Pl9TzC3DjUycJP3gZJUMaSfhqj67lZbpV11QwDUdp5bXEMV56DT4PNaJTpdyV4jpwj4ICETxVMyjjL7bQPeT3uIDCaHDfpT8Yprqt0UXEi1AfapsgZzr3k9FHbuORTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsVY+nhSvedEUfTB8nESaTmTsnvQrLLZP3CogriVhtQ=;
 b=TBXXal+pNERbe0HV3lhPtX3gqQE5+JsAA+vzIF2sSNgegJdjInm7apHIHHF7uw5sUqs3nNc02dmNTzDjxrVOFXc4ZP77azV5TmZJH5e96hbz4nTpxYIHmBKfuubBTL9SNDHQfxSSQ9BVBs/BS2tVIOXRiJAXLuNVS11cK6jGvJgWYFqzaReYuvg7mKBqP0xIVf9WSxt03lNlMSR/zUodE38tujdjwIjUYUuIbeNszZR4mmC0QNCAmiF1iJJhj0vp8NDlohcCjo3BG7K8I2aIybh04hAfTi1g7zJaQgMCTA0PTAmTCfby5kLlgep9JdERQ6IZIzXGtVzNM5Z6m0JybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsVY+nhSvedEUfTB8nESaTmTsnvQrLLZP3CogriVhtQ=;
 b=yz472YPwfaYDY3WQ6ZY8gSLKVaaODqLQfXtQNz3fxmjxSqeW5s5bY/6i4aT7F02b/0BGs9PZdsse0p8tKA+uJ5tHdBxF6BAsu+LjmRcUawJx0+DguYrkLk9QtVPaL8yPLApQx95QdqdgY6jZxRNod4j+pZp9RqsV3OeehBoS9io=
Received: from BL1PR13CA0260.namprd13.prod.outlook.com (2603:10b6:208:2ba::25)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 16:15:50 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::12) by BL1PR13CA0260.outlook.office365.com
 (2603:10b6:208:2ba::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 16:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 16:15:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 10:15:48 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 6 Jan 2026 08:15:48 -0800
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <igor.opaniuk@foundries.io>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v2 1/1] board: zynqmp: add cmd for getting boot auth state
Date: Tue, 6 Jan 2026 16:15:45 +0000
Message-ID: <20260106161545.2416551-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 5998bd08-faf1-4935-a80c-08de4d3edafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xwhbgcEaWe75fiioYm190mb+alLwvtV/9AQHp6Vbk9IKixDuDaJ0kcbaAWYm?=
 =?us-ascii?Q?gzEujZYKXbRFsJijj79iY0/RbmPdwNJMVCSKp/rjbhbuLzyJ0q/IJyne6KPu?=
 =?us-ascii?Q?HgLgEohM7eUVtrgwgyG7pJqtSP/Oq0VWPFgnXuTaFjl8hWsMdZYZKXTnxjVx?=
 =?us-ascii?Q?JJcnppSSiDZayuQnG/P/cf0SMkzdV569VWsrQorgB9E5WQbIfwJHoyMQ2WXB?=
 =?us-ascii?Q?+za5cH3Mg37uAKzzeE87nVZaaSPH7vh7ToenXvRfXrVi/wEgBOuz+cNKYRri?=
 =?us-ascii?Q?8F/UXxudQ7EUKREnLMjTeluMrRgbTfB6K8yU0ya+FCHxgC56coaLJU5HrQPb?=
 =?us-ascii?Q?FaxuCmFiza6Zumk1O3qoW2zgnE8mAR1YBrcjNefVbL6Pjivjm8YnNncvaFLu?=
 =?us-ascii?Q?Yo50jXae8zLkkbskBgEujpNOspiGEzPSWypft1r0nre7o58s84VtD3iVJG+J?=
 =?us-ascii?Q?Auv0/n5Mzpbp9DE8lmw2bYxkO06NslfvraQa4G8zyXDSEX+mJ34i1kqnZ/OW?=
 =?us-ascii?Q?eWJBUTTAt5mAQz7L+rZ+2TMHGTtCXfNprNgMbyEsA7B3a7ULQ3mhvndIFzfl?=
 =?us-ascii?Q?G0jevT8BPbXfmqN83w+sgW8JfsYolJeu4JUUcsRunydp2Di7ofu+ECcTbYB3?=
 =?us-ascii?Q?SoDJm2ecft84uj31GCroLfgz2xlmSZsjESjzeQZUZvcHexM0pHtZwjqS000Q?=
 =?us-ascii?Q?wvsJ9oOuIzQuq9EwlIccsyOG78kXYHvAtcQW/kTCKamCvh5GLND9cAF7WX1t?=
 =?us-ascii?Q?x/KWkF1Uy+VunEUDQNct3b9oZj24hKbockCj+WdhMvhLXzJ7I2LmgiFG4Fhs?=
 =?us-ascii?Q?M2anpUZkbgUQsBVWuWoC54LjRNNJRKcrG3/tHrEBG9vMsdt2JkKtsDBj05UM?=
 =?us-ascii?Q?jZ0gyHlqChhNDjMIEyyrz6DoLJ1MzGJ5an/iJJUewbxZK9uBtvwdsZEb/NCX?=
 =?us-ascii?Q?WyttU5vA3jI+LEiiNJfGlbbEbB8ZRxOanhpySx/nbEAQTRBrKs66Y9Hqs7yt?=
 =?us-ascii?Q?nH30lnKyquR8P1+7k4RpiEijIL00peoNpCl/lKphghPQXuTdBHDAvqzZRG/q?=
 =?us-ascii?Q?XpxRWzNxi9s1rY9mBZik8c4jcvoOmKn6YlXx3OzFIxiaXV9iQIfFTvoU9Y7e?=
 =?us-ascii?Q?q+/GK7FPpLhs5WhNXZ6oYsLOyfpuICMzDt5XzyvvBpnSdkcs5w7GljIBF4Js?=
 =?us-ascii?Q?RXDT3W0L8/VSxK8NALWHce4OULbpIsfJ7vUkOUTWtogBeJNLpKdWGqW5ok0t?=
 =?us-ascii?Q?Wbe/T6yRvaBTi2I91SXxhVdFM/p/EG3u8uWjlXulfXeVy2dtVWJFbp9pheO9?=
 =?us-ascii?Q?t93ZYmAb1Z0TQZlwyLNE5gcj2QdS4ZkdBaNBMIskA1X2CQIIAeBiro0KsdlI?=
 =?us-ascii?Q?x6XSCVXbqDTBr0Z2VGkoyGM8n+CKp3e6JaEnvoKWJ5BN8BT+veOyY11+kESZ?=
 =?us-ascii?Q?Pcp10WfvhGtKjg1tJKpW4n0kycrZIFeckne7fdX1w6e0KT+4HLQxElFJ+xWk?=
 =?us-ascii?Q?S+EYB8PxI/85IKX4hx0tDsatkv0KSUaNMeHKmR3/VqYNzRdquFZab5xbYRAH?=
 =?us-ascii?Q?DdHEBIu5rohAeC0kmus=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7142099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:15:48.9915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5998bd08-faf1-4935-a80c-08de4d3edafa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
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
---
 arch/arm/mach-zynqmp/zynqmp.c | 44 ++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index c0398a466ff..b15c31919c6 100644
--- a/arch/arm/mach-zynqmp/zynqmp.c
+++ b/arch/arm/mach-zynqmp/zynqmp.c
@@ -362,6 +362,45 @@ static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+static bool zynqmp_verify_auth(void)
+{
+	u32 status = 0;
+	int ret;
+
+	ret = zynqmp_mmio_read((ulong)&csu_base->status, &status);
+	if (ret) {
+		printf("Can't obtain boot auth state");
+		return false;
+	}
+
+	return (status & BIT(0));
+}
+
+static int do_zynqmp_verify_auth(struct cmd_tbl *cmdtp, int flag,
+				 int argc, char * const argv[])
+{
+	u32 status = 0;
+	int ret;
+
+	status = zynqmp_verify_auth();
+	if (status) {
+		printf("Boot is authenticated\n");
+
+		ret = env_set("zynqmp_auth", "1");
+		if (ret)
+			return CMD_RET_FAILURE;
+	} else {
+		printf("Boot is not authenticated\n");
+
+		ret = env_set("zynqmp_auth", "0");
+		if (ret)
+			return CMD_RET_FAILURE;
+		
+	}
+
+	return status;
+}
+
 static struct cmd_tbl cmd_zynqmp_sub[] = {
 	U_BOOT_CMD_MKENT(secure, 5, 0, do_zynqmp_verify_secure, "", ""),
 	U_BOOT_CMD_MKENT(pmufw, 4, 0, do_zynqmp_pmufw, "", ""),
@@ -371,6 +410,7 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
 	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
 	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
 	U_BOOT_CMD_MKENT(reboot, 3, 0, do_zynqmp_reboot, "", ""),
+	U_BOOT_CMD_MKENT(verify_auth, 2, 0, do_zynqmp_verify_auth, "", ""),
 #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
 	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
 #endif
@@ -446,10 +486,12 @@ U_BOOT_LONGHELP(zynqmp,
 	"	48 bytes hash value into srcaddr\n"
 	"	Optional key_addr can be specified for saving sha3 hash value\n"
 	"	Note: srcaddr/srclen should not be 0\n"
+	"zynqmp verify_auth - verifies if boot.bin was authenticated\n"
+	"	Returns: 0 not authenticated, 1 authenticated\n"
 	);
 
 U_BOOT_CMD(
-	zynqmp, 9, 1, do_zynqmp,
+	zynqmp, 10, 1, do_zynqmp,
 	"ZynqMP sub-system",
 	zynqmp_help_text
 );
-- 
2.25.1

