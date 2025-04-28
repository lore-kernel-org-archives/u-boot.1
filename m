Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1E9C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1A082B5C;
	Mon, 28 Apr 2025 15:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Sr5TDWQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646B682B53; Mon, 28 Apr 2025 15:45:54 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3302682A33
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl/9f1ImfU0FDnWqW2DuZfKZe9AQ5uJbiqOEzy+EyJabyA52i49UCiWYbzxOYkwlLfISc60mD8Pb5jOrsac8tXoEVsZ7HrqmjPpxqzvI9kO3lDDibox1EdFAAXEUWVT4m25473rL6/UH0K+MAHm8tpiZ4WGOlZWKB6f16tSldEIFnj+DqAqRV118UURvkC197dtSiAwPFqihsYEXOQEjIKHXUhvDb+hja2f8wWzXeGnK8jUZBQjp3LInG0tl2zNHODlKAQX5UU+tteQs5T0K9UOdNx3g7ek7TuSKm+thdD60y0H3682sC/VlEtDPKlUlEjcb6o1iTNoMRYYyqCXlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tm7oGgzdAranTTSCDsmSsbaTX3V8Gt80F4Fi1m7AgE=;
 b=f8DOPrOh0t3DGylfVj9wizvKI+di2f0y7q0DZET6Xpj78FH3c+Kc66vYTXd2HNX8HKmlcqsGKGg5CIpFuLBr1GoxPhQY0cPjFT6yC/IhugVkwiyGKyXLvtLeKVkfLSYlbOSI52CAFAjfIrur6mE4mDXJd9R5zBc5oqO1SJxn2BzUoTn0aZLBhlYpcvgvMauU5mU4b26BElQtbjY9S5tC1bx44DPKwlmQuyhXT3ESdUPhxoRNreYFq2ImfxRwg88Pu0cimrIxu/KknYdhLfEXlRaFPN01ENKnOYTwFqs5EbZ7clNGBLndBJmE5AE03fMOOSEhH4qC8ClilZ30MSUBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tm7oGgzdAranTTSCDsmSsbaTX3V8Gt80F4Fi1m7AgE=;
 b=Sr5TDWQtHTxVMtorYIMW8ftUO4neBmdmkh1T7diDIjOp493fDOPqTBOJEFZQqyGym10/c/BFb5MQDlUS8QsLtlEB14pcihNTz6tP2zTa3qAlGUXmP9iW/nK8uYGd8EywPvNyO2ieKNFtJw0i8M6le83JQ2B66qBbCKyzke00KVI5lcidF34s8YTBxIVIjTGmmURsTFsxGsQIhhQibAVLlxXi+6C5+MqAMUoP2RhflAGkGIXyugapvEs21ymtldoRBndxdG1zNJnlTvoLGvr55Sa7+Dr+a1muPeUUkqbZNCgwPMQ+3Jbof7Ie8tm/tjXoQS+GYrh3YdE27eNyqHmo2w==
Received: from DU2PR04CA0034.eurprd04.prod.outlook.com (2603:10a6:10:234::9)
 by GVXP195MB1831.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:17::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 13:45:43 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::3f) by DU2PR04CA0034.outlook.office365.com
 (2603:10a6:10:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 28 Apr 2025 13:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:45:43 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:42 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:41 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH 7/7] configs: phycore_am6xx_a53_defconfig: Enable
 BOOTDEV_SPI_FLASH
