Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A785CD3448
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E22F88C21;
	Tue,  3 Sep 2024 18:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iipw5dyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACDE38841E; Tue,  3 Sep 2024 18:13:38 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2625E88A0A
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374ba4e094aso2527263f8f.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725380015; x=1725984815; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lYugHg9w4t1Ub63UYl/9rcAF1NKvyqgE2W84/KqQrWc=;
 b=iipw5dyWeGRl9KgeiOSOGER4QVYtitIBlN6U9dqT5QBAw2tMRqjYV03ERlZtgEJofK
 l0Gp/siXsNbrL47rWfpMQW+L+edErH1hX40lpBGyGqOanNdN3e3q01UUjkJQUWzl+orA
 e17DiTDdVruXzJc4UuOJrFjR9kjSnq7Pkc95/utqhjsrApK4vnryEKKB9H+mhdsHq+pP
 R4z5SbW0WkFzZktCjKXDAJCasZP7wSMiBV0gOWklQobi+AgvdwKAUk+jDpOMG5B5jgSO
 40jHsLKHNyyimZCl5oD2tRPf8rogLXvtF0jBSpmVd03Zzvdk0M01QDl3Qnt8I+JEfhp0
 /dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725380015; x=1725984815;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYugHg9w4t1Ub63UYl/9rcAF1NKvyqgE2W84/KqQrWc=;
 b=MFrV/O2Du/r6j8PvLwg6wr8n/sKawxNsR/J28u/uK7TCFpqBzfytd1rnTiOLGsqCuP
 4o7e7wfWWalKcjlY6e41KUvmAy2hvt41Ar7vMEnwO04TuZCl1dBWW8v/xcbrvsboe9wb
 OqWQTAjuthfkRpv9omQixolcjuvHAjGUfjAlfduftWi8OT+DCs2CJj7guYh7xQ6/jOLC
 yoeG3YKoKe+W18Pq4eBMTTW7KIgOX591HTX8DWdyH2Lp8rzhT3GS96t2NKNIoEq14RCH
 4kwqRCAawFpM6H8ekbdUg9GlRegTPX8XpeEQ1xPqdTtmAykMaA1sWjcpUKdjpvuG6vDE
 KoXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXneMUIl8gy1auOfr1A3xoJTHsBX99yf4hTFZZt2Vib2V5y85icQSbv+c/rTipwBFVnI9ctbRs=@lists.denx.de
X-Gm-Message-State: AOJu0YznlaMfGmSnakhS7rp+xfTt7mM/wD0tUvlHNn8ngTHOUljOAvnL
 bAlsnQDyA9WwkHWejiF0Ouf4Y4nPj/r2+Oqh8s8pvQ7xOp4S2SMsXOJy1hSTbAc=
X-Google-Smtp-Source: AGHT+IEFPNdAlX+/ngi/Ty1labMCAYBcGS7O3M09abXDZEMljy1Lwh8zUYcyVxcmN7R3K7yUFNpP0Q==
X-Received: by 2002:adf:e592:0:b0:34d:ae98:4e7 with SMTP id
 ffacd0b85a97d-374bf1c7b74mr7166054f8f.41.1725380015140; 
 Tue, 03 Sep 2024 09:13:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3767dc16f83sm1807517f8f.60.2024.09.03.09.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:13:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 03 Sep 2024 18:13:31 +0200
Subject: [PATCH 2/2] regulator: qcom-rpmh-regulator: add support for PM8550
 & related regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-topic-sm8x50-regulators-support-v1-2-0857185bddc0@linaro.org>
References: <20240903-topic-sm8x50-regulators-support-v1-0-0857185bddc0@linaro.org>
In-Reply-To: <20240903-topic-sm8x50-regulators-support-v1-0-0857185bddc0@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6802;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Fid6fZeFw3Kvdjg+Sw1MrfbE1HxCCFoaWW5H7HMfB8s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm1zWsfmrkr15MVyRItKsgi5Xrm8X8HJA2rd4uv7xu
 qidHGEmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZtc1rAAKCRB33NvayMhJ0YujD/
 9b0oU8OLLijlnXNF6ucwDxji0Iu3oS9gvlRcjEJ7KIDbS4Jx7608pV3F8Ht2Uud+VAHka3zGGnvWAF
 B8kUyN41G4fdwCSBKtixtWeL9AM4VK7nwm0GTZtsz9CYxM0dW722uRdBnr9+s4+XO7ZNcb3PbnZVrP
 SYRAvwlt75Jd3nupCSiFq1+90ofOqmT0AGvatLCAiIa2F1kia223M/kJhDuxyvoWDoHUjzYkCDMesv
 dbXXjZmWOJxgIzc8EbXu2Q0MH+2JerZZ+tNxlnTWdhWoH02nMXdlAWvIkAqZX3E9XL6LN8i36UkHBE
 tFLUOGyCFf6rHzGj/oyj9J2AL5nEqcS7Bzq8dPNk1egTUjWW/U8/GjlzEL7zH3doKVOj1Mgbcj7Hqt
 5rHVYtDORp2ecmWxbV2ZI9yo6VmWgFrEWXQpdlupPl81zKd2d4as1S19QzHSkVHTzUEUwp4dLEqYsN
 wHOckkNgDYHx3Zcg0/+i6Ft+wbWHSeAGPMNSPrODbNz9zCEx8IAEJD8osRsFjpOU+FPP6uN13rXmZs
 ZwMOdhB9UpXXkIam6tfDSN2DZou4SaCAoPL9v1sTVsH1YaNyjM9NndhO/ipJTeUXbctd45GWL8tAAm
 9t7Z2QOFNwVP483rKgQpzeA5oM5LnmAi1TE2+EbHAvay2av6Orgtc4zR10OQ==
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

