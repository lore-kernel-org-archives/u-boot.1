Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378B0C3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FFC3887F5;
	Thu, 11 Jul 2024 18:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iL9K7fjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6616D887E7; Thu, 11 Jul 2024 18:47:08 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB9A887C0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a77e2f51496so162339266b.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716424; x=1721321224; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ofdKYirthuegY9qkvWeyoLHb60MJ4R3ImJ1DqFs1kEM=;
 b=iL9K7fjNKy8WA0w+P4ebYOMSF+3EHYq64oamqwZJGDEdWIN17Ki/1+P1JT2zRMlG4F
 f+B2Lb+R8NlxAIY5f44IdPI1FfNkanQppaDiAQPs+h1SULAVq0lMZiV/h9LpBkjTY0Ng
 SYvJAp/Z+T9WHNTua5Up3gU/I5LE4H6tOblEgJFccj3awA7PysCwT/MbNWdRp3nCkzb/
 6sS9BIEz6Z3d3EsSWpc2TsmNrzGyYRCL+tTdfjeEuPqKdgup6WnP4+Dx1v6mpshFInuD
 ggksLXcGVXLmXA7Ve450uDBgur6qI4XzkqcJ1Tde5paBOHZ/Bwax0BHUNX9Ox7mbkwyD
 z/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716424; x=1721321224;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ofdKYirthuegY9qkvWeyoLHb60MJ4R3ImJ1DqFs1kEM=;
 b=vAPmbWhQE0vVIBe7FpVa/pnNJ5RtDAPJi8as+gb+ZI1qBuV1NNc2przIsOpZWH09G4
 Nl9FkcY3KbJ3KFPmkAOqslSLWbs6mKgPmWsqFSpJox3NXp3wi3CsN2ueD1bveAA2ed+d
 YJJvUYSrx0HxedFhKOHRXy+q2i/zY0Ml+lFmGpS1aUy7mtGqmSgzQjbqcWLZu5IMfbyB
 x3UFgW6DryYRBln7YtLH4HQ7W44BxqzOYZHZtcRZU/6wlyEXvntpY3gEj4ohAymqgwCs
 rgGPAzkelWblfB1rSWQsnPSo9JaNQduI2SUXS65EgJfEOiVa8cNHsZVhmzQgKKatyOLm
 TvHg==
X-Gm-Message-State: AOJu0YzCrXw5vJn6GNECEdcor2MsA3T++8bGq0DGB3T0faoUG0YYtOih
 PkOzKTkeAUaOleJaSex9yrHTazXSDd6SKtBOA0gBdRElsP96kKxBQa9De6eoezY3oae1mtBGnbr
 R
X-Google-Smtp-Source: AGHT+IGHp0g/SizVfpYuvS7f8mlgQZJYh//Kj/z/sbUfObpSs0Ht9Z3f9ubrpZFM8vsJvVJgapJStA==
X-Received: by 2002:a17:906:1958:b0:a72:4281:bc72 with SMTP id
 a640c23a62f3a-a780b89d8b2mr576505166b.63.1720716424088; 
 Thu, 11 Jul 2024 09:47:04 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:47:03 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:51 +0200
Subject: [PATCH v5 19/23] power: regulator: qcom-rpmh-regulator: remove
 unused regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-19-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=58163;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XhzOyUuKpsEPoKbYoHeEFsJciR8wlCTaWqzBbDXW5Jc=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxw5AKtiwBMeGXYHrUtgYVM9vFpsFW54tatA
 0V0Zq9f5FSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMcAAKCRAFgzErGV9k
 tui8D/9WC9jHKMDOml02BBPIqxHHROusQdytoeqR7BR+584Wic49x3nRQAwZW1hBM5M13FVGKiE
 8L5ZbJ3FPLSacKrtECzi2kPOt25xQsIP9EUHRtW8Uw587E2bA3WqMIy5A0h6ll9RiClWOpsd/PC
 LDYIi3DoFbYGg4o9U3UFDbkbfbGZsI8PHqth2mp60d0vjCQytPNwDfi2R0JiSarSChw45hwT9FI
 T1j2NMakS8AWRvICwyiz4E3Y+sftAffKZy8K3Jjks1gebYdZF38Xnq85dqVPhohp7CszmEzQKhx
 EITS1bj1yVUarLBD21uV9WSqjnsF/O3h9NkYthkivU/XLEx9LUNwKUolH5hdJd6KIcm9O7XeiiJ
 nlXkK9Ts0f/hgZqmURvDJqT84uFqynhARh0bXhc11G8QzdwWCso/GIfRrowht3nRVU5bXTLODV5
 xeKRWYkeWVjdiMFb7FduQ4j42w+IJWARLkLP1dd5CXGMO0rezj/Qg5I0I65+ZZezoJWfshpwpje
 uWpz3CS72/dxrP9ElktI73dXjktfX9vGH3TmVKz2GM+3AakkGelNMWWkMPQfDEGqyhxIo1vXsOR
 Z3vDYMrN1kovU0+N688JCEOsx1uDnvJ1fOOIFPygnQJv3NhS5dkF8MLHr/gBwUOW1LC8yJfAvN5
 ubp3QsHkJp8cVkQ==
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

Initially just include the few regulators needed for the RB5 board.
Others can be added back as-needed.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 1281 -------------------------
 1 file changed, 1281 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 089623f3a2b9..2a8e8f9ac444 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -338,68 +338,8 @@ static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
 
 	return vreg->mode;
 }
 
