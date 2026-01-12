Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4DDD26D9B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44FEB83CBD;
	Mon, 12 Jan 2026 11:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dWQgPfJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BBC183D52; Mon, 12 Jan 2026 11:03:02 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4707F83CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GowZwqnzcZsvXi3ALuZvkWP6VTfXj18bwPmb20n3C1qGrCfswHHeTrhUuOb6amthhz4raoUpGUDUxleTZUFuXzQ6ydqElVpxyvnXiw2lMZSwGQ86RAnGxTRAFIMmOlK/rNlTtVdk5lqoDzOCTpEKBMSDWtUsN+BaPrlmM6IqCdq6zIifsb6urcUJE7oU2Vd4ejTKia8XqHn0y2WrQVHwZKrJQC6YFBSKvXwzEAB3fzSxwTEQ6ja9Axcyk+hP5bGTZv6dbpxMbzwPPXmw4ZZTK19AJzByXmeYiaCacWaY7Q7usNKRm8+zxJcEYX8mo5Hyhq5x9xmDbHjhZeiKlt2SeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhAdqXTF7cBkpy4wqt+fkEVWnOyiK1A1368bl3GXn34=;
 b=IEdMVwFbwtsO63vj4zY0zxuWI23LpazC9GZCwyPOXc6YJ73PXEYvPxcHYNjYRiKWqxRdDZBUKoCI3t+b/uOoHmP57MYtxTAqQugIh7kP7/A+uU+K5oAzjfx0RS2XSyP6XVS2Kxqe7nsrglPD8haUUgNQPSFsUHjE0z+pocJ1PHWVyu2zvEg2b7MG2pO/3C7RgEGmZPntEA0iN+jR5oawS6cRuCUeGBqiGtXxjrIFRhJbYfwVUtssOuaJj78u7JD/aa48drgw1xdUH/xcKazt1OTJWBbToOaZPnYou8Gv+hhdv9Z27eYpyp370K05tz8oo37PBIBIAjy9piOkFiayjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhAdqXTF7cBkpy4wqt+fkEVWnOyiK1A1368bl3GXn34=;
 b=dWQgPfJ5RZoeKICEd1xNoZtS5mGs0eJ6bYHJl1+anxe37aSRX0HE7q6fvJRfqJzQoI1cnSQUAa4RmxOpQz7UnErcQDYGK03HcZBn4YIeuD6DjhOkt7UGpikJctzp9LsexDOiUWGPZUHgzf4UrJXN3PkxJpyaFnI2C0xHKgwGN5g=
