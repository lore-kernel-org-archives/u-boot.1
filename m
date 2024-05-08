Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F464C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A247488321;
	Wed,  8 May 2024 16:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FRo4g5cy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A40988380; Wed,  8 May 2024 16:17:02 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688C5882FE
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so1545808a12.0
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715177820; x=1715782620; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nb7d9rYpU/QO1zujKYjUw8VOdStbVMTVm9TNYC7zCkk=;
 b=FRo4g5cy/DZUQtqg0RcoHLmV5MRifHkKhiClRxgTP9Di50mzn6+Hro9oDjKVX99h/U
 lOgegpjIifsum7sF1yD2qEvj5iTu5lOW57TZhpvTHvxaXRNDN8VTv4wuRecEd5veGBen
 wHGw0UBn0Y6myclm/WYDJfWspjlzV5pkdFGBaS0dTdisVLSIO6/Oytu82pplJYaGpzDZ
 6836Uam2NK7ufoPsMc3PftIlySeibL+568o+suoFu6r1wdMtpy9RZqQutOOreNfQeJkr
 WMTc44zrqw0LExh/kCW4+Er//GKnRfgyW76LsNaQ8ID73tQSL5L45OTrjdD/CDk5iyXd
 bFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715177820; x=1715782620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nb7d9rYpU/QO1zujKYjUw8VOdStbVMTVm9TNYC7zCkk=;
 b=L8xbyPgeB1sr1jSem1Zfm9SQ6S5mQ52a/lsoiZpqd8NIYPM5+BV8knbTd3rzMQ9f3u
 3PEmneN8I+cdPJFv2ziAcJaX7nq5CgWt4ARgStuMS0Bt2R+zKlnNV57C4ZoLUj+3eqTP
 4EGMQgGpzgjulXHneh4qc/B5eqdUEVkAmJ3yepJQbN+b4fXMXKvERMq6Uy1i4BOAbitA
 tIIb5hKl8kN5J8O9nPJIiVb2BFrOv/oo+nOoRJEjkpYGVKYVHqLCMOOvYU5wET0x00p6
 3sNXjMFVqUlfScSa6v0gDL32sw0aDrkTJDCVV53P6fuiAGEHxqbd9b7UFcXIr7JYrgIu
 aPUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB7IX8ZrdFEOo0lFIBt2BPFOKDbK2GB77yTdAyIicw0SqHvvqteoOcgmIz8b6ykfk5DwPsFHRe9nQN/KOMwDOTIUP7FA==
X-Gm-Message-State: AOJu0YxKv3/j1AhNCawEUZnC7WBFGmq441ni547eKX2KkKjZY7sMW4r9
 6OkyE6kmHCK5v9VQDEKu01n/6mx6i1T2Fvac3UbVlERD6eqaEOwnuiegVd8WPzwWugkglnhkYFd
 RkQLi9Ys6EPrapvKNQoeekrEYP/g=
X-Google-Smtp-Source: AGHT+IHLQZ3HD2NAN7AsH7inx0R/nMSz0yT3NXNavu68Mrw8sQKimNawIYm45aMX+dOxWDuFWwNHtzcYImpNpGS3TEE=
X-Received: by 2002:a50:870c:0:b0:572:a049:c797 with SMTP id
 4fb4d7f45d1cf-5731d86262bmr2369772a12.12.1715177819482; Wed, 08 May 2024
 07:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240508112401.155528-1-o451686892@gmail.com>
 <CAC_iWjLv8cdL-zUfYA+7GAtY=xHOHN6kJmg7gOFdbCmpPoiB5A@mail.gmail.com>
 <CAC_iWj+oxsNrzPPANvCK86Pq8eGKO7dqOSobBWzwNaTBVS-2tg@mail.gmail.com>
In-Reply-To: <CAC_iWj+oxsNrzPPANvCK86Pq8eGKO7dqOSobBWzwNaTBVS-2tg@mail.gmail.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 8 May 2024 22:16:47 +0800
Message-ID: <CAHk0HouNZqh4daP9yy2AXJptp1k79mLkZwRiqGG5xzspesDwGA@mail.gmail.com>
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

On Wed, May 8, 2024 at 9:56=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> >
> > > + *
> > > + * Get a possible efi system partition by expanding a boot option
> > > + * file path.
> > > + *
> > > + * @boot_dev   The device path pointing to a boot option
> > > + * Return:     The full ESP device path or NULL if fail
> > > + */
> > > +static struct efi_device_path *get_esp_from_boot_option_file_path(st=
ruct efi_device_path *boot_dev)
> > > +{
> > > +       efi_status_t ret =3D EFI_SUCCESS;
> > > +       efi_handle_t handle;
> > > +       struct efi_device_path *dp =3D boot_dev;
> > > +       struct efi_device_path *full_path =3D NULL;
> > > +
> > > +       ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_file_syst=
em_protocol_guid,
> > > +                                             &dp,
> > > +                                             &handle));
> > > +       if (ret !=3D EFI_SUCCESS)
> > > +               ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io=
_guid, &dp, &handle));
> > > +
> > > +       /* Expand Media Device Path */
> >
> > I don't see where the device path is expanded in this patch.
> > We already have try_load_from_media() which tries to do something
> > similar. Is anything missing from there?
>
> Looking a bit closer, we do lack calling ConnectController there, but
> all this should be added to try_load_from_media() not in a different
> path.

