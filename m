Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9320BCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 14:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E79CC88875;
	Mon,  2 Sep 2024 16:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="MGq/kl9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A982088C19; Mon,  2 Sep 2024 16:57:19 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A86888860
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 16:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53349d3071eso5695735e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1725289037; x=1725893837;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWzTZwpmxskFrm0OqtgzNkwosWp5UUVvak8PRqvIxIg=;
 b=MGq/kl9zMTQq/Kg3MB4GeQWkgFLnLrym5FNgcyaqh8hbJBVHTQUwWT9aR1Z38D43Jp
 kt48d/DNUmjeR6/Mq3DMQA5lbkorh4gImBjX6wh2AZgqhKQg837Z9n5vyYh7U/cVsJNB
 m8u9ga5mWzlUmsca4vHqWQXh19gOFhsCaro6C7stCCp5WT9wUCB14B6wN/QG/pkrJdY/
 e76U4qnOgVyyJOOT8hRmQX8a0RthijTeBFenVcQPXShiXBxVennh/cVEhiVjQiWgZuPf
 FYawAcucsHF+MD1JLdWZNb65Bb4EFc4u56AmigiLFcyRRg51fDhG6aVWTHJt7v54+zvS
 xFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725289037; x=1725893837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWzTZwpmxskFrm0OqtgzNkwosWp5UUVvak8PRqvIxIg=;
 b=bygn40+lbLMofMf5MrG3+qzFql0U3G7G/zfFDUk415S5K6nufA0Szsjr32TCYtnQ4v
 YYxIxKupxXqrxt4dhXfBAgQVC6xr7zqDD6vrjHBiPACabG7Jth4yuzq0hRmjXEwWxnC5
 EK1ZUfdt+gh3i5tI0o14WSmWzBl2JChcwO2//QDu/HWIz620lxlg0M6G0gXkSDc4k9Ha
 TeQatK9s9kOztsVo48fZlSrYwFa+7pimTUfjWJg+WHIWueuTwbX02UMSSvAPZlguEhJc
 PX8DVdYjTB9Ze+ZqZQ+MAPByL3Ex8UxUsQQTfCUnkdmue+WWhxSdlO2Wynf8IFh4QQWx
 JwrQ==
X-Gm-Message-State: AOJu0Yzuw1iLpw9qyRt5JohLVnn9gHoImCqyb1God1E3lmQXedt8pkvZ
 yTnLoLaXeIiWAPK4hgjEWsoOHsODJ9elPQ/EFKmyzPE7rrPYAnhiaWdU6694UH0Jh0sMFnCPD1n
 pigp0wCZprbmh7Af6uFMK6EE1Qkz/KJGniOJQHmL9bqL8AnUreIs=
X-Google-Smtp-Source: AGHT+IGRODnUfqF2NF8F7I1mkLil/iItZU3uiRSMFOIMcY3LqMtiVGQi4OEgKf9HSUNW/zpH4skG48zAjj2d+EpJGs0=
X-Received: by 2002:a05:6512:4003:b0:52c:d6d7:9dd0 with SMTP id
 2adb3069b0e04-53546b05d90mr7287423e87.20.1725289036525; Mon, 02 Sep 2024
 07:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
 <20240827142058.594556-3-lukasz.czechowski@thaumatec.com>
 <3c9b636d-2184-42dc-9604-cebe2535f11d@cherry.de>
In-Reply-To: <3c9b636d-2184-42dc-9604-cebe2535f11d@cherry.de>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Mon, 2 Sep 2024 16:57:05 +0200
Message-ID: <CABd623tpMOoRNXU07LLsvVnyEetLGjhvcQgKMLCp8DO8XutDQQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] ram: rockchip: Kconfig: Fix dependency of
 RAM_ROCKCHIP_DEBUG
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
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

Hi Quentin,

Fair point. Unfortunately the syntax "depends on <symbol> if <expr>"
seem to be not supported in Kconfig
I can do something like

depends on !TPL_SILENT_CONSOLE && TPL_RAM || !SPL_SILENT_CONSOLE && SPL_RAM

instead. What do you think?

Best regards,
=C5=81ukasz


czw., 29 sie 2024 o 12:19 Quentin Schulz <quentin.schulz@cherry.de> napisa=
=C5=82(a):
>
> Hi Lukasz,
>
> On 8/27/24 4:20 PM, Lukasz Czechowski wrote:
> > The RAM_ROCKCHIP_DEBUG can be used only if DEBUG_UART is
> > available, otherwise it won't have any effect.
> > Add negative dependency to TPL_SILENT_CONSOLE.
> >
> > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> > ---
> >   drivers/ram/rockchip/Kconfig | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfi=
g
> > index 67c63ecba04..4a6a6328676 100644
> > --- a/drivers/ram/rockchip/Kconfig
> > +++ b/drivers/ram/rockchip/Kconfig
> > @@ -15,6 +15,8 @@ if RAM_ROCKCHIP
> >
> >   config RAM_ROCKCHIP_DEBUG
> >       bool "Rockchip ram drivers debugging"
> > +     depends on DEBUG_UART
> > +     depends on !TPL_SILENT_CONSOLE
>
> I am wondering if we should also do this for TPL-less systems? i.e. the
> ones for which the dram is configured in SPL.
>
> Something like:
>
> depends on !SPL_SILENT_CONSOLE if SPL_RAM
> depends on !TPL_SILENT_CONSOLE if TPL_RAM
>
> maybe?
>
> Cheers,
> Quentin
