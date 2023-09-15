Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D268EEB596
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 06:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D88686679;
	Fri, 15 Sep 2023 08:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cNemtEi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E24C986852; Fri, 15 Sep 2023 08:32:02 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE32486660
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 08:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so20393785e9.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694759520; x=1695364320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OpnCHQI5l8nwz/U4PCX8Xtr6kngkaaN1OxDlC1qu470=;
 b=cNemtEi5J29YnjLNcPSCYnOEqUz27PyJDUAdwA36J8LOBMvweI0PMv26+MLZVI0d9w
 SGSq9A3YcsnpaoeToLSLhrqlRyV6cbChFBUAuQKquFPOC2gmqOAFL71MoHwF6I81Z+mC
 LQ8PXLJdQM1JgZ9eNtKd8dyEE81hyMlUv0TRrOS45uSu52VZdf4UsiE5oEAlwQlYN8iE
 G33gSgMopUd0da4N2MbEOsBJpBgDhllBoa3MHVwdvVTL9OZsxLN7+QXBx64j+RE4lMGN
 Z1wdxv3LlPvWRqN8DyHz96RieQpPi6liO24dnu9WDtIrgGeiE4WeeM9bNiXlVf8+XUXi
 B0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694759520; x=1695364320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpnCHQI5l8nwz/U4PCX8Xtr6kngkaaN1OxDlC1qu470=;
 b=JpOtcT+YgY/oRHRRUGQKMvIX0m95vPJ/n5xl0h+voK5gNcjyHyNIbTN9ayFf3J2JaR
 nKuFbRcEv6aFMx07pP/+B7711VJxKlDZKbNW/+Ep48dk7q8UsObSggfraV/6g7DvcYPP
 lSkgClTJFvqkd7+hZKK95MakxeBFRinT122VVCF46iVQ6lXWUQTNqb71iZYFl1xlWsu2
 9TtOagtIhIwiGryDY8uv5iF1bozGpIH0TuWuccJ4beWuHiFPwwuEazDUkcoQ8RZmMfgh
 wjFfRy1vJGRkICyQU1qaPu/L9w4nldbwo9nuTuWCLrvCJc7LCKpeJ5W0a18xRR9PRJwN
 gf5A==
X-Gm-Message-State: AOJu0Ywfon3metD5UI6tx4OpnJ2+VfvBjzmPNO1OCGRh4QGzYAkEsToY
 KWUzB4UcfkTVuQKi/mi+4R6BzA==
X-Google-Smtp-Source: AGHT+IHgO0bZXgnWQfRvfzBZS7ewGP1R3zOFtzUqi8RKnFdKAlBfq+x18MfpHTkm41vx8ImQeWP4zQ==
X-Received: by 2002:a05:600c:cc:b0:401:c52c:5ed9 with SMTP id
 u12-20020a05600c00cc00b00401c52c5ed9mr686634wmm.32.1694759520305; 
 Thu, 14 Sep 2023 23:32:00 -0700 (PDT)
Received: from hades (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c228900b003fff96bb62csm3735672wmf.16.2023.09.14.23.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 23:31:59 -0700 (PDT)
Date: Fri, 15 Sep 2023 09:31:57 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v2 4/6] efi_loader: support boot from URI device path
Message-ID: <ZQP6XU+Y2SiCOchV@hades>
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-5-masahisa.kojima@linaro.org>
 <ZQMRB9allzBqrFGX@hera>
 <CADQ0-X9mDQbRRatGsKuJNYUGVRC8K-N96HAHXuxpR_wMG=HHAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADQ0-X9mDQbRRatGsKuJNYUGVRC8K-N96HAHXuxpR_wMG=HHAA@mail.gmail.com>
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

Hi Kojima-san, 

> > > +                                       efi_handle_t *image_handle)
> > > +{
> > > +     efi_status_t ret;
> > > +     efi_handle_t bm_handle;
> > > +     struct efi_handler *handler;
> > > +     struct efi_device_path *file_path;
> > > +     struct efi_device_path *device_path;
> > > +
> > > +     if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&bm_handle)) {
> > > +             log_warning("DM_TAG_EFI not found\n");
> > > +             return EFI_INVALID_PARAMETER;
> > > +     }
> > > +
> > > +     ret = efi_search_protocol(bm_handle,
> > > +                               &efi_simple_file_system_protocol_guid, &handler);
> > > +     if (ret != EFI_SUCCESS)
> > > +             return ret;
> > > +
> > > +     ret = efi_search_protocol(bm_handle, &efi_guid_device_path, &handler);
> > > +     if (ret != EFI_SUCCESS)
> > > +             return ret;
> > > +
> > > +     ret = efi_protocol_open(handler, (void **)&device_path, efi_root, NULL,
> > > +                             EFI_OPEN_PROTOCOL_GET_PROTOCOL);
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
> > We need to decide what we want here.  There were recently some patches from
> > Raymond [0] which piggybacked on your earlier eficonfig work.  I think the
> > last patch of this series hasn't been merged due to a test failing, but we
> > should fix it.
> > That patch has a different approach.  Everytime a disk appears it will add
> > a boot option if the default filepath is found and that's how we fixed the
> 
> efi_bootmgr_update_media_device_boot_option() automatically adds the
> boot option if the device handle installed EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> but it does not check whether the default file path is found or not.
> When the user selects the automatically created boot option,
> expand_media_path()
> is called and efibootmgr tries to boot with the default file.
> 

