Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A850C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 12:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF508843F;
	Wed,  8 May 2024 14:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XN6A7DeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EEA68843F; Wed,  8 May 2024 14:59:18 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A4CD88306
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 14:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59a64db066so1111444866b.3
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715173156; x=1715777956; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5x8rE1QI1a7a9MusmQWcIJm0WTZWf7tAr9icVs1kWA=;
 b=XN6A7DeSOIcYIZIEXT1rB1vBtVhY4sO0Ju+wtoYYIbE1g2fSFXKmJLfHtO2SO/kRPH
 Coo3AhSlfTIpKPTjVtT6DmnkFhwrTozVXJ6qJ6kO7TrguWFdCHwTOtwP0FoDaCJGZJxR
 qubdHjY7nheBIDLrfYQeWMt9mT99631YZIJ6/pYSk7zBKUs6CUKz84l1eMaP14PmNx4t
 nJ127TM5TMfodsUTO7NLf8IBTyMhx9OayMqy75UnJOwGW0ryGr6ekVl0FHrbvPb1Q5kv
 nG2gO/bNMx31o0DxYPNPSrvs3702SvxdmxWEKk3Cc+AGFt0akNeMTDmSc+AvwgwtNDuo
 RyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173156; x=1715777956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E5x8rE1QI1a7a9MusmQWcIJm0WTZWf7tAr9icVs1kWA=;
 b=LX8WSmufqz2gwMtG3Je8uh75WbHKGq/OOe2W/COM2OlgvaTEN+XK83GMvWjO4DSeDu
 Pnhh8ST0zYr7ItghGsYoFdrWyw/rkmb5MooaH4Nbcy3K6D+E26i01G5DjvyvWLU5UUrA
 6WrkcL/c668aYFMtQqkreemYusfP8H7OPN2pBcEQr43TbjUPEKFyjW2D3D6nxXC713hy
 nMC1hWuI5G/FgleE/C1dhg4+4FIr7nX4h37LZTCLYCvzK6U9d87ql5149jCjyaqCpox/
 VPoNYfJDgmhxFOnN172TLU+Pf0pX7qdAVJIf+esTaZDdC6OUcgVXqkNrLV/hkHJVP5cU
 kivw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZbrOC9pJzlYlqeQaAN+AdpkzbJUXGY/ONkL30FxFlFc8YQS3V4eAHR0v3jj2hortuLRn6pYDxxHaJllt7FF8g+3z+zw==
X-Gm-Message-State: AOJu0YxJF3xh4lKNnowN6inBSdue4I9YOg3dd5urESSFBG6ezm5V8GEZ
 vNJHG0RcFs3rVg1K5YctY3u7xNAcJcq3YDX1emMjv4haodKuVtelc+olZN5wT2kCCyJ2aqg//zz
 lRvXtziskOUBBsq/rOzdVEv1Bv+w=
X-Google-Smtp-Source: AGHT+IFLIBwYh8sVLS5q/BuIxpc2TSRdA2hhjiACrkFrZ+25+UXJpnnHTmxKM8Cx/vqBq3PjWj0/F63bwlOfyuI02ZA=
X-Received: by 2002:a50:a405:0:b0:572:51fb:5571 with SMTP id
 4fb4d7f45d1cf-5731d9ce2bfmr1554104a12.5.1715173155152; Wed, 08 May 2024
 05:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240508112401.155528-1-o451686892@gmail.com>
 <f4caebe2-d218-4ce7-9c3d-4dc83a0e1c76@gmx.de>
In-Reply-To: <f4caebe2-d218-4ce7-9c3d-4dc83a0e1c76@gmx.de>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 8 May 2024 20:59:03 +0800
Message-ID: <CAHk0Hou9neEiVDLBRAsFhqu9wrWq-amSde+p2GJ6BLqwxV98_g@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: capsule: detect possible ESP device path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
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

On Wed, May 8, 2024 at 7:52=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gmx=
.de> wrote:
>
> On 5/8/24 13:24, Weizhao Ouyang wrote:
> > When using CapsuleApp to execute on-disk update, it will choose the
> > first boot option as BootNext entry to perform the capsule update after
> > a reboot. But auto-generate boot option will ignore the logical
> > partition which might be an ESP, thus it could not find the capsule
> > file.
> >
> > Align with the EDK II, detect the possible ESP device path by expanding
> > the media path.
>
> Hello Wheizhoa,
>
>  From the description I would not know how to reproduce the problem you
> face.
>
> Could you, please, provide an example (including disk image and capsule)
> for QEMU and describe expected and observed behavior.
>
> We should add a CI test case covering the observed bug.

Hi Heinrich,

Here is a brief description, I'll add a testcase in the next patch.

background:
- there is an ESP in an mmc logical partition
- in the edk2 shell payload, running "CapsuleApp.efi -OD" to perform
the capsule on-disk update

