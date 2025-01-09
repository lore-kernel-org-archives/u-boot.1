Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D02E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66402805E2;
	Thu,  9 Jan 2025 16:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LdjOzFwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BE7805E2; Thu,  9 Jan 2025 16:02:04 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB05A80655
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so1418910a91.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434919; x=1737039719; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=spAvyRb+W4SZjRpQW1ohHlko90ZWmJYeXFDmI44yaJA=;
 b=LdjOzFwpvdccMc0xVwwV/YwxJDrTPtTm+9VK+PwoQ+rGM+Wiqe99Lis4mxY9ERh54k
 U/jmlsfm/Nm9HCDnDiiSlBmOLmwSi+FeYuNQuYeo5YyiRQCcTyd44mr3nUdk0bjALdos
 61kRmQpVK5uAK6J71JnHmhsYntf4ujD2xm5AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434919; x=1737039719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=spAvyRb+W4SZjRpQW1ohHlko90ZWmJYeXFDmI44yaJA=;
 b=GcJ9npjosjEFdjtE0zsqPKbOUkHwcivNlcpV+NW+FXjFAkktyWRYx6bHO8pS8SJWJ6
 lixurU3bzVJfswiMkfca7WCw1hf4/Qc1/vkccsLgIzAbYCtI2GEvO25AmoEcI3Rj1oOQ
 5meXBdDZRBFtrxfo9AenPtcBM/afdOKXjvdLeyccbRejcMw/z53SLSrhgc4vLX9sDBeJ
 VjeA4Sete8tOjhtX9FJdX6T+z2iW+nyMPJh+8lOsMqoreQTar+Z7Jbv3jU8ex8H0kfej
 0/UOOr5HckWAvMGbJK0oYEMWQgWkO4ihXi5HJAuPoO2uCH/OC5vyvMzjRIUdPz1IspdR
 mzUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLbqPS2RQJRzXANEC5CJLu8DqK+IfkdVf0Djelc3WRPup7N1Zi+ijzn8iFQaP7Q7PCBmBZfds=@lists.denx.de
X-Gm-Message-State: AOJu0YxNHDUstMo7VXwDJ6xwZBu+zUfgk9jt+CP6hreP6SUuAwxSadCn
 ve3CT+6Sp5SH5C9N66Zjy6EA2MzEcx/wGWMk8XBM8OQ1HhNHRM7MCpqp0nbAM5gW29lxoQ4q9A8
 7dXSTwIyydtBP4Xqxzpns5UcyZa/9F1Ila0Hi
X-Gm-Gg: ASbGncs8BMusbhMRwhsvWN01tzj6O4yD3hrrlqQb29VlTDnRa7F9+sRgTchHeIyKveE
 jNlooYP8sHcGI5K7z+ntCS2Z6+h9iFMa7JI142uQ=
X-Google-Smtp-Source: AGHT+IExWD/akcWlzRzKJOKYtPEV762niCa/xMinzIB9ZGUqc2JEQ3iFqXNa32OwK+evl5Dm+NBzTZNWq+3QSgXh9eY=
X-Received: by 2002:a17:90b:4d0c:b0:2ee:8619:210b with SMTP id
 98e67ed59e1d1-2f5490bd21dmr10495364a91.29.1736434918973; Thu, 09 Jan 2025
 07:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-2-sjg@chromium.org>
 <d8931ed1-92d6-4843-9e9d-7aa1751bb116@gmx.de>
In-Reply-To: <d8931ed1-92d6-4843-9e9d-7aa1751bb116@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 08:01:27 -0700
X-Gm-Features: AbW1kvYmxkYlJwIzgFNfW4365-_baFlU0S4P_IHT4Suca1y7tPSriuHvFYuu9a4
Message-ID: <CAFLszTiFyr1zcnocFpy32YSORtkfmZbZj3A3-tfyP5LgbrQ3JA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] efi_loader: Refactor device and image paths into a
 function
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Moritz Fischer <moritzf@google.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 22 Dec 2024 at 05:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/19/24 03:38, Simon Glass wrote:
> > Move this code into a function so it can be called from elsewhere.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Make calculate_paths() static and add a comment
> >
> >   lib/efi_loader/efi_bootbin.c | 85 ++++++++++++++++++++++++------------
> >   1 file changed, 57 insertions(+), 28 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index b677bbc3124..5016ba7e225 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -44,12 +44,64 @@ void efi_clear_bootdev(void)
> >       image_size = 0;
> >   }
> >
> > +/**
> > + * calculate_paths() - Calculate the device and image patch given a device
>
> %s/patch/path/
>
> The description makes no sense. You cannot derive an image device path
> from a device.

I'll change it to 'strings'

>
> > + *
> > + * @dev:             device, e.g. "MMC"
> > + * @devnr:           number of the device, e.g. "1:2"
> > + * @path:            path to file loaded
> > + * @device_pathp:    returns EFI device path
> > + * @image_pathp:     returns EFI image path
> > + * Return EFI_SUCCESS on success, else error code
>
> This would not work with Sphinx
>
> %s/Return/Return:/
>
> > + */
> > +static efi_status_t calculate_paths(const char *dev, const char *devnr,
> > +                                 const char *path,
> > +                                 struct efi_device_path **device_pathp,
> > +                                 struct efi_device_path **image_pathp)
> > +{
> > +     struct efi_device_path *image, *device;
> > +     efi_status_t ret;
> > +
> > +#if IS_ENABLED(CONFIG_NETDEVICES)
>
> Please, avoid #if. The include needs to be fixed.
>
> > +     if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
> > +             ret = efi_net_set_dp(dev, devnr);
> > +             if (ret != EFI_SUCCESS)
> > +                     return ret;
> > +     }
>
> This does not fit to the function description. It has nothing to do with
> calculating device-paths.

