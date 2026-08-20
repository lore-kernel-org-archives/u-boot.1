Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD96C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 606076085F;
	Thu, 20 Aug 2026 15:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2j1TLFuSMaaR; Thu, 20 Aug 2026 15:34:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787240079;
	bh=JPxPKPtLGiiZkc7gt7vVc4XLLQhRVpxODa4eMZ8eaj8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UrLzgFdSMbQ5ubp6PcViMt30D67I7xtOYuNOCzRcUtnAKSO6FtFw57SUfxU+IC3bP
	 fDC8vxymKEIAfjP8mLqencNAH13SuK93wrJ3HUz5LtikLaPL9tlEItUoQZxO6Y/Ui2
	 9Wc4/hMVn5wY+sdkQlnk3DIqNhOuuOzuTCF31nF3hWTiKti9zO3a0p9NGPW6Za++BB
	 tNL31si3RgTxk9vJq3XoVrnEtAKe98kEINju5lA/8iurBwx7RIwkmADLIKZbCQuS5b
	 D4s/6tES7R4+F/BqXqKP9M8NJ43Qenok/LOe2cUfH5y+/lQwmOH5+2RzSAdILL8r7A
	 kvmaRiIZ/F7Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 788DB607FC;
	Thu, 20 Aug 2026 15:34:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC3CD29D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F12080BED
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oNN62_05fz8p for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:34:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2LuL/3ML
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7D3F80DF1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsvmhEKdPEMdibmkkYiYS0oUQLHiTBGSiHWvL5rGSaHcYa+Wj7GQ4v/ei3IvlUURSsg+kKMpXj7Ii4ggklQsGkQmLiuepVJzpBX+JBP4hquJGsgtL/px08i8DnFBBs72gXltctjIsP6UMhCIXvTdy3C/jqyjIvutqRVfgtngSxDSQme8WjeayTrPvhAGoRUDEh1B7ZIVefx/SBveKdjZrcXAyGp32wz0J29N48CDKgGfznIuZUAVM+auqOsNnoiUSzf0qh1u1WwGZVOBtJrIk+IYk9EpCjThsBw3VMUgAGa+/CkxPLJfLG87cURxcgzBXmfgy59W9ZRIQ5PoKRJZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPxPKPtLGiiZkc7gt7vVc4XLLQhRVpxODa4eMZ8eaj8=;
 b=E/jsI0msmbQvqJeVMNTh72NU64QIqJfg7u3kDbH/7c76D0nXufP8H4eBN4R5HnQW5rvnTNusM0cLQ/IacyykHxEzsBvlUKvJy9GCSBa26VBRntR/Ull3vvTaddL9Zx3HKY2b+fMkSL1UKmgA/+F5r+vZzVMfZLufr88OxfzcELPvaikVRZrQOBOKMB/fUZgaOrIIAfCEk9+ZClmWhp5kej1Nt/sfpRn/tXb4bNi/WG2lbMf4V2OZYZkG9/dY1/OiB3JwDf8Lpjyxn56qR8cJ3JL4mCyleIsf8ggOl7WSXfhwrombn3gowKprewW3vRcY4nA69UI3EkUpXnnxbVKesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPxPKPtLGiiZkc7gt7vVc4XLLQhRVpxODa4eMZ8eaj8=;
 b=2LuL/3MLL0eLKenClrWc3FV1IbkhXbY57iLp6ioYhPj/nQpJwXEkpPXBQne7iNporPWXofktBbC3fL0BwJFGmLgT6jBP7DS12UgsNzjYTJ7uGjyhmhoROzVt/w0zk41aEotTeTCv9NseTcqiGhU3fUgrLE2SLwMUSaovDPnzgA0=
