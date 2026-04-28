Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F02FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 426CB84605;
	Tue, 28 Apr 2026 14:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="sNgZhCPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57DEB8465E; Tue, 28 Apr 2026 10:51:36 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC5C84666
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za/eTsgGODTUMPuLrtGBq/L2sUkcNZg7qj960f1ZIOizJZVqgIhIgE0BxSNDJx2QZD2qw+buycjuv76dxAsdkRzGHmZf4yloqlL4uqxgvwHjVKb96/vrk2o+S4in9b6/TENmxUJwPm32mzdLdSovlUFCvq9dBjm8+VVedfI9NfXb3gC9OQkWPfUSmKhQ0zq+dRUmJz0zUu7X/fkfx1d5FRsevyE3IHoh5P22GyW9cLcXdeF59okLAt1M5TXd729PDHJuMyisW8QcdynjcfWgKJwR5ogOenaigI1oW6Y+1haufGZ1xbFQRcAaOxZ9YPG2yMzs5j3LiyAirYhqI7/OGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Pk9U2GNAV3z5S/HAmZwBdALOZO5r5QpiV8e3ohD9w4=;
 b=pnyd4rfp1/CCfpwVQMDyKlJoKGCybnqPsJ6E5D5mcRRKKxmyVV9dbyZFqfNYn/5lAdQiAX2V811E0ODhNJPBNz9qNS3Ftth8xkJ/myT9aE5P6ExQ/QT7guLr41/qsI8qH19a4cMPhPCOZac40w78fk+GLmNAujFHUlbuWnXpUTnLynD1IpL4MT0M2nvIY0vXlR6a+7chY0ehzD6oYQyZgEDz1xUXaxZcHP4792P2jmUQeD+rxls5/XTDyNRDiZcGdb5A72zBZir7Pqpr72GNk4rm71BSREcOSMG+vS6GIOg1oPWdYHGNCNtnwb/y+4WXv14qsyoIWFbdLWT8HobM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Pk9U2GNAV3z5S/HAmZwBdALOZO5r5QpiV8e3ohD9w4=;
 b=sNgZhCPauepv5788NvYR13NU+U3sQ2Mtk70H7Rta6XhrL+CTpm6iPHqLRdRN0rlBxrR38Tkuz3BkTrpighR0j52Ezm5aV8QV3erPJVTMgGaSJUy8PpvUqNtp3ICbLcB2s3N0WrGIsM4wptEVPBMnAbev/9xAAA2fmE2SbUseopkXOtBpgoQIyOtiN3kFoBQ+VBNy0dvmmgkAQgbxLjvvElv7VPaPeVxfPjXZ7dDoOgFbBuZUfN2zilaLNJ6Y3f/w0wRZJZV0elqhg7qoMA23ni0bk5+wI9NkKBIgKmRNfSQJeenW6cAbMG43n+OcU/hOf3auAblDnYpWc2gowyzYNw==
