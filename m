Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF866C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE5787634;
	Fri,  8 Dec 2023 23:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WLzSzsjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB8D8762F; Fri,  8 Dec 2023 23:31:01 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E29D87654
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3332fc9b9b2so2397025f8f.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074658; x=1702679458;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/XXgNxWrhZYUrO1TGJRm2ZSzDLELBGdR02GP7otNBM=;
 b=WLzSzsjQ5CX2LSRn73tTehBC33aNnvAoCvtG5vfmI6ugm5+XKt08kmKpaDRb9228TR
 p940HFrx24655qhyOzh/aJmtARhKkFXtfTn/x+GsXJBWVk6/xG1aKAmU1xjhM09s2Vdi
 b8n6MpkY8cV3sV/RwPMhDUAMS4W0K5hl0RAaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074658; x=1702679458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/XXgNxWrhZYUrO1TGJRm2ZSzDLELBGdR02GP7otNBM=;
 b=RBbwZzVXyrtZGdjlqiihFKrqvuWdrIiKUMVveJiabuTxEkvpwOZYT1F66/vqqD+org
 0r7R3ejIOBwEumyhiftUkpN/qvlV+RQBOX2nzPe+hVS0JgMxR07/+e6F6HlSgLiMBVVv
 ygXvBaai+8JFALTdnqbe9do7dsfjNHzuyHMMC6f5tqi0IrVGEZEEPEWA/mQXf6a910bl
 6HNzYyzZDDVxBCYTCBvKGGRLB3a0VP+iqXKarCh+qLMgrZPCS0q4nDHHd6CyoyC3x2cv
 CADS74zr+KD0iVdUJDQ7h0n6WdUPvpnT29iZjoxQZCV6n/kIDHSltturDYkfDLvk7jl5
 kj/A==
X-Gm-Message-State: AOJu0Yw/cif4Zlus8LaLfagrq33tW7wrCe1uf5B6YXIGm2R7P1WNFFoM
 ZXK0zCYv/bbxtqD0udeHT9kj/rwqsTgVoXIvwrP55w==
X-Google-Smtp-Source: AGHT+IHy2pUtU4JY/gR2d75hv3ZYNWvMwDlK7Dvth7LdftdnM1fdedeprrrWy1sqiZ0dHo+Mq8OMJw==
X-Received: by 2002:a05:600c:358c:b0:40b:d5e9:f300 with SMTP id
 p12-20020a05600c358c00b0040bd5e9f300mr175956wmq.23.1702074658114; 
 Fri, 08 Dec 2023 14:30:58 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:30:57 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v12 05/24] test: hush: Test hush commands list
Date: Fri,  8 Dec 2023 23:30:06 +0100
Message-Id: <20231208223025.55076-6-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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

