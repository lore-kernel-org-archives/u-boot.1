Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3403E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4518724B;
	Tue,  3 Oct 2023 08:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="miyT70o8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD6E486E15; Tue,  3 Oct 2023 08:29:58 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5616B870BB
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5042bfb4fe9so595524e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314594; x=1696919394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9JBtaDL/zjtWGpbK/glHoL1uctLM0L4rNGaNIvOtJ0=;
 b=miyT70o8WN0bNJsZr//O2CvCxYUkb+kI9M6B6PuTKyIT5GJ2fC1yw1RSwCMbuSwfJF
 roYMEOXQM3y42IqnfjKAFZv0eaL+P1XG7ogJ2szdqjmjKBULj61gVjmkroVPXfJkE6Jc
 j4NQZqPXEzgoe0cL4u43UGyMC+Qz0CQFxoSxPsyuc2PFl59cU/MrfNNnfaO5JXPwTFjW
 xdL1oB25FO4L1x8WY+s2tiKNcbsNj5N9Pa3VwL74Zp1iaoUkmcAtnsKs9M1HwpUIrfdB
 v7VfKd7wLNaamgUYhIvNp8OUW4qyveGhVa5wZFky7uc7q2IxqKHqde9HcJaI4nO6tZsc
 9BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314594; x=1696919394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9JBtaDL/zjtWGpbK/glHoL1uctLM0L4rNGaNIvOtJ0=;
 b=wXs7408AO9zp7ZQgZLji4RmM5KPZpvkgtahsyZCtxLM391WePiQmN7TBRCnuQZLqLO
 e8tUSW3bDeV6IDIM2rzlUyd42GJQpUoc62SFFIpjR8BBKZh338w6X24+VrsRsZ0KbdL0
 dTvosQt7/gIT02zdFyyZwBZ25Qz6OAgtXT5RJtPng7HYUvAcpc3jE4aqC8WGRoCcF+22
 SMS9vtcbALhBXtLdhZhhC+L0NIHk+9VwkCFcIHuT4XfG8Ocj693cbb9LtbxqYzGBoGd4
 t6khsLEcxDMQ86ll0vKGgB6RjczB9TKPI6GhB3zpaYa+GaOaCN6Zfv95eewoXdS5HEKW
 1WAA==
X-Gm-Message-State: AOJu0YwF3STB7KpbNE1p7NU94Ttgf618PAG8HIZI4UaTL3hES7J6vlw0
 FGgLodQC2XT4CHioLhq6HKItYz1xiuc=
X-Google-Smtp-Source: AGHT+IEj9Apzx9/VGCi8Z6P12FK6p6Qq8QpQcRgp9+VpKs4PuDp7l3inDVh6SXSxG5IYACWvcE/uJA==
X-Received: by 2002:a19:6756:0:b0:4fa:da4f:636f with SMTP id
 e22-20020a196756000000b004fada4f636fmr9782089lfj.32.1696314594534; 
 Mon, 02 Oct 2023 23:29:54 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 j27-20020ac253bb000000b005009aa86582sm78583lfh.55.2023.10.02.23.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:29:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 7/8] power: pmic: tps65910: add TPS65911 PMIC support
Date: Tue,  3 Oct 2023 09:29:40 +0300
Message-Id: <20231003062941.42501-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062941.42501-1-clamor95@gmail.com>
References: <20231003062941.42501-1-clamor95@gmail.com>
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

Add support to bind the regulators/child nodes with the pmic.
Also adds the pmic i2c based read/write functions to access pmic
registers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/device-tree-bindings/pmic/tps65911.txt | 78 ++++++++++++++++++++++
 drivers/power/pmic/pmic_tps65910_dm.c      | 15 ++++-
 include/power/tps65910_pmic.h              | 44 ++++++++++++
 3 files changed, 134 insertions(+), 3 deletions(-)
 create mode 100644 doc/device-tree-bindings/pmic/tps65911.txt

