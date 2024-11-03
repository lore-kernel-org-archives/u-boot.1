Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08F3E6781B
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 09:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34F5890F8;
	Sun,  3 Nov 2024 10:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fc2c7RhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C6E8907E; Sun,  3 Nov 2024 10:43:57 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1E85890F8
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 10:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d4c1b1455so2053785f8f.3
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 01:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730627034; x=1731231834; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PlpXUa/y6hbCSQWXh7uOUac/kfV4pe42UeWXdwzZYkU=;
 b=fc2c7RhZRDnshx2Qw10MwBKyhGgZi43BbnWdrfSc1ED/7KYKSNnSI57sCkPhLuyAgJ
 MEgzgAq8N+Qc8zjoT4oTQN/UA3CbHeNaFU539L28bFxvRu/1RrIi+QYZLzbG60GvbNBQ
 MmCrkdjptMwNTTsgjJXpAjYsPH+Bei7A/RRQYb8vAvySTzuOk8TJ9HYLBWS8o2xlc+We
 NofUWC23bETw50+jFHLE5WRkZ9jU29/TaVJerdHAqd1+KK/OZkujmM6nTUn8mANtNZoB
 LB3uB/MThigWHnSGMq4DQpdhCxW/xyQy83sYjVoODpoBdwu8CFDl+fMh5UNg9rLRXJkg
 iY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730627034; x=1731231834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PlpXUa/y6hbCSQWXh7uOUac/kfV4pe42UeWXdwzZYkU=;
 b=ZPfKIOSbsO7qDICAX/iVyGI3SFT87j00hevbx8ZuXWablxAHhdIh5UoA5XbenOzYSW
 qTDu9r0vdHJ6hbob6IH8plw14AljC02BGP6hjAFELje95vdKKRMuDTQYPzI9TcW/zhOb
 XW4v2xI6RQqccEV8OAZ7XqtJv0tdsdFZqI9gLN6gmDjK8vMOBk0F9LYICUWT6+6EhK2h
 q8qz4jiN/LeqmCnYRMiLwtp+3RLAiDT5Fh6aZVcCoxWuC2ZiNzNDcB1J6bQLnpDiFgBb
 6ZEzGxj9iA0Gjp33fwbeASvZdKk9vWA77pfKCwZODkj5ikQo7qzC8noykoeQts+0Yz23
 KElA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYNWt+in2fSTz4oEsvbutJZbLjca5UWn8mPCAmUJ4QY0hq5u6hV14/xt435r9H6rg1EpF7UD0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1Zh845algAMoW+waIHwt3I2maGamj9LzlyvifYydSYkYK9XvI
 oPGSxt2LER8HTEGcd7+Kf3aaoCzy6KKfbTx45O2zEbNX3+O1pjTlsJl4kLmU8IQOTI3niKNjXTB
 KRXvyB0Dfa7zlMGilIWpVlbNvn0k=
X-Google-Smtp-Source: AGHT+IGoNBwdL5SjQdohSFc/ao3VRguiq5OOVyAwqpvDIOjXcCqRUqo+MFdXWyFbmBE9nmzL6gP7de7+rJ1iHfy5LKI=
X-Received: by 2002:a05:6000:ac1:b0:37d:3280:203a with SMTP id
 ffacd0b85a97d-381b7057644mr11736299f8f.10.1730627034137; Sun, 03 Nov 2024
 01:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
In-Reply-To: <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Sun, 3 Nov 2024 10:43:42 +0100
Message-ID: <CAByghJb+ObC4jQ4B71Bf-eUKhyYcAY1inj=7LSa+qG1t-RBO+Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 rockosov@gmail.com, kernel@salutedevices.com, 
 Guillaume La Roque <glaroque@baylibre.com>
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

Hi Dmitry,

On Thu, Oct 17, 2024 at 4:12=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> To align with the official Android BCB (Bootloader Control Block)
> specifications, it's important to note that the slot_suffix should start
> with an underscore symbol.
>
> For a comprehensive understanding of the expected slot_suffix format in
> userspace, please refer to the provided reference [1].
>
> Links:
> [1] - https://source.android.com/docs/core/architecture/bootloader/updati=
ng#slots
>
> Based-on: https://android-review.googlesource.com/c/platform/external/u-b=
oot/+/1446439
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  boot/android_ab.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index c93e51541019d0fe793303c4b3d5286df061906f..a287eac04fe88ad08bdcf1b1b=
1d6e564d503d800 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -52,7 +52,7 @@ static int ab_control_default(struct bootloader_control=
 *abc)
>         if (!abc)
>                 return -EFAULT;
>
> -       memcpy(abc->slot_suffix, "a\0\0\0", 4);
> +       memcpy(abc->slot_suffix, "_a\0\0", 4);
>         abc->magic =3D BOOT_CTRL_MAGIC;
>         abc->version =3D BOOT_CTRL_VERSION;
>         abc->nb_slot =3D NUM_SLOTS;
> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,
>                  * or the device tree.
>                  */
>                 memset(slot_suffix, 0, sizeof(slot_suffix));
> -               slot_suffix[0] =3D BOOT_SLOT_NAME(slot);
> +               slot_suffix[0] =3D '_';
> +               slot_suffix[1] =3D BOOT_SLOT_NAME(slot);
>                 if (memcmp(abc->slot_suffix, slot_suffix,
>                            sizeof(slot_suffix))) {
>                         memcpy(abc->slot_suffix, slot_suffix,
>
> --
> 2.43.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
