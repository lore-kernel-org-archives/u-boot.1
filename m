Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAECCA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040CB88A31;
	Mon,  2 Sep 2024 12:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g/u8ra5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A3ED88A31; Mon,  2 Sep 2024 12:27:50 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F6BC88A92
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xc/PeSDkQKcLqHj4ByviAbPqJ62KdBFh8ty3Xmw4LZKEUlQEqvTLwZtsK0zLkcH7ZZvimZZDwqtUCpdR8Xk585hTeH6OHThIyaPJhoMeJPLwMQQMQcYRisEJ4yAyyOkCQIDJ0CZdWDh8relkVJEJgvFZxxU7ixbeW/PgZvWi5AMkXh4nnzx1VLsNTaQn5aajZRY5b/C8YkFhtr25NW+7yzaWWca+z2LXkyXA16wvoE4PH2MrBKqqhZqpHl0u2R/aSbfWQ+9X+kZTxRvOQEood2Tp3itD/d2caU5iPoDorLJDoWahqj5dt/f4iyv+OfyUPJc3YBHzOnIwCa+omZLJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNT7MRfq/Iv+RXUCMsiHgDqTMDxnZz1wTJteVhciewQ=;
 b=UB1X+HT/l3CZNS1hgBkcDsGeKiMGxyhA9o7UGsQ54w+H4WK4QvqCswcdWKZCWC+kSnhkI4nFQaDbPoV3ssU9ZQhk/PZrkSZv8ewji+jZodZJkFddsjpw9anYCaTbEUZvLifNFX1apV9NtZAdHlobUYUgAvYMhEAH5d0df0OW1LISj4nWhGlHYthvMzJ7W7qk94bdUpYSrx1adli3+TmsSB8fuyzqSeyGWTzxy7HZEfnGNMFVYnkkZxiY7n1/UpEYEFsUk77kqg7fX76Nhq2STV1XGTbQJxstjfneWc8icZNSdyBwGRXajXkP3qwsw4Ft4ryZ8AWj2Kp9U/Qub60Vaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNT7MRfq/Iv+RXUCMsiHgDqTMDxnZz1wTJteVhciewQ=;
 b=g/u8ra5Jy8y0/xi+FqirbTc0BATbXT4yGRLpmOmLvo2bK/yW6yZY7780LNyMTgnEOIDa8Kh0nKjOxR47ROtntLivzTwe2PSHjq+qedsF1efIh/mezGa5P4fu3xqw4RyGdW3VyrjYKRAtkmNZDuUUY//KAyO0XQpkLe1Xo8aBWQg=
Received: from SA1P222CA0167.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::15)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 10:27:44 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::33) by SA1P222CA0167.outlook.office365.com
 (2603:10b6:806:3c3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Mon, 2 Sep 2024 10:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 10:27:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:36 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 05:27:35 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH v12 9/9] config: mx6sabresd: Default don't enable the flash
 lock
