Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7755AC54FD2
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 06:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 290FE408AA;
	Thu, 30 Jul 2026 06:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lAcNTX-w90WU; Thu, 30 Jul 2026 06:49:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFC0440861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785394194;
	bh=ginvOZMsAXJID+fxYK7loeIYoaKwJ0SOxgiPipEVrc4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qRpXySehN3AIIHq0yDqnd6AWUy9k0gSLv2kr156xlugaD/cGFcqy43tXn8oFuYsdG
	 1thOxFANuhppmeSANP6U5GKtE/ttGykZmlMwKKE89l+qGsYoqcueqhjlskr3CwYMOT
	 QQ9xZnZ9/ZrC75ZwdT1U+Mq1HQr77EUMgki0kru1itEQLgZJR0UWvZ/bysFpyF+q5G
	 kQ9cZdAaRDBBtWUqGMxFBbikiZzKqcU6VGfBAUURdRLrvjyR0BF1R8zYm0T9hdoU3L
	 +914FcUWBfW6iPXQjuKi+9wgbYujL5puHrwogO1sVN/PmRNOK2PHvQPqhm0nosT0w6
	 W42s/a0FnjZZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFC0440861;
	Thu, 30 Jul 2026 06:49:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 19D9D194
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F407940861
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9fwHLdm7mcRu for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 06:49:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DA0A7406EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA0A7406EB
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA0A7406EB
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vseJLAVN8TSOzKV+hZkzkFBTEw56mqokXZoOmNa7zBKBTGfBDxDfpw4p2HofIIgYABkEy/PW5LKViOQfu7oMHymvxewEPLuXKnPJAsgyDfMXuEw20rJMSx/jyFNUqnj9HSFfgXZJRqgheJokHy8+A6r1lVkd9JfUZ/TKo8KlrnzbSdMay8CJsAH1eGu7sNYrWQaHAnt8qbu+vp74SmqYjZl1E+EKAC60Rv3u/OIRYO5xtUCOwMqjNZflWYbvrZHKmo1kCyWXE2GkVVhxzwtIoAaCjE24+U6CkpkxhYXsWxjyKGhH/wFX0hZ5dLDm7YBWBPGUjOZRTa/+j66jym5uGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ginvOZMsAXJID+fxYK7loeIYoaKwJ0SOxgiPipEVrc4=;
 b=ZHuTCCv4ZZdpHDM6Xc9VNA87JccZGyYLYp6FiKpQdY+JGkjhBxnkjWOg0JqyG4w5irjafO/8VP4vBf7k5qZsr6hjmJn1q9SL08aQMjgZFCgnZ9mPc8D+ZuEBSyrQz48/qrqDD5VOnh1rTHuCOe/6XYwik2MlOQzpsLxlKSGdGHU9MuBjEWoVj4qRYBys1QkQ3OjCF7fBkJ+T4kliT3TCeUtgFfPMD85RgbjwlTneuD7NW0Z7TuHXK2bwx4B5mmsBpSEl0tgnoy6avrgVyIFwHWyoIIdeq8Xy6fWt1iuhzciBBydZgkvSlpApaw2QkfiTX1fBpJoi0D4bOjS8mRjVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from LV3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::31)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 06:49:35 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::13) by LV3P220CA0008.outlook.office365.com
 (2603:10b6:408:234::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 06:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 06:49:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 01:49:32 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 01:49:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Bhupesh Sharma <bhupesh.linux@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>, Sean Anderson <sean.anderson@linux.dev>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] xilinx: versal2: Clean UFS firmware interface
