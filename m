Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC00BD1D461
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9550084277;
	Thu,  8 Jan 2026 15:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2cPlv0zf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4699E8422F; Thu,  8 Jan 2026 15:42:50 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B03D8423F
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so498545f8f.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767883367; x=1768488167;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dspgGp5XPwXVicN+uw8hjQjpzBCW2eE78Og3+H1RBds=;
 b=2cPlv0zfnforRT64OfowEGYUoEHIc4flEChbDULM6VrCyAGyWHLe62L96CLRA2m79p
 q+0aG9seiasf5ahrutrg0+OnegVd1Bpw4TrYraY/BnkUjGkt/V7z34ITz+d6lR1OJ5bT
 Tv5dpVfHVte5igaEimmwPxTvyWlviAHjsfTr3XFQROu2HYh5GtCvnTROY6HkuSHE4qUy
 kk0SURlFYkvSGjDkTxSugb85yD3GazvtjhQsrZaiyxshJUk18j6A23G7+LkaUNzI61fY
 pJXOjU8nyy+YI4u5BSESXV9O/FbhzhMwoMmtYk/cnId21BlUHt9ZLYTCiUzQAC3QXduN
 ynuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883367; x=1768488167;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dspgGp5XPwXVicN+uw8hjQjpzBCW2eE78Og3+H1RBds=;
 b=njUXgvMclTfjAtA6XjI3B4M+mangva5YxBFWK6Mqc/nnXos71DVAXk6zb6U9fxcAWS
 G9k3mVlakOy+V5jd5N+DSj0slM1oT0jp+giieTXKqG9INISgRampVJPyKNwWqhlWVJEj
 OfGtTEKRo2sV6CzVFXXPeA5KqaUY1aXU0dkqNu0BbWfynyEoSFb/qK6JiEuBGqVDGDbP
 TLURDwLwDerj9cvX2sG0hZvrMme49m+yEmcNmdm97foggIY4PBFcZV5e5KxjJChMEWP+
 /5V2xwUXMuOZ3l4EGdqEx9o1+p5D59Th+neqk6wzafPT/sFk6+ArNr6glLHItxXNMP2p
 Owcg==
X-Gm-Message-State: AOJu0YxOmzzU2PkqxaIrlDj+GvAnFSatrkFaEMVY0cCdDIACvqBzOzTx
 9xv4vICUZusc24odRzjoZZ//0k80fcTJJuWQVYOcRjnHGE3ZLFna3hF7BeHtgJ6dH+U=
X-Gm-Gg: AY/fxX5HkA3VHnEj8N0/g/2VjfZTmSH9ppJeOCpFPasUAONmFNMQo12oopZQ/p3FDgH
 iPt4vphoX1+YlV0lhh3gGKDD6PVyHIPnvhcuNTqmimdra/aJt6F5l5Dy//q7JIKWZsOcBwM+qYa
 M40iFPs11eq4KM90fGD0HzFvTjalI5YAYCLB9P95dJfViycCFyHiYT1HErJVogctod/vJgYuxP9
 r2MIlxrLBdiUaz8OBwbkdEeAwGyYlf42G1Xr7F88dkIt4I1xVdWMHvLlLN+b8Eh9eFFnSjVybGb
 inGX0mqXWROCMvdoFejqAaDClhzL5q8Easizg8tJ5CtcX9+XnZdmrXdVPJdWBt9l78zvb0vIYa8
 iN6JB2KxkfQXEaWAD3btDiOPrAf+Cic+USXc9W0UrOGUF+o0UDGWhA+q9x7efVRbXGjNQFRYHbo
 DeNAx6tJU3jC1O7pDVMNhe5Fnyqi3xefgri/FYmoGScK4Q+PBlznkWxCD3sTITvdF2YtinoQ8P4
 fDNs0Ddupww7mB7OvQ=
X-Google-Smtp-Source: AGHT+IGrV0u1xm9iUh4j2xLaMF9IK0ChIXXeDDVxO3WGpo1zzk1zBLJN8a+C/qCjPfSsErsgkzgWrg==
X-Received: by 2002:a05:6000:1886:b0:432:a9f0:48c with SMTP id
 ffacd0b85a97d-432c38d26f6mr8265614f8f.63.1767883366928; 
 Thu, 08 Jan 2026 06:42:46 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16d2sm17431760f8f.13.2026.01.08.06.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:42:46 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 08 Jan 2026 15:42:49 +0100
Subject: [PATCH v2 3/3] power: regulator: common: fix compilation issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-power-regulator-fix-compilation-v2-3-b00cb3268059@baylibre.com>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
In-Reply-To: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
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

If CONFIG_DM_GPIO is not enabled, compilation fails with the following
errors:

aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_of_to_plat':
<...>/u-boot/drivers/power/regulator/regulator_common.c:30: undefined reference to `gpio_request_by_name'
aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_get_enable':
<...>/u-boot/drivers/power/regulator/regulator_common.c:57: undefined reference to `dm_gpio_get_value'
aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_set_enable':
<...>/u-boot/drivers/power/regulator/regulator_common.c:92: undefined reference to `dm_gpio_set_value'
make: *** [Makefile:2029: u-boot] Error 139

Since the enable gpio is optional we can conditionally skip these calls.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/regulator/regulator_common.c | 88 +++++++++++++++---------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index cf98998579aa8a3cb7f09dccd2124207a58d8b00..518179e457f6590f09daa1b14ea7579f5a5bae71 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -27,12 +27,14 @@ int regulator_common_of_to_plat(struct udevice *dev,
 
 	/* Get optional enable GPIO desc */
 	gpio = &plat->gpio;
-	ret = gpio_request_by_name(dev, enable_gpio_name, 0, gpio, flags);
-	if (ret) {
-		debug("Regulator '%s' optional enable GPIO - not found! Error: %d\n",
-		      dev->name, ret);
-		if (ret != -ENOENT)
-			return ret;
+	if (CONFIG_IS_ENABLED(DM_GPIO)) {
+		ret = gpio_request_by_name(dev, enable_gpio_name, 0, gpio, flags);
+		if (ret) {
+			debug("Regulator '%s' optional enable GPIO - not found! Error: %d\n",
+			      dev->name, ret);
+			if (ret != -ENOENT)
+				return ret;
+		}
 	}
 
 	/* Get optional ramp up delay */
@@ -51,10 +53,10 @@ int regulator_common_get_enable(const struct udevice *dev,
 	struct regulator_common_plat *plat)
 {
 	/* Enable GPIO is optional */
-	if (!dm_gpio_is_valid(&plat->gpio))
-		return true;
+	if (CONFIG_IS_ENABLED(DM_GPIO))
+		return dm_gpio_get_value(&plat->gpio);
 
-	return dm_gpio_get_value(&plat->gpio);
+	return true;
 }
 
 int regulator_common_set_enable(const struct udevice *dev,
@@ -65,47 +67,47 @@ int regulator_common_set_enable(const struct udevice *dev,
 	debug("%s: dev='%s', enable=%d, delay=%d, has_gpio=%d\n", __func__,
 	      dev->name, enable, plat->startup_delay_us,
 	      dm_gpio_is_valid(&plat->gpio));
+
 	/* Enable GPIO is optional */
-	if (!dm_gpio_is_valid(&plat->gpio)) {
-		if (!enable)
-			return -ENOSYS;
-		return 0;
-	}
+	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&plat->gpio)) {
+		/* If previously enabled, increase count */
+		if (enable && plat->enable_count > 0) {
+			plat->enable_count++;
+			return -EALREADY;
+		}
 
-	/* If previously enabled, increase count */
-	if (enable && plat->enable_count > 0) {
-		plat->enable_count++;
-		return -EALREADY;
-	}
+		if (!enable) {
+			if (plat->enable_count > 1) {
+				/* If enabled multiple times, decrease count */
+				plat->enable_count--;
+				return -EBUSY;
+			} else if (!plat->enable_count) {
+				/* If already disabled, do nothing */
+				return -EALREADY;
+			}
+		}
 
-	if (!enable) {
-		if (plat->enable_count > 1) {
-			/* If enabled multiple times, decrease count */
-			plat->enable_count--;
-			return -EBUSY;
-		} else if (!plat->enable_count) {
-			/* If already disabled, do nothing */
-			return -EALREADY;
+		ret = dm_gpio_set_value(&plat->gpio, enable);
+		if (ret) {
+			pr_err("Can't set regulator : %s gpio to: %d\n", dev->name,
+			       enable);
+			return ret;
 		}
-	}
 
-	ret = dm_gpio_set_value(&plat->gpio, enable);
-	if (ret) {
-		pr_err("Can't set regulator : %s gpio to: %d\n", dev->name,
-		      enable);
-		return ret;
-	}
+		if (enable && plat->startup_delay_us)
+			udelay(plat->startup_delay_us);
 
-	if (enable && plat->startup_delay_us)
-		udelay(plat->startup_delay_us);
+		if (!enable && plat->off_on_delay_us)
+			udelay(plat->off_on_delay_us);
 
-	if (!enable && plat->off_on_delay_us)
-		udelay(plat->off_on_delay_us);
+		if (enable)
+			plat->enable_count++;
+		else
+			plat->enable_count--;
 
-	if (enable)
-		plat->enable_count++;
-	else
-		plat->enable_count--;
+	} else {
+		ret = enable ? 0 : -ENOSYS;
+	}
 
-	return 0;
+	return ret;
 }

-- 
2.50.1

