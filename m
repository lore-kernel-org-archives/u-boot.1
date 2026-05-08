Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9138FCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 14:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B95584C7E;
	Fri,  8 May 2026 16:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EvnEGUdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD33C84CE4; Fri,  8 May 2026 16:25:22 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C13CB84A3E
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 16:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lI5OF7qL8Ek+aWzGSldzCkjqBG7iSrYMb0SVGmkUgOI61OaDU8Rb/Tx6n1TySTCbL+mcKTDjbs7xImul7cgDzW6AlddmE5OfO7PYP5Ivbn/DXiVwtRLKQeewznnYY2TOsCQcBcGLAkvnxisOoduktju0lLKpws00kl53YRs0XWIhIcg7PqLDyXQQo68CXlAx/3vTLe5lf5C7/XxJ8wb12lbxrknn5WG5tAkxg21kRQTQqTc1OY98Jq5/YSbqiDioY/3I5oqvi0B90WandZBKbvav876P2ZFr8gq+rHwThY5nK0g5t7dqN0iaMJN3cxnodqGbylYqZkl2Qfi7sV6Wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIlaUWWscROo3Jk/bJ9jcr5wKDC2k+Y0SwevRzeSHNU=;
 b=mtCj+tqpKlukOkHSNjVVwcO6b9p9uqNuemlfcKwVBBbhYbv5fTgSJlKpLkBm/dgrO3K3epguoUmxpxNhaWuw0BVJABd44+0hgsxXdHnbQxkwFGn0dzpQ66HOD1ztqNsnIYTEhb7hDgplkYcChwuOCtrr1Y2gb+4NE1WU3Pw43RPAniW76C7/EV9PbwXBYtCDiF0qTKbN92zovM8s3ny6I1JNxi11KNKpj8dlv9ZmAHv3sNo5JI2Z3T5NO2QPKGEnTzM/k1m/v1iwgvRWFKkgKPwlYRjcCcFXtAfHmbb8t8Dlqy7P1ROHQZe/9L95UYJMBV44lJsXVK9DUTVv9qz3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIlaUWWscROo3Jk/bJ9jcr5wKDC2k+Y0SwevRzeSHNU=;
 b=EvnEGUdfHNV136zTgqCR1D9F06yxzWDL3KvNTr4AcJgV7eb0S5KZ1qAt1F9Sg+vASZ1kwKoYxIiNbNsL7Y/+HsiMO39aJBOW/zb/qyze7fkV4RNdu0sTGdUArvBYXp8uWyFuDp4q+xlP3Y/OAy45RMbHU0ZcIQERDliidJpxghg=
