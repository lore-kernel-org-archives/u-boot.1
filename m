Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B403AE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420F787165;
	Tue,  3 Oct 2023 08:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mbEKCQ61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066D9871DB; Tue,  3 Oct 2023 08:21:47 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1CD387165
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c15463ddd4so5498141fa.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314104; x=1696918904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANLIjtPoT6SG2XGbIRx4qpZAMR/iRxcgjWpKbr7R2AA=;
 b=mbEKCQ61W1eVo3s7uorOMubMaLhWu2Zp+imPFsYWzJwGftS+kYydd3r09qhjhJLKF+
 d4wn0K1fakBBySO+vZARS8xn6c1sCl/9gNo7fi2zGGs6TwGOx6czf/8GGpbrH1gqPn6j
 EZkoQNmohoxJskovVA5uBtQ+D6mruiogSjmXys/rYo0bu9U6q0H52XIthJD7QVtiufHi
 tzV3Ruy6T4esllt0bEjE+ZL3kg2BrzgCVvi8NbKlf2hKPeZvNSyXuGkTIsSp/ycNeJWG
 Y5dBv83/fK+wTxHiaYgLY5vVZ+n7kz4gKy+LxkGqKk8pghy2Ue+Ix8WluLV/ztpkVmZL
 bB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314104; x=1696918904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANLIjtPoT6SG2XGbIRx4qpZAMR/iRxcgjWpKbr7R2AA=;
 b=eMyw170e5vGKL87SytQj9xPTxDesn8rAiXM6Z3GdfOG9KOhE30k5yeSt5uUrl37siz
 4IEnbZyeEKmbMYD/uw5FFFNZWXAZPDx+z0a3S8sju1Two9DJIyBU6jRZESfLhDt/h0r2
 s37uQAluplTVZHucEUJP+91tWnj4VF1OMYgAbmJFzMt8l3xT/KPguXM/Wc4k3G+dfvoP
 +TBxNQ8QflilDdTYzCsXz5IC9aBmKgfvRH7p1GfGLFWqjvk3lMJvJPW0jlzDoqbqC2I6
 IJN99zbvwo2wVywY/XtLfhTU/kQhTOH1x+HWX6J5tG5Yv9C/xC0m3TB1fqmhFSKBfVDX
 KudQ==
X-Gm-Message-State: AOJu0YziuyupH2BGWYtCTmtfqFlNQ4AfKed7al+gSJza0RUF3pVVJy2H
 jqTIg1ne6giaJGlTJ0u6yO0=
X-Google-Smtp-Source: AGHT+IFJUro5wbB+FcKkA5/690IdtnO+34dFuefOrf7Rti2e1q9yfjTuqIxeepWM/4tf9OH4T943Sg==
X-Received: by 2002:a2e:9914:0:b0:2c0:2ab7:9aae with SMTP id
 v20-20020a2e9914000000b002c02ab79aaemr11395562lji.11.1696314103966; 
 Mon, 02 Oct 2023 23:21:43 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 n4-20020a2e86c4000000b002bfba0d26bcsm103594ljj.8.2023.10.02.23.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:21:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 John Keeping <john@metanate.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 1/4] power: regulator: expand basic reference counter onto
 all uclass
Date: Tue,  3 Oct 2023 09:21:23 +0300
Message-Id: <20231003062126.42026-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062126.42026-1-clamor95@gmail.com>
References: <20231003062126.42026-1-clamor95@gmail.com>
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

Commit is based on 4fcba5d ("regulator: implement basic reference
counter") but expands the idea to all regulators instead of just
fixed/gpio regulators.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/power/regulator/regulator-uclass.c | 41 ++++++++++++++++++++++
 drivers/power/regulator/regulator_common.c | 22 ------------
 drivers/power/regulator/regulator_common.h | 21 -----------
 include/power/regulator.h                  |  2 ++
 4 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index d5a79d861c..4b2c6c2964 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -159,6 +159,25 @@ int regulator_get_enable(struct udevice *dev)
 	return ops->get_enable(dev);
 }
 
