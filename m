Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD16C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C08871A1;
	Sat,  4 Nov 2023 08:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gnBKtSTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBAD487196; Sat,  4 Nov 2023 08:22:08 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B18C8710B
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A47Lrwo031795;
 Sat, 4 Nov 2023 02:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699082513;
 bh=sZT/ZifHc6eBmVnUVxGWp1027BV2bYGJ3Zm38o8qzO0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gnBKtSTI1X7j+YmyoOuVcGiGerFshuUeQ8w5HOsGb2r/n52bq6YOjKJssMTiuJ3rC
 2+zA5od1UjzWtO9c/h3qvv0Nq3GD9sGBkZhip8JkSXH5IUAHGX8SHz98Bur43vQrpn
 TJnrgDIcf5rVdt1/SKF2cVZQr2ALh3UbxYvprGco=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A47LrKX029605
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 02:21:53 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 02:21:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 02:21:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A47LruR017193;
 Sat, 4 Nov 2023 02:21:53 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 03/12] board: ti: j721e: evm: Switch to using IS_ENABLED
Date: Sat, 4 Nov 2023 02:21:41 -0500
Message-ID: <20231104072150.3339-4-nm@ti.com>
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
2.37.2

