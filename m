Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD17DCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 09:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38478843A;
	Thu,  4 Apr 2024 11:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A9cUkuZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA7A88430; Thu,  4 Apr 2024 11:01:02 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5995883F8
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43490mCN126677;
 Thu, 4 Apr 2024 04:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712221248;
 bh=uOEDHyDm4NvFPsCTY79QS/2Ro4oB+BZEFGxM7KVd/po=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=A9cUkuZsUN0pW5ehY1dwPrQYIuiTQktIXS9lxDJVpB475XUzX5rCB5CCR0giNrUwq
 A8AT0aLb60JgbF9B77OyTrS9HkcjAUPdspKik6P9ktxhv0q2g3LMKdFmvSk/92K3xg
 VCrML64Z7CFQZOcyHcQEouJtURVcgygbCt3rquYU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43490mTC030216
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 04:00:48 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 04:00:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 04:00:48 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.252])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43490lc5057988;
 Thu, 4 Apr 2024 04:00:47 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <rogerq@kernel.org>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 05/15] clk: ti: clk-k3: use IS_ENABLED macro and fix the
 clock-data order
Date: Thu, 4 Apr 2024 14:30:29 +0530
Message-ID: <20240404090039.87458-6-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404090039.87458-1-j-choudhary@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Use IS_ENABLED macro for the platform clock-data list and add them
in alphabetical order.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/clk/ti/clk-k3.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index 7aa162c2f7..a3c6e79db7 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -60,6 +60,24 @@ static void clk_add_map(struct ti_clk_data *data, struct clk *clk,
 }
 
 static const struct soc_attr ti_k3_soc_clk_data[] = {
+#if IS_ENABLED(CONFIG_SOC_K3_AM625)
+	{
+		.family = "AM62X",
+		.data = &am62x_clk_platdata,
+	},
+#endif
+#if IS_ENABLED(CONFIG_SOC_K3_AM62A7)
+	{
+		.family = "AM62AX",
+		.data = &am62ax_clk_platdata,
+	},
+#endif
+#if IS_ENABLED(CONFIG_SOC_K3_AM62P5)
+	{
+		.family = "AM62PX",
+		.data = &am62px_clk_platdata,
+	},
+#endif
 #if IS_ENABLED(CONFIG_SOC_K3_J721E)
 	{
 		.family = "J721E",
@@ -69,35 +87,18 @@ static const struct soc_attr ti_k3_soc_clk_data[] = {
 		.family = "J7200",
 		.data = &j7200_clk_platdata,
 	},
-#elif CONFIG_SOC_K3_J721S2
+#endif
+#if IS_ENABLED(CONFIG_SOC_K3_J721S2)
 	{
 		.family = "J721S2",
 		.data = &j721s2_clk_platdata,
 	},
 #endif
-#ifdef CONFIG_SOC_K3_AM625
-	{
-		.family = "AM62X",
-		.data = &am62x_clk_platdata,
-	},
-#endif
-#ifdef CONFIG_SOC_K3_AM62A7
-	{
-		.family = "AM62AX",
-		.data = &am62ax_clk_platdata,
-	},
-#endif
-#ifdef CONFIG_SOC_K3_J784S4
+#if IS_ENABLED(CONFIG_SOC_K3_J784S4)
 	{
 		.family = "J784S4",
 		.data = &j784s4_clk_platdata,
 	},
-#endif
-#ifdef CONFIG_SOC_K3_AM62P5
-	{
-		.family = "AM62PX",
-		.data = &am62px_clk_platdata,
-	},
 #endif
 	{ /* sentinel */ }
 };
-- 
2.25.1

