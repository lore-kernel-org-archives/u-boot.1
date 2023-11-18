Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DB4C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765E587563;
	Sat, 18 Nov 2023 22:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z92JOShI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23CE874BA; Sat, 18 Nov 2023 22:06:47 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA689874CC
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7a694a365d9so134655039f.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341584; x=1700946384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1fQYb4Aog8fhq8P0C4Rbc6vicA3Ha3sH9r7hF17AKc=;
 b=Z92JOShIq2D1bciCD/BlWtC0TIv5ZOcyqJjUdevOO8dmrvDRYnhFarw3sGfaLKOZyt
 3ZSObcP/aI+q1skadx/kElrpg4Ce/JsT6NF2b/Z/Sr1u1rvTSeI1uLp1zwN3tHGmZfdJ
 txowky6fKa/JnD8UxJPpPcbKgJrbG032Dvmqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341584; x=1700946384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1fQYb4Aog8fhq8P0C4Rbc6vicA3Ha3sH9r7hF17AKc=;
 b=sCx+oz/QExGdURB0054vzMDViDuYmvlB9bImV2eKzr/gXfS84ZbDBj5QanhAGy3pMk
 V2pPqoe9RNOX0G0fE8xTyOx+Byc7ZOp8iE0trKZpoz5vNHnbk2XlLV0VFbKD4zstYL1Q
 mqWMIvT+FqnVjW2HC3Z2bFLQId6qwUEXVUb/7wWJH9vcJMJZRzWD7MmuJLFEZ3dEXqhg
 1ryeToiZFHZ6A/Fy9HA+pkiflMJogDUk0q+p3MoByxhwBGzBEOzOAOAm3zX2xtvNJNNW
 uWCP7/n9xkArhuiArP44IWjqSQ3afRfJ9qSZX6NvYh84iGOpLvQaHT8uhR4OAfg1rCkN
 PD4g==
X-Gm-Message-State: AOJu0YxZJDwKVjIbQ4LvwZmfjcKgec7ZU7xMljSQRhII0m/WDH9NQKVc
 pmb7reG9vaIlXuz8f2faowq31WLAxsWZ9NPDKeqs9w==
X-Google-Smtp-Source: AGHT+IHVqNZCfqU7Dn6b8OdtdLZRwST5PXXGWNq5tu8PRcneo2cgxHKnswiOGviq7oOsqtZN5HJsSg==
X-Received: by 2002:a05:6602:4743:b0:79a:b53c:d758 with SMTP id
 dy3-20020a056602474300b0079ab53cd758mr4582416iob.1.1700341584319; 
 Sat, 18 Nov 2023 13:06:24 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v3 31/32] bootstd: Introduce programmatic boot
Date: Sat, 18 Nov 2023 14:05:19 -0700
Message-ID: <20231118210547.577026-32-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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
'programmatic' boot which can be used when no command line is available.
For now it does almost nothing, since most bootmeths require the
command line.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add a panic if programmatic boot fails

 boot/Kconfig      | 12 +++++++++++
 boot/Makefile     |  2 ++
 boot/prog_boot.c  | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 common/main.c     | 11 ++++++++++
 include/bootstd.h |  9 +++++++++
 5 files changed, 85 insertions(+)
 create mode 100644 boot/prog_boot.c

diff --git a/boot/Kconfig b/boot/Kconfig
index ef71883a5026..b438002059c3 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -459,6 +459,18 @@ config BOOTSTD_BOOTCOMMAND
 	  standard boot does not support all of the features of distro boot
 	  yet.
 
+config BOOTSTD_PROG
+	bool "Use programmatic boot"
+	depends on !CMDLINE
+	default y
+	help
+	  Enable this to provide a board_run_command() function which can boot
+	  a systen without using commands. If the boot fails, then U-Boot will
+	  panic.
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
index 7c70de2e59a8..6dba6cba144b 100644
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
@@ -67,6 +68,16 @@ void main_loop(void)
 
 	autoboot_command(s);
 
+	/* if standard boot if enabled, assume that it will be able to boot */
+	if (IS_ENABLED(CONFIG_BOOTSTD_PROG)) {
+		int ret;
+
+		ret = bootstd_prog_boot();
+		printf("Standard boot failed (err=%dE)\n", ret);
+		panic("Failed to boot");
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
2.43.0.rc0.421.g78406f8d94-goog

