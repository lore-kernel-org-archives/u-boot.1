Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B827C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 13:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C2E8843F;
	Wed,  8 May 2024 15:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dpVmi70o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9E9886F1; Wed,  8 May 2024 15:01:02 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999B388393
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 15:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5726ccca4c8so115189a12.3
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715173258; x=1715778058; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gYZeKwuw+4pdgO90+51kkqD0WBP6ozigOPJgeDJjIA=;
 b=dpVmi70oouOWh1LN/NQMNOSW0OGu0e2Cybg86N9yZnN4RuGzySbfrjbBWIyEqPlKfG
 Kr0WuRUKh1iqdZPyBfzi5NDOXBGov1R2As/qkgRfxuGtWWDnNDXZVKbuVrgdozZ5YL2L
 qspkZpoprNyq7TtvmSFVWYhKrS/DpyJiHhtj11CH6jhgHOV4NwlprYWe77ekm8XND99h
 VGbFf2ZEIdnpZCqzkQAXKMsaD8ElG8HEKPPC7xlrS2+CETMbjVX6EBl6YCVZNctA+oTV
 KJvQqxOafdXycD9Gn66GvGgkq3UXHkHx+uUqXvCNQKqWEb1vfZdzV6/7H/tq4NWkFBsV
 NRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173258; x=1715778058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gYZeKwuw+4pdgO90+51kkqD0WBP6ozigOPJgeDJjIA=;
 b=anzI2a7f+Ai+yRpmYjnJJRnaXbHuNd7HaHI/keOErFI3AQX2KoGEzPwsp6PA84i9G/
 T4AyXaZWLrJb6Mvcrp3sX8ZIU9ROyZ90Paa1wJhPLNvlFlgLCiQR0Q8PMsdlX0E56CWW
 HVtKafcfWKcj0pe7l0dw09RYMtgsXU9h5avbD/izIDgDE3B8q55iTdW9eBNWY3QnUY1M
 X2A+0sbQRxTdVYQAt0c7ZNrrMx7vqP0HzG+hNUySvAy8CaGB1lkxQ0tCLf1jaidRPA5r
 v0jAdCBO4Yen6lZkWYAHfY5KpW/WO6KPafgz9h7o7q4+OT3DOfRwGXnQZJas/K45l3B9
 ARFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW99C1fmg9jtPRNNgVvg3LZ6IbhTVZGWAGaCTCgunpQlUFn9nB1jcP/VNIFqNtsHoqRENajYgG+jKOARhV88+CMseJMHQ==
X-Gm-Message-State: AOJu0YwnPUezZi6E6qfawieu3ezz9cr7TFopLqv07L+ghOmIdwlqXGXt
 DBheW5fXEtAK3NPZ9YBsNB0YeKLy0BCWNDXDHNjEdJlHVRvoMUGAOxFSYIuj3n017L/vaVFPWN0
 VybhuQGQgbzZVxKuAQ1jXl8y7TVE=
X-Google-Smtp-Source: AGHT+IHOjXVScPafPzsJtpdpQnIcaJMyi+zZ0i+nGP6CXEuAU7cIjm/idkiXOEcDqKm6KYSfw532iM5STwJV4TCY23c=
X-Received: by 2002:a50:9e8d:0:b0:56e:24a5:587a with SMTP id
 4fb4d7f45d1cf-5731d9d2913mr1966344a12.11.1715173257360; Wed, 08 May 2024
 06:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240508112401.155528-1-o451686892@gmail.com>
 <c2323896-132a-4b02-86db-5cb62c6e1ba5@moroto.mountain>
In-Reply-To: <c2323896-132a-4b02-86db-5cb62c6e1ba5@moroto.mountain>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 8 May 2024 21:00:46 +0800
Message-ID: <CAHk0Hot7_1s2pJXbo371Mm=JtGOEczS=L9Bx2jAVVBPWr=fkow@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: capsule: detect possible ESP device path
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Dan,

Thanks for the suggestion, I'll fix them in the next patch.

BR,
Weizhao

