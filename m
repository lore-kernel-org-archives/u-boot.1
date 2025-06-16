Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E99DC71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 10:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3AB88210D;
	Mon, 16 Jun 2025 12:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hi2W1cGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F30E829F5; Mon, 16 Jun 2025 12:08:13 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2EC82063
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 12:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6ff4faf858cso29764077b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750068490; x=1750673290; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F/mnU4fiMYcAT2fQbWGtQp/vmpq3tIOnKEboSp4uHtc=;
 b=hi2W1cGSCDYKVw+rXTDWwF26hSZy/4ML5SQ3rMidhu6yRs6Wsroyh7RoU5Mq8Y+jxL
 lWTK7JzJGCSHjTYpqzro76wM7Kzfrlmy9KpxZxqgfittrAnME2yCcjPHHd8/aFswvxsq
 wb1WgOE7qP4S+brP+ZYwQzrOQ4v7asWi/CPHiMejhynEi9nB+46rMoa96oaZx9xRyrcd
 AZDjVcyyLq4LPt9gmcV/Kau0i69K8BOHETUu9NkLCgS60keUoiYBUdY/uGnXNo/6IvM/
 mXP8OBVq0FUovo+KmcSbAn7lZSTMQCPhjMGDCwxEhIX3TrINQ8NAZ7uOjKm6698E03RJ
 X6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750068490; x=1750673290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F/mnU4fiMYcAT2fQbWGtQp/vmpq3tIOnKEboSp4uHtc=;
 b=WlBbttRF8mudcmKsD/63csWdckF9BQPc6tlxUlZMNsqspYWjfJQuncm8NYON5BhrrX
 oVY2k2Ptq7t6kLBUAUWEgW2iNAVFiCLQlUHFAtjcmAj3or6kRp1yroNQe7o82xJuOThf
 IWGeQUKV+uOtflUqo9RW7J7xfohkwc3WobkgNgp5LhUM7Dn6VTeu+/27HzcwKZ8y3VZv
 mTKpDjyqWorALsxbFMldcIH/mD8DBKxZZgnFNqxE4Kin7RbkGNsZi1ifjVyATs94n1Dg
 0Qi/Oapm4YKbDMWBw91pmd/9aeQVehPsfshkK/arQFB4g6knDJL5q3aj8TlyssGIPTin
 CgWA==
X-Gm-Message-State: AOJu0Yxj5jYVgcDPrH0hshIclH9AyxX+nqo9FSy7sX1FI1jiBMWoBkKM
 xkC9qS9wfx1Y0qMaJZ7gLBQZbIukqtwSqfSGvUDPhPNSSbHQ0j1uKAao13t4FYfOHQoQ1BAzdOb
 I1AaRwTObp8nXxQNDfcSwNqptYQdbBjvRfoWZyqsJXQ==
X-Gm-Gg: ASbGnctUUZPSqqrhBmmokn2ueHwQ0r9dvMR2ENjKjxx+WR/ARq5PQRFkTHr6wyK5L2Y
 A5Gdh7X9/DNuvRU0Fk061Fd8GZZwEttSxxX0F9FynjsscNpPOCKfn/+Q2RKLf4QnVjpfe9xuJrz
 DPUodOIqsGvE19GAbd4XRayJJE4bnlkbfjM1R/zWppLIby
X-Google-Smtp-Source: AGHT+IHaQYozpHDU6z0SNqV7xiSA3EFocbbZCdMJuNq15gsbZk33VlSGLunEOEVMJKspVEWQifpAV5WJibK3j2+hFFQ=
X-Received: by 2002:a05:690c:4d83:b0:70d:f3f9:1898 with SMTP id
 00721157ae682-7117547b057mr124060067b3.35.1750068490096; Mon, 16 Jun 2025
 03:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250612065624.751014-1-sughosh.ganu@linaro.org>
 <20250612065624.751014-2-sughosh.ganu@linaro.org>
In-Reply-To: <20250612065624.751014-2-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 13:07:34 +0300
X-Gm-Features: AX0GCFuq6JerWMnXkahimg-N_XOKtGys6BZTM5uVUTnqvhen-O3nCb7-KFA9Quw
Message-ID: <CAC_iWj+jGZXbwuaJr+9Cqto35y+xFS8e91=Zd_eNb2a8fNa6PQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] lmb: replace lmb_reserve() and lmb_alloc_addr()
 API's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

Hi Sughosh

[...]


> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -488,6 +488,54 @@ void lmb_dump_all(void)
>  #endif
>  }
>
> +/**
> + * lmb_can_reserve_region() - check if the region can be reserved
> + * @base: base address of region to be reserved
> + * @size: size of region to be reserved
> + * @flags: flag of the region to be reserved
> + *
> + * Go through all the reserved regions and ensure that the requested
> + * region does not overlap with any existing regions. An overlap is
> + * allowed only when the flag of the request region and the existing
> + * region is LMB_NONE.
> + *
> + * Return: true if region can be reserved, false otherwise
> + */
> +static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
> +                                  u32 flags)
> +{
> +       uint i;
> +       struct lmb_region *lmb_reserved = lmb.used_mem.data;
> +
> +       for (i = 0; i < lmb.used_mem.count; i++) {
> +               u32 rgnflags = lmb_reserved[i].flags;
> +               phys_addr_t rgnbase = lmb_reserved[i].base;
> +               phys_size_t rgnsize = lmb_reserved[i].size;
> +
> +               if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> +                       if (flags != LMB_NONE || flags != rgnflags)
> +                               return false;
> +               }
> +       }
> +
> +       return true;
> +}
> +
> +static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
> +{
> +       long ret = 0;
> +       struct alist *lmb_rgn_lst = &lmb.used_mem;
> +
> +       if (!lmb_can_reserve_region(base, size, flags))
> +               return -EEXIST;
> +
> +       ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
> +       if (ret)
> +               return ret;
> +
> +       return lmb_map_update_notify(base, size, LMB_MAP_OP_RESERVE, flags);
> +}
> +
>  static void lmb_reserve_uboot_region(void)
>  {
>         int bank;
> @@ -557,39 +605,6 @@ static __maybe_unused void lmb_reserve_common_spl(void)
>         }
>  }
>
> -/**
> - * lmb_can_reserve_region() - check if the region can be reserved
> - * @base: base address of region to be reserved
> - * @size: size of region to be reserved
> - * @flags: flag of the region to be reserved
> - *
> - * Go through all the reserved regions and ensure that the requested
> - * region does not overlap with any existing regions. An overlap is
> - * allowed only when the flag of the request region and the existing
> - * region is LMB_NONE.
> - *
> - * Return: true if region can be reserved, false otherwise
> - */
> -static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
> -                                  u32 flags)
> -{
> -       uint i;
> -       struct lmb_region *lmb_reserved = lmb.used_mem.data;
> -
> -       for (i = 0; i < lmb.used_mem.count; i++) {
> -               u32 rgnflags = lmb_reserved[i].flags;
> -               phys_addr_t rgnbase = lmb_reserved[i].base;
> -               phys_size_t rgnsize = lmb_reserved[i].size;
> -
> -               if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> -                       if (flags != LMB_NONE || flags != rgnflags)
> -                               return false;
> -               }
> -       }
> -
> -       return true;
> -}
> -
>  void lmb_add_memory(void)
>  {
>         int i;
> @@ -657,21 +672,6 @@ long lmb_free(phys_addr_t base, phys_size_t size)
>         return lmb_free_flags(base, size, LMB_NONE);
>  }
>
> -long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
> -{
> -       long ret = 0;
> -       struct alist *lmb_rgn_lst = &lmb.used_mem;
> -
> -       if (!lmb_can_reserve_region(base, size, flags))
> -               return -EEXIST;
> -
> -       ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
> -       if (ret)
> -               return ret;
> -
> -       return lmb_map_update_notify(base, size, LMB_MAP_OP_RESERVE, flags);
> -}
> -
>  static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
>                                    phys_addr_t max_addr, u32 flags)
>  {
> @@ -742,7 +742,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
>         return _lmb_alloc_base(size, align, max_addr, flags);
>  }
>
> -int lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
> +static int _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
>  {
>         long rgn;
>         struct lmb_region *lmb_memory = lmb.available_mem.data;
> @@ -756,14 +756,37 @@ int lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
>                  */
>                 if (lmb_addrs_overlap(lmb_memory[rgn].base,
>                                       lmb_memory[rgn].size,
> -                                     base + size - 1, 1)) {
> +                                     base + size - 1, 1))
>                         /* ok, reserve the memory */
> -                       if (!lmb_reserve(base, size, flags))
> -                               return 0;
> -               }
> +                       return lmb_reserve(base, size, flags);
> +               else
> +                       return -EINVAL;

You don't need the else here

> +       }
> +
> +       return -EINVAL;
> +}

[...]

Other than that
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
