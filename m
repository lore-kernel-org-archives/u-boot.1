Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AF7E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 14:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CF9893C4;
	Sun,  8 Dec 2024 15:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GHIz08qR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E16E6894A7; Sun,  8 Dec 2024 15:30:57 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76CB1893BF
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 15:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6ef66a7ac14so39902227b3.0
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 06:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733668254; x=1734273054; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zXpfWxTIjSbuXEysyxzQsB74hSUkAGiyDSQbTrKfm2Q=;
 b=GHIz08qRwFUKe06eA2AS7bc+w4WGJV8oa16eJ1p93Tz1Vuxyyh1IyOJNA8J1wP8LPA
 p2I34o+hmEudvUhIzXdAhahReRXJ15Yo4p4yibYqyJgeJyx3Qs6/JY6Yl3zAkmfkMPl+
 cs+vNgAfxpgqF8Y7EIc9UKxxZR2sG5MCLaavmPZaHu+fwBJ/yqZja6Vd1R7wZGuaPqMf
 6QsPb13ZIxmRkHK2Zv41KRujD9dVzcmlNfNCrPNuE+5ZXXTxDzSOC4QjOs5TFbwZP+Hu
 0iio3s7IUySWEfDF8u9LFHt1vlR7sUlenA2yYrmg5S8LSSpZGF48UezVAhi2QP05Nyla
 ceFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733668254; x=1734273054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zXpfWxTIjSbuXEysyxzQsB74hSUkAGiyDSQbTrKfm2Q=;
 b=cc8xLfo39Ew2XXNLPWKh1c2By2UPaSTBQH3Py4gwD6fFobSkz5ZJJB8YthHmGdHZKN
 XzrJu8OYFpXwnW9b/hlTvJGspCOKQdLd1ywhWStw21ikG3Ds1l5xq8LaChRUt0eIQxjV
 6v+9EJOnln08bykxzLuRmHZyZHAHpBki25ZUrxUe2wai4yD43I+/WAUw9J+mWOJ7vcqj
 4acN3IWNVkiAcDJz52olOyBBRJnU1dzsHK5RqhScObglraWrBZpQh7zoLpwNjAT04LSf
 4sECQ3u14WhgNR9rw8iDr/e12uDh+OnEBcpGq4hBuG1EhUCLHhYCTRGXCsAqgFPeMYHc
 T+fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2oCjolc0FG+w/B9NkhEOw6yd8zw27ek7+zRoI4UZRGqtQdfkWZ4R/uaVsWykVtEXB2t12INg=@lists.denx.de
X-Gm-Message-State: AOJu0YzLCyqbLLHd4XVvo7njaSdzj5It9POZ9CyYO4krYhIcH/PprqZs
 RpGu4NbraYF+UqGnqXS70nTzpOGQebN/Gn0B8UFamr4fI8QkALOoZijFCnMzK9E5tFFvsnAU+nv
 zzpTqTIgfirmh6CPq74AgOgfzwGqUIghsMjBXKQ==
X-Gm-Gg: ASbGncuSTn5SB4g3W8KMpAOLy1HKDND9bNc7CHQvn1i5OFG3KGvDsj+fuGTnTST3rE+
 1bxLIJTYlkKBVTcvdhvnRBiMdilo+DgQ=
X-Google-Smtp-Source: AGHT+IH3LPu2fakC4RJrYDSsa4QqVrA1AVaUs8d5XMBDKCnV4DnVbdaTWLARRMJ34n3YXDn2I0HQemH1fQtncBFoOAg=
X-Received: by 2002:a05:690c:63c7:b0:6e2:451c:df02 with SMTP id
 00721157ae682-6efe393d10emr77326377b3.16.1733668254131; Sun, 08 Dec 2024
 06:30:54 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-4-ilias.apalodimas@linaro.org>
 <64AE6019-539C-4917-B6B1-96C65843F326@gmx.de>
