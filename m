Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC52D25030
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 08:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 901B683C5E;
	Sun, 11 Jan 2026 09:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="h6JdoIRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C871783B05; Sun, 11 Jan 2026 09:23:57 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B042D83A9F
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 09:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64b7a38f07eso8523146a12.0
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 00:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768119835; x=1768724635;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtgzZWNyxrestrdjMq7Z3/mtKELvM+5iu53N1RBbkB4=;
 b=h6JdoIRueUpFhD5z7w8F90z9sYBHEmZgDMTMEryCtK9fnBql5VWh7ORAk+hjWPUV4L
 sFqKo+uymfvyi1IAywN5fZgEc38MXWa4Nf7uMTPupbQ7zLlhbXfk7LLgpFEKoD7ZbzmK
 QHkkFfbV1m+/Kk6obuRE7vvPGKwzTX/3ivjSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768119835; x=1768724635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dtgzZWNyxrestrdjMq7Z3/mtKELvM+5iu53N1RBbkB4=;
 b=MrRQmBArpHHY8dhm05lkLzzbJq28VAWwvw19Xx0Fxxrq+nzxcXjm9f0KVG083XJYWL
 UzphnZvkcHW1q0bTGoacW/r/nqsjcZ2Ve9zGFXKA0Lxp/ytkQBJEuaHGkDbkbuJdqWwv
 0nAcSJFzFoFadbDsY0bw+XTY14PPGmCl6hgslvnsZHDIqPKzZUx8njps72ckUk1g5ecS
 PZdvVeeFUnycKgw826+hmkX1hmyzHcsjfcVWZSmbhYRlFM8NvF0P6wiWQT9Xly7Ekg0o
 4CXyy9imHSWY+shJApYlYavDW5l1hmWPneQ3ePMUxpaONxxRRe1v+AnMrCgJCWPNmM08
 qA3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyySOvemvHwnk+DsEEGdQ3lBCtWjtg9GB9tA7KBI4t3lIwIqKOPYj2RXUDtfGjA2UYUxM4Lx4=@lists.denx.de
X-Gm-Message-State: AOJu0YxFXKUJ3XoQ+k5jyZkFoCTprJ/IhT22Ob+w9cQa4l22MEI54O/G
 EtZoFnQr6T41GDWFreUSYrQtYLd0wXGiZoUN8dXoNcn2HgKNpTiak2by+m144EbQBlA=
X-Gm-Gg: AY/fxX4gvmvIz1okUufIJrDvymZmrKO8JNg9q9MHOK2sZIvJyH3qx0l0gIgiRzu1kxA
 Nbdc7+FcgekdiRlOI66gt/dfPuNucKrn1zKSHXT/2YeHZMlic95WEQ/q8F3M9+soSPtVnHemcd6
 Mps525g6xZCyFco4J/cxY4QzLx5D9P0JIXpsSDQM3vmP2pUflNz1rCU5SYyuuah+OsffOmt7ZxR
 w3dcoU3W0KLN3c4Dm4QFvfbqSF37kRtlQhmyWm3N7LgPUnejNED8FzHG+TGevl+vUsUmsTwlJkJ
 B4gl0lFv1q+uxR5D31P+qFi6nFLJwbHNGpHr4tXh7jm1YGM2sgxR+cBG8Pv+q/oKaJXkpZG3TCf
 VEtoQzCUxXM7OUEUUe4mdO1052b4tcMvN2sTRrAHxfuHfuuQee4PYVdKFbxMWbz+kMbT9P4YJ69
 ChgCir0qfQuraOgHhH49nRA5IoXY3S13TRNbnY65KhvYZgFD5o/7hQOt5zO5A3WQZE6jMit1a4e
 6Nmx6CmGp65AVEfYK1mGy7U/4I/mscaBm229XLLCoxNLP5TKj/S4PcYsg==
X-Google-Smtp-Source: AGHT+IHSyuL95DNvHy0ALx8/2AhWs0nMC6eKQk4DbFmDE1GpizWkE+QheeM/lCXTQK4tcBeC+HNcog==
X-Received: by 2002:a05:6402:26d1:b0:64b:5f4e:9e6d with SMTP id
 4fb4d7f45d1cf-65097e50c56mr13244155a12.18.1768119835009; 
 Sun, 11 Jan 2026 00:23:55 -0800 (PST)
Received: from panicking.homenet.telecomitalia.it
 (host-87-5-117-220.retail.telecomitalia.it. [87.5.117.220])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b9d44bfsm14608346a12.8.2026.01.11.00.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 00:23:54 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 1/2] power: regulator: pfuze100: support high voltage range
 bit
Date: Sun, 11 Jan 2026 09:23:46 +0100
Message-ID: <20260111082347.1302003-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260111082347.1302003-1-michael@amarulasolutions.com>
References: <20260111082347.1302003-1-michael@amarulasolutions.com>
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
V1->V2:
	drop change of uv_mask, it's already fixed for bit 6 and anyway
	0x7 was invalid

---
 drivers/power/regulator/pfuze100.c | 65 +++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index f864b1d8834..2242bf68f39 100644
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
@@ -281,6 +291,25 @@ static int pfuze100_regulator_probe(struct udevice *dev)
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

