Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975F1CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B28A836D1;
	Tue,  4 Nov 2025 16:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="EeFSVP3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B798003E; Tue,  4 Nov 2025 16:25:28 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55FC183623
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvX2147WAI6NDc2nCDQ/EHGxbMFTF+rCkkSrMyGhHIfWT0uSQMj2vvvjxWrOAhUAFqyKI2CfhjRT3bYMC07GTRZfn/VGdWysSWloVSf5JzIFa/uAWcLIojOASlADqFcZLVv2ejGInBA4xxGBqv25SC0oEm/nZ+btYGGwEV43KOrPlnGJOtFDYM0UbMrcGpUdzS8KXmkpywyeXR0lgReCNzuK1WcNL+8r+E4CrPCHm7NTTZ2YZimja6HHdQ8lE3xphuOXjMKkDgR5yaR0yNDNBMEdUN7Suxi60pdJOaIaZ4md7Myxj4ylO8MUKxldU0SUwSjyDbx6NITSZ5ObCuR19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vezEw0nMIEv1mtYPUd+Gr0tMuYL7i/9zbZsyY2TJabY=;
 b=jFbCpPpkX6nWRy1U6qg44MPMG8mttRcZR1FAS9eu/76AGgqA0LBUjMLFlFlShSKP3JKVhf4gDhCkKeA9/u4KTIflS56tcgaj7+e9Hw02xGzoJeLLmePAdzO6at5IbFOdsvgqyx5HkvuguId/7paucPK8wxOnpcIYe9MEcVAdzWB+tYNsDv7OrNEsODg0fEHaVB8qKD6y+u4Vdek1/Pv2QA7o1umJc8lXjeSDmIdoER8MuBRecXRtiNWBArVDGPAMv9BPN+Kmg4xao9LzeeKbxke6V1n4ciTfJpmPBhKwEjpT0olSNDsp7o+WNggBTDOTypCsLZ0J1R5zNdrnQiyvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vezEw0nMIEv1mtYPUd+Gr0tMuYL7i/9zbZsyY2TJabY=;
 b=EeFSVP3yirT8jJGZSvl3lrlCRQ2SFQO1zalfMjXzr8LMozytW+0PfRP7FJZWpk0HHk9W/raxTWhZFl0UIYJO0UdFrM5Ezq0vWZABARczzWLDSho7kh03GZ/34qly+8sIbCZAQ8E+pAxJMyaPQ8SAFpUzah0f3zdzNg1U4HE4DqEC4a9O1XNIW6Ibj4u8PCCP2oR8aSMQawxDgDzwjTa9pY+HdOdbS67vm6uOaechh+1JoEicxAKik4erQFFPzRsJSbjuZCmt7h9IvoFyCLhSKIpp5FWni9qWXNNQaxaVYNM+DUfFc2dOKda+AkUNNOO81fCxFtisifloB6t9xs0JLg==
