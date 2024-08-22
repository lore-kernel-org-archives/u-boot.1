Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4114DC52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 11:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A669F88EE5;
	Thu, 22 Aug 2024 13:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zmz0K48K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3592588EE8; Thu, 22 Aug 2024 13:20:29 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE3488C3A
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 13:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso4351455e9.3
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724325627; x=1724930427; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=m+IRpO+uHnBXQkaWh1UKS8rabJfHtk4bc+XikclFS0s=;
 b=Zmz0K48KUjKhibQrc6a/jzErZbYTvL6deaUeOuLdM3Ca+uhaFu+JJ01hhuUQouVp58
 jbewTKzd7XfwYHoZg2BJl6xacxYHAva4o29j59NujOOK7ZoBTEnPsyQNzOSwqHYa93dx
 8Er8YlijWawZGYPMsL53hhuyOT0LjRjM9vl6T6Qo4QtzjHwpxFHb5flRvGt4341um8Cv
 s7Idb69ipq9VHHm+4WQ0844auM8ITegLFqw7SNgM8BPTocL4zOcGlh1LV0RhevgIMjLT
 3ZhcFluKxYWmFoYgQT5yaZzlnVmJeavNu9eAf7Wn3UYpW4iLNq5T0wWmQ8bgg2PBj1WD
 9CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724325627; x=1724930427;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+IRpO+uHnBXQkaWh1UKS8rabJfHtk4bc+XikclFS0s=;
 b=FAAaM9MDTckrsPz6zqm2/OWKH9e8ZOgL7TzPGcvzOyemYBRmhOiIcXNxBr5zIDCVo0
 pMMyBoU5e7biHxDQvz6hT8GpF7L7t4kbqDkK+5eAWaZyh+108KOpehCOlN+CGcenDKMn
 +FRD204O97SZpQiyOED75DmIQXj0sVuzA3VoY5cBBo9o6zRZoYuqNy7B3Cg2G8E0Cao5
 JU3s7BbbCYOn2ehmgzsm/iNTglO47vVOGJZX2SFkFuLP2SZRrDXF+0F53c4nr+92FrSh
 jJ5CtgYRwX+N9BnI1d8xuKtwccvHx+Lr+eDo6ImbBhPWdKWWWj88NF3uTQ7JjWRyNQLg
 Mqkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrO3DK94MiqdIUJmKvR/8vIOeCiH+uscAiqBkXPx+bREIXXk0kK0oCaNTk63o9RfXj8ykffrM=@lists.denx.de
X-Gm-Message-State: AOJu0YzcM1H8tGQQbwF1Kk6Xldk6Vy8sx1yxDMWdDupnx8a9rwa/WZaT
 OIU1AnHST9Os9ItqnZ43oD80IRb9aSZlNkp1CPTL/Fb1O4bt6ygz
X-Google-Smtp-Source: AGHT+IHetCRRq5HlNpWe1h+kiA3z4h1pVfjm0O7cTG2QQB+mR0xP+QVt48yI3P+vcei2d+4N1cNHKw==
X-Received: by 2002:a05:600c:4706:b0:426:6688:2421 with SMTP id
 5b1f17b1804b1-42ac55d87d7mr9979915e9.11.1724325626344; 
 Thu, 22 Aug 2024 04:20:26 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-209-141.retail.telecomitalia.it.
 [87.1.209.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abefc62dbsm57217465e9.30.2024.08.22.04.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 04:20:26 -0700 (PDT)
Message-ID: <66c71efa.050a0220.1f7dd.ecb2@mx.google.com>
X-Google-Original-Message-ID: <ZscXKCt0APG0RtjF@Ansuel-XPS.>
Date: Thu, 22 Aug 2024 12:47:04 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
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
 <BD52390C-A644-44EF-B691-2816E0F56770@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD52390C-A644-44EF-B691-2816E0F56770@gmx.de>
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

On Tue, Aug 13, 2024 at 12:00:59AM +0200, Heinrich Schuchardt wrote:
> 
> 
> Am 12. August 2024 12:32:43 MESZ schrieb Christian Marangi <ansuelsmth@gmail.com>:
> >We currently init the LED OFF when SW blink is triggered when
> >on_state_change() is called. This can be problematic for very short
> >period as the ON/OFF blink might never trigger.
> >
> >Turn LED ON on initial SW blink to handle this corner case and better
> >display a LED blink from the user.
> 
> If the the prior state is on, blinking should start with off.
> 
> If the prior state is off, blinking should start with on.
>

A bit confused. You mean I should improve the commit description or the
code needs to he changed to reflect this and check the LED status before
applying the BLINK?

> 
> 
> >
> >Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >---
> > drivers/led/led_sw_blink.c | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> >index 9e36edbee47..853278670b9 100644
> >--- a/drivers/led/led_sw_blink.c
> >+++ b/drivers/led/led_sw_blink.c
> >@@ -103,8 +103,11 @@ bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
> > 		return false;
> > 
> > 	if (state == LEDST_BLINK) {
> >+		struct led_ops *ops = led_get_ops(dev);
> >+
> >+		ops->set_state(dev, LEDST_ON);
> > 		/* start blinking on next led_sw_blink() call */
> >-		sw_blink->state = LED_SW_BLINK_ST_OFF;
> >+		sw_blink->state = LED_SW_BLINK_ST_ON;
> > 		return true;
> > 	}
> > 

-- 
	Ansuel
