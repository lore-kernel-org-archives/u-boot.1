Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE6AC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4C0828BC;
	Thu,  8 May 2025 17:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="D2VgICzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6137982B26; Thu,  8 May 2025 17:16:04 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A3C82AAF
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKjCCWtIfnOanpSwI/HquAw4xpAbH9oQzCviFT3eBBF+/Zo9Xa5XGrQphAk0jqQaAZGNSfawpRYitRoZ8q8gy9UcQP2M9l4MejhHN20eVCiJ6i5wb5ZZNlH68adOkaHiWRb7tBLqyuXn1VE2gkCzlljvR6zDFOPZgqBigqfD/6lDynN5yCIPsiyjqtEAkkg3/Nrb0k17uCzrKEhrtADt09XjPEPffVO6mWl0SHrl8rObhjkn1oapIpKA89fXSeNn8v3coIGPVmpIEIndUM0+aeluK6obWHtFW0m7Owy0tfSVNjVPEfAsZrD8xkcc6P4DhBTu9lmsHdxa4dwJ8KzRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTbDWFtlddP3ZAeiPjcGn3vroTmFt7oCnWUv/rL9pQU=;
 b=ybg7NN6rFMTTW2vuQUSrRnSTEgo3ophfw0ZMtdTqPHbRAxnl5IhLs8X2nMOyEXYG2Wu90HJBiGfwnV2gb1IFW/WptW/lVmmUJD7w+Ut2rv0/INbko+cU087jW7O6B0U9O/MpUsI9QXfH9x3aIOdyAjgXdFYgXpGqQhTAcKMD0SAN2nrjSebeDTXMRfWnWfAGkBnLa5OwP3GsjRTrtSinck3MX3Ya3h+vhWkjtLWQbyV9Oljfv3+7EB3ij71SN2FNDeiXsefJHrPPH88mU+C0fg6exLCZmPsk9g+TtyKPeulUXOzHIqKdQoQXWPj2jk5Ok+CY6kNXXnSw11i57esYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTbDWFtlddP3ZAeiPjcGn3vroTmFt7oCnWUv/rL9pQU=;
 b=D2VgICzSCLNC3fM/naO6JsL9H7fu/Gqa7eOvI/ldtihX6dhVsJ0+G6vLGy28RuNbrF3+/kiuFExAqil2FPuONjuGlxk5TLGmqmYnhDi5Gg/HPL587zXjqsIHZnjjor2YxJchpzvqBBC2TwyCbe8Xh6FfQxsKN/zq98h6hOLvHw3qdKXb61E3KDcmUKcW6sBiINS/tAGZ5rLdkWMRzvny9nwiSREzcvpUXJAjq15mSKF5RH/U9N4kGjRhVoD2G9T1P7p4bXg0T18LAaQ8SfLpV3r77QW4vkukWD8tQx9I/QIKFxRRbuNvbA9zyb/Q10+Vtw12vOeiBOki5oBaBR0QbQ==
Received: from DB9PR06CA0019.eurprd06.prod.outlook.com (2603:10a6:10:1db::24)
 by AM9P195MB1013.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 15:15:59 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::50) by DB9PR06CA0019.outlook.office365.com
 (2603:10a6:10:1db::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 8 May 2025 15:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 15:15:59 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH v2 7/7] configs: phycore_am6xx_a53_defconfig: Enable
 BOOTDEV_SPI_FLASH
