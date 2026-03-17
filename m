Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3758FEDA09
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 01:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2D9840A2;
	Wed, 18 Mar 2026 02:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qZxQ0gz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9394841C2; Tue, 17 Mar 2026 23:40:28 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0179B840CF
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 23:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6Bi1UZoT+lXCNtRtQwMoCnCQFeVd1nXqh4bDggyFj+cuTow85nkKxuc01btkiydTwgBqjRj1Q6pgEuIqRSQ9hHtgl74zfC2296TjpPMTKnfbf106qlTmRWVLYmdrFJQEgrdKYJkTXmJr4YpEwnG4jRYhO1sM1koaKnrtWfN23ILTDfkqcOR3/9c3oSIv0i1QFSmQhAUvBC8FHrz/A89KluY46kqG0l1FcS0SWcgBzoOIwToMTOVgH+9nxPTEgpzgcha1n4q4qLF7xsraaCfVkE9UtQx4pXtAfzLHfB7INPtutbe8Cc7809vDFhiALeoavLXQVcY/7Q4ETyj1qBWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJTXysNpVAM4WdC6OPXB2+qtBM+WncLDRNkHtQdqdtY=;
 b=nMteYBEBCJpkJi4XO2tOk+Nr2W33ZzmRqo9hKDByVnYCAlr8GTE2sNWTprJR6kDvCKCK3R2Am3IzrtDC5/4RPlKDxldLg9jwIkaQljPv8BHsgP1V0AE59stKBHgDX8BflEsYqDnpfhaNtcczMhAtC/C25bA4rV50BQY3W2yypJO1FSIjlRSds6aivB/wFMrlhCKMp+PjfPyapGxHOID5/vBYH72G6eSG6vTTtwa1M28L9A1GbJGPvfG6ZefYXomBDFPbtYMUurG66JNDGTd7ZNzW1o0iqWNc1p/vwEV0SuZ130Grt7iZd8807PLP0lePDH9QmI9ksAThGkQjSat1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJTXysNpVAM4WdC6OPXB2+qtBM+WncLDRNkHtQdqdtY=;
 b=qZxQ0gz6MXJQV5OU730nTQmy0zTNc4+9vMnsWhA8QpLf3vG+qQBdj8apBwODGrSHZ5d44Seseps5FHJ2NvkhlhaBj634Nae9fEh5LkjHEcgd8l9KJl+0H0jSc5RaGC9y5KUMYNmZOXCmCdYN7Lcl9skkLbwkrTXfbIZW5QYOdVI=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 IA1PR10MB6880.namprd10.prod.outlook.com (2603:10b6:208:420::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.24; Tue, 17 Mar 2026 22:38:40 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::34) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 22:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 22:38:40 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 17:38:38 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 17:38:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 17:38:37 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62HMcb4m3952594;
 Tue, 17 Mar 2026 17:38:37 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <bb@ti.com>, <nm@ti.com>, <trini@konsulko.com>, 
 <afd@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 3/3] k3-am62-pocketbeagle2: add support for 1GB variant
