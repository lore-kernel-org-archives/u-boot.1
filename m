Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78BFC54F32
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3683C88874;
	Wed, 28 Aug 2024 14:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F203888875; Wed, 28 Aug 2024 14:15:31 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C46388847
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 47SCFNuG031691; Wed, 28 Aug 2024 21:15:24 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH] led: gpio: handle GPIO_ACTIVE_LOW flag properly
Date: Wed, 28 Aug 2024 21:15:16 +0900
Message-ID: <20240828121516.19696-1-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
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

invert gpio state if GPIO_ACTIVE_LOW is specified in dts.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 drivers/led/led_gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/led/led_gpio.c b/drivers/led/led_gpio.c
index ce22fb49f2a..54aa84e0726 100644
--- a/drivers/led/led_gpio.c
+++ b/drivers/led/led_gpio.c
@@ -25,6 +25,8 @@ static int gpio_led_set_state(struct udevice *dev, enum led_state_t state)
 	switch (state) {
 	case LEDST_OFF:
 	case LEDST_ON:
+		if (priv->gpio.flags & GPIOD_ACTIVE_LOW)
+			state = !state;
 		break;
 	case LEDST_TOGGLE:
 		ret = dm_gpio_get_value(&priv->gpio);
@@ -50,6 +52,9 @@ static enum led_state_t gpio_led_get_state(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
+	if (priv->gpio.flags & GPIOD_ACTIVE_LOW)
+		ret = !ret;
+
 	return ret ? LEDST_ON : LEDST_OFF;
 }
 
-- 
2.43.0

