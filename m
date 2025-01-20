Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A56EC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED54807B6;
	Mon, 20 Jan 2025 14:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fdcH588u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD818076E; Mon, 20 Jan 2025 13:44:18 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B2180758
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdHEQAdQRjbVR3GpTA3SAx3lCF/qqSQhx9bt8jmyrf2ZwfeTZv57KHdOQQLKtCGPC7U09l+xNs5RWxU3X4hFHr+phpiBUfXw295NlEyQSbw1/1bhI1IReTRG/OOghc/h30DJSRiykQ10qAPqJ39Q8+Hz7DFKmAoEcQAb9KK8Oq0kgTV9rePWwM+aOauqD4z0pIKNzzAmgqHYgSDo3dBbE8mCsHJ/AsXTKv1TQg53ZnCKPcaiM4rPfjbwyszcPKxhUXM6levnmdx2B1ufSb8ysU5reeRWNxTI43MkVUhs8O+K8Nbx1Gqqv4GucDrryWJz2QiB0foCI8z1HazBRk8Fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2Jmo3ihiU++j2tJK2AJwV6Too0ViKR9sWDeXhbheKo=;
 b=TGocrwTzTwepDPU3Axd4F/T2uTP+S7s9MfLABhDSgeabt7Echqbp24pKS+9KU57FWfaexi7srmXHLpJyqRBmYHNSvmfP1RjQdoDoQrqcLGsATKlS6FUN2WNQRAH3P9ucFAeCACP31hmrrqb4uheObB4+MExeHks25agM6l6NTMXdxq+SDhKUzjyv7FmJkMqfU61K9n+eOnNtDFeFy4CHyRPTa3SFKnofHHKXW1H6my6UZmWicNSP59/3//0Wi+W4R1MZRgHq1mdgXlZAcafa7finDLYGd1HSiOeP9UEOYTtbksOdYORgZ0ELcPolP6suDJMr/iLBOy1KiZkYn6JEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2Jmo3ihiU++j2tJK2AJwV6Too0ViKR9sWDeXhbheKo=;
 b=fdcH588u9q+D/Bc+/ZqPjJ6a22vJATRbH91jSkywua9qUDUHCW3Zv1xVJ48252wte6smx5gHC5N+0W6KSWpEEZH8XLK8qZl9bksq/MrK+YNh9P/emrjPOIR/ECm/FsG/D9cZ91WsHSOU98+RKEkihJ+oyY3CAfLoxrdvhYUECqQ=
Received: from CH2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:610:60::32)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 12:44:09 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::a2) by CH2PR14CA0022.outlook.office365.com
 (2603:10b6:610:60::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 12:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 12:44:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 06:44:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 06:44:08 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 20 Jan 2025 06:44:08 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v4 4/5] fpga: xilinx exclusive commands
Date: Mon, 20 Jan 2025 12:43:53 +0000
Message-ID: <20250120124402.1501320-5-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
References: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 9318f09b-f402-4d39-f2a9-08dd3950229b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1xgA8gb3ye1ttNKGisl+CaM0oTG6odAmRVUhdGnm0cBmSYbxINKyRWBLMVUz?=
 =?us-ascii?Q?9gGSReu2Jt5F0v00+w6Nzv/KksXy+oo+P1LS8mesZPddvHBKxS4rIM3olV4w?=
 =?us-ascii?Q?Hi06idtGgJFhvpLI015S29hL6Eg8FytmC7T8qGVergv66rXXeRghJoXi73vr?=
 =?us-ascii?Q?2AzhX13RUpMXdZl7AgBlQvLTgP0V05hcYVlVsmxX32c75akROq3dPOsvO5HK?=
 =?us-ascii?Q?Qh94myUDFq6ezJcN0utbJHZ9bLhj+llqwTTUE+ItlCMQ0fug357RqeA4vO8L?=
 =?us-ascii?Q?+uGbJYB7YHQLp3+VADBbzMLQfDIOQKMIKXmiPsWApbETgZ1BC0Qv0xX7/TMz?=
 =?us-ascii?Q?FrufIwxp3ZHY7yC6VkEhCut//UzSeZ9uum7JUnMVCiolvPKGHjL9V6bUj9F2?=
 =?us-ascii?Q?xkEXkWJKBaVP5zp6Sea1k6mnAiE5K7/XF23TGKOxggP+SAytZIzNvKLdOpAa?=
 =?us-ascii?Q?HaB4Wai9StAbDVPUzs1wF++ZaCaAI1nKGFEojwbi6hcB4gFV3VmvvdghYoqW?=
 =?us-ascii?Q?EmSdknQ+YBO4F9M4Tkmfpd6gyoj/0VOkR1HiJgG5XqCdOjCFIxs2UCEdLc5L?=
 =?us-ascii?Q?1P4GLYXdxvi4fYkAKjYV+is4ESPP5MKqnWFstzkG07o0s2wEmaLdeEQwQ8DJ?=
 =?us-ascii?Q?2VImnTQKp0xUlR/us6OoofLaNcVP7/0d5CySoCJBh7H2VwJqNb35/DsFY7Ks?=
 =?us-ascii?Q?ZyzMhQU/VYBs63IWeEYcdFhWp15/MKpRf3vGSww7CroiJssjIhmFHKzUt3h5?=
 =?us-ascii?Q?yrNC6CIY6InxojVTpEIHllOgU5oITvqoCoviubHx4QSGjZb9inOAeyhMY/Yj?=
 =?us-ascii?Q?me88landEVijqJ8UY+gUtA/nZ9ZShQIcQLgHXuOh4w4dU06UVrYcnS0hFVqx?=
 =?us-ascii?Q?jvyow+44e9R0mETc0CzxP0o5hAfX0GyV1pbXAZs70x5QK0LiSaDhP5XKRzGr?=
 =?us-ascii?Q?MHv1vfIINCahAnjR3xPJiLCaqwKyVhquSeRB+5k0PFbPte8nsiu+uWlSfijW?=
 =?us-ascii?Q?jQPNW8u0ICz6X5IJYhz5txK9N4kcOQjzivpWHIMmtVdcbaU9/8ZyqVSPbGrj?=
 =?us-ascii?Q?XzucNsWyjkFCsusMGprN7om6fZxmRKiyKXsRzU4v34YHvLaSkB6X1hgPK7hf?=
 =?us-ascii?Q?ELmQ1w9f82NZU/LXZcelH7rq8nUubhW0HiZTOuPLW8/5+1/3NCKHbi1oA8rc?=
 =?us-ascii?Q?L/0DxuMoFzPBGMoPxqbdlG4JdK60RTevvop3QaqbFLyy+En83CSSVQiWlqtC?=
 =?us-ascii?Q?orc4s7ptEu2j/sFXLUahZ79OKMBBT7DUmEG0VmR16taTzoQ/IgRKGgq2E+C/?=
 =?us-ascii?Q?PUMKWP0jwl8PRcx+XKRAllpCRnxb+uGJyYWjOoFX7U/dXMpro7XiFEAnOeUA?=
 =?us-ascii?Q?XZczBobMO6VR/PN/sHjUVTCN8kPLie0+dbP9aWuVd7YZb6hH1hCAUU5DOs4M?=
 =?us-ascii?Q?UpUhTGfnN8zt/w/ZDTsxvGITKgdaV9b04qPAR9DwB7rNBZ8ZHut5ylXuzAm8?=
 =?us-ascii?Q?2MKNyA73EKi5d24=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:44:09.6509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9318f09b-f402-4d39-f2a9-08dd3950229b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787
