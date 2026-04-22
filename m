Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CC2F9EDC0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 12:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108278429E;
	Wed, 22 Apr 2026 14:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="sb7cOvBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D9F84286; Wed, 22 Apr 2026 11:47:05 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88DB3840CB
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4bnQ0WGGc12WAl8fOBGaRJzNAjxgP8zlIpebFizAOdLgtecu/BXEw4pcoyT3mO8Ex3xWGivNCeFgozSZNGsJtlwVnv4h29/Us7Hd9ByFLXAePvnaUMtr8fc2YpDIXcu7Q4nNU893rSXnKHZbLEp5oUddDGrbjt1q9UU8b+ghkisNv7eTqqSYGKKZgiSlopQZRGgfSstNzBqbB5B7wn/2j65PcVd+PEqCXqgGLxvSog2banCjh+8HTRBzTN0dgR34TyMFvSGPQgxVz/C4TcN4lKwBOXgl61PUhLB1NPWxBr6KUzvNJQ2L17ymnptoqi3GErdbkcZY5+oMCHPIqz7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnqgJeRHYBlsn+amyVsGuZFr3agFOVsf1QhRQUHwPOg=;
 b=x7/rn1VE1VS5cBvrE5oI+PRu+U4lt0uOQPRqLe66/1fUcoQ5KPUoH1HZlbyC31rc2LKuO2l7LV4PIZImaEJS5L/K71+Fa+9QgcFJhXItLpl+3hQmzCD3pCl0VfPXOwwEY7q9ALhw5jFfad6D2ROQUpcb2kIqDOdzUqXFVWxA/DlHJ3/9J4hMYP0oa9p/4SNRtTnyu5tgTXdEQqHee67A0+PQ4lk8ABgkhjxLI3IJLD0wDoQV0iN5PaVnTlYP7f9UROrpbnvEOfSib0FGHdXpBtyAZTBaQzLeNqtRsMv5+XiAViaXJTgF+t1q5rKjts01RMb+6Zn1wWiKaRrLSMxp/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnqgJeRHYBlsn+amyVsGuZFr3agFOVsf1QhRQUHwPOg=;
 b=sb7cOvBSjIbfJWqmFDxQ4nqKWg16ld2O/xcj4BDpNqretWbJ7UFifddMrEKEuFwCD5YT+UqiB6O6M/R+xh6jNblZbahBfuTDTm2vZup5A2F3cHpV2RYh3z92cLrnxdjY/OpwCoHdIFIBYMzEYgxtLPkXa3sgigsdrx/8E1fO/LpUp2EFgKOYG1np6DKBnlADTr4IA4jr4R+as7rh6UA6YkPwMvvHQASEFxVSKjiaD24ygwiSA9hsWaBoUUBLa8xxstjU659O9jt71JBsPjxFRKWAKUNqPLdeOafCospOvqUezq9IfBVKh1xpQEkwUU3qZ6ND1JFTvqvrjgvvSHp2DQ==
Received: from CH5P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::17)
 by DM3PPF2F3BE8063.namprd22.prod.outlook.com (2603:10b6:f:fc00::e17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:46:58 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::79) by CH5P223CA0005.outlook.office365.com
 (2603:10b6:610:1f3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 09:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 09:46:58 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 7D5E21319B;
 Wed, 22 Apr 2026 12:46:56 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Lukasz Majewski <lukma@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/5] clk: imx6q: add missing pll bypasses
