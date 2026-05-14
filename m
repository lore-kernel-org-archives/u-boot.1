Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF43CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887D88465A;
	Thu, 14 May 2026 12:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EyZZFka8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C2F584669; Thu, 14 May 2026 12:34:20 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2D358464D
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5dM68+f2Ok5Igfp2BMPVHzWYF4DuEGfk8s84l76fGAb0zs0YtoS2IccxZyuAqQeTYohM8PFRVX3e+vfplArxwlsOE9kFAEaojAyVu9cgzQgS8CkCgvRuETb2cEEy3rXOyHnGsrE2W7RMqbp1cVCcFElsKLDzc6OrLHaziKe+Dbhrx4Cl2pf1Hm+nDCLonKaVgEbhciTH5VanQaHQUhB8p6S+VHEEovLGocALaXumVKcIMLsidLLAzNvj1PxPKl/cxKeMwzVI8MqSpb6ve4m1LVnw2zRE5ageA+7bJneiS0uYemdWKLkzjoSHzG1FeyD8ZzYmO/rTUtzaIrAdnpKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02migCgR834mjIjh6ONBhx/8O0p6OjSZoDcNqggYfvI=;
 b=VKAP2kcp56FfMtcJTkRTRYWOjfcOekCMAW6llcVCx5nUWRNNFqm4TT7OjA6nA+nDg4hb8HpJYdsuHEf/X/FSKYWm9jqCVN0/iCTTMs5jWh9m55344UR4kdpDRX5roMGykxN0CHWC7J32D1W/fv9Jb0a7KJyHWC/QGfGWlfCdOiq0DK5cjxZEl0oDt+dOF6dIMyGn4F/H+VLTmiw1izymszEOqXEom/xt3DWkR92XX409uO3zfykq9PzxWb47VSSsS2mjmUFAILhOvTXsTNDjMuPctxDQOkpcFId7FK89D/RJ2Y6z6+oVDswZr1dh7ZqM3xFprcH5C6rOCk1mPD2ClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02migCgR834mjIjh6ONBhx/8O0p6OjSZoDcNqggYfvI=;
 b=EyZZFka8S+aogsFWpEKjErhrcJFB6gRHFS2q5EYPainks9wid1FuAYSF0uteVst2lFauTVn8ksnSodefmnzZlTsqP2B/sLQFv5Drhw+b4h8QQqo1aMC5EyTT7B3MHT9yWHFZwM5rrVXyn1/QMbc8cBRC3Tod3hc6jwfkuv7v5Qs=
