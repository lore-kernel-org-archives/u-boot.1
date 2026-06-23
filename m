Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F64CD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B9384A0F;
	Tue, 23 Jun 2026 14:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1UdYqygS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4665684A12; Tue, 23 Jun 2026 14:54:54 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9FBD84A0E
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbzDGZ8XqOL5OcZpZn9gmpRrH2DGvC+STBNNF8FqCgfByK+ncS+4xVbNy+Uk5QYcxe+qgOeElezivD2/AxtykHwLR/tG3d+Mz/jasYBksMMzFkWpMnusVWKyL4IU1/v3TomHDMlhGEAEAHMM+Z4btWFNG3rSuzrZbWdU3rN7IgyKI49hKcMMtyeGNKjAeOjGld7jV+aT5UeEKDQ6t0aZUESrEa6yWtS+fvhB4Fm1VoUNv5Dn3/C572/7RicNqsAKxc5whKEvWI/t9UzjxiKMjB9vWR/u6oN25BvHFnCVLcHOyX6n1g1ttpIaSNlkpArrkd0/1QilucOwJVLLulaLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72CUS6epv7kQ75Pg9Uc7uT0s7EkZLUy4ebW3zVrDYG8=;
 b=eCXhTT3/0ujhBXal2Rh0bpyWYjX5VQXLE6xgbHhIwkyAqRBPgD/xyQMub/JO6BYrx6+29Mwi3EbVPY6saAlGb4RmhUvJTRW2WJ7XipKdS8e4dWjoGKfGi9jrAQq6RJdkqZSbajZWuX6TKNp0B1ZYafVXs1qhzyh06Zug4UnoiLkSV37D0XkcPkq+YZbpor/4Jkxju3qA1gLNkur/R2GP8c2GwLvMKAeEsu+kLqPqs/qusTSZ1yDO0EvmedFprcK4XmEZwl2acpqyY5culiHQCq0Fbv3lrcBClXXwqbEdP+OfxuSqI7foQmhWtB9BM8Y3iEnAVo3NnJvMxF4tziiIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72CUS6epv7kQ75Pg9Uc7uT0s7EkZLUy4ebW3zVrDYG8=;
 b=1UdYqygSUAmLzbNMqQthw7AAL/KVyytQfhEZc99fY9ttPVO5FLr79E2PlEzL5ydLys/+Fr0zMO6DatEKlEkqSA1TTEPQjv7L2KW0h1YPoH8DrPjZNYCcQG+jrH2lH6LqGXI6kQTs6rMBNcm7CvDNsIOcsMrd/4aL2V7QOdlO9FE=
Received: from CH5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:610:1f4::15)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 12:54:46 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::8c) by CH5PR04CA0009.outlook.office365.com
 (2603:10b6:610:1f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Tue,
 23 Jun 2026 12:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:45 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:44 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Francois Berder <fberder@outlook.fr>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 07/18] arm64: versal2: Move board_early_init_r clock setup to
 mach code
