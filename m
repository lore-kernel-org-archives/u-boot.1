Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C49EE57CE
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 01:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1089D83F9A;
	Wed, 31 Dec 2025 02:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="MDOuzb93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B8A83FD3; Wed, 31 Dec 2025 02:43:33 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6079E83F69
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 02:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qU60Jp2zW/q1FeHP+1fl8IdA6uNVQvu+MrOn+eCLzKuh+9yJ+kCkckYzx09S7V/SIwPzqHj8uHT6euxV/YF+EjO6dNxSMjrSQxDBqzntLbsYz0yMqn1CNxbd08C4MzlrC8KKT/c7CcMoXVp4Q+d7Sny+j4+NYo9WZDE720dQhKMt+eVey+LGLiZBe+QnnMl4kYS+qBPJemyAXvaSqYn7XX7slU+2SiVcDgLk/LPX5DXrQwUY9RbvrerkxA2qw2Wp4DCD10bFzeOKtralqfc2ggAeWpyT/mWM2yKcUK99RnSkYAuYgmerFCpftzEVdAj93N3Am1HN7cRcEQ6hTiyA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr04/R5pMJucM8skvcYYt1ZSLcFN4oJ+1yRxMjztTHI=;
 b=QBxs8LnGrhA8aMyl6tbBbOj1Iu3L4j/nDyfyjpF9sXmcWxbWPUKM+ZYX80huSfsMa/Ew5JJUvMGWO9uuDYxWYyK83K1kSZXOhI8zWzsYlnEAi27NCnAarV7Ya8GJpTOynyc3mX03BC3pt2dkk3YKSr08OVaQWQohNpqPiU7vkJXpI6IKzP9MEpG5VNpLmahfFK9H3c2fVGBr2aydqVVtXKOKlSYXfNvv87MEVvKEt707VVkWqlQOeGR0CnadLHn7NDALyvki7F3y3J4nOhTHSMbzsT3nx/RlZ9sZD0UqpNvM6e4OTq6yi9BnV94HKwRX4waJzHKuT2JdcehNDmeeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com
 smtp.mailfrom=phytec.de; 
 dmarc=temperror action=none header.from=phytec.de; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr04/R5pMJucM8skvcYYt1ZSLcFN4oJ+1yRxMjztTHI=;
 b=MDOuzb93mH0wu6MbvvXyndbcEaFid5NMTQKJlxOUMAvIZplINPhRFJ0kpFPw8ofkR06RZDN4vD4JI+XCdPc0j+V+1a252Dm4fRyDA7n/FrbIbsp26BFpinBMCZBYzsc9iz85B5hgQEixbR1msqIsVu83E5VtFjfsCQsK8g2jgmdPEzxhf35N1jQ2jC61cJVLqeRIEDsHDYKorRwF///FnSc8+Q2BhkTMyuS11nROSeJdtNc1uweGnuKUjILpJf30V06Y/KUgjyOWB1es23VwduKasJlv/gRnXYy+NsbAgKwLP0spki9nnDgJWAPdE+snzd+YWsZ5/K+HtLs250TCFw==
Received: from CWLP123CA0232.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::14)
 by AS8P195MB1877.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:560::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 01:43:28 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:400:19f:cafe::a1) by CWLP123CA0232.outlook.office365.com
 (2603:10a6:400:19f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 01:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=phytec.de;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of phytec.de: DNS Timeout)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 01:43:26 +0000
Received: from lws-haller-privat.phytec.de (172.25.39.212) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 31 Dec
 2025 02:43:24 +0100
From: Dominik Haller <d.haller@phytec.de>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, Dominik Haller <d.haller@phytec.de>,
 <u-boot@lists.denx.de>
Subject: [PATCH 1/3] arm: mach-k3: j721s2: Provide a way to obtain boot device
 for non SPLs
