Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01117D3610E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 19:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A538891AB;
	Tue,  5 Nov 2024 20:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wJ/mOChQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D49889099; Tue,  5 Nov 2024 20:18:59 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F4388CA2
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 20:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d473c4bb6so5231648f8f.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 11:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730834337; x=1731439137; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PfjjD/TYPV3kFvMMikEspJ+TId/MwMGuriVYlbUVe3w=;
 b=wJ/mOChQHjBVVhhfhNBSdGX+94VwrD7oxrA2nSlt2AvuGyOHSQ6UIAMVAQyrFODvLh
 YrUDqzGKpLOFQAjjLnn4n4VOgEEL5kCHSD4XUUk7+GFWibd+MksBHDXNICQOZ3axK/1T
 0GC5IfAE78Hdc9lN2AqYUt3sNDCK4az3q68PpfryhpaClzrPd3X81QE5KR8/qNeV8/93
 KT1EmTBWj1blBK1L/8a8d4C5xrxJq5NK9MPFa3K05+nIsM3eCOqqVx2WpWIDnkpYKKgl
 noUGHYQK0teAXOcv0X4Dwbz38iMBbok3pPj0MTrh2kLZyFgiW+KPGMmlv6XO7tws6Vn7
 cpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730834337; x=1731439137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PfjjD/TYPV3kFvMMikEspJ+TId/MwMGuriVYlbUVe3w=;
 b=G5ICwU5x+CglzwcdEGso0AaDuLvW4F/r2ZyJX9SRZgZXHro6i2T3wP+aIVQBxZ45pb
 Onxt5t/UBarInB6DTrFgeJQn1QHhkJ93uWpRoa4VM3YqBGsIECuh2rWfoZ+e3t2MRP2o
 uqpTb1YfpYPPSK+F2WwmpdiybyFgkkGhDt/6JxUbdPnjVYSeenJsGOInPQ8o3A3yDxIi
 G36nAJQpSpad5/YclQyn5g43GmPWJeYNx8tcnKYllbKy8wu9gcJJTeq5ZDcnF81CgwuB
 gvoWyT4DzL7RnHUcIbf2RTna+6BzF5KQoqkxZkJZw5ORgDReFM6zpiM61GZt7lIlqO0/
 iQYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViZlGG0L46yBkRedWallCnqJTlyRrffaoK1BcVglqSF5SnmidfrCTZETfKyc5BQfsk9JfjS6Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxN9rToYUbp6K67u+XGMKDcsQzDQ4q/RA1TPujHRbGE710wwyKm
 FbEUOcf2ei2XJgk7dILdXLkUYFGvmnCcgeLy/y0Ypn1LHIDPojp1+iWXPnpuYiTiEZBB+JfYdmB
 SP1ZxaKkv/WmPE+Rc5sVdg6hvvRNCLQr/UH55Yw==
X-Google-Smtp-Source: AGHT+IEuRSBehabbvkNJx+M+b8ih9GNfdpd/62pdHQcFeyFEBkvR25uw/ElZUmwjG68WsvOGTsdAeLnhD/v95s7BVdQ=
X-Received: by 2002:a05:6000:2c3:b0:37d:4eeb:7366 with SMTP id
 ffacd0b85a97d-381c7a461e4mr21153077f8f.4.1730834336850; Tue, 05 Nov 2024
 11:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <20241101-io_lmb_apple_dart_iommu-v1-3-fe4b9a74d47c@jannau.net>
