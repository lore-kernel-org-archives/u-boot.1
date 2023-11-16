Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05B7C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A026B8746E;
	Thu, 16 Nov 2023 05:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BbPlIQ2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D15887467; Thu, 16 Nov 2023 05:11:27 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62FAC87438
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7b06afbd3cdso13695339f.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107884; x=1700712684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRvreRq0bHpZgGkxUiUPwQEdY8OHPsUz785tyGqVh7k=;
 b=BbPlIQ2yrPMkFILZgm5mflWMBJDU0UuxfOwlsg7XlF7EIsMlh0nfwqA/rq3escgIfE
 6Q9bUEpAlZNmBKlUde9I4Q0RjyKuNA9idDtRubC+I+CRwyWDW9C84MqP4U9ZEIIWWaAR
 oBLKKpkvTXc13hvqQ/otZXnfe+1DovjxteNtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107884; x=1700712684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRvreRq0bHpZgGkxUiUPwQEdY8OHPsUz785tyGqVh7k=;
 b=cO4lPFwoOkr4QsNJ36jDlkghy3mrqcYUCXSwyDU+9vACxIVDqdmJxZI12gq7KDGdz7
 jqH9XXlorPZLvZc+9J2ov+AfTtPDVe/Pa0PmFJDXxu1/MPuz+wp2b3qqtHiKK7CXEi+i
 hK4F4RMf3meuaPf6FaeHCjNNgtcx62qoqHrfRWFsM+OC+w1230Xo2M2IgFhnuSwcEen1
 MkZiDSEuC1AYsfxOylhgnLYwYcDZgNM/OnyXyEDU9DmWlHzvpagvEuyyUtGGu2MMnAjR
 7koGLh9c2dfjodyyXeOD20FbHdzpT7A/nQ+U+UtosVD9IFfWNTTAlPf/JSUKS+12EC/4
 5Wug==
X-Gm-Message-State: AOJu0YzbQUT1l716NbETf5LIwHskPcnVsFmfNVtighto8T5PBop3phR3
 42aRv8VAeCmFJ2JuoGfU1alr4xfEfZUMZCj4cUZHvw==
X-Google-Smtp-Source: AGHT+IHzp8muXuuzv5TT/15eawrgfvIDkg9WlsGLLkGtNO9wWOSkBtgVnQn7LO1rwM//Ty5cZlVGsg==
X-Received: by 2002:a6b:e812:0:b0:7b0:1b0d:240a with SMTP id
 f18-20020a6be812000000b007b01b0d240amr16258884ioh.3.1700107883946; 
 Wed, 15 Nov 2023 20:11:23 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v2 06/32] bootstd: Introduce programmable boot
Date: Wed, 15 Nov 2023 21:10:06 -0700
Message-ID: <20231116041043.362055-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

(no changes since v1)

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
2.43.0.rc0.421.g78406f8d94-goog

