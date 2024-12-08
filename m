Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D303EE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 10:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2648954B;
	Sun,  8 Dec 2024 11:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fNFRNDaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6784893BF; Sun,  8 Dec 2024 11:52:51 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F59895A4
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 11:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3f249f3b2so460159a12.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 02:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733655169; x=1734259969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+pW5tMGIgPYQo5r7DA3jKbiS3JPJXBp8guvFqijUCI=;
 b=fNFRNDaSO9O5UHTLwNfzz/Y8CyisFPiG2rOnOXbTG+BIz27VxGUNhRvLuvag+BFtro
 YW3T9wHCFrLutXJEhUn95bTGKoAh9T0lL+q+SNCgzAnH1hMd83JUHtZv5bUcN2wFPrSl
 TcU3l4HsfTCGHje9tPYqGzjV0Tqdt1qqeaZJAKI2IJx74fvn/amzBw8nyJ6biTpxBlQb
 gUtSyJ7AUlp3ImWJ6IMQ/nQGPUJWuCd9kkf3lzaazwH6MpylqIDdwQc+RbxRbmo3rzDg
 LBdcWfV3ke1mwyyrtQBMjcl7RAEiiFuzG90DBia1z/m/mOmIk0xUKe9GwpWEkyiP/HZL
 QjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733655169; x=1734259969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+pW5tMGIgPYQo5r7DA3jKbiS3JPJXBp8guvFqijUCI=;
 b=KjKYQC2xRkep7QvIaZww8W98TV2nJUejEjQT9ooxYrI1cz9cslDeobme3pEwYqVruZ
 UXz67okdq8n8Tn1a1Vd68FnzSunTFgi46GiVECj8M8Bu80AD2ykAK30/koeiEiTxsJu2
 vasVO3CwcJ0G7+wee9wTqE38jAzqrX9C2mvuzOVBcatLw4aWH6SumapgU9DZ24a0FlJH
 fh1+Xiu9F5Cre9fWS79rAYmo3E0tMCA7eMUbCo4HWaPJfnVJ/bD1B46cxryBgURb2a8S
 8+ksWfO88syFxQsjwFUYfwmHoxdkvce0/nX5a1WLTOP49P6gCawEiWWeV08PoC4sNFnz
 8ezg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgAJWp/zcarVMBkzde6+aw4ev28Up9X2y4TMcSHrZ6QJtEtOV7ggxfO+8RjaWrmBYpcsnj/+4=@lists.denx.de
X-Gm-Message-State: AOJu0YxKRWcE12Sm94xr9/7VPpV4tTQUQqFuhYkePcKZD5sfWURhRkd4
 //OafCHQXLPFV5Evv6kb+UZE9rXvfj/eA7Otjs/RWqYCUKKcqYLw1SsvMK7Y09A=
X-Gm-Gg: ASbGnctrYDd6BSIGuYPdazIMd7kGOa4lgl3kMk+9bSylOB6XClqI0AzCyP6Yugkgv+2
 T4ZrRNIxkrUUtD+o95gRRBWqEE1/B1Knp72i2k697iqLqC424PrC78Sq8/i7lXRJwpcLA4bZ1ro
 +NXXDwNWBV1ZXXFpTByydShq+tVyoDjRK3fgb5TpKFLWjD7S+G254xGU0WSVz8qupNDpMRAdfgT
 dFIa8YORnT1vlD2riPUaOSE6gqpcJW1V6F6hWUs3Z5jbnwU9lh1S1hipwKJ1hXNgxCMjxvzXl4d
 +SsMSIo1Sc1x7hzMJDDTwCvvEtg=
