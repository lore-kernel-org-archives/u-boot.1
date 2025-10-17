Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4A4CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C275F839AD;
	Fri, 17 Oct 2025 17:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="KMevHBwf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 098D883852; Fri, 17 Oct 2025 17:29:04 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C70F583826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8197322C39;
 Fri, 17 Oct 2025 17:29:01 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fyj7rwuK794z; Fri, 17 Oct 2025 17:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714940; bh=fuaWS4WJ/h0xCYOSePKXUb+OUkU8468ItMf6++NJXk0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KMevHBwfOqgnt7lSXhRzCNfhF6WPCbkY47p85Tq8C5CgaPIpsUaJ84YuX+Khp+D2X
 oIIKd/VOSCSrPPVz/xJAGnPGn9U1lBh6wsiharQ9XC5sw2HJH2WuXuWbFC4JeoQkZT
 UCiG0F86P3B87UyaAFKdwFep1ipQsLU7cRtY3dElpoi4AeCh/FqkS+nmazxzIQR8ss
 8Oy1ZAo942WWs/Gyd/Em98NjFwJFe+D6LcjED7Hrwqb1DjYkZfll7Alv56uDeq1dVa
 sFf/GxOkxvBeWaIBV+vqNeroSVraIJ89jYIgwB94nt+nfKuX+OFS58V/J3U9Y/dVSz
 nwMMqSbg+IqfQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:58:20 +0530
Subject: [PATCH 5/6] power: regulator: s2mps11: add support for S2MPU05
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-power-pmic-regulator-s2mpu05-v1-5-91cadc0f4156@disroot.org>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>, 
 Anand Moon <linux.amoon@gmail.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714904; l=9854;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=fuaWS4WJ/h0xCYOSePKXUb+OUkU8468ItMf6++NJXk0=;
 b=GC46BKIy4EhUobp1lYN0vzC6YZXdQjGehVRX/DGGEYl/pvNhC2QREYrjlca1aBIuuQADw0CZh
 OkBrl7oRw3NBVgFj3tIxSZbY6/qUK8CSKnFhk/uNovpB8p2ZByVzWmP
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

Samsung's S2MPU05 PMIC is used by Exynos7870 SoC. It has 5 buck and 38
LDO regulators. Add support for this device variant in the driver.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/power/regulator/s2mps11_regulator.c | 110 +++++++++++++++++++++++++++
 include/power/s2mps11.h                     | 112 ++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)

diff --git a/drivers/power/regulator/s2mps11_regulator.c b/drivers/power/regulator/s2mps11_regulator.c
index 17a0a4d7ce676db7d11aa39e58a68d6f8c3f1a0a..4b4353af6394113ee481709fa37059bb6f5c41fe 100644
--- a/drivers/power/regulator/s2mps11_regulator.c
+++ b/drivers/power/regulator/s2mps11_regulator.c
@@ -119,6 +119,87 @@ static const struct sec_regulator_desc s2mps11_ldo_desc[] = {
 	regulator_desc_s2mps11_ldo_type2(38),
 };
 
