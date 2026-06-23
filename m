Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D5ECDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45B084A3C;
	Tue, 23 Jun 2026 14:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rFTK+QV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3004849F7; Tue, 23 Jun 2026 14:55:00 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3232849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNxSf0QJZCRML0SI4kqOcoQ69mcRzkl+ObxUWNCP9knDQDlQDABWSfAKKRWLzNvDeK8KrEyvmq1x8OQ3+Hap9FF3A0z2yEEGnu9oD4wpb+PjH4e3SPAhJpvXOtbn5e6uEWY1cuhRf6rkm5yG/GNzJBtJHhud41lf1IkWV6ALdsbAilnPVi/5fKFtgf1cwerklrUux9GA1YLxk0TlgrkRxDG6XfjupgpDz9evnvjmXaCmvtHq2bLVpfrJRfP5uEnNIkp7AXNrmMeH215otS0ihcrZgayzUoHZoqe/hY95bBzCk5Y8Ckx+0DW3Cy5apUeHy9+rhKif6nzNXWcOcACt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXPFrnZYiXkfOItdZFwmWyanqMdRk6w8T18StovAHgU=;
 b=cN49sgyD8mRXZ/Fu1TsoTdcu+RuewAVPDulz4fRoMW1F9WJjvaAji83bBjSmCxnNH40J+0wFubc4Hhr6TonfiYtzS8BkhzETHQXn5HhhS5QGgjzDqjvIPTgMLVpyPzIWrVQ8rdxvCHkGW+c1k44QOlGTMRXdWcf+1CHkwmwjMBDRAENffNOYtZA/WJMkOeIACeuMK9xIIm7vrilxcRaRE1EwK8Mbm0OGkpa4ZCdST6Zd6/Si1otwnfRucizAriumN1+icCU8LwSJtPOZ72ALmhRaHYikCRj5VqQZug7sYaPthhQ5H/CSuYyzBh6k3e7OhuO4TDLDsXZdcKapydPc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXPFrnZYiXkfOItdZFwmWyanqMdRk6w8T18StovAHgU=;
 b=rFTK+QV4PVSPfZfqmtOChxHYSjRMge7cgF/1UrSueFu28TjHTTk2u/VjvT2k16As1csHQLbb6tzDT++O8uWnUYaQ7E3m/CHxK4CNvVPUi/vTe9tprimyoD5rSKg/nkixt+pTimwspjYzuDBFBlTbyobgErErPCOV6lXmiA5Z7Kk=
Received: from SA1PR02CA0002.namprd02.prod.outlook.com (2603:10b6:806:2cf::6)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 12:54:54 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::6b) by SA1PR02CA0002.outlook.office365.com
 (2603:10b6:806:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 12:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:48 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:47 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/18] arm64: versal-net: Move board_early_init_r clock setup
 to mach code
