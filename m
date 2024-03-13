Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A2EC54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 17:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 021B38709C;
	Wed, 13 Mar 2024 18:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bQ16g05x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1518D8709C; Wed, 13 Mar 2024 18:22:22 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E45487150
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 18:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e972c8b67so2697f8f.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710350538; x=1710955338; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PY+yg4DzmhzJwqFulo3ExO3K58oPFTwuyi+CVyni1Co=;
 b=bQ16g05xluM7u8D+tf/8g1dq+5M1/VKngfaq1oHVMZSonYsK/ZStmUaOjKy7mKjIa1
 E6yAFH0LTloagIQ79Ws4pwNHOnr7duiFyhE13n4n9Zpl3mNmXHEZ5rblAHxfY35fFE68
 KpJoGhQd68VkV+8r/RMB/lg2OBWC/NPY0JHlJ08WNk1c4qvBuT68aOEcxH5Uylrva40s
 ogmjjd/fxhnKYdXc+BOdCaNTXcTmfo7PDFtMWIItOE5vJgpujE4f7ycUZId2VwOvrudL
 7ILP9RKyIEXA0T7iGby51JJjyBk25GNquzT0XoXTNdxhZJhYiE9umbd6blUKpb07MrNi
 ZIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710350538; x=1710955338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PY+yg4DzmhzJwqFulo3ExO3K58oPFTwuyi+CVyni1Co=;
 b=qVq81dS9zw/g8LZS1SfUIzj4o/N8WjdHX1PIW8CeoIuOz4PUh9Pfzu3BEEbYnv32cb
 TwnxhKqXP9fvz5jfRaQTtxytXw6oDGt44riUAFzjAAP05bHWIOBJ99y+xJOSIkDWBnG+
 sfLIqVPP/efHcmoqXaNbdpC+NChETOdNBgALWeRO/te50KW2C465hgmAS9ajIievsmbR
 zFl0h4AwzQXF3Tl1Cabox/UqpRzNrqMz0A4inyeyqmWPNyJcGUYMhuXn1qLw/eU5jBgG
 Vtgvy9LkcWlTKxWOn+w3Ls1rnN52iKj+mPbxmme+6vtObZ303Syr4JpNDe8PuC0He4Gv
 BOUA==
X-Gm-Message-State: AOJu0YwIuf/uCW0wgzeoy+MB5f6o1yHNe82p9FONp5ko2I0KajSEDEst
 AZUzwTPjkpcAfxc9RCGo8M7c/K4N5XIH+ZTNZOl94CWIaxUkQTokMFyATyRPCsst+ukxZ4AQ2B/
 LYT+R0IJXYpyOr40JmktXYa6LyRM=
X-Google-Smtp-Source: AGHT+IGDDS06tmJHszayI12fvx3iYL+az8IiDuR3SyS48UkoMdoxPhKBHhAvFpmjezoUhONbo2b4gR1+xmrs/6r6PdY=
X-Received: by 2002:a5d:500c:0:b0:33e:7077:4b57 with SMTP id
 e12-20020a5d500c000000b0033e70774b57mr8943749wrt.1.1710350537917; Wed, 13 Mar
 2024 10:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240312125729.82695-1-colinmca242@gmail.com>
 <20240312125729.82695-3-colinmca242@gmail.com>
 <87jzm74gw4.fsf@baylibre.com>
In-Reply-To: <87jzm74gw4.fsf@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 13 Mar 2024 18:22:06 +0100
Message-ID: <CAByghJZjX863HRWbK7U5PPmaQ_vcuuBN9r+tqEqV7h3sL4HuFg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
To: Colin McAllister <colinmca242@gmail.com>
Cc: u-boot@lists.denx.de, Colin McAllister <colin.mcallister@garmin.com>,
 JPEWhacker@gmail.com, 
 sjg@chromium.org, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

Hi Colin,

On Tue, Mar 12, 2024 at 4:19=E2=80=AFPM Mattijs Korpershoek <
mkorpershoek@baylibre.com> wrote:

