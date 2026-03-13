Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF382105F7AE
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C85D08438A;
	Fri, 13 Mar 2026 14:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DmfioN25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6815E84307; Fri, 13 Mar 2026 14:59:58 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B974B84376
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWozQcJjTZ7Iek2Z5nByiLtBaP1uwhYkC9SAc14ZYE6GSBCza4vukI1WYxgQaO/3tKMIIAYF+jh9u8i54r4d3t4CfZHCoeaYoMK0Crn/vaVrqp+k6pVuA3iTl/6/G/+8d7AJ521HDnTUwGP7z89yZzWaE+IrFkkp6ljxPPkxgNR8JA0ny8+r/myeecdANvuKwO75P+Iu97Rst5Nw2vL9aXSqTUXRTojz9WKKC2fxNaWXR/PvuJ3podX4u04tLZpeZZYCKQbpZ3rO1ArE4bmAitL3ejmWcvo3fLVqhI7vbL+OZjgvbFjEAuHYdlCaffwRQbwT0UbJwPFl+n0SG+sGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAM5rnja2fZj+QXsTmCR+69F2hw64sg++WShFqxQDmc=;
 b=hgygVJ9G3jVQ/iPnmhQjiZWAS2WeoBx8goeRqJwSEaSzYXFRcsDWGXd6ONJieDzgVl19RYPQUzWVmB9ty8ltfPUQoaZti0cXwUVJL1GbbOZ52u/VTR5tTowAWRQMWLQLOItZIszzkaRQ2eeiMAZZj//udVOqGdQ3W4Ie0mDz+gkKXB8+Leawdd1PPO/DPonWRp1GzbhZcp6JYZ1UsW98cGT2glg7RCMA2an72RDiz3DttCbaSwsvs40fHDcZPJzSRw4ag4h2tAv60tEKQmbaISw8sb6fMkZqPfMsLhMmMT4SXSNT1zBa1WNyfakJ5uSvHGtffCAr20RhzOM5Jc0Eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAM5rnja2fZj+QXsTmCR+69F2hw64sg++WShFqxQDmc=;
 b=DmfioN25pn3OF1l74PY77TlM/Zbb6DMPyw3MosyNkJ+S1S6UfudDgro2bwggjhXdXzZDPlcXPuBVArbx8YaZRO1EJqhWwx5FkUe81wWfk0usImHr7NkBzkZeimg5SRmqeDZoc9FSjQjoXZMTvRvdFGUY34peGtNmKCFnIlUV6/o=
Received: from BLAPR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:335::8)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Fri, 13 Mar
 2026 13:59:51 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::b) by BLAPR05CA0026.outlook.office365.com
 (2603:10b6:208:335::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:49 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:49 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:48 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jn638000;
 Fri, 13 Mar 2026 08:59:47 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 17/19] r5: comomon.c: Add helper functions needed in LPM
 resume sequence
Date: Fri, 13 Mar 2026 19:28:58 +0530
Message-ID: <20260313135900.3430264-18-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|BY5PR10MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: d98aaffc-0ea7-4bad-d49d-08de8108cb08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4SnbwYSMsOeQcvqODA4CczrrR37PbCFOnOx2xFoY4gLWDHrGavWwJ2baB493H17e/nJigeWMndwy7+z9KnnCrQixnzDs5b+h9Kz0s66vYOhIRP8Y4pGzEkZQJmmBmzzadPJiIH7afQT8vawoMLebtGdSqYj3Lg+mck71ghwi41tFspWk4Q0z0UjUQtUM5OlQAo4XprzAHGHQ35jlJvluCFC0hdfGtkgY0e2TVnvSrW5FGmupogWb6a+LLcG+IVUJ8RcDk0eaqlVEorMprsCG5vq7c2Uthl7EcE+m/yD11wEtBcKNVrpmSJSOQjeE+mI+dcPpF0FV0Pf5s9nwEtj3FtHRWThLVACj/t+K/dPMxwkX2bhVXquaabGzv+ai+0fUhJesuPRTd1VHC2QkQ6e23Rnzynd5//59+7vepzjCOKoKEMQTubkD3/jzviFpLKCZeo82KxwvKfoiDLRlmIw4m5wJfCs+LMFkbA086gQc9NHz2afKJ8FbuNlzGWQyIEMq1xRo3g8R66YMVt610kN56RR0zYh6zcEmJVpMCSNS9N2S81TA53VhL59L+iQS1aRht1QCnZoYXBMePoKQ4InbHucyyDqhUF2NehVoY2SN1VakMKKNaeGijGAWPiAnkMSVZbwuXFMs1tjR2Wv4EJ+kjYy+aKE1FEyBYNtjyX9nfDdCdPazXe81ku39oVS2R0P1RGUJ38YV0hixims6dSILMo9IAp5brGT7h4E/rjQ7aPk/NKv6geHEvclOmtd4oVD9iKhNdb24g8XWCWh0ECeRaQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nRR8mEdXWXZSpFqFzlJBV+liMcyLQ8Qkz8D8j7oJr/yt2g240dKfPRB/MbH1T2OsbkeZ7eFzUtmMys5dtJ3SmgxWcyi9jQpTBIzjf5IeDhYx3TF0xj/HeTPDDpz5bPow1QcbxqZV/La9KUSbhvC3/xoQwubUQ3sGS2mRCSAC4cxE4XB+Asx4zAMTXGmXPkDJG0ER3O1Bv5oHQeTtUv8kY8lTei9KaKhCR6qb3+cu2IgRYiCN8ODBii3n7Y083hK4uTqJlwpavCiLIaZKfEMbkL87scFp3x6NaSEEIaTBn/rT6uuqlBeYUu8F0kpRttJZ8AtVlTx9eZ3DBt/0+8VPQKR27YdjapGP/wQrga1J8gq19p+MYWovjryhAZgl+cOLJeuioo/0TJT+WmpSf+g0KZgCLEBzzXVSsSoXfcT+UQ9mPPLbcobJ9vh63vhMfJYZ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:49.8057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d98aaffc-0ea7-4bad-d49d-08de8108cb08
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
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

