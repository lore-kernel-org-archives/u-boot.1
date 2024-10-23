Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A263CDDE7D
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 15:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CE3892D5;
	Wed, 23 Oct 2024 17:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="syTJZXG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 025F4892CF; Wed, 23 Oct 2024 17:22:15 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E9F6892DE
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 17:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so937509766b.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729696927; x=1730301727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pm6+7/NsXinpSFKOdnca6MFUdCL8mHEX4HacqC709XQ=;
 b=syTJZXG3SA/qWZ/IFXrEDgJRQwtCkkJJTB8sSLwOwpHu63QjtSoOX23WF0sXi+rV9D
 rWAmWE4wZ8VaN3ArDW7USteUMKsBSXFnNLmRGriKASSinR4yx5Pt3u+xK8IX8DtJJxqR
 VqiPE/yncRlVzXQxZ1Bxw7Jyak7siEs0LgLHdN6G9i7jl3M5BKKa2rnCRE1AyH5KFL3g
 MWZM2guSkrc5/ReSQG7xAda7bk8A4RVjQVjfph4CdnPIb6SuViBmN8L5WvcTzS/mNQWg
 xDcwdLk9mUAulpF6z/HOLpkshlQu116K+L9dBpSjzyvdFwp+Thq2F/KqFPaWSd7C9bPR
 Usgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729696927; x=1730301727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pm6+7/NsXinpSFKOdnca6MFUdCL8mHEX4HacqC709XQ=;
 b=MRMJmA7xWaug0y2w9wvGTYprLr0MPaCI6IgxbV3XjM28UPlCOrdTxXzkYTn69hk/QA
 PrWhFsrGbIB6KnYf5pDmZlONoq9NbKI1ZsAW8VVelqUZQ04Guu77Z9nlyRTu+xdmIjRb
 +H9Wuvt0mjH+QUqYXiCsvK6155nd8MxDWsu3C3DUxTkUnoRpwa+h9xB6zm0AXG9FB61x
 uO8BfbmO94imB3frM8SfCWdPWjeTnz8a6+uPsns8xg/+n8HimgOtfeIlskK0VrunZG3l
 NX2uOkghPZGPRAyXiCJiItqsDryBCx8uBYU1vkTLfkAHxUVSghCNe99tik7atkefpabn
 dnPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSMgOwbWP45Hiz1Wv5bV2hErXTCXYyyEwCV+rfbwePNqgnj4T7tylUItSziKGXAUu0Fcmh/l0=@lists.denx.de
X-Gm-Message-State: AOJu0YzjGCkEaWMohHSgSxKvdS7kJXAfU/FrywzwbtorV2FOtU/G15Tw
 t7io69rZPhAdz338X1IOCkUQe/YwVbp+WG+1XgZjaLUoSXW+oGqW9QydRdzUHLc=
X-Google-Smtp-Source: AGHT+IGCp2R4KsgmoYvI4ZOMyDsa4f4QJ5FhwE2XWn/7RJH8J/VsajkAuEOhytElufGQ36/wGCU8vQ==
X-Received: by 2002:a17:906:c154:b0:a9a:12c9:41d1 with SMTP id
 a640c23a62f3a-a9abf8a2083mr305822766b.28.1729696927511; 
 Wed, 23 Oct 2024 08:22:07 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912edfedsm489242766b.72.2024.10.23.08.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 08:22:07 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sughosh.ganu@linaro.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] lmb: Fix lmb_add_region_flags() return codes and testing
Date: Wed, 23 Oct 2024 18:22:00 +0300
Message-ID: <20241023152203.1218242-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

The function description says this should return 0 or -1 on failures.
When regions coalesce though this returns the number of coalescedregions
which is confusing and requires special handling of the return code.
On top of that no one is using the number of coalesced regions.

So let's just return 0 on success and adjust our selftests accordingly

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/image-fdt.c |  2 +-
 lib/lmb.c        | 10 +++++-----
 test/lib/lmb.c   | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 8eda521693dc..eac09059d955 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -73,7 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, enum lmb_flags flags)
 	long ret;
 
 	ret = lmb_reserve_flags(addr, size, flags);
-	if (ret >= 0) {
+	if (!ret) {
 		debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
 		      (unsigned long long)addr,
 		      (unsigned long long)size, flags);
diff --git a/lib/lmb.c b/lib/lmb.c
index 7e90f178763b..8ce58fcb9224 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -450,7 +450,7 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 	}
 
 	if (coalesced)
-		return coalesced;
+		return 0;
 
 	if (alist_full(lmb_rgn_lst) &&
 	    !alist_expand_by(lmb_rgn_lst, lmb_rgn_lst->alloc))
@@ -487,7 +487,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	struct alist *lmb_rgn_lst = &lmb.free_mem;
 
 	ret = lmb_add_region(lmb_rgn_lst, base, size);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (lmb_should_notify(LMB_NONE))
@@ -583,8 +583,8 @@ long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
 
 	ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
-	if (ret < 0)
-		return -1;
+	if (ret)
+		return ret;
 
 	if (lmb_should_notify(flags))
 		return lmb_map_update_notify(base, size, MAP_OP_RESERVE);
@@ -651,7 +651,7 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 			if (rgn < 0) {
 				/* This area isn't reserved, take it */
 				if (lmb_add_region_flags(&lmb.used_mem, base,
-							 size, flags) < 0)
+							 size, flags))
 					return 0;
 
 				if (lmb_should_notify(flags)) {
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index b2c54fb4bcb8..c917115b7b66 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -473,7 +473,7 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 
 	/* allocate overlapping region should return the coalesced count */
 	ret = lmb_reserve(0x40011000, 0x10000);
-	ut_asserteq(ret, 1);
+	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x11000,
 		   0, 0, 0, 0);
 	/* allocate 3nd region */
@@ -748,13 +748,13 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 
 	/* merge after */
 	ret = lmb_reserve_flags(0x40020000, 0x10000, LMB_NOMAP);
-	ut_asserteq(ret, 1);
+	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x20000,
 		   0, 0, 0, 0);
 
 	/* merge before */
 	ret = lmb_reserve_flags(0x40000000, 0x10000, LMB_NOMAP);
-	ut_asserteq(ret, 1);
+	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x30000,
 		   0, 0, 0, 0);
 
@@ -770,7 +770,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 
 	/* test that old API use LMB_NONE */
 	ret = lmb_reserve(0x40040000, 0x10000);
-	ut_asserteq(ret, 1);
+	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0, 0);
 
@@ -789,7 +789,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 
 	/* merge with 2 adjacent regions */
 	ret = lmb_reserve_flags(0x40060000, 0x10000, LMB_NOMAP);
-	ut_asserteq(ret, 2);
+	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40050000, 0x30000);
 
-- 
2.45.2

