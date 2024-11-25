Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D714CD3B7F0
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 433438961D;
	Mon, 25 Nov 2024 09:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kwSMQi9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17CF89664; Mon, 25 Nov 2024 09:24:52 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C478961B
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso38387765e9.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732523090; x=1733127890; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dEf3RQiZJv1WT5rlKkP3LJTXLyeWIgkGPqV3QkkyIbs=;
 b=kwSMQi9XLhOlS4j+VsvHVZ8lrcMg16mx2AKD37lfBNOxsROrMOazQs54+ftdg6I8Dm
 zLRyCH2JOpWHr01J1s2lSTiTqwweaWNHpvRUaAL8QrFuSEoxDRvLNkDF/Fpveb0VrVGJ
 VGkJpfMfZrx1JtdMujlP+t8+i8iuu66H8L0H3mYAsF26+iU+azFwHeRa3xuPvbetHByv
 r28UFE7awlLAvMZeYtP8je79fFF/lH74m3TdYBbELdoQBCeQWejqJ7u4ndofDx9hLXLo
 NFMxPLXcgLcEKoWmcOA93CWm1wrAuZtPdO/ktfY934lXpJ5Dhpi9bSmQt3LnJwXqH8Yl
 DQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523090; x=1733127890;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEf3RQiZJv1WT5rlKkP3LJTXLyeWIgkGPqV3QkkyIbs=;
 b=Ss1sJp9gLngx/1Cxi9hXUDMi/K9yVbMYD9A0ywaSK6KuF7qg+Uua6h7Rm3lpw9rX0t
 PrxBvuPnTR4HVJIIyWqz3DpYP24XDsc4mSHGJDs12V0EDCWMoTHyP7rDO2S7muj9eHr/
 QcZ+nb4OSnh3GG+fHEnPEeshlcTAH4RoJ4SSqO4AKDJAsAH/m59//7wrf/JHbU2OdAhV
 Ldxj9fQ9iM8lKIe8ncCdDqPNChdirJZwvS10aXapATXAhd13WH8TCpcyOlY++ehkyw8i
 0QQcuqgYVGAPH131FNx6hYAqad9RAEztoMwPg7ElgLROh60/EUmHS4HYT8dINnkg/lK2
 2uyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXen1w+n5tS0E7lBakFOkCD4O8RKWZnEXnpYC9I5ScFWbSAGncAFCzHJTl3qUI5pR4gUwxWhJw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3lNtKwsa28l1tKvojSOJ20GuomyitGPoxQkkmkrdsV/Jnz8qX
 NdqetsOL9Tl1kVGVq36O8PcchkCsrb6x4qnwbwr4P33TA7j5FldbguCnur49n4plnckbV6/xsdm
 e
X-Gm-Gg: ASbGncuh3fd/c6k+qIBi9DlmjqoN40Loblawupo5oN8lYby/0nHfWcF42GaSvjT67AX
 6LD8cgygoNRWC7u1pV9fGRcQ/f4Hqeu1/naOeifA4aw2GWOpY8cimM0TU9ww8ys4QhHZ2N6mlR7
 nGV6ijgg1OVAAmiKuzqJOd2P4lUvlujY1GBhCNSjvpIhW/26P8qSO20jA9vuruaOZAaI9qzSww/
 Dna2pqPqPPGSEv+/B4UNxKTVG2LhJryV36Y0Hu7t6/5Lvwyt5AavP/fEg9L9HU4Pj+2Ztc=
X-Google-Smtp-Source: AGHT+IEPSi64Km3ZUZfUBHusP+mYqM3E7pS7UcuZf2n3HPAIEkagRqd/5Pninpt82F2a7cywUpkInA==
X-Received: by 2002:a05:600c:4f4e:b0:431:5e3c:2ff0 with SMTP id
 5b1f17b1804b1-433ce42549amr98621775e9.8.1732523090269; 
 Mon, 25 Nov 2024 00:24:50 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde8c804sm119996345e9.30.2024.11.25.00.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:24:49 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 09:24:47 +0100
Subject: [PATCH] regulator: qcom-rpmh-regulator: add support for pmc8380
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-hamoa-pmc8380-rpmh-regulators-v1-1-695c44ea8586@linaro.org>
X-B4-Tracking: v=1; b=H4sIAE40RGcC/x3NQQqDMBBA0avIrB1IUttaryIuYjKagcaEiZaCe
 PeGLt/m/xMKCVOBoTlB6MOF01ah2wZcsNtKyL4ajDKd1uaOe8rsMNiYLObo+luvUHIMKLQeb7s
 nKWjmV/dQi/PP2UMtZaGFv//LOF3XD1amD1d1AAAA
X-Change-ID: 20241125-topic-hamoa-pmc8380-rpmh-regulators-2b9460fcd7bd
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qPjA59fMJLiQZUQ+EkTBXDvq7VRasHz0wthIEZ7uvzY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRDRRkGew4Lg6iXT4H/Ez8hXDWN2Rhy8DMYmNslAh
 9sEowmyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0Q0UQAKCRB33NvayMhJ0cweEA
 C1UunBxet0nUiQFw3Qd0paXDFww0rYQc6hXkVr/sQLDxMr9x/kVP8ne+Fb5WZGyl9Icm8GggZZ3CBg
 jdP5udVbgPozSFuyU1B8NoSCIk1SYpa01dP9kssUfMmXCCvPBecr8WHo36Ij82mjZy9o+rSydl1NB8
 AM4DaqcDlJfRsitf4SCGctgn36M7aNr7i99JBkOOpu5V1BI3s7cCujk4G3uGXZsxmKfO3bikyQD9yv
 kcl7yBNXZQIA6a7EjUNatkouXbBN92C6KM6FIGj960aR19BE1tjTKVAAgDwYrsUoln7wE9UF9XEIpz
 CfCRJ22BkOQQlJQ51d0DLy+4oSo0EOHAQIBpfRf3n+h2gs7WAy3areGGd+1en+3gPNFfgGtE4OmE5I
 emep0IihqaMnVswC8NLCSymY/MqWS31mGWUmhd34zns9op8eE5VA0LKJ+nbmhw7HpGGMRh1Ogou+iv
 6NdzXP2uUCJBAV/BLHazAU4gmPUmbkjsfoU3ucSWOkyttGxpfDYvUlQJ/f09i1z7ZnpSa8Ygb3Ipgy
 UjU1uyrxnCT/oGINrQhjXJAa77zqXgX916ZqfK+CE0/EEuVLlUXwoFVyjvHXbo7pQ/PRCstMkC0Fhh
 dnxs6pJ2NHUeSEamIDGJyIqbu5cpgaraUiQdVfxH1CbqFtHvjFNZoj82X23Q==
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

Add the PMC8380 regulator data found on the Snapdragon X Elite platforms.
The tables are imported from the Linux driver.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 2dc261d83e3727a5b2f72a5d13c1ef17a9677a8c..70df51b5fa4ee4001b7eff6facc80957ada84391 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -536,6 +536,21 @@ static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pmc8380_vreg_data[] = {
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
@@ -662,6 +677,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
 		.compatible = "qcom,pm8550vs-rpmh-regulators",
 		.data = (ulong)pm8550vs_vreg_data,
 	},
+	{
+		.compatible = "qcom,pmc8380-rpmh-regulators",
+		.data = (ulong)pmc8380_vreg_data,
+	},
 	{ /* sentinal */ },
 };
 

---
base-commit: 7fe55182d9263a62e18b450c97bdf0b8031e5667
change-id: 20241125-topic-hamoa-pmc8380-rpmh-regulators-2b9460fcd7bd

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