Yeah, I'll summarize them to the try_load_from_media().

> Also I don't think we need the Fixes tag

Okay.

BR,
Weizhao

>
> Thanks
> /Ilias
> >
> > > +       if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(dp, END, END)) {
> >
> > Can you invert the logic here and return immediately?
> > (if ret !=3D EFI_SUCCESS ...etc )
> >     return full_path;
> >
> > The indentation will go away.
> >
> > > +               struct efi_device_path *temp_dp;
> > > +               struct efi_block_io *block_io;
> > > +               void *buffer;
> > > +               efi_handle_t *simple_file_system_handle;
> > > +               efi_uintn_t number_handles, index;
> > > +               u32 size;
> > > +               u32 temp_size;
> > > +
> > > +               temp_dp =3D boot_dev;
> > > +               ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_f=
ile_system_protocol_guid,
> > > +                                                     &temp_dp,
> > > +                                                     &handle));
> > > +               /*
> > > +                * For device path pointing to simple file system, it=
 only expands to one
> > > +                * full path
> >
> > Why do we have multiple calls to efi_locate_device_path()? Aren't the
> > arguments identical?
> > Which part of edk2 did you read? Is it BmExpandMediaDevicePath()?
> >
> >
> > > +                */
> > > +               if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(temp_dp, EN=
D, END)) {
> > > +                       if (device_is_present_and_system_part(temp_dp=
))
> > > +                               return temp_dp;
> > > +               }
> > > +
> > > +               /*
> > > +                * For device path only pointing to the removable dev=
ice handle, try to
> > > +                * search all its children handles
> > > +                */
> > > +               ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io=
_guid, &temp_dp, &handle));
> > > +               EFI_CALL(efi_connect_controller(handle, NULL, NULL, t=
rue));
> > > +
> > > +               /* Align with edk2, issue a dummy read to the device =
to check the device change */
> > > +               ret =3D EFI_CALL(efi_handle_protocol(handle, &efi_blo=
ck_io_guid, (void **)&block_io));
> > > +               if (ret =3D=3D EFI_SUCCESS) {
> > > +                       buffer =3D memalign(block_io->media->io_align=
, block_io->media->block_size);
> > > +                       if (buffer) {
> > > +                               ret =3D EFI_CALL(block_io->read_block=
s(block_io,
> > > +                                                                    =
block_io->media->media_id,
> > > +                                                                    =
0,
> > > +                                                                    =
block_io->media->block_size,
> > > +                                                                    =
buffer));
> > > +                               free(buffer);
> > > +                       } else {
> > > +                               return full_path;
> > > +                       }
> > > +               } else {
> > > +                       return full_path;
> > > +               }
> > > +
> > > +               /* detect the default boot file from removable media =
*/
> > > +               size =3D efi_dp_size(boot_dev) - sizeof(struct efi_de=
vice_path);
> > > +               EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
> > > +                                                 &efi_simple_file_sy=
stem_protocol_guid,
> > > +                                                 NULL,
> > > +                                                 &number_handles,
> > > +                                                 &simple_file_system=
_handle));
> > > +               for (index =3D 0; index < number_handles; index++) {
> > > +                       EFI_CALL(efi_handle_protocol(simple_file_syst=
em_handle[index],
> > > +                                                    &efi_guid_device=
_path,
> > > +                                                    (void **)&temp_d=
p));
> > > +
> > > +                       log_debug("Search ESP %pD\n", temp_dp);
> > > +                       temp_size =3D efi_dp_size(temp_dp) - sizeof(s=
truct efi_device_path);
> > > +                       if (size <=3D temp_size && !memcmp(temp_dp, b=
oot_dev, size)) {
> > > +                               if (device_is_present_and_system_part=
(temp_dp)) {
> > > +                                       efi_free_pool(simple_file_sys=
tem_handle);
> > > +                                       return temp_dp;
> > > +                               }
> > > +                       }
> > > +               }
> > > +
> > > +               if (simple_file_system_handle)
> > > +                       efi_free_pool(simple_file_system_handle);
> > > +       }
> > > +
> > > +       return full_path;
> > > +}
> > > +
> > >  /**
> > >   * find_boot_device - identify the boot device
> > >   *
> > > @@ -938,6 +1037,7 @@ static efi_status_t find_boot_device(void)
> > >         int i, num;
> > >         struct efi_simple_file_system_protocol *volume;
> > >         struct efi_device_path *boot_dev =3D NULL;
> > > +       struct efi_device_path *full_path =3D NULL;
> > >         efi_status_t ret;
> > >
> > >         /* find active boot device in BootNext */
> > > @@ -961,8 +1061,14 @@ static efi_status_t find_boot_device(void)
> > >                         if (device_is_present_and_system_part(boot_de=
v)) {
> > >                                 goto found;
> > >                         } else {
> > > -                               efi_free_pool(boot_dev);
> > > -                               boot_dev =3D NULL;
> > > +                               full_path =3D get_esp_from_boot_optio=
n_file_path(boot_dev);
> > > +                               if (full_path) {
> > > +                                       boot_dev =3D full_path;
> > > +                                       goto found;
> > > +                               } else {
> > > +                                       efi_free_pool(boot_dev);
> > > +                                       boot_dev =3D NULL;
> > > +                               }
> > >                         }
> > >                 }
> > >         }
> > > --
> > > 2.40.1
> > >
> >
> > Thanks
> > /Ilias
