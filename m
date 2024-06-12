Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E8C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 09:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E91F887FA;
	Wed, 12 Jun 2024 11:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZFG+5lne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8595A887DB; Wed, 12 Jun 2024 11:11:39 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7734F887BF
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 11:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45C9BVeC009351;
 Wed, 12 Jun 2024 04:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718183491;
 bh=DvX2gaQWlhycN1dEcAV3zE10OagLNXgsw1/855rvT1A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZFG+5lneHZ7BLnNX0y67vxdR100kUvihgVE8JdJFmf4JVBuR3NEMU79JK90M4NLn6
 96AHrn5zAXvjq1YV+xXqi872cqy+IfRujXX1R+YDlHWsD53vFXW2MyDYRBLBqQJA/G
 xn4kVF4GwbDa6cLJI0OwR+Fd5FY4iKAB+802Du/I=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45C9BVJ0070241
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Jun 2024 04:11:31 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 04:11:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 04:11:30 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.55])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45C9BUoW048500;
 Wed, 12 Jun 2024 04:11:30 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <sumit.garg@linaro.org>,
 <afd@ti.com>, <j-choudhary@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
Subject: [PATCH v2 04/14] clk: ti: clk-k3: use IS_ENABLED macro and fix the
 clock-data order
Date: Wed, 12 Jun 2024 14:41:13 +0530
Message-ID: <20240612091123.253835-5-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240612091123.253835-1-j-choudhary@ti.com>
References: <20240612091123.253835-1-j-choudhary@ti.com>
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

Reviewed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/clk/ti/clk-k3.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index 41e5022ea0..9e17755c24 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -59,6 +59,24 @@ static void clk_add_map(struct ti_clk_data *data, struct clk *clk,
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
@@ -68,35 +86,18 @@ static const struct soc_attr ti_k3_soc_clk_data[] = {
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

