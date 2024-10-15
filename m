Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA04D216A6
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5554881A5;
	Tue, 15 Oct 2024 15:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nJRj8pIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDCF883D4; Tue, 15 Oct 2024 15:38:36 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9328814D
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c805a0753so44244495ad.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728999512; x=1729604312; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hC2YUW/ylFLV+qcjiBd8fCMzK1UKkLWSYjc0VHIpqYY=;
 b=nJRj8pIRII3/g+J9IQP8NleArL8Pme7TyAx8zHvBua7Gy2d5fdX1Smi9EFkLPAA7ho
 L6LuVVLz/pbQUUBfe4RkovbRzgPgFOIyJiYjrlw4grNux4hQV7utuTkLgXZS2tNe1rSW
 ZRcsxx+YPPSKKQJmNzC28BJvEsDB+eKVkzvoSxlq5pklvbIQ1ggUo89M+t/XQM96DpF2
 D7SCiJllg+c0o8KA3HmK1TkeVZ8z9cGVbxQH9PenzQpk9UyPadr2sZ4ElSjM09K0HmVQ
 cIYlP/GlzgaoiyR9wDKjrIRY55i00GpkZMVd5+2Apl27MKJ+PsMJGj4YnTeJ0WaKLXp0
 mFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728999512; x=1729604312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hC2YUW/ylFLV+qcjiBd8fCMzK1UKkLWSYjc0VHIpqYY=;
 b=jmkX4QwW73O0njlWqKbgotweLP1M1lbEguI21dq4WfJN8caxxR9bvVhsOoMD937IYF
 eMp7s+YPnYHl1f0/p4aNzeVXKyL4RRC7eXMhxn9BTRhtNAp04uOBNvMgUyDRkV/w3yI3
 TavrEpaXhHP3zphJczePuNin6Jczxo8gjcr+67wTB45LqUe/+Ng1F3rEECLgwM5mAmQ0
 dq3Eh5lLUhxpu5JfopX1+Z9SsP5JZAHc9/0BSUL+PyF/iJlJLY/hdlrhDjrC21GvdXqQ
 v8YSCyraqS8grtVee5f7jMdXGPc+56NmbhRCrXxAnBeykgWPGsuJi4lmMkQFAn4M/1gZ
 W5Ig==
X-Gm-Message-State: AOJu0YzySTz2w7Gn4lJmSzFr2JW8oaCqwUzcI75tTTNNI/AjuTk+qWP4
 UG12K9zstWXaCnS9FAKjV6+qarWXhS//+KPJQYM8jfuSLKmHFzPGQYz1OGpYt6tt8XRP5XiOk18
 5LMbthsWXUfSp8cXUTsmwcc3W2GpwEmBBBECqifDnff8n1JxOFcI=
X-Google-Smtp-Source: AGHT+IGeC54SC3eCU5S8h2SzjmUkLbH9a8UOUmZS0n1TwEVzVDTPagaIZtWJAsb7HESXv0siBOmvrf6msfWkqQklU7M=
X-Received: by 2002:a17:903:2283:b0:20b:a10c:9bdf with SMTP id
 d9443c01a7336-20d27ed02f5mr4115945ad.32.1728999512075; Tue, 15 Oct 2024
 06:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241015133304.2874735-1-sjg@chromium.org>
 <20241015133304.2874735-3-sjg@chromium.org>
In-Reply-To: <20241015133304.2874735-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Oct 2024 16:37:55 +0300
Message-ID: <CAC_iWjL5+LN4ReAo7LNhRrC1==V8ciCd4M73kUXktV7ufQEhng@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] common: Tidy up how malloc() is inited
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Artur Rojek <artur@conclusive.pl>, 
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Simon,

I did review enough of this series in v1 [0]. Please resend it with
the proper tags added. Did anything change and you dropped by r-b?
Because the changelog says no changes

