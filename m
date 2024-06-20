Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE548C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 14:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1270D8853F;
	Thu, 20 Jun 2024 16:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PcLx4/+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D14884F9; Thu, 20 Jun 2024 13:08:22 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8847A882E8
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 13:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52cc9b887f1so922485e87.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718881699; x=1719486499; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JxzyW7YDaDnnWHkDmS4jUbFJC3ke0qKGt9kDBWWlz6g=;
 b=PcLx4/+jRppsVRh7ZlgOx/iiqlg0UYLPLar4q9fPzcgRvpdeAaLlkxtsU9jVYImuRx
 V847nFZwlZ5Q4lfaFtzKL2DQF9tiCSCaqKSxn8yYHntn0e/8oGg9qkOM+b8UJxSP81C6
 TVvUfizwHv5EwWZv3Iq7QneedOjSvUUV/LsNoECCdQA4g7ImC2hWFnFBekeW1KDXSoS1
 F6ZVINUwieClBPvQOwfzPl3Bx5ipqoBEcNcJAUVW06gjuef0KreBrDdUbUOy6A7GxoET
 J5fGnnVx77rYHSAxdeNnB8FA23qPbnbPmWeeGCY3snbEkiimQQZh3KLwwxvFFv5lnRdr
 eyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718881699; x=1719486499;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxzyW7YDaDnnWHkDmS4jUbFJC3ke0qKGt9kDBWWlz6g=;
 b=nT1d1I55b0UPH6/xiWTp/tUJGnn+HSpQ4qJbw5k1QYjQG1rYWbIPsST2teWBlcQcbI
 yvQKxzV61qOl6TDV43xFI2PIOD9QA/DnQZAXIlG204KB9ZLx7rC0CHB5Be/glpCu6SCZ
 ao1h70Gr+rCZY+7p7xdZVu9OKNH3ak4HHUeew0d4c5EH9lNAmxqHwXTkul3tzaRr6BEz
 XKpEYAJm028OPrAgzfjj16hOylNWE2BFie8y4XIYxCQQYaiYWpd/tPZ6LX3sD80IhXox
 AyGIkHmx2pUwcIDaoF7UaPLOHkayUpWmaAziDF9DJvs4F+8FHlgTa1uOLIdUBhjE92+v
 2YVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpj8ku5RK6PW81XwVIxByl8ySoP+oq0E4EYfaCmT3ogp7e575LjeNveWCGjrcREvdnB/ccxr9wk9g3X2/w6ahUL79+kQ==
X-Gm-Message-State: AOJu0Yyql/yDAs/sbreOj5hPsmUxczbHAlt3WyO4+0stMPtWLZd/L18+
 Hd4ioGApx7TZe6wkXRW9wOs13ZnbHVXMB7on5ZTVhHKO4JRm8Xl1
X-Google-Smtp-Source: AGHT+IHhetVkBBEvpzdshOEjed/Ah8IteV4+5EMHpEoxaJ72HwSw+1qF2zLWbk/TtGuEUAeuUcspIw==
X-Received: by 2002:a05:6512:108a:b0:52c:cb8d:637b with SMTP id
 2adb3069b0e04-52ccb8d6432mr3642617e87.12.1718881696983; 
 Thu, 20 Jun 2024 04:08:16 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d2122e7sm22315105e9.40.2024.06.20.04.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 04:08:16 -0700 (PDT)
Message-ID: <66740da0.050a0220.f7eae.7834@mx.google.com>
X-Google-Original-Message-ID: <ZnOwI95vQBuHXtB3@Ansuel-XPS.>
Date: Thu, 20 Jun 2024 06:29:23 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: Re: [PATCH v4 0/9] misc: introduce STATUS LED activity function
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
 <62bdc69d-edf8-422c-a6dd-4d50e1cdc1d1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bdc69d-edf8-422c-a6dd-4d50e1cdc1d1@gmx.de>
X-Mailman-Approved-At: Thu, 20 Jun 2024 16:14:38 +0200
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