Received: from CH0PR03CA0259.namprd03.prod.outlook.com (2603:10b6:610:e5::24)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 10:34:10 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::24) by CH0PR03CA0259.outlook.office365.com
 (2603:10b6:610:e5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 10:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:34:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 05:34:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 05:34:06 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 05:34:04 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, Pranav Sanwal
 <pranav.sanwal@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Maheedhar Bollapalli
 <maheedharsai.bollapalli@amd.com>
Subject: [PATCH 4/7] board: amd: Add capsule and FWU support
Date: Thu, 14 May 2026 15:52:21 +0530
Message-ID: <20260514102601.1759779-5-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514102601.1759779-1-padmarao.begari@amd.com>
References: <20260514102601.1759779-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: c938573a-84ec-44c6-1942-08deb1a4558b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: hs5P2VDgLqEDOhzTvytaqvt0Iqi1mL4x1s5/hNg6l4Mx5jMXrRaYHjHjf+vP+ZQuY8enu2ex3o5gFzzN9j1QXQCj0SwdpAOeor5LCQ7HOnpYBqHaZVTlSGvUzQgeXPxLB64s1ksGZmmycJ5pGTJQ7EmuvUvHsHwkKP+wabSGVEyQgFFbfmm4IPn72qoshTaS64/pKOlKNm9GYok5iiIRBiN7AhjtIeIJFAdeQ64ERZ5EpY2UMI+XlDezRJxPHGSwpC+zQO1k+bbteImbzqltdGz4k/sJCeuJH9fZjvdrbgEfKwB6+X6vJ5MDeBBdVD/Hj9Ayzs0PFiUNYj68kRciM6TBY/oJj2RdKzg17enl++dEfoIqpyypxObG2ALb8lc5aKI1hGoXq9eL/hPhaGGH7UJU+LK8VrDNJjG/4WU8Gh+TM/TL1WCrRIAJ2N6yqbYLo7Nhk1liHAHLTkrsze+vtRFYL/GBKJNWeCRPPy3Snh2zntrB62U2MZIm8l+t49fbCdyJZj7JTQxmGEiI28LVRDDOBr9dHnvgC/PA3rvgL0Mi0r1X1fZeSPXM4mndKSNyKrXMGLSeUpaaNdtz9/98JhE2rTs5q/ySeCb6mzFO+U4a6lKKrUNYzzHCMM9ahnwFgDF0H8snVf/2V9nwCGsjdYuv6pImQRjGaPJ/u801GlmS8hKOlfyWbwXBUC9SmsfinO2fKxoUbJSzGHV6utVi2jUDXPzbzPJZKa+KaR0fxdY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vqttOqZwXJ7PH4gNZcUb3wpTi7yPckAs21Uwze3ixg0fxuN7zCiw4gm5TUPtHp0HiQe/YFwScA+Pmhuu/zIXXCB7wBWvFnRz58JQ1t6mV1/NfhroadQ6s90vILe1fc8XSyCaGOw0jcncTIFQBNryyYWQItGAwupv3zFcPjmWGIQE40zTwcLC/Ng4omhWCmAgnAydKmyl2uuCqQPdxdNZiDqPJ/sYwdJgR7n+BJtHRbjG/+la5483MQrP80JWMPSgxojpnrIF0kEh7nR+KpKNke1Bakw7Fkl3u1ZW0GPIJBICRt38E8wkRfcOoFhEiLOg22xkI5tj5YiKINOr+WHHecb0TpOQKk1nwpe3CWOfCfjKhZZWN1LK1flU/3Kwd2x/gBa+PZmL3vU34Bhaii0vf0w5Vdbw58f3rX9HHsrXyiZ5x3d7BxDRMOtf3viHXKFY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:34:10.0795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c938573a-84ec-44c6-1942-08deb1a4558b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

Add configure_capsule_updates() supporting MMC, SD and QSPI/OSPI
boot modes for DFU string generation. Add set_dfu_alt_info() for
FWU multi-bank mode to generate DFU alt info from NOR flash MTD
partitions. Add XILINX_BOOT_IMAGE_GUID for the capsule updatable
firmware image.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/amd/versal2/board.c     | 131 +++++++++++++++++++++++++++++++++-
 include/configs/amd_versal2.h |   5 ++
 2 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index d94c1494d53..4e68efc6416 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -1,17 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2021 - 2022, Xilinx, Inc.
- * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
 
 #include <cpu_func.h>
+#include <dfu.h>
+#include <env.h>
+#include <efi_loader.h>
 #include <fdtdec.h>
+#include <fwu.h>
 #include <init.h>
 #include <env_internal.h>
 #include <log.h>
 #include <malloc.h>
+#include <memalign.h>
+#include <mmc.h>
+#include <mtd.h>
 #include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -26,6 +33,7 @@
 #include "../../xilinx/common/board.h"
 
 #include <linux/bitfield.h>
+#include <linux/sizes.h>
 #include <debug_uart.h>
 #include <generated/dt.h>
 #include <linux/ioport.h>
@@ -347,6 +355,10 @@ int board_late_init(void)
 	int ret;
 	u32 multiboot;
 
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
+	    !IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
+		configure_capsule_updates();
+
 	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
 		debug("Saved variables - Skipping\n");
 		return 0;
@@ -475,3 +487,120 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	}
 }
 #endif
