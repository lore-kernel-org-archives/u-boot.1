Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0127D5AE4C
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 03:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E26A988D29;
	Thu,  7 Nov 2024 04:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qF5E0MCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E796883D4; Thu,  7 Nov 2024 04:17:41 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0497888D29
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 04:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6ea339a41f1so4051087b3.2
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 19:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730949458; x=1731554258; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQtSDL3I+MXcDXRRveXBgA6B5E5VqBfEjy/H0NlIU7o=;
 b=qF5E0MCOAmr/JaXfbD25wduCHJbAa7Oa25FAHNd8ppsMiB4kFu70hiKy/O3Ua1AgPK
 2j56kJmbA8O9NOJp/9327X6mdVLA0g8q+xokldl5yup4X9P5BI7md9kbazp5wkwVjJHO
 +HKTVMFxn91myGVZVKzDRJkoWLQtL2e+aMBPJ1kM6jgoWppSziRO3Ihj1bltLuIICmx8
 dhn+SxdTCuEMRz0jwd34AUEliDxWvEfcup4v7x+0D91eKJb6Xb6oNonbcZOGaY+gTnJz
 gOY1FHZ5Z0MWOB+l+RauXz/m5XeG0KYoEEsQ8vhKflXOH/UKhCp1IORZrp1BKqwVPtgN
 xcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730949458; x=1731554258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQtSDL3I+MXcDXRRveXBgA6B5E5VqBfEjy/H0NlIU7o=;
 b=GX2ikM8nDOE/xhfthPy20TTMASS20x01Ty4S9VMuYhk8k0LUkhAeVXDeSrCm1Mbqlt
 eV6/xKbkpwhew/FJfzWg6wlZrJpCD1EK0vSxLNdCOuJyn0hQ62/JtzoDGyY7bSAEusGs
 aqtK4oW94ejgk7Huagta7jiE6zkKr6OPt0Pa39HLsiQKW7arDdwZhGtvv3WTevB0m7Fo
 3V6GpK23r4RkPK7qi+qeiaZVFfoQwImJoCkJO3owbdh/nyhbRATyBqLgOlbRZful6M94
 nthlyWrCGi9rkShBYHlyzi2Hj03QWL1tHeuygKRNU3hvYyf31B6GjxdZlQbXIVcMBn6g
 SNrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGpxJ/YFRPKFUDXd4wIj/UkbYNhLjgiR+yRqY+/6yQdyRcncjs5i2ZBqcKpYt7fcsamhvQus0=@lists.denx.de
X-Gm-Message-State: AOJu0YwUsZRGB3hF1JxSS4OaYi5unxyJvyX3RTTm2pSY15YKqqEWL+JH
 MXPBg+WUlrQn6QEBnaRh4pP5YTb/+ltcZKozZinLuy209rEroOFkgjH6/c6T9kHbUuTRP0bdzQE
 H+F0j2gGkTOXVRWkB3xRq936JC6nnU34F3S0BAg==
X-Google-Smtp-Source: AGHT+IHv9GNYd1GPo8eo4Yn9tgtLIHJcl5GZSikEpisUWhT44sOlol5ojTbwcycmsNizesos6h0nEjZf9ON5h/ibyuw=
X-Received: by 2002:a05:690c:4d09:b0:6ea:1f5b:1f64 with SMTP id
 00721157ae682-6ead11e3eacmr6254677b3.0.1730949457739; Wed, 06 Nov 2024
 19:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
 <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
 <87v7x1soto.fsf@baylibre.com>
 <CAPLW+4=-yPgMeDM5XRkBXR-nD4Ni2VtWqTKxJVVrfdU8g2sG4g@mail.gmail.com>
 <875xp08ysu.fsf@baylibre.com>
In-Reply-To: <875xp08ysu.fsf@baylibre.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 6 Nov 2024 21:17:27 -0600
Message-ID: <CAPLW+4=qt++B+wD6zvfsoCxgd=Jmygf7w=Wz71p3Z8GUOZS9oQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
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

On Wed, Nov 6, 2024 at 4:02=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Sam,
>
> On mar., nov. 05, 2024 at 18:58, Sam Protsenko <semen.protsenko@linaro.or=
g> wrote:
>
> > On Tue, Nov 5, 2024 at 9:06=E2=80=AFAM Mattijs Korpershoek
> > <mkorpershoek@baylibre.com> wrote:
> >>
> >> Hi Sam,
> >>
> >
> > Hey Mattijs,
> >
> > [snip]
> >
> >> >> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, s=
truct disk_partition *part_info,
> >> >>                  * or the device tree.
> >> >>                  */
> >> >>                 memset(slot_suffix, 0, sizeof(slot_suffix));
> >> >> -               slot_suffix[0] =3D BOOT_SLOT_NAME(slot);
> >> >> +               slot_suffix[0] =3D '_';
> >> >> +               slot_suffix[1] =3D BOOT_SLOT_NAME(slot);
> >> >
> >> > AFAIU, this changes the behavior of two above functions, and
> >> > consequently of "bcb ab_select" command? If so, just to double check=
:
> >> > were all users of those reworked correspondingly? I can see next
> >> > occurrences (there may be more):
> >> >
> >> > $ grep -sIrHn '"_' boot/bootmeth_android.c
> >>
> >> I thought the same when first reviewing the patch.
> >> Looking a bit closer...
> >>
> >> >
> >> > boot/bootmeth_android.c:74:    sprintf(partname, BOOT_PART_NAME "_%s=
",
> >> > priv->slot);
> >> > boot/bootmeth_android.c:111:    sprintf(partname,
> >> > VENDOR_BOOT_PART_NAME "_%s", priv->slot);
> >> > boot/bootmeth_android.c:156:    sprintf(slot_suffix, "_%s", priv->sl=
ot);
> >> > boot/bootmeth_android.c:397:    sprintf(slot_suffix, "_%s", priv->sl=
ot);
> >>
> >> ... We can see that ab_select_slot() returns an integer
> >> That integer is used later on to initialize priv->slot:
> >>
> >> """
> >>         priv->slot[0] =3D BOOT_SLOT_NAME(ret);
> >>         priv->slot[1] =3D '\0';
> >> """
> >>
> >> The change from Dmitry only changes what we **write** to the BCB (into
> >> the misc partition), not what is returned by ab_select_slot().
> >>
> >
> > Sure. Just wanted to double check that the behavior is not changed in
> > any related parts, as the commit message doesn't mention that. Btw,
> > BCB is an interface between the bootloader and AOSP, so if this patch
> > changes what's being written into BCB, does it affect AOSP part of it
> > somehow? Especially for already existing devices with particular BCB
> > data, in case U-Boot gets updated there.
>
> Those are valid concerns.
>
> Per my understanding, on recent Android versions the slot suffix is not
> read from BCB, but from the ro.boot.slot_suffix property:
>

