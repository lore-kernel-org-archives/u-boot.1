Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE4D0E6CA
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4A18931F;
	Mon, 21 Oct 2024 10:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SQt8MySL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64825892F7; Mon, 21 Oct 2024 10:19:46 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4A089306
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso617652866b.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729498784; x=1730103584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yS+9l+mLMX8uARc31BiD6Of+8AkMJPLaK43vLJos2QI=;
 b=SQt8MySLHy0bsBLM65WY4H9HcB0NiEHmcKDWf42F/kXHFVv5cMM8T2uvlIavJMd5gm
 VMLuFCcLt5hFCawqZ2IXqxg/NhsPqONqMThAk5Bw/JdoXL0VJC2L/BUVU1qvxi6zYhqR
 f+7ZvrUcB0qmfz9rnf8ZlzVqxLs6K6jWg53bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498784; x=1730103584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yS+9l+mLMX8uARc31BiD6Of+8AkMJPLaK43vLJos2QI=;
 b=BoRvc1Mp/pKZqPu1qRPVHAHe7k2QimFr70Is4iLeeCQMTuWA3C9iOu0nUMqx36C1+Y
 NeDrEYM+yUMYt3BO7TahyTiGvGZbqwpUuPL7CTzIkeRP5+T9nOVjMKk6Qz6YFsS2a3BB
 ax4QEiYHYGxc++Mb+uWEX9D1g7h/bPQBimWX+l4Xq/TKXJOLavdQ+kMI5nFMoB37pWB5
 k7BCHeE2J5pQT28CH4cmNE4RXISBgRVSrDv8eU50lM0hPgIhVPLWFZD9s9MK94Q1QXik
 Bc9nEf4WbmV8vOvUv0FqzIb/dflywr1lCG4so0tOgc4xhSHV6R0aWxqIAwt8NAcy4Sis
 ZdOA==
X-Gm-Message-State: AOJu0Yx62F78lcR385H68n8j7fhl0H2RvfMYS8BWZMnR4dUXkfu7f6kx
 QrAZCuS0EeNUpvVcKYIAiwwomuWlJXWlgP4MsISZjK1JB7obrrjky4wp4oGS68smPZODKYbKxsy
 gDJHA
X-Google-Smtp-Source: AGHT+IF1Vw/u150mQ3ne8MQk8JORoW5TRcKqWD+pUr8pIQSZx67/k558a7adOYS1AtouHpoFB/LJvQ==
X-Received: by 2002:a17:907:9451:b0:a99:f7df:b20a with SMTP id
 a640c23a62f3a-a9a69ca04fbmr1196836266b.62.1729498783596; 
 Mon, 21 Oct 2024 01:19:43 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6520sm176057766b.73.2024.10.21.01.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:19:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v4 5/8] cmd: Move meminfo command into its own file
Date: Mon, 21 Oct 2024 10:19:29 +0200
Message-ID: <20241021081934.289473-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021081934.289473-1-sjg@chromium.org>
References: <20241021081934.289473-1-sjg@chromium.org>
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
index a4ca61c37dd..05bd3e8a5e2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -885,6 +885,7 @@ config MD5SUM_VERIFY
 
 config CMD_MEMINFO
 	bool "meminfo"
+	default y if SANDBOX
 	help
 	  Display memory information.
 
diff --git a/cmd/Makefile b/cmd/Makefile
index 3c5bd56e912..16e275eba63 100644
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
2.43.0