+/*
+ * Enable or Disable a regulator
+ *
+ * This is a reentrant function and subsequent calls that enable will
+ * increase an internal counter, and disable calls will decrease the counter.
+ * The actual resource will be enabled when the counter gets to 1 coming from 0,
+ * and disabled when it reaches 0 coming from 1.
+ *
+ * @dev: regulator device
+ * @enable: bool indicating whether to enable or disable the regulator
+ * @return:
+ * 0 on Success
+ * -EBUSY if the regulator cannot be disabled because it's requested by
+ *        another device
+ * -EALREADY if the regulator has already been enabled or has already been
+ *        disabled
+ * -EACCES if there is no possibility to enable/disable the regulator
+ * -ve on different error situation
+ */
 int regulator_set_enable(struct udevice *dev, bool enable)
 {
 	const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
@@ -172,6 +191,23 @@ int regulator_set_enable(struct udevice *dev, bool enable)
 	if (!enable && uc_pdata->always_on)
 		return -EACCES;
 
+	/* If previously enabled, increase count */
+	if (enable && uc_pdata->enable_count > 0) {
+		uc_pdata->enable_count++;
+		return -EALREADY;
+	}
+
+	if (!enable) {
+		if (uc_pdata->enable_count > 1) {
+			/* If enabled multiple times, decrease count */
+			uc_pdata->enable_count--;
+			return -EBUSY;
+		} else if (!uc_pdata->enable_count) {
+			/* If already disabled, do nothing */
+			return -EALREADY;
+		}
+	}
+
 	if (uc_pdata->ramp_delay)
 		old_enable = regulator_get_enable(dev);
 
@@ -187,6 +223,11 @@ int regulator_set_enable(struct udevice *dev, bool enable)
 		}
 	}
 
+	if (enable)
+		uc_pdata->enable_count++;
+	else
+		uc_pdata->enable_count--;
+
 	return ret;
 }
 
diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index 0116fa01bb..62d06bf616 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -74,23 +74,6 @@ int regulator_common_set_enable(const struct udevice *dev,
 		return 0;
 	}
 
-	/* If previously enabled, increase count */
-	if (enable && plat->enable_count > 0) {
-		plat->enable_count++;
-		return -EALREADY;
-	}
-
-	if (!enable) {
-		if (plat->enable_count > 1) {
-			/* If enabled multiple times, decrease count */
-			plat->enable_count--;
-			return -EBUSY;
-		} else if (!plat->enable_count) {
-			/* If already disabled, do nothing */
-			return -EALREADY;
-		}
-	}
-
 	ret = dm_gpio_set_value(&plat->gpio, enable);
 	if (ret) {
 		pr_err("Can't set regulator : %s gpio to: %d\n", dev->name,
@@ -105,10 +88,5 @@ int regulator_common_set_enable(const struct udevice *dev,
 	if (!enable && plat->off_on_delay_us)
 		udelay(plat->off_on_delay_us);
 
-	if (enable)
-		plat->enable_count++;
-	else
-		plat->enable_count--;
-
 	return 0;
 }
diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
index d4962899d8..15f1fa4c93 100644
--- a/drivers/power/regulator/regulator_common.h
+++ b/drivers/power/regulator/regulator_common.h
@@ -13,7 +13,6 @@ struct regulator_common_plat {
 	struct gpio_desc gpio; /* GPIO for regulator enable control */
 	unsigned int startup_delay_us;
 	unsigned int off_on_delay_us;
-	unsigned int enable_count;
 };
 
 int regulator_common_of_to_plat(struct udevice *dev,
@@ -21,26 +20,6 @@ int regulator_common_of_to_plat(struct udevice *dev,
 				char *enable_gpio_name);
 int regulator_common_get_enable(const struct udevice *dev,
 	struct regulator_common_plat *plat);
-/*
- * Enable or Disable a regulator
- *
- * This is a reentrant function and subsequent calls that enable will
- * increase an internal counter, and disable calls will decrease the counter.
- * The actual resource will be enabled when the counter gets to 1 coming from 0,
- * and disabled when it reaches 0 coming from 1.
- *
- * @dev: regulator device
- * @plat: Platform data
- * @enable: bool indicating whether to enable or disable the regulator
- * @return:
- * 0 on Success
- * -EBUSY if the regulator cannot be disabled because it's requested by
- *        another device
- * -EALREADY if the regulator has already been enabled or has already been
- *        disabled
- * -EACCES if there is no possibility to enable/disable the regulator
- * -ve on different error situation
- */
 int regulator_common_set_enable(const struct udevice *dev,
 	struct regulator_common_plat *plat, bool enable);
 
diff --git a/include/power/regulator.h b/include/power/regulator.h
index 200652cb3d..1c7995bd5d 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -159,6 +159,7 @@ enum regulator_flag {
  * @name**     - fdt regulator name - should be taken from the device tree
  * ctrl_reg:   - Control register offset used to enable/disable regulator
  * volt_reg:   - register offset for writing voltage vsel values
+ * enable_count - counter of enable calls for this regulator
  *
  * Note:
  * *  - set automatically on device probe by the uclass's '.pre_probe' method.
@@ -185,6 +186,7 @@ struct dm_regulator_uclass_plat {
 	u8 volt_reg;
 	bool suspend_on;
 	u32 suspend_uV;
+	u32 enable_count;
 };
 
 /* Regulator device operations */
-- 
2.39.2

