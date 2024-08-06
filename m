Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C873FC52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4388188B03;
	Tue,  6 Aug 2024 23:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I91EECgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83AEA88AF8; Tue,  6 Aug 2024 23:51:08 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C52088AFB
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d2d7e692eso947880b3a.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981061; x=1723585861; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cgt0sCG8AK8wEL+7L3f+YHyyen1sVEO/60uewxTHrr8=;
 b=I91EECgBIerYOSZmWs3mXzNzGzD2y2XkJIE2bOcoiMDLHwBHHBJpG+SgHN96wCayx0
 JLi1Pw7VDndQkiAhc2te5i1B5Ip9Jf5HzF5ml4LZgoCZcoFQcwCl/2imA0FyNyN1Oe6e
 YhQlszdudNV4UDb5FPTrYXv1XDtwKIC+c0Tmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981061; x=1723585861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cgt0sCG8AK8wEL+7L3f+YHyyen1sVEO/60uewxTHrr8=;
 b=mMOrRGqfgRLghe8aNVGo6gYpRSfj2Z2LzgPVkwBr1yN2/yk6XLUyqAxm+BHDr35U3b
 G6O5P6AxyvHgoU70/kaqmaqPtGOE99oXpj/C1XGKrYvWXI7OTqNbmEZw59aC+UCUqg5G
 /Gt+5YSfOgNe2AhXeq4jX7V38Zuhh9zA1Q9chRcGdriwLNLdl2GiIbU3DQGtIWD/9O7V
 M0vIxpxxZRnjP9hXSOjI+JulocErrNPLVGGxG4oMdqoEZSoaubdpp4Oxy3nWNnDaQbfL
 xsDxxJBY/r0t+UXIdslkBthkHuoZLyg3XtWjiADRlvJnn9HLpJ3ZCg1g8FhBxqjD8r/b
 82sw==
X-Gm-Message-State: AOJu0YwPci7QqYbVdmyWM9+2Z1a8eNj3qk7bIv4Xj7QTR5X4Cg74RhS1
 4WYHCV445Tlrp/R3EzaraijvVrhchl9/dbxk5xrdCmxRVpvDZMLZJsMwSGoUz2Ae0Mj8rkmFpco
 SUvcqJWWoWt72QBuh7qhq4Oip5DvHVG4LjWl5
X-Google-Smtp-Source: AGHT+IGedhFG40bP8UNOtowXyLEuZcK73SSOT3MlQhvhS0pYZR5b1boG/q7PnRWe6iSYv6qUUxAOt1eMQq83fShpYZ4=
X-Received: by 2002:a05:6a00:240b:b0:705:d755:a9d5 with SMTP id
 d2e1a72fcca58-7106d082df1mr15905447b3a.27.1722981061432; Tue, 06 Aug 2024
 14:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240802100846.16619-1-richard@nod.at>
 <20240802100846.16619-3-richard@nod.at>
In-Reply-To: <20240802100846.16619-3-richard@nod.at>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:41 -0600
Message-ID: <CAFLszTgcWPed0JP-oN+JSTc914+yMWxHjR3AeUeyZDtZQ8Bntw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dlmalloc: Fix integer overflow in sbrk()
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, upstream+uboot@sigma-star.at, 
 marek.vasut+renesas@mailbox.org, eugeneuriev@gmail.com, trini@konsulko.com, 
 bmeng.cn@gmail.com
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

On Fri, 2 Aug 2024 at 04:08, Richard Weinberger <richard@nod.at> wrote:
>
> Make sure that the new break is within mem_malloc_start
> and mem_malloc_end before making progress.
> ulong new = old + increment; can overflow for extremely large
> increment values and memset() can get wrongly called.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  common/dlmalloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Should we update dlmalloc to the new version?


>
> diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> index 44b06e38b2..c8d1da1cb1 100644
> --- a/common/dlmalloc.c
> +++ b/common/dlmalloc.c
> @@ -581,6 +581,9 @@ void *sbrk(ptrdiff_t increment)
>         ulong old = mem_malloc_brk;
>         ulong new = old + increment;
>
> +       if ((new < mem_malloc_start) || (new > mem_malloc_end))
> +               return (void *)MORECORE_FAILURE;
> +
>         /*
>          * if we are giving memory back make sure we clear it out since
>          * we set MORECORE_CLEARS to 1
> @@ -588,9 +591,6 @@ void *sbrk(ptrdiff_t increment)
>         if (increment < 0)
>                 memset((void *)new, 0, -increment);
>
> -       if ((new < mem_malloc_start) || (new > mem_malloc_end))
> -               return (void *)MORECORE_FAILURE;
> -
>         mem_malloc_brk = new;
>
>         return (void *)old;
> --
> 2.35.3
>
