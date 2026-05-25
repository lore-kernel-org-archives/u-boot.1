Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DA7CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 12:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D420F846BD;
	Mon, 25 May 2026 14:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LrJOWqym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44BC2846C6; Mon, 25 May 2026 14:53:48 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8E99846AA
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 14:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65c21049dafso8547012d50.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 05:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779713624; cv=none;
 d=google.com; s=arc-20240605;
 b=MRfJfWWZdipRuXbOfxjdPWxUMQmCDzu5SU6TZvLrXFo4q1nG0TEtgTZO3eqgU2GGHw
 hfrak9Fi6R3QLF0OoXnKwVjqK9bar8XIbIRm+2IOGkXUs2c1HLxUvoHya54BORB43f4y
 cnQGYW+sTC3hITIkzTnPSz9IAJDqg0LQ53ZZdgM8ht5ISq7sBerBIvf5LPn2NK0tldB1
 zhqSW0PPW4W8ygO3f/R75MTVHtty4x71YZ5EqgcNMnIOPWu/sLy2oD3Xa6gOlpliAq2Y
 Q85Wq6KQvg5uo7UyUnt87v5CeZgAD0Eg/jM6Jfq5k78YNNYXOHhfdM/IVhezysTbpMR6
 ayRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nIlfhRdpWxIMoh/7numyuL46eRfYmP4R/keuojUq89Q=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=b74LA0O5m/yqEBIc9RUPjFb1xGcZW/UkKUru63/yM6FC7eTWKvQGokxQwc5lm6PxzY
 WyGBCQouA1dVULQ2WyFY2BWHPnR3slcEmARZXcREjzgCONUb3+aEZqOYLFKTjG/qRHm4
 omPCm02AGS0ExuzZxasRTfivKlHM1t9KPlLH+s5kVxjXHS+UHBOJlGxUz73yN/RSfe1F
 whzfy8CDHqYDhDwaShjiA7Sca1Tkb4VCRbrKXBm0A4kq5VfdsCMsdkK/nYLEgpS7AtSg
 g2cps5hTHwpMrV2V+yCEgTYiw9hJpjhLDxcjApz/LsMdOHp9dbepDS8ZIHiKBi7VcwZK
 4N1g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779713624; x=1780318424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nIlfhRdpWxIMoh/7numyuL46eRfYmP4R/keuojUq89Q=;
 b=LrJOWqymG34vWk99a52N5tSa+N/k7KX6sbh+U7ftOvliRglPcdlmmOrwgWWbLbmLjT
 ad3iu7QZhjoBNlcDgmiPbb2430anZH+nqhFgVGVrGBPGReAypyqpZxaQIjZP8re5/nLS
 xx9T82odDSe4ul1Z77X0LmRfzTa1KGY+yCTRWCxR2dal3agZMu2QUUT+5f/Wm6zdQPG9
 2G+rfEEN0gwF5i44AAzdAvtAvDRkPfdqPnPomVDQavGjfyIRElj7MFvzP/aM5nhnT+pO
 Bw3tye7R+HugxVKP84jbEo0Q5xYtr9GpycQlJ4tyNkX+r2J3NvlDf3Tewx5HAkvnIVyY
 cSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779713624; x=1780318424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIlfhRdpWxIMoh/7numyuL46eRfYmP4R/keuojUq89Q=;
 b=UDoJzb6I5DbsHaInm1Bf5Hg9lgdCFlZOYQkJjJ0C2lL7V3laOmclM+9CD+Wgi9XJ3K
 NuVTdRw+5SdQjdiXVoMIdHtz3+4BKJmCXwbTRfuIPiJEaDacyvsx+SEch6iGOGtENkaI
 LoX93gEI9BSNJv37u8EUH3FOhSzVA3If2ehh0eIX9vE//3zo+mhLKfFUx/WgeTmLX4uH
 AGtk7c0qgmK4VCKRpOXY/1AggZO7HXT2fXeMcATKHu3171h4FYVIXiuIyj5BnYl/KgfM
 i9+5c5iyLwz59gmHbJZSHm/J/CNW3mnZBR1YH6YQDZHmCzoZCBqIDQvg4jhnq0GBjdUR
 OPag==
X-Gm-Message-State: AOJu0YzzfUK3j4msEA0cXn2zwW04zRwbNgsp3rht6Cp/VV6mS6Ug6cJW
 mVMeaFLZTOW1DnXyzMz5bbYHyEgZVNQY6PicRwTGlg7ZWJa9Ya8ifjKHtudFbDDJTRXqBrEnw5k
 RgQ8DJVSWjXsvbBuFB5vNUEHARyl5i0+a7jlgEgqVzw==
