Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D83C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9BA18889C;
	Mon, 15 Jul 2024 12:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CrNiPCpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E84488873; Mon, 15 Jul 2024 12:08:57 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633C988655
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a77e6dd7f72so494259166b.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038135; x=1721642935; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ykNwaqwHkPIApVOJLoxhbPlmMoTloM+XmuakNGCqPoo=;
 b=CrNiPCpNdJStWokfG2y+IluHDvMeTPo7TwfZw9I6wY1a5FXCIpmaryZQ5BRAOb4mdV
 n7PvQe3eaeXim8NQ0XPt/WI1RiS493ZM2GUjp+1WtgPwTv/CsGC3dsiDtBGFsqp51muz
 LxC1ns5CIDEJIjqkyfNYHrooogeTFuu4S0i9gNShejiae2IbGlXnOZ+rDeU1ZSwX+3Da
 iQVE0XUGYZR6189Cd+w5bdTQ0NnXVDsKqLyAYb7+sml6f2nfdYDMJAF0+yjM9cotKy33
 OjoMxGrRDOupm734vnEIi+6zSRp8ii7JzXi/OSQI2IKL4FZvIg9+Ip+ikkIUQUPf9wZl
 TH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038135; x=1721642935;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykNwaqwHkPIApVOJLoxhbPlmMoTloM+XmuakNGCqPoo=;
 b=IWbbYUUQ1Z2729POefH8ebZRnqJvfoMKrv2DfJF9C5Gd7/zyf8rEy9R98HwOMYhhpm
 zeAytwpamTinaA3uj2Xo3knZLjcir92SX54pWNVbuhgpaCqegnctIPpePyNEMBpQXPTB
 zUSZiuoP9KkYziktxdiz2FJ0EJlAs2zoHOmqPpmJ492alVsfGJv8xlEoakPEwFdDistV
 3tdzIElsqVZtXRXDh0HwD5KEhumZ/3iwD3EWsq/rFTK/UbpvE9P8YpxxFnttMrjABnlM
 xBBEB5kXse53KpN0JoeP4WyjNQqGYFizxX1IWkdvoabLLw6M9MWCtl2Q2ud7o4SndkIG
 ptdg==
X-Gm-Message-State: AOJu0YyI49dXo2DaY3yM3mRW5t0sz0TKOmvxYq4sz65V6rffgSUvDKBH
 XatZ3hUeuXNKgKcQ+7+QfO0BjYMYWjxk8+MBYyRqEuoRyOIB49JZULL9s0+/HfA=
X-Google-Smtp-Source: AGHT+IEOWXdxPtux9KaWCqDz5o2Md+KM8H0nSYAdFqTHm7nnJlfKqfqx40LeWsYFE6KYNKlpaG4qrg==
X-Received: by 2002:a17:906:7d1:b0:a6f:e47d:a965 with SMTP id
 a640c23a62f3a-a780b6ff0ecmr1178911266b.41.1721038134903; 
 Mon, 15 Jul 2024 03:08:54 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:21 +0200
Subject: [PATCH v6 22/24] power: regulator: qcom-rpmh-regulator: adjust
 probe for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-22-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5762;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=w5wfaxbbfnG/DU1q1d1PAsyrg5lHl41WCxBF+lLEiQs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUHmNUevwISHw+h3WpELnzo/Tl72K6ZpVCjn
 jVnaIAFUnKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BwAKCRAFgzErGV9k
 tj5vD/0TttS8q1iwDNF7Knm8e7+FaBxfb0dA/yWpqFPondoKd+jXjSg5TQMcIZBJRhEt0myOGsJ
 XerUbK70trXfTYFBRW4eKTwujU1WPE7abLOEfp7Yqv9S1Mf9xEWwxGXWYwx+ObZQ0OLoJQ/d1FV
 770wj7Rml5YE5DhiGVbBL5sogJtznFq+5Y84JZ2Y1mBYpMcMG2uUsI/3wOX4fGpkl33cziiaDym
 i9uC973VQ55dBWYuu9KZ9vHaZrRo4oq0MKn9L9hnIgMGY7Ihtgk4RFQ2vmXTlcyuFZMU3RX5ctU
 5K3NkkacyXjHkMp+A5ZgLKWgeZhzSkir9eWN/8VANjsjn5t9I13alvJztQNkuX5Ba+UFKrtdIch
 C/MkJ9PYnboGjzn37uXuThFUF8Lgzxa54Xj/e6mUNCpPGOXyuuuyiLxZbX8TfrEkOdYqxo6tzhF
 h/39B58xTmT0LkXrKZmzULRfI80MNtiZLrSRrAQIAfYe0jFUu04xf11MhdBaxtDaX47zAuSiVZM
 dTo8EVByZdI4YB3zACovFqTGzfsEHgOFpKFQuAb6FOHhzV+PpnsprPFZdaB/+l3MnM96nUowUD4
 nuGGX7IIXdw3zuDMLGMpD/qaQYhesr8VT+w5ejQ9QMMGPPPVlnFpRerMc01O3wuoxuIknKrIYJH
 M0r46QFdhd4nT4Q==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Refactor initialization to use U-Boot's driver model and API.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 136 +++++++++++++++++++-------
 1 file changed, 102 insertions(+), 34 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index b716b380c148..06fd3f31956f 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -411,66 +411,134 @@ static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
 	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
 	{}
 };
 
