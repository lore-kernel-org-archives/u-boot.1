Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B0BC27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 09:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4959288800;
	Wed, 12 Jun 2024 11:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CZy8csBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D1088791; Wed, 12 Jun 2024 11:11:41 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA17887D7
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 11:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45C9BW1L041632;
 Wed, 12 Jun 2024 04:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718183492;
 bh=4PR7HwRLTX+25ZjErr3mrq/nwBN6+gJGKQSkzajAHdY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CZy8csBHTim1EA4WDxJPA1n7zF+Z9Hl27bNOsLCiv5lVcViVQCre2hpBhgd7qHC5U
 smilTVFpwE2tet33Kx1rfCJYPFCO3fUXUcSO/rxH7cJAHITeyg5fDySLnvnWPcw774
 OS+8sLLbDUlkw7tfabWIEdncEVT8q6enfo4PRVMY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45C9BWB1005077
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Jun 2024 04:11:32 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 04:11:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 04:11:32 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.55])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45C9BVu4048514;
 Wed, 12 Jun 2024 04:11:32 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <sumit.garg@linaro.org>,
 <afd@ti.com>, <j-choudhary@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
Subject: [PATCH v2 05/14] power: domain: ti: Fix the order for platform data
 entries
Date: Wed, 12 Jun 2024 14:41:14 +0530
Message-ID: <20240612091123.253835-6-j-choudhary@ti.com>
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

Add the power domain platform data entries in alphabetical order.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/power/domain/ti-power-domain.c | 36 +++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index b059dd3737..362fae86a2 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -71,6 +71,24 @@ static void lpsc_write(u32 val, struct ti_lpsc *lpsc, u32 reg)
 }
 
 static const struct soc_attr ti_k3_soc_pd_data[] = {
+#if IS_ENABLED(CONFIG_SOC_K3_AM625)
+	{
+		.family = "AM62X",
+		.data = &am62x_pd_platdata,
+	},
+#endif
+#if IS_ENABLED(CONFIG_SOC_K3_AM62A7)
+	{
+		.family = "AM62AX",
+		.data = &am62ax_pd_platdata,
+	},
+#endif
+#if IS_ENABLED(CONFIG_SOC_K3_AM62P5)
+	{
+		.family = "AM62PX",
+		.data = &am62px_pd_platdata,
+	},
+#endif
 #if IS_ENABLED(CONFIG_SOC_K3_J721E)
 	{
 		.family = "J721E",
@@ -87,29 +105,11 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
 		.data = &j721s2_pd_platdata,
 	},
 #endif
-#if IS_ENABLED(CONFIG_SOC_K3_AM625)
-	{
-		.family = "AM62X",
-		.data = &am62x_pd_platdata,
-	},
-#endif
-#if IS_ENABLED(CONFIG_SOC_K3_AM62A7)
-	{
-		.family = "AM62AX",
-		.data = &am62ax_pd_platdata,
-	},
-#endif
 #if IS_ENABLED(CONFIG_SOC_K3_J784S4)
 	{
 		.family = "J784S4",
 		.data = &j784s4_pd_platdata,
 	},
-#endif
-#if IS_ENABLED(CONFIG_SOC_K3_AM62P5)
-	{
-		.family = "AM62PX",
-		.data = &am62px_pd_platdata,
-	},
 #endif
 	{ /* sentinel */ }
 };
-- 
2.25.1

