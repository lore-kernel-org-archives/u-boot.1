Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9694CC28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5E781E3E;
	Sat, 15 Mar 2025 15:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PjLp0g3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA6B181E1C; Sat, 15 Mar 2025 15:28:06 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1CB381D1F
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso4172385e9.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048884; x=1742653684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljuEbntwSke4RycMWy7nA071gIuHTO7yywjsMUps4Mg=;
 b=PjLp0g3PjC/ilOYpH3xms5d/AA6VZyCS1pdSRRLK7evo5xhX/KLFbArbvDkaYfs9UQ
 uUEwCJQEEAft1dqDzFamg7d/5WU4CeXxNPudmcp6AZXYPk8pWjOJ4xfUKKbHB7loB+9J
 Hw9A/qF6BCEFq4OaUUInoppAFJ/Y6+QFDnASQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048884; x=1742653684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljuEbntwSke4RycMWy7nA071gIuHTO7yywjsMUps4Mg=;
 b=f6Pb0jEabaAjc3E+IGtuTBScxaUAQfkuB+T3GvrOz/0ntBB7cwfu38KNPGe57keloR
 u4kCQGlBTC92jbxh59duhM+sjYPxvYmN2vhNpQIQmCSjzSxa966bZ2lja/U+ZItBy472
 Bnestcq34tquqa9gVK+ReOPYhmdROyJwy4+EmthvPIsgasn1T+mQrlLP0wdC4i71bNFG
 ub/J0Y6Ujn+lPKoU21G2UqDhpYal4WRissaulLKAWgMBTK68piW/TFIWR9Mz1c4ewl22
 HFvNoLSHjG32sKDJ0CVq0Nzy/jJXGFfLSgRlIK9TRGmJpu4IQ6OyZpdtr7nA+i6QDNel
 zXVg==
X-Gm-Message-State: AOJu0Yxl2HNaUQQCKXF/PDofVytfkBxOjKc6k2sFrePL2y/aH5luygiG
 6XFyNQzqrWA+8GBEW7c4iLV6nK+tmvC+sWqM4vrwVveIfOiw4jn6dqUb6ftWAfrtODKyr4A0+3k
 Q9w==
X-Gm-Gg: ASbGncuTv2SVItT5IfteuNSWEVWi3c0KPWoDxQAb71OXOtEqWE7upAwT6OWeMJ/9ATT
 UwgO1Q3VQaBu/bPwF/QLaEcwjBeG+McPIKZnMhxyzsK0nG4Nf4oS7xc3mnTNQSDByzijtKb7Sp4
 Qd5q4ZCz6tPGCU563u6sdOA9Wk9h45v8AUYsa+5F0fuN+GHz1x2nKAhLeHi5Npcto/h34uDyXZ3
 pmbU0NnM/N/01TSvNzDCcYLLVsDC1Hwlty9P9o7G6gC7WIX4z70q5yVuAFDWvL65KJshFQY1I7o
 62Xb2PudC0gG7vti6rSjExbA1bWEG7uB6NMA+wTsmA==
X-Google-Smtp-Source: AGHT+IGaNtwhww2joc6f7nfaMYkw5wBL8PaeSwbxYxejH/3GwLV78bOMHrcR4gdIuEZnanjGfjCpyw==
X-Received: by 2002:a05:600c:338a:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-43d2021a1bdmr60050235e9.27.1742048883805; 
 Sat, 15 Mar 2025 07:28:03 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 26/46] x86: Allow adding non-aligned size for MTRR
Date: Sat, 15 Mar 2025 14:25:46 +0000
Message-ID: <20250315142643.2600605-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

At present mtrr_add_request() requires that the size is a power of two.
This is too limiting for machines with 4GB (or more) of RAM, since they
often must take account of a memory hole at 3GB.

Update the function to automatically deal with an unaligned size, using
more MTRRs as required.

The algorithm is taken from coreboot commit 60bce10750

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to allow adding non-aligned size for MTRR

 arch/x86/cpu/mtrr.c | 84 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 16 deletions(-)

