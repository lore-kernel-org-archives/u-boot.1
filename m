Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C2DFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFEE8460E;
	Tue, 28 Apr 2026 14:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="l/dBmdnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C9E84666; Tue, 28 Apr 2026 10:51:36 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E28784661
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgqLhNsWnUJS4AAzgFPpkI4dtMhCJcPDE1kW9qN6zmCYB/uxHiJYdoj1ZnpQet28MHssStzTEPCv4g7GbI10pAEnAhjAFNl1sTIPar9a5Uj4VYGtcsmiQxekvwHNnCNRoE9VI5aSYmbeLd6GRv1VKkJAcFu5jh4pYT+mdg1iNplUeGSR+ejB0FOjP2vyR2zU0OYjR0dK7qwgyFMJUclIHKgQoJK00BifBHtBY3lvX4lyOmBAA+y1OZ1jAsDeKrj9fYj5bMG7GzIeqU/X+I8eZOgjDiI976CQKOBPEhDW10i0QUmyIZaBfPoVl3asHM8VugDKAfutDj8kc4VL3jGdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBwpSJitzbSzaRF+IegF2Y7HKrm2RGT9dkUj/sXAjhQ=;
 b=jpNMcSIjTfHGOhOtDCqtf/zGCVeaDx0amN7FdyalVrDP6L/dHRFFU4K5Z5SKAA6MpLK6E6xJ7X9a82qmQNJfvalcNNscUeUGZzQc0VCf9K3kK8eox1/j2q3onLZ1JYYEXs3X9rgi1/Wf0p+GFUpRqwmKLk0cLM6luDxX+/4vT+JFnM8nwOvpokG9CQhYhHPwbTC9OcQDvs0zW20Bkr8QOF7mQuYtYmjpb1CbRzP0QwUPAjvg9by2tupHCc8Y500aKmvFak2uKWRhWUSFrFaM94GqPC2ubOi/NyrzAIvQz4JS6F53P067ijuWYpwOxUQZpemyV3CACroYukabQHLmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBwpSJitzbSzaRF+IegF2Y7HKrm2RGT9dkUj/sXAjhQ=;
 b=l/dBmdnZnjiQNW3nL1Z6/g9Mq9uDkwCM81n60CkoHIXBX2RdsKpRRxkuXTtliBihAfN5gJhBdg4ie3GI67mz7/Rq64AEwjFjcGIpC8yTotap3L7YxoVHhFM8SBUqcZj2hAXSnnBZx1T3pMqOiy4VyZElJjZqzYvZdVqfslC76MGaUwRfkxUrkypNdmozuOhVIOs5YFCB1ZnYT7tgMtGJkugSytqEp/evI8ocAzCNN8CG5EqDz5ZHrKoI0JA2AQU+K1QizwxnK90+/63/ZzOtI1aucmVnfHQ75AvYtpcnADQTUngKSev+k1okOlkqRr+YDaKycpa1vjAp5L0XmbgBSQ==
Received: from BN9PR03CA0366.namprd03.prod.outlook.com (2603:10b6:408:f7::11)
 by SA1PR22MB4183.namprd22.prod.outlook.com (2603:10b6:806:389::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:51:25 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::1d) by BN9PR03CA0366.outlook.office365.com
 (2603:10b6:408:f7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 08:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:51:25 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id CB6421290A;
 Tue, 28 Apr 2026 11:51:22 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: festevam@gmail.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: brian.ruley@gehealthcare.com,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/7] clk: imx6q: add missing pll bypasses
