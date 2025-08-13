Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D784C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 10:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B167A82CEA;
	Wed, 13 Aug 2025 12:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Vz7GwrKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF24E829E7; Wed, 13 Aug 2025 12:30:07 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7D082C84
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bawxctfg0y5XzG9NGnGYXincLlGyywBAIQ5vdZ5HkmfIFlYChGy+SlfcTEAhpkgn8pulJV95qrMzsA3PVSn8PFRcf4IN/WQLG/TGbXSVusS62e6BF7fjT3H/icGH/i7OSU4paKLp0Vw3CTs/UAvPPhLttITPE5XQOuHl4OEG+Dq/rv17QJAzwOaObt7vm5HscZ2L/03aiqQTQ5goUJojftSFQPfkeAr285OhlR1TTmlZ1nwE3U+m3BCoa1ORkN6q+trgOf6QcCyTGkLhI+NOkA400cbdPL2NuKEXm1dr1LO0tkMKCVFO08mYezFilsgk/P0DqKrx2p4P/191gSuQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4RGKgaPEl2tz5WgmCw6NqrmDvq3rEgfTSZPZTWL0Io=;
 b=Vlv27mtXbUX8aZ5DvUqrJh+VPE8eiv/L6tktF7u0IT3cDR5DzrY7IvPMSk8mTRB72UaN8yQ5slRsTUkglU8rVPVwIOjxlmmKyVkF4W+F/d7FwYaNz1V61rRya1d/Sp5LpHG+0p4Ccb4bJ5TeO0mR8IJ578Ljx2TGgkqSLcR+Rz/QvQi5DvwWgRWx7HhjbisNS6kbd4b09W25AGR+nuH6RgmljrTeZnaimw+5Ozt/PoD9vjp8BDbzFeoKtl04+f1c+92GFVzlMsCchDdeH0JpSARi3mROgq+6PvKfMIt0ZeNdHZhaC3BCu1C8bSGgGNvpIXtIv8TgYHfTQqIKs/Ejpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4RGKgaPEl2tz5WgmCw6NqrmDvq3rEgfTSZPZTWL0Io=;
 b=Vz7GwrKN4ZvmRdnrMF938kMGrv47JoF8tENqNNKm8O1A8Nc7R2Y0HjT2D9t2YN09f6AKi3OddBhMomPxd+uOzNILqLpDMq1v5lUtxoejfSdGpLaL/nTBHTsBLoR4tdS+TFyFtCt5xejA8BMrBTNWMKQhYTSn6dLucmH66n2ttiHNtbAPiBryAYCTrgHfAi+n6YYIaX3S6QW93VQbaOBKB4CQb5ugJp8+7nzKqXF47NuzK0cEjsdhNZcHFdY3QbFY2MU2N7dqCyIk3j8bbplETYA64rvlVJwh+QtUvMwPvgAQDg4Q57DvcN4vlERRRRCARF1Yeo6YmKcGgTM13m2b0w==
