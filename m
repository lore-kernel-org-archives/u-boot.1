Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44900D690FF
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 11:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 817C289883;
	Thu, 28 Nov 2024 12:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X4Hy1V43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D88897FE; Thu, 28 Nov 2024 12:49:35 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2979F897FE
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 12:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso89495766b.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 03:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732794573; x=1733399373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AjqH4lh14P3LTadLTyd2N7C/7mpT08+VMwjBJq93rdU=;
 b=X4Hy1V43CKjeL701ZgJe5bEgDzERBDcxqyr7q1aHdk5U9eDafyF3+mDifnHb+76J6f
 DoYynswrZ7bk1Tw0fl03JcmgwdIM3Q67q5vVhiq4vuYzgnorY5EJngny05Ho/PuWMY+J
 7I++SPuJ2AoEX6KlMtO6BCkXisnQAItx7VTv3uiyz/+bMRwyKBvSrx7Doc6uGVqpOjN7
 FijPinCoAV84KMm4V4vqj8pAoaZXfOLhiHaik79xBuot2RQDhsY8ciBW0Xi2XyjT649u
 7Dz3vahHsCYteSatsHTayvrlXPey7qS83RRhHt2/O23FBUq1szCNSTdTo3HOelIbxfUk
 MX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732794573; x=1733399373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AjqH4lh14P3LTadLTyd2N7C/7mpT08+VMwjBJq93rdU=;
 b=wxzgOj11+kGluOkqH0QgkxzIwReNJgr0zMUVBYI7K1NcHJh+miuenxnZ8NUmnBJqA7
 nDmDBUm3t6R5u1CNNNVkd4v3TXIOYKJ3wGaCO9vXnthHG+CcagGRIa288cFZOXtTtaTN
 b6/5AgjIK2s8x5PKHGeBmvpD3O3Rjxxed+e2ShTaSj7bSLmRXEZSvlXPceGtHytEa8Tw
 GaPjfOMmoCneliQKM8MBXQy7j+voVmI6WqmFqYq+4Ylp8+wywwb2m3M1xx1ucB52WeMu
 TzH3UpQ65hhLrhrna5joNdsGB9/qXPkWJmGmpMeGjffDINjIrkqxvLJbm5uRkEKkPgf1
 eSTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlKvowTQgUzk1BolKiHtc0kFU1STDULnDnUKaHuiRaYE0f2zf0E0cHzj8xkM4+faN0Ot7QSHI=@lists.denx.de
X-Gm-Message-State: AOJu0YxzD6o/0wcn8Ddx3xUcyx9jSPLpxAEkmnuc0K40l1ITztInScuQ
 o4N16SdKbOzs1Kr5NcGlqft+06IaltPMzPCtV1BmVfNlb/LOBX8TdHyOUrz3TUU=
X-Gm-Gg: ASbGncvTOJI/Kv1QRIzl5xuVIc2rwGOikSEnbli27qXFHUPGO0G8wshzb5grUp5VttY
 lJYEka5JAF/iPUVAKjMtty2By7/YCj02GQZGZEceBl607voSt10jzGqWE32phyrnWox//Xa+Xbo
 LExcQOpmGA0mzasH26q7+anQ3XRtA9XueDONDNALFz9nVNajHbpLjOGxYJMPDfxwUSMpqa/+hVR
 qe7xLHSCzeMtN4FzMhuKxFfmkAuEuBvRBFW1dBMOykdV1NNDcrXNELQTrylyZC7SbRJGqIo/+5P
 Yp1vVDG+ejikuCiaXEVnjPuC0Q==
X-Google-Smtp-Source: AGHT+IHeLcVxj8Ody3Vwy5r9qiptxZLPQ6I7kPowCcsuOD4u7kD95iwILoky2qqaq7HuHNi44dqouw==
X-Received: by 2002:a17:906:3d21:b0:aa5:3fa9:e90c with SMTP id
 a640c23a62f3a-aa580f56c51mr478561866b.32.1732794572570; 
 Thu, 28 Nov 2024 03:49:32 -0800 (PST)
Received: from localhost.localdomain (ppp089210064034.access.hol.gr.
 [89.210.64.34]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e69dfsm59047766b.122.2024.11.28.03.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 03:49:32 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] lmb: Fix the allocation of overlapping memory areas with
 !LMB_NONE
Date: Thu, 28 Nov 2024 13:49:26 +0200
Message-ID: <20241128114926.458728-1-ilias.apalodimas@linaro.org>
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

Fixes: commit 22f2c9ed9f53 ("efi: memory: use the LMB API's for allocating and freeing memory")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
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
index c917115b7b66..bc44dd21192f 100644
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
+	ut_asserteq(ret, 0xffffffff);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
-- 
2.45.2

