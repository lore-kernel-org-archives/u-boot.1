Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8795DE98DE7
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 06:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D09983DF3;
	Mon, 23 Feb 2026 07:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sDcy+RUE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F1383DCB; Mon, 23 Feb 2026 07:19:20 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD9683DAE
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 07:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCzMiAlXMowvhAU4eDvxW4ZxrRelhG/qj3V3bzPNWzYCubaqlq/v128JVxo8xyffQc6gRkFSXCQ0xBi74IScQ75JVnTBNvCZ4A4jduAmfX+k4MuDmbv2rGJdiF/iPEGOIc2xKJ7QtF7G8O+RceVNXqykvZD99mR1AA+tnsNX1tGslPNxfy5roijuSz12cTNVauOcGw0Nc6GHx2OoXIWegMyk7CDvwqJfYVbQizezEU9ntDO7oDpNo0K1APsFiMbfKsf39HXpnMxvOTtfIiYdVwgSHQGNVtO8nZT2rsiqu0aVHu6kJTgAaGk5wc7E/GXwYRLVQZhv5/zCJHocF9govQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chiWh07ynHObkkVxl2FZJNu9pCegyg5pZcFBfqlyh9I=;
 b=T6PqcO28P2YMBxpAHL65CtpYdj5yIKFHwnHAH8MRk0KHb3ZurnzYB7jyJZH40K5AIxbMLdxiXhku/DUho/kh0SXCjHToWymzBku8B2uNGND+xJAsUfbi0DZg3RkmgNzfaeroUWnXycHEbG48VxMNswH/yj5/k102q+sW85wCdgrzPQGBhEhpTTUeRVRIfpzd+E1TvkVvF7JdtHnar06CIqvaxzydBiZKxlHytT/m7+G4X8AnmrzWdRtGZSOtq69e1ONUFy6mOrJ7jRwEQn78jNgPMyNZL3SNl2oXAfWLvIQ0+VqkuyLUuJtFNfdZh2Bgzsl62upgNEoi8Qe3rKgQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chiWh07ynHObkkVxl2FZJNu9pCegyg5pZcFBfqlyh9I=;
 b=sDcy+RUEBPX6aA35zTxyB1WUhjGQ4sS4AZDS+tM+Jpend31Ue1qE1AL4INSihFAcYZFOTFxqHK4c1U32EONFvcaQyn5wnd+R09H9O5HZlKqyhNphSTwOyXq0M7muPQB3/yB8DXZkXzcxupTEQsUNNDmJO9/DgPmUcWTmrtGDIGg=
Received: from SN6PR01CA0016.prod.exchangelabs.com (2603:10b6:805:b6::29) by
 LV8PR10MB7944.namprd10.prod.outlook.com (2603:10b6:408:208::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 06:19:16 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::f5) by SN6PR01CA0016.outlook.office365.com
 (2603:10b6:805:b6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 06:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:19:14 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 00:19:12 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 00:19:12 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 00:19:12 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.233.254])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61N6J7Xv3992071;
 Mon, 23 Feb 2026 00:19:10 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH 1/2] configs: am64x*: Add OSPI NOR boot support
