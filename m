Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B99DCAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E003832AD;
	Fri, 19 Sep 2025 12:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="R3zgXWDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5968329F; Fri, 19 Sep 2025 12:11:33 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3658833D0
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C4C0106B2E; Fri, 19 Sep 2025 12:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1758276691; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=uI01y+o8SVTDtkOBwpTmyvvOqZfmyGOp8SEeTr9Dg+8=;
 b=R3zgXWDqwOgzx4kY1jjvPmddAVaSMiVD12k8wZ12lijvd4I5TUnMrAqhAgHgLkU6FLweOX
 pGox3QyEeDWhoxHl+QXFFK+T7pBJs5Jd1nXSZ4gowiHWPWzp7qL6IZpzfYT1vKEMNEHRlA
 YJJV2zGATvretGDJOt+abuX7kv4YAXsz+bHIpKd2KcJlpo2m+WySqaZm06sHn8n6KSUaWg
 YbLw0JCcbHR/+rEcavQMo1Ots+dHjI5BT3yl4R3mIQcRYmvvbwDZziHRnqeGYQnOF15gCF
 3FW1NRWOYXgmZDDsuL0D8jFNsZ4NEcCh6iq36s/p1vuOh6MoCw510GSQVofHVQ==
From: Lukasz Majewski <lukma@nabladev.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH] arm: gpio: Add set_flags callback to the Tegra gpio driver
Date: Fri, 19 Sep 2025 12:11:17 +0200
Message-Id: <20250919101117.853194-1-lukma@nabladev.com>
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

In some Tegra SoC (like e.g. T30) there is a possibility that one will
configure at early boot state a pin as GPIO (to use it for e.g. carrier
board detection). However, afterwards (i.e. in Linux) the same pin will
be used as the special function one.

Current Tegra gpio driver doesn't allow this, so callback for set_flags()
has been defined to properly setup the GPIO when required.
For now following flags are supported:
- GPIOD_IS_AF (i.e. "alternate function").
- GPIOD_IS_IN
- GPIOD_IS_OUT

In long term the tegra_gpio_set_flags() is going to replace
direction_{input|output} callbacks.

Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
---
 drivers/gpio/tegra_gpio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpio/tegra_gpio.c b/drivers/gpio/tegra_gpio.c
index 3d1e18854f2..1e8bd051875 100644
--- a/drivers/gpio/tegra_gpio.c
+++ b/drivers/gpio/tegra_gpio.c
@@ -258,6 +258,29 @@ static int tegra_gpio_rfree(struct udevice *dev, unsigned int offset)
 	return 0;
 }
 
+static int tegra_gpio_set_flags(struct udevice *dev, unsigned int offset,
+				ulong flags)
+{
+	struct tegra_port_info *state = dev_get_priv(dev);
+	int gpio = state->base_gpio + offset;
+
+	debug("gpio_set_flags: pin = %d (port %d:bit %d), flag = %d\n",
+	      gpio, GPIO_FULLPORT(gpio), GPIO_BIT(gpio), flags);
+
+	if (flags & GPIOD_IS_AF) {
+		set_config(gpio, CFG_SFIO);
+		return 0;
+	} else if (flags & GPIOD_IS_IN) {
+		return tegra_gpio_direction_input(dev, offset);
+	} else if (flags & GPIOD_IS_OUT) {
+		bool value = flags & GPIOD_IS_OUT_ACTIVE;
+
+		return tegra_gpio_direction_output(dev, offset, value);
+	}
+
+	return -EINVAL;
+}
+
 static const struct dm_gpio_ops gpio_tegra_ops = {
 	.direction_input	= tegra_gpio_direction_input,
 	.direction_output	= tegra_gpio_direction_output,
@@ -266,6 +289,7 @@ static const struct dm_gpio_ops gpio_tegra_ops = {
 	.get_function		= tegra_gpio_get_function,
 	.xlate			= tegra_gpio_xlate,
 	.rfree			= tegra_gpio_rfree,
+	.set_flags		= tegra_gpio_set_flags,
 };
 
 /*
-- 
2.39.5

