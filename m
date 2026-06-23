Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A7BCDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 423C984A1E;
	Tue, 23 Jun 2026 14:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FQSMXp/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59A2F84A12; Tue, 23 Jun 2026 14:54:52 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE6184A1E
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5rV/yxrZWE5jhWuC1W3acm61Qw8OYknudGZScCJ6MYKEV3raBMUiUSnExon4AnZhHl9V0Q8Ze0jryI3N3fRPv5eGihHZwHBjyXWiscIbduYGbQvOeG1JMcdE1e0MdR1U58qjJTlcIiIshaK8X+66VLFGQUU4lO8ov68Gd9vCewWYh5kvNiXiU6xiU0Jt7g7ekBZaw8H1M008S5YvmNsw95IiUoWM4vD3fLr8ECVTzcSrIq3tvJxCLemBO3xlpfe+YKeBbIsWjTcCJYDH8o9kqBab5TEenH+p5Yo+cK6vFNCWQpUqiK7vFhmv/8nPPwnkRY6QjqBwLFhbc2hGBF/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBlblBzDN/D6o35O7Q0Ghs061EjGp/PxNwyW7prxLFs=;
 b=cJjjrR0EI5Rv4VNcVp0xAOjzkN5mVrbe7mTAPB38O6+LIjHV7jQYfrq6ZeF0M8O495RPAIlZyQ2UfCYvzp9pOJc+rlU1rtHG5LcPiA/ru83NQpir1Dc+uNE5fqe1999WgoXD704o3DLZuB7kXQ+Jof52U5QqQYNeDYRtb1ddgY2O73appfTKHQ5r7C+tR1MtCBIlaTMSiz48vBZ4qIKujSMZd9eszLWZLv+qlrKZIAR0wpibPS+K+00Aj42ZAsQ22jTOGhdHtRK034/VNtZTjYArkmVD/dEcI4WOy0nKks6P65sKiBgm9IEFjSfx6zW86qT7uYJso/oljXn1bDwnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBlblBzDN/D6o35O7Q0Ghs061EjGp/PxNwyW7prxLFs=;
 b=FQSMXp/+yDr8T3sLarywxoZS/yvQrCKsUgfhanp4Mok1Niaj6dm5KFvbGmNj7D+YxreJh3fBXikGZ/Cg5g7E0NXwLbIV+JPBGd0i+zW72kAO+gi4VK2NoAJEVvffI6kBYO+1sP1xruAUVzycTRxBaXBf8BZ5AOTPFMCUuTEKaa4=
Received: from SN7PR04CA0218.namprd04.prod.outlook.com (2603:10b6:806:127::13)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:54:43 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::9) by SN7PR04CA0218.outlook.office365.com
 (2603:10b6:806:127::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 12:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:41 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:41 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/18] arm64: versal: Move board_early_init_r clock setup to
 mach code
