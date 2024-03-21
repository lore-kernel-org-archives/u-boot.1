Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0344C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 13:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B21787EFA;
	Thu, 21 Mar 2024 14:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GwoGmm4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FEA687EFA; Thu, 21 Mar 2024 13:20:01 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752D987CB7
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 13:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=colinmca242@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a4715d4c2cbso59428266b.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711023598; x=1711628398; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uq4X17sZ/wAz2gf9yIYkXLE7HrGocB2MWC+eG7t/3/E=;
 b=GwoGmm4OKZa4EHp+366stp1vUN8+0Szo02YnthE+6LgPmHVNk1Is+LiejXMXsjLxpK
 2gfjOgmcR7M4RWVTZnJG18PR+cz/R8NK2eS+y7HPKmltaN+cABX5tyyxaYX4UZcsgfl+
 K83KDqx0TO0+SuYdhywCmgIuzs/qO4GMMwJipuLZtwFTfq4FJbHGbll2pijgcClsln2j
 qnwLpqz4jAYtdc8aIeeWHGhqdDn3nFmc9kIFEBYVfZT6E+HVlTt3A2Ts4vfljEEEPXNT
 4XqpLgaUN6ULUhr+FhTKFcvrvEMi94d49WOG6r8wP9PN9A2dEVCDS04imzhFxqEr0KbR
 8A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711023598; x=1711628398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uq4X17sZ/wAz2gf9yIYkXLE7HrGocB2MWC+eG7t/3/E=;
 b=hF0XtBwLSHkaYD0IaO3I64ceCNIjF4rtQ3U46KbZcgaL459mR31e0b+wDlhbbJ3BQo
 eqf6JA1vGm5dSOq7CE9KWFDBoX2U6T7i5yjbBeRUpfhB8AqIAWiYlmPua9974aDKhtW2
 RoYZ6piKOXMZrOWak071/nNFdHOzzQqXhKuDtdIMYMvBrUI8icwibrleOVU+Iwbz/r9L
 Zdcl0n1WxijIUBiNIQo/ZTU2mtB1IxAzpDkuHMxa03572tMZGzvNz8VxYdM4Kw5TmYUo
 HmQoF1eaADPLd7vJI9kLGjZnZjPpFHIK6qluC9GGs1yEA7Z/c4FcFIDNlhqo1uIJFrCK
 vf3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKgzXnYbegpy0j/NLgsRB7u3U9ut1OsvFA78tHWN/tH3p4BcoP9ciflK0kMLTPcl/EHzWV5NYmr/g820AnLDqdHroArA==
X-Gm-Message-State: AOJu0YzWOJz7yiwdTjeA4A9gaFj8cshv7k4po4bi8bYemRVgGbXxPIGK
 MQzhqDMWHa85bvdhTth/02Ja5fJZzg6k664tB94+K6dr+qiVL9K47JQu5H3SI6uC5PYJoFnBqVY
 CRVvJMRw2rwKYrRDVnDQP5lHHIOg=
X-Google-Smtp-Source: AGHT+IH6IVhsDlXDiBmUM57j2Juh8nODfn0iFkxoy/t4aTsBkyYHguLJR7RUMTAuBDDTmSbrXKL00BQrrCxunUC97XA=
X-Received: by 2002:a17:907:2d2a:b0:a46:df55:e238 with SMTP id
 gs42-20020a1709072d2a00b00a46df55e238mr5775129ejc.44.1711023597683; Thu, 21
 Mar 2024 05:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240312125729.82695-1-colinmca242@gmail.com>
 <20240312125729.82695-3-colinmca242@gmail.com>
 <87jzm74gw4.fsf@baylibre.com>
 <CAByghJZjX863HRWbK7U5PPmaQ_vcuuBN9r+tqEqV7h3sL4HuFg@mail.gmail.com>
 <87cyronda9.fsf@baylibre.com>
