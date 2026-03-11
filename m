Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E47FD0651
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99D784178;
	Wed, 11 Mar 2026 15:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Bfb4Q/pZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D93384065; Wed, 11 Mar 2026 15:20:52 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB6284082
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-66132b22182so8345093a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773238850; x=1773843650; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5p0Yod4u0Hn9C2A0sgeaYN2CO0bI18GE9GVC0HlhK8w=;
 b=Bfb4Q/pZmtYe4CkWoq7mBKuzqKESeYNqyYG7kCJLk+rOW5Qif06GNnIc5Cz3Cd4ezH
 4RuG6O8fVIb15uSbECleZtLMgXnvhEHUyuYyNsAOUULu3df/V1lFw2zXkSXbuOXWc/1d
 tGlwnTCJ+ZfOCH8Y/CMHHp1YH8is9dqHhX0JPMChn9rE68d18O5GcE6QW9+idnDOBzwT
 YiSJ7clFCdC8y85pnqNFAH5QPl+28wupLmTknZd+w03z0C6jb207dVkUAbOp0VOk3mMO
 3vEXRLQIjKWBX8aavqq21xPVXvdyVAouUpL3LKUnpwwv+YYxZah84BSNiLbsD1ZVrpsp
 AydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773238850; x=1773843650;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5p0Yod4u0Hn9C2A0sgeaYN2CO0bI18GE9GVC0HlhK8w=;
 b=Ol9Kgx/oJ/cLm5kJPC8wIPLSWRO6xW/DeAIvjF42bICqWTHd7sk2e9ypI6seNTJyRw
 B2dsbHIN2RRPVUaJFF1xQjdr4/IYEh4H0vzFGom7lqVftbwNjl8zj3RCIdeGhPiV5S0s
 4G1rJbMn0JscP46s6WZusuX5IypOFRyZGvbfBWbGVcOE0nsJ+gnGjTeFDsHTHpXgFB/S
 fXO+jQ8BCAWI96plstLx9JRTFc+hD6K5R/fCY8SdjYabvePNf4+J5Lr5NhDkQatesrB6
 j4Gr7pieIkXdxeJwzXd/vM6zV5PE3zuAJ9B0qi4kDq+MdCJoIJzLSnU4z6PsN8bZXRai
 JeKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh8FtVILJ7f2YOwdcpXwDDReDDe8N/yOPSuly0bxLVJb093Re2mF3c1V51j8TGPHrCS2iqJyY=@lists.denx.de
X-Gm-Message-State: AOJu0YwBV7/Cul1ANkJLfWWyJpNrjrIMpGbW7Zlz41/Q9c2nKcr+55pI
 Yo0j9nbzBeWgGxuDHKFKIi1D+uG/bGY9nT48pJpbyYfBC0zbtt3uB1QNOTjculyk4n8=
X-Gm-Gg: ATEYQzzdvu6IUdu7w6N2wPsSDrPMr8Y2r8a8ilJGNiXw5u29VuSLjRNiHh4FR0OUv7P
 JMGMO7HGNsKrMXuWujAbGNch96kte3J3opiqvEcUDBrQqYkBz1tlciOIBlxaE4tH8nx8p5sBCpt
 H+ZYfQbxdZtHJOGqaxV3/wN2axNF4XsjGe6oT9V+tDq6zZ9d98dwajVayN9PNmHlmG2+v7bCOjT
 6XyVmHGrmHrAxYqdlsgKSMaZSBKE/ZQEd/e9fq6wX0pLzRRW2HWdnDB6ZAJ4pL6qUT/OdkmT0K2
 GMA/5PA9q23lYzP/p7aFw4P67SlX4mDpeep3PQdGwZnZytay2C5dAeJNf36E6WZZfiVqrPKZaCR
 qloM0ctMUCi2VjqGND8tQ69b7JB6sr50bs4Ur3eohkykpv5iWD+WK2J8rwNciPy/Miro0JC3pw5
 NQGExP8+0N8dNhV9E+jhTkVGariqfeBQl5bslZIXu+R7xKVYVR+B0cdw3i8O9ruFmN75/wD04ha
 nSuDw==
