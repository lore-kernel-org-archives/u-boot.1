Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A44FD3E799
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9AE688DB6;
	Wed,  6 Nov 2024 11:03:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TLYk8IhS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B9D8902D; Wed,  6 Nov 2024 11:03:02 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891FD88CEC
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539f7606199so4151565e87.0
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 02:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730887379; x=1731492179;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kfxDX4yZaQG0Bgjg8gnQxBPe6Cdj9nkJg95bDaBzpo8=;
 b=TLYk8IhSOPpWo1q2cZ4rRwPU98sC1yawPoHPGlnQ9RJonlGBWGHUHtZT16vUvXtM3Q
 B6AC2AbKUVIyRevO2mTNCUOdSw1eCqt7dkZE7VmnNLCfNv8aclI5OW3PJXSrRpUJv1fB
 xRJpJFpgPU6sDKBb2lztqPhEcBwH2RWj4mFlsHiyo/Ofa77rQnVYMN483gdl6qMSL0Ia
 PEVZ+jcsXwEUaDkkeDyNRCtYd3MDyIYczrKOEEn0hEL/RLhrcY+KU/EytgLjwmU0Vatg
 YUp6bwTL0uYVzA0siHWSpQ++Q8GJEvhKeEg3+7W5YqDyFqdh8ks8gZ7NNGGmtUh9QO2G
 ggZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730887379; x=1731492179;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfxDX4yZaQG0Bgjg8gnQxBPe6Cdj9nkJg95bDaBzpo8=;
 b=jibK+rlAxfflw6NdBOME3/wa5BPoGWjg2GtYuBboNe/6J9vM18pPdRjDQ8fGc7ia3a
 Nzlm6n6xQgNIStEBOucWOL0c00d0gVmbIdc9rkW2yNctyrOGpnAabXxsugRPgw+vdTPX
 BiOcMpObh925vxL9saN4+98iWhUawy13ehEeCa+z/2scqv3o3CQCChboSOigR9YQAy2B
 oDvfTYZKiLIPURHTn+UM9vqV/5/JqS7YlfZSbM1a83MM9036PqrW1iVFVlgIlo8hq4Rh
 UkQOZ8UlzhCqM0muohjNwiXMeFcB/3CirijjUmE2k+JdoMmsA2SLbF182P3WKf0ALIYe
 c0JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn6Gzrm99cdD3U3aUqmbnHk14/yVXSnF3KdxiLXKmQI/pkpEjcMoWP857C8eLJ0wdwvmUrqts=@lists.denx.de
X-Gm-Message-State: AOJu0Yy53jHiYGee4EEL1A3QCkOvgBtF4fOdAZ7IZmSf0hc3k/gjbUm4
 RBvhheo2LPBrTEfvaTehDbRu/XvhK4azd+Q/OuWYCJgLCkri1D4o2GbAz+qzkvg=
X-Google-Smtp-Source: AGHT+IELi+FkQ46N2paJoErWJVDp3/OtiZNhNYFfhU+AWP0rzBt30VR6RJogwnDpNi7EIsYFEkjZ2A==
X-Received: by 2002:a05:6512:2245:b0:539:e97c:cb12 with SMTP id
 2adb3069b0e04-53b7ecfbe41mr13038494e87.34.1730887378709; 
 Wed, 06 Nov 2024 02:02:58 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6c6460sm16484815e9.23.2024.11.06.02.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 02:02:58 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>, "Andrew F. Davis"
 <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass
 <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, rockosov@gmail.com, kernel@salutedevices.com,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
In-Reply-To: <CAPLW+4=-yPgMeDM5XRkBXR-nD4Ni2VtWqTKxJVVrfdU8g2sG4g@mail.gmail.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
 <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
 <87v7x1soto.fsf@baylibre.com>
 <CAPLW+4=-yPgMeDM5XRkBXR-nD4Ni2VtWqTKxJVVrfdU8g2sG4g@mail.gmail.com>
Date: Wed, 06 Nov 2024 11:02:57 +0100
Message-ID: <875xp08ysu.fsf@baylibre.com>
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

On mar., nov. 05, 2024 at 18:58, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:

