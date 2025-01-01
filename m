Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3A6E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077B38074B;
	Wed,  1 Jan 2025 23:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AfLlnVSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61DB980379; Wed,  1 Jan 2025 23:23:27 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E034C80719
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso143209535ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770203; x=1736375003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOGy0sxJm/MowwQPdjq232o3gA0cgUyGgTRurG7Qv5c=;
 b=AfLlnVSSaTKwc/cxwObkRwHObAsUR3Weca7ipmdV+nAvoXrfwZLi9tH9BMM1cfRzsq
 49MoMhqvnC8SSNris1oef7eWUVPb4r25jyGmoeywGlR3k2D94bQJLZq/xG/HiR9L/t5v
 OfxMBFNV/pNStNX8/bl9rPnVh3UGM+uu2KUEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770203; x=1736375003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOGy0sxJm/MowwQPdjq232o3gA0cgUyGgTRurG7Qv5c=;
 b=JySE26kas3CUrTuY9lqv8rFx6jeQO8FHx1YjrJb7ZuLrpxYM24CjHWXmiLBFi+PyaP
 QKBrcNN+C/mkr1BhDuKzoRPzo3ah5iagvIExQ2Vj0SpVfPNXNl59ns1eGWO9TcireUoi
 wOOzLg9CwYiyGM09I9jVHSJU0JD50891JaxIpGQSoXNzf0RKhTunbMQa0Rpi8nPrvNNa
 utxvHNlfllkf/RQ4az+u3odKhv3cOzR0A7iXOcn/+Zuv1rtwn0VFuGkTNFofdiRP6xBn
 qshYDutShdvwOD4nUjQeWjo0xHv8fzwOUr/+thAobevrZvsH5d6agJAmv9kDFixJYyWx
 lBRA==
X-Gm-Message-State: AOJu0YynvI/Br35OjBNU15rlqF4Kl/E9+qt+ncRpVkeZEvyzw8yBsFpj
 42BSMMqH3YaeqA6mzImuqV0GaUdfpjkeo+Y3hXXoWA/TpoR4GTTpmexMIOmLzqMk7obxfAWdfaE
 =
X-Gm-Gg: ASbGncuNIaWSoJfAbmmP9l2uYDUbCOETngWfN/aM/451Ot2u/HtS0Ni5c0a1XeU9Rcw
 x67kMuZyvGj9Nw5vqMdJIyk5Pk2SJLGnT/Y4gqVn+fg83cP7Dk8tLdlznpV7Qy+ntHmGCGEG+Et
 sRX0Xx5dQ+lX+OJloJIHQy4L9L9ntUd9FNhmdjzH3RA6nG0LDQMCqRHUesMFKolVQmtri8xpETf
 Y0wo2TRavn3j+BGSH7PlisTHkei92O1BBPAhpkTbLkngUIb5a2hVGY=
X-Google-Smtp-Source: AGHT+IGsddsMW78du9MMombJbjCFmV0dyY/z8ASRQBTijOroZCWFNyWuAZrHh3bPLGY0qiVlGorHow==
X-Received: by 2002:a05:6a00:66ca:b0:725:f1b1:cb9f with SMTP id
 d2e1a72fcca58-72abe0603c0mr61100511b3a.20.1735770202765; 
 Wed, 01 Jan 2025 14:23:22 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 63/67] upl: Add a command to execute a UPL payload
Date: Thu,  2 Jan 2025 11:09:49 +1300
Message-ID: <20250101221003.1944600-64-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Add a new 'upl exec' command which loads a payload, sets up the handoff
information and jumps to it.

This collects image information as the FIT's images are loaded.

With this, the size of the FIT is not known so is reported through UPL
as zero. Future work will address this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig     |   8 +++
 boot/Makefile    |   1 +
 boot/upl_exec.c  | 130 +++++++++++++++++++++++++++++++++++++++++++++++
 boot/upl_write.c |   2 +-
 cmd/upl.c        |  25 ++++++++-
 include/upl.h    |  29 ++++++++++-
 6 files changed, 191 insertions(+), 4 deletions(-)
 create mode 100644 boot/upl_exec.c

diff --git a/boot/Kconfig b/boot/Kconfig
index f9263513268..983bd9cdbf6 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -765,6 +765,7 @@ config BOOTMETH_SCRIPT
 config UPL
 	bool "upl - Universal Payload Specification"
 	imply CMD_UPL
+	imply UPL_EXEC
 	imply UPL_READ
 	imply UPL_WRITE
 	imply SPL_UPL if SPL
