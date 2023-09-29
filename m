Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6912E71D28
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 12:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC4F586EAC;
	Fri, 29 Sep 2023 14:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UoZIxlad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEDB286EBF; Fri, 29 Sep 2023 14:35:16 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC61B86E69
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 14:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-65b02e42399so59171056d6.3
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695990913; x=1696595713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lq1wEyGedjOWKSD7rlkiYFfq+38/EiOfD1dfX2HPCe4=;
 b=UoZIxladmUZ+Dpbc8KbtKz1126IDxStbaAju5gAWK1WC9wYNMg6ct0JI7TklPFOaoF
 XyTKsr6ZjE++h/Sx2ngtTzeYEw/7AZoBiT0MWaieGI/p+5+F8j64dJcLrvIQIyqGotFm
 +NJc1CQF8miXBdUw03WLf9G4VTq/kexO57xZtjR5ExDugKeD71wWPj96v/oe4VDygu2M
 my/7pxGMUEzzPvI1mipKZu1r/SFVUnGuoS+u5lAiq1E1uUEWI4lT95YDCVURBciE/3XD
 JQHCrlYeWK+3GLdmhcUN+lwm0FkqJsrKI8wtWuSOzI+0ZEOU+ppLWkP2DS0Kk5YZ8tBs
 nreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695990913; x=1696595713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lq1wEyGedjOWKSD7rlkiYFfq+38/EiOfD1dfX2HPCe4=;
 b=qbdblOoy6h/vjWBLNzfEyT+/+FWL9b3wYD9s6YjE6phSq1O+rBYt/AeuXy4SlIU0d8
 FuWIsbcNAM+nYAF5CV8kZm2b1s8fEB8Cppk37l+LaVznBCLxx2lfWQQpxYKR4dEqTyek
 7f0D761qLWsPRniwcvlpPIwMR1Zdd/VtLUr8oSBS1opksTXc0WdTbs0zW4Xt4q9k6fr4
 vErEJyVofGyCfOdY9uPkyt8/GnAdannh4myRRfyMWTkrhEh6B6Uez+X0LWNhCt9YuO3U
 moskUrygosrH2AtsZah5rFsg6s+qz3I3P8PnVJRuGrohDCNEnzCoERcbGGRjZbymuhnx
 P1CA==
X-Gm-Message-State: AOJu0Yy5EfLgiubAzJs+eTP+fXSR86dvooOT2htBEp+x/dk7BzWBJZDC
 +aAI4JpkN8qx/3sFfp+hyDtWYmEpqTBnsfCzdOYF3Q==
X-Google-Smtp-Source: AGHT+IF6Uhht+p5KL0bhsaYvOSZMY/rcqLraPF7P3Uh2NOB2hZb5FBKKVlMUfk6YPc2PWwnhXUHJSdafgNP2v9S9lqE=
X-Received: by 2002:a05:6214:3f92:b0:65b:17e9:1c9d with SMTP id
 ow18-20020a0562143f9200b0065b17e91c9dmr4107386qvb.52.1695990913555; Fri, 29
 Sep 2023 05:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
 <20230927093631.1595494-5-masahisa.kojima@linaro.org> <ZRa5eiRu+SHvglrp@hades>
In-Reply-To: <ZRa5eiRu+SHvglrp@hades>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 29 Sep 2023 21:35:01 +0900
Message-ID: <CADQ0-X_zeBHuXTG-L1QE+U2UZtRjH0YmVJQPKxOZWGZQxpemyQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] efi_loader: support boot from URI device path
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Fri, 29 Sept 2023 at 20:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san,
>
>
> [...]
>
> > +
> > +/**
> > + * try_load_default_file() - try to load the default file
> > + *
> > + * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> > + * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > + *
> > + * @dev                      pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
> > + * @image_handle:    pointer to handle for newly installed image
> > + * Return:           status code
> > + */
> > +static efi_status_t try_load_default_file(struct udevice *dev,
> > +                                       efi_handle_t *image_handle)
> > +{
> > +     efi_status_t ret;
> > +     efi_handle_t handle;
> > +     struct efi_handler *handler;
> > +     struct efi_device_path *file_path;
> > +     struct efi_device_path *device_path;
> > +
> > +     if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> > +             log_warning("DM_TAG_EFI not found\n");
> > +             return EFI_INVALID_PARAMETER;
> > +     }
> > +
> > +     ret = efi_search_protocol(handle,
> > +                               &efi_simple_file_system_protocol_guid, &handler);
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +
> > +     ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> > +                                      (void **)&device_path, efi_root, NULL,
> > +                                      EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +
> > +     file_path = expand_media_path(device_path);
> > +     ret = EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
> > +                                   image_handle));
> > +
> > +     efi_free_pool(file_path);
> > +
> > +     return ret;
> > +}
>
> We've discussed this on v4, but I am replying here, since you sent a v5 in
> the meantime.
> What I ideally wanted to do here is
> - Add the boot option automatically once the disk gets mount (you've
> already sent a patch for that)
> - Since the boot option is automatically added we could instead of
>   searching for BOOTAA64.EFI search for matches with a load option of
>   '1234567'.
> Is there some timing issue that I am missing which doesnt allow us to do
> that ?

Sorry, I probably misunderstood your design.
What kind of boot option is automatically added when the disk is detected?
Could you share your thoughts about the trigger to search for matches
with a load option of '1234567'?

Thanks,
Masahisa Kojima

>
> [...]
>
> Cheers
> /Ilias