Date: Tue, 28 Apr 2026 11:51:07 +0300
Message-ID: <20260428085117.402523-2-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SA1PR22MB4183:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: be8e5836-f8df-4d0c-1e47-08dea5035471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O0cxIfZH/hyvtpJROEY8oLDqivQ+vtpqJMATGAiVj39RbbtEonYlEbmEKDWtghgduueEhiz7PeuMNBq9kCPXHf+TQY/qVVtSydERzpJopuG/vCXhS/RgVYpgik2WE0E+G0DI5gGOQa02xOfA/zJydX4ieizBepsruna+ucmOxmCFRF9mLUq5Jxh7j9aoCzjKadEzgsB4ImOR+dJmiH98wTnuX6AIyJOxbianjCCsxHVR8F48vMitOAh7ToJ2K6NDH1KiQ9k+AQP0xjIuDbLN2ZEfT8GdrvOBxgCJZgf0zMlizy+r0nnToy5s1H51xp2tkNIMShVYn78SN9Dt3k+Lvcc9IvVhIlhy7PO1iPMMqDmw/LTygjnOMe9sOBcXUtLiUNio1C2YpE7s98h/8fgO3SdtErSlSA6Hw5QxOP/txseQnKAngjzI4F409anSPamZRYnKUUywtjxowZTLkLE8AhOAtvN3HE2akKKPgbdyBKLUX2Jj86S7yOdJr098DrsBL75Mlagti31xhCCVpvSZTVPADFmCX1GM5TNkgTjkConcfyv/U5z8sfO4rWTSBqoSmx24Li39+YXMUjAVGGjaju/drixnq49xIm15sx3iS9GPo+CL4eyyuCtvV8IPL6WtHSt/lnGGnKEDq65Y5+YsK77DBM6ci7hvNZfHNrjqaeMPh1n01a7Zpl6k8HficFNPlOEnNdm7+Cdqwm92DW2D259DBuiFl1D7wTweyLuv/xVvn9JzAX9/Kjnpjb2w7JCvQAdgtKzMXM5fH6fY4Fn81Q==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bNtpuCuojlaj+ly5P6POvKh4q3OUH8HRjRsmm4u+pOUe85+GO4CFSEx1ygLEX9G7Jk99N+3dmJXy6oE0JdFzGqClbAlpbH0kpkf4JDUtgQoH7/2DSsnIiIRr+CEUFhhj/N74QzO3P/IGX1nBuq+7juzuNGqn+nREEysD4mfDYrwGSmNGFY5Qw0wKkYucVISoDwpuvt1gqZv7rlV62+R6s/19diJj2onP8ThXsE8K/8Wygoop/NsWl2N2snvZNm47/Y/Nwzg8ruEhUwdfXhi8KW66XURHKdih48Pf51XLNVLf24U5UW+2gHKEIIJR1XJUYabGbPx1n3suwZjJsU+fvxuywGC5rtaZrqC1L464RFfRVh4Af1JmgaAAg5VETtq5UNFqrwu5mcG3lAdVkPrmhewYBCObNINKQEH9kfNtc9QG8v+miHohw80BxX2Ghua+
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:51:25.0336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8e5836-f8df-4d0c-1e47-08dea5035471
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB4183
X-Mailman-Approved-At: Tue, 28 Apr 2026 14:41:00 +0200
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

After reset, all PLLs are bypassed by default so unbypass them so that
dependent clocks can function correctly.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
Changes for v2:
- Fix unused variable warning
- Fix checkpatch findings (const identifier, spacing)
---
 drivers/clk/imx/clk-imx6q.c | 90 ++++++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index cd06d211e8d..6dadfd9b59c 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -111,6 +111,33 @@ static const char *ipu2_di1_sels_2[] = {
 	"ipu2_di1_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf",
 };
 
+static const char *const pll_bypass_src_sels[] = {
+	"osc",
+	"lvds1_in",
+	"lvds2_in",
+	"dummy",
+};
+
+static const char *const pll2_bypass_sels[] = {
+	"pll2",
+	"pll2_bypass_src",
+};
+
+static const char *const pll3_bypass_sels[] = {
+	"pll3",
+	"pll3_bypass_src",
+};
+
+static const char *const pll5_bypass_sels[] = {
+	"pll5",
+	"pll5_bypass_src",
+};
+
+static const char *const pll6_bypass_sels[] = {
+	"pll6",
+	"pll6_bypass_src",
+};
+
 static unsigned int share_count_mipi_core_cfg;
 
 static int imx6q_clk_probe(struct udevice *dev)
@@ -120,27 +147,70 @@ static int imx6q_clk_probe(struct udevice *dev)
 	/* Anatop clocks */
 	base = (void *)ANATOP_BASE_ADDR;
 
