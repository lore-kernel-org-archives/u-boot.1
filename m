Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8679DC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 11:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F3CD80790;
	Sat, 18 Jan 2025 12:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h0eT8KHd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PV5JEZK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41AC680312; Sat, 18 Jan 2025 12:17:07 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED91807DC
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZvFW32r1z9smm;
 Sat, 18 Jan 2025 12:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n2zvL2aPOx9kDSFD35DwKeDhCEvH3giRZp3vzmA6jCA=;
 b=h0eT8KHdMFr4bJ24cFpHRsVuf03cS2LdRpVveqyfHnsRqgFyPCBHmQyy0h6HY7kuLGTTsJ
 Vx9sYE1SfzxOla0H0axoIUDaBLrc2uyoYa8Jwc175QI8dDdvDauJr1wLl5KEManApO2hfB
 2UDDd1AaNOULOnAzbZs83BhbXXNoXfxyOQ0RIEK+WQhRjki2pjQXxXgdNpirucpBlp49yZ
 qwIIaWl2R5K41Obv5RD/ryMpudWpk4mgo1GClVuhlTKsjaQlYwUTCQBr5zUHwchlG3x983
 1ChkqDnPZgszGTTJcqUvbuJZUhketcrMXPw2Wi9KzAgsb7MmfwdJU3LGJYeefQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n2zvL2aPOx9kDSFD35DwKeDhCEvH3giRZp3vzmA6jCA=;
 b=PV5JEZK7rEshRSYO8Z6KzAmG51moxynL7zcEXBR4KeNS4qKPgaZ4/OowvLOE97xoB9BzTy
 lg4xidtJMwj42Xh2QdMyAYYKnrkWlXoUIMoe8nc8u3Z6by5YCwr8y+VhfYpQ5vin9Fd6m8
 OVmLLSlyNZWPE2w84V1Tnnn5t3ygVk2CcxinnSymQTkB4ah47JoivjcQMbVcYTZDgKFLbF
 ouS038+rl165qlPqhS/gGwhV3z0BQZG/axUno/iq1ywrD1T+Z7zOszFXVvhUusviFTBChD
 P1HlGQEEbRBPtVuNdI22CW7M8oQ3BrJJpQHSUdgaMGCvkvvpJOYAehe2pZ541A==
To: u-boot@lists.denx.de
Cc: quentin.schulz@cherry.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 8/8] arm64: renesas: Deduplicate R-Car Gen3 and Gen4 SPL
Date: Sat, 18 Jan 2025 12:15:31 +0100
Message-ID: <20250118111621.362188-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mg7ownpb89nzrgg9ca6gdem7iz9ey6uu
X-MBO-RS-ID: 43066e086824013a2a5
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

Move R-Car Gen3 and Gen4 jump_to_image_no_args() into dedicated
rcar64-spl.c file. The implementation of jump_to_image_no_args()
is identical. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 board/renesas/common/Makefile     |  4 +++-
 board/renesas/common/gen3-spl.c   | 21 ---------------------
 board/renesas/common/gen4-spl.c   | 17 -----------------
 board/renesas/common/rcar64-spl.c | 24 ++++++++++++++++++++++++
 4 files changed, 27 insertions(+), 39 deletions(-)
 create mode 100644 board/renesas/common/rcar64-spl.c

diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
index 8c26c0afd90..347be5cc93c 100644
--- a/board/renesas/common/Makefile
+++ b/board/renesas/common/Makefile
@@ -17,7 +17,9 @@ endif
 
 # 64 bit SoCs
 ifdef CONFIG_RCAR_64
-ifndef CONFIG_XPL_BUILD
+ifdef CONFIG_XPL_BUILD
+obj-y	+= rcar64-spl.o
+else
 obj-y	+= rcar64-common.o
 endif
 
