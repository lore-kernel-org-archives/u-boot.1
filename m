Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF794E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 850F087282;
	Mon,  2 Oct 2023 03:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pker/Avr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40C58709C; Mon,  2 Oct 2023 03:18:45 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB77587282
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79fb70402a7so454598439f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209392; x=1696814192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cA/EZOAekU5quaUDhV+pr1sPxRXL0A2uVdeAKP1x6K4=;
 b=Pker/AvrO3k6mx7s5MPlYkSpq2n+9WNFgcUY66ADWXwoIX9ynbqUoGwaOlHtuxXq3r
 1vs2ozZRDsqoXPnHVBMzeaWWRYTY4ozuDh5rGo55lh5NWZDG55wHlx2Xn4Lo5ojhZO8U
 MzP36bqbfA2DH2Vfmsx/S20ZmE3A6Hq3p0lfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209392; x=1696814192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cA/EZOAekU5quaUDhV+pr1sPxRXL0A2uVdeAKP1x6K4=;
 b=lscX9rdNlAYpNUGX9FWS0JO0422vLNyoDy+yZVb4kLuFvahNbH2YSZ3+qH1WQp+ZzJ
 tUH3/C34/hzpVCDafynJvPOLdTZhUy0WhQ+5NLZZq3sWrMjZZJs8ctpXOWkP1v3S8k42
 a+W4nr2SCEN8brhdZct5aR665vZJelUBbkl4IHYZQVzogKuAD3UkaSpDy08syYhJ+RrB
 ykq8jUqThepxRv6OqQY39m+ROMkjBOl8BuS1TGJ6Q34pKTyYXNbAJhYVTqiB7SlMd1ZM
 QVZi4xpTFHmWfBa/8JOeo2w6SUPEG79UCndkPZShaDC2yJZLgKRV3GzCvxYwjpgyBMoc
 l6Zw==
X-Gm-Message-State: AOJu0Yx0Wu4hWhzpAA9BqPKbs3miMLug+qCFNHQy/NPWzXDFf/4tIfVI
 ZmHyb1cpv9OxM594BdWlUY+RX+9GZWyDPXwViWE=
X-Google-Smtp-Source: AGHT+IFV2cFqkkqy3+b79diYQ8HKc3ByEyXu7HEqJx+lr71iOG+6fTLzZdn4+fTb/eXYXMBXtMUd9w==
X-Received: by 2002:a5e:8804:0:b0:791:1e87:b47e with SMTP id
 l4-20020a5e8804000000b007911e87b47emr10076904ioj.15.1696209392067; 
 Sun, 01 Oct 2023 18:16:32 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robimarko@gmail.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>
Subject: [PATCH 29/34] x86: coreboot: Add a test for cbsysinfo command
Date: Sun,  1 Oct 2023 19:15:39 -0600
Message-ID: <20231002011553.463514-30-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

 test/cmd/Makefile   |  1 +
 test/cmd/coreboot.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 test/cmd/coreboot.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 0be2cec89018..d6460b2ae5b9 100644
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
index 000000000000..277c670c15e9
--- /dev/null
+++ b/test/cmd/coreboot.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for coreboot commands
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <common.h>
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
+CMD_TEST(test_cmd_cbsysinfo, UT_TESTF_CONSOLE_REC);
-- 
2.42.0.582.g8ccd20d70d-goog

