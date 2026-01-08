Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750FBCFD635
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 07:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E263C83B87;
	Thu,  8 Jan 2026 08:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gwbWejp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D1EB83B8A; Thu,  8 Jan 2026 08:46:28 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE1A839DE
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 08:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwhJq6T4h9MUhiuS/m832Oum7YXi3rrgpzVeZxq81CwzEZHCgO2hVZc5+FqD9qbaZo0RzNQP16m2aQSTKdiLgO1V6wAqCS7g9GFHLlM76LSuc+W8JQ4rjtbXY77WmBFY0jfb9KNPwxFSmA52iNcxVs1kW5IbmA+11QP/cyEJzbwqrEx6leLW+gHZwzsphDFjcpoStv8bem+oKUdsmR1LyqbOC6rpom57GIeQJavAoKAiXChBeFAfXCaIWAOqs2bZv1ZfOkKwpDmhzj/wsoj2velj6grKmVrYt/YTNN2tBbWjGe3j3FEGC6ANd2cz1h+jWFzqQPKbsbINpCZyiaQZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixMlCWClcTHU+NPLdPuaNS3QtrjCpHtw2Ki5zUArDDs=;
 b=csy5M7296jDvbTbN0Bvs3rVMhpiTSF6DOTy2l9ouBriefqOsoxJ0IrcLk0hKM/2Bc9lzB57xNIu5l2/RNFCPrsWckWdemoOoH97sv1TurlRqiGxKFVPsxEGBW81/ghm/i+LTRz+2uhuiT/WiJR7YRrsE8Bc1/OvJTWe22XsUsIQPooPm2trvpM7QCXLGg+SQC9Tm13KlXekn4DKQGDzYxQv8nHge91u+NHEc/3klC0teyHVpfnKJSsG+DSci3PjuqRoeXPVhwsHctL+wELVMwhdd9QmMR9B3y9e1BKatD18k9Ior7ReuW5VBdlaXb2IK9LMmrvUQf3YzxnyOIYf8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixMlCWClcTHU+NPLdPuaNS3QtrjCpHtw2Ki5zUArDDs=;
 b=gwbWejp8HBl+QIg9rfeveSffdtjF55lOMzocUzTZ1IqrrLAChypp44P7Sdcf9ktZ1pWs3hRdlHeR7lrLmOafckFsp0R65Gr6XOOmP6HB1pWTmV8IKZfRFIr2lJEWU1zPQSs2yoAO8Za3QgkWvU4OwVVQXKgEO5h9Vpfwq2jq1Nc=
