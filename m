Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D62EC83F2A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE10E888DD;
	Thu, 29 Aug 2024 16:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HsMzwgcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4C288B94; Thu, 29 Aug 2024 16:14:45 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1872987F19
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7cd967d8234so438652a12.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940881; x=1725545681; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+bmGmUKq0QGRFjHq1UnJMuqBpOfffX11AC0Fr/BpbWo=;
 b=HsMzwgcBUkWWzrE2WtxHGUU1ugX5JEJo+OkqwbSbkEHWIg86cmiUwm3kMhNPc8/BLK
 mLxGAa5gmygnaPeeYmlJ0uKtPL4BKneBlbnKLcMaHGSZ1nmmmUYiADMXjxtkbC1Nq3ZF
 IgAATRYvaEkbaLOxc1c1Zcl4+EQv2vLEM8WW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940881; x=1725545681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+bmGmUKq0QGRFjHq1UnJMuqBpOfffX11AC0Fr/BpbWo=;
 b=USr1aymFxqYwXi8tRm4NcRKcIb3jpXiMG0xLyh8cfef3RT5VJcvZvnix8FRwsg2vpH
 IXvV8BgPlqptyLDzOqNI0ypDGm97Kum4IUorPv73T+Wi+tDzOvOEr+FxtSNK4H+UAmaK
 aqE8EscPzvPtfZ5AL3ccOGYSea75GUhzJWYfspHQu4rfvi209XeiEt6iBK/BvNIweXzK
 OwyHHspDk7c5Uz6ngPxEfWxjQFW9OqSA0LKQxvuHp6pDvTMWBlEwARQnjUTDTJdI9CgT
 PAK/rEPru55lvBuISo2CPCA9pqs3VZTNM5Vvyui9hRxaudpmRqbML4y4Pc4hsTQpCrbP
 WHrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCImnUiug+IZ477taA0j/+nYIxLAYf6+mQqQ3agFTbSeMLSOO4pafYn89fTlKTKfBg4Djt5Rg=@lists.denx.de
X-Gm-Message-State: AOJu0YxYaPCLp/pHxCe0rPrqTQy5f5XnXs5/7z1vx1DgT4kY11R3AFqp
 RwgnDB/2PNZS+sglsgD44SvYLTBHjFLTyLirOEMsjqtznw12nHR5JriI7w57IVyW+8cUImKS2mx
 6QuibZd2MvSHVcuEQDJqpZYcwuig2i4PWdG5hZlKmiSTjjoI=
X-Google-Smtp-Source: AGHT+IEtPSvVJ4WhwCKG2AyqF+yoOnXZ4D/sFD+BAYIDO99WpshBuOWXE9ChYuVRhMAcQEBQ1aXfrD7wuiVAYy9FGOY=
X-Received: by 2002:a05:6a21:1304:b0:1c4:8bfd:4321 with SMTP id
 adf61e73a8af0-1cce10aef48mr2670142637.34.1724940881505; Thu, 29 Aug 2024
 07:14:41 -0700 (PDT)
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
 <CAC_iWj+EO4L+Pu-QzWPDJL5=A1JNzDx13SKfvNZZcjkzVXn2Ow@mail.gmail.com>
In-Reply-To: <CAC_iWj+EO4L+Pu-QzWPDJL5=A1JNzDx13SKfvNZZcjkzVXn2Ow@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:14:30 -0600
Message-ID: <CAFLszTi+QjPANqTREqO8NoXEh_Mqy8fraFS2Uq6qirKSGhcOxQ@mail.gmail.com>
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

On Thu, 29 Aug 2024 at 06:39, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 29 Aug 2024 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 28 Aug 2024 at 01:40, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > [...]
> > >
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > > What about https://lore.kernel.org/u-boot/CAFLszTjLAKaYK_jLXJ7Z571L-QMtoiqE-oxHCRs186dZ2Qok5g@mail.gmail.com/
> > > > > > > > ?
> > > > > > >
> > > > > > > Yes, I reordered the patches in this series.
> > > > > >
> > > > > > You don't need to reorder them. As Heinrich already pointed out some
> > > > > > of these functions are used in EFI protocols. e.g
> > > > > > duplicate_device_path() requires the memory to be allocated by EFI
> > > > > > memory services, you can't just replace it with malloc.
> > > > >
> > > > > The pointers returned can be freed with EFI services. I don't see any
> > > > > problem here. All the tests pass and all the spec rules are followed,
> > > > > so far as I can tell.
> > > >
> > > > Where exactly does that happen in the current patch?
> > > >
> > > > efi_alloc() calls efi_allocate_pool() and when we need to free the
> > > > device path we are calling efi_free_pool()
> > > >
> > >
> > > Looking at it again, this wasn't very clear. The previous patch converts
> > > efi_allocate_pool() to use malloc. So this patch is not needed at all
> >
> > That's right, but ultimately I'd like to drop efi_alloc() and the only
> > other place it is used is once in lib/efi_loader/efi_bootmgr.c
>
> Right, then the right thing to do here is to replace efi_alloc() with
> efi_allocate_pool() which will be calling malloc in the end. That way
> we are free to change the efi_allocate_pool implementation in the
> future without affecting the functions described on the spec

OK, that sounds good and it will make it clearer which things are
internal memory allocations and which are presented to the app as
things that it can free. The spec doesn't mention the pool, but I
assume that is implicit.

Regards,
Simon
