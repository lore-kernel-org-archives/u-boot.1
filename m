Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D471FC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D80B788842;
	Tue, 30 Jul 2024 16:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JxmnYhWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFA688892; Tue, 30 Jul 2024 16:40:46 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D96887B9
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f86fd9305so272006839f.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350442; x=1722955242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2yc1oEyZ42xTY+5fQqjLjl3n0Y8Qj58wG3Q+8p7Au8=;
 b=JxmnYhWA5l0jFEoCbtk45rHsqM8jWVLSFiniC/9bvcy3AMC0jTaWtTA9M9wijeONa0
 w1Jlz3uzHwMa9psEhDzZzUf/3cjGenEd0/MGteCYzrtBEk17smo4oe2tdDw3wCwY94/e
 aMujFrOoPipilHRW5Lfeo4doQ6OkBcw6ythyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350442; x=1722955242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2yc1oEyZ42xTY+5fQqjLjl3n0Y8Qj58wG3Q+8p7Au8=;
 b=Oe2kojvX1LCimMOZuLtsiJ7znwiySPEnZBJS33Ziwm169t7+/PoeRjjKQd13n2/iJx
 BFw26OtIsApg47ImlJBW7Bp4tvoa3dd4xWQoKQ/R1fTB+RNiETs4R7STSoGCjfaM/+Em
 rTWReX9glcGtrRKfouRj5gslpesLMFFQ39JtBjpn6mHl1Eb7vN+0lk1p0A+Ze8TngVbP
 0t77aD00DVSOiNzyA5iWsBid7/bYOuNnv7zrN7LIhhERUoZ102H+zkAV7tHpQbpY2BvY
 xUTAgNJ71JXy+svR/xZAfF2uTUAJ+L1JzopD2nbNPgb8k1OlqEmKgTDX1zGK4fIeCyrY
 uY0w==
X-Gm-Message-State: AOJu0YxzLtnY1mb4AJmgk5NTS0LzV2tchZ7njUHBDI01i1kUI2nolNHH
 ZWsCd2cVm6KpQ8NUBMAT2YiXEByT62O2DXvHGbsUJCkwR0ZGBK4o5ClcuRPMRug8chlM9OwS7Bw
 =
X-Google-Smtp-Source: AGHT+IE/Z9atKVhBk/bl4WMjKOUAVMQ4E3a0I64wiNOJjENQJ6FWxM65t5rpiCPexSoDboPlHhlECQ==
X-Received: by 2002:a05:6602:1648:b0:81f:958d:f575 with SMTP id
 ca18e2360f4ac-81f95c130damr1291375239f.14.1722350441965; 
 Tue, 30 Jul 2024 07:40:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa9338csm2714724173.39.2024.07.30.07.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:40:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
	Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH 1/4] lmb: Put internal details in a struct
Date: Tue, 30 Jul 2024 08:40:32 -0600
Message-Id: <20240730144035.3992996-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730144035.3992996-1-sjg@chromium.org>
References: <20240730144035.3992996-1-sjg@chromium.org>
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

Rather than exporting the internal details of lmb, create a struct which
holds the lists.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/lmb.h     | 10 ++++++++-
 lib/lmb.c         | 56 +++++++++++++++++++++++++----------------------
 test/cmd/bdinfo.c |  8 +++----
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 25a984e14f3..19231439c34 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -13,7 +13,13 @@
  * Copyright (C) 2001 Peter Bergner, IBM Corp.
  */
 
-struct alist;
+#include <alist.h>
+
+struct lmb {
+	struct alist free_mem;
+	struct alist used_mem;
+};
+
 
 /**
  * enum lmb_flags - definition of memory region attributes
@@ -121,6 +127,8 @@ int lmb_mem_regions_init(struct alist **mem_lst, struct alist **used_lst,
  */
 void lmb_mem_regions_uninit(struct alist *mem_lst, struct alist *used_lst);
 
