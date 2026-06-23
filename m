Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3C4CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4556B84A2C;
	Tue, 23 Jun 2026 14:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q/VX82lI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C380E84A35; Tue, 23 Jun 2026 14:55:00 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C77B849C5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rekN1gys9E3YL79Yq4Yf0WS7WTNrqlktX641m/7KiqaNtvYtIfry8YfJC2XW2WtQ9g0VG0D83g+52FG4ht18WwQDg8ENt/VmLe8RiBKKp0Gg7GLBHQ18jhkCp4Um8YBSnLC1z+so1RFaLZyx377rjS4XQx3rQUqF+DykUOYgsLIUVtp6SdeGlcerdcRzoHGEKQPMKXXszZ7mr9MlV1dpbD4t3Ied4Spnq+w0sh0AwJ4bXEKvhQvehyGXVcm3M6v4KSTFiADXBhuzewkJEtgn06Hc1vbNuxiKLRoKOrSYZE2Mr6FYas2jiR6nrdWdlkdjxwBF1F+zcUysPCImpl3feA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xez/SsofVSlU3gHajBSSiQ9nkftMyGi8MorW4JFY3us=;
 b=FRFxqM5tXnj2aMi5ChJMy8/qAVp46ZMzwoFvu7/tD29fOqk4a4Al/JdF2B74vmOUstxdonUVJITrSX2s+5XhYICaL5FNct6yIfBH+14vDKuSxKSP4u6bsyKXh29XGPXlI5bl9G7D+02gvl+6WChVCLzjY8pmFvQivejAVTXYg7OMyOaqbuPmWziLpdJVg/7+Odkx90otxWY43yOFMw8lcrEpiw7sU5r8uyzFAPZZg6weKgp8yWTfLE86sUkLgCCP59Q/x9UBmZ7rxy9dQ+4p0O+fYYf7Wg34cUJBXNyAfJuZD3xa3+6KPp7+TJphXnFJKX4qazWv47CmkaSPhXzqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xez/SsofVSlU3gHajBSSiQ9nkftMyGi8MorW4JFY3us=;
 b=Q/VX82lIdi0bRTVIAqHGBJfQhxZTEd5mkzBfuAUUUWThkVRvcAeCS5er0mnS6u+ij8ootFWNDB21UMZRFe1UASSWx8e8xuRDU8fcmZrak5N/Xx0HzM+Q/zevZEa7bsAsPUDKvSfViaJJgVNLXH9pUj/dRPzBTxy84HfonnV2hFc=
Received: from CH0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:610:b3::20)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 12:54:53 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::ad) by CH0PR03CA0045.outlook.office365.com
 (2603:10b6:610:b3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 12:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:51 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:51 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Neal Frager
 <neal.frager@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, "Senthil Nathan
 Thangaraj" <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 09/18] arm64: zynqmp: Move board_early_init_r clock setup to
 mach code
Date: Tue, 23 Jun 2026 14:53:34 +0200
Message-ID: <2d8f2419fab314b4ff8fd53b846e1dd6151586d3.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3683; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=iTuGQzk3YKxVY6PQGdTNraW5vZbOhnpaQIEGo9oijhg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb7+uO2QeTeP/arjS3dNM3GLjfQ4nX1uidJG7UfRj
 nElq1z1OkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAisQ8ZfrNX2e3eHSSpGelT
 dPJ7sTiPzlyjA5WHXlVl3ihYZ5wYa8vwh3vNyoDOPQfaPwc49V8rXJtly3Xf79HiSYdbHmmVL3T
 vZAQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: f7762c2d-eaaf-4cf0-a17a-08ded1269e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: hwmuP0KAQL0iNlRjPdyYJQKuBDx0UvH/pi4LqyNcCnWetoG5VPrW5DK5qbq9chPgja9jWxUi429+s3MYvMu779pKa91n04cn51P/0Saa9f8byrRnVPV8uClcHIqofr5zmOmcs0Xc812jO9BqCggpGaEzH3tB3HB7Bf7umDwtwXKyEZ8wo8VgpKrC4MhObuT6T16DLGjFztdb21wWw30T7InSCpuM606mK51EYqEW6pC9kesO96CLZ+RuCnFQ4D6MMJX6HlyuPuYn3RSpL4VawQw+59MFT+GUNFEfvQaiOAM39+4KSN/y7s9VY5um/kdb5yZebZJ2AfvYxA85Zc/uL96Wm+nx7JOl/O1gk+2YVMRnwFlkbdt/MvVFqpfJ7NGRjG/leLbzAoSLN4hf7TWUat/t7j9mxUcLcgkrbviSHfCJCSqq7dSKxK7m8q7Tl4nJZxze0inF114ipvcvKYK4JwBbhgmyeccrG6/XB9JrgAkV5Q3J8jYnd4lE1+SgBwraaldHIFBnaYjjCIVrpr7WCM96xtvCU43bgGbAyd0fjuLGIBffIDqh2MRaQonk3a6ZQGy41RFPX73oHItt65ky1/tIzjOl+ElJKundmLTJDgCdA1+DIxC16lHveA0dYlOWCiogIXV54wKq/L+jyjdz2SfH5vTuKlprfrlKqMEoKRRQh/OriglyegH20nAmsHwKJJFTViFUqSAZptMYwGjOVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3MOVNJIWn2/vNA9pb1GgunyDySB6108laez0nDCGQ1IJuZwWaKwXrNE2NIkTaGUR/CXpGswQgISbAef7iOxSUGHA0QOeR1y9rIk3n6ECQfdxgbEWmKEqO42MCaX8/JBAQPVfNhUU/ykkvqBZL9p3PRC6lK5C6mh52/CRNPnH3ht551WjqnqP46ovzoXALuGPEcbuaainrjC0keMn1BhX6EzEiiLE1JcHvZB6w2XMHd9/Mgzbvfgacy6BjIvZd7sHng+XSTxrkpRq2Dc/bPZnLgHXdmT3A9jwY4j1I/8qlT6S13W39nF6WY19x3nAlraxpIJTb3isJB4W2cr+B4GZdaFl4snWAa7h2SxQbBkH3POBjPwPRkWOVf0jl/5glXFk/rLRdzWx1NQYgbbFE2KHEDfIVEf+k7F7HD5RnBPiHmdIOMdjdYGQPMjIEzCYyfB4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:52.5799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7762c2d-eaaf-4cf0-a17a-08ded1269e33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
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

board_early_init_r() programmed the system timestamp counter directly
with readl()/writel() in board code. This is SoC register setup rather
than board policy, and similar code exists across the Xilinx SoCs.

Move it into zynqmp_timer_setup() in arch/arm/mach-zynqmp so the board
hook only keeps the EL3 guard and calls the helper. The asm/arch/clk.h
include (for zynqmp_get_system_timer_freq()) moves to cpu.c along with
the code.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-zynqmp/cpu.c                    | 22 +++++++++++++++++++
 arch/arm/mach-zynqmp/include/mach/sys_proto.h |  2 ++
 board/xilinx/zynqmp/zynqmp.c                  | 18 +--------------
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 5f194aaff9a4..5ab25e385eb6 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -8,6 +8,7 @@
 #include <time.h>
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <asm/arch/clk.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/armv8/mmu.h>
@@ -234,6 +235,27 @@ int zynqmp_mmio_read(const u32 address, u32 *value)
 	return ret;
 }
 
