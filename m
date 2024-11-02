Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA716E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF72890FE;
	Sat,  2 Nov 2024 20:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fTlEfFeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19A508860B; Sat,  2 Nov 2024 20:37:38 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF39890F2
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbd550b648so22192526d6.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576254; x=1731181054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWU2y2AC9J8VOvSgW7RqkQwawtCGBl5AAkRCDglmtmw=;
 b=fTlEfFeHizySkhWpshf+7B4KGlVuq3XWwomyFEIC3S8N2fS8euhst4ji/UU+aUFW+6
 6IFzV9SQ8fnnoivFgD9G36rU8DThq/OjYPxIkn3w8dcJBVq+zRhOLgaedkxZx/auDOMQ
 vYN5HWLPhKfaTw1v2xwDgZWnQ2VJYZ14AUbQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576254; x=1731181054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWU2y2AC9J8VOvSgW7RqkQwawtCGBl5AAkRCDglmtmw=;
 b=YAxOcBFDuDQSJpBoldEIPRcnLjGZgcbZazm+dO/rt1uKfmhe/AenbVfdnoUMixsWlt
 B1UPvlslor6Cs1HZTtov3E2twqyO8JLGhQ24IbLl3PAOrw9x+SgVtl5Z7vAFdXkAlKXI
 vDbQW7revB0luP34rn9QQzBCfjsXxMLNOmD6L3iO1KSXz34VGmfS4jDuvsaKGLG5m6Cq
 WLiYjtlcgMfZbo+B9dFO3eg6+G2geNiliCN4qWTkYAyqpzYXVjaHxovsKujfPxZh7iML
 IsgVrj5iKkEaq+NiV2DJLeqzyLmfs/3SFz+O+3NJZv2aqSrkH8KxFQYMdx0sMLO3hJzw
 swGA==
X-Gm-Message-State: AOJu0YyZQxPFCeYoKKWb+ssY+cHGEG6lhD9TPAckF4tKDBnia6yNseYN
 sp6l+NUVqk+NjbvYjvKRVrxREKqwTlk4gVTzxGVW0arH3bCCgCOfz+KTCQd/E9x+lO/Oqqz/JW4
 WRrGo
X-Google-Smtp-Source: AGHT+IGh5WxABGo0mNFm11qpLjMv+Zb3TtL1X2nhBiHyGJ2Xz1Kr7lMD4dFV4nkvJ/kFAgWSEB8jwQ==
X-Received: by 2002:a05:6214:5884:b0:6cb:eb51:a26a with SMTP id
 6a1803df08f44-6d35c1aea92mr108482676d6.47.1730576253958; 
 Sat, 02 Nov 2024 12:37:33 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/20] compression: test: Move into the lib suite
Date: Sat,  2 Nov 2024 13:36:50 -0600
Message-ID: <20241102193715.432529-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

(no changes since v1)

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
index 53fddebd49d..32403b48ca4 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -111,8 +111,6 @@ static struct cmd_tbl cmd_ut_sub[] = {
 			 "", ""),
 #endif
 #ifdef CONFIG_SANDBOX
-	U_BOOT_CMD_MKENT(compression, CONFIG_SYS_MAXARGS, 1, do_ut_compression,
-			 "", ""),
 	U_BOOT_CMD_MKENT(bloblist, CONFIG_SYS_MAXARGS, 1, do_ut_bloblist,
 			 "", ""),
 	U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
@@ -207,9 +205,6 @@ U_BOOT_LONGHELP(ut,
 #ifdef CONFIG_CMDLINE
 	"\ncmd - test various commands"
 #endif
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

