Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ED0CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 18:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FEF6848D1;
	Tue, 16 Jun 2026 20:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="gs4H43WP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C7C984704; Tue, 16 Jun 2026 14:52:02 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDCBC848C5
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhG3cGUbolc3NcZFspDegsALW4qjAneehM7JXQrmggRplE175dNj5cktK+WqRNzNJoM/abNzJgpntYJPihRZWCGZpY8UHWE1VwpvDF/9fYdPKhzCRxnmzLm2L+ZCGQwQt07uFm5PZ4WFAOIcrdz3g2UMulMwVNr5Gf8jh9lvtNLZd+iCjgZkz0T9jEUesTlMsMibbpk1Lli1IWLAFxO2sLaK7NvUzUOs1QgB2PFMbHGsXDT8uP8jea7YlvTX9/Y8TZxmC+pjSBsYd0AzW6G4LIxKaRBbghkkWASs14N4VePveUZs2EeFHazSXW6Hi0uxGz5qrLYctDX9GvwauVIFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7752FDYr3/NHl4B4dvyWMohj1BzB9ypJEMGdpJzk/CY=;
 b=jsGh0PU0gUWXqpxM09aOvdsYlYbtEgIqptQTXMwZAFP9fYdiqhLZHu6nzjhv/bdTVnx3ZdympctIGlIB2yI1B0tNfSSaGXiwaLqU9jhlMfHIFPWqtMEkS/QErtzLxCGginOIITroNifvv7109uGGJHh8NDFQiPvuog+2CgKvQheipXHUZ7zFzFJpS6EJyX+/gUpdyYzjbq1y1NLf8UcZ9ExdNRqW/4ssGU41BptQls4aOpW1IliuAgMSmXBc2ErVBmljpqnQtpuyq8iXTzSVe8BkghqxMBe7OYBATWWMi4N9uGXnO6Fs8aCftxCxJx5atC7JIOoSCEDM61lTmiwe9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7752FDYr3/NHl4B4dvyWMohj1BzB9ypJEMGdpJzk/CY=;
 b=gs4H43WPVvxguy6DzuH+3dd/W4OamwT1EdeKvQbEk8I0+E8GuqqHhYcP7kAZL1MtZAs02rhzp+D6innPTh2mmbe20Kkbs+Ybmr90IU6dwIL4vqnmb2huWtyf0hspIDzAn0HNWzHnctOHaJuEA7plhjRb5n1cHy4tJYOXrWaWhmqFoO4baRnMu1f27bBIIL6kw+rxMfWA8WqQflnHUve3M5cvlerin5uVmBevnWE7TUjdFTm0oUBWzTa3Nnm6xzhrjlEgukK0EfZCNzJsr6vlnB20LS8BwzemOgXWkN1s782fhmW4rY9ni8w9liW9/PoVZHibqollVCwDHqrZQcBOxQ==
Received: from BN0PR04CA0056.namprd04.prod.outlook.com (2603:10b6:408:e8::31)
 by BL4PR22MB6051.namprd22.prod.outlook.com (2603:10b6:208:5a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Tue, 16 Jun
 2026 12:51:54 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::b) by BN0PR04CA0056.outlook.office365.com
 (2603:10b6:408:e8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 12:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Tue, 16 Jun 2026 12:51:54 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 1F84C12910;
 Tue, 16 Jun 2026 15:51:52 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: brian.ruley@gehealthcare.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: shofiqtest@gmail.com,
	festevam@gmail.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 3/8] clk: imx6q: add missing pll bypasses
Date: Tue, 16 Jun 2026 15:51:36 +0300
Message-ID: <20260616125147.3710024-3-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|BL4PR22MB6051:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c0d93557-76d8-4def-c5a2-08decba60b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: u+VfVKEFUzDdbRo1PuEuHUCjdXPLmhKPIXBo26idXHCNQahXnge0WwvXbCDidgRxtmnfJufIXRiiuAAUldQPte5SFM8zHBA3GrNIyQ28hFBQhRnq5MwGkL+ltHy62L7DXvyw/w/Hiq3BfTWgEIFpy+dsLwfFieHlzjqC7xHcwa3ERcFapxbCKLHee8izipTPMUGo6UAqXqRAewxPkbczgsbkgTTapi1KyVxhBqYalCYldgSylDTPdDv7LuFRlGnk/81tu3G0nH+V1kF46O7l4yuiy3cp6iro1oRr05v3BN6I9dBUt1TEAPoanyGUNFnzEeKrIL/fe8SJUA6Q2anUES+nxREUPpyKnDjokQQXTHOR/6uiwlfYe2Z6nXhJOT0qudcHPpcTYvAqTOjHWOfYBMk6yipg/C/QXix6fHDQdsvIN+HUgxjmnuEdj3CPoDTS/S/i8n5vs2EFftl6InOejoKUCqZayV5Uxha7VdeTIePBQEoT35hofAz/BqQ0U4hCqDBtqGQkwR/QVwo/GwjUhMd8MPb/ufkh7k+zFklecflHpRycXqsc2MGvsu8Ub/LxrW3qJQbUZ2+YzcNSGZAGwThxCKeE7zQD2c/MezFSdqujs3PIGboNO9Zr6cEan3ZtSjt44x1Ez9rCX7t9l61BQZwOs6spuJGAeTFRYCmZ8dXBZS4Pf0zfwHd1KyY7K3bdGNXZAAFDsm6CZTLv4uGqFm0/nT/pfwhB+JF6hYi38wo=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lAgalcTVQMg6x74mXVDmPl7N/27v1hDVyHZlMqYCi43YhPt4MuA/4sW9elgIy575M65zV23/O8v2cCh4oUlaEZEmosxn6LtNT09I3zFBEEQAb3rO7/kdbnmtUfyqXKHLnq2AoV2l+jnBCow2m5Qe20KcXsfFKielNSk61S7V3KiAkuoX9tuqpGWT91hdUnFm4NjBEIHxCBGF3AX2AixdMG8cQBR1i3p8bxNDHLQbx/vpRU+RTSf4h8jwq3JfxC4+2AY/WV29sNPia2Tfp3m2I0BB6Isl12s9XbMHR64wpWOQuIFsFJxaMx31FZUAPLc7hkJtVelhqzXzXEbgB+mm9PzTaTaJs5a66gZk2LrPlIggcDUoqjQboRYYhEE7dJrCBYjUHK7gO9qsGWsylkk4OTx085ARhVwEmJojXLMrSVg7ym4tjF4RPS0+EiH6HU16
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:54.4372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d93557-76d8-4def-c5a2-08decba60b34
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR22MB6051
X-Mailman-Approved-At: Tue, 16 Jun 2026 20:53:56 +0200
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
 - Fix unsused variable warning
 - Fix checkpatch findings (const identifier, spacing)
Changes for v3:
 - Move anatop clock selectors first
---
 drivers/clk/imx/clk-imx6q.c | 90 ++++++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 67c0261091d..9ee3109bf1d 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -46,6 +46,33 @@ static struct clk_ops imx6q_clk_ops = {
 	.disable = ccf_clk_disable,
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
 static const char *const usdhc_sels[] = {
 	"pll2_pfd2_396m",
 	"pll2_pfd0_352m",
@@ -123,27 +150,70 @@ static int imx6q_clk_probe(struct udevice *dev)
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

