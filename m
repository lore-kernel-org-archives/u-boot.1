Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741DFCD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10938464D;
	Thu, 14 May 2026 12:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s1Q0uo97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 000EF8464D; Thu, 14 May 2026 12:34:53 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894408465A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5XCfx4hupAMVOngTqgAW0zbC+UVedxREJ1OKjxU+GznHAP20ydknqmfursIauyaQX0CAtDqpcFChYJ23xWLOk631mCcSlGcAh9SWwHI4xrrd7OmeflRLMGwqs49XvFElSxL14YD+Bc8yQgtYjxSbB67H5D4tKShzxfZt0m03Kg08G8I6aycbt6QdjfDs83RTtI3r5227AC8ebeoxShjQ0h8IO3amsejdC5E3Lx+LEUBwtie6vEiNTFRRK3rwIu3i495CT9kZbWqc9g0lqxV8f/FGe58liIjYUnz1H+5PBFClkeQycIwvM0fpohzdlZUArvbV+vAj1IZGs43LCADDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4JF/tRA3x67DIprH0ZXyJn/ViRGf9IPOCZ7XIwzKz8=;
 b=uk9CLhedWHCq7Hg3xgJnsP4B6PgPxIVInwuEDmtVv+csBaqcGwCdIBLlclLM0xpggGt6d3I+AoaMEZWXydnYCc3IdHnzNLnwYUFF9c0+S+v3ucs/w4433LJwvgf9APLbG12iMh8/WV1eOoNw7+L+91jMFpaJQ7oDYTbSnO6J0LPhZqYKy/Gy0V/SYCg9bveEolXwV4RM9uWhQ3dkNACoZSZKJpfw4tupRaB0Bsv4fSHyGxrXgYHVtogx98E9JGKTRQA5xAfU+42IwrWQDNnSWWWuQOzz4w8RvGhSowpxdEhMJO6rnNGP5ZRHj9oHrJFrowJTYKn6KoW7yrGYSFI0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4JF/tRA3x67DIprH0ZXyJn/ViRGf9IPOCZ7XIwzKz8=;
 b=s1Q0uo97ZRNvDNpSV1mpy3yp9Q60tjm+gFJ+rLiZRlVMfxld9iEzWxUseKyWOqnJ+X3dqfcAv+OpNQ4Vq2wN6zEAZTWmhf0d5WmvcehWoRpJZtE73uYutxPftYVj05/uNCJBaOxzm5nDCKOHnTTVfSI8+NWsewVdNeE4htlQ3No=
Received: from CH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:32::7)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 10:34:47 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::43) by CH0PR07CA0002.outlook.office365.com
 (2603:10b6:610:32::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Thu, 14
 May 2026 10:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:34:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 14 May
 2026 05:34:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 May
 2026 05:34:45 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 05:34:44 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/7] board: xilinx: Add FWU boot index support
Date: Thu, 14 May 2026 15:52:22 +0530
Message-ID: <20260514102601.1759779-6-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514102601.1759779-1-padmarao.begari@amd.com>
References: <20260514102601.1759779-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6e8a0a-0c1b-4134-4043-08deb1a46bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: XSnQJtspgZgKsfsC1UZzy3+qnXHHFOTkfPqIDUo4H4+LcKViZaVnEzNLGOuTl4vsIooU9nqr17SlZI8k9C27pJLf/H1rwQSBn7zlS/wFWtuf17RKuSGdL8IwaTGzGYFpS9EYs3dzHJkZyKuYUcAcPIeG8QdZB4JbTD7/AS/uAbkG0Ro2mt4IBPn++evwURyW4WwlyDCidZS76KKwLuyc685VcFIhcvfn7EKTujYqKvWysV3WqWPw+SUmvLq8lx6j9jf2qTiOdGvZg3Z9iQMv7sjk9Vp6zZURGcO5OovCtAaKbjTU4eIlctiKPdbMu/pTsC9lfTpR7xhH9xpVl1USD51oCt1h0mYZwJ7NYXehe3PfWBPbaFxjpTNIWT5yrmm8g+ZabcWmsIJGbyWFMk++VXmv43CXfoBpH80QrtccXCxx+q/n32/AlHYr/nsWoEfTZw1TzI/O6T5yd+Uz+kV/xXTPwnJ0QNXA83G5yaYT9TgDQpFOX1ShVe/7Vg2elPJsIuRSuCsPg+EQVDn4aTVaZDa/XAa0Ie7v2POsVDXA3V/WLM8USYe4OcKbndcmP1lajTmz1IeWbHG143vaK4Ra5Ts9vN/QcbzXCBxeCQYx+GTDzphUdcCcyLHcFhAWwmqMosVX6kbnqY/sIn9Of27B0OKmWMSHEg6NyRv3pNKkN9ROc6Qpsug+8CguNimK05814AvlyuyfeTzWo2kxZ35MDHQ7QPyxkbA2o2LzxPBfn+k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lJKvHTsBWhHZYR8dEDnBd+SDYCjGyX5L8vl2k2Brhw41IZ8f3q/+dkom950EunUI4RVs9KF/ImdKI2kLyMmYMKsPoCv5Gnjb2kelNrDHSLjh4dGZORezQMT1SsQPKBkJindZlWOQ50mRRHGXHkcTnQ4KHP2FtnXkum9Wb4bPAZsFy0F17V9t1ztM4ucnaymV9snsPzPQ9gjSul6BUkoPAqb1N2UuccSDYV1tyQLBqAr4a9E9sIl0Go/c2SPFCuTWwgzsLF/SbC6wkg2/u3wBaEiVdZ6ecUwRKmgSGjoqRUsqqaYMmlJ1twbfAoApVGVSymZdBHfOdJZ1t+JE2ExAPJMwJ7sp82ApabyBnw7XVn940zbjxeuFFeoPAXv/8NoxBE5zx91WDxXa8/zCuQ+3boD8PxG1bFzFlBfkmfN+Ns6ng684+rENb6s6P4t4daig
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:34:47.6756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6e8a0a-0c1b-4134-4043-08deb1a46bf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790
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

