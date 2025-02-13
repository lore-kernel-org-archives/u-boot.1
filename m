Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B35C021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 18:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541BD80F5C;
	Thu, 13 Feb 2025 19:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QeeDt25U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C3D80F62; Thu, 13 Feb 2025 19:40:01 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B95B80EBD
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 19:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4bbf0aab584so363423137.0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 10:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739471998; x=1740076798; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=op0Lwn2QGmOiS2FCnjhFvBacMV4FhitkwwjWA/PGyFA=;
 b=QeeDt25U++3oBIoHNhzumiMKu0IDWMi2d4/1Z45/E7a3JAgpZ/EEVXv/tCMJ0SOuwp
 AXgcCpJ07MEhVpDvxkVmAjNTaANBZFHvGBAz0jOkroSxB3lJOnJ5EG99ev746scZYhIs
 Y659FP5BmUk36NL+BB86fzRP+cq5mcy86HfPKaq9buXZe29kt5N/55fWuqMv39Lr2HsQ
 QkfRoReX00KDtXQ6hqnI5jcrN7JfUrTJ0pv9+sGjWGrYKjCbHhM+bp9+uPGVqdnKD84F
 rNvoCNy31F+c11jD2yKNpDL08gSq5il6g71p1WWroAMQXXn3Kq4dRIZv2D60Ryhk1eky
 TdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739471998; x=1740076798;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=op0Lwn2QGmOiS2FCnjhFvBacMV4FhitkwwjWA/PGyFA=;
 b=fqgEdRWTqzkM3X6nDafPftmaKkj18VIdnKuJseeKj7rJbtJ2OFXeK8+23eZ90KBbKT
 3nLMayus9SZOCujpK0Ou3FFQQRZlmDORdQjWg15E13DxTRTIaEbnhAbIbw0oU/v+JPRr
 GzVMg/89w2s6qnQNtojsMm6smVcJVegKGArJCHjSXEZ89xo6GX2ojUkXiiL0U1SxFbeW
 MT6GPGvUw3aE/f/h7cPQZOuXZQa8VOlveVRDRCHnnU+0eUKUELbJsjNOB4HXNJM3Aimu
 I4TEgNorSJV9OtIe7RXVWA5z+5WDC3l9RMeCwJcZxA5tpAUmidTsNJA5FwtFhPFpJ53P
 qEFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULs0azYBRZ2o8pexWV8qIRTrzLV8jJ2EGAD+oxVmlTPoxPyrKmoWHVJ7U7vOpeLDEoglJzlBY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxw1i09gkopmhaqGUXfCKKyRMuqS2vfTenZKuW3XKyMwrUUC7N6
 kRp61dgmK+PPrPKkSRzkLddHed/rQnsKXaZhrKGvjx7yNQfXuT/aD1bXb0bXMEuBDaXXyo+k0pW
 FFjUDh9MDpkdz7YY+VySjG08X+QG9aBRiGKolZQ==
X-Gm-Gg: ASbGncuMxiDIYxUwa3ETlyD6ykkZpmvM0IeG01f3fuKHTvZK+YVGGPgygy6Fn6VZM5N
 YG5MqNzGiMz7Y8CdBlhhhHBTXxqCQeTpcmMuCmqRJwqHzHwSEuucPrI7pKeiSPODcoYV5z5DXBg
 ==
X-Google-Smtp-Source: AGHT+IFQEfiFA+beoCVSz79FzLmmIFs1mqPva3PywEKoYpBvsE/aoEp8ThcBa9EkAprAXlLHbT4sqDBLINbBDgCMW+I=
X-Received: by 2002:a05:6102:94b:b0:4bb:dc3c:1b49 with SMTP id
 ada2fe7eead31-4bbf231c5c7mr9136418137.22.1739471997821; Thu, 13 Feb 2025
 10:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-2-sughosh.ganu@linaro.org>
 <7947ea7e-a2e3-4ae1-abb1-9d4c9d506017@canonical.com>
