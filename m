Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CB0C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CBD186563;
	Thu, 24 Aug 2023 05:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QoOIpfXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B51586574; Thu, 24 Aug 2023 05:11:24 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080328655F
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O3BAFd053221;
 Wed, 23 Aug 2023 22:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692846670;
 bh=WzCg1zuQ1eMAN9Zw/pLZVjIUYRal+GEmVEIXCdkxvjY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QoOIpfXsR527Y3KLY32cOitetlfiKNS6/amFSUGq09ZrD5qJH8UiscridNCkkone/
 2Ec2GIYiCjFVu1Kjowpne+OJZGAsoLfNq8TMRv/caCN1dCCGsAZD4Mc6a/PWqSZN/5
 EXbSN57yKiTLBOPlJMKuckMgEgQ/gw56UJEI1CkI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O3BA84030871
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 22:11:10 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 22:11:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 22:11:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O3BA1b015467;
 Wed, 23 Aug 2023 22:11:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 10/17] arm: mach-k3: am625_init: Use IS_ENABLED()
Date: Wed, 23 Aug 2023 22:10:54 -0500
Message-ID: <20230824031101.3460411-11-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230824031101.3460411-1-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
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

Drop the #ifdeffery and use IS_ENABLED() inline check and let the compiler
do it's thing.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
new patch (cleanup before modifying for adding UDA-FS)

 arch/arm/mach-k3/am625_init.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 0e5d44269ebf..165bca6885ef 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -121,10 +121,10 @@ void board_init_f(ulong dummy)
 	struct udevice *dev;
 	int ret;
 
-#if defined(CONFIG_CPU_V7R)
-	setup_k3_mpu_regions();
-	rtc_erratumi2327_init();
-#endif
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		setup_k3_mpu_regions();
+		rtc_erratumi2327_init();
+	}
 
 	/*
 	 * Cannot delay this further as there is a chance that
@@ -156,29 +156,28 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
-#ifdef CONFIG_K3_EARLY_CONS
 	/*
 	 * Allow establishing an early console as required for example when
 	 * doing a UART-based boot. Note that this console may not "survive"
 	 * through a SYSFW PM-init step and will need a re-init in some way
 	 * due to changing module clock frequencies.
 	 */
-	early_console_init();
-#endif
+	if (IS_ENABLED(CONFIG_K3_EARLY_CONS))
+		early_console_init();
 
-#if defined(CONFIG_K3_LOAD_SYSFW)
 	/*
 	 * Configure and start up system controller firmware. Provide
 	 * the U-Boot console init function to the SYSFW post-PM configuration
 	 * callback hook, effectively switching on (or over) the console
 	 * output.
 	 */
-	ret = is_rom_loaded_sysfw(&bootdata);
-	if (!ret)
-		panic("ROM has not loaded TIFS firmware\n");
+	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
+		ret = is_rom_loaded_sysfw(&bootdata);
+		if (!ret)
+			panic("ROM has not loaded TIFS firmware\n");
 
-	k3_sysfw_loader(true, NULL, NULL);
-#endif
+		k3_sysfw_loader(true, NULL, NULL);
+	}
 
 	/*
 	 * Force probe of clk_k3 driver here to ensure basic default clock
@@ -209,11 +208,11 @@ void board_init_f(ulong dummy)
 		enable_mcu_esm_reset();
 	}
 
-#if defined(CONFIG_K3_AM64_DDRSS)
-	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-	if (ret)
-		panic("DRAM init failed: %d\n", ret);
-#endif
+	if (IS_ENABLED(CONFIG_K3_AM64_DDRSS)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret)
+			panic("DRAM init failed: %d\n", ret);
+	}
 	spl_enable_dcache();
 }
 
-- 
2.40.0

