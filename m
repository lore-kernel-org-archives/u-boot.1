Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13028C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 04:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B62DE80F9E;
	Mon, 27 Jan 2025 05:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RcRuryli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A569880FC4; Mon, 27 Jan 2025 05:16:34 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 227EF80ECD
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBv/sBPea8qhpPiI+8tuKstAy3kZ7sDUMWxem4lSM8yls5lMTg89/E3JmlZSEtHBiiSjkqZyd4NJaZoGtA0QGmYu6FVYXVyiJCC8s0viZnmHQrsNQ/BBnJPgY04KJl5PMNBB0CvKpgL8FyVxynuisNg4Ca1bRpB5ehx+BnQU+05gm38JFoF5sg/Kb0pANqS2FhgMa7J98Gn+CI7Bf8/DNE5hCUQqUeLyqDG2eL3AUql7AmgS0IPmkktLDypVXIB8bQ0LjfovviPeu5hKHfogbib7AC85hwgYAlwTL1fg23PsbFF9izOQC0Hh8JHR4nvJk8n+zaJRvMhl77pe04g1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7FnXO/Ec1rLqqMOefGc/7SSwyUepFnv6P9QE40zgfs=;
 b=Z30AyggHwg7weRULZfFs6NK6geVAKAGj5PE4zvGRSKj//Mh6Q8hFwFd0SgWot0cKvt+6+6th//ngkwT3z/8L/s6Q6haM8Yf9tUbo95ezZdA5YTAXvjmUqeV3cQ6qlhudoBOxqzE+A5R0pDvKwybBFsSfnxJn6KjEOPtnv6aaJ0cwUscJ+8hbky7U0Etwfd5hktZXQPKQn/g4EWvhX64YAcuSdqAXXLrvBsGIKMROgBm5OhUatrAQu9gg5GJdrv6akhm4lplepQguPeips7RgS9S0EibU/a8Y1P+YJS0OPzGk4KZjp7yHqrfc3elz2nE+FtAVBNNDAYJ1kI33DzsnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7FnXO/Ec1rLqqMOefGc/7SSwyUepFnv6P9QE40zgfs=;
 b=RcRuryliqeEdpsMJYSz2Av1ZdlI16Kk/NcuGsd1lR9Nz4o3yPQVoKIdy85MgLqGTllbEV7kyB4cL2ejp6wTIfI7bQz7hGLGRKzuedjWq/28CE1n/BZd/0KkGWe6MBru5BdYjyUnvG+xGlSgWcvmxhcp3IU78IncSrSv837KIFrjeRz8YQBOKJ5Gq703bNYdubQaXYF1s83hAQPWtDXXMtNmmtuWjXQixeEcZlt4LyTWdQIAmValXHRW7Frl46Fv7O9i3f71OaANZg3Cmh6cSoS4+z0FkhYHBh8QfU9nzMrw6+kCBEMwqwPCVBOb6Ba7OLg6pmceo/YuFo5mrhONibg==