Date: Tue, 23 Jun 2026 14:53:31 +0200
Message-ID: <2234d746ab5b8240e88b1a629d51f93751ee3b60.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4616; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=g7XPnF/lIKLUyl23ibMIlVAi8npiTUJIw89mwXxStyo=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb7U2L9s9e0sJwsfpnJ1jyMHzs3daf9KVSRH8fUPP
 RHPfadudZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEzjMw/BXt37A28XrPv39n
 HusWsr2bskM5j9Xb5l8Vu1n8jhnxPfcYGY5Wb+Bqmbn3ea6ubMfBoI75JSxlUw8lBbAfsf76/S/
 PVU4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 1605ec25-85af-4a69-ffec-08ded12698a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zzzzc3kTAVe+ZG4B9N63vIohM4+oc9Bpx/31Pse+HFFiad16vI9yMiEPWHMzPyd+qB4HUF/66skzBqWl1htqZGGb6e3SpTacmzOsJof2XGhP16XQkiTqL0Tbh9hVdlCm70/wU6U/KpyOHbIzNE2YwKIs9GQeTcrbx4+t/ohHhgQ8aoyzoAKcEkrlIPJDGHL65nKuKazzTUPqPuMKroZ4HIOPwQ1AvXIvz2GSHFmi1pSmdD0MoT7b9oayc+fi5PryP5dDi0P1WBkFPF+92i1o0pF9MFe+ptXIDTZFV9zJAWSqwEUnEq4Cfs/NNTksOXfyMLTn1wc3iQniQamGJo1ROL3GkQSU776UENUfZj3XxcBLd4Ii4TeXs1QUyzo5x8qlw4a8d9ptpL93aWVekkPWCUZXD39KDhJdtyJtfyROXfvyn0icPYP2qWBF3A+lYNvBjdDWXOEE1LMlyNo2qVrjtaPuji8hFy+y0ciAWf1tPkGtAoxboxVe2o6k4bmEotb7WLM8bSWQdru56BysuTV2heDiIpRpBBjD6UDt8jhiSepsTKBSG5J3C388OLSIayQ+vk3dv0896Z2BF11CUbQMZ89b0p9s3LujfKPbDHs4Bbso2FewpBF2YAm4h6KnkCXOJ4efN3bgz679C2xuf+AiyjQ6Tz9iZzIOKkGhcoFkOtrbqhhyJBsJnSNtRIZjGnM/vBHlY0TJ2Opq9CMPwzRlbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bZ2QPTToLou86v7OyMVwI1qLZriZYsSZAo1oO9CfJMxfMZf2Oo6w8umL7sxnROYSJAzn3hJHI2uRg3OFC7JalwE05X2XgTSO0XIhhayTIUABI5kCHZSXQbDHn3rAifCVBOgqUwbWsMR0CHIFTYuMMdcuTsBkVNGswTQW9xWd7SMPBYziaKnGhcrc5eT+O25jx8dwMwgKG9DV0QiUwqMbRhIKEcGI/jZ/lERoOndFHDh74ebVyCslu9L7iUBBEkfswug0RqVOhG/fz8oQvRXsQTVdBG470V66ZFMeM39widPfcATckUZOSMpT9y+5mc830TmDjatpjfBZk7ZG2TCW5Kvp7oA8WPxOe0ifmo55m3dayc6BjFOnGVjmtqBPuaqxle9V7HL+78hJpIEBK92HMleE0EGNbqki5r5rUFIpVlAUsQiP+iEEVPWh2v4Bhs4+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:43.2648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1605ec25-85af-4a69-ffec-08ded12698a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
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

Move it into versal_timer_setup() in arch/arm/mach-versal so the board
hook only keeps the EL3 guard and calls the helper.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal/cpu.c                    | 43 +++++++++++++++++++
 arch/arm/mach-versal/include/mach/sys_proto.h |  2 +
 board/xilinx/versal/board.c                   | 38 +---------------
 3 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 2a2b683b1fd4..76cf3181e28c 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -7,6 +7,8 @@
  */
 
 #include <init.h>
+#include <log.h>
+#include <time.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -120,6 +122,47 @@ u32 __weak versal_pmc_multi_boot(void)
 	return versal_multi_boot_reg();
 }
 
+void versal_timer_setup(void)
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
 u32 versal_bootmode_reg(void)
 {
 	return readl(&crp_base->boot_mode_usr);
diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
index f8836db5ef05..cb373e6fad91 100644
--- a/arch/arm/mach-versal/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal/include/mach/sys_proto.h
@@ -25,5 +25,7 @@ u32 versal_multi_boot_reg(void);
 u8 versal_get_bootmode(void);
 /* Direct MMIO read of the bootmode register (EL3 / no-firmware path) */
 u32 versal_bootmode_reg(void);
+/* EL3 clock/timer register setup, called from board_early_init_r() */
+void versal_timer_setup(void);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index d0c15fed1e93..0537517b1b2e 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -68,46 +68,10 @@ int board_init(void)
 
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
+	versal_timer_setup();
 
 	return 0;
 }
-- 
2.43.0

