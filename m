Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF71CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 18:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38FA8493A;
	Tue, 16 Jun 2026 20:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="ZlXbRedh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A2F848D8; Tue, 16 Jun 2026 14:52:04 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA563848EB
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuZQm9gnhX/qa4kbGBaCPUW3h+8XIUv8EtVnn5olu+nHMREHrXQ9fE3qfAieTCRJF3RYayp95MhXxYZNOps76GAJeD2PdWu4tq0NLac06aamWZXeq0OQCZr8cAMz/07Ork9vDChvOUWJTfatbfDz117aDC1TU877M3qi4XT9VEmChp4VI5HxyWEmqm603XKxXZlaHJ0WsWYwEhAasch+mwQk+EuNTj9vAFrCJWhZqsVyHJXxRU/fHGpXZDiNozl6mQ5jIhSjonuj/ktLIB0b1Ii/Y4pvt9H6vtjXQdYN3ID4wZeZXw24hC6LSAhUj3d6egDasOJwzEae+xKtUeHivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=946m1sbCBmTA/oizjyXe4FupDRFmyXymuw0JyO2Zrrk=;
 b=dWA/w0Q7yi17ObomyX4p1uvfRJK59VUn6kELT87vTcahhe3uuqGrTk4QAq15bGSP3ZhKJUTSqgyml/FvU1gQqR+WbptAIdkacSFiAe1+sZIOHbvLC1HRApF/6FUBQkygeRwP94B55Zo8j2/fAP2EJC0xgqBjnPFKFf+lBcUMbrFH/GXjkw3gIJ6f633oh9bZ5rW19T8PJBGe/XPMWTwc5vnJQd2Fwt18/ki8QxQtQ7Esp/si7N7byRv7TTTBup6XDuI9EL7Ix1K77CaBnccXctf4aCnYH/RrvimAPl/tn/tv+hAXKVmb2rDf0tTE5TOke/hGwutR8CRDPpTEqeExeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=946m1sbCBmTA/oizjyXe4FupDRFmyXymuw0JyO2Zrrk=;
 b=ZlXbRedh+rb+E0n9KbipNbntOTHVwK7iU+1hNHtZHyPiaB6PwJdbTIqv8xebajgLVMg3jmIFeXl6qg4xHShuAM7D1eSg1P5xtwWXD4PY+/gI+65YWmaupVE++fVvHRSlPM/233wnA7BV6Pjjofp/dGMYezcmz4V3or5jzdHbmU77jiMB5MjXEIPRnjVEIAg6siieVRFRVAtXLbvmgp+TLXVctqkTRALz0/0UxRN0lAYdoK1EWknLswtKih39OE4zi6MOsnw+mZOjtJZJEl7YJdpU6y10YaIRw9rbAzT46pwqNoyzplpk8NziGngeykvIw3oEygCD0ScV81kNVxBHuQ==
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by EA2PR22MB5331.namprd22.prod.outlook.com (2603:10b6:303:255::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:51:53 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::21) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 12:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:51:53 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id D0C2F1290D;
 Tue, 16 Jun 2026 15:51:50 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: brian.ruley@gehealthcare.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: shofiqtest@gmail.com,
	festevam@gmail.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 1/8] clk: imx6q: cosmetic: keep pll definitions together
Date: Tue, 16 Jun 2026 15:51:34 +0300
Message-ID: <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|EA2PR22MB5331:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0a9c7c88-810d-4a33-0c2f-08decba60a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: QDNB/vJNv2onADx7O7knDigwqGvNWlMfFFUO0O2lsflcs65Hg6d61MY64aCZsesXr91hiGYAVJOVy4GzcLGP66KDamAYq51VNPdxzWVwT1c9gij8ithwPXY19BlbObIjSCGRl0Ruxn/ZDDv0jcQwIcaN8+NFi1VN+IYzbDnTHbFGYzqNh2prRZAs7tB2fx7x6080sKVXelHLUxGlojVC+gzoh9r6qyPZhrQCF4BPayECZTgfR7f8HW7sd5OYXKeT9VNtH6MdRa4Sd1eRAVG4CoqhOl++1mDte/gOZNI99bXCvd+H61AWP7fpiyK3zp+lH4YrChon386YLPZ6VCgtc3fYrXBXyGjS0MbdJj+lKSq5IxI3xGa5iA1eqP9ZVHJW3W8OkeTamQp9uxDFvog2LPNODygdf2km3c376ryBi0uUsWO8OB4pYyc4U5l0zgrAbtLOCzBCCh9VFi8PoyPIUIjz8TiExq9cMuWM/9niagBl9CEtDfNAU3JS2pPjzM7oOZbN1k4CkT6Kl6enpOYi8cCpQKyMYpXcymegvdEjebEklHvZXzqwvnnyggoVbKH9lkK+9MN2vBMhVSjM2HMP7twVX/nfrj1DwTfYE+23nMNQFTk8jHYzCeXtNaFtmb9Q0JmSgHhPO+dP6O9dsf6bFU1eHiooTEW7ileVMVSqgTFSuAqjz3IBvGvPGL93oPai
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0fX4pelq0hFNe8kHcu6oCdzhv+aP0jpwAn9K4KOCunqLAhy4vAbY5dSEGSt3A3yzWl3Ptr6WWKEmjWfeaKWJwEpyotDF+accn97Y0FhoVQJl1dxsl3OklH7CDd/AHGGTlUGkN/wvvXztOlEkeFcdSrLrDU7R0HLsiFZMkTkm6uBng/dF/TebcygPCSJFRr9X9i3JZ+q1CjRWoIRf5Qy0ZJC7j2l0Gd+TvA3SLzXm9Go4MaMVr6Ty2JfKO7qiafwMFNJeVj7Tk33x2UM3yVGLera362CKgURht21/8tJ6HkBsVltq7Y4NA+DahroPXCwD+tysIkf2PeVoykjp5j7CEEm4LMdVKdqPtkkyByT61tSMbx5KBvARQou2G8BfAFIYfZD13BMCer9LvOlrh70hwN3sOx0uNuRCbmvFVRP/tCL5K99mlZQlaehBKqnVKp4B
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:53.0529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9c7c88-810d-4a33-0c2f-08decba60a69
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5331
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

Make it easier to reason about by keeping similar clocks grouped
together. While at it, fix comment spacing.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
v1: https://lore.kernel.org/u-boot/20260422094649.57611-1-brian.ruley@gehealthcare.com/
v2: https://lore.kernel.org/u-boot/20260428085117.402523-1-brian.ruley@gehealthcare.com/

CI: https://source.denx.de/u-boot/contributors/brianr/u-boot/-/pipelines/30482
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