Date: Mon, 23 Feb 2026 11:49:05 +0530
Message-ID: <20260223061906.1794872-2-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223061906.1794872-1-s-k6@ti.com>
References: <20260223061906.1794872-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|LV8PR10MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 476cd7d3-e4cf-41d2-5b88-08de72a377ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WayeEEJfaB64jUstZ36LevD7kuTAm19PWBvDGz0hmKJDDD7IdX6Y5qsfqhps?=
 =?us-ascii?Q?Y2C9jIKIlbykQNoMf1t3WzCjf/GqgkzUrlsQC3KXOTdu2JiOC4Upk3UOxbSE?=
 =?us-ascii?Q?MysyAG2ipKYmCY9meAx6koOVPw+CuYtL4uMGhEBZm4We8atc+/HZi/WiqMng?=
 =?us-ascii?Q?Ti9OYH0UqKNB7tmBM32ssUF2dq/Vn+odLVHeQef7uY1oJXkiUlb2hyxdorW7?=
 =?us-ascii?Q?xKmIE2QfrqO9X1x0B4lqOVQsfKh7aObHWWUZDipBXFxZ1J5DGaqfoA6qW/MY?=
 =?us-ascii?Q?KavNPR4tjnv+FWK8mtHxnW80nVOEt+f1jTdSub7FC0qnz86aUfgnIjMfZlVx?=
 =?us-ascii?Q?DyeyL/J7Lky46l3iFs/cRrTqQOpCL98RbZH0JorCxInC/ykHVtHr2cSOZq1O?=
 =?us-ascii?Q?StB6HJh/5ZwAC9Bet+//AzH0ynQ28lUBkQLs0r2kPLXgqV6jndwfyDtk6Jsa?=
 =?us-ascii?Q?ilOzlsxXf2gW1lP36qZg3sA4mfkOZEguhZ8X9MVas8rI8KXughzt2ABTuY6a?=
 =?us-ascii?Q?EZX8t64CpRNILrpUYxo6PKeFEC7rncoSeyEi3eNlvwhZlyb7I5ZvhwP8B4hW?=
 =?us-ascii?Q?gN5LVjg89JZA8VmXLIcljc2YxXchpRpeoyuO8JlF6zg81GKEk7LZeP65FFS1?=
 =?us-ascii?Q?pKrZwv7ax8V0IBzsdGST6X8ZFt8xKipzIFytlQH65uL39wvq+xfVmD8Z82zS?=
 =?us-ascii?Q?NERT+myHB0rAXxXsuwiUmbmaJZrLZBmmjOw0amtNA/Ml/DWxQZHPIIAOqDeB?=
 =?us-ascii?Q?8QHt005hQTv33U+6Us/76vtdIecZ3xwdcgx2WK1WnOcM7QHyuvktHfp5WQK1?=
 =?us-ascii?Q?LaRXzlIvC+i3FV02p8HLh3O1XOFReopEfOd4CB+1qwA8NtkWDH49kWd83ufI?=
 =?us-ascii?Q?3dqaI62F1ho7PckyZCTDI4t9oIxGoth3mdtHhuzxssvYqRDnwAcH/mCzyNMd?=
 =?us-ascii?Q?Enxf/AO7RcGgOQCvXqPx64NDw2Uif2nkDMATzRsMycBFJSHDpty0XLibfrV5?=
 =?us-ascii?Q?yPfJZuDwjduVPW+cyVLiwXVODnD5dcYICrVbEaY0BS3wr66q1LYRfLsWKsR4?=
 =?us-ascii?Q?JSfqoiEe9fQAfKvKXqrHyboEz5IGfrQHYSpNHUAcROOg5zf/qo7KyT/dBt/K?=
 =?us-ascii?Q?OnWVxZn1x/VdThG7tYezPA3UK9elmCe3gedVm6poxViV7JoJSEFX2OuS12kg?=
 =?us-ascii?Q?xJbf6jCcfAVqQc94Sp+dGew/Bw4fo1V1TLqxPz7cpX35OHUF55i7qGViYiqO?=
 =?us-ascii?Q?+yRbA1FBX53xZQXhiA9aiSBZb2tKzzGebWWBNHBa5Gq44UzPiUpuRWy59nVJ?=
 =?us-ascii?Q?7B9Fd3L5ECmWTJ5/6yZFIQf/L8VgcWahRgv/pC/JyEruffMPvKsQrxyN63kR?=
 =?us-ascii?Q?SLc/4kNyio1H6bsTTkaP8g1sC7FY6GA8sn/DouitPPG+MQpL5M85s8jJ+hpR?=
 =?us-ascii?Q?V9D7z3Lzu9g91GqoB4Eq+89glzNE11UeCeIbS1pbGmFL6DsakkPTcGkzdZq6?=
 =?us-ascii?Q?DbR/CzsjflIMJVte2m4C0dKTI7Rbnp4k/Sj5dxck1TvcoJuOCZSWf6krcuII?=
 =?us-ascii?Q?FISrSHU3ZDXRCzuUWAXcqoNt9j7uwMgBGICqAJV1+Yi9roDr0Jw3lhGslZmD?=
 =?us-ascii?Q?MhG2Gcx45mPI8U03dqVkNj7fQSJczyYyK2esWTWM4CV8+WoXKB5iYMU+HBXt?=
 =?us-ascii?Q?SQ70kA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q5f8AlFJIyv2hlI/SgubLD08nVDgpt8zTIC6q7eVJIeAWzmeXsFUI8RrRRxJz/eLJ+JZGulwIconWOM2inNUFz/7SNdtWLe4MYhrKKDBnnK/tBBCb3qKg8ELoRcD6BhOSmenPMa9kdji6UxxUn48k3rlyWEgMgypuBHGGOfhsUkPokWwcn8v5VFJc1fyTvjSm6KUESTKzMad0wuWEup1q4RWUNC1SWMZa7L3JSZAHEvDj+3aiYPl+3QsgWMKrCS8pElTKXnE4KuVhQNIHLvloV/rKRrl2H125fiXs8vKk6uX6ajJ4Vy6AnFnaRZqzRL2Zf+IHX9aA1nSLRARA2sE6pg5hpDce18Kbhu8mxGYuobQ37pXMv9yGFYAYF2NVHZpU3LRbWjpvpKjr8bDmlXViKOcfqZNaQ+Y4y9eyvWpl0W3mPyNtF9Ocjo9YYlzUG9X
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:19:14.9843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476cd7d3-e4cf-41d2-5b88-08de72a377ef
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7944
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

AM64x EVM has an OSPI NOR flash which can be used as a boot media.
Hence, enable the required configs to support the same.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 configs/am64x_evm_a53_defconfig | 1 +
 configs/am64x_evm_r5_defconfig  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index e576012b3f6b..bc0aaf879d6f 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -11,6 +11,7 @@ CONFIG_K3_ATF_LOAD_ADDR=0x701c0000
 CONFIG_TARGET_AM642_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
+CONFIG_SF_DEFAULT_MODE=0
 CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index 6a5190e5c688..19ed1902b470 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -8,6 +8,7 @@ CONFIG_SOC_K3_AM642=y
 CONFIG_TARGET_AM642_R5_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x7019b800
+CONFIG_SF_DEFAULT_MODE=0
 CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
@@ -104,12 +105,14 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_TI_AM65_CPSW_NUSS=y
 CONFIG_PHY=y
@@ -164,4 +167,5 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
+CONFIG_SPL_MTD=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
-- 
2.34.1

