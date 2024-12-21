Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386F8E77184
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 08:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB6980423;
	Sat, 21 Dec 2024 09:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mvgTTcUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5804680433; Sat, 21 Dec 2024 09:34:18 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E29803E0
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 09:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e46c6547266so2026817276.3
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 00:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734770055; x=1735374855; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pc7m7LEmaNUc929tVTF5Ti90heERBwIq9Ia2ILlXrFU=;
 b=mvgTTcUiWmoVYYfcxw+TOwZTtujw48G5netxj/jeM8U15B2dPAsp1rLJW14SMeFqs/
 NcqCNQTJraGHefzh78G/Y5HwsLz+lB7I1kCMGKy9/JS7fmp6L34R188W2ySkhmK+lg7b
 OQM8hFYqtiQIoz9vhmNYAJFtWXUFJty9krY0wCHs3jn5FHkRTc24BVEsPhCGOpEbt3ls
 pS97jd8Oc1eIbnwtJFPUwJYOwP3KmREd3IdweK2Vz5+rrp5WmYv6pDJAke+0l1K4Rd+x
 YupdqAwBjBxsFRmURBsGKPrs630PbPl6lKlSZBChU/VYzcLuDQAWqLXcw1kN/XtZI+gM
 VUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734770055; x=1735374855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pc7m7LEmaNUc929tVTF5Ti90heERBwIq9Ia2ILlXrFU=;
 b=bBpjR0XkF3FIpZjvDbzGrCPvFBn0BHuMmYNyq3IHc1vcVM10CH/6QjQCrTh1fArTEC
 3FSQl5rmnTy8Reh2gXPy8r0WQzDIcHkB5PlBs04FJIPY/aF1O5hJ+DOZEgC48INJcL8O
 ckcHN5vmEaxoGov6W7aZWCclyjsn+OPBKEgHBSbhJe64UdldUlcEBUqLbiWqZFn1nxtj
 PlSD7sMevbKw8REtQO1IAREmFWcTviiQg+7IBiGrvBhmBEF0zAsPOwX2uGBPMyfWt7mm
 LzFrTRF243vQKxrl61mg2dP2N2uswr5JSglW1gyAdJeLnvM5ahb87rTjeAO35MyhgaKW
 BzqQ==
X-Gm-Message-State: AOJu0YzcLs9hJt3Lnmz+2zbh9EOd+vRHZ88FhztrdOBWKSaNp5M/rdOx
 7aedZDIuZyyzK7c5wnqWDuxvl8OJyteQoyXPDvz7tXO/1p3Berxab29KZ0+hHCHAMHP1YBm7bHF
 fTAbKsE/6DV8d6473ynSeL75Qhflf4FMUpBWZbg==
X-Gm-Gg: ASbGncuLz3gSx+/Duz+HkO36pRxCJoBo89WStaT3AQ5twFZrz0fAkSyjdA/j5AnZMaM
 SVbWvkLfzlIW8nKCtEvTvNuLFmVZ+XvLjGvWmFA==
X-Google-Smtp-Source: AGHT+IHD6f4CvL5Neerr9H9YV18CGKBjUlL135sPqDK3Uo6B42QUsqqurXB9C224MY5n09XggjcYaHWYyX1cJUiJwtk=
X-Received: by 2002:a05:6902:703:b0:e4c:ae89:1603 with SMTP id
 3f1490d57ef6-e538c3a31f7mr4828803276.41.1734770054821; Sat, 21 Dec 2024
 00:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-2-sjg@chromium.org>
 <CAC_iWjJebots6=UpyrcJbRj9OM2duLhv7Akn6W1mJxCqEqDSCA@mail.gmail.com>
In-Reply-To: <CAC_iWjJebots6=UpyrcJbRj9OM2duLhv7Akn6W1mJxCqEqDSCA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 21 Dec 2024 10:33:38 +0200
Message-ID: <CAC_iWjK17x_X5ZMaGusjAFtt34=q6BL6gPS4iDyzwVZCo=0o4Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] efi_loader: Refactor device and image paths into a
 function
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>
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

On Sat, 21 Dec 2024 at 10:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
> I don't see any of the requested changes from v2 on this one.

