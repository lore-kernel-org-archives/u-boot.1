Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B2BC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 204F0888BE;
	Sat, 13 Jul 2024 17:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kjJWxviG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA71F87E13; Sat, 13 Jul 2024 17:14:25 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B691D88831
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c964f5a037so2134843a91.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883662; x=1721488462; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vZrjQ8hRvfO+5KfkMLopCCvcfkg7XDTs8HTA3Buim24=;
 b=kjJWxviGUvW6uG9VredccFuiT6iFmUDZV5lKSbz/kBrNp+5bE66Z3xi0jH42oAtjf9
 AFVVqb3c30b2YRTAuHgPA7e7+DxxWVGCtJDUmTWzWq2t6dBJCyRpIrKHgi8hKL7zjY2V
 u3EulDO6pAAWTJsVGPhx+uNVA+wuA5ptBi4EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883662; x=1721488462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZrjQ8hRvfO+5KfkMLopCCvcfkg7XDTs8HTA3Buim24=;
 b=wyrYd5iECeiLFeWzEMZW6UgihlumwKolTTQYC+Z364fzk2RA86vkjQ5pxn9VxBk+xg
 75eBOlwWOHC9dkr23xAWYhtZmTvRU/MxYvoVJEbMTIqw8PGMiiFsY5AwIyMyAaMv7497
 FbVVr9My6udAIUiJION2NlfOuaU0uqKDGXLQNaVLaDQnOwE4wUIe98KFvLZTcfjZnsMr
 nrAM/PtCoMPnUZie4ZjtnatMYasAZsBpqDSq5dtymKg0McUg8KMd3TetytTt4/h5iIYT
 Nxs+LtyqiE60m/dRUy4vk6VjkQsNW/422A4QxDRZZxNIqCKvOMv8RVrAEhUwmzDJPch1
 TutA==
X-Gm-Message-State: AOJu0YzTLWr2v/+OrK/pjxDhNWZDQHfcYHBZigkuJJwHZF0n33xBC3uy
 Up7C8Zz7XDmaL22Tiw7bd/Apl4QYdNG6I93hn7FNmjcZWuinPK4XplZ4/hicB2YWbUmu8pnuWHT
 BX3y+b7kYia1oMhyd/9IMrJPKjXv4FLu8CXML
X-Google-Smtp-Source: AGHT+IGKRSvrAx8lGVmhJLUKu/NBpMQLJID5qW0Mu9t0NPLYpCtj9JHbvojaDB+JAeykOQm5KfsgOM16ZDzTmRM9CzU=
X-Received: by 2002:a17:90a:17e4:b0:2c9:6928:ac9b with SMTP id
 98e67ed59e1d1-2ca35c27e18mr11850252a91.15.1720883662220; Sat, 13 Jul 2024
 08:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240712081118.29189-1-richard@nod.at>
In-Reply-To: <20240712081118.29189-1-richard@nod.at>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:50 +0100
Message-ID: <CAFLszTg-bqTTv2NtVC-3m2O2nw+9eczcM9_wn41u6XMcujqNEQ@mail.gmail.com>
Subject: Re: [PATCH] reloc_bootstage: Fix out-of-bounds read
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, patrick.delaunay@foss.st.com, 
 yangshiji66@outlook.com, raymond.mao@linaro.org, n-jain1@ti.com, 
 eugeneuriev@gmail.com, ilias.apalodimas@linaro.org, devarsht@ti.com, 
 bmeng.cn@gmail.com, trini@konsulko.com, upstream+uboot@sigma-star.at
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

Hi Richard,

On Fri, 12 Jul 2024 at 09:11, Richard Weinberger <richard@nod.at> wrote:
>
> bootstage_get_size() returns the total size of the data structure
> including associated records.
> When copying from gd->bootstage, only the allocation size of gd->bootstage
> must be used. Otherwise too much memory is copied.
>
> This bug caused no harm so far because gd->new_bootstage is always
> large enough and reading beyond the allocation length of gd->bootstage
> caused no problem due to the U-Boot memory layout.
>
> Fix by using the correct size and perform the initial copy directly
> in bootstage_relocate() to have the whole relocation process in the
> same function.

Nice commit message.

Can you use 'bootstage' as the commit tag?

>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  common/board_f.c   | 6 ------
>  common/bootstage.c | 7 ++++++-
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index 039d6d712d..f4d87692b9 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -683,12 +683,6 @@ static int reloc_bootstage(void)
>         if (gd->flags & GD_FLG_SKIP_RELOC)
>                 return 0;
>         if (gd->new_bootstage) {
> -               int size = bootstage_get_size();
> -
> -               debug("Copying bootstage from %p to %p, size %x\n",
> -                     gd->bootstage, gd->new_bootstage, size);
> -               memcpy(gd->new_bootstage, gd->bootstage, size);
> -               gd->bootstage = gd->new_bootstage;
>                 bootstage_relocate();
>         }
>  #endif
> diff --git a/common/bootstage.c b/common/bootstage.c
> index 0e6d80718f..aea5a318df 100644
> --- a/common/bootstage.c
> +++ b/common/bootstage.c
> @@ -58,10 +58,15 @@ struct bootstage_hdr {
>
>  int bootstage_relocate(void)
>  {
> -       struct bootstage_data *data = gd->bootstage;
> +       struct bootstage_data *data;
>         int i;
>         char *ptr;
>
> +       debug("Copying bootstage from %p to %p\n", gd->bootstage,
> +             gd->new_bootstage);
> +       memcpy(gd->new_bootstage, gd->bootstage, sizeof(struct bootstage_data));

I would like to have the relocation addresses in board_f like with
other relocations, so it is easy to see what is happening, in one
file. So how about passing the old address to bootstage_relocate() so
it doesn't need to access gd->new_bootstage ?

> +       data = gd->bootstage = gd->new_bootstage;
> +
>         /* Figure out where to relocate the strings to */
>         ptr = (char *)(data + 1);
>
> --
> 2.35.3
>

Regards,
Simon
