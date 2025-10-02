Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C92CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 13:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D212A835A2;
	Thu,  2 Oct 2025 15:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="i1BjtChh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 610AD83621; Thu,  2 Oct 2025 15:05:16 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E73835B0
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 15:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5yNr6x7+Z/VLKDs7SD8SOZAI2E7FbyIUiPliVg1lHS7G2xQbn2AL0/Njj5HLZMTh/oq+x9spj2LSHZ36rH49QKPIW9afiph9GHQWYft0ArNpCYZ2CORCjW2Z5yQg3q/VA1+vxdPaDLmI0slUdFT0ANN9xHlq4QrIJtkvQq1QFOI8gEh2makReo+kWBw32GBfTepT6wye/TYFfD/5Kh+2V8HtFIwwAhcMP71IiLTndlNh3p/k1ue8+VfB9q8K3KYsHJkU+VdmO2+S+HBHNGOKM+r4TyCGKkDWtfgsfMuxhmGUbX982xUjXTzzFpFBIaFUTbznqpFcshGic0JIegyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv7pZtyXMpKN7tykUctjKbvF/BPKS68fxbQUz/k3clc=;
 b=nzMisikHHyXwOq1I+qmpwcCvF2pM36MXfz7j4tnuvrqGUMnjHWGqY1lxo9tEqsW5G9EULi4SvHBIdhGreSCotzFDIaWqzZtQQ27rAErNfpomucMabiwKzuhiBYsxhsFg4nx1rOD0XKXV3aj91QqlLWf4inn0FMcV8LfxGjaFr6U5C3ka5PvQZzEJDipvJqEldbWIKo9SKyaeC6wwDktLGwqPD/VDGBwTqPbcHNIV8yzLyMSsgbNvYE8KdIPg0nivRH5UMOEyNr7Pvi0ENcjecjEgsc0AISCbOTDlvNNuk7NYYy6jU5UaZwD1nnUem4pnJIlLm2AhhaT3egIPiLgLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv7pZtyXMpKN7tykUctjKbvF/BPKS68fxbQUz/k3clc=;
 b=i1BjtChhN22Ik79X+DHBIaPvymifM2MyuiWRzRBX8sNyuqFoPNxkEt8fTb9S9Sr/CtIyACKOkrUs9KE66GQQXET+uBOwgrgxccOLmkUl6XVc5BOOIObLuk3ko0wfxz50bz+P6iF8l0O/Z7ZQX6CFvI5mYUH/6fEyb4VEeA+CC1CgIfpQKHx3NLsrlB7Ua7o4enJJvfo4g/xfpBq5ReHcucB/Qlu5tYdpMuSWjdnWRT9d//sR8/lJo1mlble0DDb/AXH9low6rzE+yfgx85JCOlX/Ht6DiolvAe4VO8hr3jOMWCM44WJN1gGwQQ0gziBRiH381nQ4A5SXCKBTCHxtYw==
Received: from AM0PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:208:d2::15)
 by AM7PPFCEBE6340D.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::764) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 2 Oct
 2025 13:05:06 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:208:d2:cafe::64) by AM0PR08CA0002.outlook.office365.com
 (2603:10a6:208:d2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 13:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 13:05:06 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 15:05:04 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <afd@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>,
 <bb@ti.com>, <ggiordano@phytec.com>, <b-padhi@ti.com>, <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 3/3] arm: mach-k3: am64x: Switch to boot-device helper
