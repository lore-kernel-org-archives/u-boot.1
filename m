Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC4EE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC439801D7;
	Thu, 12 Dec 2024 14:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oSAjiyfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E9E80209; Thu, 12 Dec 2024 14:45:18 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C94980282
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so109973366b.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 05:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734011115; x=1734615915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sJ9PWIzupa7SuTssHnrmXiKLotWKAg/16XyFBSqf1LQ=;
 b=oSAjiyfHEFJl7tozgewQYq/6Ph2/xlZoYp2X11jvcMv7AypeKTe/xTGnt/BOos00/p
 QhZLOqzfECeb/0RPF6tUQ3wUBzPW1HfarCxoWQd8WPKFcvoMOPclPtnOOAzqn6/CDEmZ
 DfadpzwMDiV4jlWQCejmSivB5vtmZPpdRI9Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734011115; x=1734615915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sJ9PWIzupa7SuTssHnrmXiKLotWKAg/16XyFBSqf1LQ=;
 b=GHt/92ZDqJjhkBFSmxxQnRFi5sYWAL4iKL3tDnkJFWwUA58Cnm+tNqIptR0BNj1P3C
 NcSThIFmL+eyDKBJSIFbrAhILFGcMf1GN6WH0VUYab0DV84uJh3C/3D8Zl458ctPdlIN
 31UP2l0i1jx50bhTLB87Qnj17KN10fioQyyr1HxsreADuT2m7Q353+/SAXeHomHlVGi2
 WRdTsLYaWdFsD7CDU3KHchgBzWJhPbfGPW2WBmgU9JiRGh/vS75KdBmo8qv/Wva5VNCV
 GeCALyQxGuevdoT8kfjiOxSWRJWK3OSykkoH+ye2UsNmlwbl/8TU9b+HE/AHwb2+DdzK
 3+Cg==
X-Gm-Message-State: AOJu0YympuRhOouLk9OsTnh+iK5GXxmtha048rRxuL3DAOnFY83VbVoN
 qARNna7J3r7W9bRQ/JgDHGbca7Nax4Fa5a46ZjpkUmboqDKqCEGo+nHY4002WieEmZvsB2n+xG4
 +6LjX8i6E6WtuWnPyFWKvKWcYD0CAjdAyW/an
X-Gm-Gg: ASbGnctc5xOoKZBQ3Kq6skFhdyiAVEFmgGntv1eGAkXMX/bzPfEFR49d0adJDA9gYvq
 cvhSqmF6QuvbS9f0Qtm98mQxS+/8Lifz//K4CrKQ=
X-Google-Smtp-Source: AGHT+IHpidXlEdH7XpLENWHusFCQe+o6g9K2zCL3J8lZ7YgppgQGkh8IDN6s9RO79HVhwgRR9PMPM3uDjY6oaqaRwzQ=
X-Received: by 2002:a17:907:781a:b0:aa6:71dc:3123 with SMTP id
 a640c23a62f3a-aa916935ed5mr214879166b.8.1734011114763; Thu, 12 Dec 2024
 05:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-5-sjg@chromium.org>
 <CAC_iWjKaywBv3qyk=fHNqH_anC3xT63Ua2=DMG2w1=LEt2vDLg@mail.gmail.com>
In-Reply-To: <CAC_iWjKaywBv3qyk=fHNqH_anC3xT63Ua2=DMG2w1=LEt2vDLg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Dec 2024 06:45:02 -0700
Message-ID: <CAFLszTj8z+CL4FU_6yGjvN82ARYr3ZiWsGd7h9A=p6ObhEKcug@mail.gmail.com>
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

On Thu, 12 Dec 2024 at 00:49, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> >
> > This uses a few global variables at present. With the bootflow we have
> > the required parameters, so add a function which accepts these. Update
> > the existing function to call the new one with the globals.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index 8febd325f34..8ebd48547cb 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -209,18 +209,22 @@ out:
> >  }
> >
> >  /**
> > - * efi_binary_run() - run loaded UEFI image
> > + * efi_binary_run_() - run loaded UEFI image
> >   *
> >   * @image_ptr: memory address of the UEFI image
> >   * @size:      size of the UEFI image
> >   * @fdt:       device-tree
> > + * @device:    EFI device-path
> > + * @image:     EFI image-path
> >   *
> >   * Execute an EFI binary image loaded at @image.
> >   * @size may be zero if the binary is loaded with U-Boot load command.
> >   *
> >   * Return:     status code
> >   */
> > -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > +efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> > +                            struct efi_device_path *device,
> > +                            struct efi_device_path *image)
> >  {
>
> This needs to be static here. Not the next patch. But I don't think we
> need this at all (look below)
>
> >         efi_status_t ret;
> >
> > @@ -236,6 +240,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> >         if (ret != EFI_SUCCESS)
> >                 return ret;
> >
> > -       return efi_run_image(image_ptr, size, bootefi_device_path,
> > -                            bootefi_image_path);
> > +       return efi_run_image(image_ptr, size, device, image);
> > +}
> > +
> > +/**
> > + * efi_binary_run() - run loaded UEFI image
> > + *
> > + * @image:     memory address of the UEFI image
> > + * @size:      size of the UEFI image
> > + * @fdt:       device-tree
> > + *
> > + * Execute an EFI binary image loaded at @image.
> > + * @size may be zero if the binary is loaded with U-Boot load command.
> > + *
> > + * Return:     status code
> > + */
> > +efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > +{
> > +       return efi_binary_run_(image, size, fdt, bootefi_device_path,
> > +                              bootefi_image_path);
> >  }
>
> We don't need functions and wrappers for such a simple call. Just
> update all the callisites with the extra parameters and keep one
> function

If you look at the two call sites, you'll see that they would need to
pass bootefi_device_path and bootefi_image_path in. but these are
static variables in this file.

>
> Thanks
> /Ilias
> > --
> > 2.34.1
> >

Regards,
Simon