Date: Tue, 30 Dec 2025 17:42:50 -0800
Message-ID: <20251231014255.87648-1-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.212]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000192:EE_|AS8P195MB1877:EE_
X-MS-Office365-Filtering-Correlation-Id: 4360ec84-1370-41a8-61c1-08de480dfe17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nxKWjpcUX0/wQ5JGkTM36afUWpobgTcKb8tb1QKYhBGhMG/31Vi07//C/Z90?=
 =?us-ascii?Q?/KCLOg+dZ+ljiw8DJocxcQZH99NxM8IG8+tkIZJ/4VSx+G5DLOvxqwnuMOzc?=
 =?us-ascii?Q?mttRj5YYZfcwIXojurRIH/NFo/Id6Zm0rqJQ8B0fasJo5itCzVYuKtXaWeQm?=
 =?us-ascii?Q?m7r4k3kF478iR2jB5Oqs5VNgAaabb4oqg080A2IF/dM/K/J+8vkMTXqpeBMa?=
 =?us-ascii?Q?pqaECofsss4uHLpFYQ9enkyumM1Z/DSKCYYqn2OGueEoI8vYnYzpwkGlJhwG?=
 =?us-ascii?Q?O+SJ1m3GeNVBld5e0+Z9DgSraX7kHaSp+JwlFYpQCrfmWb9fGoYddJ9b970n?=
 =?us-ascii?Q?Xfn0c1EAruyKKR736WUJitjVlLDmU6Do1XNAjw6jYFM9XSjNExw4muon/GYH?=
 =?us-ascii?Q?IDELHV4mWdwjVJEPOeAP5uq+T9jub5047rByJEzimwCFetAEYNuaE2UJI0+Q?=
 =?us-ascii?Q?nZbfq4AmZGPBK4UjlTP3HTM4ses+MEJU7pATbKY7xe4pSzyRjzfqSmKSSj1Z?=
 =?us-ascii?Q?hxtLLcBpl++cWD/afKm1GD+jGghleUpLliEBCEQ6ghbhPMCWocfkTthsbOLD?=
 =?us-ascii?Q?eiejnFScntixegrCECtuIanwOY9zJtVH1qz+pDp+ZRDiVnLfEftL7SE+dE6p?=
 =?us-ascii?Q?pK5bZVr86N2nDPDIJ1uGWk3tMzUOGbM1e24QGucFnaLHZO69GzDx5V2jowkl?=
 =?us-ascii?Q?XdN8TZ8uyamfUZCnKzT48Z4w7HIhrhaP+2paC1omR/JMnEUrf0h3Ln3lk/qf?=
 =?us-ascii?Q?hkJJ9smqTzqHoE7divUesZCraFEctIquW9/fkZ/QnsONAbol1enO/KNhpw6C?=
 =?us-ascii?Q?28c4fXdQT5f9xxHXZjSWEA7QhD4L1Fxb3mUwK3/OAjkj4RnngAC+BNyakbjm?=
 =?us-ascii?Q?xvpCIKrYBEMxtwyrVrFsvfjKm5yWB8hoJm8WLaERgvRev8dYFsXp0C5mKiXD?=
 =?us-ascii?Q?LL5sL3/HiL1LZ1jPIJ++8Yov669lvMIGZM351RFd2YhOP9hqZ5ALuk70H+57?=
 =?us-ascii?Q?k1m1dUVKWjN/WxE/X6htL5EbChSsVv8mUW51MbwbihiTYWbEqeK1dXFB/03z?=
 =?us-ascii?Q?WiyXEtMJYR6TDKrsrPA+032xczB4XVpd+HzXwx9g5z4Ml8KvV1bRh/P0E0WD?=
 =?us-ascii?Q?9ZD582UBVY/B5RM7CgwC/FxnBUds5qxcz1NMi9k4NjUKJehtw+efigUzpOmG?=
 =?us-ascii?Q?TeUqXt+A57BH42vTAYtM4rWQXg4negHd3T0sI72UlxhgTk1UPlnczlTzxVYh?=
 =?us-ascii?Q?fPBFFW0AhYL1Ve3T7gi1ePQrOSiSWoD2ZLLuXBzDmltYhldRlcNEJTu0/Nb0?=
 =?us-ascii?Q?3NdOjvFkKYp590MFPQeyHiJSmyZokvgCJibGB7Gi4WTx6d+/p3rFn4ujOryt?=
 =?us-ascii?Q?/tsa6dZsN+pr1g4fabhNw7TKnl+JNLStA8vJDfeqPbFkZK/kSe16c3mmCHVd?=
 =?us-ascii?Q?2s6uLHmPGN+1sFVT574wyqq4Bm7DbJ270rBbDOqQ4VXdDJHfo+vxBU8InipG?=
 =?us-ascii?Q?RNS8JBqR+PwcDcYeC1gP+3AkZJsXUQ0aeVK4tfnEpqaUfKi3MROqYgXGf0Yl?=
 =?us-ascii?Q?YimuosSeskcfVJf8idg=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 01:43:26.5331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4360ec84-1370-41a8-61c1-08de480dfe17
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1877
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