On Thu, Jun 20, 2024 at 08:34:03AM +0200, Heinrich Schuchardt wrote:
> On 6/20/24 01:03, Christian Marangi wrote:
> > This series expand the STATUS LED framework with a new color
> > and a big new feature. One thing that many device need is a way
> > to communicate to the user that the device is actually doing
> > something.
> > 
> > This is especially useful for recovery steps where an
> > user (for example) insert an USB drive, keep a button pressed
> > and the device autorecover.
> > 
> > There is currently no way to signal the user externally that
> > the bootloader is processing/recoverying aside from setting
> > a LED on.
> > 
> > A solid LED on is not enough and won't actually signal any
> > kind of progress.
> > Solution is the good old blinking LED but uboot doesn't
> > suggest (and support) interrupts and almost all the LED
> > are usually GPIO LED that doesn't support HW blink.
> > 
> > To fix this and handle the problem of device not supporting
> > HW blink, expand the STATUS LED framework with new API.
> > 
> > We introduce a new config LED_STATUS_ACTIVITY, that similar
> > to the RED, GREEN and others, takes the LED ID set in
> > the LED_STATUS config and is used as the global LED for activity
> > operations.
> > 
> > We add status_led_activity_start/stop() used to turn the
> > activity LED on and register a cyclic to make it blink.
> > LED will continue to blink until _stop() is called.
> > 
> > Function that will start some kind of action will first call
> > _start() and then at the end will call stop().
> > If (on the broken implementation) a _start() is called before
> > calling a _stop(), the Cyclic is first unregister and is
> > registered again.
> > 
> > Support for this is initially added to the tftp, mtd and ubi
> > command.
> > 
> > This also contains a big fixup for the gpio_led driver that
> > currently deviates from the Documentation and make the
> > coloured status led feature unusable.
> > 
> > (world tested with the azure pipeline)
> 
> Hello Christian,
> 
> What is the relationship between CONFIG_LED and CONFIG_LED_STATUS?
> Can they be used at the same time or should they be exclusive?
> Should CONFIG_LED_STATUS depend on CONFIG_LED?

Well this is something that should have been fixed long time ago.
Given the 2 cmd and some function clash with each other they are totally
incompatible with each other and one should exclude the other.

> 
> This should be clarified both in Kconfig and in the documentation.
> 
> At least cmd/led.c and cmd/legacy_led.c are conflicting as both provide
> a command 'led'.
> 
> Can we unify the too?

Unify them is complicated (I tried) as the Status LED goes very deep and
can be supported by the board with specific implementation. LED driver
is all based on DT and most of the time it's just GPIO. (aka require OF
support)

> 
> Best regards
> 
> Heinrich
> 
> > 
> > Changes v4:
> > - Rebase on top of next
> > - Rework for cyclic changes on next
> > - Fix compilation error
> > - Fix compilation warning due to missing header
> > Changes v3:
> > - Add log on Status LED error conditions
> > Changes v2:
> > - Add Documentation conversion
> > - Rework to Cyclic and simplify implementation
> > 
> > Christian Marangi (9):
> >    misc: gpio_led: fix broken coloured LED status functions
> >    led: status_led: add support for white LED colour
> >    led: status_led: add function to toggle a status LED
> >    led: status_led: add warning when an invalid Status LED ID is used
> >    led: status_led: add new activity LED config and functions
> >    tftp: implement support for LED status activity
> >    mtd: implement support for LED status activity
> >    ubi: implement support for LED status activity
> >    doc: convert README.LED to .rst documentation
> > 
> >   cmd/legacy_led.c          |   6 +
> >   cmd/mtd.c                 |  19 ++++
> >   cmd/ubi.c                 |  15 ++-
> >   common/board_f.c          |   2 +
> >   doc/README.LED            |  77 -------------
> >   doc/api/index.rst         |   1 +
> >   doc/api/status_led.rst    |  35 ++++++
> >   drivers/led/Kconfig       |  30 +++++
> >   drivers/misc/gpio_led.c   |  41 +++++--
> >   drivers/misc/status_led.c |  75 ++++++++++++-
> >   include/status_led.h      | 231 +++++++++++++++++++++++++++++++++++++-
> >   net/tftp.c                |   7 ++
> >   12 files changed, 440 insertions(+), 99 deletions(-)
> >   delete mode 100644 doc/README.LED
> >   create mode 100644 doc/api/status_led.rst
> > 
> 

-- 
	Ansuel
