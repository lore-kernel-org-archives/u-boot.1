Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A08CCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 18:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B10F84957;
	Tue, 16 Jun 2026 20:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="p9NBNqus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C65848C5; Tue, 16 Jun 2026 14:52:05 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC8084704
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4go1uiEuOBOH3V6TeUe7yGdWoIk4y6MlmN/by3ijIihRZOxOEultGSyWLMjRf7ge5wfAI4I8YYfbn2MsPiRqsi/VvB86Ev71SetoavNHUvvzMIIkzsH6EMQ0IN+EWJGjl+9G+sCQAnGLJz3AwgtCniWTzb/DA7Sy5k7sjauVLsxoVHAWyVvh94jhKfzczCdtr+1C8wCOUv5aeEdOz64CeHX96YTIgR78pEW8tMqNqYXDjCZV6Ke/NF1GwVR3IlTNlPc//L8W1YuWobBX1w45uPdZzWfuRWkpcnn2U1MRcQBksLOosGVzOcjnyc1N7jJtWDRm7avHIvkihUbycWi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/FfTaEj05Qi6QVLMRZuBiRwg53zuJvSQndU3qP2wm4=;
 b=rQv7BcH6V63+eBpsKsryR9/PBljUXwQKQlXe9+RC6vGLfP2J2LfaCquicE6lo7XInJomk88W4Vve+PhtKmtvyEvfIALXQTUpi7jCVXUqqoXNdwnfgyeQua8lK5gzmun+zD7wM1B+5V1PipyD12q5nk95+3roIlA64fnlb/1+QYEArNJsCMLiQt0mXq2N0XgbAM5EBiZBKdr7LtZ01QlFOh1HLvmh/felHPGD6BelWhAux/3C5RzWQ6P4YVXoa+yTAIsKAHFkEYEjQvR5yP/COZqn+w1XIHp6JruG9kqm/bmt7ww3FhYEq8x8PGDVNGNRg8sqeXZ6+Zr7Ec1qARMzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/FfTaEj05Qi6QVLMRZuBiRwg53zuJvSQndU3qP2wm4=;
 b=p9NBNqus9giXp5W05/mpH6XTm0l/7N8Am0B6TZO8ovqar9MnUEEv9bkmCNqk4Qzb4hVr+Zzc2aI5zYRJ8xG+kTQLlUBLZXKfOPxxb8YRlOTEaqlALSyjRltPczREaGiR6A+u2Tu4nKBmRjbfEyO6ZrDcKeTeDSxug55mjAfxYDGdRWRq5gT4yvqmpSIRdBs87zqOZSaI6on94ZKJ3bareh5O72IT/FLjTRiOmuYyOCdACgUJNWlTvbUXqL3OVWk+go+xdWOMa1gGs0IR1shzOLnyjU9Le87VDLdumR8WvjR/AoT7237gEQ0QVxbT+e0r8aavG9SgKbj3m4cyRF7qDw==
Received: from SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17)
 by MN0PR22MB5688.namprd22.prod.outlook.com (2603:10b6:208:4c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:51:59 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::1d) by SJ0PR05CA0102.outlook.office365.com
 (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 12:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:51:58 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 9309C1290D;
 Tue, 16 Jun 2026 15:51:55 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: brian.ruley@gehealthcare.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: shofiqtest@gmail.com,
	festevam@gmail.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 8/8] clk: imx6q: use clk_divider_table instead of fixed
 factor for pll5 divs
