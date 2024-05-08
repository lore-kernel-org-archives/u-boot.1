Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0041C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5813C886F1;
	Wed,  8 May 2024 16:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m4J2jp/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E395886F1; Wed,  8 May 2024 16:05:04 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848E888551
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59d0810f59so712407866b.0
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715177101; x=1715781901; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGpuhR52Sq0n5/Xg4J0uw8Yv98KpaEFeBqsD64N+f90=;
 b=m4J2jp/KzPsMdunZQnberEFCefHmmS+tm6oezNhU4TVjvMpLQFlgb53MAUCGecuKM7
 Bb5JfA4bo1ytvOUFnpXDdhSs5QJZk1xr0jyrXepm4FkHf7rB2Ik/ofv+MWUYJ6SJ6vDr
 JlevOFvrpEL0cu9iJzw4w5v+VnJfWd+CxDexYCnV9rXrew8ttwKuqQkpu4KbZs/jqJRW
 cglnBq5DNuv/hNe9N7vJWoVe5zv5FwL/3f7x8BEI6zuwihMX6O6r6wsigYRhhFjKk/Qe
 JFv/ecDAevLuUZKsIqo9ux+DdFFwTltg2LSslLR2cGnNsT8nOmx/A8K+ret2+80GPQG6
 ReYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715177101; x=1715781901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGpuhR52Sq0n5/Xg4J0uw8Yv98KpaEFeBqsD64N+f90=;
 b=fElabyfCkCmP8iETTJmMvEIMoV1NkQoSX1uQvY6pfkfPkAjKqsN+GQ9aTkfDa089//
 OvzbkET/GvgHw8vHJ/+69CwAs9D3CoueyNAsvfdpw5tvDPzGjnyycwVZYGySJcVAXk4A
 MopqbV+Mrdparfg6PnjPgzdtF6S8eH5gNtBbqGPIH9Sqn5VthIcX3ogp8ezeRHj+9nrP
 Tq7ouoWxq+0bbwWETpUpPlR4b46mkEljA/xplyhEdstYbo4m2pYTNBVJgztVzIXi0JGZ
 KUKSwOdGGcovxUXuRAaongY4UHCbLT6SijDrIghB1jv9y2pcp2+JC3wY3Y7EslP5wEgn
 YV/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc7AjHRJ/+oj5K2ew1P+brvk1+1PK9GnHE0eLCUj8rcgNHj2y24ri8dMJnnRD7AgOBfqx5u6Unkqr1PsVCwtb2CRgrDQ==
X-Gm-Message-State: AOJu0Yxug7DsG6GGXdSDs4dxLjaYlzFTrz8r8fZRYnMSu1Z6f2QaeX+K
 NzxIfexYGJjeU3QQlNey/fjt2fS2Mq/dS1qxEtzzNDwwrDT7lx+oFLsmigZYY5KnfXSEA68wvGI
 tzkXmTv8PTJfVBwFxQDcBVgDGhrU=
X-Google-Smtp-Source: AGHT+IFvCY4/x2YXsbSxqYiH11BxZMa3PRkrqv5haKFfCF6YgF6Iux0B84IlYSAqrXngEBV2/erl+59lJJ7PrJe2sN0=
X-Received: by 2002:a50:a417:0:b0:572:7e7e:4296 with SMTP id
 4fb4d7f45d1cf-5731d99aa93mr2214410a12.3.1715177100398; Wed, 08 May 2024
 07:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240508112401.155528-1-o451686892@gmail.com>
 <CAC_iWjLv8cdL-zUfYA+7GAtY=xHOHN6kJmg7gOFdbCmpPoiB5A@mail.gmail.com>
In-Reply-To: <CAC_iWjLv8cdL-zUfYA+7GAtY=xHOHN6kJmg7gOFdbCmpPoiB5A@mail.gmail.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 8 May 2024 22:04:48 +0800
Message-ID: <CAHk0HovLibm4AamKge=qMNc817QaXAYE6r6kBE_XqUeXSxrrJg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: capsule: detect possible ESP device path
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 8, 2024 at 9:47=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Weizhao,
>
> On Wed, 8 May 2024 at 14:24, Weizhao Ouyang <o451686892@gmail.com> wrote:
> >
> > When using CapsuleApp to execute on-disk update, it will choose the
> > first boot option as BootNext entry to perform the capsule update after
> > a reboot.
>
> This is not entirely accurate. The capsule update on-disk mechanism
> will look in the ESP pointed to by BootNext or the highest priority
> BootOrder.
> But the problem you are describing isn't tied only to capsules. IIUC
> if you have a logical partition with bootXXX.efi the current code will
> ignore it as well and the automatic selection of the boot option won't
> work.
> Can you adjust the commit message on v2 and mention the scanning as an
> issue with the capsule on disk being the obvious side-effect?

