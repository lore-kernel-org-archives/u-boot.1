Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C1BC61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 10:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F3006081A;
	Fri, 28 Aug 2026 10:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vHTFqCwhgfsq; Fri, 28 Aug 2026 10:52:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787914343;
	bh=gCRPNgP4QD9I9vCphLXvRxfpaDf9wZ48SNQ0Z/O8+rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NC5no9khKXhGa91+YR94JIbuGsPPF/WpT+g9yhQNlxO1nwf+kogiKUeXnm666//r6
	 12gxEYPTC0IeEqT575l+CmiQzbnHh08zakEWAatcA/aPJxODEwFO0U+RY4XDs6D93T
	 xMCQRxtL0quZTMTnhWPPO0VJ+UhLRqdrEsOgzU3AT97AdSNyEXPZTi6M5BUBaDfWVJ
	 3McrvvtsrzZT6pazgTYEeU01mbOrcVYrrPq30pt+xvSawrXFGZorlv8t5kv79zHD3M
	 fKA2caCu6lY9HtbO2NnBNykeNl+Lk9WmWlFp8bMjA+7lRqaFwAbRe0oWQjQzVtPr7N
	 WPXInZj+KQ8jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B773E60708;
	Fri, 28 Aug 2026 10:52:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2BB5CBC
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B90DB606A7
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QL34i64EHMx4 for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 10:52:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=d5avMnM+
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A07CA60663
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:17 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so318654f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787914335; x=1788519135;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gCRPNgP4QD9I9vCphLXvRxfpaDf9wZ48SNQ0Z/O8+rY=;
 b=d5avMnM+O93X2RK3uZTnuHH+DH8J8k65aqjVsdv5OMjZjUSbfmJDOLUduOttleALDo
 96+O2lwyeJWS5RpuOhzT5r9Fa7yv2HevIB2IIN511Ms/TxtFB7J1RaN8jEFY9VG0RSvy
 MmikKCTR8L95QMdwAwYkDDvhDoIM+nrFAoTP88a0EIBQHZJ8L5BPFTlKkPkPEz82FusG
 PqZkPnvKT8S3E0Qi62Ja3PosOZIU+oTIYcMUdrqU1etRdBXCxg8+KTCatnTEc7ZMppfm
 //BDjy+GwKr7coct0+q2fnAhO1eOs7PKosDppmA8nN3dS8/f9mszXldHRwLlNvhLPTiy
 k+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787914335; x=1788519135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gCRPNgP4QD9I9vCphLXvRxfpaDf9wZ48SNQ0Z/O8+rY=;
 b=RmZ5OgNyRKQaB6Q8iel0ymB2Q0yuQtitiyAvem1tVXBeJD2tEyBHGykSalf3ywGavh
 CCNxxmOiYtV8/vn4liN2FHrKf4RXMfvNO632DXs1LNLKq3Ik3r8exOAcYzxnbvK7T+Gq
 TkFir/0mBdddqbqkawc4wrOyaGuFDeqOSXqY26e7kPLsuKV/thbToodMq4xGrT02r4/y
 ls2QtzZ6fXGiqBK9Ou99raQUTeGatVQkP9XTTGR6LRA6nfKqq4kX0QwfnNWg3iBwUBt+
 5G4kBTfNseRdFC10ZvEUqcTT10lHLVnc1o8MFoqvO0Mwgq5adL8FymnecEl5KZIDdHfX
 1OxA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9E3hXiZXPMKm+XofhbsiqDkeXbLkxB0p4zxZN0QnnDaWHROKm5ZNjeLK6KTdab4jOfB1WvxY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nwJNxirnhXZ0McbXmAT0v+jguYUnwe6XGZsffmVpf/at0diEJr
 TniQshFspevQACmMRLgELe8vCFceAWYnPFFSLiS/XuiYB0p54qZLtOqA
X-Gm-Gg: AR+sD128yZh6qaxDftopkRifTl7L9Ne/bIb+Mub6ZAYy51MnzmmKw7rC8GDKVEmgm8w
 4XodPuF1vMrBBRBsFv44MteMqisH94WXAZJseBQLASMqaMTh+eAZrUZC5bP/yJG40XlFWgV2SuQ
 T8tbxaW78nvN7eQdqHH6+nGNEByvIkm46FjWurbz3aXwDAmtJbEnnJH29YgobDUP4CI8SjV7KIV
 XtwrhGdd+58oSYhN59nSOCN6xqwxZ+Cd4Qz1BZa4Fhsf0d923TU7RpSkKkX9mTh7XWYbMFNXO39
 /z/OkgyqT99s/ytDAmkRJRueheTdyI4OE9x0KQzhnFZt391x7ZWfagXvm4m4D1yaS0LYTOzaZrT
 9ojkaT4ji6vBW7jBKJY33SnrzOBuDd5NEZYhhNTcthLzr2Ib3f6iCX3W1Nx3fsxqvjtRpWPme2w
 Dku766G1WSvX7EfUGgRpQzZwB3KHchqdjdcrpmTzH6xzTHyLYNuQ6Ux/CR7HkTbK4phA==
