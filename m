Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19C6D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200E2890CE;
	Mon, 28 Oct 2024 13:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EorUNMqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C3489100; Mon, 28 Oct 2024 13:41:49 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CBB6890DA
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso700969166b.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119305; x=1730724105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZdEr6sSDSh9TqzvGACz9tyQ5J/Q0YIZnRxNZ2iPgkeo=;
 b=EorUNMqHwKfHago/xrmQR7Yb2t6F5WhSWmuLXDE2YrhWh/R1Jh2taV5F7F8Hy+/u2S
 0RJV0Rv1cHqAZYWoBMcgomaR7kuizqi8x1VEA0o8DOQRUkzb9g2hCXL2lPJY/OfP7gmE
 EPuNAwbRGAUsJhLBF3wVMm7BQVfnfOYYjXVro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119305; x=1730724105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZdEr6sSDSh9TqzvGACz9tyQ5J/Q0YIZnRxNZ2iPgkeo=;
 b=KJNW2kSku+6/+1IG8ZwY/hKNEEixDa8uPwEnlPbW4d1g8+1cU+Cc/ZxN1K/MLVyjC6
 bz4ztO2/vSp/IdV2WbeyujIn45yWXgcWt/NQAj0g5lvnmuSGNX5T+EAIamX2OJ4/Bi37
 Uyr208TV2y/ijYK5iZb8ewvlW+Il9fFOl+PF9yebktSGL+/4JINUPMlLylQYILWIWaiO
 xpzAkMA6UsC+F3cgb1gW5vn2NnzOGu+Nb4JEZlgHvxExp23lPo48juytYKSmHSbdypxJ
 xN94ebdHpk63q2vQ3o1577J8/OBmL/wx3BUmmTDBC+MEragLJ9ekwlNMOi2C7vDDRk4w
 aLjg==
X-Gm-Message-State: AOJu0Yw7J26msoNobwracK24KTiyQ3gE9nUIBcI3AJ0/ZgtnD6cV5GPv
 7CilIDKAmUZxdn3unmnZe4qIce06cphGMY4j/IuXqOq7JMmpaRQh5LmFQvcFhrFiKBRRP+cutMy
 9wA==
X-Google-Smtp-Source: AGHT+IHZ0dVSeJZzAxXpeJMkCQ+09td4y2mV6EbTjNDVTdfdf4iUzH8njr4EQuidJyPf3xGaYejRdQ==
X-Received: by 2002:a17:907:97d4:b0:a8a:6c5d:63b2 with SMTP id
 a640c23a62f3a-a9de5ce2522mr675985866b.18.1730119305583; 
 Mon, 28 Oct 2024 05:41:45 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/21] compression: test: Move into the lib suite
Date: Mon, 28 Oct 2024 13:41:11 +0100
Message-ID: <20241028124130.32072-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

There is no particular need for compression to have its own test suite.
Move it into the lib suite instead.

Add the missing help for 'common' and update the docs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/compression.h | 16 ----------------
 test/cmd_ut.c              |  5 -----
 test/lib/compression.c     | 39 ++++++++++++++------------------------
 3 files changed, 14 insertions(+), 46 deletions(-)
 delete mode 100644 include/test/compression.h

diff --git a/include/test/compression.h b/include/test/compression.h
deleted file mode 100644
index 02fcfa49f65..00000000000
--- a/include/test/compression.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2017 Google, Inc
- * Written by Simon Glass <sjg@chromium.org>
- */
-
-#ifndef __TEST_COMPRESSION_H__
-#define __TEST_COMPRESSION_H__
-
-#include <test/test.h>
-
-/* Declare a new compression test */
-#define COMPRESSION_TEST(_name, _flags) \
-		UNIT_TEST(_name, _flags, compression_test)
-
-#endif /* __TEST_ENV_H__ */
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index cba97725f76..0d7d5009fef 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -111,8 +111,6 @@ static struct cmd_tbl cmd_ut_sub[] = {
 			 "", ""),
 #endif
 #ifdef CONFIG_SANDBOX
-	U_BOOT_CMD_MKENT(compression, CONFIG_SYS_MAXARGS, 1, do_ut_compression,
-			 "", ""),
 	U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
 #endif
 	U_BOOT_CMD_MKENT(str, CONFIG_SYS_MAXARGS, 1, do_ut_str, "", ""),
