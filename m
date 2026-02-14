Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E21EF99E1
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDEA83E8E;
	Sat, 14 Feb 2026 05:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="G2do7eD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC8E683EA6; Sat, 14 Feb 2026 05:57:16 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A1D83E13
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 05:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0FE781101C5; Sat, 14 Feb 2026 05:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771045034; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=UCRHwP3OvsTVM0LUBmaiwt7rQ4ghme3XiUdnHY7P32U=;
 b=G2do7eD2qkj/acKL0q4PysYr1btCMzfqR/k5BD5CVXchkMo5Rp8gG9JgHmAOcYtb93ACZB
 1I7NXTDFxQzET3XFUwWsxlsmvDKXedoRtBUCHObVycqfZElyzUs0bKW4FdSLCHhC5+MkGG
 LKq0OR95JNfKDqf2r8l64Q36oEvRScozo/7lE/tXfjLNuWUwUlfNJLFyjWkhh+zg3ki6Sv
 0xkqMNXIoe4Q0LdR5tv5GE2ksmbmMHEXwATZDSdVYZ9hK7NJAT6hGiZ1e+ljwf3Am05oA3
 +V9J7KJ+VibWmybRCYxSiR7JeW+bemh6PbXalaZ4ld7b7I9pSGHsk/cby4KPew==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Heiko Schocher <hs@nabladev.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/11] siemens: capricorn: add logic to U-Boot to avoid
 zig-zag boot
Date: Sat, 14 Feb 2026 05:56:59 +0100
Message-Id: <20260214045703.28051-8-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260214045703.28051-1-hs@nabladev.com>
References: <20260214045703.28051-1-hs@nabladev.com>
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

add logic in board code for detecting the real boot
partition and set a local hush shell variable fallback
which can be used later in boot variables for detecting
a ROM bootloader fallback case.

We use the local hush shell variable, as we do not want
to save in any case the fallback variable in U-Boot
Environment, as the default Environment is maybe saved
in boards, which are downgraded to older U-Boot versions.

And than the board code does not run, and fallback never
gets the correct value.

Introduce also hush shell variable envvers to value "v2_"
so we can use them in Environment for running different
versions of variables between new and old U-Boot images.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

Changes in v2:
Added Reviewed-by from Peng
fixed typos in commit message and board code

 board/siemens/capricorn/Kconfig |  2 ++
 board/siemens/capricorn/board.c | 43 +++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/board/siemens/capricorn/Kconfig b/board/siemens/capricorn/Kconfig
index fe230971e97..d6d1aad75b2 100644
--- a/board/siemens/capricorn/Kconfig
+++ b/board/siemens/capricorn/Kconfig
@@ -1,5 +1,7 @@
 if TARGET_CAPRICORN
 
+config HUSH_INIT_VAR
+	def_bool y
 
 config SYS_BOARD
 	default "capricorn"
diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index 390a7b0d841..34e7f2d1713 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -5,6 +5,7 @@
  * Copyright 2019 Siemens AG
  *
  */
+#include <cli_hush.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
@@ -29,6 +30,7 @@
 #include "../common/board.h"
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
+#include <firmware/imx/sci/sci.h>
 
 #define GPIO_PAD_CTRL \
 		((SC_PAD_CONFIG_NORMAL << PADRING_CONFIG_SHIFT) | \
@@ -373,23 +375,48 @@ __weak int mmc_map_to_kernel_blk(int dev_no)
 
 void board_late_mmc_env_init(void)
 {
-	char cmd[32];
-	char mmcblk[32];
 	u32 dev_no = mmc_get_env_dev();
 
 	if (!check_mmc_autodetect())
 		return;
 
 	env_set_ulong("mmcdev", dev_no);
+}
+
+#if defined(CONFIG_HUSH_INIT_VAR)
+int hush_init_var(void)
+{
+	sc_misc_bt_t boot_type;
 
-	/* Set mmcblk env */
-	sprintf(mmcblk, "/dev/mmcblk%dp2 rootwait rw",
-		mmc_map_to_kernel_blk(dev_no));
-	env_set("mmcroot", mmcblk);
+	if (sc_misc_get_boot_type(-1, &boot_type) != 0) {
+		puts("boottype cannot be retrieved\n");
+		return 0;
+	}
+
+	/*
+	 * Set here explicitly a hush shell variable, so if a saveenv
+	 * happens, this variable is *not* saved in U-Boot environment.
+	 *
+	 * This is for devices which are already in the field essential,
+	 * as if such a device breaks, the cutsomer gets a new device
+	 * with a new U-Boot version (and so a new U-Boot environment).
+	 *
+	 * But the customer makes a downgrade to an older U-Boot version,
+	 * which does not have this code in, and runs now with a new
+	 * U-Boot Environment (yes, protected Environment is not enabled
+	 * there) and the old U-Boot must still work with the new U-Boot
+	 * Environment. So we cannot store this variable in U-Boot
+	 * Environment as a stored value will in this case never be over-
+	 * written.
+	 */
+	if (boot_type == 1) {
+		printf("boot-container fallback ocured\n");
+		set_local_var("fallback=1", 0);
+	}
 
-	sprintf(cmd, "mmc dev %d", dev_no);
-	run_command(cmd, 0);
+	return 0;
 }
+#endif
 
 #ifndef CONFIG_XPL_BUILD
 static int load_parameters_from_factoryset(void)
-- 
2.20.1

