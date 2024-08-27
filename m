Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681E2C54735
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 11:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A9C087E9D;
	Tue, 27 Aug 2024 13:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ClT8Aakm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A1387FA7; Tue, 27 Aug 2024 13:56:30 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F8087BF4
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 13:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gO/d0QrCJNzN9pb3Y04FhNTB0w4Cutw5sc6F2XjpSOUN+Sxbg9vP71n2p+RhUDIWUPvP2OsPyFXCb8yMC6+Ja8ORZc28CKArSXXV7BUU4fd3Y2J9nj5GZEy/iZKFh61NW8w64cXo/kL4l/zY1a2LpKHFjwAw0Yjz+hulxDI3nDWnWIB57gz6JvqNMEODcFsqVTz47bWNxVouhU19qpwnwZH128+tBn7DC98IGB074fZjSC9RkLheAs/w3xiIO0HoZIqgqKc7CTPxL1zrBm6BXdekzFYFOybt4eHwFKKk8gp2wVzouIXbvGLMZNaHc38BRSMEwp2HkxQwvmNMVhReMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5VkcNLY1LQSfQ5NCyLo5eMt3pzdL/WQRrS1/DwczGs=;
 b=DJKyhNUTG3FBYuFjo0uLo1vSIlBz/4ln7f/Zzj1cCAmgwmYrd9BeN+uuNmf+urKD2k4MkJJHdoCzYONOiaYMZpNFu+g4qyQc0baCYf4JfhqweyZg6/lOZ2wG6diJwdEFHjQI9Gb2Hi7+/r7/gVo5j2/wHB0DaWXDO9TWpLxTP/QikRCfN7U4K2BsSZ4VKxOj+9/tpx031RbVebyl8jhrLKLgyMmjN7aJsUJug0Uyjv3NhJA9SMvJqzjdKSAdomXRbHCaFd09SBpympCY6t3/lHezAvNDHNDuSvY7MJOx776i3amqBQa4+EQuEhhw+N0oOYd1mjlK66O/qx7vYFVRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5VkcNLY1LQSfQ5NCyLo5eMt3pzdL/WQRrS1/DwczGs=;
 b=ClT8AakmeY5d2LbYs5ongrtTusxk9hMqES5JWt8hPh8zYHpYhejUR7ms8GwNaJ8QMWFMg7LnFb24H5ItmlhhHE1jf3yHX+EAlFA9jCMyeMuP3Ok1MCNml6kv7lINSJpSv688lpkOzXPJQDmIo5SoDqNqFvPQGUf65UZzBMQGqrU=
Received: from PH7P220CA0160.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::18)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:56:24 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::a2) by PH7P220CA0160.outlook.office365.com
 (2603:10b6:510:33b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 11:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:56:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 06:56:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 06:56:21 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 27 Aug 2024 06:56:18 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] arm64: zynqmp: Add u-boot command to boot into recovery image
Date: Tue, 27 Aug 2024 17:25:30 +0530
Message-ID: <20240827115529.2931334-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 5048cb7d-af31-4faf-c539-08dcc68f45a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZrRAaJLJ25CPkyKV7CvvCVBtvWME4eguH285o5VxYmZoB0jpyYW/GqtAtt0p?=
 =?us-ascii?Q?PXty6ufeAHxoOdDF4+LG3y8p0XYcgw5A1XB+6NHwSZVwlzJVA7C7/7iNlYDo?=
 =?us-ascii?Q?BqVn6c5msXOkSqKPJrh+7ZH4RAEi3H6ceGLIHh7Pz6qAjL0drJM/NOjLiUtc?=
 =?us-ascii?Q?g2p6Lv7TDKelpcn/dmN5klpQEGsuIiS8S5UBNTzWt+NLhMhthUKWbwpfK+ds?=
 =?us-ascii?Q?a0UD13r6Ryr6p5WOCSWjEFMxAtYdvD6XSupZ4WvuFZ/x1C1qI62HLIT0UJ3+?=
 =?us-ascii?Q?61ixo8r4Ds+vRcpm2NwzeI6fSy/QVrRh6Y/ZZq1IgAomAMtL78BiYkGVfS72?=
 =?us-ascii?Q?u4N/DOa9G6u7njxdGyjSDU+O2Eu1MJ8okStutjedOMpZv4EdnLM8AHF6lVw9?=
 =?us-ascii?Q?6KJRnRUcczVeqdP9+AVI5FHqf53g/bDhUlfxSKK4um5zo9QtOUJuMtDVhDBG?=
 =?us-ascii?Q?KABh1oY7xWjHtpMg9gwpY/DRVj1qJQuHbHhM4nUhGOONh+5dL7KdzkaXI0Rf?=
 =?us-ascii?Q?XH0W4Oki8/ofgpPdfrKP336MuO27W5rxusvMd+E3opunvV7XmIh1a6/VHRVo?=
 =?us-ascii?Q?pjVpqjzd+s2w7vnGzG6P3MeGkzkrWV1cwFquhW5nXkk/sHLDjMa/WcHh7Exj?=
 =?us-ascii?Q?afwnmH6Lpegbw/O5ypngQa7+F53SDztsYG19QgQlobOncZcbIGiCPZYksziy?=
 =?us-ascii?Q?AfSvVudnXARKcfYyTQl/NzHkjV2YtgrcZYOzkzZRDq++6XancHy5vNZ5W3R2?=
 =?us-ascii?Q?cQsDAjehQnZM/QTk3DZ5U0IP78Azu7uo7KblFxr3DA3qcG6wIUiuISTIftSA?=
 =?us-ascii?Q?12fDWLv2cwGjhI0QQVLgox30qiMcpwmrWwPk6i7pJ4aKiwJZQ9fIyibw16tC?=
 =?us-ascii?Q?TJaFIKEsFVWE3RJHgsardUzD+bokcmeryw1DlDFDlt/dKkYorUQ8h2GORbsF?=
 =?us-ascii?Q?4cjuf5PwMNShj2SzUXfvoS1CIl3kzEA8hU2hpVcEFbsmo05/ehW3dA2RefTg?=
 =?us-ascii?Q?DA6PVGsARUqDaySYtQLpdn1ZzG9oX1nJWCulo4fkflMAiN+hbU86DQEEaBZs?=
 =?us-ascii?Q?0Tu/eiEeXgNU2rclAqLA003PZKgkdy7zAa0XmyH0ybQeeHU4sZ4DyWfxdFrO?=
 =?us-ascii?Q?jVqjSwNLCpUW7t0h+2ApdskKYEO3dmkbpsIIG2VUJMER/wqY7ge5FdWua44v?=
 =?us-ascii?Q?qlWOGXfV0eRsxtGLgMCtARAv7ZMR6AODPT/4DEaTzTMKwJ5PvHyz/4Ouz3sg?=
 =?us-ascii?Q?WgalDXXIAdw2hSeVlB4UuktO1Sto4CVrtxPXZ0gO01tJC8cponUh1EmfOzzq?=
 =?us-ascii?Q?oNwuTwCUkxktJtdZImf/+xhRuOIzAL/AzsjYYgcwcpWkYgRM7ytjLy+pfE4P?=
 =?us-ascii?Q?NMK7WZMuRo2k5kk1R87k4JnIJ6Z76eS1FgoCZX58BiKo0QRKhBSrSMtvR+5Y?=
 =?us-ascii?Q?NAOrw0hxIMOQWH8hje4qp7OAHiCUiJY0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:56:22.9501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5048cb7d-af31-4faf-c539-08dcc68f45a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046
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