workflow:
- currently, u-boot will auto-generate boot option and install with
eliminating logical partitions. So we will have a boot variable
Boot0000 that its file_path seems like: "/VenHw/eMMC(0)/eMMC(0)"
- then we run the efi app in the edk shell payload. The CapsuleApp
will find this boot entry, and it will detect that there is an ESP
in this mmc device. According to the on-disk update flow, it will
copy the capsule to the ESP, and add the Boot0000 to the BootNext.
- After CapsuleApp.efi reset the device, u-boot will check
OsIndications and perform the on-disk update flow. Then it will
search for the capsule file from the boot entry indicated by the
BootNext. Unfortunately, its file_path is "/VenHw/eMMC(0)/eMMC(0)",
so the search will fail.
- Using this patch, u-boot will expand the Boot0000 file path to
detect its ESP, so the capsule file will be found in the expanded
device path, eg: "/VenHw/eMMC(0)/eMMC(0)/HD(2)".

BR,
Weizhao

>
> >
> > Fixes: f86fba8adbf3 ("efi_loader: auto-generate boot option for each bl=
kio device")
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> >   include/efi_loader.h          |   6 ++
> >   lib/efi_loader/efi_boottime.c |  15 ++---
> >   lib/efi_loader/efi_capsule.c  | 110 +++++++++++++++++++++++++++++++++=
-
> >   3 files changed, 118 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 9600941aa327..9d78fa936701 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -683,6 +683,12 @@ efi_status_t efi_protocol_open(struct efi_handler =
*handler,
> >                              void **protocol_interface, void *agent_han=
dle,
> >                              void *controller_handle, uint32_t attribut=
es);
> >
> > +/* Connect drivers to controller */
> > +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_han=
dle,
> > +                                        efi_handle_t *driver_image_han=
dle,
> > +                                        struct efi_device_path *remain=
_device_path,
> > +                                        bool recursive);
> > +
> >   /* Install multiple protocol interfaces */
> >   efi_status_t EFIAPI
> >   efi_install_multiple_protocol_interfaces(efi_handle_t *handle, ...);
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottim=
e.c
> > index 1951291747cd..2c86d78208b2 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -103,12 +103,6 @@ static efi_status_t EFIAPI efi_disconnect_controll=
er(
> >                                       efi_handle_t driver_image_handle,
> >                                       efi_handle_t child_handle);
> >
> > -static
> > -efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_han=
dle,
> > -                                        efi_handle_t *driver_image_han=
dle,
> > -                                        struct efi_device_path *remain=
_device_path,
> > -                                        bool recursive);
> > -
> >   /* Called on every callback entry */
> >   int __efi_entry_check(void)
> >   {
> > @@ -3670,11 +3664,10 @@ static efi_status_t efi_connect_single_controll=
er(
> >    *
> >    * Return: status code
> >    */
> > -static efi_status_t EFIAPI efi_connect_controller(
> > -                     efi_handle_t controller_handle,
> > -                     efi_handle_t *driver_image_handle,
> > -                     struct efi_device_path *remain_device_path,
> > -                     bool recursive)
> > +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_han=
dle,
> > +                                        efi_handle_t *driver_image_han=
dle,
> > +                                        struct efi_device_path *remain=
_device_path,
> > +                                        bool recursive)
> >   {
> >       efi_status_t r;
> >       efi_status_t ret =3D EFI_NOT_FOUND;
> > diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.=
c
> > index de0d49ebebda..919e3cba071b 100644
> > --- a/lib/efi_loader/efi_capsule.c
> > +++ b/lib/efi_loader/efi_capsule.c
> > @@ -922,6 +922,105 @@ static bool device_is_present_and_system_part(str=
uct efi_device_path *dp)
> >       return true;
> >   }
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
> > +             EFI_CALL(efi_connect_controller(handle, NULL, NULL, true)=
);
>
> Which driver do you expect to connect here?
>
> > +
> > +             /* Align with edk2, issue a dummy read to the device to c=
heck the device change */
> > +             ret =3D EFI_CALL(efi_handle_protocol(handle, &efi_block_i=
o_guid, (void **)&block_io));
> > +             if (ret =3D=3D EFI_SUCCESS) {
> > +                     buffer =3D memalign(block_io->media->io_align, bl=
ock_io->media->block_size);
> > +                     if (buffer) {
> > +                             ret =3D EFI_CALL(block_io->read_blocks(bl=
ock_io,
> > +                                                                  bloc=
k_io->media->media_id,
> > +                                                                  0,
> > +                                                                  bloc=
k_io->media->block_size,
> > +                                                                  buff=
er));
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
>
> If you are looking for an ESP shouldn't you use the ESP GUID to find it?
> It is installed on the ESP in efi_status_t efi_disk_add_dev().
>
> Best regards
>
> Heinrich
>
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
> >   /**
> >    * find_boot_device - identify the boot device
> >    *
> > @@ -938,6 +1037,7 @@ static efi_status_t find_boot_device(void)
> >       int i, num;
> >       struct efi_simple_file_system_protocol *volume;
> >       struct efi_device_path *boot_dev =3D NULL;
> > +     struct efi_device_path *full_path =3D NULL;
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
> > +                                     goto found;
> > +                             } else {
> > +                                     efi_free_pool(boot_dev);
> > +                                     boot_dev =3D NULL;
> > +                             }
> >                       }
> >               }
> >       }
>
