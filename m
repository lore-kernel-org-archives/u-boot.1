Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B7DC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88A7D88C98;
	Thu, 15 Aug 2024 22:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DCn203Ta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE0A88C6E; Thu, 15 Aug 2024 22:35:05 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9884088B63
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2d3b36f5366so1002553a91.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754101; x=1724358901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iDkfiOFe/1W5lEkbsy+OFxpYcJMqT6S21CDmPble5S0=;
 b=DCn203TapbyD8G1oKefAaqB/S3eunDPbKkLCbtQX+RGlYySJWHetWNpxXKZJCHs7S5
 dsxppcKCTu/JMwFf3pQnG5o8WHU7Kg8Wm1ozsGWdfTtg7Kl8Yp8HwYMSZVVGgUgIrT06
 wrA6Qlis/RO3W/gSVrl8rPQomkWs65vZElq9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754101; x=1724358901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iDkfiOFe/1W5lEkbsy+OFxpYcJMqT6S21CDmPble5S0=;
 b=ZVuRjfGZPQnnIG7EmW36j+A9Q9scagBwKoz1LkdeUuKtMMaZVD4kYvulHNaj7mx3RF
 CvGM3NBbBSGA6+eWUOuGxWPEpHQKdL+f54USBmtS53VUJmd7gkQpVPEyJjl48dWRs11V
 JxAvFI9zr/ASR8Bbc7hxHkygYMyfHvP8vjscBwzEUXLjE5hdOBDCylZGjEcXP0b44mrt
 3qpQO/5759fO8yFqHPUFB69MEL9BGXEfBSmQYtaWuA9UBOzMs6u2IYKQBJkIAH4AWfwl
 eRe1dpOxijt+V5XGlRk2blD5W2CttDDR8NzhiO7yzyp7y66nYqS7R7+mRFbN1J6Iljv7
 F/zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu78tgsdwDJ7X+bgnAKO8xfyXtZ/8GZ0xZEZZA7WsLGxTHEjtykzGZI06avL3DM3G4wB28BLLuwAczjW6faCLhXKoOiQ==
X-Gm-Message-State: AOJu0YwstUrpcFRCCW9oqlYGUZroGrfxECTXUoQ3HZubtAD/0ZHXdyfQ
 69nO8pudSBVovCMJ98nvFRbD3LBB85+dlRxA8jRCmDLTRgPKYcUiUF3DyXapsPH3Eq4SPbnt/xa
 r+fPTW+yxcN8WbY8UNkOaKfMT86/hdmCyUjn9
X-Google-Smtp-Source: AGHT+IFnMlC0OhT+AXsl0oaQ9eZwNveHGCK+OrNwHDygTjumaVAJJd+6UrjhRtSV2UMfryQdPLkgnDjYvdrSUKr7spA=
X-Received: by 2002:a17:90a:bc97:b0:2d3:c863:cf16 with SMTP id
 98e67ed59e1d1-2d3dfff5d4bmr909299a91.33.1723754101168; Thu, 15 Aug 2024
 13:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-3-sjg@chromium.org>
 <CAC_iWj+6CqPCxN8jSNJSzGiprd+sAw25ooQRaAf=t=Sdio67=A@mail.gmail.com>
 <CAFLszThVpvHO8Jt2Mz1WB80=fDtYpzieo1eR4k2Jj=e37Gb87g@mail.gmail.com>
 <CAC_iWjJJFygaws2ciBDMT=JJ4yMzhQC41T_Tg1RKFvrxzRTTyw@mail.gmail.com>
In-Reply-To: <CAC_iWjJJFygaws2ciBDMT=JJ4yMzhQC41T_Tg1RKFvrxzRTTyw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:34:49 +0100
Message-ID: <CAFLszThsVcFwSe39geTeE=6bbJqK0bUT6kEYjULkOuNjO51e+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi: Convert device_path allocation to use malloc()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Ilias,

On Wed, 14 Aug 2024 at 07:07, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Wed, 14 Aug 2024 at 15:40, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 14 Aug 2024 at 05:03, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 1 Aug 2024 at 20:36, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Currently this calls efi_alloc() which reserves a page for each
> > > > allocation and this can overwrite memory that will be used for reading
> > > > images.
> > > >
> > > > Switch the code to use malloc(), as with other parts of EFI, such as
> > > > efi_add_protocol().
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > >
> > > What about https://lore.kernel.org/u-boot/CAFLszTjLAKaYK_jLXJ7Z571L-QMtoiqE-oxHCRs186dZ2Qok5g@mail.gmail.com/
> > > ?
> >
> > Yes, I reordered the patches in this series.
>
> You don't need to reorder them. As Heinrich already pointed out some
> of these functions are used in EFI protocols. e.g
> duplicate_device_path() requires the memory to be allocated by EFI
> memory services, you can't just replace it with malloc.

The pointers returned can be freed with EFI services. I don't see any
problem here. All the tests pass and all the spec rules are followed,
so far as I can tell.

Bear in mind that I am changing the *implementation* of some memory
routines, but not in a way that is visible to clients.

I will send a v2 with things split up a bit more, so long as we
remember that the EFI patches cannot be applied until the non-EFI
patches land.

Regards,
Simon