-/**
- * rpmh_regulator_vrm_get_optimum_mode() - get the mode based on the  load
- * @rdev:		Regulator device pointer for the rpmh-regulator
- * @input_uV:		Input voltage
- * @output_uV:		Output voltage
- * @load_uA:		Aggregated load current in microamps
- *
- * This function is used in the regulator_ops for VRM type RPMh regulator
- * devices.
- *
- * Return: 0 on success, errno on failure
- */
-static unsigned int rpmh_regulator_vrm_get_optimum_mode(
-	struct regulator_dev *rdev, int input_uV, int output_uV, int load_uA)
-{
-	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
-
-	if (load_uA >= vreg->hw_data->hpm_min_load_uA)
-		return REGULATOR_MODE_NORMAL;
-	else
-		return REGULATOR_MODE_IDLE;
-}
-
-static int rpmh_regulator_vrm_set_bypass(struct regulator_dev *rdev,
-				bool enable)
-{
-	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
-	int ret;
-
-	if (vreg->bypassed == enable)
-		return 0;
-
-	ret = rpmh_regulator_vrm_set_mode_bypass(vreg, vreg->mode, enable);
-	if (!ret)
-		vreg->bypassed = enable;
-
-	return ret;
-}
-
-static int rpmh_regulator_vrm_get_bypass(struct regulator_dev *rdev,
-				bool *enable)
-{
-	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
-
-	*enable = vreg->bypassed;
-
-	return 0;
-}
-
-static const struct regulator_ops rpmh_regulator_vrm_ops = {
-	.enable			= rpmh_regulator_enable,
-	.disable		= rpmh_regulator_disable,
-	.is_enabled		= rpmh_regulator_is_enabled,
-	.set_voltage_sel	= rpmh_regulator_vrm_set_voltage_sel,
-	.get_voltage_sel	= rpmh_regulator_vrm_get_voltage_sel,
-	.list_voltage		= regulator_list_voltage_linear_range,
-	.set_mode		= rpmh_regulator_vrm_set_mode,
-	.get_mode		= rpmh_regulator_vrm_get_mode,
-};
-
 static const struct regulator_ops rpmh_regulator_vrm_drms_ops = {
 	.enable			= rpmh_regulator_enable,
 	.disable		= rpmh_regulator_disable,
 	.is_enabled		= rpmh_regulator_is_enabled,
@@ -410,331 +350,8 @@ static const struct regulator_ops rpmh_regulator_vrm_drms_ops = {
 	.get_mode		= rpmh_regulator_vrm_get_mode,
 	.get_optimum_mode	= rpmh_regulator_vrm_get_optimum_mode,
 };
 
-static const struct regulator_ops rpmh_regulator_vrm_bypass_ops = {
-	.enable			= rpmh_regulator_enable,
-	.disable		= rpmh_regulator_disable,
-	.is_enabled		= rpmh_regulator_is_enabled,
-	.set_voltage_sel	= rpmh_regulator_vrm_set_voltage_sel,
-	.get_voltage_sel	= rpmh_regulator_vrm_get_voltage_sel,
-	.list_voltage		= regulator_list_voltage_linear_range,
-	.set_mode		= rpmh_regulator_vrm_set_mode,
-	.get_mode		= rpmh_regulator_vrm_get_mode,
-	.set_bypass		= rpmh_regulator_vrm_set_bypass,
-	.get_bypass		= rpmh_regulator_vrm_get_bypass,
-};
-
-static const struct regulator_ops rpmh_regulator_xob_ops = {
-	.enable			= rpmh_regulator_enable,
-	.disable		= rpmh_regulator_disable,
-	.is_enabled		= rpmh_regulator_is_enabled,
-};
-
-/**
- * rpmh_regulator_init_vreg() - initialize all attributes of an rpmh-regulator
- * @vreg:		Pointer to the individual rpmh-regulator resource
- * @dev:			Pointer to the top level rpmh-regulator PMIC device
- * @node:		Pointer to the individual rpmh-regulator resource
- *			device node
- * @pmic_id:		String used to identify the top level rpmh-regulator
- *			PMIC device on the board
- * @pmic_rpmh_data:	Pointer to a null-terminated array of rpmh-regulator
- *			resources defined for the top level PMIC device
- *
- * Return: 0 on success, errno on failure
- */
-static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
-			struct device_node *node, const char *pmic_id,
-			const struct rpmh_vreg_init_data *pmic_rpmh_data)
-{
-	struct regulator_config reg_config = {};
-	char rpmh_resource_name[20] = "";
-	const struct rpmh_vreg_init_data *rpmh_data;
-	struct regulator_init_data *init_data;
-	struct regulator_dev *rdev;
-	int ret;
-
-	vreg->dev = dev;
-
-	for (rpmh_data = pmic_rpmh_data; rpmh_data->name; rpmh_data++)
-		if (of_node_name_eq(node, rpmh_data->name))
-			break;
-
-	if (!rpmh_data->name) {
-		dev_err(dev, "Unknown regulator %pOFn\n", node);
-		return -EINVAL;
-	}
-
-	scnprintf(rpmh_resource_name, sizeof(rpmh_resource_name),
-		rpmh_data->resource_name, pmic_id);
-
-	vreg->addr = cmd_db_read_addr(rpmh_resource_name);
-	if (!vreg->addr) {
-		dev_err(dev, "%pOFn: could not find RPMh address for resource %s\n",
-			node, rpmh_resource_name);
-		return -ENODEV;
-	}
-
-	vreg->rdesc.name = rpmh_data->name;
-	vreg->rdesc.supply_name = rpmh_data->supply_name;
-	vreg->hw_data = rpmh_data->hw_data;
-
-	vreg->enabled = -EINVAL;
-	vreg->voltage_selector = -ENOTRECOVERABLE;
-	vreg->mode = REGULATOR_MODE_INVALID;
-
-	if (rpmh_data->hw_data->n_voltages) {
-		vreg->rdesc.linear_ranges = rpmh_data->hw_data->voltage_ranges;
-		vreg->rdesc.n_linear_ranges = rpmh_data->hw_data->n_linear_ranges;
-		vreg->rdesc.n_voltages = rpmh_data->hw_data->n_voltages;
-	}
-
-	vreg->always_wait_for_ack = of_property_read_bool(node,
-						"qcom,always-wait-for-ack");
-
-	vreg->rdesc.owner	= THIS_MODULE;
-	vreg->rdesc.type	= REGULATOR_VOLTAGE;
-	vreg->rdesc.ops		= vreg->hw_data->ops;
-	vreg->rdesc.of_map_mode	= vreg->hw_data->of_map_mode;
-
-	init_data = of_get_regulator_init_data(dev, node, &vreg->rdesc);
-	if (!init_data)
-		return -ENOMEM;
-
-	if (rpmh_data->hw_data->regulator_type == XOB &&
-	    init_data->constraints.min_uV &&
-	    init_data->constraints.min_uV == init_data->constraints.max_uV) {
-		vreg->rdesc.fixed_uV = init_data->constraints.min_uV;
-		vreg->rdesc.n_voltages = 1;
-	}
-
-	reg_config.dev		= dev;
-	reg_config.init_data	= init_data;
-	reg_config.of_node	= node;
-	reg_config.driver_data	= vreg;
-
-	rdev = devm_regulator_register(dev, &vreg->rdesc, &reg_config);
-	if (IS_ERR(rdev)) {
-		ret = PTR_ERR(rdev);
-		dev_err(dev, "%pOFn: devm_regulator_register() failed, ret=%d\n",
-			node, ret);
-		return ret;
-	}
-
-	dev_dbg(dev, "%pOFn regulator registered for RPMh resource %s @ 0x%05X\n",
-		node, rpmh_resource_name, vreg->addr);
-
-	return 0;
-}
-
-static const int pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
-	[REGULATOR_MODE_INVALID] = -EINVAL,
-	[REGULATOR_MODE_STANDBY] = PMIC4_LDO_MODE_RETENTION,
-	[REGULATOR_MODE_IDLE]    = PMIC4_LDO_MODE_LPM,
-	[REGULATOR_MODE_NORMAL]  = PMIC4_LDO_MODE_HPM,
-	[REGULATOR_MODE_FAST]    = -EINVAL,
-};
-
-static const int pmic_mode_map_pmic5_ldo[REGULATOR_MODE_STANDBY + 1] = {
-	[REGULATOR_MODE_INVALID] = -EINVAL,
-	[REGULATOR_MODE_STANDBY] = PMIC5_LDO_MODE_RETENTION,
-	[REGULATOR_MODE_IDLE]    = PMIC5_LDO_MODE_LPM,
-	[REGULATOR_MODE_NORMAL]  = PMIC5_LDO_MODE_HPM,
-	[REGULATOR_MODE_FAST]    = -EINVAL,
-};
-
-static const int pmic_mode_map_pmic5_ldo_hpm[REGULATOR_MODE_STANDBY + 1] = {
-	[REGULATOR_MODE_INVALID] = -EINVAL,
-	[REGULATOR_MODE_STANDBY] = -EINVAL,
-	[REGULATOR_MODE_IDLE]    = -EINVAL,
-	[REGULATOR_MODE_NORMAL]  = PMIC5_LDO_MODE_HPM,
-	[REGULATOR_MODE_FAST]    = -EINVAL,
-};
-
-static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int rpmh_mode)
-{
-	unsigned int mode;
-
-	switch (rpmh_mode) {
-	case RPMH_REGULATOR_MODE_HPM:
-		mode = REGULATOR_MODE_NORMAL;
-		break;
-	case RPMH_REGULATOR_MODE_LPM:
-		mode = REGULATOR_MODE_IDLE;
-		break;
-	case RPMH_REGULATOR_MODE_RET:
-		mode = REGULATOR_MODE_STANDBY;
-		break;
-	default:
-		mode = REGULATOR_MODE_INVALID;
-		break;
-	}
-
-	return mode;
-}
-
-static const int pmic_mode_map_pmic4_smps[REGULATOR_MODE_STANDBY + 1] = {
-	[REGULATOR_MODE_INVALID] = -EINVAL,
-	[REGULATOR_MODE_STANDBY] = PMIC4_SMPS_MODE_RETENTION,
-	[REGULATOR_MODE_IDLE]    = PMIC4_SMPS_MODE_PFM,
-	[REGULATOR_MODE_NORMAL]  = PMIC4_SMPS_MODE_AUTO,
-	[REGULATOR_MODE_FAST]    = PMIC4_SMPS_MODE_PWM,
-};
-
-static const int pmic_mode_map_pmic5_smps[REGULATOR_MODE_STANDBY + 1] = {
-	[REGULATOR_MODE_INVALID] = -EINVAL,
-	[REGULATOR_MODE_STANDBY] = PMIC5_SMPS_MODE_RETENTION,
-	[REGULATOR_MODE_IDLE]    = PMIC5_SMPS_MODE_PFM,
-	[REGULATOR_MODE_NORMAL]  = PMIC5_SMPS_MODE_AUTO,
-	[REGULATOR_MODE_FAST]    = PMIC5_SMPS_MODE_PWM,
-};
-
-static unsigned int
-rpmh_regulator_pmic4_smps_of_map_mode(unsigned int rpmh_mode)
-{
-	unsigned int mode;
-
-	switch (rpmh_mode) {
-	case RPMH_REGULATOR_MODE_HPM:
-		mode = REGULATOR_MODE_FAST;
-		break;
-	case RPMH_REGULATOR_MODE_AUTO:
-		mode = REGULATOR_MODE_NORMAL;
-		break;
-	case RPMH_REGULATOR_MODE_LPM:
-		mode = REGULATOR_MODE_IDLE;
-		break;
-	case RPMH_REGULATOR_MODE_RET:
-		mode = REGULATOR_MODE_STANDBY;
-		break;
-	default:
-		mode = REGULATOR_MODE_INVALID;
-		break;
-	}
-
-	return mode;
-}
-
-static const int pmic_mode_map_pmic4_bob[REGULATOR_MODE_STANDBY + 1] = {
-	[REGULATOR_MODE_INVALID] = -EINVAL,
-	[REGULATOR_MODE_STANDBY] = -EINVAL,
-	[REGULATOR_MODE_IDLE]    = PMIC4_BOB_MODE_PFM,
-	[REGULATOR_MODE_NORMAL]  = PMIC4_BOB_MODE_AUTO,
-	[REGULATOR_MODE_FAST]    = PMIC4_BOB_MODE_PWM,
-};
-
-static const int pmic_mode_map_pmic5_bob[REGULATOR_MODE_STANDBY + 1] = {
-	[REGULATOR_MODE_INVALID] = -EINVAL,
-	[REGULATOR_MODE_STANDBY] = -EINVAL,
-	[REGULATOR_MODE_IDLE]    = PMIC5_BOB_MODE_PFM,
-	[REGULATOR_MODE_NORMAL]  = PMIC5_BOB_MODE_AUTO,
-	[REGULATOR_MODE_FAST]    = PMIC5_BOB_MODE_PWM,
-};
-
-static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int rpmh_mode)
-{
-	unsigned int mode;
-
-	switch (rpmh_mode) {
-	case RPMH_REGULATOR_MODE_HPM:
-		mode = REGULATOR_MODE_FAST;
-		break;
-	case RPMH_REGULATOR_MODE_AUTO:
-		mode = REGULATOR_MODE_NORMAL;
-		break;
-	case RPMH_REGULATOR_MODE_LPM:
-		mode = REGULATOR_MODE_IDLE;
-		break;
-	default:
-		mode = REGULATOR_MODE_INVALID;
-		break;
-	}
-
-	return mode;
-}
-
-static const struct rpmh_vreg_hw_data pmic4_pldo = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 256,
-	.hpm_min_load_uA = 10000,
-	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_ranges = (struct linear_range[]) {
-	       REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 128,
-	.hpm_min_load_uA = 10000,
-	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic4_nldo = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 128,
-	.hpm_min_load_uA = 30000,
-	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 216,
-	.pmic_mode_map = pmic_mode_map_pmic4_smps,
-	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 259,
-	.pmic_mode_map = pmic_mode_map_pmic4_smps,
-	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic4_bob = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_bypass_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 84,
-	.pmic_mode_map = pmic_mode_map_pmic4_bob,
-	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic4_lvs = {
-	.regulator_type = XOB,
-	.ops = &rpmh_regulator_xob_ops,
-	/* LVS hardware does not support voltage or mode configuration. */
-};
-
 static const struct rpmh_vreg_hw_data pmic5_pldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
 	.voltage_ranges = (struct linear_range[]) {
@@ -759,810 +376,24 @@ static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
 	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
 	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
 };
 
-static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(1800000, 0, 187, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 188,
-	.hpm_min_load_uA = 10000,
-	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_pldo502 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 256,
-	.pmic_mode_map = pmic_mode_map_pmic5_ldo_hpm,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_pldo502ln = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(1800000, 0,  2,  200000),
-		REGULATOR_LINEAR_RANGE(2608000, 3,  28, 16000),
-		REGULATOR_LINEAR_RANGE(3104000, 29, 30, 96000),
-		REGULATOR_LINEAR_RANGE(3312000, 31, 31, 0),
-	},
-	.n_linear_ranges = 4,
-	.n_voltages = 32,
-	.pmic_mode_map = pmic_mode_map_pmic5_ldo_hpm,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_nldo = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(320000, 0, 123, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 124,
-	.hpm_min_load_uA = 30000,
-	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(320000, 0, 210, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 211,
-	.hpm_min_load_uA = 30000,
-	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_nldo502 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(528000, 0, 127, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 128,
-	.hpm_min_load_uA = 30000,
-	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
-	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 216,
-	.pmic_mode_map = pmic_mode_map_pmic5_smps,
-	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_ftsmps510 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 264,
-	.pmic_mode_map = pmic_mode_map_pmic5_smps,
-	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_ftsmps520 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 264,
-	.pmic_mode_map = pmic_mode_map_pmic5_smps,
-	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_ftsmps525_lv = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(300000, 0, 267, 4000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 268,
-	.pmic_mode_map = pmic_mode_map_pmic5_smps,
-	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(600000, 0, 267, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 268,
-	.pmic_mode_map = pmic_mode_map_pmic5_smps,
-	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_ftsmps527 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 215,
-	.pmic_mode_map = pmic_mode_map_pmic5_smps,
-	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(320000, 0, 235, 16000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 236,
-	.pmic_mode_map = pmic_mode_map_pmic5_smps,
-	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_hfsmps515_1 = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(900000, 0, 4, 16000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 5,
-	.pmic_mode_map = pmic_mode_map_pmic5_smps,
-	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
-};
-
-static const struct rpmh_vreg_hw_data pmic5_bob = {
-	.regulator_type = VRM,
-	.ops = &rpmh_regulator_vrm_bypass_ops,
-	.voltage_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(3000000, 0, 31, 32000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 32,
-	.pmic_mode_map = pmic_mode_map_pmic5_bob,
-	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
-};
-
 #define RPMH_VREG(_name, _resource_name, _hw_data, _supply_name) \
 { \
 	.name		= _name, \
 	.resource_name	= _resource_name, \
 	.hw_data	= _hw_data, \
 	.supply_name	= _supply_name, \
 }
 
-static const struct rpmh_vreg_init_data pm8998_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic4_hfsmps3,   "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic4_hfsmps3,   "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic4_hfsmps3,   "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic4_ftsmps426, "vdd-s6"),
-	RPMH_VREG("smps7",  "smp%s7",  &pmic4_ftsmps426, "vdd-s7"),
-	RPMH_VREG("smps8",  "smp%s8",  &pmic4_ftsmps426, "vdd-s8"),
-	RPMH_VREG("smps9",  "smp%s9",  &pmic4_ftsmps426, "vdd-s9"),
-	RPMH_VREG("smps10", "smp%s10", &pmic4_ftsmps426, "vdd-s10"),
-	RPMH_VREG("smps11", "smp%s11", &pmic4_ftsmps426, "vdd-s11"),
-	RPMH_VREG("smps12", "smp%s12", &pmic4_ftsmps426, "vdd-s12"),
-	RPMH_VREG("smps13", "smp%s13", &pmic4_ftsmps426, "vdd-s13"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic4_nldo,      "vdd-l1-l27"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic4_nldo,      "vdd-l2-l8-l17"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic4_nldo,      "vdd-l3-l11"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic4_nldo,      "vdd-l4-l5"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic4_nldo,      "vdd-l4-l5"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic4_pldo,      "vdd-l6"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic4_nldo,      "vdd-l2-l8-l17"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic4_pldo,      "vdd-l9"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic4_pldo,      "vdd-l10-l23-l25"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic4_nldo,      "vdd-l3-l11"),
-	RPMH_VREG("ldo12",  "ldo%s12", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo13",  "ldo%s13", &pmic4_pldo,      "vdd-l13-l19-l21"),
-	RPMH_VREG("ldo14",  "ldo%s14", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo15",  "ldo%s15", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo16",  "ldo%s16", &pmic4_pldo,      "vdd-l16-l28"),
-	RPMH_VREG("ldo17",  "ldo%s17", &pmic4_nldo,      "vdd-l2-l8-l17"),
-	RPMH_VREG("ldo18",  "ldo%s18", &pmic4_pldo,      "vdd-l18-l22"),
-	RPMH_VREG("ldo19",  "ldo%s19", &pmic4_pldo,      "vdd-l13-l19-l21"),
-	RPMH_VREG("ldo20",  "ldo%s20", &pmic4_pldo,      "vdd-l20-l24"),
-	RPMH_VREG("ldo21",  "ldo%s21", &pmic4_pldo,      "vdd-l13-l19-l21"),
-	RPMH_VREG("ldo22",  "ldo%s22", &pmic4_pldo,      "vdd-l18-l22"),
-	RPMH_VREG("ldo23",  "ldo%s23", &pmic4_pldo,      "vdd-l10-l23-l25"),
-	RPMH_VREG("ldo24",  "ldo%s24", &pmic4_pldo,      "vdd-l20-l24"),
-	RPMH_VREG("ldo25",  "ldo%s25", &pmic4_pldo,      "vdd-l10-l23-l25"),
-	RPMH_VREG("ldo26",  "ldo%s26", &pmic4_nldo,      "vdd-l26"),
-	RPMH_VREG("ldo27",  "ldo%s27", &pmic4_nldo,      "vdd-l1-l27"),
-	RPMH_VREG("ldo28",  "ldo%s28", &pmic4_pldo,      "vdd-l16-l28"),
-	RPMH_VREG("lvs1",   "vs%s1",   &pmic4_lvs,       "vin-lvs-1-2"),
-	RPMH_VREG("lvs2",   "vs%s2",   &pmic4_lvs,       "vin-lvs-1-2"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pmg1110_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510,  "vdd-s1"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pmi8998_vreg_data[] = {
-	RPMH_VREG("bob",    "bob%s1",  &pmic4_bob,       "vdd-bob"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm8005_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic4_ftsmps426, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic4_ftsmps426, "vdd-s4"),
-	{}
-};
-
 static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_hfsmps510,   "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_hfsmps510,   "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
-	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
-	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps510, "vdd-s8"),
-	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps510, "vdd-s9"),
-	RPMH_VREG("smps10", "smp%s10", &pmic5_ftsmps510, "vdd-s10"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l8-l11"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l10"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l1-l8-l11"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l2-l10"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo,      "vdd-l1-l8-l11"),
-	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
 	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
-	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,      "vdd-l13-l16-l17"),
-	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,      "vdd-l13-l16-l17"),
-	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
 	{}
 };
 
 static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps510, "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps510, "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
-	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
-	RPMH_VREG("smps8",  "smp%s8",  &pmic5_hfsmps510, "vdd-s8"),
 	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2-l3"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l2-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l4-l5-l6"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l4-l5-l6"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l4-l5-l6"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l11"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv,   "vdd-l1-l8"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l9-l10"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
 	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
-	RPMH_VREG("bob",    "bob%s1",  &pmic5_bob,       "vdd-bob"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pmm8155au_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_hfsmps510, "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_hfsmps510, "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
-	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
-	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps510, "vdd-s8"),
-	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps510, "vdd-s9"),
-	RPMH_VREG("smps10", "smp%s10", &pmic5_ftsmps510, "vdd-s10"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l8-l11"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l10"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l1-l8-l11"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l2-l10"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo,      "vdd-l1-l8-l11"),
-	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
-	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,      "vdd-l13-l16-l17"),
-	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,      "vdd-l13-l16-l17"),
-	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pmm8654au_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps527,  "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps527,  "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps527,  "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps527,  "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps527,  "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps527,  "vdd-s6"),
-	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps527,  "vdd-s7"),
-	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps527,  "vdd-s8"),
-	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps527,  "vdd-s9"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,    "vdd-s9"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo515,    "vdd-l2-l3"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,    "vdd-l2-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo515,    "vdd-s9"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo515,    "vdd-s9"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo515,    "vdd-l6-l7"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_nldo515,    "vdd-l6-l7"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo515_mv, "vdd-l8-l9"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,       "vdd-l8-l9"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm8350_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps510, "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps510, "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
-	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
-	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps510, "vdd-s8"),
-	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps510, "vdd-s9"),
-	RPMH_VREG("smps10", "smp%s10", &pmic5_hfsmps510, "vdd-s10"),
-	RPMH_VREG("smps11", "smp%s11", &pmic5_hfsmps510, "vdd-s11"),
-	RPMH_VREG("smps12", "smp%s12", &pmic5_hfsmps510, "vdd-s12"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l4"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l7"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3-l5"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l1-l4"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l3-l5"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9-l10"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l2-l7"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l8"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9-l10"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,      "vdd-l6-l9-l10"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps515, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps510, "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps510, "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
-	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
-	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps510, "vdd-s8"),
-	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps510, "vdd-s9"),
-	RPMH_VREG("smps10", "smp%s10", &pmic5_ftsmps510, "vdd-s10"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l12"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo_lv,   "vdd-l2-l8"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l6-l9-l11"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv,   "vdd-l2-l8"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l6-l9-l11"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,      "vdd-l10"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l6-l9-l11"),
-	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l1-l12"),
-	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
-	RPMH_VREG("bob",    "bob%s1",  &pmic5_bob,       "vdd-bob"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm8450_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps520, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps520, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps520, "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps520, "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps520, "vdd-s6"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo_lv,   "vdd-l4"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm8550_vreg_data[] = {
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,    "vdd-l1-l4-l10"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,    "vdd-l2-l13-l14"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,    "vdd-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo515,    "vdd-l1-l4-l10"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,    "vdd-l5-l16"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo, "vdd-l6-l7"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo, "vdd-l6-l7"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo, "vdd-l8-l9"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,    "vdd-l8-l9"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo515,    "vdd-l1-l4-l10"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo515,    "vdd-l11"),
-	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_nldo515,    "vdd-l12"),
-	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,    "vdd-l2-l13-l14"),
-	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo,    "vdd-l2-l13-l14"),
-	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo515,    "vdd-l15"),
-	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,    "vdd-l5-l16"),
-	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,    "vdd-l17"),
-	RPMH_VREG("bob1",   "bob%s1",  &pmic5_bob,     "vdd-bob1"),
-	RPMH_VREG("bob2",   "bob%s2",  &pmic5_bob,     "vdd-bob2"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm8550vs_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps525_lv, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps525_lv, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps525_lv, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps525_lv, "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps525_lv, "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps525_mv, "vdd-s6"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,   "vdd-l1"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo515,   "vdd-l2"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,   "vdd-l3"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
-	RPMH_VREG("smps1", "smp%s1", &pmic5_ftsmps525_lv, "vdd-s1"),
-	RPMH_VREG("smps2", "smp%s2", &pmic5_ftsmps525_lv, "vdd-s2"),
-	RPMH_VREG("smps3", "smp%s3", &pmic5_ftsmps525_lv, "vdd-s3"),
-	RPMH_VREG("smps4", "smp%s4", &pmic5_ftsmps525_mv, "vdd-s4"),
-	RPMH_VREG("smps5", "smp%s5", &pmic5_ftsmps525_lv, "vdd-s5"),
-	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
-	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
-	RPMH_VREG("smps8", "smp%s8", &pmic5_ftsmps525_lv, "vdd-s8"),
-	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo515,   "vdd-l1"),
-	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo515,   "vdd-l2"),
-	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo515,   "vdd-l3"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pmc8380_vreg_data[] = {
-	RPMH_VREG("smps1", "smp%s1", &pmic5_ftsmps525_lv, "vdd-s1"),
-	RPMH_VREG("smps2", "smp%s2", &pmic5_ftsmps525_lv, "vdd-s2"),
-	RPMH_VREG("smps3", "smp%s3", &pmic5_ftsmps525_lv, "vdd-s3"),
-	RPMH_VREG("smps4", "smp%s4", &pmic5_ftsmps525_mv, "vdd-s4"),
-	RPMH_VREG("smps5", "smp%s5", &pmic5_ftsmps525_lv, "vdd-s5"),
-	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
-	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
-	RPMH_VREG("smps8", "smp%s8", &pmic5_ftsmps525_lv, "vdd-s8"),
-	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo515,   "vdd-l1"),
-	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo515,   "vdd-l2"),
-	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo515,   "vdd-l3"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm8009_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_hfsmps515, "vdd-s2"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l4"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l5-l6"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l5-l6"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv,   "vdd-l7"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm8009_1_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_hfsmps515_1, "vdd-s2"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l4"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l5-l6"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l5-l6"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv,   "vdd-l7"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm8010_vreg_data[] = {
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo502,   "vdd-l1-l2"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo502,   "vdd-l1-l2"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_pldo502ln, "vdd-l3-l4"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo502ln, "vdd-l3-l4"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo502,   "vdd-l5"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo502ln, "vdd-l6"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo502,   "vdd-l7"),
-};
-
-static const struct rpmh_vreg_init_data pm6150_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_hfsmps510, "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_hfsmps510, "vdd-s5"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2-l3"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l2-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l4-l7-l8"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,   "vdd-l5-l16-l17-l18-l19"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_nldo,      "vdd-l4-l7-l8"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l4-l7-l8"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l9"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo_lv,   "vdd-l10-l14-l15"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo_lv,   "vdd-l11-l12-l13"),
-	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l11-l12-l13"),
-	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo_lv,   "vdd-l11-l12-l13"),
-	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo_lv,   "vdd-l10-l14-l15"),
-	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo_lv,   "vdd-l10-l14-l15"),
-	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,   "vdd-l5-l16-l17-l18-l19"),
-	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,   "vdd-l5-l16-l17-l18-l19"),
-	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_pldo,   "vdd-l5-l16-l17-l18-l19"),
-	RPMH_VREG("ldo19",  "ldo%s19", &pmic5_pldo,   "vdd-l5-l16-l17-l18-l19"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps510, "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps510, "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
-	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
-	RPMH_VREG("smps8",  "smp%s8",  &pmic5_hfsmps510, "vdd-s8"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2-l3"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l2-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l4-l5-l6"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l4-l5-l6"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l4-l5-l6"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l11"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo,      "vdd-l1-l8"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l9-l10"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
-	RPMH_VREG("bob",    "bob%s1",  &pmic5_bob,       "vdd-bob"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm6350_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, NULL),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_hfsmps510, NULL),
-	/* smps3 - smps5 not configured */
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      NULL),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      NULL),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_nldo,      NULL),
-	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo,      NULL),
-	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo,      NULL),
-	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_nldo,      NULL),
-	/* ldo17 not configured */
-	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_nldo,      NULL),
-	RPMH_VREG("ldo19",  "ldo%s19", &pmic5_nldo,      NULL),
-	RPMH_VREG("ldo20",  "ldo%s20", &pmic5_nldo,      NULL),
-	RPMH_VREG("ldo21",  "ldo%s21", &pmic5_nldo,      NULL),
-	RPMH_VREG("ldo22",  "ldo%s22", &pmic5_nldo,      NULL),
-};
-
-static const struct rpmh_vreg_init_data pmx55_vreg_data[] = {
-	RPMH_VREG("smps1",   "smp%s1",    &pmic5_ftsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",   "smp%s2",    &pmic5_hfsmps510, "vdd-s2"),
-	RPMH_VREG("smps3",   "smp%s3",    &pmic5_hfsmps510, "vdd-s3"),
-	RPMH_VREG("smps4",   "smp%s4",    &pmic5_hfsmps510, "vdd-s4"),
-	RPMH_VREG("smps5",   "smp%s5",    &pmic5_hfsmps510, "vdd-s5"),
-	RPMH_VREG("smps6",   "smp%s6",    &pmic5_ftsmps510, "vdd-s6"),
-	RPMH_VREG("smps7",   "smp%s7",    &pmic5_hfsmps510, "vdd-s7"),
-	RPMH_VREG("ldo1",    "ldo%s1",    &pmic5_nldo,      "vdd-l1-l2"),
-	RPMH_VREG("ldo2",    "ldo%s2",    &pmic5_nldo,      "vdd-l1-l2"),
-	RPMH_VREG("ldo3",    "ldo%s3",    &pmic5_nldo,      "vdd-l3-l9"),
-	RPMH_VREG("ldo4",    "ldo%s4",    &pmic5_nldo,      "vdd-l4-l12"),
-	RPMH_VREG("ldo5",    "ldo%s5",    &pmic5_pldo,      "vdd-l5-l6"),
-	RPMH_VREG("ldo6",    "ldo%s6",    &pmic5_pldo,      "vdd-l5-l6"),
-	RPMH_VREG("ldo7",    "ldo%s7",    &pmic5_nldo,      "vdd-l7-l8"),
-	RPMH_VREG("ldo8",    "ldo%s8",    &pmic5_nldo,      "vdd-l7-l8"),
-	RPMH_VREG("ldo9",    "ldo%s9",    &pmic5_nldo,      "vdd-l3-l9"),
-	RPMH_VREG("ldo10",   "ldo%s10",   &pmic5_pldo,      "vdd-l10-l11-l13"),
-	RPMH_VREG("ldo11",   "ldo%s11",   &pmic5_pldo,      "vdd-l10-l11-l13"),
-	RPMH_VREG("ldo12",   "ldo%s12",   &pmic5_nldo,      "vdd-l4-l12"),
-	RPMH_VREG("ldo13",   "ldo%s13",   &pmic5_pldo,      "vdd-l10-l11-l13"),
-	RPMH_VREG("ldo14",   "ldo%s14",   &pmic5_nldo,      "vdd-l14"),
-	RPMH_VREG("ldo15",   "ldo%s15",   &pmic5_nldo,      "vdd-l15"),
-	RPMH_VREG("ldo16",   "ldo%s16",   &pmic5_pldo,      "vdd-l16"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pmx65_vreg_data[] = {
-	RPMH_VREG("smps1",   "smp%s1",    &pmic5_ftsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",   "smp%s2",    &pmic5_hfsmps510, "vdd-s2"),
-	RPMH_VREG("smps3",   "smp%s3",    &pmic5_hfsmps510, "vdd-s3"),
-	RPMH_VREG("smps4",   "smp%s4",    &pmic5_hfsmps510, "vdd-s4"),
-	RPMH_VREG("smps5",   "smp%s5",    &pmic5_hfsmps510, "vdd-s5"),
-	RPMH_VREG("smps6",   "smp%s6",    &pmic5_ftsmps510, "vdd-s6"),
-	RPMH_VREG("smps7",   "smp%s7",    &pmic5_hfsmps510, "vdd-s7"),
-	RPMH_VREG("smps8",   "smp%s8",    &pmic5_hfsmps510, "vdd-s8"),
-	RPMH_VREG("ldo1",    "ldo%s1",    &pmic5_nldo,      "vdd-l1"),
-	RPMH_VREG("ldo2",    "ldo%s2",    &pmic5_nldo,      "vdd-l2-l18"),
-	RPMH_VREG("ldo3",    "ldo%s3",    &pmic5_nldo,      "vdd-l3"),
-	RPMH_VREG("ldo4",    "ldo%s4",    &pmic5_nldo,      "vdd-l4"),
-	RPMH_VREG("ldo5",    "ldo%s5",    &pmic5_pldo,      "vdd-l5-l6-l16"),
-	RPMH_VREG("ldo6",    "ldo%s6",    &pmic5_pldo,      "vdd-l5-l6-l16"),
-	RPMH_VREG("ldo7",    "ldo%s7",    &pmic5_nldo,      "vdd-l7"),
-	RPMH_VREG("ldo8",    "ldo%s8",    &pmic5_nldo,      "vdd-l8-l9"),
-	RPMH_VREG("ldo9",    "ldo%s9",    &pmic5_nldo,      "vdd-l8-l9"),
-	RPMH_VREG("ldo10",   "ldo%s10",   &pmic5_pldo,      "vdd-l10"),
-	RPMH_VREG("ldo11",   "ldo%s11",   &pmic5_pldo,      "vdd-l11-l13"),
-	RPMH_VREG("ldo12",   "ldo%s12",   &pmic5_nldo,      "vdd-l12"),
-	RPMH_VREG("ldo13",   "ldo%s13",   &pmic5_pldo,      "vdd-l11-l13"),
-	RPMH_VREG("ldo14",   "ldo%s14",   &pmic5_nldo,      "vdd-l14"),
-	RPMH_VREG("ldo15",   "ldo%s15",   &pmic5_nldo,      "vdd-l15"),
-	RPMH_VREG("ldo16",   "ldo%s16",   &pmic5_pldo,      "vdd-l5-l6-l16"),
-	RPMH_VREG("ldo17",   "ldo%s17",   &pmic5_nldo,      "vdd-l17"),
-	/* ldo18 not configured */
-	RPMH_VREG("ldo19",   "ldo%s19",   &pmic5_nldo,      "vdd-l19"),
-	RPMH_VREG("ldo20",   "ldo%s20",   &pmic5_nldo,      "vdd-l20"),
-	RPMH_VREG("ldo21",   "ldo%s21",   &pmic5_nldo,      "vdd-l21"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pmx75_vreg_data[] = {
-	RPMH_VREG("smps1",   "smp%s1",    &pmic5_ftsmps525_lv, "vdd-s1"),
-	RPMH_VREG("smps2",   "smp%s2",    &pmic5_ftsmps525_lv, "vdd-s2"),
-	RPMH_VREG("smps3",   "smp%s3",    &pmic5_ftsmps525_lv, "vdd-s3"),
-	RPMH_VREG("smps4",   "smp%s4",    &pmic5_ftsmps525_mv, "vdd-s4"),
-	RPMH_VREG("smps5",   "smp%s5",    &pmic5_ftsmps525_lv, "vdd-s5"),
-	RPMH_VREG("smps6",   "smp%s6",    &pmic5_ftsmps525_lv, "vdd-s6"),
-	RPMH_VREG("smps7",   "smp%s7",    &pmic5_ftsmps525_lv, "vdd-s7"),
-	RPMH_VREG("smps8",   "smp%s8",    &pmic5_ftsmps525_lv, "vdd-s8"),
-	RPMH_VREG("smps9",   "smp%s9",    &pmic5_ftsmps525_lv, "vdd-s9"),
-	RPMH_VREG("smps10",  "smp%s10",   &pmic5_ftsmps525_lv, "vdd-s10"),
-	RPMH_VREG("ldo1",    "ldo%s1",    &pmic5_nldo515,   "vdd-l1"),
-	RPMH_VREG("ldo2",    "ldo%s2",    &pmic5_nldo515,   "vdd-l2-18"),
-	RPMH_VREG("ldo3",    "ldo%s3",    &pmic5_nldo515,   "vdd-l3"),
-	RPMH_VREG("ldo4",    "ldo%s4",    &pmic5_nldo515,   "vdd-l4-l16"),
-	RPMH_VREG("ldo5",    "ldo%s5",    &pmic5_pldo_lv,   "vdd-l5-l6"),
-	RPMH_VREG("ldo6",    "ldo%s6",    &pmic5_pldo_lv,   "vdd-l5-l6"),
-	RPMH_VREG("ldo7",    "ldo%s7",    &pmic5_nldo515,   "vdd-l7"),
-	RPMH_VREG("ldo8",    "ldo%s8",    &pmic5_nldo515,   "vdd-l8-l9"),
-	RPMH_VREG("ldo9",    "ldo%s9",    &pmic5_nldo515,   "vdd-l8-l9"),
-	RPMH_VREG("ldo10",   "ldo%s10",   &pmic5_pldo,      "vdd-l10"),
-	RPMH_VREG("ldo11",   "ldo%s11",   &pmic5_pldo,      "vdd-l11-l13"),
-	RPMH_VREG("ldo12",   "ldo%s12",   &pmic5_nldo515,   "vdd-l12"),
-	RPMH_VREG("ldo13",   "ldo%s13",   &pmic5_pldo,      "vdd-l11-l13"),
-	RPMH_VREG("ldo14",   "ldo%s14",   &pmic5_nldo515,   "vdd-l14"),
-	RPMH_VREG("ldo15",   "ldo%s15",   &pmic5_nldo515,   "vdd-l15"),
-	RPMH_VREG("ldo16",   "ldo%s16",   &pmic5_nldo515,   "vdd-l4-l16"),
-	RPMH_VREG("ldo17",   "ldo%s17",   &pmic5_nldo515,   "vdd-l17"),
-	/* ldo18 not configured */
-	RPMH_VREG("ldo19",   "ldo%s19",   &pmic5_nldo515,   "vdd-l19"),
-	RPMH_VREG("ldo20",   "ldo%s20",   &pmic5_nldo515,   "vdd-l20-l21"),
-	RPMH_VREG("ldo21",   "ldo%s21",   &pmic5_nldo515,   "vdd-l20-l21"),
-};
-
-static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps520, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps520, "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps520, "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps520, "vdd-s6"),
-	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps520, "vdd-s7"),
-	RPMH_VREG("smps8",  "smp%s8",  &pmic5_hfsmps510, "vdd-s8"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l7"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l5"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9-l10"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l2-l7"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l8"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9-l10"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,      "vdd-l6-l9-l10"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
-	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
-	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_nldo,      "vdd-l13"),
-	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_nldo,      "vdd-l14-l16"),
-	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
-	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_nldo,      "vdd-l14-l16"),
-	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
-	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
-	RPMH_VREG("ldo19",  "ldo%s19", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pmr735a_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps520, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_hfsmps515, "vdd-s3"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l2"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l1-l2"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo_lv,   "vdd-l4"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l5-l6"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l5-l6"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-bob"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm660_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic4_ftsmps426, "vdd-s3"),
-	RPMH_VREG("smps4",  "smp%s4",  &pmic4_hfsmps3,   "vdd-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic4_hfsmps3,   "vdd-s5"),
-	RPMH_VREG("smps6",  "smp%s6",  &pmic4_hfsmps3,   "vdd-s6"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic4_nldo,      "vdd-l1-l6-l7"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic4_nldo,      "vdd-l2-l3"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic4_nldo,      "vdd-l2-l3"),
-	/* ldo4 is inaccessible on PM660 */
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic4_nldo,      "vdd-l5"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic4_nldo,      "vdd-l1-l6-l7"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic4_nldo,      "vdd-l1-l6-l7"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic4_pldo_lv,   "vdd-l8-l9-l10-l11-l12-l13-l14"),
-	RPMH_VREG("ldo9",   "ldo%s9",  &pmic4_pldo_lv,   "vdd-l8-l9-l10-l11-l12-l13-l14"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic4_pldo_lv,   "vdd-l8-l9-l10-l11-l12-l13-l14"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic4_pldo_lv,   "vdd-l8-l9-l10-l11-l12-l13-l14"),
-	RPMH_VREG("ldo12",  "ldo%s12", &pmic4_pldo_lv,   "vdd-l8-l9-l10-l11-l12-l13-l14"),
-	RPMH_VREG("ldo13",  "ldo%s13", &pmic4_pldo_lv,   "vdd-l8-l9-l10-l11-l12-l13-l14"),
-	RPMH_VREG("ldo14",  "ldo%s14", &pmic4_pldo_lv,   "vdd-l8-l9-l10-l11-l12-l13-l14"),
-	RPMH_VREG("ldo15",  "ldo%s15", &pmic4_pldo,      "vdd-l15-l16-l17-l18-l19"),
-	RPMH_VREG("ldo16",  "ldo%s16", &pmic4_pldo,      "vdd-l15-l16-l17-l18-l19"),
-	RPMH_VREG("ldo17",  "ldo%s17", &pmic4_pldo,      "vdd-l15-l16-l17-l18-l19"),
-	RPMH_VREG("ldo18",  "ldo%s18", &pmic4_pldo,      "vdd-l15-l16-l17-l18-l19"),
-	RPMH_VREG("ldo19",  "ldo%s19", &pmic4_pldo,      "vdd-l15-l16-l17-l18-l19"),
-	{}
-};
-
-static const struct rpmh_vreg_init_data pm660l_vreg_data[] = {
-	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd-s1"),
-	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic4_ftsmps426, "vdd-s3-s4"),
-	RPMH_VREG("smps5",  "smp%s5",  &pmic4_ftsmps426, "vdd-s5"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic4_nldo,      "vdd-l1-l9-l10"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic4_pldo,      "vdd-l2"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic4_pldo,      "vdd-l3-l5-l7-l8"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic4_pldo,      "vdd-l4-l6"),
-	RPMH_VREG("ldo5",   "ldo%s5",  &pmic4_pldo,      "vdd-l3-l5-l7-l8"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic4_pldo,      "vdd-l4-l6"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic4_pldo,      "vdd-l3-l5-l7-l8"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic4_pldo,      "vdd-l3-l5-l7-l8"),
-	RPMH_VREG("bob",    "bob%s1",  &pmic4_bob,       "vdd-bob"),
 	{}
 };
 
 static int rpmh_regulator_probe(struct platform_device *pdev)
@@ -1602,128 +433,16 @@ static int rpmh_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
 static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
-	{
-		.compatible = "qcom,pm8005-rpmh-regulators",
-		.data = pm8005_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm8009-rpmh-regulators",
-		.data = pm8009_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm8009-1-rpmh-regulators",
-		.data = pm8009_1_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm8010-rpmh-regulators",
-		.data = pm8010_vreg_data,
-	},
 	{
 		.compatible = "qcom,pm8150-rpmh-regulators",
 		.data = pm8150_vreg_data,
 	},
 	{
 		.compatible = "qcom,pm8150l-rpmh-regulators",
 		.data = pm8150l_vreg_data,
 	},
-	{
-		.compatible = "qcom,pm8350-rpmh-regulators",
-		.data = pm8350_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm8350c-rpmh-regulators",
-		.data = pm8350c_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm8450-rpmh-regulators",
-		.data = pm8450_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm8550-rpmh-regulators",
-		.data = pm8550_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm8550ve-rpmh-regulators",
-		.data = pm8550ve_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm8550vs-rpmh-regulators",
-		.data = pm8550vs_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm8998-rpmh-regulators",
-		.data = pm8998_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmg1110-rpmh-regulators",
-		.data = pmg1110_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmi8998-rpmh-regulators",
-		.data = pmi8998_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm6150-rpmh-regulators",
-		.data = pm6150_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm6150l-rpmh-regulators",
-		.data = pm6150l_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm6350-rpmh-regulators",
-		.data = pm6350_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmc8180-rpmh-regulators",
-		.data = pm8150_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmc8180c-rpmh-regulators",
-		.data = pm8150l_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmc8380-rpmh-regulators",
-		.data = pmc8380_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmm8155au-rpmh-regulators",
-		.data = pmm8155au_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmm8654au-rpmh-regulators",
-		.data = pmm8654au_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmx55-rpmh-regulators",
-		.data = pmx55_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmx65-rpmh-regulators",
-		.data = pmx65_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmx75-rpmh-regulators",
-		.data = pmx75_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm7325-rpmh-regulators",
-		.data = pm7325_vreg_data,
-	},
-	{
-		.compatible = "qcom,pmr735a-rpmh-regulators",
-		.data = pmr735a_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm660-rpmh-regulators",
-		.data = pm660_vreg_data,
-	},
-	{
-		.compatible = "qcom,pm660l-rpmh-regulators",
-		.data = pm660l_vreg_data,
-	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
 

-- 
2.45.2