@@ -794,6 +795,13 @@ config UPL_WRITE
 	  for how to tell U-Boot SPL to actually write it before jumping to
 	  the next phase.
 
+config UPL_EXEC
+	bool "upl - Support for executing a UPL image"
+	help
+	  Provides support for executing a loaded UPL image, passing it a
+	  suitable handoff block. This can be used to pass control to a UPL from
+	  another firmware project.
+
 config UPL_IN
 	bool "upl - Read the UPL handoff on startup"
 	select UPL_READ
diff --git a/boot/Makefile b/boot/Makefile
index 9446c6b82a9..bc4ff91a934 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += fdt_support.o
 obj-$(CONFIG_$(PHASE_)FDT_SIMPLEFB) += fdt_simplefb.o
 
 obj-$(CONFIG_$(PHASE_)UPL) += upl_common.o
+obj-$(CONFIG_$(PHASE_)UPL_EXEC) += upl_exec.o
 obj-$(CONFIG_$(PHASE_)UPL_READ) += upl_read.o
 obj-$(CONFIG_$(PHASE_)UPL_WRITE) += upl_write.o
 
diff --git a/boot/upl_exec.c b/boot/upl_exec.c
new file mode 100644
index 00000000000..8eb72a4cb16
--- /dev/null
+++ b/boot/upl_exec.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * UPL handoff parsing
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <bootstage.h>
+#include <cpu.h>
+#include <display_options.h>
+#include <dm.h>
+#include <image.h>
+#include <log.h>
+#include <mapmem.h>
+#include <serial.h>
+#include <upl.h>
+#include <video.h>
+#include <asm/global_data.h>
+#include <dm/root.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct upl *cur_upl;
+
+static void upl_prepare(const struct upl_image *img, const struct abuf *buf)
+{
+	printf("\nUPL: handoff at %lx size %zx\n", abuf_addr(buf), buf->size);
+	printf("Starting at %lx ...\n\n", img->entry);
+
+	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "upl_prepare");
+	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
+		bootstage_report();
+
+	/*
+	 * Call remove function of all devices with a removal flag set.
+	 * This may be useful for last-stage operations, like cancelling
+	 * of DMA operation or releasing device internal buffers.
+	 */
+	dm_remove_devices_active();
+}
+
+int _upl_add_image(int node, ulong load_addr, ulong size, const char *desc)
+{
+	struct upl_image img;
+
+	if (!cur_upl)
+		return 0;
+
+	memset(&img, '\0', sizeof(img));
+	img.reg.base = load_addr;
+	img.reg.size = size;
+	img.offset = node;
+	img.description = desc;
+	if (!alist_add(&cur_upl->image, img))
+		return -ENOMEM;
+	log_debug("upl: add image %s at %lx size %lx\n", desc, load_addr, size);
+
+	return 0;
+}
+
+int upl_exec(ulong addr)
+{
+	struct bootm_headers images;
+	struct upl s_upl, *upl = &s_upl;
+	struct upl_image *img;
+	ulong img_data, img_len;
+	const char *uname;
+	struct abuf buf;
+	int ret;
+
+	upl_init(upl);
+
+	cur_upl = upl;
+	uname = NULL;
+	memset(&images, '\0', sizeof(images));
+	images.fit_uname_cfg = "conf-1";
+
+	/* a side-effect of this function is to call _upl_add_image() above */
+	ret = fit_image_load(&images, addr, &uname, &images.fit_uname_cfg,
+			     IH_ARCH_DEFAULT, IH_TYPE_FIRMWARE,
+			     BOOTSTAGE_ID_FIT_KERNEL_START,
+			     FIT_LOAD_OPTIONAL_NON_ZERO, &img_data, &img_len);
+	if (ret < 0) {
+		cur_upl = NULL;
+		return log_msg_retz("ufi", ret);
+	}
+
+	/* add the FIT */
+	upl->fit.base = addr;
+	upl->fit.size = 0;  /* TODO(sjg@chromium.org): Add size */
+
+	images.fit_hdr_os = map_sysmem(addr, 0);
+	img = alist_getw(&upl->image, 0, struct upl_image);
+	if (!img)
+		return log_msg_ret("uim", ret);
+
+	if (fit_image_get_entry(images.fit_hdr_os, ret, &img->entry))
+		return log_msg_ret("uae", -ENOENT);
+	log_debug("entry %lx\n", img->entry);
+
+	/* this calls _upl_add_image() with each loaded image */
+	ret = boot_get_loadable(&images);
+	cur_upl = NULL;
+	if (ret)
+		return log_msg_ret("ulo", ret);
+
+	/* we now have a full handoff state, including the images */
+	ret = upl_create_handoff(upl, &buf);
+	if (ret)
+		return log_msg_ret("uec", ret);
+
+	if (_DEBUG) {
+		set_working_fdt_addr(abuf_addr(&buf));
+		run_command("fdt print", 0);
+	}
+
+	upl_prepare(img, &buf);
+
+	if (IS_ENABLED(CONFIG_X86)) {
+		ret = arch_upl_jump(img->entry, &buf);
+	} else {
+		printf("UPL is not supported on this architecture\n");
+		ret = -ENOSYS;
+	}
+
+	return ret;
+}
diff --git a/boot/upl_write.c b/boot/upl_write.c
index c43a588dc40..ce9f733b450 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -685,7 +685,7 @@ int upl_create_handoff_tree(const struct upl *upl, oftree *treep)
 	return 0;
 }
 
