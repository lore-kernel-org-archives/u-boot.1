Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA596E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 10:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9EC88023C;
	Wed, 11 Dec 2024 11:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LKTvaQT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252CA80239; Wed, 11 Dec 2024 11:55:27 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D5828021C
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 11:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5cfa1ec3b94so8902782a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733914524; x=1734519324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQ66NDUUIlNQKPYo6heYWOWor1RBFYpFYyRBelWLCDQ=;
 b=LKTvaQT7LvYs8NOQ5dVcnHeDbAZJ+4u0sq1HRU+XZYLKwTWVHtwbtNyUe+hYfI0Tw3
 LLTWIPpisa+stFfmzfIqmecmx2ChhYsG7F/Wx0iFAV5R57VKr0eNfseX1dkWRzNP4xKN
 iJUaqs2KYUG9cnFejLI4AwdBIvefS3932BYzGWslsuxzF45TkwDOrSshuTRW7IzHyam/
 EMcYMlPd70QlHXbsI1Bg2duSNa7XqDZ6aqlBQ2eXXeoZoqvOJXF3WEw9vgfI6nVW0qKf
 EKzra/Hd2+uaSSn1i3cN45/hSK86r9ug7wYW4LiOl/SWNA4skJ6CvReJnGBLNpLA6+lh
 ib9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733914524; x=1734519324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQ66NDUUIlNQKPYo6heYWOWor1RBFYpFYyRBelWLCDQ=;
 b=K4IRPX563Vsv6JmomV+QHD/wWBqynSSi0qJo48jBwXniIed9Gwzn7T+BDuqdmF07Oc
 ijFp/7eCoVfSgyd4m223yRlg3gRW3ZytnnfcIGjdBcnvAHDxrjrEqJIh77KxrBWl1I4+
 EjpqhdEDfzt7ghSr66/j86gvSJNPRlIGNocggRWvc3cfuIxCEFDTLVV4zeFzR2NbIwgM
 Po9QizhWufinfjS2eEEVH+6GRWPyAtgj7DcKEN6lbMlB47PCjb3ka0hwLNO/7vuni+Yb
 DP7W7sNKOVUuU86ADvB4c0vMb3P61Cb3so9QsC3Im2RkzVLn0wosPDXZFTst23sxeyZ9
 hplQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTWY+NAJDhKDJ5Ils5+KLBwsxnt1zHjDYogq3Nj34NtOmJJW3+cVM02P0a3vKaxL7lw9h7bEs=@lists.denx.de
X-Gm-Message-State: AOJu0YwB31ospWH7Jm8/oxUyIN7sgbv9D2SUykUTcNiQ1G5p+oCfrSXU
 oBftXFI2ZuwkyzbrhDGVsIGxC+A1H7HsvoRr4qYoQosEMYvB16HuO9wrOQre/AA=
X-Gm-Gg: ASbGncscgGZHIT6q5Xdm7MenEgj7tLMKJ6UtLtL4wInCnh24kZx8L8/r5H3qu9A0Mwp
 m/hAbZeH9S6JjrxVvTkgsWJAJMtjN3UKzocphx0QFq6mzW1ObEaXhbPfEW/k1mIC2atuLzfnjD1
 h4dh6EyfENvC+UGZrlAYXgmPLp8wAvOkiO9IvW+U21ODfz0WcMQRicZOfelx9VCFa+zd5yYqJju
 Ak/ufzz9rdlWE99ei4lpzdZrF2lgDhm2YbOWKU9C36D8G1G21V/+yKELKl29u97XqUwoYtnrcvw
 +lL4EEViyESU+7GQJ/RV4XLLXX5w2AQ=
