Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BB2E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 02:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D492B80200;
	Wed, 11 Dec 2024 03:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FqShcZ+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27EEB80214; Wed, 11 Dec 2024 03:17:09 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFB180207
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 03:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71deb2025dbso1562697a34.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733883425; x=1734488225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfT2oHWqRp0PVk8k7czp5K4KtbbiEK7iXob/kIGyjfQ=;
 b=FqShcZ+YAWMO7oVYj0r7jmZJlpRVAfY+EbaAOM5hh1H9F6PYq03BqhmNufIsBllFvM
 AYEZ2XqkDaXQzmJWv1wO5VcLUIypQh7ppPfZk2fCWr8jznV2PF+gwdLwwzr2DgA2IDpy
 wcqYSMJ2dPeQpnbyaQf/bHLFV3F5yBGQlTtnODfJdQDyeS2056F1R/U8IvlfWPBxwFeX
 YWT/nFcK1zNc5sIGuyozygnOcviT/j2XDqP4eym+t6v7LQbv+oLKPplBlEtIB54P0qZI
 7lL/48PRwPBLUOSFeXHzjHnC3Ts1KiDjlxK7Q1GQxjkiv5XaOkMBk3dx3QypblvDjSnW
 0u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733883425; x=1734488225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfT2oHWqRp0PVk8k7czp5K4KtbbiEK7iXob/kIGyjfQ=;
 b=R7NsYlGIjvQ5Yw3ks1vGIvAHI4H8r+chuax30bynicZXaQwc1DmJAo1GuNMiqbWUp4
 c8N+lav7JwrZAG/aIhcX7E1iyO2uGMEKQHqWRDiPQlbLQ3VA5A+KIr2j0BA1UT3zZF9t
 riuQzb6SJYvV9ftTiYWJ5MHZf9vE4VQ36BIs3nNmZvPFG3HdSEk9lUNCyAtvpPjxG0lf
 q0TrE1+ioUeVMf71/qnFtWG0q0KFFAfh9zewt6vCdE14hNM0JQgBq0BeXoEQSlPhNDtd
 IhOrUrXVmEJ+nMtRAWUUJk50prLT5mzaj2dh0/5PUaucQCEbIuLwkJt4RJP9cRqq/nIl
 XB8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCawwVir9Dft1P55jO5OBbORNZ2mkhOkI0NTqnmGsCGCwENCOplILBBomNTvhmnotMFwPEDIc=@lists.denx.de
X-Gm-Message-State: AOJu0YyPY9odHHnnkDpoBOcTmsoAe/V5v6tXjoBrtbeMXj7kzljsRhX1
 Qu8WHmV1YwLdna6v950LL+YnMdFuJbh33basBRg0R2F73hxlOFD4RA7ZEyadp/o=
X-Gm-Gg: ASbGncvLC4sV4B9IkqkWWB+EsM8LwTRcOPhA91tRGZQpY5YOoLGvXc1XFbnmeDTDzha
 CQPmfY78yb2+HQKZRyukJRpBUL30MF6a65sZ3HpMosWldeQfNFe/vvK86CbmZSApCmw6igR3Bn8
 iPyVfd+YUnd8CCpuaCyOCcWQiaElOTBXa48bSIQXddXg0PZ59gdWenHOOqcNgpD2QuGwFUPbbe6
 Mbh50kSmrhmNeuhi7Vdm+F7s0zS793wa7WBZcZCjtcKMK+Qvx4qk48UJzY=
X-Google-Smtp-Source: AGHT+IF8WdlvDOMsEhACs8tv+Ax8tQyacBVHVywsD+uS0wFthPZ9m84PpRm5EtPEde4DOukEoQ0pDw==
X-Received: by 2002:a05:6870:658d:b0:288:60d6:f183 with SMTP id
 586e51a60fabf-2a012f9ea1dmr790606fac.38.1733883425171; 
 Tue, 10 Dec 2024 18:17:05 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29fbee2df31sm1985912fac.13.2024.12.10.18.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 18:17:04 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/2] lmb: Return -EEXIST in lmb_add_region_flags() if
 region already added