Date: Mon, 28 Apr 2025 15:45:31 +0200
Message-ID: <20250428134531.2884940-7-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428134531.2884940-1-w.egorov@phytec.de>
References: <20250428134531.2884940-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|GVXP195MB1831:EE_
X-MS-Office365-Filtering-Correlation-Id: 1093ebbb-80d9-4181-96ff-08dd865af891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OlWC/jShfBuiSIYTTLiNeYcZ3ru2TvV9WGjVLJi8oh3mXnoHEnf663uIEWxW?=
 =?us-ascii?Q?tdSs6jQptStEzSK4buyOaxfXvORpuWHB4BFpTWY7OrnKjO29IDiPx1dmqJPD?=
 =?us-ascii?Q?vVyOfbdsAGik9LgNj5YceB8I+2aud7gGxbmvz8QE4DisU1WPF2jPt860JUQv?=
 =?us-ascii?Q?9d1L+YsPLg4kjby7wiLv+lghzapa/wm2Ali22Uyh9feDekckcwatZh8nkYlY?=
 =?us-ascii?Q?t++dQU+CvviWOIdZ/PvfYuORpXV18xqfPaK4rpWG0zmlY9LytU2pDwmjhfU6?=
 =?us-ascii?Q?VbxVg2ysrS7mw4s+FMAOJ5lpxlJKWStGa50eYPgAjlt6N3R0wK+y14UmQEZ7?=
 =?us-ascii?Q?L7pkJTP2L08eshrGs9rm5CaBbanvTSJryw8cxOe7wRsJpwCoPMpV23brr9jn?=
 =?us-ascii?Q?MilsH+Y9j1SDh8q33Z8mzH1clEbIpAZKhPm8rK/uSZMOQVuMPJOGOoTWZ/61?=
 =?us-ascii?Q?mE21ZyMW4rpYy47MrIyuznx8ikJOXQTpitZF0dwVlVmwXqIS7HaFczsjuGDv?=
 =?us-ascii?Q?5bXnYaumgRpoH9UjNAKN+utgI8xx6Jjh9OXygqSCGHx8L/GApn31igHUTigu?=
 =?us-ascii?Q?pMEFl16bQgI3FUCJuX8GoUuJP3g7eT4LZidWFwl5i8QkZAlWpOVfLE1Fxg/L?=
 =?us-ascii?Q?HlPClvwCz5yq93iYboZsP5S6kXBHgH4ElDSRWRlqDT3TKkpUqwa4Ny+f4UgO?=
 =?us-ascii?Q?6AODgMTkhjj2W0ld2Tg9N09Uj9txQuNNHj5hVb4R4ecG9maNfz2+Q/LvaSqH?=
 =?us-ascii?Q?PrLhtIRiCk+yqVD/XSxOzKHSQB5khaPdaFhYWOf4SIas3fPNn0re7RdnnZT1?=
 =?us-ascii?Q?+AJhpEUIR/qejFRJfueIxcZl6hBWXF7zfK0m4xNh/A1pH1KxuqAsGzPleIAn?=
 =?us-ascii?Q?AvqTs39ROHaWNPmqax1N2QzdlH8LT+7Kw58nJnbgLN/jDT9WLYlhhopSdjdT?=
 =?us-ascii?Q?jvx2B4yr2enQ1fX4F3aMwHiMR7xHODRl5Qced3WQsZ0wNEo4l+tUXFkkuous?=
 =?us-ascii?Q?YOxt9nDqibh28yh+yvqyD4fI/DIHY7IsIAa/NOtV1oP1ksBSrzMM4MoTZFt+?=
 =?us-ascii?Q?J3RFYOgcuF4S+hTEO0F5qTTCRHgvJ06Q6KI3phUqo/jX/vitrZGdeM+8/BWE?=
 =?us-ascii?Q?ddxaJcCxn1c9yeoQGQnJCi9998xoQbFX1mh1sNsSanVxjurbVkpDS+4gMVaY?=
 =?us-ascii?Q?+7Ll53FZVzlSS1kpaf/oh/QK3ihMjZp3IqYnXOe9QHMesI43NZa9WFY8MzjA?=
 =?us-ascii?Q?aZUX0VTBrai+KTWdQVuAWcckRMmCBAbqDAiZLC/w2vlcg93KvWLBCycb960O?=
 =?us-ascii?Q?zozJm8yWDF/+ZTZdyss1uVF60KI8oKiGnnql6fLfyJt8J9Ly4t56xjOCeLFp?=
 =?us-ascii?Q?j8aNQK3pTKk8J0xwMh80hstaHThZ3tcFfXANS1ciwJfchnJSwkIMOfHLEFc9?=
 =?us-ascii?Q?t3HQoQt7vsogybuq1rlfTdzmRSt1USmqb9tbgZlpe636WqYMlWEXvbeKrr0s?=
 =?us-ascii?Q?smcnCrpaKw+T5j0YEX0HLdUp9Kf94KSOt4nO?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:45:43.1207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1093ebbb-80d9-4181-96ff-08dd865af891
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB1831
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

Enable standard boot with SPI Flash & sync after savedefconfig.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62ax_a53_defconfig | 2 +-
 configs/phycore_am62x_a53_defconfig  | 2 +-
 configs/phycore_am64x_a53_defconfig  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index c9d3c9f4bb8..a1da27cf8ac 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -74,7 +74,6 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 # CONFIG_CMD_POWEROFF is not set
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
@@ -131,6 +130,7 @@ CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_BOOTDEV_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 CONFIG_SPI_FLASH_SOFT_RESET=y
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 22060e2634b..67c8bffd767 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -79,7 +79,6 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -128,6 +127,7 @@ CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_BOOTDEV_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 CONFIG_SPI_FLASH_SOFT_RESET=y
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 40e92525ef2..c9f073f721c 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -77,7 +77,6 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -133,6 +132,7 @@ CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_BOOTDEV_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 CONFIG_SPI_FLASH_SOFT_RESET=y
-- 
2.34.1

