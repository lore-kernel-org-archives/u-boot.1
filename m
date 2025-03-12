Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CA7C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9924B81D65;
	Wed, 12 Mar 2025 19:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SakdDkPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8918F81A0F; Wed, 12 Mar 2025 19:08:21 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC9880756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5e1a38c1aso62575a12.2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802899; x=1742407699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGy/k7p8H7WTRoMQrhxXTMwxhYsQXvk/8TN5ZQ3XZz0=;
 b=SakdDkPRof+3xJQKwbtJ0AkLhszXTjrnn8+Kpkjj7mZHGv9JWO8XGS2B0EGO78vZWO
 hPtyEXyAn6e2rOYKuDdDkI9nruqegzbiCiBtu+u0BXvvYIgAY1CL7/pet3Bzgwnalk7j
 3Nuy0RKwA5SEz0u/vr8vQozagpwZ17iN/KFf3Tkr1WXgbfbWC0xEoCgu4nA637hqjZdP
 pFnIEcOQQtx/xj8ajKz5qG6gcR9ym/TuyAH/Wm41NlPCAFGgPe7c5nUZC+JH3lwIGB7n
 mt1JN6MXQmljN+1IDQzc0kfLAXEbUisN/fAOeqXOzk9dylrW7V7IT+MN7Qa4F7U64AXY
 QeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802899; x=1742407699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGy/k7p8H7WTRoMQrhxXTMwxhYsQXvk/8TN5ZQ3XZz0=;
 b=PBQ7cUu6m5DzNOYlawySIpurKU1aQQYpzxh2k+6TAAu5ERMfzGRj1/8SVvhERTVsuM
 0wv/0H8EeNly8fyaJwUsK8SPWUtR+IfBKmcV0nS/ZVgCvpuZgZb3b3RJZaJ2fyHXt4RK
 uz9EPJgFfF0PlwLWbjyRv3ZzhNk3vPvosyoUsJtgfjW2g9PNHMJuFakNmHtrPxIuNSGb
 57arKaJ21d+xt6Zkv5Bv+XpY33HOv+TaxaQSu/DZazFUZN3XsflKSqcyWN5NpZln0Trf
 FAveI6ozLPM5ibMDpa+ChYT+WoLpatukAHiemSq1PSaQjNEJ7KtIfz6iNDtfaRw3dE9b
 g6jA==
X-Gm-Message-State: AOJu0Yw9ec0Bkqkw5OJqQsJZiaHAl+o6A3wEvNASNHCKWHJi9I+TaALe
 nTKEtkAreJJGpVc8/cIgD+bMbX1NHC59FbyQyvY1BJbNJqo24muj
X-Gm-Gg: ASbGncugJN7uUB1yy0yDoe8A4/AQeb0DJHSuoaExNAApSpqKHsZyD4uOismEQ4B6Aif
 6ODjVSu+nt/kndIb2oWR3wFppVWn/aSPZ3eMbvIgY0s0lOf+I7Ajk1OKm6mWrk/XvNA+gZnQHQz
 Et66mH9BszmQJe/wLdkIKn+nFJQWzgwVkUKVpopwvkxmHaPynZ2mdb8D5qjivPs+FF4fBB++Vt5
 DQ6C67RpchvTyhy89FzgAPFiPmo0IFNYTV+xlOcgWxIfQN0PbO8AaNFmqPSQlDaBSabtwmChLsc
 Ixtf3OQiaOSEJd4bFGd8qyVCk0A0MuSDKoK/
X-Google-Smtp-Source: AGHT+IGEDvXuySr7FWf7aTGPLk8RC8dPQgYrJOdsyNCEJlrEEJgsBUJtk6sOzrUNkRVYZv/tDhDRsA==
X-Received: by 2002:a05:6402:5201:b0:5df:6a:54ea with SMTP id
 4fb4d7f45d1cf-5e5e22b92e8mr53804649a12.11.1741802898802; 
 Wed, 12 Mar 2025 11:08:18 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:18 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 12/13] video: bridge: ssd2825: add power supplies
