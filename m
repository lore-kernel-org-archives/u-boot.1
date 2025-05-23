Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3444C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72483833EB;
	Fri, 23 May 2025 19:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A442C8334D; Fri, 23 May 2025 19:20:32 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0BFB83278
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uIW4L-0076pt-4h;
 Fri, 23 May 2025 17:20:29 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 07/13] board: venice: use SOM model for PMIC adjustment on SOM
Date: Fri, 23 May 2025 10:20:12 -0700
Message-Id: <20250523172018.4164647-7-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523172018.4164647-1-tharvey@gateworks.com>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use the SOM model to adjust PMIC settings on SOM's.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/eeprom.c | 7 +++++++
 board/gateworks/venice/eeprom.h | 1 +
 board/gateworks/venice/spl.c    | 6 ++----
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/board/gateworks/venice/eeprom.c b/board/gateworks/venice/eeprom.c
index 351d18886f14..41f620c90e72 100644
--- a/board/gateworks/venice/eeprom.c
+++ b/board/gateworks/venice/eeprom.c
@@ -19,6 +19,7 @@
 struct venice_board_info som_info;
 struct venice_board_info base_info;
 char venice_model[32];
+char venice_som_model[32];
 char venice_baseboard_model[32];
 u32 venice_serial;
 
@@ -315,6 +316,7 @@ int venice_eeprom_init(int quiet)
 		memset(&som_info, 0, sizeof(som_info));
 		return 0;
 	}
+	strlcpy(venice_som_model, som_info.model, sizeof(venice_som_model));
 
 	/* read optional baseboard EEPROM */
 	eeprom_read(BASEBOARD_EEPROM_BUSNO, BASEBOARD_EEPROM_ADDR, 2, &base_info);
@@ -368,6 +370,11 @@ const char *eeprom_get_model(void)
 	return venice_model;
 }
 
+const char *eeprom_get_som_model(void)
+{
+	return venice_som_model;
+}
+
 const char *eeprom_get_baseboard_model(void)
 {
 	return venice_baseboard_model;
diff --git a/board/gateworks/venice/eeprom.h b/board/gateworks/venice/eeprom.h
index bb7a5fa9ad1f..30cd347d9453 100644
--- a/board/gateworks/venice/eeprom.h
+++ b/board/gateworks/venice/eeprom.h
@@ -26,6 +26,7 @@ struct venice_board_info {
 
 int venice_eeprom_init(int quiet);
 const char *eeprom_get_model(void);
+const char *eeprom_get_som_model(void);
 const char *eeprom_get_baseboard_model(void);
 const char *eeprom_get_dtb_name(int level, char *buf, int len);
 int eeprom_getmac(int index, uint8_t *enetaddr);
diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index 275f9d3453ea..f14ab1497d70 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -57,6 +57,7 @@ static int dm_i2c_clrsetbits(struct udevice *dev, uint reg, uint clr, uint set)
 
 static int power_init_board(const char *model, struct udevice *gsc)
 {
+	const char *som = eeprom_get_som_model();
 	struct udevice *bus;
 	struct udevice *dev;
 	int ret;
@@ -77,10 +78,7 @@ static int power_init_board(const char *model, struct udevice *gsc)
 		}
 	}
 
-	if ((!strncmp(model, "GW71", 4)) ||
-	    (!strncmp(model, "GW72", 4)) ||
-	    (!strncmp(model, "GW73", 4)) ||
-	    (!strncmp(model, "GW75", 4))) {
+	if (!strncmp(som, "GW70", 4)) {
 		ret = uclass_get_device_by_seq(UCLASS_I2C, 0, &bus);
 		if (ret) {
 			printf("PMIC    : failed I2C1 probe: %d\n", ret);
-- 
2.25.1

