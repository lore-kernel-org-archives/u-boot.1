Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B36CC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 752DF8082D;
	Fri, 17 Jan 2025 15:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rVio28PK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 050E080716; Fri, 17 Jan 2025 12:26:11 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7768073F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 12:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEOxwLv3kSpRS7I+fcsJm9H8htOVqvi67vjZ37Hu/B2S4+O1BpZpNNhFACOGD75oFYqALrSc16QoMPt+ysc4KmgI030ivfbu99Tvfa5SrfeX42p4CrQR7d97WRkVGVehHycPPnBZn8rx1Bj2/w6IBV8OsZ74vOAxQhIiYrMf/Qk+auY0W9mlLcIkkIJigJ9o1nQjXoAz7tykIonTgaCchiFssB9uT2UTEO1lgYfrw03iNnCF3CZe8y8+f3Z6LIP0bxAGVpJvP9P/AjIMvBAas71AnIjDTkSQGZGfbVYPVdtvKCsEmJp+cN4KVfHyeuxwCQ8mAfjC0x9Ri8sOfeNHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEoBvhehyKpJiDegAkcRY1nGCe6EaUjjd0uQuOJ2y/E=;
 b=CC4bqeLs1xqcaMQ+rTeNjl7a2AKloNJ+1wU3RspDJSRxFhvqxSYFKrNklo6HpH/ji/Hf1bJ6Ad/ebxk1XVDOAfp6k/qfT90NZMROkwMeIx0ssJOl1a7NhHHoIW8m8ZX9YKT/p1lgmrl+d5OZlELUpdYf9M6khSPcJ/qrk7ObQpf/DIwsoISPsZgBM/hK5U8DueQ3TLFVwJ6gv6UYBIPrBPNkz+3wCCWEnVsVEbkqJpQJEwLNNhHkPEkm/rALlCDouA62Ob8pK1006bOt2ZtRmYdq0WOazbtXSRoXpZPXv81Buq3MwIspGVTT0Do+thzbp+VqBzRS+fmkETEG5D1xiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEoBvhehyKpJiDegAkcRY1nGCe6EaUjjd0uQuOJ2y/E=;
 b=rVio28PKI5oj2RUQdA+aHk2Qpv3aJCQwUO879WtwKECNurzZ+9cbwCMa3YDCgWVgMNa8/pQIDGNZLWRzgXWmGJXdYShQy/GraA/zxH3o4MbwYyKPpkBJXSxvfx+bx8slsKhsLjGWqa5lcFL5+IfHFfHZCqDO77RKKfgJYBkeP/4=
Received: from MW4PR03CA0345.namprd03.prod.outlook.com (2603:10b6:303:dc::20)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Fri, 17 Jan
 2025 11:26:04 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::32) by MW4PR03CA0345.outlook.office365.com
 (2603:10b6:303:dc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 11:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 11:26:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 05:26:02 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 05:26:02 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v3 4/4] fpga: xilinx exclusive commands
