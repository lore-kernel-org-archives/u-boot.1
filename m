Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A01ED30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F10F89688;
	Fri, 18 Oct 2024 16:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kW3Ugpoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5FEA89677; Fri, 18 Oct 2024 16:56:22 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E37589276
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbf340fccaso18080746d6.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263350; x=1729868150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dynJT2c1H1FK/eA6IqZ8+JL4KBEZqrkUJBe0wiIzZ+Q=;
 b=kW3UgpojBaqnDL1LKKR+4eTu6/29fHsmpL+eQMYxA7hHHKceJPinX01eD/g3kpLWJg
 B2ku9O9KHr66oUAb4GtikSviKwlHBEyMH+gMkyc5Q7K+AhmGFIhjDxqSfr4sB3tA8VbW
 0eDj4G+MfUbEJmYKLe4n1BIhxx+bs8gXSf2+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263350; x=1729868150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dynJT2c1H1FK/eA6IqZ8+JL4KBEZqrkUJBe0wiIzZ+Q=;
 b=WXVNwA4oPEQJNgaegYhApF1uw0sm8KxRI7bf0/Bwe6BqbuPMzUYlHVTS3I1qam9NoQ
 iuEbkec7OTQxb369jkQrCTQC0F3kizIN1plIJnt30qZ7ZulDPja6atScOHOX+ic0dDrr
 T6iSKeAmJAVnpr7oLYdSYj/r6hsNerL0Xn47spFaGMqq3VqGmGRiZLCAqQTEoLjrM+6T
 b3W0FoBzr8MA9FG+idupggXszCMgOTGGdY1ymSRruROjkgga9h1h1q/KuO69lYYKym8s
 xLd9Z3zeVKIb4LCwIwyRpLhOXTK4ZJUGTBHrslqUg04mfqFOwgqB7lOlRKeNH+nQslMQ
 5A7A==
X-Gm-Message-State: AOJu0Yxx/EABr/RxI89Pa4COJYhheKb7NDg+GvmaM8gTe1GTmudXL7Fq
 2VOQXKr/dHmNVBt1KdYVJmy/b6NLeRlPx+sP/zDCLn88RNU5Cmvz2VZLIe9F/8ZArJKcYIyiUg1
 5F5u/mHiFbgV2woYxKwtxcwXzFA6Jqv5bfJpU
X-Google-Smtp-Source: AGHT+IGGIKZHyKEGy0COmpVlBOmU+Q7/PCbX5icim1xPRDpw6jMJ/Es+n10RPPeXf3Fb1VlGQbRo8gm9GAzBlEwInY0=
X-Received: by 2002:a05:6214:daa:b0:6cb:c845:ed0f with SMTP id
 6a1803df08f44-6cc378a9291mr113409026d6.17.1729263350456; Fri, 18 Oct 2024
 07:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-17-sjg@chromium.org>
 <877ca5hjfc.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <877ca5hjfc.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:55:39 -0600
Message-ID: <CAFLszTgsyBj-GWxoiLEXrmm3-ouGua9vB8i46P9LFsHUk85Z8Q@mail.gmail.com>
Subject: Re: [PATCH 16/34] image: Add a new type for EFI apps
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, marex@denx.de, mkorpershoek@baylibre.com, 
 maximmosk4@gmail.com, raymond.mao@linaro.org, sughosh.ganu@linaro.org
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

Hi Mark,

On Fri, 18 Oct 2024 at 03:03, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Thu, 17 Oct 2024 17:23:55 -0600
>
> Hi Simon,
>
> > Add an image type for EFI applications, which U-Boot supports reading.
>
> Not necessarily a bad idea, but what would the image type be of a
> Linux kernel that is also an EFI application?  See:
>
>   https://docs.kernel.org/admin-guide/efi-stub.html

Hmm that's a good question. That is one of the challenges with EFI,
that we don't know what we are booting. Is there a way to tell whether
an EFI app is a kernel, or not?

For PXE/extlinux we have a 'kernel' line and in that case I set it to
IH_TYPE_KERNEL

>
> Cheers,
>
> Mark
>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/image.c    | 1 +
> >  include/image.h | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/boot/image.c b/boot/image.c
> > index cf16fb7fbf7..b13644b03dc 100644
> > --- a/boot/image.c
> > +++ b/boot/image.c
> > @@ -184,6 +184,7 @@ static const table_entry_t uimage_type[] = {
> >       {       IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
> >       {       IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
> >       {       IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configuration" },
> > +     {       IH_TYPE_EFI, "efi", "EFI applicaiton" },
> >       {       -1,                 "",           "",                   },
> >  };
> >
> > diff --git a/include/image.h b/include/image.h
> > index 606e7d49169..a04925aa829 100644
> > --- a/include/image.h
> > +++ b/include/image.h
> > @@ -233,6 +233,7 @@ enum image_type_t {
> >       IH_TYPE_RENESAS_SPKG,           /* Renesas SPKG image */
> >       IH_TYPE_STARFIVE_SPL,           /* StarFive SPL image */
> >       IH_TYPE_EXTLINUX_CFG,           /* extlinux configuration-file */
> > +     IH_TYPE_EFI,                    /* EFI PE image */
> >
> >       IH_TYPE_COUNT,                  /* Number of image types */
> >  };
> > --
> > 2.34.1
> >
> >

Regards,
Simon
