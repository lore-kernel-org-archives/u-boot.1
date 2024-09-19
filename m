Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D75CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66D58885D;
	Thu, 19 Sep 2024 16:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fK85UlVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AFF891A0; Thu, 19 Sep 2024 16:02:50 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A9B8915B
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5e1bf327af8so446963eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726754566; x=1727359366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKMjPURdEtWNa5Gti+b79b1aDzWqBs4TGyj61h+J8+c=;
 b=fK85UlVz3DsspUhiNP2fJWqzvvy42ZIcx2qBSzK/xmQI4FbHgc0dGUE9Rn2PqvnMBl
 Ym99FrEV07y79dzSRqL2+dEgli/ATj+4ptQpCWNFspKYZD4w61gaEq/jmttuR29wVDry
 okxDjnGJR7jEVQ1T3tJvDD1/vCkTTekcDwgQ+mlnhPXXn3BI5oDZKOt5pTvXnNTTao47
 9Tluv2B/1d9LO9iz4iA8uHRLP6zEI94uUx2MQs9kfT3PIADp2z9o4b2dDxiNtRK9EBqt
 KG802Qe46IuZK/R3ngwRG6+b3fS1fZVygF5gXfaLM0Zgkjr/gqzS2F+ed786wznM8/1H
 bg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726754566; x=1727359366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKMjPURdEtWNa5Gti+b79b1aDzWqBs4TGyj61h+J8+c=;
 b=gcNICtuusNgiQxUuVVhyPL+kE1w+gkqMXSQqedfFETaiVqN9g5xRONodSMeeK1w1S8
 Y2ge/oIkDtu4N+uZQXjcwrjtRrUYlTXiXzf3bMTzJvQG7VEbTasm8+AjkBHBMGiSWmj/
 DzGUFwbOVT5xKhgyOWIrRkxHrLaR8nN+WVXZgktGYCNbPYsvN8SRcOs4gg9hQUaG6trm
 05esy5YUmSOqgfH6XqrFYz466DWFSMdE8WQh9klVvBW5yQfuna336d/MNUEH3yq5QU8v
 z1kqDsYwTGDqNG8uzntHWybSDQe0+ag5PTy6yTMgESf4hKOILtgSh7+sEtU8Wu9XRUv6
 I50A==
X-Gm-Message-State: AOJu0YwzbGCcIllCCA8DHHImP82DdNuFfQslv0pedsGDGxZml8pZwiQy
 IS+iPR0H1wU1CndR2Q7fYPBJzAtwu33dt8etJkohmrJ3YanhYe/qJOL+Rurt
X-Google-Smtp-Source: AGHT+IE9QSv/Uq++2UrrEpxlCVG8nDZk4T/1N7Pjv7m16VW43T8vKx0HBP2WyouFRTnMc65pIez0Lw==
X-Received: by 2002:a05:6820:1b86:b0:5e1:db0d:4c4f with SMTP id
 006d021491bc7-5e201454ed5mr12564782eaf.8.1726754566439; 
 Thu, 19 Sep 2024 07:02:46 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5e3b0d6ae98sm1941649eaf.5.2024.09.19.07.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 07:02:46 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org,
 quentin.schulz@cherry.de, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 2/4] board: rockchip: Add vdd_cpu reg fixup for RGXX3 Series
Date: Thu, 19 Sep 2024 09:00:20 -0500
Message-Id: <20240919140022.511067-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919140022.511067-1-macroalpha82@gmail.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Some of the Powkiddy devices switched to using a different vendor for
the vdd_cpu regulator. Unfortunately the device does not have a new
revision to denote this, so users have no way of knowing in advance.

Add code to detect if a device is present at addresses 0x1c or 0x40 on
the i2c0 bus and update the devicetree if needed.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 147 +++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 224019f9ba3..c1d1826fd14 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -43,6 +43,7 @@ struct rg3xx_model {
 	const char *board_name;
 	const char *fdtfile;
 	const bool detect_panel;
+	const bool detect_regulator;
 	const bool uart_con;
 };
 
@@ -69,6 +70,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		/* Device is identical to RG353P. */
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
 		.detect_panel = 1,
+		.detect_regulator = 0,
 		.uart_con = 1,
 	},
 	[RG353P] = {
@@ -77,6 +79,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Anbernic RG353P",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
 		.detect_panel = 1,
+		.detect_regulator = 0,
 		.uart_con = 1,
 	},
 	[RG353V] = {
@@ -85,6 +88,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Anbernic RG353V",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353v.dtb",
 		.detect_panel = 1,
+		.detect_regulator = 0,
 		.uart_con = 1,
 	},
 	[RG503] = {
@@ -93,6 +97,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Anbernic RG503",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
 		.detect_panel = 0,
+		.detect_regulator = 0,
 		.uart_con = 1,
 	},
 	[RGB30] = {
@@ -101,6 +106,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Powkiddy RGB30",
 		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb30.dtb",
 		.detect_panel = 0,
+		.detect_regulator = 1,
 		.uart_con = 0,
 	},
 	[RK2023] = {
@@ -109,6 +115,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Powkiddy RK2023",
 		.fdtfile = DTB_DIR "rk3566-powkiddy-rk2023.dtb",
 		.detect_panel = 0,
+		.detect_regulator = 1,
 		.uart_con = 0,
 	},
 	[RGARCD] = {
@@ -117,6 +124,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Anbernic RG ARC-D",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-d.dtb",
 		.detect_panel = 0,
+		.detect_regulator = 0,
 		.uart_con = 1,
 	},
 	[RGB10MAX3] = {
@@ -125,6 +133,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Powkiddy RGB10MAX3",
 		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb10max3.dtb",
 		.detect_panel = 0,
+		.detect_regulator = 1,
 		.uart_con = 0,
 	},
 	/* Devices with duplicate ADC value */
