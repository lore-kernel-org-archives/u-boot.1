Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98296E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 11:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 171B380269;
	Wed, 18 Dec 2024 12:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g/Il5aO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E13FB80243; Wed, 18 Dec 2024 12:00:13 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C0A68029E
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 12:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso37036685e9.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 03:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734519609; x=1735124409;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HM72NDA2JTSBstoq2kmREdLcJP7hC6YSwmTxjN/6G2U=;
 b=g/Il5aO1aY+eNWL4yb3EGqalwv2nH6QlOsyWiGRuup1Bq+goieOppCd8rLBAxgb6qu
 bksI2JWhN2iiLDyCoSZ9A2ZHl4hJLYSf0Ak5vy8rCRGoclAlJeSaTGqFdiaQ5+iOF2kJ
 2dmtG32McxpFUvEkRvoFSpPt32XfELf/17T9CoG/Ud9ffOKYJCsLQM6uIqeBoXxVy1oy
 E0gTLRE8pvstv5EEdw48keJzv2sgdIijj4+HO9qKq60sRk/Mh6GOS+qlPiUf/UGJcwsd
 TOmdfc8tLlJNTFTlq2qP45hz8wmHrzJerv+zkyry4I/6JqOQBTm6ABM/6vUUXhcokfKe
 wGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519609; x=1735124409;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HM72NDA2JTSBstoq2kmREdLcJP7hC6YSwmTxjN/6G2U=;
 b=BndCRQl2uOlE+jRErJ0hvi/DOi7fRgcUuOUKsasm/KcScPEuS9ETwe3jfxtNWz7Lox
 Er2XF2lMQxVgtxxFfRv4bJEu385vaMYy8E+f3g1qOg/TZWwY/t8xG0EVEmY3ZYVmTdM/
 WEiLJs4DW13fthKUjPiF7Illh7k4wO1kk7qDHPXXelreaOMIBYnS5qQ55ttWp0S5daTV
 jbfUeghnGZ51I3t9fnQAi7mcQlFrTqr/uRkKUGq5T/2N9rb1LJd9JjrVTuP6Lx6ORtHd
 aVUT9g2oxM+16MtcCBaD81p3kptGXbe+cSeww7fR/ujt0DcO4ms9ykrmUw8qFZiAqHus
 16+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmPvhIPtHebvJ8K/6IOq6Ku+PTaoUcrzJertrSmvoGDOyj8bAt3H6FYdJvimGYUtddbCHyZAU=@lists.denx.de
X-Gm-Message-State: AOJu0YyQsB/OHYr3ADI1aSZct3jsTji4cWdWhP8BrReqqoEvNkycflfH
 41qK15xJ7ynT64s2EnjBPv+MnBk9X7SghxTvaL6SpuSxO8tB3KKLgDJP2I4cPHo=
X-Gm-Gg: ASbGncvlzyA77Eb7zxKBEC4H/gZ/8q8IQAss3KHBhWvoZ09cgvEZexjSn1/sSijAxvJ
 B08MpphCdhtN3W7RLrSDHmcFxwGISANZ08nAocBKUsw90i3oykVZg5BJbTX9yOBmE8wQvYCS4it
 foyqzypo2fmHnchrjjvMV6LajHt4yFtPazn4XME4B+oiaJVDknaSUJF4VDp0qy4ZftFFCbTHqDz
 GmDC7xQeBNUOGstM9U22YEpNrLfduQ1fea8b4cx9oGufPgRUpaXY4L5hmE1DBNl7g==
X-Google-Smtp-Source: AGHT+IFX/dO/txCfIkZBJu2TveSMmNMzedfNSxyxDR11BdPadwmVbbJrApubP3plWJ3TgbMOmZCS/g==
X-Received: by 2002:a05:600c:4f55:b0:434:fdbc:5ce5 with SMTP id
 5b1f17b1804b1-43655405847mr16908585e9.29.1734519609546; 
 Wed, 18 Dec 2024 03:00:09 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119d7sm16626135e9.20.2024.12.18.03.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 03:00:09 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 rogerq@kernel.org, nm@ti.com, u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH 2/4] board: ti: am62px: env: include environment for DFU
 Boot
In-Reply-To: <g7pupq6leeait24a4uqf3toncr5knxl2ffjvxtqesp4uymacdq@c3vsv5ee5mdt>
References: <20241217131658.2920799-1-s-vadapalli@ti.com>
 <20241217131658.2920799-3-s-vadapalli@ti.com>
 <87y10dwbxr.fsf@baylibre.com>
 <g7pupq6leeait24a4uqf3toncr5knxl2ffjvxtqesp4uymacdq@c3vsv5ee5mdt>
Date: Wed, 18 Dec 2024 12:00:08 +0100
Message-ID: <87msgtw91j.fsf@baylibre.com>
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

On mer., d=C3=A9c. 18, 2024 at 15:44, Siddharth Vadapalli <s-vadapalli@ti.c=
om> wrote:

> On Wed, Dec 18, 2024 at 10:57:36AM +0100, Mattijs Korpershoek wrote:
>
> Hello Mattijs,
>
>> Hi Siddharth,
>>=20
>> Thank you for the patch.
>>=20
>> On mar., d=C3=A9c. 17, 2024 at 18:46, Siddharth Vadapalli <s-vadapalli@t=
i.com> wrote:
>>=20
>> > Include the TI K3 DFU environment to support DFU Boot and DFU Flash.
>> > Also add "usb" to the list of "boot_targets".
>> >
>> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> > ---
>> >  board/ti/am62px/am62px.env | 5 +++--
>> >  1 file changed, 3 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
>> > index 7ef54079aa8..e0838196e3a 100644
>> > --- a/board/ti/am62px/am62px.env
>> > +++ b/board/ti/am62px/am62px.env
>> > @@ -1,5 +1,6 @@
>> >  #include <env/ti/ti_common.env>
>> >  #include <env/ti/mmc.env>
>> > +#include <env/ti/k3_dfu.env>
>> >
>> >  name_kern=3DImage
>> >  console=3DttyS2,115200n8
>> > @@ -7,7 +8,7 @@ args_all=3Dsetenv optargs ${optargs} earlycon=3Dns1655=
0a,mmio32,0x02800000
>> >  	${mtdparts}
>> >  run_kern=3Dbooti ${loadaddr} ${rd_spec} ${fdtaddr}
>> >
>> > -boot_targets=3Dmmc1 mmc0 pxe dhcp
>> > +boot_targets=3Dmmc1 mmc0 usb pxe dhcp
>> >  boot=3Dmmc
>> >  mmcdev=3D1
>> >  bootpart=3D1:2
>> > @@ -17,4 +18,4 @@ rd_spec=3D-
>> >  #if CONFIG_BOOTMETH_ANDROID
>> >  #include <env/ti/android.env>
>> >  adtb_idx=3D3
>> > -#endif
>> > \ No newline at end of file
>> > +#endif
>>=20
>> This change seems un-related, is it needed?
>
> My editor automatically adds a newline, thereby fixing the warning/error
> regarding the absence of a newline. I assume that a newline is expected.
> Please let me know if you want me to undo this in the v2 series.

This is editor dependant. I'm not sure if there is a coding style entry
for having a newline present/absent.
I'm in favor of keeping the newline addition, however, please mention
it in the commit message.

Something between the lines of "while at it, also add a missing newline
to the am62p.env file".

>
>>=20
>> Also, looking at Martyn's/Sjoerd's series, I see a couple of things
>> missing:
>> 1. Documentation. now that am62px is compatible with the
>>    am62x_r5_usbdfu.config fragment, we need to document this in the board
>>    docs. See: commit def64b493748 ("doc: board: Add document for DFU boo=
t on am62x SoCs")
>
> I planned on documenting it once this series got merged. The reason
> behind it is that I was unsure if the device-tree patch in this series
> will be accepted or will be asked to be enabled via the Linux DT Sync
> process. In the latter case, documenting this feature will be incorrect
> in the event of a partial merge (i.e. the documentation patch gets
> merged but the device-tree patch doesn't).

Hmm, I'm not the one deciding if [PATCH 4/4] will get applied so I can't
chime in on that. However, I think it's good practice to send the
documentation changes along with the code changes. Otherwise, doc
updates might be forgotten/de-prioritized.

I won't block the series if doc does not get send, though.

Maybe for future submissions, you can consider writing this in the cover
letter:

"Since i'm unsure that PATCH 4/4 will be accepted, I've decided to send
the documentation changes in a future series"

>
>>=20
>> 2. Including configs/am62x_a53_usbdfu.config in configs/am62px_evm_a53_d=
efconfig.
>>    This is how it's done for am62x, see:
>>    commit dfc2dff5a844 ("configs: am62x_evm_*: Enable USB and DFU suppor=
t")
>>=20
>> Note that If we don't do 2), we cannot use USB gadget from a U-Boot that
>> has been booted over DFU:
>>=20
>>     =3D> fastboot usb 0
>>     No USB device found
>>     USB init failed: -19
>>     =3D> usb list
>>     USB is stopped. Please issue 'usb start' first.
>>     =3D> usb start
>>     starting USB...
>>     No USB controllers found
>>     =3D>
>>=20
>> For 2, this diff fixes it:
>>=20
>> diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_d=
efconfig
>> index 9635beb1b27e..81f433c997b5 100644
>> --- a/configs/am62px_evm_a53_defconfig
>> +++ b/configs/am62px_evm_a53_defconfig
>> @@ -183,3 +183,4 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
>>  CONFIG_EFI_SET_TIME=3Dy
>>=20=20
>>  #include <configs/k3_efi_capsule.config>
>> +#include <configs/am62x_a53_usbdfu.config>
>>=20
>> In my opinion, 2) is a valid use case:
>> 1. On a blank board, we boot the bootloaders over DFU
>> 2. Once U-Boot is started, we start fastboot to flash all images to eMMC.
>>=20
>> Could this be added for v2, please?
>
> Sure, I will include it in the v2 series. Thank you for reviewing this
> patch and sharing feedback.

Make sure to check that am62px_evm_a53_defconfig does not contain any
duplicate entries with the dfu fragment, like:

CONFIG_USB_GADGET_MANUFACTURER=3D"Texas Instruments"
CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6165

>
> Regards,
> Siddharth.
