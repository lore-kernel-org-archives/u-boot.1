Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08819C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2BD060763;
	Thu,  6 Aug 2026 13:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hWoyMD8rygCp; Thu,  6 Aug 2026 13:37:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8CEC60784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786023455;
	bh=tJ6HDTWjI4N6oA8m4j7yOb4FlHfKTGY25qpbHxSg8Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hpisTh5PMq8BsycPEEYIkCDkj8mfmcYFEeEJWqpFGHn3hLqKWDZqh/VH57VSgYjHx
	 J9Du6Pi476VvZxOVWB32xS+bJAPrlXL3HVi6QGKUuYuYaGdMU7pvYuptBrlBHMK2lm
	 7CPcwUG1dRSat5vKAn/RAZK0ahb3SNlgb3N37g8KsjDAELa6QpX/kz5pCjlGruZThs
	 VOpzyvhVQAoebgyqf1kagBwjLGvZ8iBQsPi31/8LqdfVhu6Tug1/1qBER27yvsIJBV
	 4Ylad5BhUfLzq4IjZ750sqYQsE6oRvhi4MNCxy/K8a2j8XmvF8+rGPCNmewYKso9Jy
	 stqeRGz4ahi5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8CEC60784;
	Thu,  6 Aug 2026 13:37:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AAFAF198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90954404C9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lAYhvHcK84iQ for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:37:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B4015404A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4015404A2
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4015404A2
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:37:32 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-495437bb891so8953905e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786023451; x=1786628251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tJ6HDTWjI4N6oA8m4j7yOb4FlHfKTGY25qpbHxSg8Q8=;
 b=jarY7GFXF60WCMYfM88h8UUFGdQH3L6fI93dbEV1uPtubg+s4dVuQhIca92d1ltE34
 FKfFXercTmtFmJJTcbuPOTcTAYkOYUrRTMj2g6txotCQVQAYUOdLzNbCtcv2GQBRiWmb
 ZKVkCuOor9Xq1xhFhUx+N+HP7Ydnu2Q8N+Lsb3/qPAq2dU9808lxZej8I8cAHgm7T/S1
 VaDZ7XDYdFIUJySHcJLQcX9vhXziKXK0J+70rsKCSPzRfbvXorlEv18qUFvn55For+F5
 fABWtk5VkFRfB0qGjSOBsBShaTcCHIHdkCtBlROdQd7a/fxzD3zTD/G+EEsDPOaFftrU
 WB7g==
X-Gm-Message-State: AOJu0YyhLWLwNmGf28XGlE4Ro53KsY8UZ6aDQPNuKM5uaWIfUF7alA0u
 j//GZy1CmKCsNpOnQOwuMT7/YNtPf+OzeP9Qw8Wl+yRPJtOYS1MP0hqdSBhIRA==
X-Gm-Gg: AR+sD11bUMQ99sKCtXutWZoN6moup51jf2pbk4dkxBLPgyCt7vV+CQoim0CG8wUlO8U
 /k4dXzRP8Zmls6a474UNj4f1pDqNn0RJ1w3IOHkrLGQWtdVPlJi5VG/+UrhUZiSk1w5um2dimXm
 iciBP2L1yXLVjn4rKaIxQcAx+o99rFOhrNdq+GTopz3yOb2DZFuP311c2tE8Uy6u2bpK8/M988Z
 s3HahI9tuSVjv0O6dicalsVrNJGh1A0t5u0uSJDmYMQmleuDBioEThWU2yqeetj252BtASi9gzz
 IrDYNqUpc2sir2E4BUFfASBLZWn9EatLA2H+OTqdRVYjKboYPbKxdlCwbAbl5d+XmM9SR+9tJ+z
 JUzjaQPDWG7B268y91rt6V5NVL/bo84ydFk19jo/Q2pBu9d/eb6ik3NXzAFYsHtwMO5Jgp+J0KP
 5+0FVcfoaVIKdMgllqsLwqJIVUaj33TeVBWGa8BGghutEShF5H3L70xemr1qYyGc6eCcw=
X-Received: by 2002:a05:600c:468e:b0:499:596b:2e91 with SMTP id
 5b1f17b1804b1-499596b2ebbmr30306085e9.3.1786023450445; 
 Thu, 06 Aug 2026 06:37:30 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e52d819sm91691585e9.1.2026.08.06.06.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:37:30 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 2/2] test: cmd: add a test for bootd
