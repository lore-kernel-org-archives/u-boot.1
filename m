Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE09CA0FFF
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 17:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 121B583A32;
	Mon,  1 Sep 2025 19:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xiuwn5ze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C54F83A34; Mon,  1 Sep 2025 19:00:16 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 186B583A32
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 19:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b87a13242so16969785e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756746013; x=1757350813; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NEYecbmXrv+94eqSKPGhMU2KWHK6L66u0WJa0AL4dG0=;
 b=Xiuwn5ze+O1mjb237LxzpknrAFVZmvrXB+cR6yV2bgzmDoRUPPVbEnW/evCst0Q/LF
 FCnP9yM0c+hUd7+wbIOA8QzRLbUgmSx5j1gZr39RmcTz13ii+Bly3ASJoTmIuC5dTnCT
 KReoMClzgb1L4pdIHthiu7aZQC+SVmHDGY1ZhPCHeX3bZyV3c0HOeHkNVI/713T9GmQK
 En2kwEUq+ZEA8TwYC+3TcRy1lVFLkZAMnV/UaYDOA6SD+BJguZOIygHAa1+6vX/3F3Io
 +KKrIlMbWevkKB4rPvkslXoik7dHA+xMINzM+VWVUB8jkQyqHr8aFXdnGsJbK4hF/L+K
 OxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756746013; x=1757350813;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NEYecbmXrv+94eqSKPGhMU2KWHK6L66u0WJa0AL4dG0=;
 b=JenNN09aY0gQ/hJ6sFPorOv+jk8OLSWVKKn8VHzheeD4bENVAfHkdfo4aLhTjY4Jm/
 SjPUdgWirH2qI7HRy2X0SE5DmEHhdS5+d3BsdqGNRIHuIb6IRIBGZKXkC+qpVauetNy2
 fU3cLphK2swwU8s/l3LbxoJ2/jfTlGNzGxPiw6mgdbcUwHIGAuvtqZ01Ucn6XIvWR40l
 CI23nWgktZpsheL+tAY06UbhMhesKpKiMBuOPh91cgO54E4YlePmD9tf1m9pdp2YU717
 +8CCsf6OyKV7zKOO0lDmI55f0szKVPQp465D7GV/5zcnF0sNXoDJf2zbr8CV9Bx+QNLC
 gZIA==
X-Gm-Message-State: AOJu0YwPVO8En6qLfrLRQvSC7AnUMkzZwu7NhD0Lld2gPAYjdcDz5wbi
 hP72MjTB3HN144/MDme+Xu4dyprVuAILdYkH297X85MiE95apt6XI9Ja50Oga0LYVcc=
X-Gm-Gg: ASbGncsDr+fOLIuqkGTywndCaJB1pZTPbz9Lt5AdfdPODsCvCRZftftrZCbOosnpowe
 tHrVCzDEQVPT5pcy/61lJfAK6njZzZ2Ts717x3Dyd71IfbmJYvTr5+m0cbo9WkhIgDH8QBaW/Hs
 EcmffxdouFis5MO5rBxRGuiaVqFjiFWIIwgbJErLbCcEHEBbzOgAffef/Y6cI13JQHR1KOTkr4n
 CdvhQXf7mtrJLYV6UD4/AGwhdKRI1mPr4D93A0IrvE2gB5ieJoJbls7tfLAXvo8g3bmOHthc/Yj
 ZmBCdMTzW3PHR9zm2aQ9cEwJEaY0uuXa3WhN5Zd/6PUv2GP9r7Q2+gwCZfgL5Z4fwyA9yVTsnuZ
 MQFcCkLmamilIh8VCKBKrGitQFhXSvz6AFdfcdwb4TAi6iZ/qI2I=
X-Google-Smtp-Source: AGHT+IGYlJboO9oH86LmnLvFl51ZNIH7apzm+sbN6iUrgPGW9Y80/nG0kggsQDd5+4ZcZmrzH0boag==
X-Received: by 2002:a05:600c:4454:b0:459:dfde:3324 with SMTP id
 5b1f17b1804b1-45b855b34f8mr65669365e9.29.1756746013331; 
 Mon, 01 Sep 2025 10:00:13 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b85090262sm114352715e9.17.2025.09.01.10.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 10:00:12 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 01 Sep 2025 18:00:12 +0100
Subject: [PATCH] pwm: cadence-ttc: Insufficient elements in array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-cadence_pwm-v1-1-140b04cd73a9@linaro.org>
X-B4-Tracking: v=1; b=H4sIABvRtWgC/x2NwQqDMBAFf0X23EA2kKr9lVIkJq91D91KIlYQ/
 72xxxkYZqeCLCh0a3bKWKXIRyvwpaE4BX3BSKpMzjpve8smhgSNGObv21w5cccebesd1WIMBWb
 MQeN0NoptOfWc8ZTtP7k/juMHwNfhBHQAAAA=
To: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The Cadence TTC has 3 channels that can each be used for PWM functions.
Ensure that the array has sufficient elements to avoid a possible memory
access overrun. Use a macro to keep the array size and limit checks in
sync so adjust checks to work with this.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pwm/pwm-cadence-ttc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-cadence-ttc.c b/drivers/pwm/pwm-cadence-ttc.c
index 767628833bc..fae6d5a1739 100644
--- a/drivers/pwm/pwm-cadence-ttc.c
+++ b/drivers/pwm/pwm-cadence-ttc.c
@@ -47,6 +47,8 @@
 #define TTC_MATCH_1_COUNTER(reg, channel) \
 	TTC_REG((reg) + MATCH_1_COUNTER, (channel))
 
+#define TTC_PWM_CHANNELS	3
+
 struct cadence_ttc_pwm_plat {
 	u8 *regs;
 	u32 timer_width;
@@ -57,7 +59,7 @@ struct cadence_ttc_pwm_priv {
 	u32 timer_width;
 	u32 timer_mask;
 	unsigned long frequency;
-	bool invert[2];
+	bool invert[TTC_PWM_CHANNELS];
 };
 
 static int cadence_ttc_pwm_set_invert(struct udevice *dev, uint channel,
@@ -65,7 +67,7 @@ static int cadence_ttc_pwm_set_invert(struct udevice *dev, uint channel,
 {
 	struct cadence_ttc_pwm_priv *priv = dev_get_priv(dev);
 
-	if (channel > 2) {
+	if (channel >= TTC_PWM_CHANNELS) {
 		dev_err(dev, "Unsupported channel number %d(max 2)\n", channel);
 		return -EINVAL;
 	}
@@ -87,7 +89,7 @@ static int cadence_ttc_pwm_set_config(struct udevice *dev, uint channel,
 	dev_dbg(dev, "channel %d, duty %d/period %d ns\n", channel,
 		duty_ns, period_ns);
 
-	if (channel > 2) {
+	if (channel >= TTC_PWM_CHANNELS) {
 		dev_err(dev, "Unsupported channel number %d(max 2)\n", channel);
 		return -EINVAL;
 	}
@@ -153,7 +155,7 @@ static int cadence_ttc_pwm_set_enable(struct udevice *dev, uint channel,
 {
 	struct cadence_ttc_pwm_priv *priv = dev_get_priv(dev);
 
-	if (channel > 2) {
+	if (channel >= TTC_PWM_CHANNELS) {
 		dev_err(dev, "Unsupported channel number %d(max 2)\n", channel);
 		return -EINVAL;
 	}

---
base-commit: 4a2f360bd280b2b5af1c5daffbc189590c83c995
change-id: 20250901-cadence_pwm-61d1815e7752

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

