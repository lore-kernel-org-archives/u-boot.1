Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5908CC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 13:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0D38843D;
	Wed,  8 May 2024 15:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GDfFsPTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C658873C; Wed,  8 May 2024 15:56:59 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB83C8843D
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 15:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59ece5e18bso546841666b.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715176617; x=1715781417; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBMNXXB7qardlEKv1HcuwIMfn4zc0AyIEm9N0znqzfU=;
 b=GDfFsPTiQj2EZBbTLmjISlRlyDhPIcCowtluUEpdfvYI85Yok5PLgfpeSVk3Lq/DTn
 IE0YWG9gMfpswdHNURmf1d441gf4zrcL7xr8wqRj3zpHGUP6+/P5tprkygrHX33CE3+O
 cUNU4wvQpFupafuOHpWD65jBnw5FI+4M5kVsN32OLdMIqflC+1Id+pN7bY6TDGESSYba
 4MiQRggSJvAWkIEImF2y9JzQEbYALwIf8S5VQnpqZG6RxGjOC9yHRyC0Kx2Dx8qKDILR
 BAZvzvZfGcuFQgdSbXcFuGUtWcQiKNU/QA5H4Qis4igZ+mS4bztuXN81cwpsuf8H/BLp
 ReIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715176617; x=1715781417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBMNXXB7qardlEKv1HcuwIMfn4zc0AyIEm9N0znqzfU=;
 b=rUqBSDLUIKEk6dXkxEo1KTHg6va2r8ayLjMLa0PAuMY+nV9T9zJYaMskafw7mo2C1/
 8ROscr9nyZJykNA2sW0/3ZRGh2OXu6iGZJ1gxdkEIwWh4WfmyKOxDtyv2tzvkDi4TjCN
 mT4O/V6qLX87JZDG4UpTDRoKrtgMQTW8AWggpwDg/yhqrohrlwInpiwd/u8Sn4Z0wfep
 y8YgkzbrHAQdN/HHRg9cgKEhAzZppfoy08w35c9hECpECj3CYIcLe9aG4krrvu0Jm6Td
 2Gi+JsjMwXZ1YVFetuLCTAuT3CR1MEm2JuTIqeRhSTTW2YgnveoSWQfx6EmLetDjkdTE
 SX8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVELJouyv5xYD/WIf5oB6HRa7kcuyBFe1jrp8zdzTmCdEmChsBXxDmkGuRit2ujxsol2oXgs9SP4VRFasqWhaw+MCcAjQ==
X-Gm-Message-State: AOJu0YxS3LRmlKRX+jbsJdbhnqMXW4IAN+TY9/RbbZnrenVDEmw7ffPg
 dPyH5AQIHBGYZYsRCnj8YmL91j9/9rWAhNzLm+OfHRGJNM2vXXYgNGnwlUWh3h1EStv8Fb2tPXA
 r0xXhTtSWJsIDqv9V4PgDuRKTtfRy/vdAxMZtOQ==
X-Google-Smtp-Source: AGHT+IHVk9Sd1u/Zjj7sYr+75jVCAMUVTankvt3oO2AeZadOW3ctTZC245VrMojLQMvYWG56EYI5OekuOM3dht8AHNI=
X-Received: by 2002:a17:907:5c4:b0:a59:bdb7:73ec with SMTP id
 a640c23a62f3a-a59fb9dbd54mr293350166b.72.1715176617183; Wed, 08 May 2024
 06:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240508112401.155528-1-o451686892@gmail.com>
 <CAC_iWjLv8cdL-zUfYA+7GAtY=xHOHN6kJmg7gOFdbCmpPoiB5A@mail.gmail.com>
In-Reply-To: <CAC_iWjLv8cdL-zUfYA+7GAtY=xHOHN6kJmg7gOFdbCmpPoiB5A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 16:56:21 +0300
Message-ID: <CAC_iWj+oxsNrzPPANvCK86Pq8eGKO7dqOSobBWzwNaTBVS-2tg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: capsule: detect possible ESP device path
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
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

>
> > + *
> > + * Get a possible efi system partition by expanding a boot option
> > + * file path.
> > + *
> > + * @boot_dev   The device path pointing to a boot option
> > + * Return:     The full ESP device path or NULL if fail
> > + */
> > +static struct efi_device_path *get_esp_from_boot_option_file_path(struct efi_device_path *boot_dev)
> > +{
> > +       efi_status_t ret = EFI_SUCCESS;
> > +       efi_handle_t handle;
> > +       struct efi_device_path *dp = boot_dev;
> > +       struct efi_device_path *full_path = NULL;
> > +
> > +       ret = EFI_CALL(efi_locate_device_path(&efi_simple_file_system_protocol_guid,
> > +                                             &dp,
> > +                                             &handle));
> > +       if (ret != EFI_SUCCESS)
> > +               ret = EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &dp, &handle));
> > +
> > +       /* Expand Media Device Path */
>
> I don't see where the device path is expanded in this patch.
> We already have try_load_from_media() which tries to do something
> similar. Is anything missing from there?

