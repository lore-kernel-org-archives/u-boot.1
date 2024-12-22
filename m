Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D80CE77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 13:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948698056A;
	Sun, 22 Dec 2024 14:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rdT+UulA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F898056B; Sun, 22 Dec 2024 14:17:43 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E49AB80562
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 14:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5390ed85a1so1670729276.1
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 05:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734873460; x=1735478260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lYALNYBgq5ZZCDCFapyC6FHhnyMowfOVTFQe6tqb8HQ=;
 b=rdT+UulAQzTqNmq2VE9QqtIP57AXj7lkdl1TxarQT40RPkYoUEg2a4ihxPJeWckqhW
 plNbyYhJa6URhb9Mlr4ipBuEdb3YtSha5qRQhjKPv3a7pKrm7Xdq1Xv0G9b0ydEsC/Mo
 cyfWEtO/m1AqfwQ4d0Ev1y6kg3b0CV0eH0DREqK/Blc5zdyFD1c1Znzc7HaM3EkSHe9V
 +IGjQib8XWbc9QubYoLXMMR1u/+6XgxYs8YL22EinXwq6b4JzyS7Qj8k3gkan2mSMZNu
 S5pwfHSWpW2jJOUBOm2J21rMCVau7npaHo5zu1HppMEED4NRNXRcUZQMsNZfl/F/WasD
 ODvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734873460; x=1735478260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYALNYBgq5ZZCDCFapyC6FHhnyMowfOVTFQe6tqb8HQ=;
 b=OJHwlZq2naIfHrgGmzh+qGOijqNUCSE7FrK8f+sYwYhYfxinUdubHjBSm96lihqtnY
 EoIjnt/MCBI8TXGlMUCvyPbujPklJpHtV28Pvf4Wc1zIowLwsqGP5Du+Rb4kbbdU5Wg5
 SyCEd/eaIwJLe2bHLzaQ5OijFXv6Erj63JOdCbndF1C8xEvzO+hY2GBA5S0sF+ZhwkXR
 2SdHRvyDPLBqgb37ktTe3nmhElwT7KQH43huhyiZnLwfx8IxeoMDvAEoxcAnc+5/eLD/
 DgUJsWF9iWpK9g9DJ8EOKp/I7RAO3xckqLSA86+YQX8TyzvhERurb6MUUeMu6NSkrq9S
 Jimw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNuF1u8jkkoesm7LJQ/JUNVUVKW9Nrq5pKHe2hAXAjUQU/5VNs3iQuWWxocDmv9U8hOvyevxs=@lists.denx.de
X-Gm-Message-State: AOJu0YxB9LbX5ytgPu7nz3RTApYIjwGFXuDXLJica0wgK5kjU7Ig9s7b
 orXTh04PvDQGxOFnA2EQv2uLCVlUFpDhjAKGwIb8mR1wUhseRn8F3ToXFXBq/dnir3AUmigZd9x
 qMmZag2TvNbmQIQfkTB/fwH01kZyyuPy2OfSitw==
X-Gm-Gg: ASbGncu3OBuzdUOsYCquqhlUdCWm2VBQGZfV8/sPXd/xSzpyz0X7Vu2OBhY+gtqFUeI
 xy5ZQUGhwnoq1jeucYSZV4E75cjhfSCy2Kzj8NA==
X-Google-Smtp-Source: AGHT+IF4Xe9SLTu0EZTyEgPXsm8QuiB3FIHtErG9RRbON+KXmFJERbOeqm7rBYGLLe0BRcLpTY42JaHjBkK3M+9oDjE=
X-Received: by 2002:a25:60c2:0:b0:e3c:7bf7:f4df with SMTP id
 3f1490d57ef6-e538c208256mr3581662276.7.1734873459722; Sun, 22 Dec 2024
 05:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-5-sjg@chromium.org>
 <4a0a3ab8-d828-426f-93b8-364e0eeb9f74@gmx.de>
In-Reply-To: <4a0a3ab8-d828-426f-93b8-364e0eeb9f74@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 22 Dec 2024 15:17:03 +0200
Message-ID: <CAC_iWjKyBV3xYDNcXQkZ8QOiWPJxn53kgqoPoT1ZXDSD_SDevw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Moritz Fischer <moritzf@google.com>
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

Hi Heinrich

On Sun, 22 Dec 2024 at 14:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/19/24 03:38, Simon Glass wrote:
> > This uses a few global variables at present. With the bootflow we have
> > the required parameters, so add a function which accepts these. Update
> > the existing function to call the new one with the globals.
> >
> > - Rename efi_binary_run_() to _efi_binary_run()
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
> >   1 file changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index b42ff3cb4e0..f7aedeaab8a 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -228,18 +228,22 @@ out:
> >   }
> >
> >   /**
> > - * efi_binary_run() - run loaded UEFI image
> > + * efi_binary_run_() - run loaded UEFI image
> >    *
> >    * @image_ptr:      memory address of the UEFI image
> >    * @size:   size of the UEFI image
> >    * @fdt:    device-tree
> > + * @device:  EFI device-path
> > + * @image:   EFI image-path
> >    *
> >    * Execute an EFI binary image loaded at @image.
> >    * @size may be zero if the binary is loaded with U-Boot load command.
> >    *
> >    * Return:  status code
> >    */
> > -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > +efi_status_t _efi_binary_run(void *image_ptr, size_t size, void *fdt,
> > +                          struct efi_device_path *device,
> > +                          struct efi_device_path *image)
>
> A non-static function starting with underscore? Please, avoid this.

I was the one who requested this, the v1 had it as efi_binary_run_,
but i a dont mind any of those

Cheers
/Ilias
>
> Best regards
>
> Heinrich
>
> >   {
> >       efi_status_t ret;
> >
> > @@ -255,6 +259,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> >       if (ret != EFI_SUCCESS)
> >               return ret;
> >
> > -     return efi_run_image(image_ptr, size, bootefi_device_path,
> > -                          bootefi_image_path);
> > +     return efi_run_image(image_ptr, size, device, image);
> > +}
> > +
> > +/**
> > + * efi_binary_run() - run loaded UEFI image
> > + *
> > + * @image:   memory address of the UEFI image
> > + * @size:    size of the UEFI image
> > + * @fdt:     device-tree
> > + *
> > + * Execute an EFI binary image loaded at @image.
> > + * @size may be zero if the binary is loaded with U-Boot load command.
> > + *
> > + * Return:   status code
> > + */
> > +efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > +{
> > +     return _efi_binary_run(image, size, fdt, bootefi_device_path,
> > +                            bootefi_image_path);
> >   }
>
