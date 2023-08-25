Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E011C6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E8EB86B16;
	Fri, 25 Aug 2023 20:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gokrxy3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D9086B05; Fri, 25 Aug 2023 20:03:21 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB71686ACA
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PI37vV114044;
 Fri, 25 Aug 2023 13:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692986587;
 bh=VAE3aZIsMX5EO51h1dQLvIPaRF8IAO8YFuw+nIHZklA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gokrxy3s2HobrIHkN+89bhLLSKiNmznuIt4H0zVr4KqXdf4/cVVSpSChsr9Uf0Uce
 lAtpRsY0nVbe9pFAOZkfR2byIHYDwinll4mx5byCST1/RijKWXBIVbmavMgSLYzVme
 p37zlcY7SXCS4lIeoCN5idOZwpTtd8yWbYdrGPnA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PI37oq066168
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 13:03:07 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 13:03:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 13:03:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36WX114813;
 Fri, 25 Aug 2023 13:03:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 12/20] arm: mach-k3: am625_init: Use IS_ENABLED()
Date: Fri, 25 Aug 2023 13:02:57 -0500
Message-ID: <20230825180305.69515-13-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230825180305.69515-1-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
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

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
No change other than picking up reviews, tested tags along the way.
V5: https://lore.kernel.org/r/20230824031101.3460411-11-nm@ti.com
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

