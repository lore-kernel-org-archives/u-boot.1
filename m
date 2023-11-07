Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA9BC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7595C8767E;
	Tue,  7 Nov 2023 22:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KfFHezlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CEE8766A; Tue,  7 Nov 2023 22:42:12 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F21838762C
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so7694199e87.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393320; x=1699998120;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/XXgNxWrhZYUrO1TGJRm2ZSzDLELBGdR02GP7otNBM=;
 b=KfFHezlCrrczhzx5zmdjd2+PDy8qryTkrUsC8LOr5q3dKe5cc6dNsN0VpXfz1FOkOa
 AgKqXmtSPEutLpHxo3Isfz2TUdNUSacNKa2baQxIC0rS5aGArt5xdGsIH9Q8AQ8TlofA
 sevJgigZs9Y/tmkPZcFcfr6S7TF13AkFGWGEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393320; x=1699998120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/XXgNxWrhZYUrO1TGJRm2ZSzDLELBGdR02GP7otNBM=;
 b=h2eL4Tyz+HVc4i8r7K5wPO3TJdU/kwzjJZXsD9sske2Ihzhy/+kR8yFGLh2Q9T/90k
 DR+CJknJXCRFAqaSZG5cCP9PvLkHnOr+kl8GKmsRp708NgZuXeJvkLYFXqJ86JBQ+j37
 HDHRgXlyxiMYzcX92oolpQVJMBPzBGz5D4jT6IxCU5co283CfMCtGcqmEuru58bYDwRO
 E5qO9HjAmgpCc+c4utxs20S13IPik8AQLzCipKmC2YZ10dNxtyIrZCg5iQRNVJW+a4ns
 5alZYIGF0sku6X78/RFA/HumboDEXHXm3TAb+FcBnd/PrVYvUDS5g2vdnaHo3E4cR1lF
 awmA==
X-Gm-Message-State: AOJu0YydoeMavd9kKopVk833aIgPFIz6YQE21GaYRNIUbiz/QnPNnU/4
 UXd1+UL/heFaTYwqI8RGAJyDze1FhcB96GDQyVc=
X-Google-Smtp-Source: AGHT+IEsXHajcJIikpXkVoadFFdjWqQI0PPbFZBQhhy8gW3IxI3XJcyyoVC39mcLpcKzg+QiwXwEsA==
X-Received: by 2002:a05:6512:48d1:b0:500:bf33:3add with SMTP id
 er17-20020a05651248d100b00500bf333addmr23148181lfb.47.1699393320034; 
 Tue, 07 Nov 2023 13:42:00 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:41:59 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 05/24] test: hush: Test hush commands list
Date: Tue,  7 Nov 2023 23:41:02 +0200
Message-Id: <20231107214121.132079-6-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
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

