Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0B8E7717D
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 00:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36CCB894B8;
	Sun,  8 Dec 2024 01:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R59f8x1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9773E8947A; Sun,  8 Dec 2024 01:21:31 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C2A4893D1
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 01:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71de02b24cfso268328a34.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 16:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733617288; x=1734222088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNCKdtlKp7cJx6A6+2qRAeYNVZFHRjlYGRD8OJC8KOQ=;
 b=R59f8x1UANRQCCCTYxFLALdf9q+pKFNCcBwMUl1JB4x2r0iDW67pw93XdfVm9P611E
 eQlaZOc7+fzltsbHmKdk+Pti0wNgt0DgFROUs3U7MDWQUllib3MB/j+4imObfQpH5USj
 TxqYp/1zj0qJbNESBYawowrT7+7yXw25eVDpO1eFqxTAKNYJ6+DbnOBrl4ZPssxwDTxz
 /wJo/t51thcINWBVhFklEzggTfm0NHCWe+2td+6kpjq2nUuD1jzw/8ypP0QmJJAgS+rz
 CeeFFRmFEFtuVqsjV37XvTFKzWl5am47FWKFRxALkh+ZsvjNaqrSoeYult9I3mOrldRZ
 icjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733617288; x=1734222088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNCKdtlKp7cJx6A6+2qRAeYNVZFHRjlYGRD8OJC8KOQ=;
 b=Z3gtVxrtGhWeDuS2AFcSIhN717P+/7wr3uMm4Tp70sWZ36deANDwCI6uTl6uFqqMay
 itKbAC2T+FRCjqjUXtAoDT3hKox8gQ9KNANiMHWkLBxAs+Vwl8KGW3H7oIED0/iatYYT
 ufFksLduG3SakBjLgxLZTrQtIlUl8cvgn+2GZzIsQias/5LTsh6l1NkYI51MewxBM3bO
 GcuhFqZuQUJdZAPtHC2kRvs2oqL2vDdumCHg8rA6ppqAaJLEcjYqn+w/L2M8WLKFxRd4
 e5IHXQEd4gjJvM99ay2pde7lG8jG4YJe1RIsEOfqDdzhpXxt6MMpU2Eun6OFto+J01OO
 GuEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaMIo6krC08ZPqrcsGiZV9eZDc1+5rEdsmRvWPZ0q9CUFhiTGcAx3VDxed2CVFtFiPeXo7D7A=@lists.denx.de
X-Gm-Message-State: AOJu0YygqbbjqpTdijy9fr9AJWRl7OIjV3fo1n+ZZO7E+Ud3OGNJ6DMq
 Mnq2Np6morftNF6/Pm1HtEEeH862vhvfKqK3FnlRjQp5uDpMF/GNXnHLYW5ObVU=
X-Gm-Gg: ASbGncvLtnVURd2K8jlo93ZLmyG3c6fJKfBXgzluazVE0ZgWwX2Nm5DpuwXu2X+dY8h
 CbqaozihfFxSN7QKyZOnLHLchhBaJHVHzBEuW2aV8xikVt0rzYcz27xgYaIYRVGaZQT+QxxtkZA
 uigQaLIlyiHBhlOUcZPN/x87YavK2OSbvi2DjlZ9BibyPY880oNZ1U5Vh/CslXv5jBEsKNQDs8w
 kZSPQPdiVGW8hZPloqkTHzt/mcpsefhCQ+mTkcfEssPFbBV38oCxbo=
X-Google-Smtp-Source: AGHT+IFhNW1F32rATb6Zm4kFasahXc72JNAL1AwFitioNR3dR91NZX3RetR6gFZQXWy37fDzCYxALw==
X-Received: by 2002:a05:6870:d86:b0:29e:290f:7af4 with SMTP id
 586e51a60fabf-29f73860dcemr3991998fac.34.1733617288252; 
 Sat, 07 Dec 2024 16:21:28 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f7e411dafsm1161519fac.36.2024.12.07.16.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 16:21:27 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH 4/6] lmb: Improve coding style