Received: from AM0PR03CA0052.eurprd03.prod.outlook.com (2603:10a6:208::29) by
 AS8P195MB1256.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3ca::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Mon, 27 Jan 2025 04:16:28 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:208:0:cafe::37) by AM0PR03CA0052.outlook.office365.com
 (2603:10a6:208::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Mon,
 27 Jan 2025 04:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 27 Jan 2025 04:16:28 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 27 Jan
 2025 05:16:27 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 27 Jan
 2025 05:16:27 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <sjg@chromium.org>
Subject: [PATCH 2/3] board: phytec: phycore_am64x: Add support for 1 GB RAM
 variant and ECC
Date: Mon, 27 Jan 2025 05:16:11 +0100
Message-ID: <20250127041612.985929-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127041612.985929-1-w.egorov@phytec.de>
References: <20250127041612.985929-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000044:EE_|AS8P195MB1256:EE_
X-MS-Office365-Filtering-Correlation-Id: 733a229b-8b66-4b34-f783-08dd3e895f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yBVY4aefYPJmjSydNHFvRxlGqTmm4w+sNG5Xfzsy/yk1IJyYpppdAAfkelqe?=
 =?us-ascii?Q?QeDGjr0s6IiHaI0oxHoba5w37EG4idA41Z+Kt9YqmsEz2+bIjKeGSHvzGCIr?=
 =?us-ascii?Q?X4KSX9aqER+Xpc9qi+PUnheKHjaPwMjUz1BcPENfvrg3biWiYVErvL542kyv?=
 =?us-ascii?Q?S106xUNQ99ZHw3FMq+mx2FkiEw1I7tWQTSb+ySMomeF3LRAIRvUSLA2YPtZZ?=
 =?us-ascii?Q?5pEhcPyERhnQeJhw/YvyKsA3O0q4XC3ghWg+ur3nudfbYFOUqD+Xuh9w2DLg?=
 =?us-ascii?Q?NUOPgbIFwrUgHrzUfzic8yqT9FuB1N1UmRrUDH1mk/1WLQAPDQDAJXoyZd+m?=
 =?us-ascii?Q?SSz6x0QSgUxNAO5SElRphacvYsi6XP2r+X5gc8V4KyhJwZt3EnOQYA/x1f37?=
 =?us-ascii?Q?9l/uc3LhyWxqnAwEQfKP4UrNMrNA4gpvoJa/KlveLIgWaIAYY7bv6odYNw6Y?=
 =?us-ascii?Q?DemauRYl11rAVq2DuBURzjtDILHEye7HvfO2/5mJI6XPycaCx+QzO45Kz6p2?=
 =?us-ascii?Q?s43flWx/rAJ/EqPEREH15sgQo9MddNPXFYnqHDBm8MIB7NmPvqWh+uExiQnW?=
 =?us-ascii?Q?nkp1CXSsAh2WsyO/BDqojnRAHIiRikeoW4ofnU5dsQznN4xLhU0LfZ3v38av?=
 =?us-ascii?Q?rKKH0fm785G6elL54Ck1xjwQrE0Ugfi1oFp3+zN1TeKgkd6/rLP5tLhIEeQH?=
 =?us-ascii?Q?47syxQ7uj5cu74KI09YjiT/wEemGCXqKVpy/XqN6OWFJgMgybDPFVxUQg+nx?=
 =?us-ascii?Q?Z9rGPutJHFgjd/CITaCAtnxoPUnKH3NsyvDfxI3sZts4ohUK12+wl7LWjH/f?=
 =?us-ascii?Q?B3ZURzKo7PhgwImdknzOKhNuPi8Tvw9R5cTOJqkZjx//whznDjOWHErSqybz?=
 =?us-ascii?Q?Eskynx4gS+PnUTarMcED5xkIkmZkC/RtP4FASfoNNhbWs6tIdHxFQ2+CffDw?=
 =?us-ascii?Q?xt0PdExPJW82MymvuNc/jvl5WaxMTe6MFxpucr8QyfZSTEGaHqgOCdtw/rrg?=
 =?us-ascii?Q?rqCjUuqWpV5eFHFzMHHaD7WLAAODDF4FPQtfX9hcv5CWCgOo+8zlGUmNX3uL?=
 =?us-ascii?Q?antXtqu0ZdbaAHascC7D4PF7BkPnkrh7rqqtscbtpPPKxEhmAmPXo3uXKbYW?=
 =?us-ascii?Q?Z+RYvvikRdUe9OxKilnJdxaGq79q2XtRMarfXACuctfQGHA31ETmY8cdCrZL?=
 =?us-ascii?Q?VyhDWPv0lLAl0k+3oGTncLY8ZdOVUDTQ8NQ9PDpO5RZc4z7B7/AzzN87TUzM?=
 =?us-ascii?Q?q9XLNivORNbMKQiB45MMZRmSDzeSEn00YfBOm51e6S2KCVpxGPrmd35DpLg0?=
 =?us-ascii?Q?fQAPfAe0/7rGfsk/ka0zLVtheXHFrhqwdtAY708Hls4T+tMuLXCKbxc0wDsM?=
 =?us-ascii?Q?JK1hJv4/vQk3OedijB9NcEzkhkA7A0a/k/fSbBYJ38WybYy3iUiEKwoJkdmn?=
 =?us-ascii?Q?W7WHcQXEO+mJl/KpSnBRk2SqVRfuxwOvtH+CmRjvgCbH2kYXFsPpqVcDhMGR?=
 =?us-ascii?Q?JLnuAv3Vbmqp0nA=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 04:16:28.3971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733a229b-8b66-4b34-f783-08dd3e895f28
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1256
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

Detect RAM size via EEPROM and adjust DDR size and banks accordingly.
Include necessary fixups to handle ECC-enabled configurations.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am64x/Kconfig         |  25 +++++
 board/phytec/phycore_am64x/phycore-am64x.c | 105 ++++++++++++++++++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_am64x/Kconfig b/board/phytec/phycore_am64x/Kconfig
index 829526c3295..a709b71ba4d 100644
--- a/board/phytec/phycore_am64x/Kconfig
+++ b/board/phytec/phycore_am64x/Kconfig
@@ -35,3 +35,28 @@ config SYS_CONFIG_NAME
 source "board/phytec/common/Kconfig"
 
 endif
+
+config PHYCORE_AM64X_RAM_SIZE_FIX
+        bool "Set phyCORE-AM64x RAM size fix instead of detecting"
+        default false
+        help
+          RAM size is automatic being detected with the help of
+          the EEPROM introspection data. Set RAM size to a fix value
+          instead.
+
+choice
+        prompt "phyCORE-AM64x RAM size"
+        depends on PHYCORE_AM64X_RAM_SIZE_FIX
+        default PHYCORE_AM64X_RAM_SIZE_2GB
+
+config PHYCORE_AM64X_RAM_SIZE_1GB
+        bool "1GB RAM"
+        help
+          Set RAM size fix to 1GB for phyCORE-AM64x.
+
+config PHYCORE_AM64X_RAM_SIZE_2GB
+        bool "2GB RAM"
+        help
+          Set RAM size fix to 2GB for phyCORE-AM64x.
+
+endchoice
diff --git a/board/phytec/phycore_am64x/phycore-am64x.c b/board/phytec/phycore_am64x/phycore-am64x.c
index 8f3b22657c7..f14c87f5c72 100644
--- a/board/phytec/phycore_am64x/phycore-am64x.c
+++ b/board/phytec/phycore_am64x/phycore-am64x.c
@@ -11,9 +11,12 @@
 #include <env.h>
 #include <env_internal.h>
 #include <spl.h>
+#include <asm/arch/k3-ddr.h>
 #include <fdt_support.h>
 #include <asm/arch/hardware.h>
 
+#include "../common/am6_som_detection.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 int board_init(void)
@@ -21,15 +24,113 @@ int board_init(void)
 	return 0;
 }
 