+
+#define DFU_ALT_BUF_LEN		SZ_1K
+
+#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && \
+	!defined(CONFIG_FWU_MULTI_BANK_UPDATE)
+static void mtd_found_part(u32 *base, u32 *size)
+{
+	struct mtd_info *part, *mtd;
+
+	mtd_probe_devices();
+
+	mtd = get_mtd_device_nm("nor0");
+	if (!IS_ERR_OR_NULL(mtd)) {
+		list_for_each_entry(part, &mtd->partitions, node) {
+			debug("0x%012llx-0x%012llx : \"%s\"\n",
+			      part->offset, part->offset + part->size,
+			      part->name);
+
+			if (*base >= part->offset &&
+			    *base < part->offset + part->size) {
+				debug("Found my partition: %d/%s\n",
+				      part->index, part->name);
+				*base = part->offset;
+				*size = part->size;
+				break;
+			}
+		}
+	}
+}
+
+void configure_capsule_updates(void)
+{
+	int bootseq = 0, len = 0;
+	u32 multiboot = versal2_multi_boot();
+	u32 bootmode = versal2_get_bootmode();
+
+	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
+
+	memset(buf, 0, DFU_ALT_BUF_LEN);
+
+	multiboot = env_get_hex("multiboot", multiboot);
+
+	switch (bootmode) {
+	case EMMC_MODE:
+	case SD_MODE:
+	case SD1_LSHFT_MODE:
+	case SD_MODE1:
+		bootseq = mmc_get_env_dev();
+
+		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=boot",
+			       bootseq);
+
+		if (multiboot)
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+					"%04d", multiboot);
+
+		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
+			       bootseq);
+		break;
+	case QSPI_MODE_24BIT:
+	case QSPI_MODE_32BIT:
+	case OSPI_MODE:
+		{
+			u32 base = multiboot * SZ_32K;
+			u32 size = 0x1500000;
+			u32 limit = size;
+
+			mtd_found_part(&base, &limit);
+
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+					"sf 0:0=boot.bin raw 0x%x 0x%x",
+					base, limit);
+		}
+		break;
+	default:
+		return;
+	}
+
+	update_info.dfu_string = strdup(buf);
+	debug("Capsule DFU: %s\n", update_info.dfu_string);
+}
+#endif
+
+#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
+
+/* Generate dfu_alt_info from partitions */
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	int ret;
+	struct mtd_info *mtd;
+
+	/*
+	 * It is called multiple times for every image
+	 * per bank that's why enough to set it up once.
+	 */
+	if (env_get("dfu_alt_info"))
+		return;
+
+	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
+	memset(buf, 0, DFU_ALT_BUF_LEN);
+
+	mtd_probe_devices();
+
+	mtd = get_mtd_device_nm("nor0");
+	if (IS_ERR_OR_NULL(mtd))
+		return;
+
+	ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
+	if (ret < 0) {
+		log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
+		return;
+	}
+	log_debug("Make dfu_alt_info: '%s'\n", buf);
+
+	env_set("dfu_alt_info", buf);
+}
+#endif
diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
index fccc786219f..a07e12bd146 100644
--- a/include/configs/amd_versal2.h
+++ b/include/configs/amd_versal2.h
@@ -23,6 +23,11 @@
 #define CFG_SYS_BAUDRATE_TABLE \
 	{ 4800, 9600, 19200, 38400, 57600, 115200 }
 
+/* GUID for capsule updatable firmware image */
+#define XILINX_BOOT_IMAGE_GUID \
+	EFI_GUID(0xed9e7fcf, 0x47b3, 0x40cd, 0xb6, 0xe3, \
+		 0x56, 0x5f, 0x14, 0x67, 0x6d, 0x82)
+
 #if defined(CONFIG_CMD_DFU)
 #define DFU_DEFAULT_POLL_TIMEOUT	300
 #define DFU_ALT_INFO_RAM \
-- 
2.34.1

