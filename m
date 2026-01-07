Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17312CFD62A
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 13:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6846683B86;
	Wed,  7 Jan 2026 14:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a5NGXlXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA4083C4B; Wed,  7 Jan 2026 14:21:14 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0FB839D7
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 14:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5x8OxE206HBwLWD28nzJLn5xrTZRv7BdOv67i/dlVLrCbihd/pWnAY+rfxoGdW6LZ3gicjCbZq5pIoQ2fjcwKPTaVqzCeAcLtYdCeNc9evycFRhP2VAqNKn9z85ogaJyrrAIWic3sGy2ipzUoFci0sQ20wfcXcHNfyVH0HXzyEwKvbxJorkytSV0B0GmiL+I8Bb2jXv4kXpcPJC+ozMMcgtCLT9HYDlf7TZ3kJrcSBl6oXjZrVNc9daT9mxhNRotbSzZj/jAG30xszQ1huEtLcOXFszwzVCevollbdkfoxpo2ijzNzuJzs7JFZ8dD+TFNCi/t317Y4R/5HflNOCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvD8lt50VOf4q9eRK2pzkXUg1QYRre19upZ7ImRhhX8=;
 b=Ng3Q0qPAeRN7i7oTcGul8hwzJpejg054Z8JNJitgZbxczpa1n68a8IMgQTjFD9WnZJ8NiitFWjm0tGv6b2vFWOGWUzKCMlCPJ6QyrxixheBBYDAzsILJBNdhnDYuhA+vy2UIX06rR6JJyxnik26gykQZ50GtkqjSEwkje6cGKGjAQAtLS1z6JQr0GLhJ/Vu7Q4h3SyujyueG0J/HO+lAhCzitgrHQ/tVw6KMOzZQ7bscBl31VsBURYScpGYQZBAfQFjHvwS8j29VwNo3K13HBn90QApXqS2oukvPCMSyKttY/ieapXHkR0Zta5LHcLwXn+O0Ih0UERxeWAV15BOmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvD8lt50VOf4q9eRK2pzkXUg1QYRre19upZ7ImRhhX8=;
 b=a5NGXlXXTJe9bYrhQFBiXCur2XGCwqPlEzMg5V6GrMw+T4gmTey8LWiIHucvfUhiezWQFmfIVD1zPyrZTQUghGksm/w+G5JOOPxby56q1w9dX5qhnWD8W3Tu+YtY9D01cjfTVflVMu5fVMm+GtsEkz4FEa8lsST2U0oPw5dRATQ=
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 13:21:07 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::b) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 13:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 13:21:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 07:21:06 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 07:21:05 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 07:21:05 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <igor.opaniuk@foundries.io>,
 <tomas.melin@vaisala.com>, Neal Frager <neal.frager@amd.com>
