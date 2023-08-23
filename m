Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D1CC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58C086546;
	Thu, 24 Aug 2023 01:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lfgPFW+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07BAD864F9; Thu, 24 Aug 2023 01:59:29 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 164C08651A
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d77f614243aso269760276.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692835157; x=1693439957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wGrRN4Eds33fAeZ63HevS2Ij3FDMhrHg1nP7QtNoaPY=;
 b=lfgPFW+pJfFiSiEOO8VXUs8KGKh+X2hNV0uzXB+jB+h2mxEisYfgGGRMtrhCZ8CC4I
 trN6PjfH+uzysGfk0krA6S+xej9naA4UL9sllQqnp+3Xq30n5XxAbmTtWaR4nQol84R8
 8SYiQ3vGT/+ypuaxgfQ36Be6EmEQbHp3zNqvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835157; x=1693439957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wGrRN4Eds33fAeZ63HevS2Ij3FDMhrHg1nP7QtNoaPY=;
 b=esfi0cq6bZIrx/AVjd1mxtfaMAm00HxKyreJkRxngs1Zvtkt5W7qFK9j0E15qms9Gi
 RgNr5A/U37A9zd76BedRu2NDmKN+2paUesCIWE+RxNnbm1hRfIY4RbwkCVUAHnvi55QQ
 vijUhC7egncLZGLloDBue50d/QbKRmTs7elXOE/QppgNfxsn7fCgIOW3NHU6567txpRD
 YXowH98L0NpzqWOQ5sd241hw65P0tYp96qFGtMkU8VT18B/W0ofwh1dtYOrc8NOrRP/D
 jJqWJsIVk1y8ri11bl/9ufSsmheCmmkGDVKpKcqDDe8oYhZNfZwyXOnaYej+NTpTpT20
 /isA==
X-Gm-Message-State: AOJu0YzDSSxXmLvNqNNsE5nUpmyOCed3ZlB3gsVGum6rR9IuVZlkfhC8
 5ETAgnfF+Xr2PMvmkVL84ToTqrnWJj/pzql+Hnv3wA==
X-Google-Smtp-Source: AGHT+IGDhCNpl5ydDdFlx5id9geO0ws6hXkg1wUEyBMSmuuvQk7E8rS6YqbNNKBGGF7XjpgTPizHW9/L3vuVyW32jEI=
X-Received: by 2002:a25:7445:0:b0:d00:cc5b:8a9f with SMTP id
 p66-20020a257445000000b00d00cc5b8a9fmr14509888ybc.16.1692835156461; Wed, 23
 Aug 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-8-sjg@chromium.org>
 <6f1ea3e9-7284-22d3-e2ee-071523b7dbac@gmx.de>
In-Reply-To: <6f1ea3e9-7284-22d3-e2ee-071523b7dbac@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 17:57:55 -0600
Message-ID: <CAPnjgZ3i9EDe3CyU64WRpE+oR0-xS2iffQR=2hVBZRzA2KkC6Q@mail.gmail.com>
Subject: Re: [PATCH 7/8] spl: x86: Avoid starting up PCI automatically in SPL
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Wed, 23 Aug 2023 at 14:19, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 8/23/23 20:47, Simon Glass wrote:
> > For x86 platforms, PCI is core to their operation and is managed in
> > arch-specific code. Each platform has its own way of doing this. For TPL
> > and some SPL implementations, the full driver model PCI is not used.
> >
> > A recent change enabled full PCI in TPL/SPL for all boards. This breaks
> > some x86 boards, so adjust it to skip that for x86.
>
> Could you, please, give some more detail?
>
> * Which boards are broken?

For example, chromebook_samus and chromebook_samus_tpl

> * Don't these boards have a pci_init() function?

Yes, the same one you are calling.

> * In what way does calling pci_init() lead to a failure?

It probes and sets up PCI devices and uses a lot of pre-alloc RAM.

>
> It would be preferable to have all architectures and boards use the same
> high level API. Excluding x86 here looks more like a (necessary) hack
> than like a target state.

Fair enough, but on x86 we access PCI long before driver model is up.
Generally we don't fully enumerate it in SPL as it is expensive. It is
also pointless, since U-Boot proper does it again later.

Regards,
Simon


>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   common/spl/spl.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index 0062f3f45d9..13d7b1a742f 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -800,7 +800,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> >           IS_ENABLED(CONFIG_SPL_ATF))
> >               dram_init_banksize();
> >
> > -     if (CONFIG_IS_ENABLED(PCI)) {
> > +     if (CONFIG_IS_ENABLED(PCI) && !IS_ENABLED(CONFIG_X86)) {
> >               ret = pci_init();
> >               if (ret)
> >                       puts(SPL_TPL_PROMPT "Cannot initialize PCI\n");
>
