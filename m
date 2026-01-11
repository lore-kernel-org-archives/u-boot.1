Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D194BD2502E
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 07:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFDBD83C65;
	Sun, 11 Jan 2026 08:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gbmN1ZmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF3883C67; Sun, 11 Jan 2026 08:33:49 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96ACE83C5E
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64b921d9e67so9335631a12.3
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 23:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768116827; x=1768721627;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQidZ+PZ2lNQ0SE35FIC4EZo92wupR0Qpu6LmjJaFLY=;
 b=gbmN1ZmCVSmo4MxvGJ5d6ZDBrKcj9qISmQOkRlFkrHSscAmKPgxrqu/MSpLWa277Sc
 O+sfdBqRwnKz2178NLWknND8shekZ0LxpCKNzkPzlKPBEOMksZWcQ7EWMXcKz//XfATZ
 HhKFWamVe26UwrBh8bOaBG9SlPClqxvhJ2xdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768116827; x=1768721627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQidZ+PZ2lNQ0SE35FIC4EZo92wupR0Qpu6LmjJaFLY=;
 b=m722ZJMfFGN4j38XE9+d9y5lcyWEYI+7FFpI48A7AEXR5OaogzmwWLaz85YwYXNiSu
 Uv/da7POy83V40MFB5H5x9Vnk8RUZ/b9Ongnyf8iTz2N5Yn/y2ClA6v9ISg079iqergr
 pEvbcPODxAb0gXCAbRoUAnEk+3JNqtt7ngEKPQqLRm7Qq9cBrcPPeAdrvOiSFcyNCk1E
 nDsKubTiMwSHuR5TI3XVywAYsc9pnJl0qQXg9NuSSXmLv6JELE3V+TPwlVAV3dsDyBnP
 VNfudpXlRjPLi2NwPNVUrfjK0OJtQD0N6MokNFPV5I9SNEgPIcnIVPQxExLUX3rvbRmA
 pcPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvt24tdwCRHXbnXJUBjnPU5hxqU/Lkf8CL7hiViPKD4/0jYVHwcs71SM76sBIK/AgZEA0xDGg=@lists.denx.de
X-Gm-Message-State: AOJu0YyXE7cMk6fdzIkRN4ob1rICgnyQ5gteYBv50FxQd90KZGDzdJOA
 ZShSrM4yFAHeWlUFCs7mOmtGfNH/oVz8fqJqWW/k5qynCixQRaVRXDbW9lQT4kLzRR8=
X-Gm-Gg: AY/fxX5Dt6ZEwxOIg3yN0D0XOlMCuATGbtETQSkc/y3KK9FRZHD+wVXxrNhP00rGoDR
 yBAq9+3CRX6bT+aWQeQgvBW7BbB5gIsJlftiD4KkJsQr1NS95cZENt4WNuSXX2+tjCBMiP1CQpo
 P2cYjTG6IsDu4PV+kp0COLqWX3daqHpLaZODyFHtHmIi7w/kbSqA09Xu2gEGjaAqd+uJGTKP/SP
 v8/Y5VDuDTcmf1tjVWkWsjQ2rTD2bmYqcLuYM6Nu7hwrDgGCUmtrYUe0U/Oo72Zzg5yzfqIeExt
 FAKINteHQZfHccs1FfV2LSbz345o5P+U0CPyrpNJRNua7tTCKZvWJ/3DAc6marz8wtuPHwynpb6
 JZhWxQC0UaS1des1FAlHN/DRuXwdZd2U9EpGBZ9+xGh4OTQ/aXGjDhhAsAEI9T3xD6xL8TPnNVL
 s0XSLpgjjvRo5hEamo0WiMnvG4tnTZKc1yuwP01asHexjvdmxE5z67iDwhYvHMxm99cCZDdYzb9
 vSfly8yDIt5N/7N9j7rfaM15TELjOu6vWW/X/EMur++VX96kt9zFuuRXg==
X-Google-Smtp-Source: AGHT+IHYOfY9Nb/vYdAc+FsQdSJv9cFUf8ZIx2GsN9Cm2twm3ibisx/b+G16IKW14iJSWCDLJlSpbQ==
X-Received: by 2002:a05:6402:5186:b0:64b:7231:da3d with SMTP id
 4fb4d7f45d1cf-65097de81f7mr11937135a12.9.1768116827015; 
 Sat, 10 Jan 2026 23:33:47 -0800 (PST)
