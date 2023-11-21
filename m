Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AB4C61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB87875FB;
	Tue, 21 Nov 2023 23:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cTvz0SSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 199DC87585; Tue, 21 Nov 2023 23:10:58 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2619A87563
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a02ba1f500fso141695666b.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604655; x=1701209455; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WvHAcp47btrWMjA7VbkdKRxRYXnbEDNO49pxckoYRWg=;
 b=cTvz0SSdn6W4wChS7N2o3K+F4PAx6IjAm7k4gO9walCmk6+9eDxIz35WG0LgsKv3eI
 MZmArKRq2xh0JHwHaeKrWUm/eaoRddZdWVp/w0DHKfJYOVTgVeXRA1iA6ROytGfW1Brd
 cydGJ8s/H+0s0TTMGbuKD5impfvUVOguzW5no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604655; x=1701209455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WvHAcp47btrWMjA7VbkdKRxRYXnbEDNO49pxckoYRWg=;
 b=OITKz6tis5mmgCqeSbTlWCqr0hk/K7xFYRwovJT+3sCeOfO1TtwDUNWHyFsQUqJKfL
 mkyiYAQu9FkUvJR1+cg9IH3E/KEm088t2lKHNdUEFqPfZ8/PacOo8hT5JWpyr1om5iEQ
 BvgVtU5nAWmbypN3Et6skZG009Zhn+kfamn831SrOEayMRijm6NS7Z33CVftTBUM7xzv
 bDednL34armoNc3ehcopFzoG3h6GQuw4FfxmMA6NLqWFrStq/qB29hCgI1iAkq8ahTM3
 0vblzL8j2LfgLd3pyOSJU5sSMAwgK/Ukf8V3ynabnGcKyFb6l8Hw4HNqLL9A+87kcTQC
 WahA==
X-Gm-Message-State: AOJu0Yzv08K8wwU2EwuRBYafG9EbbfkVv5oEas4VgLZNHvDU6Frv94sh
 8kRF3ml6aBzDyyoP1gFJ7snmX6bLRsRY3k54OWqjWlwKk3G3QKIAMUk=
X-Google-Smtp-Source: AGHT+IF0uq1if9PS3DRZIYC8/R9Mx0HIP/lS5i2+iJAhKAs7wwyd8ZXlSLrnsWnL1oLhVtFSRO05V4XxfqaJieOYEEo=
X-Received: by 2002:a17:907:b92:b0:9b2:df16:851d with SMTP id
 ey18-20020a1709070b9200b009b2df16851dmr166677ejc.57.1700604655483; Tue, 21
 Nov 2023 14:10:55 -0800 (PST)
MIME-Version: 1.0
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-7-sjg@chromium.org>
 <07051882-8b13-4878-8f6f-1fe31fe97467@gmx.de>
In-Reply-To: <07051882-8b13-4878-8f6f-1fe31fe97467@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:10:44 -0700
Message-ID: <CAPnjgZ3fv_NgDOAA-GdQD084ZTkKi5ZfO2kpUoNDVi9=Ar1iFA@mail.gmail.com>
Subject: Re: [PATCH 6/7] WIP: efi: Allow helloworld to exit boot services
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

On Tue, 21 Nov 2023 at 10:17, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/21/23 12:35, Simon Glass wrote:
> > This allows testing of the exit_boot_services call, providing more
> > coverage of the EFI bootmeth.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I would prefer to keep helloworld.efi benign.
>
> Please, create a new EFI binary for testing ExitBootServices().

Eek...isn't helloworld already used in tets?

>
> > ---
> >
> >   lib/efi_loader/helloworld.c | 36 +++++++++++++++++++++++++++++++++++-
> >   1 file changed, 35 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> > index 1135d3a3c37e..1fb5fb5a62f2 100644
> > --- a/lib/efi_loader/helloworld.c
> > +++ b/lib/efi_loader/helloworld.c
> > @@ -206,6 +206,26 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
> >                       (con_out, u"Cannot open loaded image protocol\r\n");
> >               goto out;
> >       }
> > +
> > +     {
> > +             ulong ptr = (ulong)loaded_image;
> > +             u16 str[80];
> > +             int i;
> > +
> > +             for (i = 0; i < 8; i++) {
> > +                     uint digit = (ptr >> ((7 - i) * 4)) & 0xf;
> > +
> > +                     if (digit > 9)
> > +                             digit = 'a' + digit - 10;
> > +                     else
> > +                             digit += '0';
> > +                     str[i] = digit;
> > +             }
> > +             str[i] = 0;
> > +             con_out->output_string(con_out, str);
> > +             con_out->output_string(con_out, u"\n");
> > +     }
> > +
> >       print_load_options(loaded_image);
> >
> >       /* Get the device path to text protocol */
> > @@ -243,7 +263,21 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
> >               goto out;
> >
> >   out:
> > -     boottime->exit(handle, ret, 0, NULL);
> > +     /*
> > +      * TODO: Use vendor string to decide whether to call exit-boot-services
> > +      */
> > +     efi_uintn_t map_size = 0;
> > +     efi_uintn_t map_key;
> > +     efi_uintn_t desc_size;
> > +     u32 desc_version;
> > +
> > +     ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
> > +                                    &desc_version);
> > +     con_out->output_string(con_out, u"Exiting boot sevices\n");
> > +
> > +     boottime->exit_boot_services(handle, map_key);
> > +
> > +     ret = boottime->exit(handle, ret, 0, NULL);
>
> After ExitBootServices() you must not call boot services.
>
> Call runtime->reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL) instead.

OK, will do. That will be ignored by sandbox, right?

For now this is just a hack to try to resolve the problem mentioned.

Regards,
Simon