X-Mailman-Approved-At: Mon, 20 Jan 2025 14:08:43 +0100
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

Ensure all Xilinx exclusive fpga commands have a KConfig symbol and
dependency to FPGA_XILINX listed. Remove (Xilinx only) text from the
help command.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

(no changes since v1)

 cmd/Kconfig | 10 +++++-----
 cmd/fpga.c  |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b362595af83..c9600498787 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1187,15 +1187,15 @@ config CMD_FPGA_LOADP
 	  a partial bitstream.
 
 config CMD_FPGA_LOADBP
-	bool "fpga loadbp - load partial bitstream (Xilinx only)"
-	depends on CMD_FPGA
+	bool "fpga loadbp - load partial bitstream"
+	depends on CMD_FPGA && FPGA_XILINX
 	help
 	  Supports loading an FPGA device from a bitstream buffer containing
 	  a partial bitstream.
 
 config CMD_FPGA_LOADFS
-	bool "fpga loadfs - load bitstream from FAT filesystem (Xilinx only)"
-	depends on CMD_FPGA
+	bool "fpga loadfs - load bitstream from FAT filesystem"
+	depends on CMD_FPGA && FPGA_XILINX
 	help
 	  Supports loading an FPGA device from a FAT filesystem.
 
@@ -1207,7 +1207,7 @@ config CMD_FPGA_LOADMK
 
 config CMD_FPGA_LOAD_SECURE
 	bool "fpga loads - loads secure bitstreams"
-	depends on CMD_FPGA
+	depends on CMD_FPGA && FPGA_XILINX
 	select FPGA_LOAD_SECURE
 	help
 	  Enables the fpga loads command which is used to load secure
diff --git a/cmd/fpga.c b/cmd/fpga.c
index 13aabc95abc..75d2f824998 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -420,11 +420,11 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADBP)
 	 "fpga loadbp <dev> <address> <size> Load device from bitstream buffer\n"
-	 "             with partial bitstream (Xilinx only)\n"
+	 "             with partial bitstream\n"
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADFS)
 	 "fpga loadfs <dev> <address> <size> <blocksize> <interface> [<dev[:part]>] <filename>\n"
-	 "            Load device from filesystem (FAT by default) (Xilinx only)\n"
+	 "            Load device from filesystem (FAT by default)\n"
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADMK)
 	 "fpga loadmk <dev> <address>        Load device generated with mkimage\n"
@@ -436,7 +436,7 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
 	 "fpga loads  <dev> <address> <size> <authflag> <encflag> [Userkey address]\n"
 	 "            Load device from memory buffer with secure bistream\n"
-	 "            (authenticated/encrypted/both)(Xilinx only)\n"
+	 "            (authenticated/encrypted/both)\n"
 	 "            -authflag: 0 for OCM, 1 for DDR, 2 for no authentication\n"
 	 "            (specifies where to perform authentication)\n"
 	 "            -encflag: 0 for device key, 1 for user key, 2 for no encryption\n"
-- 
2.42.0.325.g3a06386e31

