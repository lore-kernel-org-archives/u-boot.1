Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBA5E7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 827CE83CEE;
	Mon,  9 Feb 2026 19:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qub4StIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C218883CE3; Mon,  9 Feb 2026 19:03:53 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF06680325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-385bdc72422so42785951fa.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660231; x=1771265031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAsT+zg7v27anJX0OUb2S3bHEme8K5r9NI+S11sUoyU=;
 b=Qub4StIhkL+Ar8PHjWaBdobiEZB9Unaem8NdjwqXjo8PRMFZj2QyAXQdA8Bx/cf3oT
 gLnSDeTJSQg7z3/h6a4irw0EuUlJ1y5fY/qcPeCa+GFAYjMifcmQhiaUQekq6rgDiC7h
 LoaaWeXOE3fL4fTZxdlpqinhzr6/gOm90X0gTTjy1wN1Yx1eWcKYf+/K/l627ZLKKsD4
 dkqeUEBDhsxTOUJpHnGyGZjl4whE+WgCjSFSXx7ElU53/Qdpeqfm/3L/ZgdaAIS+yxC0
 LfdFaVcB3LSUzzLlsIcUZhAcDsm8ROTKpF7O1dR8RpvLn6WEDWRdaP/3C2tBIfUTFUgN
 bH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660231; x=1771265031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bAsT+zg7v27anJX0OUb2S3bHEme8K5r9NI+S11sUoyU=;
 b=C4Yt+Gfp+AFmjdRQt6cN+Xhp//2YY1Uk41eBRENlRmAzgKKXWhzVH8IskCzpjOv+46
 vI/ZzicOwO2pOgIYkAWnpN+W1BH8CNwuBUPumGNL+uwiktQtzhpyq3bwY/ncNBo6KkFb
 CY9ZkaRKt45QBajVy77Fv8S7FsDEml4HvXXRxv96O7oKhS9DZuLeX8APaVM1JlIT+M+v
 saTF6o8ye2DL9MRTs5GYWNHzJIWURVVYJ7RhuS1+QnbmM3S694gFmkXpJgj8F1pq9fK2
 9DfsYnDypCgA1Pnwp8ecTmT0CeILWjrZeQxHc3dixQS2Zd/C/ylgaQD9JbCnrrSbLA7h
 1+2w==
X-Gm-Message-State: AOJu0Yx+RRccyhI3Q1+v6bmgAxQGImNrVrwhShhtSD4R7w7RknhXoxPX
 ZAgfutCNZQb2VfT0xF6rHHelMIVGNcR6DO8FRAVt74p73mHbDeBLHD8T
X-Gm-Gg: AZuq6aKZAXjZE63Xz6BGV6vJPGJm2gx4atTdL6xxl9slPegU4h3OUaRB74cfBdTLZr3
 yaJVM5Z8DknEatHj1Ois+1iPtYM66j9laiIYC/YQkoQJ27BAyqxAaU4cSspYJXxEQGAedYxVBLR
 KWbY+ieU5ZW1YsmnAOvX4F1kBJgKhbv1Ab0KZLA61Nvy9Q3tz92T0Mym54UAvma0jlyHcKovIKS
 AeN5FzxF6u5Jw7bWnAGZc7MjbZWTygsTZk0a/jWNUphWwi4Qtg1MmHbr16Tlj6yAQkYdHecmcI0
 caYCEdgTArygI1mhTT73SzQet809nkclqtquit8zFA+rrANwghJyF7VoMGZpsVP6P7fidAg5q4Q
 3qG7FcYumQ68u8s+OfP/9lrXINg1ldupxPGGwzZom6vS1Hm9GDA/H5KGLJYreXHI0R9fSxN/q+E
 zy
X-Received: by 2002:a2e:a103:0:b0:37a:5cb7:968f with SMTP id
 38308e7fff4ca-386b5139df3mr53233311fa.29.1770660230959; 
 Mon, 09 Feb 2026 10:03:50 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b6236383sm27285351fa.10.2026.02.09.10.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:03:50 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/4] pwm: tegra: add set_invert PWM operation
Date: Mon,  9 Feb 2026 20:03:24 +0200
Message-ID: <20260209180326.32190-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209180326.32190-1-clamor95@gmail.com>
References: <20260209180326.32190-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

Add active-low support to the PWM controller, useful for active-low
pwm-leds.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/pwm/tegra_pwm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/tegra_pwm.c b/drivers/pwm/tegra_pwm.c
index 7105d6db90d..3d398490408 100644
--- a/drivers/pwm/tegra_pwm.c
+++ b/drivers/pwm/tegra_pwm.c
@@ -12,8 +12,21 @@
 
 struct tegra_pwm_priv {
 	struct pwm_ctlr *regs;
+	u8 polarity;
 };
 
+static int tegra_pwm_set_invert(struct udevice *dev, uint channel, bool polarity)
+{
+	struct tegra_pwm_priv *priv = dev_get_priv(dev);
+
+	if (channel >= 4)
+		return -EINVAL;
+
+	clrsetbits_8(&priv->polarity, BIT(channel), (polarity << channel));
+
+	return 0;
+}
+
 static int tegra_pwm_set_config(struct udevice *dev, uint channel,
 				uint period_ns, uint duty_ns)
 {
@@ -28,6 +41,9 @@ static int tegra_pwm_set_config(struct udevice *dev, uint channel,
 
 	pulse_width = duty_ns * 255 / period_ns;
 
+	if (priv->polarity & BIT(channel))
+		pulse_width = 256 - pulse_width;
+
 	reg = pulse_width << PWM_WIDTH_SHIFT;
 	reg |= 1 << PWM_DIVIDER_SHIFT;
 	reg |= PWM_ENABLE_MASK;
@@ -72,6 +88,7 @@ static int tegra_pwm_probe(struct udevice *dev)
 static const struct pwm_ops tegra_pwm_ops = {
 	.set_config	= tegra_pwm_set_config,
 	.set_enable	= tegra_pwm_set_enable,
+	.set_invert	= tegra_pwm_set_invert,
 };
 
 static const struct udevice_id tegra_pwm_ids[] = {
-- 
2.51.0

