Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC41E77183
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 07:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89FC80283;
	Wed, 18 Dec 2024 08:03:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="znQFZu8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2649680214; Wed, 18 Dec 2024 08:03:15 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22F4802D5
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43618283dedso59196435e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 23:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734505392; x=1735110192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Frs6vrbQJHED/fo6teOSZmwleAgDavwt09hNJjrKkqQ=;
 b=znQFZu8TVTsGalB4XxygqGdl+jwgQe2lCfEQe57QuF6Eoli7UAoNFBrj12q5+y+2Ke
 CrBf9sdXCSNXOyZnkw0FJCYjEoJQ9gMuzGogtqyRsy1Kli4vJgRdLOef5u8pCBgxE1TM
 5IzFsddBeLArvYGAqR3GAIM3dFLD5pa0yc/jlS6D/ieeED2KldgmXFCbBU2ETGD+6BOK
 RXyrB43zAWjBQblamq73w6Pi1DJnIiLAIC8N9fIsay0UXDO4fkEyG2lFy/LHRZX3Selb
 JUcZ7+GIZT9s5m0Q6vPoBIm1xxMKRRbryCUnvWjj2f8JtWlTkopFbQJjvdyyz2WTxEIi
 cDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734505392; x=1735110192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Frs6vrbQJHED/fo6teOSZmwleAgDavwt09hNJjrKkqQ=;
 b=HsfYYAWGOiyZpyGzJSZ5Ekq7wgSQx+8OL3UBuJp/sEfFqUYzcCZZgCi9Pyxdg9/sLl
 +TA4oPac07X9KLJU6bt0Lv7frj1O088q37tc23lxJDISUgO+prnwjytLulhta4OJz/VX
 OvvCSh9U3rGKQiK9920IZMNMCulWpB+tVOXuLxs1LIUJzeuxQKfZ3MZ1hoseUsoJ7rPg
 bM93cxX8mnHxQK04KAIzUSxaU9wYQ0B43Eh6nSBAarow3zEEGLyigOfo6U/q3g6tVXnu
 ZQIrNS1sICpKaqEvx1Gm4tIBjonnVSRXglo0xzeM+ibKlIGj/BF+893I9+C2YPTSSpBR
 N7+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+s+fm/vpLEf4Xlbzt7Xh7mLdrovlfMFFflAnH8pwne9nyvNH4D7efpd3qJx3vqMPDpJNPYOo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+sTzS/xWCvLly3MOD8wEuxW5y0mcCBPVL9vBZLkadxBynddCt
 NrxHsVie6gErBR12rNO+5mbBYHltYEH2M6ks2NWd0/UCiizbBw2XIvA0YjQ4cZM=
X-Gm-Gg: ASbGncvdRKaFg9e1HwCO3yayagWV6UdRLy3vF0Fy7pSRHQ3+6QI4eHfT9cq69azSCoe
 90QUgRobXJA+pOue4sgMQ1/aYrvDwzL8HYg8w35+nGExhHG8MpvM02ysP2e0MfT+bW/Jo/eUwX8
 Pla1Vcn3B4IMiY6zzNqEZHYHxPWnYxXysuKKUy4A8P+OECs6Rogrxyz55Eph6bB1siNv/71nzfv
 BgMwYaNZOdqgBSxDz+lhW87MwDeFg0AKayFSLl8iSc+fxhoMV/WJPALzWM+eQhBN0abi3iDIsXL
 vduXFY10E2sjYp98aDM+1GZCDB6xHWO+zQ==
X-Google-Smtp-Source: AGHT+IHpefDRSmHUSPDCJxMENKgsyliAFPFC5TJPGnbEmWaJ13GyjL8Fqz8rpTeW2plJOy++YaTBlA==
X-Received: by 2002:a05:600c:511c:b0:434:a815:2b57 with SMTP id
 5b1f17b1804b1-436553ea6d7mr9714915e9.20.1734505392378; 
 Tue, 17 Dec 2024 23:03:12 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060592sm12971612f8f.98.2024.12.17.23.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:03:11 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Prasad Kummari <prasad.kummari@amd.com>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 4/8] lmb: Rename free_mem to available_mem
Date: Wed, 18 Dec 2024 09:02:33 +0200
Message-ID: <20241218070251.686383-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
References: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
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

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/lmb.h     |  4 ++--
 lib/lmb.c         | 34 +++++++++++++++++-----------------
 test/cmd/bdinfo.c |  2 +-
 test/lib/lmb.c    |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 3abe24deb56e..18030c610ab2 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -45,12 +45,12 @@ struct lmb_region {
 
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

