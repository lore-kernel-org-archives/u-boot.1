Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42771C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 799C987D8E;
	Tue, 12 Mar 2024 16:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KOHCMUqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF8187DB0; Tue, 12 Mar 2024 16:51:31 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15EC3879A0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHjYd0bXyNiHh5Pc5NTg+87K01PQvUC5PuJLuudVxK/aqo5MjPK1Ugacr8CkNU8nzUmE+fCAuURakiWfdW+f/zbQ4nTR6QgAPjHTMnkn6qSQa79j55oJ4uokOma4J2oH9LzdRW79BxOM1e4gAV7eetkw99J36hVm7jYb0NfcZ7e7YXKzb9l55FLQritApIU7Cb01SMMOIFtj6IP+Hq1z7DYySsX5+2XnFjPM4BUlOJbF2x2PbERFZYi2iarpzXC22XqMcwGIsBArGpJ1kGqyuBvjkpYdiZhe2uYAXyTJ+5AULPazORMJBiGu+rmr6jzoyO3TIBNcS60n9mlrtMZTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1a1v8gJVytHRk5ilXWFa9zxWuVPGNlzXGdRsud+PAN0=;
 b=M386vmJ5Q++62II51eWoM022n6+nmAJbPBFJTNCB5FxQbDzUijeKhT4LUXLJymjzuFh7Hm4IaDri/GVdnqeIsSpQhIrMQkPmjWge2J9g6BYv9wq35tj56KINp/WPioVVFPItGdYU02SqOTl9iX1s7BlXmOwlR3O6Y5EnusFj+BV8Scqu6fmaV3/U/SKfIiHoHVSKTJFChyTzQcW+9xWucD4PMaC31u7BmmubyP6fU44ZuFVII7Vuk8EGTkBW9DSqQGVAjxFVCSGb/c/a9EWs98C6xwSG3aH9Lc1iX3sfLnt3ZKMjiVewThoCD/gR3u+65yDB2Aw8nehTWON76Zjjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1a1v8gJVytHRk5ilXWFa9zxWuVPGNlzXGdRsud+PAN0=;
 b=KOHCMUqc7Yi6J36MJtvquaVTRu1GvCVsO1Wh1fGDyKrWAzl81FypD6lvBo5KxVWY8a2iyRU/ZgZgKtuLEr6SUDt2QmV184Zw4yTsNjjlhKx7jVIj0JXZPLzt0DYCYpv8/EocEreI14Z0aODIEQd7b+XapkjDnhrUCzEc+VrXgOw=
Received: from CH2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:610:60::19)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 15:51:25 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::23) by CH2PR14CA0009.outlook.office365.com
 (2603:10b6:610:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.35 via Frontend
 Transport; Tue, 12 Mar 2024 15:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 15:51:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 10:51:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andre Przywara
 <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>, Fabio Estevam
 <festevam@denx.de>, Linus Walleij <linus.walleij@linaro.org>, Peng Fan
 <peng.fan@nxp.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH] arm64: zynqmp: Do not setup default SPL options without SPL