> Hi Colin,
>
> Thank you for the patch.
>
> On mar., mars 12, 2024 at 07:57, Colin McAllister <colinmca242@gmail.com>
> wrote:
>
> Sam also gave his review here:
>
> https://lore.kernel.org/all/CAPLW+4kHmPtfACyND4Vc2p0ZrsyGY=3D+bRU=3Dfdub4=
K1uX5p33Jw@mail.gmail.com/
>
> Please include his review tag in the next submission.
>
> I will add it at the appropriate place below:
>
>
> > From: Colin McAllister <colin.mcallister@garmin.com>
> >
> > Currently, setting CONFIG_AB_BACKUP_OFFSET in a target's defconfig will
> > not actually enable the #if protected code in android_ab.c. This is
> > because "CONFIG_" should have been prepended to the config macro, or th=
e
> > macros defined in kconfig.h could have been used.
> >
> > The code included by ANDROID_AB_BACKUP_OFFSET has been refactored to no
> > longer be conditionally compiled by preprocessor conditionals and
> > instead use C conditionals. This better aligns with the Linux kernel
> > style guide.
> >
> > Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
> > Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
> > Cc: Joshua Watt <JPEWhacker@gmail.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Colin McAllister <colinmca242@gmail.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> > ---
> > v2:
> >   - Replaced #if conditionals with C if conditionals
> >   - Opted to use CONFIG_ANDROID_AB_BACKUP_OFFSET directly instead of
> >     macros in kconfig.h as CONFIG_ANDROID_AB_BACKUP_OFFSET is not a
> >       boolean or tristate value and doesn't have different values when
> >       building SPL or TPL.
> > v3:
> >   - Added "Fixes:" tag
> > v4:
> >   - No changes
> >
> >  boot/android_ab.c | 97 ++++++++++++++++++++++-------------------------
> >  1 file changed, 45 insertions(+), 52 deletions(-)
> >
> > diff --git a/boot/android_ab.c b/boot/android_ab.c
> > index 9a3d15ec60..f547aa64e4 100644
> > --- a/boot/android_ab.c
> > +++ b/boot/android_ab.c
> > @@ -187,13 +187,12 @@ int ab_select_slot(struct blk_desc *dev_desc,
> struct disk_partition *part_info,
> >                  bool dec_tries)
> >  {
> >       struct bootloader_control *abc =3D NULL;
> > +     struct bootloader_control *backup_abc =3D NULL;
> >       u32 crc32_le;
> >       int slot, i, ret;
> >       bool store_needed =3D false;
> > +     bool valid_backup =3D false;
> >       char slot_suffix[4];
> > -#if ANDROID_AB_BACKUP_OFFSET
> > -     struct bootloader_control *backup_abc =3D NULL;
> > -#endif
> >
> >       ret =3D ab_control_create_from_disk(dev_desc, part_info, &abc, 0)=
;
> >       if (ret < 0) {
> > @@ -205,53 +204,49 @@ int ab_select_slot(struct blk_desc *dev_desc,
> struct disk_partition *part_info,
> >               return ret;
> >       }
> >
> > -#if ANDROID_AB_BACKUP_OFFSET
> > -     ret =3D ab_control_create_from_disk(dev_desc, part_info, &backup_=
abc,
> > -                                       ANDROID_AB_BACKUP_OFFSET);
> > -     if (ret < 0) {
> > -             free(abc);
> > -             return ret;
> > +     if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> > +             ret =3D ab_control_create_from_disk(dev_desc, part_info,
> &backup_abc,
> > +
>  CONFIG_ANDROID_AB_BACKUP_OFFSET);
> > +             if (ret < 0) {
> > +                     free(abc);
> > +                     return ret;
> > +             }
> >       }
> > -#endif
> >
> >       crc32_le =3D ab_control_compute_crc(abc);
> >       if (abc->crc32_le !=3D crc32_le) {
> >               log_err("ANDROID: Invalid CRC-32 (expected %.8x, found
> %.8x),",
> >                       crc32_le, abc->crc32_le);
> > -#if ANDROID_AB_BACKUP_OFFSET
> > -             crc32_le =3D ab_control_compute_crc(backup_abc);
> > -             if (backup_abc->crc32_le !=3D crc32_le) {
> > -                     log_err("ANDROID: Invalid backup CRC-32 ");
> > -                     log_err("expected %.8x, found %.8x),",
> > -                             crc32_le, backup_abc->crc32_le);
> > -#endif
> > -
> > -                     log_err("re-initializing A/B metadata.\n");
> > +             if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> > +                     crc32_le =3D ab_control_compute_crc(backup_abc);
> > +                     if (backup_abc->crc32_le !=3D crc32_le) {
> > +                             log_err(" ANDROID: Invalid backup CRC-32
> ");
> > +                             log_err("(expected %.8x, found %.8x),",
> > +                                     crc32_le, backup_abc->crc32_le);
> > +                     } else {
> > +                             valid_backup =3D true;
> > +                             log_info(" copying A/B metadata from
> backup.\n");
> > +                             memcpy(abc, backup_abc, sizeof(*abc));
> > +                     }
> > +             }
> >
> > +             if (!valid_backup) {
> > +                     log_err(" re-initializing A/B metadata.\n");
> >                       ret =3D ab_control_default(abc);
> >                       if (ret < 0) {
> > -#if ANDROID_AB_BACKUP_OFFSET
> > -                             free(backup_abc);
> > -#endif
> > +                             if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> > +                                     free(backup_abc);
> >                               free(abc);
> >                               return -ENODATA;
> >                       }
> > -#if ANDROID_AB_BACKUP_OFFSET
> > -             } else {
> > -                     /*
> > -                      * Backup is valid. Copy it to the primary
> > -                      */
> > -                     memcpy(abc, backup_abc, sizeof(*abc));
> >               }
> > -#endif
> >               store_needed =3D true;
> >       }
> >
> >       if (abc->magic !=3D BOOT_CTRL_MAGIC) {
> >               log_err("ANDROID: Unknown A/B metadata: %.8x\n",
> abc->magic);
> > -#if ANDROID_AB_BACKUP_OFFSET
> > -             free(backup_abc);
> > -#endif
> > +             if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> > +                     free(backup_abc);
> >               free(abc);
> >               return -ENODATA;
> >       }
> > @@ -259,9 +254,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struc=
t
> disk_partition *part_info,
> >       if (abc->version > BOOT_CTRL_VERSION) {
> >               log_err("ANDROID: Unsupported A/B metadata version:
> %.8x\n",
> >                       abc->version);
> > -#if ANDROID_AB_BACKUP_OFFSET
> > -             free(backup_abc);
> > -#endif
> > +             if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> > +                     free(backup_abc);
> >               free(abc);
> >               return -ENODATA;
> >       }
> > @@ -338,30 +332,29 @@ int ab_select_slot(struct blk_desc *dev_desc,
> struct disk_partition *part_info,
> >               abc->crc32_le =3D ab_control_compute_crc(abc);
> >               ret =3D ab_control_store(dev_desc, part_info, abc, 0);
> >               if (ret < 0) {
> > -#if ANDROID_AB_BACKUP_OFFSET
> > -                     free(backup_abc);
> > -#endif
> > +                     if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> > +                             free(backup_abc);
> >                       free(abc);
> >                       return ret;
> >               }
> >       }
> >
> > -#if ANDROID_AB_BACKUP_OFFSET
> > -     /*
> > -      * If the backup doesn't match the primary, write the primary
> > -      * to the backup offset
> > -      */
> > -     if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
> > -             ret =3D ab_control_store(dev_desc, part_info, abc,
> > -                                    ANDROID_AB_BACKUP_OFFSET);
> > -             if (ret < 0) {
> > -                     free(backup_abc);
> > -                     free(abc);
> > -                     return ret;
> > +     if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> > +             /*
> > +             * If the backup doesn't match the primary, write the
> primary
> > +             * to the backup offset
> > +             */
>
> checkpatch.pl seems to complain about this comment block:
>
> WARNING: Block comments should align the * on each line
> #166: FILE: boot/android_ab.c:344:
> +               /*
> +               * If the backup doesn't match the primary, write the
> primary
>
> To reproduce, run:
>
> $ ./scripts/checkpatch.pl --strict --u-boot --git HEAD^..HEAD
>
> With the above addressed, please send a v5 including:
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> > +             if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
> > +                     ret =3D ab_control_store(dev_desc, part_info, abc=
,
> > +
> CONFIG_ANDROID_AB_BACKUP_OFFSET);
> > +                     if (ret < 0) {
> > +                             free(backup_abc);
> > +                             free(abc);
> > +                             return ret;
> > +                     }
> >               }
> > +             free(backup_abc);
> >       }
> > -     free(backup_abc);
> > -#endif
> >
> >       free(abc);
> >
> > --
> > 2.34.1
>

With Mattijs comment addressed:
Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
