Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EF7E7F14F
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8089086DF1;
	Wed, 27 Sep 2023 15:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O9TF5eT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2832886D5A; Wed, 27 Sep 2023 15:10:17 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86AF386E02
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RDACgC075166;
 Wed, 27 Sep 2023 08:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695820212;
 bh=NdKaXvohG5Up4zrKW+S8FMysqZpek1onA2iiZLKhrqA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=O9TF5eT+V/nYvEpkVaudQngqpELrFZEmhBEDM12W6hNl4ec4XKaZnT0ivkcBjHPU4
 AncVUA9xGK8G/DulTvpm1rG3yGyC4Z8Tnukgptc5Ht97/DDvuFiNJxzaOOz/MjlCBi
 ZVcdqO/4oyX94nDVHUCchGV0WCvuJp3ZFIf4OuvI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RDACqN008284
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 08:10:12 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 08:10:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 08:10:11 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RD9uKc025731;
 Wed, 27 Sep 2023 08:10:07 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <b-kapoor@ti.com>,
 <bb@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 2/6] arm: mach-k3: j721e_init: Move clk_k3 probe before
 loading TIFS
Date: Wed, 27 Sep 2023 18:39:52 +0530
Message-ID: <20230927130956.910988-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927130956.910988-1-n-francis@ti.com>
References: <20230927130956.910988-1-n-francis@ti.com>
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

When setting boot media to load the TIFS binary in legacy boot flow
(followed by J721E), get_timer() is called which eventually calls
dm_timer_init() to grab the tick-timer, which is mcu_timer0. Since we
need to set up the clocks before using the timer, move clk_k3 driver
probe before k3_sysfw_loader to ensure we have all necessary clocks set
up before.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-k3/j721e_init.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
index b6164575b7..b1f7e25ed0 100644
--- a/arch/arm/mach-k3/j721e_init.c
+++ b/arch/arm/mach-k3/j721e_init.c
@@ -228,6 +228,18 @@ void board_init_f(ulong dummy)
 	if (!ret)
 		pinctrl_select_state(dev, "default");
 
+	/*
+	 * Force probe of clk_k3 driver here to ensure basic default clock
+	 * configuration is always done.
+	 */
+	if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
+		ret = uclass_get_device_by_driver(UCLASS_CLK,
+						  DM_DRIVER_GET(ti_clk),
+						  &dev);
+		if (ret)
+			panic("Failed to initialize clk-k3!\n");
+	}
+
 	/*
 	 * Load, start up, and configure system controller firmware. Provide
 	 * the U-Boot console init function to the SYSFW post-PM configuration
@@ -241,18 +253,6 @@ void board_init_f(ulong dummy)
 	do_dt_magic();
 #endif
 
-	/*
-	 * Force probe of clk_k3 driver here to ensure basic default clock
-	 * configuration is always done.
-	 */
-	if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
-		ret = uclass_get_device_by_driver(UCLASS_CLK,
-						  DM_DRIVER_GET(ti_clk),
-						  &dev);
-		if (ret)
-			panic("Failed to initialize clk-k3!\n");
-	}
-
 	/* Prepare console output */
 	preloader_console_init();
 
-- 
2.34.1