Date: Tue, 23 Jun 2026 14:53:32 +0200
Message-ID: <08e835a183c39de6f666375ac390eee6a8f3f12e.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4614; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Xlybc3KouUoqHj5eBibh+mf5Qy7isWotANB6inuLdKw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb6alh37N2vBTpVDmQq2yrvvsCTe4JoZ8nKxw+GAO
 jOBnY3hHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCR9HyG/44/J+0/v+mmxTFW
 GYP9Ow5byBklt99MZPAtvsyrVxJZ3MPIcHiBncDdW88frX+8pEnrxWGzH4e5m99kf1L7wq+uXjH
 3PwMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: e6833a81-6473-49c1-00a2-08ded1269a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|32650700020|36860700016|23010399003|82310400026|376014|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: FgTHWg0Fcbq/UhqVmESmdidCc3UNFS8IhF2IWV0pGY0TzCpdR0N6k1X9oYC2QHjftwPKY4rfrkw9jic4U+15li9iJD+le1spysdHE+09ZE2bNIRYE8LIvoy9d2YmBLDHBIp7tktkf50Qy93NH2h5fGCdNgX70qXJ6ooB48VyrprjiSsq2EH2mpN5eB5bdOpMEm7PDT/0ibUCNUCSMMNtOWdXJ8nz6GjaXAMQ2d2aZ4AbtoDE0dIz9KET5dRletg1rBB9ci+ZSeKTHbi3Mf0dtTYTqjbACitjr/ZjKJ5j71EGyXoy6qGSIpsf+1Ks+U8mkthVhohr7xmaugNC569u9+seeKNg24+HJAxXndTIGbMg/a51FmDeN5cbmPLlcWb9r7QwGQ4I0ASvTZaTQAKt8gijB8PdjWKXqyIuV05tEnJs8rTOE7PF54K7OQT9Ay88gDZc6+GwKQ6xGo5SkehYtNzK7pU9rhJsxIDQ2fg9wbv9t5AEWBqjCduEr8Hcz+M4UC+OScYVUvmQV56SYCwv+m5l7+Mj+TiINguog/XQF/R3qNq67RTDhZgGbjQAI6F6KFIOKBauyto4H0Rrpfi77jCMErz45Yq0F32Xnht+WGF6+Va5kSKAJ6WrOFFHGp57iTk63YQTH68QLGN/46pmKUrFUtEN3x9+Ar/AjD7sy1eUxBI4G4XbuZC2gOSF71KCAmd75Kao6V0j+uvU4PWBRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(32650700020)(36860700016)(23010399003)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5gcMYNyn06qqVa0/ba0rrQjRS5NvmVBCsw2PD2Oagfb3uF4UPSbj8/TJVYCUP+AW4rmkK8SIyOureIuzmSK97hPrkSWPMpGpUojonbQM+nK6X8BduYqGilBXODENxKsMe0/xbRbWFDje/mSUHJds1CcZEp3p5NcwoLJ0t+zt3E3AvyRRH7LY08GY9w8pvtb+8OcTuEmRrfFE4899JqTQfNhmVCmUV63s+o+u7qdfLlYZ7Ujeu0bb0iBGUZdO7BQw1MElKWofZ/SB9ldLnYGOdGFZ4bbMZxrwttMYcvXGXP8x1NRaTrWQ925hUz+PMnqI0tX32Y9Hx5mbFlxOZ/xBRBaBHgMxqZp/jluYGjoZluARFv8+wLmhXqf3RLQ52R09tfPOTdxahCf+OboMijBgqmUzQR4Znyxu5cKvr25Xq5pLTtgmG9BXVs+ybPlyDzcv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:46.3103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6833a81-6473-49c1-00a2-08ded1269a77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852
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

board_early_init_r() programmed the IOU switch clock and the system
timestamp counter directly with readl()/writel() in board code. This is
SoC register setup rather than board policy, and the same block is
duplicated across the Xilinx SoCs.

Move it into versal2_timer_setup() in arch/arm/mach-versal2 so the board
hook only keeps the EL3 guard and calls the helper.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/cpu.c                   | 43 +++++++++++++++++++
 .../arm/mach-versal2/include/mach/sys_proto.h |  2 +
 board/amd/versal2/board.c                     | 38 +---------------
 3 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index c278dc3d3be5..d28c0e131711 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -7,6 +7,8 @@
  */
 
 #include <init.h>
+#include <log.h>
+#include <time.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -153,6 +155,47 @@ u8 __weak versal2_get_bootmode(void)
 	return bootmode;
 }
 
