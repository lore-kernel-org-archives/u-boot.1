Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA8E7717D
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 00:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D10801EA;
	Thu, 12 Dec 2024 01:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nsfk+kxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66A9801EB; Thu, 12 Dec 2024 01:58:26 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A5F801DB
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 01:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa6c0dbce1fso3523066b.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733965104; x=1734569904; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0pM+9CD/jzJivRUyr3pvXC7cuzjENmnj7YV4/PohUX0=;
 b=nsfk+kxak6MZAKgWjkzpDPUiqUNcfct1yb1WNImxueuErOUxfZEjzxwVEDYdXP90F/
 iv8jpwgkDqj5NTTLSSjGk2bMuqyxL+WIPC+P1fVbEt9BXQeMvcG0gkMkQLdmgGfoUqyH
 ksB2nZOKu3/t6Zu58/phlXmjgmogCYgSD8jDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733965104; x=1734569904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0pM+9CD/jzJivRUyr3pvXC7cuzjENmnj7YV4/PohUX0=;
 b=SAYPYUKwk4sL/JVklgFMhJz21cDtWS35Yary6vPDHyexQ5Coy4XrBGgzzNzm/mWWl4
 1/VreTfgpRV9M8hDKXvy3485BCmx/U9liutQnI7D8E8kwlnqpooWY3GKPBU7XvpBRU2S
 77uirlJD0XkDDCkA59y660Pw1J9H01AabuaTXI94qv1gQWgPtVMfMfeeke/TFgF4mAWM
 XzACy85zpcCfu/uL4Lsxyoijqhp8AeHXYwXNF2O/bKXVRzOdVAb3qxBAUFNqkukhroVU
 +5n4UR1G3S1Yj2Z/k9AYkY0kuQ1LdDC30Gg7lRHLj928FIy+AbM1d7a9FqJz+7kk6L3O
 rL2A==
X-Gm-Message-State: AOJu0Yxc1k3CnDGaRMYat7x5YIsBbSSSZjCh04lCAAW9AR2dQ/L6petE
 Fm6vH4A/3TTS5h9AxVcKegz8lg4v+r+rKwUG+NlYKWsKrgVaqn47pVIjT7qlO4JKWjcAnW7nHJw
 eWKWb5NBusC6KO1XqOkGJBCz1kXyk8iKAhjNx
X-Gm-Gg: ASbGncvgYwYL16r7M405DXe+Q7ZK2cYiL55097rrGTRM58qSkUvPedqkW92F8kRnWAo
 +U618GJqO/0l+7k56tlKaE/3E8Lz9K4Tl8DZCeCg=
X-Google-Smtp-Source: AGHT+IEsBDI9uBILx1upeeMUeph76IkslozDwarYfiLeNZhghrJrBjm0CaqCwadtgCRxvaUl3S0AxYA67XS5jombXYI=
X-Received: by 2002:a05:6402:4306:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d433163a52mr9405475a12.28.1733965103876; Wed, 11 Dec 2024
 16:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211224955.GJ2457179@bill-the-cat>
In-Reply-To: <20241211224955.GJ2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 17:58:12 -0700
Message-ID: <CAFLszTjjO4tTSAMJxqLUTKXjynR83frsjpOV3wiNTgtv7ptDNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] efi: Start to chip away at the EFI workaround
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Wildt <pwildt@google.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Wed, 11 Dec 2024 at 15:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 11, 2024 at 03:38:15PM -0700, Simon Glass wrote:
>
> > At present there is a function, efi_set_bootdev(), which is used in
> > various places to tell the EFI loader which device a file came from.
> >
> > With bootstd, this information is available in the bootflow.
> >
> > This little series provides a way for bootstd to provide the bootflow to
> > the EFI loader, so that it is able to select the correct paths.
> >
> > For now only the EFI bootmeth is updated.
>
> Hi Simon,
>
> I think as a general rule it would help everyone if you had no more than
> one outstanding series per subsystem per week. This is 30 efi_loader
> patches in 24 hours and that's _a_lot_. One could easily argue that's
> too much. Thanks.

Sure, I'm happy to send fewer patches. Could you go into a little more
detail about what 'per week' means in this context. Can you give me an
example?

This series has been sitting around since mid-October. It just didn't
get reviewed / applied. I just hit a situation where I needed PXE
booting, so I added another patch and sent a v2.

Regards,
Simon
