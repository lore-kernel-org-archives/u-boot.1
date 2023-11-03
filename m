Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18B2C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E1F387771;
	Fri,  3 Nov 2023 01:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SzMOHG0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF0B876E2; Fri,  3 Nov 2023 01:38:57 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C3687711
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A30c8sv019795;
 Thu, 2 Nov 2023 19:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698971888;
 bh=ET8olNwV84RjCTsKFr/zVyItZ5vp+iJYphfyUyC2dtI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=SzMOHG0KUTn92V/NRHSgx4FQ6yvs15LSL3sBNlMKeMsEFO3Ug/M1sIr+6YteWOoJY
 xjJJEoJGIobWyLpZrIJgk+TEEchgbOcbipbCvxz5WO3bbNhxy0fmUYrh1wq4cI76AI
 hrUEdZrL6jzpBxn/nJqjvS/wxXpbr7rg3DNlisxk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A30c8Fk017624
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:38:08 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:38:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:38:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A30c8OT030436;
 Thu, 2 Nov 2023 19:38:08 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 05/15] board: ti: j721e: evm: Switch to using IS_ENABLED
Date: Thu, 2 Nov 2023 19:37:55 -0500
Message-ID: <20231103003805.2420005-6-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231103003805.2420005-1-nm@ti.com>
References: <20231103003805.2420005-1-nm@ti.com>
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

Switch to using IS_ENABLED() for inline function usage.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/ti/j721e/evm.c | 83 ++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 8f0996c32ee6..17640ae79665 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -300,53 +300,54 @@ static int probe_daughtercards(void)
 		printf("Detected: %s rev %s\n", ep.name, ep.version);
 		daughter_card_detect_flags[i] = true;
 
-#ifndef CONFIG_SPL_BUILD
-		int j;
-		/*
-		 * Populate any MAC addresses from daughtercard into the U-Boot
-		 * environment, starting with a card-specific offset so we can
-		 * have multiple ext_cards contribute to the MAC pool in a well-
-		 * defined manner.
-		 */
-		for (j = 0; j < mac_addr_cnt; j++) {
-			if (!is_valid_ethaddr((u8 *)mac_addr[j]))
-				continue;
-
-			eth_env_set_enetaddr_by_index("eth",
-						      ext_cards[i].eth_offset + j,
-						      (uchar *)mac_addr[j]);
+		if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+			int j;
+			/*
+			 * Populate any MAC addresses from daughtercard into the U-Boot
+			 * environment, starting with a card-specific offset so we can
+			 * have multiple ext_cards contribute to the MAC pool in a well-
+			 * defined manner.
+			 */
+			for (j = 0; j < mac_addr_cnt; j++) {
+				if (!is_valid_ethaddr((u8 *)mac_addr[j]))
+					continue;
+
+				eth_env_set_enetaddr_by_index("eth",
+							      ext_cards[i].eth_offset + j,
+							      (uchar *)mac_addr[j]);
+			}
 		}
-#endif
 	}
-#ifndef CONFIG_SPL_BUILD
-	char name_overlays[1024] = { 0 };
 
-	for (i = 0; i < ARRAY_SIZE(ext_cards); i++) {
-		if (!daughter_card_detect_flags[i])
-			continue;
+	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+		char name_overlays[1024] = { 0 };
 
-		/* Skip if no overlays are to be added */
-		if (!strlen(ext_cards[i].dtbo_name))
-			continue;
+		for (i = 0; i < ARRAY_SIZE(ext_cards); i++) {
+			if (!daughter_card_detect_flags[i])
+				continue;
 
-		/*
-		 * Make sure we are not running out of buffer space by checking
-		 * if we can fit the new overlay, a trailing space to be used
-		 * as a separator, plus the terminating zero.
-		 */
-		if (strlen(name_overlays) + strlen(ext_cards[i].dtbo_name) + 2 >
-		    sizeof(name_overlays))
-			return -ENOMEM;
-
-		/* Append to our list of overlays */
-		strcat(name_overlays, ext_cards[i].dtbo_name);
-		strcat(name_overlays, " ");
-	}
+			/* Skip if no overlays are to be added */
+			if (!strlen(ext_cards[i].dtbo_name))
+				continue;
 
-	/* Apply device tree overlay(s) to the U-Boot environment, if any */
-	if (strlen(name_overlays))
-		return env_set("name_overlays", name_overlays);
-#endif
+			/*
+			 * Make sure we are not running out of buffer space by checking
+			 * if we can fit the new overlay, a trailing space to be used
+			 * as a separator, plus the terminating zero.
+			 */
+			if (strlen(name_overlays) + strlen(ext_cards[i].dtbo_name) + 2 >
+			    sizeof(name_overlays))
+				return -ENOMEM;
+
+			/* Append to our list of overlays */
+			strcat(name_overlays, ext_cards[i].dtbo_name);
+			strcat(name_overlays, " ");
+		}
+
+		/* Apply device tree overlay(s) to the U-Boot environment, if any */
+		if (strlen(name_overlays))
+			return env_set("name_overlays", name_overlays);
+	}
 
 	return 0;
 }
-- 
2.40.0

