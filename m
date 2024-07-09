Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B53DC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFCFD886B3;
	Tue,  9 Jul 2024 11:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nGcInr/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2E9885CC; Tue,  9 Jul 2024 11:35:09 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF20D886B6
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77c4309fc8so524785566b.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517706; x=1721122506; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9hN6xx7rCnIFAk/dufHNT+pnJK99S8OjMGWnvm5rk54=;
 b=nGcInr/k9E50LUysPcCpD9HxjgE8IA+vjHwK2cqHvJrFYJsDhLfuKKH82NPF2OECpU
 uodKlaRgr6iSfVYj0LVg0ZCH3jv+hCNnzd5l5KiAM+6UPXR1/8BhvjuAGrJYZDXbwF95
 9KJvse7IXONi82jEXfJ5Np21VSwu40tVGIEH4rGkyoNFeYsOrEpeKIFV25yuNmXAyCyP
 gixqjoz1Hd2xI/wSKutPFewFxV+Slrxc/XAEBlRfQqUv6ldni0OyRSnIf/ErlIiHiypt
 zZo1KUDaMEiUx0ZFOLZcy3cUduO54RcGkHbo1DkmtYkDh1yzJjLY96U9NDkrQlAlKsnz
 0koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517706; x=1721122506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9hN6xx7rCnIFAk/dufHNT+pnJK99S8OjMGWnvm5rk54=;
 b=gLgwhbdcrHdie21dH+DmHImOXlOglljQuvAjF2K9cEHECrq56qbmh6h8scivgmQ4l7
 jswcRPbjVE2IsKB+UA94YUoXPdNgO5ejOgmipbAMxp08DN4UM9wDVMjexdQ7l4TWFn60
 ho4toNsVjqFdGXZFsvav8hI31FJ74GpEIebqFJJn4aRPf0JnPAU9RN8cKZOj9sxF7Y3Y
 XUiu0juEhZa8uYMKgZBq1LLalp+YaBeujJl3vEajTe9o7SD4Areu800yq6f0CY6+Dco6
 +T8vj/bpGQAjWqf/TqQuuCaFwAN3YczVEwKAq/V8+jerhOqV4dbCBGhpuNPzenIIrMS8
 PtEw==
X-Gm-Message-State: AOJu0Yyc4pTpP9eogL4XtgS+dAVX357LZ7kKp7WFNf/vU2OoNbkclfqn
 u9UWMsziobl4l8Eek3hYgm+6Z3NatPE8wRApJ5fsAVCLX4fKbQ6QrFmljjKKjnU=
X-Google-Smtp-Source: AGHT+IG3uH2e+WN0mgiA7dOc22qqu1MzQCSsI0C4V1H3fMUT4VyI7/oSReaCPNjUtmetLsDm9J0vBQ==
X-Received: by 2002:a17:906:7107:b0:a72:40b4:c845 with SMTP id
 a640c23a62f3a-a780b8833ffmr140535366b.51.1720517706237; 
 Tue, 09 Jul 2024 02:35:06 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:35:05 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:47 +0200
Subject: [PATCH v4 19/21] power: regulator: qcom-rpmh-regulator: port ops
 to U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-19-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9384;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Am80XToELQMLXxIQ7fPME3fWiFx5pYpjlALqf43SioI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQ0nYgkksDGAu3VV0Q9N8iRPrHYYdmeB7OvL
 1JTOFKp7ASJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0ENAAKCRAFgzErGV9k
 tmoeD/95Ftzyr5XxMPP3sKmlgO8Wnjoq7jB+n/xCJBh2xLKan0djmCXga6GMUCtrP5R00VD56ZY
 84mHwNMt+UCzGph9ZAE5JT0Ku2eEQYhm9gYKPoNGWmVkPV+TkCTayWyxy1o9MgjyAw49RuKKtbu
 jNqgyp6c9JfWHZz3XBDTL/j/XxsbzjtJiBqCnWLaJ9n4TtJLhGVAvljarGR3HSWMy92oipC6Cyl
 gGgu06yBL79sUyW8E9eQpCf04G3zfFtEw+ewCwrfTC5o0hFSWRWwRpQexNm+ynhFH+b+FuDYFtc
 H1u4pH7UDr8BOQZT0WbHPspfWQeWAH/WjSlDuIn8gpfOVe8SB3dijAzaqCpsprr/HvVN+v0LZDJ
 +UVV7B4QXkGLW9HrKDHy7W8f/nmNDpzXSLkioBEYrt/+K0oB7onZGdrDZXHlpfyI2djORWDQK6R
 hl5S8Abk9uHk55nOeqogQprRjnxzk/MBe9vVcTznSQ0ApSaR9FRAC6Nq9a3gwB2sdJjkjzL1Yar
 n5/+s3cWRtK7Y229cGl63i8tmE2NY+mB30aF2KhLkeWlRRVoZiUv80lHoE6jdgnOowgc45oGlzQ
 aSmmsCoAtJDB5n/iEBFxaeVpQcvhHUMaI4q8xLng+ze/CI7r/vPZV1FBIFQvxa3u9dR07sK9rYf
 0F3LlyqxqrIqDkQ==
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

