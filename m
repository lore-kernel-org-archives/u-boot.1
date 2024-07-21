Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC6C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7535E87F9F;
	Sun, 21 Jul 2024 12:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U/Kh1ND9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E24488001; Sun, 21 Jul 2024 12:08:50 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B2487F5C
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b78c980981so20465456d6.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556525; x=1722161325; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=36O+BEdFNicVjL4sTfQ2K3Eyg+ugPgUYVWXxVaRp0TE=;
 b=U/Kh1ND9/Ur9im5RAyM7mowe8iVCbkWQN5cjqOlwE3A2s5Pa8PwXWaGwHAVJzPsW2J
 lsIN9RQQPhbe/8lii5KyoZaLwsfvmYVOh84wKe+MDIqYyH4VKUmyvnLv1iwE8FdrKNPQ
 jBBHR0wJ2wBnKYJ7TXjSdaL/QM3AZdLpIo9RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556525; x=1722161325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=36O+BEdFNicVjL4sTfQ2K3Eyg+ugPgUYVWXxVaRp0TE=;
 b=CavvKdM+aYsq/a2tpGOB6hCFPxtumPUblCd5fJfZ+AqsTGnPfStDT0czvTSZdmZnJU
 AzRNoJsTIHqTZsNl6cuobhsTKEfR/JAaQCb3Lwoqmq3NAxuoogP5fhEyZHxMbjtDbhYN
 G4pOlQDodINhrLdfp0i6DN5THvI+usv7FAsQVxoEsHGV+pbKtoF+12gTMEvmDHniHT67
 I1EC6JGJ+h4A74CU/j0cVwt2rkJWTRXx+nTmW7WcdwZZWVriQ3r4ouD1ZYvC4j1OgT/u
 5E8/X89QhEk40wRNhqaBt+Y9xzdhn2gjUP7w1YUw4avNl7XTVzaNOaMMoMsEoJ6FiV7f
 lRUQ==
X-Gm-Message-State: AOJu0Yy1ItjVhPnSBYMPbNHaDerxDB7O56BYRgAtrG/raFI2KsoFGcx4
 AcdYqHHO27avhgbfPMhtAyjy3wLBhXPhITmf/6INKGD5zFqthJ0BVMQKqIhyoDZInmG9z9qnfU3
 ZToraP4PadTrcNBHFmy6V+BcyN+NLy+KI0e+o
X-Google-Smtp-Source: AGHT+IHOZFB12HppjYRy0PWAVdFfNtiv3sf+Es7ecyGE0SGWCV/ewFs0tAl98kW82P5qp5EjLp/wJa+R9zr9URIOJFk=
X-Received: by 2002:a05:6214:c6e:b0:6b7:42bd:99f6 with SMTP id
 6a1803df08f44-6b9610bd080mr46700066d6.33.1721556525296; Sun, 21 Jul 2024
 03:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-4-sjg@chromium.org>
 <3354d01b-5994-6954-bce9-798cc6af156c@gmail.com>
In-Reply-To: <3354d01b-5994-6954-bce9-798cc6af156c@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jul 2024 11:08:34 +0100
Message-ID: <CAFLszThgQr3GyzFeW8EtqrzNifncf0DO-AB-2EKH=o7nQeanww@mail.gmail.com>
Subject: Re: [PATCH 03/14] spl: Remove some #ifdefs in spl_parse_image_header()
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
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

Hi Sean,

On Sat, 20 Jul 2024 at 16:34, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 7/20/24 02:16, Simon Glass wrote:
> > This function has a number of unnecessary #ifdefs so remove them.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   common/spl/spl.c | 22 +++++++++++-----------
> >   1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index 6f4a8bfb3f4..02567e766f1 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -308,8 +308,10 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
> >               ret = spl_parse_legacy_header(spl_image, header);
> >               if (ret)
> >                       return ret;
> > -     } else {
> > -#ifdef CONFIG_SPL_PANIC_ON_RAW_IMAGE
> > +             return 0;
> > +     }
> > +
> > +     if (IS_ENABLED(CONFIG_SPL_PANIC_ON_RAW_IMAGE)) {
> >               /*
> >                * CONFIG_SPL_PANIC_ON_RAW_IMAGE is defined when the
> >                * code which loads images in SPL cannot guarantee that
> > @@ -319,10 +321,9 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
> >                * is bad, and thus should be skipped silently.
> >                */
> >               panic("** no mkimage signature but raw image not supported");
> > -#endif
> > +     }
> >
> > -#if CONFIG_IS_ENABLED(OS_BOOT)
> > -#if defined(CONFIG_CMD_BOOTI)
> > +     if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI)) {
>
> Maybe this should be IS_ENABLED(CONFIG_SPL_OS_BOOT) since this file cannot be compiled except in SPL.

We do compile it with tpl though, so we want to avoid enabling this
option in that case.

>
> >               ulong start, size;
> >
> >               if (!booti_setup((ulong)header, &start, &size, 0)) {
> > @@ -336,7 +337,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
> >                             spl_image->load_addr, spl_image->size);
> >                       return 0;
> >               }
> > -#elif defined(CONFIG_CMD_BOOTZ)
> > +     } else if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTZ)) {
> >               ulong start, end;
> >
> >               if (!bootz_setup((ulong)header, &start, &end)) {
> > @@ -350,11 +351,11 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
> >                             spl_image->load_addr, spl_image->size);
> >                       return 0;
> >               }
> > -#endif
> > -#endif
> > +     }
> >
> > -             if (!spl_parse_board_header(spl_image, bootdev, (const void *)header, sizeof(*header)))
> > -                     return 0;
> > +     if (!spl_parse_board_header(spl_image, bootdev, (const void *)header,
> > +                                 sizeof(*header)))
> > +             return 0;
> >
> >   #ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
> >               /* Signature not found - assume u-boot.bin */
> > @@ -366,7 +367,6 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
> >               debug("Raw boot image support not enabled, proceeding to other boot methods\n");
> >               return -EINVAL;
> >   #endif
> > -     }
> >
> >       return 0;
> >   }
>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>

Thanks for all your reviews!

Regards,
Simon
