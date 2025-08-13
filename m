Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EEFCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 14:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B76A82C84;
	Wed, 13 Aug 2025 16:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XDp5PkKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BB783641; Wed, 13 Aug 2025 16:25:20 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E0C803DF
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 16:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-88e373c07f8so1042903241.1
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755095117; x=1755699917; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oHiC26WguChm2nmXJtRIRsaLpJKv8WmO3DsYwW7s1yU=;
 b=XDp5PkKqte6Xlfvhb/EDtOLn9NlCMBys90b7sFOJlwuUEXUBvHcv5iBaqjgXNCvuDL
 382ODDuLghYL9EwNAeq/oDmDwKOaRnY8DNpYI1TFT8bJ6gk9BCQay3S6rK/k+9mS0ue4
 Z3dYWKVryWZjRt8tjEunX+yIvt0u6LAnG3htUvs1Vc7q6nNz6Tgish1O8bEePC8rb8qK
 +KJW5eEF3Q9ll2uGXF+G8b2k1yGbW1yqYPdZiIawjZ3O+XwbHU5P7xZf69CgrMLjFUCp
 5d95gOw9qtQElL0jSW5d553rlI4yYXbrzzoH3jUOKH0Xqw/iJoxlaC8KqSQogkZYaMGD
 RcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755095117; x=1755699917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oHiC26WguChm2nmXJtRIRsaLpJKv8WmO3DsYwW7s1yU=;
 b=C3R9DYK5EdIpXZDVTjdIFE/iNN0WM8PUDy8CYJ6vdOJxYAieJ4rVD3pjg0mx5Fw9QX
 h6F8lYhJWCQnv7zYhvHeL2IWg8k77zVoU92vQ3zfbtmogHiZsBHt/SV9NjDjNZ7ZBHTM
 yGl+Hkf4x8FyPYz/MRSzJCrW5taXHgsRm9Fz0uh/jZ6Rm67Uoe9qOYevVf+ahdLuT4Uu
 XGz0rHd1Kmo5GiceiAKLeYuz8sKW++qFhQEphVb0QtGYv6nz5mIPy21P5mSrEMQRVya2
 9BoqbgQkjQ1z3WbigcLn1FS27CBOx7i7q97SJV5r1HAPOvh5+q4g7Bcex9EAFsSM40Jc
 T9gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIDML+bVLvtmOb1k3eGY8Gw4vu3yaxVVjJU5/IeeGBbth8nHQp98czwF7Y/KHq65+CO5yZ2Mg=@lists.denx.de
X-Gm-Message-State: AOJu0YzU0+nf++aFXWIxj5pqadwtzDJPGsoWBy1+7K7jJkUTpv+qTqAD
 hESCzr0WUsDe1nbSeJ2QqhKHXyIEwBCoPbDUqXeVyLHyJLZsjb9gy/040bFjmdKy3feaVLUBAZA
 koWfP6sgBpQEmwu5l6uvIIpnXeUD0yYc=
X-Gm-Gg: ASbGncsdPw5AkvFVJY2/+Rdm8dEPYRjsJGb9I82jGvH4zREnio7CvlPqEyXaqrh05oV
 rV8CbYBeBPnP7uCbpYDFCNhqxmXRwDlrS7Y6RSgQ2Dh/tc5Q8EQR8g4gFeEiIYGIfo0Vm+fmyrP
 8RBLOSiYdji35fszNK4/SJueKZeCS9+aYsBrxPvm0XLDF+3bOUWTKZ0LqS8IdghmjPXxdiUoeL5
 0P9U7ES6w==
X-Google-Smtp-Source: AGHT+IFYIVLUkQMrKjf/2P2iHWWNDe04OR0rrKPPF6QePJ69tAOmJZKesv+moDzPrCs09tCaCoTuk/fwAAQkaqwUOko=
X-Received: by 2002:a67:f342:0:b0:4e2:aafe:1bde with SMTP id
 ada2fe7eead31-50e80e0b912mr779255137.9.1755095111763; Wed, 13 Aug 2025
 07:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <764f11e1-c269-4ad1-8d5e-6054de6eec4a@linaro.org>
In-Reply-To: <764f11e1-c269-4ad1-8d5e-6054de6eec4a@linaro.org>
From: george chan <gchan9527@gmail.com>
Date: Wed, 13 Aug 2025 22:24:59 +0800
X-Gm-Features: Ac12FXxza9QmZUnY73wbyeYh_vvEb2-f2Yj0FvvHwys9XEX1dFo-RIAPMMhS9X0
Message-ID: <CADgMGStoszaTWEsWbCa70g0twnYNbQBEqvfcm406h00wn3R0hw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] A series of patch for enable sc7180 android boot
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Vitalii Skorkin <nikroks@mainlining.org>
X-Mailman-Approved-At: Wed, 13 Aug 2025 16:54:04 +0200
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

[resend with full list, sorry for duplicated email]

Hi Casey,

Thanks for getting back with the the patch series.