That code was added just recently, reviewed by you, so I will let you
clean it up. It is perpetuating the globals that this series is (was)
resolving.

Anyway, the naming is correct, once that is fixed.

>
> > +#endif
> > +
> > +     ret = efi_dp_from_name(dev, devnr, path, &device, &image);
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +
> > +     *device_pathp = device;
> > +     if (image) {
> > +             /* FIXME: image should not contain device */
>
> We could change efi_dp_from_name() but then we would have to concatenate
> paths in create_lo_dp_part().
>
> This does not deserve a FIXME label.

This is copied from the existing code. Please check the patch before
requesting unrelated changes.

>
> Best regards
>
> Heinrich
>
> > +             struct efi_device_path *image_tmp = image;
> > +
> > +             efi_dp_split_file_path(image, &device, &image);
> > +             efi_free_pool(image_tmp);
> > +     }
> > +     *image_pathp = image;
> > +     log_debug("- boot device %pD\n", device);
> > +     if (image)
> > +             log_debug("- image %pD\n", image);
> > +
> > +     return EFI_SUCCESS;
> > +}
> > +
> >   /**
> >    * efi_set_bootdev() - set boot device
> >    *
> >    * This function is called when a file is loaded, e.g. via the 'load' command.
> >    * We use the path to this file to inform the UEFI binary about the boot device.
> >    *
> > + * For a valid image, it sets:
> > + *    - image_addr to the provided buffer
> > + *    - image_size to the provided buffer_size
> > + *    - bootefi_device_path to the EFI device-path
> > + *    - bootefi_image_path to the EFI image-path
> > + *
> >    * @dev:            device, e.g. "MMC"
> >    * @devnr:          number of the device, e.g. "1:2"
> >    * @path:           path to file loaded
> > @@ -59,7 +111,6 @@ void efi_clear_bootdev(void)
> >   void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
> >                    void *buffer, size_t buffer_size)
> >   {
> > -     struct efi_device_path *device, *image;
> >       efi_status_t ret;
> >
> >       log_debug("dev=%s, devnr=%s, path=%s, buffer=%p, size=%zx\n", dev,
> > @@ -93,34 +144,12 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
> >       image_addr = buffer;
> >       image_size = buffer_size;
> >
> > -#if IS_ENABLED(CONFIG_NETDEVICES)
> > -     if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
> > -             ret = efi_net_set_dp(dev, devnr);
> > -             if (ret != EFI_SUCCESS)
> > -                     goto error;
> > -     }
> > -#endif
> > -
> > -     ret = efi_dp_from_name(dev, devnr, path, &device, &image);
> > -     if (ret != EFI_SUCCESS)
> > -             goto error;
> > -
> > -     bootefi_device_path = device;
> > -     if (image) {
> > -             /* FIXME: image should not contain device */
> > -             struct efi_device_path *image_tmp = image;
> > -
> > -             efi_dp_split_file_path(image, &device, &image);
> > -             efi_free_pool(image_tmp);
> > +     ret = calculate_paths(dev, devnr, path, &bootefi_device_path,
> > +                           &bootefi_image_path);
> > +     if (ret) {
> > +             log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
> > +             efi_clear_bootdev();
> >       }
> > -     bootefi_image_path = image;
> > -     log_debug("- boot device %pD\n", device);
> > -     if (image)
> > -             log_debug("- image %pD\n", image);
> > -     return;
> > -error:
> > -     log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
> > -     efi_clear_bootdev();
> >   }
> >
> >   /**
>

Regards,
Simon
