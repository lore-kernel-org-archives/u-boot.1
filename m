Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6C8C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 13:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C661288624;
	Wed, 29 May 2024 15:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CaT8kZc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE4B885E1; Wed, 29 May 2024 15:25:05 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E76088582
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 15:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44TDOvAb001492;
 Wed, 29 May 2024 08:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716989097;
 bh=C2PyGDcwKBV4xCBh0myM4PeGQZjTIHuv0wJb2n33wG8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CaT8kZc5AQU4TyieQeCkiRVVUTLchANlCksdS27/cnIofYGHUlROmFkKhiB9kPLiU
 rtKHkG5Jeg2SjVAG63zLs7QCzRmbOb9QH//4Dhn890MHhkN+j0CQFZ1N9yZQArxKd1
 UVnGlhcJ7IY/IfUf34vgPpfrobQ/yQVVT03rViqA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44TDOvxZ117024
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 08:24:57 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 08:24:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 08:24:57 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.102])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44TDOu28045023;
 Wed, 29 May 2024 08:24:56 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <sumit.garg@linaro.org>,
 <afd@ti.com>, <j-choudhary@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
Subject: [PATCH 05/14] power: domain: ti: Fix the order for platform data
 entries
Date: Wed, 29 May 2024 18:54:39 +0530
Message-ID: <20240529132448.459330-6-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529132448.459330-1-j-choudhary@ti.com>
References: <20240529132448.459330-1-j-choudhary@ti.com>
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