I'll do.

>
> > But auto-generate boot option will ignore the logical
> > partition which might be an ESP, thus it could not find the capsule
> > file.
> >
> > Align with the EDK II, detect the possible ESP device path by expanding
> > the media path.
>
> >
> > Fixes: f86fba8adbf3 ("efi_loader: auto-generate boot option for each bl=
kio device")
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> >  include/efi_loader.h          |   6 ++
> >  lib/efi_loader/efi_boottime.c |  15 ++---
> >  lib/efi_loader/efi_capsule.c  | 110 +++++++++++++++++++++++++++++++++-
> >  3 files changed, 118 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 9600941aa327..9d78fa936701 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -683,6 +683,12 @@ efi_status_t efi_protocol_open(struct efi_handler =
*handler,
> >                                void **protocol_interface, void *agent_h=
andle,
> >                                void *controller_handle, uint32_t attrib=
utes);
> >
> > +/* Connect drivers to controller */
> > +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_han=
dle,
> > +                                          efi_handle_t *driver_image_h=
andle,
> > +                                          struct efi_device_path *rema=
in_device_path,
> > +                                          bool recursive);
> > +
> >  /* Install multiple protocol interfaces */
> >  efi_status_t EFIAPI
> >  efi_install_multiple_protocol_interfaces(efi_handle_t *handle, ...);
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottim=
e.c
> > index 1951291747cd..2c86d78208b2 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -103,12 +103,6 @@ static efi_status_t EFIAPI efi_disconnect_controll=
er(
> >                                         efi_handle_t driver_image_handl=
e,
> >                                         efi_handle_t child_handle);
> >
> > -static
> > -efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_han=
dle,
> > -                                          efi_handle_t *driver_image_h=
andle,
> > -                                          struct efi_device_path *rema=
in_device_path,
> > -                                          bool recursive);
> > -
> >  /* Called on every callback entry */
> >  int __efi_entry_check(void)
> >  {
> > @@ -3670,11 +3664,10 @@ static efi_status_t efi_connect_single_controll=
er(
> >   *
> >   * Return: status code
> >   */
> > -static efi_status_t EFIAPI efi_connect_controller(
> > -                       efi_handle_t controller_handle,
> > -                       efi_handle_t *driver_image_handle,
> > -                       struct efi_device_path *remain_device_path,
> > -                       bool recursive)
> > +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_han=
dle,
> > +                                          efi_handle_t *driver_image_h=
andle,
> > +                                          struct efi_device_path *rema=
in_device_path,
> > +                                          bool recursive)
> >  {
> >         efi_status_t r;
> >         efi_status_t ret =3D EFI_NOT_FOUND;
> > diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.=
c
> > index de0d49ebebda..919e3cba071b 100644
> > --- a/lib/efi_loader/efi_capsule.c
> > +++ b/lib/efi_loader/efi_capsule.c
> > @@ -922,6 +922,105 @@ static bool device_is_present_and_system_part(str=
uct efi_device_path *dp)
> >         return true;
> >  }
> >
> > +/**
> > + * get_esp_from_boot_option_file_path - get the expand device path
>
> expanded

Okay.

>
> > + *
> > + * Get a possible efi system partition by expanding a boot option
> > + * file path.
> > + *
> > + * @boot_dev   The device path pointing to a boot option
> > + * Return:     The full ESP device path or NULL if fail
> > + */
> > +static struct efi_device_path *get_esp_from_boot_option_file_path(stru=
ct efi_device_path *boot_dev)
> > +{
> > +       efi_status_t ret =3D EFI_SUCCESS;
> > +       efi_handle_t handle;
> > +       struct efi_device_path *dp =3D boot_dev;
> > +       struct efi_device_path *full_path =3D NULL;
> > +
> > +       ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_file_system=
_protocol_guid,
> > +                                             &dp,
> > +                                             &handle));
> > +       if (ret !=3D EFI_SUCCESS)
> > +               ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io_g=
uid, &dp, &handle));
> > +
> > +       /* Expand Media Device Path */
>
> I don't see where the device path is expanded in this patch.
> We already have try_load_from_media() which tries to do something
> similar. Is anything missing from there?

