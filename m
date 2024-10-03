Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E10CF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 12:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0848E88D75;
	Thu,  3 Oct 2024 14:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A2Idtfex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AB1688BBC; Thu,  3 Oct 2024 12:59:24 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28CFF88B8F
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 12:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so7710645e9.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727953160; x=1728557960; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jz85hkJSHtX9giYt5ElRGyNpjbuBqYkcoEmLKu+zxiY=;
 b=A2IdtfexcYBpAEQBVPQatTFZXZZ1Kh6q29y06+pH1mkTufKuZl34lvs4r52mNtKxud
 LBcFLg37HMbAHzklgg656SZ/HzCyUwyo0Qux2IzkOP5qdC6OaiZMdl/PqvXqkCBar2yv
 YPEQRDSmNaT3UCJEjBGIfES0P6yzdfNXuF4XDIUKp27KomNH0H2t/JWfB1ZGUOvi+Y2B
 aQOKZE8vDbCRd+evy6St6TDMGDmj62k/+2x13GIwddK6Ola9mpg9clDtbc0a9MctyirA
 +8zTEg7Un1+phuPJeNYoclsYQrBHqJ1cXhXchvT95++GofyhE3P8s3HYoT4AZttLgB5t
 +7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727953160; x=1728557960;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jz85hkJSHtX9giYt5ElRGyNpjbuBqYkcoEmLKu+zxiY=;
 b=J1wzgFZ4uckcyzAt023p533Ha5pkG596elCKSfLtlPDOfipSdjYgmGuQxK/TcyMyoX
 LaMTJb6s0Ulta9KCycUkLHVwd4E6dXLUraIG5zFPE86EG1pCZVdNa4rsIEaYyK5gRKPs
 TNlZ55TqX6O9Yw3/jhVDR3CocODrHUjriuDIcXqfaG3j/uqu+JInJQ6yiJVDQo2QIV90
 YBXSNuznoVo7Z+hDU4YzaUUu1UKN29aRWvXTZUbnxBAtQxMqGJRTLMmhWtG/i3OfeeK7
 /bX6GKISC7IfaOVFqr3OS2VdyVLLHro1AHSjD4DfJDEx/6SAl8SxS2I0Iw7y3vWd08ix
 2qzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqPON5yr+XojoY9bCV8ug4KbjmPtD4txGG3xeMGAlTh2pejMhDHdyo7eHuginv3hmg0ptvT7A=@lists.denx.de
X-Gm-Message-State: AOJu0YwxISJm7ckLo75kbEBYmHukhyINHlxWZ5ID5C0elONwBxpQ1va/
 EWwgIoT3SWcI3t65CDdO+Z2WKcRjuuIEBbQSL4iMoSJQykke7nMT
X-Google-Smtp-Source: AGHT+IEkX4bNihzaIQlxcCZnBM/59XpnAlBOXrzNN0FXnyXHBLruDtghrOx9Z0R/XxWToy1lu1KtVA==
X-Received: by 2002:a05:600c:4704:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-42f777b99d4mr46771845e9.13.1727953160301; 
 Thu, 03 Oct 2024 03:59:20 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f8025b1f5sm12632495e9.16.2024.10.03.03.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 03:59:19 -0700 (PDT)
Message-ID: <66fe7907.7b0a0220.7e45a.3774@mx.google.com>
X-Google-Original-Message-ID: <Zv55ArXuHTSMhh_S@Ansuel-XPS.>
Date: Thu, 3 Oct 2024 12:59:14 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
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
Subject: Re: [PATCH v5 01/11] led: toggle LED on initial SW blink
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-2-ansuelsmth@gmail.com>
 <CAOf5uwn0JiCbJEZ4COMDKMwLbGxcN__8=wW404w=Xat4=T2tnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOf5uwn0JiCbJEZ4COMDKMwLbGxcN__8=wW404w=Xat4=T2tnw@mail.gmail.com>
X-Mailman-Approved-At: Thu, 03 Oct 2024 14:51:36 +0200
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

On Thu, Oct 03, 2024 at 08:22:21AM +0200, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Tue, Oct 1, 2024 at 2:25 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > We currently init the LED OFF when SW blink is triggered when
> > on_state_change() is called. This can be problematic for very short
> > period as the ON/OFF blink might never trigger.
> >
> > Toggle the LED (ON if OFF, OFF if ON) on initial SW blink to handle this
> > corner case and better display a LED blink from the user.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/led/led_sw_blink.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> > index 9e36edbee47..06a43db340c 100644
> > --- a/drivers/led/led_sw_blink.c
> > +++ b/drivers/led/led_sw_blink.c
> > @@ -103,8 +103,21 @@ bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
> >                 return false;
> >
> >         if (state == LEDST_BLINK) {
> > -               /* start blinking on next led_sw_blink() call */
> > -               sw_blink->state = LED_SW_BLINK_ST_OFF;
> > +               struct led_ops *ops = led_get_ops(dev);
> > +
> > +               /*
> > +                * toggle LED initially and start blinking on next
> > +                * led_sw_blink() call.
> > +                */
> > +               switch (ops->get_state(dev)) {
> > +               case LEDST_ON:
> > +                       ops->set_state(dev, LEDST_OFF);
> > +                       sw_blink->state = LED_SW_BLINK_ST_OFF;
> > +               default:
> > +                       ops->set_state(dev, LEDST_ON);
> > +                       sw_blink->state = LED_SW_BLINK_ST_ON;
> > +               }
> > +
> >                 return true;
> 
> I think here error is not take in account. Is somenthing that we
> should care? and if not we should
> warning the user?

Yes it's intended. Here it's assumed these function works and are
present. The check are already done before calling the on_state_change.

> 
> Apart of that
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> 
> michael
> 
> >         }
> >
> > --
> > 2.45.2
> >
> 
> 
> -- 
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
> 
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com

-- 
	Ansuel