In-Reply-To: <7947ea7e-a2e3-4ae1-abb1-9d4c9d506017@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 14 Feb 2025 00:09:46 +0530
X-Gm-Features: AWEUYZkBU60zzPCZmcREduCMqmVBjeVRr3SwIr3hGm-8bkmyMRYpgWMSzjJw6I8
Message-ID: <CADg8p97SAb=peBxUdUOuhVg=W11kzbzFsre7D_+8RT=yLoQb1g@mail.gmail.com>
Subject: Re: [PATCH 1/4] lmb: check if a region can be reserved by
 lmb_reserve()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Udit Kumar <u-kumar1@ti.com>, u-boot@lists.denx.de
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

On Thu, 13 Feb 2025 at 19:45, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 13.02.25 14:11, Sughosh Ganu wrote:
> > The logic used in lmb_alloc() takes into consideration the existing
> > reserved regions, and ensures that the allocated region does not
> > overlap with any existing allocated regions. The lmb_reserve()
> > function is not doing any such checks -- the requested region might
> > overlap with an existing region. This also shows up with
> > lmb_alloc_addr() as this function ends up calling lmb_reserve().
> >
> > Add a function which checks if the region requested is overlapping
> > with an existing reserved region, and allow for the reservation to
> > happen only if both the regions have LMB_NONE flag, which allows
> > re-requesting of the region. In any other scenario of an overlap, have
> > lmb_reserve() return -EEXIST, implying that the requested region is
> > already reserved.
> >
> > Also add corresponding test cases which checks for overlapping
> > reservation requests made through lmb_reserve() and lmb_alloc_addr().
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   lib/lmb.c      |  23 ++++++++++++
> >   test/lib/lmb.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 122 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 7ca44591e1d..aeaf120f57d 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -595,6 +595,26 @@ static __maybe_unused void lmb_reserve_common_spl(void)
> >       }
> >   }
> >
>
> Every new function should get a Sphinx style description.

Okay. Will add.

>
> > +static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
> > +                                u32 flags)
> > +{
> > +     uint i;
> > +     struct lmb_region *lmb_reserved = lmb.used_mem.data;
> > +
> > +     for (i = 0; i < lmb.used_mem.count; i++) {
> > +             u32 rgnflags = lmb_reserved[i].flags;
> > +             phys_addr_t rgnbase = lmb_reserved[i].base;
> > +             phys_size_t rgnsize = lmb_reserved[i].size;
> > +
> > +             if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> > +                     if (flags != LMB_NONE || flags != rgnflags)
> > +                             return false;
> > +             }
> > +     }
> > +
> > +     return true;
> > +}
> > +
>
> This seems to duplicate code in lmb_resize_regions(). Can we reduce the
> code size by using a common function?

Okay. Let me check if the common parts can be refactored into a single
function for reuse. Thanks.

-sughosh

