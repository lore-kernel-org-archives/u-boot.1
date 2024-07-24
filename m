Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C02AC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0778288938;
	Wed, 24 Jul 2024 16:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SBdEsN5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E5188962; Wed, 24 Jul 2024 16:39:40 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2259C8889B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6678a45eaa3so66951877b3.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721831977; x=1722436777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B+TwOllwrTNDAn0VcamQyXsrV6o+bKXGw00+KIEWg4o=;
 b=SBdEsN5EjH07uEBXmgfLEg9b7pf0xhOTc26i2vNTRNnYZh7hOHu6fVKgpTFPMIlyXS
 3UC2vxnH7th38vtcrQEv3UGJrSn5Ezzdcg3UUW/Qmv/zU7q1d9gRsjgpsdijuFlviOsu
 pZ0lwpZYFDXPUL8d1lZrLc3ZCmZQyNYBZpKn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721831977; x=1722436777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+TwOllwrTNDAn0VcamQyXsrV6o+bKXGw00+KIEWg4o=;
 b=AsgBcDynAzZAK99OA6X3zSAxZff12qYZa1Pc42t7LifhAEsuIWSrydmTNFCW7xpceA
 /kP62T/acsHN1AwOOCdqb4V/YtlBcCPAGA5M6AVny3uO0S/i1rVnuhd6qWaoOodYa9DL
 1mCFWXQ3+ptGXvNln3E7Tu4OHqrkYO1o1rdnM61cCP/C29o/PKbHDSUtq5FnWrvZTzxr
 mRCe+eRWt3OX8HbkqtZeFG9F2KamYYmqtv7I27IFjwyetH21q7qhU6vnlPTYOkTda+iv
 3wKUueuR7oRNj0n0IvOaBmo+HGdMImRuhuo8WV2kIlGyTynVfAVGO1a4UHoJTWzKUvgW
 pReg==
X-Gm-Message-State: AOJu0YzlhiCVrHVNFQtNEsK3DNGpVLLmIZoiBj1cFn6erv7hAFlaC3YH
 wTE/tUxqybYCo2n2iVX07+HHHX5k6xkSuDs8RslKia1mp1bVxbk5wHFWCHf+2+UvM8JPV+GluiJ
 HYzPeuIeJ4hNmXM9VWWqeNxXMBdUuaBWLUouA
X-Google-Smtp-Source: AGHT+IG3t1D71oh+mDEpU81hrJRHqKFSTv/s2kKPqaHpKeD0n+Hj+WY/7KR1x0B2MzcYXJmnztF2MRJ9nb/6a30byj4=
X-Received: by 2002:a05:690c:101:b0:64b:2f31:296b with SMTP id
 00721157ae682-6727962c4d0mr37789307b3.4.1721831977072; Wed, 24 Jul 2024
 07:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-3-sjg@chromium.org>
 <68cb1acb-fa61-4bdb-b109-2fad64726158@cherry.de>
In-Reply-To: <68cb1acb-fa61-4bdb-b109-2fad64726158@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 08:39:26 -0600
Message-ID: <CAFLszTjGcQqRJ8HdtL2a_d1op6Kda9q6b08ue4WtXxzjXO+_1A@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] spl: Correct use of CMD_BOOTI and CMD_BOOTZ
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
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

Hi Quentin,

On Mon, 22 Jul 2024 at 07:11, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 7/21/24 5:25 PM, Simon Glass wrote:
> > These should have a CONFIG_ prefix. Add it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 7a0d88076b9 ("Add in the ability to load and boot an uncompr...")
> > Reviewed-by: Sean Anderson <seanga2@gmail.com>
> > ---
> >
> > (no changes since v1)
> >
> >   common/spl/spl.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index 7794ddccade..6f4a8bfb3f4 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -322,7 +322,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
> >   #endif
> >
> >   #if CONFIG_IS_ENABLED(OS_BOOT)
> > -#if defined(CMD_BOOTI)
> > +#if defined(CONFIG_CMD_BOOTI)
>
> Maybe use IS_ENABLED(CMD_BOOTI) instead?

IS_ENABLED(CONFIG_CMD_BOOTI) I assume. Sure, but I don't think it
matters as they are equivalent.

>
> >               ulong start, size;
> >
> >               if (!booti_setup((ulong)header, &start, &size, 0)) {
> > @@ -336,7 +336,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
> >                             spl_image->load_addr, spl_image->size);
> >                       return 0;
> >               }
> > -#elif defined(CMD_BOOTZ)
> > +#elif defined(CONFIG_CMD_BOOTZ)
>
> Ditto?
>
> In any case,
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Though.... i'm wondering why we are checking for CMD_BOOTI in SPL in the
> first place?

I suppose it is to enable a feature in SPL only if it will be used in U-Boot?

>
> >               ulong start, end;
> >
> >               if (!bootz_setup((ulong)header, &start, &end)) {

Regards,
Simon
