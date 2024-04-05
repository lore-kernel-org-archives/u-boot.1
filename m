Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA27CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF238884BF;
	Fri,  5 Apr 2024 10:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ndHyd16J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CAF5884BC; Fri,  5 Apr 2024 10:27:33 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3545884B6
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4162c2107d3so8048075e9.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712305650; x=1712910450; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jBSNxz5F9Gk1/5Z3CGIi5kb5sg8VWXyRTlXhpfzbQLI=;
 b=ndHyd16JbaI6suCq7VbipjO1nL8myU7IV/YHiQeldjlBmkWTxpGwR8Kd0nzoJ0BoJL
 8xN/Y+Qk+0H1TFZQSD1K0KzIGY1i7rLznPHuUKsKArifOOKK3F7pL05TvZHZFx7VviSz
 wD285IajOT+PhSOD+TdHuvGQbTRKUnZncz7TdWE/THJm67hBJsjvrg3S0FXOv5jEx/1Z
 JIPlOrREGIOLp7EN2e2I+U/DB9A2G/YLJFW0UaL69EVyYLKR2Zjd1imkUjHVke06GgDz
 M/NesiaJzXeOhbm8AO7mGHHxFOkvvojd2N2UHPKzsi6OSmd0JwnMYeamg+EzHt/OFL+s
 ZQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305650; x=1712910450;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBSNxz5F9Gk1/5Z3CGIi5kb5sg8VWXyRTlXhpfzbQLI=;
 b=uQDYojqcaWjUpZdbya9xEzxsgMgmyOUfd0DSKJo2oVKI2yK+4PJ3S4biK8o2gW5nGm
 9Nrm8eXMADrsVPpKv6pVVoVWcfXhx6rHgAQEUAlufculnRE3PiJPcpqkloh24eC8Z9jM
 5XXfKZq0qiY514JL7nYWq1oB8Dp2areGzurLKB0ZwJHtAQgm2gwrrSA57rLerNNBBSPQ
 7OamASqZ77MRUxNRnSeupp1K6dmzWrQuMtOHduXpPss4OcUujpP/R3BFEQ7P4P7nL5te
 R/P8Z9mQi2uAHzXyV+q86fTtI/63q0z8/RUS3tfB3E6UXJo1lHKmewJiOeWPQeGjzDKV
 Mnag==
X-Gm-Message-State: AOJu0YzAGA8+vBJvw1nJwf1gDclvE9TUCz1eJaVo6096YnD+kfbwhuAK
 08v/IMI7162jvJa9D/n8Wrbz/RvJtbSutXdMbl7iuoDBMRsT6XGNl1eT/9XXht8=
X-Google-Smtp-Source: AGHT+IEYdMBy84w25wLJeetOMsXoL6E6tnojjiC3y3woNq2DjYO+K3eFAFYOd8IcQv3yl7uaQPohng==
X-Received: by 2002:a05:600c:1e13:b0:416:321d:e124 with SMTP id
 ay19-20020a05600c1e1300b00416321de124mr213163wmb.41.1712305649902; 
 Fri, 05 Apr 2024 01:27:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a05600c45cb00b004162d06768bsm2721593wmo.21.2024.04.05.01.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:27:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:27:25 +0200
Subject: [PATCH 2/3] button: qcom-pmic: move node name checks to btn_data
 struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-spmi-clients-v1-2-c28603ebcf18@linaro.org>
References: <20240405-topic-sm8x50-spmi-clients-v1-0-c28603ebcf18@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-spmi-clients-v1-0-c28603ebcf18@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4681;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JuJX938A0kKhn4aUDQEOACwit9CMWv30OBUpj8p+Arg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7XuUBZtZJzHN5zwN0xo0PMd+0M9JPa7CF0hUHtc
 KTZ9IaCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+17gAKCRB33NvayMhJ0YK3EA
 Cdjup1HYiCHQlRNfsU2y7ZEVl8r8SCSPyhGNc47511KOmPx+Pw1bJjghjSSKF/HjWXPIWzXADchXAF
 uLlz4fE1yofPcBU251M/siuV24ThnPnnvnHDxrKTWWr7wXytIEvoF6HXcdsFwbbgzCkfKNt63vloKK
 Z8dS1+pswON8UJRik0WAKdOx/V6XRUDcWUjWJco0GKW9HOvcitRpPg9Ih4ceRBCv7dwBfdTNUZoEHY
 RgEF86HdYjS6BX5Le3c0FhnF+k8UbiWJrKKY8CSBTZ7HEzdBmnw+uhXkmXdBzVqtMwqhtQG2fztcJ8
 SiH/VH0pErLfhTDfm4AYPFgpUoj5KakzF8SjqvQDma7HfrgTbshxbxJUlPbZCY7bhHFm9/8HLziThv
 i8I6+FcP1GuiCjoqIPsUuzrcAl+Yj2GoLDKoPWSvoDxuukOMrSUqb5NYtmNe74a9QCWGhZFLUMkPJn
 2VmmIumTBAfrtMiSEOt6PPSv7HG5LURBzwvZElcs/amob9WBFt7INRH/M/PHXZqKReOUUmTMLmVsbT
 xvl71fONnw9J1ys8y4dRMoj9V4u7Lo1hTcPNjXwXKPb0dP41kgYUHnIp+JWubTkHC9FUtXKZO3Ngzb
 jMqsHVsytnXX6dIyBhhRHhDGONyil8k4fZDsolS1a/u0BVJI59mujpqyLz/A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Move node name checks to a proper data struct with all information
