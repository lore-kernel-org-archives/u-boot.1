Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBA1D4A5E6
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 01:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CFB580325;
	Fri, 16 Jan 2026 02:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Z5ONxzrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34E182BF2; Fri, 16 Jan 2026 02:42:07 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F8E80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 02:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKsMOtoVoCFXFxmWl+V5vGolFgEvF11vILq/NBRJp9bWYgAeSosw7oCNuADRetpRrOmInXrFXSwieytN0IvaksFG3PF3hiw05tLZSlY0Wmook1uLBxYfu80XvJAG/hkkCzNwS94SyBduDqMvXQJWyaFldn6vPU61VWotNcJXbJNHjdzaqAqx6RA5QPHhJYGrZYS1ZoAdcIS8Hrcn0dF/OL4Va91pwrzze/aP0UUKevFHBZdc7tYp6ThoSmHHerqzRALdWCJnUIR9vWB2EqgOW00sCwxlbPBtyp80foiTtlhEoS1KdV8ipGJF00NL0gmsin91OH5XzYdeh07KbRaJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr04/R5pMJucM8skvcYYt1ZSLcFN4oJ+1yRxMjztTHI=;
 b=Nons3X22Z5jTyRmC5WAaO83cl+rMdh0jDrCuLUoVBmQtqyT7lFukvf1voeQA1EC4XWZWZMZD9MIRtsF3EtvLPeaP72A5ubntw0P815uRMaHe2Ao74yDvnR/dt97VIEHNCXzDox8g/dKdZVgHD7ICkjGNSiq9AB6F7EX5OZklzXRuTx2Z//XCbA/09zdTTjFbueev6emY3i6mWPt/mUm/OodBzN2LdlD6u/dyJKbDn+pvYJtmRwlnx/XO3jbDSyf79NzBYhhbsB6gzT/T4dTWeNRf3lJSdyQReV7XWWHQfxFGX2NM8a3bh0mpN7bOE4fW+Mpmy+FGdRTKkbzx6giV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr04/R5pMJucM8skvcYYt1ZSLcFN4oJ+1yRxMjztTHI=;
 b=Z5ONxzrXf+Z2ZC+xkZ8qEvX0ZR8ziYJXguPJ7reGx2AGiTB3rcUGcjxuaFLVwfHv3LDA+F9qopw+dK+DmeJLVavc/mJVwlVJ8ZzwOB2fqE/gJ40Jq1d9cNajinqtoY7fZNuRMNX+/uz9AIQgUEvyTzDlkUVFO3jC09J6Z8wNhV/ZbkJOerb441Pc/D4JIBINcTvQABVQIT2Giw5v+TZHdgU63CSyCHi+b90RYMMISd4TRzbC16MHQF2TK9iyElxaLA+jjDrIdlhVTblqgNGyDzPaQ67Znyg4/hXrARqydCRdXAwn45s7Ma+oLdnnwn/gYESq1RUslCjJhtFVCdnvHQ==
