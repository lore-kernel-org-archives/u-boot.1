Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7556E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 06:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D50801DA;
	Wed, 11 Dec 2024 07:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h3Ct6Bop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63563801DD; Wed, 11 Dec 2024 07:16:30 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DB4A801CF
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e3824e1adcdso4858516276.3
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 22:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733897787; x=1734502587; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r8jhA/NSLAssAHgAVJVEDUOcVh/WbWZyii5BXcThumE=;
 b=h3Ct6Bopc9kpFAJGG9vIB2s67EL2oz4knN/XBXJ+xmV5UNqvH0pB1oZ7bcKNLnm7Vw
 gFfpGfDqQ7RaGI1HEopW+1Lqc6wUGP+ENBTSCgqD04B9r9/oBqAKGpjLJz8QTmguxL1c
 BvyVAS+kBXguS4dN3fa6uR7FpvpLUrN/Rl9K1sozb+aD56uU/fMa1aYGdXey3RoKEI65
 psTpwSvwD79nUqHQw03fT8NerSLh7TN8X6VdnBz1AbKGHPB3rm+hDi+5PgnBUC9QvMRy
 fkq7xEGUWSyLqr+/1Eej1Z5Y4vYdycHeqYPDUZ1OOtNKqV9SLh2tExZExt4452riLIS6
 QUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733897787; x=1734502587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r8jhA/NSLAssAHgAVJVEDUOcVh/WbWZyii5BXcThumE=;
 b=SWZCWG3ifB5luNHY92aV5X6P2SuHQa1pLZ2n6ba+YrfnX5k/+FvOQu1jVo6g3OXXrO
 gyJaqzgVZJy8HBMYlet9Uybh/solaYjlsxTM3GB0/Fd4UnOf1Tcvi11npqU/H4wey/v9
 wJRPeW4rXGGxSWAaQS2dwfx3yUJlb0RndhmCf5lcMQ0lBLchsivMkrg1ScSuVmO5KDE7
 Ijzj2iFneXb3BYc8ye68Vn4FHImprekPDUwHpaJ56GUAEqspH046McmI6aB3coHW+2VV
 vx35jbCocat2UfxMF/wqFsSM96vRUYr+WE2lf+Zt5i/2Y3M6+6v571JdV4YzO/LZlZTJ
 u4TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ4t0w3gnEJKifRzfWwDW4aKPalixrqoO47yj0n8bSVwdPZs5EZ6KNVkizkY5Zo0IOyyr7jsw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3AyocaEcsmtZTnz9sq8YnR1XWdHunJOgnXznscuf9HgBGRRli
 WieI2olKhzGdgN96LOJNxzdp7GlH9dbnRbTCfBkIX4GqOxodNXzwhdqHKPMfCTe6tOrNL1qkPZo
 TLJ51gWYBIeXPT6SANq3hsx8olqs7GZWTbI4Pbg==
X-Gm-Gg: ASbGncsQOYI+akUu6s7bVJ0ZbQgLM9B3MAm+TNXgkLJPG9OhYlOvcC3E+3WrQxtYA7H
 45DYTRK0oBn6wj3x1rBXP+I6zeLC8e7e8QNw=
X-Google-Smtp-Source: AGHT+IGYSMDLfnVr85rpy/mYQpeRrfKhtLjBdjy0gzSaIZauXcEIBHxu8h6aQPKEeqFOeyTy/muhYnYB/cHAJ+0+5RY=
X-Received: by 2002:a05:6902:218c:b0:e38:b34d:121a with SMTP id
 3f1490d57ef6-e3c8e5da909mr1933940276.20.1733897786860; Tue, 10 Dec 2024
 22:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20241211021703.2333-1-semen.protsenko@linaro.org>
 <20241211021703.2333-2-semen.protsenko@linaro.org>
In-Reply-To: <20241211021703.2333-2-semen.protsenko@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 08:15:51 +0200
Message-ID: <CAC_iWjLHSPMOqATVByDSm1nqwprbpGrOw2mTT7cXPWw5f4uxQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lmb: Return -EEXIST in lmb_add_region_flags() if
 region already added
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

Thanks Sam!

