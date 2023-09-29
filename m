Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747BBE71D21
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 12:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DD186ED3;
	Fri, 29 Sep 2023 14:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eQMfrliR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661EF86488; Fri, 29 Sep 2023 14:43:37 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E193486EAC
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 14:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50325ce89e9so22912569e87.0
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695991414; x=1696596214; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o1b4vRFVET1xlZ4CT6PSAXgNBv42FzIVQ6ZcYCZrqsU=;
 b=eQMfrliReCo1X3KC7nQhEliDkfCbrNoRFqESrFTzRYkgbaJlUnIAn74gMykiwIyo4E
 aQFam8DM0TJa/alnFvdA1UPCSCkRfcZcgO/CDqjsmMTr2uV661VZZh+NjFZElHfYuo9E
 c/phmAolxM6EvkY0lJ0lVOR1xkSDtfp6aEBfC3NGxWFufZh5j/sFAg7uy9XZ71dqoJHL
 pB7gqdRjIsnxafmLtd/kCW03UTLMZ3zZ+3a7Ken8GkZJWGgLPzDmQsVgm7RuY7RdKF81
 63BxG808xv7d7R0ecA+oHdxplQlwRmb9T+YHB3f4rZzqrrUXmJsrg8MjnxGvE2d3hv7Z
 OXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695991414; x=1696596214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1b4vRFVET1xlZ4CT6PSAXgNBv42FzIVQ6ZcYCZrqsU=;
 b=mSNTcoV8xccm6DFjivQfZlxOwhr+L+TpCpcZOKyn0l9o/wwL1twjgCvlPBfEcEcBEf
 NpD7Cd4NWbsGsBN8fWe+lq6K/HNuD6mSv1CgL6ZMvuNixq2EslFGXp/uy5ALpgub7l8G
 GJPeOw8qa9ZBmG8Y2Ds5ytFCQd/OH1eTuZJo6h/nLJ+ptEGfKF91ShUEzXMH3nRePXzu
 5K11N+EajeSDJWcrSE0WHvYsoMDPlmz/9PsmjO79WFHpgjnXlp7wELCpDiQtXx8a2Z/J
 ZwFfpJCN7tbAd9t6iwZeu5c+RzDKPs6hjoyW4VFQD/OaIfEkvM1fD/DlRHyB6N9CMQss
 iZ2A==
X-Gm-Message-State: AOJu0YyT1DcttgZnf/m43WGvRyZZyC47u9p62fZwbSP/CnOOS5gr8Co5
 4/40jl4asR9qkgfTVQdXGP7uJudVE74xRLq/4H3T2A==
X-Google-Smtp-Source: AGHT+IHy8Cbbda5DUFyK6boEmMLETUgPBnxlNILiuWtvYPK/RoBeOBL/75Di84BzTwOruiFQ2EAEb7NPTsYqc8oZBEg=
X-Received: by 2002:a05:6512:3d0b:b0:4fe:2f8a:457e with SMTP id
 d11-20020a0565123d0b00b004fe2f8a457emr4130454lfv.43.1695991414151; Fri, 29
 Sep 2023 05:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
 <20230927093631.1595494-5-masahisa.kojima@linaro.org> <ZRa5eiRu+SHvglrp@hades>
 <CADQ0-X_zeBHuXTG-L1QE+U2UZtRjH0YmVJQPKxOZWGZQxpemyQ@mail.gmail.com>
In-Reply-To: <CADQ0-X_zeBHuXTG-L1QE+U2UZtRjH0YmVJQPKxOZWGZQxpemyQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 29 Sep 2023 14:42:58 +0200
Message-ID: <CAC_iWjLu7cK7YK5LW1XgK-eM2zd2-8cNkC5PwVRZUmqnTdd4Xw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] efi_loader: support boot from URI device path
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>
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

On Fri, 29 Sept 2023 at 14:35, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ilias,
>
> On Fri, 29 Sept 2023 at 20:48, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Kojima-san,
> >
> >
> > [...]
> >
> > > +
> > > +/**
> > > + * try_load_default_file() - try to load the default file
> > > + *
> > > + * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> > > + * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > > + *
> > > + * @dev                      pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
> > > + * @image_handle:    pointer to handle for newly installed image
> > > + * Return:           status code
> > > + */
> > > +static efi_status_t try_load_default_file(struct udevice *dev,
> > > +                                       efi_handle_t *image_handle)
> > > +{
> > > +     efi_status_t ret;
> > > +     efi_handle_t handle;
> > > +     struct efi_handler *handler;
> > > +     struct efi_device_path *file_path;
> > > +     struct efi_device_path *device_path;
> > > +
> > > +     if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> > > +             log_warning("DM_TAG_EFI not found\n");
> > > +             return EFI_INVALID_PARAMETER;
> > > +     }
> > > +
> > > +     ret = efi_search_protocol(handle,
> > > +                               &efi_simple_file_system_protocol_guid, &handler);
> > > +     if (ret != EFI_SUCCESS)
> > > +             return ret;
> > > +
> > > +     ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> > > +                                      (void **)&device_path, efi_root, NULL,
> > > +                                      EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> > > +     if (ret != EFI_SUCCESS)
> > > +             return ret;
> > > +
> > > +     file_path = expand_media_path(device_path);
> > > +     ret = EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
> > > +                                   image_handle));
> > > +
> > > +     efi_free_pool(file_path);
> > > +
> > > +     return ret;
> > > +}
> >
> > We've discussed this on v4, but I am replying here, since you sent a v5 in
> > the meantime.
> > What I ideally wanted to do here is
> > - Add the boot option automatically once the disk gets mount (you've
> > already sent a patch for that)
> > - Since the boot option is automatically added we could instead of
> >   searching for BOOTAA64.EFI search for matches with a load option of
> >   '1234567'.
> > Is there some timing issue that I am missing which doesnt allow us to do
> > that ?
>
> Sorry, I probably misunderstood your design.
> What kind of boot option is automatically added when the disk is detected?
> Could you share your thoughts about the trigger to search for matches
> with a load option of '1234567'?

You've recently fixed the CI errors and reported this [0].  Once that
gets merged every time a new disk is added, it will be automatically
be scanned for BOOTXXX.efi files.  If we do find such files, they will
be added to the efi bootmgr list of available options.  We do mark
these with a '1234567' in the optional data.

Once that path gets merged, wouldn't it be simpler to just scan for
boot options with '1234567' in the load options on the mounted image,
instead of rescanning it for BOOTXXX.efi?

[0] https://lore.kernel.org/u-boot/20230927010436.1503621-1-masahisa.kojima@linaro.org/

Thanks
/Ilias
>
> Thanks,
> Masahisa Kojima
>
> >
> > [...]
> >
> > Cheers
> > /Ilias
