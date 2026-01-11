Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F55AD2502F
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 07:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A9F83B07;
	Sun, 11 Jan 2026 08:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mYeYFRRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBF583C67; Sun, 11 Jan 2026 08:33:48 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F11683B05
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6505cac9879so9236619a12.1
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 23:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768116826; x=1768721626;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OpZl3MJRE5IEA/t9sJyTFgGpgwLTq3A633zlNV1dLY=;
 b=mYeYFRRf9X3twpypREH1CcmD20LwmIdJcpl6laf0EWL9iMAIqhCaO6nqDp9cNNr3n4
 hW98dCzSZJS/3FaRLULatjdXMNyOnl/qJug5CrGFe+cLI1LUrvw6FuW9Gkt4rKCacoGr
 D/PzCbinUtI2Q6QbrrX5XaQQAJSOFjLNIZz1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768116826; x=1768721626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4OpZl3MJRE5IEA/t9sJyTFgGpgwLTq3A633zlNV1dLY=;
 b=DH80k6ll5+nBOqntYK4WmUhiNobn5TcJKSZ6BKz+1DFrHpcA1wheS3j+oc4uNxdvgB
 b46PaS9mG03bG/QRD0rmMA1GcKxcAiJD83H3IZWN0TNt7NxsAEH7Ykae+zh51LJb0wBg
 c4vKUvjp0zZvHf544GuRLBTeZMAX5jvX6fal8geE3D8AI+e/hVeLFo34cwLj/HM+kWFN
 dRnBY917YQVNfhUWbPNXPQmkvkUGbAZOEbC4HyHb1IbICVq3RIriolUMrZJJqJuUUdfw
 94ME/7WiYRTj1Ezg9mOVhxziuY88aPeE3Gh3vpYMajeTMV653EtTSB+z166aXcZBE6+Y
 Yv/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxSjM1Zoz2dxIDwksdnBswV7TWPMzfCc7q5yIoWhciNPH794QmwCSTM9f5/pLWwv+hQBrm348=@lists.denx.de
X-Gm-Message-State: AOJu0YyHVMUCp9vaSk0E7rCCdSeE36UHGiKwuIm9HQGmY6Al30xrEdPB
 d6HLtK7J8pnoSiN+WF9gKOY1ggxctsampJAMry8Oib3yQNZvJ4Mkl73nEpmh2U0OBM8=
X-Gm-Gg: AY/fxX73MG6LH4UurGn0ZqssDP00vSsGjErkakehdNip+UHtkC4xfoPMBkbKFH2WdTS
 Z/ZIWqcJL58BOzss8DEjLQSAiSL1uj5F92BY1G3rnQY0r54oL82J9zg28zQbRR/lGYxBtRjvMLv
 eZ9wV0h65gmpEimWnE9vhSxYiBPSDs5/IBt7aFQ2vyDObk0V0nwZEJSVz5Ub/Jeg5QQVxs3ACux
 y7b294qphodwDjO3tWFMvI4/S5kJv/N5FpsRJyUoDhpQ/G4d79OoKstZwT0h9hitJaKWL2/AFJZ
 FGyvdwIjWotmLAqHJ0xRXZP+Kw0a1Szf9vNw2QNFEHZwwrCVNuQXouqxHNy52pDSy8KxifeHd3m
 5XDAGo3XUpVADbyULslE6ekeBNGT60cJ4IPIep8LU/M10f2FoM33g3NnSf/w5SkuIZUcosEb6Fr
 sRl2dU71CEBq0d6SmwOVtLoN12GuTa/6+X3BW/r3d6g1PL1veZqXZ1s33GaWSxp19gRHeH5nzS2
 +lPJnUpVbIuzGfYrMka1tRrFu7exQ/dhIyFXKiVPCC7PB3VIwTa2S+ekw==
X-Google-Smtp-Source: AGHT+IHn9qci2QvvMY6Wk+K+LSmOxZ05bDPeqnl6NqBXPg4LXDj7s4gJGSIpnsX1YjV8imX6c6Samw==
X-Received: by 2002:a05:6402:2345:b0:649:6ac4:79af with SMTP id
 4fb4d7f45d1cf-65097dc62abmr13696924a12.6.1768116825668; 
 Sat, 10 Jan 2026 23:33:45 -0800 (PST)