> On Tue, Nov 5, 2024 at 9:06=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Sam,
>>
>
> Hey Mattijs,
>
> [snip]
>
>> >> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, str=
uct disk_partition *part_info,
>> >>                  * or the device tree.
>> >>                  */
>> >>                 memset(slot_suffix, 0, sizeof(slot_suffix));
>> >> -               slot_suffix[0] =3D BOOT_SLOT_NAME(slot);
>> >> +               slot_suffix[0] =3D '_';
>> >> +               slot_suffix[1] =3D BOOT_SLOT_NAME(slot);
>> >
>> > AFAIU, this changes the behavior of two above functions, and
>> > consequently of "bcb ab_select" command? If so, just to double check:
>> > were all users of those reworked correspondingly? I can see next
>> > occurrences (there may be more):
>> >
>> > $ grep -sIrHn '"_' boot/bootmeth_android.c
>>
>> I thought the same when first reviewing the patch.
>> Looking a bit closer...
>>
>> >
>> > boot/bootmeth_android.c:74:    sprintf(partname, BOOT_PART_NAME "_%s",
>> > priv->slot);
>> > boot/bootmeth_android.c:111:    sprintf(partname,
>> > VENDOR_BOOT_PART_NAME "_%s", priv->slot);
>> > boot/bootmeth_android.c:156:    sprintf(slot_suffix, "_%s", priv->slot=
);
>> > boot/bootmeth_android.c:397:    sprintf(slot_suffix, "_%s", priv->slot=
);
>>
>> ... We can see that ab_select_slot() returns an integer
>> That integer is used later on to initialize priv->slot:
>>
>> """
>>         priv->slot[0] =3D BOOT_SLOT_NAME(ret);
>>         priv->slot[1] =3D '\0';
>> """
>>
>> The change from Dmitry only changes what we **write** to the BCB (into
>> the misc partition), not what is returned by ab_select_slot().
>>
>
> Sure. Just wanted to double check that the behavior is not changed in
> any related parts, as the commit message doesn't mention that. Btw,
> BCB is an interface between the bootloader and AOSP, so if this patch
> changes what's being written into BCB, does it affect AOSP part of it
> somehow? Especially for already existing devices with particular BCB
> data, in case U-Boot gets updated there.

Those are valid concerns.

Per my understanding, on recent Android versions the slot suffix is not
read from BCB, but from the ro.boot.slot_suffix property:

"""
  // Initialize the current_slot from the read-only property. If the proper=
ty
  // was not set (from either the command line or the device tree), we can =
later
  // initialize it from the bootloader_control struct.
  std::string suffix_prop =3D android::base::GetProperty("ro.boot.slot_suff=
ix", "");
  if (suffix_prop.empty()) {
    LOG(ERROR) << "Slot suffix property is not set";
    return false;
  }
  current_slot_ =3D SlotSuffixToIndex(suffix_prop.c_str());
"""

See:
https://cs.android.com/android/platform/superproject/main/+/main:hardware/i=
nterfaces/boot/1.1/default/boot_control/libboot_control.cpp;l=3D185;drc=3D8=
6b8f575059a1799c760ca7012f540a528d68a9d;bpv=3D1;bpt=3D1

This has been the case since 2019.

If we look at earlier implementations of libboot_control (which was in
bootable/recovery)
https://android-review.googlesource.com/c/platform/bootable/recovery/+/1191=
517

So implementations before 2019 that do not have this patch:
https://android-review.googlesource.com/c/platform/bootable/recovery/+/1111=
899

Will get the slot suffix from the BCB (not from the commandline)

For these older implementations, we will go through the following:
BootControl::Init()
  LoadBootloaderControl(device.c_str(), &boot_ctrl)
  android::base::ReadFully(fd.get(), buffer, sizeof(bootloader_control)

And struct bootloader_control has:

struct bootloader_control {
    // NUL terminated active slot suffix.
    char slot_suffix[4];

And if we look at how the BCB is initialized from userspace in:
https://cs.android.com/android/platform/superproject/main/+/main:hardware/i=
nterfaces/boot/1.1/default/boot_control/libboot_control.cpp;l=3D120;drc=3D8=
6b8f575059a1799c760ca7012f540a528d68a9d

We can see that we copy _a, not a (for example, if slot =3D=3D 0).

So I think this is fine.

If needed, I can dig more for behaviour on older devices (<2019), let me kn=
ow!

>
>> ab_select_slot() still returns an integer which needs to be converted
>> via the BOOT_SLOT_NAME() macro.
>>
>> >
>> > $ grep -sIrHn 'slot_suffix _' include/configs/
>> > include/configs/ti_omap5_common.h:107:    "setenv slot_suffix _${slot_=
name};"
>> > include/configs/meson64_android.h:65:        "setenv slot_suffix
>> > _${current_slot}; " \
>>
>> Same goes for these 2 examples, we use:
>> The "bcb ab_select current_slot" command to store the slot into the
>> "current_slot" environment variable.
>> Looking at cmd/bcb.c we can see:
>>
>> """
>>         ret =3D ab_select_slot(dev_desc, &part_info, dec_tries);
>>         if (ret < 0) {
>>                 printf("Android boot failed, error %d.\n", ret);
>>                 return CMD_RET_FAILURE;
>>         }
>>
>>         /* Android standard slot names are 'a', 'b', ... */
>>         slot[0] =3D BOOT_SLOT_NAME(ret);
>>         slot[1] =3D '\0';
>>         env_set(argv[1], slot);
>>         printf("ANDROID: Booting slot: %s\n", slot);
>> """
>>
>> So I think this is fine.
>>
>
> [snip]
