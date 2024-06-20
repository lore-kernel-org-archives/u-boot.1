Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ABBC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 17:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF86188543;
	Thu, 20 Jun 2024 19:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hpa0IzJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D0CD884DC; Thu, 20 Jun 2024 19:37:11 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799E78854A
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 19:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d106e69a2so1906377a12.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718905028; x=1719509828; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iXEugL0xnc4nuI5YyYnV+/LOoYJZKBO5QSInB7kM2+g=;
 b=hpa0IzJlHy5n1rJo2CS2Nofe98mFm0YvZLglMc51e6Vt8uzfs6S1QsiBqs54S6M1Mc
 37X8CP+guu+pif3WPJNmy+OJEtNhYKd1a8rFoMRIPMVpjYvLfxgtnFUiiQzP+Ki61x1p
 DpHQC09rePAWpDeOhMPCIk3tvr1chq71o/ye6kokqog1B0fo0n7LFBSiCK9fZzIxuUMa
 1b7OFIMHFmDx/5Jmgm6uUvsj40pqOXDznlefzci9nKMNRba53k5P2yOIrBOVGXet6Hd8
 YfI6rG+JryI0b1ys9fiCdTvxP7SuiTEKHJjfKFUp2na9T4vVC6nu9ol95p8yHyASoL5E
 Bcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718905028; x=1719509828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iXEugL0xnc4nuI5YyYnV+/LOoYJZKBO5QSInB7kM2+g=;
 b=B0G8psf+DLJf40dTlkOl3KsJMrXK91yu4WJX1y8I38ebCjTRXbp0UNNuIkTYRcVdzd
 QpPplMvYfixjsWf1uz4yo1Wfm9gxnigrqWNNVXQICWUYezOpz9xg9//ZpQ9w02/UoyFb
 sXeTKCO5uhFMbaW/pvwJ4ETtlsgj9a4/xHOBhKKUfYyX7GT827+PMP0ge8iUfAZO2zGj
 AiW46BCWP3nCcKbfbHDPT3jEpBMD1xGOTBuvqMirfcfLi4AR+hBB09BlgkyoLT99Y4u5
 LCrOTScb3GMOBdIHxD+gAfd6QKBDs4/Z16zGS2T64jK9yPPRMa1eZ4fjG0oyWx2B0tD7
 H1mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR7jZoSoPtw7rcgML9Ah2bkooRrsD+RNkCUAIp5v55PHhhfD6Wuo2xlI2/6uaIyYQ4G55DY7cZ3vwB/WhvBMfBnmdLUg==
X-Gm-Message-State: AOJu0YzLBhYd1xwdK0/PeYkoS/Zby0X3ayHUPznfWUMgBQ2BDsY6tUMn
 uOTgWK76CW9hGq06FyKOzCq2yRSaKZ33DQhzYN1shaiIJOHliXzWCAxcZu0YLMWeH7dxiF05Shw
 A/NP7dj1kGUr08f4mwrJOzTqn0AU=
X-Google-Smtp-Source: AGHT+IGqyShM/erRo/ZolmiQQ1DLluNrbmGy1huQ4SxP2y+7aYuCw74YZFyA2AbDUFGFalF0SjrzGE3J9ZsubWAb6HE=
X-Received: by 2002:a50:bac4:0:b0:57c:ab4c:f064 with SMTP id
 4fb4d7f45d1cf-57d06ab1fa6mr4446307a12.16.1718905027712; Thu, 20 Jun 2024
 10:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240611231435.10366-1-ansuelsmth@gmail.com>
In-Reply-To: <20240611231435.10366-1-ansuelsmth@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Jun 2024 18:36:56 +0100
Message-ID: <CALeDE9NmFvi12k8aySe1Cw4Q2CqEgpme2a3stMyHKnbraKJQXw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] misc: introduce STATUS LED activity function
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Simon Glass <sjg@chromium.org>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Stefan Bosch <stefan_b@posteo.net>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, 
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
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

On Wed, 12 Jun 2024 at 03:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> This series expand the STATUS LED framework with a new color
> and a big new feature. One thing that many device need is a way
> to communicate to the user that the device is actually doing
> something.
>
> This is especially useful for recovery steps where an
> user (for example) insert an USB drive, keep a button pressed
> and the device autorecover.
>
> There is currently no way to signal the user externally that
> the bootloader is processing/recoverying aside from setting
> a LED on.
>
> A solid LED on is not enough and won't actually signal any
> kind of progress.
> Solution is the good old blinking LED but uboot doesn't
> suggest (and support) interrupts and almost all the LED
> are usually GPIO LED that doesn't support HW blink.
>
> To fix this and handle the problem of device not supporting
> HW blink, expand the STATUS LED framework with new API.
>
> We introduce a new config LED_STATUS_ACTIVITY, that similar
> to the RED, GREEN and others, takes the LED ID set in
> the LED_STATUS config and is used as the global LED for activity
> operations.
>
> We add status_led_activity_start/stop() used to turn the
> activity LED on and register a cyclic to make it blink.
> LED will continue to blink until _stop() is called.
>
> Function that will start some kind of action will first call
> _start() and then at the end will call stop().
> If (on the broken implementation) a _start() is called before
> calling a _stop(), the Cyclic is first unregister and is
> registered again.
>
> Support for this is initially added to the tftp, mtd and ubi
> command.
>
> This also contains a big fixup for the gpio_led driver that
> currently deviates from the Documentation and make the
> coloured status led feature unusable.
>
> Changes v3:
> - Add log on Status LED error conditions
> Changes v2:
> - Add Documentation conversion
> - Rework to Cyclic and simplify implementation
>
> Christian Marangi (9):
>   misc: gpio_led: fix broken coloured LED status functions
>   led: status_led: add support for white LED colour
>   led: status_led: add function to toggle a status LED
>   led: status_led: add warning when an invalid Status LED ID is used
>   led: status_led: add new activity LED config and functions
>   tftp: implement support for LED status activity
>   mtd: implement support for LED status activity
>   ubi: implement support for LED status activity
>   doc: convert README.LED to .rst documentation
>
>  cmd/legacy_led.c          |   6 +
>  cmd/mtd.c                 |  19 ++++
>  cmd/ubi.c                 |  15 ++-
>  common/board_f.c          |   2 +
>  doc/README.LED            |  77 -------------
>  doc/api/index.rst         |   1 +
>  doc/api/status_led.rst    |  35 ++++++
>  drivers/led/Kconfig       |  30 +++++
>  drivers/misc/gpio_led.c   |  41 +++++--

Does it make sense to move misc/gpio_led.c to drivers/led as that's
where the Kconfig is?

>  drivers/misc/status_led.c |  75 ++++++++++++-
>  include/status_led.h      | 231 +++++++++++++++++++++++++++++++++++++-
>  net/tftp.c                |   7 ++
>  12 files changed, 440 insertions(+), 99 deletions(-)
>  delete mode 100644 doc/README.LED
>  create mode 100644 doc/api/status_led.rst
>
> --
> 2.43.0
>
