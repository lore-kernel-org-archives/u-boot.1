Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3AAE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72B38950A;
	Thu,  5 Dec 2024 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JXqcMeGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13470894F9; Thu,  5 Dec 2024 14:54:52 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B08D389495
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C54E840009;
 Thu,  5 Dec 2024 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733406887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bcCWj0b2Aue5X9nCkpZrD+tEAw5YEURvMSZkrlBtyQ=;
 b=JXqcMeGIHF8GPbzAOjdULcE2FLAxUxbk9kOgt55N8mHAEOvrmb5chAHaoW0IrvOKTnqfAm
 6gs/UX89koe2go4wwBQtpPeYiO6xJddYDKpoZf0zxbsfFU5I6ehrsyudbKUznKR9VKvqJk
 Y11PBJP9mYfWdSJUp4V5Rk2LyPgDuUEPd1sK6nEbAOyEBZ2ZeOKY/80zr59OEbLx8HzWLG
 osQwelRXsprbkAwVJ8tCWP6yv3uU0I0HSeU9/zShsl5g3oBcWgcyK45ZXsTN4tspzs03sN
 9wCRzieFt3wIXMFijzo6kQTEgToNHjF0+ArhSqL1ZIs+OIHNTL3KIHtGuFC9iA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Dec 2024 14:54:11 +0100
Subject: [PATCH v2 05/13] power-domain: Add refcounting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ge-mainline-display-support-v2-5-4683bb4388dc@bootlin.com>
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com
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

It is very surprising that such an uclass, specifically designed to
handle resources that may be shared by different devices, is not keeping
the count of the number of times a power domain has been
enabled/disabled to avoid shutting it down unexpectedly or disabling it
several times.

Doing this causes troubles on eg. i.MX8MP because disabling power
domains can be done in a recursive loops were the same power domain
disabled up to 4 times in a row. PGCs seem to have tight FSM internal
timings to respect and it is easy to produce a race condition that puts
the power domains in an unstable state, leading to ADB400 errors and
later crashes in Linux.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/power/domain/power-domain-uclass.c | 37 ++++++++++++++++++++++++++++--
 include/power-domain.h                     |  4 ++--
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
index 938bd8cbc9ffd1ba2109d702f886b6a99288d063..55a3d95d83c5aaac31acbd877199c87f8f6fb880 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -12,6 +12,10 @@
 #include <power-domain-uclass.h>
 #include <dm/device-internal.h>
 
+struct power_domain_priv {
+	int on_count;
+};
+
 static inline struct power_domain_ops *power_domain_dev_ops(struct udevice *dev)
 {
 	return (struct power_domain_ops *)dev->driver->ops;
@@ -110,19 +114,47 @@ int power_domain_free(struct power_domain *power_domain)
 int power_domain_on(struct power_domain *power_domain)
 {
 	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
+	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
+	int ret;
 
 	debug("%s(power_domain=%p)\n", __func__, power_domain);
 
-	return ops->on ? ops->on(power_domain) : 0;
+	if (priv->on_count++ > 0)
+		return 0;
+
+	ret = ops->on ? ops->on(power_domain) : 0;
+	if (ret) {
+		priv->on_count--;
+		return ret;
+	}
+
+	return 0;
 }
 
 int power_domain_off(struct power_domain *power_domain)
 {
 	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
+	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
+	int ret;
 
 	debug("%s(power_domain=%p)\n", __func__, power_domain);
 
-	return ops->off ? ops->off(power_domain) : 0;
+	if (priv->on_count <= 0) {
+		debug("Power domain %s already off.\n", power_domain->dev->name);
+		priv->on_count--;
+		return 0;
+	}
+
+	if (priv->on_count-- > 1)
+		return 0;
+
+	ret = ops->off ? ops->off(power_domain) : 0;
+	if (ret) {
+		priv->on_count++;
+		return ret;
+	}
+
+	return 0;
 }
 
 #if CONFIG_IS_ENABLED(OF_REAL)
@@ -180,4 +212,5 @@ int dev_power_domain_off(struct udevice *dev)
 UCLASS_DRIVER(power_domain) = {
 	.id		= UCLASS_POWER_DOMAIN,
 	.name		= "power_domain",
+	.per_device_auto = sizeof(struct power_domain_priv),
 };
diff --git a/include/power-domain.h b/include/power-domain.h
index 18525073e5e3534fcbac6fae4e18462f29a4dc49..0266fc2f864ef3645d2a8b3c6fa66fdbd868799c 100644
--- a/include/power-domain.h
+++ b/include/power-domain.h
@@ -147,7 +147,7 @@ static inline int power_domain_free(struct power_domain *power_domain)
 #endif
 
 /**
- * power_domain_on - Enable power to a power domain.
+ * power_domain_on - Enable power to a power domain (with refcounting)
  *
  * @power_domain:	A power domain struct that was previously successfully
  *		requested by power_domain_get().
@@ -163,7 +163,7 @@ static inline int power_domain_on(struct power_domain *power_domain)
 #endif
 
 /**
- * power_domain_off - Disable power to a power domain.
+ * power_domain_off - Disable power to a power domain (with refcounting)
  *
  * @power_domain:	A power domain struct that was previously successfully
  *		requested by power_domain_get().

-- 
2.47.0

