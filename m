Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15B7C369A2
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A7F82F42;
	Mon,  7 Apr 2025 17:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J3JQzAAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4FF782F65; Mon,  7 Apr 2025 17:23:35 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B33C682ED0
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 17:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so817775366b.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744039413; x=1744644213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JLkhinkyUoALOBX3IFMYUFuCroyM/XGZgtCPP3dKftU=;
 b=J3JQzAAnkOxx/+wiBhAuWmTauha5dFJmf3VzD2F6S5HHMTtD7pbLj9Opm6nWfqh9D1
 GcLv8darzGFLLynX+IsC3gm6yR6KRGYu/kYX7LOwws3QW+xHykx9A6nVmXF615vYVnlM
 hkxK3oaRgQRgU3zGQ5rAt0c8iPSwbY1edw2I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744039413; x=1744644213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JLkhinkyUoALOBX3IFMYUFuCroyM/XGZgtCPP3dKftU=;
 b=NmwDNLJgrsWmp3P2bemDT3vtyLaUZomnApWPjqUyy5BvtiyxiV5+SY5EEvXULVv5c3
 X3xIyZyrv0WJo/QA5pGE0fx+BXJ8rsV1Z+wHbou/odwSSJiKS6KeybquHayqYhNDMBcb
 LCn3roK0VF6JpbopzCDcRwrn6hiF6HHF6/Q0SKdWkzYWFGGu80ZXptBm5PUJGuJfRPY8
 wHaJy0g70NbVrhfkslhnT1iRWVsbXxNZ74lxl5Hodccab0dgLYxjPc+ihdLuyJSqpnnH
 +X9676fbNV+UYTkXRLXrK9CifBV+tf/VeTdne90CCmMpcckPEoC3YQp1UbNx37OmqL/D
 wvWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSqfpF9xUO92QNhtVGGufbWjSkmZIf3q+19mmS5tP6UOMJssoGdZNWdcpVAA1d2IgXV8HpheQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwZRei48MnoMe3i4e4cuvY4SRUezMjdvsWl6GaJT7boonUWYN8V
 86gcW7qgYysNC3mjR0y5XOrG4CYoVngp+JgSXY9aDkoI/OQvt3KUfWLdAXVnjBwde7kybz4zYdQ
 MqG824u9d91yrUgmqXR6zLPdnl3ZqxzvVXPEx
X-Gm-Gg: ASbGnctSwXc11ynk937gG5uUV1Kookq1O9rB34g6LJa4r8o/OALCgWaCaIGeZhJghsN
 ix/swSbFpiZHTY5SmnQHz0RaJ9hQGf428EIXJEeyzoKvmU9dRkyacDwiaqyFGbVzsuulT+lngaP
 T+K9TyK1nlfzMm3Co3Czs77DAS4b6gDXsvwKJTCX081HK9CNXxptWQrPQERCQ=
X-Google-Smtp-Source: AGHT+IGiH4jS1E/0K8l/19BHOj3sdZTlS8OQiygSbi2HKpxPkyhaRn8qPg+BUowmKB2FYYsw1pPryTwYfN5u/5w1jGA=
X-Received: by 2002:a17:907:94d0:b0:ac1:e53c:d13f with SMTP id
 a640c23a62f3a-ac7e7776771mr831352066b.50.1744039412787; Mon, 07 Apr 2025
 08:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-5-sjg@chromium.org>
 <ae928b59-23c1-4148-81b2-85dc5e261868@gmx.de>
 <CAFLszTgdCJMPVL6StLygGBT_GKJQXbpGGDT1tDqWMs9-kToEVQ@mail.gmail.com>
 <20250407133049.GI5495@bill-the-cat>
In-Reply-To: <20250407133049.GI5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 09:23:18 -0600
X-Gm-Features: ATxdqUH1EayPS-Pay8bV78ERw4m6eQVmzP6HM94jjhNDHzuW94YHxzDoaeuXsjo
Message-ID: <CAFLszTihXSnCSmY9NDf4=VRHxUEzTP8ScT7=3aEduZa9VM-XMg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dm: core: Rename dm_remove_devices_active()
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 neil.armstrong@linaro.org, Jonas Karlman <jonas@kwiboo.se>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Rick Chen <rick@andestech.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

Hi Tom,

