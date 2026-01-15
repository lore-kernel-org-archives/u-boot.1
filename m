Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EF9D44C54
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C53F983923;
	Thu, 15 Jan 2026 15:30:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hJxdrC8M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF1A783623; Thu, 15 Jan 2026 15:30:52 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E7A8389A
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so9625945e9.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 06:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768487450; x=1769092250;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xWJgDoQMsEw7tY9sRXkDWaU3q4eKXmtBviaZyWY660s=;
 b=hJxdrC8Mwz/YVBG3Ef2eAoKvT0vDdjBnehS9Rm6Rtk0OgBZwviXFKE87Ow9rLei4dT
 Ei0/d48jViPBhaCQRgOYrWwyLGZKmhT+7YzrooNtY0B8KiGo5Ssc4fqWQ/GKPmbv2uGG
 p50Grt1FsUD5fppoufNsFTdgopPrlbfnz0xhnoGi6+xCx6y9gDaZ5921J4XzbkOHDbxb
 k8EmuiCxQoRTjmIXtWjtoHgrxhIGs8H+YI6j4h2WEES0BOfWvif+XMQwiE07H07XwPVY
 njXDrZTM6NYDDNpfZfgtx8LOgsUwOdSxi/ppJt9mzKXLSmt/WbBIT+hHrR6G8+8xZEkr
 X8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487450; x=1769092250;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xWJgDoQMsEw7tY9sRXkDWaU3q4eKXmtBviaZyWY660s=;
 b=SFvN4JG9r0WG6S/o/Ai6arhlrKAfriSeVExIYGYpYFPqIxCC9l4EgZiEEfXEAYOYt1
 CjmFtxICm2ZX1+2xmt88cFj2r7I0Kc6x1/S0UqsnblPW3HF9EA8Uo2irbYIsAhZlRYda
 gPlhGqn4TqY8HuUcjjeKr7mfvK/2qszSMOKuPtnYQqQDTMhwh/U8OR13Ts1PK/LQLcrH
 X4/ExgritpAxFR9yxX+WG4iwkLWLXjx66Pd4lKTBPzjuHRpWjBHb4xd4cdFmMzGnaeA+
 wupAE+aENt8iidjXqcs/nJwXMazj1hJMZU9JM08g7U6bkKz07VnieIecMUhkp4axDIK9
 5lWw==
X-Gm-Message-State: AOJu0YxqS/qz8NQJlkGaeNVydGf3PgC/CsXMEOp1nbm2KohmNSRdViKb
 +y5pv0inss6GmLFAfc92HEd9Dj6SnG7a/itbyxoSjPhS0z3TI2MDTjGt5Vcpbj32H/s=
X-Gm-Gg: AY/fxX6JEFdY0AWg0GS4kcsV45UYS31V78UOX3kYJP6xF7OI0CEQeyO9JSD8kAVOUg2
 OFB1l04SyJjVRCYvp/WOiFk4wHLLoxGvODvjafHmPTj5A/cbdEUcPT1grlaMaKeEGIKxdS3Ea9B
 KQ8itcbe1e7ulydbGSYhNFnDJ3MH9zKgVv8gfr+mvW1ua32EAri3KomZN04Iz199Qfducw9eb9a
 P+bHmr1QTkWVxzQcUb4F3UFdUx5ocjskTh1xBGtN2iDhFDHm0LrTo+owr92V6BZHUVFwl22NDes
 nEoreZziDumbmQsobflD9YwyG0wOwuT8DY5xUQXPrLUQVvaC5xdFA8zmDyN20YcBmdL4q9P6qSZ
 XvHWlS+G6bhb57uBoiaQMQzF3Fpx9fJKIDEMZFTR8librY/zEuQbtaspPLNk2oVQLtsIWh1qfEF
 E4Mx7DW4qvJ1aKSgCUcPjfvXbvfuYl8c9yE08v899GqMrhZ2ZRL1vW2sB19WUecTy69WRdOcuRS
 Z5hjjtoNw==
X-Received: by 2002:a05:600c:c04b:20b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-47ee3372b78mr54753255e9.20.1768487450091; 
 Thu, 15 Jan 2026 06:30:50 -0800 (PST)
Received: from [192.168.1.62]
 (2a02-8428-e55b-1101-a95a-db72-930a-81eb.rev.sfr.net.
 [2a02:8428:e55b:1101:a95a:db72:930a:81eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee27ee45bsm47149925e9.7.2026.01.15.06.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 06:30:49 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 15 Jan 2026 15:30:45 +0100
Subject: [PATCH v3 3/3] power: regulator: common: fix compilation issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-power-regulator-fix-compilation-v3-3-08b329543e13@baylibre.com>
References: <20260115-power-regulator-fix-compilation-v3-0-08b329543e13@baylibre.com>
In-Reply-To: <20260115-power-regulator-fix-compilation-v3-0-08b329543e13@baylibre.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/regulator/regulator_common.c | 88 +++++++++++++++---------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index cf98998579a..85af8d599ad 100644
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
+	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&plat->gpio))
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
2.52.0

