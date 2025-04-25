Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71FDC369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBCE382153;
	Fri, 25 Apr 2025 16:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="LR+GpHjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 310BE8059A; Fri, 25 Apr 2025 08:49:53 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDCF281E72
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 08:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E87F843970;
 Fri, 25 Apr 2025 06:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1745563790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62lYkb3hyhezvzjlnzaHBC2eXdKq02x4YKon3heX+l0=;
 b=LR+GpHjxV5rakINFhb8Yh+1jpL9wvb9UC3PgGObmXjw8/cERdZZ01GwATpHu3mnbc/guoK
 iouEanCrK7v1jd+/yu8u2UD0AaiafgxASzlEs9xRRuXcyrkIUxBRF5Sty4YaWlSvxKqq5s
 uWn6ZW3WkkDZw5i11sh1BaB8NypbdemtQ8ooLUPOfoPPQfRZVYus1Rf1niYVIk3n1SJV6q
 c/HzTFy20Wda+/V6CTR8Q50yXh4kpGiMa4doMgsZUmbs3EzWFXUslFg5mpv+PURAC3IJVx
 HypUY93/gA7pH4/VLcIcp+rCrsPXyYTFBgs9jtMg1QflAuWrvZalS4wk3VCQhQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 25 Apr 2025 08:49:32 +0200
Subject: [PATCH 1/2] power-domain: Add support for refcounting (again)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-ge-ian-display-support-v1-1-8a7a0fe75023@bootlin.com>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
In-Reply-To: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehnqdhfrhgrnhgtihhssehtihdrtghomhdprhgtphhtthhopeifrdgvghhorhhovhesphhhhihtvggtrdguvgdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesuggvnhigrdguvgdprhgtphhtthhopehmihhquhgvlhdrr
 hgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepjhhhkedtrdgthhhunhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepshgrmhhuvghlrdhhohhllhgrnhgusehsihhfihhvvgdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Fri, 25 Apr 2025 16:09:21 +0200
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

Some drivers implement their own mechanism for that, but it is probably
best to add this feature in the uclass and share the common code across
drivers. In order to avoid breaking existing drivers, refcounting is
only enabled if the number of subdomains a device node supports is
explicitly set in the probe function. ->xlate() callbacks will return
the power domain ID which is then being used as the array index to reach
the correct refcounter.

As we do not want to break existing users while stile getting
interesting error codes, the implementation is split between:
- a low-level helper reporting error codes if the requested transition
  could not be operated,
- a higher-level helper ignoring the "non error" codes, like EALREADY and
  EBUSY.

CI tests using power domains are slightly updated to make sure the count
of on/off calls is even and the results match what we *now* expect. They
are also extended to test the low-level functions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/sandbox/include/asm/power-domain.h          |  2 +
 drivers/firmware/scmi/sandbox-scmi_devices.c     |  1 +
 drivers/power/domain/power-domain-uclass.c       | 90 ++++++++++++++++++++++--
 drivers/power/domain/sandbox-power-domain-test.c | 15 ++++
 drivers/power/domain/sandbox-power-domain.c      |  4 ++
 include/power-domain.h                           | 69 +++++++++++++++---
 test/dm/power-domain.c                           | 11 ++-
 7 files changed, 177 insertions(+), 15 deletions(-)

diff --git a/arch/sandbox/include/asm/power-domain.h b/arch/sandbox/include/asm/power-domain.h
index 4d5e861dbce2b6434ac9bcffe5fc8f704d32e62d..3b0717f8fa06f1c0493fe6ee758e2e72ff77141e 100644
--- a/arch/sandbox/include/asm/power-domain.h
+++ b/arch/sandbox/include/asm/power-domain.h
@@ -13,6 +13,8 @@ int sandbox_power_domain_query(struct udevice *dev, unsigned long id);
 int sandbox_power_domain_test_get(struct udevice *dev);
 int sandbox_power_domain_test_on(struct udevice *dev);
 int sandbox_power_domain_test_off(struct udevice *dev);