X-Google-Smtp-Source: AGHT+IFqLVT9nS7BcancllPu815h3siMaEOBONbwO9UHqVFLoyLFKr4zINCgnL+VPGT5qAMa22DggA==
X-Received: by 2002:a05:6402:915:b0:5d0:d818:559d with SMTP id
 4fb4d7f45d1cf-5d3be6801a6mr25297877a12.11.1733655168966; 
 Sun, 08 Dec 2024 02:52:48 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e92fe3sm517768566b.51.2024.12.08.02.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 02:52:48 -0800 (PST)
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
 Baruch Siach <baruch@tkos.co.il>, Nam Cao <namcao@linutronix.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [RFC PATCH 3/7] lmb: Rename free_mem to available_mem
Date: Sun,  8 Dec 2024 12:52:06 +0200
Message-ID: <20241208105223.2821049-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
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

free_mem is a misnomer. We never update that with the actual free
memory. Instead this field describes all available memory and it's
checked against used_mem to decide if a memory area is free or not.
So rename it to something that better describes its usage.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/lmb.h     |  4 ++--
 lib/lmb.c         | 34 +++++++++++++++++-----------------
 test/cmd/bdinfo.c |  2 +-
 test/lib/lmb.c    |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 62882464f866..54af5b0e4b44 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -47,12 +47,12 @@ struct lmb_region {
 /**
  * struct lmb - The LMB structure
  *
- * @free_mem:	List of free memory regions
+ * @free_mem:	List of all available memory
  * @used_mem:	List of used/reserved memory regions
  * @test:	Is structure being used for LMB tests
  */
 struct lmb {
-	struct alist free_mem;
+	struct alist available_mem;
 	struct alist used_mem;
 	bool test;
 };
diff --git a/lib/lmb.c b/lib/lmb.c
index c7bf5120696f..ffdd23d87b9b 100644
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

@@ -514,7 +514,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 void lmb_dump_all_force(void)
 {
 	printf("lmb_dump_all:\n");
-	lmb_dump_region(&lmb.free_mem, "memory");
+	lmb_dump_region(&lmb.available_mem, "memory");
 	lmb_dump_region(&lmb.used_mem, "reserved");
 }

@@ -650,7 +650,7 @@ static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 long lmb_add(phys_addr_t base, phys_size_t size)
 {
 	long ret;
-	struct alist *lmb_rgn_lst = &lmb.free_mem;
+	struct alist *lmb_rgn_lst = &lmb.available_mem;

 	ret = lmb_add_region(lmb_rgn_lst, base, size);
 	if (ret)
@@ -706,9 +706,9 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
 	struct lmb_region *lmb_used = lmb.used_mem.data;
-	struct lmb_region *lmb_memory = lmb.free_mem.data;
+	struct lmb_region *lmb_memory = lmb.available_mem.data;

-	for (i = lmb.free_mem.count - 1; i >= 0; i--) {
+	for (i = lmb.available_mem.count - 1; i >= 0; i--) {
 		phys_addr_t lmbbase = lmb_memory[i].base;
 		phys_size_t lmbsize = lmb_memory[i].size;

@@ -800,10 +800,10 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 				    enum lmb_flags flags)
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
@@ -854,10 +854,10 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
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
@@ -871,8 +871,8 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
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
@@ -895,7 +895,7 @@ static int lmb_setup(bool test)
 {
 	bool ret;

-	ret = alist_init(&lmb.free_mem, sizeof(struct lmb_region),
+	ret = alist_init(&lmb.available_mem, sizeof(struct lmb_region),
 			 (uint)LMB_ALIST_INITIAL_SIZE);
 	if (!ret) {
 		log_debug("Unable to initialise the list for LMB free memory\n");
@@ -967,7 +967,7 @@ int lmb_push(struct lmb *store)

 void lmb_pop(struct lmb *store)
 {
-	alist_uninit(&lmb.free_mem);
+	alist_uninit(&lmb.available_mem);
 	alist_uninit(&lmb.used_mem);
 	lmb = *store;
 }
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index bb419ab2394e..e5b422ab2ba8 100644
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
index 8af5dcad2ecc..0f7052224c10 100644
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

