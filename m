Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0FEC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C4580BAA;
	Wed, 15 Jan 2025 14:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GQkTWB7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDC8F80C66; Wed, 15 Jan 2025 14:32:21 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A93B80BA5
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844e39439abso216202539f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947938; x=1737552738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcZxW71x6ISJc2qV7ozIRPsTRnDvrpfIp9U1cuzyYiU=;
 b=GQkTWB7EBEBitURicm59bW83gdr/1NBUQL3VI0h7WTCRvBZz8dLE1P1QJKREAr9G0F
 rApmHegNFoGIxpwXkIgOzhPuR9rpsK1QOjJog1CqAkI2tud5xc6tG6g4knpL87m7+ODn
 SFmMo9FwdzAsb4XZY8q7rjHpUOZWSjohKM5tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947938; x=1737552738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcZxW71x6ISJc2qV7ozIRPsTRnDvrpfIp9U1cuzyYiU=;
 b=Dg889M1nstrzBAr2e+lz4uEr/8aF8mwfyCObjJ6i4Hp4Mmva4/S57/dpOKP19//6g/
 xOm+uVte8ajAoHe1jlNSX0QP1vtORl25xpLrt4iNzW51zqUg4P9wQyZBf+AZZshiT9H0
 PhjUYFADQG87n/o1L0J28NY37JjdsZonUcZeJyR6sqs5pbhdUoBpLIEbTv8ub0kYwKIo
 /rQy483HOc9GQw11Sj41eAD3ZeHLFl57ynM7KhH0MaNWx9HyxC5gPyxt010SKL/KPBwC
 +ak6FWrP7b67CSW5dvefg/GcJDPUHhClE0Uk8+WzMOOwNYLcrFAGyefq2obfW7TjzvFN
 Ev5Q==
X-Gm-Message-State: AOJu0YwN5Tzl7OqTQl0lfwcbvAQmT3Ny/kRwCLLnsVm9zERB0CWXpgCT
 TA19cqqyMekRNezL+kYBFW7Bn1FnTyEzpQwA6dLRRYTsx/J9RNCWlavP2nZ6S45qY+8qbEzuY58
 =
X-Gm-Gg: ASbGncvG99uCQWsxwuVo5zhTbm1Tdq6rj6/B3xX6pKlC1k3XMZ1AIMGKnK7fxnB3LrB
 nQGn7q3jwD7xv4BEJNLSFv97qV7LKgwOlrxRso0iMnMIrqge0VEqOasBHokHsBdOM9NeQi8Gack
 ceDSVvI8Pnxc09viyv9MaONyXDKPPdTKX/fl4x8cFKwEe7vebdzGrMuRhyoRb5NM6BeOEzQFtHh
 rCpviNtVQz/Fze6XO7CZkUW+xgMMmHj+F7UPW1B+0NJvui2MWAYE9VM3JGFNdJEJx/9Ez/xFpCG
 M3Qyi4OZ7klJAl3NeA==
X-Google-Smtp-Source: AGHT+IEFHRtNCg4keDOp8z0Ahho7q3JxfxmS2a5ku1DQD/4a13dlOAxRxAU/Cw50sAp/+CR5Kj1HnQ==
X-Received: by 2002:a05:6e02:3891:b0:3bc:be0f:edcd with SMTP id
 e9e14a558f8ab-3ce3a96da56mr196190525ab.11.1736947937775; 
 Wed, 15 Jan 2025 05:32:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 34/43] test: Drop the info test from the list
Date: Wed, 15 Jan 2025 06:31:04 -0700
Message-Id: <20250115133114.590375-35-sjg@chromium.org>
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

The 'info' test is not a real test. With the new suite array we can drop
this and the associated special-case code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c               |  4 +---
 test/py/tests/test_suite.py | 13 +++++--------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 0d055119ce3..798710972e5 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -93,7 +93,6 @@ int cmd_ut_category(const char *name, const char *prefix,
 	NULL, \
 	}
 
-SUITE_DECL(info);
 SUITE_DECL(bdinfo);
 SUITE_DECL(bootstd);
 SUITE_DECL(cmd);
@@ -121,7 +120,6 @@ SUITE_DECL(seama);
 SUITE_DECL(upl);
 
 static struct suite suites[] = {
-	SUITE_CMD(info, do_ut_info),
 #ifdef CONFIG_CMD_BDI
 	SUITE(bdinfo),
 #endif
@@ -247,7 +245,7 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		puts("\nTests  Suite\n");
 		puts("-----  -----\n");
-		for (i = 1; i < ARRAY_SIZE(suites); i++) {
+		for (i = 0; i < ARRAY_SIZE(suites); i++) {
 			struct suite *ste = &suites[i];
 			long n_ent = ste->end - ste->start;
 
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index ed636bbde74..938dfb468f6 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -8,7 +8,7 @@ import re
 EXPECTED_SUITES = [
     'addrmap', 'bdinfo', 'bloblist', 'bootm', 'bootstd',
     'cmd', 'common', 'dm', 'env', 'exit',
-    'fdt', 'font', 'hush', 'info', 'lib',
+    'fdt', 'font', 'hush', 'lib',
     'loadm', 'log', 'mbr', 'measurement', 'mem',
     'overlay', 'pci_mps', 'setexpr', 'upl',
     ]
@@ -145,9 +145,8 @@ def test_suite(u_boot_console):
         suites, all_tests, exp_test_count, missing, extra = collect_info(cons,
                                                                          output)
 
-    # Make sure we got a test count for each suite (ignore 'info' since it isn't
-    # a real suite
-    assert suites - exp_test_count.keys() == {'info'}
+    # Make sure we got a test count for each suite
+    assert suites - exp_test_count.keys() == set()
 
     # Run 'ut info' and compare with the log results
     with cons.log.section('Check suite test-counts'):
@@ -166,10 +165,8 @@ def test_suite(u_boot_console):
 
         cons.log.info(str(exp_test_count))
         for suite in EXPECTED_SUITES:
-            # 'info' is not really a suite, just a subcommand of 'ut'
-            if suite != 'info':
-                assert test_count[suite] in ['?', str(exp_test_count[suite])],\
-                    f'suite {suite} expected {exp_test_count[suite]}'
+            assert test_count[suite] in ['?', str(exp_test_count[suite])], \
+                f'suite {suite} expected {exp_test_count[suite]}'
 
         assert suite_count == len(EXPECTED_SUITES)
         assert total_test_count == len(all_tests)
-- 
2.34.1