Received: from CH5PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:1f1::22)
 by DS4PPF194C7D93E.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 14:25:12 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::b) by CH5PR03CA0009.outlook.office365.com
 (2603:10b6:610:1f1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.20 via Frontend Transport; Fri,
 8 May 2026 14:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 14:25:11 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 09:25:10 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 09:25:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 8 May 2026 09:25:10 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 648EP7Xh1541028;
 Fri, 8 May 2026 09:25:08 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <b-padhi@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <gehariprasath@ti.com>, <n-francis@ti.com>
Subject: [PATCH] arm: mach-k3: j721s2: j784s4: Add errata i2378 workaround
Date: Fri, 8 May 2026 19:55:07 +0530
Message-ID: <20260508142507.1386946-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DS4PPF194C7D93E:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a772b29-bc17-4070-c0c9-08dead0d9d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: iApkSWZGhZCbFWLH6qg0bHN+rgMKWeNpCUXNtlFyg2QsuDvjeOt9jYJYSoissQEUWsvmvY672h8+63FZ19+RCLysXRApN0x1SiqFJT9iZZOCfDcjZ5wPsbbkmZH5trBxlrdwFhj074egQ4MAOhJ/oaVQirwSnxJCUlr1UoXxCTf/OOVuIB19RGe6qPMZ8v6UdAsUO5COwq2U+z0a8vM5w8nSALZ0KUUxJCs/vpv2hY7e7sjMuq2iljhGrhTAoSknd+wama17YI8aCdchH15UOXJ42XP22MUb9N9FzYewMLYsDpKoaXyQSCDZ66iWHK9orKj3AMD+zh2x7Z5/g3SAl3EQZt8Op7O8jzYruhVtT+gf79MHIlEyjBL45napFRhG3PZ/eVjBMeaUcjr6Eb/oUnICr5XI7rCibbBMv5bAbc4XKAyqZTFILMAxJxSl9wQyanBL5Ogb3RgwU7OaAjypHYQJsvbT7Pl4w3B9TE8+wmo7ioHWgtnrseQfLszJjUnNAklWaosGhusH78zjs0vy3oLmkIZD5fzz0ZCFwDr8X3MjPLue0v9b9wcWZeR5/Ogj8E0KiQS1Gp6nhkX/wEjO9iBcJN0asAWA8+QEn7a5sFeKdVCECha3Urewi0GaCuTEdgLhZ7bw9N0CjSpO/TOvFadpcP6I6U6gOXt3gFFmKUKzgxW4wiW3nhjmSayiwVgB
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3yvtD0ple+bxvKklvnDSgXeSjg5aTOMysP2AFwt9RXpp+6D2Eu34+kF5Qj+LGD0TzxnRzxtg7tWCiL4qB6SMXnieYgxdf1fKIKAFfd/DxQxR/PTTkbcjlZsI2FQLcUrUsEGLwRvpDACZzwWnoUQNx62lQ5TCnja/5bOSRXV5OHhoS89t9HmWFcNxswGUNssfCaZkvykoUS93qSuASWM0CoSIqqNjK3fhsb1Gk/LFjKXongM33XqLzkf7H7ABs5/ZTxSVTIIWDw+bxt82JtKKXGwVSoBiud5eipl0ef//TW+41sMEmYlfu6RpOCbASuU95i5m8kuqgQLqTv6aeKLnrd1c623sFVCt4mBUusz+KZxpRo5qfUGy61bBV10tLayd70VvKzgrtD2HYOPo3V0/hSYF65XbsHZF6CdcxdW6U/w0PelEY9MZOj5TYyUg5X3e
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:25:11.3305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a772b29-bc17-4070-c0c9-08dead0d9d0d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF194C7D93E
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

The shadow copies of WAY_SELECT MSMC MMRs have incorrect reset values.
The main copy has the correct reset value but MSMC functionality uses
the shadow copy values. This incorrect reset value results in
under-utilization of MSMC L3 data cache and snoop filter for DDR
accesses.

The workaround is to write 0x00000303 to both MSMC MMRs after reset.
This ensures that their shadow copies get the correct post-reset value.

Link: https://www.ti.com/lit/er/sprz530c/sprz530c.pdf
Link: https://www.ti.com/lit/er/sprz536b/sprz536b.pdf
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/mach-k3/include/mach/j721s2_hardware.h |  4 ++++
 arch/arm/mach-k3/include/mach/j784s4_hardware.h |  4 ++++
 arch/arm/mach-k3/j721s2/j721s2_init.c           | 11 +++++++++++
 arch/arm/mach-k3/j784s4/j784s4_init.c           | 11 +++++++++++
 4 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/j721s2_hardware.h b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
index 82f076a45e0..a4d7fe48662 100644
--- a/arch/arm/mach-k3/include/mach/j721s2_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
@@ -37,6 +37,10 @@
 /* MCU SCRATCHPAD usage */
 #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
 
+/* MSMC RT_WAY MMR addresses */
+#define K3_MSMC_RT_WAY_SELECT		0x6E008000
+#define K3_MSMC_NRT_WAY_SELECT		0x6E008008
+
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
 #define J721S2_DEV_MCU_RTI0			295
diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
index 29a894baed3..bb5c58d00e4 100644
--- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
@@ -37,6 +37,10 @@
 /* MCU SCRATCHPAD usage */
 #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
 
+/* MSMC RT_WAY MMR addresses */
+#define K3_MSMC_RT_WAY_SELECT		0x6E008000
+#define K3_MSMC_NRT_WAY_SELECT		0x6E008008
+
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
 #define J784S4_DEV_MCU_RTI0			367
diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index b5453d8895d..d996dfcc332 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -163,6 +163,14 @@ static void store_boot_info_from_rom(void)
 	       sizeof(struct rom_extended_boot_data));
 }
 
+void apply_msmc_shadow_copy_errata(void)
+{
+	/* Errata i2378: Write 0x00000303 to MSMC shadow copy MMRs */
+	writel(0x00000303, K3_MSMC_RT_WAY_SELECT);
+	writel(0x00000303, K3_MSMC_NRT_WAY_SELECT);
+	debug("%s: Applied errata i2378\n", __func__);
+}
+
 void k3_spl_init(void)
 {
 	struct udevice *dev;
@@ -176,6 +184,9 @@ void k3_spl_init(void)
 	/* Make all control module registers accessible */
 	ctrl_mmr_unlock();
 
+	/* Apply MSMC shadow copy errata workaround */
+	apply_msmc_shadow_copy_errata();
+
 	if (IS_ENABLED(CONFIG_CPU_V7R)) {
 		disable_linefill_optimization();
 		setup_k3_mpu_regions();
diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 53f152ccd9c..48b52fcb333 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -180,6 +180,14 @@ static void store_boot_info_from_rom(void)
 	       sizeof(struct rom_extended_boot_data));
 }
 
+void apply_msmc_shadow_copy_errata(void)
+{
+	/* Errata i2378: Write 0x00000303 to MSMC shadow copy MMRs */
+	writel(0x00000303, K3_MSMC_RT_WAY_SELECT);
+	writel(0x00000303, K3_MSMC_NRT_WAY_SELECT);
+	debug("%s: Applied errata i2378\n", __func__);
+}
+
 void k3_spl_init(void)
 {
 	struct udevice *dev;
@@ -194,6 +202,9 @@ void k3_spl_init(void)
 	/* Make all control module registers accessible */
 	ctrl_mmr_unlock();
 
+	/* Apply MSMC shadow copy errata workaround */
+	apply_msmc_shadow_copy_errata();
+
 	if (IS_ENABLED(CONFIG_CPU_V7R)) {
 		disable_linefill_optimization();
 		setup_k3_mpu_regions();
-- 
2.34.1