Date: Thu,  6 Aug 2026 15:37:24 +0200
Message-ID: <20260806133724.336755-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806133724.336755-1-mehmet.fide@gmail.com>
References: <20260806133724.336755-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786023451; x=1786628251;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tJ6HDTWjI4N6oA8m4j7yOb4FlHfKTGY25qpbHxSg8Q8=;
 b=PVZZVHySq5wBsYwkcLGLpYmkw/ZwdRg62OGPfxMFkTHX3vYQxrRqMy0yO6Xqsmwgnb
 obUmFiIgNfU5ZhbFFSuXHydwKA+Bgi/NZzj913E5Q6klRkrPwzN2zBJLLR94Aat+AD5S
 InCt3WpooVuLBz4qB/qUEKC0RopV0/yHEd90+WYuOXHdVU8D/7RSEhw8AF6lN0mKp0/1
 tehSMwl8VMfRurQCjYOTMTMygGv5ZEdz6lYq2RtgyxJ4OhN3Og4WhGGcSL/bgDrrCexd
 fcVuuIAm7rlvLHV3ZsXEJ2wDdJritD59DkTaLhA+H8oru7CGfWhnYKbyLevYAXklEsWX
 79RA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PVZZVHyS
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
command held in the bootcmd environment variable, and the return value of
bootd is the one of that command. Also assert the recursion guard in
cmd_process(), which is part of the code bootd carries.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 test/cmd/Makefile |  1 +
 test/cmd/bootd.c  | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 test/cmd/bootd.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8d36463879d..e734933d5f7 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -17,6 +17,7 @@ ifdef CONFIG_CONSOLE_RECORD
 obj-$(CONFIG_CMD_ACPI) += acpi.o
 endif
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
+obj-$(CONFIG_CMD_BOOTD) += bootd.o
 obj-$(CONFIG_CMD_CONFIG) += config.o
 obj-$(CONFIG_COREBOOT_SYSINFO) += coreboot.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
diff --git a/test/cmd/bootd.c b/test/cmd/bootd.c
new file mode 100644
index 00000000000..be7ca49a972
--- /dev/null
+++ b/test/cmd/bootd.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the bootd command
+ *
+ * Copyright 2026 Mehmet Fide <mehmet.fide@screeningeagle.com>
+ */
+
+#include <command.h>
+#include <console.h>
+#include <env.h>
+#include <malloc.h>
+#include <test/cmd.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int cmd_bootd_test(struct unit_test_state *uts)
+{
+	char *const argv[] = { "bootd", NULL };
+	const char *old = env_get("bootcmd");
+	char *saved = NULL;
+	int repeatable = 0;
+
+	if (old) {
+		saved = strdup(old);
+		ut_assertnonnull(saved);
+	}
+
+	/* bootd runs the command held in bootcmd */
+	ut_assertok(env_set("bootcmd", "echo hello bootd"));
+	ut_assertok(run_command("bootd", 0));
+	ut_assert_nextline("hello bootd");
+	ut_assert_console_end();
+
+	/* and so does its "boot" alias */
+	ut_assertok(run_command("boot", 0));
+	ut_assert_nextline("hello bootd");
+	ut_assert_console_end();
+
+	/*
+	 * The return value is the one of the command in bootcmd. An unknown
+	 * command fails whichever parser is built in; they word the complaint
+	 * differently, so match only its start.
+	 */
+	ut_assertok(env_set("bootcmd", "no_such_command"));
+	ut_asserteq(1, run_command("bootd", 0));
+	ut_assert_nextlinen("Unknown command");
+	ut_assert_console_end();
+
+	/*
+	 * A bootd reached from bootd is refused rather than recursing. The
+	 * guard lives in cmd_process(), and run_command() drops its flag
+	 * argument when the hush parser is used, so call cmd_process()
+	 * directly. bootcmd would print if the guard let it through.
+	 */
+	ut_assertok(env_set("bootcmd", "echo bootcmd must not run"));
+	ut_asserteq(CMD_RET_FAILURE,
+		    cmd_process(CMD_FLAG_BOOTD, 1, argv, &repeatable, NULL));
+	ut_assert_nextline("'bootd' recursion detected");
+	ut_assert_console_end();
+
+	ut_assertok(env_set("bootcmd", saved));
+	free(saved);
+
+	return 0;
+}
+CMD_TEST(cmd_bootd_test, UTF_CONSOLE);
-- 
2.54.0

