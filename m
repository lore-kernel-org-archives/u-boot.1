Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B69CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2838004F;
	Tue,  4 Nov 2025 16:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="p5mK++xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59CD98389A; Tue,  4 Nov 2025 16:25:24 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1714E8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ka+VqNUgF8Hj3QGhTHBdqaRTwXG+5ZpF3bup6MPGra1ZZLG93yzyDWF2GqXDJdx/A/bqenRog6dFvzuKNUI5fLBwmAK13Xk/b6K0vjEyGH8J5INH16cGMrggP5FGVssCVLSinkRubAQYnS5KrqtSzIaAQLYj5F7QnhK0kvel/bnvjS4/LpsXL8fx+BjhmHSuKdAOTQuT4JzR3zkm8h2PPUIa1kIiurwck/kiY7qsOJzvtm294OX4Nu1BKFx/7j/da4p9uWkcrAizn+9ygv9kbHQN65yUwFyVn0EI5Smhi78DSYzuqlA2bFUfMkW9zbsjJQ/jozbUwB/BxwpcxpcBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF9XyXCb6SwNzqiAby2a2Ag7AEVcCpmaaWKIwka8bh4=;
 b=WyO/Rd+gYV+HzWmNirhG1DchNVn+rivK7xFiwYRCqFJlIuWm4m5so4sqOh4H8kyL5h8lZb54wPFfGELqGx7UqCB4D62Qk7wH/UkzVhYLEV2K5N5Sc+rx6PylPS1fwvHy5S+gnS+OsL5u9JFKLUtZq4imVgAYc/5nRnZppAQTKlo00gP0agb4DdwGNrojyTJZfRdt3kSoG3QzqRKRtyLjDNEOu/IXTovU5EEI/oHOhlCNn9/9mzwLbZNvXuSreWr8Mk+vtSFxtUwBwRhUINFdlMZyiD9a4jbNt9i5dkrb6LfCUt0PUh8tNBj3qrBhwGoOJqQiXA/znvtoGtfxZdkcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF9XyXCb6SwNzqiAby2a2Ag7AEVcCpmaaWKIwka8bh4=;
 b=p5mK++xetWrs4EDmPJOQeFS60XiR9+X4WUfKPh821nzAIJlkf9AGjgLqIR8vVlNqksfh2cxCFppfLKUpmghFOzq3CfyOesV7fwZI0N7S395BD3PnPWT28ih4xCxqi89kpO7MjhkQY/NqKaNBuomTcwVN11y0xQ+7szUTbBgLtcW2+AgC07X1QUqWmMZ+HdBy53+IAsPms/ji74SYxSP83MkfRmzv3h4da3iaPF5iKVnXx6NY+HzO3YBfi2BOB2Mp3yFyAbbbXnqVsASt63Mj3j33P9Jktz5XHsbPZItJI6JStK3khEmFBtQonQ3vQ2Tg9jTC0D+TlcRJtyqnyeJlkA==
