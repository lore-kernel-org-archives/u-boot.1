Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59912D1CDCA
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 10:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3ABC83FBF;
	Thu,  4 Dec 2025 11:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DJFoVoM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A7F83FCD; Thu,  4 Dec 2025 11:25:28 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6612683AEF
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-787eb2d8663so11530817b3.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764843924; x=1765448724; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9/XNtRtxNhFxLHNSJ3Y0UkLQ2kQP6kgwpAn559Zv3k=;
 b=DJFoVoM08hcR5QE25XSd835/URbPPWqOriGtn6KzntTJFzkOe88VwO4/V8R0YkghwT
 pZxHxvuVxOqae6k9Cpnce922dWhlA7cMrweZu3XqjoGHw2x9/Q3QMpXeXODH0drXMXHI
 8/DLlWufZ4Z46lpvAhQ7HqpSXZDYkf8es79uChXQ6DxZvMIA8eRu70Id4nULygIVcD2C
 iN4DxrwVNBoGJD7UvonIpLjR+wLGHv15S+KnrV55nRJmnwTipFBx8SWGiTqhqlFieUSo
 Lb8NTiU6bulyUAGN2GtvIUd2A4P/GmVjnx9iZBWTDCi5Z1DQviXL+lyjkxj4Mz8PwEfr
 EcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764843924; x=1765448724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d9/XNtRtxNhFxLHNSJ3Y0UkLQ2kQP6kgwpAn559Zv3k=;
 b=lj3Bt/W+NhZXkWOwXSbNqXokWYYr+Fky+kwjulPnsAuCVup7Mkxi8ogPr/LZljVIv1
 x1F7zf6QAssNWJCxsofDaIcxZVjJnEgpwe2YGJMLPI06O00CUMslOzNXAtm8FTFwFRdN
 HBzRuKkRb9dfpUzLYv0po1TsEv0OIuHZcsSCdCUYeztJ9sXQs0HC+ZAT8KVqCX8GrgdK
 yga1p/COn8dh4iwcKHDVYmBeyrnRk7rdk50OAOrTpZ8Dbp0rlZ/3Q43mjMILAliFK+QT
 1b7F9ckXWw369D7zUZECmjT57k+jMyC5obXiquEP2F8TcGVLrAUJ+hRzHWlpxL4siMv5
 tBEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGXEVubnxBZA/E5Qx5xk4u/I07rnt1kp9C7BTye5/Iz5PHqgSD2dSJ4wedqtDX/b9GdqUo4Gg=@lists.denx.de
X-Gm-Message-State: AOJu0YwQy24mS4aVZGemAO5yMMkZ6unupOYeJ9cv+I7p+OCcvF6JuYR3
 yvFD1AUufbhBp742+4FbQVlZmkvU4o6mx1TkMOPTCZasaCUBoZkmszyRPu1gUzZXT8okOE69CkV
 y2glu7xQ1Il12WZHjxRBs1hOnAtKuqImlaNkJGu9+cQ==
X-Gm-Gg: ASbGnctyLYlWGupSB4UnuCOTR/SWL1mPMcorMHg53wugxH3zGaY3pectytjGHBhuA92
 +yS0haeKwBh586qQ49Xgmw/kwh/Uygg5czGJ6vxGVaRSK7dQNqx3HxPYfODegsWLTrrcSvSWE3R
 dlR7HMYKADAsOJvGIb/jLh9px+RHAs08S24/rhragqr61VDEIW7EIkPvOXPxLuUXoA7X9wTB+JN
 PITCvC1hnvhzQu0T4IWuYdbfkyyICy6wRpnnQSfwm755ZoX7yt4C7D8oDtbbvvuMdJoTFDtX+96
 X2FYFJCYTgfe+SN08q97lQuImIil/HK1iUyVO39A+m9DyqfNaCVTGgQgkg0Q7rxBD7lXdEnVKDx
 pOkzTPemeQENUY7TNUg==
