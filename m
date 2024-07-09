Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EA6C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B77A885F6;
	Tue,  9 Jul 2024 11:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dzNFmZ1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15708885CC; Tue,  9 Jul 2024 11:35:10 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A895D886CE
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a77b60cafecso570680466b.1
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517707; x=1721122507; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RBwBcET8BoyMM0P8CNTV/SJuAqIlGkLGRF8O7GP42xg=;
 b=dzNFmZ1CU8jW94is8FYeZC7+K6btuSddufeC44cYUrG75DkX0WyA4dtQ2slRQirT5j
 0/bvSQqQiT7SWOTxTeFvoCic6VNCKkDeq0GCYeLNfYvQfKURW8J1s+PCZ4VsK4vXgVCr
 3mIVEWBvnrx4wubDFLXI3DZIHtSk1t4TjAeLynTg6IUE/HWWJpr0E7iijG2UW2MzicXp
 x6+Z2pomsxk7bmETy3JS2AWy2V2xr6InY9U/sQOxFDvVIatza5eUzdynyf9ZoPABPQTQ
 Jlnv+VQORiESMug6PL8/bXnBpKnyn2oFbTGkiaStM+g7/TEONuV26l683O23qLGbSzKH
 DsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517707; x=1721122507;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBwBcET8BoyMM0P8CNTV/SJuAqIlGkLGRF8O7GP42xg=;
 b=advVGhHnLaLkQKx+e+Hy/Yy1ZJVowXJaawTGpSA0qJCyGEh3eGL77JiueGVm1fzsap
 v+Ba0Bz4hZ4xU9PzNzNcYo/67F76h8wo3cWkRBKPg4Z04lNLG+4F1lxOeC8egmJwD4Z9
 vXEUn/7BIuqWooxnpvlzsBxk9kvT0kTJ6pL7lbRA3JjCi4VeQ5CNmJIrX7vmGyO+1+Hs
 SBuytMl44gtrZozdCt1S/aFBEVM+3/EuDP6CAoL09tTFACdxYYzw4kKtdmSc6Msdk7vM
 3z1zNyP3pJ4y3LVop61ukzj3pCDYZG+ZqNw5PFy2M9XDZXTYLRN3LSS7qdB9MYRVQ1wm
 zKSg==
X-Gm-Message-State: AOJu0YyU2deV89HICEvBYEAXO/mVwPvfhSyN77ZmnOGLUgY+57X04fQQ
 SNMCBBrl+/2mcsdGeYGK+HitzTSY1ipmymMXDNss55uXGthab+K/KtsoSefBWds=
X-Google-Smtp-Source: AGHT+IH7Bd7pXHv+XnXTq1lTmjFVuCTHfUJlJCJUyyHk11EnlM9xSreAnamEylAyLRTOTg+VNKzXFg==
X-Received: by 2002:a17:906:2706:b0:a6f:1d90:3415 with SMTP id
 a640c23a62f3a-a780b6b1641mr120767766b.17.1720517707137; 
 Tue, 09 Jul 2024 02:35:07 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:35:06 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:48 +0200
Subject: [PATCH v4 20/21] power: regulator: qcom-rpmh-regulator: adjust
 probe for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-20-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5716;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=LONXjJ7wID4Oryn6RY7Yogltd+UBv3ebxxDP6o/rqB4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQ1mMQT3ZiiyJG8o73VK/1m8yWxD7poOe6gh
 lu66CYSphGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0ENQAKCRAFgzErGV9k
 tijAD/kBcN7RDipmaA/VOcxVYA7grn+RexRNLXHfgjG3DU8yCQXkEaoKbvkn4w4r5KyhcQRcoTg
 BhH8/0s+rjyJ2TG7frS2Hgb/EvriOxih1CIxHluelgrq9Uq0xX9HdJTWrJvvrXh2/mIqd5GbUaf
 dlcSoMk37vWIPaB6H3O4bWERAoNM9uXIlC/5kbm1qBiWahIIzk/WNfRvsMwKQUZuANSSjxOdDKs
 Ov/1rPvP1j0EI9GxyUzQkG7aicDhocgrDGlkNmyAxKyLnTzR/nVh60/y6QWGJSXa5hXi3on0xqY
 iixLTm2jPVaoje+FMceXojqaxcW52ThrSCjNfcMLke65K646aEzPtzpuIZ9Om4QsVUusraqoSrL
 ssG2y/olo9Eg78owtWEuzeu/RIIPT4G02rHpA3iAlv9LuOxr0z3ul+JS9m8/VqDFR044ijfBpzz
 nOjTYuHv54a8g9wQfs/Zk7orJpAitiwXSjy51Qntkc51haGRR6Y0mSngdTeCfljC+/wCUjY0IrR
 QdhjjsGD3UPlepWXP2A+Gjk6+ZISVXQ8Oe9XKrsVBTzstrcpI7VAJttN/f5m81y29bH0p+z27Oy
 yAK/WUM72xJt2LgtlnpQn4jkN/GtrY117vJxJj+6juZBPCD/hBwZjZznVG/hG4GsL1aPs8x9Ddh
 HtqSDHec8Z8u5Dg==
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