-	clk_dm(IMX6QDL_CLK_PLL2,
-	       imx_clk_pllv3(dev, IMX_PLLV3_GENERIC, "pll2_bus", "osc",
-			     base + 0x30, 0x1));
-	clk_dm(IMX6QDL_CLK_PLL3_USB_OTG,
-	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_usb_otg", "osc",
-			     base + 0x10, 0x3));
+	clk_dm(IMX6QDL_PLL2_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll2_bypass_src", base + 0x30, 14, 2,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(IMX6QDL_PLL3_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll3_bypass_src", base + 0x10, 14, 2,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(IMX6QDL_PLL5_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll5_bypass_src", base + 0xa0, 14, 2,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(IMX6QDL_PLL6_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll6_bypass_src", base + 0xe0, 14, 2,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+
+	clk_dm(IMX6QDL_CLK_PLL2, imx_clk_pllv3(dev, IMX_PLLV3_GENERIC, "pll2",
+					       "osc", base + 0x30, 0x1));
+	clk_dm(IMX6QDL_CLK_PLL3, imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3",
+					       "osc", base + 0x10, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL5, imx_clk_pllv3(dev, IMX_PLLV3_AV, "pll5", "osc",
 					       base + 0xa0, 0x7f));
 	clk_dm(IMX6QDL_CLK_PLL6, imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6",
 					       "osc", base + 0xe0, 0x3));
 
+	clk_dm(IMX6QDL_PLL2_BYPASS,
+	       imx_clk_mux_flags(dev, "pll2_bypass", base + 0x30, 16, 1,
+				 pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6QDL_PLL3_BYPASS,
+	       imx_clk_mux_flags(dev, "pll3_bypass", base + 0x10, 16, 1,
+				 pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6QDL_PLL5_BYPASS,
+	       imx_clk_mux_flags(dev, "pll5_bypass", base + 0xa0, 16, 1,
+				 pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6QDL_PLL6_BYPASS,
+	       imx_clk_mux_flags(dev, "pll6_bypass", base + 0xe0, 16, 1,
+				 pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+
+	SET_CLK_PARENT(IMX6QDL_PLL2_BYPASS, IMX6QDL_CLK_PLL2);
+	SET_CLK_PARENT(IMX6QDL_PLL3_BYPASS, IMX6QDL_CLK_PLL3);
+	SET_CLK_PARENT(IMX6QDL_PLL5_BYPASS, IMX6QDL_CLK_PLL5);
+	SET_CLK_PARENT(IMX6QDL_PLL6_BYPASS, IMX6QDL_CLK_PLL6);
+
+	clk_dm(IMX6QDL_CLK_PLL2_BUS,
+	       imx_clk_gate(dev, "pll2_bus", "pll2_bypass", base + 0x30, 13));
+	clk_dm(IMX6QDL_CLK_PLL3_USB_OTG,
+	       imx_clk_gate(dev, "pll3_usb_otg", "pll3_bypass", base + 0x10,
+			    13));
+	clk_dm(IMX6QDL_CLK_PLL5_VIDEO,
+	       imx_clk_gate(dev, "pll5_video", "pll5_bypass", base + 0xa0, 13));
+	clk_dm(IMX6QDL_CLK_PLL6_ENET,
+	       imx_clk_gate(dev, "pll6_enet", "pll6_bypass", base + 0xe0, 13));
+
 	clk_dm(IMX6QDL_CLK_PLL3_60M,
 	       imx_clk_fixed_factor(dev, "pll3_60m", "pll3_usb_otg", 1, 8));
 	clk_dm(IMX6QDL_CLK_PLL3_80M,
 	       imx_clk_fixed_factor(dev, "pll3_80m", "pll3_usb_otg", 1, 6));
 	clk_dm(IMX6QDL_CLK_PLL3_120M,
 	       imx_clk_fixed_factor(dev, "pll3_120m", "pll3_usb_otg", 1, 4));
-	clk_dm(IMX6QDL_CLK_PLL5_VIDEO,
-	       imx_clk_gate(dev, "pll5_video", "pll5", base + 0xa0, 13));
-	clk_dm(IMX6QDL_CLK_PLL6_ENET,
-	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
 
 	clk_dm(IMX6QDL_CLK_PLL2_PFD0_352M,
 	       imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0));
-- 
2.47.3