=E5=9C=A8 2025=E5=B9=B48=E6=9C=8813=E6=97=A5=E9=80=B1=E4=B8=89 21:39=EF=BC=
=8CCasey Connolly <casey.connolly@linaro.org> =E5=AF=AB=E9=81=93=EF=BC=9A

> Hi George,
>
> Sorry for not getting around to this sooner, I got it mixed up with your
> other patch series!
>
> I think this is ready to go but there's a few checkpatch errors, can you
> run "b4 prep --check", fix the issues and then resend this and I'll pick
> it up for next.
>

i am afraid it is still have some sort of concern about the logic change.
So even through with respin....I suggested[1] to get those patches with
review-by to get in this round, and leave the yet-to-discuss as independent
patch later.

If you agreed with this arrangement then please git cherry-pick from this
series, or once found difficulty then let me know I can start a fresh new
series for you.

Thanks,
George

[1]https://lists.denx.de/pipermail/u-boot/2025-July/594610.html


> Thanks and regards,
>
> On 30/06/2025 09:56, George Chan via B4 Relay wrote:
> > Since attempt[1] to embed android specific boot param into fdt bootargs=
,
> > a new idea is formed as to make use of env file to contain default para=
m
> > value. Current code logic is already working fine, unless the priority
> > of param at begining is higher than at tail. From env file, bootargs is
> > treated important, and prepend at begining. So there is a need to
> > reverse the logic, and make sure default bootargs value at the end, and
> > let androidboot img bootargs value sit at begining.
> >
> > So a new kconfig item is introduced. Once enabled, the bootargs strcat
> > param will get reversed.
> >
> > A similar logic is needed for fastboot->bootm glue function, so split
> > function of patch #1 into 2 functions as #2, fixed some issues #3, and
> > apply #4 with same trick to glue function too.
> >
> > Some one-liners patch is included to enable device driver for sc7180
> > soc. It is about iommu for usb, usb gadget vendor/product id.
> >
> > Reduce dependency on abootimg when androidboot v3 or greater is not
> > needed. Since Tom suggested to reduce __maybe_unused directive and
> > use IS_ENABLE() instead; two __weak func proto need to add into image.h
> >
> > [1]https://lists.denx.de/pipermail/u-boot/2025-May/588828.html
> > [2]https://lists.denx.de/pipermail/u-boot/2025-May/589926.html
> >
> > Signed-off-by: George Chan <gchan9527@gmail.com>
> > ---
> > Changes in v4:
> > - Drop patch #3.
> > - Refine #2 to remove intermediate variables and code style.
> > - Link to v3:
> https://lore.kernel.org/r/20250628-sc7180-android-boot-v3-0-105098a19165@=
gmail.com
> >
> > Changes in v3:
> > - Collect acks-by and review-by.
> > - Split function and replace old #2 into #2-#4, code reuse in #4
> > - Modify changelog and Kconfig description of #1, suggested by Mattijs
> > - Slightly modify #5, add back line break.
> > - Rebase to latest next
> > - Link to v2:
> https://lore.kernel.org/r/20250607-sc7180-android-boot-v2-0-2df5d7f61124@=
gmail.com
> >
> > Changes in v2:
> > - Add new patch #2 that is same trick as #1 to fastboot->bootm glue
> layer.
> > - Remove default n to patch #1, suggested by Tom.
> > - Use IS_ENABLE() instead, suggested by Tom.
> > - Collect review-by from Casey and Neil.
> > - Rebase to u-boot/next branch.
> > - CCing myself too.
> > - Link to v1:
> https://lore.kernel.org/r/20250520-sc7180-android-boot-v1-0-3075a84ea094@=
gmail.com
> >
> > ---
> > George Chan (6):
> >       image-android: Prepend/postpend default bootargs value with given
> bootcmd
> >       boot/image-android.c: Split android_image_get_kernel into two
> functions
> >       bootm: Append bootargs value when bootmeth_android provide cmdlin=
e
> >       boot: bootmeth_android: Conditionally dependent on abootimg
> >       iommu: qcom-smmu: Introduce sc7180 compatible string
> >       usb: gadget: Introduce usb gadget vendor/product default id for
> ARCH_QCOM
> >
> >  boot/Kconfig                  |  9 ++++
> >  boot/bootm.c                  |  2 +-
> >  boot/bootmeth_android.c       |  2 +-
> >  boot/image-android.c          | 97
> ++++++++++++++++++++++++++++---------------
> >  drivers/iommu/qcom-hyp-smmu.c |  1 +
> >  drivers/usb/gadget/Kconfig    |  2 +
> >  include/image.h               | 14 +++++++
> >  7 files changed, 92 insertions(+), 35 deletions(-)
> > ---
> > base-commit: 490ae8ceae2d5999c9de863e014e463f5c1495a6
> > change-id: 20250520-sc7180-android-boot-a845ecf48a48
> >
> > Best regards,
>
> --
> // Casey (she/her)
>
>
