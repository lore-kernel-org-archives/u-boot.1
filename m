Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F6AD78326
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 14:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E80D88E33;
	Mon,  2 Dec 2024 15:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yh0/eDaD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DFFA8907B; Mon,  2 Dec 2024 15:42:52 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F5FD88DB1
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 15:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa5500f7a75so705176466b.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 06:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733150570; x=1733755370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jwtgzft/8b+dsoThc5yDF10gQJDvhmLN7o3EcONuJis=;
 b=yh0/eDaD13PJk7vqWI2p9h7heJS9me4SnEY2eN7bKymYCjNElV2gh1lV5DdMnMTNIz
 yKCAfVZUypgoAi8uWpHYXdi4H8llF+LJCnn/v0vuaOMa27T2fw57VbiQ+BYbaP06kxqw
 AfbzxUl9+7aTefTV4SneFdw+pL2NlkBZvkjika3/nH3ou8iFCRX7ymUhqMb9h+d1Gq7r
 YHKQh56VLgdv8NiV4gVNEe6VKHj2kjpQFn4V780epNHRlLEKpmMozQY2OtZ5fNWKdMGF
 Z7+mELhatqxDSgxoaxCVthoiy3aDiAkbbx+Rm3cyu3nWEFlnrKBKwjJkTo1xkGpM5s7W
 Wnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733150570; x=1733755370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jwtgzft/8b+dsoThc5yDF10gQJDvhmLN7o3EcONuJis=;
 b=tlzZBuU7Bm9kWBISagr/npMDaAZ5Xka/ScoCMPUSgNyN1sHzBqBG3FYNuwDtMO5Ux4
 M5rOx5Yf2/oLGL11ajtnzfYYLvUO4Ekmzt7QGWxn2xzYCytGFLxpXsEzPsxSG9m2GbDo
 e6FH+VTuNO71yYHLJyVQ9S5nUnVAeWsJpy6VxEXzriHFLQqy8D+Jjaz1GBUqmXEx1Tc/
 HkXrbpmaC9l1be/fb19nCgp5KJF6S9Ui/Zi1H0JRof52AIFYsNXrYzhNfxrHnHdqywgX
 fM6wq/tZCt4lCUHrEhoS3s9t4GOokbGQAg6UBvXlCYeVHae6NWgZVPh07YD1A/k6qnAu
 Fx0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyzcuboT5EoqMUZRc6hcwfOmtoDa42W4NkST33BVb8XAPoiCDtIzIT7L6gwVEf+Y4S0eImLGE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxrtz7xF/A4BnOpItutjnTcMQnVcrrM2+EuowCDV24W3QO6XU+r
 wA45cotmvMQBkZ/W7T+c1s1UMyugscj3aKpqZLcfBybxCyjjUSVa3rasT4OIzkw=
X-Gm-Gg: ASbGncsD8OjoUKyv1ghFPJXB1lFA1w90mFHnk4Q9XV53gGM8mvVCbEqWm/YWOW5xSMl
 9ceEAKcOrQuns85n40iITUDbJkbtoLBcIEHe4nQEUt0ztj6k2RtFvuBRp933jd7Imnw9BZSadtL
 xkGrRq1HNwsciSSMij7icSOcu5OtQ2hhevwFDBBSHTep2TSUUhRked9LAEWC4o0xFE42K8kf+bo
 5t19ZIYNmQdfUTapWMBMCRIQfSwdCvyGqOwa8DD05xlKUdCpCNRoBdVIUNq0hmbreNRTGgHyous
 g49VFmtgv+iGePxO3Jw1qxdQN/4=
X-Google-Smtp-Source: AGHT+IEGu1D6/QLN5yySaY/KmbwzcCwjK5jxIo1D1NaH0OWuStqbRUTzU61KyI6OCf5fQrDBcUAq3A==
X-Received: by 2002:a17:906:3114:b0:aa5:427e:6af6 with SMTP id
 a640c23a62f3a-aa580ef3240mr1775630466b.3.1733150569773; 
 Mon, 02 Dec 2024 06:42:49 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e6dadsm516921066b.132.2024.12.02.06.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 06:42:49 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2] lmb: Fix the allocation of overlapping memory areas with
 !LMB_NONE
Date: Mon,  2 Dec 2024 16:42:45 +0200
Message-ID: <20241202144246.877105-1-ilias.apalodimas@linaro.org>
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

At the moment the LMB allocator will return 'success' immediately on two
consecutive allocations if the second one is smaller and the flags match
without resizing the reserved area.

This is problematic for two reasons, first of all the new updated
allocation won't update the size and we end up holding more memory than
needed, but most importantly it breaks the EFI SCT tests since EFI
now allocates via LMB.

More specifically when EFI requests a specific address twice with the
EFI_ALLOCATE_ADDRESS flag set, the first allocation will succeed and
update the EFI memory map. Due to the LMB behavior the second allocation
will also succeed but the address ranges are already in the EFI memory
map due the first allocation. EFI will then fail to update the memory map,
returning EFI_OUT_OF_RESOURCES instead of EFI_NOT_FOUND which break EFI
conformance.

So let's remove the fast check with is problematic anyway and leave LMB
resize and calculate address properly. LMB will now
- try to resize the reservations for LMB_NONE
- return -1 if the memory is not LMB_NONE and already reserved

The LMB code needs some cleanup in that part, but since we are close to
2025.01 do the easy fix and plan to refactor it later.
Also update the dm tests with the new behavior.

Fixes: commit 22f2c9ed9f53 ("efi: memory: use the lmb API's for allocating and freeing memory")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- check for -1 instead of 0xffffffff in lmb_reserve_flags()
 lib/lmb.c      |  9 ---------
 test/lib/lmb.c | 22 +++++++++++++++++++++-
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 14b9b8466ff2..3a765c11bee6 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -201,15 +201,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 		phys_addr_t rgnbase = rgn[i].base;
 		phys_size_t rgnsize = rgn[i].size;
 		phys_size_t rgnflags = rgn[i].flags;
-		phys_addr_t end = base + size - 1;
-		phys_addr_t rgnend = rgnbase + rgnsize - 1;
-		if (rgnbase <= base && end <= rgnend) {
-			if (flags == rgnflags)
-				/* Already have this region, so we're done */
-				return 0;
-			else
-				return -1; /* regions with new flags */
-		}

 		ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
 		if (ret > 0) {
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index c917115b7b66..0bd29e2a4fe7 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -529,6 +529,26 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);

+	/* Try to allocate a page twice */
+	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
+	ut_asserteq(b, alloc_addr_a);
+	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
+	ut_asserteq(b, 0);
+	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
+	ut_asserteq(b, alloc_addr_a);
+	b = lmb_alloc_addr_flags(alloc_addr_a, 0x2000, LMB_NONE);
+	ut_asserteq(b, alloc_addr_a);
+	ret = lmb_free(alloc_addr_a, 0x2000);
+	ut_asserteq(ret, 0);
+	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
+	ut_asserteq(b, alloc_addr_a);
+	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
+	ut_asserteq(b, 0);
+	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
+	ut_asserteq(b, 0);
+	ret = lmb_free(alloc_addr_a, 0x1000);
+	ut_asserteq(ret, 0);
+
 	/*  reserve 3 blocks */
 	ret = lmb_reserve(alloc_addr_a, 0x10000);
 	ut_asserteq(ret, 0);
@@ -734,7 +754,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)

 	/* reserve again, same flag */
 	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
-	ut_asserteq(ret, 0);
+	ut_asserteq(ret, -1L);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);

--
2.45.2