Received: from panicking.homenet.telecomitalia.it
 (host-87-5-117-220.retail.telecomitalia.it. [87.5.117.220])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d683sm14548782a12.34.2026.01.10.23.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 23:33:44 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 1/2] power: regulator: pfuze100: support high voltage range bit
Date: Sun, 11 Jan 2026 08:33:38 +0100
Message-ID: <20260111073339.1297089-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260111073339.1297089-1-michael@amarulasolutions.com>
References: <20260111073339.1297089-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The PFUZE100/200/3000 family of PMICs allow switching regulators (specifically
SW2, SW3A/B, SW4 on PFUZE100/200 and SW2 on PFUZE3000) to operate in a
"high" voltage range mode. This mode is indicated by a specific bit in the
voltage selection register (bit 3 for PFUZE3000, bit 6 for others).

When this bit is set:
- PFUZE100/200 switches from a 25mV step to a 50mV step, with a different
  minimum voltage (800mV).
- PFUZE3000 SW2 switches to a completely different non-linear voltage table.

Currently, the driver uses static descriptors that assume the low/default
range. This results in incorrect voltage readings and settings if the
PMIC is configured for the high range.

This patch updates the driver to:
1. Identify regulators with high-bit support via a new `hi_bit` flag.
2. Read the register during probe to detect the current range configuration.
3. Dynamically update the regulator descriptor (step, mask, min_uV, or table)
   to match the active range.

This aligns the U-Boot driver behavior with the Linux kernel implementation.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/power/regulator/pfuze100.c | 66 ++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index f864b1d8834..63d39c21bb8 100644
--- a/drivers/power/regulator/pfuze100.c
+++ b/drivers/power/regulator/pfuze100.c
@@ -18,6 +18,7 @@
  *
  * @name: Identify name for the regulator.
  * @type: Indicates the regulator type.
+ * @hi_bit: Indicate if support hi voltage range.
  * @uV_step: Voltage increase for each selector.
  * @vsel_reg: Register for adjust regulator voltage for normal.
  * @vsel_mask: Mask bit for setting regulator voltage for normal.
@@ -29,6 +30,7 @@
 struct pfuze100_regulator_desc {
 	char *name;
 	enum regulator_type type;
+	bool hi_bit;
 	unsigned int uV_step;
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
@@ -54,10 +56,11 @@ struct pfuze100_regulator_plat {
 		.voltage	=	(vol),				\
 	}
 
-#define PFUZE100_SW_REG(_name, base, step)				\
+#define PFUZE100_SW_REG(_name, base, step, hbit)			\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_BUCK,		\
+		.hi_bit		=	(hbit),				\
 		.uV_step	=	(step),				\
 		.vsel_reg	=	(base) + PFUZE100_VOL_OFFSET,	\
 		.vsel_mask	=	0x3F,				\
@@ -65,10 +68,11 @@ struct pfuze100_regulator_plat {
 		.stby_mask	=	0x3F,				\
 	}
 
-#define PFUZE100_SWB_REG(_name, base, mask, step, voltages)		\
+#define PFUZE100_SWB_REG(_name, base, mask, step, voltages, hbit)	\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_BUCK,		\
+		.hi_bit		=	(hbit),				\
 		.uV_step	=	(step),				\
 		.vsel_reg	=	(base),				\
 		.vsel_mask	=	(mask),				\
@@ -155,15 +159,19 @@ static unsigned int pfuze3000_sw2lo[] = {
 	1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000
 };
 
+static unsigned int pfuze3000_sw2hi[] = {
+	2500000, 2800000, 2850000, 3000000, 3100000, 3150000, 3200000, 3300000,
+};
+
 /* PFUZE100 */
 static struct pfuze100_regulator_desc pfuze100_regulators[] = {
-	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000),
-	PFUZE100_SW_REG(sw1c, PFUZE100_SW1CVOL, 25000),
-	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000),
-	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000),
-	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000),
-	PFUZE100_SW_REG(sw4, PFUZE100_SW4VOL, 25000),
-	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst),
+	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, false),
+	PFUZE100_SW_REG(sw1c, PFUZE100_SW1CVOL, 25000, false),
+	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, true),
+	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, true),
+	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, true),
+	PFUZE100_SW_REG(sw4, PFUZE100_SW4VOL, 25000, true),
+	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst, false),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
 	PFUZE100_VGEN_REG(vgen1, PFUZE100_VGEN1VOL, 50000),