Date: Sat,  7 Dec 2024 18:21:19 -0600
Message-Id: <20241208002121.31887-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208002121.31887-1-semen.protsenko@linaro.org>
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
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

Fix checkpatch warnings. No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 lib/lmb.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 1642ce48bbbd..8c1c9b0f67c8 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -57,7 +57,6 @@ static long lmb_regions_overlap(struct alist *lmb_rgn_lst, unsigned long r1,
 				unsigned long r2)
 {
 	struct lmb_region *rgn = lmb_rgn_lst->data;
-
 	phys_addr_t base1 = rgn[r1].base;
 	phys_size_t size1 = rgn[r1].size;
 	phys_addr_t base2 = rgn[r2].base;
@@ -70,11 +69,11 @@ static long lmb_regions_adjacent(struct alist *lmb_rgn_lst, unsigned long r1,
 				 unsigned long r2)
 {
 	struct lmb_region *rgn = lmb_rgn_lst->data;
-
 	phys_addr_t base1 = rgn[r1].base;
 	phys_size_t size1 = rgn[r1].size;
 	phys_addr_t base2 = rgn[r2].base;
 	phys_size_t size2 = rgn[r2].size;
+
 	return lmb_addrs_adjacent(base1, size1, base2, size2);
 }
 
@@ -235,9 +234,9 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 
 				coalesced++;
 				break;
-			} else {
-				return -1;
 			}
+
+			return -1;
 		}
 	}
 
@@ -288,14 +287,17 @@ static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
 	phys_addr_t end = base + size - 1;
 	int i;
 
-	rgnbegin = rgnend = 0; /* supress gcc warnings */
+	/* Suppress GCC warnings */
+	rgnbegin = 0;
+	rgnend = 0;
+
 	rgn = lmb_rgn_lst->data;
 	/* Find the region where (base, size) belongs to */
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		rgnbegin = rgn[i].base;
 		rgnend = rgnbegin + rgn[i].size - 1;
 
-		if ((rgnbegin <= base) && (end <= rgnend))
+		if (rgnbegin <= base && end <= rgnend)
 			break;
 	}
 
@@ -304,7 +306,7 @@ static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
 		return -1;
 
 	/* Check to see if we are removing entire region */
-	if ((rgnbegin == base) && (rgnend == end)) {
+	if (rgnbegin == base && rgnend == end) {
 		lmb_remove_region(lmb_rgn_lst, i);
 		return 0;
 	}
@@ -340,6 +342,7 @@ static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		phys_addr_t rgnbase = rgn[i].base;
 		phys_size_t rgnsize = rgn[i].size;
+
 		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
 			break;
 	}
@@ -715,7 +718,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size)
 }
 
 static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
-				    phys_addr_t max_addr, enum lmb_flags flags)
+				   phys_addr_t max_addr, enum lmb_flags flags)
 {
 	int ret;
 	long i, rgn;
@@ -730,16 +733,18 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 
 		if (lmbsize < size)
 			continue;
-		if (max_addr == LMB_ALLOC_ANYWHERE)
+
+		if (max_addr == LMB_ALLOC_ANYWHERE) {
 			base = lmb_align_down(lmbbase + lmbsize - size, align);
-		else if (lmbbase < max_addr) {
+		} else if (lmbbase < max_addr) {
 			base = lmbbase + lmbsize;
 			if (base < lmbbase)
 				base = -1;
 			base = min(base, max_addr);
 			base = lmb_align_down(base - size, align);
-		} else
+		} else {
 			continue;
+		}
 
 		while (base && lmbbase <= base) {
 			rgn = lmb_overlaps_region(&lmb.used_mem, base, size);
@@ -813,7 +818,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 }
 
 static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
-				    enum lmb_flags flags)
+				   enum lmb_flags flags)
 {
 	long rgn;
 	struct lmb_region *lmb_memory = lmb.free_mem.data;
-- 
2.39.5