Received: from panicking.homenet.telecomitalia.it
 (host-87-5-117-220.retail.telecomitalia.it. [87.5.117.220])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d683sm14548782a12.34.2026.01.10.23.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 23:33:46 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 2/2] power: regulator: pfuze100: Decouple hardware base
 voltage from DTS constraints
Date: Sun, 11 Jan 2026 08:33:39 +0100
Message-ID: <20260111073339.1297089-3-michael@amarulasolutions.com>
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

Currently, the driver uses the device tree property `regulator-min-microvolt`
(accessed via `uc_pdata->min_uV`) as the base voltage for calculating
voltage register values.

However, the device tree property defines the safety constraint (the
minimum voltage allowed for the specific board/consumer), not the physical
minimum voltage the regulator outputs when the selector is at 0.

Using the DTS constraint as the linear base leads to incorrect voltage
calculations if the constraint does not exactly match the hardware's
zero-index voltage. For example, if a regulator physically starts at
700mV but the DTS constrains it to 1000mV, the driver incorrectly calculates
the selector assuming 0 corresponds to 1000mV.

Fix this by:
1. Adding a `min_uV` field to the regulator descriptor to hold the
   true hardware base voltage as defined in the datasheet.
2. Updating the regulator definitions with the correct base voltages
   (aligned with Linux kernel driver definitions).
3. Using the descriptor's hardware minimum for all voltage-to-selector
   calculations, instead of the DTS constraint.
4. Adding a validation check to ensure the DTS constraint is within the
   hardware's possible range.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/power/regulator/pfuze100.c | 94 ++++++++++++++++--------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index 63d39c21bb8..107f036d33f 100644
--- a/drivers/power/regulator/pfuze100.c
+++ b/drivers/power/regulator/pfuze100.c
@@ -32,6 +32,7 @@ struct pfuze100_regulator_desc {
 	enum regulator_type type;
 	bool hi_bit;
 	unsigned int uV_step;
+	unsigned int min_uV;
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
 	unsigned int stby_reg;
@@ -54,13 +55,15 @@ struct pfuze100_regulator_plat {
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_FIXED,		\
 		.voltage	=	(vol),				\
+		.min_uV		=	(vol),				\
 	}
 
-#define PFUZE100_SW_REG(_name, base, step, hbit)			\
+#define PFUZE100_SW_REG(_name, base, min, step, hbit)			\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_BUCK,		\
 		.hi_bit		=	(hbit),				\
+		.min_uV		=	(min),				\
 		.uV_step	=	(step),				\
 		.vsel_reg	=	(base) + PFUZE100_VOL_OFFSET,	\
 		.vsel_mask	=	0x3F,				\
@@ -88,10 +91,11 @@ struct pfuze100_regulator_plat {
 		.volt_table	=	(voltages),			\
 	}
 
-#define PFUZE100_VGEN_REG(_name, base, step)				\
+#define PFUZE100_VGEN_REG(_name, base, min, step)				\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_LDO,		\
+		.min_uV		=	(min),				\
 		.uV_step	=	(step),				\
 		.vsel_reg	=	(base),				\
 		.vsel_mask	=	0xF,				\
@@ -99,10 +103,11 @@ struct pfuze100_regulator_plat {
 		.stby_mask	=	0x20,				\
 	}
 
-#define PFUZE3000_VCC_REG(_name, base, step)				\
+#define PFUZE3000_VCC_REG(_name, base, min, step)				\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_LDO,		\
+		.min_uV		=	(min),				\
 		.uV_step	=	(step),				\
 		.vsel_reg	=	(base),				\
 		.vsel_mask	=	0x3,				\
@@ -110,10 +115,11 @@ struct pfuze100_regulator_plat {
 		.stby_mask	=	0x20,				\
 }
 
-#define PFUZE3000_SW1_REG(_name, base, step)				\
+#define PFUZE3000_SW1_REG(_name, base, min, step)				\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_BUCK,		\
+		.min_uV		=	(min),				\
 		.uV_step	=	(step),				\
 		.vsel_reg	=	(base) + PFUZE100_VOL_OFFSET,	\
 		.vsel_mask	=	0x1F,				\
@@ -121,10 +127,11 @@ struct pfuze100_regulator_plat {
 		.stby_mask	=	0x1F,				\
 	}
 
-#define PFUZE3000_SW2_REG(_name, base, step)				\
+#define PFUZE3000_SW2_REG(_name, base, min, step)				\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_BUCK,		\
+		.min_uV		=	(min),				\
 		.uV_step	=	(step),				\
 		.vsel_reg	=	(base) + PFUZE100_VOL_OFFSET,	\
 		.vsel_mask	=	0x7,				\
@@ -132,10 +139,11 @@ struct pfuze100_regulator_plat {
 		.stby_mask	=	0x7,				\
 	}
 
-#define PFUZE3000_SW3_REG(_name, base, step)				\
+#define PFUZE3000_SW3_REG(_name, base, min, step)			\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_BUCK,		\
+		.min_uV		=	(min),				\
 		.uV_step	=	(step),				\
 		.vsel_reg	=	(base) + PFUZE100_VOL_OFFSET,	\
 		.vsel_mask	=	0xF,				\
@@ -165,55 +173,55 @@ static unsigned int pfuze3000_sw2hi[] = {
 
 /* PFUZE100 */
 static struct pfuze100_regulator_desc pfuze100_regulators[] = {
-	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, false),
-	PFUZE100_SW_REG(sw1c, PFUZE100_SW1CVOL, 25000, false),
-	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, true),
-	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, true),
-	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, true),
-	PFUZE100_SW_REG(sw4, PFUZE100_SW4VOL, 25000, true),
+	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 300000, 25000, false),
+	PFUZE100_SW_REG(sw1c, PFUZE100_SW1CVOL, 300000, 25000, false),
+	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 400000, 25000, true),
+	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 400000, 25000, true),
+	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 400000, 25000, true),
+	PFUZE100_SW_REG(sw4, PFUZE100_SW4VOL, 400000, 25000, true),
 	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst, false),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
