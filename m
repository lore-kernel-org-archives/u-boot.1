Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DF1CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C79D58398C;
	Thu, 30 Oct 2025 17:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cHasDRW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0282D83955; Thu, 30 Oct 2025 17:45:30 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17E63838FA
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id BC2C04E413FD;
 Thu, 30 Oct 2025 16:45:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8CD6860331;
 Thu, 30 Oct 2025 16:45:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C52011808CA9; Thu, 30 Oct 2025 17:45:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761842726; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=UgV3H1KZ413paXJqWusEHPCT5t8u078SbEW7+OnJs6U=;
 b=cHasDRW4uOvIW9wNmKUlt3/HLscx51rsJmLS5U5DSj9wZYL+upe8CHPoczaq+A5KysLOs/
 /cMDuZAA9qB8nYa2RC2gtgoG/fPAalmM6S7mA5ozfeGAh5TgzV0AZbbtwQvKoout81ZkNB
 YFam2T1/ILbSPocGfOpDexHxvX1o9GE4sI7RNysL+nBugEaoa5lIGN8w+KST+thPRP5b4o
 dg7YP42O88/O48MQjLxl+TQIaulZDmPGrx3lBzLiByt/5qgm2zlMlT95BjK6YIA8cSLhXp
 Scp8ItaqUe/z3ZrbaOi3NlSBduaGenzV9EJYk7PZiCSZHi74+BOtRliiq/EEGA==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 30 Oct 2025 17:45:02 +0100
Subject: [PATCH v5 09/20] board: ti: Refactor cape detection code for
 readability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-feature_sysboot_extension_board-v5-9-cfb77672fc68@bootlin.com>
References: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
In-Reply-To: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.3
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

Clean up and reorganize cape detection code structure for improved
maintainability and readability.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 board/ti/common/cape_detect.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detect.c
index da805befabc..7786bdda5d1 100644
--- a/board/ti/common/cape_detect.c
+++ b/board/ti/common/cape_detect.c
@@ -24,19 +24,18 @@ static void sanitize_field(char *text, size_t size)
 
 int extension_board_scan(struct list_head *extension_list)
 {
-	struct extension *cape;
-	struct am335x_cape_eeprom_id eeprom_header;
-
-	int num_capes = 0;
-	int ret, i;
-	struct udevice *dev;
 	unsigned char addr;
-
-	char process_cape_part_number[17] = {'0'};
-	char process_cape_version[5] = {'0'};
-	uint8_t cursor = 0;
+	int num_capes = 0;
 
 	for (addr = CAPE_EEPROM_FIRST_ADDR; addr <= CAPE_EEPROM_LAST_ADDR; addr++) {
+		struct am335x_cape_eeprom_id eeprom_header;
+		char process_cape_part_number[17] = {'0'};
+		char process_cape_version[5] = {'0'};
+		struct extension *cape;
+		struct udevice *dev;
+		u8 cursor = 0;
+		int ret, i;
+
 		ret = i2c_get_chip_for_busnum(CONFIG_CAPE_EEPROM_BUS_NUM, addr, 1, &dev);
 		if (ret)
 			continue;
@@ -59,8 +58,8 @@ int extension_board_scan(struct list_head *extension_list)
 		sanitize_field(eeprom_header.part_number, sizeof(eeprom_header.part_number));
 
 		/* Process cape part_number */
-		memset(process_cape_part_number, 0, sizeof(process_cape_part_number));
-		strncpy(process_cape_part_number, eeprom_header.part_number, 16);
+		strlcpy(process_cape_part_number, eeprom_header.part_number,
+			sizeof(process_cape_part_number));
 		/* Some capes end with '.' */
 		for (i = 15; i >= 0; i--) {
 			if (process_cape_part_number[i] == '.')
@@ -70,8 +69,8 @@ int extension_board_scan(struct list_head *extension_list)
 		}
 
 		/* Process cape version */
-		memset(process_cape_version, 0, sizeof(process_cape_version));
-		strncpy(process_cape_version, eeprom_header.version, 4);
+		strlcpy(process_cape_version, eeprom_header.version,
+			sizeof(process_cape_version));
 		for (i = 0; i < 4; i++) {
 			if (process_cape_version[i] == 0)
 				process_cape_version[i] = '0';
@@ -87,9 +86,12 @@ int extension_board_scan(struct list_head *extension_list)
 
 		snprintf(cape->overlay, sizeof(cape->overlay), "%s-%s.dtbo",
 			 process_cape_part_number, process_cape_version);
-		strncpy(cape->name, eeprom_header.board_name, 32);
-		strncpy(cape->version, process_cape_version, 4);
-		strncpy(cape->owner, eeprom_header.manufacturer, 16);
+		strlcpy(cape->name, eeprom_header.board_name,
+			sizeof(eeprom_header.board_name));
+		strlcpy(cape->version, process_cape_version,
+			sizeof(process_cape_version));
+		strlcpy(cape->owner, eeprom_header.manufacturer,
+			sizeof(eeprom_header.manufacturer) + 1);
 		list_add_tail(&cape->list, extension_list);
 		num_capes++;
 	}

-- 
2.43.0