X-Received: by 2002:a05:6402:1449:b0:65f:a9f5:750b with SMTP id
 4fb4d7f45d1cf-66319cc2452mr1781852a12.15.1773238849602; 
 Wed, 11 Mar 2026 07:20:49 -0700 (PDT)
Received: from [172.16.240.100] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6631503c903sm543467a12.20.2026.03.11.07.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 07:20:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Mar 2026 15:20:44 +0100
Subject: [PATCH 4/7] regulator: qcom-rpmh-regulator: add support for PM7550
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-milos-bringup-v1-4-eb905c467f10@fairphone.com>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
In-Reply-To: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773238844; l=3213;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=roMoK2LgQ8SaczuYPMYPN9oy8X9NqJmQnXlRJH3yDW8=;
 b=5TApsVqBhDkA6JkMHTs42bLKlbpssQVxU8C09nodqGSBnb+PiUgKsdEkZbf4OKfxB2Xkf2In6
 vztGhx66uadA9SSE5EaOgWyCTWSDHe1caXEMja3R8w7Jzgv/WspcvWt
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

Add the PM7550 regulator data found on Qualcomm Milos devices.
The tables are imported from the Linux driver. The SMPS regulators were
not added now.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 3f0f1845469..4d65aae1690 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -640,6 +640,35 @@ static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pm7550_vreg_data[] = {
+	/* smps1 - smps6 are not added to u-boot yet */
+	RPMH_VREG("ldo1",  "ldo%s1",  &pmic5_nldo515,      "vdd-l1"),
+	RPMH_VREG("ldo2",  "ldo%s2",  &pmic5_nldo515,      "vdd-l2-l3"),
+	RPMH_VREG("ldo3",  "ldo%s3",  &pmic5_nldo515,      "vdd-l2-l3"),
+	RPMH_VREG("ldo4",  "ldo%s4",  &pmic5_nldo515,      "vdd-l4-l5"),
+	RPMH_VREG("ldo5",  "ldo%s5",  &pmic5_nldo515,      "vdd-l4-l5"),
+	RPMH_VREG("ldo6",  "ldo%s6",  &pmic5_nldo515,      "vdd-l6"),
+	RPMH_VREG("ldo7",  "ldo%s7",  &pmic5_nldo515,      "vdd-l7"),
+	RPMH_VREG("ldo8",  "ldo%s8",  &pmic5_nldo515,      "vdd-l8"),
+	RPMH_VREG("ldo9",  "ldo%s9",  &pmic5_nldo515,      "vdd-l9-l10"),
+	RPMH_VREG("ldo10", "ldo%s10", &pmic5_nldo515,      "vdd-l9-l10"),
+	RPMH_VREG("ldo11", "ldo%s11", &pmic5_nldo515,      "vdd-l11"),
+	RPMH_VREG("ldo12", "ldo%s12", &pmic5_pldo515_mv,   "vdd-l12-l14"),
+	RPMH_VREG("ldo13", "ldo%s13", &pmic5_pldo515_mv,   "vdd-l13-l16"),
+	RPMH_VREG("ldo14", "ldo%s14", &pmic5_pldo,         "vdd-l12-l14"),
+	RPMH_VREG("ldo15", "ldo%s15", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
+	RPMH_VREG("ldo16", "ldo%s16", &pmic5_pldo,         "vdd-l13-l16"),
+	RPMH_VREG("ldo17", "ldo%s17", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
+	RPMH_VREG("ldo18", "ldo%s18", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
+	RPMH_VREG("ldo19", "ldo%s19", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
+	RPMH_VREG("ldo20", "ldo%s20", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
+	RPMH_VREG("ldo21", "ldo%s21", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
+	RPMH_VREG("ldo22", "ldo%s22", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
+	RPMH_VREG("ldo23", "ldo%s23", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
+	RPMH_VREG("bob",   "bob%s1",  &pmic5_bob,          "vdd-bob"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
@@ -946,6 +975,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
 		.compatible = "qcom,pm7325-rpmh-regulators",
 		.data = (ulong)pm7325_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm7550-rpmh-regulators",
+		.data = (ulong)pm7550_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8150-rpmh-regulators",
 		.data = (ulong)pm8150_vreg_data,

-- 
2.53.0

