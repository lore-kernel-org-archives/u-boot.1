Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBF5CF395D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 16:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8052D89257;
	Thu, 19 Sep 2024 18:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYLaaoSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDB15891B0; Thu, 19 Sep 2024 18:26:54 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157F589257
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 18:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cba8340beso13825975e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726763211; x=1727368011; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=I4OmWOKwQnaaI26Gppoek4wt1Muvi5gG63vKqD7Bfi4=;
 b=AYLaaoSFUrApOfhU5mwSZMb6wDxbWTaYphIhpJPMMPYlcI3/owBF7h3tS20LrdR/O2
 eX9BCUh9rMEKV+Rd8eS5KCMmt6cA9LOzHHYG3E4qstsxXwSJ4Uvn26Ei/0g3iBriBfwC
 nM5LBDfMipS7QYFiLyObp50aoNILcV30r62YwDalSyTsRWjOj62JKa9D8X4S2NLdRUfo
 j965K0cJC3lOrdp3egg6T/6ECImieyUu/zgGZkedvuaTGgxa5zuTSSXEwi2xK6VcgH43
 OkTyucBdT7sTLOC0scxT2ewkqUysz2tuGwHTJcbjdNcaXquUxnc5NnxkUyKp7QE1f2Fy
 j5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726763211; x=1727368011;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4OmWOKwQnaaI26Gppoek4wt1Muvi5gG63vKqD7Bfi4=;
 b=oxPFQr2WbNZEbuVp6C80n7RsYq5CS8sW/STXtffx1kDtk7z2JODG3KLG36KSijc/uV
 X+reyuAGwnmEEk7agATdf46ocBxOdeRK9Jwz5Oy2ymHjsGHxb35DP58TaWzbK9gDcoUC
 89uI3b8bYJZws9faqyquaZNM/vUPh7fo14HZse1jKYhm4I62vwvkD9UU5T45ai150xTO
 TCieE+y8r0kKBMEWrvGGpZtkTSJevSSRZNQR/OMH9KDbpuDimBUPhlALwGfMlpWfdROj
 b1qHxdOj5kt1dbUHzW432pVpPouVmiW8enJr1UP7lKHLQ8e2cNB33iAKpqGjy4B7UMed
 cBLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKYMqXxEcwm4pOVCEwIb/WKfw6p8WEWGph+rtSk8H1a7rBUz13i+EltTyvvK1frUqq4rcd4P0=@lists.denx.de
X-Gm-Message-State: AOJu0YxDhmREMncbCE6DdERSINzfsBxCVNSsBoTg4q5fvlvrR1Fhdobk
 FHBINjiFaY/csKdEm4rgCYPvvqPoChxqz6l/7cWjdFcmKoeuGzC6
X-Google-Smtp-Source: AGHT+IFAISyQ65kSW51dMGQ3IMz2GWOH7+sy2CagssKOFS67gPxaPFVdEXv8Q4bCwqs7pkHOjzPVng==
X-Received: by 2002:a05:600c:4f53:b0:42c:bd4d:e8d6 with SMTP id
 5b1f17b1804b1-42e7a8c1d04mr1390445e9.3.1726763211065; 
 Thu, 19 Sep 2024 09:26:51 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754a7aedsm26260325e9.31.2024.09.19.09.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 09:26:50 -0700 (PDT)
Message-ID: <66ec50ca.050a0220.eee78.a0d3@mx.google.com>
X-Google-Original-Message-ID: <ZuxQx4sItXsq3EmO@Ansuel-XPS.>
Date: Thu, 19 Sep 2024 18:26:47 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/9] led: turn LED ON on initial SW blink
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-2-ansuelsmth@gmail.com>
 <CAFLszTib_uLiGHRo2Gh5V4p8e3TMx=zWzHWQ5YdeW_yh2gWxoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTib_uLiGHRo2Gh5V4p8e3TMx=zWzHWQ5YdeW_yh2gWxoA@mail.gmail.com>
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

On Thu, Sep 19, 2024 at 04:13:44PM +0200, Simon Glass wrote:
> Hi Christian,
> 
> On Mon, 12 Aug 2024 at 12:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > We currently init the LED OFF when SW blink is triggered when
> > on_state_change() is called. This can be problematic for very short
> > period as the ON/OFF blink might never trigger.
> >
> > Turn LED ON on initial SW blink to handle this corner case and better
> > display a LED blink from the user.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/led/led_sw_blink.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> nit below
> 
> >
> > diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> > index 9e36edbee47..853278670b9 100644
> > --- a/drivers/led/led_sw_blink.c
> > +++ b/drivers/led/led_sw_blink.c
> > @@ -103,8 +103,11 @@ bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
> >                 return false;
> >
> >         if (state == LEDST_BLINK) {
> > +               struct led_ops *ops = led_get_ops(dev);
> > +
> > +               ops->set_state(dev, LEDST_ON);
> 
> Normally in drivers we define functions like led_set_state() in the
> uclass, rather than calling things directly like this.
> 

I used ops directly as I'm following how it's done in led_sw_blink and
because the support for these ops is already validated and we don't need
to check for the -ENOSYS condition.

Hope it's ok. Also as suggested I changed the function to toggle the LED
as suggested. I added the review tag. Tell me if I have to drop it in
the next revision.

> >                 /* start blinking on next led_sw_blink() call */
> > -               sw_blink->state = LED_SW_BLINK_ST_OFF;
> > +               sw_blink->state = LED_SW_BLINK_ST_ON;
> >                 return true;
> >         }
> >
> > --
> > 2.45.2
> >
> 
> Regards,
> Simon

-- 
	Ansuel
