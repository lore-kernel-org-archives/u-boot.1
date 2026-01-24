Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE48D715CA
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 05:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF5B83CB5;
	Sat, 24 Jan 2026 06:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="XSLvtvrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FA283C23; Sat, 24 Jan 2026 06:55:11 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E240083C01
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 06:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 10E5B10F26D; Sat, 24 Jan 2026 06:55:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769234103; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=TqDWsiWBHDVGB3utT20RJ9ATyVHoFUCDdauPdgUrMH8=;
 b=XSLvtvrW2/8VUaxzbSwjhoipgx7LR3s1UvaQ9lH0BtxZtPXK+d0qyVi1tXfylK10JE4m4s
 prR4cj5HPv0PNOkj6/Wfpw8wFMA0JDLT2++QGl52vXzBgyjTbHrxDYrVQw3dHGva2EStYn
 578Av26XWJ+TxvuN+JDuELcQjp+oDM7wQvdbl07TJThtQE+ciw1FJpg9KthuuL1xJIcjCl
 sBoUWvuM96ROsTE1UlWOAN1TRP5YmBpHp91yPNhu2NNDLs2ef72MXGUDbbN1CB6Op2RDJj
 IWUPjAAl/ZA+APq52ZJw4LGjb/4dKu2Q53fsKY4IHVxagahNpFQ2XdicN6jiOQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 07/11] siemens: capricorn: add logic to U-Boot to avoid
 zig-zag boot
Date: Sat, 24 Jan 2026 06:54:48 +0100
Message-Id: <20260124055452.8799-8-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260124055452.8799-1-hs@nabladev.com>
References: <20260124055452.8799-1-hs@nabladev.com>
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
a ROMbootloader fallback case.

We use the local hush shell variable, as we do not want
to save in any case the fallback variable in U-Boot
Environment, as the default Environment is may saved
in boards, which are downgraded to older U-Boot versions.

And than the board code does not run, and fallback never
gets the correct value.

Introduce also hush shell variable envvers to value "v2_"
so we can use them in Environment for running different
versions of variables between new and old U-Boot images.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
---

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
index 390a7b0d841..d4f26b6ff7f 100644
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
+	 * But the customer makes a downgrade to an older U-bootversion,
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

