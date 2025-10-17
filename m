Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF29CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E091839A7;
	Fri, 17 Oct 2025 17:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="douBEPeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97ABD83869; Fri, 17 Oct 2025 17:28:57 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08F383826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 711B9262AB;
 Fri, 17 Oct 2025 17:28:55 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QxG6xKhPDgpn; Fri, 17 Oct 2025 17:28:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714934; bh=ZBSE7NkfLhGaJ3Zy1gv+1fGNQrj8znCZweI95fJqq8g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=douBEPeC2MsET+jjJm50CQx9DlyYrZ6UOZ1KR+XXwNc62+qw0wab3JPLA0b38Mn9+
 ifM+WWBt4EHgtRXbmtJwk//Q7vMDrBrVEcQNfXIPDo3HE5CnN08y3KyV1ekyP5E9On
 Wlu8epw9dQ+LY1bHfZKDTyDadDon5c/sfy6Ffquvo9lYgOX9ExNLCvvJp+JFtLcfy1
 m3jafsqfhSeEaA34YxrSkdQvjPtQP3uIUDFxShxmLEf6WgaRfYgFgD5VCrNMww14/V
 o/MoIk8UpY2k+P2fI8BumyzGnVFrv3OakAFcy7YvXf84NEYhUIAEDbu2hoCyuFYnpb
 t3GjT0WeQ/AjA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:58:19 +0530
Subject: [PATCH 4/6] power: regulator: s2mps11: declaratively get/set
 regulator mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-power-pmic-regulator-s2mpu05-v1-4-91cadc0f4156@disroot.org>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>, 
 Anand Moon <linux.amoon@gmail.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714904; l=6231;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=ZBSE7NkfLhGaJ3Zy1gv+1fGNQrj8znCZweI95fJqq8g=;
 b=qTbwsYxOTaawyEl2eQN2dZCDRPzk9H4scvL2p+cYRJKT1zd9slexNvojlhTnlv7V3hBolpXmI
 WVGRLjKyucED+r5WWe3jSMrpA9CQ/i3oExkLyfjlCRn7isXZIIrrwY1
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

The functions s2mps11_{buck,ldo}_mode use the s2mps11_{buck,ldo}_modes
arrays directly in order to extract the mode of a certain register.
This approach does not allow similar devices of other variants (which
may support a different set of modes) to work with the same driver.

Instead of using these arrays hardcoded, extract them from the device's
uclass platform data. Now the responsibility of setting these arrays
properly is done by functions s2mps11_{buck,ldo}_probe, by implementing
a switch-case block which can support modes of multiple variants if and
when added.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/power/regulator/s2mps11_regulator.c | 132 +++++++++++++---------------
 1 file changed, 59 insertions(+), 73 deletions(-)