-int upl_create_handoff(struct upl *upl, ulong addr, struct abuf *buf)
+int upl_create_handoff(struct upl *upl, struct abuf *buf)
 {
 	oftree tree;
 	int ret;
diff --git a/cmd/upl.c b/cmd/upl.c
index 461f8f4f0aa..e64ac7bbd20 100644
--- a/cmd/upl.c
+++ b/cmd/upl.c
@@ -112,12 +112,33 @@ static int do_upl_read(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_upl_exec(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	ulong addr;
+	int ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	addr = hextoul(argv[1], NULL);
+	ret = upl_exec(addr);
+	if (ret) {
+		printf("Failed (err=%dE)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
 U_BOOT_LONGHELP(upl,
 	"info [-v]     - Check UPL status\n"
 	"upl read <addr>   - Read handoff information\n"
-	"upl write         - Write handoff information");
+	"upl write         - Write handoff information\n"
+	"upl exec          - Execute a loaded UPL");
 
 U_BOOT_CMD_WITH_SUBCMDS(upl, "Universal Payload support", upl_help_text,
 	U_BOOT_SUBCMD_MKENT(info, 2, 1, do_upl_info),
 	U_BOOT_SUBCMD_MKENT(read, 2, 1, do_upl_read),
-	U_BOOT_SUBCMD_MKENT(write, 1, 1, do_upl_write));
+	U_BOOT_SUBCMD_MKENT(write, 1, 1, do_upl_write),
+	U_BOOT_SUBCMD_MKENT(exec, 2, 1, do_upl_exec));
diff --git a/include/upl.h b/include/upl.h
index b9bcdf60089..f210a39df0c 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -347,6 +347,14 @@ int upl_create_handoff_tree(const struct upl *upl, oftree *treep);
  */
 int upl_read_handoff(struct upl *upl, oftree tree);
 
+/**
+ * upl_exec() - Execulated a loaded UPL image
+ *
+ * @addr: Address of image
+ * Return: 0 on success, or -ve error
+ */
+int upl_exec(ulong addr);
+
 /**
  * upl_get_test_data() - Fill a UPL with some test data
  *
@@ -404,7 +412,7 @@ int _upl_add_image(int node, ulong load_addr, ulong size, const char *desc);
 static inline int upl_add_image(const void *fit, int node, ulong load_addr,
 				ulong size)
 {
-	if (CONFIG_IS_ENABLED(UPL) && IS_ENABLED(CONFIG_XPL_BUILD)) {
+	if (CONFIG_IS_ENABLED(UPL)) {
 		const char *desc = fdt_getprop(fit, node, FIT_DESC_PROP, NULL);
 
 		return _upl_add_image(node, load_addr, size, desc);
@@ -469,6 +477,25 @@ int upl_write_to_buf(struct upl *upl, ofnode root, struct abuf *buf);
 int upl_add_region(struct alist *lst, u64 base, ulong size);
 #endif
 
+/**
+ * upl_create_handoff() - Create a UPL handoff
+ *
+ * @upl: Returns the handoff structure that was created
+ * @buf: Returns buffer containing the final handoff info
+ * Return: 0 if OK, -ve on error
+ */
+int upl_create_handoff(struct upl *upl, struct abuf *buf);
+
+/**
+ * arch_upl_jump() - Jump to the UPL payload
+ *
+ * Jump to
+ *
+ * @entry: Address to jump to
+ * @buf: Buffer containing UPL-handoff information
+ */
+int arch_upl_jump(ulong entry, const struct abuf *buf);
+
 /** upl_init() - Set up a UPL struct */
 void upl_init(struct upl *upl);
 
-- 
2.43.0

