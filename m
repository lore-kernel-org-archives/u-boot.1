Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1E2C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45AC8144A;
	Fri, 28 Mar 2025 16:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JRMfuD74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C5881DB4; Fri, 28 Mar 2025 16:50:31 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27863810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2240b4de12bso9808175ad.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743177027; x=1743781827; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DTvKKoncqDeN763jNpoYyp2MD5g5hJ1RTgmshfqWhVk=;
 b=JRMfuD74w178ZaAmPi7AH8yeWv96CkiYxwK5f/I5yaRGsGKnt/dwSEDKQNHXj8BcKn
 kznbsyH6Tqq5fGJTsSaNwAffaqN7UjMHWzJNGOAuLo/1z7eVQYfVvNKSbSjwuLRCE3iZ
 Hre7uwaOQ77c/CjY1Rrk6/PnwpYAeqsJKzwc70TH13wzqw21oG+QS+/ma998d8Dixuql
 z72HuWjUirghvJGLc1qM0D+3d7Cetd4vb2QL0umRRXGxJ/sbIpr1s/6nOP+XF/C9C8/4
 ZRg5G38Z581eGzcOPTMEv3eQUzg6E+SblmABGmgeawouP/GS9pp6hWu2/D4QxsaN/zqq
 Xcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743177027; x=1743781827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DTvKKoncqDeN763jNpoYyp2MD5g5hJ1RTgmshfqWhVk=;
 b=PvBafyG4vnB68fwkddQE5AxuH0urv2oimozBYSvLQwJcTjZxWbkabO122R6P50P4P0
 QQf9Z6tFtvthu0nPjyzdOfPMnMtKzs41s58pxbfnXc9tlG66uGeoyYbvoHCO3YiaPZf+
 ksj6HwQJTphTrDw7wYwYh8mJee9JN4J3r6vk513yHczpQxvUMdu5x3wljxV0Jj9XfH0e
 fWWlIpBRS58fBJIR+Px1bDAk4ZQphp79BOmqT9zgNjNHWbb5hooKSsBx9THt52EqgfTl
 o+JgOU8A6gJ61T+hxID9YcCYolZV/5Ya6fEHjyX6Tvns6gobYCDda4+EXKsME68oS30D
 pXFw==
X-Gm-Message-State: AOJu0YyIes2dKjBA8mnTq6KWLbuxcDwGKgMiItmEwtNx3qj/kr+ELAFb
 iYGSYZfy+1A2qGVDLGKLyR/Kmk9tgFg+cPrfX2KLMTLax5xO7M1Vzs33Ywxkw9UpQZakHk9Ih5E
 tyWl4gr3dKpJKuTcJDU0nnmdZAv8d2X0D2zmPeQ==
X-Gm-Gg: ASbGncutYIvgG+95sFwCC0RqwCwiUh2J52wYdLKjpS3Cuu/JzPs/U0mknyjJV6DVM7F
 dRuAbsd1H+ZnrSCywpgqdV7IekN/FmFhlR1lYtaAYOLMLhjzxhs5y4f+XYu/vOpIEB5kj2Tl4WB
 OWECJRGF9VZku0AAC86Z0v0iVTbV7/
X-Google-Smtp-Source: AGHT+IED8G9Gq2jh8bGfX6bbUt7Pq5f2PSoGOBgWiZ+9stLASc6JEz8XatqiCBJ3cg3lrLrvIm3A2Z4URs9W2SZR/MQ=
X-Received: by 2002:a17:902:f709:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-2280481cc49mr121023215ad.8.1743177027396; Fri, 28 Mar 2025
 08:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-30-sjg@chromium.org>
In-Reply-To: <20250328153522.3555472-30-sjg@chromium.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 28 Mar 2025 11:50:14 -0400
X-Gm-Features: AQ5f1Jri9W2EBCdij450aBGbxUzPLumqnrgLqcn1o7G_xZyC-4nXS4VPiwJc4Bc
Message-ID: <CAEfUkUKa-_=zOry+0-EnS=e8tEq7=nooDDt6Yr_M5vx31w+JUA@mail.gmail.com>
Subject: Re: [PATCH v3 29/31] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>
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

Hi Simon,


On Fri, 28 Mar 2025 at 11:36, Simon Glass <sjg@chromium.org> wrote:
>
> The logic of this has become too confusing.
>
> The primary issue with the patch is that U-Boot needs to set up a
> bloblist in the first phase where BLOBLIST is enabled. Subsequent
> phases can then use that bloblist.
>
> But the first phase of U-Boot cannot assume that one exists.
>
> Reverting this commit seems like a better starting point for getting
> things working for all use-cases.
>
> Note: The work to tidy this up is apparently underway. For this series,
> a revert is the easiest path.
>
> This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
>
> https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>