Date: Tue, 10 Dec 2024 20:17:01 -0600
Message-Id: <20241211021703.2333-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211021703.2333-1-semen.protsenko@linaro.org>
References: <20241211021703.2333-1-semen.protsenko@linaro.org>
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

An attempt to add the already added LMB region using
lmb_add_region_flags() ends up in lmb_addrs_overlap() check, which
eventually leads to either returning 0 if 'flags' is LMB_NONE, or -1
otherwise. It makes it impossible for the user of this function to catch
the case when the region is already added and differentiate it from
regular errors. That in turn may lead to incorrect error handling in the
caller code, like reporting misleading errors or interrupting the normal
code path where it could be treated as the normal case. An example is
boot_fdt_reserve_region() function, which might be called twice (e.g.
during board startup in initr_lmb(), and then during 'booti' command
booting the OS), thus trying to reserve exactly the same memory regions
described in the device tree twice, which produces an error message on
second call.

Return -EEXIST error code in case when the added region exists and it's
not LMB_NONE; for LMB_NONE return 0, to conform to unit tests
(specifically test_alloc_addr() in test/lib/lmb.c) and the preferred
behavior described in commit 1d9aa4a283da ("lmb: Fix the allocation of
overlapping memory areas with !LMB_NONE"). The change of
lmb_add_region_flags() return values is described in the table below:

    Return case                        Pre-1d9   1d9    New
    -----------------------------------------------------------
    Added successfully                    0      0      0
    Failed to add                         -1     -1     -1
    Already added, flags == LMB_NONE      0      0      0
    Already added, flags != LMB_NONE      0      -1     -EEXIST

Rework all affected functions and their documentation. Also fix the
corresponding unit test which checks reserving the same region with the
same flags to account for the changed return value.

No functional change is intended (by this patch itself).

Fixes: 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory areas with !LMB_NONE")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Removed the check for exactly the same region, and return -EEXIST in
    the branch handling overlapping regions instead
  - Reworded the commit message accordingly

 lib/lmb.c      | 26 +++++++++++++-------------
 test/lib/lmb.c |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index b03237bc06cb..a695edf70dfa 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -183,8 +183,10 @@ static long lmb_resize_regions(struct alist *lmb_rgn_lst,
  * the function might resize an already existing region or coalesce two
  * adjacent regions.
  *
- *
- * Returns: 0 if the region addition successful, -1 on failure
+ * Return:
+ * * %0		- Added successfully, or it's already added (only if LMB_NONE)
+ * * %-EEXIST	- The region is already added, and flags != LMB_NONE
+ * * %-1	- Failure
  */
 static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 				 phys_size_t size, enum lmb_flags flags)
@@ -217,17 +219,15 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 			coalesced++;
 			break;
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
-			if (flags == LMB_NONE) {
-				ret = lmb_resize_regions(lmb_rgn_lst, i, base,
-							 size);
-				if (ret < 0)
-					return -1;
+			if (flags != LMB_NONE)
+				return -EEXIST;
 
-				coalesced++;
-				break;
-			} else {
+			ret = lmb_resize_regions(lmb_rgn_lst, i, base, size);
+			if (ret < 0)
 				return -1;
-			}
+
+			coalesced++;
+			break;
 		}
 	}
 
@@ -667,7 +667,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
  *
  * Free up a region of memory.
  *
- * Return: 0 if successful, -1 on failure
+ * Return: 0 if successful, negative error code on failure
  */
 long lmb_free_flags(phys_addr_t base, phys_size_t size,
 		    uint flags)
@@ -818,7 +818,7 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 				      lmb_memory[rgn].size,
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
-			if (lmb_reserve_flags(base, size, flags) >= 0)
+			if (!lmb_reserve_flags(base, size, flags))
 				return base;
 		}
 	}
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 0bd29e2a4fe7..48c3c966f8f2 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -754,7 +754,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 
 	/* reserve again, same flag */
 	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
-	ut_asserteq(ret, -1L);
+	ut_asserteq(ret, -EEXIST);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
-- 
2.39.5

