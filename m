Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8741EC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 19:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E91F288663;
	Fri,  9 Aug 2024 21:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFNwWkv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D548F88663; Fri,  9 Aug 2024 21:12:44 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D220A88581
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 21:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-36868fcb919so1440821f8f.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723230762; x=1723835562; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:to
 :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=IzXbVzwoSkVU0jZd3aqwPaE3B+VM2x0xn1Ovd+xdtMA=;
 b=ZFNwWkv1G681uk+4dsmjyjVZp2xLQrGA7JjGo0A3QyQ78nOQoHtMFTD/duGDFTyDQZ
 TxM/oIF01nLpZwKXs3yWJHWIw6vkcPPZngquwu5xk5MxFBR+SHo32EEu6A/mSQxW1kFz
 RuVZleUsMtOBSxMP+ujcW0hXAsLwsMnFiazNQiCZAooDy/3ZI8ipKZe0Z4EFIOGwYHU3
 5ILfoguJtJeH8BEJmgZyZujGHpk9EdQ6T3q/THoNOmS7ES7YZW1e3v6bYEsAEG8v+a4r
 KnJf1i/wT7wf+aE5xWdQX8AT0ppc4ENOX0OIUpZoFW3GgSWmYpm7gVdQDWZW/9xAMicz
 2/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723230762; x=1723835562;
 h=in-reply-to:content-disposition:mime-version:references:subject:to
 :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IzXbVzwoSkVU0jZd3aqwPaE3B+VM2x0xn1Ovd+xdtMA=;
 b=k+WRQh8Oea4eCtrIp8++I1FsU6cuje4sLYRYpsr8hQKTQQID9tow1a3xNQtQNZoVaN
 ReI9+Ya785QIov7KHLoyUoAP3xS5hv3XeAtP+tMbd3uVX2c6Z2MMSG3IPnSFTRTnEhyd
 qH1dPrnQU05KizJeJzoXkeRrfiLAEcMK1BKLtkOewbQRmcJdBl0goYmnxxFpCskyvvUD
 MLsmKeT/jBdCJ5yxm0vyRT7mV7IENefCIyWgf6iIDx14tQTGL9GRKHQVonnQfwlEUY5w
 y1SrA/hBP4n6AWTOejIDjQjTLrKGXS0VG4s8HAXl9ViZSf8hswWUcApC4pZ53B6SZvUD
 NaPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEjwSAiEmriEkjE1mrZVjnoQRccntVjJHH9LzRZ3f0YfoiS4oyWgZEMaee3OJlt7UzZHLIdeFQrZtww8bnZqqEkunZqQ==
X-Gm-Message-State: AOJu0Yz+BLx8xlZHlUtsLG0GLUiLZlxHw1zrrHk3Cr9cZRjKOd6vupFf
 K3LDA5MGD3w1eKU8w1eEcmyJBeGkdXOiWUzzmaFUIun7jD4jB6dO
X-Google-Smtp-Source: AGHT+IHyVrDcpdSeTuWIJqXzPj48v0B8glDZ854Ed0PBrHdNJ/02n0y8mSUjJAo0MduxBOjss99CEg==
X-Received: by 2002:a5d:453a:0:b0:367:9d2c:9602 with SMTP id
 ffacd0b85a97d-36d616e2b48mr1978605f8f.49.1723230761807; 
 Fri, 09 Aug 2024 12:12:41 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-10-253-138.retail.telecomitalia.it.
 [87.10.253.138]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfeef22sm242719f8f.52.2024.08.09.12.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 12:12:41 -0700 (PDT)
Message-ID: <66b66a29.df0a0220.208aae.0bba@mx.google.com>
X-Google-Original-Message-ID: <ZrYgzcXcDpa99mtO@Ansuel-XPS.>
Date: Fri, 9 Aug 2024 15:59:41 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 9/9] doc: introduce led.rst documentation
References: <20240807195413.30456-1-ansuelsmth@gmail.com>
 <20240807195413.30456-10-ansuelsmth@gmail.com>
 <20240808-ferret-childless-9151f7abae55@thorsis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-ferret-childless-9151f7abae55@thorsis.com>
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

