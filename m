Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6239ACCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3954E8399D;
	Fri, 17 Oct 2025 17:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="cQO5phH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D130083869; Fri, 17 Oct 2025 17:28:53 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE8583826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 79205262D9;
 Fri, 17 Oct 2025 17:28:51 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6nkkuoPrNmLu; Fri, 17 Oct 2025 17:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714930; bh=K1Q/AIlV9oFw5KGARBBOgHMLkr6Quebq6sEQChCXlvA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cQO5phH3XUb+QEb/pscS/ebGQbCcXAaSsqnqboAtjMTjRDavD3VTGrQwl3PDwcQp7
 NQB30RLh32z/P3gE0ugzV2oHx4T6G3pwLyQ3H6Oy06l8S2ov2dWOhO9KjiZApQmXYR
 lWsrR37rZiORVzo3Cn5cIQdR+s4KtfXzDgDaUsnx4fuxGXlPL4BD0e53QxX2aYL0uX
 IeWC+yDwY1UacxXm17yiIt2WoUjTreQlNlHQWMUqH58P+gb975vvy4LuAt26txpkKz
 a4mlHxlTSks/YrKZwJQSiz+MoOxW5Cc8jvguKQb5YoXYosCZwh6g2r0uwjr80VfO3V
 0Uq7d5vTwSv1g==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:58:18 +0530
Subject: [PATCH 3/6] power: regulator: s2mps11: declaratively define LDOs
 and BUCKs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-power-pmic-regulator-s2mpu05-v1-3-91cadc0f4156@disroot.org>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>, 
 Anand Moon <linux.amoon@gmail.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714904; l=16129;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=K1Q/AIlV9oFw5KGARBBOgHMLkr6Quebq6sEQChCXlvA=;
 b=+XemtBV1UYFCZyzZDfXVTcFjQqgiCo+iFXh2SvIZAlh8ko9o3lQG641XHxxguuXtaTcHrzvex
 FWneQNA4VgtAq8qvcgVjYcKj7/vTAr+UF+enmYipBDmiM8oaRHoeC7D
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

In the Linux kernel driver, all information related to LDO and BUCK
regulators are stored in descriptive arrays. This also allows multiple
variants to be supported by the same driver.

Define a struct sec_regulator_desc which holds all values required by a
regulator. Create an array of said struct containing all regulators. The
descriptors are designed to follow a style similar to what's seen in the
Linux driver, so comparing one with the other is simple.

In functions such as s2mps11_{buck,ldo}_{val,mode} these values are to
be used, make necessary modifications to pull them from the descriptors.
Since multiple variants have varying descriptors, select them from
within a switch-case block.

Functions s2mps11_{buck,ldo}_{volt2hex,hex2volt} and arrays
s2mps11_buck_{ctrl,out} are phased out as the calculations are now
hardcoded in descriptors, thusly, it reduces clutter and enhances
readability.

Two macros in s2mps11.h, S2MPS11_LDO_NUM and S2MPS11_BUCK_NUM are
removed as they are no longer being used.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/power/regulator/s2mps11_regulator.c | 364 +++++++++++++++-------------
 include/power/s2mps11.h                     |  17 +-
 2 files changed, 205 insertions(+), 176 deletions(-)

diff --git a/drivers/power/regulator/s2mps11_regulator.c b/drivers/power/regulator/s2mps11_regulator.c
index 96de55065feb06fdb86d7b3f056b5a65f97dda16..db981df53ae4b6297c63cb8be0f285805307c230 100644
--- a/drivers/power/regulator/s2mps11_regulator.c
+++ b/drivers/power/regulator/s2mps11_regulator.c
@@ -13,6 +13,112 @@
 #include <power/regulator.h>
 #include <power/s2mps11.h>
 
