Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC35C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DB3887EB;
	Mon, 15 Jul 2024 12:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XJtxTrnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6D788889; Mon, 15 Jul 2024 12:08:56 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2250988853
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-58b447c5112so5513951a12.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038133; x=1721642933; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ucK3zIA7EbO5G9x/Ruo1tW04nQP6COUjq51be8zAaoM=;
 b=XJtxTrnvle24H8r9XxzABa058eVDVrJXLzK5pfF3zDGqs3VUbh9WHv7dVtoMhaqOTK
 Sn1KCX67Pa7gZ5djcACIEGrHa18D7IioWKvCSpG9COB9oxfu6ouXi6M3O3IyEucj1FYE
 shPPfvoXOYxUayUXtz1IGB/l12D5I5GR9KtYp29DuOyaiKQZm0FPQ4eS+4wz5nbaoSIF
 IA7US2mg9LuIMsgtVdYaq2VJVLumGHwgPLxstB97AUNXPUSuGzH0PbpA6GExGuneimcd
 df5vvvFlRc3lbysDG3+bgMLiU/5kWemUffS1NxU0FQJMqoL75T63QoLAj4aowIJuahoD
 6QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038133; x=1721642933;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucK3zIA7EbO5G9x/Ruo1tW04nQP6COUjq51be8zAaoM=;
 b=kZdot4Z4anWpC8C3qxvURzVpTQAgHJvD6TWc+Js6VgJSMNxR9Tcr+b0u9lfERLhRE8
 T7A5tDVke1Qw+6k2rjmnY2S3JJg+TPkNhVH4HBxViXYT56/K4d8AoHHiICRdk1y8DGfz
 PzRMHCzNn5kzpUhnMV94dYXHwNENxij+NPoHJRCe6TXNR+SRjkqwbYySzG4WBqb2goHM
 2RJ5STUXx37W+ZMvUj+MusEJC6Gcu3lRnpK5WeQ82lhjKCAauaD2F5DXowUOgYkcZ1vz
 EKaLiV1E5uE61xFbP20HqzVLfmcIW5/v+kWGUCzqoo/1Qw6IVrV5DStaYaKyBsgwSsP5
 QwWg==
X-Gm-Message-State: AOJu0Yy9hpJynz4TX1BGDuvMX4zaVGSpIhAXvFqkk88NAIyuLiAP4jGZ
 Ok0N3ZLz/AfCY0XlnB9rHMpmSV3CIYVBWGxsKjQ5EnmWkB2i5rm/AzLvd1bbGsI=
X-Google-Smtp-Source: AGHT+IEcouG3UKEvbTo9MVmgrRxOI2kB+aeBgJqStBqsyUw0CiraeploYSfPty7BFW0oScncyrMAqQ==
X-Received: by 2002:a17:906:260f:b0:a77:c364:c4e9 with SMTP id
 a640c23a62f3a-a780b705312mr1153496366b.45.1721038133637; 
 Mon, 15 Jul 2024 03:08:53 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:20 +0200
Subject: [PATCH v6 21/24] power: regulator: qcom-rpmh-regulator: port ops
 to U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-21-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9430;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Sr0fFMnSXPacpM/eQM/aMYto6EZyS+TqU9f8AYSIiQo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUHbSlTEoMX7ImK3gvEe1IcJtYQt28bsTmVk
 mnB1jZam5mJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BwAKCRAFgzErGV9k
 tlIHD/9uD7JWzLBa10h2TOYs5GcKshYSudboEC5332SwmpBfcG9Wv8WgKSTyL3uSKZ0KqlpeU6M
 /j8C9C90wEhFajTaIlTBPF88F77VEUoHD2pI7RM/8gDNIKpbqrKE25asTY0wh1VlfH52O0cx4S0
 Q/7gN7n+nl75e5M54AK8D8zpgeUiRPFfPwZdrArA9mj56WnLbEMFMwlONaa2vEmGU1vr3PYnGUv
 kMdr04OxvGXJnUGNPI2BSHzWib5p1EnR1caLxHINZcdAQTY9QNPBYhioeGOIlgXbb781P1kjJbR
 zTkskBaO449WEb7ZbRWErDqfMRDc9ELtQG0sapWcWW70Y0h516lYXnYMdvTmu/Rt9fDfUXBxY3u
 UhLqH4WLwcFLHFTZP5wp1Lj3KVNzphNzfKw3bHF85MzGLeSpNapwKVDvc9LaiRYJV0yziWypqAx
 zawSVWMSNXcspIbYe4w2bUiqjz7LDqX2lTiHHWQCeVJMs30XjNEsvpavZse1hzf/jDtjGdmlVkr
 WeQC5Dw/HfftcdRRnwCBEZBRBMJDvu6ZjhGKguOD8GtoDoX7dWChBYZWI1Tpma2Hrb7EXxNZZty
 9MIDzxI21jdy1Q326/hvdxvm+v6s4he994P2hyFavbjONL1gwyJCSc+3Ac4P0dIKADuIbBHdzE9
 Vjy3NkfPzSrI9zw==
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

Acked-by: Sumit Garg <sumit.garg@linaro.org>
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

