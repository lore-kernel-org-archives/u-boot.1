Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2593C54E60
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 11:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE27387F01;
	Tue, 12 Mar 2024 12:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IeDPVtU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCB487F01; Tue, 12 Mar 2024 12:34:37 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2450187E2E
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 12:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muPVNjMG62YOqB5W1dY+BlVuUsZeqK85aUPQN5hha1NGMkKcHSCgwDsmTT5SxooG5GcG4hcqvT17gdbb5ApMCtZ6VVx2KDqddQVKiSLT2J5xoVlBjthgSOJtb8pXI6Ifo1PcvRx2ImqgB2N1U0py/VQxayNyYn0asbemLQJcVicaO0kFPCJsjq86tVn7ue74QgZbHHlMUJEbqtfuCbLFSvjgMgqbbD7H4sbmwyfaQYEzzBAUxHMwiuhrFZu93uy+h4G0nGwvMXQRHAcgmAK6M91u2oJp4MYmKDG3CtnxJC1nvC7QGVj/3/PUNhRllJ1Qk4fv0IAJJJnqSTzpo8ueSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZIfT/Rk7xsc5H5jGDOp1uH32e6sIshMhCbBcYkjCNY=;
 b=GTkLBRtM5xJMikmOQ5j75FAKhj8skI89VL+zyc8XkjyKsXH25nDnMbQrIchDu6Z26xlRiXm7dCedEvNas8Ywdc3GMVLFxSl1Egk2yRtUafA73ZZeNEV7JwTDFABoWnRGCqojEEXlDmy9ONIF3eeyllDClCvFNeCfF6p1yOSI17SesjukSrM6iyIWCbLj8C7YI0frjZxVWTVJawzAsjnQLNbVDZoR0doQYbF3ehEMj4H80RzQjwvITjT7mv0GpomDg4U8HTYAIZwqAkUoX03Bks26oEMN26QUJDfhpxyEqwcqgpV/DOSvkORSb+2CvW+O7yOcvQL0btSTd0ueJ0TBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZIfT/Rk7xsc5H5jGDOp1uH32e6sIshMhCbBcYkjCNY=;
 b=IeDPVtU6/caDp+B6CvpRuMTUTqC5sLsImXBufL7YgnJNQ8+O/rIp3T4YCiQFjiyoEtYAyUnp3/Tor9pTI5C+FR7e8Xn/Bbr6hsABr7q0CVhqrnLCs7HElMLBpryYdfLxumICCiY9NaMIItV/EGOZH45V8FmcEu6M32QzKdT7dik=
Received: from DS7PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:3bb::9) by
 PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 11:34:31 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::78) by DS7PR03CA0064.outlook.office365.com
 (2603:10b6:5:3bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Tue, 12 Mar 2024 11:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 11:34:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 06:34:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:34:29 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 06:34:28 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] xilinx: versal-net: Add support for saving env based on
 bootmode
Date: Tue, 12 Mar 2024 17:04:21 +0530
Message-ID: <20240312113421.7394-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 92105568-3fd9-4b2d-a2ff-08dc42886238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 983WZqCN+erdLkQ9vqnlq48eRIyKnLbFeyhR1em5GMcP6Oi8o2P0kpimtKO2BkHKV/DPNk6r7ebJXpzfkQt/KQ/xLjKsCfetvibzA8wHKxImdOYjv/JGU12FMuj0E+2fCV2YX3lSt5LA0jh3KTV/3X4+v+CfdctalNkpxgkeh4kXDIZVcpKrX+HslsRijzi12/Qpiw4TJkjlyyaLB6xd/y3DXj2xMd99l2US2366EqBOVZVa9szF3aNtfl8FNt9rLs125GY67zW7XQmWHgenfGxzt0LTrqXASNwQ+a6j31eM7YOyHttjlBPT4pPkh1GVwPmbdj9xY+6IrpUTD2c1cbwOEKA/Jk4oTqLPbdCOcD16QUj67Ylph4Lqy4+ddnWMt63+roxJWIbEWtQo9H4yxWmihSPVVqUt+qE4I+OWjSYS4JwYM9B/OQDoyJvirTtm/iayH6LYZW5uRW7ku5x6qRLmw2jYvX+mqrDTval+pG19e6Wn5hdC24ol3sydK/v/8CNpQuF9l0mqbPEQdd5CFj7U8mRpPED5+tEF71SAdNxRjGsosInjlzEjf5hKZrmlKPhYYoMBkldhntkt4eW9j2vd5UNbkpFY8ikAJ25s5kKHnnSG1MmTUR5ewTG17UGmaiq9mOgpM1uPnDqqF0vdMw9WQVSjnTmKgr5ZZzrnuPTDOjyw/we9Lnn1yDtAWzjTQiLPTZgSXH0ZUaNLWdAa5lIB9BhjUZl+Zj6YVLGERuuY4M+PnCMJVXthQ4z5+RfC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 11:34:30.9694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92105568-3fd9-4b2d-a2ff-08dc42886238
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
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

Enable ENV_FAT_DEVICE_AND_PART="0:auto" for versal-net platform as well.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/versal-net/board.c          | 30 ++++++++++++++++++++++++
 configs/xilinx_versal_net_virt_defconfig |  3 +++
 env/Kconfig                              |  2 +-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 990ca1650a..aecaeb6574 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -371,3 +371,33 @@ int dram_init(void)
 void reset_cpu(void)
 {
 }
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	u8 bootmode = versal_net_get_bootmode();
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
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 29cebe2713..40c6a29a16 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -60,6 +60,9 @@ CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_BOARD=y
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/env/Kconfig b/env/Kconfig
index 7885c8bf83..1f8e90af55 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -472,7 +472,7 @@ config ENV_FAT_DEVICE_AND_PART
 	string "Device and partition for where to store the environemt in FAT"
 	depends on ENV_IS_IN_FAT
 	default "0:1" if TI_COMMON_CMD_OPTIONS
-	default "0:auto" if ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL
+	default "0:auto" if ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET
 	default ":auto" if ARCH_SUNXI
 	default "0" if ARCH_AT91
 	help
-- 
2.17.1

