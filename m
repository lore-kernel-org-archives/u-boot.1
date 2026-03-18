Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402DD103E18F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E094B8407F;
	Wed, 18 Mar 2026 15:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Yjz4bQjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54DFB84142; Wed, 18 Mar 2026 13:47:04 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CF784213
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 13:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so116551866b.3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773838020; x=1774442820; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QgR1e4ygQPp+Xltsrr9i+j8pAtuxhN76CwrS+Gph05Q=;
 b=Yjz4bQjRm1chPo03X5+94W1+ZRXvPh//JS0L1gus5WHxRtt4+1OFzNitgjDQ5V/6xq
 CY8e4MeS8Ut5DPI5MgSV5+QwXM0rDenh9ZVySsV0yAnyX3bXXQggezA6V9iiru04Uiri
 uVD1KXV/yR/oZCPcLerHWQv0xXhT0Mcj+uMG//SQHAmvAjJs7rNqkU3q1DSkMrbYRtWQ
 jCSaUKD9+ohLquta630yomJWIx09BKukTZJmtVjedMipoDtPruK22DGprteGO+gcEYoG
 kNjByYaX2ov+rILxMOI2AHSdwUqNK3MNeeI2tDMuuh14yEiUKH54OW9YFl+S2lmH2T1M
 jHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773838020; x=1774442820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QgR1e4ygQPp+Xltsrr9i+j8pAtuxhN76CwrS+Gph05Q=;
 b=Wf2g6VIZaKs9EcFObQklwhet7G+d/GnP1plhx+mn2HYmaRI9mozWwQ5SkIeP4jfl2p
 R4SCivAtvAi5JpgjIDkDEiZNu9nGOaCvOrxC+5Uc7dDoH2Sf/RmdjbHwxuwdYXjgN+yK
 Fj9UK0+e+rPbskXI/WFWez2nEPKKIkf7T5Y4vQlioiXacxoXkAHnLII6XxPbochplodB
 IrgzFEAqUqF1bvntrBUzo7xmFB14IeOveqHAAwVvAsvMr+yErkN0yd8I1Et4zyBTCQvN
 cy+jJivU6rRueefoljLNbXU0APhy9b1f9i5GUaKdrDD6Wkd1Z4/Dduuq9pyYhGeTa5bs
 G/cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBK6BsZJMugD6CdmtA2OamO4jp18XVbRQEXJO2AExfC1Ai4qSv73o46isAKXa4i4sFySKA/1w=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz/LzCXUkJRT4I08AKHY45grK8ral2UxjX8acj4tBOoEzl7Lwb
 O7cWnVm8MDFlWU/rhvKVLSxLygsHzi9T3AsUQjHHXAMLY4gbXzqh7Sdb8807nsk4qq8=
X-Gm-Gg: ATEYQzzbZgSniMCvCOoA9T8sguc3DeODy3oD9Ct3JrfyDNFqZpIEvr6PEgZSB4o5Bgc
 QUG/LTrxbqhD6bM+9mzo7n22gyzJweyOgHkxuQtPKu+E8U52h5/dBkUWgvxb/JKtJuwB0ycTdVm
 HRs2VqQFboNttfvFlE6nG6DW/XQ6SBLUdQYz/ijjOLiFuzRYunAUcvCl1r4S25vZ05aa4aA6u8R
 SoEysmOdOKx0o0yZIoWbmvoYJUwuOSwlr3qPwGOhX1wKNJlSms7sixJvtB2Jffxygo+MBhKTHFr
 a6MIavK04r1y0kBKxTs+Xq5MmRrLLmuLCau8bSyNvjEDK5JJFgqrNPhfUp9v5N2rvBVMfdpCmWG
 ZR0Xu58groVcja7ZjWr2qfGhgO2v36qprSG19WoJnZNUXYbHK9KSkiOPhCYspLIXBsMTDWkcrQg
 ek2Ol/WF2bdLWHKxDXKx93wSyPxzQPWek2uxYrasyhIf6gg5XFmPyqUtoYjrVsIvmaVAaXSOszW
 kXrWw==
X-Received: by 2002:a17:906:c145:b0:b97:ca81:e89a with SMTP id
 a640c23a62f3a-b97f435a1afmr241703466b.0.1773838019671; 
 Wed, 18 Mar 2026 05:46:59 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f142cf16sm206080366b.20.2026.03.18.05.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 05:46:59 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Mar 2026 13:46:30 +0100
Subject: [PATCH v2 4/7] regulator: qcom-rpmh-regulator: add support for
 PM7550 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-milos-bringup-v2-4-650b91dd75d8@fairphone.com>
References: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
In-Reply-To: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773838014; l=3283;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=LhfB3zwiH3GB2Ppss3e4dWKvmiLhM36dHgfCCB4P3lQ=;
 b=R1jNbnhO+f+2tXA6Gz+rfKQiizknF43RGGvS4c2ftACFai9PfzhEE42DLpJ0y9FC/w0j9Q9FF
 gAAHSBBDMJADypTQMHVB//TaR1qbSyy05aacoRI5M20pBITAStAU400
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:14 +0100
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
The tables are imported from the Linux driver (tag v7.0-rc4). The SMPS
regulators were not added now.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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

