Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A66BD1CA0F
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 23:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F4488DE6;
	Tue,  5 Nov 2024 00:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pmTJxgPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB2988E96; Tue,  5 Nov 2024 00:06:42 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E076888D29
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 00:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6e33c65d104so40503927b3.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 15:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730761599; x=1731366399; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uui/o0ZsYS5WVwOp/dS3baegzYPblc+/UJ7XOLxLFrE=;
 b=pmTJxgPUzDF+ReqzFUm6DbfS8h2U+9K+qoryhYl7s94fvNmHbPDUn1Qp9yESGDpQ4S
 4z+BBvCydei2/yV1MGye2eVfD7jZok0ZMpf+pYGeillSrja5oY/4Fdl+eFvwIHrBI84B
 kKUskSXHJR52hRqDIdqgqPIUV0nF6f/Dbgp3jHh1UXdPrsBbWW5iW5p8UFyfgeiPAihb
 bP8PT3W71et7cuwWcV7rGzdFP4sYkkLXGpAbQN6DTFae94gbHWULp+XhZhUcSZebgtcw
 Wl3c3qd8JqYUb7estyLPM7+odm3w3s4vwIhLLMwM4Bv8gSX5yBXmHl0gh+2KdPxOggzB
 7G9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730761599; x=1731366399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uui/o0ZsYS5WVwOp/dS3baegzYPblc+/UJ7XOLxLFrE=;
 b=PZ4XsZCMByVREqFxwrqVKPdMLMPV5ZGIqRc+sFpX+TsHvKBVJeVlL16EAGlTbNAjlE
 EPSJmIRiFLcA+WQjPDZ5kNMj8V3gA5wQWMZIqt5Wqyrh9oFqcSI7wWCznsmsuoeP5Hwb
 Nv4ue7RNDLvldEsLJmWb0HfzWfekVlCH8FSL0vgER493FWQSICJnrkjktqeMuR2b/dVm
 T2846CLHc6D+mpMVuB24EYEJppwJzLZyHO20jE8yYsu0DlPRIlvpDLbD8IvgTys3Usr7
 knRfTmG0IJBoe78wa7sAKHCs8Bxf0XXjLBWcv8MH0dFHaXaoJUOed3hGX+6Ife19HONP
 YLdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2qj4MOwKSSK0B30aibqvgiuOWtkwKn7hx32d7Fgb1wdgTlVhc1dgEP1QZW+4LH9wEZG0HquQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwGP7A1UDmZZJWetJcJe5Oy6NRcR77e8OpPHP2qqzlPbc7rhyaC
 Zq/JYdGsEyUH8b1J6xcJ/x9+g0axuzmtJuXoqGtwDNtVVx2Bg1zf0mDa3s8I1U3Ov8rvaWEr3fm
 UEh2tIoJRJyf0L2Of5c+Pw5osP1F+pM/ZrIyKDg==
X-Google-Smtp-Source: AGHT+IH1qy24gizr5lfA9Ah/no+7F4niJ4Ykm91JKYFlIgZ+6ZZzjhA/Jf0QNoJJiunbcgZXN/ZRxHKAs+ls0vKQEMA=
X-Received: by 2002:a05:690c:9a8c:b0:6ea:7198:fb64 with SMTP id
 00721157ae682-6ea7198fd57mr86239957b3.41.1730761598706; Mon, 04 Nov 2024
 15:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
In-Reply-To: <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 4 Nov 2024 17:06:28 -0600
Message-ID: <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
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

On Thu, Oct 17, 2024 at 9:12=E2=80=AFAM Dmitry Rokosov
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

Would be nice to add "Fixes:" tag here, pointing to the corresponding
commit where the issue was introduced (see kernel docs for details).
It could be quite useful for possible stable branches and other
purposes, I'd recommend to add that tag for all fixes if you have more
in this series.

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

AFAIU, this changes the behavior of two above functions, and
consequently of "bcb ab_select" command? If so, just to double check:
were all users of those reworked correspondingly? I can see next
occurrences (there may be more):

$ grep -sIrHn '"_' boot/bootmeth_android.c

boot/bootmeth_android.c:74:    sprintf(partname, BOOT_PART_NAME "_%s",
priv->slot);
boot/bootmeth_android.c:111:    sprintf(partname,
VENDOR_BOOT_PART_NAME "_%s", priv->slot);
boot/bootmeth_android.c:156:    sprintf(slot_suffix, "_%s", priv->slot);
boot/bootmeth_android.c:397:    sprintf(slot_suffix, "_%s", priv->slot);

$ grep -sIrHn 'slot_suffix _' include/configs/
include/configs/ti_omap5_common.h:107:    "setenv slot_suffix _${slot_name}=
;"
include/configs/meson64_android.h:65:        "setenv slot_suffix
_${current_slot}; " \

>                 if (memcmp(abc->slot_suffix, slot_suffix,
>                            sizeof(slot_suffix))) {
>                         memcpy(abc->slot_suffix, slot_suffix,
>
> --
> 2.43.0
>