In-Reply-To: <20241101-io_lmb_apple_dart_iommu-v1-3-fe4b9a74d47c@jannau.net>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 6 Nov 2024 00:48:45 +0530
Message-ID: <CADg8p95AbiUTFcmYrs0idPEyvq=hT78FzHbSiR3sPVCUh+ns4w@mail.gmail.com>
Subject: Re: [PATCH 3/4] lmb: Add basic io_lmb functionality
To: Janne Grunau <j@jannau.net>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Fri, 1 Nov 2024 at 15:47, Janne Grunau <j@jannau.net> wrote:
>
> These functions can be used with struct lmb pointers and will be used to
> manage IOVA space in the apple_dart iommu driver. This restores part of
> the pointer base struct lmb API from before commit ed17a33fed29 ("lmb:
> make LMB memory map persistent and global").
> io_lmb_add() and io_lmb_free() can trivially reuse exisiting lmb
> functions. io_lmb_setup() is separate for unique error log messages.
> io_lmb_alloc() is a simplified copy of _lmb_alloc_base() since the
> later has unused features and internal use of the global LMB memory map.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  include/lmb.h | 47 +++++++++++++++++++++++++++++++++++++
>  lib/lmb.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 121 insertions(+)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 2201d6f2b67bb605dbff015fa2a6a008b780c57a..9cb3ba8289e10ab92bea135d248580e44880e3e2 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -156,6 +156,53 @@ static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
>         return lmb_alloc_addr(addr, len) == addr ? 0 : -1;
>  }
>
> +/**
> + * io_lmb_setup() - Initialize LMB struct
> + * @lmb: IO LMB to initialize
> + *
> + * Add the IOVA space [base, base + size] to be managed by io_lmb.
> + *
> + * Returns: 0 on success, negative error code on failure
> + */
> +int io_lmb_setup(struct lmb *io_lmb);
> +
> +/**
> + * io_lmb_add() - Add an IOVA range for allocations
> + * @io_lmb: LMB to add the space to
> + * @base: Base Address of region to add
> + * @size: Size of the region to add
> + *
> + * Add the IOVA space [base, base + size] to be managed by io_lmb.
> + *
> + * Returns: 0 if the region addition was successful, -1 on failure
> + */
> +long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
> +
> +/**
> + * io_lmb_alloc() - Allocate specified IO memory address with specified alignment
> + * @io_lmb: LMB to alloc from
> + * @size: Size of the region requested
> + * @align: Required address and size alignment
> + *
> + * Allocate a region of IO memory. The base parameter is used to specify the
> + * base address of the requested region.
> + *
> + * Return: base IO address on success, 0 on error
> + */
> +phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
> +
> +/**
> + * io_lmb_free() - Free up a region of IOVA space
> + * @io_lmb: LMB to return the IO address space to
> + * @base: Base Address of region to be freed
> + * @size: Size of the region to be freed
> + *
> + * Free up a region of IOVA space.
> + *
> + * Return: 0 if successful, -1 on failure
> + */
> +long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
> +
>  #endif /* __KERNEL__ */
>
>  #endif /* _LINUX_LMB_H */
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 2ce91f7521cfe58577b092fdaea8004b17f0eeff..cbf1ee0df93a9cb0cfea571a4caebae09646595e 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -351,6 +351,80 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
>         return addr & ~(size - 1);
>  }
>
> +/*
> + * IOVA LMB memory maps using lmb pointers instead of the global LMB memory map.
> + */
> +
> +int io_lmb_setup(struct lmb *io_lmb)
> +{
> +       int ret;
> +
> +       ret = alist_init(&io_lmb->free_mem, sizeof(struct lmb_region),
> +                        (uint)LMB_ALIST_INITIAL_SIZE);
> +       if (!ret) {
> +               log_debug("Unable to initialise the list for LMB free IOVA\n");
> +               return -ENOMEM;
> +       }
> +
> +       ret = alist_init(&io_lmb->used_mem, sizeof(struct lmb_region),
> +                        (uint)LMB_ALIST_INITIAL_SIZE);
> +       if (!ret) {
> +               log_debug("Unable to initialise the list for LMB used IOVA\n");
> +               return -ENOMEM;
> +       }
> +
> +       io_lmb->test = false;
> +
> +       return 0;
> +}

In the current use case, the above data structure is getting allocated
as part of the driver's probe function. The resource should be free'd
from the driver's remove function -- that should happen through a
corresponding alist_uninit() call.

-sughosh

> +
> +long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
> +{
> +       return lmb_add_region_flags(&io_lmb->free_mem, base, size, LMB_NONE);
> +}
> +
> +/* derived and simplified from _lmb_alloc_base() */
> +phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align)
> +{
> +       long i, rgn;
> +       phys_addr_t base = 0;
> +       phys_addr_t res_base;
> +       struct lmb_region *lmb_used = io_lmb->used_mem.data;
> +       struct lmb_region *lmb_memory = io_lmb->free_mem.data;
> +
> +       for (i = io_lmb->free_mem.count - 1; i >= 0; i--) {
> +               phys_addr_t lmbbase = lmb_memory[i].base;
> +               phys_size_t lmbsize = lmb_memory[i].size;
> +
> +               if (lmbsize < size)
> +                       continue;
> +               base = lmb_align_down(lmbbase + lmbsize - size, align);
> +
> +               while (base && lmbbase <= base) {
> +                       rgn = lmb_overlaps_region(&io_lmb->used_mem, base, size);
> +                       if (rgn < 0) {
> +                               /* This area isn't reserved, take it */
> +                               if (lmb_add_region_flags(&io_lmb->used_mem, base,
> +                                                        size, LMB_NONE) < 0)
> +                                       return 0;
> +
> +                               return base;
> +                       }
> +
> +                       res_base = lmb_used[rgn].base;
> +                       if (res_base < size)
> +                               break;
> +                       base = lmb_align_down(res_base - size, align);
> +               }
> +       }
> +       return 0;
> +}
> +
> +long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
> +{
> +       return _lmb_free(&io_lmb->used_mem, base, size);
> +}
> +
>  /*
>   * Low level LMB functions are used to manage IOVA memory maps for the Apple
>   * dart iommu. They must not access the global LMB memory map.
>
> --
> 2.47.0
>