diff --git a/arch/x86/cpu/mtrr.c b/arch/x86/cpu/mtrr.c
index fca7b28f815..7a0f00b9b8f 100644
--- a/arch/x86/cpu/mtrr.c
+++ b/arch/x86/cpu/mtrr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2014 Google, Inc
+ * Portions added from coreboot
  *
  * Memory Type Range Regsters - these are used to tell the CPU whether
  * memory is cacheable and if so the cache write mode to use.
@@ -204,29 +205,80 @@ int mtrr_commit(bool do_caches)
 	return 0;
 }
 
-int mtrr_add_request(int type, uint64_t start, uint64_t size)
+/* fms: find most significant bit set (from Linux)  */
+static inline uint fms(uint val)
+{
+	uint ret;
+
+	__asm__("bsrl %1,%0\n\t"
+		"jnz 1f\n\t"
+		"movl $0,%0\n"
+		"1:" : "=r" (ret) : "mr" (val));
+
+	return ret;
+}
+
+/*
+ * fms64: find most significant bit set in a 64-bit word
+ * As samples, fms64(0x0) = 0; fms64(0x4400) = 14;
+ * fms64(0x40400000000) = 42.
+ */
+static uint fms64(uint64_t val)
+{
+	u32 hi = (u32)(val >> 32);
+
+	if (!hi)
+		return fms((u32)val);
+
+	return fms(hi) + 32;
+}
+
+int mtrr_add_request(int type, u64 base, uint64_t size)
 {
 	struct mtrr_request *req;
-	uint64_t mask;
+	u64 mask;
 
 	debug("%s: count=%d\n", __func__, gd->arch.mtrr_req_count);
 	if (!gd->arch.has_mtrr)
 		return -ENOSYS;
 
-	if (!is_power_of_2(size))
-		return -EINVAL;
-
-	if (gd->arch.mtrr_req_count == MAX_MTRR_REQUESTS)
-		return -ENOSPC;
-	req = &gd->arch.mtrr_req[gd->arch.mtrr_req_count++];
-	req->type = type;
-	req->start = start;
-	req->size = size;
-	debug("%d: type=%d, %08llx  %08llx\n", gd->arch.mtrr_req_count - 1,
-	      req->type, req->start, req->size);
-	mask = mtrr_to_mask(req->size);
-	mask |= MTRR_PHYS_MASK_VALID;
-	debug("   %016llx %016llx\n", req->start | req->type, mask);
+	while (size) {
+		uint addr_lsb;
+		uint size_msb;
+		u64 mtrr_size;
+
+		addr_lsb = fls64(base);
+		size_msb = fms64(size);
+
+		/*
+		 * All MTRR entries need to have their base aligned to the
+		 * mask size. The maximum size is calculated by a function of
+		 * the min base bit set and maximum size bit set.
+		 * Algorithm is from coreboot
+		 */
+		if (!addr_lsb || addr_lsb > size_msb)
+			mtrr_size = 1ull << size_msb;
+		else
+			mtrr_size = 1ull << addr_lsb;
+		log_debug("addr_lsb %x size_msb %x mtrr_size %llx\n",
+			  addr_lsb, size_msb, mtrr_size);
+
+		if (gd->arch.mtrr_req_count == MAX_MTRR_REQUESTS)
+			return -ENOSPC;
+		req = &gd->arch.mtrr_req[gd->arch.mtrr_req_count++];
+		req->type = type;
+		req->start = base;
+		req->size = mtrr_size;
+		log_debug("%d: type=%d, %08llx  %08llx ",
+			  gd->arch.mtrr_req_count - 1, req->type, req->start,
+			  req->size);
+		mask = mtrr_to_mask(req->size);
+		mask |= MTRR_PHYS_MASK_VALID;
+		log_debug("   %016llx %016llx\n", req->start | req->type, mask);
+
+		size -= mtrr_size;
+		base += mtrr_size;
+	}
 
 	return 0;
 }
-- 
2.43.0

