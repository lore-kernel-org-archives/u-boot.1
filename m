Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB8DC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 19:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A74484C02;
	Thu,  9 Jul 2026 21:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WdCF+XsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7F884C0B; Thu,  9 Jul 2026 21:11:06 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EACA84B3B
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 21:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsankouski@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c15cd3fd760so24420566b.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783624264; x=1784229064; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=22BcOUgsIYhEqVGM0vREHXnwXkut2WlJSy9L6D4JOJ0=;
 b=WdCF+XsSk4whIsINLByuVAtO7MWwmRc6w7VXrD2M/NEiob68GuYz5wMQNrWaEehbR6
 9qF1jHul7TgNA2BgiPmudQIjMa9UBouJR2c1MDtIJZT/SyNM8fFnRxuiogjO9M3uCSsv
 1dqiSf6KK2GtStvwxwmtSILjSdt5juTQEjKdC4zaXBOnEcAGnz56ZNkpv9BUFBDD7xHv
 wYdFBUl7SVUM3W2oF3bSDLMzxMzQYm6nj2WkCPrv28hU0RQ5qpeuQE2X5PvkyDZfT5AI
 jff1dmkHXUZ3jY8OYy03f8GrHsj5wyV28JrZNBy6fmbIha7VQeDjb9sk319XarjZsYA1
 zLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624264; x=1784229064;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=22BcOUgsIYhEqVGM0vREHXnwXkut2WlJSy9L6D4JOJ0=;
 b=sT5E3hbL1k++lpJQ+cJpCuHlzdKYoXgDKxbDhsF4LOOTYdWKLxUzVXv/79BchHCZBs
 Peqr7GKHK+SCw81buxMxKcSCukh+K0y5iXEj7j5i+nr2EfOP7RcvW6K1enunW7Y0ltD0
 O7zGOZMvEp1kcJ1krVw8xBKi8LCoHrWzTrdiEv6ph0gZ1IMpawDSSylkmeVgQE1nHWqU
 HIOnoVDsZsZDp5bsxDSg04CqGcEgrxRT+KWQVfSbx5EiueswcxT5bPl27ujBoiCZqu7n
 0i+hGH9qT56uIh6e6UDj8FjuBsW2TpK9CfnA/qIudFiMFJiqSYjdRg3mWoyWrg5VQ2YS
 mevg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1qqmPC/8S4pF7huatWFuzHjD4VXhS8St6jP6i0PqixFpbAo09eJlC3gEf4wErvgAkPi4/Fx8=@lists.denx.de
X-Gm-Message-State: AOJu0YwhrxAw2pNRf8rVk/LrqqyKdN3mfYvyzj9Qj+pCLe1ktnOHLttc
 y4xKey4VDrMSd2+Lz2fZ5iiJ3wo3pLZIuAL6nkRL3bN2/rBreaeKl465
X-Gm-Gg: AfdE7ckYOiD9CUR9D3ELooAX0ggHvV1uaodEUlGSwgFjLgmbIMyJhNXdo2wqp7TqUs9
 snMVUvAqdYUgW1LvkeNfhUegNq0HBmhFOnMSoQ2htztGwT9sQyPOyUCkMlPbcwNq3IIoPtRWDgc
 w1gQaObXb0KLPRuksH7dsjOdqbfY/l1IwCjg8dGVV6lNBdwtwHHtjoHoGyV6X0Zss7SRkqK9rl7
 lUWXvL2zGjLJAtep82vpbcVQ8Xqg1f/VTAB5V05mzbEx6hI1DnavbB4ezximEhGug7kbfGa02SQ
 WRndrDHfWxb3RnS/4yESi9qXc4oz4TZYZocEKMJ9ttKNWgM13a92R8eQIza+wtOLav3VIvV3oyo
 lXq5Aod4Cic3/UBcUQBpQyeMdjUXqhFgC3m2/VcyqYk5CBEXACx8eSlinc4zRQuhVKpkMhSbQma
 SzWhXZ4KGPVw==
X-Received: by 2002:a17:906:9fcd:b0:c12:1992:2ca4 with SMTP id
 a640c23a62f3a-c15cdec79f2mr471283966b.2.1783624262524; 
 Thu, 09 Jul 2026 12:11:02 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.244.65])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c15ad82311fsm546846366b.8.2026.07.09.12.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 12:11:01 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 09 Jul 2026 22:10:34 +0300