@@ -203,9 +201,6 @@ U_BOOT_LONGHELP(ut,
 	"\ncmd - test various commands"
 #endif
 	"\ncommon   - tests for common/ directory"
-#ifdef CONFIG_SANDBOX
-	"\ncompression - compressors and bootm decompression"
-#endif
 #ifdef CONFIG_UT_DM
 	"\ndm - driver model"
 #endif
diff --git a/test/lib/compression.c b/test/lib/compression.c
index 618a1936955..31b6e5b1eb4 100644
--- a/test/lib/compression.c
+++ b/test/lib/compression.c
@@ -23,8 +23,7 @@
 
 #include <linux/lzo.h>
 #include <linux/zstd.h>
-#include <test/compression.h>
-#include <test/suites.h>
+#include <test/lib.h>
 #include <test/ut.h>
 
 static const char plain[] =
@@ -471,40 +470,40 @@ static int compression_test_gzip(struct unit_test_state *uts)
 	return run_test(uts, "gzip", compress_using_gzip,
 			uncompress_using_gzip);
 }
-COMPRESSION_TEST(compression_test_gzip, 0);
+LIB_TEST(compression_test_gzip, 0);
 
 static int compression_test_bzip2(struct unit_test_state *uts)
 {
 	return run_test(uts, "bzip2", compress_using_bzip2,
 			uncompress_using_bzip2);
 }
-COMPRESSION_TEST(compression_test_bzip2, 0);
+LIB_TEST(compression_test_bzip2, 0);
 
 static int compression_test_lzma(struct unit_test_state *uts)
 {
 	return run_test(uts, "lzma", compress_using_lzma,
 			uncompress_using_lzma);
 }
-COMPRESSION_TEST(compression_test_lzma, 0);
+LIB_TEST(compression_test_lzma, 0);
 
 static int compression_test_lzo(struct unit_test_state *uts)
 {
 	return run_test(uts, "lzo", compress_using_lzo, uncompress_using_lzo);
 }
-COMPRESSION_TEST(compression_test_lzo, 0);
+LIB_TEST(compression_test_lzo, 0);
 
 static int compression_test_lz4(struct unit_test_state *uts)
 {
 	return run_test(uts, "lz4", compress_using_lz4, uncompress_using_lz4);
 }
-COMPRESSION_TEST(compression_test_lz4, 0);
+LIB_TEST(compression_test_lz4, 0);
 
 static int compression_test_zstd(struct unit_test_state *uts)
 {
 	return run_test(uts, "zstd", compress_using_zstd,
 			uncompress_using_zstd);
 }
-COMPRESSION_TEST(compression_test_zstd, 0);
+LIB_TEST(compression_test_zstd, 0);
 
 static int compress_using_none(struct unit_test_state *uts,
 			       void *in, unsigned long in_size,
@@ -570,50 +569,40 @@ static int compression_test_bootm_gzip(struct unit_test_state *uts)
 {
 	return run_bootm_test(uts, IH_COMP_GZIP, compress_using_gzip);
 }
-COMPRESSION_TEST(compression_test_bootm_gzip, 0);
+LIB_TEST(compression_test_bootm_gzip, 0);
 
 static int compression_test_bootm_bzip2(struct unit_test_state *uts)
 {
 	return run_bootm_test(uts, IH_COMP_BZIP2, compress_using_bzip2);
 }
-COMPRESSION_TEST(compression_test_bootm_bzip2, 0);
+LIB_TEST(compression_test_bootm_bzip2, 0);
 
 static int compression_test_bootm_lzma(struct unit_test_state *uts)
 {
 	return run_bootm_test(uts, IH_COMP_LZMA, compress_using_lzma);
 }
-COMPRESSION_TEST(compression_test_bootm_lzma, 0);
+LIB_TEST(compression_test_bootm_lzma, 0);
 
 static int compression_test_bootm_lzo(struct unit_test_state *uts)
 {
 	return run_bootm_test(uts, IH_COMP_LZO, compress_using_lzo);
 }
-COMPRESSION_TEST(compression_test_bootm_lzo, 0);
+LIB_TEST(compression_test_bootm_lzo, 0);
 
 static int compression_test_bootm_lz4(struct unit_test_state *uts)
 {
 	return run_bootm_test(uts, IH_COMP_LZ4, compress_using_lz4);
 }
-COMPRESSION_TEST(compression_test_bootm_lz4, 0);
+LIB_TEST(compression_test_bootm_lz4, 0);
 
 static int compression_test_bootm_zstd(struct unit_test_state *uts)
 {
 	return run_bootm_test(uts, IH_COMP_ZSTD, compress_using_zstd);
 }
-COMPRESSION_TEST(compression_test_bootm_zstd, 0);
+LIB_TEST(compression_test_bootm_zstd, 0);
 
 static int compression_test_bootm_none(struct unit_test_state *uts)
 {
 	return run_bootm_test(uts, IH_COMP_NONE, compress_using_none);
 }
-COMPRESSION_TEST(compression_test_bootm_none, 0);
-
-int do_ut_compression(struct cmd_tbl *cmdtp, int flag, int argc,
-		      char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(compression_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(compression_test);
-
-	return cmd_ut_category("compression", "compression_test_",
-			       tests, n_ents, argc, argv);
-}
+LIB_TEST(compression_test_bootm_none, 0);
-- 
2.43.0