X-Received: by 2002:a05:6000:4211:b0:482:f530:c45b with SMTP id
 ffacd0b85a97d-482f798a6c1mr7738537f8f.5.1787914335160; 
 Fri, 28 Aug 2026 03:52:15 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f16sm3212202f8f.1.2026.08.28.03.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:52:14 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 2/4] regulator: claim the enable GPIO at probe time,
 not in of_to_plat()
Date: Fri, 28 Aug 2026 12:52:08 +0200
Message-ID: <20260828105210.32664-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828105210.32664-1-mehmet.fide@gmail.com>
References: <20260828105210.32664-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

regulator_common_of_to_plat() requests the enable GPIO, which probes
the GPIO controller and claims the pin while the consumer's platform
data is still being read. of_to_plat() must not do either: it runs
before the device's pinctrl state is applied, so on SoCs where the
direction lives in the pad register - the output enable on Vybrid is
one - the pinctrl undoes the direction the early claim just set, and a
fixed regulator configured as always-on powers nothing.

Parse the GPIO into the platform data in of_to_plat() and request it in
the new regulator_common_probe(), called from the fixed and fixed-clock
regulator probe methods. The gpio regulator's voltage-control GPIO has
the same problem and moves the same way.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/power/regulator/fixed.c            | 11 ++++++++++
 drivers/power/regulator/gpio-regulator.c   | 21 +++++++++++++++---
 drivers/power/regulator/regulator_common.c | 25 ++++++++++++++++++----
 drivers/power/regulator/regulator_common.h |  3 +++
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/power/regulator/fixed.c b/drivers/power/regulator/fixed.c
index 1dd137f493e..b8e3af0f0ca 100644
--- a/drivers/power/regulator/fixed.c
+++ b/drivers/power/regulator/fixed.c
@@ -38,6 +38,11 @@ static int fixed_regulator_of_to_plat(struct udevice *dev)
 	return regulator_common_of_to_plat(dev, plat, gpios ? "gpios" : "gpio");
 }
 
+static int fixed_regulator_probe(struct udevice *dev)
+{
+	return regulator_common_probe(dev, dev_get_plat(dev));
+}
+
 static int fixed_regulator_get_value(struct udevice *dev)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
@@ -115,6 +120,11 @@ static int fixed_clock_regulator_set_enable(struct udevice *dev, bool enable)
 static int fixed_clock_regulator_probe(struct udevice *dev)
 {
 	struct fixed_clock_regulator_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = regulator_common_probe(dev, dev_get_plat(dev));
+	if (ret)
+		return ret;
 
 	priv->enable_clock = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->enable_clock))
@@ -150,6 +160,7 @@ U_BOOT_DRIVER(regulator_fixed) = {
 	.id = UCLASS_REGULATOR,
 	.ops = &fixed_regulator_ops,
 	.of_match = fixed_regulator_ids,
+	.probe = fixed_regulator_probe,
 	.of_to_plat = fixed_regulator_of_to_plat,
 	.plat_auto = sizeof(struct regulator_common_plat),
 };
diff --git a/drivers/power/regulator/gpio-regulator.c b/drivers/power/regulator/gpio-regulator.c
index 787f8170234..703a96ff095 100644
--- a/drivers/power/regulator/gpio-regulator.c
+++ b/drivers/power/regulator/gpio-regulator.c
@@ -19,6 +19,7 @@
 
 struct gpio_regulator_plat {
 	struct regulator_common_plat common;
+	struct gpio_dt_desc gpio_dt; /* parsed voltage GPIO, requested in probe */
 	struct gpio_desc gpio; /* GPIO for regulator voltage control */
 	int states[GPIO_REGULATOR_MAX_STATES];
 	int voltages[GPIO_REGULATOR_MAX_STATES];
@@ -28,7 +29,6 @@ static int gpio_regulator_of_to_plat(struct udevice *dev)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
 	struct gpio_regulator_plat *plat;
-	struct gpio_desc *gpio;
 	int ret, count, i, j;
 	u32 states_array[GPIO_REGULATOR_MAX_STATES * 2];
 
@@ -47,8 +47,8 @@ static int gpio_regulator_of_to_plat(struct udevice *dev)
 	 * per gpio-regulator. As of now no instance with multiple
 	 * gpios is presnt
 	 */
-	gpio = &plat->gpio;
-	ret = gpio_request_by_name(dev, "gpios", 0, gpio, GPIOD_IS_OUT);
+	ret = gpio_parse_by_name(dev, "gpios", 0, GPIOD_IS_OUT,
+				 &plat->gpio_dt);
 	if (ret)
 		debug("regulator gpio - not found! Error: %d", ret);
 
@@ -76,6 +76,20 @@ static int gpio_regulator_of_to_plat(struct udevice *dev)
 	return regulator_common_of_to_plat(dev, &plat->common, "enable-gpios");
 }
 
