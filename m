Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797ADE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 06:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BA788DC6;
	Sun,  8 Dec 2024 07:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SJ5e7xN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6576894AD; Sun,  8 Dec 2024 07:55:45 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8984688DC6
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 07:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6efa5bf5202so33517457b3.3
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 22:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733640942; x=1734245742; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ifULzhYlPn/gqbJJbda48GIH3lae5nrTK9ByUvZVtpU=;
 b=SJ5e7xN/war7zuxupBYhOtW/5z3o5W7Pno60FgbbH3gd/6d1rHNsBCWS+x7HRI1B1N
 yYKTkt60jSMZ0PXLrQZrlmmEQ3qIdDHPy56R82oneBoiro16Z1gPc90EtpDrYgA67Szr
 zMrk7MR8wkftmNZGi6zwdG8Iiduw3No09K5EVaxz+dLeG9E+KIAgxOLsvo2ZVMJTR2tN
 9cTm4eLv3/FWTh6Zyl/x6tW6xwB0AmrdZO2W1KBRRiKWSMNvrpH5/4EHUgSO+MF5PvzR
 hM3yYUq54sCKU+c3WpJf++UrTbOYkCNyrd5YVg8EqI5go8z55QMDxg37MBFHWVWNouYC
 /lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733640942; x=1734245742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ifULzhYlPn/gqbJJbda48GIH3lae5nrTK9ByUvZVtpU=;
 b=WBE/1BDTBOPyiMUrGLvMh7ruojkQDESsftpYWSPvKEFXDKsM4SmGx3nI+mWQTLXzXE
 KggM1DigTnqPEDnJXu77qDTnH4n5f25hcujdtOC/71YaPyJHoktDnjo4y+mxDiMeob2B
 gBK7jYOdX8D8b8ZiNXuRIsMKjPLnejlhvi2SSAFpVvgzXZIWCBVvEbN5Jyf3K4LeL4l3
 gu5gzksoqnwk30O8jnnpozblFBww7zeO6hdyFymnGCvmCoO+qKt79mlnWjnIH5wdNuf0
 ioylApLXejTvRa4ZK4uJjv5mspI+pV/yN+qfmRKikD3QNfagV7mHeVpQUauq7noZd+nF
 TGAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/v48HnU7mCXtTojrRKhkqEcWoWvZ46Mg21OiErtsHhKhVG78UerjY5gb7PBi09DLag8vr6EE=@lists.denx.de
X-Gm-Message-State: AOJu0YxtFOmh5wDChIP5VyI9iqjrVepGTX379uDJm2WVTG1WP8ylUQjN
 JpYjDVZ45kmOWld6sD6jk9vU3Zqx9R4AKkLSkxlVruUWC5mLK2HZQ4vXPTKh6zZhPYFg5O91Bee
 7BuLKVqNALF7nc4dwRTUETB1KO9gzuWynciz+mQ==
X-Gm-Gg: ASbGnctuT3Ay6O3QOCsUsgW8ciuJ0fvHyKrrhWFYev03hXja4jyaIECk8l+IVXsIAhe
 q20qL36GDm3gURR/VunRJDDbJQiqztHE=
X-Google-Smtp-Source: AGHT+IHKHdJmDAEUjfm8Eu5mZXXlK9BWFptVzqLNMdvZ+WHBSOXezAj/9UnqwG2tMGLKW72xphia6f6VuOMQaqZJxhc=
X-Received: by 2002:a05:690c:67c7:b0:6ef:4fba:8137 with SMTP id
 00721157ae682-6efe3bce656mr100041237b3.6.1733640942371; Sat, 07 Dec 2024
 22:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
 <20241208002121.31887-5-semen.protsenko@linaro.org>
