Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195A7C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83664885CF;
	Thu,  1 Aug 2024 16:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hFtGy6NX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5675C8863E; Thu,  1 Aug 2024 16:58:35 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FC8C87D10
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7bcd0so10762583a12.3
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722524313; x=1723129113; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pVF/IgLCfzATpZGgSv36GUmdZPSATCZmU1ZcTGciKpg=;
 b=hFtGy6NX/Y3S8TM5kLrp1hwsIi+baG76zeMOkdQIi4clmW4lS2yUzNTTkgYYPuSnpm
 Nin8s6oCwhWrcA3zDrOqb10/iRD3DlalwQLyIa7Y0tD+BBfLZYzE+5+zspUnP/U/yli6
 XLqffxUNkq1sEqPbcO7mVbdJDMbQwkxXlgdkGIhIsrCh70uOB5JiInA1CSDWnUFINuV1
 uzqWbZvaHvB/w8UelOqatE9YpO3r3wxGpypek49hZAusy0uLuToaSu2XVGRqZDgQOf2/
 IvM3ySk1ElmHy+7n5O74lbAmpKKktKy5zxp2rYo/qv+E1hC371tScKMD8wFat3Gw1Vej
 NH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722524313; x=1723129113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pVF/IgLCfzATpZGgSv36GUmdZPSATCZmU1ZcTGciKpg=;
 b=Zq0Gh87xtRBQLRwAIkMNXoWhjx6j7/z0o7y3Z+NxwnZqZZDhr8NTvC9Xt8lJMQ9TSI
 hvaw53sA8ltjDuIOMsWlYB2pBQflyjNmhNYJD5LPLmKO8ZWK/QJ7iJQDVP7f2CuSHMmK
 8jWAxFeJhScVlre11M1qa+F/Bb9gwu/P2/9+Jo3O/7J42xvj+Y09a//Kz9rhMrr1E+kJ
 /Yre83L7U8cb5rkUqN8BXwOI5w7CBKf0JZwuawB0kEoMha4wf1ytYb7FuxglxUr5d9vv
 TcVcpOkxyNKQWLMVCCs3I1Q9mHSs/kc3qUFznB56Lqz/nnDYF4oDJufeBGuHuK4QCm+I
 /NGQ==
X-Gm-Message-State: AOJu0YwV2Q3r0dCKqEodN6nqnQKHRX/R9Tbt9ts9+muZ3scr7Qay7bv5
 U4qE6aLcblAEwuBbkn6LcoSFiKNUlcw5DlEyLFZUTNd1JJX2eO0jgZlVP7ARHKX7RCIL5PeRnpf
 8wPTd8/TjkxUoF280WTMCux+O02iBmya4p8f2Kb1sydBqnc6n
X-Google-Smtp-Source: AGHT+IF6Ma+vCkjJLsfsAMokAypuqDuLOn86Dmnuuk5pfu0mK0lQ25+wYfAD3Nvnc+OM+MIt8ESjKpYpy1P3uTDHViw=
X-Received: by 2002:aa7:d601:0:b0:5aa:32bb:161 with SMTP id
 4fb4d7f45d1cf-5b7f4294153mr442943a12.22.1722524312330; Thu, 01 Aug 2024
 07:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240730144035.3992996-1-sjg@chromium.org>
 <20240730144035.3992996-3-sjg@chromium.org>
In-Reply-To: <20240730144035.3992996-3-sjg@chromium.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 1 Aug 2024 20:28:21 +0530
Message-ID: <CADg8p94BuoZzqhjE8eioS8TOHP=iyEK6LkBsTys78hLTf54x_g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] lmb: Tighten up the code in lmb_add_region_flags()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 30 Jul 2024 at 20:10, Simon Glass <sjg@chromium.org> wrote:
>
> This function has more special cases than it needs. Simplify it to
> reduce code size and complexity.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  lib/lmb.c | 57 +++++++++++++++++++------------------------------------
>  1 file changed, 19 insertions(+), 38 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index c11ce308c5b..83b060a2f4d 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -396,14 +396,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>         if (alist_err(lmb_rgn_lst))
>                 return -1;
>
> -       if (alist_empty(lmb_rgn_lst)) {
> -               rgn[0].base = base;
> -               rgn[0].size = size;
> -               rgn[0].flags = flags;
> -               lmb_rgn_lst->count = 1;
> -               return 0;
> -       }
> -
>         /* First try and coalesce this LMB with another. */
>         for (i = 0; i < lmb_rgn_lst->count; i++) {
>                 phys_addr_t rgnbase = rgn[i].base;
> @@ -448,50 +440,39 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>                 }
>         }
>
> -       if (i < lmb_rgn_lst->count - 1 &&
> -           rgn[i].flags == rgn[i + 1].flags) {
> -               if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
> -                       lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
> -                       coalesced++;
> -               } else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
> -                       /* fix overlapping area */
> -                       lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
> -                       coalesced++;
> +       if (lmb_rgn_lst->count && i < lmb_rgn_lst->count - 1) {
> +               rgn = lmb_rgn_lst->data;
> +               if (rgn[i].flags == rgn[i + 1].flags) {
> +                       if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
> +                               lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
> +                               coalesced++;
> +                       } else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
> +                               /* fix overlapping area */
> +                               lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
> +                               coalesced++;
> +                       }
>                 }
>         }
>
>         if (coalesced)
>                 return coalesced;
>
> -       if (alist_full(lmb_rgn_lst)) {
> -               if (!alist_expand_by(lmb_rgn_lst, lmb_rgn_lst->alloc * 2))
> -                       return -1;
> -               else
> -                       rgn = lmb_rgn_lst->data;
> -       }
> +       if (!alist_add_placeholder(lmb_rgn_lst))
> +               return -1;
> +       rgn = lmb_rgn_lst->data;

I think the above should have a check for alist_full(), and then add
to the list if full. Else we simply go on adding to the list on every
new node that gets added.

>
>         /* Couldn't coalesce the LMB, so add it to the sorted table. */
>         for (i = lmb_rgn_lst->count - 1; i >= 0; i--) {
> -               if (base < rgn[i].base) {
> -                       rgn[i + 1].base = rgn[i].base;
> -                       rgn[i + 1].size = rgn[i].size;
> -                       rgn[i + 1].flags = rgn[i].flags;
> +               if (i && base < rgn[i - 1].base) {
> +                       rgn[i] = rgn[i - 1];
>                 } else {
> -                       rgn[i + 1].base = base;
> -                       rgn[i + 1].size = size;
> -                       rgn[i + 1].flags = flags;
> +                       rgn[i].base = base;
> +                       rgn[i].size = size;
> +                       rgn[i].flags = flags;
>                         break;
>                 }
>         }

With the logic that you put above, should the loop not have 'i'
initialised to lmb_rgn_lst-count? I mean

for (i = lmb_rgn_lst->count; i >= 0; i--)

Else we are overwriting one region?

-sughosh

>
> -       if (base < rgn[0].base) {
> -               rgn[0].base = base;
> -               rgn[0].size = size;
> -               rgn[0].flags = flags;
> -       }
> -
> -       lmb_rgn_lst->count++;
> -
>         return 0;
>  }
>
> --
> 2.34.1
>