Received: from BN9PR03CA0715.namprd03.prod.outlook.com (2603:10b6:408:ef::30)
 by LV8PR22MB4711.namprd22.prod.outlook.com (2603:10b6:408:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:51:28 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::88) by BN9PR03CA0715.outlook.office365.com
 (2603:10b6:408:ef::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.29 via Frontend Transport; Tue,
 28 Apr 2026 08:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:51:28 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 534801290C;
 Tue, 28 Apr 2026 11:51:26 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: festevam@gmail.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: brian.ruley@gehealthcare.com,
	u-boot@lists.denx.de
Subject: [PATCH v2 7/7] clk: imx6q: use clk_divider_table instead of fixed
 factor for pll5 divs
Date: Tue, 28 Apr 2026 11:51:12 +0300
Message-ID: <20260428085117.402523-7-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|LV8PR22MB4711:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f8bdda72-6a30-4b15-2dae-08dea5035675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: c+PUWm/laM3dX22BFbFDpIr9J/YuGGY7elNzP/qu5agIaAe5///Ja+fBBRjJdSeC0PeAmQEnQ+rINNZGJOf4qwlrhpGkqpfDLAhS8x4PPa4Ws6/Hl/HTtfaXI8rLdcfyaXh/+I/e4l3fFAkRs0pwbGnSIQi2jgnnRYief3D3mbmFDCUvJ+g/leOqOZv1JoqqnYqzlTgJ2yksQixdHLBRa6m5gu1YCEboBr+5BYhFQD8DrPOlHDkFXh+AB6M4LqT12kk2GgseaZ8L/1XRiZ9dWwD1Fi5KaZWF5LaGNYMGUuPAcI74+d8gqBysYUqLWb+JKGpfDE/zXB+a9fyShODvTaGm1jSNeeiLJtW7PyhOuW0WPo6FkdWcr6Qvh5AWHkFFMfwPcJAub+K2yzfZfxpXPRZDvXrLxq9cf6PjdJmkNuvTKbOPAcwTAdPH09RT22Vs1JNCvDIxtLVJHQlo/7T0DNsvjYCriY4fst3g2nNTcAjOJW93uUtlwhcNWqEWbM73ok89gb6k+W3d1aIIXyderecB8YpZwTkQsrVBrkHir93JdxYK7AVmBJAq93j9sRFG5VLIXBNCtFq2NCHshOVAL7ktiMaI430ati2pxSfRtD68eRegj5Yht1WFOFvxoSuCoEl6j0JsFKyOdIv1fG5B4pIp6zGtzpr1im0CIGsB9Qw2QD6Lxj3ShAd7c5Ci9Cbj8UqoYqhuRbU04ZAU+/CL8GF+TGwLeNizbXEkOFsYVSL+adjFazIgk2Hc906wXSQiiisqc3vzb78n8p/wd4+CtA==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J65axcEIyqyHxsRCWfcala3f1dMFsBxtRb4i+I463FHPGchOwrBQ9Ry54OoiRTKXniRe6qxyUlp920MjQnHTcc3WQ04iXC87lch++JhBRk26ujAYVfP1GSH3EW2rat8K6Vd/eYT2sMWcqoNHqFPFu+b4XG5+uuPiorsKTCyt6LVMn7Pdnxxh/HjausA/XyknDVM63dqZT1BW5fcDZFOrs5uj7aaCTZo50XEEPFK0wtpy+s0eaBixXUSCDCnCeQPAre466K4xsb1owhx6shuOuhhmPucgoM9W0SOmcPnyp6aeOd5c8wJGuN8Y5n5irp7h/dh5eS92ndAr4FjHq6eECm0Z8VCxB0yzmRH3tV6TYaDI8NbWrCp+/L/SxB5foQP3ApCFyTybl6vqmiMIA0szLeVltDGEWX6P18LCHLXXVa3a6JV6otSHIZ2vwR63ZzB8
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:51:28.4682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bdda72-6a30-4b15-2dae-08dea5035675
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB4711
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

Now that non-linear clk divider tables are supported, replace the fixed
factor implementation with the proper divider, which allows more fine
control over clock rates.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
Changes for v2:
- New
---
 drivers/clk/imx/clk-imx6q.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index ba039e56227..a4649a1a9d9 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -139,6 +139,21 @@ static const char *const pll6_bypass_sels[] = {
 	"pll6_bypass_src",
 };
 
+static struct clk_div_table post_div_table[] = {
+	{ .val = 2, .div = 1, },
+	{ .val = 1, .div = 2, },
+	{ .val = 0, .div = 4, },
+	{ /* sentinel */ }
+};
+
+static struct clk_div_table video_div_table[] = {
+	{ .val = 0, .div = 1, },
+	{ .val = 1, .div = 2, },
+	{ .val = 2, .div = 1, },
+	{ .val = 3, .div = 4, },
+	{ /* sentinel */ }
+};
+
 static unsigned int share_count_mipi_core_cfg;
 
 static void of_assigned_ldb_sels(struct udevice *dev, int *ldb_di0_sel,
@@ -338,10 +353,14 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_PLL2_198M,
 	       imx_clk_fixed_factor(dev, "pll2_198m", "pll2_pfd2_396m", 1, 2));
 	clk_dm(IMX6QDL_CLK_PLL5_POST_DIV,
-	       imx_clk_fixed_factor(dev, "pll5_post_div", "pll5_video", 1, 1));
+	       clk_register_divider_table(dev, "pll5_post_div", "pll5_video",
+					  CLK_SET_RATE_PARENT, base + 0xa0, 19,
+					  2, 0, post_div_table));
 	clk_dm(IMX6QDL_CLK_PLL5_VIDEO_DIV,
-	       imx_clk_fixed_factor(dev, "pll5_video_div", "pll5_post_div", 1,
-				    1));
+	       clk_register_divider_table(dev, "pll5_video_div",
+					  "pll5_post_div", CLK_SET_RATE_PARENT,
+					  base + 0x170, 30, 2, 0,
+					  video_div_table));
 	clk_dm(IMX6QDL_CLK_VIDEO_27M,
 	       imx_clk_fixed_factor(dev, "video_27m", "pll3_pfd1_540m", 1,
 				    20));
-- 
2.47.3

