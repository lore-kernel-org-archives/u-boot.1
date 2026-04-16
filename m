Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8165CF8A144
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 08:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB5E2840AB;
	Thu, 16 Apr 2026 10:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X9MFBtQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D4384105; Thu, 16 Apr 2026 10:40:23 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85EDC8407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6501d242e3fso7355196d50.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 01:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776328818; cv=none;
 d=google.com; s=arc-20240605;
 b=b0t5qYN8EagEaZNwibB0hzU8xVzF97ccvTxH5gLEOJFr0FuXG/GgLGumIBzPlyc6qH
 bfFlpGV4RkIcXkJ5DkHgzMOgxuEwPQgNez2kZ+L5hcsL+DliUHePAfo8mSPzpwFdAno2
 F6xLoYW9QZnNhlsjxKOxPOhhZ09w+T1fcaY/ZAKR+gOnI2c403XVq5f4TWnlXjJVkFMv
 dW2bibfHpeq8EZmky/28S9CZKAN4YOT47Xsd6XzTjWGHRrOpULjsxEdKMDj7njoP5R7c
 V4vveeAn6kg475y/OpVhURrVgxXvmjOZhVqwnLiMxDczAusKa9RBrc0kf/wsKcDY8MZC
 L1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mNQYUBOFLt8gLA6wBRUxSvTcMRR3+8XSkpsYoUhjP/s=;
 fh=o4Xx3yszQT+GTqIl9cNlWhIM7FZfrNfcgLNrzrH0NeE=;
 b=TfMFzac+361AsUsJ7ER61dASQd8hdwbOeGa167MhPO6V2wzVqMq7ABLwutTdYT2BrE
 5pEsnJHKJ7ePi6mFHyguSQXDbcU4W4SPLa4JIXz+JCLDVTKLWrcCBefEC6Q72b4ekVz8
 nN40s2XMMlQRO55pBcUK1ZAImgp4pXHMPAeu1WZSzGG5z8KhZdF//q1h0ZYTv4MaH77t
 qIw4zY20DyR6qGPkM6yBHP5edln1L2K5SVoW6fzXySqQ/AAweXj59XHx7HivJUllqUYM
 qox3Tv6PPjXQ8aSl3bNxmI9yWFFlkARtup3raVFy5aiz9ebwYom7RYKQQkr5ajpwRNjK
 0aSw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776328818; x=1776933618; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mNQYUBOFLt8gLA6wBRUxSvTcMRR3+8XSkpsYoUhjP/s=;
 b=X9MFBtQ9PpjetQcx0mftPkmiOaj4mj2AeS0yqhwE9RHocxfkcUgFtTAbYvPYNvQaGH
 uWbzdvSA+Z1946zsCLnaFhougebBm70HGYR4LQCpdpsHtv6ZAU2K5ROGXJ+TNsdV66rB
 iU95GJLu7PEm1IBkpblcGM2HNSeTe5izFulUCEKQez6l5cQtL2BuBPyyNpQMeXo4Vk+f
 5GsRa1m2KdN+7UU7WNP/WwrE4zMH5kK0OCj05J4EArn3L91OPLTb57Qa0r1EkcAYqpbc
 6NUgj9OT99Lm1bfgD726uH8kQGh/t1gJv4xoKXfTBAumagB0wXGQnbXc4XqkhDp43FEE
 TRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776328818; x=1776933618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNQYUBOFLt8gLA6wBRUxSvTcMRR3+8XSkpsYoUhjP/s=;
 b=N9OxBrcuLZK63K0mDeSkanJ1WOutH9JK2AJn3is3xJxmR4YGVyLM3s9WcPWxFJ1Sbu
 MLEjh+bnzjV25IosehDUUOj+i0lswDs9SvDjBF8d9rH5ZDpmzML2k2mx9LKNisXCFQW3
 BRKKwfy8N/QYCJNecjzuDCYwmqKgF9rcn0DU5YFkWFVZexnDQlXXFPkk0bnBFny7WeX8
 pL9Xw+xj91e5CrlXDYBKo1aUbvOdYbHoWsMycxjEZ+r2RBUKHQ5Kwf3p7Klw5wdWzP3V
 E0lhUCQsRheVcfRo5/bCnJbqNl1uDtfd22t9n7cndlekbFfoaKXwzwgbiiUWXj0aipD4
 ggtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ajKKAQhN0mo9vdSCa4Fy4DKOgEwMWlC6OlhnHixFGhM+T0/wfOqcwtR5C9AH0j6eWMIGQtHI=@lists.denx.de
X-Gm-Message-State: AOJu0YyemahWP6WpDdWBSrJllD+2d2hDFdVmhFlZOHUEV2W4djd05j73
 k7piZauZrlFSC9wuQ9wQqMgrXoQqnb1qYd0dRC5o2SmqvPpgeaCjSVDAAR79aL6SbbteRfGG5Jt
 UTQn0JB70NBKz0KUrCVTdoHCWNinuAarXgzodwKg+3Q==