Yes we have the try_load_from_media(), but it doesn't cover all
cases. Maybe we need to expand it.

>
> > +       if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(dp, END, END)) {
>
> Can you invert the logic here and return immediately?
> (if ret !=3D EFI_SUCCESS ...etc )
>     return full_path;
>
> The indentation will go away.

Okay.

>
> > +               struct efi_device_path *temp_dp;
> > +               struct efi_block_io *block_io;
> > +               void *buffer;
> > +               efi_handle_t *simple_file_system_handle;
> > +               efi_uintn_t number_handles, index;
> > +               u32 size;
> > +               u32 temp_size;
> > +
> > +               temp_dp =3D boot_dev;
> > +               ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_fil=
e_system_protocol_guid,
> > +                                                     &temp_dp,
> > +                                                     &handle));
> > +               /*
> > +                * For device path pointing to simple file system, it o=
nly expands to one
> > +                * full path
>
> Why do we have multiple calls to efi_locate_device_path()? Aren't the
> arguments identical?
> Which part of edk2 did you read? Is it BmExpandMediaDevicePath()?

Yes it is BmExpandMediaDevicePath().
The device_is_present_and_system_part() check can be removed.

>
>
> > +                */
> > +               if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(temp_dp, END,=
 END)) {
> > +                       if (device_is_present_and_system_part(temp_dp))
> > +                               return temp_dp;
> > +               }
> > +
> > +               /*
> > +                * For device path only pointing to the removable devic=
e handle, try to
> > +                * search all its children handles
> > +                */
> > +               ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io_g=
uid, &temp_dp, &handle));
> > +               EFI_CALL(efi_connect_controller(handle, NULL, NULL, tru=
e));
> > +
> > +               /* Align with edk2, issue a dummy read to the device to=
 check the device change */
> > +               ret =3D EFI_CALL(efi_handle_protocol(handle, &efi_block=
_io_guid, (void **)&block_io));
> > +               if (ret =3D=3D EFI_SUCCESS) {
> > +                       buffer =3D memalign(block_io->media->io_align, =
block_io->media->block_size);
> > +                       if (buffer) {
> > +                               ret =3D EFI_CALL(block_io->read_blocks(=
block_io,
> > +                                                                    bl=
ock_io->media->media_id,
> > +                                                                    0,
> > +                                                                    bl=
ock_io->media->block_size,
> > +                                                                    bu=
ffer));
> > +                               free(buffer);
> > +                       } else {
> > +                               return full_path;
> > +                       }
> > +               } else {
> > +                       return full_path;
> > +               }
> > +
> > +               /* detect the default boot file from removable media */
> > +               size =3D efi_dp_size(boot_dev) - sizeof(struct efi_devi=
ce_path);
> > +               EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
> > +                                                 &efi_simple_file_syst=
em_protocol_guid,
> > +                                                 NULL,
> > +                                                 &number_handles,
> > +                                                 &simple_file_system_h=
andle));
> > +               for (index =3D 0; index < number_handles; index++) {
> > +                       EFI_CALL(efi_handle_protocol(simple_file_system=
_handle[index],
> > +                                                    &efi_guid_device_p=
ath,
> > +                                                    (void **)&temp_dp)=
);
> > +
> > +                       log_debug("Search ESP %pD\n", temp_dp);
> > +                       temp_size =3D efi_dp_size(temp_dp) - sizeof(str=
uct efi_device_path);
> > +                       if (size <=3D temp_size && !memcmp(temp_dp, boo=
t_dev, size)) {
> > +                               if (device_is_present_and_system_part(t=
emp_dp)) {
> > +                                       efi_free_pool(simple_file_syste=
m_handle);
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
> >         struct efi_device_path *boot_dev =3D NULL;
> > +       struct efi_device_path *full_path =3D NULL;
> >         efi_status_t ret;
> >
> >         /* find active boot device in BootNext */
> > @@ -961,8 +1061,14 @@ static efi_status_t find_boot_device(void)
> >                         if (device_is_present_and_system_part(boot_dev)=
) {
> >                                 goto found;
> >                         } else {
> > -                               efi_free_pool(boot_dev);
> > -                               boot_dev =3D NULL;
> > +                               full_path =3D get_esp_from_boot_option_=
file_path(boot_dev);
> > +                               if (full_path) {
> > +                                       boot_dev =3D full_path;
> > +                                       goto found;
> > +                               } else {
> > +                                       efi_free_pool(boot_dev);
> > +                                       boot_dev =3D NULL;
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
