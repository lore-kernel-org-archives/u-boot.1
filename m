Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BD9CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 06:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC5A8334F;
	Fri, 12 Sep 2025 08:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e0Bt16aB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2AC4833EC; Fri, 12 Sep 2025 08:04:29 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC0983322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 08:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71d603b60cbso13946087b3.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757657066; x=1758261866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WqFuRCwKPfWulCSr7Bg5/PhyuRQFNebnfX5QHwIo9gU=;
 b=e0Bt16aBhOujdfiqnPwkEGBaux1cf6TmoSoj3QYuZBiPe26k7uDod610aj2dM72NT3
 TusVtOgXdefF8JHLVwsm6KkKZeJ8HQ/cd8s8aKVPaHH5Mt4QykeAzJJijOhO1CT6Pt1T
 +kPhjLrC3+tlgenj2RJnohjYYnOLD4O/Sow4iVFMp/+mqdB0nWOTph/9kuZspLDCV/cU
 fHvnyy2kg2Xc5ComWtlbkQUhUQd17RD4KSaOaO5rRv59yUGQAF9YBJ6U06SPC0bVuPNo
 z1ukVedcnXItV54RhsHMMhYf0cFiVyTbGYdhs9j9dOg+Tkm6NWZqOrNhhs6r5FqqXAgW
 lblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757657066; x=1758261866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WqFuRCwKPfWulCSr7Bg5/PhyuRQFNebnfX5QHwIo9gU=;
 b=C8yQH30YasdNlgu7q0g0syJnLBvIb+0YRA4ue3cNGZFoWsLM5uVb1sUi7rrW2CEPiC
 DcW/P1HJOVGGwhj6+tr7eP72zwAgwCYLdVm1CMXN3/Z4xrfAgX2aRX2vFF63nJgwTPGI
 UV1SdyEm2zanhnYNA2CMAOpkAosWGH8Rybxnli0U9FW2b9Hf7u+maclZwzNv5U8V1zlA
 zAVSon7OsFE1+3axrYMc8MRaewyt65LKbdGHnfaXoxkqp6q0Vp9pSN7+iN4NWKU5tjaY
 xx1q2FUjoHfqJwMIufEn254ZDgSm1beSlSOEXS85cUpnZavjWgnskYrxLayyf71XxIrd
 9KfQ==
X-Gm-Message-State: AOJu0YwWEd7t+AuVxMrD/h5wik2yXqLj0VVzfQPy4fhyAudgASZjLluM
 t/wyTHmd3tqP1RK+F11DwyPAC1wLYMGqV4p3/wnqJJmtKYEMp2eMlLWZlEc2pjuwjPJFKTU7BHA
 U8xdWnbfyJRlO6R2va8OFodtQB1gi3pF4ILVisdNCWw==
X-Gm-Gg: ASbGnctMBq9o36zR1iPM8pyd/6SdiY5HExiq8msJGuYkMnIhIMCikzkuOiuIKcCsuNp
 rH/rs51rUVsMYBgtrqxnINSWc/vxB7xmPgJu8tedZWTSgTCltTHXB++BKfebuxGZoPm58IgUvig
 GXpJ78ZckB06O961XSHZg16/6MXDE2teYqCKs4Prvf9KfMcCIDkFa91qjQg3imOMpP2302iKl0w
 P9EEkpO6wnjARBY69iphRkM3xFLcJOTZllTKhHPuYN8I2Q1BdLh9qCoGMIWKur6DBuz/vEsLQin
 7q7YIeTT2PnZqaeIStnbmFKy/C7fczKMwTivgmdJETRi2w2zQl5F30S4yIICA9IQ5s0jOeLeDQ=
 =
X-Google-Smtp-Source: AGHT+IGsqLALJL/igwnuNZAUARlHeA3K5DlVS+j2QfXo7cvF9Aq1wZk1+9tsYRyp5GzYzpLxXZkzn0wSTUNm2T6KdhU=
X-Received: by 2002:a05:690c:6406:b0:720:378:bec2 with SMTP id
 00721157ae682-730652db61bmr18003187b3.33.1757657066143; Thu, 11 Sep 2025
 23:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-5-anshuld@ti.com>
In-Reply-To: <20250905081902.489345-5-anshuld@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 12 Sep 2025 09:03:50 +0300
X-Gm-Features: Ac12FXw4Fl948cttNC76yl4MumY7vtJsrGfvySOC-VzFNgL_r7tSvGg7D-UyjLg
Message-ID: <CAC_iWjLYcGuW60ZYTiNLDGfqc7zfReOtcgUeyTK+vfieuSMSsA@mail.gmail.com>
Subject: Re: [PATCH -next v6 04/10] arm: armv8: invalidate dcache entries on
 dcache_enable
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, 
 trini@konsulko.com, nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com, 
 a-nandan@ti.com, afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com
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

On Fri, 5 Sept 2025 at 11:19, Anshul Dalal <anshuld@ti.com> wrote:
>
> In dcache_enable, currently the dcache entries are only invalidated when
> the MMU is not enabled. This causes issues when dcache_enable is called
> with the MMU already configured, in such cases the existing dcache
> entries are not flushed which might result in un-expected behavior.
>
> This patch invalidates the cache entries on every call of dcache_enable
> before enabling dcache (by setting CR_C). This makes dcache_enable
> behave similar to icache_enable as well.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 1c1e33bec24..6e662395a83 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -830,16 +830,15 @@ void flush_dcache_range(unsigned long start, unsigned long stop)
>  void dcache_enable(void)
>  {
>         /* The data cache is not active unless the mmu is enabled */
> -       if (!(get_sctlr() & CR_M)) {
> -               invalidate_dcache_all();
> -               __asm_invalidate_tlb_all();
> +       if (!mmu_status())
>                 mmu_setup();
> -       }
>
>         /* Set up page tables only once (it is done also by mmu_setup()) */
>         if (!gd->arch.tlb_fillptr)
>                 setup_all_pgtables();
>
> +       invalidate_dcache_all();
> +       __asm_invalidate_tlb_all();
>         set_sctlr(get_sctlr() | CR_C);
>  }
>
> --
> 2.50.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
