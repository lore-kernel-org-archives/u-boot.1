Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B59AC71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA4881760;
	Mon, 16 Jun 2025 15:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ot70LAoE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F9D81E18; Mon, 16 Jun 2025 15:33:22 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15EC080C93
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70e3e0415a7so40859047b3.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080799; x=1750685599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yc56dX8h6afco0F0BLz1zEetk920K1E83rPIjud2Fj0=;
 b=Ot70LAoEKb7I+t3gabsLgkx4m+9IVSWUXPePrH0sSiFWPYtnUX2kedavtHzlwaU3VP
 db1824rhrl3RjHJAQDSteXg99JJBHt5Bg0WHzOdEI5qcShbzndC4X1JmZzOuXcQr2Y4N
 EavN0Q4EZ8piur5Srw4DnXdU/7b5T9pdvRJsJaQ/bc3c5GewgSsMyauDpQ4Dp/+pq2TW
 tM7ko0hWNHujtTdd6miEcmZFc2KHoHMkbeTFjXsSVeI8mNGjr73rhcSOqs8MkSlf5iu3
 AnJSicyzRE07e4aYFjZgkRmD2/D+Ps7ucUn3Fhe2LvkD6BLtb49q+8cLxuAPp3QeuZXq
 xJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080799; x=1750685599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yc56dX8h6afco0F0BLz1zEetk920K1E83rPIjud2Fj0=;
 b=der6F7tQ0OIDCG+eZs+F16cAZHEp02+1jOWrG3/j1Rkakg4esz5FCyPn7/QsQbhcnF
 bNAvO384al8PPUhprBQhlwXxgBL+WIB+5wJy23BW8NCOq6+4EBKAYm0oKmg8MZ2ZVozc
 d183C9O072RKYnDY1vBpQNYJDdz7YmBnH5r89eFACNEaZo0vdu3FxHPYFSE2RLJJ6mmU
 h66D5bi+5cRLkCAv7nJTJluEiSXAdOHazYSbzF59RCAEXqTBrXuDqHVAYtOpWfVbyztv
 EriW2skS/iW3A8hvoNbCtrCmDhKHAgNZgdaRTJcdJjkfgAVt4K9oS5VjwBNisl1Qdd4D
 pRKw==
X-Gm-Message-State: AOJu0Yz98lMqFQwDutT/OZmw9c9QkdRevNA4JWGYoPvN+ecP52plXCeB
 fE7v9mCMFGfyUbPpFFSDisqJuQTGgA6u73pOQJfdM5GMv8jKWSwQbeo6KINtaK7ImNe6xWRN4rY
 JDDLC2nGOnl3/ijM+p6MqnGeJzmkwIg3ni/y9jjUU8Q==
X-Gm-Gg: ASbGncsXy7ZUFohJIewwpigutNSGS5uja4B1M20uNHCe99tUA0yToH7rsdaqVLpFkfs
 q+GuZbbxn29GVneko3SMIIk0RxirORuaf0SPjPWg67G6t2NXDWrXe3fewXsFQuTYb34akhRSCTD
 OHVMbAA5c60/sptDe964UfBiJ+QK2XOPiW8VsVXiCaGdS4
X-Google-Smtp-Source: AGHT+IEvXxM6bdDrrgvZhoN3XN6mmJDRAFfWGe56OGC2i2DWMCw6Y52BlxxTmM8iNeI5vQEEu6lyYzm+uphcjZ6a0rM=
X-Received: by 2002:a05:690c:3608:b0:70e:76eb:8fb0 with SMTP id
 00721157ae682-71172386e0amr137362967b3.13.1750080798785; Mon, 16 Jun 2025
 06:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-2-javierm@redhat.com>
In-Reply-To: <20250613085742.796015-2-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 16:32:41 +0300
X-Gm-Features: AX0GCFuHdW9aIceh7ohaTOlURHAwFf5njXPO9my9BjReUzzc3QIj2d0rzSwy4y0
Message-ID: <CAC_iWj+YfdT=6nazVJQEuYH_RuWbXNL_FmOL57i35Z4rmOi6Sg@mail.gmail.com>
Subject: Re: [PATCH 1/3] disk: efi: Move logic to get a GPT entry into a
 helper function
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, mkorpers@redhat.com, mskrivan@redhat.com, 
 eballetb@redhat.com, mripard@redhat.com, alexl@redhat.com, 
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Fri, 13 Jun 2025 at 11:58, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Factor out the logic to get the Partition Table Entry (PTE) of a given
> partition into a helper function, since it could be used by other code.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  disk/part_efi.c | 67 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 40 insertions(+), 27 deletions(-)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index 932d058c184c..c7d79e253958 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -216,6 +216,34 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
>         return 0;
>  }
>
> +static int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
> +{
> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
> +       gpt_entry *gpt_pte = NULL;
> +
> +       /* "part" argument must be at least 1 */
> +       if (part < 1) {
> +               log_debug("Invalid Argument(s)\n");

I think this should be a log_err an match the comment above

> +               return -EINVAL;
> +       }
> +
> +       /* This function validates AND fills in the GPT header and PTE */
> +       if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
> +               return -EINVAL;
> +
> +       if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
> +           !is_pte_valid(&gpt_pte[part - 1])) {
> +               log_debug("Invalid partition number %d\n", part);

I haven't read the reat yet, but isn't this something we want visible
as a normal error?

> +               free(gpt_pte);
> +               return -EPERM;
> +       }
> +
> +       memcpy(gpt_e, &gpt_pte[part - 1], sizeof(*gpt_e));
> +
> +       free(gpt_pte);
> +       return 0;
> +}
> +
>  static void __maybe_unused part_print_efi(struct blk_desc *desc)
>  {
>         ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
> @@ -261,45 +289,32 @@ static void __maybe_unused part_print_efi(struct blk_desc *desc)
>  static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
>                                             struct disk_partition *info)
[..]

Rest looks good

Thanks
/Ilias