Date: Thu, 30 Jul 2026 08:49:17 +0200
Message-ID: <26bc9aa2c02921690e126ab3401f7974ef04ad6e.1785394153.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785394153.git.michal.simek@amd.com>
References: <cover.1785394153.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11569; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=GMpNS+TqiGvsMU5ZV7WzTymOPm+ujyh4s8sz6nK5H1k=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRlff6U+CL85YLtTrLMihU3FwiGPn7HG8X4IacubMu0b
 JOzPcUfOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAibocYGU7rXHbkt/7PmRTU
 YRu/W6Tsp3NFXvgi9p1/vb+0sTF9l2b4zfbmJdd+sffrj3TzPYiPTvq288jDmhjHg+uuz7ywyqv
 tJQ8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 669213ac-0cd5-42d6-324d-08deee06b709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 65bFn5cRsGQgxidAsWoQf4E015lxP9GUUppLP00x3WjiSWIkRg1ukfb/jkm87coht/EZ3u1gi97mhXAgyRQUhoqEFFXPI/5sxvbQuGKs3nICpwKDDzmbHIu8y/mO+6Sh0rpZoKOmufolehRCNdavxYGuudMJo7gm5dxTkexc/D2x7qjC0XF6qEGsgsaAiRDxD7aHT9wMUxrtvkV623lfm3Ls3lo8vJOXiiAMaCwLM9OJHVpVNrg/l1rCC7G6SGPPNP3fVdGV/y+MOCX5UP6FfFPn5uxaRzZ3yEDYU4fPuaaMkwuCL93RStj2MIUnnStrh32a322mPKIrX/LXwBBjMl5r0kH+hmPsvsSYDi/SUBAyQniwte9BmfoUhhDTvqB+u/aXtscLsrk6scqyuPE3bYfmGr0b24m8VzXHo3oVLBxQauZE0An4LG6FGDL5K0JqChwbz1l01zwcdxn8iK1bT5JQXovKB47mhA3EjWdzJ1qbe/psvAgXv+fIn82Es8bRnI+4O47tE4RsGLxKsWdeWj1qRXREJExQRB16VhhMcKb0G0YDmlVLOtbgUM3TpdVI/Xa6cDEBjn0aVkpATbgAdJYVOQgtXp9vsd1S4tiQIs3+NwzF9JWFF7jCukTtWHbnLmnQAlAOs8PD717+9q3ouU+tc6E9rszR4rpbpgxw6RNPf1Voo/6eQAbw/IVVdg8Hysegmq2BvQT+9Smm8csQpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FH+/4U1w0Ba777KyzBmEXzL//0ED9l6UP+edscQAvbP1Ga+ZWPcQpmBwCK5NlHz6L0T22rMzG9weojr0bcJb1xRT5wXzSxMckoy5Xc7hsFJx/G/+757MKhK10ZcMelFhDxUNnPt6tMzZDfTrMRlKBRF1S63tbMFvGLy2ppup/qc2nGVicQlbh0u/JQoAwXYkrcwLO/GGFYnHqdmBvrnpTyGqzjbqE6QyysYqYO4WUWkbyqr11bnuEqrnvn2jaGes2wRa5E44kjsnO+bHJVXfHdYYBt+PVzgI4tgaKW25p8KSLcvMeGIEv21ouVsqnEhHfhP2XdForXIoaDNeD/kZSDshl3NRfBEKRuhGSvbMtINDtdatzM74/Y1/dWhQVZRS8Os3Y4tovCoXViaQMe8e/v0NAlXUoOJgHuQVbUCgxDf/x2HFDPVxMNgYvpOC/SBo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 06:49:34.0813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 669213ac-0cd5-42d6-324d-08deee06b709
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ginvOZMsAXJID+fxYK7loeIYoaKwJ0SOxgiPipEVrc4=;
 b=LErEFPJZ/kNeCW4m+fXn+PQVKlsdkfHQLhenJpJxEPv98Ysb8M1WFg7N8OYvXj4/XYCd9kprpWhyZ5rvZIR2ohPm+be5c1qL/mHUSVOexnp/nkHKB8/AQ/Wy+Gp/DEULbb20FpKtQ8CRz7RSLU9PCLR4CQ+lhj0Wmo0N6aPpJBs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LErEFPJZ
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The M-PHY and SRAM readiness poll loops move out of the UFS controller
driver and into the firmware backend, exposed as blocking waits with
a caller-owned timeout budget. This keeps the UFS driver backend-agnostic
and lets an other backends offload the wait to the platform in a single
call instead of round-tripping every poll.

set_sram_bypass() now performs the SRAM_CSR read-modify-write in the
firmware layer.

Hook up functions are also update to reflect their usage.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/cpu.c                   | 34 ++++++---
 arch/arm/mach-versal2/include/mach/hardware.h |  5 ++
 .../arm/mach-versal2/include/mach/sys_proto.h |  8 +-
 drivers/firmware/firmware-zynqmp.c            | 72 +++++++++++-------
 drivers/ufs/ufs-amd-versal2.c                 | 73 +++++--------------
 5 files changed, 95 insertions(+), 97 deletions(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 01efa7b79282..d72f66f4fbac 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <time.h>
 #include <vsprintf.h>
+#include <wait_bit.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -160,25 +161,40 @@ u8 __weak versal2_get_bootmode(void)
 	return bootmode;
 }
 