To boot into the firmware recovery tool, the user currently
needs to press a button on the board while powering the
system up. To simplify this process, a U-Boot command
was added to allow booting directly into the recovery tool.

For example:
ZynqMP> zynqmp reboot <multiboot offset in hex>

Co-develop-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Co-develop-by: Prasad Kummari <prasad.kummari@amd.com>
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 arch/arm/mach-zynqmp/include/mach/hardware.h |  6 ++++-
 arch/arm/mach-zynqmp/zynqmp.c                | 26 ++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
index 8cb6494e52..9228fa3c80 100644
--- a/arch/arm/mach-zynqmp/include/mach/hardware.h
+++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
@@ -42,6 +42,8 @@
 #define CRLAPB_DBG_LPD_CTRL_SETUP_CLK	0x01002002
 #define CRLAPB_RST_LPD_DBG_RESET	0
 
+#define CRL_APB_SOFT_RESET_CTRL_MASK	0x10
+
 struct crlapb_regs {
 	u32 reserved0[36];
 	u32 cpu_r5_ctrl; /* 0x90 */
@@ -51,7 +53,9 @@ struct crlapb_regs {
 	u32 timestamp_ref_ctrl; /* 0x128 */
 	u32 reserved3[53];
 	u32 boot_mode; /* 0x200 */
-	u32 reserved4_0[7];
+	u32 reserved4_0[5];
+	u32 soft_reset; /* 0x218 */
+	u32 reserved4_10;
 	u32 reset_reason; /* 0x220 */
 	u32 reserved4_1[6];
 	u32 rst_lpd_top; /* 0x23C */
diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index bf39c5472e..3b4d9c60e5 100644
--- a/arch/arm/mach-zynqmp/zynqmp.c
+++ b/arch/arm/mach-zynqmp/zynqmp.c
@@ -340,6 +340,30 @@ static int do_zynqmp_sha3(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
+			    int argc, char * const argv[])
+{
+	u32 multiboot;
+	int ret;
+
+	if (argc != cmdtp->maxargs)
+		return CMD_RET_USAGE;
+
+	multiboot = hextoul(argv[2], NULL);
+
+	ret = zynqmp_mmio_write(0xFFCA0010, 0xfff, multiboot);
+	if (ret != 0) {
+		printf("Failed: mmio write\n");
+		return ret;
+	}
+
+	/* issue soft reset */
+	writel(CRL_APB_SOFT_RESET_CTRL_MASK, &crlapb_base->soft_reset);
+
+	/* never get here */
+	return CMD_RET_SUCCESS;
+}
+
 static struct cmd_tbl cmd_zynqmp_sub[] = {
 	U_BOOT_CMD_MKENT(secure, 5, 0, do_zynqmp_verify_secure, "", ""),
 	U_BOOT_CMD_MKENT(pmufw, 4, 0, do_zynqmp_pmufw, "", ""),
@@ -348,6 +372,7 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
 	U_BOOT_CMD_MKENT(aes, 9, 0, do_zynqmp_aes, "", ""),
 	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
 	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
+	U_BOOT_CMD_MKENT(reboot, 3, 0, do_zynqmp_reboot, "", ""),
 #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
 	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
 #endif
@@ -387,6 +412,7 @@ U_BOOT_LONGHELP(zynqmp,
 	"                            long at address $src. Optional key_addr\n"
 	"                            can be specified if user key needs to\n"
 	"                            be used for decryption\n"
+	"zynqmp reboot multiboot - soft reboot to multiboot offset\n"
 	"zynqmp mmio_read address - read from address\n"
 	"zynqmp mmio_write address mask value - write value after masking to\n"
 	"					address\n"
-- 
2.25.1