Date: Wed, 12 Mar 2025 20:07:53 +0200
Message-ID: <20250312180754.120946-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312180754.120946-1-clamor95@gmail.com>
References: <20250312180754.120946-1-clamor95@gmail.com>
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

Convert enable GPIO into a set of supplies according to
datasheet.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/ssd2825.c | 40 +++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index b8653cc7297..2a49b895404 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -13,6 +13,7 @@
 #include <backlight.h>
 #include <video_bridge.h>
 #include <panel.h>
+#include <power/regulator.h>
 #include <spi.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -108,6 +109,10 @@
 #define SSD2825_LP_MIN_CLK		5000 /* KHz */
 #define SSD2825_REF_MIN_CLK		2000 /* KHz */
 
+static const char * const ssd2825_supplies[] = {
+	"dvdd-supply", "avdd-supply", "vddio-supply"
+};
+
 struct ssd2825_bridge_priv {
 	struct mipi_dsi_host host;
 	struct mipi_dsi_device device;
@@ -115,6 +120,8 @@ struct ssd2825_bridge_priv {
 	struct udevice *panel;
 	struct display_timing timing;
 
+	struct udevice *supplies[ARRAY_SIZE(ssd2825_supplies)];
+
 	struct gpio_desc power_gpio;
 
 	struct clk *tx_clk;
@@ -444,7 +451,7 @@ static int ssd2825_bridge_hw_init(struct udevice *dev)
 {
 	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
 	struct video_bridge_priv *uc_priv = dev_get_uclass_priv(dev);
-	int ret;
+	int i, ret;
 
 	ret = clk_prepare_enable(priv->tx_clk);
 	if (ret) {
@@ -453,11 +460,14 @@ static int ssd2825_bridge_hw_init(struct udevice *dev)
 		return ret;
 	}
 
-	ret = dm_gpio_set_value(&priv->power_gpio, 1);
-	if (ret) {
-		log_debug("%s: error changing power-gpios (%d)\n",
-			  __func__, ret);
-		return ret;
+	/* enable supplies */
+	for (i = 0; i < ARRAY_SIZE(ssd2825_supplies); i++) {
+		ret = regulator_set_enable_if_allowed(priv->supplies[i], 1);
+		if (ret) {
+			log_debug("%s: cannot enable %s %d\n", __func__,
+				  ssd2825_supplies[i], ret);
+			return ret;
+		}
 	}
 	mdelay(10);
 
@@ -506,7 +516,7 @@ static int ssd2825_bridge_probe(struct udevice *dev)
 	struct spi_slave *slave = dev_get_parent_priv(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	struct mipi_dsi_panel_plat *mipi_plat;
-	int ret;
+	int i, ret;
 
 	ret = spi_claim_bus(slave);
 	if (ret) {
@@ -533,12 +543,16 @@ static int ssd2825_bridge_probe(struct udevice *dev)
 	device->format = mipi_plat->format;
 	device->mode_flags = mipi_plat->mode_flags;
 
-	/* get panel gpios */
-	ret = gpio_request_by_name(dev, "power-gpios", 0,
-				   &priv->power_gpio, GPIOD_IS_OUT);
-	if (ret) {
-		log_err("could not decode power-gpios (%d)\n", ret);
-		return ret;
+	/* get supplies */
+	for (i = 0; i < ARRAY_SIZE(ssd2825_supplies); i++) {
+		ret = device_get_supply_regulator(dev, ssd2825_supplies[i],
+						  &priv->supplies[i]);
+		if (ret) {
+			log_debug("%s: cannot get %s %d\n", __func__,
+				  ssd2825_supplies[i], ret);
+			if (ret != -ENOENT)
+				return log_ret(ret);
+		}
 	}
 
 	/* get clk */
-- 
2.43.0

