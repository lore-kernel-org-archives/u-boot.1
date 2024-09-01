Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9C8C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B76D288706;
	Sun,  1 Sep 2024 22:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sc7+Qwi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B4788970; Sun,  1 Sep 2024 22:09:52 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50CA787DEA
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5df9dec9c0eso2413965eaf.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221389; x=1725826189; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UMt4+jNqd9HlfxTVNMeuOmTc8VAaJ0piew4DiziAFs0=;
 b=Sc7+Qwi+Ay9vCgBda5CygyXm/VKhWMMy+iRGN3Q3piuht5G+odHBJwRS21y2hKKrJ2
 YCpWg9JAvoTj5o5F4FZfW6a2K+B0KXXwNfrCLe9KLu6NHTvhSilCsmPxJBnbiRerLWBO
 TjcvrmBQktN/uoABw0T3VyDJFI9aNSnFx3jfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221389; x=1725826189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UMt4+jNqd9HlfxTVNMeuOmTc8VAaJ0piew4DiziAFs0=;
 b=a4xS9qO3mvOchoUer/gagToJOWCeyDoLAK99307POKLIYMoNVjv3QzP+GqDohnXPik
 M12swQ5iU2lxw8X/y8nw1VNiT7Y6hDbeqNC+/mpTxlRwq+5FU2JKp90HnGEhXDMgrawL
 hulq85OHImlnldXMedBXWu6+BLF8qFrSpVengLZfp9wQVzAC7NZ4/iymI4wMBmRW03lR
 5Zjj16Ka9YInSRUVUUZrAXu4EMAVwI04yrfGGtriQVzYKD/Jk2ddpcgvimIixt8Q5OWa
 1ht9ADlXo9PsCUVJ3qN5Y8o5gkOYUtr5ygeMeiW5Brsp5o3UgvmblwGyE/Nn1NPLxeSA
 NFEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4/VAzieWpIzmN98QnTkYeTJYI77+RkuUv4lslLHTP2hXh/5tT3AkNfY3TI5GRwXGDw6swvGM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywu/y4CiHVNTkZ6b4F+sU2u6pbLtD1xI2IaQd8LpqNjXqNyqdVy
 o81dz2kq/bYfnmgU3Z9bxAi8+YbiLbLKYoTa1GgmzukDe/NawNrSmLP6E0OgdK9Q8nCfUjD/02H
 gmpDntKuuASZEuIx5zXo5OvreBuTRWPQ/QcY5
X-Google-Smtp-Source: AGHT+IFsZNNUSn+YetcyASM3QdYsRukgeqayi6dvtOwL5PxAZQkyXJ52iu5VtUFAoz51JPSyroo9xSA5HnZWo20Ur00=
X-Received: by 2002:a05:6358:e4a9:b0:1ad:282:126d with SMTP id
 e5c5f4694b2df-1b7ef6c80cfmr700084555d.12.1725221388945; Sun, 01 Sep 2024
 13:09:48 -0700 (PDT)
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
 <CAFLszTi+QjPANqTREqO8NoXEh_Mqy8fraFS2Uq6qirKSGhcOxQ@mail.gmail.com>
In-Reply-To: <CAFLszTi+QjPANqTREqO8NoXEh_Mqy8fraFS2Uq6qirKSGhcOxQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:38 -0600
Message-ID: <CAFLszThGJVd6RFcmu_8RNXCfOWK=QzsyyTLkJ6Lg9_SBOkTA_w@mail.gmail.com>
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

On Thu, 29 Aug 2024 at 08:14, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 29 Aug 2024 at 06:39, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 29 Aug 2024 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 28 Aug 2024 at 01:40, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > [...]
> > > >
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > (no changes since v1)
> > > > > > > > >
> > > > > > > > > What about https://lore.kernel.org/u-boot/CAFLszTjLAKaYK_jLXJ7Z571L-QMtoiqE-oxHCRs186dZ2Qok5g@mail.gmail.com/
> > > > > > > > > ?
> > > > > > > >
> > > > > > > > Yes, I reordered the patches in this series.
> > > > > > >
> > > > > > > You don't need to reorder them. As Heinrich already pointed out some
> > > > > > > of these functions are used in EFI protocols. e.g
> > > > > > > duplicate_device_path() requires the memory to be allocated by EFI
> > > > > > > memory services, you can't just replace it with malloc.
> > > > > >
> > > > > > The pointers returned can be freed with EFI services. I don't see any
> > > > > > problem here. All the tests pass and all the spec rules are followed,
> > > > > > so far as I can tell.
> > > > >
> > > > > Where exactly does that happen in the current patch?
> > > > >
> > > > > efi_alloc() calls efi_allocate_pool() and when we need to free the
> > > > > device path we are calling efi_free_pool()
> > > > >
> > > >
> > > > Looking at it again, this wasn't very clear. The previous patch converts
> > > > efi_allocate_pool() to use malloc. So this patch is not needed at all
> > >
> > > That's right, but ultimately I'd like to drop efi_alloc() and the only
> > > other place it is used is once in lib/efi_loader/efi_bootmgr.c
> >
> > Right, then the right thing to do here is to replace efi_alloc() with
> > efi_allocate_pool() which will be calling malloc in the end. That way
> > we are free to change the efi_allocate_pool implementation in the
> > future without affecting the functions described on the spec
>
> OK, that sounds good and it will make it clearer which things are
> internal memory allocations and which are presented to the app as
> things that it can free. The spec doesn't mention the pool, but I
> assume that is implicit.

OK, so it turns out that this increases code size, since the EFI call
has more parameters. So I think the best thing to do is just leave
efi_alloc() alone (or perhaps use it more consistently). For now I can
drop the memset() in there, which seems to serve no purpose and is
confusing.

I'll send a v3 of this series.

Regards,
Simon