Looking a bit closer, we do lack calling ConnectController there, but
all this should be added to try_load_from_media() not in a different
path.
Also I don't think we need the Fixes tag

Thanks
/Ilias
>
> > +       if (ret == EFI_SUCCESS && EFI_DP_TYPE(dp, END, END)) {
>
> Can you invert the logic here and return immediately?
> (if ret != EFI_SUCCESS ...etc )
>     return full_path;
>
> The indentation will go away.
>
> > +               struct efi_device_path *temp_dp;
> > +               struct efi_block_io *block_io;
> > +               void *buffer;
> > +               efi_handle_t *simple_file_system_handle;
> > +               efi_uintn_t number_handles, index;
> > +               u32 size;
> > +               u32 temp_size;
> > +
> > +               temp_dp = boot_dev;
> > +               ret = EFI_CALL(efi_locate_device_path(&efi_simple_file_system_protocol_guid,
> > +                                                     &temp_dp,
> > +                                                     &handle));
> > +               /*
> > +                * For device path pointing to simple file system, it only expands to one
> > +                * full path
>
> Why do we have multiple calls to efi_locate_device_path()? Aren't the
> arguments identical?
> Which part of edk2 did you read? Is it BmExpandMediaDevicePath()?
>
>
> > +                */
> > +               if (ret == EFI_SUCCESS && EFI_DP_TYPE(temp_dp, END, END)) {
> > +                       if (device_is_present_and_system_part(temp_dp))
> > +                               return temp_dp;
> > +               }
> > +
> > +               /*
> > +                * For device path only pointing to the removable device handle, try to
> > +                * search all its children handles
> > +                */
> > +               ret = EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &temp_dp, &handle));
> > +               EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));
> > +
> > +               /* Align with edk2, issue a dummy read to the device to check the device change */
> > +               ret = EFI_CALL(efi_handle_protocol(handle, &efi_block_io_guid, (void **)&block_io));
> > +               if (ret == EFI_SUCCESS) {
> > +                       buffer = memalign(block_io->media->io_align, block_io->media->block_size);
> > +                       if (buffer) {
> > +                               ret = EFI_CALL(block_io->read_blocks(block_io,
> > +                                                                    block_io->media->media_id,
> > +                                                                    0,
> > +                                                                    block_io->media->block_size,
> > +                                                                    buffer));
> > +                               free(buffer);
> > +                       } else {
> > +                               return full_path;
> > +                       }
> > +               } else {
> > +                       return full_path;
> > +               }
> > +
> > +               /* detect the default boot file from removable media */
> > +               size = efi_dp_size(boot_dev) - sizeof(struct efi_device_path);
> > +               EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
> > +                                                 &efi_simple_file_system_protocol_guid,
> > +                                                 NULL,
> > +                                                 &number_handles,
> > +                                                 &simple_file_system_handle));
> > +               for (index = 0; index < number_handles; index++) {
> > +                       EFI_CALL(efi_handle_protocol(simple_file_system_handle[index],
> > +                                                    &efi_guid_device_path,
> > +                                                    (void **)&temp_dp));
> > +
> > +                       log_debug("Search ESP %pD\n", temp_dp);
> > +                       temp_size = efi_dp_size(temp_dp) - sizeof(struct efi_device_path);
> > +                       if (size <= temp_size && !memcmp(temp_dp, boot_dev, size)) {
> > +                               if (device_is_present_and_system_part(temp_dp)) {
> > +                                       efi_free_pool(simple_file_system_handle);
> > +                                       return temp_dp;
> > +                               }
> > +                       }
> > +               }
> > +
> > +               if (simple_file_system_handle)
> > +                       efi_free_pool(simple_file_system_handle);
> > +       }
> > +
> > +       return full_path;
> > +}
> > +
> >  /**
> >   * find_boot_device - identify the boot device
> >   *
> > @@ -938,6 +1037,7 @@ static efi_status_t find_boot_device(void)
> >         int i, num;
> >         struct efi_simple_file_system_protocol *volume;
> >         struct efi_device_path *boot_dev = NULL;
> > +       struct efi_device_path *full_path = NULL;
> >         efi_status_t ret;
> >
> >         /* find active boot device in BootNext */
> > @@ -961,8 +1061,14 @@ static efi_status_t find_boot_device(void)
> >                         if (device_is_present_and_system_part(boot_dev)) {
> >                                 goto found;
> >                         } else {
> > -                               efi_free_pool(boot_dev);
> > -                               boot_dev = NULL;
> > +                               full_path = get_esp_from_boot_option_file_path(boot_dev);
> > +                               if (full_path) {
> > +                                       boot_dev = full_path;
> > +                                       goto found;
> > +                               } else {
> > +                                       efi_free_pool(boot_dev);
> > +                                       boot_dev = NULL;
> > +                               }
> >                         }
> >                 }
> >         }
> > --
> > 2.40.1
> >
>
> Thanks
> /Ilias
