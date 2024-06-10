Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A35C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 06:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E84882DF;
	Mon, 10 Jun 2024 08:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mV3IiQrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 110A48826E; Mon, 10 Jun 2024 08:22:45 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B19E882DF
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5751bcb3139so4819090a12.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000561; x=1718605361; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IvO/WrW2qYeRbU6LYQqHaCaF4o8teEsGq9sC6CcQ9ao=;
 b=mV3IiQrj2AaoFrQ20Y0VD8HAeu5UYW3AgbCkL79fkqKNn+2xpjuAY65htWPKPn0CBc
 GzJW88sgJl8H+kBeiwFEKsGPqtRkHp6GLFIt0phRsAGBs6VkG7TiTowypS0MFZ/kdKFH
 kAFkdk0PWXXwU3qh6XhLjkt5agePRcj+tZeS1fbhLxaghW+6oQofucmXrRS2ovd4bpXp
 94Bqn9xuL+YXb2QU4LrjT+3ZK/3/EoaWsTan304gHe/VLIGdJI1PcWHT1QWEDfNDpZHi
 fXop6xZjaV02hXxAaoPL8odA2Zcz9aE80YWAOwb+tItjUAgVyWIuPf1ZxdL0Jzgm7YaM
 nOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000561; x=1718605361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IvO/WrW2qYeRbU6LYQqHaCaF4o8teEsGq9sC6CcQ9ao=;
 b=DEFjB97OqLiQy7iecctGRPvmvuq2hEW6/sOlDQyCURADfjSBoQyvKHAQW1QytqHUpO
 t95eOeCLwmTDEPrlFlXN8BMAW7arSzGddz718QJN11sLsTUVzWS85pz0H3MNsvbtcHWc
 j3ke/khGy5zzRFPvFgywAXXHSNf7i1m7mRLVilsJRrFgE6aGIBow/5ccOC57RngR8cni
 +XFTCYuSo/qkjRO7AKH/uXBbAj3C763L9mBruv+ZRdMw1AOD80HwLE6HzqU/wJ3jL99A
 KoO2/YM+XTyUbvRw4peY2f8/sL2jHsGltV5TuvgPa1OMovE30MW1uCTYPUpWR0BHBQrE
 Bdzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA0OMkSxt+9zE7aGiTNPn7adeSnyECp/7guNeao/USGyfMHn01DHroY7sXEl981tK2WjLjMdVAdXi6a2RJBU2l85Anig==
X-Gm-Message-State: AOJu0Yx+kGsngAh1jcGozn4loMqXJAbleTMGc3QkC3Lda60Zv1l2IJg8
 iiwfcMAc+ymoVOfBs0T3BZcCZP0jSg2EQfAqPNIhcpa/YKBGsJA3aZ5eyHCzTnhPXiuJ3Q8Anax
 hzQr0+t1zEmX4ZN/WoQ9w78l8fpoPmRal4kXb8g==
X-Google-Smtp-Source: AGHT+IFnOyhh4CxMX7tsq07ZwSsrQFEG3ViAmlvxEFsEicgxlEoOIiJJH9FEPChNGc+vSHjvzvMD9TvM51cw9P/0g0A=
X-Received: by 2002:a50:a45a:0:b0:57c:8bdd:2d92 with SMTP id
 4fb4d7f45d1cf-57c8bdd2df8mr183192a12.10.1718000560853; Sun, 09 Jun 2024
 23:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-27-sughosh.ganu@linaro.org>
 <6098d0ed-f641-483a-8cf7-6711e2ab663d@gmx.de>
In-Reply-To: <6098d0ed-f641-483a-8cf7-6711e2ab663d@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 10 Jun 2024 11:52:29 +0530
Message-ID: <CADg8p95pEc=R-AYS-Ghe23nwZC3k=+4zeh4Vjdrv9RVUB6dKqw@mail.gmail.com>
Subject: Re: [RFC PATCH 26/31] test: lmb: run lmb tests only manually
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
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

On Sat, 8 Jun 2024 at 10:09, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 6/7/24 20:52, Sughosh Ganu wrote:
> > The LMB code has been changed so that the memory reservations and
> > allocations are now persistent and global. With this change, the
> > design of the LMB tests needs to be changed accordingly. For now, mark
> > the LMB tests to be run only manually. The tests won't be run as part
> > of the unit test suite, and thus would not interfere with the running
> > of the rest of the tests.
>
> We should run important tests in the CI.
>
> You could trigger the 'manual' test from a Python test and reboot the
> system to get into an initial state.

Yes, that is one of the solutions that I have in mind. Will work on
this for the next version. Thanks.

-sughosh