diff --git a/doc/device-tree-bindings/pmic/tps65911.txt b/doc/device-tree-bindings/pmic/tps65911.txt
new file mode 100644
index 0000000000..29270efbfe
--- /dev/null
+++ b/doc/device-tree-bindings/pmic/tps65911.txt
@@ -0,0 +1,78 @@
+Texas Instruments, TPS65911 PMIC
+
+This device uses two drivers:
+- drivers/power/pmic/tps65910.c (for parent device)
+- drivers/power/regulator/tps65911_regulator.c (for child regulators)
+
+This chapter describes the binding info for the PMIC driver and regulators.
+
+Required properties for PMIC:
+- compatible: "ti,tps65911"
+- reg: 0x2d
+
+With those two properties, the pmic device can be used for read/write only.
+To bind each regulator, the optional regulators subnode should exists.
+
+Optional subnode:
+- name: regulators (subnode list of each device's regulator)
+
+Regulators subnode contains set on supported regulators.
+
+Required properties:
+- regulator-name: used for regulator uclass platform data '.name',
+
+List of supported regulator nodes names for tps65911:
+- vdd1, vdd2, vddctrl, vddio
+- ldo1, ldo2, ldo3, ldo4, ldo5, ldo6, ldo7, ldo8
+
+vddio in datasheet is referred as vio, but for reduction of code and
+unification of smps regulators it is named vddio.
+
+Optional:
+- regulator-min-microvolt: minimum allowed Voltage to set
+- regulator-max-microvolt: minimum allowed Voltage to set
+- regulator-always-on: regulator should be never disabled
+- regulator-boot-on: regulator should be enabled by the bootloader
+
+Example:
+
+tps65911@2d {
+	compatible = "ti,tps65911";
+	reg = <0x2d>;
+
+	regulators {
+		vdd1 {
+			regulator-name = "vdd_1v2_backlight";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		...
+
+		vddio {
+			regulator-name = "vdd_1v8_gen";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		ldo1 {
+			regulator-name = "vdd_emmc_core";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		...
+
+		ldo8 {
+			regulator-name = "vdd_ddr_hs";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+	};
+};
diff --git a/drivers/power/pmic/pmic_tps65910_dm.c b/drivers/power/pmic/pmic_tps65910_dm.c
index 8ead1db802..0a4911cef6 100644
--- a/drivers/power/pmic/pmic_tps65910_dm.c
+++ b/drivers/power/pmic/pmic_tps65910_dm.c
@@ -12,13 +12,19 @@
 #include <power/regulator.h>
 #include <power/tps65910_pmic.h>
 
-static const struct pmic_child_info pmic_children_info[] = {
+static const struct pmic_child_info tps65910_children_info[] = {
 	{ .prefix = "ldo_", .driver = TPS65910_LDO_DRIVER },
 	{ .prefix = "buck_", .driver = TPS65910_BUCK_DRIVER },
 	{ .prefix = "boost_", .driver = TPS65910_BOOST_DRIVER },
 	{ },
 };
 
+static const struct pmic_child_info tps65911_children_info[] = {
+	{ .prefix = "ldo", .driver = TPS65911_LDO_DRIVER },
+	{ .prefix = "vdd", .driver = TPS65911_VDD_DRIVER },
+	{ },
+};
+
 static int pmic_tps65910_reg_count(struct udevice *dev)
 {
 	return TPS65910_NUM_REGS;
@@ -50,6 +56,8 @@ static int pmic_tps65910_read(struct udevice *dev, uint reg, u8 *buffer,
 
 static int pmic_tps65910_bind(struct udevice *dev)
 {
+	const struct pmic_child_info *tps6591x_children_info =
+			(struct pmic_child_info *)dev_get_driver_data(dev);
 	ofnode regulators_node;
 	int children;
 
@@ -59,7 +67,7 @@ static int pmic_tps65910_bind(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	children = pmic_bind_children(dev, regulators_node, pmic_children_info);
+	children = pmic_bind_children(dev, regulators_node, tps6591x_children_info);
 	if (!children)
 		debug("%s has no children (regulators)\n", dev->name);
 
@@ -83,7 +91,8 @@ static struct dm_pmic_ops pmic_tps65910_ops = {
 };
 
 static const struct udevice_id pmic_tps65910_match[] = {
-	{ .compatible = "ti,tps65910" },
+	{ .compatible = "ti,tps65910", .data = (ulong)&tps65910_children_info },
+	{ .compatible = "ti,tps65911", .data = (ulong)&tps65911_children_info },
 	{ /* sentinel */ }
 };
 
diff --git a/include/power/tps65910_pmic.h b/include/power/tps65910_pmic.h
index 66214786d3..7d6545abdf 100644
--- a/include/power/tps65910_pmic.h
+++ b/include/power/tps65910_pmic.h
@@ -126,4 +126,48 @@ struct tps65910_regulator_pdata {
 #define TPS65910_BOOST_DRIVER	"tps65910_boost"
 #define TPS65910_LDO_DRIVER	"tps65910_ldo"
 
+/* tps65911 i2c registers */
+enum {
+	TPS65911_REG_VIO			= 0x20,
+	TPS65911_REG_VDD1,
+	TPS65911_REG_VDD1_OP,
+	TPS65911_REG_VDD1_SR,
+	TPS65911_REG_VDD2,
+	TPS65911_REG_VDD2_OP,
+	TPS65911_REG_VDD2_SR,
+	TPS65911_REG_VDDCTRL,
+	TPS65911_REG_VDDCTRL_OP,
+	TPS65911_REG_VDDCTRL_SR,
+	TPS65911_REG_LDO1			= 0x30,
+	TPS65911_REG_LDO2,
+	TPS65911_REG_LDO5,
+	TPS65911_REG_LDO8,
+	TPS65911_REG_LDO7,
+	TPS65911_REG_LDO6,
+	TPS65911_REG_LDO4,
+	TPS65911_REG_LDO3,
+};
+
+#define TPS65911_VDD_NUM		4
+#define TPS65911_LDO_NUM		8
+
+#define TPS65911_VDD_VOLT_MAX		1500000
+#define TPS65911_VDD_VOLT_MIN		600000
+#define TPS65911_VDD_VOLT_BASE		562500
+
+#define TPS65911_LDO_VOLT_MAX		3300000
+#define TPS65911_LDO_VOLT_BASE		800000
+
+#define TPS65911_LDO_SEL_MASK		(0x3f << 2)
+
+#define TPS65911_LDO124_VOLT_MAX_HEX	0x32
+#define TPS65911_LDO358_VOLT_MAX_HEX	0x19
+#define TPS65911_LDO358_VOLT_MIN_HEX	0x02
+
+#define TPS65911_LDO124_VOLT_STEP	50000
+#define TPS65911_LDO358_VOLT_STEP	100000
+
+#define TPS65911_VDD_DRIVER		"tps65911_vdd"
+#define TPS65911_LDO_DRIVER		"tps65911_ldo"
+
 #endif /* __TPS65910_PMIC_H_ */
-- 
2.39.2

