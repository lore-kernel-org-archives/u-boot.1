Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D450C021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AD8811AC;
	Tue, 25 Feb 2025 00:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SGstti1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA9281191; Tue, 25 Feb 2025 00:07:54 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2D2F80F91
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-855b3e42c5bso134260639f.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438467; x=1741043267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zlTpA+NowbbK8hKVkVO8N3taJOUmEAqquY1TETzvTg=;
 b=SGstti1N/GZ2zDbDJNsA+DG7+GSA9mS2fQxn0cZ4tsEZNYA6Wo8rkJ0yjdtHaZDkan
 XZANkFNF/ER7b5xgFMFnoREFh9MRV6r+GmsdZRZQBUk6rzud2g5Ux6hujDVE9SS+q/Au
 7l/eirXDbf6pN3RgfjDupJJG5MIhd2DK+EiJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438467; x=1741043267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zlTpA+NowbbK8hKVkVO8N3taJOUmEAqquY1TETzvTg=;
 b=Pwfz7sfWb8TrMAf4SHYBisQ3ka7IGh3WgZU6DKCZ2qL9ONJqZSYRJUSEvjLgGIFOzD
 EsF7AOnJM8bnMYv2gTR+gaRhYIsV/yAcqSZvZGwVhlZkAdhYVTx+nRVMzQ5xnfJofrqF
 +yWv/2Koh0Ym5oCqXzMYJdG7sH94/fPgSze8rQ+Qky2GOXig1ru3wZuXVZdZtbat8W1r
 rrgQ1l/uxfmaC0UdsC1CBybOkZb6FfRB5rPJeqpdE3tsZTzjccuc2bKcZRlvqdjNkTt3
 gY+SE9XKIEEwXLTDfN0e8V0fUJSlPEd0HSMMsbrfyC2VQrN3rH3bwE54GVM4NCT8hoNy
 9ZWg==
X-Gm-Message-State: AOJu0YyKPfEIN5yXdosapv+ZaeDFEF7TV/yTZzrBXzvKkjNlSKbHS06j
 r2jmRK+UVhLzYjEzRXElpR+oAeOFDTtw8+Cmho0Os4S7jiBdi5vl+7kP3ZqOMtWQxBL3cfXiuss
 =
X-Gm-Gg: ASbGncsVgSrx/vBLgF0E3J/CBsDWFWjI/DVlUYwkX+e9xU3IFNczqWbU8LfxkH10+u0
 sUw0z1AlN/exFyrt5L/CpuvA+CdFd8+LJSLwZCwmrpIEhL1EFTu3YQgNuFxgXwY2qmWsd+EvcW+
 xyW1SMpjmeBeS0D9IFCaRuJmZz2kFrrvm7A/GXZ+7al+EYHPyHAF3cHDRgm9PasjNeBwRUgKWtl
 ZsKq+mlgpR+V81rToEldP2bn1AYHhwvSYS3Oi0sB6B2JEwqLtOYI+yLhBW69cgTS1czHwo1c/Y4
 TG4BkvTDBQzV74IHbF0SlBiW6a8AANiVHvE0qKBC5DZTX1zIQPTlhRnqORD4tbw=
X-Google-Smtp-Source: AGHT+IFSWau1ORAR815p8Cn7Hg9uIt5EnvJfjYyOtKyfLbQyKcErAXIvAHEaa8uBOoFi3RB1bf/OEw==
X-Received: by 2002:a05:6602:2d84:b0:855:a437:1419 with SMTP id
 ca18e2360f4ac-8562014720amr164920139f.6.1740438466870; 
 Mon, 24 Feb 2025 15:07:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 24/44] x86: Allow adding non-aligned size for MTRR
Date: Mon, 24 Feb 2025 16:06:13 -0700
Message-ID: <20250224230640.2665206-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