On Wed, 11 Dec 2024 at 04:17, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> An attempt to add the already added LMB region using
> lmb_add_region_flags() ends up in lmb_addrs_overlap() check, which
> eventually leads to either returning 0 if 'flags' is LMB_NONE, or -1
> otherwise. It makes it impossible for the user of this function to catch
> the case when the region is already added and differentiate it from
> regular errors. That in turn may lead to incorrect error handling in the
> caller code, like reporting misleading errors or interrupting the normal
> code path where it could be treated as the normal case. An example is
> boot_fdt_reserve_region() function, which might be called twice (e.g.
> during board startup in initr_lmb(), and then during 'booti' command
> booting the OS), thus trying to reserve exactly the same memory regions
> described in the device tree twice, which produces an error message on
> second call.
>
> Return -EEXIST error code in case when the added region exists and it's
> not LMB_NONE; for LMB_NONE return 0, to conform to unit tests
> (specifically test_alloc_addr() in test/lib/lmb.c) and the preferred
> behavior described in commit 1d9aa4a283da ("lmb: Fix the allocation of
> overlapping memory areas with !LMB_NONE"). The change of
> lmb_add_region_flags() return values is described in the table below:
>
>     Return case                        Pre-1d9   1d9    New
>     -----------------------------------------------------------
>     Added successfully                    0      0      0
>     Failed to add                         -1     -1     -1
>     Already added, flags == LMB_NONE      0      0      0
>     Already added, flags != LMB_NONE      0      -1     -EEXIST
>
> Rework all affected functions and their documentation. Also fix the
> corresponding unit test which checks reserving the same region with the
> same flags to account for the changed return value.
>
> No functional change is intended (by this patch itself).
>
> Fixes: 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory areas with !LMB_NONE")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Removed the check for exactly the same region, and return -EEXIST in
>     the branch handling overlapping regions instead
>   - Reworded the commit message accordingly
>
>  lib/lmb.c      | 26 +++++++++++++-------------
>  test/lib/lmb.c |  2 +-
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index b03237bc06cb..a695edf70dfa 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -183,8 +183,10 @@ static long lmb_resize_regions(struct alist *lmb_rgn_lst,
>   * the function might resize an already existing region or coalesce two
>   * adjacent regions.
>   *
> - *
> - * Returns: 0 if the region addition successful, -1 on failure
> + * Return:
> + * * %0                - Added successfully, or it's already added (only if LMB_NONE)
> + * * %-EEXIST  - The region is already added, and flags != LMB_NONE
> + * * %-1       - Failure
>   */
>  static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>                                  phys_size_t size, enum lmb_flags flags)
> @@ -217,17 +219,15 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>                         coalesced++;
>                         break;
>                 } else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> -                       if (flags == LMB_NONE) {
> -                               ret = lmb_resize_regions(lmb_rgn_lst, i, base,
> -                                                        size);
> -                               if (ret < 0)
> -                                       return -1;
> +                       if (flags != LMB_NONE)
> +                               return -EEXIST;
>
> -                               coalesced++;
> -                               break;
> -                       } else {
> +                       ret = lmb_resize_regions(lmb_rgn_lst, i, base, size);
> +                       if (ret < 0)
>                                 return -1;
> -                       }
> +
> +                       coalesced++;
> +                       break;
>                 }
>         }
>
> @@ -667,7 +667,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
>   *
>   * Free up a region of memory.
>   *
> - * Return: 0 if successful, -1 on failure
> + * Return: 0 if successful, negative error code on failure
>   */
>  long lmb_free_flags(phys_addr_t base, phys_size_t size,
>                     uint flags)
> @@ -818,7 +818,7 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
>                                       lmb_memory[rgn].size,
>                                       base + size - 1, 1)) {
>                         /* ok, reserve the memory */
> -                       if (lmb_reserve_flags(base, size, flags) >= 0)
> +                       if (!lmb_reserve_flags(base, size, flags))
>                                 return base;
>                 }
>         }
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index 0bd29e2a4fe7..48c3c966f8f2 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -754,7 +754,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
>
>         /* reserve again, same flag */
>         ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
> -       ut_asserteq(ret, -1L);
> +       ut_asserteq(ret, -EEXIST);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
>                    0, 0, 0, 0);
>
> --
> 2.39.5
>

Tom this needs to go in -master for the release
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
