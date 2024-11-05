Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1826D2C11E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10FF88FCC;
	Tue,  5 Nov 2024 16:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Obfm+d/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B2168919A; Tue,  5 Nov 2024 16:06:03 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2930988F77
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb5638dd57so52676481fa.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730819160; x=1731423960;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9HZpd1bzSJHQl4obdcwxMK9nPRyH24ygPbUV/B51BdE=;
 b=3Obfm+d/4puDU2xcU3GSES185Y2ATBskpPRPt1UBWqUgBJXlXiLvMrHwCQBJnW6coF
 uhBTF4sgjmKIcR/Yf4hfyWYRV74bxmwxPfcncOUwnfdmSeh97Y6MIVFNKt24XVI5pCaL
 lFrOiHUGgWaKdMABen5PmJlG3aNz1TWDSlWr+ZHfOInAxcpwy3yDnA+cd0mdNmMpVZr/
 3k+4Ro6yGdZe5rci/RExySt5Ju+GFgr8qK3KZe9/icuRNdzLXm2PU/3+paiPlGWFBGE4
 Pbh2n14PD5NmD+HBMokcmVdnTYgFatDkRq+djTqFbWFpGwcGBUbzuzntegVHan7kzhqA
 anXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819160; x=1731423960;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HZpd1bzSJHQl4obdcwxMK9nPRyH24ygPbUV/B51BdE=;
 b=JAwb9Yt2vdb8pPuCgNSRdSMZvZTwNcLP1OxL5cBwrly2axCtWNsqto/AhosRo2/jrf
 GN73HNowWIbhSMH+8tfNtgP2PVoUeXvEwhtW5f/SEOnqDnBM8g2hEEZzTrkDJwLEB2rA
 HsfUVZTCEOmyGBMQqGEITbt+rSMGX6M/sP7XUmvUd7vWXxFFKcU8Mr0FkBD28oXHb7tv
 vyCJEEritQBAptPMtqWxK0+bkKQNyi0ZUcNWz/ECtdnTv6U07/vLk372IG6JDaR8EM6s
 kNYRZXvcQgMNyk1vlBQSbU80UPj/pEHxcjsRdYsJec0VkmPywVFHXoSVtAj8UU8X8hlz
 F6OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ2ANMpBY9fDxpDPxmXHrr9MWFABsuMOeYnOHoYonLyqBuQv8jgIkNeJ5f6Y9qXieWsc60TOQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzDjsXvhL2Njf1AZd+a7ebx+s3HYf7P7uCoYiAJ/SlMqj5o51Z0
 yAYkbnqSfNNvPd4j/ofngee/+Q/4JVzJVB+rx2SBxFAm2PIqH4XoiLPlo4XdS0s=
X-Google-Smtp-Source: AGHT+IGbr1ZM4n3t3aQV+gGUJLoodSaD42NTzRYOr3OZ06TEkbtMaoffHf7d3J8pMo3zal5rZmHHKA==
X-Received: by 2002:a2e:e11:0:b0:2fb:62ad:89fe with SMTP id
 38308e7fff4ca-2fcbdfbb311mr134294621fa.16.1730819158774; 
 Tue, 05 Nov 2024 07:05:58 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a9faesm221127695e9.35.2024.11.05.07.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:05:58 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sam Protsenko <semen.protsenko@linaro.org>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>,
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 rockosov@gmail.com, kernel@salutedevices.com, Guillaume La Roque
 <glaroque@baylibre.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
In-Reply-To: <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
 <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
Date: Tue, 05 Nov 2024 16:05:55 +0100
Message-ID: <87v7x1soto.fsf@baylibre.com>
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

Hi Sam,

Thank you for the review.

On lun., nov. 04, 2024 at 17:06, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:

> On Thu, Oct 17, 2024 at 9:12=E2=80=AFAM Dmitry Rokosov
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
>
> Would be nice to add "Fixes:" tag here, pointing to the corresponding
> commit where the issue was introduced (see kernel docs for details).
> It could be quite useful for possible stable branches and other
> purposes, I'd recommend to add that tag for all fixes if you have more
> in this series.

I agree. Unfortunately, this series has already been merged here:

https://lore.kernel.org/r/all/20241025175409.GB4959@bill-the-cat/

>
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
>
> AFAIU, this changes the behavior of two above functions, and
> consequently of "bcb ab_select" command? If so, just to double check:
> were all users of those reworked correspondingly? I can see next
> occurrences (there may be more):
>
> $ grep -sIrHn '"_' boot/bootmeth_android.c

I thought the same when first reviewing the patch.
Looking a bit closer...

>
> boot/bootmeth_android.c:74:    sprintf(partname, BOOT_PART_NAME "_%s",
> priv->slot);
> boot/bootmeth_android.c:111:    sprintf(partname,
> VENDOR_BOOT_PART_NAME "_%s", priv->slot);
> boot/bootmeth_android.c:156:    sprintf(slot_suffix, "_%s", priv->slot);
> boot/bootmeth_android.c:397:    sprintf(slot_suffix, "_%s", priv->slot);

... We can see that ab_select_slot() returns an integer
That integer is used later on to initialize priv->slot:

"""
	priv->slot[0] =3D BOOT_SLOT_NAME(ret);
	priv->slot[1] =3D '\0';
"""

The change from Dmitry only changes what we **write** to the BCB (into
the misc partition), not what is returned by ab_select_slot().

ab_select_slot() still returns an integer which needs to be converted
via the BOOT_SLOT_NAME() macro.

>
> $ grep -sIrHn 'slot_suffix _' include/configs/
> include/configs/ti_omap5_common.h:107:    "setenv slot_suffix _${slot_nam=
e};"
> include/configs/meson64_android.h:65:        "setenv slot_suffix
> _${current_slot}; " \

Same goes for these 2 examples, we use:
The "bcb ab_select current_slot" command to store the slot into the
"current_slot" environment variable.
Looking at cmd/bcb.c we can see:

"""
	ret =3D ab_select_slot(dev_desc, &part_info, dec_tries);
	if (ret < 0) {
		printf("Android boot failed, error %d.\n", ret);
		return CMD_RET_FAILURE;
	}

	/* Android standard slot names are 'a', 'b', ... */
	slot[0] =3D BOOT_SLOT_NAME(ret);
	slot[1] =3D '\0';
	env_set(argv[1], slot);
	printf("ANDROID: Booting slot: %s\n", slot);
"""

So I think this is fine.

>
>>                 if (memcmp(abc->slot_suffix, slot_suffix,
>>                            sizeof(slot_suffix))) {
>>                         memcpy(abc->slot_suffix, slot_suffix,
>>
>> --
>> 2.43.0
>>