+#define regulator_desc_s2mps11_buck(num, mask, min, step, max_hex)			\
+	[num] = {									\
+		.mode_reg	= S2MPS11_REG_B##num##CTRL1,				\
+		.mode_mask	= S2MPS11_BUCK_MODE_MASK << S2MPS11_BUCK_MODE_SHIFT,	\
+		.volt_reg	= S2MPS11_REG_B##num##CTRL2,				\
+		.volt_mask	= mask,							\
+		.volt_min	= min,							\
+		.volt_step	= step,							\
+		.volt_max_hex	= max_hex,						\
+	}
+
+#define regulator_desc_s2mps11_buck1_2_3_4_6(num)			\
+	regulator_desc_s2mps11_buck(num, S2MPS11_BUCK_VOLT_MASK,	\
+					 S2MPS11_BUCK_UV_MIN,		\
+					 S2MPS11_BUCK_LSTEP,		\
+					 S2MPS11_BUCK_VOLT_MAX_HEX)
+
+#define regulator_desc_s2mps11_buck5					\
+	regulator_desc_s2mps11_buck(5, S2MPS11_BUCK_VOLT_MASK,		\
+				       S2MPS11_BUCK_UV_MIN,		\
+				       S2MPS11_BUCK_LSTEP,		\
+				       S2MPS11_BUCK5_VOLT_MAX_HEX)
+
+#define regulator_desc_s2mps11_buck7_8_10(num)				\
+	regulator_desc_s2mps11_buck(num, S2MPS11_BUCK_VOLT_MASK,	\
+					 S2MPS11_BUCK_UV_HMIN,		\
+					 S2MPS11_BUCK_HSTEP,		\
+					 S2MPS11_BUCK7_8_10_VOLT_MAX_HEX)
+
+#define regulator_desc_s2mps11_buck9					\
+	regulator_desc_s2mps11_buck(9, S2MPS11_BUCK9_VOLT_MASK,		\
+				       S2MPS11_BUCK_UV_MIN,		\
+				       S2MPS11_BUCK9_STEP,		\
+				       S2MPS11_BUCK9_VOLT_MAX_HEX)
+
+static const struct sec_regulator_desc s2mps11_buck_desc[] = {
+	regulator_desc_s2mps11_buck1_2_3_4_6(1),
+	regulator_desc_s2mps11_buck1_2_3_4_6(2),
+	regulator_desc_s2mps11_buck1_2_3_4_6(3),
+	regulator_desc_s2mps11_buck1_2_3_4_6(4),
+	regulator_desc_s2mps11_buck5,
+	regulator_desc_s2mps11_buck1_2_3_4_6(6),
+	regulator_desc_s2mps11_buck7_8_10(7),
+	regulator_desc_s2mps11_buck7_8_10(8),
+	regulator_desc_s2mps11_buck9,
+	regulator_desc_s2mps11_buck7_8_10(10),
+};
+
+#define regulator_desc_s2mps11_ldo(num, step)						\
+	[num] = {									\
+		.mode_reg	= S2MPS11_REG_L##num##CTRL,				\
+		.mode_mask	= S2MPS11_LDO_MODE_MASK << S2MPS11_LDO_MODE_SHIFT,	\
+		.volt_reg	= S2MPS11_REG_L##num##CTRL,				\
+		.volt_mask	= S2MPS11_LDO_VOLT_MASK,				\
+		.volt_min	= S2MPS11_LDO_UV_MIN,					\
+		.volt_step	= step,							\
+		.volt_max_hex	= S2MPS11_LDO_VOLT_MAX_HEX				\
+	}
+
+#define regulator_desc_s2mps11_ldo_type1(num)	\
+	regulator_desc_s2mps11_ldo(num, S2MPS11_LDO_STEP)
+
+#define regulator_desc_s2mps11_ldo_type2(num)	\
+	regulator_desc_s2mps11_ldo(num, S2MPS11_LDO_STEP * 2)
+
+static const struct sec_regulator_desc s2mps11_ldo_desc[] = {
+	regulator_desc_s2mps11_ldo_type1(1),
+	regulator_desc_s2mps11_ldo_type2(2),
+	regulator_desc_s2mps11_ldo_type2(3),
+	regulator_desc_s2mps11_ldo_type2(4),
+	regulator_desc_s2mps11_ldo_type2(5),
+	regulator_desc_s2mps11_ldo_type1(6),
+	regulator_desc_s2mps11_ldo_type2(7),
+	regulator_desc_s2mps11_ldo_type2(8),
+	regulator_desc_s2mps11_ldo_type2(9),
+	regulator_desc_s2mps11_ldo_type2(10),
+	regulator_desc_s2mps11_ldo_type1(11),
+	regulator_desc_s2mps11_ldo_type2(12),
+	regulator_desc_s2mps11_ldo_type2(13),
+	regulator_desc_s2mps11_ldo_type2(14),
+	regulator_desc_s2mps11_ldo_type2(15),
+	regulator_desc_s2mps11_ldo_type2(16),
+	regulator_desc_s2mps11_ldo_type2(17),
+	regulator_desc_s2mps11_ldo_type2(18),
+	regulator_desc_s2mps11_ldo_type2(19),
+	regulator_desc_s2mps11_ldo_type2(20),
+	regulator_desc_s2mps11_ldo_type2(21),
+	regulator_desc_s2mps11_ldo_type1(22),
+	regulator_desc_s2mps11_ldo_type1(23),
+	regulator_desc_s2mps11_ldo_type2(24),
+	regulator_desc_s2mps11_ldo_type2(25),
+	regulator_desc_s2mps11_ldo_type2(26),
+	regulator_desc_s2mps11_ldo_type1(27),
+	regulator_desc_s2mps11_ldo_type2(28),
+	regulator_desc_s2mps11_ldo_type2(29),
+	regulator_desc_s2mps11_ldo_type2(30),
+	regulator_desc_s2mps11_ldo_type2(31),
+	regulator_desc_s2mps11_ldo_type2(32),
+	regulator_desc_s2mps11_ldo_type2(33),
+	regulator_desc_s2mps11_ldo_type2(34),
+	regulator_desc_s2mps11_ldo_type1(35),
+	regulator_desc_s2mps11_ldo_type2(36),
+	regulator_desc_s2mps11_ldo_type2(37),
+	regulator_desc_s2mps11_ldo_type2(38),
+};
+
 #define MODE(_id, _val, _name) { \
 	.id = _id, \
 	.register_value = _val, \