>
> Best regards
>
> Heinrich
>
> >   void lmb_add_memory(void)
> >   {
> >       int i;
> > @@ -667,6 +687,9 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
> >       long ret = 0;
> >       struct alist *lmb_rgn_lst = &lmb.used_mem;
> >
> > +     if (!lmb_can_reserve_region(base, size, flags))
> > +             return -EEXIST;
> > +
> >       ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
> >       if (ret)
> >               return ret;
> > diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> > index fcb5f1af532..6b995c976dd 100644
> > --- a/test/lib/lmb.c
> > +++ b/test/lib/lmb.c
> > @@ -499,6 +499,32 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
> >       ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x40000,
> >                  0, 0, 0, 0);
> >
> > +     /* try to allocate overlapping region with a different flag, should fail */
> > +     ret = lmb_reserve(0x40008000, 0x1000, LMB_NOOVERWRITE);
> > +     ut_asserteq(ret, -EEXIST);
> > +
> > +     /* allocate another region at 0x40050000 with a different flag */
> > +     ret = lmb_reserve(0x40050000, 0x10000, LMB_NOOVERWRITE);
> > +     ut_asserteq(ret, 0);
> > +     ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x40000,
> > +                0x40050000, 0x10000, 0, 0);
> > +
> > +     /*
> > +      * try to allocate a region adjacent to region 1 overlapping the 2nd region,
> > +      * should fail
> > +      */
> > +     ret = lmb_reserve(0x40040000, 0x20000, LMB_NONE);
> > +     ut_asserteq(ret, -EEXIST);
> > +
> > +     /*
> > +      * try to allocate a region between the two regions, but without an overlap,
> > +      * should succeed. this added region coalesces with the region 1
> > +      */
> > +     ret = lmb_reserve(0x40040000, 0x10000, LMB_NONE);
> > +     ut_asserteq(ret, 0);
> > +     ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x50000,
> > +                0x40050000, 0x10000, 0, 0);
> > +
> >       lmb_pop(&store);
> >
> >       return 0;
> > @@ -549,6 +575,78 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
> >       ret = lmb_free(alloc_addr_a, 0x1000);
> >       ut_asserteq(ret, 0);
> >
> > +     /*
> > +      * Add two regions with different flags, region1 and region2 with
> > +      * a gap between them.
> > +      * Try adding another region, adjacent to region 1 and overlapping
> > +      * region 2. Should fail.
> > +      */
> > +     a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> > +     ut_asserteq(a, alloc_addr_a);
> > +
> > +     b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
> > +     ut_asserteq(b, alloc_addr_a + 0x4000);
> > +     ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
> > +                b, 0x1000, 0, 0);
> > +
> > +     c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NONE);
> > +     ut_asserteq(c, 0);
> > +     ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
> > +                b, 0x1000, 0, 0);
> > +
> > +     ret = lmb_free(a, 0x1000);
> > +     ut_asserteq(ret, 0);
> > +     ret = lmb_free(b, 0x1000);
> > +     ut_asserteq(ret, 0);
> > +
> > +
> > +     /*
> > +      * Add two regions with same flags(LMB_NONE), region1 and region2
> > +      * with a gap between them.
> > +      * Try adding another region, adjacent to region 1 and overlapping
> > +      * region 2. Should succeed. All regions should coalesce into a
> > +      * single region.
> > +      */
> > +     a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> > +     ut_asserteq(a, alloc_addr_a);
> > +
> > +     b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NONE);
> > +     ut_asserteq(b, alloc_addr_a + 0x4000);
> > +     ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
> > +                b, 0x1000, 0, 0);
> > +
> > +     c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NONE);
> > +     ut_asserteq(c, alloc_addr_a + 0x1000);
> > +     ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, 0x6000,
> > +                0, 0, 0, 0);
> > +
> > +     ret = lmb_free(a, 0x6000);
> > +     ut_asserteq(ret, 0);
> > +
> > +     /*
> > +      * Add two regions with same flags(LMB_NOOVERWRITE), region1 and
> > +      * region2 with a gap between them.
> > +      * Try adding another region, adjacent to region 1 and overlapping
> > +      * region 2. Should fail.
> > +      */
> > +     a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> > +     ut_asserteq(a, alloc_addr_a);
> > +
> > +     b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
> > +     ut_asserteq(b, alloc_addr_a + 0x4000);
> > +     ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
> > +                b, 0x1000, 0, 0);
> > +
> > +     c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NOOVERWRITE);
> > +     ut_asserteq(c, 0);
> > +     ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
> > +                b, 0x1000, 0, 0);
> > +
> > +     ret = lmb_free(a, 0x1000);
> > +     ut_asserteq(ret, 0);
> > +     ret = lmb_free(b, 0x1000);
> > +     ut_asserteq(ret, 0);
> > +
> >       /*  reserve 3 blocks */
> >       ret = lmb_reserve(alloc_addr_a, 0x10000, LMB_NONE);
> >       ut_asserteq(ret, 0);
> > @@ -760,7 +858,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
> >
> >       /* reserve again, new flag */
> >       ret = lmb_reserve(0x40010000, 0x10000, LMB_NONE);
> > -     ut_asserteq(ret, -1);
> > +     ut_asserteq(ret, -EEXIST);
> >       ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
> >                  0, 0, 0, 0);
> >
>