X-Google-Smtp-Source: AGHT+IGP5rhlnaarIgJyT7kBq19UvsoBhTyh5MRaZEYpp256rqIJvKnq8ReHqPKXi+iTtyraJBTKbw==
X-Received: by 2002:a17:907:9548:b0:aa6:748e:d20d with SMTP id
 a640c23a62f3a-aa6b12052c1mr184988266b.32.1733914524455; 
 Wed, 11 Dec 2024 02:55:24 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67e652b1dsm508006566b.172.2024.12.11.02.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 02:55:23 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Baruch Siach <baruch@tkos.co.il>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Nam Cao <namcao@linutronix.de>, Sam Protsenko <semen.protsenko@linaro.org>,
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1 4/8] lmb: Rename free_mem to available_mem
Date: Wed, 11 Dec 2024 12:54:45 +0200
Message-ID: <20241211105504.453234-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
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

free_mem is a misnomer. We never update it with the free memory for
LMB. Instead, it describes all available memory and is checked against
used_mem to decide whether an area is free or not.

So let's rename this field to better match its usage.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/lmb.h     |  4 ++--
 lib/lmb.c         | 34 +++++++++++++++++-----------------
 test/cmd/bdinfo.c |  2 +-
 test/lib/lmb.c    |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 9539cb67c3d7..3db35992df8d 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -43,12 +43,12 @@ struct lmb_region {
 
 /**
  * struct lmb - The LMB structure
- * @free_mem: List of free memory regions
+ * @available_mem: List of memory available to LMB
  * @used_mem: List of used/reserved memory regions
  * @test: Is structure being used for LMB tests
  */
 struct lmb {
-	struct alist free_mem;
+	struct alist available_mem;
 	struct alist used_mem;
 	bool test;
 };
diff --git a/lib/lmb.c b/lib/lmb.c
index fd0e91981ad4..da960e422ada 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -350,7 +350,7 @@ int io_lmb_setup(struct lmb *io_lmb)
 {
 	int ret;
 
-	ret = alist_init(&io_lmb->free_mem, sizeof(struct lmb_region),
+	ret = alist_init(&io_lmb->available_mem, sizeof(struct lmb_region),
 			 (uint)LMB_ALIST_INITIAL_SIZE);
 	if (!ret) {
 		log_debug("Unable to initialise the list for LMB free IOVA\n");
@@ -371,13 +371,13 @@ int io_lmb_setup(struct lmb *io_lmb)
 
 void io_lmb_teardown(struct lmb *io_lmb)
 {
-	alist_uninit(&io_lmb->free_mem);
+	alist_uninit(&io_lmb->available_mem);
 	alist_uninit(&io_lmb->used_mem);
 }
 
 long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
 {
-	return lmb_add_region_flags(&io_lmb->free_mem, base, size, LMB_NONE);
+	return lmb_add_region_flags(&io_lmb->available_mem, base, size, LMB_NONE);
 }
 
 /* derived and simplified from _lmb_alloc_base() */
@@ -387,9 +387,9 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align)
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
 	struct lmb_region *lmb_used = io_lmb->used_mem.data;
-	struct lmb_region *lmb_memory = io_lmb->free_mem.data;
+	struct lmb_region *lmb_memory = io_lmb->available_mem.data;
 
-	for (i = io_lmb->free_mem.count - 1; i >= 0; i--) {
+	for (i = io_lmb->available_mem.count - 1; i >= 0; i--) {
 		phys_addr_t lmbbase = lmb_memory[i].base;
 		phys_size_t lmbsize = lmb_memory[i].size;
 
@@ -515,7 +515,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 void lmb_dump_all_force(void)
 {
 	printf("lmb_dump_all:\n");
-	lmb_dump_region(&lmb.free_mem, "memory");
+	lmb_dump_region(&lmb.available_mem, "memory");
 	lmb_dump_region(&lmb.used_mem, "reserved");
 }
 
@@ -642,7 +642,7 @@ static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 long lmb_add(phys_addr_t base, phys_size_t size)
 {
 	long ret;
-	struct alist *lmb_rgn_lst = &lmb.free_mem;
+	struct alist *lmb_rgn_lst = &lmb.available_mem;
 
 	ret = lmb_add_region(lmb_rgn_lst, base, size);
 	if (ret)
@@ -688,9 +688,9 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
 	struct lmb_region *lmb_used = lmb.used_mem.data;
-	struct lmb_region *lmb_memory = lmb.free_mem.data;
+	struct lmb_region *lmb_memory = lmb.available_mem.data;
 
-	for (i = lmb.free_mem.count - 1; i >= 0; i--) {
+	for (i = lmb.available_mem.count - 1; i >= 0; i--) {
 		phys_addr_t lmbbase = lmb_memory[i].base;
 		phys_size_t lmbsize = lmb_memory[i].size;
 
@@ -771,10 +771,10 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 				   u32 flags)
 {
 	long rgn;
-	struct lmb_region *lmb_memory = lmb.free_mem.data;
+	struct lmb_region *lmb_memory = lmb.available_mem.data;
 
 	/* Check if the requested address is in one of the memory regions */
-	rgn = lmb_overlaps_region(&lmb.free_mem, base, size);
+	rgn = lmb_overlaps_region(&lmb.available_mem, base, size);
 	if (rgn >= 0) {
 		/*
 		 * Check if the requested end address is in the same memory
@@ -813,10 +813,10 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
 	int i;
 	long rgn;
 	struct lmb_region *lmb_used = lmb.used_mem.data;
-	struct lmb_region *lmb_memory = lmb.free_mem.data;
+	struct lmb_region *lmb_memory = lmb.available_mem.data;
 
 	/* check if the requested address is in the memory regions */
-	rgn = lmb_overlaps_region(&lmb.free_mem, addr, 1);
+	rgn = lmb_overlaps_region(&lmb.available_mem, addr, 1);
 	if (rgn >= 0) {
 		for (i = 0; i < lmb.used_mem.count; i++) {
 			if (addr < lmb_used[i].base) {
@@ -830,8 +830,8 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
 			}
 		}
 		/* if we come here: no reserved ranges above requested addr */
-		return lmb_memory[lmb.free_mem.count - 1].base +
-		       lmb_memory[lmb.free_mem.count - 1].size - addr;
+		return lmb_memory[lmb.available_mem.count - 1].base +
+		       lmb_memory[lmb.available_mem.count - 1].size - addr;
 	}
 	return 0;
 }
@@ -854,7 +854,7 @@ static int lmb_setup(bool test)
 {
 	bool ret;
 
-	ret = alist_init(&lmb.free_mem, sizeof(struct lmb_region),
+	ret = alist_init(&lmb.available_mem, sizeof(struct lmb_region),
 			 (uint)LMB_ALIST_INITIAL_SIZE);
 	if (!ret) {
 		log_debug("Unable to initialise the list for LMB free memory\n");
@@ -914,7 +914,7 @@ int lmb_push(struct lmb *store)
 
 void lmb_pop(struct lmb *store)
 {
-	alist_uninit(&lmb.free_mem);
+	alist_uninit(&lmb.available_mem);
 	alist_uninit(&lmb.used_mem);
 	lmb = *store;
 }
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 014391b38ac0..764294857082 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -131,7 +131,7 @@ static int lmb_test_dump_all(struct unit_test_state *uts)
 	struct lmb *lmb = lmb_get();
 
 	ut_assert_nextline("lmb_dump_all:");
-	ut_assertok(lmb_test_dump_region(uts, &lmb->free_mem, "memory"));
+	ut_assertok(lmb_test_dump_region(uts, &lmb->available_mem, "memory"));
 	ut_assertok(lmb_test_dump_region(uts, &lmb->used_mem, "reserved"));
 
 	return 0;
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 3c3e862ffa0e..6e870274fedb 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -65,7 +65,7 @@ static int setup_lmb_test(struct unit_test_state *uts, struct lmb *store,
 
 	ut_assertok(lmb_push(store));
 	lmb = lmb_get();
-	*mem_lstp = &lmb->free_mem;
+	*mem_lstp = &lmb->available_mem;
 	*used_lstp = &lmb->used_mem;
 
 	return 0;
-- 
2.45.2