Date: Tue, 12 Mar 2024 16:51:21 +0100
Message-ID: <8dc4b799d36f963a3e1ebb5b24793632dc360b61.1710258674.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2233; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=EcSBuxp2PmeRPBiTbmf1Gc6BeGSXd/eLC3VekmLEw3I=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQPlZ8Tr8/d8qvq4bymd+LcLYfcmPPqbW9zeabffPC8m
 MPLxX9uRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIm0qGefqrrnDlfrn8LdIj
 s4NjisUj5YznZgzzvW44RtRk/RdZVfKx1JJ915S/vsvOAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: cadb172f-f874-4c7d-36f9-08dc42ac45d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYt1pPQ+RjP81YMKzCdSRoJSx4kjzfIt6AbwFm35eZycyVXsNT8k/rhc81ZJZi5FjA5zng7uVXqvHxAcnkgA0jL9uSxGWTFQNKoPKeyn3sDaTowuyOjFcHsw0L4g1OysOGxNFxWHkA0FjD6wA8cPYz+0m4OvI6j2GwX9ZxgolAG6Dq0Y3+G21s5wEvrhV9aUITXlw3exdRYueYewT7Cwx4Datfn3lVW7F3Z3Q9ytrYpQsjA5rshTNQDZLen3NbIm+7KMRFzPrfBXc8aptDU7VykUpURPpX1Fz/ahg6AR9AWpEWT7IIVgGYpCrR3531gM+52lpLkM8N/BuA+WJOZjzbsJvI+dRta06/QTZLNfZHpM7uUSFT+oyBZVRlTLfQbYNZvbC06DXuBHw21n/Z819CcWbW5JIN2dJIy3b2Ewx4SYQuKD26rFVzGwE5v0/GcbHQGehYU+TKn3Og8lFTqLYofoPDdLZ/tB2JTYF2MqTrISzFOTmbKyyUkAOIInXJ8ZCwCukgzJRBLzzAQxQ6bQKh0Vzf2pHMzyHHgE7Jrje/fpGl2y/mZHA563LN9dvoFy0AKRWD2Nttr2P1wIqRTH4G9lxfNB82ekx6JSrk9HDizEgd4REBs81mSkMczEhEnyNpz9m4Btb25h7ddwhfRdqD0IAujGQqQdWSHJ85tukbvL3rm0NKyYFkkUoiedQDKbTJ2l2wK0zTFskfl1NV3/twfnwCBwuWKduM7S6jZ8NY3wTSNIsF1Up3rxewqcQ+WNf1MzHUtNqVg6zko1eOF1CHHSCJEM12GPDzcYkk1LYYQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(82310400014)(376005)(32650700005)(36860700004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:51:25.2395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cadb172f-f874-4c7d-36f9-08dc42ac45d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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

mach Kconfig file select some options independently of if SPL is actually
enabled. It ends up in situation that SPL is disabled but symbols are still
present in .config. That's why add SPL dependency for them but also group
them with other SPL options in ARCH_ZYNQMP fragment with using imply
option. This should ensure the same behavior as default y.

Also fixed SPL_ZYNQMP_PSU_INIT_ENABLED for the same.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/Kconfig             |  8 ++++++++
 arch/arm/mach-zynqmp/Kconfig | 27 ++-------------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fde85dc0d537..0cf85edcb45d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1325,6 +1325,14 @@ config ARCH_ZYNQMP
 	select SPL_DM_SPI_FLASH if SPL_DM_SPI
 	select SPL_DM_MAILBOX if SPL
 	imply SPL_FIRMWARE if SPL
+	imply SPL_FS_FAT if SPL
+	imply SPL_LIBCOMMON_SUPPORT if SPL
+	imply SPL_LIBDISK_SUPPORT if SPL
+	imply SPL_LIBGENERIC_SUPPORT if SPL
+	imply SPL_MMC if SPL && MMC_SDHCI_ZYNQ
+	imply SPL_SERIAL if SPL
+	imply SPL_SPI if SPL && ZYNQ_QSPI
+	imply SPL_SPI_FLASH_SUPPORT if SPL && ZYNQ_QSPI
 	select SPL_SEPARATE_BSS if SPL
 	select SUPPORT_SPL
 	imply ZYNQMP_IPI if DM_MAILBOX
diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index 7e7c87d16fa9..eee34380f0a0 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -1,29 +1,5 @@
 if ARCH_ZYNQMP
 
-config SPL_FS_FAT
-	default y
-
-config SPL_LIBCOMMON_SUPPORT
-	default y
-
-config SPL_LIBDISK_SUPPORT
-	default y
-
-config SPL_LIBGENERIC_SUPPORT
-	default y
-
-config SPL_MMC
-	default y if MMC_SDHCI_ZYNQ
-
-config SPL_SERIAL
-	default y
-
-config SPL_SPI_FLASH_SUPPORT
-	default y if ZYNQ_QSPI
-
-config SPL_SPI
-	default y if ZYNQ_QSPI
-
 config SYS_BOARD
 	string "Board name"
 	default "zynqmp"
@@ -143,7 +119,8 @@ config ZYNQMP_PSU_INIT_ENABLED
 
 config SPL_ZYNQMP_PSU_INIT_ENABLED
 	bool "Include psu_init in SPL"
-	default y if SPL
+	depends on SPL
+	default y
 	select BOARD_EARLY_INIT_F
 	help
 	  Include psu_init by default in SPL.
-- 
2.36.1