+void versal2_timer_setup(void)
+{
+	u32 val;
+
+	debug("iou_switch ctrl div0 %x\n",
+	      readl(&crlapb_base->iou_switch_ctrl));
+
+	writel(IOU_SWITCH_CTRL_CLKACT_BIT |
+	       (CONFIG_IOU_SWITCH_DIVISOR0 << IOU_SWITCH_CTRL_DIVISOR0_SHIFT),
+	       &crlapb_base->iou_switch_ctrl);
+
+	/* Global timer init - Program time stamp reference clk */
+	val = readl(&crlapb_base->timestamp_ref_ctrl);
+	val |= CRL_APB_TIMESTAMP_REF_CTRL_CLKACT_BIT;
+	writel(val, &crlapb_base->timestamp_ref_ctrl);
+
+	debug("ref ctrl 0x%x\n",
+	      readl(&crlapb_base->timestamp_ref_ctrl));
+
+	/* Clear reset of timestamp reg */
+	writel(0, &crlapb_base->rst_timestamp);
+
+	/*
+	 * Program freq register in System counter and
+	 * enable system counter.
+	 */
+	writel(CONFIG_COUNTER_FREQUENCY,
+	       &iou_scntr_secure->base_frequency_id_register);
+
+	debug("counter val 0x%x\n",
+	      readl(&iou_scntr_secure->base_frequency_id_register));
+
+	writel(IOU_SCNTRS_CONTROL_EN,
+	       &iou_scntr_secure->counter_control_register);
+
+	debug("scntrs control 0x%x\n",
+	      readl(&iou_scntr_secure->counter_control_register));
+	debug("timer 0x%llx\n", get_ticks());
+	debug("timer 0x%llx\n", get_ticks());
+}
+
 U_BOOT_DRVINFO(soc_amd_versal2) = {
 	.name = "soc_amd_versal2",
 };
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index b3118c208e8f..b8d12d1dd3bb 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -19,5 +19,7 @@ u32 versal2_pmc_multi_boot(void);
 u32 versal2_multi_boot_reg(void);
 /* Weak bootmode decode (MMIO default); a firmware/SCMI build may override */
 u8 versal2_get_bootmode(void);
+/* EL3 clock/timer register setup, called from board_early_init_r() */
+void versal2_timer_setup(void);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index c4e88440d64e..7f2fb4c1ec63 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -132,46 +132,10 @@ bool soc_detection(void)
 
 int board_early_init_r(void)
 {
-	u32 val;
-
 	if (current_el() != 3)
 		return 0;
 
-	debug("iou_switch ctrl div0 %x\n",
-	      readl(&crlapb_base->iou_switch_ctrl));
-
-	writel(IOU_SWITCH_CTRL_CLKACT_BIT |
-	       (CONFIG_IOU_SWITCH_DIVISOR0 << IOU_SWITCH_CTRL_DIVISOR0_SHIFT),
-	       &crlapb_base->iou_switch_ctrl);
-
-	/* Global timer init - Program time stamp reference clk */
-	val = readl(&crlapb_base->timestamp_ref_ctrl);
-	val |= CRL_APB_TIMESTAMP_REF_CTRL_CLKACT_BIT;
-	writel(val, &crlapb_base->timestamp_ref_ctrl);
-
-	debug("ref ctrl 0x%x\n",
-	      readl(&crlapb_base->timestamp_ref_ctrl));
-
-	/* Clear reset of timestamp reg */
-	writel(0, &crlapb_base->rst_timestamp);
-
-	/*
-	 * Program freq register in System counter and
-	 * enable system counter.
-	 */
-	writel(CONFIG_COUNTER_FREQUENCY,
-	       &iou_scntr_secure->base_frequency_id_register);
-
-	debug("counter val 0x%x\n",
-	      readl(&iou_scntr_secure->base_frequency_id_register));
-
-	writel(IOU_SCNTRS_CONTROL_EN,
-	       &iou_scntr_secure->counter_control_register);
-
-	debug("scntrs control 0x%x\n",
-	      readl(&iou_scntr_secure->counter_control_register));
-	debug("timer 0x%llx\n", get_ticks());
-	debug("timer 0x%llx\n", get_ticks());
+	versal2_timer_setup();
 
 	return 0;
 }
-- 
2.43.0

