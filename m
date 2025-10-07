Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1B0CCD184
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D88483655;
	Tue,  7 Oct 2025 10:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="BUkyKTxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 597958386F; Tue,  7 Oct 2025 10:18:17 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85B2083881
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 33866C9A4A; Tue,  7 Oct 2025 10:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825095; h=from:subject:date:message-id:to:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=24Q/wha0yMl1PsNeMyhM8gJUtvtGsqltqf4RDfBGhag=;
 b=BUkyKTxzIeIeZ5OpzxjTFol0hIvV7zgLAhEynsWEZQKsE90FZUsmcVc6PnV1da1Jnhq6m1
 CjSeuo5iMK+B2GaGaqquBUoyNELsDq0UakS6MV06Q/d28CKfYVqypL9avLVrwGA/CPN4Y7
 npAo16VPXARH8oyzaR2daxFk9cCfJY+TEGXq/Ya/xYNSQW+Cn9IWFbEpH35jThn3sZZCi5
 79jD5VXCXrbW/YmhOReeoXsbMzxrqn1VORd05ut5a9Z9JBqOUfJ+73y1gl6jRKUglvZOaK
 EpJujKRPA1feiPWeR3V1PkvsPKq84354g2KxMT05sniVPrJ1Fo5NJmRsLfIu7Q==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH 03/13] imx: kontron-sl-mx8mm: Remove deprecation warning for
 old modules
Date: Tue,  7 Oct 2025 10:16:00 +0200
Message-ID: <20251007081640.61772-4-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The module version this warning is referring to never really existed
except for in-house development and there is a conflict with the
I2C address used for detecting it and the I2C EEPROM of the latest
OSM-S module. Remove the check.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx8mm/spl.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/board/kontron/sl-mx8mm/spl.c b/board/kontron/sl-mx8mm/spl.c
index 54ee1e66a7a..e3b029752b8 100644
--- a/board/kontron/sl-mx8mm/spl.c
+++ b/board/kontron/sl-mx8mm/spl.c
@@ -129,17 +129,6 @@ int do_board_detect(void)
 		       (unsigned int)gd->ram_size);
 	}
 
-	/*
-	 * Check the I2C PMIC to detect the deprecated SoM with DA9063.
-	 */
-	imx_iomux_v3_setup_multiple_pads(i2c1_pads, ARRAY_SIZE(i2c1_pads));
-
-	if (i2c_get_chip_for_busnum(0, 0x58, 0, &udev) == 0) {
-		printf("### ATTENTION: DEPRECATED SOM REVISION (N8010 Rev0) DETECTED! ###\n");
-		printf("###  THIS HW IS NOT SUPPORTED AND BOOTING WILL PROBABLY FAIL  ###\n");
-		printf("###             PLEASE UPGRADE TO LATEST MODULE               ###\n");
-	}
-
 	return 0;
 }
 
-- 
2.51.0

