Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AADE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 03:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45E7A8018E;
	Fri, 13 Dec 2024 04:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V3RA6+yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B1180192; Fri, 13 Dec 2024 04:53:24 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C78A80141
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa69077b93fso189037766b.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 19:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734062002; x=1734666802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KNlSYNSYYkpYYKAS1bQMVTO8cpWwFUOtScQh9UdLSB4=;
 b=V3RA6+ycrSd8D0g0mWjriIBYcBoH/841caA6k2+0kaoZeWBxbTKTnIp+6TBZkqFVrD
 cDSQHr48uLtT0nnFvRCPtJD152EAJFNTkeVjp/bPCel5Wz1JK+DALJTrbMx2miOpYgFd
 Pi6waiaQKXMzRkzCc5zAhw/Uri/xW4gNOm7e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734062002; x=1734666802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KNlSYNSYYkpYYKAS1bQMVTO8cpWwFUOtScQh9UdLSB4=;
 b=N0BGFMkeIMftSECdq5Xh1issbW0W1Oyt7zqE9PrI6nY/E9bOtGlbOXHQQv6vV3g87O
 h45znqrIxjoiIX/BjNp5eIluTlKmHIQKijVRZrR/viu1TPSg/K7H61tPBGh0HdBO/kwZ
 Da9AcE+E713vVS7oX8lIZHuxAPFAwWPCDM+PcXD86svn3khOoy4MgG6RusonK1uRz1B8
 j7x67K8A5F4i/jqmm50vkHzjsn9P0BPOFONZ7c1tElxbF8BAgmZcU+KzBfhAXcOt4/rs
 fhu1QekwdORl4pbzjSoaYWHynBCh3Sd1u6gOfBM9/7KsGQbgYtKFV0Tt2XkyK3DgJxzI
 Pieg==
X-Gm-Message-State: AOJu0YxNFADdkCv4o2l3e/VOwhOlcLer3Uty26SVtNYDHt5PtrvU2lYK
 14EAntuBjVnmHiUndwQ4a6m6jcxfr1WmAYZmBPlyrqHIBhVMr4J4QvseqSwX3phqP5t6xPjlQgX
 NMQPNzzca6LwgUhLBzWe9mAaOQgV5FVGufIfW
X-Gm-Gg: ASbGnctzabI7Fev0pLTcPiRPDj4f+OyAZasO4y4xLzWKCbrIR9Zjo/DE7A/7DLCTKTD
 C1Lqzt/k/2/QB9F0SJfhgvy4eDzTf1t8lEGcVvVU=
X-Google-Smtp-Source: AGHT+IGFLX6M5g++TbfI0PprDmSrggwB5QNasxf0RXZWSx+6IEc9NLz90jZt5JNDmboK1O7B9OiGwYNt3pnEIUmL70k=
X-Received: by 2002:a17:907:7290:b0:aa6:79fa:b486 with SMTP id
 a640c23a62f3a-aab77ed3a3amr110421966b.49.1734062001738; Thu, 12 Dec 2024
 19:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-5-sjg@chromium.org>
 <CAC_iWjKaywBv3qyk=fHNqH_anC3xT63Ua2=DMG2w1=LEt2vDLg@mail.gmail.com>
 <CAFLszTj8z+CL4FU_6yGjvN82ARYr3ZiWsGd7h9A=p6ObhEKcug@mail.gmail.com>
 <CAC_iWjJtG2qoHEWW8h7hVVU1c6+dPFJ3X7jYSe5H0UzXkSHxcQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJtG2qoHEWW8h7hVVU1c6+dPFJ3X7jYSe5H0UzXkSHxcQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Dec 2024 20:53:09 -0700
Message-ID: <CAFLszTinZrL8VLiMSk-PxWP7oWdY=35kNNUYXXx3EfEz7Z72cQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Thu, 12 Dec 2024 at 08:45, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 15:45, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 12 Dec 2024 at 00:49, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > This uses a few global variables at present. With the bootflow we have
> > > > the required parameters, so add a function which accepts these. Update
> > > > the existing function to call the new one with the globals.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
> > > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > > > index 8febd325f34..8ebd48547cb 100644
> > > > --- a/lib/efi_loader/efi_bootbin.c
> > > > +++ b/lib/efi_loader/efi_bootbin.c
> > > > @@ -209,18 +209,22 @@ out:
> > > >  }
> > > >
> > > >  /**
> > > > - * efi_binary_run() - run loaded UEFI image
> > > > + * efi_binary_run_() - run loaded UEFI image
> > > >   *
> > > >   * @image_ptr: memory address of the UEFI image
> > > >   * @size:      size of the UEFI image
> > > >   * @fdt:       device-tree
> > > > + * @device:    EFI device-path
> > > > + * @image:     EFI image-path
> > > >   *
> > > >   * Execute an EFI binary image loaded at @image.
> > > >   * @size may be zero if the binary is loaded with U-Boot load command.
> > > >   *
> > > >   * Return:     status code
> > > >   */
> > > > -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > > > +efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> > > > +                            struct efi_device_path *device,
> > > > +                            struct efi_device_path *image)
> > > >  {
> > >
> > > This needs to be static here. Not the next patch. But I don't think we
> > > need this at all (look below)
> > >
> > > >         efi_status_t ret;
> > > >
> > > > @@ -236,6 +240,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > > >         if (ret != EFI_SUCCESS)
> > > >                 return ret;
> > > >
> > > > -       return efi_run_image(image_ptr, size, bootefi_device_path,
> > > > -                            bootefi_image_path);
> > > > +       return efi_run_image(image_ptr, size, device, image);
> > > > +}
> > > > +
> > > > +/**
> > > > + * efi_binary_run() - run loaded UEFI image
> > > > + *
> > > > + * @image:     memory address of the UEFI image
> > > > + * @size:      size of the UEFI image
> > > > + * @fdt:       device-tree
> > > > + *
> > > > + * Execute an EFI binary image loaded at @image.
> > > > + * @size may be zero if the binary is loaded with U-Boot load command.
> > > > + *
> > > > + * Return:     status code
> > > > + */
> > > > +efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > > > +{
> > > > +       return efi_binary_run_(image, size, fdt, bootefi_device_path,
> > > > +                              bootefi_image_path);
> > > >  }
> > >
> > > We don't need functions and wrappers for such a simple call. Just
> > > update all the callisites with the extra parameters and keep one
> > > function
> >
> > If you look at the two call sites, you'll see that they would need to
> > pass bootefi_device_path and bootefi_image_path in. but these are
> > static variables in this file.
>
> Ah fair enough, then please rename efi_binary_run_ -> _efi_binary_run
> ands make it static on this patch

I don't mind where the underscore goes. I changed my mind about that
when the dtc maintainer pointed out that C-library functions start
with underscore, so putting an underscore at the start of the function
is confusing things.

"The underscore prefix is reserved for functions and types used by the
compiler and standard library. The standard library can use these
names freely."[1]

But I don't mind. We don't even use the C library except for sandbox
and tools. So let me know what you think.

Regards,
SImon

[1] https://stackoverflow.com/questions/39625352/why-do-some-functions-in-c-have-an-underscore-prefix