Add fwu_plat_get_alt_num() and fwu_plat_get_bootidx() platform
callbacks required for FWU multi-bank update on Versal and Versal
Gen 2. The boot index is read from the PMC Global PGGS4 register
which is populated by PLM with a magic number and boot partition
index. Uses firmware IOCTL when CONFIG_ZYNQMP_FIRMWARE is enabled,
otherwise falls back to direct MMIO read.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/xilinx/common/board.c | 73 +++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 89562ef77fc..52a2e8767d8 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -14,8 +14,12 @@
 #include <init.h>
 #include <jffs2/load_kernel.h>
 #include <log.h>
+#include <asm/io.h>
 #include <asm/global_data.h>
 #include <asm/sections.h>
+#if defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL2)
+#include <asm/arch/hardware.h>
+#endif
 #include <dm/uclass.h>
 #include <i2c.h>
 #include <linux/sizes.h>
@@ -30,6 +34,8 @@
 #include <rng.h>
 #include <slre.h>
 #include <soc.h>
+#include <zynqmp_firmware.h>
+#include <linux/bitfield.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <u-boot/uuid.h>
@@ -718,7 +724,74 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 
 	return reg + size;
 }
+#endif
+
+#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
+
+#if defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL2)
+/*
+ * The Versal and Versal Gen 2 PMC Global pggs4 register contains below
+ * information in each byte as:
+ *
+ * Byte[3]: Magic number
+ * Byte[2]: Boot counter value
+ * Byte[1]: Boot partition value - boot index
+ * Byte[0]: Rollback counter value
+ */
+
+#define MAGIC_NUM	0x1D
+#define MAGIC_MASK	GENMASK(31, 24)
+#define BOOTINDEX_MASK	GENMASK(15, 8)
+
+static int plat_get_boot_index(void)
+{
+	u32 val;
+
+	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
+		val = zynqmp_pm_get_pmc_global_pggs_reg(PMC_GLOBAL_PGGS4_REG);
+	else
+		val = readl(PMC_GLOBAL_PGGS4_REG);
+
+	if (FIELD_GET(MAGIC_MASK, val) != MAGIC_NUM) {
+		log_err("FWU requires PMC magic number 0x%x\n", MAGIC_NUM);
+		return -EINVAL;
+	}
+
+	return FIELD_GET(BOOTINDEX_MASK, val);
+}
+#endif
+
+int fwu_plat_get_alt_num(struct udevice __always_unused *dev,
+			 efi_guid_t *image_id, u8 *alt_num)
+{
+	int ret;
+
+	ret = fwu_mtd_get_alt_num(image_id, alt_num, "nor0");
+	debug("%s: return %d\n", __func__, ret);
+
+	return ret;
+}
 
+void fwu_plat_get_bootidx(uint *boot_idx)
+{
+	int ret;
+	u32 active_idx;
+
+	ret = fwu_get_active_index(&active_idx);
+	if (ret < 0)
+		printf("%s: failed to read active index\n", __func__);
+
+	ret = plat_get_boot_index();
+	if (ret < 0) {
+		*boot_idx = 0;
+		printf("%s: failed and setup boot index to 0\n", __func__);
+	} else {
+		*boot_idx = ret;
+	}
+
+	debug("%s: boot_idx: %d, active_idx: %d\n",
+	      __func__, *boot_idx, active_idx);
+}
 #endif
 
 #if IS_ENABLED(CONFIG_BOARD_RNG_SEED)
-- 
2.34.1

