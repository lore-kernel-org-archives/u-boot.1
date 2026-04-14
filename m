Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3C3F9D0D3
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 15:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F9A84201;
	Tue, 14 Apr 2026 17:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GkFtAe63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E8398421D; Tue, 14 Apr 2026 17:36:23 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884A8841CD
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 17:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 11AF6C5AAAF
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 15:36:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CC93660410;
 Tue, 14 Apr 2026 15:36:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4D99310451174; 
 Tue, 14 Apr 2026 17:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776180980; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=sGU4ZqTzwrK0tsENZS8xfQyl2/iJF4BkFW81I3BdIZw=;
 b=GkFtAe63IztuqT6PUlboP/Pr6mgw6jn6xAMes9R8beBE7/TGeiW99kNORNgratzt1xCTeL
 qtkUsLVvKuqSe9GaJue41+0IR64lyLXey/qlr6EPdOZWKiwtVsaOC49BwTuu9byZAaUKNA
 B5yqN+spMySUgVnpnIcHWqP8/yswXodYvIK4D8oR5bGFo4AiUxtCNZ/SZWTq1vH9fq2Rtn
 d4V4q7EWWpMvRSnBkCEdG5qdAelM8G6/FHw3KE1l/4tMqj3dx8p+2y20i8iG9ojUhgD0pV
 3mLnh6x8EJ4XEwH80KbBttJZoRJygjgT4uaY+AVI5fKaBtKkttrGBnUIZBLHIg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Andrew Davis <afd@ti.com>,
 Jason Kridner <jkridner@beagleboard.org>,
 "Kory Maincent (TI)" <kory.maincent@bootlin.com>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>,
 Marian Cingel <cingel.marian@gmail.com>
Subject: [PATCH v2] board: ti: cape_detect: Add overlay name lookup table for
 extension boards
Date: Tue, 14 Apr 2026 17:36:11 +0200
Message-ID: <20260414153612.754646-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
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

From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>

Some extension boards have EEPROM part numbers that do not directly match
their devicetree overlay filenames. Introduce a static name_mapping table
and a set_cape_overlay() helper that translates the part number and version
strings read from the EEPROM into the correct overlay filename.

When no entry matches, fall back to the existing behavior of constructing
the overlay name as "<part_number>-<version>.dtbo" directly from the
EEPROM content.

Add an initial entry mapping BB-GREEN-HDMI revision 00A0 to
am335x-bone-hdmi-00a0.dtbo.

Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
---

Changes in v2:
- Use ARRAY_SIZE instead of null-terminated array.
- Declare the function static
---
 board/ti/common/cape_detect.c | 42 +++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detect.c
index 88fa6ae81f0..65bd6ef39ec 100644
--- a/board/ti/common/cape_detect.c
+++ b/board/ti/common/cape_detect.c
@@ -13,6 +13,44 @@
 
 #include "cape_detect.h"
 
+struct name_mapping {
+	char part_number[17];
+	char version[5];
+	char overlay[64];
+};
+
+static struct name_mapping extension_mapping[] = {
+	{
+		"BB-GREEN-HDMI",
+		"00A0",
+		"am335x-bone-hdmi-00a0.dtbo",
+	}
+};
+
+static void set_cape_overlay(char *overlay, char *part_number, char *version)
+{
+	struct name_mapping *mapping;
+
+	for (int i = 0; i < ARRAY_SIZE(extension_mapping); i++) {
+		mapping = &extension_mapping[i];
+
+		if (strncmp(mapping->part_number, part_number,
+			    sizeof(mapping->part_number)))
+			continue;
+
+		if (strncmp(mapping->version, version,
+			    sizeof(mapping->version)))
+			continue;
+
+		strlcpy(overlay, mapping->overlay, sizeof(mapping->overlay));
+		return;
+	}
+
+	/* Use default name extracted from the EEPROM */
+	snprintf(overlay, sizeof(extension_mapping[0].overlay), "%s-%s.dtbo",
+		 part_number, version);
+}
+
 static void sanitize_field(char *text, size_t size)
 {
 	char *c = NULL;
@@ -82,8 +120,8 @@ static int ti_extension_board_scan(struct udevice *dev,
 
 		printf("BeagleBone Cape: %s (0x%x)\n", eeprom_header.board_name, addr);
 
-		snprintf(cape.overlay, sizeof(cape.overlay), "%s-%s.dtbo",
-			 process_cape_part_number, process_cape_version);
+		set_cape_overlay(cape.overlay, process_cape_part_number,
+				 process_cape_version);
 		strlcpy(cape.name, eeprom_header.board_name,
 			sizeof(eeprom_header.board_name));
 		strlcpy(cape.version, process_cape_version,
-- 
2.43.0

