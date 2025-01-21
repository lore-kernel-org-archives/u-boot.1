Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305DDC0218B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC100807D6;
	Tue, 21 Jan 2025 14:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nCbjUrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75CF880763; Tue, 21 Jan 2025 14:01:54 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD12801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7QLn+jXPfpp/BTQXPMlnpfkrNFVjUFoqXXmFg56LzL/r96Kh1+hZVzBRUK30FCIo4erljZDizbWjVlMG6UOVWLjB8+2Isj1AUxvvQ6z6T2Z9RfThwTtH8ewlIZvf7srovYL/OJ8x80Bv7gIxByhaaR9o+ifT/9mE41Sq+0W9T/4O+roSbTRCtdh653xhf+CcSdnHjKrBzzXq5f7HaFu/TIjke6KStsUWEARVWpSFbE0gg8fWdiHtyOZHvj5utT5SP+6HUOJIwQOXCL6Z6LEwo2hMwNNziKkoykDypuHDjZg2be1AQDTt9mcZoCNrBhgUGNw0SP3mm8DxeMGWrHOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb8iYq4njpeqD1vQAI+z6nRjUhFhcF8dmB4ccAgm2j4=;
 b=TbTQRLSEpyQZMiG5FEXpGdTtE/7SGYFm5L4BaFCMejUkNI7TJAun3SJNCrN+SHe0PRNkyn9oJsLezmMczzpMyQM+1k4gBxh+HCaRs/10mIyI40CYKcWZPcJraUb4GicXxAKzNHwYXUxH7NXRgBVa/awKNQX4Bbpt0LtNt2muXRXCXQuHG420EtlBgSNnXoMUWFOiUoWSB+2ubRhK81rGDwYGTVZh//KBKtP66w4Ibg3LVaLGZyZ8C9MEcfhsNPbdg/OU3uY/35bqtixvmBHyXvAqrSeWUxf2T2rh8OPNgh9S2p+9M1+hBy6VW65l6L1KsawimUW16V3etMPPSJLKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb8iYq4njpeqD1vQAI+z6nRjUhFhcF8dmB4ccAgm2j4=;
 b=3nCbjUrk5+U2ciRNTLZ476+wnkfgkC4sH3Z4N7Tr2VV5UQflGOLYs9d5y8ZWcDHUJHH8YqLFVzbStA41I/qCN8qSVtj5UuQLGHK2UZ+0WIiWCxbCurP64jcw4uHzzeeMxZMhUM18JthxYRl4R6v7aTusObrnChALezp3ZAa1ntk=
Received: from SN7P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::24)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 13:01:47 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::a8) by SN7P220CA0019.outlook.office365.com
 (2603:10b6:806:123::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 21 Jan 2025 13:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 13:01:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:01:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:01:46 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 21 Jan 2025 07:01:45 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, <ada@thorsis.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v5 5/5] fpga: add new symbol for fpga_loadb
Date: Tue, 21 Jan 2025 13:01:34 +0000
Message-ID: <20250121130138.1999916-6-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
References: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: f3cbbcbf-9826-4ba3-b6b5-08dd3a1bc345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NO3WIrfSFl28AxTtzLc9VZiT/Wg6l0WZgPJoxzGYpp86Jo1eqO+EDzy9uygh?=
 =?us-ascii?Q?lnJvO4uTUYsnh2LQpaRvhg0oFufJ74+UsToCUnfqvxF3NWvNM/2PL1qqVxp8?=
 =?us-ascii?Q?4geClMZBRKYEjOoFfi3+aUtLqQlBELo1CoNXPLACB6DZThO6nnMMVub84XmE?=
 =?us-ascii?Q?yxuzGhWqWpnOSINZwFpqGHz0Vn/zN2YGp+B42rUprWMcne5XIhiSyuUXbAJy?=
 =?us-ascii?Q?ovW/oY4AYoObFLAp3wAzFWxyc9LoeT8i2MtjWn3ZAQqNmTD+3j4ifvgFXWoI?=
 =?us-ascii?Q?aUaB3fgaN+YyaoNfpzva6embdE3/Es7KuhBoC9bwlztnr7EEpw0D3lbBRc2+?=
 =?us-ascii?Q?Zj6tWnLWLmk+OuiuY7UOzTagE8FjXmA5dVH/RK2uCpNchLp33RLZyqIb3LoN?=
 =?us-ascii?Q?6DX37EASyLV2EmCM2qbtI/NwOGUX9haWBDGrkmZB2iDSRNgtbTrF73F59qDo?=
 =?us-ascii?Q?lxUzCuA+me9zXsSyjg3OmYkrLBu76qvDdCD0eRi4+aaX8Ai8IxvOWmxfqpEY?=
 =?us-ascii?Q?mir0vWOo0bxMYaWdkQXKJEi0KYCV1C0aeyP7daUP6td0eLl8YegvKJ+PeIYK?=
 =?us-ascii?Q?ETwRwHWlin2YZfH5EoDIN0Fx45LCWQOS6QP2h60v1YxMbuhurx2BIOgRX85Y?=
 =?us-ascii?Q?yLKjFdONbPxruSwH82CCgP5toF32I8ooOHyNwUw/TAwHPT5AC/jFuHFHj5OW?=
 =?us-ascii?Q?NO/g5QdR1FZXmvKMfHxxW8RBqChwNQBdtDgk4ovR3eoAEzEnRbn4EHTDkB+s?=
 =?us-ascii?Q?I1NobPDeu0/qlDVWnK4DflLstul8fSS359PyFzpLBxjQQf20EPD77lzrkXll?=
 =?us-ascii?Q?lXYXCyE+os4Y99LS6h91SiwJrHej/B0q/2/TDtMIjKYV4MQXOyQsrUIdmd+G?=
 =?us-ascii?Q?xsG2PUKifbO3zsbDJaphXHlMPzyLYaisnQNJwgkQh7oDTr9e9WGGnhfsa/Nl?=
 =?us-ascii?Q?5rB8nySy7EdGpN+wEtkNWFi4CiMXh9TnvNoyZa1ukUS0kZfYxH3G/LqipVda?=
 =?us-ascii?Q?dlmhkgDLZ/Ej2sI/hJNB8fo4DmfglODy8gKVFWL24p8p/i45t5WplmySZx9f?=
 =?us-ascii?Q?hILB2F4mqeFq39FirRXVg2a3i3PyZIl/SawrKULeAp69uHKR5A5JReS5Gqz6?=
 =?us-ascii?Q?CCnhwiJQ4cuMogJlaL3yDxNo1dUb8bxX/3xp4+xdDYc/FnTuHtFgfuZfq9Q3?=
 =?us-ascii?Q?+IFPiVr/xrmeKmTeBpFVNN1+h0VSVUMQmOJQdsX2AVgRD4ugGQfHfLSIRJFn?=
 =?us-ascii?Q?L1sbZWVkNRISEVUbUucPA3DIOE8LbC9EYp24m2QLg6bMqsjOdbHLBQMGKswT?=
 =?us-ascii?Q?0QFbzOhqfl+r3deFyX14ypMmxRY6xCs2CYuwySy60q9Q67U7nEqa9Dn/dHBm?=
 =?us-ascii?Q?oeynNpsMzm1mmXHJiZovU+j/u9surgzm9EgI6ZCUDpyzrfwIlwmGORQe0zBw?=
 =?us-ascii?Q?yJI5/1XZ3AAGxLjEvQL60N1igqfmLlaXl57+6uE7O59LqP5mptHPsGfhqIEY?=
 =?us-ascii?Q?Xe9VdxGvyykyOOc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:01:47.0194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cbbcbf-9826-4ba3-b6b5-08dd3a1bc345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
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

