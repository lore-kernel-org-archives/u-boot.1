Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EC5D1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9587689045;
	Mon, 14 Oct 2024 21:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iM5W6//o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E7989056; Mon, 14 Oct 2024 21:13:31 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35AE088744
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbf0e6414aso15543826d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728933208; x=1729538008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JDlESrcbjOClOhRAVgo1cmDu5cWhVG8WOZYTSmSeCO8=;
 b=iM5W6//oaOMxLI4mRRqlOdKRGdYEQuyuzXwsMSHSI5p3vrnJgyXBPvD9qVyK5zG82f
 /S3Y/1RvHvMt/BD4FiS2nCw4S2YU+iipSMeDss/ZQuA5OBFM2nCBjV3gpMkFg9NmYkH8
 GZokVL46NuG7e3CzYIV3fgivsdQci9bNY1Mps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728933208; x=1729538008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDlESrcbjOClOhRAVgo1cmDu5cWhVG8WOZYTSmSeCO8=;
 b=EzPzsm5pIKtLjutIlFoUb07C/FU5nXkD0L7gSbP/yKWY07a+WF47QXaUURfycd3Jrf
 nqTXQGi51AVvUajWaw7yQT1r1Eij2R41B939ja5BVFfgPrJPylHriMl5MyDMzObvkGZX
 jqW5r4uUJM+8nlPMpZJJwG4BcHGUYoI92eMVQwOLqmbUX5MocQKcUgbyDucBkkxkFnj5
 pxreSQmjYy6upr3z0g8gLBlUPt9dhcrGK0QupsAXliTyUrcCSQt/hAU1WwJ+v+95EFjr
 iIBisvADoxvkBz069H5Ln7rkdwg6/kh3D86dm17xbwY3XFPhmpgADUpRj5w5GFNLAHix
 eCww==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6BGJJjI0cAkgGJ0Y5U2+lW+lEcrBaUsj8KQ07vpj3d+5l0wgDvPIPp4BVsV1rKGlFQcEBYWI=@lists.denx.de
X-Gm-Message-State: AOJu0YzHVmAW0rJUNnZl0YRI39mPa2Ce4IaTfLkRUy2sneqpxi16/iv9
 ZnknAnHkqsAH+5Pt+DdJjLz2xMhdmhQocAqjE2yipfEp2spA6Onucy4tMaa+gO24HtuiIwAxBbM
 UBjtnlu3qLPAGx3a5gbreqH7jH+e2l4950elt
X-Google-Smtp-Source: AGHT+IEqJeKm8CG+AVLCcOTk4UcIrfS1sHytwR17gIRn5EDiUVwvNBC90uJWi+DksINNL/g6ASUrorlpQDFR8G+e7Lg=
X-Received: by 2002:a05:6214:5b06:b0:6cb:e4d3:91c5 with SMTP id
 6a1803df08f44-6cbf0098734mr207227446d6.36.1728933208015; Mon, 14 Oct 2024
 12:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
 <20241014155642.GO53053@bill-the-cat>
In-Reply-To: <20241014155642.GO53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 13:13:17 -0600
Message-ID: <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Tom,

On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> > Hi Sughosh,
> >
> > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Use the LMB API's for allocating and freeing up memory. With this, the
> > > LMB module becomes the common backend for managing non U-Boot image
> > > memory that might be requested by other modules.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V2:
> > > * Use map_to_sysmem() to get the user-visible address to be shared
> > >   with the lmb API's for sandbox.
> > >
> > >  lib/efi_loader/Kconfig      |  1 +
> > >  lib/efi_loader/efi_memory.c | 77 +++++++++++--------------------------
> > >  2 files changed, 24 insertions(+), 54 deletions(-)
> >
> > When efi_init_obj() is called, it should be able to add the lmb memory
> > to its own tables. There is no need to worry about lmb after that,
> > since no other images will be loaded, except under EFI's control. Then
> > perhaps you don't need this patch?
>
> But that's not true. The EFI application can return us to the U-Boot
> prompt.

Can you finish that thought? What are you getting at?

Regards,
Simon