@@ -176,11 +184,11 @@ static struct pfuze100_regulator_desc pfuze100_regulators[] = {
 
 /* PFUZE200 */
 static struct pfuze100_regulator_desc pfuze200_regulators[] = {
-	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000),
-	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000),
-	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000),
-	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000),
-	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst),
+	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, false),
+	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, true),
+	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, true),
+	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, true),
+	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst, false),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
 	PFUZE100_VGEN_REG(vgen1, PFUZE100_VGEN1VOL, 50000),
@@ -195,9 +203,9 @@ static struct pfuze100_regulator_desc pfuze200_regulators[] = {
 static struct pfuze100_regulator_desc pfuze3000_regulators[] = {
 	PFUZE3000_SW1_REG(sw1a, PFUZE100_SW1ABVOL, 25000),
 	PFUZE3000_SW1_REG(sw1b, PFUZE100_SW1CVOL, 25000),
-	PFUZE100_SWB_REG(sw2, PFUZE100_SW2VOL, 0x7, 50000, pfuze3000_sw2lo),
+	PFUZE100_SWB_REG(sw2, PFUZE100_SW2VOL, 0x7, 50000, pfuze3000_sw2lo, true),
 	PFUZE3000_SW3_REG(sw3, PFUZE100_SW3AVOL, 50000),
-	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst),
+	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst, false),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze3000_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
 	PFUZE100_VGEN_REG(vldo1, PFUZE100_VGEN1VOL, 100000),
@@ -246,9 +254,10 @@ static int pfuze100_regulator_probe(struct udevice *dev)
 	struct dm_regulator_uclass_plat *uc_pdata;
 	struct pfuze100_regulator_plat *plat = dev_get_plat(dev);
 	struct pfuze100_regulator_desc *desc;
-	int i, size;
+	int i, size, val, sw_hi = 0x40;
+	int version = dev_get_driver_data(dev_get_parent(dev));
 
-	switch (dev_get_driver_data(dev_get_parent(dev))) {
+	switch (version) {
 	case PFUZE100:
 		desc = pfuze100_regulators;
 		size = ARRAY_SIZE(pfuze100_regulators);
@@ -260,6 +269,7 @@ static int pfuze100_regulator_probe(struct udevice *dev)
 	case PFUZE3000:
 		desc = pfuze3000_regulators;
 		size = ARRAY_SIZE(pfuze3000_regulators);
+		sw_hi = 1 << 3;
 		break;
 	default:
 		debug("Unsupported PFUZE\n");
@@ -281,6 +291,26 @@ static int pfuze100_regulator_probe(struct udevice *dev)
 	uc_pdata = dev_get_uclass_plat(dev);
 
 	uc_pdata->type = desc[i].type;
+
+	/* SW2~SW4 high bit check and modify the voltage value table */
+	if (desc[i].hi_bit) {
+		val = pmic_reg_read(dev->parent, desc[i].vsel_reg);
+		if (val < 0) {
+			printf("Fails to read from the register.\n");
+			return -EIO;
+		}
+
+		if (val & sw_hi) {
+			if (version == PFUZE3000) {
+				desc[i].volt_table = pfuze3000_sw2hi;
+			} else {
+				desc[i].uV_step = 50000;
+				desc[i].vsel_mask = 0x7;
+				uc_pdata->min_uV = 800000;
+			}
+		}
+	}
+
 	if (uc_pdata->type == REGULATOR_TYPE_BUCK) {
 		if (!strcmp(dev->name, "swbst")) {
 			uc_pdata->mode = pfuze_swbst_modes;
-- 
2.51.0