@@ -134,6 +143,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Anbernic RG353PS",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353ps.dtb",
 		.detect_panel = 1,
+		.detect_regulator = 0,
 		.uart_con = 1,
 	},
 	[RG353VS] = {
@@ -142,6 +152,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Anbernic RG353VS",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353vs.dtb",
 		.detect_panel = 1,
+		.detect_regulator = 0,
 		.uart_con = 1,
 	},
 	[RGARCS] = {
@@ -150,6 +161,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Anbernic RG ARC-S",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-s.dtb",
 		.detect_panel = 0,
+		.detect_regulator = 0,
 		.uart_con = 1,
 	},
 };
@@ -172,6 +184,22 @@ static const struct rg353_panel rg353_panel_details[] = {
 	},
 };
 
+struct powkiddy_regulators {
+	const u8 addr;
+	const char *regulator_compat;
+};
+
+static const struct powkiddy_regulators regulator_details[] = {
+	{
+		.addr = 0x1c,
+		.regulator_compat = "tcs,tcs4525",
+	},
+	{
+		.addr = 0x40,
+		.regulator_compat = "fcs,fan53555",
+	},
+};
+
 /*
  * Start LED very early so user knows device is on. Set color
  * to red.
@@ -361,6 +389,44 @@ int rgxx3_detect_display(void)
 	return 0;
 }
 
+/*
+ * Some of the Powkiddy devices switched the CPU regulator, but users
+ * are not able to determine this by looking at their hardware.
+ * Attempt to auto-detect this situation and fixup the device-tree.
+ */
+int rgxx3_detect_regulator(void)
+{
+	struct udevice *bus;
+	struct udevice *chip;
+	u8 val;
+	int ret;
+
+	/* Get the correct i2c bus (i2c0). */
+	ret = uclass_get_device_by_name(UCLASS_I2C,
+					"i2c@fdd40000", &bus);
+	if (ret)
+		return ret;
+
+	/*
+	 * Check for all vdd_cpu regulators and read an arbitrary
+	 * register to confirm it's present.
+	 */
+	for (int i = 0; i < ARRAY_SIZE(regulator_details); i++) {
+		ret = i2c_get_chip(bus, regulator_details[i].addr,
+				   1, &chip);
+		if (ret)
+			return ret;
+
+		ret = dm_i2c_read(chip, 0, &val, 1);
+		if (!ret) {
+			env_set("vdd_cpu", regulator_details[i].regulator_compat);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int rgxx3_read_board_id(void)
 {
 	u32 adc_info;
@@ -485,6 +551,16 @@ int rk_board_late_init(void)
 			printf("Failed to detect panel type\n");
 	}
 
+	/*
+	 * Skip vdd_cpu regulator detection if not needed. Warn but
+	 * don't fail for errors in auto-detection of regulator.
+	 */
+	if (rg3xx_model_details[gd->board_type].detect_regulator) {
+		ret = rgxx3_detect_regulator();
+		if (ret)
+			printf("Unable to detect vdd_cpu regulator\n");
+	}
+
 end:
 	/* Turn off red LED and turn on orange LED. */
 	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | GPIO_C6,
@@ -547,6 +623,71 @@ int rgxx3_panel_fixup(void *blob)
 	return 0;
 }
 
+int rgxx3_regulator_fixup(void *blob)
+{
+	const struct powkiddy_regulators *vdd_cpu = NULL;
+	int node, ret, i;
+	char path[] = "/i2c@fdd40000/regulator@00";
+	char name[] = "regulator@00";
+	char *env;
+
+	env = env_get("vdd_cpu");
+	if (!env) {
+		printf("Can't get vdd_cpu env\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Find the device we have in our tree, which may or may not
+	 * be present.
+	 */
+	for (i = 0; i < ARRAY_SIZE(regulator_details); i++) {
+		sprintf(path, "/i2c@fdd40000/regulator@%02x",
+			regulator_details[i].addr);
+		node = fdt_path_offset(blob, path);
+		if (node > 0)
+			break;
+
+		printf("Unable to find vdd_cpu\n");
+		return -ENODEV;
+	}
+
+	node = fdt_path_offset(blob, path);
+	if (!(node > 0)) {
+		printf("Can't find the vdd_cpu node\n");
+		return -ENODEV;
+	}
+
+	ret = fdt_node_check_compatible(blob, node, env);
+	if (ret < 0)
+		return -ENODEV;
+
+	/* vdd_cpu regulators match, return 0. */
+	if (!ret)
+		return 0;
+
+	/* Regulators don't match, search by first compatible value. */
+	for (i = 0; i < ARRAY_SIZE(regulator_details); i++) {
+		if (!strcmp(env, regulator_details[i].regulator_compat)) {
+			vdd_cpu = &regulator_details[i];
+			break;
+		}
+	}
+
+	if (!vdd_cpu) {
+		printf("Unable to identify vdd_cpu by compat string\n");
+		return -ENODEV;
+	}
+
+	/* Set the compatible and reg with the auto-detected values */
+	fdt_setprop_string(blob, node, "compatible", vdd_cpu->regulator_compat);
+	fdt_setprop_u32(blob, node, "reg", vdd_cpu->addr);
+	sprintf(name, "regulator@%02x", vdd_cpu->addr);
+	fdt_set_name(blob, node, name);
+
+	return 0;
+}
+
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	int ret;
@@ -562,6 +703,12 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 			printf("Unable to update panel compat\n");
 	}
 
+	if (rg3xx_model_details[gd->board_type].detect_regulator) {
+		ret = rgxx3_regulator_fixup(blob);
+		if (ret)
+			printf("Unable to update vdd_cpu compat\n");
+	}
+
 	return 0;
 }
 
-- 
2.34.1

