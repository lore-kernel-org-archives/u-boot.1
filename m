Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08EDCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1EEB838EC;
	Tue,  4 Nov 2025 16:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="MWU6x8Vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A32838E7; Tue,  4 Nov 2025 16:25:25 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 952F983623
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPG/6AAx7o2QwG0iUJuEhgVeziF44ugXAo+/Iy+1D+/a7sgM5VEq4UrbWaSFEum0l2QzbuoK8cX6WseMOmbdXAJmWwI3fhtEshqahICp83A/PKrO0LbA6z8Ro75E4hEf35yz2eTpCVTOGnHFwXuN3Ikc7ppRtTbQE31RklabNYNdJ1XSV9QrJiTsJzboeLBIB2eIUOMgUSuK5B23x4xnqTp5pW/tdcmk5D2GwzwG33tkSO5AwYD7pphYvEXzMVUZZodgll6mI/4Hp53QkjmIS+yRvdY4Yi7R3shAFPKq5MikhLiqDx+/o57aThDMOfxH61BRDPEwWsLZXg9AV9k09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlDYMXzoZYgND3fYJh5CAxEj6ss73tEZfcx7NrIXjv8=;
 b=jY77vbDwbBex18XEbW1sQ4wh9AhFX7zWPo1xy7DMbBPDJVsbu6XBdMFRYp/rFRRB0LPxBgHQrN9V7DUthaRSiVxvmxcY7xDxWRakOUcBZyn1GqrigVRT8WsMNsGJqVlMNWU63Mf2wzfPH2w6N4yck2jsSzvmLmdWtiHSqrmvB5SUS6SM2CwvtgO5wB2IICGl3tIrt4iLPGoHFp0v5ydhbDSrWNzo0lnJvPBoSV9h1xN2uMoVUk6/uBSRDX2836fDAA8zQGhs+ap8FvJvL7OKj4LIKJDE4YgS+IN+opBbjW5upNVThyteWKBnGnPefsW9IQrN6LYnR++mvp/ZtIf46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlDYMXzoZYgND3fYJh5CAxEj6ss73tEZfcx7NrIXjv8=;
 b=MWU6x8VmueMDugOTRGwvRPPXjRYdjtEpONDwSKkdnsEx1ADNAsWi7k6DIFplbjgxH1ABQ2oLP8rDaVyaNwJUfAitC3r6+C63WdcH5YyRjF+BcGLvDm8vVmIEkBvTdFuNWjGj2LgdY5povl/VM0Q0qFjMjEFH6Mbo1dyBStrnsRnH9fLeSxJW0quaLmFjpOauFbsrmpCipSsFN2d7zlXD57OASsfLxXnRmJTMKW9VRXAYu023qd1YVRe5SZXH4t9AK4juIGqMskd5BS/llBTAl5e/1HA/qmtPEwguFJTdsQG8t496aHC7zQs3NPNTWkZWddhGcDG0+TGdMNww6xWUCA==
