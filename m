Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703F5C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 15:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7DB48215F;
	Wed, 30 Apr 2025 17:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ivf4D2j+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6224482B9D; Wed, 30 Apr 2025 17:01:28 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6047A8215E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so1441586766b.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746025286; x=1746630086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iv2RMbtzfTXOhI6JwgXW97ZV1SpSKtjFIN09aLYIcU4=;
 b=Ivf4D2j+brxdHO3mrXI9INUQdqPuyIRuwWH1Vr68Dg6MZhULbkesfoV73Db8GuSGYn
 8DRq9LzPpC/QiQ27TNaBFkSmgiMTSk0u81nPFrbdUnVOJwYgnRYQ9OnpPDX42sqXRtHx
 jpSjj3Q0ebO5PR5MFKisbNjqcV/P+rHckmYyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025286; x=1746630086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iv2RMbtzfTXOhI6JwgXW97ZV1SpSKtjFIN09aLYIcU4=;
 b=S1sKT4u+Ne27qTWK7zadk0n+a1T6jdc2Xr+Rc9oktt5MWG3RJbd6M3rHS8AqidtoXY
 rH+WCkjvA1/fNDilPtB5/ayb1dxr1SiZ19wsTjJKMAi6O13LDi/sadqKK90KXw+F2Cdl
 T27mhitwJhe57X+AHu+5sHCwUDcy0vMof7xoNifhaP0gqA6AtlhusAND/2DmhQN7hdwu
 +51lQ4kNaIgqdsuzbDPtv2EmkY0wQheO7SeGI9EhBxrTFo0QfjOKCuFFcT0GRJauE/av
 EKsqPqhWZk/ODQ0VzCHkYxdyWjtcX3RrYImhCtG3VEY2r48qSjNzYql01v1JXiKtTR6Z
 shZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcP9WP63R65dqXiopg0tcUSmQ/PARuYiucriEEFx3KyWiFBaOgce3+V5frfybk91rBqUtaAoU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyn5uKfQ34qVsS+geLtzo7hM381QE6EZRS9wGXTkOYCvx2isreQ
 Mnf2R1b3wHVjDvCGW2ftI9GqeIt1eIlYLgv/88PNOPMGGDldw03ROUf3szjdSWbajcRc+zL4jSo
 T/1fxe12gekz9h+auP+IZt1aAcj6WW5izrTIV
X-Gm-Gg: ASbGncszC62YmIE5yujpiOxJZHoUn+bye3vdAWL+qupzp5iqS38IEZ75U7DRg3U6wxe
 mP8uHtGqheLnveD2jZNn2BxIId2bCrOzgEiSiLIbJP7hvunmaGnpulNk7vEpoGfztpvYNLDNysI
 1CAJID/h5BjMz+sGcbArbOOEHpblboFsZBqA==
X-Google-Smtp-Source: AGHT+IGtX3oJ9vbEGPAsxen/YGfa1TZkbcqa/E0ez9Yq0Z+X94fylxkSGII/s7fXZWpuIGh76t65dE/qRf4pCC5EI6U=
X-Received: by 2002:a17:907:6d15:b0:acb:4cd7:2963 with SMTP id
 a640c23a62f3a-acee241c417mr316410566b.33.1746025285616; Wed, 30 Apr 2025
 08:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250430105546.327442-1-heinrich.schuchardt@canonical.com>
 <CAFLszTiGDHWpEEhZZ_uN5KEjc52huun3U93qomaK8o2RZW1sUA@mail.gmail.com>
 <d7b41927-e375-4f85-b4fd-cda39defd9e3@canonical.com>
In-Reply-To: <d7b41927-e375-4f85-b4fd-cda39defd9e3@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 09:01:12 -0600
X-Gm-Features: ATxdqUEyCiEIZkqLSYOJ4RgPGcDCi9cqFhCeWXGMPYtJ44uDmdTmEl18bYqCA2U
Message-ID: <CAFLszTiEKdf2F6=jomTfxj-cmECefxmwd=MQ3drsP0pNC-4oFQ@mail.gmail.com>
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

On Wed, 30 Apr 2025 at 08:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 30.04.25 15:54, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, 30 Apr 2025 at 04:55, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> The EFI sub-system needs the load address and not the entry point
> >> to boot the binary passed from the bootm command. The entry point
> >> is derived from the PE-COFF header of the binary.
> >>
> >> Fixes: ecc7fdaa9ef1 ("bootm: Add a bootm command for type IH_OS_EFI")
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   boot/bootm_os.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> >> index dc9d3e61fca..a3c7cb5332e 100644
> >> --- a/boot/bootm_os.c
> >> +++ b/boot/bootm_os.c
> >> @@ -498,11 +498,11 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
> >>          /* We expect to return */
> >>          images->os.type = IH_TYPE_STANDALONE;
> >>
> >> -       image_buf = map_sysmem(images->ep, images->os.image_len);
> >> +       image_buf = map_sysmem(images->os.image_start, images->os.image_len);
> >>
> >>          /* Run EFI image */
> >>          printf("## Transferring control to EFI (at address %08lx) ...\n",
> >> -              images->ep);
> >> +              images->os.image_start);
> >>          bootstage_mark(BOOTSTAGE_ID_RUN_OS);
> >>
> >>          ret = efi_binary_run(image_buf, images->os.image_len,
> >
> > In this case ep should be set to image_start as it is with many
> > methods. How come it isn't in this case?
>
> As described above the entry point is encoded in the PE-COFF header.
>
> What makes you think that a user would set it in an its file containing
> an EFI binary?
>
> If it where set, it would point to an address after the load address and
> not to the start of the PE-COFF header.
>
> The proper design would completely remove load and entry addresses in
> FIT images and use LMB for memory allocation.

You are missing the point entirely.

However the image calculates the entry point is up to that image. But
the correct entry point should be put into ->ep

We can't have some OS--booting functions using ->ep and some using ->os.load

So please dig in a little more and fix whatever is going wrong here
and ensure that ->ep is set correctly. If you need help, please ask.

Regards,
SImon