Introduce get_boot_device() to obtain the booting device. Make it also
available for non SPL builds so u-boot can also know the device it
is booting from.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 arch/arm/mach-k3/j721s2/Makefile      |  1 +
 arch/arm/mach-k3/j721s2/boot.c        | 76 +++++++++++++++++++++++++++
 arch/arm/mach-k3/j721s2/j721s2_init.c | 68 +-----------------------
 3 files changed, 78 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm/mach-k3/j721s2/boot.c

diff --git a/arch/arm/mach-k3/j721s2/Makefile b/arch/arm/mach-k3/j721s2/Makefile
index 051ef1b11d8c..3193b3e37001 100644
--- a/arch/arm/mach-k3/j721s2/Makefile
+++ b/arch/arm/mach-k3/j721s2/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += j721s2_fdt.o
 obj-$(CONFIG_XPL_BUILD) += j721s2_init.o
+obj-y += boot.o
diff --git a/arch/arm/mach-k3/j721s2/boot.c b/arch/arm/mach-k3/j721s2/boot.c
new file mode 100644
index 000000000000..28dc2f97b246
--- /dev/null
+++ b/arch/arm/mach-k3/j721s2/boot.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/j721s2_spl.h>
+
+static u32 __get_backup_bootmedia(u32 main_devstat)
+{
+	u32 bkup_boot = (main_devstat & MAIN_DEVSTAT_BKUP_BOOTMODE_MASK) >>
+		MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT;
+
+	switch (bkup_boot) {
+	case BACKUP_BOOT_DEVICE_USB:
+		return BOOT_DEVICE_DFU;
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+	case BACKUP_BOOT_DEVICE_ETHERNET:
+		return BOOT_DEVICE_ETHERNET;
+	case BACKUP_BOOT_DEVICE_MMC2:
+	{
+		u32 port = (main_devstat & MAIN_DEVSTAT_BKUP_MMC_PORT_MASK) >>
+			MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT;
+		if (port == 0x0)
+			return BOOT_DEVICE_MMC1;
+		return BOOT_DEVICE_MMC2;
+	}
+	case BACKUP_BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+	case BACKUP_BOOT_DEVICE_I2C:
+		return BOOT_DEVICE_I2C;
+	}
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 __get_primary_bootmedia(u32 main_devstat, u32 wkup_devstat)
+{
+	u32 bootmode = (wkup_devstat & WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+		WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+
+	bootmode |= (main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) <<
+		BOOT_MODE_B_SHIFT;
+
+	if (bootmode == BOOT_DEVICE_OSPI || bootmode == BOOT_DEVICE_QSPI ||
+	    bootmode == BOOT_DEVICE_XSPI)
+		bootmode = BOOT_DEVICE_SPI;
+
+	if (bootmode == BOOT_DEVICE_MMC2) {
+		u32 port = (main_devstat &
+			MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK) >>
+			MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT;
+		if (port == 0x0)
+			bootmode = BOOT_DEVICE_MMC1;
+	}
+
+	return bootmode;
+}
+
+u32 get_boot_device(void)
+{
+	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
+	u32 main_devstat;
+	u32 bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
+
+	if (wkup_devstat & WKUP_DEVSTAT_MCU_ONLY_MASK) {
+		printf("ERROR: MCU only boot is not yet supported\n");
+		return BOOT_DEVICE_RAM;
+	}
+
+	/* MAIN CTRL MMR can only be read if MCU ONLY is 0 */
+	main_devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+
+	if (bootindex == K3_PRIMARY_BOOTMODE)
+		return __get_primary_bootmedia(main_devstat, wkup_devstat);
+	else
+		return __get_backup_bootmedia(main_devstat);
+}
diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index eee3d0440ac3..b5453d8895d4 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -361,73 +361,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	}
 }
 