Received: from DU2PR04CA0264.eurprd04.prod.outlook.com (2603:10a6:10:28e::29)
 by AS4P195MB1406.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 15:25:17 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::4f) by DU2PR04CA0264.outlook.office365.com
 (2603:10a6:10:28e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 15:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 4 Nov 2025 15:25:17 +0000
Received: from ls-radium.phytec (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 4 Nov
 2025 16:25:14 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <afd@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>,
 <anshuld@ti.com>, <bb@ti.com>, <ggiordano@phytec.com>, <b-padhi@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v2 1/3] arm: mach-k3: Rework spl/get_boot_device()
Date: Tue, 4 Nov 2025 07:24:57 -0800
Message-ID: <20251104152459.3648004-2-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|AS4P195MB1406:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba98271-7f0a-45b3-7e94-08de1bb65bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FsVHEo2rBApQb1qcbRZj5dH4STgth7N6oR3gVcSGcsAY2vIy6zdpTl68RbHP?=
 =?us-ascii?Q?bIhdUzo5w9mgpKKxEM2lpMsf1pkQWqB/tYDlD4InFcSWVX03SuEu6ivoukxb?=
 =?us-ascii?Q?jmphl8l6uy8S4l9r1NrdH7mwcqrNDQ3fPVPauLUdqjpWuz3bRsGtfZ3S0O3O?=
 =?us-ascii?Q?Kz1Vhwr2WdqszDBi3G/5lop+5wW/akKumWeTJ/THjF4XTuKPGA4eoQe/cXfP?=
 =?us-ascii?Q?nWAQ/YllYfVfRcSKm9pZFqZJ4ETGF3yXHpx49fPNEhdqetxVKffRtr9fFiec?=
 =?us-ascii?Q?yIcofn5j76TujdrfRwB+GcJBSy+EU6jd8oeN+izDP3R6TZdvRFE3/gMwTMOx?=
 =?us-ascii?Q?QVZ6u2RkGUUamHBvYzHvwllTD6Ufe+4iRJRyJv+pi72eSa3D/QSNNGhUvgwq?=
 =?us-ascii?Q?NDFDJ2w6MqFFBekaA4A1J4hSDMFf+O+RFiKmLBPyJy254JcYoaDmvJe+v/DX?=
 =?us-ascii?Q?iGiSXfXD186z0/W65EbTa9mEg/QUaOrJfqvOTVbCs+IAxVcHJT+xRF2LCLwj?=
 =?us-ascii?Q?sbnmZOR7SpabrFkb+Stiw6NXzMsf/iUWOZ5QLII8v2jrdV2zpg3Se9FX7otb?=
 =?us-ascii?Q?ZBMXP+YX77iL6X+veJdFSwzw6pmardQPqQwpTS+n6QSHcMS+XkRwQeqFOUS9?=
 =?us-ascii?Q?Xwce/wHwXkjXRkJJ+2ob75FrqFqmiwrtJfrRkn1vjj3QsB8w7jC3KfYqhuwQ?=
 =?us-ascii?Q?Gzi+aUD71GD9f7Aarojm0hp6tDjyHfosPb10BcPJijGQrz76yrK97wvrF3gc?=
 =?us-ascii?Q?m1kiGUZ4F5ZEV2bezY0aBr5dAeYa0sTGvxK854kOy6jPueCUEqR7+PL0E6fd?=
 =?us-ascii?Q?MkqTN3v/6oR15bkRA05zBtKoqBp+gtQVCLcJhg0E8xFf/1MC63KwncSNeXs9?=
 =?us-ascii?Q?+w+n6yAUQblqbo7FL0NmQ9hByj2rCCL7uLWhK4a2hPzdmAYJZwH8Chdkug4y?=
 =?us-ascii?Q?8EvVn/Ec1AbUpJUUNpDTiUL3qsnGMM4XKEHpWNhYjMwrJ+PdP9D81/Rf0Ctt?=
 =?us-ascii?Q?JeIlHsRs7egyOck13AokOQ4xlQDir7ZKFC3hUe+Pi1AAN50ShNKY78Dmba2R?=
 =?us-ascii?Q?p+N3MwHnOaSmSA7MUR31RO4gSGFU26GOEtU7arOwrY1n1RzYTY3AmFRwAg6n?=
 =?us-ascii?Q?A/lHE6s1G9EX5XrDDzS6DrDS7hxj9L85SRFitaJfrop2d0NRhq+oFCqONRch?=
 =?us-ascii?Q?19m0muxaZgpj5RsIYksPU8SBsrJgJoqTW4BqIQTJclFKCrzqaIX05sqNMPsM?=
 =?us-ascii?Q?5oG9TO6dpsjwWEaKU1KCQUQA95gyraExxwYf81JFKEC/7lHdotK6D9HxlwU/?=
 =?us-ascii?Q?UWAuxUEMmFaY1B763L2UEKB/k2xbxq1AJLKMEjPCp26LyVplmWHq0dc93oe5?=
 =?us-ascii?Q?35XH1kPX91aZpa+Fvo9Y8hYktiRFj9PD9Bwra8kRxa2KJ4VomUOScH1iYa2+?=
 =?us-ascii?Q?A7TFzlz5CTq37BCndZjjs5aRYQM4Atx9OAK6bFo9lgNiYizJKtiCl4T8ymus?=
 =?us-ascii?Q?0yMDRFDbIDakwrEk6aVa/035x2hFfZ9fyDmP126L//yoO8tjdL2Xlvn+U7ck?=
 =?us-ascii?Q?5/RPm/vTHNN9AAm1WB4=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:25:17.1643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba98271-7f0a-45b3-7e94-08de1bb65bdc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1406
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

Introduce a shared boot-device helper that translates DEVSTAT boot
modes via SoC-specific lookup tables. This replaces the per SoC
get_boot_device()/get_*_bootmedia() implementations and centralizes
the logic in boot-device.c while keeping the mapping data SoC-owned.

Start with am62x as a reference implementation.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Acked-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/Makefile      |   2 +-
 arch/arm/mach-k3/am62x/boot.c  | 141 ++++++++++-----------------------
 arch/arm/mach-k3/boot-device.c |  90 +++++++++++++++++++++
 arch/arm/mach-k3/boot-device.h |  41 ++++++++++
 4 files changed, 175 insertions(+), 99 deletions(-)
 create mode 100644 arch/arm/mach-k3/boot-device.c
 create mode 100644 arch/arm/mach-k3/boot-device.h

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index b2fd5810b67..7dc77328e5c 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_ARM64) += arm64/
 obj-$(CONFIG_CPU_V7R) += r5/
 obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