Ah correct.  On the function above though, we are we open coding a
different version of efi_open_protocol()?  Can't we call that instead of
efi_search_protocol()/efi_protocol_open()? 

> > behaviour of efibootmgr to adhere to the EFI spec.  This patch is doing the
> > opposite, trying to detect the BOOTAA64.EFI etc on the fly.  I think I
> > prefer the approach you have here, but we should end up with one solution
> > to solve both.
> 
> This HTTP Boot case is slightly different from the case where the user selects
> the automatically added boot option.
> In this case, user selects the URI device path boot option. The
> efibootmgr downloads the
> file, mount the image, and try to boot with the default file name on the fly.
> When the patch[0] is merged, it is possible to boot the downloaded iso
> image from the
> automatically added "blkmap" boot option, but I think efibootmgr needs
> to boot with
> the URI device path user selected that this series does, not boot
> from the "blkmap" boot option.
> 

Indeed, the used must still select the 'http://' boot option.  
It's been a while and I don't remember the eficonfig details.  Do you
remember why we decided to store the load options after scanning back then?  
IOW if we pick this up, can we also use it on the efibootmgr code and scan
all disks on the fly instead of adding boot options?

> >
> > > +
> > > +/**
> > > + * load_default_file_from_blk_dev() - load the default file
> > > + *
> > > + * @blk              pointer to the UCLASS_BLK udevice
> > > + * @handle:  pointer to handle for newly installed image
> > > + * Return:   status code
> > > + */
> > > +static efi_status_t load_default_file_from_blk_dev(struct udevice *blk,
> > > +                                                efi_handle_t *handle)
> > > +{
> > > +     efi_status_t ret;
> > > +     struct udevice *partition;
> > > +
> > > +     /* image that has no partition table but a file system */
> > > +     ret = try_load_default_file(blk, handle);
> > > +     if (ret == EFI_SUCCESS)
> > > +             return ret;
> > > +
> > > +     /* try the partitions */
> > > +     device_foreach_child(partition, blk) {
> > > +             enum uclass_id id;
> > > +
> > > +             id = device_get_uclass_id(partition);
> > > +             if (id != UCLASS_PARTITION)
> > > +                     continue;
> > > +
> > > +             ret = try_load_default_file(partition, handle);
> > > +             if (ret == EFI_SUCCESS)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     return EFI_NOT_FOUND;
> > > +}
> > > +
> > > +/**
> > > + * try_load_from_uri_path() - Handle the URI device path
> > > + *
> > > + * @uridp:   uri device path
> > > + * @lo_label label of load option
> > > + * @handle:  pointer to handle for newly installed image
> > > + * Return:   status code
> > > + */
> > > +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> > > +                                        u16 *lo_label,
> > > +                                        efi_handle_t *handle)
> > > +{
> > > +     char *s;
> > > +     int uri_len;
> > > +     int image_size;
> > > +     efi_status_t ret;
> > > +     ulong image_addr;
> > > +
> > > +     s = env_get("loadaddr");
> > > +     if (!s) {
> > > +             log_err("Error: loadaddr is not set\n");
> > > +             return EFI_INVALID_PARAMETER;
> > > +     }
> > > +     image_addr = hextoul(s, NULL);
> > > +     image_size = wget_with_dns(image_addr, uridp->uri);
> > > +     if (image_size < 0)
> > > +             return EFI_INVALID_PARAMETER;
> > > +
> > > +     /*
> > > +      * If the file extension is ".iso" or ".img", mount it and try to load
> > > +      * the default file.
> >
> > Don't we have a better way to validate isos and efi apps instead of
> > the extension?  The efi is checked against a valid PE/COFF image so I guess
> > we'll really on the mount to fail for isos?
> 
> EDK2 reference implementation checks the file type with the following priority.
>  1) "Content-Type" header in HTTP response message
>  2) Filename Extensions
> Documentation is here[1].
> 
> Since "Content-Type" is not available in the current U-Boot wget, file extension
> is used to identify ISO images.

Ok fair enough, we can go back and improve this once lwip is merged I guess

> 
> [1] https://github.com/tianocore/tianocore.github.io/wiki/HTTP-Boot#ram-disk-boot-from-http
> 

[...]

Thanks
/Ilias