Add the PM8550 & related regulators found on the SM8550 and SM8650 platforms.
The tables are imported from the Linux driver.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 136 ++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 06fd3f31956..2dc261d83e3 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -357,6 +357,69 @@ static const struct dm_regulator_ops rpmh_regulator_vrm_drms_ops = {
 	.get_mode = rpmh_regulator_vrm_get_mode,
 };
 
+static struct dm_regulator_mode pmic_mode_map_pmic5_bob[] = {
+	{
+		.id = REGULATOR_MODE_LPM,
+		.register_value = PMIC5_BOB_MODE_PFM,
+		.name = "PMIC5_BOB_MODE_PFM"
+	}, {
+		.id = REGULATOR_MODE_AUTO,
+		.register_value = PMIC5_BOB_MODE_AUTO,
+		.name = "PMIC5_BOB_MODE_AUTO"
+	}, {
+		.id = REGULATOR_MODE_HPM,
+		.register_value = PMIC5_BOB_MODE_PWM,
+		.name = "PMIC5_BOB_MODE_PWM"
+	},
+};
+
+static struct dm_regulator_mode pmic_mode_map_pmic5_smps[] = {
+	{
+		.id = REGULATOR_MODE_RETENTION,
+		.register_value = PMIC5_SMPS_MODE_RETENTION,
+		.name = "PMIC5_SMPS_MODE_RETENTION"
+	}, {
+		.id = REGULATOR_MODE_LPM,
+		.register_value = PMIC5_SMPS_MODE_PFM,
+		.name = "PMIC5_SMPS_MODE_PFM"
+	}, {
+		.id = REGULATOR_MODE_AUTO,
+		.register_value = PMIC5_SMPS_MODE_AUTO,
+		.name = "PMIC5_SMPS_MODE_AUTO"
+	}, {
+		.id = REGULATOR_MODE_HPM,
+		.register_value = PMIC5_SMPS_MODE_PWM,
+		.name = "PMIC5_SMPS_MODE_PWM"
+	},
+};
+
+static const struct rpmh_vreg_hw_data pmic5_bob = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(3000000, 0, 31, 32000),
+	.n_voltages = 32,
+	.pmic_mode_map = pmic_mode_map_pmic5_bob,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_bob),
+};
+
+static const struct rpmh_vreg_hw_data pmic5_ftsmps525_lv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 267, 4000),
+	.n_voltages = 268,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
+};
+
+static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(600000, 0, 267, 8000),
+	.n_voltages = 268,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
+};
+
 static struct dm_regulator_mode pmic_mode_map_pmic5_ldo[] = {
 	{
 		.id = REGULATOR_MODE_RETENTION,
@@ -393,6 +456,16 @@ static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
 	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
 };
 
+static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 210, 8000),
+	.n_voltages = 211,
+	.hpm_min_load_uA = 30000,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
+};
+
 #define RPMH_VREG(_name, _resource_name, _hw_data, _supply_name) \
 { \
 	.name		= _name, \
@@ -412,6 +485,57 @@ static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pm8550_vreg_data[] = {
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,    "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,    "vdd-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo515,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,    "vdd-l5-l16"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo, "vdd-l6-l7"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo, "vdd-l6-l7"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo, "vdd-l8-l9"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,    "vdd-l8-l9"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo515,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo515,    "vdd-l11"),
+	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_nldo515,    "vdd-l12"),
+	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,    "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo,    "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo515,    "vdd-l15"),
+	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,    "vdd-l5-l16"),
+	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,    "vdd-l17"),
+	RPMH_VREG("bob1",   "bob%s1",  &pmic5_bob,     "vdd-bob1"),
+	RPMH_VREG("bob2",   "bob%s2",  &pmic5_bob,     "vdd-bob2"),
+	{}
+};
+
+static const struct rpmh_vreg_init_data pm8550vs_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps525_lv, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps525_lv, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps525_lv, "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps525_lv, "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps525_lv, "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps525_mv, "vdd-s6"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,   "vdd-l1"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo515,   "vdd-l2"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,   "vdd-l3"),
+	{}
+};
+
+static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
+	RPMH_VREG("smps1", "smp%s1", &pmic5_ftsmps525_lv, "vdd-s1"),
+	RPMH_VREG("smps2", "smp%s2", &pmic5_ftsmps525_lv, "vdd-s2"),
+	RPMH_VREG("smps3", "smp%s3", &pmic5_ftsmps525_lv, "vdd-s3"),
+	RPMH_VREG("smps4", "smp%s4", &pmic5_ftsmps525_mv, "vdd-s4"),
+	RPMH_VREG("smps5", "smp%s5", &pmic5_ftsmps525_lv, "vdd-s5"),
+	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
+	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
+	RPMH_VREG("smps8", "smp%s8", &pmic5_ftsmps525_lv, "vdd-s8"),
+	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo515,   "vdd-l1"),
+	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo515,   "vdd-l2"),
+	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo515,   "vdd-l3"),
+	{}
+};
+
 /* probe an individual regulator */
 static int rpmh_regulator_probe(struct udevice *dev)
 {
@@ -526,6 +650,18 @@ static const struct udevice_id rpmh_regulator_ids[] = {
 		.compatible = "qcom,pm8150l-rpmh-regulators",
 		.data = (ulong)pm8150l_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8550-rpmh-regulators",
+		.data = (ulong)pm8550_vreg_data,
+	},
+	{
+		.compatible = "qcom,pm8550ve-rpmh-regulators",
+		.data = (ulong)pm8550ve_vreg_data,
+	},
+	{
+		.compatible = "qcom,pm8550vs-rpmh-regulators",
+		.data = (ulong)pm8550vs_vreg_data,
+	},
 	{ /* sentinal */ },
 };
 

-- 
2.34.1

