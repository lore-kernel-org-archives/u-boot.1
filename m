Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38D8C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F8D81BC5;
	Thu,  6 Mar 2025 17:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aIM1FosJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3938181BC5; Thu,  6 Mar 2025 17:05:48 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38DD81B5C
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3ce886a2d5bso6165465ab.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277143; x=1741881943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljuEbntwSke4RycMWy7nA071gIuHTO7yywjsMUps4Mg=;
 b=aIM1FosJj31z7RDc1SGdBtZHMKvjPY7l8vCLy6S4HtEFZwt5UnPr8N1YAKHojWHgS+
 z/RIYkWaGK/2UV31RXw/QmwNEDsaZVOdQrovfzVu1MTu/G9EqYt31BOIbIZWJcv1obiP
 HG6S1wi1AzoTERvGX8FAL63GLJBnRFYOxQwbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277143; x=1741881943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljuEbntwSke4RycMWy7nA071gIuHTO7yywjsMUps4Mg=;
 b=DfI14qbhQU0lcE6RYpnacui1hmlbU7yywI0LqYraGd1HG+ux2Fi7+IraOlK+FWkGiC
 OLFYuP/IRqIkRGvIgVpKUvzLxL31Fiu6BSTMHgufTnncuBXY8TfdqDJld7B2L3ZrLrFv
 PC3LVr8Qd7l8qd3VTEXTvOYaikYh8I1TpLm1jKB4R7IHxF0skQoRoISke7ZaoTn/vfw4
 TdP/9wmTaN2FSH70mzGIovtLwfVtpYGWbyw9f1j2to0FCB1hD40yCBl9q/KKHUBHsg5Y
 PpUgdWlSdYiKVoLOzf98209pFJOA7C1SEp+AYAygpSch0exgh/PnWo0tHcQVQQtans+Z
 grHQ==
X-Gm-Message-State: AOJu0YyjCwxuxenToMsajsbtTgXaqfWNfmyGxXts7wKkWgmVVjfS5MZm
 CnnXS2yDeJL0G8h8szavo+lFJ/OJ5YkYQj4sLHqv7Dapwpe0dOJ5kxkYEUwTuPXjUZ0BWhoAS5g
 =
X-Gm-Gg: ASbGncvR7dmlwy/yC8XUaTjHpVfOVXHS1Z4IkqGvcAeGgyvo9Cpz7/hEWNBIYqwbWa0
 sAqqllgobaed20ubDdwykwQHM2/p9VD3rTkadXkna0hiuYawhiTYtZIy7nJ7LACdTbdnDkScWhB
 iYJhge7IDD8zhwwvJcpT+qTaGq+x5uiVYpi07iSJaj/4+COk4/uF3WXk6vFWLdn7aQ/xpIhfrq2
 1v2DWaCJLB0qZr+UgZfUCsU7hcrGEgNE+FX6GGf8eCdbHT2mdVpbU//29jMBHCMMZkHzmzOEh8A
 lIINNMuDthxdsfjub+5HSJXWueOyuR8U9oRttR/knxEa1tYHwlHijdPQQeqosUws+Rm9d9Zc9A9
 yclpARA==
X-Google-Smtp-Source: AGHT+IHZ6D8OfDil7y/wDegIm3DVuPZVq4LenDxxPGDIzMsA8xNGytx12/NgTkOkRxdvkhVix14O1Q==
X-Received: by 2002:a05:6e02:1c0e:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3d44195797bmr359425ab.18.1741277142941; 
 Thu, 06 Mar 2025 08:05:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 26/47] x86: Allow adding non-aligned size for MTRR
Date: Thu,  6 Mar 2025 09:03:53 -0700
Message-ID: <20250306160428.3041057-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

