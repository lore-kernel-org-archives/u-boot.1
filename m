Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4A3C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E19ED889DB;
	Wed, 24 Jul 2024 17:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JGu6m6W8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0F48898B; Wed, 24 Jul 2024 17:09:56 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11CA888F6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-389ccd2f0abso27270385ab.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833792; x=1722438592; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRiDcVCSSjJEs/6FAiIGCFP0clyqH3r0UR3wRHKYC38=;
 b=JGu6m6W82ldw62/Wi+MVdDPJSg7GzJ7QTquzxxyPFn861MMRvge1RyLQxYRNlmOeni
 0DG2JpWTd88PdxMMZPRnusHyiSTJSoetJyw6AT3xrVM7G1W6VJwoonxfSL2aViP8Gz5M
 vQQsS/DEkYOrsJuPXAevwaMJ7GjvFe6rNKz38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833792; x=1722438592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRiDcVCSSjJEs/6FAiIGCFP0clyqH3r0UR3wRHKYC38=;
 b=ks/n9rPd1nVgkiE48wgiAULgeF+ax0mnkdMvuhld0EL0YFNMnY4wiOswpwdJ3t3ARj
 O2D0dahkSVQLMRCFeeChzsPcBwer95MF7rtj5qSYqy4oOgcBzl8i36sBYlB1nuPX9YX7
 JjJP0jjwCIEvaDAWzaQObSKnndyKnUHuHbYW0swim6ov9QfRSNWMukjxY9V7C385n46M
 ysjg4/wSVUxtixyODrHq4FSjvFwLaMcIQUbOARC7FURfxyUnmSm2OHFuoXfQYNvwc1IO
 pKLY32CurC71pxr1Cw0sJaNnx3RnKQxi83v12byJge/oSzRL7Knwatlt+YLoByruUVLF
 Ld+w==
X-Gm-Message-State: AOJu0YznaY9w9Mszapj9X3BWQyj5ycgC1EWR0kIfT3sNzm/FEyn+ZjQO
 qjtsuOWDKE3r2E25JKNQKDg0NJAge6lI+CJN8gE+y46gjKrE9igW5szhIz8rKq9LyDqrIlzrIQk
 =
X-Google-Smtp-Source: AGHT+IE3KZW17TmsfvWYx5QiNMkQt0tqiqdnb1LD2Dh+pm4st2P3Tv5Z4xhx96JDqaydphv5YGFQMw==
X-Received: by 2002:a05:6e02:1d8d:b0:375:a180:b3d1 with SMTP id
 e9e14a558f8ab-398e6b9e4e7mr183500855ab.20.1721833792350; 
 Wed, 24 Jul 2024 08:09:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Shiji Yang <yangshiji66@outlook.com>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH 17/35] board_f: Add a new struct to hold pre-relocation info
Date: Wed, 24 Jul 2024 09:09:04 -0600
Message-Id: <20240724150922.2343249-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

Quite a few of the members of struct global_data are only used before
reloction, or have little meaning afterwards, yet they hang around in
struct global_data for the lifetime of U-Boot. This uses up precious
pre-relocation SRAM on many boards.

To help with this, start a new struct which exists only before
relocation. Move new_fdt into this new struct. Drop the display of it
in the 'bdinfo' command as it is probably not very useful.

Note that the field does not exist in SPL builds.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bdinfo.c                      |  1 -
 common/board_f.c                  | 11 +++++++----
 include/asm-generic/global_data.h | 11 +++++++----
 include/board_f.h                 | 23 +++++++++++++++++++++++
 test/cmd/bdinfo.c                 |  2 --
 5 files changed, 37 insertions(+), 11 deletions(-)
 create mode 100644 include/board_f.h

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 437ac4e8630..b53b51acca4 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -154,7 +154,6 @@ static int bdinfo_print_all(struct bd_info *bd)
 	if (IS_ENABLED(CONFIG_CMD_NET))
 		print_eth();
 	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
-	bdinfo_print_num_l("new_fdt", (ulong)map_to_sysmem(gd->new_fdt));
 	bdinfo_print_num_l("fdt_size", (ulong)gd->fdt_size);
 	if (IS_ENABLED(CONFIG_VIDEO))
 		show_video_info();
