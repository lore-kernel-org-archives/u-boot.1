Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65843CA1005
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 02:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC53483403;
	Wed,  3 Sep 2025 04:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E986D83438; Wed,  3 Sep 2025 04:08:24 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 958BF833D0
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 04:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id AAC86B22028C;
 Wed,  3 Sep 2025 04:08:20 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Subject: [PATCH v1] board: starfive: visionfive2: deprecate mixed-case product
 ids VF7110a VF7110b
Date: Tue,  2 Sep 2025 19:07:06 -0700
Message-ID: <20250903020715.682143-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Per recent discussion [1] product IDs VF7110A or VF7110B from EEPROM are
sufficient to select for VisionFive 2 1.2a or VisionFive 2 1.3b boards.
There are no VisionFive 2 products with mixed-case product IDs in EERPOM
so factor out the unnecessary select case conditional.

1: https://lore.kernel.org/u-boot/ZQ2PR01MB1307D97D2C9566B8EE443812E6062@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn/

Signed-off-by: E Shattow <e@freeshell.de>
Reported-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c               | 16 ++++------------
 .../visionfive2/starfive_visionfive2.c         | 18 ++++--------------
 2 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 3dfa931b655..9dfe0bea5f1 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -126,19 +126,11 @@ int board_fit_config_name_match(const char *name)
 		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2a") &&
-		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
-		switch (get_pcb_revision_from_eeprom()) {
-		case 'a':
-		case 'A':
-			return 0;
-		}
+		    !strncmp(get_product_id_from_eeprom(), "VF7110A", 7)) {
+		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.3b") &&
-		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
-		switch (get_pcb_revision_from_eeprom()) {
-		case 'b':
-		case 'B':
-			return 0;
-		}
+		    !strncmp(get_product_id_from_eeprom(), "VF7110B", 7)) {
+		return 0;
 	}
 
 	return -EINVAL;
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index bfbb11a2ee7..6271974b9c7 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -59,20 +59,10 @@ static void set_fdtfile(void)
 		fdtfile = "starfive/jh7110-milkv-mars.dtb";
 	} else if (!strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		fdtfile = "starfive/jh7110-pine64-star64.dtb";
-	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
-		switch (get_pcb_revision_from_eeprom()) {
-		case 'a':
-		case 'A':
-			fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
-			break;
-		case 'b':
-		case 'B':
-			fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
-			break;
-		default:
-			log_err("Unknown revision\n");
-			return;
-		}
+	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7)) {
+		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
+	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7)) {
+		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
 	} else {
 		log_err("Unknown product\n");
 		return;

base-commit: e4c8b32d03d7ecffd586b7d33336603ad639d7c0
-- 
2.50.0