+void zynqmp_timer_setup(void)
+{
+	u32 val;
+
+	val = readl(&crlapb_base->timestamp_ref_ctrl);
+	val &= ZYNQMP_CRL_APB_TIMESTAMP_REF_CTRL_CLKACT;
+
+	if (!val) {
+		val = readl(&crlapb_base->timestamp_ref_ctrl);
+		val |= ZYNQMP_CRL_APB_TIMESTAMP_REF_CTRL_CLKACT;
+		writel(val, &crlapb_base->timestamp_ref_ctrl);
+
+		/* Program freq register in System counter */
+		writel(zynqmp_get_system_timer_freq(),
+		       &iou_scntr_secure->base_frequency_id_register);
+		/* And enable system counter */
+		writel(ZYNQMP_IOU_SCNTR_COUNTER_CONTROL_REGISTER_EN,
+		       &iou_scntr_secure->counter_control_register);
+	}
+}
+
 U_BOOT_DRVINFO(soc_xilinx_zynqmp) = {
 	.name = "soc_xilinx_zynqmp",
 };
diff --git a/arch/arm/mach-zynqmp/include/mach/sys_proto.h b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
index b6a41df1da47..723e7593cf7b 100644
--- a/arch/arm/mach-zynqmp/include/mach/sys_proto.h
+++ b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
@@ -54,5 +54,7 @@ void mem_map_fill(void);
 #if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
 void tcm_init(enum tcm_mode mode);
 #endif
+/* EL3 clock/timer register setup, called from board_early_init_r() */
+void zynqmp_timer_setup(void);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index eb41f84c198d..d50fab4f6779 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -24,7 +24,6 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <wdt.h>
-#include <asm/arch/clk.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/psu_init_gpl.h>
@@ -214,26 +213,11 @@ int board_init(void)
 
 int board_early_init_r(void)
 {
-	u32 val;
-
 	if (current_el() != 3)
 		return 0;
 
-	val = readl(&crlapb_base->timestamp_ref_ctrl);
-	val &= ZYNQMP_CRL_APB_TIMESTAMP_REF_CTRL_CLKACT;
-
-	if (!val) {
-		val = readl(&crlapb_base->timestamp_ref_ctrl);
-		val |= ZYNQMP_CRL_APB_TIMESTAMP_REF_CTRL_CLKACT;
-		writel(val, &crlapb_base->timestamp_ref_ctrl);
+	zynqmp_timer_setup();
 
-		/* Program freq register in System counter */
-		writel(zynqmp_get_system_timer_freq(),
-		       &iou_scntr_secure->base_frequency_id_register);
-		/* And enable system counter */
-		writel(ZYNQMP_IOU_SCNTR_COUNTER_CONTROL_REGISTER_EN,
-		       &iou_scntr_secure->counter_control_register);
-	}
 	return 0;
 }
 
-- 
2.43.0

