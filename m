Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0902DCD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C2986C1C;
	Thu, 21 Sep 2023 03:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VJQ1OACK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C40D86C2A; Thu, 21 Sep 2023 03:02:44 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC80F86B55
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b9338e4695so6176461fa.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258161; x=1695862961; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BnKEcRxEdT0ajE/1fxD6PiaK9kxO9qL1r9/+uRgL+O8=;
 b=VJQ1OACKyy2M+4F2WiJO9JdnbFchvi5INrqxVuwXOlQlcle88y+k/yerzMOBB2GLWc
 Lm9XfyMsBK37nD+4U2SN+4z4L6fftfn/nemSX3Vw4sPrc4gn3k3OGE3Pcls4z0fDGAQN
 xwrV3IqofOY3Lco6Zy/La0faQ9BrAA3s8irgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258161; x=1695862961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BnKEcRxEdT0ajE/1fxD6PiaK9kxO9qL1r9/+uRgL+O8=;
 b=IM7eaCLmYa6HGjb6ewlA+1m3Sl/TvxGpJmXtF3safs8ff6hcMhypgBydQUMASBDvJ3
 ZyLSwBcbaK2mQFIHiX59K1oFjwHf9A3GRIqmyJErFAsnfXlsC7o+MoybSdHA9sjQv6aT
 5pZ7iR3YGQ8q1gFpPfVncTGiCi09SJVyS3+tOrfQUFrZQwbANLa30NnvXu42NKwd/udU
 pvX+MjeGIdK0GT2cXilY7FTB8wUD5yUz6bBAzsUidh8VMwJ1wERie4OI1E/3z/f4Y9+o
 mx3f+0viH+ygJo1Tryy4T4ifRzJSlwyLJl9Go45STKPvrDE+cZzAfuROHBsaUrUHPoqL
 vmbQ==
X-Gm-Message-State: AOJu0YxVdFyMApDQ6BIdGWwaWlNh5V5DClIVxgqFxsgR+n/8x8eFLMf8
 s13ceHsNnI4EPMCkMNBNl2mHJOLHB9hizc06T3OuJg==
X-Google-Smtp-Source: AGHT+IE1npuQMVIh5JtLPvdVfGDti+dyxk/BVLUAJ7hNKHHQf50g8FaDPs8vH1o3YDj0hCr8AgHfRO0pxFrN0b1StyQ=
X-Received: by 2002:a19:8c14:0:b0:500:ac10:1641 with SMTP id
 o20-20020a198c14000000b00500ac101641mr3663121lfd.46.1695258160916; Wed, 20
 Sep 2023 18:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:23 -0600
Message-ID: <CAPnjgZ2NzoYi9vVWxnnCNU0yudbVCnN2qMRm_gq1zVW-=SuUCg@mail.gmail.com>
Subject: Re: [PATCH 0/2] make CONFIG_SPL_SYS_MALLOC_SIMPLE &&
 CONFIG_SYS_SPL_MALLOC actually work
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>
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

Hi Rasmus,

On Fri, 15 Sept 2023 at 11:51, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Currently, setting both CONFIG_SPL_SYS_MALLOC_SIMPLE and
> CONFIG_SYS_SPL_MALLOC (but not CONFIG_SPL_STACK_R) doesn't work as
> expected: The SIMPLE option means that all malloc etc. calls are
> directed at build-time to the implementation in malloc_simple.c, but

Sort-of. It is control by both a CONFIG and GD_FLG_FULL_MALLOC_INIT.

> the mem_alloc_init() call which is done in board_init_f() currently
> calls into dlmalloc.c, and updates the variables describing the
> dlmalloc arena - which is of course completely unused. And the
> malloc() implementation continues to hand out allocations from the
> initial SPL_SYS_MALLOC_F_LEN bytes.
>
> These two patches are an attempt at making the combination in $subject
> actually work as one would expect: define an area of sdram to be used
> as a malloc arena, but still manage that using the malloc_simple()
> implementation.
>
> Since this now changes the mem_alloc_init() from being a harmless
> no-op call to actually doing something, there's a risk of some boards
> breaking. The solution for those boards will probably be to just drop
> CONFIG_SYS_SPL_MALLOC, since that hasn't actually done anything.
>
> Rasmus Villemoes (2):
>   spl: make SYS_SPL_MALLOC depend on !(SPL_STACK_R &&
>     SPL_SYS_MALLOC_SIMPLE)
>   malloc_simple: add mem_malloc_init_simple()
>
>  common/dlmalloc.c      | 2 +-
>  common/malloc_simple.c | 7 +++++++
>  common/spl/Kconfig     | 1 +
>  include/malloc.h       | 7 +++++--
>  4 files changed, 14 insertions(+), 3 deletions(-)
>
> --
> 2.37.2
>

Regards,
Simon
