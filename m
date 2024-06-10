Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CAEC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1150881C1;
	Mon, 10 Jun 2024 11:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kqS3pfsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3377588468; Mon, 10 Jun 2024 11:34:39 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFA6881C1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f6f1677b26so10386665ad.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718012075; x=1718616875; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v7tmsQ0hplW2JpEdFVEmtAKGfg2xWK3XDKJ435enUaA=;
 b=kqS3pfsBsb1nabDHSgG6uv+PxZUgZIuadKDK15rZ2eAOSS2pcadEWpSzSBDtssCJ1l
 av/B0g+o0qj4KT0zudg9gLA1WHm9GXJ2arzETnzci8lCducUgglfMcOLm/jSrcW4Mjqq
 fAK6akXXDqCYUvZOHijlsmAwGh90XbR0h6zt8hDwVvIKAhWmpVKmo9h+fLrGW6fK5hnH
 yM+G+gcXRZ3vovkAoUDh0bjM8hHS+nY+CzxhvB90nI3lS3OtXn+YjyLabFns2Xm1jwyp
 UoPq1vLWFEyoRPd9rh71bhuqT4REoRIQLyHCpG/8WrmXHI1AQmXltdDXeosrL7I7tHw9
 SD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718012075; x=1718616875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7tmsQ0hplW2JpEdFVEmtAKGfg2xWK3XDKJ435enUaA=;
 b=CDefB1r3FijwOiXAYbhjCJRRtv06FGcg+jkOU6Abatm5pg2O8t3SNfpBEwIIRQ9Mm0
 yX6f10hAvFgcvS60BhdpMR63MpOP9lciJiHtuI2k/fAAlEyPHcn7f44U0030vvYh+q3I
 n2AOVyO04/X/pTC9Pa7DaWvC2p3ZD4kCuQ1W2e/pq8zrJlGxV80TNtrUSlCz5iPF6bon
 gR3aW1NB7tlm4M/h3b5xNCTvXQE/wc4YOkRE8SwoitZepSDwBxnpLgYR5ZrEHEGMvrz4
 X0dENL852OA9Qumiu1ACvLZ6+3Bslx4f3xnDMfkVYzvOydXiG6xAN3xjXaq9Oprx0goy
 L9uA==
X-Gm-Message-State: AOJu0YwdooeAIQL+X8NE9FpIiSpOSg8vK8g/BwjhgIyzyczpUJDajEvO
 XqhiZ+LHtCHXObE+VOqOIkf4G2H8aOGqwUqb3vPwuNxKjP6+pZdcmrT25QjPtSXFi0fh+aZJ+qq
 uwxBnMOEZIV77vzmx8xr+Nwa8m8gFcXXD0aGDQKrdT7om3vc20UHZsQ==
X-Google-Smtp-Source: AGHT+IElCImYfZb2Jsv4r/dvySwH37E61NXUduQ7jTjXEeqrTx03BEpRJwm/1l0jTVGTmapasLrCWtSvilnXscB2W9Y=
X-Received: by 2002:a17:902:e54c:b0:1f6:1a86:37ba with SMTP id
 d9443c01a7336-1f6d010c375mr137786295ad.2.1718012075193; Mon, 10 Jun 2024
 02:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-2-sughosh.ganu@linaro.org>
In-Reply-To: <20240607185240.1892031-2-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 12:33:59 +0300
Message-ID: <CAC_iWjJ0a71iV4Ai9avekaS9s2PTgv+cyCAus8scFHaoSa+1ow@mail.gmail.com>
Subject: Re: [RFC PATCH 01/31] lmb: remove the unused lmb_is_reserved()
 function
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

On Fri, 7 Jun 2024 at 21:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The lmb_is_reserved() API is not used. There is another API,
> lmb_is_reserved_flags() which can be used to check if a particular
> memory region is reserved. Remove the unused API.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  include/lmb.h | 11 -----------
>  lib/lmb.c     |  5 -----
>  2 files changed, 16 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 231b68b27d..6c50d93e83 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -117,17 +117,6 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
>  phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size);
>  phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr);
>
> -/**
> - * lmb_is_reserved() - test if address is in reserved region
> - *
> - * The function checks if a reserved region comprising @addr exists.
> - *
> - * @lmb:       the logical memory block struct
> - * @addr:      address to be tested
> - * Return:     1 if reservation exists, 0 otherwise
> - */
> -int lmb_is_reserved(struct lmb *lmb, phys_addr_t addr);
> -
>  /**
>   * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
>   *
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 44f9820531..adc3abd5b4 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -565,11 +565,6 @@ int lmb_is_reserved_flags(struct lmb *lmb, phys_addr_t addr, int flags)
>         return 0;
>  }
>
> -int lmb_is_reserved(struct lmb *lmb, phys_addr_t addr)
> -{
> -       return lmb_is_reserved_flags(lmb, addr, LMB_NONE);
> -}
> -
>  __weak void board_lmb_reserve(struct lmb *lmb)
>  {
>         /* please define platform specific board_lmb_reserve() */
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
