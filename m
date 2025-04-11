Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36458C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DAEF84177;
	Fri, 11 Apr 2025 17:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="28yGs+uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA1684179; Fri, 11 Apr 2025 17:46:35 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99EB484107
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JS5cajW4sy2RVo/UDSlxd0YdUPbzQ3duB7ZV5tKMBFBv2rsgqCmOize92dGzehQoRoK0SI1hjMqxTUW1v4x+WIrjfmfouoZZ46YHKsScLMGf+CEAuVaKL4n8GpvsMDGjBUTXU6326I4WrR6ZM/GUmjLtcpy71xi11d1H0cGN1tEL9Y91PPKpR5zoN4RoC7mxZ7uUC3CBXIu7LNtXTkq5Jz7xjOT5x5fjM3WG6Pe0qWScLg3bEEegDnch+2dp9lXWFfNjTHyUUQmPCBwZDZ5TPCJ1sW7nU98zq3F/F5CntHsvRZl1NEXUWMOFd++QK8+eSh7ocHyAq+y0WxxU2yvVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQRKNNYUGIwL2cMRxLyR7h0qzFYyhr3zdoTuctYSWmE=;
 b=bqcg7mBGKsyzu3yq+E/pqxEIFLktoCSGXdh1FVAfNXfgPha98Lren9mrHIGXOoPADGCpRkdWBhyxXQn9vGnfRKbBBwe7uPDaTFXoFmMZUNIueL+mFj26MjnqAwFdWUgQ+DBhzFvBHTm792uEUdP6fm9t99ypDgLwlayQFXlbg4v+OUQnkHXvgCbWkNNWmqq9nQRB7jOxaNWIoxzgIA2ixJsQ9Qjc+oxir2MmwafyWAMyIBpfEAJp8/tKGVoNsvEmd3LVsxUUnpVB9/wvCJE5z+0uSG2V4Cuk5J7hSQtZZR7OX/piRaET+8eZFiSyg1kvYh3LIWcjpEhCIQYybMlp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQRKNNYUGIwL2cMRxLyR7h0qzFYyhr3zdoTuctYSWmE=;
 b=28yGs+uv3fvMebyuXjabEN9j4Zqu8jhebWLT5DD/wV8vkO2w8F+wMuVgRLMm74uwVqQt3yiCt7aARPMvHMW+1ajTCddw2s3proaZ0kkfx1vvdEk8rxCPubziHDWlMl+2vtVSlR69KHx4o5lf+qYRlRxCGKJhK9wPYLbjfw9hBYM=