-int __weak zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value)
+/*
+ * Wait for the M-PHY TX/RX config-ready status to settle (all bits cleared) or
+ * @timeout_us to elapse. The direct-MMIO fallback owns the poll loop, mirroring
+ * the EEMI backend; the timeout budget is owned by the caller.
+ */
+int __weak zynqmp_pm_wait_mphy_tx_rx_config_ready(u32 timeout_us)
 {
-	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_TX_RX_CFG_RDY);
-	return 0;
+	return wait_for_bit_le32((void *)(uintptr_t)(PMXC_SLCR_BASE_ADDRESS +
+						     PMXC_TX_RX_CFG_RDY),
+				 TX_RX_CFG_RDY_MASK, false, timeout_us / 1000,
+				 false);
 }
 
-int __weak zynqmp_pm_ufs_sram_csr_read(u32 *value)
+int __weak zynqmp_pm_wait_sram_init_done(u32 timeout_us)
 {
-	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
-	return 0;
+	return wait_for_bit_le32((void *)(uintptr_t)(PMXC_SLCR_BASE_ADDRESS +
+						     PMXC_SRAM_CSR),
+				 SRAM_CSR_INIT_DONE_MASK, true, timeout_us / 1000,
+				 false);
 }
 
-int __weak zynqmp_pm_ufs_sram_csr_write(u32 *value)
+int __weak zynqmp_pm_set_sram_bypass(void)
 {
-	writel(*value, PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
+	u32 sram_csr;
+
+	sram_csr = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
+	sram_csr &= ~SRAM_CSR_EXT_LD_DONE_MASK;
+	sram_csr |= SRAM_CSR_BYPASS_MASK;
+	writel(sram_csr, PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
+
 	return 0;
 }
 
-int __weak zynqmp_pm_ufs_cal_reg(u32 *value)
+int __weak zynqmp_pm_get_ufs_calibration_values(u32 *value)
 {
 	*value = readl(PMXC_EFUSE_CACHE_BASE_ADDRESS + PMXC_UFS_CAL_1_OFFSET);
 	return 0;
diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
index 7977529fd6c1..4ff732d660fd 100644
--- a/arch/arm/mach-versal2/include/mach/hardware.h
+++ b/arch/arm/mach-versal2/include/mach/hardware.h
@@ -65,6 +65,11 @@
 #define PMXC_SRAM_CSR			0x4C
 #define PMXC_TX_RX_CFG_RDY		0x54
 
+#define SRAM_CSR_INIT_DONE_MASK		BIT(0)
+#define SRAM_CSR_EXT_LD_DONE_MASK	BIT(1)
+#define SRAM_CSR_BYPASS_MASK		BIT(2)
+#define TX_RX_CFG_RDY_MASK		GENMASK(3, 0)
+
 #define PMC_GLOBAL_PGGS3_REG	0xF111005C
 #define PMC_GLOBAL_PGGS4_REG	0xF1110060
 
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index c1dfd184d865..d678adf9c267 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -22,9 +22,9 @@ u8 versal2_get_bootmode(void);
 /* EL3 clock/timer register setup, called from board_early_init_r() */
 void versal2_timer_setup(void);
 
-int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value);
-int zynqmp_pm_ufs_sram_csr_read(u32 *value);
-int zynqmp_pm_ufs_sram_csr_write(u32 *value);
-int zynqmp_pm_ufs_cal_reg(u32 *value);
+int zynqmp_pm_wait_mphy_tx_rx_config_ready(u32 timeout_us);
+int zynqmp_pm_wait_sram_init_done(u32 timeout_us);
+int zynqmp_pm_set_sram_bypass(void);
+int zynqmp_pm_get_ufs_calibration_values(u32 *value);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 2bdb1c4d9f89..fae66ccb3d83 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -19,6 +19,7 @@
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 
 #if defined(CONFIG_ZYNQMP_IPI)
 #include <mailbox.h>
@@ -175,51 +176,60 @@ unsigned int zynqmp_firmware_version(void)
 };
 
 #if defined(CONFIG_ARCH_VERSAL2)
-int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value)
+/*
+ * Poll the M-PHY TX/RX config-ready status until it settles or @timeout_us
+ * elapses. Legacy EEMI firmware only offers the per-read status primitive, so
+ * the poll loop lives here rather than in the UFS driver; the timeout budget is
+ * owned by the caller.
+ */
+int zynqmp_pm_wait_mphy_tx_rx_config_ready(u32 timeout_us)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	if (!value)
-		return -EINVAL;
+	while (timeout_us--) {
+		ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
+					IOCTL_READ_REG, TXRX_CFGRDY_OFFSET, 0, 0,
+					0, ret_payload);
+		if (ret)
+			return ret;
 
