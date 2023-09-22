Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189A0CD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5CE86B69;
	Fri, 22 Sep 2023 12:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XJ4Uypjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E782486B55; Fri, 22 Sep 2023 12:40:14 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7EF786BA6
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38MAeAd3124027;
 Fri, 22 Sep 2023 05:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695379210;
 bh=z2KdRoXH6lO0rDkIITV/xWwOvuij8sJicVZpqW1smSc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=XJ4UypjmTPMqLzfqaaVi/WT3ewghMby9b8W98egJQ3kHPZZKXfClRIkXKmyJgaUg5
 Y+R5PW56m4DY7rp5Gh/+BHCmgES/+d4lh75W0ucHmu5EMDe2NSiAt3Nf32YI/pY6be
 6kf16T9bzAmgSdceHkgJfp/7Y369MfcKrojBwDjA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38MAeAek001062
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Sep 2023 05:40:10 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 05:40:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 05:40:10 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38MAdtBt034669;
 Fri, 22 Sep 2023 05:40:05 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <b-kapoor@ti.com>,
 <bb@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 2/6] arm: mach-k3: j721e_init: Move clk_k3 probe before
 loading TIFS
Date: Fri, 22 Sep 2023 16:09:50 +0530
Message-ID: <20230922103954.3454891-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922103954.3454891-1-n-francis@ti.com>
References: <20230922103954.3454891-1-n-francis@ti.com>
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

