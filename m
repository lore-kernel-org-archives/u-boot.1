Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67125D40D13
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 00:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F1388A1C;
	Wed,  6 Nov 2024 01:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WvNohygm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA7A88C44; Wed,  6 Nov 2024 01:58:21 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D1F8852D
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 01:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6ea5b97e31cso3838407b3.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 16:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730854698; x=1731459498; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0T625n7xhdhvD5r9zXSr9RDqmz7giA2s8bSypQmLkQ=;
 b=WvNohygmOomdnP6avE+vyMBbk4DdCbFazqjYSjn6W4Vv+Dox5NqggL6jVMuuBwDn6X
 vacqHYEo+YU6mtfDB3/8hXSb5kbi0HytOlQuGRhdAuW1dXniZB2zwJL/sreRVzIbveZV
 z4Kd+c2TSDalaL1SoAJ1Ir/KIqw8IEr89ZQNfrJsH17Pqr7g5ndZRrGn2o25C+tyoXP6
 /WSw4TmN4KM84XjISdlAGzKb/ExAwom4kZ3FcX3nk3ReW167jsyDgYY+rzv6byi/GOTd
 PgsgrCEkK2tBdncie0F3fQJGxCodIlGSBhI7Ebq00yldIrA1sw2iXAjPFzpeFIYNyfgE
 EscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730854698; x=1731459498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0T625n7xhdhvD5r9zXSr9RDqmz7giA2s8bSypQmLkQ=;
 b=hFvqIY6sKaPrmJpf5X2Bzwct3b4MBRcoRAEl/TOPGasWcgkBZF/Yszy1/O45OOFesN
 A1vXVekU7XH17MJ0/cSkU4GccJWg6d+zZFipfvrMg/L9CwmmIm6tHeSOUfMBLdF4qDpK
 75GJDkJ0qF177PyrrrgdjA4tIC2k+r+Mc1QmTdDmD2wy93l5GNVm6bJprjomRUle0fGU
 KAhMPhwmwRkk7RWapfk3SZVbWTnmSvm9LHhN61bXsg7j3vuu0rvB3iBdAEXFp6LuF782
 Pv7lTTyD62Pj+tF4KmvvFrQm6dNyu0YMhe/d9OZ0NbJknZIH/X6WlAjrqwI4LKPQxyf/
 fZEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnkbjXYuH199P7zye5w2hUY5rLx8KvlCyTI9PUCwclsstloydll7gSunI2UNEi5q5L0VBCRt4=@lists.denx.de
X-Gm-Message-State: AOJu0YwgSvnmzOZK3LoDbv2ZpZgSwJL0P8/Rl4sEvhw9HdrarD4Y1mud
 3mSZq49zQ7Ro1kOl2i1xnQc3L/YTolZiI7jxKkb9IEDIFdNFAeRy7NXITRAqTTEGGhgUAPTSFDQ
 AYywi17jUskS7GaMM4sfp8t2bN8+NgRllgiGBlQ==
X-Google-Smtp-Source: AGHT+IGMRCuceF+eAofYz263lImLlyi0T3K6Bygh/KHtwRTW1Ys7zsjs/I6pK1YRFz3W+z0u5r7v6zWuQVXd5wgs3OE=
X-Received: by 2002:a05:690c:3382:b0:6ea:88d4:fd4f with SMTP id
 00721157ae682-6eabf04814cmr5414917b3.18.1730854698192; Tue, 05 Nov 2024
 16:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
 <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
 <87v7x1soto.fsf@baylibre.com>
In-Reply-To: <87v7x1soto.fsf@baylibre.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 5 Nov 2024 18:58:07 -0600
Message-ID: <CAPLW+4=-yPgMeDM5XRkBXR-nD4Ni2VtWqTKxJVVrfdU8g2sG4g@mail.gmail.com>
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

On Tue, Nov 5, 2024 at 9:06=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Sam,
>

Hey Mattijs,

[snip]

> >> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, stru=
ct disk_partition *part_info,
> >>                  * or the device tree.
> >>                  */
> >>                 memset(slot_suffix, 0, sizeof(slot_suffix));
> >> -               slot_suffix[0] =3D BOOT_SLOT_NAME(slot);
> >> +               slot_suffix[0] =3D '_';
> >> +               slot_suffix[1] =3D BOOT_SLOT_NAME(slot);
> >
> > AFAIU, this changes the behavior of two above functions, and
> > consequently of "bcb ab_select" command? If so, just to double check:
> > were all users of those reworked correspondingly? I can see next
> > occurrences (there may be more):
> >
> > $ grep -sIrHn '"_' boot/bootmeth_android.c
>
> I thought the same when first reviewing the patch.
> Looking a bit closer...
>
> >
> > boot/bootmeth_android.c:74:    sprintf(partname, BOOT_PART_NAME "_%s",
> > priv->slot);
> > boot/bootmeth_android.c:111:    sprintf(partname,
> > VENDOR_BOOT_PART_NAME "_%s", priv->slot);
> > boot/bootmeth_android.c:156:    sprintf(slot_suffix, "_%s", priv->slot)=
;
> > boot/bootmeth_android.c:397:    sprintf(slot_suffix, "_%s", priv->slot)=
;
>
> ... We can see that ab_select_slot() returns an integer
> That integer is used later on to initialize priv->slot:
>
> """
>         priv->slot[0] =3D BOOT_SLOT_NAME(ret);
>         priv->slot[1] =3D '\0';
> """
>
> The change from Dmitry only changes what we **write** to the BCB (into
> the misc partition), not what is returned by ab_select_slot().
>

Sure. Just wanted to double check that the behavior is not changed in
any related parts, as the commit message doesn't mention that. Btw,
BCB is an interface between the bootloader and AOSP, so if this patch
changes what's being written into BCB, does it affect AOSP part of it
somehow? Especially for already existing devices with particular BCB
data, in case U-Boot gets updated there.

> ab_select_slot() still returns an integer which needs to be converted
> via the BOOT_SLOT_NAME() macro.
>
> >
> > $ grep -sIrHn 'slot_suffix _' include/configs/
> > include/configs/ti_omap5_common.h:107:    "setenv slot_suffix _${slot_n=
ame};"
> > include/configs/meson64_android.h:65:        "setenv slot_suffix
> > _${current_slot}; " \
>
> Same goes for these 2 examples, we use:
> The "bcb ab_select current_slot" command to store the slot into the
> "current_slot" environment variable.
> Looking at cmd/bcb.c we can see:
>
> """
>         ret =3D ab_select_slot(dev_desc, &part_info, dec_tries);
>         if (ret < 0) {
>                 printf("Android boot failed, error %d.\n", ret);
>                 return CMD_RET_FAILURE;
>         }
>
>         /* Android standard slot names are 'a', 'b', ... */
>         slot[0] =3D BOOT_SLOT_NAME(ret);
>         slot[1] =3D '\0';
>         env_set(argv[1], slot);
>         printf("ANDROID: Booting slot: %s\n", slot);
> """
>
> So I think this is fine.
>

[snip]
