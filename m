Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD31C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B123B88BC6;
	Wed,  7 Aug 2024 21:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z0BVhOR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F7B88C0E; Wed,  7 Aug 2024 21:54:27 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9660889D4
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-428e3129851so1682255e9.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723060464; x=1723665264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7MItkl2Z+Jt8Mvb5HInZTEP3uAkqW6OJugrf2S9IW4A=;
 b=Z0BVhOR/eVh6OI+9UukcxRAa06dG6+AzYDvE5/y6+rNtUI6SDv4TeTw32rw95BrRII
 TFEksozfb2KWMUqQeP3xFJnwY9BM4TWWxdvkyDfH5UgCAPTha0HeL0NaESbNM6luzA7s
 tVIbJnnYmL2xs4pEn+uk50YFwp9usLHcGAXBn1MwKRKT3wzVVSEC9D7x4IrHqKJM/U5d
 jsH404yOUM+ceVlKj9CyPLZw7BqjeWDDZGjdtMiaEPjRxxKNUxNov+mDs+4eTWgNNRmK
 z5OSdFOtZfRyIcXW23w9S1yxBKRSpirMB+kJsvbRsRx4w94Mwcs4fh9bumPUyqkmkKo6
 /Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060464; x=1723665264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MItkl2Z+Jt8Mvb5HInZTEP3uAkqW6OJugrf2S9IW4A=;
 b=Ajqsqs1lfG5BTc2OFRS08VqcKQmCaX2te4O6cHgZyr6TlSvX/ZM41mr0Z3PTcvhmab
 dYCERvm7F6DXmI128jObm8fT2jWVPdB+W7QdLsCIiY7M3Z/1vxDc3fLHFc1TppJyYqDO
 TPQYzfNR5CcF/cojS8Z8kwe08tNJdKpj4yanD5ps9VGNBiPr+ecxvSA3OYOWdqpHKDOW
 EJpZCoeT2dyLJUQo15c6dBqownUeiWjseml6inX+rdtwE/BQ5LxojME/14mJWViEVXvU
 BbnGtMBUPhnsheRBleX2wVt9z94rX7zmUC9S11/A1LAJF2R25R636ZlOd+gkYG5qadQx
 sGGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDJbajbwEb4TpCiOeL+z7Hpxyvs2VPNtOchZz9C+9cUvia4s39JOWbCB83IoKlQ/fwOR6KxdWw+pz31yMPmeS7tg+IoQ==
X-Gm-Message-State: AOJu0YwT5EdSkvUheCam7JDCAAiAqB4NLOctyYH1otPpD6jl/gIjvobh
 Ch2oSvUPv26/lhtIesZhg8pAMDYOH3ezUkI8ef5t1V9aeRP/OvK2
X-Google-Smtp-Source: AGHT+IECrUW4YimfG0yYeXPC80HW1cpGAeaIYdKPviJzzJq21nPal7gC1PTNvvAtL9ADaQBJ+8fgTQ==
X-Received: by 2002:a05:600c:35d2:b0:427:ff7a:79e with SMTP id
 5b1f17b1804b1-428e6b08baemr128345175e9.16.1723060463758; 
 Wed, 07 Aug 2024 12:54:23 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429057a8802sm44383765e9.21.2024.08.07.12.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:54:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
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
Subject: [PATCH v2 1/9] led: turn LED ON on initial SW blink
Date: Wed,  7 Aug 2024 21:54:04 +0200
Message-ID: <20240807195413.30456-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807195413.30456-1-ansuelsmth@gmail.com>
References: <20240807195413.30456-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We currently init the LED OFF when SW blink is triggered when
on_state_change() is called. This can be problematic for very short
period as the ON/OFF blink might never trigger.

Turn LED ON on initial SW blink to handle this corner case and better
display a LED blink from the user.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/led_sw_blink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
index 9e36edbee47..853278670b9 100644
--- a/drivers/led/led_sw_blink.c
+++ b/drivers/led/led_sw_blink.c
@@ -103,8 +103,11 @@ bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
 		return false;
 
 	if (state == LEDST_BLINK) {
+		struct led_ops *ops = led_get_ops(dev);
+
+		ops->set_state(dev, LEDST_ON);
 		/* start blinking on next led_sw_blink() call */
-		sw_blink->state = LED_SW_BLINK_ST_OFF;
+		sw_blink->state = LED_SW_BLINK_ST_ON;
 		return true;
 	}
 
-- 
2.45.2