Subject: [PATCH v3 1/1] board: zynqmp: add cmd for getting boot auth state
Date: Wed, 7 Jan 2026 13:21:03 +0000
Message-ID: <20260107132103.216743-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 0821d583-bf95-49b2-3525-08de4def9d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bU7zl4sejIBp1+ogCu+hJimOCC8UQcZNXRe34MnLG9Pb+PzWzz4YG0tZsXDV?=
 =?us-ascii?Q?cThV0kL0M7YACBYfmVSqSQ00Rp9dnyNa1N3+Bl47h63HvqnMLcJQV+OM8xlN?=
 =?us-ascii?Q?4/UiuB+WbYMz9Yfx0fMPAktbfcLFTOCUqPXpJHahiDvlqMf1oFzJWJfIx1z+?=
 =?us-ascii?Q?NmaXQMTmNgUWMmkriwRmHmT8g88ixROJ/UoILZd7qXNcB1Q50QeckO2KbNYG?=
 =?us-ascii?Q?AV0E8Q2CiK8zE6ey7PY7eH46WOVSSzZfMArGw7XOaD8sRbg2VzEC4UKLtdFs?=
 =?us-ascii?Q?6yEqM1BYik4NX41ORPpcSu4YZvCtdo8o3K59SyQRJDhBniK8mDocBdSQt/yb?=
 =?us-ascii?Q?gdJzO5wd20EoK7lhZnyrd0BOY72bpCs4RvBkkdnDAYaT04IR9RAPuum1tEPI?=
 =?us-ascii?Q?vjOjywqiCDJZ6R4STaSwm1Au0nMS7CKyj/arkfrzp84BJZmbHG3m0efN3F5o?=
 =?us-ascii?Q?4aG51YMSze0e6MyZ3na9YqmxBI2AHCOkcPv3V8hpjlqdHj3l6K1l8/p4qt0W?=
 =?us-ascii?Q?3VjOiwewrY8Rz/eum5qQ328aQf7Q4tDaDoW+X2w5sOrISWBeBMG3epqYkMeS?=
 =?us-ascii?Q?45EYpva/O8e2liurZb3nIkUMfKd0ytVYG4WUO8UIhyD2B0o9mMOuiB5biKpL?=
 =?us-ascii?Q?VLQaB8KDxvDcMMJAIDmqZYuM5oI9rJEL036gJblplrvtlRcY+Vq/Vrn8oWn4?=
 =?us-ascii?Q?/KN1cMb+mLwmLxNbPNRJfEemzgBbGeRkTy524p4mrrgNEFBNk1i2gwacyAON?=
 =?us-ascii?Q?iVsux+SebI+1ub/d7kzMtBWTOSecev0gDmBJgZ5WGVAXMriQqgaDhd26jrxk?=
 =?us-ascii?Q?1FpkBR65AiXjwslDrRlwQG0Az978hgYghyCZNS3XDU/28HbR8DiOLHHPKoGr?=
 =?us-ascii?Q?GEtUVA3jTABxtzBRc7+kB1JAKgOlFeLoOBmDcouXZm6w0/ewwGMXDuCifhpy?=
 =?us-ascii?Q?VXQB70ylF7AEDe7UUsnQZXQp8A5TQbcapUmGEYE47q0g3uNtgPjSdAYdVTBm?=
 =?us-ascii?Q?9NU92xuG5HJmImgKXXld4blCKXYB6Xlmpr323pzeHUJNp1q6/rJEYoktdhNx?=
 =?us-ascii?Q?xtjBlY463aVeEZc/iSQ59c3NosTLP5B8+f9nn1IDJsxi5aKu1fm0/ooPRH7x?=
 =?us-ascii?Q?Hk66P9lL3pK3ZsihSysfZOjIpAAiMCj3vuiBnwceje4YVRMPU4Lg87wsjXLl?=
 =?us-ascii?Q?/zU6XZsn94A7w8MVCC87DgvjkcxNtujexFEifilQv1HiYjaUwdx/7gng44Oa?=
 =?us-ascii?Q?LVMHUwv92cIq46Qn/V2bF7O54WpYtFtAZFB+Nrqu9nKJ9hFVLsluyuUt1RWQ?=
 =?us-ascii?Q?eyn4URsjygnc5L9RO6rNmw8+EscFeChtkfMvMn1TIO1ApqhivzFaDQk+gVc/?=
 =?us-ascii?Q?lz/vCAApdNXDCl711j8epn3g6uGKqMa2qBMSwz9/WD27en9hIqOzcukv5ANn?=
 =?us-ascii?Q?wJ40ut/QN3xsiL7sCsSq8umwJIK+TokzWNTMRF9GIDMBXw8RWBuRbB7MnqQO?=
 =?us-ascii?Q?DmXi6Z+nGQEmAMXFW1qVs9sBMnTAfLKDaZZFRucCYmL6hu96zpdQiwB2QO+n?=
 =?us-ascii?Q?nxpV7IqBgdug59fnZSM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7142099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 13:21:06.4630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0821d583-bf95-49b2-3525-08de4def9d50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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
---
 arch/arm/mach-zynqmp/zynqmp.c | 46 ++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index c0398a466ff..6f61be3c6f8 100644
--- a/arch/arm/mach-zynqmp/zynqmp.c
+++ b/arch/arm/mach-zynqmp/zynqmp.c
@@ -362,6 +362,47 @@ static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+static int zynqmp_verify_auth(u32 *status)
+{
+	int ret;
+
+	ret = zynqmp_mmio_read((ulong)&csu_base->status, status);
+	if (ret) {
+		printf("Can't obtain boot auth state");
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_zynqmp_verify_auth(struct cmd_tbl *cmdtp, int flag,
+				 int argc, char * const argv[])
+{
+	u32 status;
+	int ret;
+
+	ret = zynqmp_verify_auth(&status);
+	if (ret)
+		return CMD_RET_FAILURE;
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
@@ -371,6 +412,7 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
 	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
 	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
 	U_BOOT_CMD_MKENT(reboot, 3, 0, do_zynqmp_reboot, "", ""),
+	U_BOOT_CMD_MKENT(verify_auth, 2, 0, do_zynqmp_verify_auth, "", ""),
 #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
 	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
 #endif
@@ -446,10 +488,12 @@ U_BOOT_LONGHELP(zynqmp,
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