Date: Tue, 17 Mar 2026 17:38:00 -0500
Message-ID: <20260317223800.776581-4-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317223800.776581-1-rs@ti.com>
References: <20260317223800.776581-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA1PR10MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 7581bd76-b61d-46cf-2b45-08de8475efe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: MjjnA/P0iYmYXVYQe0McuamCp+CBE12k0nGsbRv/KtlIBk2AQ01pvlrV+wUUe+cl7BvfWVskeZgzdzxecPfjCvcVoh9CqziEAkohCBdHp94lVwJrUGIkMyoro+UVe78kh8h/seG26E/qhX6HCklaUb4B5oU5tw04mih/OW/JczdueFyihJ503J2CCMXBhm1jrcqGzItI+rP416d4hBH7v4175p/TWEEoQ/ttkiMqugvZZlTPxWRazkL6MWWqMtzeoHIi3Uf2iuB0turGA5zzFWhKHm+kKUG0voBmdOQrEfTJSV4y1QaErmSJzuHhLal96ZU7GIIk2mM3iyMyF6IyWfThuYwZbbOa7g3MsTRrON8qVmvIEcKhw6Nka1NfeDRMPeCSKquLlm/we5iDZmvszcnMN4HQdLoDL4+ynVBqx5hsWuwmRlD6a9kICVuIIIzSrtr/DxK3RuBqECu28ElX2qead9072iYFCk+y53rdOHUUI1c/Qs7r5bdir2QmT0/T3MgA7drdPu6Tx5hJjao7bTDWszPH6e/JhtRpKGQJFWi4Q4DBUBRMKvpWbKrLDmMl4gPzARLrFcKEYMklt8ocT+awRx45SODlfTFZtA/jhRV1RPu9y6cR+R0BVfKbUxfWUkG92e4XB6oCWKf/vvgYfpUBav0EdOEbVb3+bur0rs0Jt1cYVOQ4FrZjXuirX87K/eLdT0b5RFWYPDPchHzTjx5gXnI66y6uOyQLCVR3Xc4=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6K3XapM3t7foor/RlocU6ql/EHKl9UAh1hzC2tQjUBuWvWFySxBlHDMFx+VSHrmPokeW0DIZ6gns0kaaEBdPc/WLQV/g/qITkjlUphIsd3Dr/euKr0Gtl/gl7+5SDM1nlSP/djSiFsUX8mRXjb6U/AgmsbvMuhraC42NYa9fPSos7pMu7u6ExPPPk679yVgCPI7SSvtENrca67tIzBnWFeM4xJTMvU/6EomoxSPD11VOGtMNYuZ0+4NSipf9rysfjrDxSr8/b2KvKNYfTHM3wSbX4gWZyJru/8J4oYthoNZlkRk8ponc2f0gJwFb/BJHRobgOnzDFhb4LgLLQ98+Haf/eyDr5lXwcxA1B6yufG1KnxIsbKZ9YpLf26ejcW2Pe9TuGPubsP3dId4O0bwfyFV8yV2h/xLpuSLJ9cNSs1ltJHODGKuCnN3YbKOgjLAz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 22:38:40.2553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7581bd76-b61d-46cf-2b45-08de8475efe0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6880
X-Mailman-Approved-At: Wed, 18 Mar 2026 02:21:10 +0100
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

From: Randolph Sapp <rs@ti.com>

Take Phytec's current DDR fixup functions and utilize them to
dynamically adjust for variants in the pocketbeagle2. There are
currently 3 skews, two of which are both 512MB with the same memory
configuration, and one which is 1GB using the same CWL and CL settings
but a modified density [1].

Based off of Bryan Brattlof's patch [2].

[1] https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5411/8G%20Bits%20DDR4%20SDRAM.pdf
[2] https://github.com/bryanbrattlof/beagleboot/commit/fb2f022e27427e990d7a33fd001ffb571e13cfc3

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 board/beagle/pocketbeagle2/Kconfig            |  26 ++++
 board/beagle/pocketbeagle2/Makefile           |   2 +
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 112 +++++++++++++++++-
 .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 ++++++++
 configs/am62_pocketbeagle2_r5_defconfig       |   5 +-
 5 files changed, 192 insertions(+), 3 deletions(-)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h

diff --git a/board/beagle/pocketbeagle2/Kconfig b/board/beagle/pocketbeagle2/Kconfig
index e957b8e8377..a361fcebfc1 100644
--- a/board/beagle/pocketbeagle2/Kconfig
+++ b/board/beagle/pocketbeagle2/Kconfig
@@ -12,6 +12,7 @@ config TARGET_AM62X_A53_POCKETBEAGLE2
 	select ARM64
 	select BINMAN
 	select OF_SYSTEM_SETUP
+	imply TI_I2C_BOARD_DETECT
 
 config TARGET_AM62X_R5_POCKETBEAGLE2
 	bool "BeagleBoard.org AM62X PocketBeagle 2 running on R5"
