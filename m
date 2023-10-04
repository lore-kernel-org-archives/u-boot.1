Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B360E7C4E3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4974886EC3;
	Wed,  4 Oct 2023 18:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lxcG3ClF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B8987599; Wed,  4 Oct 2023 18:43:03 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB5C187513
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53829312d12so2580906a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437776; x=1697042576;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/XXgNxWrhZYUrO1TGJRm2ZSzDLELBGdR02GP7otNBM=;
 b=lxcG3ClFJOW0r/bpo0Ub/nV7eK9B0rrf1t2HIo+jsgVNIU5xCzAZ5FEE+Otjppr5Cr
 IQ3haADX19Cwit2NRr18PKXhKeUEeFkgwLKGWHEhi+2JN9UIL+Xh2fKeDj09mcPrTTRZ
 5HM4xJfgSTXGoHcf3XjU6MNM/u459nvVW8vNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437776; x=1697042576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/XXgNxWrhZYUrO1TGJRm2ZSzDLELBGdR02GP7otNBM=;
 b=QxwBPsAYfRc1L+0opIaR8mqjgEVELgzdkwlPuozVAYQAGpNzqf3jrMJH3Cn322q8wc
 yS8fFw7pns4qJRNpYYL2lzHx4k/DJzu3yxVzl2lm7j7e99uMaM/wJIJRWCh1TJEb5ujV
 A1gdrk4xBWNzrqHT1DuXeWIVxTD7rJi6EmxfMR3mAzE/YlLQvdohgFstHVWJFmBGIUyd
 5pxO/UiyQ9x6Wnl6p4XNYtTrUTf1SStePbrgZcIcBKgmRiJc9/hU2EALPbJmM7mTOFNR
 VZBEKRj0QMuIMrK28bOd+uXeKqhWtYx1FVMbq5MtYPNGiDwxcXo/ERZdb8jUXBTV1XMQ
 EJlg==
X-Gm-Message-State: AOJu0YyuXcQVBRtQdpegyf59IfZ3T/ljfPvFO+iqBvbvqJNGLOu3Vqn9
 l/jRo8IuAvlOs9Cl1jCJ6jMB2SWpgs3tE/Vgnsg=
X-Google-Smtp-Source: AGHT+IH60S9LztHFacmOvZi5lB4xXPJiKVjoTxD1cSkJXJQXX60SUqhMPAMN5I87BzqTI3aC6Qd76w==
X-Received: by 2002:a05:6402:1a57:b0:521:d2ab:e4df with SMTP id
 bf23-20020a0564021a5700b00521d2abe4dfmr178345edb.19.1696437776282; 
 Wed, 04 Oct 2023 09:42:56 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:42:56 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [RFC PATCH v10 05/24] test: hush: Test hush commands list
Date: Wed,  4 Oct 2023 19:42:01 +0300
Message-Id: <20231004164220.15738-6-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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

Verifies behavior of commands separated by ';', '&&' and '||'.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 test/hush/Makefile |  1 +
 test/hush/list.c   | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 test/hush/list.c

diff --git a/test/hush/Makefile b/test/hush/Makefile
index feb4f71956..ff4fe7700b 100644
--- a/test/hush/Makefile
+++ b/test/hush/Makefile
@@ -6,3 +6,4 @@
 obj-y += cmd_ut_hush.o
 obj-y += if.o
 obj-y += dollar.o
+obj-y += list.o
diff --git a/test/hush/list.c b/test/hush/list.c
new file mode 100644
index 0000000000..052cf2783c
--- /dev/null
+++ b/test/hush/list.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2021
+ * Francis Laniel, Amarula Solutions, francis.laniel@amarulasolutions.com
+ */
+
+#include <common.h>
+#include <command.h>
+#include <env_attr.h>
+#include <test/hush.h>
+#include <test/ut.h>
+
+static int hush_test_semicolon(struct unit_test_state *uts)
+{
+	/* A; B = B truth table. */
+	ut_asserteq(1, run_command("false; false", 0));
+	ut_assertok(run_command("false; true", 0));
+	ut_assertok(run_command("true; true", 0));
+	ut_asserteq(1, run_command("true; false", 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_semicolon, 0);
+
+static int hush_test_and(struct unit_test_state *uts)
+{
+	/* A && B truth table. */
+	ut_asserteq(1, run_command("false && false", 0));
+	ut_asserteq(1, run_command("false && true", 0));
+	ut_assertok(run_command("true && true", 0));
+	ut_asserteq(1, run_command("true && false", 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_and, 0);
+
+static int hush_test_or(struct unit_test_state *uts)
+{
+	/* A || B truth table. */
+	ut_asserteq(1, run_command("false || false", 0));
+	ut_assertok(run_command("false || true", 0));
+	ut_assertok(run_command("true || true", 0));
+	ut_assertok(run_command("true || false", 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_or, 0);
+
+static int hush_test_and_or(struct unit_test_state *uts)
+{
+	/* A && B || C truth table. */
+	ut_asserteq(1, run_command("false && false || false", 0));
+	ut_asserteq(1, run_command("false && false || true", 0));
+	ut_asserteq(1, run_command("false && true || true", 0));
+	ut_asserteq(1, run_command("false && true || false", 0));
+	ut_assertok(run_command("true && true || false", 0));
+	ut_asserteq(1, run_command("true && false || false", 0));
+	ut_assertok(run_command("true && false || true", 0));
+	ut_assertok(run_command("true && true || true", 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_and_or, 0);
+
+static int hush_test_or_and(struct unit_test_state *uts)
+{
+	/* A || B && C truth table. */
+	ut_asserteq(1, run_command("false || false && false", 0));
+	ut_asserteq(1, run_command("false || false && true", 0));
+	ut_assertok(run_command("false || true && true", 0));
+	ut_asserteq(1, run_command("false || true && false", 0));
+	ut_assertok(run_command("true || true && false", 0));
+	ut_assertok(run_command("true || false && false", 0));
+	ut_assertok(run_command("true || false && true", 0));
+	ut_assertok(run_command("true || true && true", 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_or_and, 0);
-- 
2.34.1

