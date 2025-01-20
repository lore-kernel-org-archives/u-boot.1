Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C7AC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18B7E807A7;
	Mon, 20 Jan 2025 14:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ab5BBSfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEC980762; Mon, 20 Jan 2025 13:44:16 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A2F80077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCjCS5w6tDLpv0xWXNd7wAExwMP0xemvc0P2LyViraKOy0JSJ3ijXXvcK2eiAs5GlT0pwc2XLmOPg0epmE4yfozEIoFYgLnDTLcG5Il5x6YPPgPMvCz1gtaypTPjvp90CDfEvirRbITs2rXtPofj/emJQuMkZyIfUwjKR75xayRZwORy9j4w/cAAOvsv+TyQi9GvQ7cryx7+Msojnpp2s/NhHxrduCWaVF6jrJLsWonCrinEjCMir+IPkBrEDuctV0r9S/djmsr6LgitZo2soR3RWakuwINUHtso7vlSXTz/1trkqz/nIJKVLMUm/CWxNwv0SukuftnlDTZtLFKJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VfmfSi0j26hTFmOTfzLnPQHUeSLFnBu3hWZ+k0pAdc=;
 b=Pjg5K86PLIW162wL6ALtbbyU/cVV/W/AtGq9j2tRV09ygTsLXOQPffVTbkrdAMDRYy+3kqH+g6LPxdsM78U0q6YTdOdyapHRA+4YQ9H1CH9+IqJQd1CXXWIIxyGOCgE4dDtDXJTfc/Kk/b7b8LAoajy2kYLOyjdQueYDWX0Atj5kTE6oC4lk+pI+Y0lhr/GyRHs/6yv7r55pvsY5iSPN3gTPQvY9AqH4A1JM8KTwAcyax43hByRywa6ZiAgsaI+zq6AbXCxXJqssQAPhB5DjnF9LEJul2emmic6lUp+w1GOEWD4zKAgSLL1gql6KdErfeAxTfvK6rSxGWjHbvAvl/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VfmfSi0j26hTFmOTfzLnPQHUeSLFnBu3hWZ+k0pAdc=;
 b=Ab5BBSfZ1DMDggxKtHV520pks2wzsrtA9Mfg0ddY2CRg9HdNqgROyRsFXecWkYQP6X6yrK2pVZceVK41IaCS8smcsXiebA8VCg/ptsN1OxwwRMmabn/1vp39LWvA2A9/xqZphTB5yXQ1ScReSfqSstPyEUN2147Y8pRJyoK08iA=
Received: from BN9PR03CA0919.namprd03.prod.outlook.com (2603:10b6:408:107::24)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 12:44:10 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::b1) by BN9PR03CA0919.outlook.office365.com
 (2603:10b6:408:107::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 12:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 12:44:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 06:44:10 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 06:44:09 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 20 Jan 2025 06:44:09 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v4 5/5] fpga: add new symbol for fpga_loadb