+struct lmb *lmb_get(void);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_LMB_H */
diff --git a/lib/lmb.c b/lib/lmb.c
index 97ea26b013f..c11ce308c5b 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -24,8 +24,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define LMB_ALLOC_ANYWHERE	0
 #define LMB_ALIST_INITIAL_SIZE	4
 
-struct alist lmb_free_mem;
-struct alist lmb_used_mem;
+static struct lmb lmb;
 
 static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 {
@@ -50,8 +49,8 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 void lmb_dump_all_force(void)
 {
 	printf("lmb_dump_all:\n");
-	lmb_dump_region(&lmb_free_mem, "memory");
-	lmb_dump_region(&lmb_used_mem, "reserved");
+	lmb_dump_region(&lmb.free_mem, "memory");
+	lmb_dump_region(&lmb.used_mem, "reserved");
 }
 
 void lmb_dump_all(void)
@@ -499,7 +498,7 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 /* This routine may be called with relocation disabled. */
 long lmb_add(phys_addr_t base, phys_size_t size, uint flags)
 {
-	struct alist *lmb_rgn_lst = &lmb_free_mem;
+	struct alist *lmb_rgn_lst = &lmb.free_mem;
 
 	return lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
 }
@@ -507,7 +506,7 @@ long lmb_add(phys_addr_t base, phys_size_t size, uint flags)
 long lmb_free(phys_addr_t base, phys_size_t size, uint flags)
 {
 	struct lmb_region *rgn;
-	struct alist *lmb_rgn_lst = &lmb_used_mem;
+	struct alist *lmb_rgn_lst = &lmb.used_mem;
 	phys_addr_t rgnbegin, rgnend;
 	phys_addr_t end = base + size - 1;
 	int i;
@@ -557,7 +556,7 @@ long lmb_free(phys_addr_t base, phys_size_t size, uint flags)
 
 long lmb_reserve(phys_addr_t base, phys_size_t size, uint flags)
 {
-	struct alist *lmb_rgn_lst = &lmb_used_mem;
+	struct alist *lmb_rgn_lst = &lmb.used_mem;
 
 	return lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
 }
@@ -589,10 +588,10 @@ static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
 	long i, rgn;
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
-	struct lmb_region *lmb_used = lmb_used_mem.data;
-	struct lmb_region *lmb_memory = lmb_free_mem.data;
+	struct lmb_region *lmb_used = lmb.used_mem.data;
+	struct lmb_region *lmb_memory = lmb.free_mem.data;
 
-	for (i = lmb_free_mem.count - 1; i >= 0; i--) {
+	for (i = lmb.free_mem.count - 1; i >= 0; i--) {
 		phys_addr_t lmbbase = lmb_memory[i].base;
 		phys_size_t lmbsize = lmb_memory[i].size;
 
@@ -610,10 +609,10 @@ static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
 			continue;
 
 		while (base && lmbbase <= base) {
-			rgn = lmb_overlaps_region(&lmb_used_mem, base, size);
+			rgn = lmb_overlaps_region(&lmb.used_mem, base, size);
 			if (rgn < 0) {
 				/* This area isn't reserved, take it */
-				if (lmb_add_region_flags(&lmb_used_mem, base,
+				if (lmb_add_region_flags(&lmb.used_mem, base,
 							 size, flags) < 0)
 					return 0;
 				return base;
@@ -651,10 +650,10 @@ static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 				    enum lmb_flags flags)
 {
 	long rgn;
-	struct lmb_region *lmb_memory = lmb_free_mem.data;
+	struct lmb_region *lmb_memory = lmb.free_mem.data;
 
 	/* Check if the requested address is in one of the memory regions */
-	rgn = lmb_overlaps_region(&lmb_free_mem, base, size);
+	rgn = lmb_overlaps_region(&lmb.free_mem, base, size);
 	if (rgn >= 0) {
 		/*
 		 * Check if the requested end address is in the same memory
@@ -686,13 +685,13 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
 {
 	int i;
 	long rgn;
-	struct lmb_region *lmb_used = lmb_used_mem.data;
-	struct lmb_region *lmb_memory = lmb_free_mem.data;
+	struct lmb_region *lmb_used = lmb.used_mem.data;
+	struct lmb_region *lmb_memory = lmb.free_mem.data;
 
 	/* check if the requested address is in the memory regions */
-	rgn = lmb_overlaps_region(&lmb_free_mem, addr, 1);
+	rgn = lmb_overlaps_region(&lmb.free_mem, addr, 1);
 	if (rgn >= 0) {
-		for (i = 0; i < lmb_used_mem.count; i++) {
+		for (i = 0; i < lmb.used_mem.count; i++) {
 			if (addr < lmb_used[i].base) {
 				/* first reserved range > requested address */
 				return lmb_used[i].base - addr;
@@ -704,8 +703,8 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
 			}
 		}
 		/* if we come here: no reserved ranges above requested addr */
-		return lmb_memory[lmb_free_mem.count - 1].base +
-		       lmb_memory[lmb_free_mem.count - 1].size - addr;
+		return lmb_memory[lmb.free_mem.count - 1].base +
+		       lmb_memory[lmb.free_mem.count - 1].size - addr;
 	}
 	return 0;
 }
@@ -713,9 +712,9 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
 int lmb_is_reserved_flags(phys_addr_t addr, int flags)
 {
 	int i;
-	struct lmb_region *lmb_used = lmb_used_mem.data;
+	struct lmb_region *lmb_used = lmb.used_mem.data;
 
-	for (i = 0; i < lmb_used_mem.count; i++) {
+	for (i = 0; i < lmb.used_mem.count; i++) {
 		phys_addr_t upper = lmb_used[i].base +
 			lmb_used[i].size - 1;
 		if ((addr >= lmb_used[i].base) && (addr <= upper))
@@ -760,14 +759,14 @@ int lmb_mem_regions_init(struct alist **mem_lst, struct alist **used_lst,
 {
 	bool ret;
 
-	ret = alist_init(&lmb_free_mem, sizeof(struct lmb_region),
+	ret = alist_init(&lmb.free_mem, sizeof(struct lmb_region),
 			 (uint)LMB_ALIST_INITIAL_SIZE);
 	if (!ret) {
 		log_debug("Unable to initialise the list for LMB free memory\n");
 		return -1;
 	}
 
-	ret = alist_init(&lmb_used_mem, sizeof(struct lmb_region),
+	ret = alist_init(&lmb.used_mem, sizeof(struct lmb_region),
 			 (uint)LMB_ALIST_INITIAL_SIZE);
 	if (!ret) {
 		log_debug("Unable to initialise the list for LMB used memory\n");
@@ -775,10 +774,10 @@ int lmb_mem_regions_init(struct alist **mem_lst, struct alist **used_lst,
 	}
 
 	if (mem_lst)
-		*mem_lst = &lmb_free_mem;
+		*mem_lst = &lmb.free_mem;
 
 	if (used_lst)
-		*used_lst = &lmb_used_mem;
+		*used_lst = &lmb.used_mem;
 
 	if (!add_rsv_mem)
 		return 0;
@@ -829,3 +828,8 @@ int initr_lmb(void)
 
 	return ret;
 }
+
+struct lmb *lmb_get(void)
+{
+	return &lmb;
+}
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 3184aaf629f..e18e4701bbe 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -129,12 +129,12 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
 
 static int lmb_test_dump_all(struct unit_test_state *uts)
 {
-	extern struct alist lmb_free_mem;
-	extern struct alist lmb_used_mem;
+	struct lmb *lmb = lmb_get();
 
+	ut_assertnonnull(lmb);
 	ut_assert_nextline("lmb_dump_all:");
-	ut_assertok(lmb_test_dump_region(uts, &lmb_free_mem, "memory"));
-	ut_assertok(lmb_test_dump_region(uts, &lmb_used_mem, "reserved"));
+	ut_assertok(lmb_test_dump_region(uts, &lmb->free_mem, "memory"));
+	ut_assertok(lmb_test_dump_region(uts, &lmb->used_mem, "reserved"));
 
 	return 0;
 }
-- 
2.34.1