Date: Fri, 17 Jan 2025 11:25:51 +0000
Message-ID: <20250117112557.3729416-5-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
References: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: eb217585-f97f-4d8e-b91f-08dd36e9ba78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?unwmoC6ujWOn6roPWg9nqqJWN5dYQMDdljjsiW3pg03VzvO2l1B5KM6vODPT?=
 =?us-ascii?Q?OQcanok3O6HNVy7GN5vV3CUALnI6iUsea2DDkNkX1++71cEF3kOZ7Ra+wilW?=
 =?us-ascii?Q?jvI7g6MA6+ikelKZeStUVK5s/t2+KzIPWPlUMkgfdGxulYdtbysAFDc0nDkt?=
 =?us-ascii?Q?ikg0bX+07xTfb3IX0qBAqBUiVfbg4xLcNAnjAqJ55TB+Ej5dG5FuNM48v2EI?=
 =?us-ascii?Q?CmqRA+UUp2N5k3psAhKzynIpY7VxwIX3dpZ0x9493aUVIeiclntFo3lXxH5U?=
 =?us-ascii?Q?9iC2uLtI8wgVfEtuv0EGrioUNtWqqnZKUTpRanqarPWun/tqY9dHEod9s5O4?=
 =?us-ascii?Q?r3ISFUDrMsH4ZzcDGd9Jlo2NTfXJW/0i2PjpHZmkD7X3+geP87CZnaZWe/XB?=
 =?us-ascii?Q?pwfWRrjMWgw6PYjmjaeRfsoW6iGB2s6fDgzykgmyhYgftLF+H6mB2oyhc+nX?=
 =?us-ascii?Q?8dvhJbXrTwqHUJkUPD6yOHNqX0knzm+t6cWLshvepRx73QCHIRy20kX3a4yJ?=
 =?us-ascii?Q?7RvPszjrVqIGGhm9AUJCunPcGa9TBMs58yleA/Gx9SUP/JYhqmgC5uFUtPDK?=
 =?us-ascii?Q?rkSc4rxs3VCr3LkOTO/1m8xZ9gntlxmxHKqMI2M/J7i1071zCTK/+So32N5A?=
 =?us-ascii?Q?+18RRqiWgIeDCuN+m4yGgNP+D0EVc5UAZE8USmIeZET115QPVSKH5BwOrkE5?=
 =?us-ascii?Q?vtWEbN9VU9HR7B69MDE/sr8ysgtGsNGb+5qnstlVrtnVP+pbXeWHI61SiByN?=
 =?us-ascii?Q?y6maCBmui/JWA4MJrrMKnp1uUVJQktgW61Uz12sZclEmBbfCLbuJdLhC8KhM?=
 =?us-ascii?Q?CHx9WOT6+DQXFYo2HTCXPJtuJppknl6FzQ8inDZZn2ygyh1ilVepq5VEJ7io?=
 =?us-ascii?Q?wu6hCDnFu4cy0EdZ48xekEF0jlsWj3DVGNFM/EpCRsK38S5SEO53lvYM8ay/?=
 =?us-ascii?Q?s5b1mVrvauM+i1C4r18ICyKYlA2AXirHSEmRekN6laRhXrrfhJJ6e+C/YOp5?=
 =?us-ascii?Q?9Z9+mmcwBF1QXhmj3zVzoOfiN5rXBiG9nPEkx9ANp/zAYze5oj8ed86AKTif?=
 =?us-ascii?Q?h3V88YZ9PK64Bt7VEC6B2mAIpGevpLwO7eKozpXWgcO1c/f3zYSKp1yoCQtP?=
 =?us-ascii?Q?Jwmvby1uLsmQu9+6H0q+7DJ50rrfKApjYTrxfPeN54YWFj0tC4Io7plUfa0o?=
 =?us-ascii?Q?jMLrqKXMFcbIMUtvPgBTpmm3G25S7GICpNN/bOEVW5jIXDc4NZxRJ/6V9aiF?=
 =?us-ascii?Q?6pRsZEnTRF8wtT+NqN+psOaFaOt64SY6OI1rSRHWKTj9pIqc3XDRgkT7m14W?=
 =?us-ascii?Q?VeVIiyQmN9Vkik43/K2kNjFkRgugpGzPizyE5LeSc/dImYUiDL4kNlhFCvBn?=
 =?us-ascii?Q?yTArEooEvPik3J3Ud83biGjJlYe5CjyPxH5+pjf6BZG8zxc2r69K/n6+UdXl?=
 =?us-ascii?Q?EOrtMgH6Xtw5nkwdUtF1nfm24KgUz1WwoxtEwuMtQ8thpXzV75D/6NKaUxL/?=
 =?us-ascii?Q?4QuKUfDkLhWlAIc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:26:03.8669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb217585-f97f-4d8e-b91f-08dd36e9ba78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:41 +0100
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

 cmd/Kconfig | 16 +++++++++++-----
 cmd/fpga.c  |  9 +++++----
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f3ba230db42..822adbc7da1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1163,6 +1163,12 @@ config CMD_FPGA
 	help
 	  FPGA support.
 
+config CMD_FPGA_LOADB
+	bool "fpga loadb - load bitstream"
+	depends on CMD_FPGA && FPGA_XILINX
+	help
+	  Supports loading an FPGA device from a bitstream buffer
+
 config CMD_FPGA_LOADP
 	bool "fpga loadp - load partial bitstream"
 	depends on CMD_FPGA
@@ -1171,15 +1177,15 @@ config CMD_FPGA_LOADP
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
 
@@ -1192,7 +1198,7 @@ config CMD_FPGA_LOADMK
 config CMD_FPGA_LOAD_SECURE
 	bool "fpga loads - loads secure bitstreams"
 	depends on CMD_FPGA
-	select FPGA_LOAD_SECURE
+	select FPGA_LOAD_SECURE && FPGA_XILINX
 	help
 	  Enables the fpga loads command which is used to load secure
 	  (authenticated or encrypted or both) bitstreams on to FPGA.
diff --git a/cmd/fpga.c b/cmd/fpga.c
index 13aabc95abc..65038a79930 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -412,19 +412,20 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 	 "info   [dev]                  List known device information\n"
 	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
 	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
+#if defined(CONFIG_CMD_FPGA_LOADB)
 	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
-	 "            (Xilinx only)\n"
+#endif
 #if defined(CONFIG_CMD_FPGA_LOADP)
 	 "fpga loadp  <dev> <address> <size> Load device from memory buffer\n"
 	 "            with partial bitstream\n"
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
@@ -436,7 +437,7 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
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