Add helper functions that are used by respective socs in lpm resume flow.

- save_certificate(void) is used to store the certificate information
in the reserved DDR memory for LPM.
- resume_to_dm_f(void) has the actual resume sequence which includes
decrypting atf back to original location and restoring context.
- resume_rproc_f(void) turn on the powerdomain of the rproc.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/common.h    |  14 +++++
 arch/arm/mach-k3/r5/common.c | 116 +++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index e970076d08e..321c86eb7bd 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -15,6 +15,7 @@
 
 #define K3_FIREWALL_BACKGROUND_BIT	(8)
 #define K3_SPEED_GRADE_UNKNOWN		'\0'
+#define FW_IMAGE_SIZE 0x80000
 
 struct fwl_data {
 	const char *name;
@@ -41,6 +42,16 @@ enum k3_device_type {
 	K3_DEVICE_TYPE_HS_SE,
 };
 
+struct lpm_addr_info {
+	u32 *context_save_addr;
+	u32 *atf_cert_addr;
+	u32 *optee_cert_addr;
+	u32 *dm_save_addr;
+	u32 size;
+};
+
+extern struct lpm_addr_info mem_addr_lpm;
+
 void setup_k3_mpu_regions(void);
 int early_console_init(void);
 void disable_linefill_optimization(void);
@@ -60,6 +71,9 @@ struct ti_sci_handle *get_ti_sci_handle(void);
 void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
+void save_certificate(void);
+u32 resume_to_dm_f(void);
+void resume_rproc_f(void);
 
 #if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
 int k3_r5_falcon_bootmode(void);
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 03638366046..e0bc57061b4 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -16,6 +16,9 @@
 #include <spl.h>
 #include <remoteproc.h>
 #include <elf.h>
+#include <clk.h>
+#include <power-domain.h>
+#include <dm/read.h>
 
 #include "../common.h"
 
@@ -45,6 +48,23 @@ static const char *image_os_match[IMAGE_AMT] = {
 
 static struct image_info fit_image_info[IMAGE_AMT];
 
+struct lpm_addr_info mem_addr_lpm;
+
+__weak int board_is_resuming(void)
+{
+	return 0;
+}
+
+__weak void lpm_process(void)
+{
+	return;
+}
+
+__weak int extract_lpm_region(void)
+{
+	return -EINVAL;
+}
+
 void init_env(void)
 {
 #ifdef CONFIG_SPL_ENV_SUPPORT
@@ -137,6 +157,25 @@ void release_resources_for_core_shutdown(void)
 	}
 }
 
+void save_certificate(void)
+{
+	int ret;
+
+	if (!fit_image_info[IMAGE_ID_ATF].image_start || !fit_image_info[IMAGE_ID_OPTEE].image_start || !fit_image_info[IMAGE_ID_DM_FW].image_start) {
+		pr_err("Invalid images to save\n");
+		return;
+	}
+
+	ret = extract_lpm_region();
+	if (ret)
+		pr_err("Cannot find valid LPM address range..\n");
+	else {
+		memcpy(mem_addr_lpm.atf_cert_addr, (void *)fit_image_info[IMAGE_ID_ATF].image_start, fit_image_info[IMAGE_ID_ATF].image_len);
+		memcpy(mem_addr_lpm.optee_cert_addr, (void *)fit_image_info[IMAGE_ID_OPTEE].image_start, fit_image_info[IMAGE_ID_OPTEE].image_len);
+		memcpy(mem_addr_lpm.dm_save_addr, (void *)fit_image_info[IMAGE_ID_DM_FW].image_start, fit_image_info[IMAGE_ID_DM_FW].image_len);
+	}
+}
+
 void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_noargs_t)(void);
