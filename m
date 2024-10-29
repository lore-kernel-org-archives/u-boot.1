Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A5FD5B16F
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 08:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8466588EF5;
	Tue, 29 Oct 2024 09:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MNUUOIVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0381989152; Tue, 29 Oct 2024 09:53:07 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D91B588EF5
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a2cdc6f0cso696599866b.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730191984; x=1730796784; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tOd6XNre5DPIaKzxJ3W/wiqNdiKXw7amStXEhvzuXnA=;
 b=MNUUOIVeoezaZ0DZFcSpOgZC0tuJoOjQOY0C5Flk2twmJxb1F9fmN0/Wco9st/Ck4u
 9Nd5AKeXyq0J7kJiEGqqrM0l9pEqF1XFH7DeSfviVsKcn5EEqO2oVx//u2i83JzkoWCW
 eMbDHEEdb0PGk+fTM32viHzlLmVM6zp3f5QDBtPCxCRv0HHvmnu+UbQVIo7kmN3TG0dY
 UnEr+TVXyGrz/XbtXlhU+zZIMRYXlnmvb3QRabDiuJbbSeKzZzlSwH7NRTcEqSls0pQt
 +jvLdM7+Gb1oYpfA0CH4UdJumgBUjDPZRhe4wxaywkYJ6Xy1okRvfSyFHxcZhZR/VTe3
 m0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730191984; x=1730796784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tOd6XNre5DPIaKzxJ3W/wiqNdiKXw7amStXEhvzuXnA=;
 b=WrPTIWECyy/uAh6pHmreXrS5IXC/rC0XzUMj25Cwj1CpU+FxlHcv2TIzlFz/svsaYh
 BaThqruTetOPFJSZTC+rwE5S1JRsgUf7ylmNeEW2LZ8kXA0SEyrg8UAxBXLzgRSyfHNk
 l6gkvUPeL50yERJ3NmtPKtSLS1OdQ37XzC8nK9U25rpsPs9Dt/H26A+7Y8bGHxxo3ZEx
 /mT9HRy86Y7yKyJjMwYk/GBzJvl/+GEaj92fRb7E5C1DU5B5coMfioMYTPPlYsKi6lwn
 olflJHzebPWV2X9+ESrtaUtFWNkz5tIJ8Len5iAOUlN0n7ceAnr8PB/8rFflklbstTFb
 ePMw==
X-Gm-Message-State: AOJu0Yw4SxfmltRpKf9FR6+0zOdb0+KbxH5xQjWWDVB+WyPggCPJg/7c
 5uO0fAv9fk3bZRpQBcjXsu/E3CO+t8kOTRY7/5JgQ9e6tD3h90cfLCcwI9uBVG7lyxNnXSMYa9u
 JXBnU4Ef8yzvuTuT97ZLf9H7yUPithd5oRlBCyw==
X-Google-Smtp-Source: AGHT+IHj4H+n2V3c8tJy2eUb2XACRxGOjSoLRFITrXBK9UiNM1JaJgBAoIyWQ9bhDhK03KG6G8EUEI4P1WkodOTgoao=
X-Received: by 2002:a17:906:c14d:b0:a99:e98f:e73d with SMTP id
 a640c23a62f3a-a9de5ee15f8mr996016166b.37.1730191984182; Tue, 29 Oct 2024
 01:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241029071846.514559-1-sughosh.ganu@linaro.org>
 <20241029071846.514559-3-sughosh.ganu@linaro.org> <ZyCdj5x3RS_djKqk@robin>