X-Google-Smtp-Source: AGHT+IG0wEihOzKVfKknFIcdBn39kkaq03Zcg2jBJVbG577wsBVmG1dAmWt4y8guIQG8+k6fHjtQ8tG8vR3ZPkovL7w=
X-Received: by 2002:a05:690c:498f:b0:78a:9417:1eb9 with SMTP id
 00721157ae682-78c17163c4cmr21705037b3.5.1764843924081; Thu, 04 Dec 2025
 02:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20251202085101.1344799-1-ilias.apalodimas@linaro.org>
 <b52c69db-5663-42c7-b26a-6178c88815b6@oss.qualcomm.com>
In-Reply-To: <b52c69db-5663-42c7-b26a-6178c88815b6@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Dec 2025 12:24:47 +0200
X-Gm-Features: AWmQ_bn8Ie6abHNS3HtQ0VhG4k47xCPn5Z-kWcDIME-_3yCrEofu_gZfm9_mQJM
Message-ID: <CAC_iWjLu6+6MK2_MBNdURZjLv-99N7qubFRO_xCB8wmJEvJ45A@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Trigger capsule updates with automatically
 generated boot options
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: heinrich.schuchardt@canonical.com, John Toomey <john.toomey@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Yao Zi <ziyao@disroot.org>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Maks Mishin <maks.mishinfz@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de
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

Hi Baaji,

Thanks for testing, can you also send a reply with a tested-by: tag?
/Ilias

On Thu, 4 Dec 2025 at 06:42, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
>
> On 12/2/2025 2:20 PM, Ilias Apalodimas wrote:
> > The EFI spec in =C2=A78.5.5 says
> > "The directory \EFI\UpdateCapsule is checked for capsules only within
> >   the EFI system partition on the device specified in the active boot
> >   option determine by reference to BootNext variable or BootOrder varia=
ble
> >   processing."
> >
> > Automatically generated boot options don't point to the ESP, they point=
 to