+static u8 phytec_get_am64_ddr_size_default(void)
+{
+	int ret;
+	struct phytec_eeprom_data data;
+
+	if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_FIX)) {
+		if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_1GB))
+			return EEPROM_RAM_SIZE_1GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_2GB))
+			return EEPROM_RAM_SIZE_2GB;
+	}
+
+	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	if (!ret && data.valid)
+		return phytec_get_am6_ddr_size(&data);
+
+	/* Default DDR size is 2GB */
+	return EEPROM_RAM_SIZE_2GB;
+}
+
 int dram_init(void)
 {
-	return fdtdec_setup_mem_size_base();
+	u8 ram_size;
+
+	if (!IS_ENABLED(CONFIG_CPU_V7R))
+		return fdtdec_setup_mem_size_base();
+
+	ram_size = phytec_get_am64_ddr_size_default();
+
+	switch (ram_size) {
+	case EEPROM_RAM_SIZE_1GB:
+		gd->ram_size = 0x40000000;
+		break;
+	case EEPROM_RAM_SIZE_2GB:
+		gd->ram_size = 0x80000000;
+		break;
+	default:
+		gd->ram_size = 0x80000000;
+	}
+
+	return 0;
 }
 
 int dram_init_banksize(void)
 {
-	return fdtdec_setup_memory_banksize();
+	u8 ram_size;
+
+	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]) * CONFIG_NR_DRAM_BANKS);
+
+	if (!IS_ENABLED(CONFIG_CPU_V7R))
+		return fdtdec_setup_memory_banksize();
+
+	ram_size = phytec_get_am64_ddr_size_default();
+	switch (ram_size) {
+	case EEPROM_RAM_SIZE_1GB:
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = 0x40000000;
+		gd->ram_size = 0x40000000;
+		break;
+
+	case EEPROM_RAM_SIZE_2GB:
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = 0x80000000;
+		gd->ram_size = 0x80000000;
+		break;
+
+	default:
+		/* Continue with default 2GB setup */
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = 0x80000000;
+		gd->ram_size = 0x80000000;
+		printf("DDR size %d is not supported\n", ram_size);
+	}
+
+	return 0;
+}
+
+#if defined(CONFIG_K3_DDRSS)
+int do_board_detect(void)
+{
+	void *fdt = (void *)gd->fdt_blob;
+	int bank;
+
+	u64 start[CONFIG_NR_DRAM_BANKS];
+	u64 size[CONFIG_NR_DRAM_BANKS];
+
+	dram_init();
+	dram_init_banksize();
+
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		start[bank] = gd->bd->bi_dram[bank].start;
+		size[bank] = gd->bd->bi_dram[bank].size;
+	}
+
+	return fdt_fixup_memory_banks(fdt, start, size, CONFIG_NR_DRAM_BANKS);
+}
+#endif
+
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	if (IS_ENABLED(CONFIG_K3_DDRSS) && IS_ENABLED(CONFIG_K3_INLINE_ECC))
+		fixup_ddr_driver_for_ecc(spl_image);
+	else
+		fixup_memory_node(spl_image);
 }
+#endif
 
 #define CTRLMMR_USB0_PHY_CTRL	0x43004008
 #define CORE_VOLTAGE		0x80000000
-- 
2.34.1

