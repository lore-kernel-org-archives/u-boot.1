Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E73BCAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 13:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D90C835D8;
	Thu,  2 Oct 2025 15:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Ta/5G3wu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2564280107; Thu,  2 Oct 2025 15:05:15 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF0008328F
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 15:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ0C63pNdiymOCjmUs0ezf4rtBfipyO8Bq3PjJEoNP85xXcjMve9XD0tuP2f/37Bop5Hsnx7NbpANMv4nma8Ery8gDo0PIeW9dwo00nKZD1PdBFWhaRW3WWLXN4UN+3bF8kIcbL8zTt4GAfAcdZNTF6AQtWMW6bo8kikK6IOj22gfdaoi3RwTCwO3xjI6jLE2isCXZz/1XcrbTEUSQYvkpAnTJc3+UaK+EiI/VbqA5HXXTcu/tzUNEawCY20IpxC7Gr86btQzuFaSJiYluyIg2DfonQ7xM/iZEY7OrJDE3kXoD/fboZE5i60O0RArmdM0gQDmgPD1nP9qFkju05Hlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEbLOVBgvyb5452Dh5souNdKDx2A6SGaAr5prUoAQZ8=;
 b=FHjU6TlM+dTkbDB4gpZtOOqgEy9ce3RV/ufZLv4tlv14S8CD5Fn5MkkZvTx8UHPE0pDntzxImuNrvzqyz1TTw9HbJ3rKm641XRt5ts+vvKwFlkTbi0yGxcaCCEW6T4NjLwsEj6XOf0ICYf5zJBUORF9QNlUJIVULHOuwgNU5cQsqtXuRvF7/5yz2masWNzxTBAoIhtgPpZUaPNU2Le0MEIQuvvxJ1S1qJQhpTU2t8m8/2Er4sm0LkqMoKjVo+Kl3dC2yJ+6NRWb38H4MR3as/j2CHs1cVMIjXTNh9HI4ExPeeK+Gad0fUkfKyIC3QxQyiohN8EoQkbNoN7JrvCU1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEbLOVBgvyb5452Dh5souNdKDx2A6SGaAr5prUoAQZ8=;
 b=Ta/5G3wuJ1dSsV5ttPFbVHespQ1H0ZAZVHG4R5ngc0WDuf26Ug+k1XE18tHs59SIa+X2ApSXD1+IXVlse2h6T43E20yklcc0khxkjVFet0jqny5LcWleamqB/yNq8RhNXMMT+08psLgJGFb8upPOEWXKwwuAvhf6sG3uWnwS89jBFhYUhB+mCH45+CBxSIckmD1HR8Ke06uBUaAsnyiKXpXSWp2Kv8S5pqbuaOuk0pX/hhekQcLVSX6kVM0u5YFi3bC+jBaQ5HddWBjAbGM8gfca2uJyCjfSOsrIWrO8xWLZFz4JQ4LBYF7+40d1B+ETPvDgw6WHt9mPnY6q5kP7JA==