In-Reply-To: <20241208002121.31887-5-semen.protsenko@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 08:55:06 +0200
Message-ID: <CAC_iWjJMjNNWibDeH8bVaC+AW+zf2X5V8hbR9dHo4nZnU2zyKw@mail.gmail.com>
Subject: Re: [PATCH 4/6] lmb: Improve coding style
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 02:21, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Fix checkpatch warnings. No functional change.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  lib/lmb.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 1642ce48bbbd..8c1c9b0f67c8 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -57,7 +57,6 @@ static long lmb_regions_overlap(struct alist *lmb_rgn_lst, unsigned long r1,
>                                 unsigned long r2)
>  {
>         struct lmb_region *rgn = lmb_rgn_lst->data;
> -
>         phys_addr_t base1 = rgn[r1].base;
>         phys_size_t size1 = rgn[r1].size;
>         phys_addr_t base2 = rgn[r2].base;
> @@ -70,11 +69,11 @@ static long lmb_regions_adjacent(struct alist *lmb_rgn_lst, unsigned long r1,
>                                  unsigned long r2)
>  {
>         struct lmb_region *rgn = lmb_rgn_lst->data;
> -
>         phys_addr_t base1 = rgn[r1].base;
>         phys_size_t size1 = rgn[r1].size;
>         phys_addr_t base2 = rgn[r2].base;
>         phys_size_t size2 = rgn[r2].size;
> +
>         return lmb_addrs_adjacent(base1, size1, base2, size2);
>  }
>
> @@ -235,9 +234,9 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>
>                                 coalesced++;
>                                 break;
> -                       } else {
> -                               return -1;
>                         }
> +
> +                       return -1;
>                 }
>         }
>
> @@ -288,14 +287,17 @@ static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
>         phys_addr_t end = base + size - 1;
>         int i;
>
> -       rgnbegin = rgnend = 0; /* supress gcc warnings */
> +       /* Suppress GCC warnings */
> +       rgnbegin = 0;
> +       rgnend = 0;
> +
>         rgn = lmb_rgn_lst->data;
>         /* Find the region where (base, size) belongs to */
>         for (i = 0; i < lmb_rgn_lst->count; i++) {
>                 rgnbegin = rgn[i].base;
>                 rgnend = rgnbegin + rgn[i].size - 1;
>
> -               if ((rgnbegin <= base) && (end <= rgnend))
> +               if (rgnbegin <= base && end <= rgnend)
>                         break;
>         }
>
> @@ -304,7 +306,7 @@ static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
>                 return -1;
>
>         /* Check to see if we are removing entire region */
> -       if ((rgnbegin == base) && (rgnend == end)) {
> +       if (rgnbegin == base && rgnend == end) {
>                 lmb_remove_region(lmb_rgn_lst, i);
>                 return 0;
>         }
> @@ -340,6 +342,7 @@ static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
>         for (i = 0; i < lmb_rgn_lst->count; i++) {
>                 phys_addr_t rgnbase = rgn[i].base;
>                 phys_size_t rgnsize = rgn[i].size;
> +
>                 if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
>                         break;
>         }
> @@ -715,7 +718,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size)
>  }
>
>  static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
> -                                   phys_addr_t max_addr, enum lmb_flags flags)
> +                                  phys_addr_t max_addr, enum lmb_flags flags)
>  {
>         int ret;
>         long i, rgn;
> @@ -730,16 +733,18 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
>
>                 if (lmbsize < size)
>                         continue;
> -               if (max_addr == LMB_ALLOC_ANYWHERE)
> +
> +               if (max_addr == LMB_ALLOC_ANYWHERE) {
>                         base = lmb_align_down(lmbbase + lmbsize - size, align);
> -               else if (lmbbase < max_addr) {
> +               } else if (lmbbase < max_addr) {
>                         base = lmbbase + lmbsize;
>                         if (base < lmbbase)
>                                 base = -1;
>                         base = min(base, max_addr);
>                         base = lmb_align_down(base - size, align);
> -               } else
> +               } else {
>                         continue;
> +               }
>
>                 while (base && lmbbase <= base) {
>                         rgn = lmb_overlaps_region(&lmb.used_mem, base, size);
> @@ -813,7 +818,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
>  }
>
>  static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> -                                   enum lmb_flags flags)
> +                                  enum lmb_flags flags)
>  {
>         long rgn;
>         struct lmb_region *lmb_memory = lmb.free_mem.data;
> --
> 2.39.5
>


Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