Received: from MW4PR04CA0241.namprd04.prod.outlook.com (2603:10b6:303:88::6)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:46:04 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::19) by MW4PR04CA0241.outlook.office365.com
 (2603:10b6:303:88::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 07:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 07:46:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 01:46:04 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 01:46:03 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 01:46:03 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <igor.opaniuk@foundries.io>,
 <tomas.melin@vaisala.com>, Neal Frager <neal.frager@amd.com>
Subject: [PATCH v5 1/1] board: zynqmp: add cmd for getting boot auth state
Date: Thu, 8 Jan 2026 07:46:01 +0000
Message-ID: <20260108074601.491837-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: neal.frager@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: d36c9269-95aa-4dd7-e224-08de4e89f9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ih8OrgiH625YumdRfg4hPbL1BioqlQ/uzcqL60nhRKUqCfAnH0K2BiX9N15c?=
 =?us-ascii?Q?tca7ac8X5zK380EjvtaUqDqPzfyfjXnbSAWUbU2+6YB4LUBdblgcZu49NeFn?=
 =?us-ascii?Q?9aNxAyieiwfckSYce5TsKVDnjp7v5ZAgN4BKf3eTv2o7ZdE32fRQ2LCpRF4R?=
 =?us-ascii?Q?KS5wzmPAfM/ClJcVExa5pGNVGXqYVwYD+UTxPp3OtjrN92sfymQDU4Pmlbbz?=
 =?us-ascii?Q?r0qGFNECTOv0YdJjFJ0py5MYbl45Uy7aSFn8SfBkBsDS9QG/oOAjwAF3p7dK?=
 =?us-ascii?Q?dVS5Uv+iOvSNOSos8ikibYGvX2XkOkDG8nPXaNEWkkxgNjcUSz8GP6GGWVQh?=
 =?us-ascii?Q?WcO4VHL5D/E+N/9mEe3u0nrpzB6FikgAbf9wBQa1lWMuUIgNSt+UtM/g2hJw?=
 =?us-ascii?Q?N1noIzpSYSUVHoKdaIbCQ1UpCdweak1Ahi7bp+PAJwxWOoFUZLnxk3AautmV?=
 =?us-ascii?Q?gEb0QrgBuWEfEm1YQeZPzUmmlQL6hDpbAlKF8uXfLUBOEvh6o1ckj1cGmwlv?=
 =?us-ascii?Q?A7Xtj88LPa02gjwCS7U9UXcncutgplQulTIKLoGB1FBv5wGyFqbAejyP3Q0r?=
 =?us-ascii?Q?iXVrqmM3jodhErfUBcSU1zbZfitA375ZjdFBn/Wwe8+AtMDJwp1i9M7Xr3b/?=
 =?us-ascii?Q?laNr76pqQpZT+w+/r8hSiEICzPmWnmGPed1VBCtxuDsxn73q6Mfb+h2KYjnB?=
 =?us-ascii?Q?XuI/kPD5kn4bnwaGIm0udZei/VFrItqAkNp3qFyxkL7Y8uoOvXBnrsQCjrjx?=
 =?us-ascii?Q?g1SnFYjNmCtt0ojJMRZ/hELfUuO8TtvgWbhAaNbNZtkeIaCPR4EAb7jh14sW?=
 =?us-ascii?Q?v17m6WBU+wv8SatZlJO+sN6HCOd1XLDWXGh3a00DXe20Mw58VOKPXoy+Va3J?=
 =?us-ascii?Q?W2Up3OiuFhF5L4zCHSCjK6P5oQJ2vfBu+DpCXlfToBTq0pJXsxtyN9ESOnTr?=
 =?us-ascii?Q?aKypGrbstRRP4OeYRVcR0gj9xteuSy6uGuqaTAz7aKdxZx914QNLH2nXMPmt?=
 =?us-ascii?Q?92gnHQ80m951AbrlK+vmUROzcx/JG2RVdb66VKkSOf13ve/LywbNf/TW13qF?=
 =?us-ascii?Q?65Sg43SHcew5y8lVl9yr8az4Ltugwuj8CbvUnJ8LayzX8qUfHnTqvSSN5Hni?=
 =?us-ascii?Q?XZOqQZ9Gmr7qKBF8b6i0W/nprY4pU189ClMSYCm++WyHl+9YJzBl9eXeQt1v?=
 =?us-ascii?Q?1Bslr8IPUTdVh3qfQS9nEvLAtWqHTXbnyN+LNGLMkhFtXHdGawsPPgr6x+kz?=
 =?us-ascii?Q?eaJoRQLRHnuzZZmZY3a06tmA9uCvSHpoXJaTj3AfaG/xCo8T0erSGln233TZ?=
 =?us-ascii?Q?beIMe0a/zvfR//0//kwucDQIJByXVdjQD7vIbf/aZWezkCmFSzKwKv5GOcd6?=
 =?us-ascii?Q?JpLJaKojsHxzavun3kjWdBZ/o8qi88YuR+ZAijLkwcL8KGryIYojX3hC2saS?=
 =?us-ascii?Q?RiYqSM/wMMA1Qo6mzo+n1uhDbeb2CHlrigZjbIgAyg3qAtoTRVGHhwrBwd2W?=
 =?us-ascii?Q?dv/3emFKAqH3TG7fNgkkdR3LTlRgI2OBxk6N0N4IPrsRu55tbnhcp15uink8?=
 =?us-ascii?Q?A2kFRxYlGAZL/13yNtQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7142099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:46:04.4053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d36c9269-95aa-4dd7-e224-08de4e89f9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736
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
V4->V5:
- added newline to zynqmp_mmio_read error msg
---
 arch/arm/mach-zynqmp/zynqmp.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index c0398a466ff..bcfbe229148 100644
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
+		printf("Can't obtain boot auth state\n");
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

