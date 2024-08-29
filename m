Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D65C83F0A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 12:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F7C88B94;
	Thu, 29 Aug 2024 14:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XgaPabJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E33288B86; Thu, 29 Aug 2024 14:17:59 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1104D88B31
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 14:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf784346b9so3074976d6.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 05:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724933876; x=1725538676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e1vHReszTXPOpqxk5+PuUrDkF2daUJFP18nhZB9PNIY=;
 b=XgaPabJAyUAycuY9SuHiAqbVmvtv3nF1prbQJ+2FbVr7byFcM4w0dh+ueZE9rGYcX7
 Zdab/5q2CpVS9H4z69czVlh+C5tvOafLPeeySCS3MVyl8t01tjGirXCSUWrHpE9jMfsW
 zBh0I1lhmcxHJfT7I3huikX6iplJMmiH584eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724933876; x=1725538676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e1vHReszTXPOpqxk5+PuUrDkF2daUJFP18nhZB9PNIY=;
 b=WCc/y2u5uCrQorLrSm6GwV6ibSIj6VebnwJlCP4NUAl8/CNCxNVFMHiE8m5VgLkHWg
 VC9GPjKpp40y2e/pM7xJD9/afvbD9cjeuXWBkujUtFGCIhRhCwHCfokrKU+N/dXp2L30
 QN2w2bjn2p3M+HLOHz8A6ESyMbkkG1LUTtK8OJhbd9jBHthCMDcPQd4WyYf1at/VQeN7
 dzLNs4o18FYqEju0GXvEH0URDypnHbEh2zByuhDg1WLT4kd10QkiAEO4g8D6uxrCBReR
 cy7ulxTB+DjK5f0m/CtLRks8LrMqD0Lt24q2LwTmh7Pu3KyrefSk5NxeU6b+yAnSH5lP
 HIWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAnKHaftxKBq0IVhYOE0eeYyjdTJHEhms7SN0fo2lEeQePkszRzc5u1Z0uYCuvXLbUP/9nETQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxTU9mY8Xsq0rtYb55JEmwx2MOp2G6kJynjjgPtz4HcA0Ss12SV
 aBvO/RK8LCe3luja5u1q+n7s/b37xuSZozczR2JD4I4zXpKzEUsx6f9kH/7YT6ZfRKrdywIbwPp
 1R3MJhvcIjJxfKhjO5J3i/Fwm0nEk49GwZpku
X-Google-Smtp-Source: AGHT+IG7890SQAMOty3JlcnJQ119wxAbUQFthH69SXzJbA+LdelhLoe2cvqBZWT9gPQg2FSHlWWWCnjUANC7+kziV6U=
X-Received: by 2002:a05:6214:3909:b0:6bf:8912:4213 with SMTP id
 6a1803df08f44-6c33e69070bmr26956386d6.38.1724933875890; Thu, 29 Aug 2024
 05:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-3-sjg@chromium.org>
 <CAC_iWj+6CqPCxN8jSNJSzGiprd+sAw25ooQRaAf=t=Sdio67=A@mail.gmail.com>
 <CAFLszThVpvHO8Jt2Mz1WB80=fDtYpzieo1eR4k2Jj=e37Gb87g@mail.gmail.com>
 <CAC_iWjJJFygaws2ciBDMT=JJ4yMzhQC41T_Tg1RKFvrxzRTTyw@mail.gmail.com>
 <CAFLszThsVcFwSe39geTeE=6bbJqK0bUT6kEYjULkOuNjO51e+Q@mail.gmail.com>
 <CAC_iWjKPTv6Yzb6cQD=eJtC7Wm3bTC+cyaCUSmDXaWUySByoYw@mail.gmail.com>
 <Zs7Ubog171uwz8jn@hades>
In-Reply-To: <Zs7Ubog171uwz8jn@hades>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 06:17:45 -0600
Message-ID: <CAFLszTgNnmyKFC5XKPieFoqT1J6aerYkD=qOof3tZ_V25SrO-A@mail.gmail.com>
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

On Wed, 28 Aug 2024 at 01:40, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> [...]
>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > >
> > > > > > What about https://lore.kernel.org/u-boot/CAFLszTjLAKaYK_jLXJ7Z571L-QMtoiqE-oxHCRs186dZ2Qok5g@mail.gmail.com/
> > > > > > ?
> > > > >
> > > > > Yes, I reordered the patches in this series.
> > > >
> > > > You don't need to reorder them. As Heinrich already pointed out some
> > > > of these functions are used in EFI protocols. e.g
> > > > duplicate_device_path() requires the memory to be allocated by EFI
> > > > memory services, you can't just replace it with malloc.
> > >
> > > The pointers returned can be freed with EFI services. I don't see any
> > > problem here. All the tests pass and all the spec rules are followed,
> > > so far as I can tell.
> >
> > Where exactly does that happen in the current patch?
> >
> > efi_alloc() calls efi_allocate_pool() and when we need to free the
> > device path we are calling efi_free_pool()
> >
>
> Looking at it again, this wasn't very clear. The previous patch converts
> efi_allocate_pool() to use malloc. So this patch is not needed at all

That's right, but ultimately I'd like to drop efi_alloc() and the only
other place it is used is once in lib/efi_loader/efi_bootmgr.c

Regards,
Simon