Received: from CH0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:610:b3::13)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 15:46:23 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::f2) by CH0PR03CA0038.outlook.office365.com
 (2603:10b6:610:b3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 15:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 15:46:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 10:46:21 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 10:46:19 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <marek.vasut+renesas@mailbox.org>, <cniedermaier@dh-electronics.com>,
 <xypron.glpk@gmx.de>, <git@amd.com>
Subject: [PATCH] amd: versal2: Add support for saving env based on bootmode
Date: Fri, 11 Apr 2025 21:16:12 +0530
Message-ID: <20250411154612.107136-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 217ad39c-adf9-4a18-76c0-08dd791002f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oVJeJzD8zQ0cGqHQYoffDEoGJIp6bTeSokE36V8msx4219WFKZ6xVwLS5Ip3?=
 =?us-ascii?Q?PH0ub41keLz7H/ubbMk9aFbA63Fno5GsnLHsQFLPCsY+23FD+r+/4cLKTShs?=
 =?us-ascii?Q?tnGz9PvuQwKRI8aUmbZWSjXe9FBtHNLnBnWFNtiSmYiZIGwP22Yd0xkp0UUn?=
 =?us-ascii?Q?9uBzEK5gRsfQbqwb/JDI2uYR7/wG79cfovk3uYaIlh32YXrawmjHsWaICfAq?=
 =?us-ascii?Q?R5s5OyZhEGJ4VzQ050R7U3xv+ZEftUpuA0AlMZLT2R8PzFP6fM95vkdvW7gy?=
 =?us-ascii?Q?FsPq8XQLIic+opxfFndmwbDJX0eyjcxnrU1FIkJ9wnvxzuZc4SiQ+js9Pgzv?=
 =?us-ascii?Q?ghJ2IgBj0UpSILBFqz7QD76drDpoV41jcz42f/mwzjEmzJGmRNxUl0qBUgUt?=
 =?us-ascii?Q?GQIcqil+w0o5HnSN7Gd2g+6YUoCrfYaUGRoVdUhwn0MNoIdddBWrOQkLY4ba?=
 =?us-ascii?Q?/p/sqNvjqiz0NwinTA0HD1pPxYZdQ09eaHUCybNPRTpCguzvEVUnwZyF6qHa?=
 =?us-ascii?Q?V1Ur9K+jqMYQqTKcqfpfLcdP1w6Lvd0TtMl434PtqcaEFw6i4ZnVY9nyhxPB?=
 =?us-ascii?Q?Gkmh3JBc6y4C54Pb68sc2ItRi+AX8cxsdJf0PuRZkTLUrptng/JaX60RSgGr?=
 =?us-ascii?Q?eQ4l5TPEfxreEEFSGTL6YIfWEMrNzmriMDc9QQ86/SYN3r/9MqCcV12MpS1p?=
 =?us-ascii?Q?ZF5yIABh7i1JupsFXKWJ0I4yYigdUmPaseA9kb05hEOtZJBQ5FPYZHar+g57?=
 =?us-ascii?Q?pa6ZQdwOTaedrMvS1uKqcplb97upbZqhC0bSUHNOd8LF2jM+hIzRfVyYcvUl?=
 =?us-ascii?Q?fhnJbqNPsQV02vOquyF8cUfJpnKN2/TjsF+8RtEjkRae3hEWgBiBhwFsa6v1?=
 =?us-ascii?Q?f51Ht4hKcaKvXXefQquz5QZfcKPHa6Ta9MizZDO6zypr3qMtkj3O3PTJT5yB?=
 =?us-ascii?Q?iUgL+Uv4obd74CjU7nSYvroUyy0vrDoX4+3Rsj5xa0HuUcpz0LuaHS2hg3+0?=
 =?us-ascii?Q?Va6KAcGPaE9nxmhq5k7wzU5RAu+vHTQdjXsVZr23LFkr6QvMsbIEgphm7kCo?=
 =?us-ascii?Q?cRrbQ2H5dkA/Q6ycfJzSTDNDNUpVFXeLLlnCK5LaRsidYe8f92muyHEwGOac?=
 =?us-ascii?Q?zA53XMk395lSaUoEe7W1Eppt/t5K/Y05I88SdakhdWSQLtXB5HFzRrdM+IBG?=
 =?us-ascii?Q?WTpSoVZt8QSlEAwM/JzNHsh4EGCdxOeVL0YqtFTkjPETQKaNC7cj8cymJLNP?=
 =?us-ascii?Q?drAN7YZRWl/2dc2/2GCH+cFiZs9JR4LvS4cZqdKRcs49e4fgwiAlTZj3wwde?=
 =?us-ascii?Q?mA/7+1WXsgdD/qfpW5PUWOxed/ThrJmrqojSVNzcIODWRet+7hhfUcOOTxO8?=
 =?us-ascii?Q?nIoEYPkTVGv0xNPLSbgLJpjd8tU8VL6GJdrbWNNG75OYxFArUl6y1L7nNERl?=
 =?us-ascii?Q?9wO+q2v2tvA55eH+3FTgkMEixpyIiEn/ULBYBuHo4uj3CPINUOmneshHoQUd?=
 =?us-ascii?Q?ORdR0fYiD1xiNM23MfbKLwkaURLuCbGrvPQk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:46:23.1735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 217ad39c-adf9-4a18-76c0-08dd791002f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
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

Enable saving variables to MMC(FAT) and SPI based on primary
bootmode. If bootmode is JTAG, dont save env anywhere(NOWHERE).

Enable ENV_FAT_DEVICE_AND_PART="0:auto" for Versal Gen2 platform.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/amd/versal2/board.c          | 32 ++++++++++++++++++++++++++++++
 configs/amd_versal2_virt_defconfig |  3 +++
 env/Kconfig                        |  2 +-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 5651d516a9e..23c76238f01 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -341,3 +341,35 @@ int dram_init(void)
 void reset_cpu(void)
 {
 }
+
+#if defined(CONFIG_ENV_IS_NOWHERE)
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	u32 bootmode = versal_net_get_bootmode();
+
+	if (prio)
+		return ENVL_UNKNOWN;
+
+	switch (bootmode) {
+	case EMMC_MODE:
+	case SD_MODE:
+	case SD1_LSHFT_MODE:
+	case SD_MODE1:
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
+			return ENVL_FAT;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
+			return ENVL_EXT4;
+		return ENVL_NOWHERE;
+	case OSPI_MODE:
+	case QSPI_MODE_24BIT:
+	case QSPI_MODE_32BIT:
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+			return ENVL_SPI_FLASH;
+		return ENVL_NOWHERE;
+	case JTAG_MODE:
+	case SELECTMAP_MODE:
+	default:
+		return ENVL_NOWHERE;
+	}
+}
+#endif
diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 9911caa0e46..a8d9f5cc777 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -66,6 +66,9 @@ CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_BOARD=y
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
diff --git a/env/Kconfig b/env/Kconfig
index 4438f0b392c..9507aeed12a 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -485,7 +485,7 @@ config ENV_FAT_DEVICE_AND_PART
 	string "Device and partition for where to store the environemt in FAT"
 	depends on ENV_IS_IN_FAT
 	default "0:1" if TI_COMMON_CMD_OPTIONS
-	default "0:auto" if ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET
+	default "0:auto" if ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
 	default ":auto" if ARCH_SUNXI
 	default "0" if ARCH_AT91
 	help
-- 
2.34.1

