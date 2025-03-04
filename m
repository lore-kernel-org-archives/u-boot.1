Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DD5C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90F581280;
	Tue,  4 Mar 2025 16:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v920mA2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4016810ED; Tue,  4 Mar 2025 16:32:13 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26ED781335
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so39849025e9.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102303; x=1741707103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2b0elY+BCEMH9XRp7+WKyqFK+JQ8TgjRK/4IpiB+xp8=;
 b=v920mA2fE/KflWV4FTWwudoV27G/ep4Q9TwxwhmysRh474uwq4yz5SHbQp/2TwRCxl
 ussLLhXrDT5+8QyJyHnUFYA+h1XiSdg9zxt6ujlnxiYw/3LQ/b9kselzbn0Ju5AqGT92
 37VGQK68A0ehksLA4jSvOxontD0AkY7z1zQrlES0XoO1SDobuoJ8D4jCkUgdGiEKBhC5
 ZyEVIW8LymJnwTIpse5ukz82DPtya5/mymwyDwT6tLd370z1S3GWdy0UB0LRxtNDvjXJ
 XBWZBYOPHJPAlWNOwyOEG1WYWo3Hcdrhbudh651aefs67vQ7upTU1DBWojoKy6Vb6yu+
 3/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102303; x=1741707103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2b0elY+BCEMH9XRp7+WKyqFK+JQ8TgjRK/4IpiB+xp8=;
 b=OP+VWb8Xk6ODvvVlGphcnQBjUD7rs8r/0mgsMN9bciDtvGsjOWiizU9edtcJHYynEy
 XmrcPttuzjMT5iCeYJd7xHRAmZllKW/BlT2RN0tGyyfKAG2X1/q2j/0H9PeuUzpFxqaz
 JDD2vpBRKVsGjjn+7keZEQj4fLdR6yY/Wx1mky+xpzE7eMaI2YvWL0f7408AxJJgPYeY
 5Eo9YFpSnSolJRb2qF/aLnH4f9lh7D+qbElzulr30hjyUUyg569Rxo+vpBoHdgItL0iU
 wiZ9VBwHZrEL0Rqk3UH1UmlbNiEvcFDkjLYsKpUCWqWIt+AZR3PtWOXQ1QW3+zYOdFb8
 3rLQ==
X-Gm-Message-State: AOJu0YzM5qLcKn7ddOe7I835gN3Od01VyYZG+qy5sPDPVNItPOv+mvKz
 LwIHSeJRHqupd6aSw10RZXROxpVS2SQF/8aziYWKLHiIQ1EfapMicipVAhsRMVvAxXkvRHhBcBO
 f
X-Gm-Gg: ASbGncs9UfFYiWOrJ1Uw8d/jbEvNaqtw32dHBZJZ+kwmzoWEajEm2jVw/1pYhhkIX9Z
 ixpkGny3A5f52TWreyEsq8m4XQPSwGFfPPoQdYxs1pmkV5MI4byw9+6DgaVmk2lE0Gj0j4I08CL
 FhD4J3HKoCL+NRqVnVUj3/ZKVaCDURIvJW3BL3XltNmwoehiC0UMxTKe3811+r0yUmzOyjKRGnS
 Mh+q6E3tK+Y0hb+YQEyYGm/V+93855nl2Ju2dK68/AZoPfI0LIbZ7bi9Rxyfh0Hh5PHQwfvtfaH
 FLGLV1wZ3KOJsC5+VvLCVBEJDYGocukM1R/G+Q0LqfHwyRnFx5pEDQ==
X-Google-Smtp-Source: AGHT+IGNNLFxt0w64EYQLklWmJi5+P84i+2iJlg20OQPrxFKiAuaCkJZlM84ZftpibzdsTiIcir84A==
X-Received: by 2002:a05:600c:2292:b0:43b:c0fa:f9ce with SMTP id
 5b1f17b1804b1-43bc0fafff1mr67444255e9.14.1741102303000; 
 Tue, 04 Mar 2025 07:31:43 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:42 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 13/14] test: cmd: add test for spawn and wait commands
Date: Tue,  4 Mar 2025 16:25:01 +0100
Message-ID: <20250304152510.2832340-14-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152510.2832340-1-jerome.forissier@linaro.org>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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
 test/cmd/spawn.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
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
index 00000000000..8f48f5ee25c
--- /dev/null
+++ b/test/cmd/spawn.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Tests for spawn and wait commands
+ *
+ * Copyright 2025, Linaro Ltd.
+ */
+
+#include <command.h>
+#include <test/cmd.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int test_cmd_spawn(struct unit_test_state *uts)
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
+CMD_TEST(test_cmd_spawn, UTF_CONSOLE);
-- 
2.43.0

