Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8C8E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 18:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E5C7806FC;
	Fri, 10 Jan 2025 19:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Mjy6sEvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A374F806C9; Fri, 10 Jan 2025 19:43:09 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F8080657
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 19:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B5336000B;
 Fri, 10 Jan 2025 18:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1736534586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZGKXJMKJtwdlR46nNEEkW5eYdxjCavvffDsNxfMgdY=;
 b=Mjy6sEvxfa6/MlKwmhVfagC9HxqxZGiqUvrrriWyCV6RxRcCySzc6Auy2+1EgwCxRoZSr7
 p0FNuzapiuS/c3UtrYqpshiR/a48doHRHAQTTH6jQ9chPRp5H8Ly7hq/M7OMNCw55MnT5r
 RX3d+WK+pKRu+RIjcBTYo5C5ZiFzS1EDMDwCAe/k5vsNMCCIVJIlJZkYXqWApfBs3YzFh/
 dp7R3xkrk77yhPG/e+iayTR7CWxuw+TTjsK4WzvgolUkXF3E5Xbb1zuvgPC9CNbo5dMxeD
 0yOsqQKPiYdnq0RMGkEekNxt5QqL2QQE+l1LtDCdTZXE/RyB+I4oczdQmxGgwA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 19:43:02 +0100
Subject: [PATCH v3 05/13] power-domain: Add refcounting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-ge-mainline-display-support-v3-5-d2c0acea6feb@bootlin.com>
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
In-Reply-To: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
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
domains can be done in recursive loops were the same power domain
disabled up to 4 times in a row. PGCs seem to have tight FSM internal
timings to respect and it is easy to produce a race condition that puts
the power domains in an unstable state, leading to ADB400 errors and
later crashes in Linux.

CI tests using power domains are slightly updated to make sure the count
of on/off calls is even and the results match what we *now* expect.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/firmware/scmi/sandbox-scmi_devices.c     |  1 +
 drivers/power/domain/power-domain-uclass.c       | 37 ++++++++++++++++++++++--
 drivers/power/domain/sandbox-power-domain-test.c |  1 +
 include/power-domain.h                           |  4 +--
 test/dm/power-domain.c                           |  2 +-
 5 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
index 96c2922b067e2886b3fa963bcd7e396f4569a569..9f253b0fd40f703a5ec11d34c197423d27ad8b01 100644
--- a/drivers/firmware/scmi/sandbox-scmi_devices.c
+++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
@@ -163,4 +163,5 @@ U_BOOT_DRIVER(sandbox_scmi_devices) = {
 	.priv_auto = sizeof(struct sandbox_scmi_device_priv),
 	.remove = sandbox_scmi_devices_remove,
 	.probe = sandbox_scmi_devices_probe,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
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
diff --git a/drivers/power/domain/sandbox-power-domain-test.c b/drivers/power/domain/sandbox-power-domain-test.c
index 08c15ef342b3dd3ce01807ee59b7e97337f7dde5..5b530974e942ffcba453e53be330baaf3a113a13 100644
--- a/drivers/power/domain/sandbox-power-domain-test.c
+++ b/drivers/power/domain/sandbox-power-domain-test.c
@@ -51,4 +51,5 @@ U_BOOT_DRIVER(sandbox_power_domain_test) = {
 	.id = UCLASS_MISC,
 	.of_match = sandbox_power_domain_test_ids,
 	.priv_auto	= sizeof(struct sandbox_power_domain_test),
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
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
diff --git a/test/dm/power-domain.c b/test/dm/power-domain.c
index 896cf5b2ae9d26701150fad70e888f8b135a22b0..8a95f6bdb903be9d1993528d87d5cae0075a83e4 100644
--- a/test/dm/power-domain.c
+++ b/test/dm/power-domain.c
@@ -27,7 +27,7 @@ static int dm_test_power_domain(struct unit_test_state *uts)
 
 	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "power-domain-test",
 					      &dev_test));
-	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
+	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain,
 						  TEST_POWER_DOMAIN));
 	ut_assertok(sandbox_power_domain_test_get(dev_test));
 

-- 
2.47.0