@@ -23,6 +24,7 @@ config TARGET_AM62X_R5_POCKETBEAGLE2
 	select K3_DDRSS
 	select BINMAN
 	imply SYS_K3_SPL_ATF
+	imply TI_I2C_BOARD_DETECT
 
 endchoice
 
@@ -58,3 +60,27 @@ config SPL_LDSCRIPT
 source "board/ti/common/Kconfig"
 
 endif
+
+config POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
+	bool "Set the PocketBeagle 2 RAM size instead of detecting it"
+	default false
+	help
+	  RAM size is automatically detected through the device revision stored
+	  in EEPROM. This overrides the detection logic with a fixed value.
+
+choice
+	prompt "PocketBeagle 2 RAM size"
+	depends on POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
+	default POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
+
+config POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
+	bool "512MB RAM"
+	help
+	  Set RAM size fix to 512MB for the PocketBeagle 2.
+
+config POCKETBEAGLE2_AM62X_RAM_SIZE_1GB
+	bool "1GB RAM"
+	help
+	  Set RAM size fix to 1GB for the PocketBeagle 2.
+
+endchoice
diff --git a/board/beagle/pocketbeagle2/Makefile b/board/beagle/pocketbeagle2/Makefile
index 3d42c160716..dd529fe6d75 100644
--- a/board/beagle/pocketbeagle2/Makefile
+++ b/board/beagle/pocketbeagle2/Makefile
@@ -7,3 +7,5 @@
 #
 
 obj-y += pocketbeagle2.o
+obj-${CONFIG_K3_DDRSS} += ../../phytec/common/k3/k3_ddrss_patch.o
+obj-${CONFIG_TI_I2C_BOARD_DETECT} += ../../ti/common/board_detect.o
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle/pocketbeagle2/pocketbeagle2.c
index b6768caa34b..1bfc79350b6 100644
--- a/board/beagle/pocketbeagle2/pocketbeagle2.c
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
@@ -15,15 +15,123 @@
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
 
+#include "../../ti/common/board_detect.h"
+#include "pocketbeagle2_ddr.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static int pocketbeagle2_get_ddr_size(void)
+{
+	// check config overrides first
+	if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_FIX)) {
+		if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_512MB))
+			return EEPROM_RAM_SIZE_512MB;
+		if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_1GB))
+			return EEPROM_RAM_SIZE_1GB;
+	}
+
+#if IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)
+	// dynamically detect the config if we can
+	if (!do_board_detect_am6()) {
+		struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
+
+		if (strlen(ep->name) > 11 && ep->name[0] == 'P') {
+			/*
+			 * POCKETBEAGL2A00 (am6232 512MB)
+			 * POCKETBEAGL2A10 (am625 512MB)
+			 * POCKETBEAGL2A1I (am625 1GB)
+			 */
+			if (!strncmp(&ep->name[11], "2A1I", 4))
+				return EEPROM_RAM_SIZE_1GB;
+		}
+	}
+#endif
+
+	return EEPROM_RAM_SIZE_512MB;
+}
+
 int dram_init(void)
 {
-	return fdtdec_setup_mem_size_base();
+	if (!IS_ENABLED(CONFIG_CPU_V7R))
+		return fdtdec_setup_mem_size_base();
+
+	return 0;
 }
 
