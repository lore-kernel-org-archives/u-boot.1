Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACB4C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB14182E66;
	Wed, 18 Jun 2025 16:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="S2ocy/Jt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8734F82BCD; Wed, 18 Jun 2025 16:25:35 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EA782BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ade76b8356cso1403069966b.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750256732; x=1750861532; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O49phv1pHLo9APZEKDYUJyK9zCnTMAIdXRA1qzjrHXQ=;
 b=S2ocy/JtuMjLYMXPhXMhSJ0MZlOYbOO86xAzvQhuOwzKQAJ3r1+8osc+u91fu/fZQu
 BxNuCA8EqbNejHaQ6V+VAf8p9Idf371wj80Z5mgp00BoWLWAO+l38OAKMvtErxgF2ljH
 xSl07CmC42Odkj0G3Og9NYmEu6mct2b12FHJcoEHh+v5ceyOlapvCB+wcrAPdn0msBsJ
 HoG1pS60F8kYH98KjVpAsCRfxvJ2wPboQdWy5ycj9yWlKHM3SZXUODbCOcijgryKDB0y
 k3mtZOkOusiwljpX7VrS7gIdWnKW21qZTOJUm9wpb/JKGMECSjU09Yq7J0xLsBLHQ8Ft
 dpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256732; x=1750861532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O49phv1pHLo9APZEKDYUJyK9zCnTMAIdXRA1qzjrHXQ=;
 b=nYQzAEGzYtFHTn2TEKwptpYaEtbonapPt41Fw2QWtbvjzMiVlcPo8WXj8b+UDMtjNo
 AJpfVwE/CNGwj06MZbH9Hu1PQUs5y6keBHKhM6DwTEn+EPmY2IbGF53NA5Sj0UsRYPYz
 aY0zIheyiIA1zql/OJt8Ey1k1YWOsrMYtf1MXtYFJqVVTXk2rfqt2bogW2uhF8M9dxCb
 lwtQWlifGLVw4dhCW1VL9vQ6csFQwcXzgwQ3T+GbNEBiazEUsa+xGWG52l8/9sxaLsnI
 Es1t1ZDUDsKyGh2fzevvOwYWjcHAKtr+if6HpLbmVn/n0oJTFh+snGI57o6tdgk4VHk4
 z3ew==
X-Gm-Message-State: AOJu0YzZDWEzuZSf58jyWIv97d/puT6/K9vblHYGxD4ttzFKcS17NlQE
 YigJ61l3Lv3+NaR7X/sJtrsb2p8l74KcBN36xajuCmsONVIb6VO1Ta/APW2ReeZw1n4=
X-Gm-Gg: ASbGnctS9ughl9tzw5AVUTxrrrqpCmyyQ10KtTBPEnvcPyhtCEm0IUUJXgWRzTV+Hhy
 HqQSBfIlnJX5omRRcpVQcnXrJko6WtzIEBsnMHeTpkGA9HrLMBrJLRqLaJWkEN53hWBfZWPJd42
 CzQDJE7l4gqvLTPuVmh+bHe8tebuqklrG03semPo7Ga21OBef3dNytLSIy9cPQdzc7R3T6nnHiK
 ZhvmscEGAgF7RLIJxvH+qWOB76XzUxS83bBe1bfuipH3jwfIJI9E+wA14bDJzQV2N9VAXZMEfkQ
 0UHIBzdU3oNbF4C0Ma7Mnpsv/VssITEMUUKQu6bzPfNevIb7/hdrn7G7CbpYFpVa2eMBc3KqQh3
 9m/9DevWEHfn5RqO8OH6mVhLCFX5ETw0M
X-Google-Smtp-Source: AGHT+IFHLOcQYOaRZA61pFwrSL8wQUaj7i/ok2fVHUOUM+P+swPgW2/Z2uWiF7Jru2NS8p0eagVV1w==
X-Received: by 2002:a17:907:2d2c:b0:ad9:db54:ba47 with SMTP id
 a640c23a62f3a-adfad60904bmr1874058066b.43.1750256732160; 
 Wed, 18 Jun 2025 07:25:32 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec8159e19sm1056733866b.4.2025.06.18.07.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:25:31 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Jun 2025 16:25:22 +0200
Subject: [PATCH 6/8] regulator: qcom-rpmh-regulator: add support for
 pm6150l regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-sm6350-bringup-v1-6-3cc22aab7a7a@fairphone.com>
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
In-Reply-To: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750256728; l=2797;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ZuNogaN1HdbgFo5n33w3n478T0GqsTPPRrrR1Sy+cY0=;
 b=M9iKa7i7FeVVidMLvyxQE4t1s75Izzx6PXjy0Ww1v5FPKDpecCd4ISBTx3IiRlaHUM+gOwjaQ
 FHVxxB7pQtQAyWhhVaIjT4FPYlu1KAc2ZVR+cjZPxvK3C960JQw/nVl
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Jun 2025 16:45:31 +0200
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

Add the pm6150l regulator data found on the Qualcomm SM6350 platform.
The tables are imported from the Linux driver. The SMPS regulators were
not added now.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 954deca5ed75ca4f58898ee401bd06c9da82e56e..0646614256049e49846aa257bd02466fb9cf59d7 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -456,6 +456,16 @@ static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
 	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
 };
 
+static const struct rpmh_vreg_hw_data pmic5_nldo = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 123, 8000),
+	.n_voltages = 124,
+	.hpm_min_load_uA = 30000,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
+};
+
 static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
@@ -493,6 +503,23 @@ static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
 	.supply_name	= _supply_name, \
 }
 
+static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
+	/* smps1 - smps8 are not added to u-boot yet */
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2-l3"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l2-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l4-l5-l6"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l4-l5-l6"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l4-l5-l6"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l11"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo,      "vdd-l1-l8"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l9-l10"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
+	RPMH_VREG("bob",    "bob%s1",  &pmic5_bob,       "vdd-bob"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
 	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
 	{}
@@ -705,6 +732,10 @@ static int rpmh_regulators_bind(struct udevice *dev)
 }
 
 static const struct udevice_id rpmh_regulator_ids[] = {
+	{
+		.compatible = "qcom,pm6150l-rpmh-regulators",
+		.data = (ulong)pm6150l_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8150-rpmh-regulators",
 		.data = (ulong)pm8150_vreg_data,

-- 
2.50.0

