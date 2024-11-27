Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0AFD6ACC0
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 11:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A572C897B7;
	Wed, 27 Nov 2024 12:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nvq0+asP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA8D897B9; Wed, 27 Nov 2024 12:48:24 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74BA897B5
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 12:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cfc035649bso8595944a12.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 03:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732708102; x=1733312902; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2nzmmN0O/0l8sxKRl4grDH3Zf9u1iFxrsmEPRGuq3Vc=;
 b=nvq0+asPITT/BGEJkwilXYs3vFGRYPiDh30bYKd/TP/EtjaKdX5UibI01odNWzlkDx
 mXBGgMEb24tUL7RwrorzZkaGZ1K+ftbrl1Lh+D7o8lwsWQfJppkYL7DDmqMRM5Tt3h9l
 lJmp2IntJJ54zERT2LCE9MUIDbKQriiN3feYq+cm+thLa4yABEWGOB66fS3ZSJxOKZuK
 V5SIhG8mjyBEjUc7yZONe1PmIUAdkCweHpBlEamcuMWm1sJMZe/yaxihAjoaPRt/F19Y
 /ruxavKl425hBCsESuA7ulg+9eHozSXlltMLgyS4UPZmOiU40cyDtYPW/w9Mmuo0Z+bM
 cEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732708102; x=1733312902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2nzmmN0O/0l8sxKRl4grDH3Zf9u1iFxrsmEPRGuq3Vc=;
 b=H4exU5qKjKpvpqmQ1g4oeIZ+SnEEVUId9GTbdkXY6kRhB3sBSxiKbw/x1JU3juZYkJ
 ScqYnx6cafx+6WP6o8aWiAbLweSwNPeDj6q4AwtWSURZLNQgMDmGsgjY4GGDjxmXPEp8
 jhmm2z1gq+E8P8bE1HLZI+RCXHcEy4NKGepIOPAZtN0ufonCbxc1famcc0d+NYIBzYEV
 nqEjcB2CATiBstu4gtpDHjNRnVzGu22MOgGLepFmyuJQwo3XeT4m7suVMCifhB3R6Xwk
 X0IHbkxCHuwSE8XA1bLtg2ChNCnvyzea+bgWBi/rwUf0NOsanZeqM4OHjoc7OdcwXydz
 pKfg==
X-Gm-Message-State: AOJu0YyP+ZwkiaCfkSu6HNOS8VI4Lo7LenQ7DgkHgtztlg9h8rN2FWS2
 7WwoQbgRdKRRF0TPnF2DgUSuY8brMjF359QpvNuHQUIhkSyROSXnhiTXdHBj9eChPiap5GSlgqO
 IlyMi+C3P+RxTLc08vS+mWO2XCAYkluoLH4KXYeaJ1Qfty10W
X-Gm-Gg: ASbGncvXjs4SdJIhOv1e4FOBK9L5M2+Isn3qSmlYdsmmF+NfVxjUw5gRTYL02VPeNPf
 0iyDrAFAnRt4CN5f1kbKyd8d64ZrS9ZNi
X-Google-Smtp-Source: AGHT+IEgcmlMuKb2F5Mvhnp2BDbAn14zXbnhHGhWG+amMAsxwYyX6zst44hntRzHU/wkW+iuqTFmwgWyKhpESLJoSEU=
X-Received: by 2002:a05:6402:3718:b0:5c9:69d8:6329 with SMTP id
 4fb4d7f45d1cf-5d080bc69bamr2405778a12.20.1732708102359; Wed, 27 Nov 2024
 03:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20241112131830.576864-1-sjg@chromium.org>
 <CADg8p96cKqSEmZWLaOV1-onUwT4uwBp11=t4K7tmmPwZ-6UvXw@mail.gmail.com>
 <CAFLszTjw8ihHESoDk0RE6+00idN4Y-7=72NbUp+yOqpyCYqexQ@mail.gmail.com>
In-Reply-To: <CAFLszTjw8ihHESoDk0RE6+00idN4Y-7=72NbUp+yOqpyCYqexQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 27 Nov 2024 17:18:10 +0530
Message-ID: <CADg8p97KQskghmGR+mv-AUVSAyCJ02DRzCbfHsZjGfEYbb+skQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Tue, 26 Nov 2024 at 21:09, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 21 Nov 2024 at 00:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Tue, 12 Nov 2024 at 18:48, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
> > > patch. I am not sure how to investigate it.
> > >
> > > The boot hangs at some point during booting of the install image, before
> > > the Ubuntu logo appears.
> > >
> > > I will sent a series with a script showing how it is run.
> > >
> > > This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> >
> > I did some digging into this issue, and it turns out that the revert
> > is only masking the real issue. What this revert does is mark the
> > memory region occupied by U-Boot as EFI_BOOT_SERVICES_CODE. The x86
> > kernel seems to mark memory regions other than
> > EFI_{BOOT,RUNTIME}_SERVICES_CODE as not executable -- and this is
> > precisely why this crash shows up only on x86. The actual cause of
> > this issue is in the efi runtime functionality of U-Boot. The kernel
> > is calling the SetVirtualAddressMap() runtime service function, and
> > that seems to be calling some of the boot service code of U-Boot,
> > which it shouldn't. We do not get the crash after disabling the
> > ConvertPointer() and SetVirtualAddressMap() runtime functions.
>
> OK, so what is the solution here? Did you send a patch?

I am trying to check if the installation can be done by disabling the
ConvertPointer() and SetVirtualAddressMap() runtime service calls. If
so, then I will send a patch which disables them temporarily till the
actual issue is triaged and fixed. If the installation does not work
without these runtime calls, I would say putting this change in with
an explanation of what is happening (similar to the above
explanation). Please give me some more days, and I will let you know.
Thanks.

-sughosh

>
> Regards,
> Simon
