Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1599FC55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 16:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAF0481151;
	Thu, 30 Jul 2026 16:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rNl2tQjDzFxs; Thu, 30 Jul 2026 16:06:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F7F281141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785427580;
	bh=8zX5Ex3NTMEAzer0dCMKzUkUKgDG+Cj5pjEjPL4zDlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KMFaTXmFhnj+mgg0Uc4UjGp6yRGN6nI06zpXSsaF2gMy/2AANsMfumE9azBVmAiXp
	 5Ep684bTwuxaOFzV7TBgj9zJT2DdMHZEnIspjb8yCl537rFj53k0AyWMzYFI/Q8zzo
	 ug/2ZIaiPe7zpq5swT/GS5FSBx7OY9ySGwXt8408J/3xPifdny/qv/7vyx+Qoc0TaJ
	 pfhJhYn7QkPRAFHDs3Hqta181P3XjOhndnW9kqrOfvvODq1yny9CKE7acsFxpDeiIR
	 7yQk27TCT+CX8c72qXEdAhWrD8dZuOFKsfFAEDh/8n13d8jLFe9vj4ReYTYgm3eAVw
	 vbI/nOPY6s10w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F7F281141;
	Thu, 30 Jul 2026 16:06:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DEB5D197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0D56608CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8iL9txF3afe for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:51:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DEF5E608CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEF5E608CB
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEF5E608CB
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:51:25 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso15344535e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785426684; x=1786031484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8zX5Ex3NTMEAzer0dCMKzUkUKgDG+Cj5pjEjPL4zDlk=;
 b=WEZLxh2VPFY6mHz+Dv1HF36XKuHxSLt7xYRAg/sZnN48/VPzM7x45tBIDcEY/RYMN8
 jJ28cHWrxoksjq0V5bS60hLOk+expPsm68tLz0wSenZy93RiZxFSCA5WWjq9rsZSCC5J
 +/svJ8E7WjRn5YHGhbXe7j24CaHUXEHWFvmbyOu9K/ZXVpUNJT3SxrHOF0anbpiPVBkt
 huKcGc1jTJ5HEOvWV+x6y4fsQEx2g5IlmMoyq9ioEOC8gyGKkrm+7xWT5645UbfKK7LS
 +ark1jgrXMzXeoYFMIpnfq5lk3MC2/enkzcdmUvoZ4jsEnpj+CpGcVcnKG2IVMJvtHLD
 evgw==
X-Gm-Message-State: AOJu0YwEXrnCKzA94iRAMA4er1uKhC/8f+rgDOyPgAFTcra2KUwroKkD
 35LKdGJE8JGfPVpDO2C9rSjzW/XNpxylxUOlKNa4OYg6QwQ/A2zznVkcxPVrRQ==
X-Gm-Gg: AR+sD11AV5iCfycbyNltaaaCQwDNnZN2qlwZPxKGT2pGGD5oXM8VBx0Zs/HNt/YU2Fg
 7KEYetJRU2ap1DyczIuf0X0Y3u7JneOPSoG8Zm+qwmEc9W4DFsKTzh8CSv7NOFXtsg9XlVvxF9B
 FyLp//l7CnLRmW0OC+M54VMUCK0RBKby5H1lSCI2sHnHTCJCnfxH5JX/PXsVys426jzqqvdcBzL
 clOZyrAMzIeMsaWmV0sk8FnHXLWspCUnYL+/7L7ZRGUQM9IQZ/O6MvTdR1n0KtSS7u50QqqDltA
 R5FL8pVq0XE7it7cm4+lzcIC9hcChgFA9Ddk42JIbKQ1ohLrwOI2aM6HmVQtLgr73FEXBoE4Ea8
 p2OK9OhckyYm3BJH9WEop2T6F1gaBA7KsPZ2nAeKKnPsijxfoBA4bPSwDQEfYGfscVB5xPTsfYZ
 gH2UUHIRvzyQ9Xl8CjHvRdFc+SE9isa5cDMjJ0qpWGr0YTFPORkSUYQmJOOppm9wNMq1Q=
