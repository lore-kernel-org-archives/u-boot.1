Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD92C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D38CB88B41;
	Thu,  1 Aug 2024 16:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EOazQbw6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8194788B39; Thu,  1 Aug 2024 16:42:28 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EFB388ADF
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6678a45eaa3so59572147b3.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722523345; x=1723128145; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6KH5U8fPwjIgCv4+dsyAsNHwnbC0IKhU3U1Bv+iXOqI=;
 b=EOazQbw699PlBcL2vk0wBrh4DFSLHWWjefxVNGvsG/gZhw4063rpo4XDpqkNpifDVo
 9ZlYAZR/REtPKSH+SNkoG/aQMJbRKRWKodQTjARS8GQs7RoWUoQU6IeDU12ZXvsWSLus
 IcyFHRq76QTQyXmk23xfCbAeZu3ou4Wt6+xf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523345; x=1723128145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6KH5U8fPwjIgCv4+dsyAsNHwnbC0IKhU3U1Bv+iXOqI=;
 b=r1J6SmZjtzmJVHRUVIyEmvDpLmr9+Z6YVrOQGQ7KT7amGngRZqlXeBQ6IwKjHIFFg/
 vQIEvQ4DK81Opk/UC4Ia6iD3a+TLU1JmoAFWpKpDS+Jfb469ktQg3m4iIF+eSUz8ftVU
 WeVlkkTQ1f1uAtV49gE4D9GTF3bY06+V1+r3DC7UeM42cQ0T0SiXhsa+lq/hayEVDTZu
 H1UTe/3VfV2RyOl5qAEyItBpNIXLuP60cVYcYrajS8XtdE7OXlSc0wNO8jNaVVcR0NSp
 nF4NuakH0x+WsSHrzEGC2swTH1MsrsLl+iSZznD7XZHKNdIl++2vVRQqrwI42BVtALlV
 V4bA==
X-Gm-Message-State: AOJu0YySB5QAEoOmV6uoqNw0FeaPj4WY6w/bICawoL1io8ocYqS8HXGX
 Z/Q3nLYwteneINyk5Tb9t+rdg8AHfpzIvRYJjC6mQxJsH8VimMkB3iaJHcEw87JKkbkuFe3ZPDA
 Wo2YlUpne65vkKsHbJdvwWh/VzzFnRJzodkY7
X-Google-Smtp-Source: AGHT+IEx5cMYSc8ZtDElmgf2HyAAybOd2BmzVUyFJMvDEbH8bTabjUyzfsffF1H8/1xkqSJ+sUxQKsz25KamvlTz3DI=
X-Received: by 2002:a81:c24e:0:b0:631:43e1:6b99 with SMTP id
 00721157ae682-689601ab907mr2837007b3.12.1722523345320; Thu, 01 Aug 2024
 07:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240731160754.16263-1-richard@nod.at>
In-Reply-To: <20240731160754.16263-1-richard@nod.at>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 08:42:14 -0600
Message-ID: <CAFLszThXjgSBHjUmbD1whpVnRvQO0rBXdYv60RS7DgXwrbzvKA@mail.gmail.com>
Subject: Re: [PATCH v2] bootstage: Fix out-of-bounds read in reloc_bootstage()
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, upstream+uboot@sigma-star.at, 
 patrick.delaunay@foss.st.com, marek.vasut+renesas@mailbox.org, 
 yangshiji66@outlook.com, xypron.glpk@gmx.de, eugeneuriev@gmail.com, 
 raymond.mao@linaro.org, devarsht@ti.com, bmeng.cn@gmail.com, 
 trini@konsulko.com
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

On Wed, 31 Jul 2024 at 10:08, Richard Weinberger <richard@nod.at> wrote:
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
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Changes since v1:
> - Pass gd->new_bootstage to bootstage_relocate()
> ---
>  common/board_f.c    | 8 +-------
>  common/bootstage.c  | 8 ++++++--
>  include/bootstage.h | 4 ++--
>  3 files changed, 9 insertions(+), 11 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

> diff --git a/common/board_f.c b/common/board_f.c
> index 29e185137a..21a8944e2b 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -683,13 +683,7 @@ static int reloc_bootstage(void)
>         if (gd->flags & GD_FLG_SKIP_RELOC)
>                 return 0;
>         if (gd->new_bootstage) {
> -               int size = bootstage_get_size();
> -
> -               debug("Copying bootstage from %p to %p, size %x\n",
> -                     gd->bootstage, gd->new_bootstage, size);
> -               memcpy(gd->new_bootstage, gd->bootstage, size);
> -               gd->bootstage = gd->new_bootstage;
> -               bootstage_relocate();
> +               bootstage_relocate(gd->new_bootstage);
>         }
>  #endif
>
> diff --git a/common/bootstage.c b/common/bootstage.c
> index b6c268d9f4..49acc9078a 100644
> --- a/common/bootstage.c
> +++ b/common/bootstage.c
> @@ -54,12 +54,16 @@ struct bootstage_hdr {
>         u32 next_id;            /* Next ID to use for bootstage */
>  };
>
> -int bootstage_relocate(void)
> +int bootstage_relocate(void *to)
>  {
> -       struct bootstage_data *data = gd->bootstage;
> +       struct bootstage_data *data;
>         int i;
>         char *ptr;
>
> +       debug("Copying bootstage from %p to %p\n", gd->bootstage, to);
> +       memcpy(to, gd->bootstage, sizeof(struct bootstage_data));
> +       data = gd->bootstage = to;

should be a separate line (patman/checkpatch complains)

> +
>         /* Figure out where to relocate the strings to */
>         ptr = (char *)(data + 1);
>
> diff --git a/include/bootstage.h b/include/bootstage.h
> index f4e77b09d7..57792648c4 100644
> --- a/include/bootstage.h
> +++ b/include/bootstage.h
> @@ -258,7 +258,7 @@ void show_boot_progress(int val);
>   * relocation, since memory can be overwritten later.
>   * Return: Always returns 0, to indicate success
>   */
> -int bootstage_relocate(void);
> +int bootstage_relocate(void *to);
>
>  /**
>   * Add a new bootstage record
> @@ -395,7 +395,7 @@ static inline ulong bootstage_add_record(enum bootstage_id id,
>   * and won't even do that unless CONFIG_SHOW_BOOT_PROGRESS is defined
>   */
>
> -static inline int bootstage_relocate(void)
> +static inline int bootstage_relocate(void *to)
>  {
>         return 0;
>  }
> --
> 2.35.3
>

Regards,
Simon