+#define regulator_desc_s2mpu05_buck(num, which)						\
+	[num] = {									\
+		.mode_reg	= S2MPU05_REG_B##num##CTRL1,				\
+		.mode_mask	= S2MPS11_BUCK_MODE_MASK << S2MPS11_BUCK_MODE_SHIFT,	\
+		.volt_reg	= S2MPU05_REG_B##num##CTRL2,				\
+		.volt_mask	= S2MPS11_BUCK_VOLT_MASK,				\
+		.volt_min	= S2MPU05_BUCK_MIN##which,				\
+		.volt_step	= S2MPU05_BUCK_STEP##which,				\
+		.volt_max_hex	= S2MPS11_BUCK_VOLT_MASK,				\
+	}
+
+#define regulator_desc_s2mpu05_buck1_2_3(num)	\
+	regulator_desc_s2mpu05_buck(num, 1)
+
+#define regulator_desc_s2mpu05_buck4_5(num)	\
+	regulator_desc_s2mpu05_buck(num, 2)
+
+static const struct sec_regulator_desc s2mpu05_buck_desc[] = {
+	regulator_desc_s2mpu05_buck1_2_3(1),
+	regulator_desc_s2mpu05_buck1_2_3(2),
+	regulator_desc_s2mpu05_buck1_2_3(3),
+	regulator_desc_s2mpu05_buck4_5(4),
+	regulator_desc_s2mpu05_buck4_5(5),
+};
+
+#define regulator_desc_s2mpu05_ldo(num, reg, min, step)					\
+	[num] = {									\
+		.mode_reg	= S2MPU05_REG_L##num##reg,				\
+		.mode_mask	= S2MPS11_LDO_MODE_MASK << S2MPS11_LDO_MODE_SHIFT,	\
+		.volt_reg	= S2MPU05_REG_L##num##reg,				\
+		.volt_mask	= S2MPS11_LDO_VOLT_MASK,				\
+		.volt_min	= min,							\
+		.volt_step	= step,							\
+		.volt_max_hex	= S2MPS11_LDO_VOLT_MAX_HEX,				\
+	}
+
+#define regulator_desc_s2mpu05_ldo_type1(num)				\
+	regulator_desc_s2mpu05_ldo(num, CTRL, S2MPU05_LDO_MIN1,		\
+					      S2MPU05_LDO_STEP1)
+
+#define regulator_desc_s2mpu05_ldo_type2(num)				\
+	regulator_desc_s2mpu05_ldo(num, CTRL, S2MPU05_LDO_MIN1,		\
+					      S2MPU05_LDO_STEP2)
+
+#define regulator_desc_s2mpu05_ldo_type3(num)				\
+	regulator_desc_s2mpu05_ldo(num, CTRL, S2MPU05_LDO_MIN2,		\
+					      S2MPU05_LDO_STEP2)
+
+#define regulator_desc_s2mpu05_ldo_type4(num)				\
+	regulator_desc_s2mpu05_ldo(num, CTRL, S2MPU05_LDO_MIN3,		\
+					      S2MPU05_LDO_STEP2)
+
+#define regulator_desc_s2mpu05_ldo_type5(num)				\
+	regulator_desc_s2mpu05_ldo(num, CTRL1, S2MPU05_LDO_MIN3,	\
+					       S2MPU05_LDO_STEP2)
+
+static const struct sec_regulator_desc s2mpu05_ldo_desc[] = {
+	regulator_desc_s2mpu05_ldo_type4(1),
+	regulator_desc_s2mpu05_ldo_type3(2),
+	regulator_desc_s2mpu05_ldo_type2(3),
+	regulator_desc_s2mpu05_ldo_type1(4),
+	regulator_desc_s2mpu05_ldo_type1(5),
+	regulator_desc_s2mpu05_ldo_type1(6),
+	regulator_desc_s2mpu05_ldo_type2(7),
+	regulator_desc_s2mpu05_ldo_type3(8),
+	regulator_desc_s2mpu05_ldo_type5(9),
+	regulator_desc_s2mpu05_ldo_type4(10),
+	/* LDOs 11-24 are used for CP. They aren't documented. */
+	regulator_desc_s2mpu05_ldo_type2(25),
+	regulator_desc_s2mpu05_ldo_type3(26),
+	regulator_desc_s2mpu05_ldo_type2(27),
+	regulator_desc_s2mpu05_ldo_type3(28),
+	regulator_desc_s2mpu05_ldo_type3(29),
+	regulator_desc_s2mpu05_ldo_type2(30),
+	regulator_desc_s2mpu05_ldo_type3(31),
+	regulator_desc_s2mpu05_ldo_type3(32),
+	regulator_desc_s2mpu05_ldo_type3(33),
+	regulator_desc_s2mpu05_ldo_type3(34),
+	regulator_desc_s2mpu05_ldo_type3(35),
+};
+
 #define MODE(_id, _val, _name) { \
 	.id = _id, \
 	.register_value = _val, \
@@ -139,6 +220,11 @@ static struct dm_regulator_mode s2mps11_ldo_modes[] = {
 	MODE(OP_ON, S2MPS11_LDO_MODE_ON, "ON"),
 };
 
