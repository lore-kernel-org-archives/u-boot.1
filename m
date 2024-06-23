Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA85C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B0788572;
	Sun, 23 Jun 2024 22:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OkV1UdIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE5C088405; Sun, 23 Jun 2024 22:30:45 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA33883C8
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7eee5740aceso137746539f.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174642; x=1719779442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vd1lgyE0323kxHzqwAr6nvI90PDCPp9kU72jIBe8uLY=;
 b=OkV1UdIPVlQwRq3EkCoTIZk3yKMc4/7ESmAa4IXbQj6mggG/tCSyRNyl5TmsmIi9Yu
 u08CB5dDvrZwZwO51J05OGkAkJu86Ama2A6ZtwuQff9OL0PNWZn0jHJqLPfvqbE9Cc1U
 scl58DLu0dtKckcBpoAIESiwZYV7tl1cNmPOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174642; x=1719779442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vd1lgyE0323kxHzqwAr6nvI90PDCPp9kU72jIBe8uLY=;
 b=XHzHGLMWkp6l/uiaZ+Bv9rtzjgFyFv63ibjfrlQRtyNwecv2ZIs11jK0zH8T3N2W+p
 egh43QFklv9qa3EJrjo+lCO4P0bZQNhzFDHTlZqUdYIw5sez17+k+ubhkBd31gOBolTs
 GvheJcBYL7QGWkBpPJleSuvC5R9TJPSfl4yf5o880VQCZL6NFJI7vyO/Lk82RUW8T/lm
 X4jfKk5VT6LR6GEpI9oB82Ti3qt3TRGdH+8u8FCylHvAXr7fwVgC38E3Fe9I2Yu46t9i
 EzfiA58BQ7RSiZ0st9sQJFdQh86s2/H96fBKXK80elVRVTYyhdMfUvV3fr/dZMtTY0Rq
 8UZA==
X-Gm-Message-State: AOJu0YxZaaXpmren5qxticBfeAcMwxDuwgSo6Mo/HDuuUFyNk3KcyigJ
 FYRETrcfm9s9i9Jq+CmO9B+TTFQhjyWlGOGgLcMS3LE2EZQjrC8e9JBg6EtfwCFU/RlQSjtvxWV
 lLg==
X-Google-Smtp-Source: AGHT+IE7rOLpp2AelnhD22UJwqptSga16Q1uTfEp2DgRww7QnNCc0zWyQgG5LtQWxXQa5UB80vNG5g==
X-Received: by 2002:a05:6602:13d5:b0:7e1:a7e8:eecb with SMTP id
 ca18e2360f4ac-7f3a74be807mr273672739f.6.1719174642356; 
 Sun, 23 Jun 2024 13:30:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot-amlogic@groups.io
Subject: [PATCH 07/14] meson: Correct driver declaration for meson_axg_gpio
Date: Sun, 23 Jun 2024 14:30:26 -0600
Message-Id: <20240623203033.1566505-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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