Adding new symbol for the fpga loadb command which is exclusive to
Xilinx. Default value is y for backward compatibility.

Clarify the type of file used for fpga programming commands

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

(no changes since v1)

 cmd/Kconfig | 17 ++++++++++++-----
 cmd/fpga.c  |  8 ++++++--
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c9600498787..6ed9b4a0f35 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1179,19 +1179,26 @@ config CMD_FPGA
 	help
 	  FPGA support.
 
+config CMD_FPGA_LOADB
+	bool "fpga loadb - load bitstream file"
+	default y
+	depends on CMD_FPGA && FPGA_XILINX
+	help
+	  Supports loading an FPGA device from a bitstream file (.BIT)
+
 config CMD_FPGA_LOADP
 	bool "fpga loadp - load partial bitstream"
 	depends on CMD_FPGA
 	help
-	  Supports loading an FPGA device from a bitstream buffer containing
-	  a partial bitstream.
+	  Supports loading an FPGA device from a bitstream buffer (.BIN)
+	  containing a partial bitstream.
 
 config CMD_FPGA_LOADBP
-	bool "fpga loadbp - load partial bitstream"
+	bool "fpga loadbp - load partial bitstream file"
 	depends on CMD_FPGA && FPGA_XILINX
 	help
-	  Supports loading an FPGA device from a bitstream buffer containing
-	  a partial bitstream.
+	  Supports loading an FPGA device from a bitstream file (.BIT)
+	  containing a partial bitstream.
 
 config CMD_FPGA_LOADFS
 	bool "fpga loadfs - load bitstream from FAT filesystem"
diff --git a/cmd/fpga.c b/cmd/fpga.c
index 75d2f824998..212f421739f 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -180,6 +180,7 @@ static int do_fpga_load(struct cmd_tbl *cmdtp, int flag, int argc,
 	return fpga_load(dev, (void *)fpga_data, data_size, BIT_FULL, 0);
 }
 
+#if defined(CONFIG_CMD_FPGA_LOADB)
 static int do_fpga_loadb(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
@@ -194,7 +195,7 @@ static int do_fpga_loadb(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	return fpga_loadbitstream(dev, (void *)fpga_data, data_size, BIT_FULL);
 }
-
+#endif
 #if defined(CONFIG_CMD_FPGA_LOADP)
 static int do_fpga_loadp(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
@@ -356,7 +357,9 @@ static struct cmd_tbl fpga_commands[] = {
 	U_BOOT_CMD_MKENT(info, 1, 1, do_fpga_info, "", ""),
 	U_BOOT_CMD_MKENT(dump, 3, 1, do_fpga_dump, "", ""),
 	U_BOOT_CMD_MKENT(load, 3, 1, do_fpga_load, "", ""),
+#if defined(CONFIG_CMD_FPGA_LOADB)
 	U_BOOT_CMD_MKENT(loadb, 3, 1, do_fpga_loadb, "", ""),
+#endif
 #if defined(CONFIG_CMD_FPGA_LOADP)
 	U_BOOT_CMD_MKENT(loadp, 3, 1, do_fpga_loadp, "", ""),
 #endif
@@ -412,8 +415,9 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 	 "info   [dev]                  List known device information\n"
 	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
 	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
+#if defined(CONFIG_CMD_FPGA_LOADP)
 	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
-	 "            (Xilinx only)\n"
+#endif
 #if defined(CONFIG_CMD_FPGA_LOADP)
 	 "fpga loadp  <dev> <address> <size> Load device from memory buffer\n"
 	 "            with partial bitstream\n"
-- 
2.42.0.325.g3a06386e31

