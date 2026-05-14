Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1CACD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2A6839D9;
	Thu, 14 May 2026 12:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dMCNNV9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E787683FF5; Thu, 14 May 2026 12:30:06 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B438341A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=La2FQRhsw3PBqPsI6wT0na+emMn7qH6XqWEQzJYuToiXsllhh22+lXGxTIMRO3rAo97wVxV71Zi852y2HskYvcWOg/oLs8IOY3OBP5uNKgFoE14v9sspvtYNQn2T5wzxEdqLG03Npm0TpAobjP6sXbB5Tp/RWy6p1OQNUiVa7yu1rMrFM8Dpjtk80URxl93SGAph71NFVEXAjuuLGVEIzM1/wizUllVp3l/CWocutG4yw0kOf6vlqf5rVcyzLwotvqtaCwfaF7JfYPK4Y3kZFR1diQAQkPcVToTysVqXz1goZN7wUuU9X16jVbpxipkxXNKVCEajHIIBkiKsqZXL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW1mypylyWZsTSrXNvtyMRjwLPZVP0DfksYmRBFME7s=;
 b=Vlb2dNOUv31voLJB/9EzZP7j9MP/zBiq76uCuWNDtDMWX8ejTgYNDAybPKN8iJjUhTKaSUsGdrSTgM4djxhrTmiVe2OpFQFJQm5RuwP+Dk6OxAMAYSolR3v8h9wgnDaUdyIeY1InV0OJaI3vbOqSb97e7LCs9sAmhii2O4gmQWxMNg3/bY5mIagO3kFE1XYpMbGLwP35dMT+lXMi2wcOJKAiaVge3X0DFwfFb5jRvWit85GkvV64oTD5wkqQyhYGzq1wa21O0y/2L6hwX8NooWDRa6bvm3ackIFfZOlKIOtkfo9pUfm22TStpf/WH6FxVhHGsQ0j8jgoav3We86YCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW1mypylyWZsTSrXNvtyMRjwLPZVP0DfksYmRBFME7s=;
 b=dMCNNV9t7q6G4vGY5x5jtwN+hhhPcTu+KwTbFFKyaTAXkLzRreQ0gGguiIexY2Y65bDfcrBp+16MEovN6cxAgOAVCbftrFSj3za4UYtJDd/BgvFJCIYLYTTwdC7ZmEQWDUpQRoDUrJnpmdnqSY2AtQbQkEDfS9y9AdtMyQuRhv4=
Received: from BL1PR13CA0242.namprd13.prod.outlook.com (2603:10b6:208:2ba::7)
 by IA0PPF002462CFE.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Thu, 14 May
 2026 10:29:52 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::33) by BL1PR13CA0242.outlook.office365.com
 (2603:10b6:208:2ba::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 10:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:29:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 05:29:17 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 05:29:15 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sean.anderson@linux.dev>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Naman Trivedi <naman.trivedimanojbhai@amd.com>
Subject: [PATCH 2/7] firmware: zynqmp: Add PMC PGGS register read API
Date: Thu, 14 May 2026 15:52:19 +0530
Message-ID: <20260514102601.1759779-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514102601.1759779-1-padmarao.begari@amd.com>
References: <20260514102601.1759779-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 46daf884-059b-4718-6e3f-08deb1a3a7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: JIa9buC8+8h4QkD1L9wsYm01WnQbc/w9SxPaKiURLah9a/AdHmWrjaSQFpNd4apd0s5dj+KeHDMJ04j6l6Ll6A3ElUpqVzjzCGZKAry++3Q8UzJ6tCL61xMTVlqbUORsMiWJYZgWc+cylTq6KN45rb6GMXEAbr1MPW4YqemwZ6rpMOFaibMH050KoFTBBTOHo+f455LBi72RXJnCJbY5R3vQVcYFAKdq4rhr3DaqoYFwCGcLlSvkSzo1BHcv241vs+NmB7+p/YnjKVk31v1hY9rebxrJqz2a9Jr8NhCjgFe3tPtbrt5/TTbL7IAS3GV5EmyN76G7OfhF1NEsDzD0lvSt/uK9L5K9kwcPInCCEnVAIb3qTUoxSEJPuxwl5fla9qzPL+cNfclgRgq9MIai4vEvLN5KR5UWjZS3fkeuoHW9o5IAx4I7ApiUgKh2uAvTxAEttMiB4JM1U883DrEr29smRmMRMAv0N5xWlsoqB31ccuywVNTV7HHmNLOuJmvghCOEWvwqiXkzWhjiY63cJfJE57h+zzI+4tovmYWIIkxfSTszOus1TCM01q6JWcuvAZW5dRW01AvcbSoC6x3itdzJfLLZvtGbBVYFloPAer9+B0KBXThim+UxHlGBm4D6RVEnrKJVCRttyUuQFPSZAXlUn1T5VACJtRHsQtgpuUmYaqRJ4EwEMCaC+a8X0fklbmGlm/KzGamW9RQ7Sd9Rnr7n1Ey6GUB+kDx/ZjcQw8w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lakvnfzFShlUqYK9ZV8ixTix/rIv2PKgQnTuXzFtthtweX9s9CoLdbxKWaEwZ0nU63aB9GOMLaSoowMFSMkC7U+5z3Z92XyD/sur1gGde8WdxiynJtGdMqdhIGQI65BH1yeE0DAQHgFWD/Wjx+6b2tYV4MEs4YZL3Zij56qcREd/me7h5qaYyqhTJ9RYTk2ozU528WJF37nPNUvJM3eZnKwA/BZQr1VrJW1LYexKRN+qe3M83r/jWuVVuJ7f9G0xRLh17zcPIIJqZxif4VPZJwZqS0IizPh0hpJmMnrQUFyY4Lhl2oywg71LKs182OUczxzgvsVCLmOAq5YAtGCcRrqmAIbOfXDi7TjvxOp7qszhShwzOAVBgc9X7vMABZEwfmVQkk6EVZkJbsqSeQPgNyIFDL/2nhOBVW1jpMbJQVWR+zo1S0gsHFYV3qbG42hI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:29:18.6925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46daf884-059b-4718-6e3f-08deb1a3a7de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE
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

Add zynqmp_pm_get_pmc_global_pggs_reg() to read PMC Global PGGS3
and PGGS4 registers via firmware IOCTL. Supports IOCTL_READ_PGGS
as the preferred path and falls back to IOCTL_READ_REG for older
PLM firmware versions that do not support IOCTL_READ_PGGS.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/firmware/firmware-zynqmp.c | 54 +++++++++++++++++++++++++++++-
 include/zynqmp_firmware.h          |  4 +++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index fb583580ebe..ea14ed4ef95 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -3,7 +3,7 @@
  * Xilinx Zynq MPSoC Firmware driver
  *
  * Copyright (C) 2018-2019 Xilinx, Inc.
- * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
  */
 
 #include <asm/arch/hardware.h>
@@ -197,6 +197,58 @@ int zynqmp_pm_ufs_cal_reg(u32 *value)
 	*value = readl(PMXC_EFUSE_CACHE_BASE_ADDRESS + PMXC_UFS_CAL_1_OFFSET);
 	return 0;
 }