Ah you changed it to static instead. That's fine we can move it to the
dp helpers. if someone else needs it.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Cheers
> /Ilias
>
> On Thu, 19 Dec 2024 at 04:39, Simon Glass <sjg@chromium.org> wrote:
> >
> > Move this code into a function so it can be called from elsewhere.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Make calculate_paths() static and add a comment
> >
> >  lib/efi_loader/efi_bootbin.c | 85 ++++++++++++++++++++++++------------
> >  1 file changed, 57 insertions(+), 28 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index b677bbc3124..5016ba7e225 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -44,12 +44,64 @@ void efi_clear_bootdev(void)
> >         image_size = 0;
> >  }
> >
> > +/**
> > + * calculate_paths() - Calculate the device and image patch given a device
> > + *
> > + * @dev:               device, e.g. "MMC"
> > + * @devnr:             number of the device, e.g. "1:2"
> > + * @path:              path to file loaded
> > + * @device_pathp:      returns EFI device path
> > + * @image_pathp:       returns EFI image path
> > + * Return EFI_SUCCESS on success, else error code
> > + */
> > +static efi_status_t calculate_paths(const char *dev, const char *devnr,
> > +                                   const char *path,
> > +                                   struct efi_device_path **device_pathp,
> > +                                   struct efi_device_path **image_pathp)
> > +{
> > +       struct efi_device_path *image, *device;
> > +       efi_status_t ret;
> > +
> > +#if IS_ENABLED(CONFIG_NETDEVICES)
> > +       if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
> > +               ret = efi_net_set_dp(dev, devnr);
> > +               if (ret != EFI_SUCCESS)
> > +                       return ret;
> > +       }
> > +#endif
> > +
> > +       ret = efi_dp_from_name(dev, devnr, path, &device, &image);
> > +       if (ret != EFI_SUCCESS)
> > +               return ret;
> > +
> > +       *device_pathp = device;
> > +       if (image) {
> > +               /* FIXME: image should not contain device */
> > +               struct efi_device_path *image_tmp = image;
> > +
> > +               efi_dp_split_file_path(image, &device, &image);
> > +               efi_free_pool(image_tmp);
> > +       }
> > +       *image_pathp = image;
> > +       log_debug("- boot device %pD\n", device);
> > +       if (image)
> > +               log_debug("- image %pD\n", image);
> > +
> > +       return EFI_SUCCESS;
> > +}
> > +
> >  /**
> >   * efi_set_bootdev() - set boot device
> >   *
> >   * This function is called when a file is loaded, e.g. via the 'load' command.
> >   * We use the path to this file to inform the UEFI binary about the boot device.
> >   *
> > + * For a valid image, it sets:
> > + *    - image_addr to the provided buffer
> > + *    - image_size to the provided buffer_size
> > + *    - bootefi_device_path to the EFI device-path
> > + *    - bootefi_image_path to the EFI image-path
> > + *
> >   * @dev:               device, e.g. "MMC"
> >   * @devnr:             number of the device, e.g. "1:2"
> >   * @path:              path to file loaded
> > @@ -59,7 +111,6 @@ void efi_clear_bootdev(void)
> >  void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
> >                      void *buffer, size_t buffer_size)
> >  {
> > -       struct efi_device_path *device, *image;
> >         efi_status_t ret;
> >
> >         log_debug("dev=%s, devnr=%s, path=%s, buffer=%p, size=%zx\n", dev,
> > @@ -93,34 +144,12 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
> >         image_addr = buffer;
> >         image_size = buffer_size;
> >
> > -#if IS_ENABLED(CONFIG_NETDEVICES)
> > -       if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
> > -               ret = efi_net_set_dp(dev, devnr);
> > -               if (ret != EFI_SUCCESS)
> > -                       goto error;
> > -       }
> > -#endif
> > -
> > -       ret = efi_dp_from_name(dev, devnr, path, &device, &image);
> > -       if (ret != EFI_SUCCESS)
> > -               goto error;
> > -
> > -       bootefi_device_path = device;
> > -       if (image) {
> > -               /* FIXME: image should not contain device */
> > -               struct efi_device_path *image_tmp = image;
> > -
> > -               efi_dp_split_file_path(image, &device, &image);
> > -               efi_free_pool(image_tmp);
> > +       ret = calculate_paths(dev, devnr, path, &bootefi_device_path,
> > +                             &bootefi_image_path);
> > +       if (ret) {
> > +               log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
> > +               efi_clear_bootdev();
> >         }
> > -       bootefi_image_path = image;
> > -       log_debug("- boot device %pD\n", device);
> > -       if (image)
> > -               log_debug("- image %pD\n", image);
> > -       return;
> > -error:
> > -       log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
> > -       efi_clear_bootdev();
> >  }
> >
> >  /**
> > --
> > 2.34.1
> >
