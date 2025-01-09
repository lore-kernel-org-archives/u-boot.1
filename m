Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F19E7719B
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6360A80608;
	Thu,  9 Jan 2025 16:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gZmNABmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB95680602; Thu,  9 Jan 2025 16:01:36 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F2B805EA
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d96944401dso1545883a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434893; x=1737039693; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EQkVo/7CUfJN/b7/Z+4OLVa5h4CYzr2EoqhKlz/n8xo=;
 b=gZmNABmAYvP+Yh7vK2LQaELD8OLV8neSStsVYcfUJGgD1RRxCA9dA5oEDONn2uMchE
 uQqjxMCBJHI5TUI8gz3NKvPJEZnlihH/Hvf66fzz2A11dzVhKUzM4F6MXlTZNh71Vjrz
 bUOAr8WcXQ27i9nQQ3YLDa+ASB3zaQkl7u2rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434893; x=1737039693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQkVo/7CUfJN/b7/Z+4OLVa5h4CYzr2EoqhKlz/n8xo=;
 b=UxSMB7Foe/SfD5LApJ2wYFouL7tkQ5jeNFwD1eryeb8dsECzMGT78RORdROqZkmhlp
 QjvQ7+7ligrCTkOnr1d++RbGylzmngfdlkFhaPCroTGeSSlb+U92kN9XzdyfdgVFSfiQ
 Gj0ukJh274IMId6mnPSmCY1XPJ/o291R9Dh1jdysFaMB93+C7DyihbuM6M1sL85A7KI6
 iY4WJ48P7DJfBBSiJfMaKZnvCKJ6VKMlI+h47YMkITfZCgGpIfrEn4MDl/Ns++9OOyGI
 XNGHc/k3toNDTys4dkUZV3dFdZk+SUBswDHUuxyiwc2PP1akB6V3uyKr41M3h6b9aXwh
 a+Fg==
X-Gm-Message-State: AOJu0YxRKL+UCn5TxPmTB4b0zazx67v/BtcREV3wZNIbPKS61fv7rbHL
 u+uUiszzhlN7pAcGjkueGLY+TqOJxY/krus7YKZA8KPph8jF/fxVpStepbKCurg4nfHV2o7WUeE
 qih2vAb/vpTNKMZH6jjjRs3/Brph5iRHABCSo4vi0Z0qzkjM=
X-Gm-Gg: ASbGncueXEZkov0OyYTZKzFmpQ+f+4WssS83XWmmR6IXZnSHSvtt4m7JPWmZ9O6ZzWq
 hQ75BTrF9g0Dfi+Lye1C6sJKuAZgOizzLDyu3YN8=
X-Google-Smtp-Source: AGHT+IGoGxv9ZP5fvqdrLx0+RVd/lNYEVBi0mb4tgwwTOsQQDDTUuxl9a+BvbOYkE7Ra+aKuh1vQUSFTqYLMa4A+2ms=
X-Received: by 2002:a05:6402:50c6:b0:5d0:b60a:2ff6 with SMTP id
 4fb4d7f45d1cf-5d972e4c915mr6700663a12.22.1736434890423; Thu, 09 Jan 2025
 07:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-4-sjg@chromium.org>
 <20250106214130.GC3476@bill-the-cat>
In-Reply-To: <20250106214130.GC3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 08:01:17 -0700
X-Gm-Features: AbW1kvYLu_Kx5edT2g6Be1odBJM_GMoMf3jdyPDjQ3Y0FROciqKk4lGAnLhuAjg
Message-ID: <CAFLszTif6J6r48DWca3GSuGwnARuzJdnuhbi9wkr8ws=0S6Cjw@mail.gmail.com>
Subject: Re: [PATCH v2 03/33] bloblist: Make BLOBLIST_ALLOC the default
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Chen-Yu Tsai <wens@csie.org>, Dragan Simic <dsimic@manjaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joshua Watt <jpewhacker@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>
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

On Mon, 6 Jan 2025 at 14:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 06, 2025 at 07:31:59AM -0700, Simon Glass wrote:
>
> > We want to encourage people to use an allocated bloblist since it is
> > more flexible than a fixed one. Make this the default, being sure not to
> > change existing users.
> >
> > The unit tests require BLOBLIST_FIXED so add a dependency in the
> > Makefile to avoid build errors.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> > diff --git a/common/Kconfig b/common/Kconfig
> > index e8d89bf6eb9..a00387a4609 100644
> > --- a/common/Kconfig
> > +++ b/common/Kconfig
> > @@ -1039,16 +1039,10 @@ if BLOBLIST
> >
> >  choice
> >       prompt "Bloblist location"
> > +     default BLOBLIST_FIXED if SANDBOX
> >       help
> >         Select the location of the bloblist, via various means.
>
> This should just be "default BLOBLIST_ALLOC" and sandbox platforms that
> are using the bloblist can be like the other platforms using a fixed
> address.

We don't need 'default BLOBLIST_ALLOC' as it is now first, so is the
default. I would like the 'fixed' thing to be later on so that people
know we want to stop using it.

All the sandbox platforms use BLOBLIST_FIXED. I'm not sure what change
you are wanting me to make to this patch?

Regards,
Simon
