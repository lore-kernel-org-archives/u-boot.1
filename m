Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82FCD18157
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77ED989220;
	Tue, 15 Oct 2024 00:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TMQ2j5R8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0FC0892D4; Tue, 15 Oct 2024 00:32:36 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F84B89280
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-835426c0fefso157978039f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945150; x=1729549950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rc8+5sDXJN82oBKx4MC4MsfaqPJQezLgNsq8FzJNHMA=;
 b=TMQ2j5R8vInmUhb5moXrxdhrdtB4pwtFsIu2qTKfZy63rIZAyVRUcnAkJp41frcVx4
 i/j242S385B8Nxpb/yXg7YE6WU9d1Gdph7Bgozf8nJQdM0H7V8Rl+f2c7VlIrbeFovBT
 DWRM6BXlLiigpNudevtIHIMHD+94ed8YDEpb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945150; x=1729549950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rc8+5sDXJN82oBKx4MC4MsfaqPJQezLgNsq8FzJNHMA=;
 b=BMIGubnlaNuBnMyVKE2DQZGrFdRf0RChMLWJ/rhQICqvXiL/Dp5maPde8IXOR+Hgn3
 sFWh1rarapQYlZJWmA33LanTFEj/uwxUUxheKziWVUMEiKkU6fMiwRuENFrIWOmjKSyf
 nSIlhhNJ48RP3ylMwJTBOkrbvpdk6+BjdJ6XDlLgZN6euKhJcCN5pKrNCOQQfjk2NzdS
 JwsW4BQcX0rpBlzSj46qq9pZ25XFp+sP1XlZF621xSllgySg7X21KXCEV1e9ZrhY7yWZ
 PPW3XstDOM+xJV2tol42EvG862mJv+HnsC7pQDskoUakFUDQCDvcXkuGVOwhRFfTry46
 aY8Q==
X-Gm-Message-State: AOJu0YwNiMdAwr9lHA7bK0MNmAJ24jMRe+4ves5IkconG1hDAafEoOlj
 pd+ACXiXnY9ndqvEKdnh4gjtWPO0m+mkMLqC6dLcjz3LDsaicpk9Y/1gZD93udYTOWWeyBsJWIL
 1Xw==
X-Google-Smtp-Source: AGHT+IGChFsFfkNsw+DdZqdnG2PiHjAzTfCJe4UFAHsWIOA477wr7CF8cyUdKYT130bMSkd/pyRKIA==
X-Received: by 2002:a05:6602:610f:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-835486a6280mr1145676639f.5.1728945149738; 
 Mon, 14 Oct 2024 15:32:29 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v3 15/20] x86: coreboot: Add a test for cbsysinfo command
Date: Mon, 14 Oct 2024 16:32:07 -0600
Message-Id: <20241014223212.2212442-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

Add a simple test for this command, checking that coreboot has the
required features.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/Makefile   |  1 +
 test/cmd/coreboot.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 test/cmd/coreboot.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8f2134998ad..f2955cd4e53 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -14,6 +14,7 @@ endif
 obj-y += exit.o mem.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
+obj-$(CONFIG_COREBOOT_SYSINFO) += coreboot.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
 obj-$(CONFIG_CONSOLE_TRUETYPE) += font.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
diff --git a/test/cmd/coreboot.c b/test/cmd/coreboot.c
new file mode 100644
index 00000000000..4a00bad2b8f
--- /dev/null
+++ b/test/cmd/coreboot.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for coreboot commands
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <command.h>
+#include <test/cmd.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/**
+ * test_cmd_cbsysinfo() - test the cbsysinfo command produces expected output
+ *
+ * This includes ensuring that the coreboot build has the expected options
+ * enabled
+ */
+static int test_cmd_cbsysinfo(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("cbsysinfo", 0));
+	ut_assert_nextlinen("Coreboot table at");
+
+	/* Make sure the linear frame buffer is enabled */
+	ut_assert_skip_to_linen("Framebuffer");
+	ut_assert_nextlinen("   Phys addr");
+
+	ut_assert_skip_to_line("Chrome OS VPD: 00000000");
+	ut_assert_nextlinen("RSDP");
+	ut_assert_nextlinen("Unimpl.");
+	ut_assert_console_end();
+
+	return 0;
+}
+CMD_TEST(test_cmd_cbsysinfo, UTF_CONSOLE);
-- 
2.34.1