diff --git a/board/renesas/common/gen3-spl.c b/board/renesas/common/gen3-spl.c
index 44a20cef2df..9590b5d6a2e 100644
--- a/board/renesas/common/gen3-spl.c
+++ b/board/renesas/common/gen3-spl.c
@@ -5,13 +5,9 @@
  * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <cpu_func.h>
-#include <image.h>
 #include <init.h>
-#include <log.h>
 #include <asm/io.h>
 #include <spl.h>
-#include <linux/bitops.h>
 
 #define RCAR_CNTC_BASE	0xE6080000
 #define CNTCR_EN	BIT(0)
@@ -33,23 +29,6 @@ u32 spl_boot_device(void)
 	return BOOT_DEVICE_UART;
 }
 
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
-{
-	debug("image entry point: 0x%lx\n", spl_image->entry_point);
-	if (spl_image->os == IH_OS_ARM_TRUSTED_FIRMWARE) {
-		typedef void (*image_entry_arg_t)(int, int, int, int)
-			__attribute__ ((noreturn));
-		image_entry_arg_t image_entry =
-			(image_entry_arg_t)(uintptr_t) spl_image->entry_point;
-		image_entry(IH_MAGIC, CONFIG_SPL_TEXT_BASE, 0, 0);
-	} else {
-		typedef void __noreturn (*image_entry_noargs_t)(void);
-		image_entry_noargs_t image_entry =
-			(image_entry_noargs_t)spl_image->entry_point;
-		image_entry();
-	}
-}
-
 void s_init(void)
 {
 }
diff --git a/board/renesas/common/gen4-spl.c b/board/renesas/common/gen4-spl.c
index 2aca8baf3dd..e46ef0a3075 100644
--- a/board/renesas/common/gen4-spl.c
+++ b/board/renesas/common/gen4-spl.c
@@ -76,23 +76,6 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 	return map_sysmem(CONFIG_SYS_LOAD_ADDR + offset, 0);
 }
 
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
-{
-	debug("image entry point: 0x%lx\n", spl_image->entry_point);
-	if (spl_image->os == IH_OS_ARM_TRUSTED_FIRMWARE) {
-		typedef void (*image_entry_arg_t)(int, int, int, int)
-			__attribute__ ((noreturn));
-		image_entry_arg_t image_entry =
-			(image_entry_arg_t)(uintptr_t) spl_image->entry_point;
-		image_entry(IH_MAGIC, CONFIG_SPL_TEXT_BASE, 0, 0);
-	} else {
-		typedef void __noreturn (*image_entry_noargs_t)(void);
-		image_entry_noargs_t image_entry =
-			(image_entry_noargs_t)spl_image->entry_point;
-		image_entry();
-	}
-}
-
 #define APMU_BASE 0xe6170000U
 #define CL0GRP3_BIT			BIT(3)
 #define CL1GRP3_BIT			BIT(7)
diff --git a/board/renesas/common/rcar64-spl.c b/board/renesas/common/rcar64-spl.c
new file mode 100644
index 00000000000..76f2bde924e
--- /dev/null
+++ b/board/renesas/common/rcar64-spl.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Marek Vasut <marek.vasut+renesas@mailbox.org>
+ */
+
+#include <image.h>
+#include <spl.h>
+
+void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+{
+	debug("image entry point: 0x%lx\n", spl_image->entry_point);
+	if (spl_image->os == IH_OS_ARM_TRUSTED_FIRMWARE) {
+		typedef void (*image_entry_arg_t)(int, int, int, int)
+			__attribute__ ((noreturn));
+		image_entry_arg_t image_entry =
+			(image_entry_arg_t)(uintptr_t) spl_image->entry_point;
+		image_entry(IH_MAGIC, CONFIG_SPL_TEXT_BASE, 0, 0);
+	} else {
+		typedef void __noreturn (*image_entry_noargs_t)(void);
+		image_entry_noargs_t image_entry =
+			(image_entry_noargs_t)spl_image->entry_point;
+		image_entry();
+	}
+}
-- 
2.45.2

