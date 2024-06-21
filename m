Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C36FC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F6E885CE;
	Fri, 21 Jun 2024 21:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xs08FrYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FEF885BE; Fri, 21 Jun 2024 21:52:27 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52B9885A5
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7eee734a668so101106239f.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999544; x=1719604344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vd1lgyE0323kxHzqwAr6nvI90PDCPp9kU72jIBe8uLY=;
 b=Xs08FrYnlNWz8G2cUdJZFEtjMlaQwBTLxcTQfKrEPtewxblu5l5dByN5PoxKANm5aq
 Y7CLgpjgteoFKAI8klD7vwaccNqnoCPaqiDnOgG8okINW3QJlQq5B62QDQH9iITXAFFr
 DSqRn7JGtIGx0Nbo5C/C00+DlOL4Akw4kG+vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999544; x=1719604344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vd1lgyE0323kxHzqwAr6nvI90PDCPp9kU72jIBe8uLY=;
 b=F1AxGC05do4+fdi4ktF+v1f3pebRzc5PJ+0iqiNcpoHdXHbxbYBYuEyA6ISOPON23Z
 uHRNvVg0tewY93StLukDYWUtiHYEMV5WKNvAiThv712lilYfrZQtxb+EiaI3LMMBrxXo
 nV/B/tP0TeKtbnwEJpKEnc+xFAwRV8s4d/S8v0Bc7pUYG9uzEuf33FEYDhaRUCdgdopZ
 nQ5zw9z47vZK8Kha5kWd8sNk0B/u5I80I0c8ImZ2ab0RK4lWV0Xgf21b9wy6UTJoVLlj
 8UrMzGogM3TI8HoM65j1IyKbFN2IqsPKrj3RhF8cX991pGVRmbiwnpmT9/2eReVaMIcN
 tSSA==
X-Gm-Message-State: AOJu0Yz2LeJ1llpUkW+dB4N6qxu59NDTAT5nXLBiUi004zeOr8RcH2mB
 hEBJCPgqtbbXqxDJZe3MFegBbhUV6ERmmWB60snI1EL+RbI/n1je4aqzRKeeyfc5bWnBJMldzvl
 Yrg==
X-Google-Smtp-Source: AGHT+IGGmeEuApYEDVaDdFzINV6SZs41L8PlB0cRIyKEYSSCqlwbaaDWyvKGW3Gasoq6cpQtCSlGyQ==
X-Received: by 2002:a05:6602:14d2:b0:7eb:9864:410b with SMTP id
 ca18e2360f4ac-7f13ee202bbmr1043360639f.5.1718999544248; 
 Fri, 21 Jun 2024 12:52:24 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 18/43] meson: Correct driver declaration for meson_axg_gpio
Date: Fri, 21 Jun 2024 13:51:39 -0600
Message-Id: <20240621195204.2675252-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

This should use the driver macros so that the driver appears in the
linker list. Fix this.

Fixes: 8587839f19d ("pinctrl: meson: add axg support")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c     | 4 ++--
 drivers/pinctrl/meson/pinctrl-meson-axg.h     | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
index 52c726cf038..15ebd574ef1 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
@@ -179,7 +179,7 @@ static const struct dm_gpio_ops meson_axg_gpio_ops = {
 	.direction_output = meson_gpio_direction_output,
 };
 
-const struct driver meson_axg_gpio_driver = {
+U_BOOT_DRIVER(meson_axg_gpio) = {
 	.name	= "meson-axg-gpio",
 	.id	= UCLASS_GPIO,
 	.probe	= meson_gpio_probe,
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 94e09cd3f8a..ed3f92b2d75 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -939,7 +939,7 @@ struct meson_pinctrl_data meson_axg_periphs_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_axg_periphs_groups),
 	.num_funcs	= ARRAY_SIZE(meson_axg_periphs_functions),
 	.num_banks	= ARRAY_SIZE(meson_axg_periphs_banks),
-	.gpio_driver	= &meson_axg_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
 	.pmx_data	= &meson_axg_periphs_pmx_banks_data,
 };
 
@@ -953,7 +953,7 @@ struct meson_pinctrl_data meson_axg_aobus_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_axg_aobus_groups),
 	.num_funcs	= ARRAY_SIZE(meson_axg_aobus_functions),
 	.num_banks	= ARRAY_SIZE(meson_axg_aobus_banks),
-	.gpio_driver	= &meson_axg_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
 	.pmx_data	= &meson_axg_aobus_pmx_banks_data,
 };
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.h b/drivers/pinctrl/meson/pinctrl-meson-axg.h
index c8d2b3af036..a6581bab500 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.h
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.h
@@ -61,6 +61,6 @@ struct meson_pmx_axg_data {
 	}
 
 extern const struct pinctrl_ops meson_axg_pinctrl_ops;
-extern const struct driver meson_axg_gpio_driver;
+extern U_BOOT_DRIVER(meson_axg_gpio);
 
 #endif /* __PINCTRL_MESON_AXG_H__ */
diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index 24f47f82558..67114df6824 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -1253,7 +1253,7 @@ static struct meson_pinctrl_data meson_g12a_periphs_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_g12a_periphs_groups),
 	.num_funcs	= ARRAY_SIZE(meson_g12a_periphs_functions),
 	.num_banks	= ARRAY_SIZE(meson_g12a_periphs_banks),
-	.gpio_driver	= &meson_axg_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
 	.pmx_data	= &meson_g12a_periphs_pmx_banks_data,
 };
 
@@ -1267,7 +1267,7 @@ static struct meson_pinctrl_data meson_g12a_aobus_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_g12a_aobus_groups),
 	.num_funcs	= ARRAY_SIZE(meson_g12a_aobus_functions),
 	.num_banks	= ARRAY_SIZE(meson_g12a_aobus_banks),
-	.gpio_driver	= &meson_axg_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
 	.pmx_data	= &meson_g12a_aobus_pmx_banks_data,
 };
 
-- 
2.34.1

