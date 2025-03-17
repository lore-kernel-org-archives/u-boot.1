Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D78C28B28
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 10:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7AB581100;
	Mon, 17 Mar 2025 11:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NFt1Fj8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3DC48122F; Mon, 17 Mar 2025 11:06:47 +0100 (CET)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848648141E
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 11:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5241abb9761so1857814e0c.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742206002; x=1742810802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fGjydFhOTtf9dDpMYGav5WNmoaKOF9deIyUxJiwJ7NI=;
 b=NFt1Fj8xUa1l0xC4l25qTqAzUXGYcQfrTA0s10dNywKEQOdsaZVy0UOuWYWdXz747Q
 m/zTH0yI6I9HBQXmginqqnfx8hEAb6Q08XR8zs4XpKjCOBNntzGsk9mq5Qad6yD63vxZ
 XvhYM4/1HctUgJfY6whnItxWGWXqgUh2MH3wXNV0khZzPT5cxqgSCT2GXeiJzI+qjLZ6
 l9n0tWrDCuDuiMlJHaO83kQKkRWTy8uuKjhTeVyNgR0JlVbtxE7TivWD1mimwPvwWAEb
 Z0BcpgO7J2wv3nMOR+CVOGyoNvpRtWTcwNuFdYyvIkl8tw1ut6TGWMdvT/dso04fPVss
 rsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742206002; x=1742810802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fGjydFhOTtf9dDpMYGav5WNmoaKOF9deIyUxJiwJ7NI=;
 b=A70tBqIUQYxRBh4BeszA4cvokteUy8jBFCx+EZJR05v3IdlvEStEjZO/XYQWO8CP0G
 SZ749rtY5DTZ3rXy2NSppA4RnlzW6QObBeKHwBKxVl2uCMDsbP2T9PsPkHmIld+wn9eq
 zMo4Gh46l4YzfGW6irhxgE2JjgzOLusDfO7zTCJvH9eqS9rR3w4/M6oTY1DWOWHfR0X9
 jWLmH0DB1kLIbN4ZXhEaHpmm3eGpqq6dFIwMn2GfIkdMrTiIthNNiLWFB3odgLVaVZm2
 7xUVEY49tb7IKr35+Kxdswa49VVyQ00ediB/SroGqu16MokW9IjU61QJR4ndc22TNLJI
 rHRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6cLnZNIDiOo2/JEDW5xnV9WJUyY8Uy32yKNj2tRX6zPJphk2GYMWuMyTKsK79yBEyGh6XjcQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzs1/C7GAYFEGJkJhNHIFHwQ3rLQcAwxVtK2f3MhFCWAfkCRJ2l
 kopcvy1Gz0cX62jmF7m8occ7Z7Hb1xii70uh677r9dEXcz/C+z5oBY9gHoPvCzsuR4ZqxsGAWA/
 KYKBrUAD4icWgtRDKSPGNEdWtKDOyZWBPbF5jVQ==
X-Gm-Gg: ASbGnctkdSQJLeNJfAR/ea6f1nQ3PjOYXkC3mA0E80S63PPnbZOSAFNaSwKfiyM8LBg
 0KCdUJgUIU6he6zI73qVItoeoaHosdH7vjdIKBgBTqwt1fZIJnrJ6yGJuV+NjGWMGtUaq30HFCL
 FRsZvVkOYQ727IYMgZRyH1mOlvOFs=
X-Google-Smtp-Source: AGHT+IGgk5NA/tzMoUHiGgdlYAoPc49f/YRwjT1f/7o548hRuKTEJLnncbnLXRHHOYcLKwq5iA55PCBozX3OD2mZw6g=
X-Received: by 2002:a05:6102:3a0a:b0:4c1:9159:859c with SMTP id
 ada2fe7eead31-4c38316408dmr7148335137.15.1742206002224; Mon, 17 Mar 2025
 03:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 17 Mar 2025 15:36:31 +0530
X-Gm-Features: AQ5f1JpvsCtYClSbsu92bATB3Ti-GfjM2K2z_ha_zVsIAQ_Vp24Ny6tOF_ImyBA
Message-ID: <CADg8p94t0XCvD==6V4nF0CeakVz8WDaTk6uw8ctEVMMeJvXEOw@mail.gmail.com>
Subject: Re: [PATCH] lmb: change the return code on lmb_alloc_addr()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, ardb@kernel.org, Ben Schneider <ben@bens.haus>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Nam Cao <namcao@linutronix.de>, 
 Baruch Siach <baruch@tkos.co.il>, Sam Protsenko <semen.protsenko@linaro.org>, 
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

On Fri, 14 Mar 2025 at 16:27, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Ben reports a failure to boot the kernel on hardware that starts its
> physical memory from 0x0.
> The reason is that lmb_alloc_addr(), which is supposed to reserve a
> specific address, takes the address as the first argument, but then also
> returns the address for success or failure and treats 0 as a failure.
>
> Since we already know the address change the prototype to return an int.
>
> Reported-by: Ben Schneider <ben@bens.haus>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Reviewed-by: Sughosh Ganu <sughosh.ganu@linaro.org>

>  fs/fs.c                     |  2 +-
>  include/lmb.h               |  6 ++---
>  lib/efi_loader/efi_memory.c |  3 +--
>  lib/lmb.c                   |  6 ++---
>  test/lib/lmb.c              | 53 +++++++++++++++++++------------------
>  5 files changed, 35 insertions(+), 35 deletions(-)
>

