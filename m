Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B61CCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 09:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4968842A;
	Thu,  4 Apr 2024 11:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HhhhvTdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B206788408; Thu,  4 Apr 2024 11:00:58 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0BE388418
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43490n56126682;
 Thu, 4 Apr 2024 04:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712221249;
 bh=TKRV38HnB8NfrmpUNRW/P/7r4cATkqBuhES+3vfgjD8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HhhhvTdUkUmCv/MR3VX+/l04Y4PHuVKAH/EjllfDdRCiNjWmzjp9K3ITOrvhF1T4C
 23ZGtOHROGKTJTIb6PXYAyfnlezdBcEX3N6aGvq6ugh/014PZYE6FXkKeTji5trHKg
 3dZjxXzQgF3ZEcNpjtjaLqeZ5bXqcyAsclxtAsmI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43490nWF091345
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 04:00:49 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 04:00:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 04:00:49 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.252])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43490m07010856;
 Thu, 4 Apr 2024 04:00:49 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <rogerq@kernel.org>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 06/15] power: domain: ti: Fix the order for platform data
 entries
Date: Thu, 4 Apr 2024 14:30:30 +0530
Message-ID: <20240404090039.87458-7-j-choudhary@ti.com>
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

Add the power domain platform data entries in alphabetical order.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/power/domain/ti-power-domain.c | 36 +++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index 8996c40ddc..a280859aa5 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -72,6 +72,24 @@ static void lpsc_write(u32 val, struct ti_lpsc *lpsc, u32 reg)
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
@@ -88,29 +106,11 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
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