X-Received: by 2002:a05:600c:154e:b0:495:3e08:ad19 with SMTP id
 5b1f17b1804b1-49800e7556amr46259995e9.9.1785426683704; 
 Thu, 30 Jul 2026 08:51:23 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496e8e06f7csm146871545e9.0.2026.07.30.08.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:51:23 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 2/2] test: cmd: add a test for bootd
Date: Thu, 30 Jul 2026 17:51:19 +0200
Message-ID: <20260730155119.3328020-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730155119.3328020-1-mehmet.fide@gmail.com>
References: <20260730155119.3328020-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Jul 2026 16:06:15 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785426684; x=1786031484;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8zX5Ex3NTMEAzer0dCMKzUkUKgDG+Cj5pjEjPL4zDlk=;
 b=r6PO+WfpmxP1/lJrv5ghlklWdi5wIr0Rf52K48/KNyMnL/9gMELS8BAaKXw1iUD5dc
 J+7g9EnSRPZDC/eqXZCQUfo9H2qU+yiCcXU7fiu6SsQvHCD3qAdlGPv0QJkD0CSfO4S5
 GCb5vSdN68TIb65OdMBZcabgAS90gojfTOLQUtLem+b+rl2BVW7+G+lKbAmd/OS/vdT8
 0LAVXqQK+FFC4x3dioNr2jHk/PlUtBU/BhhShqil5mSvcHmozx4u4XEIpdA4ThEPYKHG
 vgUrt06Yh/jN4bGR+C7HwxeNABETAi/Ie9+Oz6VIp/NQJf9Q1yQ3zSHmuj/u6WDqSNS+
 NQOg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=r6PO+Wfp
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

There is no test for the bootd command. Add one to the cmd suite that
covers the documented behaviour: bootd and its "boot" alias run the
command held in the bootcmd environment variable, and the return value
of bootd is the one of that command.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    checkpatch asks for a blank line before CMD_TEST(); test/cmd/command.c and
    test/cmd/exit.c place the macro directly after the closing brace, so this
    follows the surrounding tests.

 test/cmd/Makefile |  3 +++
 test/cmd/bootd.c  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 test/cmd/bootd.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8d36463879d..757aefa3e02 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -17,6 +17,9 @@ ifdef CONFIG_CONSOLE_RECORD
 obj-$(CONFIG_CMD_ACPI) += acpi.o
 endif
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
+ifdef CONFIG_CONSOLE_RECORD
+obj-$(CONFIG_CMD_BOOTD) += bootd.o
+endif
 obj-$(CONFIG_CMD_CONFIG) += config.o
 obj-$(CONFIG_COREBOOT_SYSINFO) += coreboot.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
diff --git a/test/cmd/bootd.c b/test/cmd/bootd.c
new file mode 100644
index 00000000000..83dc9ab6ecc
--- /dev/null
+++ b/test/cmd/bootd.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the bootd command
+ *
+ * Copyright 2026 Mehmet Fide <mehmet.fide@screeningeagle.com>
+ */
+
+#include <command.h>
+#include <env.h>
+#include <test/cmd.h>
+#include <test/ut.h>
+
+/* Check that bootd and its "boot" alias run the bootcmd variable */
+static int cmd_bootd_test(struct unit_test_state *uts)
+{
+	ut_assertok(env_set("bootcmd", "echo hello bootd"));
+
+	ut_assertok(run_command("bootd", 0));
+	ut_assert_nextline("hello bootd");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("boot", 0));
+	ut_assert_nextline("hello bootd");
+	ut_assert_console_end();
+
+	/* the return value is the one of the command in bootcmd */
+	ut_assertok(env_set("bootcmd", "false"));
+	ut_asserteq(1, run_command("bootd", 0));
+	ut_assert_console_end();
+
+	ut_assertok(env_set("bootcmd", NULL));
+
+	return 0;
+}
+CMD_TEST(cmd_bootd_test, UTF_CONSOLE);
-- 
2.54.0