diff --git a/common/board_f.c b/common/board_f.c
index 1935b1dd11b..2125eb5ca50 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -577,7 +577,7 @@ static int reserve_fdt(void)
 			gd->fdt_size = ALIGN(fdt_totalsize(gd->fdt_blob), 32);
 
 			gd->start_addr_sp = reserve_stack_aligned(gd->fdt_size);
-			gd->new_fdt = map_sysmem(gd->start_addr_sp, gd->fdt_size);
+			gd->boardf->new_fdt = map_sysmem(gd->start_addr_sp, gd->fdt_size);
 			debug("Reserving %lu Bytes for FDT at: %08lx\n",
 			      gd->fdt_size, gd->start_addr_sp);
 		}
@@ -667,10 +667,10 @@ static int init_post(void)
 static int reloc_fdt(void)
 {
 	if (!IS_ENABLED(CONFIG_OF_EMBED)) {
-		if (gd->new_fdt) {
-			memcpy(gd->new_fdt, gd->fdt_blob,
+		if (gd->boardf->new_fdt) {
+			memcpy(gd->boardf->new_fdt, gd->fdt_blob,
 			       fdt_totalsize(gd->fdt_blob));
-			gd->fdt_blob = gd->new_fdt;
+			gd->fdt_blob = gd->boardf->new_fdt;
 		}
 	}
 
@@ -1005,8 +1005,11 @@ static const init_fnc_t init_sequence_f[] = {
 
 void board_init_f(ulong boot_flags)
 {
+	struct board_f boardf;
+
 	gd->flags = boot_flags;
 	gd->flags &= ~GD_FLG_HAVE_CONSOLE;
+	gd->boardf = &boardf;
 
 	if (initcall_run_list(init_sequence_f))
 		hang();
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 0904fcf77fc..bd053f77f6c 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -20,6 +20,7 @@
  */
 
 #ifndef __ASSEMBLY__
+#include <board_f.h>
 #include <cyclic.h>
 #include <event_internal.h>
 #include <fdtdec.h>
@@ -41,6 +42,12 @@ struct global_data {
 	 * @bd: board information
 	 */
 	struct bd_info *bd;
+#ifndef CONFIG_SPL_BUILD
+	/**
+	 * @boardf: information only used before relocation
+	 */
+	struct board_f *boardf;
+#endif
 	/**
 	 * @flags: global data flags
 	 *
@@ -218,10 +225,6 @@ struct global_data {
 	 * @fdt_blob: U-Boot's own device tree, NULL if none
 	 */
 	const void *fdt_blob;
-	/**
-	 * @new_fdt: relocated device tree
-	 */
-	void *new_fdt;
 	/**
 	 * @fdt_size: space reserved for relocated device space
 	 */
diff --git a/include/board_f.h b/include/board_f.h
new file mode 100644
index 00000000000..74fca6df75c
--- /dev/null
+++ b/include/board_f.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 Google LLC
+ * Written by: Simon Glass <sjg@chromeium.org>
+ */
+
+#ifndef __BOARD_F
+#define __BOARD_F
+
+/**
+ * struct board_f: Information used only before relocation
+ *
+ * This struct is set up in board_init_f() and used to deal with relocation. It
+ * is not available after relocation.
+ */
+struct board_f {
+	/**
+	 * @new_fdt: relocated device tree
+	 */
+	void *new_fdt;
+};
+
+#endif
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 027848c3e24..60adc4aa960 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -185,8 +185,6 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	ut_assert(map_to_sysmem(gd->fdt_blob) == env_get_hex("fdtcontroladdr", 0x1234));
 	ut_assertok(test_num_l(uts, "fdt_blob",
 			       (ulong)map_to_sysmem(gd->fdt_blob)));
-	ut_assertok(test_num_l(uts, "new_fdt",
-			       (ulong)map_to_sysmem(gd->new_fdt)));
 	ut_assertok(test_num_l(uts, "fdt_size", (ulong)gd->fdt_size));
 
 	if (IS_ENABLED(CONFIG_VIDEO))
-- 
2.34.1