Is this same as something we discussed in the thread below?
https://lore.kernel.org/u-boot/20250205015606.2686149-29-sjg@chromium.org/

I am a bit confused since I think we had agreed that it should not be reverted.

Regards,
Raymond


>  common/bloblist.c  | 64 ++++++++++++++--------------------------------
>  include/bloblist.h | 10 --------
>  2 files changed, 19 insertions(+), 55 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index bc752b5fdf5..3f8c7f669a7 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -500,57 +500,37 @@ int bloblist_reloc(void *to, uint to_size)
>         return 0;
>  }
>
> -/*
> - * Weak default function for getting bloblist from boot args.
> - */
> -int __weak xferlist_from_boot_arg(ulong __always_unused addr,
> -                                 ulong __always_unused size)
> -{
> -       return -ENOENT;
> -}
> -
>  int bloblist_init(void)
>  {
>         bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
>         int ret = -ENOENT;
> -       ulong addr = 0, size;
> -       /*
> -        * If U-Boot is not in the first phase, an existing bloblist must be
> -        * at a fixed address.
> -        */
> -       bool from_addr = fixed && !xpl_is_first_phase();
> -       /*
> -        * If U-Boot is in the first phase that an arch custom routine should
> -        * install the bloblist passed from previous loader to this fixed
> +       ulong addr, size;
> +       bool expected;
> +
> +       /**
> +        * We don't expect to find an existing bloblist in the first phase of
> +        * U-Boot that runs. Also we have no way to receive the address of an
> +        * allocated bloblist from a previous stage, so it must be at a fixed
>          * address.
>          */
> -       bool from_boot_arg = fixed && xpl_is_first_phase();
> -
> +       expected = fixed && !xpl_is_first_phase();
>         if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> -               from_addr = false;
> +               expected = false;
>         if (fixed)
>                 addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
>                                       CONFIG_BLOBLIST_ADDR);
>         size = CONFIG_BLOBLIST_SIZE;
> -
> -       if (from_boot_arg)
> -               ret = xferlist_from_boot_arg(addr, size);
> -       else if (from_addr)
> +       if (expected) {
>                 ret = bloblist_check(addr, size);
> -
> -       if (ret)
> -               log_warning("Bloblist at %lx not found (err=%d)\n",
> -                           addr, ret);
> -       else
> -               /* Get the real size */
> -               size = gd->bloblist->total_size;
> -
> +               if (ret) {
> +                       log_warning("Expected bloblist at %lx not found (err=%d)\n",
> +                                   addr, ret);
> +               } else {
> +                       /* Get the real size, if it is not what we expected */
> +                       size = gd->bloblist->total_size;
> +               }
> +       }
>         if (ret) {
> -               /*
> -                * If we don't have a bloblist from a fixed address, or the one
> -                * in the fixed address is not valid. we must allocate the
> -                * memory for it now.
> -                */
>                 if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
>                         void *ptr = memalign(BLOBLIST_ALIGN, size);
>
> @@ -558,8 +538,7 @@ int bloblist_init(void)
>                                 return log_msg_ret("alloc", -ENOMEM);
>                         addr = map_to_sysmem(ptr);
>                 } else if (!fixed) {
> -                       return log_msg_ret("BLOBLIST_FIXED is not enabled",
> -                                          ret);
> +                       return log_msg_ret("!fixed", ret);
>                 }
>                 log_debug("Creating new bloblist size %lx at %lx\n", size,
>                           addr);
> @@ -572,11 +551,6 @@ int bloblist_init(void)
>                 return log_msg_ret("ini", ret);
>         gd->flags |= GD_FLG_BLOBLIST_READY;
>
> -#ifdef DEBUG
> -       bloblist_show_stats();
> -       bloblist_show_list();
> -#endif
> -
>         return 0;
>  }
>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index dfe6a700e5e..191b9aa1d54 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -500,14 +500,4 @@ static inline int bloblist_maybe_init(void)
>   */
>  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
>
> -/**
> - * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
> - *                           to the specified address.
> - *
> - * @addr: Address for the bloblist
> - * @size: Size of space reserved for the bloblist
> - * Return: 0 if OK, else on error
> - */
> -int xferlist_from_boot_arg(ulong addr, ulong size);
> -
>  #endif /* __BLOBLIST_H */
> --
> 2.43.0
>
