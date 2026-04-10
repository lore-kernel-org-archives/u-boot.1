Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C944F36BA9
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 05:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28D0684105;
	Fri, 10 Apr 2026 07:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tvx0vdmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4516684106; Fri, 10 Apr 2026 07:12:21 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6E6083D8A
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 07:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-650775f427eso1691689d50.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 22:12:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775797937; cv=none;
 d=google.com; s=arc-20240605;
 b=OmhY6cNzqzeKEsYFx1UQwYtjK8xTMUe5KGU+mohLhUn9AtGPan0OotbbrJ/KvlrX/Y
 FEIH3S9ej6Why13CPh1NljQ7pvlER3MShOdx73LZt4GvqccThTDhUQqRzfuN550fRvUT
 xWQMnB7UzBMt1Hs8wTppm+fRsuJp8XJIEENdlfD6oQ9BNEZctxqDw5KOAdkAqxMr0ymg
 oUO8pQYn9ym0PpRMF6b80IW2gq2xNDMdHAktIAGhXo/4I0/JGw45BKOdiRWAeE+P3ssk
 aGoKBZ39LFiN2USE4nO1mkPzYey2EVH3AiuOo4VGiM+0DxMi0kDj+x9/U9cOW4z53c3p
 1L+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TJ+pxyCpjhzwu+Z1Yy03esl/9YuZgeAeLS1lO32O6qk=;
 fh=Rdyxsq4dA/1AqvRcDq+Wwo8DHI5uPB9wDtKBoDJ9ZFI=;
 b=A/4EbakpkgqHoF3CnRHYwZHRlHpfS0HR96RP/kKsZ91kRt6eyo0AmRQoWXE1JLhJNN
 8T9J00xXDJxg9slfGCcmZKsn9rhAHrKD3/mv1v2QnKV7F+rLfhSDTujISGjUeUau0pfu
 ow0m+im/yhraaWt+n8WW38vSLF5KPZusZFlhECeTMHumJ7zZoABXNtR/JWr/EilEfIR4
 n45UzCh9loKaFiSGKjjVwG2W79TpM7MGsUYdmlHQS4utNfkrN9QyhIxzG/P0sudDFby1
 P0m5ZB21qDcSJ5sVjzq17p/X1dqMZKRPM3jAd0TWxDD50YV+IAcH/bnaBGF0oKMA1Vy+
 jSTw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775797937; x=1776402737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TJ+pxyCpjhzwu+Z1Yy03esl/9YuZgeAeLS1lO32O6qk=;
 b=Tvx0vdmiTKUsZxd7eCKqWYCh6W9djkS5vlZUkIwgCSawuYglLqUJtZJc9sIm7ACPd4
 i8hFeQkrYzGDPzuSnSMvsWRTPrW67s/YL4dJ0L3eJYxgm7q5zm0NVQISnDAd3Ae+UfcU
 5JBH0RpEzV8vBd/O7v+qOFO+wcvpDa34Toes/Nc19+HRXydnLte9cMDzvbmTLQxgcSLE
 d80J71bMn/mUDorUZ08oNszc+n2b+95tAZ5xT85iAQe3WmyVP9/ZyTdZj0xdUs5iReYq
 4LMIvL9g6IR3kdHB49qbkv6hHN9O11MsbrQQs9KrxF9tyXYSCB0Cj+g/LT7ZslvQUv2K
 avag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775797937; x=1776402737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJ+pxyCpjhzwu+Z1Yy03esl/9YuZgeAeLS1lO32O6qk=;
 b=Zo+zs2iKiZYdnR3PthIn06Q9mOkiAWwuTz74SfgCEFQmZzvehQ7HlL/cpuDMQAB7Px
 w0l6Z4idLMqHfwYLBj0vvwqAtfUsyyqY7WcDw364zPdTUfk7ZYxJckwnVAiBS5iFqvbg
 MjfW+TeE9RF4LKsNzmadYkCoZ9sBmjKJZbS1JoRqQy3toAP0rf050K1xMBTXNigwd1MU
 Oh4ca0R81OSgHG2F7pPLSheCqJTv0GiA0ypZ16IfBYLqWSsFAD5TOaxSG/cNc1QDrZ7P
 FXbsdIVQ8BBeFMDDvLF4wEYm5NZG5VGGZulEqR2lCoCyLibNfDZ140Nyob4MLvNFlQRv
 rYWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB8bVIusY7BIfBxr7kMz4vfsXRGxUJjCqJaOfKpwZ8n8Rn0jlK5GPuPROSNGZLJwhVUeqXvAo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxp4dMKBaGLmJ1B7HRX6LsTXSlXhjPLHWBCBk3+ayMuqWaLZH9Y
 JUBT5gozr+cVdXMvhuHy0dOK7r2LuNeTkZQyldEU+D3p5NkPKYBx4y5+xRocebkcxYOrlRwL89V
 UmUAjnCyWU30LovB3T//FSP/44HPab5uJS88VpmEmYw==