> > the disk itself and find_handle() won't match when searching for an ESP
> > during a capsule update.
> > This happens because find_handle() only matches device paths that are
> > shorter or equal to the device path passed as an argument.
> > Since the EFI spec allows it we want to allow capsule updates, when the
> > boot option points to a disk, but that disk contains an ESP with a
> > \EFI\UpdateCapsule  directory.
> >
> > find_handle() implicitly changes it's behavior depending on the passed
> > arguments as well. If the 'rem' ptr is not valid it will only search fo=
r
> > an exact match. Otherwise it will match on the best match and return th=
e
> > remaining portion of the matched device path to 'rem'.
> >
> > Tweak this slightly and pass an enum with 3 options
> > - EXACT   - Exact match, as if 'rem' was NULL
> > - SHORTER - Match a shorter device path and put the remainder in 'rem'
> > - LONGER  - Inverse the logic and match a longer device path. Put the
> >              remainder into 'rem'.
> >
> > To avoid any regressions, LONGER is only used during capsule updates an=
d
> > since 'rem' always carries the remainder of the matched device path we
> > can plug it in with minimal changes.
> >
> > Reported-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > Reported-by: John Toomey <john.toomey@amd.com>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >
> > John, Balaji, can you check if this fixes your problem?
>
> Hi Ilias,
>
> Thanks for this patch. This fixes the problem and have verified the patch=
.
>
> Regards,
>
> Balaji
>
> >
> >   cmd/eficonfig.c                  |  2 +-
> >   include/efi_device_path.h        | 10 +++---
> >   lib/efi_loader/efi_bootmgr.c     |  6 ++--
> >   lib/efi_loader/efi_boottime.c    |  5 +--
> >   lib/efi_loader/efi_capsule.c     | 20 +++++++-----
> >   lib/efi_loader/efi_device_path.c | 55 +++++++++++++++++++++++++------=
-
> >   lib/efi_loader/efi_disk.c        |  2 +-
> >   7 files changed, 70 insertions(+), 30 deletions(-)
> >
> > diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> > index d8d946c87ac8..e317f3c90c14 100644
> > --- a/cmd/eficonfig.c
> > +++ b/cmd/eficonfig.c
> > @@ -1321,7 +1321,7 @@ static efi_status_t prepare_file_selection_entry(=
struct efimenu *efi_menu, char
> >               return EFI_OUT_OF_RESOURCES;
> >
> >       /* get the device name only when the user already selected the fi=
le path */
> > -     handle =3D efi_dp_find_obj(file_info->dp_volume, NULL, NULL);
> > +     handle =3D efi_dp_find_obj(file_info->dp_volume, NULL, NULL, fals=
e);
> >       if (handle) {
> >               ret =3D efi_disk_get_device_name(handle, devname, EFICONF=
IG_VOLUME_PATH_MAX);
> >               if (ret !=3D EFI_SUCCESS)
> > diff --git a/include/efi_device_path.h b/include/efi_device_path.h
> > index aae85228f681..f9c538730c94 100644
> > --- a/include/efi_device_path.h
> > +++ b/include/efi_device_path.h
> > @@ -73,13 +73,15 @@ struct efi_device_path *efi_dp_shorten(struct efi_d=
evice_path *dp);
> >    *
> >    * If @rem is provided, the handle with the longest partial match is =
returned.
> >    *
> > - * @dp:     device path to search
> > - * @guid:   GUID of protocol that must be installed on path or NULL
> > - * @rem:    pointer to receive remaining device path
> > + * @dp:                      device path to search
> > + * @guid:            GUID of protocol that must be installed on path o=
r NULL
> > + * @rem:             pointer to receive remaining device path
> > + * @inversed_match:  Match even if the dp is shorter. rem will stil ho=
ild the
> > + *                      remaining device path
> >    * Return:  matching handle
> >    */
> >   efi_handle_t efi_dp_find_obj(struct efi_device_path *dp, const efi_gu=
id_t *guid,
> > -                          struct efi_device_path **rem);
> > +                          struct efi_device_path **rem, bool inversed_=
match);
> >
> >   /**
> >    * efi_dp_last_node() - Determine the last device path node before th=
e end node
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.=
c
> > index a687f4d8e85c..df7500a94876 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -84,7 +84,8 @@ struct efi_device_path *expand_media_path(struct efi_=
device_path *device_path)
> >        * booting from removable media.
> >        */
> >       handle =3D efi_dp_find_obj(device_path,
> > -                              &efi_simple_file_system_protocol_guid, &=
rem);
> > +                              &efi_simple_file_system_protocol_guid, &=
rem,
> > +                              false);
> >       if (handle) {
> >               if (rem->type =3D=3D DEVICE_PATH_TYPE_END) {
> >                       char fname[30];
> > @@ -625,7 +626,8 @@ static efi_status_t try_load_from_media(struct efi_=
device_path *file_path,
> >       struct efi_device_path *rem, *dp =3D NULL;
> >       struct efi_device_path *final_dp =3D file_path;
> >
> > -     handle_blkdev =3D efi_dp_find_obj(file_path, &efi_block_io_guid, =
&rem);
> > +     handle_blkdev =3D efi_dp_find_obj(file_path, &efi_block_io_guid, =
&rem,
> > +                                     false);
> >       if (handle_blkdev) {
> >               if (rem->type =3D=3D DEVICE_PATH_TYPE_END) {
> >                       /* no file name present, try default file */
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottim=
e.c
> > index ddc935d22409..0391b92a8be4 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -1816,7 +1816,8 @@ efi_status_t efi_setup_loaded_image(struct efi_de=
vice_path *device_path,
> >       info->system_table =3D &systab;
> >
> >       if (device_path) {
> > -             info->device_handle =3D efi_dp_find_obj(device_path, NULL=
, NULL);
> > +             info->device_handle =3D efi_dp_find_obj(device_path, NULL=
, NULL,
> > +                                                   false);
> >
> >               dp =3D efi_dp_concat(device_path, file_path, 0);
> >               if (!dp) {
> > @@ -2016,7 +2017,7 @@ efi_status_t efi_load_image_from_path(bool boot_p=
olicy,
> >       *size =3D 0;
> >
> >       dp =3D file_path;
> > -     device =3D efi_dp_find_obj(dp, NULL, &rem);
> > +     device =3D efi_dp_find_obj(dp, NULL, &rem, false);
> >       ret =3D efi_search_protocol(device, &efi_simple_file_system_proto=
col_guid,
> >                                 NULL);
> >       if (ret =3D=3D EFI_SUCCESS)
> > diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.=
c
> > index eafc647f558f..103328c76a6e 100644
> > --- a/lib/efi_loader/efi_capsule.c
> > +++ b/lib/efi_loader/efi_capsule.c
> > @@ -886,18 +886,18 @@ static efi_status_t get_dp_device(u16 *boot_var,
> >    * @dp              device path
> >    * Return:  true - yes, false - no
> >    */
> > -static bool device_is_present_and_system_part(struct efi_device_path *=
dp)
> > +static bool device_is_present_and_system_part(struct efi_device_path *=
dp,
> > +                                           struct efi_device_path **re=
m)
> >   {
> >       efi_handle_t handle;
> > -     struct efi_device_path *rem;
> >
> >       /* Check device exists */
> > -     handle =3D efi_dp_find_obj(dp, NULL, NULL);
> > +     handle =3D efi_dp_find_obj(dp, NULL, NULL, false);
> >       if (!handle)
> >               return false;
> >
> >       /* Check device is on system partition */
> > -     handle =3D efi_dp_find_obj(dp, &efi_system_partition_guid, &rem);
> > +     handle =3D efi_dp_find_obj(dp, &efi_system_partition_guid, rem, t=
rue);
> >       if (!handle)
> >               return false;
> >
> > @@ -919,7 +919,7 @@ static efi_status_t find_boot_device(void)
> >       efi_uintn_t size;
> >       int i, num;
> >       struct efi_simple_file_system_protocol *volume;
> > -     struct efi_device_path *boot_dev =3D NULL;
> > +     struct efi_device_path *boot_dev =3D NULL, *rem =3D NULL;
> >       efi_status_t ret;
> >
> >       /* find active boot device in BootNext */
> > @@ -940,7 +940,7 @@ static efi_status_t find_boot_device(void)
> >
> >               ret =3D get_dp_device(boot_var16, &boot_dev);
> >               if (ret =3D=3D EFI_SUCCESS) {
> > -                     if (device_is_present_and_system_part(boot_dev)) =
{
> > +                     if (device_is_present_and_system_part(boot_dev, &=
rem)) {
> >                               goto found;
> >                       } else {
> >                               efi_free_pool(boot_dev);
> > @@ -967,7 +967,7 @@ skip:
> >               if (ret !=3D EFI_SUCCESS)
> >                       continue;
> >
> > -             if (device_is_present_and_system_part(boot_dev))
> > +             if (device_is_present_and_system_part(boot_dev, &rem))
> >                       break;
> >
> >               efi_free_pool(boot_dev);
> > @@ -977,7 +977,11 @@ found:
> >       if (boot_dev) {
> >               log_debug("Boot device %pD\n", boot_dev);
> >
> > -             volume =3D efi_fs_from_path(boot_dev);
> > +             if (rem->type =3D=3D DEVICE_PATH_TYPE_END)
> > +                     volume =3D efi_fs_from_path(boot_dev);
> > +             else
> > +                     volume =3D efi_fs_from_path(rem);
> > +
> >               if (!volume)
> >                       ret =3D EFI_DEVICE_ERROR;
> >               else
> > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devi=
ce_path.c
> > index b3fb20b2501e..ad7f452c411b 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -30,6 +30,12 @@ const struct efi_device_path EFI_DP_END =3D {
> >       .length   =3D sizeof(EFI_DP_END),
> >   };
> >
> > +enum match {
> > +     EXACT,
> > +     SHORTER,
> > +     LONGER
> > +};
> > +
> >   #if defined(CONFIG_MMC)
> >   /*
> >    * Determine if an MMC device is an SD card.
> > @@ -109,10 +115,11 @@ struct efi_device_path *efi_dp_shorten(struct efi=
_device_path *dp)
> >    */
> >   static efi_handle_t find_handle(struct efi_device_path *dp,
> >                               const efi_guid_t *guid, bool short_path,
> > -                             struct efi_device_path **rem)
> > +                             struct efi_device_path **rem,
> > +                             enum match match)
> >   {
> >       efi_handle_t handle, best_handle =3D NULL;
> > -     efi_uintn_t len, best_len =3D 0;
> > +     efi_uintn_t len, match_len =3D 0, best_len =3D 0;
> >
> >       len =3D efi_dp_instance_size(dp);
> >
> > @@ -137,22 +144,35 @@ static efi_handle_t find_handle(struct efi_device=
_path *dp,
> >                       if (!dp_current)
> >                               continue;
> >               }
> > -             len_current =3D efi_dp_instance_size(dp_current);
> > -             if (rem) {
> > +
> > +             match_len =3D len_current =3D efi_dp_instance_size(dp_cur=
rent);
> > +             switch (match) {
> > +             case EXACT:
> > +                     if (len_current !=3D len)
> > +                             continue;
> > +                     break;
> > +             case SHORTER:
> >                       if (len_current > len)
> >                               continue;
> > -             } else {
> > -                     if (len_current !=3D len)
> > +                     break;
> > +             case LONGER:
> > +                     if (len_current < len)
> >                               continue;
> > +                     match_len =3D len;
> > +                     break;
> >               }
> > -             if (memcmp(dp_current, dp, len_current))
> > +
> > +             if (memcmp(dp_current, dp, match_len))
> >                       continue;
> >               if (!rem)
> >                       return handle;
> >               if (len_current > best_len) {
> >                       best_len =3D len_current;
> >                       best_handle =3D handle;
> > -                     *rem =3D (void*)((u8 *)dp + len_current);
> > +                     if (len_current <=3D len)
> > +                             *rem =3D (void *)((uintptr_t)dp + len_cur=
rent);
> > +                     else
> > +                             *rem =3D (void *)((uintptr_t)dp_current +=
 match_len);
> >               }
> >       }
> >       return best_handle;
> > @@ -160,14 +180,25 @@ static efi_handle_t find_handle(struct efi_device=
_path *dp,
> >
> >   efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
> >                            const efi_guid_t *guid,
> > -                          struct efi_device_path **rem)
> > +                          struct efi_device_path **rem, bool inversed_=
match)
> >   {
> >       efi_handle_t handle;
> >
> > -     handle =3D find_handle(dp, guid, false, rem);
> > +     handle =3D find_handle(dp, guid, false, rem, EXACT);
> >       if (!handle)
> > -             /* Match short form device path */
> > -             handle =3D find_handle(dp, guid, true, rem);
> > +             handle =3D find_handle(dp, guid, true, rem, EXACT);
> > +     if (handle)
> > +             return handle;
> > +
> > +     handle =3D find_handle(dp, guid, false, rem, SHORTER);
> > +     if (!handle)
> > +             handle =3D find_handle(dp, guid, true, rem, SHORTER);
> > +
> > +     if (inversed_match && !handle) {
> > +             handle =3D find_handle(dp, guid, false, rem, LONGER);
> > +             if (!handle)
> > +                     handle =3D find_handle(dp, guid, true, rem, LONGE=
R);
> > +     }
> >
> >       return handle;
> >   }
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index 130c4db9606f..0d3d7c187d72 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path)
> >       efi_free_pool(file_path);
> >
> >       /* Get the EFI object for the partition */
> > -     efiobj =3D efi_dp_find_obj(device_path, NULL, NULL);
> > +     efiobj =3D efi_dp_find_obj(device_path, NULL, NULL, false);
> >       efi_free_pool(device_path);
> >       if (!efiobj)
> >               return NULL;
> > --
> > 2.51.0
> >