Received: from PR1P264CA0109.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::11)
 by PR3P195MB0667.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 10:30:01 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:102:2cf:cafe::bf) by PR1P264CA0109.outlook.office365.com
 (2603:10a6:102:2cf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 10:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 10:30:00 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 12:29:59 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 12:29:58 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <afd@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [RFC 1/1] arm: mach-k3: Rework spl/get_boot_device()
Date: Wed, 13 Aug 2025 12:29:48 +0200
Message-ID: <20250813102948.2426361-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250813102948.2426361-1-w.egorov@phytec.de>
References: <20250813102948.2426361-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|PR3P195MB0667:EE_
X-MS-Office365-Filtering-Correlation-Id: 93699a3b-998b-459e-9e21-08ddda545bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pSJY24SrQWt6hOoS81eK6Nj8woFg+g0p5kkUq1aZNtvIW4su60PQg+ereROE?=
 =?us-ascii?Q?ghRKkSDDwmSgRWtzgLeMZjjd6FSv3twRLg7VyrjDmjXqNicZzPK0keWAuruU?=
 =?us-ascii?Q?2VIN1PDn4k0bTahPN2fD/TGKtrjM2H/wxbj4EZQ92n2P3KDdQKKTwnlP9kFs?=
 =?us-ascii?Q?XlQATTi9kwGaUjJXiSukOjvyfgozhb92nKo9kHZYzIv7pxKp5lTsEy1VGHH9?=
 =?us-ascii?Q?iTx5n6s5jyMqPk83U3mtXUdnuG7n05dkiGmH7yWfRGpbZPJGge5QJr3ypfyG?=
 =?us-ascii?Q?qmrQ0sU7UKNs6GEFcCy6hwEIck0ZevHuhIL7p6lsDmTC9Ir6E+uO+CVAF6WL?=
 =?us-ascii?Q?bvX3W1/rfTrvNpPeos1OlMVqp0BgUKEYOnXLWvJi38gvO5dARE2HIFRIQ76s?=
 =?us-ascii?Q?Em5kcgzCZKbUGwfHjRoFN1rrxNwGWMC5BzQw5QaWFmulsAA+3ZRoVmF4yCDz?=
 =?us-ascii?Q?S3ioyeadUVDNXitkLv7RPb5kEt0xhqlI6YpqFn81+5EOnVHz5oqWf47aUGfA?=
 =?us-ascii?Q?tThq0dELHXK+oEWV2px5oRLhB1wvSSnUkLGHWXcBA8adaGfWPgsOcakQNrDJ?=
 =?us-ascii?Q?miO35tYrcpi9tj+bUQ8tFOu1d6nIH77W7A3rFMKhcmjkcH1rInHOUd2Tekar?=
 =?us-ascii?Q?IcWne/RVrdh8MWkpF/KClKecnh5cIhKXN/KsObEgbwkQBJCZPrPIU5SQn30C?=
 =?us-ascii?Q?JKqGnKxjD8TvnB9nU1qn+ipFEINERcadnxVi+xWNaPyfuzOCd7eu6lsZGT1w?=
 =?us-ascii?Q?a/FHLsapIt3DM0/gAS33joVWAf2bZvpZmr75Psi2jzi0kDYUJ2xfT8DKiafY?=
 =?us-ascii?Q?fwgL4xwckwOGlNA5aJa9cTMkoRXfPlmO+gHlhcRrJbdZ26yMq9CFoFISeqxW?=
 =?us-ascii?Q?s6T9B7e3vDKWKNr1QbrYoHhkPO6dIYJNoWdauuFfV542paAG8oRJM33tGgdL?=
 =?us-ascii?Q?kCLtL15ZR+bVuODITkAG2xZ4YpCmfIcsCFyf2dRk0q8ER8of0fjR+hpq1oNY?=
 =?us-ascii?Q?D9w2FRoO+nL47cGcudGnc1Ayd8j7Tj0HZ1BsyB4JbeQ9j+cwDdg15yhU7vmR?=
 =?us-ascii?Q?iFie03eUOJ8roJULXJay1y65YQqIcIjdk9WpZJ1GBqE2YcgJa3cYpiLuitDL?=
 =?us-ascii?Q?fny0PGpga3UfjKsD3JvfZZZiK8aBMUyJcQLdllHujgdT4FuyuLYae1zS/gRa?=
 =?us-ascii?Q?3HyP0a+3JxqEUhbaAP6Y0T3lWwFcvSkCzJU+pFMj9Ymri/r7jAeVsrQWBmyH?=
 =?us-ascii?Q?1GIZkKHwdh9HJf7P5jS53wyWxF1OPPcCcIP/LCPEGpVvD50dCAnw9am7ytRq?=
 =?us-ascii?Q?W+SGr+u/YnJYEuCiXFJTBTOc4YGKfLZmIpo6DcTjbvYJLODlcDbMLKeIuuGf?=
 =?us-ascii?Q?/QNtDPcvLO5cra/KOWnZ5fD5OHrizSb8awZieHbGIYJc76sA2e/6G7R5vk2Z?=
 =?us-ascii?Q?H0h9vRu94VOu/KjrYz55SltZjDHN7aFvtF4y97exQkrrl+4AszYApJBNmTBj?=
 =?us-ascii?Q?Ty55N12W5Nrnnuwr0HGpTfq29aWU4qg14IkA?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 10:30:00.9541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93699a3b-998b-459e-9e21-08ddda545bdf
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0667
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

The current implementation requires every K3 SoC to provide its own
get_boot_device()/get_*_bootmedia() functions which look very identical.
Rework it using table lookups for SoC data and reduce code duplication.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/Makefile                     |   2 +-
 arch/arm/mach-k3/am62x/boot.c                 | 129 +++++-------------
 arch/arm/mach-k3/boot-device.c                | 109 +++++++++++++++
 arch/arm/mach-k3/boot-device.h                |  27 ++++
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
index a3a6cda6bdb..6d458f546a6 100644
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
@@ -141,3 +44,33 @@ const char *get_reset_reason(void)
 
 	return "UNKNOWN";
 }