Date: Tue, 23 Jun 2026 14:53:33 +0200
Message-ID: <10dd9f35d03be0402ce13475f20b2cd3761189a6.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4519; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Yr1yo9MD0McE73xEhB+Z/fywF8eZbx7wG9mwqkcaYXE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb4uSc5h4+WedUFuH/P+l0cfJyvLuOZedrcJbDJ+U
 LzkYpRqRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExk+jmGX8yv9/QvDlRY9OzE
 FCWBI5b/Xmh/cOf28U9tKbV7VO3/upORoaug6bL5S6HpAi6Jm54EX+jjXe8dvW9J3ow7t73ZD8y
 Q4wYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 5025c421-5c8d-4f9c-17d1-08ded1269f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Jf1U4Pmcr+ZbMdk/AMqiPdQ7cQuhwchzpkAmRYfcLHZI2Gg3S9uUiR+9GcGvKxDjCauoi0O6C+KUpJSGHKNMqrRQXjJgKmuoJKdXXJrMztc6cQqFqQRxUngQ5BO5r73VZIBLT3GKNjTjZGssFwwrhosXTpeRRVxNMLmuxKCxFlhBH1PTbKmvt+wDLavYSszFCikoOpcpVs5zO2byOnNzhHyRU2ABXltjKD10sc8f+f7ik6nXIaWQXxlKdbL9ZXkXw+bRxEmS7OXBEUoMKhK17jo58NVaVSfDokdT2TxUsDLLbMaCijPV0xiz3lNZ6RqKcK2uu7a10s7Cjf5dbdyS4K+k2GW5UzDgE1J3Xe5BqxWIdEvSyEcAJJKNINMfHHevWtmccxvlwSRvDAmGb4S76NCWbM6oW6O4PQe7LYaoFwWZIuOLKbuJNUPEOnA5NsjrWkxJFc9BdrprXaGyFYdVqIrGlulffWAgvhIYkrYn5U5VLenxIhe8sHwFQvvNFjl/By/uvGlHSBKkjv9IsEsMGcSvlHgYlUFnz3c6hPZNzG0AiHGBJ06hyrqrBB/Aao692X+FaP2xTcETuIRKpZ4R2kHLzVZvbEL051WMgbtu6D0oruugyL6O4ih+09XzpiQ3jmgWLgCOl76s6a6bJOBZ1mnJ8AIt4ZuY0wcnbSQ6yZKbXulyrUoZMeLiFcOJJX+aQMB78a8nrSpi9gkF2Q+9YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bUrn/8Q6DwwNpJz7aPsUOXq5jIRT+DR8O92qvn4nuj0OUI73kTP64V9cZTbV8sN2j4CxeruvUpltJ4LaCWN1B4gjDnthrIdERAUrcavuLT8rRQBBk2omDhMh8+4mw63SSryM2MYQIy2RfUzMfiZfC1lv/rhq7OEVYG4lF2H86qYotE7SqvUSk597uTYfvdFAieRc5vmdl2Imcqz72Cn7VL190LUd2WI8MW2cZY0rEAtWqxICFox+I+gOCpgrqYdRD7QOAGKQqtILbbn+Ohc3EoDXnkk+iwIchK5tFF1bFgT18IzCW1kv+E+5e0EMMi0BFBUwYF8H3DR1M1mpr20ts5+2Y1uLk8ItN1D/KT5AABL5D3aUoC1AybJNL6tYZ6e6hU26NdH3SVP1JMdsiWCnK5bFU1EM02iUxyoJPTaCKKyCgiG6ANjv3wKoWjNKPlEg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:54.2940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5025c421-5c8d-4f9c-17d1-08ded1269f38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
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

Move it into versal_net_timer_setup() in arch/arm/mach-versal-net so the
board hook only keeps the EL3 guard and calls the helper.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal-net/cpu.c                | 43 +++++++++++++++++++
 .../mach-versal-net/include/mach/sys_proto.h  |  2 +
 board/xilinx/versal-net/board.c               | 38 +---------------
 3 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index d088e440f638..5e7c1bebf2cc 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -7,6 +7,8 @@
  */
 
 #include <init.h>
+#include <log.h>
+#include <time.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -88,6 +90,47 @@ u64 get_page_table_size(void)
 	return 0x14000;
 }
 
+void versal_net_timer_setup(void)
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
 U_BOOT_DRVINFO(soc_xilinx_versal_net) = {
 	.name = "soc_xilinx_versal_net",
 };
diff --git a/arch/arm/mach-versal-net/include/mach/sys_proto.h b/arch/arm/mach-versal-net/include/mach/sys_proto.h
index 23374d10a6b4..33253ca88bfe 100644
--- a/arch/arm/mach-versal-net/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal-net/include/mach/sys_proto.h
@@ -7,3 +7,5 @@
 #include <linux/build_bug.h>
 
 void mem_map_fill(void);
+/* EL3 clock/timer register setup, called from board_early_init_r() */
+void versal_net_timer_setup(void);
diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 65b2a451ad7a..a40039a1dc8e 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -148,46 +148,10 @@ int board_early_init_f(void)
 
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
+	versal_net_timer_setup();
 
 	return 0;
 }
-- 
2.43.0