@@ -170,6 +209,7 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
 	if (ret)
 		panic("%s: ATF failed to load on rproc (%d)\n", __func__, ret);
 
+	lpm_process();
 #if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
 	/* Authenticate ATF */
 	void *image_addr = (void *)fit_image_info[IMAGE_ID_ATF].image_start;
@@ -254,6 +294,82 @@ void disable_linefill_optimization(void)
 	asm("mcr p15, 0, %0, c1, c0, 1" : : "r" (actlr));
 }
 
+u32 resume_to_dm_f(void)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	u32 loadaddr = 0, save_addr = 0;
+	int ret = 0;
+
+	loadaddr = (u32)mem_addr_lpm.dm_save_addr;
+	if (!valid_elf_image(loadaddr))
+		panic("%s: DM-Firmware image is not valid, it cannot be loaded\n",
+		      __func__);
+	loadaddr = load_elf_image_phdr(loadaddr);
+	save_addr = (uintptr_t)mem_addr_lpm.context_save_addr;
+	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci, save_addr, mem_addr_lpm.size);
+	if (ret)
+		panic("TIFS lpm save addr fail : %x\n", ret);
+	/*
+	 * TIFS minimal context restore
+	 * This restores also the firewall
+	*/
+	ret = ti_sci->ops.lpm_ops.restore_context(ti_sci, 0);
+	if (ret)
+		panic("TIFS min_context_restore failed (%d)\n", ret);
+	/*
+	 * Restore TFA in msmc memory
+	 */
+	ret = ti_sci->ops.lpm_ops.decrypt_tfa(ti_sci,
+					      CONFIG_K3_ATF_LOAD_ADDR);
+	if (ret)
+		panic("%s: TIFS failed to decrytp TFA : %x\n", __func__, ret);
+		/* restore TFA resume vectore address in main core */
+	ret = ti_sci->ops.lpm_ops.core_resume(ti_sci);
+	if (ret)
+		panic("ATF failed to resume (%d)\n", ret);
+
+	return loadaddr;
+}
+
+void resume_rproc_f(void)
+{
+	struct power_domain rproc_pwrdmn;
+	unsigned long gtc_rate;
+	struct udevice *dev;
+	struct clk gtc_clk;
+	void *gtc_base;
+	int ret;
+
+	ret = uclass_get_device_by_seq(UCLASS_REMOTEPROC, 1, &dev);
+	if (ret)
+		panic("Unknown remote processor 1 (%d)\n", ret);
+
+	ret = power_domain_get_by_index(dev, &rproc_pwrdmn, 1);
+	if (ret)
+		panic("power_domain_get_rproc() failed: %d\n", ret);
+
+	ret = clk_get_by_index(dev, 0, &gtc_clk);
+	if (ret)
+		panic("clk_get failed: %d\n", ret);
+
+	gtc_base = dev_read_addr_ptr(dev);
+	if (!gtc_base)
+		panic("Get GTC address failed\n");
+
+	gtc_rate = clk_get_rate(&gtc_clk);
+
+#define GTC_CNTCR_REG	0x0
+#define GTC_CNTFID0_REG	0x20
+#define GTC_CNTR_EN	0x3
+	/* TFA expect the Global Timebase Counter to be set-up */
+	writel((u32)gtc_rate, gtc_base + GTC_CNTFID0_REG);
+	writel(GTC_CNTR_EN, gtc_base + GTC_CNTCR_REG);
+
+	ret = power_domain_on(&rproc_pwrdmn);
+	if (ret)
+		panic("power_domain_on failed: %d\n", ret);
+}
+
 int remove_fwl_region(struct fwl_data *fwl)
 {
 	struct ti_sci_handle *sci = get_ti_sci_handle();
-- 
2.34.1

