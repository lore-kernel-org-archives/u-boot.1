Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E95AF9EDC0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 12:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5EDD84286;
	Wed, 22 Apr 2026 14:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="UE3PHOAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03DC5840CB; Wed, 22 Apr 2026 11:47:06 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D0B84227
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T423ZjkuGiPr3s7vUhOkPXIpXfPi9npdURVDAg4xvIFZdIojV5ruVHmoXk4tD5Bf8xnUc0eOTOZM8fe0r5WrOgsVm8WTBQhwH5om2NyGSEvCoH9mS/dz9gJxBZVDMuzhrhLPgRzLV0prmhWaPpyR5RRqLB5bjO8jlmJ8m/9l14Cp1aTVvo6F08xgfj0sa3IT5EwyNGkmmTuDo6b0EhXWRT3eeJ6c8+oNAPKJvEnHNeY/C8H+BzMn1MggbzFyOl+XSAffkmmJadYXGyLjrzB708fE9OwlrEBhwwyPDxCQu5dqrfK/0N4cdCQCTSy/gEGHSuxyXtHD6SEYTdqSj8LFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtqNb/nYIDRk1uA2l9jpGpVVcAwqZHXmaYAjbAmF4vc=;
 b=YlM04FlnanUOd3wvUGaQR+NK0ijAQRDEkC8rKVaafzxPbl8/sqPR0rtlcGTN1E5BfNA5yH5fll3ahwCDs62I0MGOX9P4GZFVziXfwpC53HL9Yx0bf3YYBfzBVltAekiAjn6l80f80D4bXNotb0bZ3F2EI/SD82g7xgB2oiR2mF32k3FnLK0cYtUhJvA4tRpFPYfBr2DU74yyRKDlz+gmA2Vmx5AnipTkb1ACrxGV72W+BPdsrcJ//bLSfp4mbzDokRYJ6hZ7XgL1Juqfi/FqrJ7yK+RWbaO6QD19Mm5jQft+h/CeNt/+qdkWAIgPM5srAofzdZirOHUhQSBiTxv7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtqNb/nYIDRk1uA2l9jpGpVVcAwqZHXmaYAjbAmF4vc=;
 b=UE3PHOAdNDov1zbkQ7xZEm66EM7IQbE5JEmGXaPbDwN5fKCfVJJLcUk1jF2MBJpmJK8hU1x1jfsQbX8oXnFIfMmkFGAAIIhStBmaDN4MuDYp/I4WoB0ivlFL2bNti+hbTWeebpYJXsY5PsGGYPKFpUYb185K7y674V3lVXHlnDHE1kujpnQGTZmGrENijqh063QhwUcM1AJjbnTz5zpuyBUlIzo7+qPKVKj2QIvy0/FShjQbAl8w4TyWCuCBRuM+/h5dka9GB/6tQW0GeoMgXYDDtgLxrpI/KzAW6Sggx48sqg+qgnLEuQmzAqNf7/kBDHDWIQaHOfZTwnn7AZ/U4g==
Received: from DM6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:5:190::20)
 by LV3PR22MB5795.namprd22.prod.outlook.com (2603:10b6:408:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:46:59 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::e7) by DM6PR11CA0007.outlook.office365.com
 (2603:10b6:5:190::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 09:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 09:46:57 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id B8E6F131E4;
 Wed, 22 Apr 2026 12:46:55 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Lukasz Majewski <lukma@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/5] clk: imx6q: cosmetic: keep pll definitions together
