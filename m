Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180D9D2C114
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 14:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E75E88F77;
	Tue,  5 Nov 2024 15:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LAbIljFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489A1891A4; Tue,  5 Nov 2024 15:54:29 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE8488E96
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 15:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d447de11dso4312247f8f.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 06:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730818466; x=1731423266;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rjK3CpCzjOKZWgXNLqIPZYNp3SDYBLyEBuadA8pHxTw=;
 b=LAbIljFkYtCKszX9QwZHAjZ20aAxeISGKsvCSom8y/YY9xV39olhtmlJ6tDAQ1nG6Z
 V33Qfdq6ftJ/CzegYYCZgoCvYLxuyCodZrTjYY5uHXX0R/ZXvG3qXrEUIxMozxV8FaAI
 mBGLkp04k9YUsUjZdrRUDvSUp7VizZ5Z3Pm5og6JmfAC6/UQHzBGDJZRiFPPfvYAandw
 5DSTgzIZgqi71tG2YprpFbjUg38YYYBw5LnSBoD/QsgNduc3/R94icRRNt4sy4b5f8Up
 YOyMhi8hHvD/jOlOmMzNgvPAAa1JQbKqVzT1/HLIQC7rFAhUqARZZZMKo80TnQR2ZuQI
 vqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730818466; x=1731423266;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjK3CpCzjOKZWgXNLqIPZYNp3SDYBLyEBuadA8pHxTw=;
 b=ey8ErL8MY8+3qKj0qJ+dkhLczidiQBDrlra4YICmfcJhZcJZIFfyb+ZAHTbUzvJw6j
 JuZkjG5ueDTuUb2t+pa31IXplN0Oen7PHrWUmIIdYRP2lXfwkdUZIZeWuP4nsTofiuiZ
 nSDRZFIYmoda3/tz3wOwxwON8xcteVYJIJANLZj2+12hiS/siBjUSF3JVosWtD5+6qmT
 D/0qiPzdRvKvfVkfp29TgwS1/zTct1bLtTMUCDSGu9eHvv1D7/m155NNrnmvA7DgGXc6
 BVkC8jJou+CaL9nst+n19x6qfr/nBBgWcbW86Dbc4cGnvIIQ8vVzUl3rhAs/Vt8oxna7
 aBwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhe+VAGc9aRM2d0Xx8U6e1bzF8b7AzQf6lLl6YlUSIQrBPAAQuLa789rJf0dAHbW7174wyfmM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2vHgeKEqDvqdaKE91U0SDJrgJONy4iPng//zHWX0C4b/Kg5gB
 ZzdoftjuG04WuOT7EQvtFZBECxelYzgjrOZP2+6vUCUJ2ui/eHcetNTYxt4hSBc=
X-Google-Smtp-Source: AGHT+IFFqfpRQKWdmeOWfkxfBjFjCMoTc6tZFPby43e/OhNMIQJhTECfZSRD3hiSG9io7SKbRe1WCg==
X-Received: by 2002:a05:6000:1fac:b0:37d:498a:a237 with SMTP id
 ffacd0b85a97d-381be7adfc7mr15214092f8f.8.1730818465996; 
 Tue, 05 Nov 2024 06:54:25 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7c08sm16452466f8f.17.2024.11.05.06.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 06:54:25 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 rockosov@gmail.com, kernel@salutedevices.com, Guillaume La Roque
 <glaroque@baylibre.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
In-Reply-To: <CAByghJb+ObC4jQ4B71Bf-eUKhyYcAY1inj=7LSa+qG1t-RBO+Q@mail.gmail.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
 <CAByghJb+ObC4jQ4B71Bf-eUKhyYcAY1inj=7LSa+qG1t-RBO+Q@mail.gmail.com>
Date: Tue, 05 Nov 2024 15:54:22 +0100
Message-ID: <87y11xspcx.fsf@baylibre.com>
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

Hi Igor,

Thank you for the review.

On dim., nov. 03, 2024 at 10:43, Igor Opaniuk <igor.opaniuk@gmail.com> wrot=
e:

> Hi Dmitry,
>
> On Thu, Oct 17, 2024 at 4:12=E2=80=AFPM Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
>>
>> To align with the official Android BCB (Bootloader Control Block)
>> specifications, it's important to note that the slot_suffix should start
>> with an underscore symbol.
>>
>> For a comprehensive understanding of the expected slot_suffix format in
>> userspace, please refer to the provided reference [1].
>>
>> Links:
>> [1] - https://source.android.com/docs/core/architecture/bootloader/updat=
ing#slots
>>
>> Based-on: https://android-review.googlesource.com/c/platform/external/u-=
boot/+/1446439
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
>> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> ---
>>  boot/android_ab.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/boot/android_ab.c b/boot/android_ab.c
>> index c93e51541019d0fe793303c4b3d5286df061906f..a287eac04fe88ad08bdcf1b1=
b1d6e564d503d800 100644
>> --- a/boot/android_ab.c
>> +++ b/boot/android_ab.c
>> @@ -52,7 +52,7 @@ static int ab_control_default(struct bootloader_contro=
l *abc)
>>         if (!abc)
>>                 return -EFAULT;
>>
>> -       memcpy(abc->slot_suffix, "a\0\0\0", 4);
>> +       memcpy(abc->slot_suffix, "_a\0\0", 4);
>>         abc->magic =3D BOOT_CTRL_MAGIC;
>>         abc->version =3D BOOT_CTRL_VERSION;
>>         abc->nb_slot =3D NUM_SLOTS;
>> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct=
 disk_partition *part_info,
>>                  * or the device tree.
>>                  */
>>                 memset(slot_suffix, 0, sizeof(slot_suffix));
>> -               slot_suffix[0] =3D BOOT_SLOT_NAME(slot);
>> +               slot_suffix[0] =3D '_';
>> +               slot_suffix[1] =3D BOOT_SLOT_NAME(slot);
>>                 if (memcmp(abc->slot_suffix, slot_suffix,
>>                            sizeof(slot_suffix))) {
>>                         memcpy(abc->slot_suffix, slot_suffix,
>>
>> --
>> 2.43.0
>>
>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Sorry, I can't apply that R-b tag because this series has been merged
into master already:

https://lore.kernel.org/r/all/20241025175409.GB4959@bill-the-cat/

> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk
