Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63DAC61D92
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 07:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9BC0875C0;
	Wed, 22 Nov 2023 08:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SD46Cj2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B994B875C3; Wed, 22 Nov 2023 08:39:21 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4451875A1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 08:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50aa8c0af41so582624e87.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700638759; x=1701243559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xa7iJA27o273ic0lAwlSHjUHnuCESXpDkuG7OelPnvg=;
 b=SD46Cj2rc2o0F3Yavf07zTAsS3K21/qiz/hGBID1DDwvn5ZnQWb4+u2sLhVAuKj25s
 xDiPxiHMvAcHwSFQFdynRMupZnvlQwcas9E3FMts17H2r5tAAYBHGQhHnS5M/P6HtnOX
 XiSPmr4/nhWdNEQzTK79Igf3CpJcRZ3EU0ez5QY4KqSVWj2+7y9LMtjgodLUnRIpub+q
 AhAaGRt0qNp3JSfVLK2Q+NcZTCORRIGJGNAhIuqJc7+Tnfo6YwGrdII80VEAtqHQx+ve
 RQZnyni2JRjYZd4epH2MjFpa708g4SW/O207d9CdqpdrlypfObmScaUhTJL9BhjmkuK7
 hEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700638759; x=1701243559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xa7iJA27o273ic0lAwlSHjUHnuCESXpDkuG7OelPnvg=;
 b=ogcmTyqP8QUJVHyw2qOamrR6VG3OnEXA+W9s06Ge6jieVFqK6dbZCxzEEXFslKn2Tc
 7Wnh+dVDNMFp3fw97LTjZZLPgkdMZvilomgzFuHMDvP+apVkO0D7KrPtqsxLmw+Mdx1x
 qlCw9bVm5jUGKzjAagrcPzjDtKT6S3/ow4YoaF/5f5b5wpg5B6FQt63RvS3SYL8sisO8
 5d7eVG8MPdX31vXJlVK2wy0lAWfoPoabHkRVgHMrNqm7+yOp8/ZR2ZbXdstI5qMazhxH
 +LVhT37pdzEUbBC4DORWu2JNRPHHIHQLPoNzcRuuptmAPqmN4Wie5GPVB28v3kbJjWiE
 HQvw==
X-Gm-Message-State: AOJu0YxkjaqNLHQbUA/NMNIhUNJlX4sh7Z6zaLnd1sL1Z9fbX2N/AiIx
 ktXorRZD/WQeZRiKbS4fjdpAJn34kxTRiIlrWW/rZg==
X-Google-Smtp-Source: AGHT+IEfZT38gJZgwHMBMzHr+g4dCASXaht/9u/bucxQB8NfL0JvIlrf8WqAxxWckbf9dcKz80V+iTzqzWAZx/vKw9Q=
X-Received: by 2002:a05:6512:3987:b0:50a:a3a7:488b with SMTP id
 j7-20020a056512398700b0050aa3a7488bmr1911732lfu.18.1700638758867; Tue, 21 Nov
 2023 23:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-7-sjg@chromium.org>
 <07051882-8b13-4878-8f6f-1fe31fe97467@gmx.de>
 <CAPnjgZ3fv_NgDOAA-GdQD084ZTkKi5ZfO2kpUoNDVi9=Ar1iFA@mail.gmail.com>
In-Reply-To: <CAPnjgZ3fv_NgDOAA-GdQD084ZTkKi5ZfO2kpUoNDVi9=Ar1iFA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 22 Nov 2023 09:38:43 +0200
Message-ID: <CAC_iWjJSU7sdkOWBdoqn90koNjj1HyxPL4VrDR10FPtPHGA-AQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] WIP: efi: Allow helloworld to exit boot services
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi Simon,

On Wed, 22 Nov 2023 at 00:10, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Tue, 21 Nov 2023 at 10:17, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 11/21/23 12:35, Simon Glass wrote:
> > > This allows testing of the exit_boot_services call, providing more
> > > coverage of the EFI bootmeth.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > I would prefer to keep helloworld.efi benign.
> >
> > Please, create a new EFI binary for testing ExitBootServices().
>
> Eek...isn't helloworld already used in tets?\

Yes, but calling exitboot services from it means we need to be really
careful when/how we call it, since once that app runs the boottime
services along with any attached disks will disappear.
Instead having a single EFI app that calls that and then tests for any
runtime services is more scalable

Thanks
/Ilias
>
> >
> > > ---
> > >
> > >   lib/efi_loader/helloworld.c | 36 +++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 35 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> > > index 1135d3a3c37e..1fb5fb5a62f2 100644
> > > --- a/lib/efi_loader/helloworld.c
> > > +++ b/lib/efi_loader/helloworld.c
> > > @@ -206,6 +206,26 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
> > >                       (con_out, u"Cannot open loaded image protocol\r\n");
> > >               goto out;
> > >       }
> > > +
> > > +     {
> > > +             ulong ptr = (ulong)loaded_image;
> > > +             u16 str[80];
> > > +             int i;
> > > +
> > > +             for (i = 0; i < 8; i++) {
> > > +                     uint digit = (ptr >> ((7 - i) * 4)) & 0xf;
> > > +
> > > +                     if (digit > 9)
> > > +                             digit = 'a' + digit - 10;
> > > +                     else
> > > +                             digit += '0';
> > > +                     str[i] = digit;
> > > +             }
> > > +             str[i] = 0;
> > > +             con_out->output_string(con_out, str);
> > > +             con_out->output_string(con_out, u"\n");
> > > +     }
> > > +
> > >       print_load_options(loaded_image);
> > >
> > >       /* Get the device path to text protocol */
> > > @@ -243,7 +263,21 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
> > >               goto out;
> > >
> > >   out:
> > > -     boottime->exit(handle, ret, 0, NULL);
> > > +     /*
> > > +      * TODO: Use vendor string to decide whether to call exit-boot-services
> > > +      */
> > > +     efi_uintn_t map_size = 0;
> > > +     efi_uintn_t map_key;
> > > +     efi_uintn_t desc_size;
> > > +     u32 desc_version;
> > > +
> > > +     ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
> > > +                                    &desc_version);
> > > +     con_out->output_string(con_out, u"Exiting boot sevices\n");
> > > +
> > > +     boottime->exit_boot_services(handle, map_key);
> > > +
> > > +     ret = boottime->exit(handle, ret, 0, NULL);
> >
> > After ExitBootServices() you must not call boot services.
> >
> > Call runtime->reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL) instead.
>
> OK, will do. That will be ignored by sandbox, right?
>
> For now this is just a hack to try to resolve the problem mentioned.
>
> Regards,
> Simon