+static struct dm_regulator_mode s2mpu05_regulator_modes[] = {
+	MODE(OP_OFF, S2MPS11_LDO_MODE_OFF, "OFF"),
+	MODE(OP_ON, S2MPS11_LDO_MODE_ON, "ON"),
+};
+
 static const ulong s2mps11_get_variant(struct udevice *dev)
 {
 	struct udevice *parent = dev_get_parent(dev);
@@ -163,6 +249,10 @@ static int s2mps11_buck_val(struct udevice *dev, int op, int *uV)
 		buck_desc = s2mps11_buck_desc;
 		num_bucks = ARRAY_SIZE(s2mps11_buck_desc);
 		break;
+	case VARIANT_S2MPU05:
+		buck_desc = s2mpu05_buck_desc;
+		num_bucks = ARRAY_SIZE(s2mpu05_buck_desc);
+		break;
 	default:
 		pr_err("Unknown device type\n");
 		return -EINVAL;
@@ -215,6 +305,10 @@ static int s2mps11_buck_mode(struct udevice *dev, int op, int *opmode)
 		buck_desc = s2mps11_buck_desc;
 		num_bucks = ARRAY_SIZE(s2mps11_buck_desc);
 		break;
+	case VARIANT_S2MPU05:
+		buck_desc = s2mpu05_buck_desc;
+		num_bucks = ARRAY_SIZE(s2mpu05_buck_desc);
+		break;
 	default:
 		pr_err("Unknown device type\n");
 		return -EINVAL;
@@ -352,6 +446,10 @@ static int s2mps11_buck_probe(struct udevice *dev)
 		uc_pdata->mode = s2mps11_buck_modes;
 		uc_pdata->mode_count = ARRAY_SIZE(s2mps11_buck_modes);
 		break;
+	case VARIANT_S2MPU05:
+		uc_pdata->mode = s2mpu05_regulator_modes;
+		uc_pdata->mode_count = ARRAY_SIZE(s2mpu05_regulator_modes);
+		break;
 	default:
 		pr_err("Unknown device type\n");
 		return -EINVAL;
@@ -388,6 +486,10 @@ static int s2mps11_ldo_val(struct udevice *dev, int op, int *uV)
 		ldo_desc = s2mps11_ldo_desc;
 		num_ldos = ARRAY_SIZE(s2mps11_ldo_desc);
 		break;
+	case VARIANT_S2MPU05:
+		ldo_desc = s2mpu05_ldo_desc;
+		num_ldos = ARRAY_SIZE(s2mpu05_ldo_desc);
+		break;
 	default:
 		pr_err("Unknown device type\n");
 		return -EINVAL;
@@ -440,6 +542,10 @@ static int s2mps11_ldo_mode(struct udevice *dev, int op, int *opmode)
 		ldo_desc = s2mps11_ldo_desc;
 		num_ldos = ARRAY_SIZE(s2mps11_ldo_desc);
 		break;
+	case VARIANT_S2MPU05:
+		ldo_desc = s2mpu05_ldo_desc;
+		num_ldos = ARRAY_SIZE(s2mpu05_ldo_desc);
+		break;
 	default:
 		pr_err("Unknown device type\n");
 		return -EINVAL;
@@ -586,6 +692,10 @@ static int s2mps11_ldo_probe(struct udevice *dev)
 		uc_pdata->mode = s2mps11_ldo_modes;
 		uc_pdata->mode_count = ARRAY_SIZE(s2mps11_ldo_modes);
 		break;
+	case VARIANT_S2MPU05:
+		uc_pdata->mode = s2mpu05_regulator_modes;
+		uc_pdata->mode_count = ARRAY_SIZE(s2mpu05_regulator_modes);
+		break;
 	default:
 		pr_err("Unknown device type\n");
 		return -EINVAL;
diff --git a/include/power/s2mps11.h b/include/power/s2mps11.h
index dfbb5f1c165cc177a34365b64c71fa08df5bdcbf..51eb79bdde19f5b69245c754ebe79ae5680787ad 100644
--- a/include/power/s2mps11.h
+++ b/include/power/s2mps11.h
@@ -150,6 +150,117 @@ enum s2mps11_reg {
 #define S2MPS11_LDO_MODE_STANDBY_LPM	(0x2 << 6)
 #define S2MPS11_LDO_MODE_ON		(0x3 << 6)
 
+enum s2mpu05_reg {
+	S2MPU05_REG_ID,
+	S2MPU05_REG_INT1,
+	S2MPU05_REG_INT2,
+	S2MPU05_REG_INT3,
+	S2MPU05_REG_INT1M,
+	S2MPU05_REG_INT2M,
+	S2MPU05_REG_INT3M,
+	S2MPU05_REG_ST1,
+	S2MPU05_REG_ST2,
+	S2MPU05_REG_PWRONSRC,
+	S2MPU05_REG_OFFSRC,
+	S2MPU05_REG_BU_CHG,
+	S2MPU05_REG_RTC_BUF,
+	S2MPU05_REG_CTRL1,
+	S2MPU05_REG_CTRL2,
+	S2MPU05_REG_ETC_TEST,
+	S2MPU05_REG_OTP_ADRL,
+	S2MPU05_REG_OTP_ADRH,
+	S2MPU05_REG_OTP_DATA,
+	S2MPU05_REG_MON1SEL,
+	S2MPU05_REG_MON2SEL,
+	S2MPU05_REG_CTRL3,
+	S2MPU05_REG_ETC_OTP,
+	S2MPU05_REG_UVLO,
+	S2MPU05_REG_TIME_CTRL1,
+	S2MPU05_REG_TIME_CTRL2,
+	S2MPU05_REG_B1CTRL1,
+	S2MPU05_REG_B1CTRL2,
+	S2MPU05_REG_B2CTRL1,
+	S2MPU05_REG_B2CTRL2,
+	S2MPU05_REG_B2CTRL3,
+	S2MPU05_REG_B2CTRL4,
+	S2MPU05_REG_B3CTRL1,
+	S2MPU05_REG_B3CTRL2,
+	S2MPU05_REG_B3CTRL3,
+	S2MPU05_REG_B4CTRL1,
+	S2MPU05_REG_B4CTRL2,
+	S2MPU05_REG_B5CTRL1,
+	S2MPU05_REG_B5CTRL2,
+	S2MPU05_REG_BUCK_RAMP,
+	S2MPU05_REG_LDO_DVS1,
+	S2MPU05_REG_LDO_DVS9,
+	S2MPU05_REG_LDO_DVS10,
+	S2MPU05_REG_L1CTRL,
+	S2MPU05_REG_L2CTRL,
+	S2MPU05_REG_L3CTRL,
+	S2MPU05_REG_L4CTRL,
+	S2MPU05_REG_L5CTRL,
+	S2MPU05_REG_L6CTRL,
+	S2MPU05_REG_L7CTRL,
+	S2MPU05_REG_L8CTRL,
+	S2MPU05_REG_L9CTRL1,
+	S2MPU05_REG_L9CTRL2,
+	S2MPU05_REG_L10CTRL,
+	S2MPU05_REG_L11CTRL1,
+	S2MPU05_REG_L11CTRL2,
+	S2MPU05_REG_L12CTRL,
+	S2MPU05_REG_L13CTRL,
+	S2MPU05_REG_L14CTRL,
+	S2MPU05_REG_L15CTRL,
+	S2MPU05_REG_L16CTRL,
+	S2MPU05_REG_L17CTRL1,
+	S2MPU05_REG_L17CTRL2,
+	S2MPU05_REG_L18CTRL1,
+	S2MPU05_REG_L18CTRL2,
+	S2MPU05_REG_L19CTRL,
+	S2MPU05_REG_L20CTRL,
+	S2MPU05_REG_L21CTRL,
+	S2MPU05_REG_L22CTRL,
+	S2MPU05_REG_L23CTRL,
+	S2MPU05_REG_L24CTRL,
+	S2MPU05_REG_L25CTRL,
+	S2MPU05_REG_L26CTRL,
+	S2MPU05_REG_L27CTRL,
+	S2MPU05_REG_L28CTRL,
+	S2MPU05_REG_L29CTRL,
+	S2MPU05_REG_L30CTRL,
+	S2MPU05_REG_L31CTRL,
+	S2MPU05_REG_L32CTRL,
+	S2MPU05_REG_L33CTRL,
+	S2MPU05_REG_L34CTRL,
+	S2MPU05_REG_L35CTRL,
+	S2MPU05_REG_LDO_DSCH1,
+	S2MPU05_REG_LDO_DSCH2,
+	S2MPU05_REG_LDO_DSCH3,
+	S2MPU05_REG_LDO_DSCH4,
+	S2MPU05_REG_LDO_DSCH5,
+	S2MPU05_REG_LDO_CTRL1,
+	S2MPU05_REG_LDO_CTRL2,
+	S2MPU05_REG_TCXO_CTRL,
+	S2MPU05_REG_SELMIF,
+	S2MPU05_REG_COUNT,
+};
+
+#define S2MPU05_OF_BUCK_PREFIX	"buck"
+#define S2MPU05_OF_LDO_PREFIX	"ldo"
+
+/* BUCK */
+#define S2MPU05_BUCK_MIN1	400000
+#define S2MPU05_BUCK_MIN2	600000
+#define S2MPU05_BUCK_STEP1	6250
+#define S2MPU05_BUCK_STEP2	12500
+
+/* LDO */
+#define S2MPU05_LDO_MIN1	800000
+#define S2MPU05_LDO_MIN2	1800000
+#define S2MPU05_LDO_MIN3	400000
+#define S2MPU05_LDO_STEP1	12500
+#define S2MPU05_LDO_STEP2	25000
+
 struct sec_regulator_desc {
 	/* regulator mode control */
 	unsigned int mode_reg;
@@ -175,6 +286,7 @@ enum {
 enum {
 	VARIANT_NONE,
 	VARIANT_S2MPS11,
+	VARIANT_S2MPU05,
 };
 
 #endif

-- 
2.51.0