-static u32 __get_backup_bootmedia(u32 main_devstat)
-{
-	u32 bkup_boot = (main_devstat & MAIN_DEVSTAT_BKUP_BOOTMODE_MASK) >>
-			MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT;
-
-	switch (bkup_boot) {
-	case BACKUP_BOOT_DEVICE_USB:
-		return BOOT_DEVICE_DFU;
-	case BACKUP_BOOT_DEVICE_UART:
-		return BOOT_DEVICE_UART;
-	case BACKUP_BOOT_DEVICE_ETHERNET:
-		return BOOT_DEVICE_ETHERNET;
-	case BACKUP_BOOT_DEVICE_MMC2:
-	{
-		u32 port = (main_devstat & MAIN_DEVSTAT_BKUP_MMC_PORT_MASK) >>
-			    MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT;
-		if (port == 0x0)
-			return BOOT_DEVICE_MMC1;
-		return BOOT_DEVICE_MMC2;
-	}
-	case BACKUP_BOOT_DEVICE_SPI:
-		return BOOT_DEVICE_SPI;
-	case BACKUP_BOOT_DEVICE_I2C:
-		return BOOT_DEVICE_I2C;
-	}
-
-	return BOOT_DEVICE_RAM;
-}
-
-static u32 __get_primary_bootmedia(u32 main_devstat, u32 wkup_devstat)
-{
-	u32 bootmode = (wkup_devstat & WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
-			WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
-
-	bootmode |= (main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) <<
-			BOOT_MODE_B_SHIFT;
-
-	if (bootmode == BOOT_DEVICE_OSPI || bootmode ==	BOOT_DEVICE_QSPI ||
-	    bootmode == BOOT_DEVICE_XSPI)
-		bootmode = BOOT_DEVICE_SPI;
-
-	if (bootmode == BOOT_DEVICE_MMC2) {
-		u32 port = (main_devstat &
-			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK) >>
-			   MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT;
-		if (port == 0x0)
-			bootmode = BOOT_DEVICE_MMC1;
-	}
-
-	return bootmode;
-}
-
 u32 spl_boot_device(void)
 {
-	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
-	u32 main_devstat;
-
-	if (wkup_devstat & WKUP_DEVSTAT_MCU_ONLY_MASK) {
-		printf("ERROR: MCU only boot is not yet supported\n");
-		return BOOT_DEVICE_RAM;
-	}
-
-	/* MAIN CTRL MMR can only be read if MCU ONLY is 0 */
-	main_devstat = readl(CTRLMMR_MAIN_DEVSTAT);
-
-	if (bootindex == K3_PRIMARY_BOOTMODE)
-		return __get_primary_bootmedia(main_devstat, wkup_devstat);
-	else
-		return __get_backup_bootmedia(main_devstat);
+	return get_boot_device();
 }
-- 
2.43.0

