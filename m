Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDEDEE49B0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A60C864DD;
	Wed, 23 Aug 2023 15:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gSJIEGae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4796A864D3; Wed, 23 Aug 2023 15:42:23 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6FAB864C1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79241bb5807so72550339f.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692798139; x=1693402939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSzk/5ngIVrLaxGl1ng+aY3+mD32yAtdU3NWUYntb68=;
 b=gSJIEGaeHmbH/62RjNJpr1THr3onhYDXHy1nMOKI5wtgJZF7yBwQiKIBQwZgAQeRaX
 3c6GhZt//M3I63741ndJBz/Y3c8PTNqmlqsFCNpxpxBMcOOX553MQ81GSNXLNC148LpE
 q08lg24meoIixtKwfs1x1ZjdjETSqq7gyDdVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692798139; x=1693402939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SSzk/5ngIVrLaxGl1ng+aY3+mD32yAtdU3NWUYntb68=;
 b=HxU7eDdS4ZoPC33MjcbMDYjuBtZ8YCrO/mcrRAseV2lCVV2aDRsJpv4TEkRh22z2NF
 901Sf4vmPSya8jupuq3HL6z1l/1QoBCNsDQEpAPM7ENI4Hfe0Yvtgc9fKOUMsQV/jUEn
 Y4Vw8oLNYtvvdllg1CMGtslHvHRwy/E/b3TKVJP48WT91Mg9mhotlT2GDAV5BMJWdNBi
 hcXjHHUNdP3ScA9HNXOHXrTFjEoj85BstwbhvrOHaSiyL6XsSh5IGDcnG4o51khhHYHO
 MsxHam3UltgxZJzKnJTJKuNz607b3EtCXK9WwIFc5wQBMDYNZyZsrpPirfmFCJRU2YqA
 o/Fg==
X-Gm-Message-State: AOJu0YwzQ8EmRtC6z1FYepxcajYLZf9oDuHANiGtcbfRmoVIz4qkDW2r
 ANYwHRVIicHKuSewHX+MxQHmhHHSNB7UjRJYkm8=
X-Google-Smtp-Source: AGHT+IFlFrhpYbG+JtZBr1kNEKpbjpQTBTF0iEzZzEN1gKsdWHWQPz+SDFE8WcRQGcuA3Xw+2NXEpA==
X-Received: by 2002:a5e:8406:0:b0:783:5452:e343 with SMTP id
 h6-20020a5e8406000000b007835452e343mr2876991ioj.14.1692798139412; 
 Wed, 23 Aug 2023 06:42:19 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a02cdcd000000b0042b4f9ddecasm3800233jap.85.2023.08.23.06.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 06:42:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH 3/7] lmb: Avoid long for loop counters and function returns
Date: Wed, 23 Aug 2023 07:41:59 -0600
Message-ID: <20230823134209.1450567-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823134209.1450567-1-sjg@chromium.org>
References: <20230823134209.1450567-1-sjg@chromium.org>
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

Use int for loop counters since it is more common. Do the same with the
return value of some internal functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/lmb.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 8b9a611c5216..2f7b9f7f15fb 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -53,8 +53,8 @@ void lmb_dump_all(struct lmb *lmb)
 #endif
 }
 
-static long lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
-			      phys_addr_t base2, phys_size_t size2)
+static int lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
+			     phys_addr_t base2, phys_size_t size2)
 {
 	const phys_addr_t base1_end = base1 + size1 - 1;
 	const phys_addr_t base2_end = base2 + size2 - 1;
@@ -62,8 +62,8 @@ static long lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
 	return base1 <= base2_end && base2 <= base1_end;
 }
 
-static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
-			       phys_addr_t base2, phys_size_t size2)
+static int lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
+			      phys_addr_t base2, phys_size_t size2)
 {
 	if (base2 == base1 + size1)
 		return 1;
@@ -73,8 +73,7 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
 	return 0;
 }
 
-static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
-				 unsigned long r2)
+static int lmb_regions_adjacent(struct lmb_region *rgn, ulong r1, ulong r2)
 {
 	phys_addr_t base1 = rgn->region[r1].base;
 	phys_size_t size1 = rgn->region[r1].size;
@@ -86,7 +85,7 @@ static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
 
 static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
 {
-	unsigned long i;
+	uint i;
 
 	for (i = r; i < rgn->cnt - 1; i++)
 		rgn->region[i] = rgn->region[i + 1];
@@ -223,11 +222,11 @@ void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 }
 
 /* This routine called with relocation disabled. */
-static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
-				 phys_size_t size, enum lmb_flags flags)
+static int lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
+				phys_size_t size, enum lmb_flags flags)
 {
-	unsigned long coalesced = 0;
-	long adjacent, i;
+	uint coalesced = 0;
+	int adjacent, i;
 
 	if (rgn->cnt == 0) {
 		rgn->region[0].base = base;
@@ -310,8 +309,8 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 	return 0;
 }
 
-static long lmb_add_region(struct lmb_region *rgn, phys_addr_t base,
-			   phys_size_t size)
+static int lmb_add_region(struct lmb_region *rgn, phys_addr_t base,
+			  phys_size_t size)
 {
 	return lmb_add_region_flags(rgn, base, size, LMB_NONE);
 }
@@ -388,10 +387,10 @@ long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 	return lmb_reserve_flags(lmb, base, size, LMB_NONE);
 }
 
-static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
-				phys_size_t size)
+static int lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
+			       phys_size_t size)
 {
-	unsigned long i;
+	uint i;
 
 	for (i = 0; i < rgn->cnt; i++) {
 		phys_addr_t rgnbase = rgn->region[i].base;
@@ -430,7 +429,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 			     phys_addr_t max_addr)
 {
-	long i, rgn;
+	int i, rgn;
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
 
@@ -500,8 +499,7 @@ phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 /* Return number of bytes from a given address that are free */
 phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr)
 {
-	int i;
-	long rgn;
+	int i, rgn;
 
 	/* check if the requested address is in the memory regions */
 	rgn = lmb_overlaps_region(&lmb->memory, addr, 1);
-- 
2.42.0.rc1.204.g551eb34607-goog

