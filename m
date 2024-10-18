Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3989AD3000E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9947888FAA;
	Fri, 18 Oct 2024 16:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aHUmtYrb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7886F89096; Fri, 18 Oct 2024 16:04:24 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C5EC88D9C
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c94b0b466cso2308220a12.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260262; x=1729865062; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HDN8ljwYfuqGWudHy93cmaWjSBbRreys8/d65OlZUG8=;
 b=aHUmtYrbb0FUDOrsXxuoQBC2n6dxG2gXivZi0LwmtZKF2TFDY7HvnUondelkXduKHC
 sU6GvfwanE022sLBh07iqz/4O5AHBLfCY30KrAursJintFpv6mnjNu/37M6tb1YpKOlQ
 YZCOJsPA3sHnyuVPm5rLsIu2n7Pw6RaVND1UsJi48FUOr1bJ8jagYjan+1TmZaHs73fA
 HJ2vd5bHrZfvhM3Lqe9FuCwoM59PvABl1aEc3LoUn/EXjzABrieWLpdxlCoAGHXLva5o
 gpfe5ErE1CfOxOJWAxkFC60zpmGLOzxGb/Kq6sXM0BjVf5OWTh2uINE4dHui91Fs61Nu
 Mv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260262; x=1729865062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HDN8ljwYfuqGWudHy93cmaWjSBbRreys8/d65OlZUG8=;
 b=sBMkqqcdwactfTQrGfvUGWATTJAb73Wqq52/UTdCSMm8c9H2ndfCjGqj/w8gq734NS
 96DrKOQ9yi2+21YDMRwTquaRryV2TgxZrH4l2QPAL2a4MHDHuqfP9uW7OYpj5x5/1//D
 HwlMpT9GGkVV/EBeAWiFqMxkgKvaF25CwPvxHtBvPS/OckyLNuI8ofayX2NGegP+VpV8
 8Nqbu7m5/9VjSvP7bo1bRS8FrnGoqrWMd3XSG+fvW2RVonE11zDGtBFb80eT6bleQR6X
 rGacLum3x9MeZ+oHtvnh0T2F5JSUkBoNDQHhOVl/Va9uPRyzkKqBxE4iPlAKwN9uUCoh
 t/eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvi4n7hCjnyCI3iVs+sQdZhSW+qg67eE5O/16554UpoPuVI1c/WqlZl6Z+ApTYTA+uLvlJ/ao=@lists.denx.de
X-Gm-Message-State: AOJu0YzRkVqb7vA6QV1R41JECWky3JL9SAhoS+ttlR8bdqtOQFs5bWNR
 ajxqnTBz421z0fMdvgSrtUfgUjE+NF00zZoHDLNTv+Ka6T6whGtjDkoYAZNhfDVzq0x0NtAvk+P
 y6oFEPs9iEJjnfrmczdikOrjnKqdcx0Z4yrOF9g==
X-Google-Smtp-Source: AGHT+IGpAeHFpBPDr/N5/BFRv54BdHnO27c5b6v2a7Dt5Sm5o/8fewKq1YFKE1iM4Zj68CPsqgqqsiAtB5Z3AR1lYH0=
X-Received: by 2002:a05:6402:40d0:b0:5c9:4be9:7c4 with SMTP id
 4fb4d7f45d1cf-5ca0af8767bmr1453364a12.31.1729260261423; Fri, 18 Oct 2024
 07:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241018135112.3978130-2-caleb.connolly@linaro.org>
In-Reply-To: <20241018135112.3978130-2-caleb.connolly@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 18 Oct 2024 19:34:10 +0530
Message-ID: <CADg8p95eCiSW6qO86Mrd-=i7ZvZFBgStoFjkrwb3ApNNLicaYg@mail.gmail.com>
Subject: Re: [PATCH] lmb: notify when adjacent regions are added
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Fri, 18 Oct 2024 at 19:23, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> lmb_add_region() returns a positive integer if the added regions causes
> existing regions to be coalesced. We still want to notify the EFI
> subsystem about these added regions though, so adjust lmb_add() to only
> bail on errors.
>
> This fixes EFI memory allocation on boards with adjacent memory banks as is the
> case on several Qualcomm boards like the RB3 Gen 2.
>
> Fixes: 2f6191526a13 (lmb: notify of any changes to the LMB memory map)
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---

Reviewed-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

> Cc: u-boot-qcom@groups.io
> ---
>  lib/lmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 78fe2d4de7c6..7e90f178763b 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -486,9 +486,9 @@ long lmb_add(phys_addr_t base, phys_size_t size)
>         long ret;
>         struct alist *lmb_rgn_lst = &lmb.free_mem;
>
>         ret = lmb_add_region(lmb_rgn_lst, base, size);
> -       if (ret)
> +       if (ret < 0)
>                 return ret;
>
>         if (lmb_should_notify(LMB_NONE))
>                 return lmb_map_update_notify(base, size, MAP_OP_ADD);
> --
> 2.46.2
>