Subject: [PATCH] regulator: qcom-rpmh-regulator: add support for PM8998
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-b4-pm8998_rpmh_regulators-v1-1-dd8efec64afd@gmail.com>
X-B4-Tracking: v=1; b=H4sIACnyT2oC/yXMQQqDMBBA0avIrBuIoWjSq5QiJhl1StUwo6Ug3
 r1Rl2/x/waCTCjwKDZg/JLQPGWUtwLC0E49KorZYLSpdK2d8neVRuucbTiNQ8PYr592mVlULKv
 a2+iCNxFynxg7+p3v5+uyrP6NYTmGsO9/jYEgcn0AAAA=
X-Change-ID: 20260709-b4-pm8998_rpmh_regulators-d167b8d9cb2d
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783624260; l=7796;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=MHuYvQ9wCIuKEmXwNUGMrDUcqOvIFcb30eOhVLHEWOQ=;
 b=jZeDySMnafeIFMxR28661cIO+TZyOlLjePKS9px8E+ka42VSPGCaaxPCRd3cENLEkZjK8Vzxs
 Hik2mC2t3GHCxhp4/m+FXCnMbRuVfVinwjXyaHvGdDb4Ui3l6WIjcQ+
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=
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

Add the PM8998 regulator data found on Qualcomm platforms.
These regulator tables are imported from the Linux driver
to enable support for these PMICs in U-Boot.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Add the PM8998 regulator data found on Qualcomm platforms.
These regulator tables are imported from the Linux driver
to enable support for these PMICs in U-Boot.

This is used by starqltechn sdcard.
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 133 ++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index c458f227bed..caeba4c8ee6 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -464,6 +464,26 @@ static struct dm_regulator_mode pmic_mode_map_pmic5_bob[] = {
 	},
 };
 
+static struct dm_regulator_mode pmic_mode_map_pmic4_smps[] = {
+	{
+		.id = REGULATOR_MODE_RETENTION,
+		.register_value = PMIC4_SMPS_MODE_RETENTION,
+		.name = "PMIC4_SMPS_MODE_RETENTION"
+	}, {
+		.id = REGULATOR_MODE_LPM,
+		.register_value = PMIC4_SMPS_MODE_PFM,
+		.name = "PMIC4_SMPS_MODE_PFM"
+	}, {
+		.id = REGULATOR_MODE_AUTO,
+		.register_value = PMIC4_SMPS_MODE_AUTO,
+		.name = "PMIC4_SMPS_MODE_AUTO"
+	}, {
+		.id = REGULATOR_MODE_HPM,
+		.register_value = PMIC4_SMPS_MODE_PWM,
+		.name = "PMIC4_SMPS_MODE_PWM"
+	},
+};
+
 static struct dm_regulator_mode pmic_mode_map_pmic5_smps[] = {
 	{
 		.id = REGULATOR_MODE_RETENTION,
@@ -484,6 +504,24 @@ static struct dm_regulator_mode pmic_mode_map_pmic5_smps[] = {
 	},
 };
 
+static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	.n_voltages = 216,
+	.pmic_mode_map = pmic_mode_map_pmic4_smps,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_smps),
+};
+
+static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
+	.n_voltages = 259,
+	.pmic_mode_map = pmic_mode_map_pmic4_smps,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_smps),
+};
+
 static const struct rpmh_vreg_hw_data pmic5_bob = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
@@ -563,6 +601,52 @@ static struct dm_regulator_mode pmic_mode_map_pmic5_ldo[] = {
 	},
 };
 
+static struct dm_regulator_mode pmic_mode_map_pmic4_ldo[] = {
+	{
+		.id = REGULATOR_MODE_RETENTION,
+		.register_value = PMIC4_LDO_MODE_RETENTION,
+		.name = "PMIC4_LDO_MODE_RETENTION"
+	}, {
+		.id = REGULATOR_MODE_LPM,
+		.register_value = PMIC4_LDO_MODE_LPM,
+		.name = "PMIC4_LDO_MODE_LPM"
+	}, {
+		.id = REGULATOR_MODE_HPM,
+		.register_value = PMIC4_LDO_MODE_HPM,
+		.name = "PMIC4_LDO_MODE_HPM"
+	},
+};
+
+static const struct rpmh_vreg_hw_data pmic4_pldo = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
+	.n_voltages = 256,
+	.hpm_min_load_uA = 10000,
+	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_ldo),
+};
+
+static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
+	.n_voltages = 128,
+	.hpm_min_load_uA = 10000,
+	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_ldo),
+};
+
+static const struct rpmh_vreg_hw_data pmic4_nldo = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
+	.n_voltages = 128,
+	.hpm_min_load_uA = 30000,
+	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_ldo),
+};
+
 static const struct rpmh_vreg_hw_data pmic5_pldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