-	PFUZE100_VGEN_REG(vgen1, PFUZE100_VGEN1VOL, 50000),
-	PFUZE100_VGEN_REG(vgen2, PFUZE100_VGEN2VOL, 50000),
-	PFUZE100_VGEN_REG(vgen3, PFUZE100_VGEN3VOL, 100000),
-	PFUZE100_VGEN_REG(vgen4, PFUZE100_VGEN4VOL, 100000),
-	PFUZE100_VGEN_REG(vgen5, PFUZE100_VGEN5VOL, 100000),
-	PFUZE100_VGEN_REG(vgen6, PFUZE100_VGEN6VOL, 100000),
+	PFUZE100_VGEN_REG(vgen1, PFUZE100_VGEN1VOL, 800000, 50000),
+	PFUZE100_VGEN_REG(vgen2, PFUZE100_VGEN2VOL, 800000, 50000),
+	PFUZE100_VGEN_REG(vgen3, PFUZE100_VGEN3VOL, 1800000, 100000),
+	PFUZE100_VGEN_REG(vgen4, PFUZE100_VGEN4VOL, 1800000, 100000),
+	PFUZE100_VGEN_REG(vgen5, PFUZE100_VGEN5VOL, 1800000, 100000),
+	PFUZE100_VGEN_REG(vgen6, PFUZE100_VGEN6VOL, 1800000, 100000),
 };
 
 /* PFUZE200 */
 static struct pfuze100_regulator_desc pfuze200_regulators[] = {
-	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, false),
-	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, true),
-	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, true),
-	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, true),
+	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 300000, 25000, false),
+	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 400000, 25000, true),
+	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 400000, 25000, true),
+	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 400000, 25000, true),
 	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst, false),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
