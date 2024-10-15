Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF2DD216A2
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7604889AA;
	Tue, 15 Oct 2024 15:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C5QJp41e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D9688875; Tue, 15 Oct 2024 15:33:19 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD748878A
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8378db14280so276589639f.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728999195; x=1729603995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pj81dmftPRkBx5NJR1Io70OJU6U74m9lgfFwQnIFbiw=;
 b=C5QJp41evWbUV305pmK0+zASRgcknHayFQqRB2Ywq6FXBhfMALWUcv6o12TKHxtzeC
 F+QyKJu/8u8veWJjXDE1SymiNmdlUeG+fENp92DVyCT9GthFhrHYdj8Yv6MpaZMyy4FQ
 wPTxyA4R5GwJCKXffDdYdmrsVrm40qYeTtFzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728999195; x=1729603995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pj81dmftPRkBx5NJR1Io70OJU6U74m9lgfFwQnIFbiw=;
 b=U9i6J0CuVSwYDUIj+iCVPJARDXogVA6+FdYWROY4hpWFwzcmqav1EesmPqAFbVDFvo
 vIG12Q9xZuEeWDC/ukyP4hak78KcMDBeMHbXAaxCjx5kOx9C1HaQYVP4BSANkzZBdaJ5
 eSElBgvSpdYtHS864L7qyGusjYXefuCqViEfrPLA6Xh/DAnJ0hxDAMRDoRLL0wYHJyyG
 h00kxosw+I4liwgBK8KrXHYDQQBKBmB9SpvxtGEa/pXKjna/o1m/zju+Ufz/HSm6TSiX
 YyNgj13SZWsh+zchlRViMJiSD4rrJ/vIT3T6jp4F2mjh6ObmBOiBXZaAAXKpwcHHkqtK
 d6Fw==
X-Gm-Message-State: AOJu0Yw8e2tWZzS7TsAJzMZqm+D4dmLusXjgT2sCAdCu0UMP7YmXrq20
 wX+ioTwmSis2FQZGf23SIUEgLJy9q19KqrbgW1/maUJAfpjrIUa17BSeghxWA6gCtaS+5gniKw+
 WCQ==
X-Google-Smtp-Source: AGHT+IFutvo5uhr0LEi+UQVm8ZEHrKAsMF7sK2as5A9kS068gMRGZHFUaM3l7RH9QDLhU4xFR14BSw==
X-Received: by 2002:a05:6602:482:b0:835:46cb:6747 with SMTP id
 ca18e2360f4ac-83a9440a573mr80524639f.4.1728999195471; 
 Tue, 15 Oct 2024 06:33:15 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83a8b28bed6sm29794939f.8.2024.10.15.06.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:33:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v3 6/7] cmd: Move meminfo command into its own file
Date: Tue, 15 Oct 2024 07:33:03 -0600
Message-Id: <20241015133304.2874735-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015133304.2874735-1-sjg@chromium.org>
References: <20241015133304.2874735-1-sjg@chromium.org>
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

In preparation for expanding this command, move it into a separate file.
Rename the function to remove the extra underscore. Update the number of
arguments to 1, since 3 is incorrect.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Split into its own patch

 cmd/Kconfig   |  1 +
 cmd/Makefile  |  1 +
 cmd/mem.c     | 19 -------------------
 cmd/meminfo.c | 26 ++++++++++++++++++++++++++
 4 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 cmd/meminfo.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 37894eb80d6..2fd29e9fa88 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -878,6 +878,7 @@ config MD5SUM_VERIFY
 
 config CMD_MEMINFO
 	bool "meminfo"
+	default y if SANDBOX
 	help
 	  Display memory information.
 
diff --git a/cmd/Makefile b/cmd/Makefile
index 21d376309b9..b630756a629 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_CMD_LOG) += log.o
 obj-$(CONFIG_CMD_LSBLK) += lsblk.o
 obj-$(CONFIG_CMD_MD5SUM) += md5sum.o
 obj-$(CONFIG_CMD_MEMORY) += mem.o
+obj-$(CONFIG_CMD_MEMINFO) += meminfo.o
 obj-$(CONFIG_CMD_IO) += io.o
 obj-$(CONFIG_CMD_MII) += mii.o
 obj-$(CONFIG_CMD_MISC) += misc.o
diff --git a/cmd/mem.c b/cmd/mem.c
index 4d6fde28531..9e716776393 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -1379,17 +1379,6 @@ U_BOOT_CMD(
 
 #endif
 
-#ifdef CONFIG_CMD_MEMINFO
-static int do_mem_info(struct cmd_tbl *cmdtp, int flag, int argc,
-		       char *const argv[])
-{
-	puts("DRAM:  ");
-	print_size(gd->ram_size, "\n");
-
-	return 0;
-}
-#endif
-
 U_BOOT_CMD(
 	base,	2,	1,	do_mem_base,
 	"print or set address offset",
@@ -1433,14 +1422,6 @@ U_BOOT_CMD(
 );
 #endif /* CONFIG_CMD_MX_CYCLIC */
 
-#ifdef CONFIG_CMD_MEMINFO
-U_BOOT_CMD(
-	meminfo,	3,	1,	do_mem_info,
-	"display memory information",
-	""
-);
-#endif
-
 #ifdef CONFIG_CMD_RANDOM
 U_BOOT_CMD(
 	random,	4,	0,	do_random,
diff --git a/cmd/meminfo.c b/cmd/meminfo.c
new file mode 100644
index 00000000000..bb9bcec2e3f
--- /dev/null
+++ b/cmd/meminfo.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	puts("DRAM:  ");
+	print_size(gd->ram_size, "\n");
+
+	return 0;
+}
+
+U_BOOT_CMD(
+	meminfo,	1,	1,	do_meminfo,
+	"display memory information",
+	""
+);
-- 
2.34.1