diff --git a/drivers/power/regulator/s2mps11_regulator.c b/drivers/power/regulator/s2mps11_regulator.c
index db981df53ae4b6297c63cb8be0f285805307c230..17a0a4d7ce676db7d11aa39e58a68d6f8c3f1a0a 100644
--- a/drivers/power/regulator/s2mps11_regulator.c
+++ b/drivers/power/regulator/s2mps11_regulator.c
@@ -204,10 +204,11 @@ static int s2mps11_buck_val(struct udevice *dev, int op, int *uV)
 
 static int s2mps11_buck_mode(struct udevice *dev, int op, int *opmode)
 {
+	struct dm_regulator_uclass_plat *uc_pdata = dev_get_uclass_plat(dev);
 	const struct sec_regulator_desc *buck_desc;
 	unsigned int addr, mode;
 	unsigned char val;
-	int num_bucks, buck, ret;
+	int num_bucks, buck, ret, i;
 
 	switch (s2mps11_get_variant(dev)) {
 	case VARIANT_S2MPS11:
@@ -233,42 +234,29 @@ static int s2mps11_buck_mode(struct udevice *dev, int op, int *opmode)
 
 	if (op == PMIC_OP_GET) {
 		val &= buck_desc[buck].mode_mask;
-		switch (val) {
-		case S2MPS11_BUCK_MODE_OFF:
-			*opmode = OP_OFF;
-			break;
-		case S2MPS11_BUCK_MODE_STANDBY:
-			*opmode = OP_STANDBY;
-			break;
-		case S2MPS11_BUCK_MODE_ON:
-			*opmode = OP_ON;
-			break;
-		default:
-			return -EINVAL;
+		for (i = 0; i < uc_pdata->mode_count; i++) {
+			if (uc_pdata->mode[i].register_value != val)
+				continue;
+
+			*opmode = uc_pdata->mode[i].id;
+			return 0;
 		}
-		return 0;
-	}
 
-	switch (*opmode) {
-	case OP_OFF:
-		mode = S2MPS11_BUCK_MODE_OFF;
-		break;
-	case OP_STANDBY:
-		mode = S2MPS11_BUCK_MODE_STANDBY;
-		break;
-	case OP_ON:
-		mode = S2MPS11_BUCK_MODE_ON;
-		break;
-	default:
-		pr_err("Wrong mode: %d for buck: %d\n", *opmode, buck);
 		return -EINVAL;
 	}
 
-	val &= ~buck_desc[buck].mode_mask;
-	val |= mode;
-	ret = pmic_write(dev->parent, addr, &val, 1);
+	for (i = 0; i < uc_pdata->mode_count; i++) {
+		if (uc_pdata->mode[i].id != *opmode)
+			continue;
 
-	return ret;
+		mode = uc_pdata->mode[i].register_value;
+		val &= ~buck_desc[buck].mode_mask;
+		val |= mode;
+		return pmic_write(dev->parent, addr, &val, 1);
+	}
+
+	pr_err("Wrong mode: %d for buck: %d\n", *opmode, buck);
+	return -EINVAL;
 }
 
 static int s2mps11_buck_enable(struct udevice *dev, int op, bool *enable)
@@ -357,10 +345,17 @@ static int s2mps11_buck_probe(struct udevice *dev)
 	struct dm_regulator_uclass_plat *uc_pdata;
 
 	uc_pdata = dev_get_uclass_plat(dev);
-
 	uc_pdata->type = REGULATOR_TYPE_BUCK;
-	uc_pdata->mode = s2mps11_buck_modes;
-	uc_pdata->mode_count = ARRAY_SIZE(s2mps11_buck_modes);
+
+	switch (s2mps11_get_variant(dev)) {
+	case VARIANT_S2MPS11:
+		uc_pdata->mode = s2mps11_buck_modes;
+		uc_pdata->mode_count = ARRAY_SIZE(s2mps11_buck_modes);
+		break;
+	default:
+		pr_err("Unknown device type\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -434,10 +429,11 @@ static int s2mps11_ldo_val(struct udevice *dev, int op, int *uV)
 
 static int s2mps11_ldo_mode(struct udevice *dev, int op, int *opmode)
 {
+	struct dm_regulator_uclass_plat *uc_pdata = dev_get_uclass_plat(dev);
 	const struct sec_regulator_desc *ldo_desc;
 	unsigned int addr, mode;
 	unsigned char val;
-	int num_ldos, ldo, ret;
+	int num_ldos, ldo, ret, i;
 
 	switch (s2mps11_get_variant(dev)) {
 	case VARIANT_S2MPS11:
@@ -463,48 +459,30 @@ static int s2mps11_ldo_mode(struct udevice *dev, int op, int *opmode)
 
 	if (op == PMIC_OP_GET) {
 		val &= ldo_desc[ldo].mode_mask;
-		switch (val) {
-		case S2MPS11_LDO_MODE_OFF:
-			*opmode = OP_OFF;
-			break;
-		case S2MPS11_LDO_MODE_STANDBY:
-			*opmode = OP_STANDBY;
-			break;
-		case S2MPS11_LDO_MODE_STANDBY_LPM:
-			*opmode = OP_STANDBY_LPM;
-			break;
-		case S2MPS11_LDO_MODE_ON:
-			*opmode = OP_ON;
-			break;
-		default:
-			return -EINVAL;
+
+		for (i = 0; i < uc_pdata->mode_count; i++) {
+			if (uc_pdata->mode[i].register_value != val)
+				continue;
+
+			*opmode = uc_pdata->mode[i].id;
+			return 0;
 		}
-		return 0;
-	}
 
-	switch (*opmode) {
-	case OP_OFF:
-		mode = S2MPS11_LDO_MODE_OFF;
-		break;
-	case OP_STANDBY:
-		mode = S2MPS11_LDO_MODE_STANDBY;
-		break;
-	case OP_STANDBY_LPM:
-		mode = S2MPS11_LDO_MODE_STANDBY_LPM;
-		break;
-	case OP_ON:
-		mode = S2MPS11_LDO_MODE_ON;
-		break;
-	default:
-		pr_err("Wrong mode: %d for ldo: %d\n", *opmode, ldo);
 		return -EINVAL;
 	}
 
-	val &= ~ldo_desc[ldo].mode_mask;
-	val |= mode;
-	ret = pmic_write(dev->parent, addr, &val, 1);
+	for (i = 0; i < uc_pdata->mode_count; i++) {
+		if (uc_pdata->mode[i].id != *opmode)
+			continue;
 
-	return ret;
+		mode = uc_pdata->mode[i].register_value;
+		val &= ~ldo_desc[ldo].mode_mask;
+		val |= mode;
+		return pmic_write(dev->parent, addr, &val, 1);
+	}
+
+	pr_err("Wrong mode: %d for ldo: %d\n", *opmode, ldo);
+	return -EINVAL;
 }
 
 static int s2mps11_ldo_enable(struct udevice *dev, int op, bool *enable)
@@ -602,8 +580,16 @@ static int s2mps11_ldo_probe(struct udevice *dev)
 
 	uc_pdata = dev_get_uclass_plat(dev);
 	uc_pdata->type = REGULATOR_TYPE_LDO;
-	uc_pdata->mode = s2mps11_ldo_modes;
-	uc_pdata->mode_count = ARRAY_SIZE(s2mps11_ldo_modes);
+
+	switch (s2mps11_get_variant(dev)) {
+	case VARIANT_S2MPS11:
+		uc_pdata->mode = s2mps11_ldo_modes;
+		uc_pdata->mode_count = ARRAY_SIZE(s2mps11_ldo_modes);
+		break;
+	default:
+		pr_err("Unknown device type\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }

-- 
2.51.0