@@ -837,6 +921,51 @@ static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pm8998_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic4_hfsmps3,   "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic4_hfsmps3,   "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic4_hfsmps3,   "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic4_ftsmps426, "vdd-s6"),
+	RPMH_VREG("smps7",  "smp%s7",  &pmic4_ftsmps426, "vdd-s7"),
+	RPMH_VREG("smps8",  "smp%s8",  &pmic4_ftsmps426, "vdd-s8"),
+	RPMH_VREG("smps9",  "smp%s9",  &pmic4_ftsmps426, "vdd-s9"),
+	RPMH_VREG("smps10", "smp%s10", &pmic4_ftsmps426, "vdd-s10"),
+	RPMH_VREG("smps11", "smp%s11", &pmic4_ftsmps426, "vdd-s11"),
+	RPMH_VREG("smps12", "smp%s12", &pmic4_ftsmps426, "vdd-s12"),
+	RPMH_VREG("smps13", "smp%s13", &pmic4_ftsmps426, "vdd-s13"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic4_nldo,      "vdd-l1-l27"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic4_nldo,      "vdd-l2-l8-l17"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic4_nldo,      "vdd-l3-l11"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic4_nldo,      "vdd-l4-l5"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic4_nldo,      "vdd-l4-l5"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic4_pldo,      "vdd-l6"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic4_nldo,      "vdd-l2-l8-l17"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic4_pldo,      "vdd-l9"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic4_pldo,      "vdd-l10-l23-l25"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic4_nldo,      "vdd-l3-l11"),
+	RPMH_VREG("ldo12",  "ldo%s12", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo13",  "ldo%s13", &pmic4_pldo,      "vdd-l13-l19-l21"),
+	RPMH_VREG("ldo14",  "ldo%s14", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo15",  "ldo%s15", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo16",  "ldo%s16", &pmic4_pldo,      "vdd-l16-l28"),
+	RPMH_VREG("ldo17",  "ldo%s17", &pmic4_nldo,      "vdd-l2-l8-l17"),
+	RPMH_VREG("ldo18",  "ldo%s18", &pmic4_pldo,      "vdd-l18-l22"),
+	RPMH_VREG("ldo19",  "ldo%s19", &pmic4_pldo,      "vdd-l13-l19-l21"),
+	RPMH_VREG("ldo20",  "ldo%s20", &pmic4_pldo,      "vdd-l20-l24"),
+	RPMH_VREG("ldo21",  "ldo%s21", &pmic4_pldo,      "vdd-l13-l19-l21"),
+	RPMH_VREG("ldo22",  "ldo%s22", &pmic4_pldo,      "vdd-l18-l22"),
+	RPMH_VREG("ldo23",  "ldo%s23", &pmic4_pldo,      "vdd-l10-l23-l25"),
+	RPMH_VREG("ldo24",  "ldo%s24", &pmic4_pldo,      "vdd-l20-l24"),
+	RPMH_VREG("ldo25",  "ldo%s25", &pmic4_pldo,      "vdd-l10-l23-l25"),
+	RPMH_VREG("ldo26",  "ldo%s26", &pmic4_nldo,      "vdd-l26"),
+	RPMH_VREG("ldo27",  "ldo%s27", &pmic4_nldo,      "vdd-l1-l27"),
+	RPMH_VREG("ldo28",  "ldo%s28", &pmic4_pldo,      "vdd-l16-l28"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
@@ -1010,6 +1139,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
 		.compatible = "qcom,pm8550vs-rpmh-regulators",
 		.data = (ulong)pm8550vs_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8998-rpmh-regulators",
+		.data = (ulong)pm8998_vreg_data,
+	},
 	{
 		.compatible = "qcom,pmc8380-rpmh-regulators",
 		.data = (ulong)pmc8380_vreg_data,

---
base-commit: a18265f1ccb7a272721ed4286ed3b5a6182ff424
change-id: 20260709-b4-pm8998_rpmh_regulators-d167b8d9cb2d

Best regards,
--  
Dzmitry Sankouski <dsankouski@gmail.com>

