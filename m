Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C32C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 06:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F80D81026;
	Tue, 22 Apr 2025 08:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D07810E8; Tue, 22 Apr 2025 08:49:41 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAAE58056A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 08:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 350E3B4C0206;
 Tue, 22 Apr 2025 08:49:38 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH v1] board: starfive: visionfive2: Order board detection logic
 to match config
Date: Mon, 21 Apr 2025 23:49:17 -0700
Message-ID: <20250422064925.635394-1-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
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

Refactor inside-out EEPROM-checking logic to better match the board-seeking
callback and ordered list of targets from starfive_visionfive2_config since
the JH7110 OF_UPSTREAM migration.

Signed-off-by: E Shattow <e@freeshell.de>
---
 board/starfive/visionfive2/spl.c | 40 ++++++++++++++------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 3e4d3e21988..4d319f65a36 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -116,30 +116,26 @@ void board_init_f(ulong dummy)
 #if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	const char *product_id;
-	u8 version;
-
-	product_id = get_product_id_from_eeprom();
-
-	/* Strip off prefix */
-	if (strncmp(name, "starfive/", 9))
-		return -EINVAL;
-	name += 9;
-	if (!strncmp(product_id, "VF7110", 6)) {
-		version = get_pcb_revision_from_eeprom();
-		if ((version == 'b' || version == 'B') &&
-		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
-			return 0;
-
-		if ((version == 'a' || version == 'A') &&
-		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
-			return 0;
-	} else if (!strncmp(product_id, "MARS", 4) &&
-		   !strcmp(name, "jh7110-milkv-mars")) {
+	if(!strcmp(name, "starfive/jh7110-milkv-mars") &&
+	   !strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
 		return 0;
-	} else if (!strncmp(product_id, "STAR64", 6) &&
-		   !strcmp(name, "jh7110-pine64-star64")) {
+	} else if((!strcmp(name, "starfive/jh7110-pine64-star64")) &&
+	   !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		return 0;
+	} else if((!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2a")) &&
+	   !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
+		switch (get_pcb_revision_from_eeprom()) {
+		case 'a':
+		case 'A':
+			return 0;
+		}
+	} else if((!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2b")) &&
+	   !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
+		switch (get_pcb_revision_from_eeprom()) {
+		case 'b':
+		case 'B':
+			return 0;
+		}
 	}
 
 	return -EINVAL;

base-commit: cde0050618968aae335dfbc930641656d51ff5d0
prerequisite-patch-id: 3fdb915979e0c14c53e387fcf00d2dcaae28165e
prerequisite-patch-id: 1a0c600d97801d90a464a645794ae65df41f2789
-- 
2.49.0