@@ -33,94 +139,37 @@ static struct dm_regulator_mode s2mps11_ldo_modes[] = {
 	MODE(OP_ON, S2MPS11_LDO_MODE_ON, "ON"),
 };
 
-static const char s2mps11_buck_ctrl[] = {
-	0xff, 0x25, 0x27, 0x29, 0x2b, 0x2d, 0x33, 0x35, 0x37, 0x39, 0x3b
-};
-
-static const char s2mps11_buck_out[] = {
-	0xff, 0x26, 0x28, 0x2a, 0x2c, 0x2f, 0x34, 0x36, 0x38, 0x3a, 0x3c
-};
-
-static int s2mps11_buck_hex2volt(int buck, int hex)
+static const ulong s2mps11_get_variant(struct udevice *dev)
 {
-	unsigned int uV = 0;
-
-	if (hex < 0)
-		goto bad;
-
-	switch (buck) {
-	case 7:
-	case 8:
-	case 10:
-		if (hex > S2MPS11_BUCK7_8_10_VOLT_MAX_HEX)
-			goto bad;
+	struct udevice *parent = dev_get_parent(dev);
 
-		uV = hex * S2MPS11_BUCK_HSTEP + S2MPS11_BUCK_UV_HMIN;
-		break;
-	case 9:
-		if (hex > S2MPS11_BUCK9_VOLT_MAX_HEX)
-			goto bad;
-		uV = hex * S2MPS11_BUCK9_STEP * 2 + S2MPS11_BUCK9_UV_MIN;
-		break;
-	default:
-		if (buck == 5 && hex > S2MPS11_BUCK5_VOLT_MAX_HEX)
-			goto bad;
-		else if (buck != 5 && hex > S2MPS11_BUCK_VOLT_MAX_HEX)
-			goto bad;
-
-		uV = hex * S2MPS11_BUCK_LSTEP + S2MPS11_BUCK_UV_MIN;
-		break;
+	if (!parent) {
+		pr_err("Parent is non-existent, this shouldn't happen!\n");
+		return VARIANT_NONE;
 	}
 
-	return uV;
-bad:
-	pr_err("Value: %#x is wrong for BUCK%d", hex, buck);
-	return -EINVAL;
+	return dev_get_driver_data(parent);
 }
 
-static int s2mps11_buck_volt2hex(int buck, int uV)
+static int s2mps11_buck_val(struct udevice *dev, int op, int *uV)
 {
-	int hex;
-
-	switch (buck) {
-	case 7:
-	case 8:
-	case 10:
-		hex = (uV - S2MPS11_BUCK_UV_HMIN) / S2MPS11_BUCK_HSTEP;
-		if (hex > S2MPS11_BUCK7_8_10_VOLT_MAX_HEX)
-			goto bad;
+	const struct sec_regulator_desc *buck_desc;
+	int num_bucks, hex, buck, ret;
+	u32 addr;
+	u8 val;
 
-		break;
-	case 9:
-		hex = (uV - S2MPS11_BUCK9_UV_MIN) / S2MPS11_BUCK9_STEP;
-		if (hex > S2MPS11_BUCK9_VOLT_MAX_HEX)
-			goto bad;
+	switch (s2mps11_get_variant(dev)) {
+	case VARIANT_S2MPS11:
+		buck_desc = s2mps11_buck_desc;
+		num_bucks = ARRAY_SIZE(s2mps11_buck_desc);
 		break;
 	default:
-		hex = (uV - S2MPS11_BUCK_UV_MIN) / S2MPS11_BUCK_LSTEP;
-		if (buck == 5 && hex > S2MPS11_BUCK5_VOLT_MAX_HEX)
-			goto bad;
-		else if (buck != 5 && hex > S2MPS11_BUCK_VOLT_MAX_HEX)
-			goto bad;
-		break;
-	};
-
-	if (hex >= 0)
-		return hex;
-
-bad:
-	pr_err("Value: %d uV is wrong for BUCK%d", uV, buck);
-	return -EINVAL;
-}
-
-static int s2mps11_buck_val(struct udevice *dev, int op, int *uV)
-{
-	int hex, buck, ret;
-	u32 mask, addr;
-	u8 val;
+		pr_err("Unknown device type\n");
+		return -EINVAL;
+	}
 
 	buck = dev->driver_data;
-	if (buck < 1 || buck > S2MPS11_BUCK_NUM) {
+	if (buck < 1 || buck > num_bucks) {
 		pr_err("Wrong buck number: %d\n", buck);
 		return -EINVAL;
 	}
@@ -128,35 +177,25 @@ static int s2mps11_buck_val(struct udevice *dev, int op, int *uV)
 	if (op == PMIC_OP_GET)
 		*uV = 0;
 
-	addr = s2mps11_buck_out[buck];
-
-	switch (buck) {
-	case 9:
-		mask = S2MPS11_BUCK9_VOLT_MASK;
-		break;
-	default:
-		mask = S2MPS11_BUCK_VOLT_MASK;
-		break;
-	}
+	addr = buck_desc[buck].volt_reg;
 
 	ret = pmic_read(dev->parent, addr, &val, 1);
 	if (ret)
 		return ret;
 
 	if (op == PMIC_OP_GET) {
-		val &= mask;
-		ret = s2mps11_buck_hex2volt(buck, val);
-		if (ret < 0)
-			return ret;
-		*uV = ret;
+		val &= buck_desc[buck].volt_mask;
+		*uV = val * buck_desc[buck].volt_step + buck_desc[buck].volt_min;
 		return 0;
 	}
 
-	hex = s2mps11_buck_volt2hex(buck, *uV);
-	if (hex < 0)
-		return hex;
+	hex = (*uV - buck_desc[buck].volt_min) / buck_desc[buck].volt_step;
+	if (hex > buck_desc[buck].volt_max_hex) {
+		pr_err("Value: %d uV is wrong for LDO%d\n", *uV, buck);
+		return -EINVAL;
+	}
 
-	val &= ~mask;
+	val &= ~buck_desc[buck].volt_mask;
 	val |= hex;
 	ret = pmic_write(dev->parent, addr, &val, 1);
 
@@ -165,24 +204,35 @@ static int s2mps11_buck_val(struct udevice *dev, int op, int *uV)
 
 static int s2mps11_buck_mode(struct udevice *dev, int op, int *opmode)
 {
+	const struct sec_regulator_desc *buck_desc;
 	unsigned int addr, mode;
 	unsigned char val;
-	int buck, ret;
+	int num_bucks, buck, ret;
+
+	switch (s2mps11_get_variant(dev)) {
+	case VARIANT_S2MPS11:
+		buck_desc = s2mps11_buck_desc;
+		num_bucks = ARRAY_SIZE(s2mps11_buck_desc);
+		break;
+	default:
+		pr_err("Unknown device type\n");
+		return -EINVAL;
+	}
 
 	buck = dev->driver_data;
-	if (buck < 1 || buck > S2MPS11_BUCK_NUM) {
+	if (buck < 1 || buck > num_bucks) {
 		pr_err("Wrong buck number: %d\n", buck);
 		return -EINVAL;
 	}
 
-	addr = s2mps11_buck_ctrl[buck];
+	addr = buck_desc[buck].mode_reg;
 
 	ret = pmic_read(dev->parent, addr, &val, 1);
 	if (ret)
 		return ret;
 
 	if (op == PMIC_OP_GET) {
-		val &= (S2MPS11_BUCK_MODE_MASK << S2MPS11_BUCK_MODE_SHIFT);
+		val &= buck_desc[buck].mode_mask;
 		switch (val) {
 		case S2MPS11_BUCK_MODE_OFF:
 			*opmode = OP_OFF;
@@ -214,7 +264,7 @@ static int s2mps11_buck_mode(struct udevice *dev, int op, int *opmode)
 		return -EINVAL;
 	}
 
-	val &= ~(S2MPS11_BUCK_MODE_MASK << S2MPS11_BUCK_MODE_SHIFT);
+	val &= ~buck_desc[buck].mode_mask;
 	val |= mode;
 	ret = pmic_write(dev->parent, addr, &val, 1);
 
@@ -331,95 +381,51 @@ U_BOOT_DRIVER(s2mps11_buck) = {
 	.probe = s2mps11_buck_probe,
 };
 
-static int s2mps11_ldo_hex2volt(int ldo, int hex)
+static int s2mps11_ldo_val(struct udevice *dev, int op, int *uV)
 {
-	unsigned int uV = 0;
-
-	if (hex > S2MPS11_LDO_VOLT_MAX_HEX) {
-		pr_err("Value: %#x is wrong for LDO%d", hex, ldo);
-		return -EINVAL;
-	}
-
-	switch (ldo) {
-	case 1:
-	case 6:
-	case 11:
-	case 22:
-	case 23:
-	case 27:
-	case 35:
-		uV = hex * S2MPS11_LDO_STEP + S2MPS11_LDO_UV_MIN;
-		break;
-	default:
-		uV = hex * S2MPS11_LDO_STEP * 2 + S2MPS11_LDO_UV_MIN;
-		break;
-	}
-
-	return uV;
-}
+	const struct sec_regulator_desc *ldo_desc;
+	unsigned int addr;
+	unsigned char val;
+	int num_ldos, hex, ldo, ret;
 
-static int s2mps11_ldo_volt2hex(int ldo, int uV)
-{
-	int hex = 0;
-
-	switch (ldo) {
-	case 1:
-	case 6:
-	case 11:
-	case 22:
-	case 23:
-	case 27:
-	case 35:
-		hex = (uV - S2MPS11_LDO_UV_MIN) / S2MPS11_LDO_STEP;
+	switch (s2mps11_get_variant(dev)) {
+	case VARIANT_S2MPS11:
+		ldo_desc = s2mps11_ldo_desc;
+		num_ldos = ARRAY_SIZE(s2mps11_ldo_desc);
 		break;
 	default:
-		hex = (uV - S2MPS11_LDO_UV_MIN) / (S2MPS11_LDO_STEP * 2);
-		break;
+		pr_err("Unknown device type\n");
+		return -EINVAL;
 	}
 
-	if (hex >= 0 && hex <= S2MPS11_LDO_VOLT_MAX_HEX)
-		return hex;
-
-	pr_err("Value: %d uV is wrong for LDO%d", uV, ldo);
-	return -EINVAL;
-
-	return 0;
-}
-
-static int s2mps11_ldo_val(struct udevice *dev, int op, int *uV)
-{
-	unsigned int addr;
-	unsigned char val;
-	int hex, ldo, ret;
-
 	ldo = dev->driver_data;
-	if (ldo < 1 || ldo > S2MPS11_LDO_NUM) {
+	if (ldo < 1 || ldo > num_ldos) {
 		pr_err("Wrong ldo number: %d\n", ldo);
 		return -EINVAL;
 	}
 
-	addr = S2MPS11_REG_L1CTRL + ldo - 1;
+	addr = ldo_desc[ldo].volt_reg;
+
+	if (op == PMIC_OP_GET)
+		*uV = 0;
 
 	ret = pmic_read(dev->parent, addr, &val, 1);
 	if (ret)
 		return ret;
 
 	if (op == PMIC_OP_GET) {
-		*uV = 0;
-		val &= S2MPS11_LDO_VOLT_MASK;
-		ret = s2mps11_ldo_hex2volt(ldo, val);
-		if (ret < 0)
-			return ret;
-
-		*uV = ret;
+		val &= ldo_desc[ldo].volt_mask;
+		*uV = val * ldo_desc[ldo].volt_step + ldo_desc[ldo].volt_min;
 		return 0;
 	}
 
-	hex = s2mps11_ldo_volt2hex(ldo, *uV);
-	if (hex < 0)
-		return hex;
+	hex = (*uV - ldo_desc[ldo].volt_min) / ldo_desc[ldo].volt_step;
+	if (hex > ldo_desc[ldo].volt_max_hex) {
+		pr_err("Value: %d uV is wrong for LDO%d\n", *uV, ldo);
+		return -EINVAL;
+	}
 
-	val &= ~S2MPS11_LDO_VOLT_MASK;
+	val &= ~ldo_desc[ldo].volt_mask;
 	val |= hex;
 	ret = pmic_write(dev->parent, addr, &val, 1);
 
@@ -428,23 +434,35 @@ static int s2mps11_ldo_val(struct udevice *dev, int op, int *uV)
 
 static int s2mps11_ldo_mode(struct udevice *dev, int op, int *opmode)
 {
+	const struct sec_regulator_desc *ldo_desc;
 	unsigned int addr, mode;
 	unsigned char val;
-	int ldo, ret;
+	int num_ldos, ldo, ret;
+
+	switch (s2mps11_get_variant(dev)) {
+	case VARIANT_S2MPS11:
+		ldo_desc = s2mps11_ldo_desc;
+		num_ldos = ARRAY_SIZE(s2mps11_ldo_desc);
+		break;
+	default:
+		pr_err("Unknown device type\n");
+		return -EINVAL;
+	}
 
 	ldo = dev->driver_data;
-	if (ldo < 1 || ldo > S2MPS11_LDO_NUM) {
+	if (ldo < 1 || ldo > num_ldos) {
 		pr_err("Wrong ldo number: %d\n", ldo);
 		return -EINVAL;
 	}
-	addr = S2MPS11_REG_L1CTRL + ldo - 1;
+
+	addr = ldo_desc[ldo].mode_reg;
 
 	ret = pmic_read(dev->parent, addr, &val, 1);
 	if (ret)
 		return ret;
 
 	if (op == PMIC_OP_GET) {
-		val &= (S2MPS11_LDO_MODE_MASK << S2MPS11_LDO_MODE_SHIFT);
+		val &= ldo_desc[ldo].mode_mask;
 		switch (val) {
 		case S2MPS11_LDO_MODE_OFF:
 			*opmode = OP_OFF;
@@ -482,7 +500,7 @@ static int s2mps11_ldo_mode(struct udevice *dev, int op, int *opmode)
 		return -EINVAL;
 	}
 
-	val &= ~(S2MPS11_LDO_MODE_MASK << S2MPS11_LDO_MODE_SHIFT);
+	val &= ~ldo_desc[ldo].mode_mask;
 	val |= mode;
 	ret = pmic_write(dev->parent, addr, &val, 1);
 
diff --git a/include/power/s2mps11.h b/include/power/s2mps11.h
index c08bea5a516a8a48e8ffea993e28df158da026a3..dfbb5f1c165cc177a34365b64c71fa08df5bdcbf 100644
--- a/include/power/s2mps11.h
+++ b/include/power/s2mps11.h
@@ -106,9 +106,6 @@ enum s2mps11_reg {
 
 #define S2MPS11_LDO26_ENABLE	0xec
 
-#define S2MPS11_LDO_NUM		26
-#define S2MPS11_BUCK_NUM	10
-
 /* Driver name */
 #define S2MPS11_BUCK_DRIVER	"s2mps11_buck"
 #define S2MPS11_OF_BUCK_PREFIX	"BUCK"
@@ -153,6 +150,20 @@ enum s2mps11_reg {
 #define S2MPS11_LDO_MODE_STANDBY_LPM	(0x2 << 6)
 #define S2MPS11_LDO_MODE_ON		(0x3 << 6)
 
+struct sec_regulator_desc {
+	/* regulator mode control */
+	unsigned int mode_reg;
+	unsigned int mode_mask;
+
+	/* regulator voltage control */
+	unsigned int volt_reg;
+	unsigned int volt_mask;
+
+	unsigned int volt_min;
+	unsigned int volt_step;
+	unsigned int volt_max_hex;
+};
+
 enum {
 	OP_OFF = 0,
 	OP_LPM,

-- 
2.51.0