+int sandbox_power_domain_test_on_ll(struct udevice *dev);
+int sandbox_power_domain_test_off_ll(struct udevice *dev);
 int sandbox_power_domain_test_free(struct udevice *dev);
 
 #endif
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
index 938bd8cbc9ffd1ba2109d702f886b6a99288d063..d9fa8ad4bd2126ea564fd5be8124035946dbd432 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -12,6 +12,10 @@
 #include <power-domain-uclass.h>
 #include <dm/device-internal.h>
 
+struct power_domain_priv {
+	int *on_count;
+};
+
 static inline struct power_domain_ops *power_domain_dev_ops(struct udevice *dev)
 {
 	return (struct power_domain_ops *)dev->driver->ops;
@@ -107,22 +111,67 @@ int power_domain_free(struct power_domain *power_domain)
 	return ops->rfree ? ops->rfree(power_domain) : 0;
 }
 
-int power_domain_on(struct power_domain *power_domain)
+int power_domain_on_lowlevel(struct power_domain *power_domain)
 {
+	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
+	struct power_domain_plat *plat = dev_get_uclass_plat(power_domain->dev);
 	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
+	int *on_count = plat->subdomains ? &priv->on_count[power_domain->id] : NULL;
+	int ret;
 
-	debug("%s(power_domain=%p)\n", __func__, power_domain);
+	/* Refcounting is not enabled on all drivers by default */
+	if (on_count) {
+		debug("Enable power domain %s.%ld: %d -> %d (%s)\n",
+		      power_domain->dev->name, power_domain->id, *on_count, *on_count + 1,
+		      (((*on_count + 1) > 1) ? "EALREADY" : "todo"));
 
-	return ops->on ? ops->on(power_domain) : 0;
+		(*on_count)++;
+		if (*on_count > 1)
+			return -EALREADY;
+	}
+
+	ret = ops->on ? ops->on(power_domain) : 0;
+	if (ret) {
+		if (on_count)
+			(*on_count)--;
+		return ret;
+	}
+
+	return 0;
 }
 
-int power_domain_off(struct power_domain *power_domain)
+int power_domain_off_lowlevel(struct power_domain *power_domain)
 {
+	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
+	struct power_domain_plat *plat = dev_get_uclass_plat(power_domain->dev);
 	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
+	int *on_count = plat->subdomains ? &priv->on_count[power_domain->id] : NULL;
+	int ret;
 
-	debug("%s(power_domain=%p)\n", __func__, power_domain);
+	/* Refcounting is not enabled on all drivers by default */
+	if (on_count) {
+		debug("Disable power domain %s.%ld: %d -> %d (%s%s)\n",
+		      power_domain->dev->name, power_domain->id, *on_count, *on_count - 1,
+		      (((*on_count) <= 0) ? "EALREADY" : ""),
+		      (((*on_count - 1) > 0) ? "BUSY" : "todo"));
 
-	return ops->off ? ops->off(power_domain) : 0;
+		if (*on_count <= 0)
+			return -EALREADY;
+
+		(*on_count)--;
+		if (*on_count > 0)
+			return -EBUSY;
+	}
+
+	ret = ops->off ? ops->off(power_domain) : 0;
+	if (ret) {
+		if (on_count)
+			(*on_count)++;
+
+		return ret;
+	}
+
+	return 0;
 }
 
 #if CONFIG_IS_ENABLED(OF_REAL)
@@ -177,7 +226,36 @@ int dev_power_domain_off(struct udevice *dev)
 }
 #endif  /* OF_REAL */
 
