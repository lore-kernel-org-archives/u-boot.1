Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E6ECA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CDFC831EA;
	Wed, 27 Aug 2025 16:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="iJPZfqgh";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="XkRaDF9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0182B83145; Wed, 27 Aug 2025 01:34:47 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40AF6830F6
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 01:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrian@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1756251239; bh=kJ9hwIfe6oVD+TlF1TwioPj
 bJqO714YwEds6CaeMdZg=; b=iJPZfqghayzq/05tpZR1+bN/bQrpzpDURcvfXiMPhWGtzFvmbq
 sWjTWI5yviYeJ+3Ybr7u5ixQ/f6hpjJI7vxF2CKkLmqi2PbOybd+Q0lY3BM4ON/1pJYenPYZ9/p
 LTtKp1PeizhVpom3czV0KJUbCr4TnwVJh+oDmllVwB9LjeMfEFJvxjncJuNkYgyiRTnq1FaIqKt
 Nc74ialCIzgGmPIrX3cnaqexfVKIRXLApSN3LW5ZNu7ZgcBWEaNdogkP3/JHsNycc8vxA355e9z
 zKFZGBkL61mIZh2OQ88AHcuMkGS3oessORNxZy7gJcdeyee1sfBAZY9xohA8GB/rPUw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1756251239; bh=kJ9hwIfe6oVD+TlF1TwioPj
 bJqO714YwEds6CaeMdZg=; b=XkRaDF9DVe0QzIE2uT4+q8VldLK19meHeBXiteqaUw4eULRW3p
 wnnWybBMfg4tOKfSp8CRSqN8bkdzcpCyHnCw==;
From: Jens Reidel <adrian@mainlining.org>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Jens Reidel <adrian@mainlining.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] power: qcom-rpmh-regulator: add support for pm6150l
Date: Wed, 27 Aug 2025 01:33:39 +0200
Message-ID: <20250826233339.64077-1-adrian@mainlining.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 Aug 2025 16:25:23 +0200
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

Provides the supplies for SD card on SM7150.

Signed-off-by: Jens Reidel <adrian@mainlining.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 954deca5ed7..ac63c50e1d4 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -493,6 +493,19 @@ static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
 	.supply_name	= _supply_name, \
 }
 
+static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l4-l5-l6"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l4-l5-l6"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l4-l5-l6"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l11"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo,      "vdd-l1-l8"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l9-l10"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
 	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
 	{}
@@ -705,6 +718,10 @@ static int rpmh_regulators_bind(struct udevice *dev)
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

