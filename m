Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB6BC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41EB580762;
	Mon, 20 Jan 2025 14:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r1NC7+Bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C321805CD; Mon, 20 Jan 2025 13:44:15 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEC3280757
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD0djHFl+x9wBkNC0ZdWe2uA4daWMZ8Ode9wa9CGmWZKOMCRHhWbQI70TmY2LUvl+vPy70p9+N6yVh+ri9DRWZAVTk9l+t8S7VmkfnvdU3LvY64UNHaBI7bN3M6IsOl/2M6fN9s0PRcI9F2Gh4zqNemJh0pzLGXBmoZoPmBgF0KFfTEmbT4V2zlEqqKO2CeBRuCLb6inkbLXCIAUvQ0fqHgFg46CSQZLVDu8S1afged4goW6U3923o96xeA9I+P7atXGYxojmdoNdDV7jgcLWrfky+swAgr1vgokelh0aCqaQ16U+8H8yjd6/Bju9e3rmuSZI4afAWxGTOPIfdSwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wKl9fetnLQH6kfx1BNk1PJf2aZ3S8o9yFk4WkKkY8s=;
 b=PkiF+opVaGObFbQVcwJwSs64bFW5fbtVhUwUU3rBF4oM8SKXPSPdBZIG8zNxi5OZbb6IJX4ndA5aN8+2FEBb7/QGOBAWyPS0+Jj/1y2yMsiePIpAl3FU8FZoVFwfoB1Pdc5AFKy9135PXNRkLu5ejCevMC35DQhyns2EihD+aaqB6sNzq9js7JcyEci8c76oOPLHraoXVGiyhCyt6A5wGYtu824+1TK5xrw7BPyHKsMuNQmRvUtTHJPjyohMLuBI0D0ZYUCrA9Or+g+784R7rbuFWoHrndr1JZEVVp5b2lQrmylB+7Ek5QTjwFaNM63SZhaWcAcHeG2Ghhz4WsgmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wKl9fetnLQH6kfx1BNk1PJf2aZ3S8o9yFk4WkKkY8s=;
 b=r1NC7+Bppzsj9muymWwD5wevvGb0rf7adXBQ6aX9q4S5PB/TiSKd1+YwwannazEVN7nYA3tFXujBkuSrjgyQrtZEY8QMLzPC68gwhP6RbUFgotFdv3Lg9BRJ+tFsG/jphEOsL9UmeUtfs1magMXe2qPYGzLh1Pxx4cAu/bvVT6k=
Received: from CH5P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::9)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 12:44:08 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::bd) by CH5P223CA0020.outlook.office365.com
 (2603:10b6:610:1f3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 12:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 12:44:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 06:44:07 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 20 Jan 2025 06:44:07 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v4 3/5] fpga: resort fpga commands
