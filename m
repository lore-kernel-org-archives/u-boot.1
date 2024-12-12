Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4ACE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18298801BE;
	Thu, 12 Dec 2024 16:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IpLUx9EY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C75F6801FE; Thu, 12 Dec 2024 16:45:10 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A978018E
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f00da6232bso6890227b3.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734018307; x=1734623107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F+wvw6zmYUp17w+0bhTGEwjBxPYtUJ+ra955JZyyTVA=;
 b=IpLUx9EYHh91wKWZB+aMyOv6UvhpcHowP/9o2kwSUkVCqI0YlTHaBN7wsjJPZR5n/y
 kYP8fHqgwjVNQJ2ApZNNgz/ibzUXsaKlArRqHzZ/mmwzHZ0ca+fT638R3ted306JTCRc
 dgkCMyjdGZxRUfWIkrd7MMQlHIuCFId/KXxXjaip+AvI1tkDK8xRE2CvExc47cenY7aE
 LiHWXxK52KsamZzaULBUxH4Q5IuJO66gpXyL8J1lT+3timqeiViTGqLHVH4Y/6yi81QH
 xR27BEKbiMEGAcEeMVr4MOX+/sW2lMOXDLzQCw+u8B51FHlqfAuF5AHMd0YMdlKNso/F
 doYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734018307; x=1734623107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F+wvw6zmYUp17w+0bhTGEwjBxPYtUJ+ra955JZyyTVA=;
 b=YIW+97Xg5sXwjt2uJbj+6Yffi7Pj63B/noyCctGOAis4Rnmli9xvxzRTGiJkJHaQXV
 t/8gzyJVLKuQSH8/5YoBg91o/DTlrwQ3ptkMl1FBJ3F4VPa5GVjdJ9u2pm20nuUT3HE0
 cvpqdxblwOMH05ls/62MjOXlPDJE8H9Skw6i0BSQnT14nXtPzrvGD1u/F6pg7cKGEy73
 evX/MS32w+yrRFPlI/TEY9l37+lfTUFnYKMROwN1n2cskPd8ytbY+OCyi8QJ0hcb0cN9
 +yClHk6VRlShDzw0PW6WQ6Nz6FLb9TzSbaU3q9HbDcpn6hepzlp7sIFGWdWQdk39rWJu
 z/CA==
X-Gm-Message-State: AOJu0Yz8S8L54PfLlZCO63mBEq3SCW8Tj4ugg2gSAQTGwHLtJMgjC1za
 fhipjA32xfSS0Jor5G9jQVM+CjYdWW09Q2mERzbeVgCItHJMFGCSWQm39OSZZSZYgUkbnsWEJYf
 EY7Km8qdv2Du1GH2ctr90bv9lYLsn99QOLhynsw==
X-Gm-Gg: ASbGncviuzRLnPCuzcjBoWUAOyoKioeEcvsD0T6TdNHLBn/t3ngVvT6ohIQPIeeLKSe
 w0FG+PoeQcQR6j064gCtwrNa5dDn8hoRFXIuIoA==
X-Google-Smtp-Source: AGHT+IGvPoHv36OOyrshdl9s9mi1A8vuCi9tbVE+JCSIGG30n4w6Mu50zmUKwW297qDM2PYp/QRN53+x5Ptfc6JXuaQ=
X-Received: by 2002:a05:690c:4c05:b0:6ef:c24e:5e2 with SMTP id
 00721157ae682-6f2752b46c2mr7771017b3.19.1734018307228; Thu, 12 Dec 2024
 07:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-5-sjg@chromium.org>
 <CAC_iWjKaywBv3qyk=fHNqH_anC3xT63Ua2=DMG2w1=LEt2vDLg@mail.gmail.com>
 <CAFLszTj8z+CL4FU_6yGjvN82ARYr3ZiWsGd7h9A=p6ObhEKcug@mail.gmail.com>
In-Reply-To: <CAFLszTj8z+CL4FU_6yGjvN82ARYr3ZiWsGd7h9A=p6ObhEKcug@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 17:44:31 +0200
Message-ID: <CAC_iWjJtG2qoHEWW8h7hVVU1c6+dPFJ3X7jYSe5H0UzXkSHxcQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>
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

On Thu, 12 Dec 2024 at 15:45, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 12 Dec 2024 at 00:49, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > This uses a few global variables at present. With the bootflow we have
> > > the required parameters, so add a function which accepts these. Update
> > > the existing function to call the new one with the globals.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
> > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > > index 8febd325f34..8ebd48547cb 100644
> > > --- a/lib/efi_loader/efi_bootbin.c
> > > +++ b/lib/efi_loader/efi_bootbin.c
> > > @@ -209,18 +209,22 @@ out:
> > >  }
> > >
> > >  /**
> > > - * efi_binary_run() - run loaded UEFI image
> > > + * efi_binary_run_() - run loaded UEFI image
> > >   *
> > >   * @image_ptr: memory address of the UEFI image
> > >   * @size:      size of the UEFI image
> > >   * @fdt:       device-tree
> > > + * @device:    EFI device-path
> > > + * @image:     EFI image-path
> > >   *
> > >   * Execute an EFI binary image loaded at @image.
> > >   * @size may be zero if the binary is loaded with U-Boot load command.
> > >   *
> > >   * Return:     status code
> > >   */
> > > -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > > +efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> > > +                            struct efi_device_path *device,
> > > +                            struct efi_device_path *image)
> > >  {
> >
> > This needs to be static here. Not the next patch. But I don't think we
> > need this at all (look below)
> >
> > >         efi_status_t ret;
> > >
> > > @@ -236,6 +240,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > >         if (ret != EFI_SUCCESS)
> > >                 return ret;
> > >
> > > -       return efi_run_image(image_ptr, size, bootefi_device_path,
> > > -                            bootefi_image_path);
> > > +       return efi_run_image(image_ptr, size, device, image);
> > > +}
> > > +
> > > +/**
> > > + * efi_binary_run() - run loaded UEFI image
> > > + *
> > > + * @image:     memory address of the UEFI image
> > > + * @size:      size of the UEFI image
> > > + * @fdt:       device-tree
> > > + *
> > > + * Execute an EFI binary image loaded at @image.
> > > + * @size may be zero if the binary is loaded with U-Boot load command.
> > > + *
> > > + * Return:     status code
> > > + */
> > > +efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > > +{
> > > +       return efi_binary_run_(image, size, fdt, bootefi_device_path,
> > > +                              bootefi_image_path);
> > >  }
> >
> > We don't need functions and wrappers for such a simple call. Just
> > update all the callisites with the extra parameters and keep one
> > function
>
> If you look at the two call sites, you'll see that they would need to
> pass bootefi_device_path and bootefi_image_path in. but these are
> static variables in this file.

Ah fair enough, then please rename efi_binary_run_ -> _efi_binary_run
ands make it static on this patch

Thanks
/Ilias
>
> >
> > Thanks
> > /Ilias
> > > --
> > > 2.34.1
> > >
>
> Regards,
> Simon
