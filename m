Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7614BC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 09:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8977587E3F;
	Thu, 21 Mar 2024 10:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l0BFKX3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D054E880AC; Thu, 21 Mar 2024 10:29:38 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4885287D83
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 10:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4146562a839so5333325e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711013376; x=1711618176;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+TmuW/dgmvsPdUPCScvF+GikRwI0BxsT5WkKecqj1L8=;
 b=l0BFKX3/6jO2R/w0T1nqmXecUkF+AoEEZB3zTs7KCZ+BTGzHtIcnKRwqXna3kLY2tO
 fLBtjNPrDJ5k6utFLPhheJNcX9ZM1Opp6mzFXZLkpELvaXe0vjI0n33PXw2WA3WzoYiO
 AF9rtKP7+MPNOVQt1XCdd/llMOfkcmPKT1clTYkHaddcsr+fxAjAbmbx6sJwTTRXbnrF
 GWufBrqy+TKHe+iDaw9LfmmewNwFRaEV8i/q3gTJKgz9kNvvbq5TCNN50ZbbQ40c8yER
 biI3+DyGVsk1Ww4idaAcUmvJigrH401t2tSs52D+jYSVPrE42b9T7s4ZGJZhjsCT9cWf
 YrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711013376; x=1711618176;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+TmuW/dgmvsPdUPCScvF+GikRwI0BxsT5WkKecqj1L8=;
 b=Eh0gDl/uuvzMYztyEIzIlQH+8aB7ybw8u3dLsVWS2g4W/U+Qvx5sx01srLFi7j8pVK
 yPvfoTpnIU0M2TO6JknvwPXLLz0riApqVrRbsxFakPmt8Nqt0owZShbWKyduYtfhOEee
 BcsuMPOnHA+kPhjk8qgtv/gtAvYueQnkrBLBQCc1iswEyZlEDozSPBPpEpVO+70nNbwE
 0onXQjwm0YCUUZNh15ztYIyzI8+h/t8pR+is+OhttXWf29MDiMI0H9YdhbBP7lvycuQO
 /whimp8YqWyt3FPKXGPH4+RPDPKczmWqb60k/L50RkQy8OLu5otusvP5habq0y+Nj8US
 iYmw==
X-Gm-Message-State: AOJu0Yxs7JqR1k1Q6KAALrf7LU7mT3ud4oWTVCGmQ6JhJg1F72dOuqw7
 QVPRoiWsFmS8XSCH2sFR3M/WY1oe5d7kv9/YYcseE/unl6a5DirZARPx85bkoeRdnu8pKPeXoTr
 G
X-Google-Smtp-Source: AGHT+IG3Z+WUxg449H51hsZN5unUz835AHMqi9whKZZq8SbeTkUY2qj3EdE83RssUG95RHuDcGHZHg==
X-Received: by 2002:a05:600c:524a:b0:414:63c6:8689 with SMTP id
 fc10-20020a05600c524a00b0041463c68689mr5161919wmb.20.1711013375575; 
 Thu, 21 Mar 2024 02:29:35 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c4e8e00b0041413aefeb9sm4946115wmq.48.2024.03.21.02.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 02:29:35 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Colin McAllister
 <colinmca242@gmail.com>
Cc: u-boot@lists.denx.de, Colin McAllister <colin.mcallister@garmin.com>,
 JPEWhacker@gmail.com, sjg@chromium.org, Sam Protsenko
 <semen.protsenko@linaro.org>