-obj-y += common.o security.o k3-ddr.o
+obj-y += common.o security.o k3-ddr.o boot-device.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
index a3a6cda6bdb..06bd04da99f 100644
--- a/arch/arm/mach-k3/am62x/boot.c
+++ b/arch/arm/mach-k3/am62x/boot.c
@@ -3,104 +3,7 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/am62_spl.h>
 
-static u32 __get_backup_bootmedia(u32 devstat)
-{
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
-}
+#include "../boot-device.h"
 
 const char *get_reset_reason(void)
 {
@@ -141,3 +44,45 @@ const char *get_reset_reason(void)
 
 	return "UNKNOWN";
 }
+
+static const struct k3_boot_map am62_boot_device_primary_table[] = {
+	{ BOOT_DEVICE_OSPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_QSPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_XSPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BOOT_DEVICE_ETHERNET_RGMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
+	{ BOOT_DEVICE_ETHERNET_RMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
+	{ BOOT_DEVICE_EMMC, 0, 0, 0, BOOT_DEVICE_MMC1 },
+	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 1, BOOT_DEVICE_MMC2 },
+	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 0, BOOT_DEVICE_MMC1 },
+	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 1, BOOT_DEVICE_USB },
+	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 0, BOOT_DEVICE_DFU },
+	{ BOOT_DEVICE_NOBOOT, 0, 0, 0, BOOT_DEVICE_RAM },
+};
+
+static const struct k3_boot_map am62_boot_device_backup_table[] = {
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
+static const struct k3_boot_device_info am62_boot_device_info = {
+	.boot_device_primary_table = am62_boot_device_primary_table,
+	.boot_device_primary_count = ARRAY_SIZE(am62_boot_device_primary_table),
+	.boot_device_backup_table = am62_boot_device_backup_table,
+	.boot_device_backup_count = ARRAY_SIZE(am62_boot_device_backup_table),
+	.main_devstat_reg = (void __iomem *)CTRLMMR_MAIN_DEVSTAT,
+	.wkup_devstat_reg = NULL,
+	.bootmode_addr = (void __iomem *)K3_BOOT_PARAM_TABLE_INDEX_OCRAM,
+};
+
+const struct k3_boot_device_info *k3_get_boot_device_info(void)
+{
+	return &am62_boot_device_info;
+}
diff --git a/arch/arm/mach-k3/boot-device.c b/arch/arm/mach-k3/boot-device.c
new file mode 100644
index 00000000000..4c3f2da3269
--- /dev/null
+++ b/arch/arm/mach-k3/boot-device.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ *  Author: Wadim Egorov <w.egorov@phytec.de>
+ */
+
+#include "boot-device.h"
+
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <spl.h>
+
+__weak const struct k3_boot_device_info *k3_get_boot_device_info(void)
+{
+	return NULL;
+}
+
+static u32 __get_backup_bootmedia(const struct k3_boot_device_info *info, u32 devstat)
+{
+	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
+			     MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
+	u32 bkup_bootmode_cfg = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
+				 MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
+	unsigned int i;
+
+	for (i = 0; i < info->boot_device_backup_count; i++) {
+		const struct k3_boot_map *m = &info->boot_device_backup_table[i];
+
+		if (bkup_bootmode != m->mode)
+			continue;
+
+		if (m->cfg_mask == 0)
+			return m->result;
+
+		if (((bkup_bootmode_cfg & m->cfg_mask) >> m->cfg_shift) == m->cfg_value)
+			return m->result;
+	}
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 __get_primary_bootmedia(const struct k3_boot_device_info *info, u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+			MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+			MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+	unsigned int i;
+
+	for (i = 0; i < info->boot_device_primary_count; i++) {
+		const struct k3_boot_map *m = &info->boot_device_primary_table[i];
+
+		if (bootmode != m->mode)
+			continue;
+
+		if (m->cfg_mask == 0)
+			return m->result;
+
+		if (((bootmode_cfg & m->cfg_mask) >> m->cfg_shift) == m->cfg_value)
+			return m->result;
+	}
+
+	return bootmode;
+}
+
+u32 __weak get_boot_device(void)
+{
+	const struct k3_boot_device_info *info = k3_get_boot_device_info();
+	u32 bootmode;
+	u32 main_devstat;
+	u32 bootmedia;
+
+	if (!info) {
+		pr_err("%s: no boot-device info for this SoC\n", __func__);
+		return BOOT_DEVICE_NOBOOT;
+	}
+
+	bootmode = readl(info->bootmode_addr);
+	main_devstat = readl(info->main_devstat_reg);
+
+	if (bootmode == K3_PRIMARY_BOOTMODE)
+		bootmedia = __get_primary_bootmedia(info, main_devstat);
+	else
+		bootmedia = __get_backup_bootmedia(info, main_devstat);
+
+	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
+	      __func__, main_devstat, bootmedia, bootmode);
+
+	return bootmedia;
+}
diff --git a/arch/arm/mach-k3/boot-device.h b/arch/arm/mach-k3/boot-device.h
new file mode 100644
index 00000000000..04951deafb3
--- /dev/null
+++ b/arch/arm/mach-k3/boot-device.h
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ *  Author: Wadim Egorov <w.egorov@phytec.de>
+ */
+
+#ifndef _K3_BOOT_DEVICE_H
+#define _K3_BOOT_DEVICE_H
+
+#include <linux/types.h>
+#include <asm/io.h>
+
+/**
+ * struct k3_boot_map - Descriptor to map a raw boot mode to normalized device
+ * @mode:       Raw PRIMARY_BOOTMODE value
+ * @cfg_mask:   Bits in devstat-cfg to test (0 if none)
+ * @cfg_shift:  Shift right before comparing
+ * @cfg_value:  Desired value after mask+shift
+ * @result:     Normalized device to return
+ */
+struct k3_boot_map {
+	u32 mode;
+	u32 cfg_mask;
+	u32 cfg_shift;
+	u32 cfg_value;
+	u32 result;
+};
+
+struct k3_boot_device_info {
+	const struct k3_boot_map *boot_device_primary_table;
+	unsigned int boot_device_primary_count;
+	const struct k3_boot_map *boot_device_backup_table;
+	unsigned int boot_device_backup_count;
+	void __iomem *main_devstat_reg;
+	void __iomem *wkup_devstat_reg;
+	void __iomem *bootmode_addr;
+};
+
+const struct k3_boot_device_info *k3_get_boot_device_info(void);
+
+#endif /* _K3_BOOT_DEVICE_H */
-- 
2.48.1

