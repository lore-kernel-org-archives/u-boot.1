Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0F0CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BDB483759;
	Wed, 17 Sep 2025 18:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="FXjhfayb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A3E0835B2; Wed, 17 Sep 2025 14:47:57 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE9C3835B3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b0473327e70so522773966b.3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113274; x=1758718074; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fqsMwdhsi8Vo8YzU4S+YG5nXvs4LNSXVVvA9d6P6HiQ=;
 b=FXjhfaybHuozTDFXn/o6CzgG0YVrf8MsF2uP9OwAxqXpEhUvvlY2Z+DzXeV6FD2HNY
 sPFVFgAG77qj2DnB2Gs8xq9AU+bQUoGe56vOQ5AVpiNgEaJ1wzvu/hZLnc7UKeznFbeG
 iThveJRS4oK/bvjTy1xm/KKewKr/WP6GEzhPueJGIiVe0CDcRqppCk4u28YTMyACABcy
 hj1LxGC1A9MbBtS6GvGHFwr1elRzYoaO9HND2ThcB/MRNcBsE98fpopt58nwrBnrSoTJ
 1bRpVxJuLiR7gOQa61lSqemlkKY1tA8fdeigi6O6fSxPPQheItVRcAydwe351pM8hvsy
 ifgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113274; x=1758718074;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqsMwdhsi8Vo8YzU4S+YG5nXvs4LNSXVVvA9d6P6HiQ=;
 b=NvkW9AJSbSrSbn2ds+RCSL/VdkDA0M1Ktt8bFSLcRx6SmONN7S8sYN/EdRBJr78mtr
 N7bpoZG6A+oYU/dEX7kbaa89tb6+ryBWwK5N8p07dAUbx3CipY+t2otVGdw7AXvBeOoC
 7POCJqK5rDQwwPtqPMRe3M11HyWef/hNZ2knqLt08rrA5/ER/10aM3kPC0AILI4fH4CY
 3fYX6BgnLq1X7YcNTHaElP9zm0eENqO5/dNqGFMBpyKMu5Axqb6ULpvfinImwOVJroC6
 jgHOrdxFY0xlxaQY9GRWxIyOmzc2vtSZx6PvM2yzlgrzQRJrjHvaRZdZQk/Lbb0HynCe
 KUpw==
X-Gm-Message-State: AOJu0YyfRm+oe46Vy3qWuELXKPGHs5spm5pDa2+AJFRY4pzzq5OPsh4y
 4iwDx05xoOw1tmEO2L8EJQrSKBUHJVKRF6H8dbNtrVJ3Idph9wFoLHUJeEKFcD4gdBg=
X-Gm-Gg: ASbGncuMX+5xrD1VLQbBYuC+QD4QHu1UbDpclTgBYcFvmRdtBWPrxcCkkNd6c97G2fQ
 JZwa4A7nTVZdLFhnQ6/xBNGzjDHQ8lt6yi792ymKgWaAfCRrnbUOA+dWG3QdPrT/F8S2m/pEGzU
 KVLCboUq5C6CdORZHttS4M0w8b3exlDtnOFBO3BXes5kL9S1g2lF0Owu8IG7fo8NR8AT2gvLu1B
 jtPH2IuDTt+m2zGSmaHAQuynuYL76gwxkj3qB9TlPHZK49dFU9kIDcaKB++Gc5Zu0HG/urW4AGA
 39gYqz1yHBvx5P9pB9gNUcOcNZXopz2bIluPih2eLCD2KCuTgTPMIapnM9/e5iobqigxL9mE7ag
 SAgaiCvpNhvSNHz4DaAipaQzSa2SY7PqiT8okvnG6qVRXq4zR2nRzbYW3bmksOxF6lRKxkg==
X-Google-Smtp-Source: AGHT+IHdUKeyGYxWZ7r8tiwy+9fmyOZA28agXF+OIocyV6vaw7sc3gKWHQt0Eyk+YoxUJ5ctqcPgNg==
X-Received: by 2002:a17:907:9721:b0:b04:21c9:adac with SMTP id
 a640c23a62f3a-b1bb8ca528bmr235722366b.39.1758113274201; 
 Wed, 17 Sep 2025 05:47:54 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b08cab32303sm937441866b.72.2025.09.17.05.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:47:53 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 17 Sep 2025 14:47:39 +0200
Subject: [PATCH v2 6/9] regulator: qcom-rpmh-regulator: add support for
 pm6150l regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sm6350-bringup-v2-6-13346fc2a2f6@fairphone.com>
References: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
In-Reply-To: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113268; l=2854;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=kg8BwKkS2AzqiEESlTbfieSc0pckNpf8iDssi6Jjbv0=;
 b=FLP+VDAXFKPJEP0oVt5Y8HRtwyVvgn1Zhmn0YXqXi7KIQxUGzf6yX0hCTi3ES3YBauWTVqUDN
 T+2fH61pj2KD6e8Upl2XoIrvvFeR+6cyAGmPo3H7591Bga/s/M9ig14
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:22:41 +0200
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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
2.51.0