Date: Mon, 20 Jan 2025 12:43:52 +0000
Message-ID: <20250120124402.1501320-4-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
References: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 473ecbb0-df29-4cda-6675-08dd395021e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cDxpTTmE/ksOA0Py9nkSOIh5QF9ttX7MllxshFFaUw35LXGPDZoHUas/iyR8?=
 =?us-ascii?Q?DrQzI7B+WXf73ZcdOOVdqGBrpiU+QCr9Pox7Bp62Zn3iBd/NwOBcKVZUeoAL?=
 =?us-ascii?Q?ewyLSooJmivmmB6bvA5q7gOrxcvXW7aS2AblRxphhw+tFwtMryFVNmoiPlts?=
 =?us-ascii?Q?2UySe6aYEqfKKK4pD6rnNELuHpZHck1cgGqmkTyWZ4UJoUBiM/DlevmBE2L7?=
 =?us-ascii?Q?kS8BfGmRaphmLuVTgld8IS0r5gh3+leGBlRfZbizDTlhRwsweenas91F/Q2U?=
 =?us-ascii?Q?K9gPRycsoqs1ttuEOWIHA6QIWmdauK6izogE+SaXdWOpThyX0Yxbwyh7PPlc?=
 =?us-ascii?Q?xTbRuOJDgJg3cJLS6RAhBFiIpD9GIdiXZI2jen3pAqoValiSfprwsTVMS01N?=
 =?us-ascii?Q?mo43z0vxNzN6FvDsNTub4PYG59gtCjgSV4shrSZaTolPfJetGvGORCgNQA8l?=
 =?us-ascii?Q?EnlNocXWVhu7O4UWqy1CObkGAmN3SVS2YCDpOCjl0aVB2HO3LnCwi7XWzVjI?=
 =?us-ascii?Q?/OZ/zw3DLd05vyDPcMsXrXmOp449HM/owOvMqgKK+tEOH/3heCkyiFnMxOtv?=
 =?us-ascii?Q?r9pt7TpwhAi2NY/cB6dVcVhfD1z0p+JV6/l7POYiSXfRo+Ld1AQGZGXzIc/D?=
 =?us-ascii?Q?eqG7GerhtwwVepV5EW+tBpaayAc0GpBSdzOALp3AV50qKCq+tNXP4ybimgvq?=
 =?us-ascii?Q?UuC+o2McoyiOFg53rgkZu3PFqzKGXkF+jf6zk2Mrm5rGphmCFAabrqfYekGl?=
 =?us-ascii?Q?H00suXpfWJsKzm91MNbT7Hg0sn9XgLQkxTE42Iy1KIgS2oUVg05+fgGSvwC4?=
 =?us-ascii?Q?NB0jBbRTteebTKev30nBgJISzfXC9ZWkotEtpBNbKpCXTCPwS0P0eMUEj+rh?=
 =?us-ascii?Q?GNjVfDKtnr6KgcQ6PT2kN+Tp+MpPNvx2FSoeQl1JUng6hYCaBOlLuCTFFwLx?=
 =?us-ascii?Q?5zzg1CQgA5d32dvNX0pS4Vk0q18dW/lJtYs0pgo3peGDtHpBT4qhdRyY/4j4?=
 =?us-ascii?Q?iSgqt9Y65nn3kfj7q8bIG9aXMpW7LOgtYrz1N+hfrIzU1BTarvFOUCJsqwvU?=
 =?us-ascii?Q?v1rLyqVryHS79pUAbFkitw3mr1HaWg6m0/PXejIh6537ldhwxew3AoEGVbD0?=
 =?us-ascii?Q?qadwLYekJyS9darCnN7WGVc9DEtmlivzp9zwkiYWYxb6gDpzDV5RucAOjKRU?=
 =?us-ascii?Q?OtVB6WN326jBZOssqtABDdgbvSxiw/ntG0o4+yXPex+T1IpNdqYBDvrPEjWe?=
 =?us-ascii?Q?Rao39gj3tF2Kk/YMCCGKKIWIXTsLsgZfb3KIneI7uiCUXuFdBN1EoxIIRQPz?=
 =?us-ascii?Q?PzDD3CSvq2k0hV1n5TnAEWpOKNZv+AubSxWjKCShnsuKcNpXHeNZj9SWUOsj?=
 =?us-ascii?Q?2eHhwXyCP7/RP1fA+msj1T8a9Qu+KMKhSfuZJ4M9r4RPueeCcTPkPDOtl/E3?=
 =?us-ascii?Q?dgWnmckEKz0hTMNZOVjYryzgO2ljhNMONQtxHOKHpdfnHczVCXu9DBvv3j7t?=
 =?us-ascii?Q?61cqeUTwosxkkNY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:44:08.4742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 473ecbb0-df29-4cda-6675-08dd395021e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971
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

Resort the fpga commands both in the Kconfig and in the source code to
list

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

(no changes since v1)

 cmd/Kconfig | 14 +++++++-------
 cmd/fpga.c  |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 1a0985ca479..b362595af83 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1179,6 +1179,13 @@ config CMD_FPGA
 	help
 	  FPGA support.
 
+config CMD_FPGA_LOADP
+	bool "fpga loadp - load partial bitstream"
+	depends on CMD_FPGA
+	help
+	  Supports loading an FPGA device from a bitstream buffer containing
+	  a partial bitstream.
+
 config CMD_FPGA_LOADBP
 	bool "fpga loadbp - load partial bitstream (Xilinx only)"
 	depends on CMD_FPGA
@@ -1198,13 +1205,6 @@ config CMD_FPGA_LOADMK
 	help
 	  Supports loading an FPGA device from a image generated by mkimage.
 
-config CMD_FPGA_LOADP
-	bool "fpga loadp - load partial bitstream"
-	depends on CMD_FPGA
-	help
-	  Supports loading an FPGA device from a bitstream buffer containing
-	  a partial bitstream.
-
 config CMD_FPGA_LOAD_SECURE
 	bool "fpga loads - loads secure bitstreams"
 	depends on CMD_FPGA
diff --git a/cmd/fpga.c b/cmd/fpga.c
index 91ccbee0fef..13aabc95abc 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -412,12 +412,12 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 	 "info   [dev]                  List known device information\n"
 	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
 	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
+	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
+	 "            (Xilinx only)\n"
 #if defined(CONFIG_CMD_FPGA_LOADP)
 	 "fpga loadp  <dev> <address> <size> Load device from memory buffer\n"
 	 "            with partial bitstream\n"
 #endif
-	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
-	 "            (Xilinx only)\n"
 #if defined(CONFIG_CMD_FPGA_LOADBP)
 	 "fpga loadbp <dev> <address> <size> Load device from bitstream buffer\n"
 	 "             with partial bitstream (Xilinx only)\n"
-- 
2.42.0.325.g3a06386e31

