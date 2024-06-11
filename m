Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6429FC27C78
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 02:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5906887BA;
	Wed, 12 Jun 2024 04:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aYWcnX4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B990B88757; Wed, 12 Jun 2024 01:14:56 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBC887B30
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 01:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35f22d3abf1so2734520f8f.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718147694; x=1718752494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Deq+K/f4mLjipGQcm5bssaae9fAIVoi6omAuikcDoDw=;
 b=aYWcnX4UUii0QYNT3AopotqCyVR9pRY9n7rGjFmAC3KFrKHlhO8nRUDCnHSQD0Tfoq
 okg/l2uio45jpCfxIAeuYKjVPNM76g9TXu+oSCv28XOyjMKF5Av7I8Yl5gUG5HFPqYuv
 WwJ9MpJ6cH/X4hkNcMbfX0VGH+gco3fjRpxnLldNQUJ6uem+4EOlz1MVaIWUvLSLz0XI
 mg/Fh5H/xVjzni9xYpnD/SesfAngSPZQvPeZXtVX/ZQYqRSC1qJ5hRw/hCfh803891XU
 aOVw31s8PsD+x/fACZbnJ86qGR5yJlkHAVHJO/FuPkkd3hZ3gOCoIfWqMVydrgnPBCSn
 3B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718147694; x=1718752494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Deq+K/f4mLjipGQcm5bssaae9fAIVoi6omAuikcDoDw=;
 b=fMzgVr69FFYkRWhTH4RSZKIswsOBgDdIXVtehzNO0RQohVVEbnOhWbxrGeN2RZZUw2
 FUNWokwfydt2i+v7HBfk2GmKO5+jcSNwm+1WvzzoDwTGmLmMrgRTjnHFKn948dyK1oRp
 pZn8eiiqvo2QzlOeQap6W+FXAlp9TsF1kiYkPIWBO2Yehj7wZ0dfixa8L0j18crqOQlf
 9stXdcl7CI4zSplYQBOs59iCd3Dk6qlYYFeJnCEjdf+zphKWEmFt9ujAtZTeh8PVZHJh
 3nrbqSweeecIV280RwHKecyo4BsuainYImycDqIf//z+nJ/7bhVDDPc+XBM+TBle7hUK
 Vh9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbStTYbv2YHzpmavlD+FKpovRbtLacMhN+NzNSPBCwQvagJ7ngMEccsFeJHK9Jup0r/y8TQrmHYwXjY49GiYIuw3L4cg==
X-Gm-Message-State: AOJu0YyDCvwcLlRkXC9mA1gTnfkk4qGoNv3PSY5LNe9jIwUrHfqPfqee
 xMhH9z0YH0H9cGeQq7VtRt9JGTk9O1Y9qnTtkb8YxsSHQ07GDvC1
X-Google-Smtp-Source: AGHT+IF72VIYclhw+KFuDLQgD6RcIs8jHbGEOGqiXNF/t6MIr2fwOuTZXohZcA98JJxSdIkXAdlYrA==
X-Received: by 2002:adf:e6c2:0:b0:35f:225e:400f with SMTP id
 ffacd0b85a97d-35fe1c0a063mr60932f8f.30.1718147694307; 
 Tue, 11 Jun 2024 16:14:54 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35f231d5761sm7052096f8f.35.2024.06.11.16.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 16:14:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Bosch <stefan_b@posteo.net>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v3 4/9] led: status_led: add warning when an invalid Status
 LED ID is used
Date: Wed, 12 Jun 2024 01:14:19 +0200
Message-ID: <20240611231435.10366-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611231435.10366-1-ansuelsmth@gmail.com>
References: <20240611231435.10366-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jun 2024 04:33:23 +0200
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

Add a warning when an invalid Status LED ID is used to make the user
aware of bad configurations.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/status_led.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/status_led.c b/drivers/misc/status_led.c
index 93bfb410662..882273cc322 100644
--- a/drivers/misc/status_led.c
+++ b/drivers/misc/status_led.c
@@ -105,8 +105,10 @@ void status_led_tick(ulong timestamp)
 
 static led_dev_t *status_get_led_dev(int led)
 {
-	if (led < 0 || led >= MAX_LED_DEV)
+	if (led < 0 || led >= MAX_LED_DEV) {
+		printf("Invalid Status LED ID %d.", led)
 		return NULL;
+	}
 
 	if (!status_led_init_done)
 		status_led_init();
-- 
2.43.0

