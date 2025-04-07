Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ADCC3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18DC82DED;
	Mon,  7 Apr 2025 12:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cOzojDmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE2882CE7; Mon,  7 Apr 2025 12:49:28 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF30782DED
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so713014866b.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744022965; x=1744627765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tGIz201AJiMByBdm7o1HV9dBRGvoTi2xKRXLnNQ8xbQ=;
 b=cOzojDmVtQ3ZZ4qI8s2jIHyxZXeBwf6nvroMxdERadCcSgW7yVcoOb09rHA6sLDjts
 XngTWaMf3lzYX9o+2LwuAiy715B5VCut3oMcWhbbdFNnLk7Kmiq4dhCF2NxhWSe7rAMq
 1wE99ZUljAeaXhPv8PIXz6lHk/k9cf680MkPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744022965; x=1744627765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tGIz201AJiMByBdm7o1HV9dBRGvoTi2xKRXLnNQ8xbQ=;
 b=EKx4yuxN/bNEHlG9BoEThAegQlIaYq9d5cFkdkVi3cY39kxifwwlxSdG2OGGULAuFR
 6TZonn73UOvoSu+m00kCDaDkmkFemCVr3LHG4W1qceF//pbqC+/Mx1GuJoJ2QDL6nGvf
 Gq5A/aYb0PzNx9ogrsXa+Sy+A7wirvS7yeT7IVQvL1vitHB+YgzLPcl4qdqx1P4WiwSH
 e3ZqSSBEeAcsg9XoAx5kuZhgh6nnXWPW0usm1jc4ja70KXCLCFKCgtkIsFjrpbxdOo3m
 5rea61KnXMzhuMPwH+93Jt0+Nj7FtToYrlTEbeOLe/mzHBEvfkEd+LxlV31ZGO/wbzgs
 UJZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwjukjJYUTZlIL2oAMteM8aNgIe0+o9p1PXyx8Bz9TcgaVsaSIaN8P9xgbg2yku2EytEo4BMg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8qWzek/eArob3WbzxMd4liFOzBoWcSigcgBloZlSbYbS4huTJ
 +vkmLLfY2tHCm69aG92+Pz9Dku9LOZOZzmmxwZyPbyzRVg+VCtQ9eGYjylF3SFG6cM999V2gDD9
 CrFjFWdVJgoGdhb4vIu53KcMlA/GAKkCr75qS
X-Gm-Gg: ASbGnctBdUS7lKNH2kPEJJQ0U+2vlK8FKdxzahDAUuEz6Ep0TfUt1aW0oxFQvl9elhS
 /4UKG62SBy0tVgjfxRVcue7250Iu3sqJo1ZptyaTsEbt4Wpxx4uHnws3Lk3xc+9Xgtrl6UN+xIk
 Jy/0xCJ81MvsK7LERT07zRoJlnoyQ=
X-Google-Smtp-Source: AGHT+IH2vy7wwgRFbXpTLu7IyxrSW1/W9NH4KqNZiQg2kgG1J/ohnqInVDT5SxXIKTGYxigYeq7wom2hl/ClD+WJdzY=
X-Received: by 2002:a17:907:86a2:b0:ac7:b48f:4cd6 with SMTP id
 a640c23a62f3a-ac7d6d567bemr1025096666b.24.1744022965083; Mon, 07 Apr 2025
 03:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-5-sjg@chromium.org>
 <ae928b59-23c1-4148-81b2-85dc5e261868@gmx.de>
In-Reply-To: <ae928b59-23c1-4148-81b2-85dc5e261868@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 22:49:11 +1200
X-Gm-Features: ATxdqUHxEQWz-ChzsMMXWs6vuzOXPgfwFpIhVYa9VwsZVnfoiCbCalf7jS1D2Qs
Message-ID: <CAFLszTgdCJMPVL6StLygGBT_GKJQXbpGGDT1tDqWMs9-kToEVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dm: core: Rename dm_remove_devices_active()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
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

Hi Heinrich,