Received: from AM0PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:208:d2::15)
 by AM7PPF3B35A546A.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::74b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Thu, 2 Oct
 2025 13:05:05 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:208:d2:cafe::ec) by AM0PR08CA0002.outlook.office365.com
 (2603:10a6:208:d2::15) with Microsoft SMTP Server (version=TLS1_3,
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
Subject: [PATCH 1/3] arm: mach-k3: Rework spl/get_boot_device()
Date: Thu, 2 Oct 2025 15:04:53 +0200
Message-ID: <20251002130455.1795794-2-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|AM7PPF3B35A546A:EE_
X-MS-Office365-Filtering-Correlation-Id: e497306e-7924-4800-72ae-08de01b44e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dV0yNwlJjkrs4M+WRPnIJrXThWnuKQhkuFZBMX1tnbu/E5TU1iMNMjRIiD/j?=
 =?us-ascii?Q?E4ZVx/tQSg8bvqLVPl5Hf4vauV5gUahoRvjGBJBpmEWQJgCqQUb2mGo3gahk?=
 =?us-ascii?Q?esmP9bBbv0lTLiFDWhf64ivizLjdK3mEnW43spYXGImm8BWkfGT5Fq3W/fxi?=
 =?us-ascii?Q?i5AtPiYoQQZrKek0bKZ5yQrDz4VNMOSyJdOfBMEn8U7+6E436ecXQOt5PB4p?=
 =?us-ascii?Q?xk0DY9za0clvToRa+BdaY6YWrd7W+JmarUpXemyZ533YjF4LDiKvaOlJxrEH?=
 =?us-ascii?Q?otGGeXpE0g7vbinKApacJSzvIJv2cR+QbBOMkGB7YS5JXGNdc3gNNeu6NTWx?=
 =?us-ascii?Q?Dtg0jR2N6VgGiezeYSramjkLKwIqA4mTzD27Z3NvuD+SSVMo61ZGNCO7h70R?=
 =?us-ascii?Q?nUC135vyEJner35QdlHqf04sUH/0DAyp7IHrR2KlldKupRb15QC5fmVqWrzv?=
 =?us-ascii?Q?SR5502tQEpJWRqydgGpu14UkxrWtItKJaPh1lsMsr/qku8Fx6srVvnHwuI57?=
 =?us-ascii?Q?DJxFu804mytQlWOoCJRmRBrwMw9QgIhGyfMifxAHjavJ6sQ5051C1NcYLvf1?=
 =?us-ascii?Q?ZopXqU49d3wdyPGcAQrC4XnT6GaWoBUFor+WO7bl4v81mJTRG/rxQ/r0/wKy?=
 =?us-ascii?Q?hPgM3kdvBl8L5K+fkFI+vUyEPOncA6E+uQKNN/R8agv1drhyPYXhb+PER3XX?=
 =?us-ascii?Q?B4i5LfWfZWmqa5jFKNttwsHFP6xN6ybLuZ3ui5HX/ZpN3KyZIYJXkCWTzSHu?=
 =?us-ascii?Q?AJh0ZkpXfFb4gSY6GRU781CBtIYjTSxsvgEnlwa4qqSx6p2CFEBldCgBK5cq?=
 =?us-ascii?Q?vwnmw07pWNKSEmJW4ymsWBjymiaZ7BUbnmKad0wEtkrPSmB5u7Udqr0OMMY0?=
 =?us-ascii?Q?8Saho/P9wJSDFSEeIJo/4oEA7cgS0xEzisK/qoMT0IJFDgyiPWsnp5br7/jX?=
 =?us-ascii?Q?QLrbJeZUMwb+2zgrSj0pTgME/Xma2YK00ZDXJ8Nl45YmlwSnzIsHLaKdS8/s?=
 =?us-ascii?Q?49qNbeT9p05khKaxdOjfufOAHwoPM7MMXilSk8nO9vVu/oLpCNXmkmYovdJJ?=
 =?us-ascii?Q?MVC76U9FIoVCYdhv8Xwduk3oTmUxnLDxJXBWHrZHDXWX1FrUsIvtOPNili/5?=
 =?us-ascii?Q?g4WFeRZV3vs+sJfo2fGr8Cy5PLfL4COPy0dXI8JRbn9jLDAHoJjNXvNj6K0R?=
 =?us-ascii?Q?Gq7Eono3C4zfOiMmsEdavUQgGG9HyWPX+1DaiLnmxeHdQqdrbknXWm0MHZbk?=
 =?us-ascii?Q?ZijxsTKSV40amk0T6ViUBelgJeF7VooS4o5cAK/JPBnt97RTPll81K/V8rJG?=
 =?us-ascii?Q?mY4Nwc97aw/D1mTVZGJUxb+F4dZPeDR2CtG9QOQENoOozudH0a30TlmjLVuR?=
 =?us-ascii?Q?5eG8n3zWXUOphmP4qArbR81ERKu0zkbglGCFmZmydA+VjjmZlPKkdhoDbbx3?=
 =?us-ascii?Q?g1uyy1LlqbMTSHXyi5Se1L5El+9yxiWciutWGCufwjnZLUE8RBJn6f63Nxp5?=
 =?us-ascii?Q?9pNYqs4HT9Yn9kuiReQv90Rg2Kvm5WXUZChbATr/JbxhpPzgDD1H8/Pp3Uu3?=
 =?us-ascii?Q?uJaPzsEz2TWxNuCSJD0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:05:05.1416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e497306e-7924-4800-72ae-08de01b44e41
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF3B35A546A
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
---
 arch/arm/mach-k3/Makefile                     |   2 +-
 arch/arm/mach-k3/am62x/boot.c                 | 141 ++++++------------
 arch/arm/mach-k3/boot-device.c                |  90 +++++++++++
 arch/arm/mach-k3/boot-device.h                |  34 +++++
 arch/arm/mach-k3/include/mach/am62_hardware.h |   1 +
 5 files changed, 169 insertions(+), 99 deletions(-)
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
index 00000000000..9431dae71fa
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
+#include <asm/arch/am62_spl.h>
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
index 00000000000..965a4570710
--- /dev/null
+++ b/arch/arm/mach-k3/boot-device.h
@@ -0,0 +1,34 @@
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
+/* Descriptor for mode + optional cfg test -> normalized device */
+struct k3_boot_map {
+	u32 mode;	/* Raw PRIMARY_BOOTMODE value */
+	u32 cfg_mask;	/* Bits in devstat-cfg to test (0 if none) */
+	u32 cfg_shift;	/* Shift right before comparing */
+	u32 cfg_value;	/* Desired value after mask+shift */
+	u32 result;	/* Normalized device to return */
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
diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index 2f5655bf24a..084f16bf2d2 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -10,6 +10,7 @@
 #define __ASM_ARCH_AM62_HARDWARE_H
 
 #include <config.h>
+#include <asm/io.h>
 #ifndef __ASSEMBLY__
 #include <linux/bitops.h>
 #endif
-- 
2.48.1

