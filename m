Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34736C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 09:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D677831BE;
	Wed, 16 Jul 2025 11:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Iz9Y30NT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 944CE831C3; Wed, 16 Jul 2025 11:03:34 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A705831AC
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 11:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45611a517a4so2336285e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752656611; x=1753261411; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/HUsSRTQaE4+pwflyIZy6lZ5qnrjhEOPvp0+q2OYpgg=;
 b=Iz9Y30NT2iCcDcWrtgY+q/9ikao2yY8AgT6gF3H+IpSJiEz3PVqRy7jb6gFmaZnVTe
 HL04I/bQxCwKC89g7zDoKpQ6x4hjyIJALBf1Qb0QIkf8drHkMR6d46iUmGiR0LuVppRt
 fJjEwuKVKQZ5cs32NASGpUPsZcG5gbprLnxPv4Dcc+hAFuWm8puVLlReJuFtvHsiyuiV
 TpFWDeqIr/vtVNes9P5QnSiOcGlg9P5869fVFz2rV56udxxiB2Nb8p2eJXeQc0SRN7YK
 6wsFty6HBEINRiSI7IIZR2cG690NiSs4iRc/TlqIWp93yGH0mRYxD99/63qaNIG8hOXg
 fcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752656611; x=1753261411;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/HUsSRTQaE4+pwflyIZy6lZ5qnrjhEOPvp0+q2OYpgg=;
 b=BMFl+s/WmTavbKGdZXZDZ1eYGw1Pe+Gd6VGbylL47iRvfeEYZ6euIHluOpTo+7kJFL
 s5I60czbEBgIcuTp34MoSRI7LI5zLTEmDLvHA+exEYEXXCWrgbHNb/fIvgMwtSYEodiZ
 sMD1ALqcm38txEMljNp7hsTFWR9Qok7kMFevFVhCaG+WZ14CN3I+hKgrEnSNaSxnOn2n
 DDNg0FxHPyVMhGZOVkAwBnIisVj/8Pzu7k23bvY+LEIi0lITD0GbNmrCPu2+nqtiMpGT
 MKB/1v5g4TYmFcbuEbKWJZcCV0T+O+T/oQRGWRlRGp6LcNVsgndPcYQuJJpqnbn8D4x1
 8NUg==
X-Gm-Message-State: AOJu0YxKTtvzgMtNJx2gQH7A4UKGhych/eVbHn8ilJO4dkO9ebilBigG
 UwK94zgF7jgF0EcK8Q6HC8MFofdzbRU9ku+L4NG4eg45tZS8lOvkrkgiuQa+5ztXDO3KyTs/RA/
 5BR0B
X-Gm-Gg: ASbGnctRvrmqR2L2y+B2tka6r1Drz0V5Frt5jVnZ5tht7nL3MchdIuQGNrV/quLRTh7
 yHVHXFmtvgsArGsid6YUSRiQ/HnIHrW7lkV3kdpJu9lxGq1MYC79uOdx2nNmfJVWzplqlEjAll/
 rcWfW5Gt0boQu+PkazjcEO1+vUC1LkUNE9mVfsgTPHNWyTGAnSMslSW5mkxMgdVDOSVfR0P0jPf
 dSgufUTykPYtgbKqmvMK7qvlnN2Mszgg/7nwIu+dI+m/vqBFEQDzC3kCb9LEk3Dhm2HnRNdp7Pf
 bY4aP6YGD2NlSL+Xh9ij+rmCvz+0aoRU58sU43sSuVvbw2E6UgmMQPa/bhay3cNSc6WRHTOma8g
 2GQU9PZcstnhVQFEl/tloRvh0O5vvkiPc71cU33d4ffHJKeLppQ==
X-Google-Smtp-Source: AGHT+IEMJsU3FgWtW4XC5N859NPRwXLaexXfUI3nt0Ajr2nPA8nbw1UPZoO8HaaGeojPlj3V+O6Bkw==
X-Received: by 2002:a05:600c:310b:b0:456:942:b162 with SMTP id
 5b1f17b1804b1-4562dcc2f8emr21861225e9.11.1752656611392; 
 Wed, 16 Jul 2025 02:03:31 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:d584:3606:6325:3ecd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d587sm16999681f8f.46.2025.07.16.02.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 02:03:30 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 16 Jul 2025 10:03:30 +0100
Subject: [PATCH] abuf: Remove code that prevented test code running
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-abuf_test-v1-1-d4eef5cb79e7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOFqd2gC/x2NQQqDMBBFryKzbsCIUfEqpcgknegsjGUmSkG8e
 2OXj/8+7wQlYVIYqxOEDlbeUgH7qCAsmGYy/C4MTd24urfOoN/jlEmzwWBj37adH6yD4ntUMl4
 wheV+rKiZ5B4+QpG//8jzdV0/Oe05WHQAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

When abuf was introduced some test code was prevented from running using
a 'return 0' early in the functions. A comment said it crashed on
sandbox due to a 'bug' in realloc. Some time later a bug in abuf_realloc
was fixed but this test code was never enabled.

Remove the early 'return 0' instances so that the test code can run.
Also remove some checks that relied on the implementation details of the
U-Boot memory code as these can fail on sandbox which uses system memory
code. Besides that this code should be testing abuf implementation not
the underlying memory code which has its own tests.
Finally use a new #define for the allocs that are meant to fail to
ensure they do fail on all CI platforms.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/lib/abuf.c | 46 +++++++---------------------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index 97b128c01c0..3dced1ddb11 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -12,6 +12,7 @@
 
 static char test_data[] = "1234";
 #define TEST_DATA_LEN	sizeof(test_data)
