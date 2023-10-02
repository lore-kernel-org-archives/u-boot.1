Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C1AE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B96587272;
	Mon,  2 Oct 2023 03:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mw6av7to";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE378709C; Mon,  2 Oct 2023 03:18:01 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C95387238
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-352308c0799so17524085ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209374; x=1696814174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avxd/J4FHw7l+by9QQKXOqvFjf/TZKRr9aaJCq0SzGI=;
 b=mw6av7tomx36PV59C32NMtNHKCri65rOxn19VYaH6vfMgJUeP/g1XmjNXskJXJ5j7u
 U3sSHQZwH+ov47vl0miFcpMzS8uMoInMaF1Cs3EoOXGlnZ0T1V3Zs1V9STpy3pJ4bq00
 Seqo08wEXEW61o7iH4xuRJymAFbfZwQ98yZYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209374; x=1696814174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avxd/J4FHw7l+by9QQKXOqvFjf/TZKRr9aaJCq0SzGI=;
 b=s1BJSgmEcv57pnd7o0LUDJEpdiWQhuW4sv0lmzQdfg3MQK0fMUmKBBb2zEuYN/z8/b
 jdaeWBoujqSTgLkfsSGWDQez77fBAHepymo0P34gl5ITy7nBYTWj11gJu6lcqC2AS4mo
 dA3+unNQ1WyZmSPtQfXqa85398vAoIlSNvlzPwsTGXDzegQfdktb/9T6s9zF/Zw6p1Uo
 WscK2C2GqJS21asQn3yWPdA8XjKuDKAvHIZEcDd7ulI7qecaS8wUkgvd0uAEN3TFY8Cu
 Q7praHv8Glc+S5Tosdverm+5307xN2TKueJtcJhOdCozVNxMwu3q03hRNvioNytgzJDm
 Vn3w==
X-Gm-Message-State: AOJu0YwaZMTXgNwZJmmeiXOmQRfa18swtFcBZD4/V00JXO1/AsNPa5O+
 1EbYYDERzEtGysH13SozgVqWTvwcbbHcL4fgmJA=
X-Google-Smtp-Source: AGHT+IFj8IzwGcnPnFRiCmIasiy9wGENm5ekwE9+wh4vFcD4kTRFaMAamU7Mmd/aqFekuf8CJqCdFw==
X-Received: by 2002:a05:6e02:214a:b0:349:7663:566c with SMTP id
 d10-20020a056e02214a00b003497663566cmr12482138ilv.30.1696209374268; 
 Sun, 01 Oct 2023 18:16:14 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 11/34] test: lmb: Move tests into the lib suite
Date: Sun,  1 Oct 2023 19:15:21 -0600
Message-ID: <20231002011553.463514-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

These tests are marked as driver model tests, but have nothing to do
with driver model. As a result, they are run as part of 'ut dm' which
only exists for sandbox.

Move them to the 'lib' suite and drop the requirement for initing
devices, since they don't use devices.

Also put the lib_test_lmb_max_regions() macro inside the same #ifdef
as its function, to avoid a build error if the condition is false.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/lib/lmb.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 162887503588..0eccd77114e1 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <dm/test.h>
+#include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -205,8 +206,7 @@ static int lib_test_lmb_simple(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_multi_alloc_512mb(uts, 0xE0000000);
 }
-
-DM_TEST(lib_test_lmb_simple, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+LIB_TEST(lib_test_lmb_simple, 0);
 
 /* Create two memory regions with one reserved region and allocate */
 static int lib_test_lmb_simple_x2(struct unit_test_state *uts)
@@ -221,8 +221,7 @@ static int lib_test_lmb_simple_x2(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 3.5GiB and 1 GiB */
 	return test_multi_alloc_512mb_x2(uts, 0xE0000000, 0x40000000);
 }
-
-DM_TEST(lib_test_lmb_simple_x2,  UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+LIB_TEST(lib_test_lmb_simple_x2, 0);
 
 /* Simulate 512 MiB RAM, allocate some blocks that fit/don't fit */
 static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
@@ -288,8 +287,7 @@ static int lib_test_lmb_big(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_bigblock(uts, 0xE0000000);
 }
-
-DM_TEST(lib_test_lmb_big, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+LIB_TEST(lib_test_lmb_big, 0);
 
 /* Simulate 512 MiB RAM, allocate a block without previous reservation */
 static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
@@ -364,7 +362,7 @@ static int lib_test_lmb_noreserved(struct unit_test_state *uts)
 	return test_noreserved(uts, 0xE0000000, 4, 1);
 }
 
-DM_TEST(lib_test_lmb_noreserved, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+LIB_TEST(lib_test_lmb_noreserved, 0);
 
 static int lib_test_lmb_unaligned_size(struct unit_test_state *uts)
 {
@@ -378,8 +376,8 @@ static int lib_test_lmb_unaligned_size(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_noreserved(uts, 0xE0000000, 5, 8);
 }
+LIB_TEST(lib_test_lmb_unaligned_size, 0);
 
-DM_TEST(lib_test_lmb_unaligned_size, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 /*
  * Simulate a RAM that starts at 0 and allocate down to address 0, which must
  * fail as '0' means failure for the lmb_alloc functions.
@@ -421,8 +419,7 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 
 	return 0;
 }
-
-DM_TEST(lib_test_lmb_at_0, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+LIB_TEST(lib_test_lmb_at_0, 0);
 
 /* Check that calling lmb_reserve with overlapping regions fails. */
 static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
@@ -459,9 +456,7 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 
 	return 0;
 }
-
-DM_TEST(lib_test_lmb_overlapping_reserve,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+LIB_TEST(lib_test_lmb_overlapping_reserve, 0);
 
 /*
  * Simulate 512 MiB RAM, reserve 3 blocks, allocate addresses in between.
@@ -590,8 +585,7 @@ static int lib_test_lmb_alloc_addr(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_alloc_addr(uts, 0xE0000000);
 }
-
-DM_TEST(lib_test_lmb_alloc_addr, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+LIB_TEST(lib_test_lmb_alloc_addr, 0);
 
 /* Simulate 512 MiB RAM, reserve 3 blocks, check addresses in between */
 static int test_get_unreserved_size(struct unit_test_state *uts,
@@ -661,9 +655,7 @@ static int lib_test_lmb_get_free_size(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_get_unreserved_size(uts, 0xE0000000);
 }
-
-DM_TEST(lib_test_lmb_get_free_size,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+LIB_TEST(lib_test_lmb_get_free_size, 0);
 
 #ifdef CONFIG_LMB_USE_MAX_REGIONS
 static int lib_test_lmb_max_regions(struct unit_test_state *uts)
@@ -732,11 +724,9 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 
 	return 0;
 }
+LIB_TEST(lib_test_lmb_max_regions, 0);
 #endif
 
-DM_TEST(lib_test_lmb_max_regions,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
-
 static int lib_test_lmb_flags(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0x40000000;
@@ -822,6 +812,4 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 
 	return 0;
 }
-
-DM_TEST(lib_test_lmb_flags,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+LIB_TEST(lib_test_lmb_flags, 0);
-- 
2.42.0.582.g8ccd20d70d-goog