[...]

> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index fcb5f1af532a..01b1c7fdedd0 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -531,21 +531,21 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
>
>         /* Try to allocate a page twice */
>         b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> -       ut_asserteq(b, alloc_addr_a);
> -       b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
>         ut_asserteq(b, 0);
> +       b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> +       ut_asserteq(b, -1);
>         b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> -       ut_asserteq(b, alloc_addr_a);
> +       ut_asserteq(b, 0);
>         b = lmb_alloc_addr(alloc_addr_a, 0x2000, LMB_NONE);
> -       ut_asserteq(b, alloc_addr_a);
> +       ut_asserteq(b, 0);
>         ret = lmb_free(alloc_addr_a, 0x2000);
>         ut_asserteq(ret, 0);
>         b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> -       ut_asserteq(b, alloc_addr_a);
> -       b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
>         ut_asserteq(b, 0);
> +       b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> +       ut_asserteq(b, -1);
>         b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> -       ut_asserteq(b, 0);
> +       ut_asserteq(b, -1);
>         ret = lmb_free(alloc_addr_a, 0x1000);
>         ut_asserteq(ret, 0);
>
> @@ -561,22 +561,22 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
>
>         /* allocate blocks */
>         a = lmb_alloc_addr(ram, alloc_addr_a - ram, LMB_NONE);
> -       ut_asserteq(a, ram);
> +       ut_asserteq(a, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, ram, 0x8010000,
>                    alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
>         b = lmb_alloc_addr(alloc_addr_a + 0x10000,
>                            alloc_addr_b - alloc_addr_a - 0x10000, LMB_NONE);
> -       ut_asserteq(b, alloc_addr_a + 0x10000);
> +       ut_asserteq(b, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x10010000,
>                    alloc_addr_c, 0x10000, 0, 0);
>         c = lmb_alloc_addr(alloc_addr_b + 0x10000,
>                            alloc_addr_c - alloc_addr_b - 0x10000, LMB_NONE);
> -       ut_asserteq(c, alloc_addr_b + 0x10000);
> +       ut_asserteq(c, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
>                    0, 0, 0, 0);
>         d = lmb_alloc_addr(alloc_addr_c + 0x10000,
>                            ram_end - alloc_addr_c - 0x10000, LMB_NONE);
> -       ut_asserteq(d, alloc_addr_c + 0x10000);
> +       ut_asserteq(d, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, ram_size,
>                    0, 0, 0, 0);
>
> @@ -586,57 +586,58 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, ram_size,
>                    0, 0, 0, 0);
>
> -       ret = lmb_free(d, ram_end - alloc_addr_c - 0x10000);
> +       /* free thge allocation from d */

nit: typo in the comment

> +       ret = lmb_free(alloc_addr_c + 0x10000, ram_end - alloc_addr_c - 0x10000);
>         ut_asserteq(ret, 0);
>
>         /* allocate at 3 points in free range */
>
>         d = lmb_alloc_addr(ram_end - 4, 4, LMB_NONE);
> -       ut_asserteq(d, ram_end - 4);
> +       ut_asserteq(d, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
> -                  d, 4, 0, 0);
> -       ret = lmb_free(d, 4);
> +                  ram_end - 4, 4, 0, 0);
> +       ret = lmb_free(ram_end - 4, 4);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
>                    0, 0, 0, 0);
>
>         d = lmb_alloc_addr(ram_end - 128, 4, LMB_NONE);
> -       ut_asserteq(d, ram_end - 128);
> +       ut_asserteq(d, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
> -                  d, 4, 0, 0);
> -       ret = lmb_free(d, 4);
> +                  ram_end - 128, 4, 0, 0);
> +       ret = lmb_free(ram_end - 128, 4);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
>                    0, 0, 0, 0);
>
>         d = lmb_alloc_addr(alloc_addr_c + 0x10000, 4, LMB_NONE);
> -       ut_asserteq(d, alloc_addr_c + 0x10000);
> +       ut_asserteq(d, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010004,
>                    0, 0, 0, 0);
> -       ret = lmb_free(d, 4);
> +       ret = lmb_free(alloc_addr_c + 0x10000, 4);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
>                    0, 0, 0, 0);
>
> -       /* allocate at the bottom */
> -       ret = lmb_free(a, alloc_addr_a - ram);
> +       /* allocate at the bottom a was assigned to ram at the top */

nit: can be split into two sentences. "allocate at the bottom. a was
assigned..."

-sughosh

> +       ret = lmb_free(ram, alloc_addr_a - ram);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram + 0x8000000,
>                    0x10010000, 0, 0, 0, 0);
>
>         d = lmb_alloc_addr(ram, 4, LMB_NONE);
> -       ut_asserteq(d, ram);
> -       ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, d, 4,
> +       ut_asserteq(d, 0);
> +       ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 4,
>                    ram + 0x8000000, 0x10010000, 0, 0);
>
>         /* check that allocating outside memory fails */
>         if (ram_end != 0) {
>                 ret = lmb_alloc_addr(ram_end, 1, LMB_NONE);
> -               ut_asserteq(ret, 0);
> +               ut_asserteq(ret, -1);
>         }
>         if (ram != 0) {
>                 ret = lmb_alloc_addr(ram - 1, 1, LMB_NONE);
> -               ut_asserteq(ret, 0);
> +               ut_asserteq(ret, -1);
>         }
>
>         lmb_pop(&store);
> --
> 2.47.2
>