Received: from BY5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:a03:167::37)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:02:56 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::66) by BY5PR17CA0060.outlook.office365.com
 (2603:10b6:a03:167::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 10:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 10:02:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 04:02:56 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 02:02:55 -0800
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 12 Jan 2026 04:02:55 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <igor.opaniuk@foundries.io>,
 <tomas.melin@vaisala.com>, Neal Frager <neal.frager@amd.com>
Subject: [PATCH v7 1/1] board: zynqmp: add cmd for getting boot auth state
Date: Mon, 12 Jan 2026 10:02:53 +0000
Message-ID: <20260112100253.2778715-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: e98e67a3-dc4d-40ec-7a04-08de51c1c263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GsZj/w1UcwfZgj72FiDKiebG5HTK8K1aY1Bo7Cwt+2ZQjLX+QJg9dxQxfx8/?=
 =?us-ascii?Q?/hUuAyfXlwMD0bPrwJQnrvRZo6AW8njDN83hjeMUmoFPBPrU3MZ0gZKIQtwb?=
 =?us-ascii?Q?WrFYp33Jtz1wwJl4qFrzgRrw9HY4yc6y8mkHFS7G+WgRN5+XtsmBkF3tF3wA?=
 =?us-ascii?Q?pO2dhquh2QgS9PoD5rOMZNZDoAjs78b8XZufG5hxqW1lwiD5Dd1U6jQKe10+?=
 =?us-ascii?Q?iHWAOK3zeSytpH6dstvvwrmAIPF2Om3NgmDcPTQbYfqMkiq1Tkk8dG3Cc4Sm?=
 =?us-ascii?Q?ZdzBrsGOHcyFIPTZvvdXtti1PlfEU7o8izYt0/7d791fstZ9w5mUG1aPb1rt?=
 =?us-ascii?Q?dgsIH8Ht3+/m+neAta7R2KoQTpqxQafat+5lQEopKFgQThROaQSEfqjen/eS?=
 =?us-ascii?Q?SGOyo8jd3mbJDUAfeysTxosr1avaTOZgUXWS4aq3nbm0wbi6jkENh34eB2ZT?=
 =?us-ascii?Q?XOuCVXxMdO6FlKU7gGe7jOlWT3KqMWJ1wArtMMmKBjiWyzT54OxnGJDmu9Kt?=
 =?us-ascii?Q?Wh/wWsKJ9kvPEeVFz54CTAwAxhrajXPzK3eAh30ES3I4TX4xFpZ5imbnqjMi?=
 =?us-ascii?Q?GAdPfsM5NeGicMw5FwVRtR9NMkQz18etiL1gWgppTv/apk3D4XCMSjQeQutP?=
 =?us-ascii?Q?dlKcT13QcrGZR0Y90+3eoFmd+h0vyz9k6RDmB2dhvumEkJ3qmeCls/P2aHGw?=
 =?us-ascii?Q?pgEBBHApou6bgBkcK0+FGr3698O6XyFp3E72n2YxA9jnYPd9+augBkCp53CR?=
 =?us-ascii?Q?oCK0beV3ZtW9xr8xUaPNK+pfeqcoi4c8XeZWATPVyRrScZFv5ySse4kzu2Uq?=
 =?us-ascii?Q?cruDFyQk083UQORm257PbNiBclOSMfiwYUE+pJXLq2JmGx4kjHD+pf+Kxp+X?=
 =?us-ascii?Q?O+cNsTHYkCMtxmb5or3Wl5QmcvIhqxZP7U5zICuCA0yBWi9Mj3k7SKYH7oZ+?=
 =?us-ascii?Q?2SdbUTSJqVXwlNel2SpwJToUnANY5BOxW2FnPttfODXeRZjc9GLj6Ny5eEBi?=
 =?us-ascii?Q?wWU7zFS0tMogBsgpYv11+nzPjVlnq9uPtsyaYNVXEuYdgP0zHvaDxPmK0j6w?=
 =?us-ascii?Q?m1eCJpBcAOk0TCBzdufcRCC+mTHqWg+Dp4G4TMcavrHWtfTNZTi2qUVKOfXF?=
 =?us-ascii?Q?mfY/V7yfmsapMNALIB/OuZgkeJMoWjgcZ4lxp9Dn6oOS0DPvlX7kUvnEx1Vq?=
 =?us-ascii?Q?NixdrIF2CsXypDT4T1kIlfcgnlm/XxjCbs+Zxs8BMu3xxnmnP6GWoiYhh0xk?=
 =?us-ascii?Q?R3h5iFzPzMHbuBuIL8M0pVyhG0E5gwQYR+6tVmldZiBDIU2hjmT5+KatTR99?=
 =?us-ascii?Q?hUsXew5Rl9HxDYR4YodfxZOK2JpESPcltr+d/OJDfZN/LSgdM4jTS0oQcxkr?=
 =?us-ascii?Q?a3ifMdkxJJ2p0Jw+Q5dhKPy6rTkeIeQWLfC/IPjo6UEjBNyokl1AzeoS+qqO?=
 =?us-ascii?Q?teckrGxri8XbdCqQBCOX2LvTAsgRdMPT1o5qxNT/gELyNO0YQx2hxjYkIOMc?=
 =?us-ascii?Q?sy8s3ikxaUzWWuG20IP54AvOqGyTxpVrYBJAchzqrucEGBnqOBIhbLsyDge8?=
 =?us-ascii?Q?f/B1b4MT64Tg40f3SNo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7142099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 10:02:56.3944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e98e67a3-dc4d-40ec-7a04-08de51c1c263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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
V6->V7:
- improved help message
- removed unnecessary change to U_BOOT_CMD
---
 arch/arm/mach-zynqmp/zynqmp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index c0398a466ff..cea6f8f4a99 100644
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
@@ -446,6 +476,8 @@ U_BOOT_LONGHELP(zynqmp,
 	"	48 bytes hash value into srcaddr\n"
 	"	Optional key_addr can be specified for saving sha3 hash value\n"
 	"	Note: srcaddr/srclen should not be 0\n"
+	"zynqmp verify_auth - verifies if boot.bin was authenticated\n"
+	"	Create boot_auth var : 0 not authenticated, 1 authenticated\n"
 	);
 
 U_BOOT_CMD(
-- 
2.25.1