+#endif /* CONFIG_ARCH_VERSAL2 */
+
+#if defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL2)
+u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr)
+{
+	int ret;
+	u32 value = 0;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	if (reg_addr == PMC_GLOBAL_PGGS3_REG) {
+		value = 0;
+	} else if (reg_addr == PMC_GLOBAL_PGGS4_REG) {
+		value = 1;
+	} else {
+		printf("%s: not supported pggs register 0x%x\n",
+		       __func__, reg_addr);
+		return 0;
+	}
+
+	ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_READ_PGGS);
+	if (ret) {
+		ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_READ_REG);
+		if (ret) {
+			printf("%s: IOCTL_READ_REG is not supported : %d\n"
+				, __func__, ret);
+			return 0;
+		}
+
+		/* find node ID from the pggs3 offset */
+		value = PM_REG_PGGS3 + value;
+
+		ret = xilinx_pm_request(PM_IOCTL, value,
+					IOCTL_READ_REG, 0, 0, 0, 0,
+					ret_payload);
+		if (ret) {
+			printf("%s: node 0x%x get pggs register failed\n",
+			       __func__, value);
+			return 0;
+		}
+	} else {
+		ret = xilinx_pm_request(PM_IOCTL, PMC_GLOBAL_PGGS3_REG_NODE,
+					IOCTL_READ_PGGS, value, 0, 0, 0,
+					ret_payload);
+		if (ret) {
+			printf("%s: node 0x%x get pggs register failed\n",
+			       __func__, PMC_GLOBAL_PGGS3_REG_NODE);
+			return 0;
+		}
+	}
+
+	return ret_payload[1];
+}
 #endif
 
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config, u32 value)
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index f5e72625e53..0e545e3db1b 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -470,6 +470,7 @@ int zynqmp_pm_ufs_sram_csr_read(u32 *value);
 int zynqmp_pm_ufs_sram_csr_write(u32 *value);
 int zynqmp_pm_ufs_cal_reg(u32 *value);
 u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
+u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
 
 /* Type of Config Object */
 #define PM_CONFIG_OBJECT_TYPE_BASE	0x1U
@@ -534,4 +535,7 @@ extern smc_call_handler_t __data smc_call_handler;
 
 #define PM_DEV_OSPI		(0x1822402aU)
 
+#define PM_REG_PGGS3	0x30004003
+#define PMC_GLOBAL_PGGS3_REG_NODE	0x1824C005
+
 #endif /* _ZYNQMP_FIRMWARE_H_ */
-- 
2.34.1