+static int gpio_regulator_probe(struct udevice *dev)
+{
+	struct gpio_regulator_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	if (plat->gpio_dt.present) {
+		ret = gpio_request_parsed(dev, &plat->gpio_dt, &plat->gpio);
+		if (ret)
+			return ret;
+	}
+
+	return regulator_common_probe(dev, &plat->common);
+}
+
 static int gpio_regulator_get_value(struct udevice *dev)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
@@ -153,6 +167,7 @@ U_BOOT_DRIVER(gpio_regulator) = {
 	.id = UCLASS_REGULATOR,
 	.ops = &gpio_regulator_ops,
 	.of_match = gpio_regulator_ids,
+	.probe = gpio_regulator_probe,
 	.of_to_plat = gpio_regulator_of_to_plat,
 	.plat_auto	= sizeof(struct gpio_regulator_plat),
 };
diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index c0387eff4fc..99a3cde436e 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -16,7 +16,6 @@ int regulator_common_of_to_plat(struct udevice *dev,
 				struct regulator_common_plat *plat,
 				const char *enable_gpio_name)
 {
-	struct gpio_desc *gpio;
 	int flags = GPIOD_IS_OUT;
 	int ret;
 
@@ -25,10 +24,10 @@ int regulator_common_of_to_plat(struct udevice *dev,
 	if (dev_read_bool(dev, "regulator-boot-on"))
 		flags |= GPIOD_IS_OUT_ACTIVE;
 
-	/* Get optional enable GPIO desc */
-	gpio = &plat->gpio;
+	/* Read the optional enable GPIO; it is requested in probe() */
 	if (CONFIG_IS_ENABLED(DM_GPIO)) {
-		ret = gpio_request_by_name(dev, enable_gpio_name, 0, gpio, flags);
+		ret = gpio_parse_by_name(dev, enable_gpio_name, 0, flags,
+					 &plat->gpio_dt);
 		if (ret) {
 			debug("Regulator '%s' optional enable GPIO - not found! Error: %d\n",
 			      dev->name, ret);
@@ -49,6 +48,24 @@ int regulator_common_of_to_plat(struct udevice *dev,
 	return 0;
 }
 
+int regulator_common_probe(struct udevice *dev,
+			   struct regulator_common_plat *plat)
+{
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(DM_GPIO) || !plat->gpio_dt.present)
+		return 0;
+
+	ret = gpio_request_parsed(dev, &plat->gpio_dt, &plat->gpio);
+	if (ret) {
+		debug("Regulator '%s' enable GPIO request failed: %d\n",
+		      dev->name, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int regulator_common_get_enable(const struct udevice *dev,
 	struct regulator_common_plat *plat)
 {
diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
index d4962899d83..43e32ac48f6 100644
--- a/drivers/power/regulator/regulator_common.h
+++ b/drivers/power/regulator/regulator_common.h
@@ -10,6 +10,7 @@
 #include <asm/gpio.h>
 
 struct regulator_common_plat {
+	struct gpio_dt_desc gpio_dt; /* parsed enable GPIO, requested in probe */
 	struct gpio_desc gpio; /* GPIO for regulator enable control */
 	unsigned int startup_delay_us;
 	unsigned int off_on_delay_us;
@@ -19,6 +20,8 @@ struct regulator_common_plat {
 int regulator_common_of_to_plat(struct udevice *dev,
 				struct regulator_common_plat *plat, const
 				char *enable_gpio_name);
+int regulator_common_probe(struct udevice *dev,
+			   struct regulator_common_plat *plat);
 int regulator_common_get_enable(const struct udevice *dev,
 	struct regulator_common_plat *plat);
 /*
-- 
2.54.0