That probably still leaves the possible combination of some devices
running new U-Boot versions (with this patch applied) together with
older Android versions. E.g. in case when U-Boot is updated but
Android isn't, may be especially relevant for some dev boards out
there.

> """
>   // Initialize the current_slot from the read-only property. If the prop=
erty
>   // was not set (from either the command line or the device tree), we ca=
n later
>   // initialize it from the bootloader_control struct.

So even in recent Android versions it's being initialized from BCB in
case the property is not set.

>   std::string suffix_prop =3D android::base::GetProperty("ro.boot.slot_su=
ffix", "");
>   if (suffix_prop.empty()) {
>     LOG(ERROR) << "Slot suffix property is not set";
>     return false;
>   }
>   current_slot_ =3D SlotSuffixToIndex(suffix_prop.c_str());
> """
>
> See:
> https://cs.android.com/android/platform/superproject/main/+/main:hardware=
/interfaces/boot/1.1/default/boot_control/libboot_control.cpp;l=3D185;drc=
=3D86b8f575059a1799c760ca7012f540a528d68a9d;bpv=3D1;bpt=3D1
>
> This has been the case since 2019.
>
> If we look at earlier implementations of libboot_control (which was in
> bootable/recovery)
> https://android-review.googlesource.com/c/platform/bootable/recovery/+/11=
91517
>
> So implementations before 2019 that do not have this patch:
> https://android-review.googlesource.com/c/platform/bootable/recovery/+/11=
11899
>
> Will get the slot suffix from the BCB (not from the commandline)
>
> For these older implementations, we will go through the following:
> BootControl::Init()
>   LoadBootloaderControl(device.c_str(), &boot_ctrl)
>   android::base::ReadFully(fd.get(), buffer, sizeof(bootloader_control)
>
> And struct bootloader_control has:
>
> struct bootloader_control {
>     // NUL terminated active slot suffix.
>     char slot_suffix[4];
>
> And if we look at how the BCB is initialized from userspace in:
> https://cs.android.com/android/platform/superproject/main/+/main:hardware=
/interfaces/boot/1.1/default/boot_control/libboot_control.cpp;l=3D120;drc=
=3D86b8f575059a1799c760ca7012f540a528d68a9d
>
> We can see that we copy _a, not a (for example, if slot =3D=3D 0).
>
> So I think this is fine.
>
> If needed, I can dig more for behaviour on older devices (<2019), let me =
know!
>

My point is, if it's possible to introduce this change but keep the
same old behavior (across both U-Boot and AOSP), it's usually better
to do that that way. If I'm not missing anything and that's a valid
concern, maybe a separate patch can be developed on top of the merged
patch series handling that. Anyways, I don't have enough time to work
on this right now, so just pointing out what I noticed, if it's useful
for anybody. I'll let the maintainers decide :)

Thanks!

> >
> >> ab_select_slot() still returns an integer which needs to be converted
> >> via the BOOT_SLOT_NAME() macro.
> >>
> >> >
> >> > $ grep -sIrHn 'slot_suffix _' include/configs/
> >> > include/configs/ti_omap5_common.h:107:    "setenv slot_suffix _${slo=
t_name};"
> >> > include/configs/meson64_android.h:65:        "setenv slot_suffix
> >> > _${current_slot}; " \
> >>
> >> Same goes for these 2 examples, we use:
> >> The "bcb ab_select current_slot" command to store the slot into the
> >> "current_slot" environment variable.
> >> Looking at cmd/bcb.c we can see:
> >>
> >> """
> >>         ret =3D ab_select_slot(dev_desc, &part_info, dec_tries);
> >>         if (ret < 0) {
> >>                 printf("Android boot failed, error %d.\n", ret);
> >>                 return CMD_RET_FAILURE;
> >>         }
> >>
> >>         /* Android standard slot names are 'a', 'b', ... */
> >>         slot[0] =3D BOOT_SLOT_NAME(ret);
> >>         slot[1] =3D '\0';
> >>         env_set(argv[1], slot);
> >>         printf("ANDROID: Booting slot: %s\n", slot);
> >> """
> >>
> >> So I think this is fine.
> >>
> >
> > [snip]
