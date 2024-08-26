Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7669EC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 08:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB1C88770;
	Mon, 26 Aug 2024 10:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qfEN28sO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4C28891B; Mon, 26 Aug 2024 10:24:23 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2B0886DF
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-201fba05363so29643555ad.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724660658; x=1725265458; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UIhvC3uSl7quKivHr1apK8aHXCH7wHb7PU/bITSS5oE=;
 b=qfEN28sOTx3I34tqDE9l7S05biKveSBWU6GqK08V51f6jAcmxR91rdwwrOTvK+KBJr
 D98Zjklkqkz+lNfQ+rPp6u0iQ0mH1rFH4f+ESnujEqL01ePbQ3sZvykZ6cPSKZ7xaz5w
 w8v70fwhkLq3j6yjga7+ig32wE81hUuiAl2v+nT3nnuE1yJXaYRZ4Mu3r90Nxfke5O2r
 Z9XO4zYiZ+ZmM09HQcGhq2yvvivdfamvs9in9/37UP5Gk5IOydgkmHQKnvWR63hDMYeO
 rXp8afzRAWA+8x12qvX4IHFc2lXbw9KGXH5khwDm+ObirPWLL2k5fC9REmTl0TkDUsXc
 17uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724660658; x=1725265458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UIhvC3uSl7quKivHr1apK8aHXCH7wHb7PU/bITSS5oE=;
 b=gS3qpV/pFBZzqP1kwT5D7IWPYDgTp+gJ22Z7MHggWeLTr1AlbcOq/BWQzaTcGYPgfV
 qEnfBg9z8nGbnmPibeqAyHsqMTl4tS3C3cYmFFPhelc+WOJTAUOWnUi5K4l6JhRqpYME
 IgfFZf41EYuQcQ7k3tB51a5I9ejOwDZfk3VAfAY778HQk4yhej0tN/k2FQ2WvbXFE1PG
 963Iq9ErvMs678TdHYSZXx33unyC6o4bBwKQKdxVl/Zucf9dePHk4G1cVNLyIENNYGDF
 JuvdYMDbJJcGoV5XFm65OdYj9pr7Ovc5u7Up23f/UweNxYEoJA5AsLnVfPeAULIPbefb
 G7aA==
X-Gm-Message-State: AOJu0YzfIjEf8IpatFqs108JLMadXRIDfWmQ7AnaBk+TR7pHrWlwFShm
 3tl4ZTr+thHmQ5FDaKd30/wyDxTJbQTxogWPYE851uDaHaZbiqWtkxY9k2SVoprx3mcfR1zllXs
 OeNXHMN016xMdSwkWSDLJn19MYMxJS7YpeKXn6A==
X-Google-Smtp-Source: AGHT+IG8Kfh2CTTsp5XI5+mKDhHS6mAP0tzyiCmp1kyO6Q18kt/bqsAYUA1Ccj1nnNaP/U8M1qKJlPnkXoqzNZV+BqY=
X-Received: by 2002:a17:902:d512:b0:202:51ca:9831 with SMTP id
 d9443c01a7336-2039e570630mr94531845ad.49.1724660658072; Mon, 26 Aug 2024
 01:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
 <20240821105839.2870293-19-sughosh.ganu@linaro.org>
In-Reply-To: <20240821105839.2870293-19-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 11:23:41 +0300
Message-ID: <CAC_iWj+RJF8ewArUwJnRgiy+g792hFP61OpJv=+zysMpJYX=Ng@mail.gmail.com>
Subject: Re: [PATCH v3 18/27] lmb: remove the unused board_lmb_reserve()
 function
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

On Wed, 21 Aug 2024 at 14:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The board_lmb_reserve() function is not being used, and currently
> there is only an empty weak function defined. Remove this unused
> function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: New patch
>
>  include/lmb.h | 2 --
>  lib/lmb.c     | 6 ------
>  2 files changed, 8 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 6e435bd35c..79bd2457d3 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -107,8 +107,6 @@ long lmb_free(phys_addr_t base, phys_size_t size);
>  void lmb_dump_all(void);
>  void lmb_dump_all_force(void);
>
> -void board_lmb_reserve(void);
> -
>  #if CONFIG_IS_ENABLED(UNIT_TEST)
>  struct lmb *lmb_get(void);
>  int lmb_push(struct lmb *store);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 1116b2b868..11959760b6 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -221,7 +221,6 @@ static void lmb_reserve_uboot_region(void)
>
>  static void lmb_reserve_common(void *fdt_blob)
>  {
> -       board_lmb_reserve();
>         lmb_reserve_uboot_region();
>
>         if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
> @@ -688,11 +687,6 @@ int lmb_is_reserved_flags(phys_addr_t addr, int flags)
>         return 0;
>  }
>
> -__weak void board_lmb_reserve(void)
> -{
> -       /* please define platform specific board_lmb_reserve() */
> -}
> -
>  static int lmb_setup(void)
>  {
>         bool ret;
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
