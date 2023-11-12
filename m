Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0F3C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C71D86B54;
	Sun, 12 Nov 2023 01:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SD6R+Qod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D197F86F6C; Sun, 12 Nov 2023 01:09:50 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCC686FB8
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7a956887c20so126344739f.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747775; x=1700352575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/d0SoO30+b+hYFgo8EtEBKMy0cMBS3+Rk9+GZ/AUP0g=;
 b=SD6R+Qod9RiqztOxKZm7BDJiOAL+KC+XJtgV1EoO3NiT6rt/FCtAZWoPfDUmdwj1Dj
 WHlkn0RAMiDGBfu0Hdr1yFqlag9eXL/Gz7leQFT737wrG0SPzAApxEfu5TAmnT7zVJwY
 wOLQIJ8src6kxCk0RZ4osywo2RMz2/3033nyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747775; x=1700352575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/d0SoO30+b+hYFgo8EtEBKMy0cMBS3+Rk9+GZ/AUP0g=;
 b=auWkKqLJ0EHHQ3CXVJDpzyyxd93Dja5VbEDU7we2vLQ2jmj9fVMjIM3KS8K4q3RlOT
 Ecn9byenj2aUUVCOKIXZQdfnZClBPo/CB/ke5GPIiKtaRsBrMjnWfFFOLP2F2r/TZn3W
 Jg0XjchtPUu//ReuZL+AnJaQ/M4F4u5FPUdDeb2FJkdTAzYYIHistlil9sRK2i6o16b3
 dyIeGWv3ZQfEiS6HynlAEk0i4eFQaBFRWrTD80pyng8lxOJW6HDVs7VyN0uIMycdyVoF
 0W6dkU3jbaurrZuXp9FM6spR7We+WbpOn4pL5cdSHxCbTWGvxHC0udQslsiPxhIonPW5
 ux+Q==
X-Gm-Message-State: AOJu0Ywko/DZ/uFndYZ4R9Kns2i7jQNaKu8vlAoHPCv2hhZGrDfdt1Zg
 CnHQaOCx5+p4/xVihyzPjysSS+Vlck0Me33zjgW0gg==
X-Google-Smtp-Source: AGHT+IFqzU4LVitD6WX5soifKLJdOE/i3qeDCHs/Ytjvl6VMiFbu4NAiCgFazAme/3VBb6hqe2BiTw==
X-Received: by 2002:a92:c546:0:b0:35a:b1da:1fba with SMTP id
 a6-20020a92c546000000b0035ab1da1fbamr2288720ilj.23.1699747775188; 
 Sat, 11 Nov 2023 16:09:35 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH 05/29] bootstd: Introduce programmable boot
Date: Sat, 11 Nov 2023 17:08:50 -0700
Message-ID: <20231112000923.73568-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

At present bootstd requires CONFIG_CMDLINE to operate. Add a new
'programmable' boot which can be used when no command line is available.
For now it does almost nothing, since most bootmeths require the
command line.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig      | 11 ++++++++++
 boot/Makefile     |  2 ++
 boot/prog_boot.c  | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 common/main.c     |  9 +++++++++
 include/bootstd.h |  9 +++++++++
 5 files changed, 82 insertions(+)
 create mode 100644 boot/prog_boot.c

diff --git a/boot/Kconfig b/boot/Kconfig
index ef71883a5026..586d7a69fab3 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -459,6 +459,17 @@ config BOOTSTD_BOOTCOMMAND
 	  standard boot does not support all of the features of distro boot
 	  yet.
 
+config BOOTSTD_PROG
+	bool "Use programmatic boot"
+	depends on !CMDLINE
+	default y
+	help
+	  Enable this to provide a board_run_command() function which can boot
+	  a systen without using commands.
+
+	  Note: This currently has many limitations and is not a useful booting
+	  solution. Future work will eventually make this a viable option.
+
 config BOOTMETH_GLOBAL
 	bool
 	help
diff --git a/boot/Makefile b/boot/Makefile
index 3fd048bb41ab..de0eafed14b1 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -25,6 +25,8 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootmeth-uclass.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootstd-uclass.o
 
+obj-$(CONFIG_$(SPL_TPL_)BOOTSTD_PROG) += prog_boot.o
+
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
diff --git a/boot/prog_boot.c b/boot/prog_boot.c
new file mode 100644
index 000000000000..045554b93db0
--- /dev/null
+++ b/boot/prog_boot.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <bootflow.h>
+#include <bootstd.h>
+#include <command.h>
+#include <dm.h>
+
+/*
+ * show_bootmeths() - List available bootmeths
+ *
+ * We could refactor this to use do_bootmeth_list() if more detail (or ordering)
+ * are needed
+ */
+static void show_bootmeths(void)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+
+	printf("Bootmeths: ");
+	uclass_id_foreach_dev(UCLASS_BOOTMETH, dev, uc)
+		printf(" %s", dev->name);
+	printf("\n");
+}
+
+int bootstd_prog_boot(void)
+{
+	struct bootflow_iter iter;
+	struct bootflow bflow;
+	int ret, flags, i;
+
+	printf("Programmatic boot starting\n");
+	show_bootmeths();
+	flags = BOOTFLOWIF_HUNT | BOOTFLOWIF_SHOW | BOOTFLOWIF_SKIP_GLOBAL;
+
+	bootstd_clear_glob();
+	for (i = 0, ret = bootflow_scan_first(NULL, NULL, &iter, flags, &bflow);
+	     i < 1000 && ret != -ENODEV;
+	     i++, ret = bootflow_scan_next(&iter, &bflow)) {
+		if (!bflow.err)
+			bootflow_run_boot(&iter, &bflow);
+		bootflow_free(&bflow);
+	}
+
+	return -EFAULT;
+}
diff --git a/common/main.c b/common/main.c
index 7c70de2e59a8..2668f3bb1637 100644
--- a/common/main.c
+++ b/common/main.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <autoboot.h>
 #include <bootstage.h>
+#include <bootstd.h>
 #include <cli.h>
 #include <command.h>
 #include <console.h>
@@ -67,6 +68,14 @@ void main_loop(void)
 
 	autoboot_command(s);
 
+	if (IS_ENABLED(CONFIG_BOOTSTD_PROG)) {
+		int ret;
+
+		ret = bootstd_prog_boot();
+		printf("Standard boot failed (err=%dE)\n", ret);
+	}
+
 	cli_loop();
+
 	panic("No CLI available");
 }
diff --git a/include/bootstd.h b/include/bootstd.h
index 7802564bcc63..99ce7b64e7c5 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -94,4 +94,13 @@ int bootstd_get_priv(struct bootstd_priv **stdp);
  */
 void bootstd_clear_glob(void);
 
+/**
+ * bootstd_prog_boot() - Run standard boot in a fully programmatic mode
+ *
+ * Attempts to boot without making any use of U-Boot commands
+ *
+ * Returns: -ve error value (does not return except on failure to boot)
+ */
+int bootstd_prog_boot(void);
+
 #endif
-- 
2.42.0.869.gea05f2083d-goog

