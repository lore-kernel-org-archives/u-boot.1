Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2A0CF0449
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6DD88FAB;
	Wed,  9 Oct 2024 12:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UccW00mB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E7B088FB9; Wed,  9 Oct 2024 12:38:44 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C309888F55
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so4997723a12.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728470320; x=1729075120; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6EkYCaHOYt8g5EWf9JQLNGdXlMD47XjFEruP6dUk9EU=;
 b=UccW00mBsaPgvcZQTI7GW1aASdw1tWLr0KHCDqdmqNnPvN/r1fiKM70ylzFH0u9eSr
 sueDZ8C5KUdVLEmizDBnD12cBb6KBzREgjJ8/W2vb38sTvSN8Gd9+Li/vRUfbFqniihq
 704QnQhUNVoYcnY9iqr7+BnApS1Bw+p5MHD2c/ghAz3eGAIlzjnE+MsW4vxhPJASHfOy
 lfiJd0vnS5sdYnh3pGbx966NdamyV7hzTeLRcjcGfHXaWCRlA2PWX54+bMRq1SuUF4OB
 3mYWTjGY+1h11bX5XRpbe6VOu/al3/DCGFR0zWZyzOurYgtoLl7ECh/g2uyVXVYCavbk
 p3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728470320; x=1729075120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6EkYCaHOYt8g5EWf9JQLNGdXlMD47XjFEruP6dUk9EU=;
 b=oIjnrtYckjQrrzXcTLCLNT37hOrl71iGEHbQUpYYBXFj3fTXnHD1zUsQtWkigWoMn6
 M2FgejCxxdX/yjJtWlnaQ6I4CgVdVGcnWxdmIgdwXldeeVatRKoUj9YrxTurd5ypdwTh
 YZOEWYcW/xJXhbV1iYFLHJJ9V6NYLi5o1cHZjhv8cISEa/iENkE0Bzq31yeTwtZdF4e4
 pf6B9kcqaCo/U8L0FH7hPuPz059CPX7kFtt4zLOR3a5uki3hVLc6nTrRyt72cmExpDB/
 qE4TGP1ffc9/CiO/+7gjTNmcyR0AAcUzMZontZKKQZduId75ABdqfJiAPzykLw16pnYe
 nFBg==
X-Gm-Message-State: AOJu0Yw9SF7lBIzGzThg9G99EiZ0xwjPNtroW0jetGSPZdDf9zA7YS6D
 CtX783lRUaHpAwal+umK6pP2Z1tXNRZjcxzF/2EGKwoNfdr+NGzoexkZU1DUfPWayWGaMYyt61I
 LHYU6/v/UPzmqztN3NoLrWMK6ZsJ9ExIzMyVDPw==
X-Google-Smtp-Source: AGHT+IELjQSuiCtab1kpjAhWMqEm5nytmKBXXobgWYon/3HMRImS+BZny3+26qjhoME8XaenD1Imxgl/MwwuyPIKn5s=
X-Received: by 2002:a17:90b:4a05:b0:2e2:a6ef:d7a6 with SMTP id
 98e67ed59e1d1-2e2a6efd982mr2213075a91.36.1728470320281; Wed, 09 Oct 2024
 03:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241009015020.25817-1-sjg@chromium.org>
 <20241009015020.25817-3-sjg@chromium.org>
In-Reply-To: <20241009015020.25817-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 13:38:03 +0300
Message-ID: <CAC_iWjJN4gDmf9tgd6ZSF6aZHwosqrVYu6+G7R+JywOUO9ifPw@mail.gmail.com>
Subject: Re: [PATCH 2/6] common: Tidy up how malloc() is inited
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Artur Rojek <artur@conclusive.pl>, 
 Devarsh Thakkar <devarsht@ti.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Weinberger <richard@nod.at>, 
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Wed, 9 Oct 2024 at 04:50, Simon Glass <sjg@chromium.org> wrote:
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
> ---
>
>  common/board_r.c  | 3 +--
>  common/dlmalloc.c | 8 +++++---
>  common/spl/spl.c  | 4 +---
>  include/malloc.h  | 8 ++++++++
>  4 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 4faaa202421..fbb10fea494 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -203,8 +203,7 @@ static int initr_malloc(void)
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
> index c13b2b8f714..fc8b38862e8 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -679,9 +679,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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
> 2.43.0
>

This looks ok as long as map_sysmem() is a 1:1 mapping for non-sandbox
archs. NXP seems to be calling these with an address already.
I guess since we only define an alternative map_sysmem() for sandbox this is ok

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