In-Reply-To: <64AE6019-539C-4917-B6B1-96C65843F326@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 16:30:18 +0200
Message-ID: <CAC_iWjJVPC_-FQCZ33eijMK3TKDp961oN-N69AEqxND4VK+imA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] lmb: Rename free_mem to available_mem
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: trini@konsulko.com, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Baruch Siach <baruch@tkos.co.il>, 
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 8 Dec 2024 at 13:53, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 8. Dezember 2024 11:52:06 MEZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
> >free_mem is a misnomer. We never update that with the actual free
> >memory. Instead this field describes all available memory and it's
> >checked against used_mem to decide if a memory area is free or not.
> >So rename it to something that better describes its usage.
> >
> >Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >---
> > include/lmb.h     |  4 ++--
> > lib/lmb.c         | 34 +++++++++++++++++-----------------
> > test/cmd/bdinfo.c |  2 +-
> > test/lib/lmb.c    |  2 +-
> > 4 files changed, 21 insertions(+), 21 deletions(-)
> >
> >diff --git a/include/lmb.h b/include/lmb.h
> >index 62882464f866..54af5b0e4b44 100644
> >--- a/include/lmb.h
> >+++ b/include/lmb.h
> >@@ -47,12 +47,12 @@ struct lmb_region {
> > /**
> >  * struct lmb - The LMB structure
> >  *
> >- * @free_mem: List of free memory regions
> >+ * @free_mem: List of all available memory
>
> %s/free/available/

Sure, did you find anything else wrong with this patch?

Thanks
/Ilias
>
> >  * @used_mem: List of used/reserved memory regions
> >  * @test:     Is structure being used for LMB tests
> >  */
> > struct lmb {
> >-      struct alist free_mem;
> >+      struct alist available_mem;
> >       struct alist used_mem;
> >       bool test;
> > };
> >diff --git a/lib/lmb.c b/lib/lmb.c
> >index c7bf5120696f..ffdd23d87b9b 100644
> >--- a/lib/lmb.c
> >+++ b/lib/lmb.c
> >@@ -350,7 +350,7 @@ int io_lmb_setup(struct lmb *io_lmb)
> > {
> >       int ret;
> >
> >-      ret = alist_init(&io_lmb->free_mem, sizeof(struct lmb_region),
> >+      ret = alist_init(&io_lmb->available_mem, sizeof(struct lmb_region),
> >                        (uint)LMB_ALIST_INITIAL_SIZE);
> >       if (!ret) {
> >               log_debug("Unable to initialise the list for LMB free IOVA\n");
> >@@ -371,13 +371,13 @@ int io_lmb_setup(struct lmb *io_lmb)
> >
> > void io_lmb_teardown(struct lmb *io_lmb)
> > {
> >-      alist_uninit(&io_lmb->free_mem);
> >+      alist_uninit(&io_lmb->available_mem);
> >       alist_uninit(&io_lmb->used_mem);
> > }
> >
> > long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
> > {
> >-      return lmb_add_region_flags(&io_lmb->free_mem, base, size, LMB_NONE);
> >+      return lmb_add_region_flags(&io_lmb->available_mem, base, size, LMB_NONE);
> > }
> >
> > /* derived and simplified from _lmb_alloc_base() */
> >@@ -387,9 +387,9 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align)
> >       phys_addr_t base = 0;
> >       phys_addr_t res_base;
> >       struct lmb_region *lmb_used = io_lmb->used_mem.data;
> >-      struct lmb_region *lmb_memory = io_lmb->free_mem.data;
> >+      struct lmb_region *lmb_memory = io_lmb->available_mem.data;
> >
> >-      for (i = io_lmb->free_mem.count - 1; i >= 0; i--) {
> >+      for (i = io_lmb->available_mem.count - 1; i >= 0; i--) {
> >               phys_addr_t lmbbase = lmb_memory[i].base;
> >               phys_size_t lmbsize = lmb_memory[i].size;
> >
> >@@ -514,7 +514,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
> > void lmb_dump_all_force(void)
> > {
> >       printf("lmb_dump_all:\n");
> >-      lmb_dump_region(&lmb.free_mem, "memory");
> >+      lmb_dump_region(&lmb.available_mem, "memory");
> >       lmb_dump_region(&lmb.used_mem, "reserved");
> > }
> >
> >@@ -650,7 +650,7 @@ static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
> > long lmb_add(phys_addr_t base, phys_size_t size)
> > {
> >       long ret;
> >-      struct alist *lmb_rgn_lst = &lmb.free_mem;
> >+      struct alist *lmb_rgn_lst = &lmb.available_mem;
> >
> >       ret = lmb_add_region(lmb_rgn_lst, base, size);
> >       if (ret)
> >@@ -706,9 +706,9 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
> >       phys_addr_t base = 0;
> >       phys_addr_t res_base;
> >       struct lmb_region *lmb_used = lmb.used_mem.data;
> >-      struct lmb_region *lmb_memory = lmb.free_mem.data;
> >+      struct lmb_region *lmb_memory = lmb.available_mem.data;
> >
> >-      for (i = lmb.free_mem.count - 1; i >= 0; i--) {
> >+      for (i = lmb.available_mem.count - 1; i >= 0; i--) {
> >               phys_addr_t lmbbase = lmb_memory[i].base;
> >               phys_size_t lmbsize = lmb_memory[i].size;
> >
> >@@ -800,10 +800,10 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> >                                   enum lmb_flags flags)
> > {
> >       long rgn;
> >-      struct lmb_region *lmb_memory = lmb.free_mem.data;
> >+      struct lmb_region *lmb_memory = lmb.available_mem.data;
> >
> >       /* Check if the requested address is in one of the memory regions */
> >-      rgn = lmb_overlaps_region(&lmb.free_mem, base, size);
> >+      rgn = lmb_overlaps_region(&lmb.available_mem, base, size);
> >       if (rgn >= 0) {
> >               /*
> >                * Check if the requested end address is in the same memory
> >@@ -854,10 +854,10 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
> >       int i;
> >       long rgn;
> >       struct lmb_region *lmb_used = lmb.used_mem.data;
> >-      struct lmb_region *lmb_memory = lmb.free_mem.data;
> >+      struct lmb_region *lmb_memory = lmb.available_mem.data;
> >
> >       /* check if the requested address is in the memory regions */
> >-      rgn = lmb_overlaps_region(&lmb.free_mem, addr, 1);
> >+      rgn = lmb_overlaps_region(&lmb.available_mem, addr, 1);
> >       if (rgn >= 0) {
> >               for (i = 0; i < lmb.used_mem.count; i++) {
> >                       if (addr < lmb_used[i].base) {
> >@@ -871,8 +871,8 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
> >                       }
> >               }
> >               /* if we come here: no reserved ranges above requested addr */
> >-              return lmb_memory[lmb.free_mem.count - 1].base +
> >-                     lmb_memory[lmb.free_mem.count - 1].size - addr;
> >+              return lmb_memory[lmb.available_mem.count - 1].base +
> >+                     lmb_memory[lmb.available_mem.count - 1].size - addr;
> >       }
> >       return 0;
> > }
> >@@ -895,7 +895,7 @@ static int lmb_setup(bool test)
> > {
> >       bool ret;
> >
> >-      ret = alist_init(&lmb.free_mem, sizeof(struct lmb_region),
> >+      ret = alist_init(&lmb.available_mem, sizeof(struct lmb_region),
> >                        (uint)LMB_ALIST_INITIAL_SIZE);
> >       if (!ret) {
> >               log_debug("Unable to initialise the list for LMB free memory\n");
> >@@ -967,7 +967,7 @@ int lmb_push(struct lmb *store)
> >
> > void lmb_pop(struct lmb *store)
> > {
> >-      alist_uninit(&lmb.free_mem);
> >+      alist_uninit(&lmb.available_mem);
> >       alist_uninit(&lmb.used_mem);
> >       lmb = *store;
> > }
> >diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> >index bb419ab2394e..e5b422ab2ba8 100644
> >--- a/test/cmd/bdinfo.c
> >+++ b/test/cmd/bdinfo.c
> >@@ -131,7 +131,7 @@ static int lmb_test_dump_all(struct unit_test_state *uts)
> >       struct lmb *lmb = lmb_get();
> >
> >       ut_assert_nextline("lmb_dump_all:");
> >-      ut_assertok(lmb_test_dump_region(uts, &lmb->free_mem, "memory"));
> >+      ut_assertok(lmb_test_dump_region(uts, &lmb->available_mem, "memory"));
> >       ut_assertok(lmb_test_dump_region(uts, &lmb->used_mem, "reserved"));
> >
> >       return 0;
> >diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> >index 8af5dcad2ecc..0f7052224c10 100644
> >--- a/test/lib/lmb.c
> >+++ b/test/lib/lmb.c
> >@@ -65,7 +65,7 @@ static int setup_lmb_test(struct unit_test_state *uts, struct lmb *store,
> >
> >       ut_assertok(lmb_push(store));
> >       lmb = lmb_get();
> >-      *mem_lstp = &lmb->free_mem;
> >+      *mem_lstp = &lmb->available_mem;
> >       *used_lstp = &lmb->used_mem;
> >
> >       return 0;
> >--
> >2.45.2
> >
>