Date: Thu, 8 May 2025 17:15:48 +0200
Message-ID: <20250508151548.162122-7-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508151548.162122-1-w.egorov@phytec.de>
References: <20250508151548.162122-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|AM9P195MB1013:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8508b6-6afd-4e42-e65c-08dd8e433d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sN8bg7/j84M0kbd4Q1Ilx6oJ3ocM5iBbg4r8gQIo5Xebs0j0NJOJOyk8hdQp?=
 =?us-ascii?Q?zh6qWNJipR8X1JbZaz57YwvLxSdOvd1mYLjTLaxhH57edV3Ek+qrMKhfuJBG?=
 =?us-ascii?Q?9M7ryoQRHVuk8vUeSX7hC8n98MxWt5lymPD7enDbqismpwhAs5NZnxNFCZ7H?=
 =?us-ascii?Q?cHaMYxlI3tOYUI0NZL/4V5tOobk8yVEo9ue2IEh+F92YYZqIQNdqjAdKEQZY?=
 =?us-ascii?Q?FV7Ov2sqDxUwWg7dOlW54H1PWycUT+GOOeiqHUgdCrkdY1M+5cFSIeiQg+Tg?=
 =?us-ascii?Q?q0PLHuxnRFg2M9km5C2dfZZjYsSLqd6n7Rq6lXjCCMt5w0DiqaydPKiiZ+IS?=
 =?us-ascii?Q?XGkmmWAVMD72x8B/+c62mwIr4BPb/Qtbgp7emKtyiQQ+Ilinu58wmJcOGbg/?=
 =?us-ascii?Q?wukGMAeWIzFrnfDO2B+6bdji9WNE4xycvRkHxxgJyrxNfR1KWXXQDfw3TKUc?=
 =?us-ascii?Q?XcCK5r8Hmg8zHlYlXAzn5nxj8eAZeRl0HSEkCQ+DtGH4wg4C423g+X6YAUa3?=
 =?us-ascii?Q?PuvqJvEMSQNQDnjq6WxX3hWA+suiHzN+xh1n2TbzGINTyEZPB/C6aS/qG4+3?=
 =?us-ascii?Q?YGfFl5rqZEElQ8RKOt2FvncgRONN66w0tbW1tvx2OGvQCLfHeq/2tYDZRPHI?=
 =?us-ascii?Q?CXmQYTU39VSyxlZ6Rwp/keOe3axVAwrLqHGfEJCzoPZIDjmjOMMdxvxkE2ji?=
 =?us-ascii?Q?hv6/E+0xJueV7M6BNj0O/Bbut3hzIImv59wDYdvB/eizqGU74Q+0qaCqw/3H?=
 =?us-ascii?Q?ssgMACPNcQyXBye/tzbgB3eGWD3LOg2HaGZuzmRthQGpqoGXYsMpz6QWpWEd?=
 =?us-ascii?Q?JWDhW8+oaxag4fRGwNKy7xehTaRACPsekvBbE3tigJiv8vklg1b1hQ03hKQq?=
 =?us-ascii?Q?+ThpEs5RV5iTY5TwqIC7f1p2lx8txOhZPUHD4cpu1DY1PhJsEouKoe8r0aGR?=
 =?us-ascii?Q?lE/Q0/SBjmLXWrW0sQwqPnKnw+6L1hCet4YAHf8lWEnDBZa3g3PAS9smEOVo?=
 =?us-ascii?Q?gQe2RLtmJ4o4Srx7bZ+Xj/DfNx3vpo10VMz3tQ2qzUK5e2pewx/FrHazorH4?=
 =?us-ascii?Q?UtjJqmVQSjwnJfyEe7DAOy832Rll84hCdigCpHmIwElbl6r0DquLD5qus/dA?=
 =?us-ascii?Q?SqegfYMW0AChTSPZuGpHS2Vbj7HTo/CjXjI0RyduNMoqPt1eWTAS5TImnrSz?=
 =?us-ascii?Q?9eyIZwG4rc64gVO1fz7hwRgWdjMXwFWCPfMig6xmnCjnZV9qExxU6bqiguIg?=
 =?us-ascii?Q?RML4V7+eRgJX/yeKPdt8OKbVrSwc1NJ2cmFmhgrWOhaf3YJ+HnygHzJng8un?=
 =?us-ascii?Q?BKnmwVVdvPzbA6AID7wQMj+F0zR3lpI3XldyABjCUxDQhIF0//HBPoNHuQe2?=
 =?us-ascii?Q?17fp7CMtwToGUv0xztSBt0E4WdyOku8na/qSuU+QMIOkq2hbJgrfKBnEFgT3?=
 =?us-ascii?Q?rhXiFlYr9BM9f9SS6ckJctbgWR//k67T2sSsv5g8l5sPnj9AXhCfF6FhbsYC?=
 =?us-ascii?Q?xm5rNoWvkp41hg5nErmX4AK8qX1pbCoItubl?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:15:59.8152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8508b6-6afd-4e42-e65c-08dd8e433d4c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1013
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
index 64bf89b14c2..11aaec67e2e 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -73,7 +73,6 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 # CONFIG_CMD_POWEROFF is not set
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
@@ -130,6 +129,7 @@ CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_BOOTDEV_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 CONFIG_SPI_FLASH_SOFT_RESET=y
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index e60ac1f363f..5f91ca647fd 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -77,7 +77,6 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -126,6 +125,7 @@ CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_BOOTDEV_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 CONFIG_SPI_FLASH_SOFT_RESET=y
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 7b3d21e8ee2..8b508d011e0 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -76,7 +76,6 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -132,6 +131,7 @@ CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_BOOTDEV_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 CONFIG_SPI_FLASH_SOFT_RESET=y
-- 
2.34.1

