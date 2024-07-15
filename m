Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1238BC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 09:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84FC588403;
	Mon, 15 Jul 2024 11:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dxGp7AW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5BF88403; Mon, 15 Jul 2024 11:42:13 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B890582B86
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 11:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58b0beaf703so5044889a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721036531; x=1721641331; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nWiYO0naaql+Glj/IU0SQymT7gDqsT3HfSfVZ9whUd8=;
 b=dxGp7AW+btIJFQjEiHPLMeygdRUi5NYqeDQMW4Q6B+dU/8yX6pY4YaZRQP2wh96J6X
 0s8Kgs1LX7t8J077QyuSP9X5byjqgHQNnU0BRUJ0TDC/86bMe31qHx9NniKLHDzyDD71
 EWnFbfZX+WzKDehjDKjcWnbBRRz5Ov4MT6b6g3nNE8Fmd0zSgY496WIw8650pMfrus4n
 P69Ulr2QfMVGloiGsgCxDowZslfA0Pz/sDS9wytep9hmpV2SPTj2VMiPdWFUlrsAcHvj
 Rp2k3EScZFeV2s5Ek96CNvqpjSHag2xMnnfXtDeMcAw82gNCYvfPQHLReVNvs717RSNR
 BgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721036531; x=1721641331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nWiYO0naaql+Glj/IU0SQymT7gDqsT3HfSfVZ9whUd8=;
 b=RA209LVdfo1hmPP81wtkEWCrCzR9naGgG8HQilcrFyyeP0XOIlmR710i/OWuTP5xud
 eRGDGhx+PSu0mPWE5luvutTcupI2DmMVNmeqAIJZkifeb+L77DP3dUoyDEuypCEyuhXc
 MLUlmANPy4jWP1jsMA31a0Rqi6/IvltN2gdBUJEkyVMFEx7TcXCoHRmlFfimXHEvcmY3
 iWhoGtmd1icrpnNh0sghwgxrEuSX0dOWFaGBfISi0FmIrN37sOLm6uu8W9w98xyWiiKw
 YQf0KA9Mve+rxMSj/ba0CYYRNq3VLoGdQ4ypxTL5Jh7jgS8dxiwB/SoGhAY74aO14TcH
 OV/w==
X-Gm-Message-State: AOJu0YzUzAO2UOFr8ffLilSBcYTcw6RrSUmx8GmVAAt+k+5uDW6uLrdQ
 FbLXMmqzrgqbg3GdNMdVYbJGSu8FjiqJGZPGlRNK/UTRXQucOd8qz1fxY+GOH29ZQjXyYlKdiEh
 SpyQmr2y4JBJcsowhxod8myFl+75X5YlWGjaryQ==
X-Google-Smtp-Source: AGHT+IFnzGV1iJ4wduw9QsvjQsdNQvHzfq0ZV3SY0ObjNM82K6IIxETt0avlv19qRYXYAY1wCo4CqYmNlGthgc2KxZg=
X-Received: by 2002:a05:6402:5256:b0:58d:31f6:2162 with SMTP id
 4fb4d7f45d1cf-594bcab1320mr13095254a12.36.1721036531089; Mon, 15 Jul 2024
 02:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-47-sughosh.ganu@linaro.org>
 <CAFLszThvVSuUMOavz=MqpE5GSm5Yr2CBBUvMkvV7RbNGQEPDVg@mail.gmail.com>
In-Reply-To: <CAFLszThvVSuUMOavz=MqpE5GSm5Yr2CBBUvMkvV7RbNGQEPDVg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 15 Jul 2024 15:11:59 +0530
Message-ID: <CADg8p96xj1MCKnrhKL5JoyrJfbr3xYqmQ00JJtMLAT_hyNKqQA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 46/48] lmb: mark the EFI runtime memory regions as
 reserved
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

hi Simon,

On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Mark the EFI runtime memory region as reserved memory during board
> > init so that it does not get allocated by the LMB module on subsequent
> > memory requests.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: New patch
> >
> >  lib/lmb.c | 41 ++++++++++++++++++++---------------------
> >  1 file changed, 20 insertions(+), 21 deletions(-)
>
> I see again that this is getting circular. Can you look at what is
> actually allocated by EFI on init (i.e. before anything is booted)?

This code is simply ensuring that the EFI runtime regions are marked
as reserved by the LMB module to prevent that region from being
allocated. Do you have any other way by which this can be communicated
to the LMB module ?

-sughosh

>
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 387ec2ac65..6018f1de31 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -19,6 +19,7 @@
> >  #include <asm/global_data.h>
> >  #include <asm/sections.h>
> >  #include <linux/kernel.h>
> > +#include <linux/sizes.h>
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> > @@ -212,33 +213,31 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
> >  /**
> >   * efi_lmb_reserve() - add reservations for EFI memory
> >   *
> > - * Add reservations for all EFI memory areas that are not
> > - * EFI_CONVENTIONAL_MEMORY.
> > + * Add reservations for EFI runtime services memory
> >   *
> > - * Return:     0 on success, 1 on failure
> > + * Return: None
> >   */
> > -static __maybe_unused int efi_lmb_reserve(void)
> > +static __maybe_unused void efi_lmb_reserve(void)
> >  {
> > -       struct efi_mem_desc *memmap = NULL, *map;
> > -       efi_uintn_t i, map_size = 0;
> > -       efi_status_t ret;
> > +       phys_addr_t runtime_start, runtime_end;
> > +       unsigned long runtime_mask = EFI_PAGE_MASK;
> >
> > -       ret = efi_get_memory_map_alloc(&map_size, &memmap);
> > -       if (ret != EFI_SUCCESS)
> > -               return 1;
> > +#if defined(__aarch64__)
> > +       /*
> > +        * Runtime Services must be 64KiB aligned according to the
> > +        * "AArch64 Platforms" section in the UEFI spec (2.7+).
> > +        */
> >
> > -       for (i = 0, map = memmap; i < map_size / sizeof(*map); ++map, ++i) {
> > -               if (map->type != EFI_CONVENTIONAL_MEMORY) {
> > -                       lmb_reserve_flags(map_to_sysmem((void *)(uintptr_t)
> > -                                                       map->physical_start),
> > -                                         map->num_pages * EFI_PAGE_SIZE,
> > -                                         map->type == EFI_RESERVED_MEMORY_TYPE
> > -                                             ? LMB_NOMAP : LMB_NONE);
> > -               }
> > -       }
> > -       efi_free_pool(memmap);
> > +       runtime_mask = SZ_64K - 1;
> > +#endif
> >
> > -       return 0;
> > +       /* Reserve the EFI runtime services memory */
> > +       runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> > +       runtime_end = (uintptr_t)__efi_runtime_stop;
> > +       runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> > +
> > +       lmb_reserve_flags(runtime_start, runtime_end - runtime_start,
> > +                         LMB_NOOVERWRITE | LMB_NONOTIFY);
> >  }
> >
> >  static void lmb_reserve_common(void *fdt_blob)
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
