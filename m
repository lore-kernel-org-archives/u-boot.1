Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9B9CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 13:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4729C828A2;
	Thu,  2 Oct 2025 15:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="H2a98Ozw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49450835D0; Thu,  2 Oct 2025 15:05:14 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B39E80107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 15:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEBzOTGS6QIR5R4l+Hg748TnmqdM3CfHyhuA17RyMsF/Spjvra9bHmCbtlecQDFaxeu/b+X6Yxb/D6igSFRPSJlqrjJgtxHpIXp4kD8ZJ8fTwC8C6w5ikz02uXG0zMdRjy50tCN68U/j08ohIsjaW21KKO4cA8ttmJ3v68ognt6ZHZcNzEnER9j7jdfnWb8uiTZmap66C1SAfmm+bvgNQUyS8TbSZEGH+ogWqNZIanUAIB0VDdNroSqzY6RIhLkewjNqEIWVu4377Gzs0WJmv2U0uMbWBYnR0994Wu0cKdXJYgCY4eeSqzKfoCr/ef7JUx9nvDB56QqIDdhJO/fHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlDYMXzoZYgND3fYJh5CAxEj6ss73tEZfcx7NrIXjv8=;
 b=oDQKx3p4B2m+3WxWRomp3rTb0wYwaFamwqkPsq9P0SDEfXaKspOvM2E+JVv0Y0X86IpiCW7mvhPe6sHNVLKel+lsAGfqYvK8xGY2/a+r8LBPOfaFLy6TvyWMvFJY+AhYxV44hTzoqHtH4+mnLub/A1xw5ZIoU8CcmZD6PWVNuejbqK/GCrQI8y0jcJKOY/2npKCwP2OSJ8MlIaWKTWii0GBBqjjejjiqH/UNjeO3saEUD4BQe170Q0qel7x4KhY3AKG/Z3YYCZ15NEEBkv3nkpTaZPMOPBy2iBLCZjBMyGv8oht7r0lQuJ/lhPDm8nWmmTgfMeBzes4DXnD/+9zDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlDYMXzoZYgND3fYJh5CAxEj6ss73tEZfcx7NrIXjv8=;
 b=H2a98OzwL8/GlQ2wLju+FPVCJqB8dO9JcWQ/01RSbJVBdXHQIlLAz57wHon2b2reqXfpbDoNPYENhJDOrwvccfW5X6QlDAxboTaJHISUvzZlE/CrgXMQ2agnKDSQgfh/hgz+YXe7ggyUqr3thkqT2zOBzp81Evh6jKmKnZSZyJGQ88Kw4qgbFvDwayquUFL9TLudbhw2Zv+PYKjBDhrdXm0EbY20/eiRm7x425VoNf30mgmNy3JBym+hYGkenFPlCuuCQRJZLf0f6aLkTpzFM9HceZBaI6+yt9dYOhHdaoICayqrCpLaIlnq7OT8sf0+rji58+BrXrz+pkzw9XrQ3w==
Received: from AM0PR08CA0012.eurprd08.prod.outlook.com (2603:10a6:208:d2::25)
 by GV1P195MB2079.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 13:05:05 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:208:d2:cafe::c9) by AM0PR08CA0012.outlook.office365.com
 (2603:10a6:208:d2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 13:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 13:05:05 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 15:05:04 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <afd@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>,
 <bb@ti.com>, <ggiordano@phytec.com>, <b-padhi@ti.com>, <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 2/3] arm: mach-k3: am62ax: Switch to boot-device helper