In-Reply-To: <ZyCdj5x3RS_djKqk@robin>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 29 Oct 2024 14:22:53 +0530
Message-ID: <CADg8p94Kc13KHdZxJ1-rhkSWzOY=QBDfPsSnQdQzmLpcfzy+VA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] apple: dart: use driver specific instance of LMB
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 29 Oct 2024 at 14:02, Janne Grunau <j@jannau.net> wrote:
>
> Hej,
>
> On Tue, Oct 29, 2024 at 12:48:46PM +0530, Sughosh Ganu wrote:
> > The LMB module is typically used for managing the platform's RAM
> > memory. RAM memory gets added to the module's memory map, and
> > subsequently allocated through various LMB API's.
> >
> > The IOMMU driver for the apple platforms also uses the LMB API's for
> > allocating device virtual addresses(VA). These addresses are different
> > from the RAM addresses, and cannot be added to the RAM memory map. Add
> > a separate instance of LMB memory map for the device VA's, which gets
> > managed by the IOMMU driver. Use lmb_push() and lmb_pop() functions to
> > set-up the relevant lmb instance.
>
> thanks, this fixes the initial brokenness when setting up dma mappings
> but I still see SError due to translation fault. I don't have time right
> now to look into it so it could be unrelated to the iommu.

Good to know. Thanks for testing the changes.

>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  drivers/iommu/apple_dart.c | 67 +++++++++++++++++++++++++++++++++++++-
> >  include/lmb.h              |  2 ++
> >  lib/lmb.c                  |  1 -
> >  3 files changed, 68 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> > index 611ac7cd6de..55f60287b0e 100644
> > --- a/drivers/iommu/apple_dart.c
> > +++ b/drivers/iommu/apple_dart.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
> >   */
> >
> > +#include <alist.h>
> >  #include <cpu_func.h>
> >  #include <dm.h>
> >  #include <iommu.h>
> > @@ -70,6 +71,8 @@
> >
> >  struct apple_dart_priv {
> >       void *base;
> > +     struct lmb apple_dart_lmb;
> > +     struct lmb ram_lmb;
> >       u64 *l1, *l2;
> >       int bypass, shift;
> >
> > @@ -87,6 +90,56 @@ struct apple_dart_priv {
> >       void (*flush_tlb)(struct apple_dart_priv *priv);
> >  };
> >
> > +static int apple_dart_lmb_init(struct apple_dart_priv *priv)
> > +{
> > +     bool ret;
> > +     struct lmb *almb = &priv->apple_dart_lmb;
> > +
> > +     ret = alist_init(&almb->free_mem, sizeof(struct lmb_region),
> > +                      (uint)LMB_ALIST_INITIAL_SIZE);
> > +     if (!ret) {
> > +             log_debug("Unable to initialise the list for LMB free memory\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ret = alist_init(&almb->used_mem, sizeof(struct lmb_region),
> > +                      (uint)LMB_ALIST_INITIAL_SIZE);
> > +     if (!ret) {
> > +             log_debug("Unable to initialise the list for LMB used memory\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void apple_dart_lmb_uninit(struct apple_dart_priv *priv)
> > +{
> > +     struct lmb *almb = &priv->apple_dart_lmb;
> > +
> > +     alist_uninit(&almb->free_mem);
> > +     alist_uninit(&almb->used_mem);
> > +}
> > +
> > +static void apple_dart_lmb_setup(struct apple_dart_priv *priv)
> > +{
> > +     struct lmb *almb = &priv->apple_dart_lmb;
> > +     struct lmb *rlmb = &priv->ram_lmb;
> > +
> > +     lmb_push(rlmb);
> > +
> > +     lmb_pop(almb);
>
> This doesn't look look like a good solution to me. We're conflating two
> different concepts into the global lmb. This looks error prone to me. I
> was looking into adding iomb_* entry points into the lmb points which
> take a pointer.

Yes, even I was trying to avoid having another instance of LMB as much
as possible, but given that this is breaking the platform, I thought
this would be the quickest to fix the break. Personally, I would
prefer LMB to have a consistent window of RAM addresses for all
platforms, i.e. ram_base to ram_top. Also, apart from this peculiar
scenario, I am not sure if there would be other uses of having to
allocate anything other than RAM addresses by LMB.

-sughosh


>
> Janne