+#define HUGE_ALLOC_SIZE 0x60000000
 
 /* Test abuf_set() */
 static int lib_test_abuf_set(struct unit_test_state *uts)
@@ -93,13 +94,6 @@ static int lib_test_abuf_realloc(struct unit_test_state *uts)
 {
 	struct abuf buf;
 	ulong start;
-	void *ptr;
-
-	/*
-	 * TODO: crashes on sandbox sometimes due to an apparent bug in
-	 * realloc().
-	 */
-	return 0;
 
 	start = ut_check_free();
 
@@ -116,23 +110,18 @@ static int lib_test_abuf_realloc(struct unit_test_state *uts)
 	ut_assertnonnull(buf.data);
 	ut_asserteq(TEST_DATA_LEN, buf.size);
 	ut_asserteq(true, buf.alloced);
-	ptr = buf.data;
 
 	/*
-	 * Make it smaller; the pointer should remain the same. Note this relies
-	 * on knowledge of how U-Boot's realloc() works
+	 * Make it smaller.
 	 */
 	ut_asserteq(true, abuf_realloc(&buf, TEST_DATA_LEN - 1));
 	ut_asserteq(TEST_DATA_LEN - 1, buf.size);
 	ut_asserteq(true, buf.alloced);
-	ut_asserteq_ptr(ptr, buf.data);
 
 	/*
-	 * Make it larger, forcing reallocation. Note this relies on knowledge
-	 * of how U-Boot's realloc() works
+	 * Make it larger.
 	 */
 	ut_asserteq(true, abuf_realloc(&buf, 0x1000));
-	ut_assert(buf.data != ptr);
 	ut_asserteq(0x1000, buf.size);
 	ut_asserteq(true, buf.alloced);
 
@@ -210,19 +199,12 @@ static int lib_test_abuf_large(struct unit_test_state *uts)
 	ulong start;
 	size_t size;
 	int delta;
-	void *ptr;
-
-	/*
-	 * This crashes at present due to trying to allocate more memory than
-	 * available, which breaks something on sandbox.
-	 */
-	return 0;
 
 	start = ut_check_free();
 
 	/* Try an impossible size */
 	abuf_init(&buf);
-	ut_asserteq(false, abuf_realloc(&buf, CONFIG_SYS_MALLOC_LEN));
+	ut_asserteq(false, abuf_realloc(&buf, HUGE_ALLOC_SIZE));
 	ut_assertnull(buf.data);
 	ut_asserteq(0, buf.size);
 	ut_asserteq(false, buf.alloced);
@@ -237,13 +219,11 @@ static int lib_test_abuf_large(struct unit_test_state *uts)
 	ut_assertnonnull(buf.data);
 	ut_asserteq(TEST_DATA_LEN, buf.size);
 	ut_asserteq(true, buf.alloced);
-	ptr = buf.data;
 	delta = ut_check_delta(start);
 	ut_assert(delta > 0);
 
 	/* try to increase it */
-	ut_asserteq(false, abuf_realloc(&buf, CONFIG_SYS_MALLOC_LEN));
-	ut_asserteq_ptr(ptr, buf.data);
+	ut_asserteq(false, abuf_realloc(&buf, HUGE_ALLOC_SIZE));
 	ut_asserteq(TEST_DATA_LEN, buf.size);
 	ut_asserteq(true, buf.alloced);
 	ut_asserteq(delta, ut_check_delta(start));
@@ -254,8 +234,8 @@ static int lib_test_abuf_large(struct unit_test_state *uts)
 
 	/* Start with a huge unallocated buf and try to move it */
 	abuf_init(&buf);
-	abuf_map_sysmem(&buf, 0, CONFIG_SYS_MALLOC_LEN);
-	ut_asserteq(CONFIG_SYS_MALLOC_LEN, buf.size);
+	abuf_map_sysmem(&buf, 0, HUGE_ALLOC_SIZE);
+	ut_asserteq(HUGE_ALLOC_SIZE, buf.size);
 	ut_asserteq(false, buf.alloced);
 	ut_assertnull(abuf_uninit_move(&buf, &size));
 
@@ -278,12 +258,6 @@ static int lib_test_abuf_uninit_move(struct unit_test_state *uts)
 
 	start = ut_check_free();
 
-	/*
-	 * TODO: crashes on sandbox sometimes due to an apparent bug in
-	 * realloc().
-	 */
-	return 0;
-
 	/* Move an empty buffer */
 	abuf_init(&buf);
 	ut_assertnull(abuf_uninit_move(&buf, &size));
@@ -383,12 +357,6 @@ static int lib_test_abuf_init_move(struct unit_test_state *uts)
 	struct abuf buf;
 	void *ptr;
 
-	/*
-	 * TODO: crashes on sandbox sometimes due to an apparent bug in
-	 * realloc().
-	 */
-	return 0;
-
 	ptr = strdup(test_data);
 	ut_assertnonnull(ptr);
 

---
base-commit: cd79a2839b01571b6f2915c219f71c05e3c97482
change-id: 20250715-abuf_test-ac1f7446b815

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