On Wed, May 8, 2024 at 8:04=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> On Wed, May 08, 2024 at 07:24:01PM +0800, Weizhao Ouyang wrote:
> > diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.=
c
> > index de0d49ebebda..919e3cba071b 100644
> > --- a/lib/efi_loader/efi_capsule.c
> > +++ b/lib/efi_loader/efi_capsule.c
> > @@ -922,6 +922,105 @@ static bool device_is_present_and_system_part(str=
uct efi_device_path *dp)
> >       return true;
> >  }
> >
> > +/**
> > + * get_esp_from_boot_option_file_path - get the expand device path
> > + *
> > + * Get a possible efi system partition by expanding a boot option
> > + * file path.
> > + *
> > + * @boot_dev The device path pointing to a boot option
> > + * Return:   The full ESP device path or NULL if fail
> > + */
> > +static struct efi_device_path *get_esp_from_boot_option_file_path(stru=
ct efi_device_path *boot_dev)
> > +{
> > +     efi_status_t ret =3D EFI_SUCCESS;
> > +     efi_handle_t handle;
> > +     struct efi_device_path *dp =3D boot_dev;
> > +     struct efi_device_path *full_path =3D NULL;
> > +
> > +     ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_file_system_p=
rotocol_guid,
> > +                                           &dp,
> > +                                           &handle));
> > +     if (ret !=3D EFI_SUCCESS)
> > +             ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io_gui=
d, &dp, &handle));
> > +
> > +     /* Expand Media Device Path */
> > +     if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(dp, END, END)) {
>
> Flip this around.  Always do failure handling.  Never do success
> handling.  full_path is always NULL.  Just return that.  Delete
> the variable.
>
>         if (ret !=3D EFI_SUCCESS ||
>             !EFI_DP_TYPE(dp, END, END))
>                 return NULL;
>
>
> > +             struct efi_device_path *temp_dp;
> > +             struct efi_block_io *block_io;
> > +             void *buffer;
> > +             efi_handle_t *simple_file_system_handle;
> > +             efi_uintn_t number_handles, index;
> > +             u32 size;
> > +             u32 temp_size;
> > +
> > +             temp_dp =3D boot_dev;
> > +             ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_file_=
system_protocol_guid,
> > +                                                   &temp_dp,
> > +                                                   &handle));
> > +             /*
> > +              * For device path pointing to simple file system, it onl=
y expands to one
> > +              * full path
> > +              */
> > +             if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(temp_dp, END, E=
ND)) {
>
> "Always" was hyperbole.  This success handling is fine.
>
> > +                     if (device_is_present_and_system_part(temp_dp))
> > +                             return temp_dp;
> > +             }
> > +
> > +             /*
> > +              * For device path only pointing to the removable device =
handle, try to
> > +              * search all its children handles
> > +              */
> > +             ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io_gui=
d, &temp_dp, &handle));
>
> ret is not used.  Delete.
>
> > +             EFI_CALL(efi_connect_controller(handle, NULL, NULL, true)=
);
> > +
> > +             /* Align with edk2, issue a dummy read to the device to c=
heck the device change */
> > +             ret =3D EFI_CALL(efi_handle_protocol(handle, &efi_block_i=
o_guid, (void **)&block_io));
> > +             if (ret =3D=3D EFI_SUCCESS) {
>
>         if (ret !=3D EFI_SUCCESS)
>                 return NULL;
>
> > +                     buffer =3D memalign(block_io->media->io_align, bl=
ock_io->media->block_size);
> > +                     if (buffer) {
>
>         if (!buffer)
>                 return NULL;
>
>
> > +                             ret =3D EFI_CALL(block_io->read_blocks(bl=
ock_io,
> > +                                                                  bloc=
k_io->media->media_id,
> > +                                                                  0,
> > +                                                                  bloc=
k_io->media->block_size,
> > +                                                                  buff=
er));
>
> Delete the unused "ret =3D " assignment.
>
> > +                             free(buffer);
> > +                     } else {
> > +                             return full_path;
> > +                     }
> > +             } else {
> > +                     return full_path;
> > +             }
> > +
> > +             /* detect the default boot file from removable media */
> > +             size =3D efi_dp_size(boot_dev) - sizeof(struct efi_device=
_path);
> > +             EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
> > +                                               &efi_simple_file_system=
_protocol_guid,
> > +                                               NULL,
> > +                                               &number_handles,
> > +                                               &simple_file_system_han=
dle));
> > +             for (index =3D 0; index < number_handles; index++) {
> > +                     EFI_CALL(efi_handle_protocol(simple_file_system_h=
andle[index],
> > +                                                  &efi_guid_device_pat=
h,
> > +                                                  (void **)&temp_dp));
> > +
> > +                     log_debug("Search ESP %pD\n", temp_dp);
> > +                     temp_size =3D efi_dp_size(temp_dp) - sizeof(struc=
t efi_device_path);
> > +                     if (size <=3D temp_size && !memcmp(temp_dp, boot_=
dev, size)) {
> > +                             if (device_is_present_and_system_part(tem=
p_dp)) {
>
> You could combine these conditions:
>
>                 if (size <=3D temp_size &&
>                     memcmp(temp_dp, boot_dev, size) =3D=3D 0 &&
>                     device_is_present_and_system_part(temp_dp)) {
>                         efi_free_pool(simple_file_system_handle);
>                         return temp_dp;
>                 }
>
>
> > +                                     efi_free_pool(simple_file_system_=
handle);
> > +                                     return temp_dp;
> > +                             }
> > +                     }
> > +             }
> > +
> > +             if (simple_file_system_handle)
> > +                     efi_free_pool(simple_file_system_handle);
> > +     }
> > +
> > +     return full_path;
> > +}
> > +
> >  /**
> >   * find_boot_device - identify the boot device
> >   *
> > @@ -938,6 +1037,7 @@ static efi_status_t find_boot_device(void)
> >       int i, num;
> >       struct efi_simple_file_system_protocol *volume;
> >       struct efi_device_path *boot_dev =3D NULL;
> > +     struct efi_device_path *full_path =3D NULL;
>
> No need to initialize this to NULL, it disables static checker warnings
> for uninitialized variables so it can lead to bugs.
>
> >       efi_status_t ret;
> >
> >       /* find active boot device in BootNext */
> > @@ -961,8 +1061,14 @@ static efi_status_t find_boot_device(void)
> >                       if (device_is_present_and_system_part(boot_dev)) =
{
> >                               goto found;
> >                       } else {
> > -                             efi_free_pool(boot_dev);
> > -                             boot_dev =3D NULL;
> > +                             full_path =3D get_esp_from_boot_option_fi=
le_path(boot_dev);
> > +                             if (full_path) {
> > +                                     boot_dev =3D full_path;
>
> Later, we free full_path but do we ever free the original boot_dev?
>
> > +                                     goto found;
> > +                             } else {
> > +                                     efi_free_pool(boot_dev);
> > +                                     boot_dev =3D NULL;
> > +                             }
>
> Better to delete indenting where you can:
>
>                         full_path =3D get_esp_from_boot_option_file_path(=
boot_dev);
>                         if (full_path) {
>                                 boot_dev =3D full_path;
>                                 goto found;
>                         }
>                         efi_free_pool(boot_dev);
>                         boot_dev =3D NULL;
>
> regards,
> dan carpenter
>
>