Subject: Re: [PATCH v4 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
In-Reply-To: <CAByghJZjX863HRWbK7U5PPmaQ_vcuuBN9r+tqEqV7h3sL4HuFg@mail.gmail.com>
References: <20240312125729.82695-1-colinmca242@gmail.com>
 <20240312125729.82695-3-colinmca242@gmail.com>
 <87jzm74gw4.fsf@baylibre.com>
 <CAByghJZjX863HRWbK7U5PPmaQ_vcuuBN9r+tqEqV7h3sL4HuFg@mail.gmail.com>
Date: Thu, 21 Mar 2024 10:29:34 +0100
Message-ID: <87cyronda9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Colin,

Since both below remarks are minor nitpicks, I can also do them when
applying (to avoid delaying this series too much).

Please le me know what you prefer:
1. You send a v5 at your convience
2. I do the minor fixups and I merge right away.

Again, thank you for doing your first U-Boot contributions!

Mattijs

On mer., mars 13, 2024 at 18:22, Igor Opaniuk <igor.opaniuk@gmail.com> wrot=
e:

> Hi Colin,
>
> On Tue, Mar 12, 2024 at 4:19=E2=80=AFPM Mattijs Korpershoek <
> mkorpershoek@baylibre.com> wrote:
>
>> Hi Colin,
>>
>> Thank you for the patch.
>>
>> On mar., mars 12, 2024 at 07:57, Colin McAllister <colinmca242@gmail.com>
>> wrote:
>>
>> Sam also gave his review here:
>>
>> https://lore.kernel.org/all/CAPLW+4kHmPtfACyND4Vc2p0ZrsyGY=3D+bRU=3Dfdub=
4K1uX5p33Jw@mail.gmail.com/
>>
>> Please include his review tag in the next submission.
>>
>> I will add it at the appropriate place below:
>>
>>
>> > From: Colin McAllister <colin.mcallister@garmin.com>
>> >
>> > Currently, setting CONFIG_AB_BACKUP_OFFSET in a target's defconfig will
>> > not actually enable the #if protected code in android_ab.c. This is
>> > because "CONFIG_" should have been prepended to the config macro, or t=
he
>> > macros defined in kconfig.h could have been used.
>> >
>> > The code included by ANDROID_AB_BACKUP_OFFSET has been refactored to no
>> > longer be conditionally compiled by preprocessor conditionals and
>> > instead use C conditionals. This better aligns with the Linux kernel
>> > style guide.
>> >
>> > Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
>> > Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
>> > Cc: Joshua Watt <JPEWhacker@gmail.com>
>> > Cc: Simon Glass <sjg@chromium.org>
>> > Signed-off-by: Colin McAllister <colinmca242@gmail.com>
>> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>>
>> > ---
>> > v2:
>> >   - Replaced #if conditionals with C if conditionals
>> >   - Opted to use CONFIG_ANDROID_AB_BACKUP_OFFSET directly instead of
>> >     macros in kconfig.h as CONFIG_ANDROID_AB_BACKUP_OFFSET is not a
>> >       boolean or tristate value and doesn't have different values when
>> >       building SPL or TPL.
>> > v3:
>> >   - Added "Fixes:" tag
>> > v4:
>> >   - No changes
>> >
>> >  boot/android_ab.c | 97 ++++++++++++++++++++++-------------------------
>> >  1 file changed, 45 insertions(+), 52 deletions(-)
>> >
>> > diff --git a/boot/android_ab.c b/boot/android_ab.c
>> > index 9a3d15ec60..f547aa64e4 100644
>> > --- a/boot/android_ab.c
>> > +++ b/boot/android_ab.c
>> > @@ -187,13 +187,12 @@ int ab_select_slot(struct blk_desc *dev_desc,
>> struct disk_partition *part_info,
>> >                  bool dec_tries)
>> >  {
>> >       struct bootloader_control *abc =3D NULL;
>> > +     struct bootloader_control *backup_abc =3D NULL;
>> >       u32 crc32_le;
>> >       int slot, i, ret;
>> >       bool store_needed =3D false;
>> > +     bool valid_backup =3D false;
>> >       char slot_suffix[4];
>> > -#if ANDROID_AB_BACKUP_OFFSET
>> > -     struct bootloader_control *backup_abc =3D NULL;
>> > -#endif
>> >
>> >       ret =3D ab_control_create_from_disk(dev_desc, part_info, &abc, 0=
);
>> >       if (ret < 0) {
>> > @@ -205,53 +204,49 @@ int ab_select_slot(struct blk_desc *dev_desc,
>> struct disk_partition *part_info,
>> >               return ret;
>> >       }
>> >
>> > -#if ANDROID_AB_BACKUP_OFFSET
>> > -     ret =3D ab_control_create_from_disk(dev_desc, part_info, &backup=
_abc,
>> > -                                       ANDROID_AB_BACKUP_OFFSET);
>> > -     if (ret < 0) {
>> > -             free(abc);
>> > -             return ret;
>> > +     if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
>> > +             ret =3D ab_control_create_from_disk(dev_desc, part_info,
>> &backup_abc,
>> > +
>>  CONFIG_ANDROID_AB_BACKUP_OFFSET);
>> > +             if (ret < 0) {
>> > +                     free(abc);
>> > +                     return ret;
>> > +             }
>> >       }
>> > -#endif
>> >
>> >       crc32_le =3D ab_control_compute_crc(abc);
>> >       if (abc->crc32_le !=3D crc32_le) {
>> >               log_err("ANDROID: Invalid CRC-32 (expected %.8x, found
>> %.8x),",
>> >                       crc32_le, abc->crc32_le);
>> > -#if ANDROID_AB_BACKUP_OFFSET
>> > -             crc32_le =3D ab_control_compute_crc(backup_abc);
>> > -             if (backup_abc->crc32_le !=3D crc32_le) {
>> > -                     log_err("ANDROID: Invalid backup CRC-32 ");
>> > -                     log_err("expected %.8x, found %.8x),",
>> > -                             crc32_le, backup_abc->crc32_le);
>> > -#endif
>> > -
>> > -                     log_err("re-initializing A/B metadata.\n");
>> > +             if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
>> > +                     crc32_le =3D ab_control_compute_crc(backup_abc);
>> > +                     if (backup_abc->crc32_le !=3D crc32_le) {
>> > +                             log_err(" ANDROID: Invalid backup CRC-32
>> ");
>> > +                             log_err("(expected %.8x, found %.8x),",
>> > +                                     crc32_le, backup_abc->crc32_le);
>> > +                     } else {
>> > +                             valid_backup =3D true;
>> > +                             log_info(" copying A/B metadata from
>> backup.\n");
>> > +                             memcpy(abc, backup_abc, sizeof(*abc));
>> > +                     }
>> > +             }
>> >
>> > +             if (!valid_backup) {
>> > +                     log_err(" re-initializing A/B metadata.\n");
>> >                       ret =3D ab_control_default(abc);
>> >                       if (ret < 0) {
>> > -#if ANDROID_AB_BACKUP_OFFSET
>> > -                             free(backup_abc);
>> > -#endif
>> > +                             if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
>> > +                                     free(backup_abc);
>> >                               free(abc);
>> >                               return -ENODATA;
>> >                       }
>> > -#if ANDROID_AB_BACKUP_OFFSET
>> > -             } else {
>> > -                     /*
>> > -                      * Backup is valid. Copy it to the primary
>> > -                      */
>> > -                     memcpy(abc, backup_abc, sizeof(*abc));
>> >               }
>> > -#endif
>> >               store_needed =3D true;
>> >       }
>> >
>> >       if (abc->magic !=3D BOOT_CTRL_MAGIC) {
>> >               log_err("ANDROID: Unknown A/B metadata: %.8x\n",
>> abc->magic);
>> > -#if ANDROID_AB_BACKUP_OFFSET
>> > -             free(backup_abc);
>> > -#endif
>> > +             if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
>> > +                     free(backup_abc);
>> >               free(abc);
>> >               return -ENODATA;
>> >       }
>> > @@ -259,9 +254,8 @@ int ab_select_slot(struct blk_desc *dev_desc, stru=
ct
>> disk_partition *part_info,
>> >       if (abc->version > BOOT_CTRL_VERSION) {
>> >               log_err("ANDROID: Unsupported A/B metadata version:
>> %.8x\n",
>> >                       abc->version);
>> > -#if ANDROID_AB_BACKUP_OFFSET
>> > -             free(backup_abc);
>> > -#endif
>> > +             if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
>> > +                     free(backup_abc);
>> >               free(abc);
>> >               return -ENODATA;
>> >       }
>> > @@ -338,30 +332,29 @@ int ab_select_slot(struct blk_desc *dev_desc,
>> struct disk_partition *part_info,
>> >               abc->crc32_le =3D ab_control_compute_crc(abc);
>> >               ret =3D ab_control_store(dev_desc, part_info, abc, 0);
>> >               if (ret < 0) {
>> > -#if ANDROID_AB_BACKUP_OFFSET
>> > -                     free(backup_abc);
>> > -#endif
>> > +                     if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
>> > +                             free(backup_abc);
>> >                       free(abc);
>> >                       return ret;
>> >               }
>> >       }
>> >
>> > -#if ANDROID_AB_BACKUP_OFFSET
>> > -     /*
>> > -      * If the backup doesn't match the primary, write the primary
>> > -      * to the backup offset
>> > -      */
>> > -     if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
>> > -             ret =3D ab_control_store(dev_desc, part_info, abc,
>> > -                                    ANDROID_AB_BACKUP_OFFSET);
>> > -             if (ret < 0) {
>> > -                     free(backup_abc);
>> > -                     free(abc);
>> > -                     return ret;
>> > +     if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
>> > +             /*
>> > +             * If the backup doesn't match the primary, write the
>> primary
>> > +             * to the backup offset
>> > +             */
>>
>> checkpatch.pl seems to complain about this comment block:
>>
>> WARNING: Block comments should align the * on each line
>> #166: FILE: boot/android_ab.c:344:
>> +               /*
>> +               * If the backup doesn't match the primary, write the
>> primary
>>
>> To reproduce, run:
>>
>> $ ./scripts/checkpatch.pl --strict --u-boot --git HEAD^..HEAD
>>
>> With the above addressed, please send a v5 including:
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
>> > +             if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
>> > +                     ret =3D ab_control_store(dev_desc, part_info, ab=
c,
>> > +
>> CONFIG_ANDROID_AB_BACKUP_OFFSET);
>> > +                     if (ret < 0) {
>> > +                             free(backup_abc);
>> > +                             free(abc);
>> > +                             return ret;
>> > +                     }
>> >               }
>> > +             free(backup_abc);
>> >       }
>> > -     free(backup_abc);
>> > -#endif
>> >
>> >       free(abc);
>> >
>> > --
>> > 2.34.1
>>
>
> With Mattijs comment addressed:
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
