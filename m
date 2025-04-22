Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1CDC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 06:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BDAD81E25;
	Tue, 22 Apr 2025 08:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 956AA8171B; Tue, 22 Apr 2025 08:46:33 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFFBF810EB
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 08:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C42DCB4C088B;
 Tue, 22 Apr 2025 08:46:29 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/2] board: starfive: visionfive2: Drop setting of $fdtfile
Date: Mon, 21 Apr 2025 23:45:26 -0700
Message-ID: <20250422064541.635210-3-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422064541.635210-1-e@freeshell.de>
References: <20250422064541.635210-1-e@freeshell.de>
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

Remove board detection logic from main payload that is duplicated from SPL
and do not set convenience data into $fdtfile environment variable. U-Boot
"starfive visionfive2" board target(s) now boot on recent upstream Linux
Kernel releases without this manipulation since the JH7110 OF_UPSTREAM
migration. Changes to $fdtfile by users (i.e. following newer or older Linux
Kernel releases) should follow the advice in general U-Boot documentation.

Signed-off-by: E Shattow <e@freeshell.de>
---
 .../visionfive2/starfive_visionfive2.c        | 61 -------------------
 1 file changed, 61 deletions(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index b8cd509bc89..039a32f1874 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -17,14 +17,6 @@
 DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
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
@@ -45,51 +37,6 @@ static void enable_prefetcher(void)
 	}
 }
 
-/**
- * set_fdtfile() - set the $fdtfile variable based on the board revision
- */
-static void set_fdtfile(void)
-{
-	u8 version;
-	const char *fdtfile;
-	const char *product_id;
-
-	fdtfile = env_get("fdtfile");
-	if (fdtfile)
-		return;
-
-	product_id = get_product_id_from_eeprom();
-	if (!product_id) {
-		log_err("Can't read EEPROM\n");
-		return;
-	}
-	if (!strncmp(product_id, "MARS", 4)) {
-		fdtfile = FDTFILE_MILK_V_MARS;
-	} else if (!strncmp(product_id, "VF7110", 6)) {
-		version = get_pcb_revision_from_eeprom();
-
-		switch (version) {
-		case 'a':
-		case 'A':
-			fdtfile = FDTFILE_VISIONFIVE2_1_2A;
-			break;
-
-		case 'b':
-		case 'B':
-		default:
-			fdtfile = FDTFILE_VISIONFIVE2_1_3B;
-			break;
-		}
-	} else if (!strncmp(product_id, "STAR64", 6)) {
-		fdtfile = FDTFILE_PINE64_STAR64;
-	} else {
-		log_err("Unknown product\n");
-		return;
-	}
-
-	env_set("fdtfile", fdtfile);
-}
-
 int board_init(void)
 {
 	enable_caches();
@@ -98,14 +45,6 @@ int board_init(void)
 	return 0;
 }
 
-int board_late_init(void)
-{
-	if (CONFIG_IS_ENABLED(ID_EEPROM))
-		set_fdtfile();
-
-	return 0;
-}
-
 int board_fdt_blob_setup(void **fdtp)
 {
 	if (gd->arch.firmware_fdt_addr) {
-- 
2.49.0