Date: Wed, 22 Apr 2026 12:46:39 +0300
Message-ID: <20260422094649.57611-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|LV3PR22MB5795:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f09bf760-fe97-4210-0e05-08dea054186d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: J2vQ7syyj8QWIs24pQE8qfmDGpuSWmlcgH3192YhT7yO06Tb5JC1KVj3EoMJh+wQ5BHrGf3Kwk7w/Lwz/EyKs6ubrBhkSRXD9/l8GsSvdcp7pzsIGY9LBfHj+gLpSaHnOAv2sZUkWAxK5LOjnR5QScAnUbio1ABuhsfQurcWmJ/d1xDkhkaJpA8kMTbQ0wr7BSzDXgdPWxf6Gw1hVm6RlXsmQAcQxz5lNDArdH/LTZxGdk2pCQCWCfBCkbfJZIqgGsru3XJIoOQOH7URZpexK7rPRIomVmW/UfK3/8C4vnXSpbghwkW4BhxrQ8doUzwSVwB2FPhb2ad9J/6j1z7RlD2LpXy8B9tsL1Z0KwMXk4IwSJlsa7nepBF2OU0c+oLfck8FznVALSq/JWmr75XwxH1qLEjbY0Xhkx796RiRKSHvo4zYcYSeI3C0WFzMUCMBei1V6N8EZc+i32zAgOq9X4cEXK7BIcSBC0W/Xr9wRK9nD7Fu0tpXef7qyo0Q0ZIMlvmYThSLwv6ovz0vbdf5iaqi69p7uuhq+IUOQQoYQ6Sur5vUjP8fRBeL9JOFj+6q6hMLzeLYLar/TxpK3T3ib9C20qdkWgPWHUbQ49xJ+huOaIQTgMy0gx23R793qNIcOZo3qCeVKIH7RB1f27lHU/Y0GcB11fEf0yPzwhmvlFXa24pymVt/ZGoawA/2Ug55uTfLIAlpT4dDvcFMQB6zbcSsbYNflqWldDNCqa/SR79WxMALwo1hIKGtCGrCBLZaVaM78F0IwGT8LQEpU6rBwA==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1U6kslA2j6DdZT2MmCIWjUshzXvwzMHmNOkkgviy7lYtyn5/v7oc2dXwLwPl/Q3fLqRpf3p32onYTCgn2hNacsD25c3xsRB4A8ziFdWl2Cxxo2tpklNTKXbF81r25grEOLstgVfjsZCwxW+xp3UXb0m8cSEvl0Dlw2v+NFayGH9nJQ6xGwNRmWeb2vajncS2xLrZIhrcacc/XDaPPMD0h32ivfU130Ql5HTkr5s386RWgEK7Ksk7trcijFj75IR5Ao+jOevEL+9Qlbn3u6JBVsAFlrHRJwAvIsvWRMIOuWFa8f2pbvgZkxXghAAe+yu6PheAWC1kmo8JkHJKmYHGUDtblS4kL4oySCxK4s0VXwgGMFwwHhrEAohyhU2DiK5u4ZQKm7rgCPfPvSpJyXGfgTCInNyIMEBcyMOi6u9WS7sInlDBWDYT9e1b5DrAX7uD
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:46:57.8314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f09bf760-fe97-4210-0e05-08dea054186d
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5795
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

Make it easier to reason about by keeping similar clocks grouped
together. While at it, fix comment spacing.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
 drivers/clk/imx/clk-imx6q.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index f57ac79f8ca..cd06d211e8d 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -126,18 +126,19 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_PLL3_USB_OTG,
 	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_usb_otg", "osc",
 			     base + 0x10, 0x3));
+	clk_dm(IMX6QDL_CLK_PLL5, imx_clk_pllv3(dev, IMX_PLLV3_AV, "pll5", "osc",
+					       base + 0xa0, 0x7f));
+	clk_dm(IMX6QDL_CLK_PLL6, imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6",
+					       "osc", base + 0xe0, 0x3));
+
 	clk_dm(IMX6QDL_CLK_PLL3_60M,
 	       imx_clk_fixed_factor(dev, "pll3_60m", "pll3_usb_otg", 1, 8));
 	clk_dm(IMX6QDL_CLK_PLL3_80M,
 	       imx_clk_fixed_factor(dev, "pll3_80m", "pll3_usb_otg", 1, 6));
 	clk_dm(IMX6QDL_CLK_PLL3_120M,
 	       imx_clk_fixed_factor(dev, "pll3_120m", "pll3_usb_otg", 1, 4));
-	clk_dm(IMX6QDL_CLK_PLL5, imx_clk_pllv3(dev, IMX_PLLV3_AV, "pll5", "osc",
-					       base + 0xa0, 0x7f));
 	clk_dm(IMX6QDL_CLK_PLL5_VIDEO,
 	       imx_clk_gate(dev, "pll5_video", "pll5", base + 0xa0, 13));
-	clk_dm(IMX6QDL_CLK_PLL6, imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6",
-					       "osc", base + 0xe0, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL6_ENET,
 	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
 
@@ -279,9 +280,9 @@ static int imx6q_clk_probe(struct udevice *dev)
 				   ldb_di_sels, ARRAY_SIZE(ldb_di_sels)));
 	} else {
 		/*
-                 * Need to set these as read-only due to a hardware bug.
-                 * Keeping default mux values. Fixed on the i.MX6 QuadPlus
-                 */
+		 * Need to set these as read-only due to a hardware bug.
+		 * Keeping default mux values. Fixed on the i.MX6 QuadPlus
+		 */
 		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
 		       imx_clk_mux_flags(dev, "ldb_di0_sel", base + 0x2c, 9, 3,
 					 ldb_di_sels, ARRAY_SIZE(ldb_di_sels),
-- 
2.47.3