>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   test/lib/lmb.c | 49 ++++++++++++++++++++++++-------------------------
> >   1 file changed, 24 insertions(+), 25 deletions(-)
> >
> > diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> > index 67a6be5bc3..813f7e3100 100644
> > --- a/test/lib/lmb.c
> > +++ b/test/lib/lmb.c
> > @@ -195,7 +195,7 @@ static int test_multi_alloc_512mb_x2(struct unit_test_state *uts,
> >   }
> >
> >   /* Create a memory region with one reserved region and allocate */
> > -static int lib_test_lmb_simple(struct unit_test_state *uts)
> > +static int lib_test_lmb_simple_norun(struct unit_test_state *uts)
> >   {
> >       int ret;
> >
> > @@ -207,10 +207,10 @@ static int lib_test_lmb_simple(struct unit_test_state *uts)
> >       /* simulate 512 MiB RAM beginning at 1.5GiB */
> >       return test_multi_alloc_512mb(uts, 0xE0000000);
> >   }
> > -LIB_TEST(lib_test_lmb_simple, 0);
> > +LIB_TEST(lib_test_lmb_simple_norun, UT_TESTF_MANUAL);
> >
> >   /* Create two memory regions with one reserved region and allocate */
> > -static int lib_test_lmb_simple_x2(struct unit_test_state *uts)
> > +static int lib_test_lmb_simple_x2_norun(struct unit_test_state *uts)
> >   {
> >       int ret;
> >
> > @@ -222,7 +222,7 @@ static int lib_test_lmb_simple_x2(struct unit_test_state *uts)
> >       /* simulate 512 MiB RAM beginning at 3.5GiB and 1 GiB */
> >       return test_multi_alloc_512mb_x2(uts, 0xE0000000, 0x40000000);
> >   }
> > -LIB_TEST(lib_test_lmb_simple_x2, 0);
> > +LIB_TEST(lib_test_lmb_simple_x2_norun, UT_TESTF_MANUAL);
> >
> >   /* Simulate 512 MiB RAM, allocate some blocks that fit/don't fit */
> >   static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
> > @@ -275,7 +275,7 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
> >       return 0;
> >   }
> >
> > -static int lib_test_lmb_big(struct unit_test_state *uts)
> > +static int lib_test_lmb_big_norun(struct unit_test_state *uts)
> >   {
> >       int ret;
> >
> > @@ -287,7 +287,7 @@ static int lib_test_lmb_big(struct unit_test_state *uts)
> >       /* simulate 512 MiB RAM beginning at 1.5GiB */
> >       return test_bigblock(uts, 0xE0000000);
> >   }
> > -LIB_TEST(lib_test_lmb_big, 0);
> > +LIB_TEST(lib_test_lmb_big_norun, UT_TESTF_MANUAL);
> >
> >   /* Simulate 512 MiB RAM, allocate a block without previous reservation */
> >   static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
> > @@ -348,7 +348,7 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
> >       return 0;
> >   }
> >
> > -static int lib_test_lmb_noreserved(struct unit_test_state *uts)
> > +static int lib_test_lmb_noreserved_norun(struct unit_test_state *uts)
> >   {
> >       int ret;
> >
> > @@ -360,10 +360,9 @@ static int lib_test_lmb_noreserved(struct unit_test_state *uts)
> >       /* simulate 512 MiB RAM beginning at 1.5GiB */
> >       return test_noreserved(uts, 0xE0000000, 4, 1);
> >   }
> > +LIB_TEST(lib_test_lmb_noreserved_norun, UT_TESTF_MANUAL);
> >
> > -LIB_TEST(lib_test_lmb_noreserved, 0);
> > -
> > -static int lib_test_lmb_unaligned_size(struct unit_test_state *uts)
> > +static int lib_test_lmb_unaligned_size_norun(struct unit_test_state *uts)
> >   {
> >       int ret;
> >
> > @@ -375,13 +374,13 @@ static int lib_test_lmb_unaligned_size(struct unit_test_state *uts)
> >       /* simulate 512 MiB RAM beginning at 1.5GiB */
> >       return test_noreserved(uts, 0xE0000000, 5, 8);
> >   }
> > -LIB_TEST(lib_test_lmb_unaligned_size, 0);
> > +LIB_TEST(lib_test_lmb_unaligned_size_norun, UT_TESTF_MANUAL);
> >
> >   /*
> >    * Simulate a RAM that starts at 0 and allocate down to address 0, which must
> >    * fail as '0' means failure for the lmb_alloc functions.
> >    */
> > -static int lib_test_lmb_at_0(struct unit_test_state *uts)
> > +static int lib_test_lmb_at_0_norun(struct unit_test_state *uts)
> >   {
> >       const phys_addr_t ram = 0;
> >       const phys_size_t ram_size = 0x20000000;
> > @@ -417,9 +416,9 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
> >
> >       return 0;
> >   }
> > -LIB_TEST(lib_test_lmb_at_0, 0);
> > +LIB_TEST(lib_test_lmb_at_0_norun, UT_TESTF_MANUAL);
> >
> > -static int lib_test_lmb_overlapping_add(struct unit_test_state *uts)
> > +static int lib_test_lmb_overlapping_add_norun(struct unit_test_state *uts)
> >   {
> >       const phys_addr_t ram = 0x40000000;
> >       const phys_size_t ram_size = 0x20000000;
> > @@ -433,10 +432,10 @@ static int lib_test_lmb_overlapping_add(struct unit_test_state *uts)
> >
> >       return 0;
> >   }
> > -LIB_TEST(lib_test_lmb_overlapping_add, 0);
> > +LIB_TEST(lib_test_lmb_overlapping_add_norun, UT_TESTF_MANUAL);
> >
> >   /* Check that calling lmb_reserve with overlapping regions fails. */
> > -static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
> > +static int lib_test_lmb_overlapping_reserve_norun(struct unit_test_state *uts)
> >   {
> >       const phys_addr_t ram = 0x40000000;
> >       const phys_size_t ram_size = 0x20000000;
> > @@ -480,7 +479,7 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
> >                  0, 0, 0, 0);
> >       return 0;
> >   }
> > -LIB_TEST(lib_test_lmb_overlapping_reserve, 0);
> > +LIB_TEST(lib_test_lmb_overlapping_reserve_norun, UT_TESTF_MANUAL);
> >
> >   /*
> >    * Simulate 512 MiB RAM, reserve 3 blocks, allocate addresses in between.
> > @@ -596,7 +595,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
> >       return 0;
> >   }
> >
> > -static int lib_test_lmb_alloc_addr(struct unit_test_state *uts)
> > +static int lib_test_lmb_alloc_addr_norun(struct unit_test_state *uts)
> >   {
> >       int ret;
> >
> > @@ -608,7 +607,7 @@ static int lib_test_lmb_alloc_addr(struct unit_test_state *uts)
> >       /* simulate 512 MiB RAM beginning at 1.5GiB */
> >       return test_alloc_addr(uts, 0xE0000000);
> >   }
> > -LIB_TEST(lib_test_lmb_alloc_addr, 0);
> > +LIB_TEST(lib_test_lmb_alloc_addr_norun, UT_TESTF_MANUAL);
> >
> >   /* Simulate 512 MiB RAM, reserve 3 blocks, check addresses in between */
> >   static int test_get_unreserved_size(struct unit_test_state *uts,
> > @@ -665,7 +664,7 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
> >       return 0;
> >   }
> >
> > -static int lib_test_lmb_get_free_size(struct unit_test_state *uts)
> > +static int lib_test_lmb_get_free_size_norun(struct unit_test_state *uts)
> >   {
> >       int ret;
> >
> > @@ -677,10 +676,10 @@ static int lib_test_lmb_get_free_size(struct unit_test_state *uts)
> >       /* simulate 512 MiB RAM beginning at 1.5GiB */
> >       return test_get_unreserved_size(uts, 0xE0000000);
> >   }
> > -LIB_TEST(lib_test_lmb_get_free_size, 0);
> > +LIB_TEST(lib_test_lmb_get_free_size_norun, UT_TESTF_MANUAL);
> >
> >   #ifdef CONFIG_LMB_USE_MAX_REGIONS
> > -static int lib_test_lmb_max_regions(struct unit_test_state *uts)
> > +static int lib_test_lmb_max_regions_norun(struct unit_test_state *uts)
> >   {
> >       const phys_addr_t ram = 0x00000000;
> >       /*
> > @@ -745,10 +744,10 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
> >
> >       return 0;
> >   }
> > -LIB_TEST(lib_test_lmb_max_regions, 0);
> > +LIB_TEST(lib_test_lmb_max_regions_norun, UT_TESTF_MANUAL);
> >   #endif
> >
> > -static int lib_test_lmb_flags(struct unit_test_state *uts)
> > +static int lib_test_lmb_flags_norun(struct unit_test_state *uts)
> >   {
> >       const phys_addr_t ram = 0x40000000;
> >       const phys_size_t ram_size = 0x20000000;
> > @@ -832,4 +831,4 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
> >
> >       return 0;
> >   }
> > -LIB_TEST(lib_test_lmb_flags, 0);
> > +LIB_TEST(lib_test_lmb_flags_norun, UT_TESTF_MANUAL);
>