-	PFUZE100_VGEN_REG(vgen1, PFUZE100_VGEN1VOL, 50000),
-	PFUZE100_VGEN_REG(vgen2, PFUZE100_VGEN2VOL, 50000),
-	PFUZE100_VGEN_REG(vgen3, PFUZE100_VGEN3VOL, 100000),
-	PFUZE100_VGEN_REG(vgen4, PFUZE100_VGEN4VOL, 100000),
-	PFUZE100_VGEN_REG(vgen5, PFUZE100_VGEN5VOL, 100000),
-	PFUZE100_VGEN_REG(vgen6, PFUZE100_VGEN6VOL, 100000),
+	PFUZE100_VGEN_REG(vgen1, PFUZE100_VGEN1VOL, 800000, 50000),
+	PFUZE100_VGEN_REG(vgen2, PFUZE100_VGEN2VOL, 800000, 50000),
+	PFUZE100_VGEN_REG(vgen3, PFUZE100_VGEN3VOL, 1800000, 100000),
+	PFUZE100_VGEN_REG(vgen4, PFUZE100_VGEN4VOL, 1800000, 100000),
+	PFUZE100_VGEN_REG(vgen5, PFUZE100_VGEN5VOL, 1800000, 100000),
+	PFUZE100_VGEN_REG(vgen6, PFUZE100_VGEN6VOL, 1800000, 100000),
 };
 
 /* PFUZE3000 */
 static struct pfuze100_regulator_desc pfuze3000_regulators[] = {
-	PFUZE3000_SW1_REG(sw1a, PFUZE100_SW1ABVOL, 25000),
-	PFUZE3000_SW1_REG(sw1b, PFUZE100_SW1CVOL, 25000),
+	PFUZE3000_SW1_REG(sw1a, PFUZE100_SW1ABVOL, 700000, 25000),
+	PFUZE3000_SW1_REG(sw1b, PFUZE100_SW1CVOL, 700000, 25000),
 	PFUZE100_SWB_REG(sw2, PFUZE100_SW2VOL, 0x7, 50000, pfuze3000_sw2lo, true),
-	PFUZE3000_SW3_REG(sw3, PFUZE100_SW3AVOL, 50000),
+	PFUZE3000_SW3_REG(sw3, PFUZE100_SW3AVOL, 900000, 50000),
 	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst, false),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze3000_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
-	PFUZE100_VGEN_REG(vldo1, PFUZE100_VGEN1VOL, 100000),
-	PFUZE100_VGEN_REG(vldo2, PFUZE100_VGEN2VOL, 50000),
-	PFUZE3000_VCC_REG(vccsd, PFUZE100_VGEN3VOL, 150000),
-	PFUZE3000_VCC_REG(v33, PFUZE100_VGEN4VOL, 150000),
-	PFUZE100_VGEN_REG(vldo3, PFUZE100_VGEN5VOL, 100000),
-	PFUZE100_VGEN_REG(vldo4, PFUZE100_VGEN6VOL, 100000),
+	PFUZE100_VGEN_REG(vldo1, PFUZE100_VGEN1VOL, 1800000, 100000),
+	PFUZE100_VGEN_REG(vldo2, PFUZE100_VGEN2VOL, 800000, 50000),
+	PFUZE3000_VCC_REG(vccsd, PFUZE100_VGEN3VOL, 2850000, 150000),
+	PFUZE3000_VCC_REG(v33, PFUZE100_VGEN4VOL, 2850000, 150000),
+	PFUZE100_VGEN_REG(vldo3, PFUZE100_VGEN5VOL, 1800000, 100000),
+	PFUZE100_VGEN_REG(vldo4, PFUZE100_VGEN6VOL, 1800000, 100000),
 };
 
 #define MODE(_id, _val, _name) { \
@@ -483,15 +491,15 @@ static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 			val &= desc->vsel_mask;
 			*uV = desc->volt_table[val];
 		} else {
-			if (uc_pdata->min_uV < 0) {
-				debug("Need to provide min_uV in dts.\n");
+			if (uc_pdata->min_uV < desc->min_uV) {
+				debug("min_uV in dts can not be below regulator min_uV.\n");
 				return -EINVAL;
 			}
 			val = pmic_reg_read(dev->parent, desc->vsel_reg);
 			if (val < 0)
 				return val;
 			val &= desc->vsel_mask;
-			*uV = uc_pdata->min_uV + (int)val * desc->uV_step;
+			*uV = desc->min_uV + (int)val * desc->uV_step;
 		}
 
 		return 0;
@@ -513,13 +521,13 @@ static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 		return pmic_clrsetbits(dev->parent, desc->vsel_reg,
 				       desc->vsel_mask, i);
 	} else {
-		if (uc_pdata->min_uV < 0) {
-			debug("Need to provide min_uV in dts.\n");
+		if (uc_pdata->min_uV < desc->min_uV) {
+			debug("min_uV in dts can not be below regulator min_uV.\n");
 			return -EINVAL;
 		}
 		return pmic_clrsetbits(dev->parent, desc->vsel_reg,
 				       desc->vsel_mask,
-				       (*uV - uc_pdata->min_uV) / desc->uV_step);
+				       (*uV - desc->min_uV) / desc->uV_step);
 	}
 
 	return 0;
-- 
2.51.0