In-Reply-To: <87cyronda9.fsf@baylibre.com>
From: Colin <colinmca242@gmail.com>
Date: Thu, 21 Mar 2024 07:19:47 -0500
Message-ID: <CAAyLwgQx7+VdLfSzDKMs1QQpwrdHyqUBqgybb6rTm1tjdm45rA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Colin McAllister <colin.mcallister@garmin.com>, JPEWhacker@gmail.com,
 sjg@chromium.org, Sam Protsenko <semen.protsenko@linaro.org>
X-Mailman-Approved-At: Thu, 21 Mar 2024 14:04:30 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Mattijs,

Sorry, I did not realize there were outstanding issues for me to address. I
would be happy to send a v5, but if you doing the fixups gets this merged
quicker, that sounds better to me.

Happy to contribute,
*_____________________*
*Colin McAllister*


On Thu, Mar 21, 2024 at 4:29=E2=80=AFAM Mattijs Korpershoek <
mkorpershoek@baylibre.com> wrote:

> Hi Colin,
>
> Since both below remarks are minor nitpicks, I can also do them when
> applying (to avoid delaying this series too much).
>
> Please le me know what you prefer:
> 1. You send a v5 at your convience
> 2. I do the minor fixups and I merge right away.
>
> Again, thank you for doing your first U-Boot contributions!
>
> Mattijs
>
> On mer., mars 13, 2024 at 18:22, Igor Opaniuk <igor.opaniuk@gmail.com>
> wrote:
>
> > Hi Colin,
> >
> > On Tue, Mar 12, 2024 at 4:19=E2=80=AFPM Mattijs Korpershoek <
> > mkorpershoek@baylibre.com> wrote:
> >
> >> Hi Colin,
> >>
> >> Thank you for the patch.
> >>
> >> On mar., mars 12, 2024 at 07:57, Colin McAllister <
> colinmca242@gmail.com>
> >> wrote:
> >>
> >> Sam also gave his review here:
> >>
> >>
> https://lore.kernel.org/all/CAPLW+4kHmPtfACyND4Vc2p0ZrsyGY=3D+bRU=3Dfdub4=
K1uX5p33Jw@mail.gmail.com/
> >>
> >> Please include his review tag in the next submission.
> >>
> >> I will add it at the appropriate place below:
> >>
> >>
> >> > From: Colin McAllister <colin.mcallister@garmin.com>
> >> >
> >> > Currently, setting CONFIG_AB_BACKUP_OFFSET in a target's defconfig
> will
> >> > not actually enable the #if protected code in android_ab.c. This is
> >> > because "CONFIG_" should have been prepended to the config macro, or
> the
> >> > macros defined in kconfig.h could have been used.
> >> >
> >> > The code included by ANDROID_AB_BACKUP_OFFSET has been refactored to
> no
> >> > longer be conditionally compiled by preprocessor conditionals and
> >> > instead use C conditionals. This better aligns with the Linux kernel
> >> > style guide.
> >> >
> >> > Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
> >> > Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
> >> > Cc: Joshua Watt <JPEWhacker@gmail.com>
> >> > Cc: Simon Glass <sjg@chromium.org>
> >> > Signed-off-by: Colin McAllister <colinmca242@gmail.com>
> >> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> >>
> >> > ---
> >> > v2:
> >> >   - Replaced #if conditionals with C if conditionals
> >> >   - Opted to use CONFIG_ANDROID_AB_BACKUP_OFFSET directly instead of
> >> >     macros in kconfig.h as CONFIG_ANDROID_AB_BACKUP_OFFSET is not a
> >> >       boolean or tristate value and doesn't have different values wh=
en
> >> >       building SPL or TPL.
> >> > v3:
> >> >   - Added "Fixes:" tag
> >> > v4:
> >> >   - No changes
> >> >
> >> >  boot/android_ab.c | 97
> ++++++++++++++++++++++-------------------------
> >> >  1 file changed, 45 insertions(+), 52 deletions(-)
> >> >
> >> > diff --git a/boot/android_ab.c b/boot/android_ab.c
> >> > index 9a3d15ec60..f547aa64e4 100644
> >> > --- a/boot/android_ab.c
> >> > +++ b/boot/android_ab.c
> >> > @@ -187,13 +187,12 @@ int ab_select_slot(struct blk_desc *dev_desc,
> >> struct disk_partition *part_info,
> >> >                  bool dec_tries)
> >> >  {
> >> >       struct bootloader_control *abc =3D NULL;
> >> > +     struct bootloader_control *backup_abc =3D NULL;
> >> >       u32 crc32_le;
> >> >       int slot, i, ret;
> >> >       bool store_needed =3D false;
> >> > +     bool valid_backup =3D false;
> >> >       char slot_suffix[4];
> >> > -#if ANDROID_AB_BACKUP_OFFSET
> >> > -     struct bootloader_control *backup_abc =3D NULL;
> >> > -#endif
> >> >
> >> >       ret =3D ab_control_create_from_disk(dev_desc, part_info, &abc,=
 0);
> >> >       if (ret < 0) {
> >> > @@ -205,53 +204,49 @@ int ab_select_slot(struct blk_desc *dev_desc,
> >> struct disk_partition *part_info,
> >> >               return ret;
> >> >       }
> >> >
> >> > -#if ANDROID_AB_BACKUP_OFFSET
> >> > -     ret =3D ab_control_create_from_disk(dev_desc, part_info,
> &backup_abc,
> >> > -                                       ANDROID_AB_BACKUP_OFFSET);
> >> > -     if (ret < 0) {
> >> > -             free(abc);
> >> > -             return ret;
> >> > +     if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> >> > +             ret =3D ab_control_create_from_disk(dev_desc, part_inf=
o,
> >> &backup_abc,
> >> > +
> >>  CONFIG_ANDROID_AB_BACKUP_OFFSET);
> >> > +             if (ret < 0) {
> >> > +                     free(abc);
> >> > +                     return ret;
> >> > +             }
> >> >       }
> >> > -#endif
> >> >
> >> >       crc32_le =3D ab_control_compute_crc(abc);
> >> >       if (abc->crc32_le !=3D crc32_le) {
> >> >               log_err("ANDROID: Invalid CRC-32 (expected %.8x, found
> >> %.8x),",
> >> >                       crc32_le, abc->crc32_le);
> >> > -#if ANDROID_AB_BACKUP_OFFSET
> >> > -             crc32_le =3D ab_control_compute_crc(backup_abc);
> >> > -             if (backup_abc->crc32_le !=3D crc32_le) {
> >> > -                     log_err("ANDROID: Invalid backup CRC-32 ");
> >> > -                     log_err("expected %.8x, found %.8x),",
> >> > -                             crc32_le, backup_abc->crc32_le);
> >> > -#endif
> >> > -
> >> > -                     log_err("re-initializing A/B metadata.\n");
> >> > +             if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> >> > +                     crc32_le =3D ab_control_compute_crc(backup_abc=
);
> >> > +                     if (backup_abc->crc32_le !=3D crc32_le) {
> >> > +                             log_err(" ANDROID: Invalid backup CRC-=
32
> >> ");
> >> > +                             log_err("(expected %.8x, found %.8x),"=
,
> >> > +                                     crc32_le, backup_abc->crc32_le=
);
> >> > +                     } else {
> >> > +                             valid_backup =3D true;
> >> > +                             log_info(" copying A/B metadata from
> >> backup.\n");
> >> > +                             memcpy(abc, backup_abc, sizeof(*abc));
> >> > +                     }
> >> > +             }
> >> >
> >> > +             if (!valid_backup) {
> >> > +                     log_err(" re-initializing A/B metadata.\n");
> >> >                       ret =3D ab_control_default(abc);
> >> >                       if (ret < 0) {
> >> > -#if ANDROID_AB_BACKUP_OFFSET
> >> > -                             free(backup_abc);
> >> > -#endif
> >> > +                             if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> >> > +                                     free(backup_abc);
> >> >                               free(abc);
> >> >                               return -ENODATA;
> >> >                       }
> >> > -#if ANDROID_AB_BACKUP_OFFSET
> >> > -             } else {
> >> > -                     /*
> >> > -                      * Backup is valid. Copy it to the primary
> >> > -                      */
> >> > -                     memcpy(abc, backup_abc, sizeof(*abc));
> >> >               }
> >> > -#endif
> >> >               store_needed =3D true;
> >> >       }
> >> >
> >> >       if (abc->magic !=3D BOOT_CTRL_MAGIC) {
> >> >               log_err("ANDROID: Unknown A/B metadata: %.8x\n",
> >> abc->magic);
> >> > -#if ANDROID_AB_BACKUP_OFFSET
> >> > -             free(backup_abc);
> >> > -#endif
> >> > +             if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> >> > +                     free(backup_abc);
> >> >               free(abc);
> >> >               return -ENODATA;
> >> >       }
> >> > @@ -259,9 +254,8 @@ int ab_select_slot(struct blk_desc *dev_desc,
> struct
> >> disk_partition *part_info,
> >> >       if (abc->version > BOOT_CTRL_VERSION) {
> >> >               log_err("ANDROID: Unsupported A/B metadata version:
> >> %.8x\n",
> >> >                       abc->version);
> >> > -#if ANDROID_AB_BACKUP_OFFSET
> >> > -             free(backup_abc);
> >> > -#endif
> >> > +             if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> >> > +                     free(backup_abc);
> >> >               free(abc);
> >> >               return -ENODATA;
> >> >       }
> >> > @@ -338,30 +332,29 @@ int ab_select_slot(struct blk_desc *dev_desc,
> >> struct disk_partition *part_info,
> >> >               abc->crc32_le =3D ab_control_compute_crc(abc);
> >> >               ret =3D ab_control_store(dev_desc, part_info, abc, 0);
> >> >               if (ret < 0) {
> >> > -#if ANDROID_AB_BACKUP_OFFSET
> >> > -                     free(backup_abc);
> >> > -#endif
> >> > +                     if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> >> > +                             free(backup_abc);
> >> >                       free(abc);
> >> >                       return ret;
> >> >               }
> >> >       }
> >> >
> >> > -#if ANDROID_AB_BACKUP_OFFSET
> >> > -     /*
> >> > -      * If the backup doesn't match the primary, write the primary
> >> > -      * to the backup offset
> >> > -      */
> >> > -     if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
> >> > -             ret =3D ab_control_store(dev_desc, part_info, abc,
> >> > -                                    ANDROID_AB_BACKUP_OFFSET);
> >> > -             if (ret < 0) {
> >> > -                     free(backup_abc);
> >> > -                     free(abc);
> >> > -                     return ret;
> >> > +     if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> >> > +             /*
> >> > +             * If the backup doesn't match the primary, write the
> >> primary
> >> > +             * to the backup offset
> >> > +             */
> >>
> >> checkpatch.pl seems to complain about this comment block:
> >>
> >> WARNING: Block comments should align the * on each line
> >> #166: FILE: boot/android_ab.c:344:
> >> +               /*
> >> +               * If the backup doesn't match the primary, write the
> >> primary
> >>
> >> To reproduce, run:
> >>
> >> $ ./scripts/checkpatch.pl --strict --u-boot --git HEAD^..HEAD
> >>
> >> With the above addressed, please send a v5 including:
> >>
> >> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >>
> >> > +             if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
> >> > +                     ret =3D ab_control_store(dev_desc, part_info, =
abc,
> >> > +
> >> CONFIG_ANDROID_AB_BACKUP_OFFSET);
> >> > +                     if (ret < 0) {
> >> > +                             free(backup_abc);
> >> > +                             free(abc);
> >> > +                             return ret;
> >> > +                     }
> >> >               }
> >> > +             free(backup_abc);
> >> >       }
> >> > -     free(backup_abc);
> >> > -#endif
> >> >
> >> >       free(abc);
> >> >
> >> > --
> >> > 2.34.1
> >>
> >
> > With Mattijs comment addressed:
> > Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> >
> > --
> > Best regards - Atentamente - Meilleures salutations
> >
> > Igor Opaniuk
> >
> > mailto: igor.opaniuk@gmail.com
> > skype: igor.opanyuk
> > https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniu=
k
> >
>