Received: from AM9P193CA0003.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::8)
 by AS4P195MB1887.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:577::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 01:42:02 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:20b:21e:cafe::c3) by AM9P193CA0003.outlook.office365.com
 (2603:10a6:20b:21e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 01:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:01 +0000
Received: from lws-haller-privat.attlocal.net (172.25.39.212) by
 Postix.phytec.de (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 16 Jan
 2026 02:41:58 +0100
From: Dominik Haller <d.haller@phytec.de>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, Dominik Haller <d.haller@phytec.de>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 1/3] arm: mach-k3: j721s2: Provide a way to obtain boot
 device for non SPLs
Date: Thu, 15 Jan 2026 17:41:11 -0800
Message-ID: <20260116014116.767555-1-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.212]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A7:EE_|AS4P195MB1887:EE_
X-MS-Office365-Filtering-Correlation-Id: 5606c69c-a5e7-478b-a145-08de54a071cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HN2HlLb9u+cPALQPw93t2HCTTW9rawipND9r8vcLBtat80/kle9m6dHmRGtK?=
 =?us-ascii?Q?xSPGdyVr7tvLqglvKw1NoFeRkL0FtHyorEeVWfsg9KOqJWG5J6x11NeC/wm8?=
 =?us-ascii?Q?Q4Bm5yM+kYCaARS66h940rLkMwDFnJq/AlCBFCAOrnprpAyypkNRQO4SPuRd?=
 =?us-ascii?Q?DWoyf9Id1R+cU876xSeX2bqx3xC/4VijOV8zRCKofjVD2EIogas402QvWDkK?=
 =?us-ascii?Q?YSzZvhkhmgTRDYFf3jrP+lk5crJrakSrE8btDKDe70x37DWRTUHMSjfUMzNg?=
 =?us-ascii?Q?IYgGUyzFQbAr/yPgj1BQa/ufCsBDIcec2j5DREHgiFYjFHYmhR23nE6Qd6k7?=
 =?us-ascii?Q?ptioJDTdzmxs8APKki6QPWnEuS8aSqNFtQmMt/bojFSZiPIDuGwEUd31Jo2S?=
 =?us-ascii?Q?+c1xG7e7fCZ93FK56/Uux1KwKj6/5jX7oOG+3aFbWSuiyEabJHBWsSTJnooD?=
 =?us-ascii?Q?LAOEvgFiVFEjMfyZOojx87fBB0d6cJEqvgbgwsgKfnUMtLuRhsmPi/0k+zq4?=
 =?us-ascii?Q?gSiiZFjtQBBz7HCtM1SGEskZfJYOOgLH9cu3AOOtnWAbkbLyjArEQ0wkpa69?=
 =?us-ascii?Q?owcZacyS1ahq3aHNoTLhnZQ8aIUKSM4MFaEeQxG4XaKiUKWVsu1UIYUBHpur?=
 =?us-ascii?Q?tVK/s+T7qO7EDDsTraAny3N8lIbMsnitrH2TDH0lsqAAmRsCiMsr+sTtulTx?=
 =?us-ascii?Q?eswR7PY+A8IN6VAXl8Z+oRvTxqCbAS4q5FFUOJ6EkaQ69i74nLdRkdvA7pua?=
 =?us-ascii?Q?L0Oh9Zqa1W1htl+S/kYFlkgoThSp+vFxNC+aM+HYWhbJtjiGYvRTdfIkhFI0?=
 =?us-ascii?Q?eecYY7EZfUukrBNioT3O9wROOyF7VSmwYW+gQgwjOyKERc1J1KWt1/lUNZju?=
 =?us-ascii?Q?ycHwAzilbLrCJCt8OD9k8x5OgfyvNb8jjow8MsZK+zFffdTI4DYWIVBVC4GY?=
 =?us-ascii?Q?9wKqTSUoLfwHwlDQnmZAxBFeDmqRos7jFpZ7J337HRsVnlYoA4k3FGG/oHBo?=
 =?us-ascii?Q?+HwKhhuECXchBbyn2jPfXC4WwWKwfoqr/qv7EtwITocLn1UYQjGnQAZcEJca?=
 =?us-ascii?Q?cSUutoQlQWftlTKYPHpMK9f5jZ2/gTn17jxuMDf0LguL6/VD/1tEsFV41z3X?=
 =?us-ascii?Q?uf679WI/AjALT99Lelo/2nuMw+6tICIwGPR010SA8IRDnTYcOtHL5kx0Iqt2?=
 =?us-ascii?Q?GcFQInNTUpzEQrwO5o3E/0JvPw7NbprBzT8HwHyWSkoTieFlTKCeTo/5HeMR?=
 =?us-ascii?Q?0L/PJdOcRScorD9ubKDGZHPK55bLSXrj8svD5NO7nsIUdco+NDcuZDNW5bG5?=
 =?us-ascii?Q?wITswDWxbPrjxlMI23QiggMtA8OBkA9w0C4ObXMQaJAJQVZhzAo8g7T4CPOX?=
 =?us-ascii?Q?rnF5imMrbBdc2Iljw0f8WaJQQH+i7V5UfTTo1h68utqSrr/rn/rR9gfDumJT?=
 =?us-ascii?Q?zLh1vxmja7Ggck2S7djLNk4dhMZcpG2JJdMajIrU8xjjDSor9msWZOFe/boD?=
 =?us-ascii?Q?s5CtqG2Uitd7SoRUuq5p7XAOIf2+d5WYayjGqWBM004g+OqyQyqaQwcs+aKD?=
 =?us-ascii?Q?LJd4ee3ArAuckgKoIhqR7OkRzLM2Uid282GeMnxu8Azjfkf3KTo1PmnVdAea?=
 =?us-ascii?Q?jbfHauUmE4dbqF+Wq9QATcwFcm1KG0M3aUJmpakSj/Z0MShOWkEbnIBwHLwf?=
 =?us-ascii?Q?uFsa7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:01.3555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5606c69c-a5e7-478b-a145-08de54a071cd
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1887
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

