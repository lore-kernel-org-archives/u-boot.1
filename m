Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3853BCDB47F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2456849D2;
	Tue, 23 Jun 2026 16:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f9YJsDMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 697FE849EA; Tue, 23 Jun 2026 16:34:13 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE9C8849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3996f80800bso11503541fa.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782225250; cv=none;
 d=google.com; s=arc-20260327;
 b=mzE79tL9XdCn+EYW8zFaS9O/GxtI20jUv9pE4cBDH1aOXDZwdWzKuqvtOS5D5DihPV
 xhFtX7/q2taO9A8CLHpuYOQBvClgLwVx01MPPofHLO0O8ZSvLxe8IK7KASCzAQ6tRgkL
 duOWl3IyFKgHB3KLFSwLjwD8ejaPpjuDzN9MuorDGtAqgftdOop+lLo/DbFBMtOa12bH
 04OKxQEiGzgnA6lFeVCgGZ9rZpGwpZKIEnXZEOShRWco2C7lDK2+SXQENPsDp+xNlgYB
 QBwoIZSyNy4UwfT0VFm/3gd5y0MsRjJ+ys9hBaGHVh/LlwvHSyusKadDnl3+jEY7S3AO
 niHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7MjBGUGWXMvaYQAh25X7eyZbWtiiNSXIXueNNeNt6aA=;
 fh=TLHdG9UXP/6pNSjkQbR8B2EMQBf0ZWFmaP7cL+oWG1g=;
 b=sS+01MmNrxee/8gay+OXMNzgz2fB8osivF2Ksd0RVeuAhbw0EaSHaVUDZdilMwyzSV
 Y6rGM+Y7n3dX5NuXYlt2MW68wS/HjtYu8qmxe1VyT+sE4g+HwqqflcdOkPeEiz209Sfe
 q0STn1zjPzcvUWt7RujVcHBlunV3tpIp4TMxjxFR+JeYuWxgXUDI/HP/aT/odzur1+FK
 N+LEpCAf3uAf9MO20YKr6fFPzwcz8ndlg17NuhLf2Yt1cJN8rPoLAKzxUXC1EbYd2anO
 WEp6A8titCwkK/iNm6C+njIwOiTBffjgVmbGbpms9Pc+tSwJ8i5t7A59DNNH2jm8wmBz
 OYvA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782225250; x=1782830050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7MjBGUGWXMvaYQAh25X7eyZbWtiiNSXIXueNNeNt6aA=;
 b=f9YJsDMzLuWRwy+Iu4LJuh6YlMmqDZaTkqZV5EH9FplOfTOCYfstQsMEn5Vy1na558
 1QG5HW+tofvwg0Wum1I2YFfwiUORr/p0hdDZ7igZDTKu2YwG1vWI75dUUX31F1OiPOjx
 CzSMeGqNri0uT+K3fE+PZ/cI84gM3WTf2XF1InZbJKM0Q25FQTqnpJWHeRhOW1QPjCwo
 Vf8OWxObeaM6OXODp2PhtppRc0WuiaPYQ9KETj9P4c2yCc1JUaNkjN9d0XKkA/CZR6gP
 5atc0et4TOuYy6tR40coAsrX50+E2yRq+HwIfW60m2GbLxQe5TbXLOl09NHQ/j8rzmr/
 2NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782225250; x=1782830050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MjBGUGWXMvaYQAh25X7eyZbWtiiNSXIXueNNeNt6aA=;
 b=jY++Dy6qOOU8yXm7B+Shtsaoya2XWYJRVKsdUf/xoJvqiOpOo138sF1FUP0jQ3BIqo
 ZRYZmgwqwqbRDiOMod5ioPGde3Njt/DybNLwmkb1zmfnC1gShcgkzq0Jr5G7qIEiFFet
 BmArn9Ikijwz031+ivt6iClVw4rx4ujhNghqnstEAAaQB6kwCT0PeeM8ucwqP/DzAqi1
 1rBTvXFyfGa2EpaMpl0UkgozLXxaGaBlZIVPcZQvgVJfEbEO3U/MohSgQvKyky/qWZib
 VbS/jPo++GMFj5N80T9fb1A5efHP2GMnQ1ASjj9k0QAXC9FA87fqZKGFZrsFgVN4kp+h
 mlLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ifplxWLZlRFcskWAGfDqYpDrTnwJ07rlyZnC0SnIquuAy611dIXh2glXWxVbwISTwg7xv5xo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxx4MQeSCnfsRoU29jDh+F1UBlbAUSmc1n6RHIm1ChHLdFNkCOZ
 jG5tx+6QndaNseEK4XWlgLHti3jbaUvbbRtBj3kGRh1CvFVLJprJ8IApmEVC5bSe4YuMn6yard9
 TlKYHnn0HbUfL0zAa3cfRTbsnzPsHbQZsmDvsUNObkmgCWs13U6EvXJXTTw==