Date: Mon, 20 Jan 2025 12:43:54 +0000
Message-ID: <20250120124402.1501320-6-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
References: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: a59ba10c-a7f3-4ebc-5666-08dd39502329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wHPt4XeP/tQEc9GbIZ8oF2JxiQPNix9atW/MAjjLoNefCcqorprTeK9tjP/i?=
 =?us-ascii?Q?I9nW6rsUg/UT4GlaF2vJHS+i6AK07ghtjohO0BycD8QvDm7oqiBB6dTd1+No?=
 =?us-ascii?Q?TsUEvlGzhiayHC0zFuvZum/mB+cYzeEPH7NlORaxoGmMXHpwSuw8DIaYIbsE?=
 =?us-ascii?Q?G5O0F9uPhfR2EFh6SW2v2K0H2alBKw6e0UiiO95rl0P0KIZ0M5ejKiXWah7f?=
 =?us-ascii?Q?ShEkqBhJB31AgtvTBXEsueMd9w3s7e4nLKHATQcLvNwRGWuK+EImIjk2OrST?=
 =?us-ascii?Q?3qAT5tbw2RDUf2cnVnaq1Xr7fPKmEKqNTwC2CWuPUc1uLmxH0bp1UXWHpoES?=
 =?us-ascii?Q?9xTSJCuruuWZgug2GBEHVqbDSsYdZ1MGJjk1rRTT5H0Qv/zX+RFWMmoFU3iC?=
 =?us-ascii?Q?SwTedr8AHiRR7X4ERIP7hYRiEi/16uAXI8/rfk5xuO2cPzX74An/lvRteYfx?=
 =?us-ascii?Q?R5mJBafEfjjsIxqNmRH4TnDTe6wfqtY5KVej7PEM+bDmmSuMo5e91b0yq5fq?=
 =?us-ascii?Q?X87JSJ/9AgawOvkTvxm5gUllyBZMO4qC7CzZkSYw2TUzGCv6oRhFhLjRVSNV?=
 =?us-ascii?Q?Tc1dFjpq5SJln+04gVx/Am1N+TJhrmoZrWbMvItKC4E1sLXudG48XSICyDMQ?=
 =?us-ascii?Q?Oz3F9JTDxlHgc1FzpHaE+BRM9a+Qu4NNAIwigs+DU9RPw1wbC5ce5BYUHvtu?=
 =?us-ascii?Q?3i3T2jvlXWXNUKThdagM8B/Anyn1cSBo5EIySF9P2ZCpWNc+GkLcY3bWXBuz?=
 =?us-ascii?Q?sFXFGhkK3ehFeNN5nS7IWFiyM1trN89bDBf/O9zk2s0Q8iuQj9NzRdKFyx9i?=
 =?us-ascii?Q?TjHLUWFoyQZxzUsymyD7D9mKANoOt6PjKZ37J6moYsgVxuwsP7zwk2ZXasaj?=
 =?us-ascii?Q?cmmxPn/aKfVpgW1bzBSlwkI9AdilZ5urVv0h/L8c8xdhmAFcRAIj0OplnNRn?=
 =?us-ascii?Q?MSSf6i0yluQiVlzRUdvD5F+nKK3azr/GAAbcrI/GnTBk7fuEKPo/ed7QDnjZ?=
 =?us-ascii?Q?YgWREOg7evZaNg/2EpmgS0sdpg9FBVs2z5y9txOfF4KHvzejzlxzJWd8sng+?=
 =?us-ascii?Q?2khvLmWjJz1RKmW7z8wtYWb5afLviumrZk7OcCINYjJsTwy5vzl4HC12+dxF?=
 =?us-ascii?Q?auxKPnmo/LbG0VXrXW8BfDRwLrvdibMjsdwEIpvMg+/XRZnLpVlIvu5tj5Mp?=
 =?us-ascii?Q?wf/W+x7LkPdPSptsX9EjwU/Dza+OMVR4ARICKgwQEfP+BUqVaFi0JQC4rnA2?=
 =?us-ascii?Q?S9082MOYV4PULBxtHbvWJmkT84mtH1IWXqyI3X5A5UYvibstGdnjkYDgHAQK?=
 =?us-ascii?Q?qHfvQ5H8xi0kui42kLazkBjG9GILSiT/H0e8ontNHq7XFWTDHf2c9WuoPI5Q?=
 =?us-ascii?Q?tYiAVy6zTphSwv6Om2sqUnsw0sLbVr6f7dLMciF73JvwgQnaOPVrfoXJo1ZS?=
 =?us-ascii?Q?ofJt7CZ1wz3WjKjZOn+e/aR69Aqm2+lHNPmA7xaWADkKWf/jlZ6vSAE8gBzI?=
 =?us-ascii?Q?cb9fO/O4m17nc5s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:44:10.5931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59ba10c-a7f3-4ebc-5666-08dd39502329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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

Adding new symbol for the fpga loadb command which is exclusive to
Xilinx. Default value is y for backward compatibility.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

(no changes since v1)

 cmd/Kconfig | 7 +++++++
 cmd/fpga.c  | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c9600498787..55a8d4189a4 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1186,6 +1186,13 @@ config CMD_FPGA_LOADP
 	  Supports loading an FPGA device from a bitstream buffer containing
 	  a partial bitstream.
 
+config CMD_FPGA_LOADB
+	bool "fpga loadb - load bitstream"
+	default y
+	depends on CMD_FPGA && FPGA_XILINX
+	help
+	  Supports loading an FPGA device from a bitstream buffer
+
 config CMD_FPGA_LOADBP
 	bool "fpga loadbp - load partial bitstream"
 	depends on CMD_FPGA && FPGA_XILINX
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

