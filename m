Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CEFC369AB
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 06:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A426810EB;
	Sun, 27 Apr 2025 08:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EBFD81E0F; Sun, 27 Apr 2025 08:04:24 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B754680FDE
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 08:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0A6FCB4C1EAE;
 Sun, 27 Apr 2025 08:04:19 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH v2] board: starfive: visionfive2: Order board detection logic
 to match config
Date: Sat, 26 Apr 2025 23:02:52 -0700
Message-ID: <20250427060301.709506-1-e@freeshell.de>
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

Fixup previous merge resolution of this series. Intent is to ease code
readability and logic to match ordering in CONFIG_OF_LIST

- Remove "starfive/" string math
- Remove redundant local cache of calls to get_*_from_eeprom()
- Match name before EEPROM product_id in board_fit_config_name_match()
- Remove single-consumer FDTFILE_* defines
- Do not set fdtfile for visionfive-2-* when unknown model revision

Fixes: 5a0a93a76848 ("Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-riscv")

Signed-off-by: E Shattow <e@freeshell.de>
---
 board/starfive/visionfive2/spl.c              | 33 +++-----------
 .../visionfive2/starfive_visionfive2.c        | 43 +++++++------------
 2 files changed, 21 insertions(+), 55 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 353313b9e88..3dfa931b655 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -116,44 +116,23 @@ void board_init_f(ulong dummy)
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
-	if (!strncmp(product_id, "FML13V01", 8) &&
-	    !strcmp(name, "jh7110-deepcomputing-fml13v01")) {
-		return 0;
-	} else if (!strncmp(product_id, "VF7110", 6)) {
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
+	if (!strcmp(name, "starfive/jh7110-deepcomputing-fml13v01") &&
+		    !strncmp(get_product_id_from_eeprom(), "FML13V01", 8)) {
 		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-milkv-mars") &&
-		   !strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
+		    !strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
 		return 0;
-	} else if ((!strcmp(name, "starfive/jh7110-pine64-star64")) &&
+	} else if (!strcmp(name, "starfive/jh7110-pine64-star64") &&
 		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		return 0;
-	} else if ((!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2a")) &&
+	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2a") &&
 		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
 		switch (get_pcb_revision_from_eeprom()) {
 		case 'a':
 		case 'A':
 			return 0;
 		}
-	} else if ((!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2b")) &&
+	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.3b") &&
 		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
 		switch (get_pcb_revision_from_eeprom()) {
 		case 'b':
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 4b273e52e9a..bfbb11a2ee7 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -17,16 +17,6 @@
 DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
-#define FDTFILE_FML13V01 \
-	"starfive/jh7110-deepcomputing-fml13v01.dtb"
-#define FDTFILE_MILK_V_MARS \
-	"starfive/jh7110-milkv-mars.dtb"
-#define FDTFILE_VISIONFIVE2_1_2A \
-	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
-#define FDTFILE_VISIONFIVE2_1_3B \
-	"starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
-#define FDTFILE_PINE64_STAR64 \
-	"starfive/jh7110-pine64-star64.dtb"
 
 /* enable U74-mc hart1~hart4 prefetcher */
 static void enable_prefetcher(void)
@@ -48,44 +38,41 @@ static void enable_prefetcher(void)
 }
 
 /**
- * set_fdtfile() - set the $fdtfile variable based on the board revision
+ * set_fdtfile() - set the $fdtfile variable based on product data in EEPROM
  */
 static void set_fdtfile(void)
 {
-	u8 version;
 	const char *fdtfile;
-	const char *product_id;
 
 	fdtfile = env_get("fdtfile");
 	if (fdtfile)
 		return;
 
-	product_id = get_product_id_from_eeprom();
-	if (!product_id) {
+	if (!get_product_id_from_eeprom()) {
 		log_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "FML13V01", 8)) {
-		fdtfile = FDTFILE_FML13V01;
-	} else if (!strncmp(product_id, "MARS", 4)) {
-		fdtfile = FDTFILE_MILK_V_MARS;
-	} else if (!strncmp(product_id, "VF7110", 6)) {
-		version = get_pcb_revision_from_eeprom();
 
-		switch (version) {
+	if (!strncmp(get_product_id_from_eeprom(), "FML13V01", 8)) {
+		fdtfile = "starfive/jh7110-deepcomputing-fml13v01.dtb";
+	} else if (!strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
+		fdtfile = "starfive/jh7110-milkv-mars.dtb";
+	} else if (!strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
+		fdtfile = "starfive/jh7110-pine64-star64.dtb";
+	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
+		switch (get_pcb_revision_from_eeprom()) {
 		case 'a':
 		case 'A':
-			fdtfile = FDTFILE_VISIONFIVE2_1_2A;
+			fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
 			break;
-
 		case 'b':
 		case 'B':
-		default:
-			fdtfile = FDTFILE_VISIONFIVE2_1_3B;
+			fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
 			break;
+		default:
+			log_err("Unknown revision\n");
+			return;
 		}
-	} else if (!strncmp(product_id, "STAR64", 6)) {
-		fdtfile = FDTFILE_PINE64_STAR64;
 	} else {
 		log_err("Unknown product\n");
 		return;

base-commit: 5a0a93a768487e55ebe50a34cc90d751bf99cc56
-- 
2.49.0