+
+struct k3_boot_map am62_boot_device_primary_table[] = {
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
+struct k3_boot_map am62_boot_device_backup_table[] = {
+	{ BACKUP_BOOT_DEVICE_UART, 0, 0, 0, BOOT_DEVICE_UART },
+	{ BACKUP_BOOT_DEVICE_USB, 0, 0, 0, BOOT_DEVICE_USB },
+	{ BACKUP_BOOT_DEVICE_ETHERNET, 0, 0, 0, BOOT_DEVICE_ETHERNET },
+	{ BACKUP_BOOT_DEVICE_MMC, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT, 0, BOOT_DEVICE_MMC1 },
+	{ BACKUP_BOOT_DEVICE_MMC, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT, 1, BOOT_DEVICE_MMC2 },
+	{ BACKUP_BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
+	{ BACKUP_BOOT_DEVICE_I2C, 0, 0, 0, BOOT_DEVICE_I2C },
+	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT, 0, BOOT_DEVICE_DFU },
+	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT, 1, BOOT_DEVICE_USB },
+};
+
+unsigned int am62_boot_device_primary_table_count = ARRAY_SIZE(am62_boot_device_primary_table);
+unsigned int am62_boot_device_backup_table_count = ARRAY_SIZE(am62_boot_device_backup_table);
diff --git a/arch/arm/mach-k3/boot-device.c b/arch/arm/mach-k3/boot-device.c
new file mode 100644
index 00000000000..9b4f0ae7aa6
--- /dev/null
+++ b/arch/arm/mach-k3/boot-device.c
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
+struct k3_boot_device_info {
+	struct k3_boot_map *boot_device_primary_table;
+	unsigned int *boot_device_primary_count;
+	struct k3_boot_map *boot_device_backup_table;
+	unsigned int *boot_device_backup_count;
+	void __iomem *main_devstat_reg;
+	void __iomem *wkup_devstat_reg;
+	void __iomem *bootmode_addr;
+};
+
+static const struct k3_boot_device_info k3_boot_device_info[] = {
+#if defined(CONFIG_SOC_K3_AM625)
+	{
+		.boot_device_primary_table = am62_boot_device_primary_table,
+		.boot_device_primary_count = &am62_boot_device_primary_table_count,
+		.boot_device_backup_table = am62_boot_device_backup_table,
+		.boot_device_backup_count = &am62_boot_device_backup_table_count,
+		.main_devstat_reg = (void __iomem *)CTRLMMR_MAIN_DEVSTAT,
+		.wkup_devstat_reg = 0,
+		.bootmode_addr = (void __iomem *)K3_BOOT_PARAM_TABLE_INDEX_OCRAM,
+	},
+#endif
+};
+
+static u32 __get_backup_bootmedia(u32 devstat)
+{
+	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
+			     MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
+	u32 bkup_bootmode_cfg = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
+				 MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
+
+	const struct k3_boot_device_info *info = &k3_boot_device_info[0];
+	unsigned int i;
+
+	for (i = 0; i < *info->boot_device_backup_count; i++) {
+		struct k3_boot_map *m = &info->boot_device_backup_table[i];
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
+static u32 __get_primary_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+			MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+			MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+	const struct k3_boot_device_info *info = &k3_boot_device_info[0];
+	unsigned int i;
+
+	for (i = 0; i < *info->boot_device_primary_count; i++) {
+		struct k3_boot_map *m = &info->boot_device_primary_table[i];
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
+u32 get_boot_device(void)
+{
+	const struct k3_boot_device_info *info = &k3_boot_device_info[0];
+	u32 bootmode = readl(info->bootmode_addr);
+	u32 main_devstat = readl(info->main_devstat_reg);
+	u32 bootmedia;
+
+	if (!ARRAY_SIZE(k3_boot_device_info)) {
+		pr_err("%s: no boot-device info for this SoC\n", __func__);
+		return BOOT_DEVICE_NOBOOT;
+	}
+
+	if (bootmode == K3_PRIMARY_BOOTMODE)
+		bootmedia = __get_primary_bootmedia(main_devstat);
+	else
+		bootmedia = __get_backup_bootmedia(main_devstat);
+
+	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
+	      __func__, main_devstat, bootmedia, bootmode);
+
+	return bootmedia;
+}
diff --git a/arch/arm/mach-k3/boot-device.h b/arch/arm/mach-k3/boot-device.h
new file mode 100644
index 00000000000..351f710151b
--- /dev/null
+++ b/arch/arm/mach-k3/boot-device.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ *  Author: Wadim Egorov <w.egorov@phytec.de>
+ */
+
+#ifndef _K3_BOOT_DEVICE_H
+#define _K3_BOOT_DEVICE_H
+
+#include <linux/types.h>
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
+extern struct k3_boot_map am62_boot_device_primary_table[];
+extern unsigned int am62_boot_device_primary_table_count;
+
+extern struct k3_boot_map am62_boot_device_backup_table[];
+extern unsigned int am62_boot_device_backup_table_count;
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