for the supported subnodes.

Replace the key offset defines with the Linux driver ones.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/button/button-qcom-pmic.c | 84 ++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index bad445efa86..f6da958097c 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -19,6 +19,13 @@
 #define REG_TYPE		0x4
 #define REG_SUBTYPE		0x5
 
+struct qcom_pmic_btn_data {
+	char *compatible;
+	unsigned int status_bit;
+	int code;
+	char *label;
+};
+
 struct qcom_pmic_btn_priv {
 	u32 base;
 	u32 status_bit;
@@ -27,11 +34,8 @@ struct qcom_pmic_btn_priv {
 };
 
 #define PON_INT_RT_STS                        0x10
-#define KPDPWR_ON_INT_BIT                     0
-#define RESIN_ON_INT_BIT                      1
-
-#define NODE_IS_PWRKEY(node) (!strncmp(ofnode_get_name(node), "pwrkey", strlen("pwrkey")))
-#define NODE_IS_RESIN(node) (!strncmp(ofnode_get_name(node), "resin", strlen("resin")))
+#define  PON_KPDPWR_N_SET		0
+#define  PON_RESIN_N_SET		1
 
 static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
 {
@@ -52,10 +56,39 @@ static int qcom_pwrkey_get_code(struct udevice *dev)
 	return priv->code;
 }
 
+static const struct qcom_pmic_btn_data qcom_pmic_btn_data_table[] = {
+	{
+		.compatible = "qcom,pm8941-pwrkey",
+		.status_bit = PON_KPDPWR_N_SET,
+		.code = KEY_ENTER,
+		.label = "pwrkey",
+	},
+	{
+		.compatible = "qcom,pm8941-resin",
+		.status_bit = PON_RESIN_N_SET,
+		.code = KEY_DOWN,
+		.label = "vol_down",
+	},
+};
+
+static const struct qcom_pmic_btn_data *button_qcom_pmic_match(ofnode node)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qcom_pmic_btn_data_table); ++i) {
+		if (ofnode_device_is_compatible(node,
+						qcom_pmic_btn_data_table[i].compatible))
+			return &qcom_pmic_btn_data_table[i];
+	}
+
+	return NULL;
+}
+
 static int qcom_pwrkey_probe(struct udevice *dev)
 {
 	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
+	const struct qcom_pmic_btn_data *btn_data;
 	ofnode node = dev_ofnode(dev);
 	int ret;
 	u64 base;
@@ -64,6 +97,14 @@ static int qcom_pwrkey_probe(struct udevice *dev)
 	if (!uc_plat->label)
 		return 0;
 
+	/* Get the data for the node compatible */
+	btn_data = button_qcom_pmic_match(node);
+	if (!btn_data)
+		return -EINVAL;
+
+	priv->status_bit = btn_data->status_bit;
+	priv->code = btn_data->code;
+
 	/* the pwrkey and resin nodes are children of the "pon" node, get the
 	 * PMIC device to use in pmic_reg_* calls.
 	 */
@@ -87,23 +128,10 @@ static int qcom_pwrkey_probe(struct udevice *dev)
 
 	ret = pmic_reg_read(priv->pmic, priv->base + REG_SUBTYPE);
 	if (ret < 0 || (ret & 0x7) == 0) {
-		printf("%s: unexpected PMCI function subtype %d\n", dev->name, ret);
+		printf("%s: unexpected PMIC function subtype %d\n", dev->name, ret);
 		return -ENXIO;
 	}
 
-	if (NODE_IS_PWRKEY(node)) {
-		priv->status_bit = 0;
-		priv->code = KEY_ENTER;
-	} else if (NODE_IS_RESIN(node)) {
-		priv->status_bit = 1;
-		priv->code = KEY_DOWN;
-	} else {
-		/* Should not get here! */
-		printf("Invalid pon node '%s' should be 'pwrkey' or 'resin'\n",
-		       ofnode_get_name(node));
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -114,12 +142,20 @@ static int button_qcom_pmic_bind(struct udevice *parent)
 	int ret;
 
 	dev_for_each_subnode(node, parent) {
+		const struct qcom_pmic_btn_data *btn_data;
 		struct button_uc_plat *uc_plat;
 		const char *label;
 
 		if (!ofnode_is_enabled(node))
 			continue;
 
+		/* Get the data for the node compatible */
+		btn_data = button_qcom_pmic_match(node);
+		if (!btn_data) {
+			debug("Unknown button node '%s'\n", ofnode_get_name(node));
+			continue;
+		}
+
 		ret = device_bind_driver_to_node(parent, "qcom_pwrkey",
 						 ofnode_get_name(node),
 						 node, &dev);
@@ -128,15 +164,7 @@ static int button_qcom_pmic_bind(struct udevice *parent)
 			return ret;
 		}
 		uc_plat = dev_get_uclass_plat(dev);
-		if (NODE_IS_PWRKEY(node)) {
-			uc_plat->label = "pwrkey";
-		} else if (NODE_IS_RESIN(node)) {
-			uc_plat->label = "vol_down";
-		} else {
-			debug("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
-			       ofnode_get_name(node));
-			device_unbind(dev);
-		}
+		uc_plat->label = btn_data->label;
 	}
 
 	return 0;

-- 
2.34.1

