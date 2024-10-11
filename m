Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2813D0EE38
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62DC893FE;
	Fri, 11 Oct 2024 23:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hgAn9h0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A8AA893F8; Fri, 11 Oct 2024 23:40:46 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E927893F8
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a3b7442db5so3140615ab.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728682843; x=1729287643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptuzgqdUvY88LbXw4ijWIv5w0u0uc9ZxhNSCHQsIuEs=;
 b=hgAn9h0AKYzL9sXA6Q23BOMZHbvLMSPw6ebJF8IFwRvHTfpJAl2SeQ5Dnzc1Ymlp78
 9cgCf+tTjDn9GJmG0Ky0MLuVp7OzVXD/SzOKXoYGgUJPo+yE7T1Vz5GitYFiuGkqihhV
 d70qUQ6RFi5RPVnlUPbBjXZcHCMIqu5v9FSU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728682843; x=1729287643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptuzgqdUvY88LbXw4ijWIv5w0u0uc9ZxhNSCHQsIuEs=;
 b=NR5XBzzovvRnJH9ykk2UXJqrbqfWoXWGSNWzWAuPj0uWbxeakPg6rgDUrT+r0mDdTI
 OecWeqB1fhGE93kFDMK7nqMBb+1JGtTHy04Qs7ooPpv4cKyTmtnCPmJWC4hJZhqdsnBh
 kwIYDvX/jEyBzcCHsKSbAHIOROm7q+RWZbt7KP51QV+uXXglvM70vdgrq6WjSRPL7/oq
 w55/kdQqMYHTztmtTMiNtXuhzVMaxeYqILp/9m6WOuzs8VsmTxRG3QF123ppef48/0Iw
 GOBc1aSCaN5GqGXsOV4Ea1x4BrhI8ih8IRZop+xyCWr0gPhsBbG+ihmd77DfGPhVLMO6
 VxqA==
X-Gm-Message-State: AOJu0YyWc4DAZQRrQUdoi5J0yte6gqnuQVUtIlP2zEthjvWToyuc1Uwn
 J8fGnpSJ4s63/RZFGeCJJOwhsie699KFVLYdsjVxE6DnKiLpchzkyIhVi2BDorB8Z6ROMnwAdfS
 kCw==
X-Google-Smtp-Source: AGHT+IE5jgEjMy/tqLNRK5GiUiWFwO6msCwHxLT9zg6h/aEaXxOyWojuU+3amr9uqyjVVNKZQ7aKJg==
X-Received: by 2002:a05:6e02:164b:b0:3a3:983a:8741 with SMTP id
 e9e14a558f8ab-3a3b5f6efe8mr23478455ab.11.1728682842977; 
 Fri, 11 Oct 2024 14:40:42 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a3afdae0f1sm8830475ab.11.2024.10.11.14.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:40:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 6/7] cmd: Move meminfo command into its own file
Date: Fri, 11 Oct 2024 15:40:30 -0600
Message-Id: <20241011214032.760072-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011214032.760072-1-sjg@chromium.org>
References: <20241011214032.760072-1-sjg@chromium.org>
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
index 91227f1249c..510344509c7 100644
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