Date: Wed, 22 Apr 2026 12:46:40 +0300
Message-ID: <20260422094649.57611-2-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422094649.57611-1-brian.ruley@gehealthcare.com>
References: <20260422094649.57611-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DM3PPF2F3BE8063:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c69bf364-9058-409d-9c40-08dea05418b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: eM3JBimT/tnommMdv7E4x5I0OtO/8z3yiMouHmwjiVpOeHcL25G5K07MYL5dVg8dlfKpumOYa3/sq4AshyHfTuIFT3Ua5d6TpmgDBfMc2cpotO9KXShsvQ7JHytQgTO4e2fET2XSf81k7Vaj47W7liEi7vqsxR+qWeK4YQPf8dPVVuF+4myL6FT1s4PVJzQDeghJRA9lqpNNko7HrccEEJpxZoiVY5CubULF2eWR/NwOhU47TSSuKo+qyTHv3Ym7sdbiE6987xY7L8+3QUU2Dkr0B33bg2neZfDOxeajQ8vUtnjMayt6qDYQt4oef0Y0oIuw0vevZ7CLSU/M34Pp4w10Q2aHc18MRD5AobN1mYR1zheT4DU3wAtJ31GQI0rt/rfOH9k3WcupYjA2HwOlK9SgHI1PKZ4bmiOyquNgSJDIWEMoYh0ZWhbdY+40ZKxc35tzCA4/ud31tDy6Qylm2XFHVe3thpto+DPorH8k0D55aXbYQXohZeg16vlyFro3Vyt/wWnHmOEQHbFYKPniVJG32H7yS2Ovn0zm+7FeZrcgWV1NNSnCEqyjlhjTg8G6PR3E2fWnuwz1OrIc/QDLcFbiBhid2RqAFcrGPdKmiY4xHO601/h2HUsM28n9nHGauWK/WjajhsFeGQbeo6GOe8rBehpYI9zAQyij4BOzkYeNUzP8ymzQmd3LHtsXcgVxNwYQ/42/kiWZegPAeJE0jfpaHnrRIxgIcAh80qwBxRJ9l57162wYWVQkrX2RG4QiGpKq2mm7afEchUSwQm9iZw==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XIWwNWRFipDfPgfllNvG+TZ94c4YNBCMGJaSFaaBNmL40IJ6r2UIpAxrsomAlt1BYYJd/ruMp2idXIapMhl6mIDQKSwXfmQpbmhovOp8L+TMQtIl1yxIZugzpqh9qQVg3V0Om4xMCBlfE9fDiDKIR7N0xR71h4hOINZaj3veOhzydnqrlfb8uHmXcTmHHiqhJ5N/qJkyxGas05PA6kzNaOOSJDV7GImwL2ArseIIMIVKaQvQwa40p1XuV+Jd/lUOXXvGL1lmUSNHsrORGC59ImzQF25sImTLRhnc12isZUeP+h0Hx0MHyK4EUacLTj1BcssznC9zu0ve5yh2ctszqYqYZD8mHsNNA8I2PF+GgAA4RAWNYDKzQQHaWq/xpvNDfYPum0qn2MEZS3q0cXNsiH1yr7If5oezYSCyUU3l4kWFmZv239AxZDjU5bVfeTve
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:46:58.3480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69bf364-9058-409d-9c40-08dea05418b8
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2F3BE8063
X-Mailman-Approved-At: Wed, 22 Apr 2026 14:34:21 +0200
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
 drivers/clk/imx/clk-imx6q.c | 98 +++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index cd06d211e8d..eadb44749a0 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -111,6 +111,41 @@ static const char *ipu2_di1_sels_2[] = {
 	"ipu2_di1_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf",
 };
 
+static const char *pll_bypass_src_sels[] = {
+	"osc",
+	"lvds1_in",
+	"lvds2_in",
+	"dummy",
+};
+static const char *pll1_bypass_sels[] = {
+	"pll1",
+	"pll1_bypass_src",
+};
+static const char *pll2_bypass_sels[] = {
+	"pll2",
+	"pll2_bypass_src",
+};
+static const char *pll3_bypass_sels[] = {
+	"pll3",
+	"pll3_bypass_src",
+};
+static const char *pll4_bypass_sels[] = {
+	"pll4",
+	"pll4_bypass_src",
+};
+static const char *pll5_bypass_sels[] = {
+	"pll5",
+	"pll5_bypass_src",
+};
+static const char *pll6_bypass_sels[] = {
+	"pll6",
+	"pll6_bypass_src",
+};
+static const char *pll7_bypass_sels[] = {
+	"pll7",
+	"pll7_bypass_src",
+};
+
 static unsigned int share_count_mipi_core_cfg;
 
 static int imx6q_clk_probe(struct udevice *dev)
@@ -120,27 +155,70 @@ static int imx6q_clk_probe(struct udevice *dev)
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