-	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
-				IOCTL_READ_REG, TXRX_CFGRDY_OFFSET, 0, 0,
-				0, ret_payload);
-	if (ret)
-		return ret;
+		if (!(ret_payload[1] & TX_RX_CFG_RDY_MASK))
+			return 0;
 
-	*value = ret_payload[1];
+		udelay(1);
+	}
 
-	return ret;
+	return -ETIMEDOUT;
 }
 
-int zynqmp_pm_ufs_sram_csr_read(u32 *value)
+int zynqmp_pm_wait_sram_init_done(u32 timeout_us)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	if (!value)
-		return -EINVAL;
+	while (timeout_us--) {
+		ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
+					IOCTL_READ_REG, SRAM_CSR_OFFSET, 0, 0,
+					0, ret_payload);
+		if (ret)
+			return ret;
 
-	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
-				IOCTL_READ_REG, SRAM_CSR_OFFSET, 0, 0,
-				0, ret_payload);
-	if (ret)
-		return ret;
+		if (ret_payload[1] & SRAM_CSR_INIT_DONE_MASK)
+			return 0;
 
-	*value = ret_payload[1];
+		udelay(1);
+	}
 
-	return ret;
+	return -ETIMEDOUT;
 }
 
-int zynqmp_pm_ufs_sram_csr_write(u32 *value)
+int zynqmp_pm_set_sram_bypass(void)
 {
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 sram_csr;
 	int ret;
 
-	if (!value)
-		return -EINVAL;
-
 	ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_MASK_WRITE_REG);
 	if (ret) {
 		printf("%s: IOCTL_MASK_WRITE_REG is not supported : %d\n"
@@ -228,15 +238,21 @@ int zynqmp_pm_ufs_sram_csr_write(u32 *value)
 	}
 
 	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
-				IOCTL_MASK_WRITE_REG, SRAM_CSR_OFFSET,
-				GENMASK(2, 1), *value, 0, NULL);
+				IOCTL_READ_REG, SRAM_CSR_OFFSET, 0, 0,
+				0, ret_payload);
 	if (ret)
 		return ret;
 
-	return ret;
+	sram_csr = ret_payload[1];
+	sram_csr &= ~SRAM_CSR_EXT_LD_DONE_MASK;
+	sram_csr |= SRAM_CSR_BYPASS_MASK;
+
+	return xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
+				 IOCTL_MASK_WRITE_REG, SRAM_CSR_OFFSET,
+				 GENMASK(2, 1), sram_csr, 0, NULL);
 }
 
-int zynqmp_pm_ufs_cal_reg(u32 *value)
+int zynqmp_pm_get_ufs_calibration_values(u32 *value)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index 986147848bda..48854792cbf3 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -20,10 +20,6 @@
 #include "ufshcd-dwc.h"
 #include "ufshci-dwc.h"
 
-#define SRAM_CSR_INIT_DONE_MASK		BIT(0)
-#define SRAM_CSR_EXT_LD_DONE_MASK	BIT(1)
-#define SRAM_CSR_BYPASS_MASK		BIT(2)
-
 #define MPHY_FAST_RX_AFE_CAL		BIT(2)
 #define MPHY_FW_CALIB_CFG_VAL		BIT(8)
 
@@ -31,8 +27,6 @@
 #define MPHY_RX_OVRD_VAL		BIT(2)
 #define MPHY_RX_ACK_MASK		BIT(0)
 
