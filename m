Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8BACE837A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82937891D2;
	Tue,  1 Oct 2024 15:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c1FSQtdB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8759D891B8; Tue,  1 Oct 2024 14:25:49 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 687A5891BC
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cdbdbbb1cso1880212f8f.3
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785547; x=1728390347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6niXAgcX1N/AkgZ+dKk831lGYbjaHBN48HqyFT7EyRw=;
 b=c1FSQtdBXR+2K+R89Ym7X70B3+W8UhMKlm90ru/HHz2RdPBAUwH7NY7EDfy2i0kfqg
 n7BQaNoET93T6Fr2cvTeAj8qbMbpTSSseMoOWsaZnhPswIpQoAa10Pnil2VSGWNMVkbl
 7YCn2tnV0WRb29Wt411IyBo3KGQKLX0BdDgmkjszr2CKKI4qf+JGNMdyUxMmwZcL+h6p
 5RksxSoM4fXh6eXj6KCLXcIcqCrvxKq+wvK4OWKlgiEq5DlCfnAZPwPWKrBN8Tm2Ap0X
 L4BuOd0i2+ox/A2V+PvR+73dvELFh6ffwg0mD/p7UGJyOG9ozyEe7tdFtFdFRVIq2jaF
 IDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785547; x=1728390347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6niXAgcX1N/AkgZ+dKk831lGYbjaHBN48HqyFT7EyRw=;
 b=ovD4rJVFp0bYMad9r83akxqdXRu1BjxaGYd23FkrSpi9KNjzBKuKrnHZbmRNzpXTB1
 ckAD3fhhgbQLTMyW9OdErL6zcBC8fzURGMeI+rdtJnnStWn6TjckfiQFGDHNCwkC9j7t
 GLoiT38ynEruH8UcJYe3Aky+uJHTNLchNb3JWLLeTl0bzvJkwhCtvEKTQlDGIMUFn8c4
 DGezkmQ/W44aJC+kJx74w1hn3n/JXdQ4tEY//Yj7unxUZRb6O7oL5xwpXe7UehJBwZ88
 wtbUrXIPQq5DhzceFTWVz8y8UE8Wb4GOaaSwatu19p8Vf+RGdlQ3SVVaOlHBpiE3PTM/
 gO4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSyLvqWIOywlkbTb7+o5SFUJGkw6faymrzw9UXKIPfJaBw7EUwTUFYf2pt0rvsEvCk7PoLi+Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzTlTpEil4VCUaVwhNHZcyWL5B+y66aDeBUCmb9rHv0WAQuZRal
 Cl60v56+Hc5Bv+CayBB9HUsJU9atoWdNsTaKJoM0LMOlVorIItWY
X-Google-Smtp-Source: AGHT+IE4Sz8jjIH58TSs+FU6JqhA0VRWcrqaI9lQd03hy/9i0ZARvZi+QGlfFiSDWmCQX6ry8ct++g==
X-Received: by 2002:a5d:548a:0:b0:37c:d1c1:8e07 with SMTP id
 ffacd0b85a97d-37cd5b108a2mr7942512f8f.51.1727785546653; 
 Tue, 01 Oct 2024 05:25:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:25:46 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
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
Subject: [PATCH v5 01/11] led: toggle LED on initial SW blink
Date: Tue,  1 Oct 2024 14:24:34 +0200
Message-ID: <20241001122511.8832-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001122511.8832-1-ansuelsmth@gmail.com>
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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

Toggle the LED (ON if OFF, OFF if ON) on initial SW blink to handle this
corner case and better display a LED blink from the user.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/led_sw_blink.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
index 9e36edbee47..06a43db340c 100644
--- a/drivers/led/led_sw_blink.c
+++ b/drivers/led/led_sw_blink.c
@@ -103,8 +103,21 @@ bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
 		return false;
 
 	if (state == LEDST_BLINK) {
-		/* start blinking on next led_sw_blink() call */
-		sw_blink->state = LED_SW_BLINK_ST_OFF;
+		struct led_ops *ops = led_get_ops(dev);
+
+		/*
+		 * toggle LED initially and start blinking on next
+		 * led_sw_blink() call.
+		 */
+		switch (ops->get_state(dev)) {
+		case LEDST_ON:
+			ops->set_state(dev, LEDST_OFF);
+			sw_blink->state = LED_SW_BLINK_ST_OFF;
+		default:
+			ops->set_state(dev, LEDST_ON);
+			sw_blink->state = LED_SW_BLINK_ST_ON;
+		}
+
 		return true;
 	}
 
-- 
2.45.2

