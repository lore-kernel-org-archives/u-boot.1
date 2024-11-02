Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6553E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1D48917E;
	Sat,  2 Nov 2024 20:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aZ3H/pAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC4489065; Sat,  2 Nov 2024 20:36:26 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979A689066
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so34712205e9.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730576183; x=1731180983; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HRjgP+pF+vSLQPt/GV90yirr3v/6bY8czrZaUn5OS4Y=;
 b=aZ3H/pArD79JGEzfiwpNWO9EfnCQjPcye6FD7VqVziLlDB0QG5KQZqVYzwUZiy29V+
 mOvdUkJB9X8A6B3FHQAKQwd2eRjyk+rJEsGYjclPViZG9krM3LyGY/msdO1sT2GGKNi9
 tHNHhjiqMBuQO4kFL67dA+NMy2M+VYybhyEfyJItFSDNsOGsudeOsI3xwPw8sd8QewGl
 wHOd0/riapa1IBxiGyW+0s5HeSZi/Gcaonb3FipXlGZjgZg20ckCEmC4QMFH56xo3B1O
 6bni+036VKdZtrx5yh5yF6UThgy3VT5MdqpKs1foYK3H4BVo9CUexSVF+qkCngfq3zLD
 wbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576183; x=1731180983;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRjgP+pF+vSLQPt/GV90yirr3v/6bY8czrZaUn5OS4Y=;
 b=MQE1h9rYBomZv/wPW0iG7XkIv/PRwQ3Hx81kbMbJZel92ODIm+AEIuC8x8Z2qmK9yM
 ePT/Ft9BDfuWApwqtsa6q7JnQ/JNd6thwTxXGveHRyzapA04Fw7zBXc5OudJc0U1MOEp
 SINyi91YlYJcR9aVKOe8RQxETMvo5KNF8oSxZEoO08jXLs6A1Q7KlBt/w3ppE7lhvcvn
 QrwQJe2E5SHfrtc8CH3E9S3eQLPbmkvbjwIPP55Getw4zao/QgdHffclYB6/2CvSxaFS
 zdxgYP39jebP1HEDFIztjfHcKBaeaVkdz8lEnzbm2SDTwvUE37LmMIzoUY+OGgbsO6q+
 2DrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq4JhqD1aD0XtA3f5Fq5nQO1AHV6SdDCdt2ck+CrrRXyBJHO8BbFqYgFjlcB3Mr3ylEk3EJ08=@lists.denx.de
X-Gm-Message-State: AOJu0YxsD8qTK2gGP/a7MWkGAIMIO5mDDt4XcMbFyDDj4wkvh20s6WvE
 znWWtH44owWE3xH0/d//AaHMqx1gTq3UlQfWov9DTyjgiYd986ov
X-Google-Smtp-Source: AGHT+IG9fNsrlb70GGxOJUT2EKx3sfao9NdvOjOvVu04neYRy3tnNV4LQSWZolO1SWP1Ikv3LMnJxg==
X-Received: by 2002:a05:6000:1f8c:b0:37d:2de3:bf8a with SMTP id
 ffacd0b85a97d-381c7a6bcb4mr7517011f8f.26.1730576182671; 
 Sat, 02 Nov 2024 12:36:22 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e74casm8776202f8f.65.2024.11.02.12.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:36:22 -0700 (PDT)
Message-ID: <67267f36.df0a0220.87602.7b89@mx.google.com>
X-Google-Original-Message-ID: <ZyZ_MLfQZ67w9sPh@Ansuel-XPS.>
Date: Sat, 2 Nov 2024 20:36:16 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v5 03/11] led: implement LED boot API
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-4-ansuelsmth@gmail.com>
 <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
 <CAFLszTh9WYnya=8YXXFEcSuVUYuhCGy-+iYFRucgMZq+-1H5UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTh9WYnya=8YXXFEcSuVUYuhCGy-+iYFRucgMZq+-1H5UQ@mail.gmail.com>
X-Mailman-Approved-At: Sat, 02 Nov 2024 20:48:44 +0100
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

On Sat, Nov 02, 2024 at 01:33:10PM -0600, Simon Glass wrote:
> Hi Christian,
> 
> On Wed, 2 Oct 2024 at 16:55, Simon Glass <sjg@chromium.org> wrote:
> >
> > On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > Implement LED boot API to signal correct boot of the system.
> > >
> > > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > > designated boot LED.
> > >
> > > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > > This makes use of the /options/u-boot property "boot-led" to the
> > > define the boot LED.
> > > It's also introduced a new /options/u-boot property "boot-led-period"
> > > to define the default period when the LED is set to blink mode.
> >
> > BTW could you please send a schema update for this so that Linux accepts it?
> 
> I'm just checking that you did this?
>

Yep [0]. Also tagged Rob 2 hours ago. (eh the coincidence)

Tell me if I should send it with usual way with a dedicated mail. (any
hint on the mailing-list address?)

[0] https://github.com/devicetree-org/dt-schema/pull/144

> >
> > >
> > > If "boot-led-period" is not defined, the value of 250 (ms) is
> > > used by default.
> > >
> > > If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
> > > led_boot_blink call will fallback to simple LED ON.
> > >
> > > To cache the data we repurpose the now unused led_uc_priv for storage of
> > > global LED uclass info.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/led/Kconfig      | 11 ++++++
> > >  drivers/led/led-uclass.c | 85 ++++++++++++++++++++++++++++++++++++++++
> > >  include/led.h            | 55 +++++++++++++++++++++++++-
> > >  3 files changed, 149 insertions(+), 2 deletions(-)
> > >
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon

-- 
	Ansuel