-#define TX_RX_CFG_RDY_MASK		GENMASK(3, 0)
-
 #define TIMEOUT_MICROSEC		1000000L
 
 struct ufs_versal2_priv {
@@ -229,7 +223,6 @@ static int ufs_versal2_setup_phy(struct ufs_hba *hba)
 static int ufs_versal2_phy_init(struct ufs_hba *hba)
 {
 	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
-	u32 reg, time_left;
 	int ret;
 	static const struct ufshcd_dme_attr_val rmmi_attrs[] = {
 		{ UIC_ARG_MIB(CBREFCLKCTRL2), CBREFREFCLK_GATE_OVR_EN, DME_LOCAL },
@@ -238,24 +231,15 @@ static int ufs_versal2_phy_init(struct ufs_hba *hba)
 		{ UIC_ARG_MIB(VS_MPHYCFGUPDT), 1, DME_LOCAL }
 	};
 
-	/* Wait for Tx/Rx config_rdy */
-	time_left = TIMEOUT_MICROSEC;
-	do {
-		time_left--;
-		ret = zynqmp_pm_ufs_get_txrx_cfgrdy(&reg);
-		if (ret)
-			return ret;
-
-		reg &= TX_RX_CFG_RDY_MASK;
-		if (!reg)
-			break;
-
-		mdelay(5);
-	} while (time_left);
-
-	if (!time_left) {
+	/*
+	 * Wait for Tx/Rx config_rdy. The poll loop lives in the firmware
+	 * backend (IO, EEMI or SCMI) so this driver stays backend-agnostic;
+	 * the timeout budget stays here with the consumer.
+	 */
+	ret = zynqmp_pm_wait_mphy_tx_rx_config_ready(TIMEOUT_MICROSEC);
+	if (ret) {
 		dev_err(hba->dev, "Tx/Rx configuration signal busy.\n");
-		return -ETIMEDOUT;
+		return ret;
 	}
 
 	ret = ufshcd_dwc_dme_set_attrs(hba, rmmi_attrs, ARRAY_SIZE(rmmi_attrs));
@@ -269,24 +253,11 @@ static int ufs_versal2_phy_init(struct ufs_hba *hba)
 		return ret;
 	}
 
-	/* Wait for SRAM init done */
-	time_left = TIMEOUT_MICROSEC;
-	do {
-		time_left--;
-		ret = zynqmp_pm_ufs_sram_csr_read(&reg);
-		if (ret)
-			return ret;
-
-		reg &= SRAM_CSR_INIT_DONE_MASK;
-		if (reg)
-			break;
-
-		mdelay(5);
-	} while (time_left);
-
-	if (!time_left) {
+	/* Wait for SRAM init done (poll handled by the firmware backend). */
+	ret = zynqmp_pm_wait_sram_init_done(TIMEOUT_MICROSEC);
+	if (ret) {
 		dev_err(hba->dev, "SRAM initialization failed.\n");
-		return -ETIMEDOUT;
+		return ret;
 	}
 
 	ret = ufs_versal2_setup_phy(hba);
@@ -301,7 +272,7 @@ static int ufs_versal2_init(struct ufs_hba *hba)
 	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
 	struct clk clk;
 	unsigned long core_clk_rate = 0;
-	u32 cal, sram_csr;
+	u32 cal;
 	int ret = 0;
 
 	priv->phy_mode = UFSHCD_DWC_PHY_MODE_ROM;
@@ -345,28 +316,18 @@ static int ufs_versal2_init(struct ufs_hba *hba)
 		return ret;
 	}
 
-	ret = zynqmp_pm_ufs_sram_csr_read(&sram_csr);
-	if (ret)
+	ret = zynqmp_pm_set_sram_bypass();
+	if (ret) {
+		dev_err(hba->dev, "Bypass SRAM interface failed, err = %d\n", ret);
 		return ret;
-
-	if (!priv->phy_mode) {
-		sram_csr &= ~SRAM_CSR_EXT_LD_DONE_MASK;
-		sram_csr |= SRAM_CSR_BYPASS_MASK;
-	} else {
-		dev_err(hba->dev, "Invalid phy-mode %d.\n", priv->phy_mode);
-		return -EINVAL;
 	}
 
-	ret = zynqmp_pm_ufs_sram_csr_write(&sram_csr);
-	if (ret)
-		return ret;
-
 	/* De Assert RST_UFS Reset for UFS block in PMX_IOU */
 	ret = reset_deassert(priv->rstc);
 	if (ret)
 		dev_err(hba->dev, "host reset deassert failed, err = %d\n", ret);
 
-	ret = zynqmp_pm_ufs_cal_reg(&cal);
+	ret = zynqmp_pm_get_ufs_calibration_values(&cal);
 	if (ret)
 		return ret;
 
-- 
2.43.0