+// logic after this block assumes that there is only 1 DRAM bank currently
+#if CONFIG_NR_DRAM_BANKS != 1
+#error Unsupported number of DRAM banks!
+#endif
+
 int dram_init_banksize(void)
 {
-	return fdtdec_setup_memory_banksize();
+	u8 ram_size;
+
+	if (!IS_ENABLED(CONFIG_CPU_V7R))
+		return fdtdec_setup_memory_banksize();
+
+	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]));
+
+	ram_size = pocketbeagle2_get_ddr_size();
+	switch (ram_size) {
+	case EEPROM_RAM_SIZE_1GB:
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = 0x40000000;
+		gd->ram_size = 0x40000000;
+		break;
+	case EEPROM_RAM_SIZE_512MB:
+	default:
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = 0x20000000;
+		gd->ram_size = 0x20000000;
+		break;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_K3_DDRSS)
+static int update_ddrss_timings(void)
+{
+	int ret = 0;
+	u8 ram_size = 0;
+	struct ddrss *ddr_patch = NULL;
+	void *fdt = (void *)gd->fdt_blob;
+
+	ram_size = pocketbeagle2_get_ddr_size();
+	ddr_patch = &pocketbeagle2_ddrss_data[ram_size];
+
+	if (!ddr_patch)
+		return ret;
+
+	ret = fdt_apply_ddrss_timings_patch(fdt, ddr_patch);
+	if (ret) {
+		printf("Failed to apply ddrs timings patch: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int do_board_detect(void)
+{
+	void *fdt = (void *)gd->fdt_blob;
+	u64 start[] = {gd->bd->bi_dram[0].start};
+	u64 size[] = {gd->bd->bi_dram[0].size};
+	int ret;
+
+	dram_init();
+	dram_init_banksize();
+
+	ret = fdt_fixup_memory_banks(fdt, start, size, 1);
+	if (ret) {
+		printf("Failed to fixup memory banks: %d\n", ret);
+		return ret;
+	}
+
+	return update_ddrss_timings();
 }
+#endif /* CONFIG_K3_DDRSS */
 
 #if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
 int board_late_init(void)
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h b/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
new file mode 100644
index 00000000000..6d248ce6dfa
--- /dev/null
+++ b/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * DDR override logic for AM625 PocketBeagle 2
+ * https://www.beagleboard.org/boards/pocketbeagle-2
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __POCKETBEAGLE2_DDR_H
+#define __POCKETBEAGLE2_DDR_H
+
+#include "../../phytec/common/k3/k3_ddrss_patch.h"
+
+enum {
+	EEPROM_RAM_SIZE_512MB = 0,
+	EEPROM_RAM_SIZE_1GB = 1
+};
+
+struct ddr_reg ddr_1gb_ctl_regs[] = {
+	{ 317, 0x00000101 },
+	{ 318, 0x1FFF0000 },
+};
+
+struct ddr_reg ddr_1gb_pi_regs[] = {
+	{ 77, 0x04010100 },
+};
+
+struct ddrss pocketbeagle2_ddrss_data[] = {
+	// default configuration
+	[EEPROM_RAM_SIZE_512MB] = {
+		.ctl_regs = NULL,
+		.ctl_regs_num = 0,
+		.pi_regs = NULL,
+		.pi_regs_num = 0,
+		.phy_regs = NULL,
+		.phy_regs_num = 0,
+	},
+
+	// industrial configuration
+	[EEPROM_RAM_SIZE_1GB] = {
+		.ctl_regs = &ddr_1gb_ctl_regs[0],
+		.ctl_regs_num = ARRAY_SIZE(ddr_1gb_ctl_regs),
+		.pi_regs = &ddr_1gb_pi_regs[0],
+		.pi_regs_num = ARRAY_SIZE(ddr_1gb_pi_regs),
+		.phy_regs = NULL,
+		.phy_regs_num = 0,
+	},
+};
+
+#endif /* __POCKETBEAGLE2_DDR_H */
diff --git a/configs/am62_pocketbeagle2_r5_defconfig b/configs/am62_pocketbeagle2_r5_defconfig
index e863204cfef..d72f78b932c 100644
--- a/configs/am62_pocketbeagle2_r5_defconfig
+++ b/configs/am62_pocketbeagle2_r5_defconfig
@@ -14,7 +14,7 @@ CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-pocketbeagle2"
 CONFIG_DM_RESET=y
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
@@ -42,6 +42,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
+CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
@@ -73,6 +74,8 @@ CONFIG_SPL_CLK_K3_PLL=y
 CONFIG_SPL_CLK_K3=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DA8XX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_SPL_MISC=y
-- 
2.53.0