Date: Mon, 2 Sep 2024 15:57:06 +0530
Message-ID: <20240902102706.1107-10-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
References: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 5620ff97-4caf-4700-38f4-08dccb39e1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mhJUeynwUg0ytXj7ScNCM7IjT6eoxS7wKONHR2SPXZpFFx4ZYilF3o+h2eyJ?=
 =?us-ascii?Q?QdqR+5m/NvWbTBGzWlmIwYC0hF6PH+Zu2v8MiCPDq7f8sHT2cYexYbkGPLBx?=
 =?us-ascii?Q?sebSNQBePyeYM7ZudDbVAM3QdgZKkXmzYk+Z+Pe2+ReCDrn0XGzvx2DcOexP?=
 =?us-ascii?Q?jJzRpTfd7NJpEbhZNVY27W9FMuXi8fWv8SseJuyTNVoBbKY/8nJWCa6RHx7Z?=
 =?us-ascii?Q?UjHOdYKVaNc845/zUkeWntZNHkpS4pNebyE3idDzvQ+T/YI1QhtYm4RbjaCz?=
 =?us-ascii?Q?f86eQ7Z3YOm0hcxwb4dd3hsUKMutYsGcPCk/ZvvPOMoZEAsq+eNsvfMq4K1T?=
 =?us-ascii?Q?VxhTbOIo11RwwqdPPTYyWR2x35SQx89jA8WkbMBiQR+drRQ0xh9/CPybNGwo?=
 =?us-ascii?Q?mWJGW2EiOOL0/4lc1ZHuLSXTMo/TpydxmpXf+eT2rO4meiNtpqVSqZ5CEzUv?=
 =?us-ascii?Q?SEjc/D/gyKPCIXi4iykkKG0WRDUzbTiFNY+SU+b2AT1wbueygDfAGhQfQtoa?=
 =?us-ascii?Q?XG5g1n3iHodSLK7KU0EO5NzXwdqIwr5uIZh8Flzz6ji8cf1UksGhxou6YIdI?=
 =?us-ascii?Q?WdwtCZ+R5wMbTSRGDNcO2zu9ctYEYHR3obDxDH91dlyq1yPdhNkPn8kAykmm?=
 =?us-ascii?Q?KEH6z0qFzGPRlFW2/q4h8oY5aTCi3+/OJ6YJOvueSyPaSurEH9CHbLUP01UB?=
 =?us-ascii?Q?wk1axM4/eIO+deAhr77erXMmxWUdczYQo4k3TFgECTu6i9whOzyAWNyJ8CXn?=
 =?us-ascii?Q?gdDBtzzC7ZGD/TfsOb7XH44y88t/5KV0j97g9y50N8/+VBOHEsuw4ZzegFnT?=
 =?us-ascii?Q?RufuUVEqDAAqAIUq9wTUDLkBILL8gOLv1d1vos/yPIFQJME94K9WbUrTLCVF?=
 =?us-ascii?Q?vPUZtaOIQsKGheTiWA80gc/2YMjpHMwKXjKYb4lvs8/1Q8fn7rk2If7fUpPc?=
 =?us-ascii?Q?eAs7khyygI3Y73jEB/eJg+BnONpdvO9jy7I0PNcHHssuSUpphhQtPMco1h2K?=
 =?us-ascii?Q?/d9zH8ccetgTaYLbDTtyPSyJqfDdWIDY9pasPlwvdELwm2iRdQDiFUAXodee?=
 =?us-ascii?Q?YfiexN6TRLb3aakyrd1WJ1IQRHTfgygyyECXb8ZQr8waT1ZG6OPNi58wN2z8?=
 =?us-ascii?Q?dx1gkv5qHPE6fYLad/PKXvPwp2MM/XaWUUAzUPnpfWlCsAZtdJHD3Cbb2pI4?=
 =?us-ascii?Q?hJDtLGoQV/28Jdq8gcIrSMx2dftXc/hJSyewNJG9ZZqVnlYjnRHurHzROjJd?=
 =?us-ascii?Q?tBBH6ZXZHUEeJlR2sVh5i3G/+L87BCW1WUN0ZhxzHJQORnk+o71NNRNKPfrz?=
 =?us-ascii?Q?k1gtHy8//2dwOc7SFk3VTG78wGq0J1QD21W2D4gr2R/kezm7EQmumYTGEeBb?=
 =?us-ascii?Q?ScvFeSNjlahvFjWv/iIUt4h2wzZL/qy+7w2nyi7swzB81TMsPFzTsepbVxg8?=
 =?us-ascii?Q?oPdQBfC0KLvqlX1dVYgtvaMr/ukScHKJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:27:43.8091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5620ff97-4caf-4700-38f4-08dccb39e1a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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

By default flash lock option is enabled, enable this option only
when it is required. By disabling the lock config will save some
amount of memory.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/mx6sabresd_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index 80f7cd60b5..2a83b8cd06 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -86,6 +86,7 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+# CONFIG_SPI_FLASH_LOCK is not set
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_ATHEROS=y
-- 
2.17.1