X-Gm-Gg: Acq92OE/AGYbdSdY0Lhym6nfcGJVnzE7vvrIba4feDJpMOxxp0bwE+ilUl/9seRRuXg
 8wz5YEfBTsRRQ+d4KLkfBwPYPp2GTzVI7odoeUFr6oy7Hb01qDYmaVXHWYzpO5gNQhjjrcUuKfu
 D/ID52zm2FwLNkKAlu7h+csMxMnE1PJDCrRJ0lSYKk6gpBnDjcD6eTWpg1Wq38PzsWZjc0f18PT
 lJqeswXuwIDegRRmAdGKA4eV/6jb2iKo9DPXd6Y2/Q5L+gbEC9quPtZq02ug2IQEPOYAykQj4v8
 SZJW+GNoimoI6qQVRFD70M1I2sggeWb0r7SCkJg8S2UyORAZHxRwh/3ukZJNBVkagr8J0yVMjy1
 b5qAccTk1kHVn4RBlN4TCo85teWaAtW28QWwl7v4r8nET9JOIrl9t1AQzfCB4VClpvPgYq0L4nv
 o1a/I18u2i8fIdFUjV6KMWujOdcDBMGyz3nc1pv+duNXM2/R14s/M0cBIwaC8cknoQn254eCeId
 KnT6xXKKdyrbMNwbM4XCTq7Xpcs35wWgZOd6PGZXxhzV236jyHpsRl0YTwSqgUI33txhocYyBaZ
 jvAR3kqzWLrBX2uyiX4p4o1LgYeZXOI6KdIVOLQTebB639qvRlVbPs+PTNCoFuXoPkFDp2aT1zm
 v4QXbCQ==
X-Received: by 2002:a53:ac83:0:b0:65d:8123:25e5 with SMTP id
 956f58d0204a3-65ec95ef675mr14016862d50.7.1779713623591; Mon, 25 May 2026
 05:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
 <20260518-b4-mmu-unmap-fixes-v5-4-7802245a40a2@linaro.org>
In-Reply-To: <20260518-b4-mmu-unmap-fixes-v5-4-7802245a40a2@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 May 2026 15:53:06 +0300
X-Gm-Features: AVHnY4JpqCRGlCZSENwhoPj3hMAhoxi-HLEvuXOSe49Mbi8maHPuT2IVVePtRl4
Message-ID: <CAC_iWjL+gX29x5LPnzY3uksGo4ozFPg=NmfUB32po7CsYOyHUQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] armv8: mmu: fix and optimise explicitly unmapping
 regions
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>
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

Hi Casey,

[...]

>
>         return NULL;
>  }
>
> +/* Checks if the current PTE is an aligned subset of the region */
>  static bool is_aligned(u64 addr, u64 size, u64 align)
>  {
> -       return !(addr & (align - 1)) && !(size & (align - 1));
> +       return !(addr & (align - 1)) && size >= align;
>  }
>
>  /* Use flag to indicate if attrs has more than d-cache attributes */
>  static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> @@ -1003,11 +1004,16 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>         int levelshift = level2shift(level);
>         u64 levelsize = 1ULL << levelshift;
>         u64 *pte = find_pte(start, level);
>
> -       /* Can we can just modify the current level block PTE? */
> +       /* Can we can just modify the current level block/page? */
>         if (is_aligned(start, size, levelsize)) {
> -               if (flag) {
> +               if (attrs == PTE_TYPE_FAULT) {
> +                       if (pte_type(pte) == PTE_TYPE_TABLE && level < 3)
> +                               *pte = 0;
> +                       else
> +                               *pte &= ~(PMD_ATTRMASK | PTE_TYPE_MASK | PTE_BLOCK_INNER_SHARE);

Looks correct now, but the umapped memory appears as 'Device-nGnRnE'.
Shouldn't we preserve whatever was there?

Thanks
/Ilias
> +               } else if (flag) {
>                         *pte &= ~PMD_ATTRMASK;
>                         *pte |= attrs & PMD_ATTRMASK;
>                 } else {
>                         *pte &= ~PMD_ATTRINDX_MASK;
> @@ -1107,8 +1113,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
>         flush_dcache_range(gd->arch.tlb_addr,
>                            gd->arch.tlb_addr + gd->arch.tlb_size);
>         __asm_invalidate_tlb_all();
>
> +       /* If we were unmapping a region then we have nothing to make and can return. */
> +       if (attrs == PTE_TYPE_FAULT)
> +               return;
> +
>         mmu_change_region_attr_nobreak(addr, size, attrs);
>  }
>
>  int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
>
> --
> 2.53.0
>