-static int rpmh_regulator_probe(struct platform_device *pdev)
+/* probe an individual regulator */
+static int rpmh_regulator_probe(struct udevice *dev)
 {
-	struct device *dev = &pdev->dev;
-	const struct rpmh_vreg_init_data *vreg_data;
-	struct device_node *node;
-	struct rpmh_vreg *vreg;
-	const char *pmic_id;
-	int ret;
+	const struct rpmh_vreg_init_data *init_data;
+	struct rpmh_vreg *priv;
+	struct dm_regulator_uclass_plat *plat_data;
 
-	vreg_data = of_device_get_match_data(dev);
-	if (!vreg_data)
+	init_data = (const struct rpmh_vreg_init_data *)dev_get_driver_data(dev);
+	priv = dev_get_priv(dev);
+	plat_data = dev_get_uclass_plat(dev);
+
+	priv->dev = dev;
+	priv->addr = cmd_db_read_addr(dev->name);
+	if (!priv->addr) {
+		dev_err(dev, "Failed to read RPMh address for %s\n", dev->name);
 		return -ENODEV;
-
-	ret = of_property_read_string(dev->of_node, "qcom,pmic-id", &pmic_id);
-	if (ret < 0) {
-		dev_err(dev, "qcom,pmic-id missing in DT node\n");
-		return ret;
 	}
 
-	for_each_available_child_of_node(dev->of_node, node) {
-		vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
-		if (!vreg) {
-			of_node_put(node);
+	priv->hw_data = init_data->hw_data;
+	priv->enabled = -EINVAL;
+	priv->uv = -ENOTRECOVERABLE;
+	if (ofnode_read_u32(dev_ofnode(dev), "regulator-initial-mode", &priv->mode))
+		priv->mode = -EINVAL;
+
+	plat_data->mode = priv->hw_data->pmic_mode_map;
+	plat_data->mode_count = priv->hw_data->n_modes;
+
+	return 0;
+}
+
+/* for non-drm, xob, or bypass regulators add additional driver definitions */
+U_BOOT_DRIVER(rpmh_regulator_drm) = {
+	.name = "rpmh_regulator_drm",
+	.id = UCLASS_REGULATOR,
+	.probe = rpmh_regulator_probe,
+	.priv_auto = sizeof(struct rpmh_vreg),
+	.ops = &rpmh_regulator_vrm_drms_ops,
+};
+
+/* This driver intentionally only supports a subset of the available regulators.
+ * This function checks to see if a given regulator node in DT matches a regulator
+ * defined in the driver.
+ */
+static const struct rpmh_vreg_init_data *
+vreg_get_init_data(const struct rpmh_vreg_init_data *init_data, ofnode node)
+{
+	const struct rpmh_vreg_init_data *data;
+
+	for (data = init_data; data->name; data++) {
+		if (!strcmp(data->name, ofnode_get_name(node)))
+			return data;
+	}
+
+	return NULL;
+}
+
+static int rpmh_regulators_bind(struct udevice *dev)
+{
+	const struct rpmh_vreg_init_data *init_data, *data;
+	const char *pmic_id;
+	char *name;
+	struct driver *drv;
+	ofnode node;
+	int ret;
+	size_t namelen;
+
+	init_data = (const struct rpmh_vreg_init_data *)dev_get_driver_data(dev);
+	if (!init_data) {
+		dev_err(dev, "No RPMh regulator init data\n");
+		return -ENODEV;
+	}
+
+	pmic_id = ofnode_read_string(dev_ofnode(dev), "qcom,pmic-id");
+	if (!pmic_id) {
+		dev_err(dev, "No PMIC ID\n");
+		return -ENODEV;
+	}
+
+	drv = lists_driver_lookup_name("rpmh_regulator_drm");
+
+	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+		data = vreg_get_init_data(init_data, node);
+		if (!data)
+			continue;
+
+		/* %s is replaced with pmic_id, so subtract 2, then add 1 for the null terminator */
+		namelen = strlen(data->resource_name) + strlen(pmic_id) - 1;
+		name = devm_kzalloc(dev, namelen, GFP_KERNEL);
+		ret = snprintf(name, namelen, data->resource_name, pmic_id);
+		if (ret < 0 || ret >= namelen) {
+			dev_err(dev, "Failed to create RPMh regulator name\n");
 			return -ENOMEM;
 		}
 
-		ret = rpmh_regulator_init_vreg(vreg, dev, node, pmic_id,
-						vreg_data);
+		ret = device_bind_with_driver_data(dev, drv, name, (ulong)data,
+						   node, NULL);
 		if (ret < 0) {
-			of_node_put(node);
+			dev_err(dev, "Failed to bind RPMh regulator %s: %d\n", name, ret);
 			return ret;
 		}
 	}
 
 	return 0;
 }
 
-static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
+static const struct udevice_id rpmh_regulator_ids[] = {
 	{
 		.compatible = "qcom,pm8150-rpmh-regulators",
-		.data = pm8150_vreg_data,
+		.data = (ulong)pm8150_vreg_data,
 	},
 	{
 		.compatible = "qcom,pm8150l-rpmh-regulators",
-		.data = pm8150l_vreg_data,
+		.data = (ulong)pm8150l_vreg_data,
 	},
-	{}
+	{ /* sentinal */ },
 };
-MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
 
-static struct platform_driver rpmh_regulator_driver = {
-	.driver = {
-		.name = "qcom-rpmh-regulator",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table	= of_match_ptr(rpmh_regulator_match_table),
-	},
-	.probe = rpmh_regulator_probe,
+/* Driver for a 'bank' of regulators. This creates devices for each
+ * individual regulator
+ */
+U_BOOT_DRIVER(rpmh_regulators) = {
+	.name = "rpmh_regulators",
+	.id = UCLASS_MISC,
+	.bind = rpmh_regulators_bind,
+	.of_match = rpmh_regulator_ids,
+	.ops = &rpmh_regulator_vrm_drms_ops,
 };
-module_platform_driver(rpmh_regulator_driver);
 
 MODULE_DESCRIPTION("Qualcomm RPMh regulator driver");
 MODULE_LICENSE("GPL v2");

-- 
2.45.2