On Mon, 7 Apr 2025 at 19:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.04.25 03:35, Simon Glass wrote:
> > This function doesn't have a great name, since we talk of devices being
> > active once they are probed.
> >
> > Rename it to dm_remove_dma_devices().
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >
> > (no changes since v1)
> >
> >   arch/arm/lib/bootm.c          | 4 ++--
> >   arch/riscv/lib/bootm.c        | 2 +-
> >   arch/x86/lib/bootm.c          | 2 +-
> >   drivers/core/root.c           | 2 +-
> >   include/dm/root.h             | 6 +++---
> >   lib/efi_loader/efi_boottime.c | 2 +-
> >   test/dm/core.c                | 2 +-
> >   7 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
> > index 688c2f3f29b..ef859a2cd4c 100644
> > --- a/arch/arm/lib/bootm.c
> > +++ b/arch/arm/lib/bootm.c
> > @@ -74,10 +74,10 @@ static void announce_and_cleanup(int fake)
> >        * Call remove function of all devices with a removal flag set.
> >        * This may be useful for last-stage operations, like cancelling
> >        * of DMA operation or releasing device internal buffers.
> > -      * dm_remove_devices_active() ensures that vital devices are removed in
> > +      * dm_remove_dma_devices() ensures that vital devices are removed in
> >        * a second round.
> >        */
> > -     dm_remove_devices_active();
> > +     dm_remove_dma_devices();
> >
> >       cleanup_before_linux();
> >   }
> > diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> > index 76c610bcee0..9aecaafef43 100644
> > --- a/arch/riscv/lib/bootm.c
> > +++ b/arch/riscv/lib/bootm.c
> > @@ -57,7 +57,7 @@ static void announce_and_cleanup(int fake)
> >        * This may be useful for last-stage operations, like cancelling
> >        * of DMA operation or releasing device internal buffers.
> >        */
> > -     dm_remove_devices_active();
> > +     dm_remove_dma_devices();
> >
> >       cleanup_before_linux();
> >   }
> > diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> > index 3c420b00936..91e8de4e1ad 100644
> > --- a/arch/x86/lib/bootm.c
> > +++ b/arch/x86/lib/bootm.c
> > @@ -50,7 +50,7 @@ void bootm_announce_and_cleanup(void)
> >        * This may be useful for last-stage operations, like cancelling
> >        * of DMA operation or releasing device internal buffers.
> >        */
> > -     dm_remove_devices_active();
> > +     dm_remove_dma_devices();
> >   }
> >
> >   #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
> > diff --git a/drivers/core/root.c b/drivers/core/root.c
> > index c7fb58285ca..101cc4d43fa 100644
> > --- a/drivers/core/root.c
> > +++ b/drivers/core/root.c
> > @@ -148,7 +148,7 @@ int dm_remove_devices_flags(uint flags)
> >       return 0;
> >   }
> >
> > -void dm_remove_devices_active(void)
> > +void dm_remove_dma_devices(void)
> >   {
> >       /* Remove non-vital devices first */
> >       device_remove(dm_root(), DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
> > diff --git a/include/dm/root.h b/include/dm/root.h
> > index 5651b868c8b..39a069cd465 100644
> > --- a/include/dm/root.h
> > +++ b/include/dm/root.h
> > @@ -169,16 +169,16 @@ int dm_uninit(void);
> >   int dm_remove_devices_flags(uint flags);
> >
> >   /**
> > - * dm_remove_devices_active - Call remove function of all active drivers heeding
> > + * dm_remove_dma_devices - Call remove function of all active drivers heeding
> >    *                            device dependencies as far as know, i.e. removing
> >    *                            devices marked with DM_FLAG_VITAL last.
> >    *
> >    * All active devices will be removed
> >    */
> > -void dm_remove_devices_active(void);
> > +void dm_remove_dma_devices(void);
>
> We have to remove all active devices. Not only DMA devices but also any
> device that creates interrupts.
>
> The renaming is misleading.

Yes, but so is the existing name, as mentioned.

How about dm_remove_for_boot() ?

Regards,
Simon