On Tue, 15 Oct 2024 at 16:33, Simon Glass <sjg@chromium.org> wrote:
>
> The call to malloc() is a bit strange. The naming of the arguments
> suggests that an address is passed, but in fact it is a pointer, at
> least in the board_init_r() function and SPL equivalent.
>
> Update it to work as described. Add a function comment as well.
>
> Note that this does adjustment does not extend into the malloc()
> implementation itself, apart from changing mem_malloc_init(), since
> there are lots of casts and pointers and integers are used
> interchangeably.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>
> (no changes since v1)
>
>  common/board_r.c  | 3 +--
>  common/dlmalloc.c | 8 +++++---
>  common/spl/spl.c  | 4 +---
>  include/malloc.h  | 8 ++++++++
>  4 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 1acad069d92..60eba0942d8 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -204,8 +204,7 @@ static int initr_malloc(void)
>          */
>         start = gd->relocaddr - TOTAL_MALLOC_LEN;
>         gd_set_malloc_start(start);
> -       mem_malloc_init((ulong)map_sysmem(start, TOTAL_MALLOC_LEN),
> -                       TOTAL_MALLOC_LEN);
> +       mem_malloc_init(start, TOTAL_MALLOC_LEN);
>         return 0;
>  }
>
> diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> index 1ac7ce3f43c..cc4d3a0a028 100644
> --- a/common/dlmalloc.c
> +++ b/common/dlmalloc.c
> @@ -16,6 +16,8 @@
>  #include <asm/global_data.h>
>
>  #include <malloc.h>
> +#include <mapmem.h>
> +#include <string.h>
>  #include <asm/io.h>
>  #include <valgrind/memcheck.h>
>
> @@ -598,9 +600,9 @@ void *sbrk(ptrdiff_t increment)
>
>  void mem_malloc_init(ulong start, ulong size)
>  {
> -       mem_malloc_start = start;
> -       mem_malloc_end = start + size;
> -       mem_malloc_brk = start;
> +       mem_malloc_start = (ulong)map_sysmem(start, size);
> +       mem_malloc_end = mem_malloc_start + size;
> +       mem_malloc_brk = mem_malloc_start;
>
>  #ifdef CONFIG_SYS_MALLOC_DEFAULT_TO_INIT
>         malloc_init();
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 94657d00591..1ceb63daf31 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -678,9 +678,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>         spl_set_bd();
>
>         if (IS_ENABLED(CONFIG_SPL_SYS_MALLOC)) {
> -               mem_malloc_init((ulong)map_sysmem(SPL_SYS_MALLOC_START,
> -                                                 SPL_SYS_MALLOC_SIZE),
> -                               SPL_SYS_MALLOC_SIZE);
> +               mem_malloc_init(SPL_SYS_MALLOC_START, SPL_SYS_MALLOC_SIZE);
>                 gd->flags |= GD_FLG_FULL_MALLOC_INIT;
>         }
>         if (!(gd->flags & GD_FLG_SPL_INIT)) {
> diff --git a/include/malloc.h b/include/malloc.h
> index 07d3e90a855..9e0be482416 100644
> --- a/include/malloc.h
> +++ b/include/malloc.h
> @@ -981,6 +981,14 @@ extern ulong mem_malloc_start;
>  extern ulong mem_malloc_end;
>  extern ulong mem_malloc_brk;
>
> +/**
> + * mem_malloc_init() - Set up the malloc() pool
> + *
> + * Sets the region of memory to be used for all future calls to malloc(), etc.
> + *
> + * @start: Start address
> + * @size: Size in bytes
> + */
>  void mem_malloc_init(ulong start, ulong size);
>
>  #ifdef __cplusplus
> --
> 2.34.1
>

[0] https://lore.kernel.org/u-boot/CAFLszThRCmPDfPxWZf9ZhbwcHLNhdUrzNCLwJKkz=17x96ZEJg@mail.gmail.com/
