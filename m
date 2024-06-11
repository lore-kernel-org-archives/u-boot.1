Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F21C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 846E6887BE;
	Tue, 11 Jun 2024 22:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ker3UrRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51BCB887A9; Tue, 11 Jun 2024 22:02:32 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE4288710
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-374528b81ddso24067335ab.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136149; x=1718740949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qf2T4EoOgEH5RJRfr6RU1JO8qUpBjihP5i6QW2xcyjQ=;
 b=Ker3UrRYgIPuUKlfw99AK4D3sFqfCytVN2glKzglXkEOorbWAbWv6H9FS8MN2yOnpH
 RgWyiBzSxqehUFA/DHbX7qdVJeeJNP+FkVP/PJCGmSa7YBOLvE/JwzB3aD49Ba6V/bID
 g0sJxg3o4LUjk2wb2/8BrSW5p5qLg+oYV49+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136149; x=1718740949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qf2T4EoOgEH5RJRfr6RU1JO8qUpBjihP5i6QW2xcyjQ=;
 b=ZC7ChE9bH5z5FV17xb1BruEQaZMCY2QYZtn80x6YQXPSIktaTYtIpjSKFau0xJo758
 TmitnIWhJeuYYcEvJmoeAVjrcduilmxOr4u1ueqoN0jufLCspMLRTrvTlfchJkdn8RpF
 mzV8Na/PlLp8CkIwUMqcKO1E3xaAt8ijgV7pxEb+O9EQDHuN/peSydmwBmUKf6cJemqm
 Dvz0qIdhqy17Tf229t7eBmAERu3j5FpM6vNdNcz2Vq8ZA4r5fT0NMF+TXPbsLnnD9rov
 W/Ppfu8wZY/pp8326HaV/o59jD8TtljLeZJa2zHNwofVX8tSaBvQaMEAnA8sB+W5OKsb
 uSPQ==
X-Gm-Message-State: AOJu0Yys2QLB9qlbjiHXko+juuNyZ+AAl5N5owpTkgLPsn+CHl4a06vd
 JL12LjdPk6Mib4gzqvjYXWZxrAQE0hjpKKL764v3dw4mvzb1H3IQvHW0P8ZRdnohW/e0oKWbddi
 YFg==
X-Google-Smtp-Source: AGHT+IEgSBtCT5zVxwq3XgJLg68nPLcdS6qLNF9VBoT46G4+sLMYy12e9VkY8oD7/qKDBKZEdDcsQg==
X-Received: by 2002:a05:6e02:1487:b0:374:a412:3d95 with SMTP id
 e9e14a558f8ab-3758035f491mr152648375ab.20.1718136148668; 
 Tue, 11 Jun 2024 13:02:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot-amlogic@groups.io
Subject: [PATCH 18/42] meson: Correct driver declaration for meson_axg_gpio
Date: Tue, 11 Jun 2024 14:01:32 -0600
Message-Id: <20240611200156.2245525-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