Date: Thu, 2 Oct 2025 15:04:54 +0200
Message-ID: <20251002130455.1795794-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251002130455.1795794-1-w.egorov@phytec.de>
References: <20251002130455.1795794-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|GV1P195MB2079:EE_
X-MS-Office365-Filtering-Correlation-Id: a73b4a24-73bb-42d3-65eb-08de01b44e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6fQIbf0PNjI85fBaMSJrtBXbCPO94cPsOHLdhJcqIOmiCN4fzXnlnDF5odsC?=
 =?us-ascii?Q?qxmMgxGbhrvcNG4Iig+Mub4CMAZu3QIbUp79LjMPWfz9AfUG8gDn8/Sld5rF?=
 =?us-ascii?Q?4T+ctSXYFcPWHvGP57u+n8gNx+QUIdHDz7KfBlgrg4Cyp+vgoHMCOzeTU3Pf?=
 =?us-ascii?Q?FZZ9Z8gjVxUZxZLA3xFpFsJfbN7BUuZO7aQQ04/RK3FHkbLXoAnVEEAD9D6H?=
 =?us-ascii?Q?Cr7r4JPNZM6QxuwKvoHzU2YAlp4XzCnme0Fj+DURPRMobgnmhS19G12q+i8C?=
 =?us-ascii?Q?Gt0ZssUFWso4utpddCKQUrNqC/ZEJUcGaIzAfDBc/Lr4Vdk4Jg+DwhqX+1ei?=
 =?us-ascii?Q?73LBG9fdfHVmV6iFd2chArxO+67dBqAS2//JKNgpVy2EnnvJm14FfCtUjNCA?=
 =?us-ascii?Q?o/o2wENDF+Y72juEaNX3WzqJsXei0dbkSL+cUBp75Wh+r2WzyGQMMPFUn9x6?=
 =?us-ascii?Q?OXrmbuEyebG4uVZwwn4xVC8IUahpTzA0CJuL9qz/cYj6Va/ES6aYIx3QksGd?=
 =?us-ascii?Q?Y+q9PyIstjUl9/TBtW2nEDJiFYm4pz8JhZzxacoz0Cjoec2eZsWYHKy6B4Ku?=
 =?us-ascii?Q?ndk8FBFqyOeFgTDcxSd0RF+Oq3Onc2fNs/F++cp7CGsIGOLwHteYowt3YSpq?=
 =?us-ascii?Q?tQqbPkNbE1JNX9Occ0tLd6wb8ltTfExYNfDmupKEwGGT1orrUZmHvenSobSS?=
 =?us-ascii?Q?NwebcqK8yAntVOoogslLGTFEScFAB2AE0kQkDd/KKLyy9EA5FAEXtFFvRQJB?=
 =?us-ascii?Q?rnTAj07LWpdbH7IY78lADZwTv5Cp+Hpp0fgUvE1zsysoTvr3f967NKg/SQJf?=
 =?us-ascii?Q?V7rgExQkXeNsO/4jtcAseM5X8RBgpxsc+rNBllP8klinc62RuR1EnOtiwmip?=
 =?us-ascii?Q?rWPTpxeFNJqXxkFafKEOurxPeokIzZmg2Cn6n+kHk9kCl2civjRwAQwxIlng?=
 =?us-ascii?Q?qECRdYQUPR0zuODx9y2fmuQNQ62Xr7yu04zbc4sKYKLfzTqI3QUt9jk1xTtu?=
 =?us-ascii?Q?R2rWhmL7rtjRk2oGbQadpcR2Rjc8PYrGXgXcOjjGTkE0NmUkLw5m611u027L?=
 =?us-ascii?Q?x71/TK1+qCEKZ/XALX1i32iMtZnIEVnFucK+s1KkciVr2Ed/QtaFrFRXDNQZ?=
 =?us-ascii?Q?6qftjf1rGEcbFw+0n3LQnDxNHlIpgIenU+Ducj8DnUpub1tIds67My339PhU?=
 =?us-ascii?Q?lKty0sPh1W+H0Y1g6pBkedlxskFRFoOkAh+OAo5PuaZaPr/PkpqGjyv5+eHZ?=
 =?us-ascii?Q?V5dm1IYeSK4DVH8o69xrGoTXk57YH8bZr7KCSrM0ko5DGYAGISU8yBthO2l9?=
 =?us-ascii?Q?V8fK+Py6NvQGSfBZGEQxI0WrNj7lkIJH5PMy0iD9mdncxb6FdU5zaKqxJ0O4?=
 =?us-ascii?Q?AY/weXDXMqxG/R4ip7PEd3jc1/v0EVynjVKJXaP8p53cRyQbb76bJJEysjmv?=
 =?us-ascii?Q?Gd+/1O02h+f9WH+dGlVnCqgzvBuFPuhYehT9eeoQIoKGEYlkaCxbulhftphm?=
 =?us-ascii?Q?4CwkoN+i/E7B14y07BtpFb8HB4yhLwGfcTouuL1k77g5lWBIwew2SgKCmSp+?=
 =?us-ascii?Q?FYyXXMk1KZlwHBYy23Q=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:05:05.4956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a73b4a24-73bb-42d3-65eb-08de01b44e77
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2079
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

