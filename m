Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE38C83F12
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 12:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E101C88B8F;
	Thu, 29 Aug 2024 14:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IXza1ByX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D763088B94; Thu, 29 Aug 2024 14:39:35 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F0D88B31
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 14:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d863c34496so129494a91.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 05:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724935172; x=1725539972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TpKmntfkQ0ZGa8OvjCIyNLk7WGL3zPNGASEWW+749xY=;
 b=IXza1ByX9poFsewUrKgl19RxZP2ofwBPcvwmR/35mWHWqWZYjiM+szaEMAeedwqjy/
 TuD/XrIviqnLBROz2cOFIlv45CHnh76aUqfwMvs5Y3+ewLs5qUuxEEaXpwhvcehbs5Y1
 SHUpGvj4C1AyBo3HhAoqBlTTjKOT63ebndWVel4zmnpIsHfp2PQnm//gbgA2QwvJNnZ0
 uPp5R2XupAGr9embztOt+2r9+fK6IVQ6mu7SCwrDbFgOPYXynUNXtFyrFHOxI/Hg1wGE
 FbhqBNyah/w10sIifplmty5asDYZbkfMZ5enfjx9qR3AqamR5LScG7oyH/31X2PFCN2o
 lXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724935172; x=1725539972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TpKmntfkQ0ZGa8OvjCIyNLk7WGL3zPNGASEWW+749xY=;
 b=OG8GKThkNirzhZLezsUqtRsZpn/Ffl3ci2dCenVRlXsREtRBu79jgn7+AaxBUhn9rl
 4HGBvNh5IdwI2PC8MAmsOYO4DP7vL64K1bLj8rmkOZyCywegodOpuuY931xSPmsggdAx
 6SzzOeWooIZZi3shduM5nM1ydLNHCy64w9cfo4m033Cqbc8zZXJjOWjPV0yPUzgbpq3v
 WBgO+VbLsrfAJIJcDoBRh3tyQXdjk4wu1kAM6puU8e2cW8SQCMqKU0U0sfUh8Aasm9jA
 LIcCKbDwYE4TZyhaKowfSb3jhd7HFigQUgkvSOcmqnYR2HMuq4ORXxrbJQRORqyaoSHU
 BZLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlx1OI3s+8aPQcPCbzhETdOTkUzuxEZmq9e/hUDPJxz32QfSJWNxj9zl/f/a42ryU95gaWTkI=@lists.denx.de
X-Gm-Message-State: AOJu0YxuoNLp/L0AXpfmvaO09809BsA3xgxWVv/PxAVVz5i0zC6DTICn
 0RMUQy4Y4fkL7dI2V2EVma+LraGJwZYrub8lCsNnfAI0rUKPi5gO0Sf9SxIHqB+L1ZPJAVgo+WL
 5yH7RP3q7DRajaw0Qe1cqUMgeLNQwoWcWyESM0X+jS579o73l
X-Google-Smtp-Source: AGHT+IG0CaWqSns1K+Ov9fOHBSkQIW0lSm80yI7dbCtZCCRVeekORgNI3nnobXswEG3J9VqoAm8Q5ZcmlizBB3+Y3G8=
X-Received: by 2002:a17:90b:4a06:b0:2d3:b748:96dd with SMTP id
 98e67ed59e1d1-2d8561e24e0mr2727536a91.25.1724935171443; Thu, 29 Aug 2024
 05:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-3-sjg@chromium.org>
 <CAC_iWj+6CqPCxN8jSNJSzGiprd+sAw25ooQRaAf=t=Sdio67=A@mail.gmail.com>
 <CAFLszThVpvHO8Jt2Mz1WB80=fDtYpzieo1eR4k2Jj=e37Gb87g@mail.gmail.com>
 <CAC_iWjJJFygaws2ciBDMT=JJ4yMzhQC41T_Tg1RKFvrxzRTTyw@mail.gmail.com>
 <CAFLszThsVcFwSe39geTeE=6bbJqK0bUT6kEYjULkOuNjO51e+Q@mail.gmail.com>
 <CAC_iWjKPTv6Yzb6cQD=eJtC7Wm3bTC+cyaCUSmDXaWUySByoYw@mail.gmail.com>
 <Zs7Ubog171uwz8jn@hades>
 <CAFLszTgNnmyKFC5XKPieFoqT1J6aerYkD=qOof3tZ_V25SrO-A@mail.gmail.com>
In-Reply-To: <CAFLszTgNnmyKFC5XKPieFoqT1J6aerYkD=qOof3tZ_V25SrO-A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Aug 2024 15:38:54 +0300
Message-ID: <CAC_iWj+EO4L+Pu-QzWPDJL5=A1JNzDx13SKfvNZZcjkzVXn2Ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi: Convert device_path allocation to use malloc()
To: Simon Glass <sjg@chromium.org>
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

On Thu, 29 Aug 2024 at 15:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 28 Aug 2024 at 01:40, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > [...]
> >
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > >
> > > > > > > What about https://lore.kernel.org/u-boot/CAFLszTjLAKaYK_jLXJ7Z571L-QMtoiqE-oxHCRs186dZ2Qok5g@mail.gmail.com/
> > > > > > > ?
> > > > > >
> > > > > > Yes, I reordered the patches in this series.
> > > > >
> > > > > You don't need to reorder them. As Heinrich already pointed out some
> > > > > of these functions are used in EFI protocols. e.g
> > > > > duplicate_device_path() requires the memory to be allocated by EFI
> > > > > memory services, you can't just replace it with malloc.
> > > >
> > > > The pointers returned can be freed with EFI services. I don't see any
> > > > problem here. All the tests pass and all the spec rules are followed,
> > > > so far as I can tell.
> > >
> > > Where exactly does that happen in the current patch?
> > >
> > > efi_alloc() calls efi_allocate_pool() and when we need to free the
> > > device path we are calling efi_free_pool()
> > >
> >
> > Looking at it again, this wasn't very clear. The previous patch converts
> > efi_allocate_pool() to use malloc. So this patch is not needed at all
>
> That's right, but ultimately I'd like to drop efi_alloc() and the only
> other place it is used is once in lib/efi_loader/efi_bootmgr.c

Right, then the right thing to do here is to replace efi_alloc() with
efi_allocate_pool() which will be calling malloc in the end. That way
we are free to change the efi_allocate_pool implementation in the
future without affecting the functions described on the spec

Thanks
/Ilias


>
> Regards,
> Simon