Port over the regulator ops to U-Boot's regulator API. Add back the
pmic5 mode map using U-Boot dm_regulator_mode API and adjust the
pmic5_pldo and pmic5_pldo_lv definitions. No functional changes.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 158 ++++++++++++++------------
 1 file changed, 87 insertions(+), 71 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 2a8e8f9ac444..b716b380c148 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -192,87 +192,96 @@ struct rpmh_vreg_init_data {
  *
  * Return: 0 on success, errno on failure
  */
 static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
-			struct tcs_cmd *cmd, bool wait_for_ack)
+				       const struct tcs_cmd *cmd, bool wait_for_ack)
 {
 	int ret;
 
 	if (wait_for_ack || vreg->always_wait_for_ack)
-		ret = rpmh_write(vreg->dev, RPMH_ACTIVE_ONLY_STATE, cmd, 1);
+		ret = rpmh_write(vreg->dev->parent, RPMH_ACTIVE_ONLY_STATE, cmd, 1);
 	else
-		ret = rpmh_write_async(vreg->dev, RPMH_ACTIVE_ONLY_STATE, cmd,
-					1);
+		ret = rpmh_write_async(vreg->dev->parent, RPMH_ACTIVE_ONLY_STATE, cmd, 1);
 
 	return ret;
 }
 
-static int _rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
-				unsigned int selector, bool wait_for_ack)
+static int _rpmh_regulator_vrm_set_value(struct udevice *rdev,
+					 int uv, bool wait_for_ack)
 {
-	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
 	struct tcs_cmd cmd = {
 		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
 	};
 	int ret;
+	unsigned int selector;
 
-	/* VRM voltage control register is set with voltage in millivolts. */
-	cmd.data = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev,
-							selector), 1000);
+	selector = (uv - vreg->hw_data->voltage_range.min) / vreg->hw_data->voltage_range.step;
+	cmd.data = DIV_ROUND_UP(vreg->hw_data->voltage_range.min +
+				selector * vreg->hw_data->voltage_range.step, 1000);
 
 	ret = rpmh_regulator_send_request(vreg, &cmd, wait_for_ack);
 	if (!ret)
-		vreg->voltage_selector = selector;
+		vreg->uv = cmd.data * 1000;
 
 	return ret;
 }
 
-static int rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
-					unsigned int selector)
+static int rpmh_regulator_vrm_set_value(struct udevice *rdev,
+					int uv)
 {
-	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+
+	debug("%s: set_value %d (current %d)\n", rdev->name, uv, vreg->uv);
 
 	if (vreg->enabled == -EINVAL) {
 		/*
 		 * Cache the voltage and send it later when the regulator is
 		 * enabled or disabled.
 		 */
-		vreg->voltage_selector = selector;
+		vreg->uv = uv;
 		return 0;
 	}
 
-	return _rpmh_regulator_vrm_set_voltage_sel(rdev, selector,
-					selector > vreg->voltage_selector);
+	return _rpmh_regulator_vrm_set_value(rdev, uv,
+					uv > vreg->uv);
 }
 
-static int rpmh_regulator_vrm_get_voltage_sel(struct regulator_dev *rdev)
+static int rpmh_regulator_vrm_get_value(struct udevice *rdev)
 {
-	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
 
-	return vreg->voltage_selector;
+	debug("%s: get_value %d\n", rdev->name, vreg->uv);
+
+	return vreg->uv;
 }
 
-static int rpmh_regulator_is_enabled(struct regulator_dev *rdev)
+static int rpmh_regulator_is_enabled(struct udevice *rdev)
 {
-	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
 
-	return vreg->enabled;
+	debug("%s: is_enabled %d\n", rdev->name, vreg->enabled);
+
+	return vreg->enabled > 0;
 }
 