Received: from DU2PR04CA0256.eurprd04.prod.outlook.com (2603:10a6:10:28e::21)
 by AS1P195MB1596.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 15:25:20 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::9d) by DU2PR04CA0256.outlook.office365.com
 (2603:10a6:10:28e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 15:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 4 Nov 2025 15:25:19 +0000
Received: from ls-radium.phytec (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 4 Nov
 2025 16:25:17 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <afd@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>,
 <anshuld@ti.com>, <bb@ti.com>, <ggiordano@phytec.com>, <b-padhi@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v2 2/3] arm: mach-k3: am62ax: Switch to boot-device helper
Date: Tue, 4 Nov 2025 07:24:58 -0800
Message-ID: <20251104152459.3648004-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251104152459.3648004-1-w.egorov@phytec.de>
References: <20251104152459.3648004-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|AS1P195MB1596:EE_
X-MS-Office365-Filtering-Correlation-Id: 9369f97b-4827-4a77-d91d-08de1bb65d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DRy905B/E/BlgPWW5yZy2JzLVUbErcMEC0WmWtIbmVa/ZRd8pnlB+o4+EUXD?=
 =?us-ascii?Q?P+sZ69Kkf25cCUgB2MaHH10uBIqTQb9CYMNIc/hz0Ie8vlpOco7IjiVwyQhp?=
 =?us-ascii?Q?sranKh/S2OpXd6l/e+3j18d0uQDTwBHx/65xe0KXEWtgyxv8mV4DHLY9UEWg?=
 =?us-ascii?Q?sdrJdDix8JyFBX2DTvZFPODg67GOS/xkQpjzQ4hEz2biJbELDxhI9h3eTF1d?=
 =?us-ascii?Q?UwXZz/Y80+gGJ3fT4UUP4hq3xJzG4HtaAQ37vqoOQYIN2jdeIQO6Bz8GWg2F?=
 =?us-ascii?Q?UoAYKFxovx41mZkVYlmgbVU0GZ++OMIjIVxREicNTZNiXLLDIJcuHFz+qgvB?=
 =?us-ascii?Q?7F/VppjjYNJ5ej2Fpm34PeJTDCfGfWTmGSvGzm7hsCm7aRWJd32MnoaUN/MH?=
 =?us-ascii?Q?ZRizYfNvBBjBYqENgLH4ZCVn2w4Sq2xME7xzmhQ1d8+hTId7NmcyG6F49dlo?=
 =?us-ascii?Q?IEP0Wkkl6Oe/tUoISKJpYbZDLi0TFPJVq6pb9ut30eNjw+NIO261FU/CRLLm?=
 =?us-ascii?Q?0RcUmrlmKFQQC+O2Pdoql3z9zIn8I1iJ7v3tmG0t8XaHm7UCsxHk5w01QbYz?=
 =?us-ascii?Q?ufnMzQ9+6wY2PQVqrvzZrbZsI6IjiNYwmvz3emBv6P2F7kf8nTz9ernuBGB/?=
 =?us-ascii?Q?olyyAoXaEF+zHZDqrvaDTVWWGQMQwPCl8S485DW7PDNUz1qUMM3HgikmBWCE?=
 =?us-ascii?Q?lHJOhsO8v0g8eYa0HRCtwAxQ68HQtvj1hATBYHs3CkyQxQ+zmcD3THLhjt6S?=
 =?us-ascii?Q?QRhNX9I+0JNGuBmDqvWyaUUvrmmT+I1Rzgx9Ha1gYFRUPUQlAQONQbMZB8sg?=
 =?us-ascii?Q?EHh3DnGZNlVhO6TFZNgZgpEZg0+RYmKt2YUIcFd5zKUR4qtR/SrLAab2FNsr?=
 =?us-ascii?Q?qXCNCTafq+uBUk5605TqditL/eXSHfzb+YyOf2ehioX2e0sUl0tw21f2J7nX?=
 =?us-ascii?Q?hBSuSQawkwhyU3Uh+wPC0Rq3nwc8M+B55updNTU85vf0EAa38tKRMMtl3Hdj?=
 =?us-ascii?Q?KNG/JHQjpQjFESHeUO2Hd274dlV1QnQReTwf/nKqYK+veE9fs8mK6WkjOi8e?=
 =?us-ascii?Q?7KvryogAd/UuFTWcxLQkP3qUTqz94sxwnb6ZWeiG3/Ax1GO//YiVkeu1TiRg?=
 =?us-ascii?Q?zottRN14TiKwgVr4c2heHEn2b0IiHQoOIseTFBDxf3+4Q7FW5Ck7ON8AZGxq?=
 =?us-ascii?Q?pmaE4Ca/2HhXDSZTA+EVn7V4qrRCXLFwSRu2j5/LvWGBOwdfEhUcjei7Q2DG?=
 =?us-ascii?Q?xr5fa6mXyGYd87Xi4NH3DosXpu+bvG9FgYEr5joBw1txfl3yn63pqzfI7YVa?=
 =?us-ascii?Q?ElB8XD1jyaXdeMgytM2WCvG1IeA7JmJ892//ZgGVhuSfcRCVBn6Rvxnk0vTT?=
 =?us-ascii?Q?ID5URgvm29jDziJAmT7PlKRGFZV/zOejxaVl9L/rZA0Dqv29OSRa8YJv2SbO?=
 =?us-ascii?Q?mYBytnzhpAfm6ae11gwGUrFKhK6CE9Dw7pRMvkTLKdkCs4NtT1Qrn4Rgakg2?=
 =?us-ascii?Q?ctoseclmRO8onhiF/mJUvflAujCJb1GYQJoDSynxyZnerw3m1riSoeVoA+7G?=
 =?us-ascii?Q?AflwFS/VU8JGC4ug9ss=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:25:19.7940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9369f97b-4827-4a77-d91d-08de1bb65d6d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1596
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

Update am62ax to use the new shared boot-device helper instead of
its own get_boot_device() implementation.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/am62ax/boot.c | 141 ++++++++++-----------------------
 1 file changed, 42 insertions(+), 99 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/boot.c b/arch/arm/mach-k3/am62ax/boot.c
index af7fce1e5e9..364bf9ed026 100644
--- a/arch/arm/mach-k3/am62ax/boot.c
+++ b/arch/arm/mach-k3/am62ax/boot.c
@@ -3,104 +3,47 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/am62a_spl.h>
 
-static u32 __get_backup_bootmedia(u32 devstat)
+#include "../boot-device.h"
+
+static const struct k3_boot_map am62a_boot_device_primary_table[] = {
+	{ BOOT_DEVICE_OSPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_QSPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_XSPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_ETHERNET_RGMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
+	{ BOOT_DEVICE_ETHERNET_RMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
+	{ BOOT_DEVICE_EMMC, 0, 0, 0, BOOT_DEVICE_MMC1 },
+	{ BOOT_DEVICE_SPI_NAND, 0, 0, 0, BOOT_DEVICE_SPINAND },
+	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 1, BOOT_DEVICE_MMC2 },
+	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 0, BOOT_DEVICE_MMC1 },
+	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 1, BOOT_DEVICE_USB },
+	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 0, BOOT_DEVICE_DFU },
+	{ BOOT_DEVICE_NOBOOT, 0, 0, 0, BOOT_DEVICE_RAM },
+};
+
+static const struct k3_boot_map am62a_boot_device_backup_table[] = {
+	{ BACKUP_BOOT_DEVICE_UART, 0, 0, 0, BOOT_DEVICE_UART },
+	{ BACKUP_BOOT_DEVICE_USB, 0, 0, 0, BOOT_DEVICE_USB },
+	{ BACKUP_BOOT_DEVICE_ETHERNET, 0, 0, 0, BOOT_DEVICE_ETHERNET },
+	{ BACKUP_BOOT_DEVICE_MMC, 1, 0, 1, BOOT_DEVICE_MMC2 },
+	{ BACKUP_BOOT_DEVICE_MMC, 1, 0, 0, BOOT_DEVICE_MMC1 },
+	{ BACKUP_BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BACKUP_BOOT_DEVICE_I2C, 0, 0, 0, BOOT_DEVICE_I2C },
+	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 0, BOOT_DEVICE_DFU },
+	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 1, BOOT_DEVICE_USB },
+};
+
+static const struct k3_boot_device_info am62a_boot_device_info = {
+	.boot_device_primary_table = am62a_boot_device_primary_table,
+	.boot_device_primary_count = ARRAY_SIZE(am62a_boot_device_primary_table),
+	.boot_device_backup_table = am62a_boot_device_backup_table,
+	.boot_device_backup_count = ARRAY_SIZE(am62a_boot_device_backup_table),
+	.main_devstat_reg = (void __iomem *)CTRLMMR_MAIN_DEVSTAT,
+	.wkup_devstat_reg = NULL,
+	.bootmode_addr = (void __iomem *)K3_BOOT_PARAM_TABLE_INDEX_OCRAM,
+};
+
+const struct k3_boot_device_info *k3_get_boot_device_info(void)
 {
-	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
-				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
-	u32 bkup_bootmode_cfg =
-			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
-				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
-
-	switch (bkup_bootmode) {
-	case BACKUP_BOOT_DEVICE_UART:
-		return BOOT_DEVICE_UART;
-
-	case BACKUP_BOOT_DEVICE_USB:
-		return BOOT_DEVICE_USB;
-
-	case BACKUP_BOOT_DEVICE_ETHERNET:
-		return BOOT_DEVICE_ETHERNET;
-
-	case BACKUP_BOOT_DEVICE_MMC:
-		if (bkup_bootmode_cfg)
-			return BOOT_DEVICE_MMC2;
-		return BOOT_DEVICE_MMC1;
-
-	case BACKUP_BOOT_DEVICE_SPI:
-		return BOOT_DEVICE_SPI;
-
-	case BACKUP_BOOT_DEVICE_I2C:
-		return BOOT_DEVICE_I2C;
-
-	case BACKUP_BOOT_DEVICE_DFU:
-		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
-			return BOOT_DEVICE_USB;
-		return BOOT_DEVICE_DFU;
-	};
-
-	return BOOT_DEVICE_RAM;
-}
-
-static u32 __get_primary_bootmedia(u32 devstat)
-{
-	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
-	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
-
-	switch (bootmode) {
-	case BOOT_DEVICE_OSPI:
-		fallthrough;
-	case BOOT_DEVICE_QSPI:
-		fallthrough;
-	case BOOT_DEVICE_XSPI:
-		fallthrough;
-	case BOOT_DEVICE_SPI:
-		return BOOT_DEVICE_SPI;
-
-	case BOOT_DEVICE_ETHERNET_RGMII:
-		fallthrough;
-	case BOOT_DEVICE_ETHERNET_RMII:
-		return BOOT_DEVICE_ETHERNET;
-
-	case BOOT_DEVICE_EMMC:
-		return BOOT_DEVICE_MMC1;
-
-	case BOOT_DEVICE_SPI_NAND:
-		return BOOT_DEVICE_SPINAND;
-
-	case BOOT_DEVICE_MMC:
-		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
-			return BOOT_DEVICE_MMC2;
-		return BOOT_DEVICE_MMC1;
-
-	case BOOT_DEVICE_DFU:
-		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
-		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
-			return BOOT_DEVICE_USB;
-		return BOOT_DEVICE_DFU;
-
-	case BOOT_DEVICE_NOBOOT:
-		return BOOT_DEVICE_RAM;
-	}
-
-	return bootmode;
-}
-
-u32 get_boot_device(void)
-{
-	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
-	u32 bootmode = *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
-	u32 bootmedia;
-
-	if (bootmode == K3_PRIMARY_BOOTMODE)
-		bootmedia = __get_primary_bootmedia(devstat);
-	else
-		bootmedia = __get_backup_bootmedia(devstat);
-
-	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
-	      __func__, devstat, bootmedia, bootmode);
-
-	return bootmedia;
+	return &am62a_boot_device_info;
 }
-- 
2.48.1