On Thu, Aug 08, 2024 at 08:34:32AM +0200, Alexander Dahl wrote:
> Hello Christian,
> 
> Am Wed, Aug 07, 2024 at 09:54:12PM +0200 schrieb Christian Marangi:
> > Introduce simple led.rst documentation to document all the additional
> > Kconfig and the current limitation of LED_BLINK and GPIO software blink.
> 
> This is a good idea.  An overview of all the LED possibilities in the
> Documentation is much appreciated.  Remarks below.
> 
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  doc/api/index.rst |  1 +
> >  doc/api/led.rst   | 10 ++++++++++
> >  include/led.h     | 38 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 49 insertions(+)
> >  create mode 100644 doc/api/led.rst
> > 
> > diff --git a/doc/api/index.rst b/doc/api/index.rst
> > index ec0b8adb2cf..9f7f23f868f 100644
> > --- a/doc/api/index.rst
> > +++ b/doc/api/index.rst
> > @@ -14,6 +14,7 @@ U-Boot API documentation
> >     event
> >     getopt
> >     interrupt
> > +   led
> >     linker_lists
> >     lmb
> >     logging
> > diff --git a/doc/api/led.rst b/doc/api/led.rst
> > new file mode 100644
> > index 00000000000..e52e350d1bb
> > --- /dev/null
> > +++ b/doc/api/led.rst
> > @@ -0,0 +1,10 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +LED
> > +===
> > +
> > +.. kernel-doc:: include/led.h
> > +   :doc: Overview
> > +
> > +.. kernel-doc:: include/led.h
> > +   :internal:
> > \ No newline at end of file
> > diff --git a/include/led.h b/include/led.h
> > index 61ece70a975..77b18ddffbf 100644
> > --- a/include/led.h
> > +++ b/include/led.h
> > @@ -10,6 +10,44 @@
> >  #include <stdbool.h>
> >  #include <cyclic.h>
> >  
> > +/**
> > + * DOC: Overview
> > + *
> > + * Generic LED API provided when a supported compatible is defined in DeviceTree.
> > + *
> > + * To enable support for LEDs, enable the `CONFIG_LED` Kconfig option.
> > + *
> > + * The most common implementation is for GPIO-connected LEDs. If using GPIO-connected LEDs,
> > + * enable the `LED_GPIO` Kconfig option.
> > + *
> > + * `LED_BLINK` support requires LED driver support and is therefore optional. If LED blink
> > + * functionality is needed, enable the `LED_BLINK` Kconfig option. If LED driver doesn't
> > + * support HW Blink, SW Blink can be used with the Cyclic framework by enabling the
> > + * CONFIG_LED_SW_BLINK.
> > + *
> > + * Boot and Activity LEDs are also supported. These LEDs can signal various system operations
> > + * during runtime, such as boot initialization, file transfers, and flash write/erase operations.
> > + *
> > + * To enable a Boot LED, enable `CONFIG_LED_BOOT_ENABLE` and define `CONFIG_LED_BOOT_LABEL`. This
> > + * will enable the specified LED to blink and turn ON when the bootloader initializes correctly.
> 
> This is somehow redundant to defining "u-boot,boot-led" in
> *-u-boot.dtsi snippets, isn't it?  This is documented in
> doc/device-tree-bindings/config.txt and used by roughly a dozen dtsi
> files and five times in board code.  It also stores a LED label, which
> board code can make use of then, but I think it's not further
> integrated in any driver or class code.  Are you aware of that mechanism
> and hwo does it fit into your rework of the boot led?
>

No I wasn't aware of those property. I will check how that can be
expanded and implemented here as it seems a better way than raw configs.

> 
> > + *
> > + * To enable an Activity LED, enable `CONFIG_LED_ACTIVITY_ENABLE` and define
> > + * `CONFIG_LED_ACTIVITY_LABEL`.
> > + * This will enable the specified LED to blink and turn ON during file transfers or flash
> > + * write/erase operations.
> > + *
> > + * Both Boot and Activity LEDs provide a simple API to turn the LED ON or OFF:
> > + * `led_boot_on()`, `led_boot_off()`, `led_activity_on()`, and `led_activity_off()`.
> > + *
> > + * Both configurations can optionally define a `_PERIOD` option if `CONFIG_LED_BLINK` or
> > + * `CONFIG_LED_SW_BLINK` is enabled for LED blink operations, which is usually used by
> > + * the Activity LED.
> > + *
> > + * When `CONFIG_LED_BLINK` or `CONFIG_LED_SW_BLINK` is enabled, additional APIs are exposed:
> > + * `led_boot_blink()` and `led_activity_blink()`. Note that if `CONFIG_LED_BLINK` is disabled,
> > + * these APIs will behave like the `led_boot_on()` and `led_activity_on()` APIs, respectively.
> > + */
> > +
> >  struct udevice;
> >  
> >  enum led_state_t {
> > -- 
> > 2.45.2
> > 

-- 
	Ansuel