On Mon, 7 Apr 2025 at 07:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Apr 07, 2025 at 10:49:11PM +1200, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 7 Apr 2025 at 19:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 07.04.25 03:35, Simon Glass wrote:
> > > > This function doesn't have a great name, since we talk of devices being
> > > > active once they are probed.
> > > >
> > > > Rename it to dm_remove_dma_devices().
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >   arch/arm/lib/bootm.c          | 4 ++--
> > > >   arch/riscv/lib/bootm.c        | 2 +-
> > > >   arch/x86/lib/bootm.c          | 2 +-
> > > >   drivers/core/root.c           | 2 +-
> > > >   include/dm/root.h             | 6 +++---
> > > >   lib/efi_loader/efi_boottime.c | 2 +-
> > > >   test/dm/core.c                | 2 +-
> > > >   7 files changed, 10 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
> > > > index 688c2f3f29b..ef859a2cd4c 100644
> > > > --- a/arch/arm/lib/bootm.c
> > > > +++ b/arch/arm/lib/bootm.c
> > > > @@ -74,10 +74,10 @@ static void announce_and_cleanup(int fake)
> > > >        * Call remove function of all devices with a removal flag set.
> > > >        * This may be useful for last-stage operations, like cancelling
> > > >        * of DMA operation or releasing device internal buffers.
> > > > -      * dm_remove_devices_active() ensures that vital devices are removed in
> > > > +      * dm_remove_dma_devices() ensures that vital devices are removed in
> > > >        * a second round.
> > > >        */
> > > > -     dm_remove_devices_active();
> > > > +     dm_remove_dma_devices();
> > > >
> > > >       cleanup_before_linux();
> > > >   }
> > > > diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> > > > index 76c610bcee0..9aecaafef43 100644
> > > > --- a/arch/riscv/lib/bootm.c
> > > > +++ b/arch/riscv/lib/bootm.c
> > > > @@ -57,7 +57,7 @@ static void announce_and_cleanup(int fake)
> > > >        * This may be useful for last-stage operations, like cancelling
> > > >        * of DMA operation or releasing device internal buffers.
> > > >        */
> > > > -     dm_remove_devices_active();
> > > > +     dm_remove_dma_devices();
> > > >
> > > >       cleanup_before_linux();
> > > >   }
> > > > diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> > > > index 3c420b00936..91e8de4e1ad 100644
> > > > --- a/arch/x86/lib/bootm.c
> > > > +++ b/arch/x86/lib/bootm.c
> > > > @@ -50,7 +50,7 @@ void bootm_announce_and_cleanup(void)
> > > >        * This may be useful for last-stage operations, like cancelling
> > > >        * of DMA operation or releasing device internal buffers.
> > > >        */
> > > > -     dm_remove_devices_active();
> > > > +     dm_remove_dma_devices();
> > > >   }
> > > >
> > > >   #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
> > > > diff --git a/drivers/core/root.c b/drivers/core/root.c
> > > > index c7fb58285ca..101cc4d43fa 100644
> > > > --- a/drivers/core/root.c
> > > > +++ b/drivers/core/root.c
> > > > @@ -148,7 +148,7 @@ int dm_remove_devices_flags(uint flags)
> > > >       return 0;
> > > >   }
> > > >
> > > > -void dm_remove_devices_active(void)
> > > > +void dm_remove_dma_devices(void)
> > > >   {
> > > >       /* Remove non-vital devices first */
> > > >       device_remove(dm_root(), DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
> > > > diff --git a/include/dm/root.h b/include/dm/root.h
> > > > index 5651b868c8b..39a069cd465 100644
> > > > --- a/include/dm/root.h
> > > > +++ b/include/dm/root.h
> > > > @@ -169,16 +169,16 @@ int dm_uninit(void);
> > > >   int dm_remove_devices_flags(uint flags);
> > > >
> > > >   /**
> > > > - * dm_remove_devices_active - Call remove function of all active drivers heeding
> > > > + * dm_remove_dma_devices - Call remove function of all active drivers heeding
> > > >    *                            device dependencies as far as know, i.e. removing
> > > >    *                            devices marked with DM_FLAG_VITAL last.
> > > >    *
> > > >    * All active devices will be removed
> > > >    */
> > > > -void dm_remove_devices_active(void);
> > > > +void dm_remove_dma_devices(void);
> > >
> > > We have to remove all active devices. Not only DMA devices but also any
> > > device that creates interrupts.
> > >
> > > The renaming is misleading.
> >
> > Yes, but so is the existing name, as mentioned.
> >
> > How about dm_remove_for_boot() ?
>
> I think the name itself is fine and maybe just a bit more
> documentation? It's dealing with the DM_REMOVE_ACTIVE_ALL flag
> after all.

Yes,  it is. I would like to more clearly separate the naming, but I
haven't come up with a great option. So let's drop this patch.

Regards,
SImon