X-Gm-Gg: AeBDiesgxDVqx5gH852vVNqPgAi5GDOnKrWh9Mq2JLUtiN0I+oW8muRem1McXMaps2F
 vX7ifgCxfcgbYEL49SpRGuZZhUyMrqUNdSzHzSlqMj7dysXY6dOAfSIqlNxPQ5aF4ZAkR3rYTNk
 dWxwjqMsiiyBaJFZM1WMKIjbQhKwjQj6PHh9OSVbXvVGNAtAiHkA+NIxwqxt/1hYlAX1ODc6G1v
 mgAdd7rovnqdmgUNzoVDy8aQlv//Uju6+UmCO9wjx/tY4vXS4AqeR8LyO+5oCZ8MlLosX2IXuUG
 7EzgLX000ki7AeM8b+zD/1K521fiNO8kHVU7z37SGJOxNWj8XaI2cE1ZbYTTiZ2lFDJRjxfhVAH
 rvVM0rbJAlJH5qR+lTAwbXSKXHNIWWVXa5twwiD101k5w6rqLA+ui3MTLZjlOL8CKEaXCS86p9k
 slywoASGA+uUPJBe+5t5t0HFWGbdEpsiyOkopDekCdKPgN0EcmmsLsjP9PqsTAyRa4AMRAcTMPd
 c0zSH56WLA9RykmhceRdlkzhaEkqIDJGgYt69wXqyTCyF9DaNHN2DIhJYQMx6rKhE97aQpOXvCJ
 jrCblkSR6LrJDm/ha3sWMXfYpCy6v4Nm4f0JeqfVsM/e
X-Received: by 2002:a05:690e:1919:b0:651:b2e4:63c1 with SMTP id
 956f58d0204a3-651b2e466a6mr18206158d50.22.1776328818184; Thu, 16 Apr 2026
 01:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
In-Reply-To: <20260413203555.1990337-3-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Apr 2026 11:39:41 +0300
X-Gm-Features: AQROBzAys3d14NMq73lxoXvhFyr7G5no-L4gZUVGQNgKezTWVjmjJsX5NboD-z4
Message-ID: <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

Hi Randolph.

On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> parsing a new device tree and properly warn people when a reservation
> overlaps with an existing allocation.

The LMB has a set of regions that clearly describe memory in an
abstact way, e.g reserved, no overwrite etc.
I don't think adding we should open the door for treating reserved
memory as special. Can't we apply the same fix without adding a new
description?

Thanks
/Ilias
>
> If we don't at least warn the user of these reservation failures,
> there's a chance that this region could be freed and reallocated for
> something important later.
>
> This useful warning mechanism was broken in:
> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  boot/image-fdt.c |  5 ++++-
>  include/lmb.h    | 14 ++++++++++++++
>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
>  3 files changed, 47 insertions(+), 5 deletions(-)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index a3a4fb8b558..0f5857f24d2 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
>  {
>         long ret;
>         phys_addr_t rsv_addr;
> +       flags |= LMB_FDT;
>
>         rsv_addr = (phys_addr_t)addr;
>         ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
>                 debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
>                       (unsigned long long)addr,
>                       (unsigned long long)size, flags);
> -       } else if (ret != -EEXIST && ret != -EINVAL) {
> +       } else if (ret != -EINVAL) {
>                 puts("ERROR: reserving fdt memory region failed ");
>                 printf("(addr=%llx size=%llx flags=%x)\n",
>                        (unsigned long long)addr,
> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
>         if (fdt_check_header(fdt_blob) != 0)
>                 return;
>
> +       lmb_free_fdt_regions();
> +
>         /* process memreserve sections */
>         total = fdt_num_mem_rsv(fdt_blob);
>         for (i = 0; i < total; i++) {
> diff --git a/include/lmb.h b/include/lmb.h
> index 427d701bc30..c6a1fc1ca47 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -51,6 +51,15 @@
>   */
>  #define LMB_NONOTIFY BIT(3)
>
> +/**
> + * define LMB_FDT - reclaim this region with lmb_free_fdt_regions()
> + *
> + * LMB Memory region attribute flag to indicate that the region will be
> + * reclaimed with lmb_free_fdt_regions(). This allows device tree reservations
> + * to be cleaned up and tracked more granularly.
> + */
> +#define LMB_FDT BIT(4)
> +
>  /**
>   * enum lmb_mem_type - type of memory allocation request
>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region of memory
> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
>   */
>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
>
> +/**
> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserved regions
> + */
> +void lmb_free_fdt_regions(void);
> +
>  #endif /* __KERNEL__ */
>
>  #endif /* _LINUX_LMB_H */
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 8f12c6ad8e5..7ecc548d831 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
>
>  static void lmb_print_region_flags(u32 flags)
>  {
> -       const char * const flag_str[] = { "none", "no-map", "no-overwrite",
> -                                         "no-notify" };
> -       unsigned int pflags = flags &
> -                             (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
> +       const char *const flag_str[] = { "none", "no-map", "no-overwrite",
> +                                        "no-notify", "fdt" };
> +       unsigned int pflags =
> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY | LMB_FDT);
>
>         if (flags != pflags) {
>                 printf("invalid %#x\n", flags);
> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
>  }
>
> +void lmb_free_fdt_regions(void)
> +{
> +       struct alist *lmb_rgn_lst = &lmb.used_mem;
> +       struct lmb_region *rgn = lmb_rgn_lst->data;
> +       long ret;
> +       int i = 0;
> +
> +       while (i < lmb_rgn_lst->count) {
> +               phys_addr_t base = rgn[i].base;
> +               phys_size_t size = rgn[i].size;
> +               u32 flags = rgn[i].flags;
> +
> +               if (flags & LMB_FDT) {
> +                       ret = lmb_free(base, size, flags);
> +                       if (ret < 0) {
> +                               printf("Unable to free FDT memory at 0x%08lx\n",
> +                                      (ulong)base);
> +                               i++;
> +                       }
> +               } else {
> +                       i++;
> +               }
> +       }
> +}
> +
>  static int _lmb_alloc_base(phys_size_t size, ulong align,
>                            phys_addr_t *addr, u32 flags)
>  {
> --
> 2.53.0
>
