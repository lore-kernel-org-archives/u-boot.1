Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71A0C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB2A8081E;
	Wed, 15 Jan 2025 14:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fph2+6MX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED32A80A37; Wed, 15 Jan 2025 14:32:02 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC5B80713
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844eac51429so492335839f.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947919; x=1737552719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOhUlPpWU55mhoQTDB0sOP7gGsVDv6Ho+Ei6OEhi5YI=;
 b=Fph2+6MXhcBDx5NDCbllXyt4iG+wxgcm2THgPagXYSrhTr7nWDkG2L81kJDtk34Iky
 IVfdrCFkikGbjiHI4eaTYmikN1mOOuArnFoMbNyrjAC71oY6YsdCFaan0Bnse9v/1iDe
 NwuCT9qm8F37uZWp13kwPztQfLRiifazOKJPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947919; x=1737552719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOhUlPpWU55mhoQTDB0sOP7gGsVDv6Ho+Ei6OEhi5YI=;
 b=tz3TWoQzPhfZRVgxrfq56DAyoJT+fcwR8YGdJ7em058iZ4WyeCTeY2VgFg136yaTSn
 BhMY7DO9w1I7kFdlishHHymFfCfnRKSE4lLAzhq10Ic2TPVK+4T/bCJk2Tzo3RRnA/og
 ixnq8Vrj9PEhy/X9Z5i9NdcVXJcXj/Zk2wjzqVeYWgpfTFPRi6vp4svBDVreFp8UZU4p
 MTAwAIlULTeKJ5V8YBKojGcPZgILq4dTOAjFI5aVAT4KMWWf2Q8MxYF6/ghy/3nTeID3
 ajLMZgTXGvLVZ6MHicwbjMCQnbAy3nkg0HBnUqxUdxr5dOrU+NWSxuBFdNlxvtkRfjwX
 HdEA==
X-Gm-Message-State: AOJu0YyH7z987JkgPHKlCnhmtQG42LWR5wq5PYyScEW8FtV2jDKJC0lP
 r37R3RqQDvMrfawr3nlquRi9KdZr1+7z/FozyeKGF38U7xSyey0LLQKNh8t3SvaCVAR9FpFosvI
 =
X-Gm-Gg: ASbGncvjHn2EN87gEuegcmy9s8Lp2TUMCCNN6EtmVTM/1skl9loV1p70umNL6YZffiY
 ToJ1pqaTmqISXRdXw9DseIViXYtpd3oGc3goRHb4zApichS4sq4/LFdL5bi9iiz962mu0nEPIOu
 KT+k8Svd470o+Fudg+twfJYGiPb/qjR0Wn+zcvW7CoeMdNqq46YhERSrEDOV8JNgTOLoRJoTc34
 QTpKiMuXGyGRnwwg5v6KNSe80cdVu6tVZq/w0vqpBhqnHUfF7nL6xjCLEAcMaB0JvnKAUdqsw7N
 L7rICsFd9ifIwtJWZw==
X-Google-Smtp-Source: AGHT+IEoZGHvOP3nBi8KHYlgGs30ZbBaDgpfN8QM0VAJgZ9xDE/mBXUshPYchxQfCh/mXUInmfbzgw==
X-Received: by 2002:a05:6602:3f0e:b0:843:f220:fa3d with SMTP id
 ca18e2360f4ac-84ce00a0533mr3036015839f.7.1736947918894; 
 Wed, 15 Jan 2025 05:31:58 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 23/43] test: Drop the function for running mem tests
Date: Wed, 15 Jan 2025 06:30:53 -0700
Message-Id: <20250115133114.590375-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h |  1 -
 test/cmd/Makefile     |  2 +-
 test/cmd/mem.c        | 19 -------------------
 test/cmd_ut.c         |  2 +-
 4 files changed, 2 insertions(+), 22 deletions(-)
 delete mode 100644 test/cmd/mem.c

diff --git a/include/test/suites.h b/include/test/suites.h
index 612167fe053..cb6b6fba240 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -40,7 +40,6 @@ int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
-int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index f83c53696d0..d8a5e77402d 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -10,7 +10,7 @@ endif
 ifdef CONFIG_CONSOLE_RECORD
 obj-$(CONFIG_CMD_PAUSE) += test_pause.o
 endif
-obj-y += exit.o mem.o
+obj-y += exit.o
 obj-$(CONFIG_X86) += cpuid.o msr.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
diff --git a/test/cmd/mem.c b/test/cmd/mem.c
deleted file mode 100644
index 2b78e421a9c..00000000000
--- a/test/cmd/mem.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Executes tests for memory-related commands
- *
- * Copyright 2020 Google LLC
- */
-
-#include <command.h>
-#include <test/suites.h>
-#include <test/test.h>
-
-int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(mem);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(mem);
-
-	return cmd_ut_category("mem", "mem_test_", tests, n_ents, argc,
-			       argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index f5fbcf0d686..4e57fcf0005 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -161,7 +161,7 @@ static struct suite suites[] = {
         && defined(CONFIG_MMC_SANDBOX) && defined(CONFIG_MMC_WRITE)
 	SUITE(mbr),
 #endif
-	SUITE_CMD(mem, do_ut_mem),
+	SUITE(mem),
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_SETEXPR)
 	SUITE_CMD(setexpr, do_ut_setexpr),
 #endif
-- 
2.34.1

