Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D661E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19CC18060C;
	Thu,  9 Jan 2025 16:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eRURwlDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568A480601; Thu,  9 Jan 2025 16:01:58 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6F88069D
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso17264925ad.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434912; x=1737039712; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yjea4Jkb0uSrAGL4t8sAK88Lw+BPvfLiH0OAq3Xi7Eg=;
 b=eRURwlDVZ1mMYqwUAjzvGGAqBfhuxkPFGr6NhGypNo6v77OHGY3dobQ7hGsP478mis
 3Of5CWHzJZzNYJY0O2UkYOZkKkhyZcT1JpqFfKe3hDwm8UYujLWHZa0LZ13K3VPETTFw
 hYc5Pti2UI8Vuj/JrV7Za5OLbfg9dk2XxVYjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434912; x=1737039712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yjea4Jkb0uSrAGL4t8sAK88Lw+BPvfLiH0OAq3Xi7Eg=;
 b=FzU3ozFHeyu/yiXxbZIoLeuq7jkllchcYuVV0tZ9aVFulELIyMeOr36lGiLEEtUpv9
 I4I5GxP14oh13kkRoCQ8nywaTRuXQo+c2Vl2hKEF0mzWu1tGIGQvelc8C8lxBu4W9nP0
 ExNdU6ttOk0Abj/s7lb30x0cVZnueWwtu5qRg5ogyHx612Y3R9kdKL3WC/m2/bAnkC25
 rwOeXb0vH/TZcoV2BG3gSYVuNY8zsqT/IwBByid58t+IeXFPhAH6qa+FDXk3iJFLsAvK
 iXa+/duwl7gXkSVDn6xqA4xryOYkVrCuB+DWgrVzSphbVcS6q0QXVM/iyy96Sfk5DNTE
 VnhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi2QClGcvqrRcxBr78vm4DzeaB7onw/PKM5nf0RkgGDsvTLOtW25yqfVeks6GWT38+pExE2ZI=@lists.denx.de
X-Gm-Message-State: AOJu0YyYYw3mpb8WQsDvs2vVBt7dmMtckcco9rSUkO9edCClpCMFbUbC
 ngnHIo0KXc8Tizcwzhz7u5rt3pFOKb1hsIcX7bwLg7BuE+rporvgyBD35Yd1BwOOwjsR7QltaWP
 uiTWaby9/+gSg4og5a0rKKvF7ljaE3Jr3iEms
X-Gm-Gg: ASbGncte3fCqemOqYQhiybCfEOdF/1SuN/e7h1A+zAbZ8/5JKW8HKrKzvTeHrkpShO9
 ZMXEt7b3B3jr+sKa8x2ochDVqcHafWAfziN/Kkfk=
X-Google-Smtp-Source: AGHT+IGdouPfDwRHdtHd0HyHJ0gYcz9PPeR3p/rYDlVa9jkFntiy1CRKJ+//mfcQhqFATw0KW2CC8UtnGonTp8V1Tn4=
X-Received: by 2002:a17:90b:3a05:b0:2ef:2d9f:8e55 with SMTP id
 98e67ed59e1d1-2f548edaa0emr11502157a91.17.1736434912147; Thu, 09 Jan 2025
 07:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-5-sjg@chromium.org>
 <4a0a3ab8-d828-426f-93b8-364e0eeb9f74@gmx.de>
 <CAC_iWjKyBV3xYDNcXQkZ8QOiWPJxn53kgqoPoT1ZXDSD_SDevw@mail.gmail.com>
In-Reply-To: <CAC_iWjKyBV3xYDNcXQkZ8QOiWPJxn53kgqoPoT1ZXDSD_SDevw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 08:01:34 -0700
X-Gm-Features: AbW1kvaUwDgDB4Scpe27z_5Y4Wacg0_hsCWhiBychQakUp3v_bwlaYpfP3iVPts
Message-ID: <CAFLszTi02WTz1TRZBtH1JKQo-zfdX345f_HiA9V4ia8j==8fAg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, 
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

Hi guys,

On Sun, 22 Dec 2024 at 06:17, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich
>
> On Sun, 22 Dec 2024 at 14:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 12/19/24 03:38, Simon Glass wrote:
> > > This uses a few global variables at present. With the bootflow we have
> > > the required parameters, so add a function which accepts these. Update
> > > the existing function to call the new one with the globals.
> > >
> > > - Rename efi_binary_run_() to _efi_binary_run()
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >   lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
> > >   1 file changed, 25 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > > index b42ff3cb4e0..f7aedeaab8a 100644
> > > --- a/lib/efi_loader/efi_bootbin.c
> > > +++ b/lib/efi_loader/efi_bootbin.c
> > > @@ -228,18 +228,22 @@ out:
> > >   }
> > >
> > >   /**
> > > - * efi_binary_run() - run loaded UEFI image
> > > + * efi_binary_run_() - run loaded UEFI image
> > >    *
> > >    * @image_ptr:      memory address of the UEFI image
> > >    * @size:   size of the UEFI image
> > >    * @fdt:    device-tree
> > > + * @device:  EFI device-path
> > > + * @image:   EFI image-path
> > >    *
> > >    * Execute an EFI binary image loaded at @image.
> > >    * @size may be zero if the binary is loaded with U-Boot load command.
> > >    *
> > >    * Return:  status code
> > >    */
> > > -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > > +efi_status_t _efi_binary_run(void *image_ptr, size_t size, void *fdt,
> > > +                          struct efi_device_path *device,
> > > +                          struct efi_device_path *image)
> >
> > A non-static function starting with underscore? Please, avoid this.
>
> I was the one who requested this, the v1 had it as efi_binary_run_,
> but i a dont mind any of those

Well I'm not changing it again :-) Heinrich you are free to send a patch later.

Regards,
Simon
