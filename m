Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EE7CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 16:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB48682B20;
	Tue, 21 Oct 2025 18:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jAt8lHTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279F183642; Tue, 21 Oct 2025 18:08:36 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4076380107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 18:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so38465175e9.1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761062914; x=1761667714; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rRaFThVw6NP1T7izzQPgI+l4I1r6mRFH8INCO+fTsUE=;
 b=jAt8lHTR9haQpj2UTmtQ7dRTqQbR4+/geXhzx1SDF3httmNczwOGVWyGk0ZLfReWYu
 tyP0ic0afb9atRMCU7fThu2LbiMqKBwF2VLa43K9jD8to+Xjo+bzTTy9mD1XtshD/tdJ
 kRtDpMCJGdh/cyRHKcI66Z8ouDvuHfBRjYVPKIkUvD5sg55hN+JPa0qwH41N6o8TLqRw
 XX4QD89h9mi4K0YGAG2FwmFvGGnI0Z4vxCmIJnza05+RTnMyU3Cyux+8tx9Xw2KZR79I
 v/nw3lVTgiRnZ/HIDLKoN+r6CaNI0L7bOkEnEZEyxoGe6MB2rFzvHsEQHgGlVjf+KNnh
 dxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062914; x=1761667714;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRaFThVw6NP1T7izzQPgI+l4I1r6mRFH8INCO+fTsUE=;
 b=PXwe8p+dGSXn2Y/wOdE78X29/PA8jQpa/SIWSWR51DFxAI5Nr1tg2OwbepXeZ8uc4M
 /kO1miNA9kNqxLrOMZLvokmuppcvtBuIxxE0MJvENFD3uOUzk4S53KHuZkljl5xKLuIv
 0iKW8HprmhvJRGyoD94RD7NPc9n5gtCKO+wXZI450AnOlKevy12NlcEZV/Lp1hg5upj3
 nsdvaBnEmfu0v9j88hLqLjznXqINrDBav8tODLCzTOt8G/N2xKZpT0gj+fLTX0TK7/Xd
 TJyx+jLxUp8zCGa0YRpaw0rFlI/gIaSkCByaq01TVLyZKF5mxkYr5u1f9DWmuzVwaXUE
 8Vfg==
X-Gm-Message-State: AOJu0YwGJC/R2T8Ese/o9A7/pcWmXu7kml+0xezrs8ye7C310cGPM+R+
 HS1C/kQye8CdSk2O/R2upRTcU95BGvQmLS2AZ+hzB+se/HNf6Rxm2vbIGvg+RSotGzQ=
X-Gm-Gg: ASbGncsTW1h1znjsxFnJnkMcmshyWkbLMe3iqUvbSl+E3PuovO1zaClTVRSGC5Fwipg
 tJqc5pjfB1Z0jOD5oXS2ZwrnCG/f1Z723zGHFG9NJXl7Q/72lZgAT6vHMGqvVkW73JGAj8NflVY
 nZYEFiftI5hsS1cBct1TXxCfgkEbHuzMGanmQ6xVIwFAaEr5+Tmn6zDhWvBVZGXFCzxz0tXwOY7
 u59Sbz6HouP4z9iO0MnLoM0FVi5j3IcxLt8tLEgGuQ2CJ5ylhLZe2B/IFFAp4KYsP6nLHQ5RxPi
 0tPLGc7NUfyBaYeCvlCpSP7cHhaTQqLaa7v0trCkr8Yww2cFzr8/gkk2l28j57TlsvlQscRnIOm
 cO9uK0QQ+wYwI+T5TvnknncWjy2M83Lve8LzjVYgGYm5CFm/5ssnoPfoXiUcCjlK2v3Q8vu5Yux
 95/QAlkXmBR6Bn2Er/hivf2DutXlKvG+T9FejuIA==
X-Google-Smtp-Source: AGHT+IHlALApp6rbgRupiMEhCQ/hyaN+75auYTYGRjfq29V4Q4EliZgrLDrZ+S4J0ZbH0u8ft0Wv/w==
X-Received: by 2002:a05:600c:c091:b0:46f:b42e:edcf with SMTP id
 5b1f17b1804b1-47117925d66mr93607975e9.40.1761062913627; 
 Tue, 21 Oct 2025 09:08:33 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:ff54:533:2c9b:1f57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3ae9sm20830245f8f.13.2025.10.21.09.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:08:32 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 21 Oct 2025 17:08:29 +0100
Subject: [PATCH 5/6] i2c: imx_lpi2c: Fix error detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-clk_funcs-v1-5-acf51a40eea7@linaro.org>
References: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
In-Reply-To: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Schocher <hs@nabladev.com>, 
 Jim Liu <JJLIU0@nuvoton.com>, Stanley Chu <yschu@nuvoton.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Testing an unisgned ivariable to be <= 0 will only detect the
case when it is 0. So correct this error test to a working version that
will behave as expected.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/i2c/imx_lpi2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index 4636da9f3015ec8854c471fe3041fb8560f70041..a309fd6f07ce0dad22ae49bb4414c6e331b29927 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -304,7 +304,7 @@ static int bus_i2c_set_bus_speed(struct udevice *bus, int speed)
 
 	if (CONFIG_IS_ENABLED(CLK)) {
 		clock_rate = clk_get_rate(&i2c_bus->per_clk);
-		if (clock_rate <= 0) {
+		if (!clock_rate || IS_ERR_VALUE(clock_rate)) {
 			dev_err(bus, "Failed to get i2c clk: %d\n", clock_rate);
 			return clock_rate;
 		}

-- 
2.47.3