Date: Tue, 16 Jun 2026 15:51:41 +0300
Message-ID: <20260616125147.3710024-8-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|MN0PR22MB5688:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a58d74d9-aa6a-4433-a400-08decba60dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mVs4kvIB/szNDtEXn2bWvyRAYX46wpuWKCYCPJIn6ThAvB86rpcXXe1rGqovH3QZ+c3Mt6YcUo+XseQNc7QWtw8ppFn89+wNV+qvKUItb/VK7UNB0RumO0tfNr81NvSfUG2GwC4YrCuP/RmlgesmzmN8cDQ7JwsmjMmH7yKpwSSHWczYCNsDgZA3uq8OnzRdBq++RBTQaqKzNnbts7G8lfFa+SfekhA2yOutByunaFS3jVfUIsHqWhvju9bEURYFpvhNnlAGyDN9tgrejtIPUc6WKPHqIajisykG6Vh1xKuA+ucjc91sQx63284RwUe8VLmYyMOWn9bEYcRJ80FCQCf3f08sSndCC5a3R2gM2avBHz2gpFTNwwAwCu6Rsum9ywTUdEKLzsLsew2E7mmqd1Qwh0qoHU0Y1IkVO4ORITDjP7YLuLAHEyUqr8sr3x5hbNFIxnBp/ksj5tphcA0XjdJzUdfv0bAXYX61dKxtQX7DEis7V6QHbjMN/YXUaxBa0x9PmAQKz84ju7g5qFJw1AbdT7zonex+LvsJgXRMsF0NPFY3jqrpnQydAOpbk2YHv/6IDNP4h4yPJ9z5gGjfovVUdND7scRBeY9Bz0XWQVZaD2XhfUYhBZNZ1TB+x2OJnnCet4FuVE0h8cqs9zqa7s2Hnl1D58RgoPWdxHVXNWvohimYaJLkWibsAxK+ShduQXQHjTS1G3i+8jJy3lG14TtVRXFyu2+RY6DKBncmflI=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iryiHZh053DNGdlYDtdqp+YHRfWMOb6tVaZqOjAD4NM3tdQRICWb4Afs+6R4EWh0R9r5JIl5S0s4P9+VHHWPF7jzosuqpWzRoCN3Po3ztx/ZS9Iof/PGHtHkY/zaU9jNvUlLKo8YWSwBv8GQuQXhSnjs6HJUlG0e5GI9zXfu/65//aw9aBtfRL89CVrSQlNqFW3vw9nhhvpLCdImXO5K4YYecvYkl106LJowh8Y/ovnyq2HSZLkXhvxqJKLMjd0f7SjqzSA/MACcSy7lDLELTUlFcjs98cvVPi3QSdmUAjHr73WWUSCVNDiQcsX+nnk2yG1Tr0+VDl3r+d8tj1TD0+3ABr34WxA/89QonPPJ8vCtSsix1RWHpQ4gykNOSc7Eit0IGmQt9w8v9HY50/ERRZ+ZBHsh5sswCHsdGicQrQ58+hdsYXV/XSmfQUJtjruN
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:58.5339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58d74d9-aa6a-4433-a400-08decba60dba
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB5688
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

Now that non-linear clk divider tables are supported, replace the fixed
factor implementation with the proper divider, which allows more fine
control over clock rates.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
Changes for v2:
 - New
Changes for v3:
 - Add const identifier to div tables
---
 drivers/clk/imx/clk-imx6q.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 393b4215fe8..846b8011f5c 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -101,6 +101,21 @@ static const char *const ecspi_sels[] = {
 	"osc",
 };
 
+static const struct clk_div_table post_div_table[] = {
+	{ .val = 2, .div = 1, },
+	{ .val = 1, .div = 2, },
+	{ .val = 0, .div = 4, },
+	{ /* sentinel */ }
+};
+
+static const struct clk_div_table video_div_table[] = {
+	{ .val = 0, .div = 1, },
+	{ .val = 1, .div = 2, },
+	{ .val = 2, .div = 1, },
+	{ .val = 3, .div = 4, },
+	{ /* sentinel */ }
+};
+
 #if CONFIG_IS_ENABLED(VIDEO)
 static const char *const ipu_sels[] = {
 	"mmdc_ch0_axi",
@@ -341,10 +356,14 @@ static int imx6q_clk_probe(struct udevice *dev)
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

