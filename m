Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814F4D3B9AB
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 21:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B72883D0B;
	Wed, 10 Dec 2025 22:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DgInjjf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59A783CF5; Wed, 10 Dec 2025 22:24:33 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA87383CD2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 22:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso1906735e9.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765401871; x=1766006671;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NCLOyKZmVc73RdxSiGDeZOCdDDwPhoZOaYr+ImaGkgY=;
 b=DgInjjf89lrFgAhpmrPkwJMKFz1bfbZQMt4qtiyDsuVOvI6JehXPYT3YJugk2Tl9Aa
 cFfGmW4iarp7KAgvFfbL+t2uVY4Pz/ZMf9O30GWmHe1azMRHI4Td3OWpiam32CrO4wCE
 5j+XLPwhaxFcEEqG3LV3nXGRk+KA+o/h+TeUcWZycOcS14lqvUhPnGfAFgQwnJoiUD5w
 1tkrRiDVpzEe6EwgheiObHoT4JXbgUpWAnBme3e5OcJqIQsEKv0TTxkjBeM6z5tGVJqy
 NYnn6qy2EU+cwsM75gbPAWURA78+el0rFlI5OZZq/Y4T+vHZCIwn/dVE+B5rA8hIGiII
 fRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765401871; x=1766006671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NCLOyKZmVc73RdxSiGDeZOCdDDwPhoZOaYr+ImaGkgY=;
 b=lT1feFAxU9in+NeXvtjyooiBwu82DbgVBLjC/e5djLDeVUrjBfvY2xCpMm/t4IKNB7
 wN22aFFBzolR1dxlaHILc7pCRzADj976sYsuMfp3hmrdMqbO8SC/7IGMeHJMuKE6SW4F
 bpdAs2SiBmwqnvIWDDnlgf9DNp/93ggonhqd+3Ekgb6HCJ11fBBtq5+9eq8Dm3ARN8bJ
 hTSOBXq2v+XwJp70Bz9JlaT0jJKx5aEtKe/Xx9s25Os2v9P1gfrbh0cXxMRngCdVZ5HG
 GXNTvpwz0a1/70GPN4toF818E4me3XrFKq/o4VF+1HoGx5aOf7xiOrXzgGf/azVEXCsc
 uaBQ==
X-Gm-Message-State: AOJu0Yz1smfzAB2SFxB4dH455My2hRJDZ2wErqkVxcuPsBmJvngqY/jz
 KRTnH4RYlf+nrVyvVkfoXAw3s+OM1boGXReyuOWMwhp9/GkO3BghFIdOVwUr11Knx+s=
X-Gm-Gg: AY/fxX6jg5svq0qLKVgQVY+YgalKGN7y1PcfRTtuQUhneM/aoEFWST6YoRyXTEamJPP
 QDmAHAPCYp/lsR9dETi4bGl2a65RwTfSPxzJwQdnonDfg5F8v7OE6o8ymoQAdE2L51+c6Meb6d3
 2ZvMpZAm+gwMcNd3M3H/VxhK9IqF5e+SVAlcOEe/6W7ZAp0khjm50RR+iYBpsMo7enVsYcpLYA+
 odaUOO+r8XbQ4I3NianOAnwr+aE9pnJ9uOOLWuJuC5eWdGzDK0KfSsoU955qaB41QCDzJvDrdis
 YZcBnAgzdOpde5qMOuUTJjTH1e7fBk2Rt7jcoy7xBjl4OZcHwSlDYEYSUVPNvChANJkFfrCZDIU
 BDCCPADBsmBzPt1yWl8bnEwmPFl1pbMUW2hYwA0TtvI8Wk+qzWqpScgY0yFKj9NpLj/wi1MtIWH
 qDP6HnRU4K/t8QRTOIHOXBja/o+BhimLJVl6ddMHESPtQht2BXFdZHpR1jS5Qg9wqiO0wwpgSJc
 WRSI6I60dyQRB6ZuPnHMQOrtjtrpUA=
X-Google-Smtp-Source: AGHT+IHZwMWtneO2puaR7AOeAK+W4L9odJicS5k9E37AYZgHyvhiwSX+tjxbSvVbscWh1tERKdQPvQ==
X-Received: by 2002:a05:6000:26cd:b0:42b:3cd2:e9bb with SMTP id
 ffacd0b85a97d-42fa3af89c6mr4301336f8f.32.1765401871165; 
 Wed, 10 Dec 2025 13:24:31 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-f92a-5586-f2e9-b313.rev.sfr.net.
 [2a02:842a:d52e:6101:f92a:5586:f2e9:b313])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b96c70sm1122254f8f.37.2025.12.10.13.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 13:24:30 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 10 Dec 2025 22:24:24 +0100
Subject: [PATCH 3/3] power: regulator: common: fix compilation issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-power-regulator-fix-compilation-v1-3-c58f01e0a5c3@baylibre.com>
References: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
In-Reply-To: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
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
index cf98998579aa8a3cb7f09dccd2124207a58d8b00..fcf19253e048995fdcd952a48a6976cf86991ca8 100644
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
+	if (IS_ENABLED(CONFIG_DM_GPIO)) {
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
+	if (IS_ENABLED(CONFIG_DM_GPIO) && dm_gpio_is_valid(&plat->gpio))
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
+	if (IS_ENABLED(CONFIG_DM_GPIO) && dm_gpio_is_valid(&plat->gpio)) {
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