Date: Thu, 2 Oct 2025 15:04:55 +0200
Message-ID: <20251002130455.1795794-4-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|AM7PPFCEBE6340D:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6aeb45-b355-4450-7874-08de01b44ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TggxsZ+BFT1XSpOu2TeYvzCZ1Av/xzGnxAq3vJhjh8R9ihuxuHgvnmU5vRJS?=
 =?us-ascii?Q?GCKHkvxji+ABAl37RrjFoQUVl/9mJrEgvx07Jci6duoz65gOw9FfvifXK4Am?=
 =?us-ascii?Q?brhSnwgBHf0rVBxzmS5jDysL7yXZy2tN264h/2ZgRh0AVvWlmM5k6HH4cKF0?=
 =?us-ascii?Q?UtnQc/DR2tN5jWz4uaR2on6mN14FF6Jx1mU57qkjnDVn/3JqFiAoodfZzB2o?=
 =?us-ascii?Q?MWd8TqtcCEllvfs+gjCr+R05IWGaGRMvWbA9xLboeAdHcZmX3BZvf90BI39y?=
 =?us-ascii?Q?pgluFTnIUpoDDcCUX3YqWUvxp2COkp1ym3cj+RZDYGQ0HqiLD8AeRnjfHUOL?=
 =?us-ascii?Q?yZZa88Dh1JnpAy8XX53J6VKghQpLM+pt9aY+RFJc/0yy3i+flWb+ThzsfG9e?=
 =?us-ascii?Q?/zUXKa7kXTmLUS8YbyE1G69A3BEK2vzrcIQKfBPnD/sqFGYu2nNKFc+DWZCh?=
 =?us-ascii?Q?TVRyNFnvfeu9jrJZbgU3o2QEtDzRbpqMyrH9mssq88jwlFDnPRdugGxBYSaA?=
 =?us-ascii?Q?kjt/FDiRSi/dzEk42lLU/5BnPnMAZ5met1qb8tX7S08BC48vYq0pjSkkObXM?=
 =?us-ascii?Q?UxmJ5eRLhnlC1Kh0DJFQQ0Vo08T/l7guVUQHxtuHLSBY2ZD2Du/+99/Rzpv5?=
 =?us-ascii?Q?Ucfvu5HfmW+rDc3n4yAVQT15gM2SCD55J/6rDK54o/Q1bxhSehJdqy3XxDfB?=
 =?us-ascii?Q?pYp1Z6+AgT7TKBzqmN2Gm5TsgRMAZNXrE+TiUBntABDIozycjN5vrVTeT5w/?=
 =?us-ascii?Q?m/mHYpGf49F3exbOwafVxhlyEkuEX4k+R6GXT84RPD4EXXwt7O1qF+AT79SC?=
 =?us-ascii?Q?H6UNtmwQG5SZ5LEgLcNhrUhdRiycVdPlvLKp5DwgcF/y2eDksaYZi25MHq2S?=
 =?us-ascii?Q?juZuyaZ6wCAybR6Is/Hiaa360yPtDdIeShMVVGWLduWF3WsX/7RCMA//ZO1h?=
 =?us-ascii?Q?RUfSCHlBOMeJH+Pwk+eP1fLrYMZJ/XzY3razPAY2UC9axhribJ1JaRKnKFjx?=
 =?us-ascii?Q?+I8X+s4u1AcnR5x9CvhX50aCNYFj4tmJ+Djum5sMTcKgEiHeQs5i4hRThle+?=
 =?us-ascii?Q?l5pghqYrUasFVFvLMUq9gs4W7QcPKujiggLxv6AUnMvJ3+DidX16nwDtbz2F?=
 =?us-ascii?Q?AoZrEyCXdHoIiDf9u7ivv+r80sS14mM1CPsJuWEaBiE/4WGdI8qRUytuFHny?=
 =?us-ascii?Q?ZQ5jv0OXTgHRiimPgEksK3rPkjL7O9Fvv/JNi4mQMcHpNMQeDmOZQGB+Q2cT?=
 =?us-ascii?Q?Dw0l4Q+mk13zcien8+LvaRHq3vhOjUW2gcz2bc++F0FpA9jwhM4emV+VJRIm?=
 =?us-ascii?Q?12J5GwzXAl7kYaJ0f2NS4r4CVxWTHq3U1acH7Vg37ll7cxXVQ0hsbu+Pcgqr?=
 =?us-ascii?Q?OEmJV7HV13feEhYudfXNfuw+S5PLOV4q7I+EVUfnEu62EYGqfaSPe/9Mfyo1?=
 =?us-ascii?Q?qqsb3RHfJobIwcOCrBxviNn7esVPBMe7BoSuuTFOw+Cg40j1k1WagB9PfN1r?=
 =?us-ascii?Q?Gz/c1WqulD8HhLMTnaMxSSscYngPVdQUe43eEMTmn0fx0r1TtYnbwkcYElSB?=
 =?us-ascii?Q?2xGGH4PPqXbvSgq0MtU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:05:06.0595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6aeb45-b355-4450-7874-08de01b44ecd
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPFCEBE6340D
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
index ce8ae941be6..3ef6e60e989 100644
--- a/arch/arm/mach-k3/am64x/boot.c
+++ b/arch/arm/mach-k3/am64x/boot.c
@@ -3,103 +3,46 @@
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
-- 
2.48.1

