Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999ADC021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8577381113;
	Tue, 25 Feb 2025 17:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yNFg9R6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B89D810F5; Tue, 25 Feb 2025 17:35:31 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FCF080FED
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43998deed24so55550485e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501328; x=1741106128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgqKz0JnkEMJXv2dl1r5sJ8K6KK0LVfIjcCRnaqavds=;
 b=yNFg9R6dvkTBzUlJS/VmE27ik17qunBPKGbFXqFOAGN2fwdp5vjzzRUW/mb+QyYdgP
 YU0eSfqVpFeHAxR4glHU/7kNI0leOVYrW+exvvlTfsN4eWEpDc52MmgntZY/oUzjO2aa
 BoRHKPII+jmM3d7qb6ZVWr2JqB/Ix3YfsvuwHAWhMD3nGLkN5ivHvPalSdTgDgLhiVN3
 0Ji1QMoyA5ZFjzIn+FikkeRJpwNaUEMrePMuZ5sYBDOBXcvYb93ikd5GGJN2aorb7ttG
 r+TwAevUMYjLMleTcJRj1eTX1HwuPWY+oxxeqAczb4E6MmN9oWsusKP79f+Q0wFA6A5G
 WNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501328; x=1741106128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TgqKz0JnkEMJXv2dl1r5sJ8K6KK0LVfIjcCRnaqavds=;
 b=aeoAuWOe1WUKzUT8s589qC6wQNese605afizc2PSoboHQfGRPBxU4XoZMDuyApUuiU
 AFpMdkw58YX71hSbdf/L2UQSJl959rGIF5YYxO7H50KYomI6yaPjkPf4bvRs2e9WYh8C
 utFq1VoO/41cKGuYiW9GqJe3FcG0Bmd+3q8rvy2lUq1QLKWHQwLXZuyEp7z+QsHYQi71
 vNuJFeVDY8xqLHiiHTzfjyCIuOANw5iBnkxiF/z6RcKCPcdguscEb6E4rBmB4I4Us82N
 y0oErxfTco9JNI8u92JwqHDjum4JA51Xi3TInj2nGLwcSNX/hI1iXNvSyQjcWd2JNKbC
 t5Ag==
X-Gm-Message-State: AOJu0YxmSVysqaueYaqu5EdAJ3E8PNEr0icZV0CjwNqSRcd+9sJxnz/c
 C7J+DKEQJJaL/cGuVNhh/niR3SEJmVxGmvmSno0aYTQ8dQ7/j1/enCndN7MkpHE1iPtpjRk11Lg
 HHyCSOw==
X-Gm-Gg: ASbGncsFybhG2KAProLkAkWeYxT+w14YkeClTqkLnBlQ2Iwm7m5YCT8+QbYEZpMnwYf
 Q/VOr2r02Ci5Ws6TPz9US2gc6AA5GWtyXu+7TlBe6aEQ/CUXiRsPwB2/OxQs7mksCI/uzeaZw1X
 UKXYDW3GDGttWxOwXuhCm7XyrNmeA5NNVNo/7qeOmW7EGMhqeKNmKCQMktzj1hVvudz5V0qPj01
 1TTXnHH0oYmTRgDKYiyQrQOa42Fhz3FGvaSsPZzGj2yfi5xzKZzom0SUlGil1etKkjAFg+7xUnd
 PON9nQa/rQqixjbB9KJv72LnouF3wquv/yg=
X-Google-Smtp-Source: AGHT+IGosUMbsJFNVOsjwSMGkl5OSeyVS+GUlGYrQAL10mfEClKmkaW8JxEYM21qdg6RVmbN1s6KYQ==
X-Received: by 2002:a05:6000:1a85:b0:38d:ba81:b5c2 with SMTP id
 ffacd0b85a97d-38f70854e1amr14897628f8f.47.1740501328441; 
 Tue, 25 Feb 2025 08:35:28 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:28 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 14/14] test: dm: add test for spawn and wait commands
Date: Tue, 25 Feb 2025 17:34:40 +0100
Message-ID: <2f17fd7ec21b59218d5bf88f045c13db08f906ca.1740499185.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740499185.git.jerome.forissier@linaro.org>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
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

Test the spawn and wait commands.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/cmd/Makefile |  1 +
 test/cmd/spawn.c  | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 test/cmd/spawn.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index d8a5e77402d..cf47f04851c 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_CMD_WGET) += wget.o
 endif
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
 endif
+obj-$(CONFIG_CMD_SPAWN) += spawn.o
diff --git a/test/cmd/spawn.c b/test/cmd/spawn.c
new file mode 100644
index 00000000000..5e0770858c0
--- /dev/null
+++ b/test/cmd/spawn.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Tests for spawn and wait commands
+ *
+ * Copyright 2025, Linaro Ltd.
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int dm_test_cmd_spawn(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("wait; spawn sleep 2; setenv j ${job_id}; "
+				"spawn setenv spawned true; "
+				"setenv jj ${job_id}; wait; "
+				"echo ${j} ${jj} ${spawned}", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_asserteq_ptr(uts->actual_str,
+			strstr(uts->actual_str, "1 2 true"));
+
+	ut_assertok(run_command("spawn true; wait; setenv t $?; spawn false; "
+				"wait; setenv f $?; wait; echo $t $f $?", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_asserteq_ptr(uts->actual_str,
+			strstr(uts->actual_str, "0 1 0"));
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_cmd_spawn, UTF_CONSOLE);
-- 
2.43.0

