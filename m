Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D142CC47072
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A521D87640;
	Fri, 22 Dec 2023 22:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SNB0OsBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D37B876C5; Fri, 22 Dec 2023 22:03:15 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9ADF8770F
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d4103aed7so21030805e9.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703278992; x=1703883792;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/XXgNxWrhZYUrO1TGJRm2ZSzDLELBGdR02GP7otNBM=;
 b=SNB0OsBsrdiufTta3RCcnfSVy0ol+EOFJGOIkhJJcvN+Hr3sAJrQf5Avob4YVdlrsW
 9J6JFe5EHZmI+XUNdl7U861AHuD3jK+J0xzTgHKBQXC/MZgv8ZBXlQxU3CZdoAqUIjYZ
 c776vbs2lzp4hPhoEZv66nn50jLCULloFZfLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703278992; x=1703883792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/XXgNxWrhZYUrO1TGJRm2ZSzDLELBGdR02GP7otNBM=;
 b=D5RA1jzuYHSz91uM06bITEn1CKC1+1wWSOMgeW2R7m4HVsalC9V+AwEv5njYZhG7iH
 LRhv6BAXJfhPW3o+ExwM6BDICRvFxDeMeg2oiQFGsMAEAQWW/nW91W26fXCHrcaMImr0
 wggA7ATIrxnAm2L7ykaBp7/icvRUsSpNkB8dXNgZKhEV23PJ5zLoLBc791NrvDpkRSKA
 X/8d1Gtf9E4rxzgouGUn790+3QMpLlRrTQMuynrbIPCRDOkiBb7VaKPVfhge6CkLcbeG
 dR8OqB1X6n4mmzBsQNrqoAq7o72n4nqv2/OOMZvipg09jJfVD92fdFc/kQQkKSMeIhuR
 MkuA==
X-Gm-Message-State: AOJu0YxZwMvddhSeXhb2l97xo+ej0FgndMZmDEmCWaq71BPeqT362eDU
 xWYlbygBbBCjqO3rI2VX27+CB3puu+SFBzjNgog27b3MtKg=
X-Google-Smtp-Source: AGHT+IEdOkAuTG4I1rRbL/1tP1OPJtAkHRGws4tkKYPrPgdzUPQei8BXIskQ8zyOd7Ap6Hc9eMYIgg==
X-Received: by 2002:a05:600c:3115:b0:40d:47a8:a256 with SMTP id
 g21-20020a05600c311500b0040d47a8a256mr864984wmo.13.1703278992356; 
 Fri, 22 Dec 2023 13:03:12 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:12 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 05/24] test: hush: Test hush commands list
Date: Fri, 22 Dec 2023 22:02:25 +0100
Message-Id: <20231222210244.91830-6-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
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

