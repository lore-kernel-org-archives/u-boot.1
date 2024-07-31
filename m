Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F5CC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA7788A5A;
	Wed, 31 Jul 2024 16:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XChG2I8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89AB788A32; Wed, 31 Jul 2024 16:39:09 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CAA288A4C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d5c8c1006eso3269689eaf.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436746; x=1723041546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JOFJHI4FtXkfBdYpEBv+Bz/26pY1jSI/VADLgaMw0E4=;
 b=XChG2I8stIzCZ648WNj7C23mcnFZ3Mt929ntr5iOtTXFrtA/BOxAT2L36kVZfM1N4P
 lhZT1+ysxBg6NW0biS8WoOX8JP6BXXTge48HjhV8bwOUxk/jS17MKcQu8wYyFCztEPgm
 SzgajKWu7ZgWFso0Gddpk4JodfOOLS9EJT38s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436746; x=1723041546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JOFJHI4FtXkfBdYpEBv+Bz/26pY1jSI/VADLgaMw0E4=;
 b=o1Jwx6KlK5UVjxQ0e62RWGg+PihP+worfJCKQ+lByGQgxVu+twz6I96FKAb6Jc3kJC
 5xCXrym0rB2OYJPuoMaRj1muTZYSnmAUMIxDacKSoL7k45p4m4s26ZGU0tcte2WicDmV
 yR44C+FVd29vJ5i0j2AxldCwrtwMPqyRVFnuMgghwKXh4LYXtQxCgSBExWtrS7Q8NZUU
 2UbexGHI8jW1HRiDSGB8PSyyHzAjI2meoXrh/3sBWYGfQwX5/7IVsr4W/Cc0ou+zpUd9
 85vqaglcO1EdV8Bi9GZGe8wycVcDbeaF9sKEP7Jis2/tPueJgCmilXlkSMPmU2sxUlc+
 A3Yg==
X-Gm-Message-State: AOJu0YwUyD36NfqhSGTQsQXHX78V8IpzOH660GslPSkEfeqp44vW42YU
 Zw1yKt+j9P3yNMQfx16qHku1jndGuGJued0mK5y1Tv9RY0g4AWDMhLtIYYinrR3IX8KM9c001Dy
 ZQyxKXP/td9YtVyWvqQV7/qbtpTlYBJh2SgRX0eRBhKZLcjw=
X-Google-Smtp-Source: AGHT+IGN6ZP7Rspw9U6LVq52DfOUIPip5/zKVCTlE9Pe82bGAPKe9Ej/1JL1qU1nxgT184LAeCYVArVPbaW9GPYYTN0=
X-Received: by 2002:a05:6358:741f:b0:1aa:a177:359b with SMTP id
 e5c5f4694b2df-1adc0672b67mr1759604955d.15.1722436746082; Wed, 31 Jul 2024
 07:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
 <CAFLszTiwfVg7o+Rhf10U2exgUA-vJ4V_A-2L75ZLpwJ8sW=9Kw@mail.gmail.com>
 <CB131E81-078E-43FF-BE67-90D7F48EDB2E@arachsys.com>
 <CAFLszTggwpCnhZ0xaPR2n=e+x+PDe-wP4WxnPE60BqyF1ms3UA@mail.gmail.com>
 <43228DC7-4184-4C63-9BBA-65F056ECC91F@arachsys.com>
 <CAFLszThCz2NL+6svYMRD7qAHHNN8frWzrM4tyhDbuS77M3jUHg@mail.gmail.com>
 <E1381CA1-72D5-42D5-BB22-2B9B458B29C7@arachsys.com>
In-Reply-To: <E1381CA1-72D5-42D5-BB22-2B9B458B29C7@arachsys.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:38:55 -0600
Message-ID: <CAFLszThj6=XKSUiBdfFK-1n5VeovJHf7UcjE+dORK7r68xQNag@mail.gmail.com>
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
To: Chris Webb <chris@arachsys.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
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

Hi Chris,

On Wed, 31 Jul 2024 at 04:14, Chris Webb <chris@arachsys.com> wrote:
>
> Hi Simon,
>
>
> Simon Glass <sjg@chromium.org> wrote:
>
> >> Presumably it needs to apply to every mtk soc that uses
> >> mtk_pinctrl_common_probe() as they'll all be affected by this problem.
> >
> > Yes I suppose so.
>
> As well as the mediatek case (patch just sent), I thought I should look
> through the other pinctrl drivers for other examples of this problem you
> explained to me.
>
> Both starfive/pinctrl-starfive.c and mvebu/pinctrl-armada-37xx.c do the
> same thing, calling their gpiochip_register as part of the driver probe
> method. The pinctrl-armada-37xx.c driver also has a bind action:
>
>    static int armada_37xx_pinctrl_bind(struct udevice *dev)
>    {
>            /*
>             * Make sure that the pinctrl driver gets probed after binding
>             * as on A37XX the pinctrl driver is the one that is also
>             * registering the GPIO one during probe, so if its not probed
>             * GPIO-s are not registered as well.
>             */
>            dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>
>            return 0;
>    }
>
> which presumably wouldn't be needed if the gpiochip were bound at pinctrl
> bind time instead of pinctrl probe time?
>
> Alas I don't have any boards to test on for either of these platforms.

If you have the inclination it is still worth sending a patch. The
maintainer can check it. These sorts of counter-examples can be copied
and soon everyone is making the same mistake!

Regards,
Simon