X-Gm-Gg: AfdE7cmv8ji2qw8WIKZy8sQ4rkj2XI/4bpryz4MM76V5Q+MDWgQPGn9CH596eMi4Nwt
 ZpUZkiWotgmUG3bnA/vK+pRkbwOcIFP6JsiESA72FcBVzv5mjy1PmC0R/+WlJezQcZpnJG92DGh
 OzBaHjyj8zB3djwzxK5kU3PYEGaThKisIyWAkf2iRd9Z8mPGD+yij8slbJepcHXt8Abw3OJ3nSx
 VgquCsRNvWlKdsQhQqlxdpIKhFe+F51RKQGRux7ltdasMjVIQNF8l+vO4uxKU2slTV+BciQmWlG
 nPS2lllH9hpDh5NSfL9YIKcAB5b+dUGEDSZltjaBz+ZrKCcZnfZv+3UlYuNGcJUaiJMQUQEbGns
 Zf+DnK0w4D4zowpzUZasBDbba1G1qsWiTWoRUNy5Zwf4Zvw1GTtUI3tISV2S/vqKuomCRLm8T5M
 p3RdEu5NCr4yS/xKhIXkp+C/svVu6D7ELLR8zn1UXYqs4vcYdPuVJ6+3v4bxvUZRaPhGudP86Id
 jUOvmfQZKQlOTYv7tjoj4xtNw2Z+3MZBQ6Oau1srzzPBLGEa4c2N+wjXDAXftD6WciWm4MKQKBT
 6JYse/80Z+Ptq2gGzuAONk3yBfKdHTTZM257ruiM5ZbxmSPtUfFrskoVhdFUdKf/k09XQ9g=
X-Received: by 2002:a05:651c:1549:b0:396:6d94:4a4b with SMTP id
 38308e7fff4ca-399c549fca7mr9832211fa.10.1782225249791; Tue, 23 Jun 2026
 07:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260612113144.458665-2-casey.connolly@linaro.org>
 <CAC_iWj+C0u3fos0LJCn0_KP9gCNQdh3vA_CCzOsGDgncOuZx_w@mail.gmail.com>
 <CAC_iWjKNGEvj6oZ7EFkGFT35Skf7552VJb6f-EMMQGZyR3er9A@mail.gmail.com>
In-Reply-To: <CAC_iWjKNGEvj6oZ7EFkGFT35Skf7552VJb6f-EMMQGZyR3er9A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jun 2026 17:33:31 +0300
X-Gm-Features: AVVi8Cf6OoOjnfED82FbT3IbAgxiBxavwWKQHwxO76aI63gE0Jd4Oss1KR0wxuI
Message-ID: <CAC_iWj+Uz9xOkijUJp7ySEbDDkXbaGupA63SvrtMiMzd1xhT5A@mail.gmail.com>
Subject: Re: [PATCH] armv8: mmu: don't panic when unmapping a page which isn't
 mapped
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Mark Kettenis <kettenis@openbsd.org>, 
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

On Tue, 23 Jun 2026 at 12:17, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 23 Jun 2026 at 12:07, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Fri, 12 Jun 2026 at 14:32, Casey Connolly <casey.connolly@linaro.org> wrote:
> > >
> > > If a caller tries to unmap a single page which is already part of an
> > > unmapped block, set_one_region() will panic since there isn't a valid
> > > block or table to contain the page. Detect this case explicitly and
> > > return since no action needs to be taken.
> > >
> > > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > > ---
> > > Depends on my previous series which fixes unmapping regions
> > >
> > > https://lore.kernel.org/u-boot/20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org/
> > > ---
> >
> > Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > >  arch/arm/cpu/armv8/cache_v8.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > > index 6c85022556ad..472887b5d99b 100644
> > > --- a/arch/arm/cpu/armv8/cache_v8.c
> > > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > > @@ -1003,8 +1003,13 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> > >         int levelshift = level2shift(level);
> > >         u64 levelsize = 1ULL << levelshift;
> > >         u64 *pte = find_pte(start, level);
> > >
> > > +       /* Trying to unmap a region which is part of an already unmapped block, nothing to do */
> > > +       if (pte_type(pte) == PTE_TYPE_FAULT && attrs == PTE_TYPE_FAULT && size < levelsize) {
> > > +               return size;
> > > +       }
>
> On a second thought, you should check the size of the region as well.
> What if the user starts from an unmapped region with size X but
> requests to unmap a size Y with Y > X?

Just to make the response a bit clearer.
Add these on the qemu board_late_init()
mmu_change_region_attr_nobreak(0x40200000, 0x200000, PTE_TYPE_FAULT);
mmu_change_region_attr_nobreak(0x40200000, 0x2000, PTE_TYPE_FAULT);
mmu_change_region_attr_nobreak(0x40300000, 0x101000, PTE_TYPE_FAULT);

meminfo says:
[0x0000013ffea000]                        |  Table |            |
         |
    [0x00000040000000 - 0x00000040200000]   |  Block | RWX        |
Normal        | Inner-shareable
    [0x00000040200000 - 0x00000040400000]   |  Fault | RWX        |
Normal        | Inner-shareable
    [0x00000040400000 - 0x00000080000000]   |  Block | RWX        |
Normal        | Inner-shareable

Cheers
/Ilias

>
> Thanks
> /Ilias
> > > +
> > >         /* Can we can just modify the current level block/page? */
> > >         if (is_aligned(start, size, levelsize)) {
> > >                 if (attrs == PTE_TYPE_FAULT) {
> > >                         if (pte_type(pte) == PTE_TYPE_TABLE && level < 3)
> > > --
> > > 2.53.0
> > >