-static int rpmh_regulator_set_enable_state(struct regulator_dev *rdev,
-					bool enable)
+static int rpmh_regulator_set_enable_state(struct udevice *rdev,
+					   bool enable)
 {
-	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
 	struct tcs_cmd cmd = {
 		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
 		.data = enable,
 	};
 	int ret;
 
+	debug("%s: set_enable %d (current %d)\n", rdev->name, enable,
+	      vreg->enabled);
+
 	if (vreg->enabled == -EINVAL &&
-	    vreg->voltage_selector != -ENOTRECOVERABLE) {
-		ret = _rpmh_regulator_vrm_set_voltage_sel(rdev,
-						vreg->voltage_selector, true);
+	    vreg->uv != -ENOTRECOVERABLE) {
+		ret = _rpmh_regulator_vrm_set_value(rdev,
+						    vreg->uv, true);
 		if (ret < 0)
 			return ret;
 	}
 
@@ -282,47 +291,46 @@ static int rpmh_regulator_set_enable_state(struct regulator_dev *rdev,
 
 	return ret;
 }
 
-static int rpmh_regulator_enable(struct regulator_dev *rdev)
-{
-	return rpmh_regulator_set_enable_state(rdev, true);
-}
-
-static int rpmh_regulator_disable(struct regulator_dev *rdev)
-{
-	return rpmh_regulator_set_enable_state(rdev, false);
-}
-
 static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
-					unsigned int mode, bool bypassed)
+					      unsigned int mode, bool bypassed)
 {
 	struct tcs_cmd cmd = {
 		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
 	};
-	int pmic_mode;
+	struct dm_regulator_mode *pmic_mode;
+	int i;
 
-	if (mode > REGULATOR_MODE_STANDBY)
+	if (mode > REGULATOR_MODE_HPM)
 		return -EINVAL;
 
-	pmic_mode = vreg->hw_data->pmic_mode_map[mode];
-	if (pmic_mode < 0)
-		return pmic_mode;
+	for (i = 0; i < vreg->hw_data->n_modes; i++) {
+		pmic_mode = &vreg->hw_data->pmic_mode_map[i];
+		if (pmic_mode->id == mode)
+			break;
+	}
+	if (pmic_mode->id != mode) {
+		printf("Invalid mode %d\n", mode);
+		return -EINVAL;
+	}
 
 	if (bypassed)
 		cmd.data = PMIC4_BOB_MODE_PASS;
 	else
-		cmd.data = pmic_mode;
+		cmd.data = pmic_mode->id;
 
 	return rpmh_regulator_send_request(vreg, &cmd, true);
 }
 
-static int rpmh_regulator_vrm_set_mode(struct regulator_dev *rdev,
-					unsigned int mode)
+static int rpmh_regulator_vrm_set_mode(struct udevice *rdev,
+				       int mode)
 {
-	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
 	int ret;
 
+	debug("%s: set_mode %d (current %d)\n", rdev->name, mode, vreg->mode);
+
 	if (mode == vreg->mode)
 		return 0;
 
 	ret = rpmh_regulator_vrm_set_mode_bypass(vreg, mode, vreg->bypassed);
@@ -331,51 +339,59 @@ static int rpmh_regulator_vrm_set_mode(struct regulator_dev *rdev,
 
 	return ret;
 }
 
-static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
+static int rpmh_regulator_vrm_get_mode(struct udevice *rdev)
 {
-	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+
+	debug("%s: get_mode %d\n", rdev->name, vreg->mode);
 
 	return vreg->mode;
 }
+static const struct dm_regulator_ops rpmh_regulator_vrm_drms_ops = {
+	.get_value = rpmh_regulator_vrm_get_value,
+	.set_value = rpmh_regulator_vrm_set_value,
+	.set_enable = rpmh_regulator_set_enable_state,
+	.get_enable = rpmh_regulator_is_enabled,
+	.set_mode = rpmh_regulator_vrm_set_mode,
+	.get_mode = rpmh_regulator_vrm_get_mode,
+};
 
-static const struct regulator_ops rpmh_regulator_vrm_drms_ops = {
-	.enable			= rpmh_regulator_enable,
-	.disable		= rpmh_regulator_disable,
-	.is_enabled		= rpmh_regulator_is_enabled,
-	.set_voltage_sel	= rpmh_regulator_vrm_set_voltage_sel,
-	.get_voltage_sel	= rpmh_regulator_vrm_get_voltage_sel,
-	.list_voltage		= regulator_list_voltage_linear_range,
-	.set_mode		= rpmh_regulator_vrm_set_mode,
-	.get_mode		= rpmh_regulator_vrm_get_mode,
-	.get_optimum_mode	= rpmh_regulator_vrm_get_optimum_mode,
+static struct dm_regulator_mode pmic_mode_map_pmic5_ldo[] = {
+	{
+		.id = REGULATOR_MODE_RETENTION,
+		.register_value = PMIC5_LDO_MODE_RETENTION,
+		.name = "PMIC5_LDO_MODE_RETENTION"
+	}, {
+		.id = REGULATOR_MODE_LPM,
+		.register_value = PMIC5_LDO_MODE_LPM,
+		.name = "PMIC5_LDO_MODE_LPM"
+	}, {
+		.id = REGULATOR_MODE_HPM,
+		.register_value = PMIC5_LDO_MODE_HPM,
+		.name = "PMIC5_LDO_MODE_HPM"
+	},
 };
 
 static const struct rpmh_vreg_hw_data pmic5_pldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
-	},
-	.n_linear_ranges = 1,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
 	.n_voltages = 256,
 	.hpm_min_load_uA = 10000,
 	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
 };
 
 static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(1504000, 0, 62, 8000),
-	},
-	.n_linear_ranges = 1,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1504000, 0, 62, 8000),
 	.n_voltages = 63,
 	.hpm_min_load_uA = 10000,
 	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
 };
 
 #define RPMH_VREG(_name, _resource_name, _hw_data, _supply_name) \
 { \

-- 
2.45.2