Received: from DU2PR04CA0082.eurprd04.prod.outlook.com (2603:10a6:10:232::27)
 by PR3P195MB0571.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 15:25:22 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::c8) by DU2PR04CA0082.outlook.office365.com
 (2603:10a6:10:232::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 15:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 4 Nov 2025 15:25:22 +0000
Received: from ls-radium.phytec (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 4 Nov
 2025 16:25:19 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <afd@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>,
 <anshuld@ti.com>, <bb@ti.com>, <ggiordano@phytec.com>, <b-padhi@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v2 3/3] arm: mach-k3: am64x: Switch to boot-device helper
Date: Tue, 4 Nov 2025 07:24:59 -0800
Message-ID: <20251104152459.3648004-4-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|PR3P195MB0571:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a5c5bc-53c1-45e3-21d4-08de1bb65f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DjEgfuVw4Sn21WkemhFHCqwQy5kcV8WZVgocdatHYETBXN8zs6Vx0eV15PVY?=
 =?us-ascii?Q?X7mT84ZrPHHRaQKBh5H4YrknWtP2W8jWCrVokQ4QQLGDOuF5j3J93ASXbAkb?=
 =?us-ascii?Q?H0Q8cCp2nATI8jvCwoUynjbLv3dNyofwnIXaWWuNfzU7c+h+BF8pneCBDHk0?=
 =?us-ascii?Q?7SqytZrSjrlaAXCTMs9+TgnzakW5ZVrcX3VzxbFxEQtus6qukMgyty3NFDFi?=
 =?us-ascii?Q?UiObKPV/tTxOT2+98/YmJfOg1Q8gwxyzXkJVvysBNXFGExxq98eEHA4bsfji?=
 =?us-ascii?Q?F7Otd42W6sknAatPu6P+0Q3wYE0QyOVaA584er1o2r8oHzoToqXRgN6531NS?=
 =?us-ascii?Q?21fA59WN2rnhgi+b2FJvwLtLjQj6t6kf/sTg9rtiGRcdoUWvqjD7nxR7fbvE?=
 =?us-ascii?Q?fnBLXM2iMALshDu6aotXnM7f2BtZe86/++4tGP6TJOEsUWEBiOabCgEij9bP?=
 =?us-ascii?Q?kFAQvxYi7Q7Krs10yNzE+uOZPKet3Syo8q41trFnfcy969syw3+V1HUGjl/2?=
 =?us-ascii?Q?SeF1QW8PlobGSuztw7fSKYCdZRo3V7oQtdqqHKFmZhB+Cfe5xgsp0jN9K49O?=
 =?us-ascii?Q?3OGqdLO7oBKnMutRdmbxaHwwKmp6YhaGZeVAavfb7AyiFaBzSP5QHJA4hukK?=
 =?us-ascii?Q?vD6XHoGwSXRDZwb1e4pFihGN1rEXZhTCG1ZEfoYVNDriG3mWI7xkyJWCo9Sc?=
 =?us-ascii?Q?LiiIvrz6V56sL8hVMr9CR3mwhn6id+cMkrx+TnSRRev0RCl77E/itxYwmCpP?=
 =?us-ascii?Q?KSV35R/NF0mABGS9q4p426EJihGWU/9fZEM4QS5LVHeuO8G5iZFOl3bQlj/2?=
 =?us-ascii?Q?UQ8kZOQ4TitXevy8HB6g3WSKEVltnC0HilhbXu+CUAKO0gEYQ7RaRo/RujW3?=
 =?us-ascii?Q?LyqSLXowN33e16DLVN8veVHFeoQEfRPbq2vo0tA5zC3YJHnl/TE2SsK71f6U?=
 =?us-ascii?Q?niuVbhqneGJmvzRqHWXPveX7AU37o7gNFs6BscQE/7iHhO1Q/Ks05DJ1T2UT?=
 =?us-ascii?Q?Rbpz8bgEeOXTqYavEUlAsfvZ7jpRCFAJUiGM8uHL5diE2J5EASa+P0LRLVek?=
 =?us-ascii?Q?0AM6TyCzM0Vy4YDBpMH+4owNbuHwS0q1h/6mofwKzAmZ5wXfNrrtrolVLQpq?=
 =?us-ascii?Q?1o9gwevNvLAAm2iLo9FMuLCHU6o+XcbY8ohCd7vBi79tqg+f/Zcyd0a8KjXp?=
 =?us-ascii?Q?FGMqWwsXiG+Avzd7LWvxyfSA5RDw863MI1XcSH5AkYns/NVsZN/BHOMyUbWX?=
 =?us-ascii?Q?KU7WFJkaO2wHt1v0EStyrL7V2pDui8uNmDvlhfbD1MFO8k80NxWp7jCkLX2M?=
 =?us-ascii?Q?JYNfhC8sPoPWM8fburzh0mjpmr22YLtb6WE3e+5VXAJFFhvGV/LDmbZlAacc?=
 =?us-ascii?Q?liE7VwgPaEliykm+3UkZD3zUCvBUOzIQn2QFNFvPrSdSUkPiMQGRMgLGep1s?=
 =?us-ascii?Q?CXjY0ANHqXdQnq4wj9rCtTOkZsRquSvm3aUhjweDc5TRKuRfCiTpgRnZsoF+?=
 =?us-ascii?Q?0qkD0N8hqhqPz3e6N8qtN0t1Qb98Ng2qkeQeoPPhK0dy/+nuyRGRyyMAcmFN?=
 =?us-ascii?Q?iFHpKNCy9bFsG+gFES0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:25:22.6591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a5c5bc-53c1-45e3-21d4-08de1bb65f23
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0571
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

Update am64x to use the new shared boot-device helper instead of
its own get_boot_device() implementation.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/am64x/boot.c | 139 ++++++++++------------------------
 1 file changed, 41 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-k3/am64x/boot.c b/arch/arm/mach-k3/am64x/boot.c
index bf8e1a5cb44..7aa1648536f 100644
--- a/arch/arm/mach-k3/am64x/boot.c
+++ b/arch/arm/mach-k3/am64x/boot.c
@@ -3,105 +3,48 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/spl.h>
 
-static u32 __get_backup_bootmedia(u32 main_devstat)
+#include "../boot-device.h"
+
+static const struct k3_boot_map am64_boot_device_primary_table[] = {
+	{ BOOT_DEVICE_OSPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_QSPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_XSPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_ETHERNET_RGMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
+	{ BOOT_DEVICE_ETHERNET_RMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
+	{ BOOT_DEVICE_EMMC, 0, 0, 0, BOOT_DEVICE_MMC1 },
+	{ BOOT_DEVICE_NAND, 0, 0, 0, BOOT_DEVICE_NAND },
+	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 1, BOOT_DEVICE_MMC2 },
+	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 0, BOOT_DEVICE_MMC1 },
+	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 1, BOOT_DEVICE_USB },
+	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 0, BOOT_DEVICE_DFU },
+	{ BOOT_DEVICE_NOBOOT, 0, 0, 0, BOOT_DEVICE_RAM },
+};
+
+static const struct k3_boot_map am64_boot_device_backup_table[] = {
+	{ BACKUP_BOOT_DEVICE_UART, 0, 0, 0, BOOT_DEVICE_UART },
+	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 0, BOOT_DEVICE_DFU },
+	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 1, BOOT_DEVICE_USB },
+	{ BACKUP_BOOT_DEVICE_ETHERNET, 0, 0, 0, BOOT_DEVICE_ETHERNET },
+	{ BACKUP_BOOT_DEVICE_MMC, 1, 0, 1, BOOT_DEVICE_MMC2 },
+	{ BACKUP_BOOT_DEVICE_MMC, 1, 0, 0, BOOT_DEVICE_MMC1 },
+	{ BACKUP_BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BACKUP_BOOT_DEVICE_I2C, 0, 0, 0, BOOT_DEVICE_I2C },
+};
+
+static const struct k3_boot_device_info am64_boot_device_info = {
+	.boot_device_primary_table = am64_boot_device_primary_table,
+	.boot_device_primary_count = ARRAY_SIZE(am64_boot_device_primary_table),
+	.boot_device_backup_table = am64_boot_device_backup_table,
+	.boot_device_backup_count = ARRAY_SIZE(am64_boot_device_backup_table),
+	.main_devstat_reg = (void __iomem *)CTRLMMR_MAIN_DEVSTAT,
+	.wkup_devstat_reg = NULL,
+	.bootmode_addr = (void __iomem *)CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX,
+};
+
+const struct k3_boot_device_info *k3_get_boot_device_info(void)
 {
-	u32 bkup_bootmode =
-	    (main_devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
-	    MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
-	u32 bkup_bootmode_cfg =
-	    (main_devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
-	    MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
-
-	switch (bkup_bootmode) {
-	case BACKUP_BOOT_DEVICE_UART:
-		return BOOT_DEVICE_UART;
-
-	case BACKUP_BOOT_DEVICE_DFU:
-		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
-			return BOOT_DEVICE_USB;
-		return BOOT_DEVICE_DFU;
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
-	};
-
-	return BOOT_DEVICE_RAM;
-}
-
-static u32 __get_primary_bootmedia(u32 main_devstat)
-{
-	u32 bootmode = (main_devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
-	    MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
-	u32 bootmode_cfg =
-	    (main_devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
-	    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
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
-	case BOOT_DEVICE_NAND:
-		return BOOT_DEVICE_NAND;
-
-	case BOOT_DEVICE_MMC:
-		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
-		     MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
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
-	u32 bootmode = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
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
+	return &am64_boot_device_info;
 }
 
 const char *get_reset_reason(void)
-- 
2.48.1

