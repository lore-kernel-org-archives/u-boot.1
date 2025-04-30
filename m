Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C398DC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 19:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CF08007D;
	Wed, 30 Apr 2025 21:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XJoFrscd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDF9800D7; Wed, 30 Apr 2025 21:15:41 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3598004F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 21:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so24528566b.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746040539; x=1746645339; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I2qdKcy5vrHHWZC7Bp9opAry5kvqCavIfWTc1FysOLg=;
 b=XJoFrscdd47j+1Pip7ynKHfx7y11klM6p9b68Qo2HJvVXkH8mHKTr677zxrdYHsUzg
 hCU1lXLAbI3ceNd1qT3eN2j0KopqJxp02s6vyrMA/zSmXVrfnxCrV2V4LGgK0jLaPs+X
 azPgNNH1vaZtcq4v6rrbDtF2WMgzOqTAnUOw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746040539; x=1746645339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2qdKcy5vrHHWZC7Bp9opAry5kvqCavIfWTc1FysOLg=;
 b=FPrWWZOPyNDHUQZWK9zG9K8a+H16A2caAdK7CS3qSRBPHczA3nN5aKgz/pK+HxJKzR
 Bhg+PNGOFrliXpuSYBfzCu6UtkSSxf6T/smkegwrvjMaxpJY3azjfYwVh+mLhsnyzZjJ
 enA0U607PmfrET5+S3r57Glg44kWokpfQrdJh8ER14rpvm7fQ/gFFmv01Ic9FOfbFjuc
 efahhcuLcAkfBqU1b6K47PSek692euKfCpqOnb1mYctsFWUyEaVTERSmnjFNCM+0rQZJ
 Xot94hSzTPVoQwp1yoAYPz4NhIMYarXygC1MfAoFc4rGKOa8pfdVgdX0gQR/kckqPPRL
 WLqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKFXqAzVS9I4FlhSQy/O/1XCu/eu5RxcoxT4SatqN58mEGkFyeQ1FxhMOLoDqhCydvlW32F1o=@lists.denx.de
X-Gm-Message-State: AOJu0YyrM6pP6H55+ux0ZRw/l0zFbMcRvGYuGywRMgHmuljgQ93cEyNq
 ea9bqT+jPFjRUUghMOhnTMxhlpQfjt1Yblp7oU5hayB4RCXUnb79B6hZpe586P4KGRbWtqztHWC
 2FJXG0g8Hp+yAOD2WPONhbgNNJoK6m7dPE//r
X-Gm-Gg: ASbGncvVOdYI9ONgqm4wjGfWTYgInM507tKIZlm8BgJ2Rlwg/VVmnB+ZkV31tj+MTqI
 3Cz8zuhvX/ZDL182deM21NircWtaFOsBwHWUYW8X8SPV8fzndprcCVTwo3jp4RR/RuBLnhYgA9H
 OIEDtJSlMvJA3DuTA47pUp7Xw=
X-Google-Smtp-Source: AGHT+IGpOOyav4QiXCYpdzkYZ9W8D+ymlaq61D18wyokTXe6pDY4lKM0Hibru1iPS+WC2ZC0GshPTrvcdplx56sMC1c=
X-Received: by 2002:a17:907:9494:b0:ace:d4f8:b687 with SMTP id
 a640c23a62f3a-acee21aebb0mr411044966b.20.1746040538666; Wed, 30 Apr 2025
 12:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250430105546.327442-1-heinrich.schuchardt@canonical.com>
 <CAFLszTiGDHWpEEhZZ_uN5KEjc52huun3U93qomaK8o2RZW1sUA@mail.gmail.com>
 <d7b41927-e375-4f85-b4fd-cda39defd9e3@canonical.com>
 <CAFLszTiEKdf2F6=jomTfxj-cmECefxmwd=MQ3drsP0pNC-4oFQ@mail.gmail.com>
 <0ce6f15b-7fb9-46d6-b06f-15174d318e79@canonical.com>
In-Reply-To: <0ce6f15b-7fb9-46d6-b06f-15174d318e79@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 13:15:25 -0600
X-Gm-Features: ATxdqUGqlacc0kGyfXHfgCVhSnWAJLqPp7IE_kpqJ8os5J9bfDwuqulLItfCp_g
Message-ID: <CAFLszTgRfa6ER-UtpfSyKRkTQWrY_ZBvUU905+wn5T=sVjC3=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] bootm: pass kernel load address not entry point for
 IH_OS_EFI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Wed, 30 Apr 2025 at 09:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 30.04.25 17:01, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, 30 Apr 2025 at 08:04, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 30.04.25 15:54, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Wed, 30 Apr 2025 at 04:55, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> The EFI sub-system needs the load address and not the entry point
> >>>> to boot the binary passed from the bootm command. The entry point
> >>>> is derived from the PE-COFF header of the binary.
> >>>>
> >>>> Fixes: ecc7fdaa9ef1 ("bootm: Add a bootm command for type IH_OS_EFI")
> >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>> ---
> >>>>    boot/bootm_os.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> >>>> index dc9d3e61fca..a3c7cb5332e 100644
> >>>> --- a/boot/bootm_os.c
> >>>> +++ b/boot/bootm_os.c
> >>>> @@ -498,11 +498,11 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
> >>>>           /* We expect to return */
> >>>>           images->os.type = IH_TYPE_STANDALONE;
> >>>>
> >>>> -       image_buf = map_sysmem(images->ep, images->os.image_len);
> >>>> +       image_buf = map_sysmem(images->os.image_start, images->os.image_len);
> >>>>
> >>>>           /* Run EFI image */
> >>>>           printf("## Transferring control to EFI (at address %08lx) ...\n",
> >>>> -              images->ep);
> >>>> +              images->os.image_start);
> >>>>           bootstage_mark(BOOTSTAGE_ID_RUN_OS);
> >>>>
> >>>>           ret = efi_binary_run(image_buf, images->os.image_len,
> >>>
> >>> In this case ep should be set to image_start as it is with many
> >>> methods. How come it isn't in this case?
> >>
> >> As described above the entry point is encoded in the PE-COFF header.
> >>
> >> What makes you think that a user would set it in an its file containing
> >> an EFI binary?
> >>
> >> If it where set, it would point to an address after the load address and
> >> not to the start of the PE-COFF header.
> >>
> >> The proper design would completely remove load and entry addresses in
> >> FIT images and use LMB for memory allocation.
> >
> > You are missing the point entirely.
> >
> > However the image calculates the entry point is up to that image. But
> > the correct entry point should be put into ->ep
> >
> > We can't have some OS--booting functions using ->ep and some using ->os.load
> >
> > So please dig in a little more and fix whatever is going wrong here
> > and ensure that ->ep is set correctly. If you need help, please ask.
>
> The only information that the EFI sub-system cares about is the start of
> the image. That information is in os.start_image.
>
> Field ep is for the entry point and not for the start of the image and
> EFI should never take it from the FIT meta-information.
>
> This is why whatever value I put into the field entry of my handcrafted
> its file is completely irrelevant.

As discussed, we should split efi_binary_run() so that we can do the
loading. For now:

Reviewed-by: Simon Glass <sjg@chromium.org>
