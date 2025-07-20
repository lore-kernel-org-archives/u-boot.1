Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12EBC83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 19:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD35582E52;
	Sun, 20 Jul 2025 21:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y90VVumf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAEE882F14; Sun, 20 Jul 2025 21:57:22 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110BB82DA1
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 21:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e1d8c2dc2so34635367b3.3
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 12:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753041439; x=1753646239; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ag76i5pdG49nOP4MPYNcX2Uhqp4EM7lVvyeinm2PaL8=;
 b=y90VVumf77JXSjhlUZPTPxz4LsvEy2Cv7V6FQWtg/UU5jFucgaNhFKJm6hD/Cw0hip
 G/atbtiMpnppb25G+yn6lJws5iJRhi6B5I7TOSCJyiucfkUtv770BC7B36K3qXQTbGCJ
 FPdlvCFdsLK+reS4aahtIIg7B7vdMXrjpc0CQPPbsGaYO7FcjQaGGH/fFM2DNK2EvohQ
 8jyxeiJad1w4L8HSQVXA4j2YNE/DaMGMguX5iTShjqoFXHjSTLVd0iSC2unthrRNgf4w
 Ro4EgPjgLOAkeZPM+lu2M8ZiblLlh/7/f763ji1R4MfRML90v5r0HXeHjrgs535BjChy
 UfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753041439; x=1753646239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ag76i5pdG49nOP4MPYNcX2Uhqp4EM7lVvyeinm2PaL8=;
 b=S5uWpK6t4+4gSkg1c6nFkDolBZm0RZHvkj3KzVQLnm2+IOZzN5mESynNVtF/gumO24
 HzFkyCrXXgjkbZ14U3Pk+YWc3XFkJLTuuDz/UdZ8edybV/t2AGDbjI7chSY69q/Kf3S2
 3MNlUHnzRtXxZjq3XjB26fGGnGntFNo4925FZdHudY20FbwkhXDCVTwsagDNrlHjJb35
 uzbVfYXvDnbyJ7v1tLbB2O1j6s6HyaNy3A6bsOR548eChd8sAMyxaF77kltuON8+l8k4
 DTPo14cdcpzgIydFdVeMuJnnPET/lKh1XNxqQWCrPpgMP7beMPA0T1aQy38RuXUdgJYs
 5Tyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8eOCGCDz/gr3rvWL1TnVTywpRJDB1NC+eGkMPv1jvkppTtxb63Y4lf7uNE339/O9AaWWAfFk=@lists.denx.de
X-Gm-Message-State: AOJu0YxfZsu9vjJnQRMVIRIyDhi3HmdjdFmUJiEFXRFRi5V04wGn1U7u
 l93kuj93HMs68DwbEQgjo2Udx4+PPKRiQRcZfRh3vdi0jiNeLHxkrZJENJ3ivswKIX2laNsIjza
 D3jeSo5j+D7yFFo8+tXkjJ3WRHEChdwA4kkMXZPfNrQ==
X-Gm-Gg: ASbGncuyZ0RBcrmrmHJQbMs/xAoc6ADCZWU3DpA5ZnUWNZiGxVPLSvVR6YqXkvp76ae
 Cbj1f2GBmIZrqc24fSdEEvC05Lsr8xpuoH4c60VyQ1pdnZSz3X5kBdcW5BVKP8F5uTTrjzcs5yA
 IGLFVM+ecoAkyx1Z46T5DCB4lZD6MUl3upY0HlS345PubXXp/w+QM2V+ia2wLsDanW3gHAt2LY6
 cF95MSvyeT2I/Isbw==
X-Google-Smtp-Source: AGHT+IF/nQ4eMxKKBqb2lvS6P6LHuva2RNAslYpbJnCauwjE1HngBW9jK0qr0IiKULbW1FgjfMKL09XmwR3DGSUo6uU=
X-Received: by 2002:a05:690c:4809:b0:70c:a57c:94a3 with SMTP id
 00721157ae682-718374f0513mr190992617b3.19.1753041438734; Sun, 20 Jul 2025
 12:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
 <20250709222926.24671-2-semen.protsenko@linaro.org>
 <87tt3b2ti7.fsf@kernel.org>
In-Reply-To: <87tt3b2ti7.fsf@kernel.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 20 Jul 2025 14:57:08 -0500
X-Gm-Features: Ac12FXzJ6hl0EwGgQlXDo19GswGKt5S0Pf2qvOs2fa6s1O85f740ot69bvn1Ed0
Message-ID: <CAPLW+4moDYL0Q9TjSuWbqOuLQV2KCCrrzR_02-YUhivWuvQ=SA@mail.gmail.com>
Subject: Re: [PATCH 1/9] phy: samsung: Add Exynos USB DRD PHY driver
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jul 17, 2025 at 1:58=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Sam,
>
> Thank you for the patch.
>

[snip]

> > +
> > +#define EXYNOS850_DRD_UTMI                   0x50
> > +#define UTMI_FORCE_SLEEP                     BIT(0)
> > +#define UTMI_FORCE_SUSPEND                   BIT(1)
> > +#define UTMI_DM_PULLDOWN                     BIT(2)
> > +#define UTMI_DP_PULLDOWN                     BIT(3)
> > +#define UTMI_FORCE_BVALID                    BIT(4)
> > +#define UTMI_FORCE_VBUSVALID                 BIT(5)
>
> Comparing with the linux driver using
> commit cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4nm =
controller")
>
> I notice that the defines are in reverse order (from 0 to 5 and linux
> has from 5 to 0).
>
> Is there any particular reason for this?
> I don't mind it too much but it makes diffing between linux and U-Boot a
> bit harder.
>
> Anyway, I've compared this with the linux driver and it looks good to
> me!
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>

Thank for reviewing this, Mattijs! Yeah, I kinda flipped the register
bits w.r.t. kernel's version, just because it looks better to me this
way (easier to read when it's sorted properly). Due to the driver
model API differences between kernel and U-Boot I had to rework the
whole structure of the driver, and I only added Exynos850 support for
now, so the difference between U-Boot and kernel versions is quite big
as it is anyway, so I figured it's not a big deal to reorder things
even more. Hope it's ok with you?
