Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F300C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3306886BB;
	Mon, 12 Aug 2024 12:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NF1qPiU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E9287D6B; Mon, 12 Aug 2024 12:33:04 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B9088680
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4280b3a7efaso30726225e9.0
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723458782; x=1724063582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7MItkl2Z+Jt8Mvb5HInZTEP3uAkqW6OJugrf2S9IW4A=;
 b=NF1qPiU37hIJOXt11AYoRty84qEckGe8VkIEbP7bKJjHV5au+eZRpfObLjC+OPZ8Oa
 CX3zI8KqqqW/qihDGTeZBiOJTpMTTsXF5/Mt9Z6b2ThQtePvvvCnIOGdWDSHF45y1Fd1
 1KyB9IN4enbK2GrhyDikV/L1Yb9EFa+OZhVL0sLDCm/wl5M8bJ/sintLm04P29Jd1vjN
 /wDOlguWY59UqY1h170rY5zIRuQ+OZgXPWyvOmMK3gptj4fJuaBqScdRt528SgjfkB/S
 9IC8Ih/ABAk1mliwaCMmcZSdcQJEZRtjBkZ/oSAzTV7V3Hbm3KZe1Sp7QP0N5Z2Pg7UQ
 9P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458782; x=1724063582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MItkl2Z+Jt8Mvb5HInZTEP3uAkqW6OJugrf2S9IW4A=;
 b=mFXMIKvgN4rLsTYqztWJCI+CNudJXwnrcgtolE859fy4f7fAMF0ADpcCjBP1IRaHYS
 FaTx31rRerCnFda1kMQG1x2D8g/GuQ+emQMFQ0EwqXZCgniYCur+Col+JVVDMzUrM3lE
 Q01sfkhjflKKFWGnk31cLgXrGWiGnBbaaZlSqTBHUruKpq2giqXLTxIf0YMTlVc/Tas9
 ZeS05DwPxd+Yca3okR0VCCAGUchFyqRGD701TFaS3FxxlHPqCj71Jp02Vt7AW6wU0Hn5
 tVofnlaZaOB5g7pqu9xGhZoIaKKyoO267kuFuzFcTje+t3iE1wC1CHHPHrRpKXaU0xhi
 683g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYzQudqxw+oUp1UHn5pkdHlmwQf2kkFBsW+/gHR8b4Tvj5QGfz8xW7MXIQBUKaz88eCu8kXmCjzQz5uYlBgE1WynWxJA==
X-Gm-Message-State: AOJu0YwstVjri+ahuRNfRjwYD59zxuL3VPzgSuCo8UWxGx4F5xZ+vLId
 qKf9E5kdP2tjRkz+a9k5sON/LYUavb/DAvhXBn0NG5NLprxA1++M
X-Google-Smtp-Source: AGHT+IHzPAIHDR8YU0uwHbtPhMhjWpYBL7JJAtXgoJ6ywGPEzFlPBvq74zrkOVdWXZkqzNLoTd97pg==
X-Received: by 2002:a05:600c:4e91:b0:428:1799:35e3 with SMTP id
 5b1f17b1804b1-429c3a28d5dmr61451465e9.21.1723458781973; 
 Mon, 12 Aug 2024 03:33:01 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm186016425e9.37.2024.08.12.03.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 03:33:01 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
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
Subject: [PATCH v3 1/9] led: turn LED ON on initial SW blink
Date: Mon, 12 Aug 2024 12:32:43 +0200
Message-ID: <20240812103254.26972-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812103254.26972-1-ansuelsmth@gmail.com>
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
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