+static int power_domain_post_probe(struct udevice *dev)
+{
+	struct power_domain_priv *priv = dev_get_uclass_priv(dev);
+	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
+
+	if (plat->subdomains) {
+		priv->on_count = calloc(sizeof(int), plat->subdomains);
+		if (!priv->on_count)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int power_domain_pre_remove(struct udevice *dev)
+{
+	struct power_domain_priv *priv = dev_get_uclass_priv(dev);
+	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
+
+	if (plat->subdomains)
+		free(priv->on_count);
+
+	return 0;
+}
+
 UCLASS_DRIVER(power_domain) = {
 	.id		= UCLASS_POWER_DOMAIN,
 	.name		= "power_domain",
+	.post_probe	= power_domain_post_probe,
+	.pre_remove	= power_domain_pre_remove,
+	.per_device_auto = sizeof(struct power_domain_priv),
+	.per_device_plat_auto = sizeof(struct power_domain_plat),
 };
diff --git a/drivers/power/domain/sandbox-power-domain-test.c b/drivers/power/domain/sandbox-power-domain-test.c
index 08c15ef342b3dd3ce01807ee59b7e97337f7dde5..df063001f517cae92df6b04a213c81b0d5584d18 100644
--- a/drivers/power/domain/sandbox-power-domain-test.c
+++ b/drivers/power/domain/sandbox-power-domain-test.c
@@ -34,6 +34,20 @@ int sandbox_power_domain_test_off(struct udevice *dev)
 	return power_domain_off(&sbrt->pd);
 }
 
+int sandbox_power_domain_test_on_ll(struct udevice *dev)
+{
+	struct sandbox_power_domain_test *sbrt = dev_get_priv(dev);
+
+	return power_domain_on_lowlevel(&sbrt->pd);
+}
+
+int sandbox_power_domain_test_off_ll(struct udevice *dev)
+{
+	struct sandbox_power_domain_test *sbrt = dev_get_priv(dev);
+
+	return power_domain_off_lowlevel(&sbrt->pd);
+}
+
 int sandbox_power_domain_test_free(struct udevice *dev)
 {
 	struct sandbox_power_domain_test *sbrt = dev_get_priv(dev);
@@ -51,4 +65,5 @@ U_BOOT_DRIVER(sandbox_power_domain_test) = {
 	.id = UCLASS_MISC,
 	.of_match = sandbox_power_domain_test_ids,
 	.priv_auto	= sizeof(struct sandbox_power_domain_test),
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
diff --git a/drivers/power/domain/sandbox-power-domain.c b/drivers/power/domain/sandbox-power-domain.c
index 9dd490b14a3f6e502baccd94d32704e4b6bd56ed..a80316576384b27dc8159e81b5c79fc355af2860 100644
--- a/drivers/power/domain/sandbox-power-domain.c
+++ b/drivers/power/domain/sandbox-power-domain.c
@@ -64,8 +64,12 @@ static int sandbox_power_domain_bind(struct udevice *dev)
 
 static int sandbox_power_domain_probe(struct udevice *dev)
 {
+	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
+
 	debug("%s(dev=%p)\n", __func__, dev);
 
+	plat->subdomains = 1;
+
 	return 0;
 }
 
diff --git a/include/power-domain.h b/include/power-domain.h
index 18525073e5e3534fcbac6fae4e18462f29a4dc49..7fd2c5e365b54889a156d0f0b969fae490ac41a7 100644
--- a/include/power-domain.h
+++ b/include/power-domain.h
@@ -65,6 +65,15 @@ struct power_domain {
 	void *priv;
 };
 
+/**
+ * struct power_domain_plat - Per device accessible structure
+ * @subdomains: Number of subdomains covered by this device, required
+ *              for refcounting
+ */
+struct power_domain_plat {
+	int subdomains;
+};
+
 /**
  * power_domain_get - Get/request the power domain for a device.
  *
@@ -147,37 +156,81 @@ static inline int power_domain_free(struct power_domain *power_domain)
 #endif
 
 /**
- * power_domain_on - Enable power to a power domain.
+ * power_domain_on_lowlevel - Enable power to a power domain (with refcounting)
  *
  * @power_domain:	A power domain struct that was previously successfully
  *		requested by power_domain_get().
- * Return: 0 if OK, or a negative error code.
+ * Return: 0 if the transition has been performed correctly,
+ *         -EALREADY if the domain is already on,
+ *         a negative error code otherwise.
  */
 #if CONFIG_IS_ENABLED(POWER_DOMAIN)
-int power_domain_on(struct power_domain *power_domain);
+int power_domain_on_lowlevel(struct power_domain *power_domain);
 #else
-static inline int power_domain_on(struct power_domain *power_domain)
+static inline int power_domain_on_lowlevel(struct power_domain *power_domain)
 {
 	return -ENOSYS;
 }
 #endif
 
 /**
- * power_domain_off - Disable power to a power domain.
+ * power_domain_on - Enable power to a power domain (ignores the actual state
+ *		      of the power domain)
  *
  * @power_domain:	A power domain struct that was previously successfully
  *		requested by power_domain_get().
- * Return: 0 if OK, or a negative error code.
+ * Return: a negative error code upon error during the transition, 0 otherwise.
+ */
+static inline int power_domain_on(struct power_domain *power_domain)
+{
+	int ret;
+
+	ret = power_domain_on_lowlevel(power_domain);
+	if (ret == -EALREADY)
+		ret = 0;
+
+	return ret;
+}
+
+/**
+ * power_domain_off_lowlevel - Disable power to a power domain (with refcounting)
+ *
+ * @power_domain:	A power domain struct that was previously successfully
+ *		requested by power_domain_get().
+ * Return: 0 if the transition has been performed correctly,
+ *         -EALREADY if the domain is already off,
+ *         -EBUSY if another device is keeping the domain on (but the refcounter
+ *         is decremented),
+ *         a negative error code otherwise.
  */
 #if CONFIG_IS_ENABLED(POWER_DOMAIN)
-int power_domain_off(struct power_domain *power_domain);
+int power_domain_off_lowlevel(struct power_domain *power_domain);
 #else
-static inline int power_domain_off(struct power_domain *power_domain)
+static inline int power_domain_off_lowlevel(struct power_domain *power_domain)
 {
 	return -ENOSYS;
 }
 #endif
 
+/**
+ * power_domain_off - Disable power to a power domain (ignores the actual state
+ *		      of the power domain)
+ *
+ * @power_domain:	A power domain struct that was previously successfully
+ *		requested by power_domain_get().
+ * Return: a negative error code upon error during the transition, 0 otherwise.
+ */
+static inline int power_domain_off(struct power_domain *power_domain)
+{
+	int ret;
+
+	ret = power_domain_off_lowlevel(power_domain);
+	if (ret == -EALREADY || ret == -EBUSY)
+		ret = 0;
+
+	return ret;
+}
+
 /**
  * dev_power_domain_on - Enable power domains for a device .
  *
diff --git a/test/dm/power-domain.c b/test/dm/power-domain.c
index 896cf5b2ae9d26701150fad70e888f8b135a22b0..1002d831764b5a62b05631aee0d70c5609b8574b 100644
--- a/test/dm/power-domain.c
+++ b/test/dm/power-domain.c
@@ -27,17 +27,26 @@ static int dm_test_power_domain(struct unit_test_state *uts)
 
 	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "power-domain-test",
 					      &dev_test));
-	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
+	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain,
 						  TEST_POWER_DOMAIN));
 	ut_assertok(sandbox_power_domain_test_get(dev_test));
 
 	ut_assertok(sandbox_power_domain_test_on(dev_test));
 	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain, 0));
+	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
+						  TEST_POWER_DOMAIN));
+	ut_asserteq(-EALREADY, sandbox_power_domain_test_on_ll(dev_test));
+	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
+						  TEST_POWER_DOMAIN));
+	ut_asserteq(-EBUSY, sandbox_power_domain_test_off_ll(dev_test));
 	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
 						  TEST_POWER_DOMAIN));
 
 	ut_assertok(sandbox_power_domain_test_off(dev_test));
 	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain, 0));
+	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain,
+						  TEST_POWER_DOMAIN));
+	ut_asserteq(-EALREADY, sandbox_power_domain_test_off_ll(dev_test));
 	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain,
 						  TEST_POWER_DOMAIN));
 

-- 
2.48.1

