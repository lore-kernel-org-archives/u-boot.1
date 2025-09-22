Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02552CAC5A8
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7004883211;
	Mon, 22 Sep 2025 16:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="PzvoPdNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69AC8341C; Mon, 22 Sep 2025 16:16:42 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB7B982CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 33568106D7B; Mon, 22 Sep 2025 16:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1758550600; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=9xUPXrSV0idaApuboMOT/B/J2pnDmTK38u8N/NyMvIo=;
 b=PzvoPdNjfLKfsOhb7Lxvj07ghY+/V05y5WK/3xu5rU4dav6QHGqYMUh5BJiV4jgyZ36amL
 n3wHV/pa/oSKQpvRo5NRvw21VZv+Eb32BKCuek4omS5rtt0/SyKQcw9mG+6+R32eMBjJja
 Fp4ySCeQzXerks/kab4E5TbCYsH+70QliUXXoeKpqlNGypjtdv66h6boya5hO6uyMEChUM
 uS5qQgF9BmHDHtLH8iid5//qdbEB76YUzhjR5TNniVBRbBt1xXpZGvBLT6cUbf6Pceun9A
 asafOYoG39UoqXE4PAPKA3EybIr9b20oUIvJV+I51BdZN01lh7hNqi5TyRZTHw==
From: Lukasz Majewski <lukma@nabladev.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH v2] arm: gpio: Add set_flags callback to the Tegra gpio driver
Date: Mon, 22 Sep 2025 16:16:17 +0200
Message-Id: <20250922141617.225861-1-lukma@nabladev.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

This patch adds support for the .set_flags callback.
For now following flags are supported:
- GPIOD_IS_AF (i.e. "alternate function").
- GPIOD_IS_IN
- GPIOD_IS_OUT

Currently, the .set_flags in gpio-uclass.c (function dm_gpio_set_value())
is used before .set_value callback, so functionally replaces it.
As a result the corresponding tegra_gpio_set_value() can be removed.

Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
---

Changes for v2:
- Fix the format specifier for flags in debug() function
- Update commit message
- Remove tegra_gpio_set_value() method (as it is functionally replaced by
  set_value()
- Prevent from returning errors when flags = 0 (problem with e.g. I2C GPIO
  support)
---
 drivers/gpio/tegra_gpio.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/tegra_gpio.c b/drivers/gpio/tegra_gpio.c
index 3d1e18854f2..85f2d28ee73 100644
--- a/drivers/gpio/tegra_gpio.c
+++ b/drivers/gpio/tegra_gpio.c
@@ -182,21 +182,6 @@ static int tegra_gpio_get_value(struct udevice *dev, unsigned offset)
 	return (val >> GPIO_BIT(gpio)) & 1;
 }
 
-/* write GPIO OUT value to pin 'gpio' */
-static int tegra_gpio_set_value(struct udevice *dev, unsigned offset, int value)
-{
-	struct tegra_port_info *state = dev_get_priv(dev);
-	int gpio = state->base_gpio + offset;
-
-	debug("gpio_set_value: pin = %d (port %d:bit %d), value = %d\n",
-	      gpio, GPIO_FULLPORT(gpio), GPIO_BIT(gpio), value);
-
-	/* Configure GPIO output value. */
-	set_level(gpio, value);
-
-	return 0;
-}
-
 void gpio_config_table(const struct tegra_gpio_config *config, int len)
 {
 	int i;
@@ -258,14 +243,36 @@ static int tegra_gpio_rfree(struct udevice *dev, unsigned int offset)
 	return 0;
 }
 
+static int tegra_gpio_set_flags(struct udevice *dev, unsigned int offset,
+				ulong flags)
+{
+	struct tegra_port_info *state = dev_get_priv(dev);
+	int gpio = state->base_gpio + offset;
+
+	debug("gpio_set_flags: pin = %d (port %d:bit %d), flag = 0x%lx\n",
+	      gpio, GPIO_FULLPORT(gpio), GPIO_BIT(gpio), flags);
+
+	if (flags & GPIOD_IS_AF) {
+		set_config(gpio, CFG_SFIO);
+	} else if (flags & GPIOD_IS_IN) {
+		return tegra_gpio_direction_input(dev, offset);
+	} else if (flags & GPIOD_IS_OUT) {
+		bool value = flags & GPIOD_IS_OUT_ACTIVE;
+
+		return tegra_gpio_direction_output(dev, offset, value);
+	}
+
+	return 0;
+}
+
 static const struct dm_gpio_ops gpio_tegra_ops = {
 	.direction_input	= tegra_gpio_direction_input,
 	.direction_output	= tegra_gpio_direction_output,
 	.get_value		= tegra_gpio_get_value,
-	.set_value		= tegra_gpio_set_value,
 	.get_function		= tegra_gpio_get_function,
 	.xlate			= tegra_gpio_xlate,
 	.rfree			= tegra_gpio_rfree,
+	.set_flags		= tegra_gpio_set_flags,
 };
 
 /*
-- 
2.39.5