Received: from BN9PR03CA0161.namprd03.prod.outlook.com (2603:10b6:408:f4::16)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 15:34:24 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::12) by BN9PR03CA0161.outlook.office365.com
 (2603:10b6:408:f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 15:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 15:34:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:34:20 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 10:34:18 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>
Subject: [PATCH 1/2] reset: zynqmp: move reset assert helper into firmware
 driver
Date: Thu, 20 Aug 2026 21:02:38 +0530
Message-ID: <20260820153258.261076-2-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820153258.261076-1-akshay.belsare@amd.com>
References: <20260820153258.261076-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f01082c-c84d-46ab-fbc8-08defed08372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|6133799003|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NXddwoNOKf9IxSVbTxzxHCFCj5jUa6mKNs/2pd3mCpXS7kGYK10dGzuyLR6YIKSK83Uu/KyDGWlHXKR1YYFLyDu0z7ravxQ/p2zNN8jBglMn+YSBQKMKTq8EIuRN0cg/ra1D1zdDeVODh50B9y1OjwgVkLMxMIdtEbUbfdLWMczB8WAtdkt1HtOfxmMHc0X9P7kcA1WepVExBvSPKlVSIrdta8cHBn1erOxKth0z5sT+V65Ks63p33WQjM+ooTKgBTKbWd4shLRGz/fWQNVBMaYusLDjIUNA7CIP0fwUKbroA4vq8fYtqlaJv06edYooOxVR6k4C6jhDntknJv7KxiozJVMqMy9RDjs4foWdRf0L2NU9e+7gkNt6wy+x4ew648Py+gvQcu7YvU6l1LWqdInaEjE0yYTLqN+YD8/JI5cN9/buVowrYwVBGjZR2C2a1C5OuS3R9RluKXcRIX7xEa2YcRayvKq8Cp//Z/e7BK9t2bZtk03tx74umXbYnNblCk+6gaYDbVRqcNgz9CHYEdXTf43Pc/JrUWwdkzgfrIJpSpble8JKEPRLUXYl93ySrfuopayQKmfOlQATqR02mX2F8X99rxALr4+sS/E3g3FVsmBRJIJF/2FVIwsP9izuv/gbWE8vpI3i3FVG5ltqrHPxQVcB5ZVOYNyR5C7sUZNCHHaU185Ph7D1oppJYuWGUtLSankvEnPFQDyxh7Da8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c2NbOHM7PyJbC+GV2ncT810rpZRxIRP80vhRG6hcNJq1oLKr3Gi+/nCgrK3NdAJ94r5AVGmF8qdlLY+aZQwzb+KjiyxsztrNxDuNff3CasDag5aYrkUaTYwAMprLAr8lKtczYJ/OkBkLhePtPxWyaBy5Qiw7cZNLdplP0drGRdXXvMb/Gbrw3WzVVAQR1SADu804wQAx5eqj//4tsoDPQTjlobaqcJx6QrkLkRIZ9V4pDQcA5L8iR0VzEJ9Yf2G+oJCUXlNcalAkdWAUnWWPIpl0f51iNV4sBhgpbHhSQUbzfKiq7v9CkaxnwIKnaR5I/EFLI85RwnLkb4p1JA2Fw8FQt5VE3s1PED0EFHYKdaZtotsij9G/wTj3V2IF0DPnWIlWIJZ149KHBPFh6NbcpuxYcekmdeevSUP97GHvNCdzo2MMf6qF+5DQ+o1tQhlE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:34:24.4758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f01082c-c84d-46ab-fbc8-08defed08372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
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

zynqmp_pm_reset_assert() is currently implemented in the reset driver,
requiring reset-zynqmp.c to invoke the PM firmware interface directly.
 
Move the helper into firmware-zynqmp.c and expose it through the
firmware layer instead. Since reset assertion has no non-firmware
implementation, this keeps the firmware-specific logic localized to the
firmware driver and simplifies the reset driver.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 drivers/firmware/firmware-zynqmp.c | 7 +++++++
 drivers/reset/reset-zynqmp.c       | 7 -------
 include/zynqmp_firmware.h          | 2 ++
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index fae66ccb3d8..9f5556751be 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -175,6 +175,13 @@ unsigned int zynqmp_firmware_version(void)
 	return pm_api_version;
 };
 
+int zynqmp_pm_reset_assert(const u32 reset,
+			   const enum zynqmp_pm_reset_action assert_flag)
+{
+	return xilinx_pm_request(PM_RESET_ASSERT, reset, assert_flag, 0, 0,
+				 0, 0, NULL);
+}
+
 #if defined(CONFIG_ARCH_VERSAL2)
 /*
  * Poll the M-PHY TX/RX config-ready status until it settles or @timeout_us
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index 2b58f3a75b4..eb2f6d0bdfe 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -18,13 +18,6 @@ struct zynqmp_reset_priv {
 	u32 nr_reset;
 };
 
-static int zynqmp_pm_reset_assert(const u32 reset,
-				  const enum zynqmp_pm_reset_action assert_flag)
-{
-	return xilinx_pm_request(PM_RESET_ASSERT, reset, assert_flag, 0, 0,
-				 0, 0, NULL);
-}
-
 static int zynqmp_reset_assert(struct reset_ctl *rst)
 {
 	struct zynqmp_reset_priv *priv = dev_get_priv(rst->dev);
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index f753a67ac27..86f3ccf8932 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -463,6 +463,8 @@ int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_mmio_read(const u32 address, u32 *value);
 int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
+int zynqmp_pm_reset_assert(const u32 reset,
+			   const enum zynqmp_pm_reset_action assert_flag);
 int zynqmp_pm_feature(const u32 api_id);
 u32 zynqmp_pm_get_bootmode_reg(void);
 u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
-- 
2.34.1

