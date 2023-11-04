Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1DAC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32437871E9;
	Sat,  4 Nov 2023 08:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o+MlFn1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9669086FBD; Sat,  4 Nov 2023 08:22:22 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6BD86F81
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A47Lrvn031793;
 Sat, 4 Nov 2023 02:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699082513;
 bh=e+RymVpsVjnHbkQ3VM+lQ4hMB0ecWkNe6aK/YFq8Klo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=o+MlFn1OBFDtpfbbFbgNGLrjWIn212d2EQizvJFicLC9eFXaqndRDlfxV5cX7Za7i
 bSqRDdZ2gWk+HbnqBcXsEmUw9fspzhgupGJM745uhqqKA4d2NHrOqWnHaiqOY9i/pW
 rtCbBoDaBC4fZ4hvjhKSoLOnqhoGYB7qnPD7gLX4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A47LrTi002803
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 02:21:53 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 02:21:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 02:21:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A47LraP103846;
 Sat, 4 Nov 2023 02:21:53 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 02/12] board: ti: j721e: evm: Drop board check for ESM
Date: Sat, 4 Nov 2023 02:21:40 -0500
Message-ID: <20231104072150.3339-3-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104072150.3339-1-nm@ti.com>
References: <20231104072150.3339-1-nm@ti.com>
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

When config is enabled, the esm dt probe makes sense. Simplify by
dropping board specific checks.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/ti/j721e/evm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index aa22f1653fec..8f0996c32ee6 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -523,10 +523,8 @@ err_free_gpio:
 
 void spl_board_init(void)
 {
-#if defined(CONFIG_ESM_K3) || defined(CONFIG_ESM_PMIC)
 	struct udevice *dev;
 	int ret;
-#endif
 
 	if ((IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM) ||
 	     IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM)) &&
@@ -535,24 +533,20 @@ void spl_board_init(void)
 			probe_daughtercards();
 	}
 
-#ifdef CONFIG_ESM_K3
-	if (board_ti_k3_is("J721EX-PM2-SOM")) {
+	if (IS_ENABLED(CONFIG_ESM_K3)) {
 		ret = uclass_get_device_by_driver(UCLASS_MISC,
 						  DM_DRIVER_GET(k3_esm), &dev);
 		if (ret)
 			printf("ESM init failed: %d\n", ret);
 	}
-#endif
 
-#ifdef CONFIG_ESM_PMIC
-	if (board_ti_k3_is("J721EX-PM2-SOM")) {
+	if (IS_ENABLED(CONFIG_ESM_PMIC)) {
 		ret = uclass_get_device_by_driver(UCLASS_MISC,
 						  DM_DRIVER_GET(pmic_esm),
 						  &dev);
 		if (ret)
 			printf("ESM PMIC init failed: %d\n", ret);
 	}
-#endif
 	if ((IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM) || IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM)) &&
 	    IS_ENABLED(CONFIG_HBMC_AM654)) {
 		struct udevice *dev;
-- 
2.37.2

