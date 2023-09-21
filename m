Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3074CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABBB786D3F;
	Thu, 21 Sep 2023 03:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GmsNGcDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D73586D5B; Thu, 21 Sep 2023 03:06:08 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B6FC86D36
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59bebd5bdadso5523337b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LuR8IeTgP1xh/rSInWEwp/HgqGRUn0+I98MPCnnlmx0=;
 b=GmsNGcDEcrSwYpiqH/DcCmiSEtDue0Iu1vz6QXEC/ooIe4mzSEIBcwH4cbmbkVTti2
 voaJpWSYv9Elsf0Yc6xNOw8CvtQae1Fhv6MVrChLxw1I4EbmSLH3nawtZke7mWrc5i/N
 nWV6hKhPPfZ9n+N1bbBauBEOe/i2CeQ5VRxss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LuR8IeTgP1xh/rSInWEwp/HgqGRUn0+I98MPCnnlmx0=;
 b=hpau7tFzkmHzrIoWU7J5jKd9PKRKyKtwoOGpceuCqKUwY9ehVsljx2INihZosLBNVl
 jFE/2OeT3alPHV73V550iJo43MStk2tBSgIKGl5+Fxnv3AE8r21xtAZV7qq1PlgI1o+p
 zDFV5Z7zeZKtC+sl9HVejLPG2RnTxCzRgKVImJbMRxCISgxWbQNMfCDwgkjqjQZqOyPy
 tH7lEXToAg9Mgv+pjwnHUKjWm+HLLTpDRkjGiCv4uZqsh/NkPFOIiv/GyaiFcpppFwdd
 y5pfu41upbmTHF9GeHHHNY5npzkfOocqCRp+xBZKGZV4XpI9LmWnB/374PjYs5CKdS6f
 WU2A==
X-Gm-Message-State: AOJu0Yy3phSNLFtLxtVHS50aDhIkWAhuzxbDqu1tjx5ia9WnQ3MejV2t
 GmM1Dzz+h7kGv+4AxNpTtSSF0SpMaIwTrdWUT7q9jg==
X-Google-Smtp-Source: AGHT+IHiQWn39e4JnK8I17mHk+P8qDA++cdFu2RkLvr9nUTXOWN9V35q/j+w5UGuNq0NTdu6ZlCMfz7UCKL2dbq6mPM=
X-Received: by 2002:a81:5dd7:0:b0:59b:ce0b:7829 with SMTP id
 r206-20020a815dd7000000b0059bce0b7829mr3696649ywb.35.1695258357416; Wed, 20
 Sep 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
 <20230915175050.4109711-3-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230915175050.4109711-3-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:43 -0600
Message-ID: <CAPnjgZ2pCV32gzT+4psGCHZ74EuaBa-MMLEGiV4FGW7Ash1Kzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] malloc_simple: add mem_malloc_init_simple()
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
> I was running out of malloc() in SPL, and the message told me to look
> at CONFIG_SYS_SPL_MALLOC_SIZE. So I did, and bumped it quite a bit,
> but that had no effect whatsoever.
>
> The reason for that was that I also have
> CONFIG_SPL_SYS_MALLOC_SIMPLE=y. So while board_init_r() in spl.c duly
> calls
>
>   mem_malloc_init(SYS_SPL_MALLOC_START, CONFIG_SYS_SPL_MALLOC_SIZE);
>
> that doesn't actually do anything, because that function just sets
> some variables in dlmalloc.c, and (as the linker map shows), the rest
> of dlmalloc.o has been garbage-collected.
>
> I don't want to have the full dlmalloc implementation in SPL - code
> size is still precious. However, once SDRAM is initialized, the heap
> is practically infinite, if only CONFIG_SYS_SPL_MALLOC_SIZE actually
> had an effect.
>
> So just as CONFIG_SPL_SYS_MALLOC_SIMPLE redirects malloc() and friends
> at build-time to the _simple variants, add a _simple variant of
> mem_malloc_init() which will actually update the bookkeeping variables
> relevant to the actual and active malloc() implementation.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  common/dlmalloc.c      | 2 +-
>  common/malloc_simple.c | 7 +++++++
>  include/malloc.h       | 7 +++++--
>  3 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

width change below

>
> diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> index dcecdb8623..d42b26410f 100644
> --- a/common/dlmalloc.c
> +++ b/common/dlmalloc.c
> @@ -619,7 +619,7 @@ void *sbrk(ptrdiff_t increment)
>         return (void *)old;
>  }
>
> -void mem_malloc_init(ulong start, ulong size)
> +void mem_dlmalloc_init(ulong start, ulong size)
>  {
>         mem_malloc_start = start;
>         mem_malloc_end = start + size;
> diff --git a/common/malloc_simple.c b/common/malloc_simple.c
> index 0a004d40e1..9ecf05cf2e 100644
> --- a/common/malloc_simple.c
> +++ b/common/malloc_simple.c
> @@ -17,6 +17,13 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +void mem_malloc_init_simple(ulong start, ulong size)
> +{
> +       gd->malloc_base = start;
> +       gd->malloc_ptr = 0;
> +       gd->malloc_limit = size;
> +}
> +
>  static void *alloc_simple(size_t bytes, int align)
>  {
>         ulong addr, new_ptr;
> diff --git a/include/malloc.h b/include/malloc.h
> index 161ccbd129..f59942115b 100644
> --- a/include/malloc.h
> +++ b/include/malloc.h
> @@ -899,6 +899,7 @@ void malloc_disable_testing(void);
>  #define malloc malloc_simple
>  #define realloc realloc_simple
>  #define memalign memalign_simple
> +#define mem_malloc_init mem_malloc_init_simple
>  #if IS_ENABLED(CONFIG_VALGRIND)
>  #define free free_simple
>  #else
> @@ -908,6 +909,9 @@ void *calloc(size_t nmemb, size_t size);
>  void *realloc_simple(void *ptr, size_t size);
>  #else
>
> +#define mem_malloc_init mem_dlmalloc_init
> +void mem_dlmalloc_init(ulong start, ulong size);

Please add a full comment here

> +
>  # ifdef USE_DL_PREFIX
>  # define cALLOc                dlcalloc
>  # define fREe          dlfree
> @@ -955,6 +959,7 @@ int initf_malloc(void);
>  /* Simple versions which can be used when space is tight */
>  void *malloc_simple(size_t size);
>  void *memalign_simple(size_t alignment, size_t bytes);
> +void mem_malloc_init_simple(ulong start, ulong size);

Please add a full comment here

>
>  #pragma GCC visibility push(hidden)
>  # if __STD_C
> @@ -997,8 +1002,6 @@ extern ulong mem_malloc_start;
>  extern ulong mem_malloc_end;
>  extern ulong mem_malloc_brk;
>
> -void mem_malloc_init(ulong start, ulong size);
> -
>  #ifdef __cplusplus
>  };  /* end of extern "C" */
>  #endif
> --
> 2.37.2
>

Regards,
Simon
