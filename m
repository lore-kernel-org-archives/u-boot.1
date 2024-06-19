Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67762C2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 467F7884FA;
	Thu, 20 Jun 2024 03:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gr6w51V0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F37884BA; Thu, 20 Jun 2024 01:04:15 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 357AA8840C
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52bc274f438so406152e87.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838252; x=1719443052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VpwCJAzbR9t2YTMLu+cq7xEgWJdpWYheYWlqF08EMJk=;
 b=gr6w51V0jD3IwmA1EXmVFhEK4xP8qiLSauWNJR+oQu3Oz9ElQC47DdGHDRS19cbxdO
 kJq5vR6OUMVCv7AjTxAOV0fyySWgwdFYLmrvKzBQEMNEJ7cy6owePHTl/hoP3cLF1p1P
 ImkTYxLvRcAb+iGivgpFng2XmNsj3shXtME4Iat61TI3u5fNTTZIYfF+3PLYDqklSbvO
 pHuIg9VxQuEJD8d4odt+076hFxtQ765kN9GCm2WIpBmSqf7gf7/jjoJRNt6tmp2N//nl
 WGMRcii5R7DS7e/UvroQkH1NC7nFaMncdqh1H63UZnYd/FViqsiKkhrLkIT1fuih6ZQ8
 B9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838252; x=1719443052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VpwCJAzbR9t2YTMLu+cq7xEgWJdpWYheYWlqF08EMJk=;
 b=dCBuhwBnIW90nwWiO5rsXStlbtfz3GkecUUMphyRNGvi4sJnu1ixoQduT5ByaSuiY2
 uxR12k3pj5M6lckydoJAxVHnPKA65umq8Feo5dl1qPtyKw7D5meoaa21dL3xmUjNE+Yy
 HN8J1b4wug7MGJnHifkujz0kh9T75IbR//QeK7c9WfCrCZRYEhhRNC/5ju6OyadJsii5
 PoiAlgXtl2rPKFQhe9h/KuQD0fnLJzj720eKWtaDKlbrcA8D22lnSvCZ4H1Y1R/XURuR
 ao7OLmxa9c5lW4y3Cr33BGuerneXxU5FvlLxd0Ky7TNzhpiltrFIHGStVmXhKEiHLz6Y
 11Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbPeFSLrUlZrfuSqJDxEo2hBCI45KjsU4Xoud0E+7VOukkdo+tyb2alv82VCPTSaQ8gSCIFG0ksf3aZwmmY4esIGnQZg==
X-Gm-Message-State: AOJu0YznhKbaVOwyNc2y1XtW7x7S5fzJRvkjT2m7/STa82lVK1p9UoZl
 KU7OOxfCN/1bRVtVdlOcIzkC9dQh9ahbFJee4OuLII7IUW8wZsrK
X-Google-Smtp-Source: AGHT+IFKypCAsNim0a5VmqYsm00zV1EsIHw3U/N6cdvXrzeKPJiAyQG9yxDCJ8aHNc+KIBrYdGzVzA==
X-Received: by 2002:a05:6512:32c6:b0:52c:cd0b:f0a9 with SMTP id
 2adb3069b0e04-52ccd0bf137mr2337909e87.58.1718838252275; 
 Wed, 19 Jun 2024 16:04:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm5410465e9.27.2024.06.19.16.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:04:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Dmitry Dunaev <dunaev@tecon.ru>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v4 4/9] led: status_led: add warning when an invalid Status
 LED ID is used
Date: Thu, 20 Jun 2024 01:03:22 +0200
Message-ID: <20240619230400.8459-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619230400.8459-1-ansuelsmth@gmail.com>
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Jun 2024 03:31:55 +0200
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
index 2b904bfa9c2..7912b4a9448 100644
--- a/drivers/misc/status_led.c
+++ b/drivers/misc/status_led.c
@@ -105,8 +105,10 @@ void status_led_tick(ulong timestamp)
 
 static led_dev_t *status_get_led_dev(int led)
 {
-	if (led < 0 || led >= MAX_LED_DEV)
+	if (led < 0 || led >= MAX_LED_DEV) {
+		printf("Invalid Status LED ID %d.", led);
 		return NULL;
+	}
 
 	if (!status_led_init_done)
 		status_led_init();
-- 
2.43.0

