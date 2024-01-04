Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F55C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7B8879F5;
	Thu,  4 Jan 2024 16:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ll60PJPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B39FF879AB; Thu,  4 Jan 2024 16:12:49 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01793879E8
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3606c7a4cb5so41145ab.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381131; x=1704985931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AHz9fEzdkBidJDnXS8luDbQa6mzzVrR8DxhEWVPrM4=;
 b=Ll60PJPCfaOkjJ2woTn5b09lZpALs2ijo1vsE6h2IHcop8b2ExHHuj6qvAGMJxmAwB
 SVYpSrV85I+CUEXxbj/EGOT+Fg0AV9yMQABkTyBhBnR9LPm/WyyK7q+rGksQMqO94eJC
 GKA+9OoOby5aFvN2Vbsux7Zm1bc92HuLFK+8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381131; x=1704985931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1AHz9fEzdkBidJDnXS8luDbQa6mzzVrR8DxhEWVPrM4=;
 b=CZVso1/1EwF68DTgpkPFJ4CPl19d/I0ZRRgWnXJS6FpnYi/aLGl71N1dlFUzLVlN2m
 vdMXGf4riP9tZoE7jjiczWGHBdV3MBlDls5D7qtsqOisicgr3Fg/CIoAnl8Ia2vWhWS4
 nzG7gvcV3TXkIcYFVrlepTyoHz4m0Jt7GpLW7OLRzx9kCewGUVe05nTn48lI6I6Ka1ZT
 RAJuV2ptOakJ30yDDlsTLQZeW2vjN+Tmvz+hKRlRVsa72RPoVcf0WMeIcTPPHtSRb9fy
 TmkjKdLSSM/yvXDUf/5SXIxle6shD30+Xa2Rc8iy8qHO64lu1lerGVS8Uvlkdk9apbOE
 M+jQ==
X-Gm-Message-State: AOJu0YwXAtRdU69zHbqGRbZupzXrMe0eUmLu+feykWGmNLVisKRT8Xs9
 ig6hluLX9IE7Z3+Q85rg5LYVt6fpaVYRquQrotjz1UWWxVuf
X-Google-Smtp-Source: AGHT+IHGpnmi7e+cunvzK0VcO2NU3nBvUDhtoElKiqI0ra0y0NyiAeEiX4FOEO3FwU225xDhlqR7/Q==
X-Received: by 2002:a05:6e02:174c:b0:35d:695a:d323 with SMTP id
 y12-20020a056e02174c00b0035d695ad323mr787304ill.70.1704381130951; 
 Thu, 04 Jan 2024 07:12:10 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 14/19] x86: coreboot: Add a test for cbsysinfo command
Date: Thu,  4 Jan 2024 08:11:47 -0700
Message-Id: <20240104151152.697855-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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
index 7e40e25b9e8..dd2c0dc28b5 100644
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
index 00000000000..054fe2d7950
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
+CMD_TEST(test_cmd_cbsysinfo, UT_TESTF_CONSOLE_REC);
-- 
2.34.1

