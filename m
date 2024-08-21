Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2659FC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7625388E4A;
	Wed, 21 Aug 2024 18:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="le6fE5Nz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98FF688E3B; Wed, 21 Aug 2024 18:19:55 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5194B88E2A
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-70942ebcc29so4691062a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257192; x=1724861992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J069fjtCukUQl6BWW5majxQ7J8lZvOVTd1vTkeDsIZo=;
 b=le6fE5NzfIcDzRpuHM4flMOeGvxYUrbw2HiE5hbU/962qfPjrU0yeQdvisNbJqPH5Q
 cQVZxuknNGdEcMCRJ28q7o2UuGSLKaIt4FyneiA6v2u/6GZM0Cu/RwXnP15oSt+pZbD1
 6OMjAVV8uZUkwRn9ySSr8k3Ul3QUQoZaerFms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257192; x=1724861992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J069fjtCukUQl6BWW5majxQ7J8lZvOVTd1vTkeDsIZo=;
 b=rp7vJ8hChOw0HTFh3wBQAW7QcAv4wIa3TLTMKINsQGQ7EoS4ZK7oiApWIUjZmR68TQ
 +v/0Ox5WiCLrcQqZVl6E7VGaY8uH/rQLkYbFiM+nmZWudRK63W7zEXE7kQgZDAZccRGQ
 8iHBdc5cX09r3Gh5O62UuqqYksllAg6Niae9zluxbLCvheZVSr6XshXntxq8aKu4Z0bF
 sG6F+WASgHX/FN7dGY4tdbOYlAKXhQH8nyegB5n1g8Dr0jurjMb5cHSwJN/9JxDeCdNG
 nRKvC/WUS4SrmKnRGUzJeIVFiIDQ6j6JGMyrE9JltEjxh0D1lbEt7jHX2oq5chy3pA1D
 Zn8Q==
X-Gm-Message-State: AOJu0YwJ/ENLV28r27h9H8dyJMncKVQ0DkwgNCbDIUzP2KG9/LJxROAP
 tlpYHaidbk9fprGbptxVkNx6SGyPz0d7k/VPZDpBo6ssTMyI4/wMTEZm4CLo6/dkpKYZSucMxdU
 =
X-Google-Smtp-Source: AGHT+IGzvARlkESB1h7R2zi/Rsw2XOTn96EH22RDtGWfnMuin0dkYZFaJRm4QCCPpIp1TqAreChvsQ==
X-Received: by 2002:a05:6830:358f:b0:704:4824:2b3e with SMTP id
 46e09a7af769-70df873ae72mr3583091a34.19.1724257191976; 
 Wed, 21 Aug 2024 09:19:51 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 17/35] board_f: Add a new struct to hold pre-relocation info
Date: Wed, 21 Aug 2024 10:19:09 -0600
Message-Id: <20240821161927.695717-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

(no changes since v1)

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
index a1f8641ae26..8f7c56e812f 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -578,7 +578,7 @@ static int reserve_fdt(void)
 			gd->fdt_size = ALIGN(fdt_totalsize(gd->fdt_blob), 32);
 
 			gd->start_addr_sp = reserve_stack_aligned(gd->fdt_size);
-			gd->new_fdt = map_sysmem(gd->start_addr_sp, gd->fdt_size);
+			gd->boardf->new_fdt = map_sysmem(gd->start_addr_sp, gd->fdt_size);
 			debug("Reserving %lu Bytes for FDT at: %08lx\n",
 			      gd->fdt_size, gd->start_addr_sp);
 		}
@@ -668,10 +668,10 @@ static int init_post(void)
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
 
@@ -1021,8 +1021,11 @@ static const init_fnc_t init_sequence_f[] = {
 
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
index 1252b8acefa..8a1a4e298ac 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -20,6 +20,7 @@
  */
 
 #ifndef __ASSEMBLY__
+#include <board_f.h>
 #include <cyclic.h>
 #include <event_internal.h>
 #include <fdtdec.h>
@@ -42,6 +43,12 @@ struct global_data {
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
@@ -219,10 +226,6 @@ struct global_data {
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