X-Gm-Gg: AeBDiesUG5iBApYDChjW6Xs3P1IKIc2z+S5HnhyvHJ+nlcP1XMXz8baI1liea9pWLTn
 1MUKssPvu6m9/EugquRC0h99BQ1pzO0ypE9fSOmREJ6qEBGCdPKhh33yxRK4uQQY2spsFuE86q+
 YcX7ANc9VEbR7NAQZO9skZfmuYuj/e7BeH+wV5UZgnSbqrXlV9cDkkpBdB235cgPmIi9yxO+Dtk
 w4bgrFl9t4zdBSrg1hvOoehIptVqXjp9v8LwjJduLBUXnSlw8LlJzHblS7JtRDT96anbz2M3rJM
 35Ev0z/LuS0cid5er9dYJN2+4FgFiAQoPQnGnSGQETZ0Dq7PNx4R6RZeiwnq+5mYdvdXP0JAgOS
 O5JizrNEwZzsl20L5j/7EN2bELw97M6SljAWM1PVy3oFTcGp04q3j1BMOS4ed9FtJGUIcfE5Twt
 JlX4931QuyFBKzq52O60Uvdz+gvaQeKEaLjMbYWnuKb10W4Bs7ESfhRSoQ+4llVIq8KWCfi3Jyv
 eoLHPspiTltPEpEisznXMTpz7iGHK0+77ZG/H7RhnTSMFNElnKj70M04eWE1D5V5HpOfH2J+jQA
 mSLYS9phWp6l3RzbQJEiyr3KrykW4hnVH2UF/vfDbTk=
X-Received: by 2002:a05:690e:4801:b0:650:78be:7ae with SMTP id
 956f58d0204a3-6519885e62cmr1299285d50.0.1775797937570; Thu, 09 Apr 2026
 22:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-2-ilias.apalodimas@linaro.org>
 <177547797999.70791.8632199569441183064.b4-review@b4>
In-Reply-To: <177547797999.70791.8632199569441183064.b4-review@b4>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Apr 2026 08:11:41 +0300
X-Gm-Features: AQROBzAjIY1veupXtPKJ0IeQpUuvkl1-skIQClPJgPBMhBA29QWJl6QP99m3om4
Message-ID: <CAC_iWj+Voi98T2VpF+S5tsHf+v-y3=Wdgc_gAeGCGVZ-+POftw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] treewide: move bi_dram[] from bd to gd
To: Anshul Dalal <anshuld@ti.com>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 sjg@chromium.org, u-boot@lists.denx.de
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

Thanks a lot Anshul

On Mon, 6 Apr 2026 at 15:19, Anshul Dalal <anshuld@ti.com> wrote:
>
> On Fri, 03 Apr 2026 12:01:03 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > [...]
> > Additionally, U-Boot defaults to relocating to the top of the first memory
> > bank. While boards currently use custom functions to override this
> > behavior, having the DRAM bank information available earlier in gd makes
> > relocating to a different bank trivial and standardizes the process.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Two files below still refer to 'bd->bi_dram' after your patch, rest looks good
> to me.
>
>         --- a/arch/arm/lib/cache-cp15.c
>         +++ b/arch/arm/lib/cache-cp15.c
>         @@ -96,7 +96,7 @@ __weak void dram_bank_mmu_setup(int bank)
>          {
>                 int     i;
>
>         -       /* bd->bi_dram is available only after relocation */
>         +       /* gd->bi_dram is available only after relocation */
>                 if ((gd->flags & GD_FLG_RELOC) == 0)
>                         return;
>
>         --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>         +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>         @@ -66,7 +66,7 @@ void dram_bank_mmu_setup(int bank)
>                         size = ALIGN(STM32_SYSRAM_SIZE, MMU_SECTION_SIZE);
>          #endif
>                 } else if (gd->flags & GD_FLG_RELOC) {
>         -               /* bd->bi_dram is available only after relocation */
>         +               /* gd->bi_dram is available only after relocation */
>                         start = gd->bi_dram[bank].start;
>                         size =  gd->bi_dram[bank].size;
>                         use_lmb = true;

Ah thanks, I'll amend the comments on v2

>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
>
> --
> Anshul Dalal <anshuld@ti.com>
