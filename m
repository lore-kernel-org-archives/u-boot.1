Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F76E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12802805D7;
	Mon,  9 Feb 2026 19:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HayHnJ7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4427683CB5; Mon,  9 Feb 2026 19:12:04 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D8F8397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-59dd490be5fso5352979e87.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660721; x=1771265521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTA3sU76TMkCndkqRMavkbDtgcHMzJq5J1UDzWbj+FQ=;
 b=HayHnJ7LpqmwLYdX9vReSt6vwBqsq5fprW1rAEn/LDd3SqxWDeNWBbJbT0Mf6d8YEn
 QNUfBrkAmAmG4dLOkcyMfgIZyzmZy6bm2Wj0f1wnr/oCg4y+Z34xHEWBOQuXA4A9uhyM
 pSDluUCo2QKlXSu4uNmdXhJI55aF3bwIBGYcebWmfhLZtT/lxdQN5J9uMdfvZeIN4OfJ
 XyqR+7Fo2ikFNiqjo7mEZgCt0/YGRWnUW/LSYFKOz8QzDc95u83vXk5+fGOFxW4E5DN8
 dECbGW8+CljWy6yp59vipo6k4LFlqxgNAaRBVZJ0B45tqRcvjmV6BZ7ZjCj4h0kO3/7c
 +Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660721; x=1771265521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NTA3sU76TMkCndkqRMavkbDtgcHMzJq5J1UDzWbj+FQ=;
 b=tkQg+raX4rfWS7+LVdiV9lQy8iJ4w6z30y8ilmKUQ7WCv0PGTA5f0Lp+QqKDwtvEkc
 jH4arFkfOg8op0oT5mcBN27WhoxXq6MRLjtMOSuIOk9woaXtyIHvomYqZpN0H6Wp+Mzz
 Qd+jMccC/f3RquWcKxeM5Tfj6zwZxCCUPJ5NRln1AHWEX52A8VHj/fsr5sASQRcgucF/
 SsQIsXCthpBJYE/VREO4VrDhJKMS8veVW2pxkYL1H8Kk193f8os87UrQYlL1+W6TVaUt
 0VhZdm0GiqzSOP5FsxNxi1en+YBPdFpShi5gwUOlK25VnPPthQtmX4NwRFtC5hQQQ9+l
 9cXg==
X-Gm-Message-State: AOJu0Yy1tWjBa7HSwLQtfcKH2PF576hdjmpUqjVQvO94IVrm3XgcqmGm
 Z8QC2Ma/BvOBTpa1T2D4x1hF7dads8UygYupnF04bJNaw3X8Q7Z6KyR+
X-Gm-Gg: AZuq6aLk0D4jI7Fy1PMQABPM6TAWtoILJyFfk20aURklVuMiF9TdSz1BNVXnE0IlcsL
 MFw08BWIcVOBVjv+2nziexwKHK1+KiKSwydT3KDHoJUDT3daTKZNqCJ0YmRyIxpxP9HE5/i+uEm
 V78Zuc3u/j1qeOIAPlwh0Ry6TCQFwwtAOmq2Q4GoVKjKspKfgXhWaE7kBq0zjK1WTDffURj/Apz
 adHNZ60fid3UFkbFbevUNY2ZVAjjirum9iJderPEIrEP6ZrWfEQPV2sJhNo0TgqgfvUdgHG7X+9
 fiioHp6LG2GkSfZ44qKtwnfcoOmg6KFnIY4LEOf/B2v4+cbpQcwhoin/hm9nN4vo2KiFAxkwrpD
 blrDeGaybM7fOhhEovL3osPrD2IV+5fa6gDi9qGvJfryOVluxH1Zw7yvfMV2KxJMoAgVuRXjcm7
 Te
X-Received: by 2002:a05:6512:b8b:b0:59e:2242:fb9 with SMTP id
 2adb3069b0e04-59e4504ba8amr4096323e87.16.1770660720394; 
 Mon, 09 Feb 2026 10:12:00 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44e25e4bsm2792801e87.88.2026.02.09.10.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:12:00 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/5] power: regulator: cpcap: remove
 bit_offset_from_cpcap_lowest_voltage
Date: Mon,  9 Feb 2026 20:11:45 +0200
Message-ID: <20260209181149.32714-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209181149.32714-1-clamor95@gmail.com>
References: <20260209181149.32714-1-clamor95@gmail.com>
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

The bit_offset_from_cpcap_lowest_voltage value was inherited from the
downstream kernel as a quirk. With the correct voltage table, it is no
longer needed. An additional benefit is that SW1, SW2, and SW4 now share
the same voltage table.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/regulator/cpcap_regulator.c | 53 +++++++++++------------
 include/power/cpcap.h                     | 48 +++++++-------------
 2 files changed, 40 insertions(+), 61 deletions(-)

diff --git a/drivers/power/regulator/cpcap_regulator.c b/drivers/power/regulator/cpcap_regulator.c
index 04cd6651374..15426675066 100644
--- a/drivers/power/regulator/cpcap_regulator.c
+++ b/drivers/power/regulator/cpcap_regulator.c
@@ -55,7 +55,7 @@
 
 #define CPCAP_REG(_reg, _assignment_reg, _assignment_mask, _mode_mask,		\
 		  _volt_mask, _volt_shft, _mode_val, _off_mode_val, _val_tbl,	\
-		  _mode_cntr, _volt_trans_time, _turn_on_time, _bit_offset) {	\
+		  _mode_cntr, _volt_trans_time, _turn_on_time) {		\
 	.reg = CPCAP_REG_##_reg,						\
 	.assignment_reg = CPCAP_REG_##_assignment_reg,				\
 	.assignment_mask = CPCAP_BIT_##_assignment_mask,			\
@@ -69,60 +69,59 @@
 	.mode_cntr = _mode_cntr,						\
 	.volt_trans_time = _volt_trans_time,					\
 	.turn_on_time = _turn_on_time,						\
-	.bit_offset_from_cpcap_lowest_voltage = _bit_offset,			\
 }
 
 static const struct cpcap_regulator_data tegra20_regulators[CPCAP_REGULATORS_COUNT] = {
 	/* BUCK */
 	[CPCAP_SW1]      = CPCAP_REG(S1C1, ASSIGN2, SW1_SEL, 0x6f00, 0x007f,
-				     0, 0x6800, 0, sw1_val_tbl, 0, 0, 1500, 0x0c),
+				     0, 0x6800, 0, sw_val_tbl, 0, 0, 1500),
 	[CPCAP_SW2]      = CPCAP_REG(S2C1, ASSIGN2, SW2_SEL, 0x6f00, 0x007f,
-				     0, 0x4804, 0, sw2_sw4_val_tbl, 0, 0, 1500, 0x18),
+				     0, 0x4804, 0, sw_val_tbl, 0, 0, 1500),
 	[CPCAP_SW3]      = CPCAP_REG(S3C, ASSIGN2, SW3_SEL, 0x0578, 0x0003,
-				     0, 0x043c, 0, sw3_val_tbl, 0, 0, 0, 0),
+				     0, 0x043c, 0, sw3_val_tbl, 0, 0, 0),
 	[CPCAP_SW4]      = CPCAP_REG(S4C1, ASSIGN2, SW4_SEL, 0x6f00, 0x007f,
-				     0, 0x4909, 0, sw2_sw4_val_tbl, 0, 0, 1500, 0x18),
+				     0, 0x4909, 0, sw_val_tbl, 0, 0, 1500),
 	[CPCAP_SW5]      = CPCAP_REG(S5C, ASSIGN2, SW5_SEL, 0x0028, 0x0000,
-				     0, 0x0020, 0, sw5_val_tbl, 0, 0, 1500, 0),
+				     0, 0x0020, 0, sw5_val_tbl, 0, 0, 1500),
 	[CPCAP_SW6]      = CPCAP_REG(S6C, ASSIGN2, SW6_SEL, 0x0000, 0x0000,
-				     0, 0, 0, unknown_val_tbl, 0, 0, 0, 0),
+				     0, 0, 0, unknown_val_tbl, 0, 0, 0),
 	/* LDO */
 	[CPCAP_VCAM]     = CPCAP_REG(VCAMC, ASSIGN2, VCAM_SEL, 0x0087, 0x0030,
-				     4, 0x7, 0, vcam_val_tbl, 0, 420, 1000, 0),
+				     4, 0x7, 0, vcam_val_tbl, 0, 420, 1000),
 	[CPCAP_VCSI]     = CPCAP_REG(VCSIC, ASSIGN3, VCSI_SEL, 0x0047, 0x0010,
-				     4, 0x7, 0, vcsi_val_tbl, 0, 350, 1000, 0),
+				     4, 0x7, 0, vcsi_val_tbl, 0, 350, 1000),
 	[CPCAP_VDAC]     = CPCAP_REG(VDACC, ASSIGN3, VDAC_SEL, 0x0087, 0x0030,
-				     4, 0x0, 0, vdac_val_tbl, 0, 420, 1000, 0),
+				     4, 0x0, 0, vdac_val_tbl, 0, 420, 1000),
 	[CPCAP_VDIG]     = CPCAP_REG(VDIGC, ASSIGN2, VDIG_SEL, 0x0087, 0x0030,
-				     4, 0x0, 0, vdig_val_tbl, 0, 420, 1000, 0),
+				     4, 0x0, 0, vdig_val_tbl, 0, 420, 1000),
 	[CPCAP_VFUSE]    = CPCAP_REG(VFUSEC, ASSIGN3, VFUSE_SEL, 0x00a0, 0x000f,
-				     0, 0x0, 0, vfuse_val_tbl, 0, 420, 1000, 0),
+				     0, 0x0, 0, vfuse_val_tbl, 0, 420, 1000),
 	[CPCAP_VHVIO]    = CPCAP_REG(VHVIOC, ASSIGN3, VHVIO_SEL, 0x0017, 0x0000,
-				     0, 0x2, 0, vhvio_val_tbl, 0, 0, 1000, 0),
+				     0, 0x2, 0, vhvio_val_tbl, 0, 0, 1000),
 	[CPCAP_VSDIO]    = CPCAP_REG(VSDIOC, ASSIGN2, VSDIO_SEL, 0x0087, 0x0038,
-				     3, 0x2, 0, vsdio_val_tbl, 0, 420, 1000, 0),
+				     3, 0x2, 0, vsdio_val_tbl, 0, 420, 1000),
 	[CPCAP_VPLL]     = CPCAP_REG(VPLLC, ASSIGN3, VPLL_SEL, 0x0047, 0x0018,
-				     3, 0x1, 0, vpll_val_tbl, 0, 420, 100, 0),
+				     3, 0x1, 0, vpll_val_tbl, 0, 420, 100),
 	[CPCAP_VRF1]     = CPCAP_REG(VRF1C, ASSIGN3, VRF1_SEL, 0x00ac, 0x0002,
-				     1, 0x0, 0, vrf1_val_tbl, 0, 10, 1000, 0),
+				     1, 0x0, 0, vrf1_val_tbl, 0, 10, 1000),
 	[CPCAP_VRF2]     = CPCAP_REG(VRF2C, ASSIGN3, VRF2_SEL, 0x0023, 0x0008,
-				     3, 0x0, 0, vrf2_val_tbl, 0, 10, 1000, 0),
+				     3, 0x0, 0, vrf2_val_tbl, 0, 10, 1000),
 	[CPCAP_VRFREF]   = CPCAP_REG(VRFREFC, ASSIGN3, VRFREF_SEL, 0x0023, 0x0008,
-				     3, 0x0, 0, vrfref_val_tbl, 0, 420, 100, 0),
+				     3, 0x0, 0, vrfref_val_tbl, 0, 420, 100),
 	[CPCAP_VWLAN1]   = CPCAP_REG(VWLAN1C, ASSIGN3, VWLAN1_SEL, 0x0047, 0x0010,
-				     4, 0x0, 0, vwlan1_val_tbl, 0, 420, 1000, 0),
+				     4, 0x0, 0, vwlan1_val_tbl, 0, 420, 1000),
 	[CPCAP_VWLAN2]   = CPCAP_REG(VWLAN2C, ASSIGN3, VWLAN2_SEL, 0x020c, 0x00c0,
-				     6, 0xd, 0, vwlan2_val_tbl, 0, 420, 1000, 0),
+				     6, 0xd, 0, vwlan2_val_tbl, 0, 420, 1000),
 	[CPCAP_VSIM]     = CPCAP_REG(VSIMC, ASSIGN3, NONE, 0x0023, 0x0008,
-				     3, 0x0, 0, vsim_val_tbl, 0, 420, 1000, 0),
+				     3, 0x0, 0, vsim_val_tbl, 0, 420, 1000),
 	[CPCAP_VSIMCARD] = CPCAP_REG(VSIMC, ASSIGN3, NONE, 0x1e80, 0x0008,
-				     3, 0x1E00, 0, vsimcard_val_tbl, 0, 420, 1000, 0),
+				     3, 0x1E00, 0, vsimcard_val_tbl, 0, 420, 1000),
 	[CPCAP_VVIB]     = CPCAP_REG(VVIBC, ASSIGN3, VVIB_SEL, 0x0001, 0x000c,
-				     2, 0x1, 0, vvib_val_tbl, 0, 500, 500, 0),
+				     2, 0x1, 0, vvib_val_tbl, 0, 500, 500),
 	[CPCAP_VUSB]     = CPCAP_REG(VUSBC, ASSIGN3, VUSB_SEL, 0x011c, 0x0040,
-				     6, 0xc, 0, vusb_val_tbl, 0, 0, 1000, 0),
+				     6, 0xc, 0, vusb_val_tbl, 0, 0, 1000),
 	[CPCAP_VAUDIO]   = CPCAP_REG(VAUDIOC, ASSIGN4, VAUDIO_SEL, 0x0016, 0x0001,
-				     0, 0x5, 0, vaudio_val_tbl, 0, 0, 1000, 0),
+				     0, 0x5, 0, vaudio_val_tbl, 0, 0, 1000),
 };
 
 static int cpcap_regulator_get_value(struct udevice *dev)
@@ -139,7 +138,6 @@ static int cpcap_regulator_get_value(struct udevice *dev)
 		return 0;
 
 	value &= regulator->volt_mask;
-	value -= regulator->bit_offset_from_cpcap_lowest_voltage;
 
 	return regulator->val_tbl[value >> volt_shift];
 }
@@ -164,7 +162,6 @@ static int cpcap_regulator_set_value(struct udevice *dev, int uV)
 			value = regulator->val_tbl_sz;
 
 		value <<= volt_shift;
-		value += regulator->bit_offset_from_cpcap_lowest_voltage;
 	}
 
 	ret = pmic_clrsetbits(dev->parent, regulator->reg, regulator->volt_mask,
diff --git a/include/power/cpcap.h b/include/power/cpcap.h
index bb0e28cec55..b035b84840f 100644
--- a/include/power/cpcap.h
+++ b/include/power/cpcap.h
@@ -297,32 +297,21 @@ static const char * const cpcap_regulator_to_name[] = {
 };
 
 static const u32 unknown_val_tbl[] = { 0, };
-static const u32 sw1_val_tbl[] = { 750000, 762500, 775000, 787500, 800000,
-				   812500, 825000, 837500, 850000, 862500,
-				   875000, 887500, 900000, 912500, 925000,
-				   937500, 950000, 962500, 975000, 987500,
-				   1000000, 1012500, 1025000, 1037500,
-				   1050000, 1062500, 1075000, 1087500,
-				   1100000, 1112500, 1125000, 1137500,
-				   1150000, 1162500, 1175000, 1187500,
-				   1200000, 1212500, 1225000, 1237500,
-				   1250000, 1262500, 1275000, 1287500,
-				   1300000, 1312500, 1325000, 1337500,
-				   1350000, 1362500, 1375000, 1387500,
-				   1400000, 1412500, 1425000, 1437500,
-				   1450000, 1462500, 1475000 };
-static const u32 sw2_sw4_val_tbl[] = { 900000, 912500, 925000, 937500, 950000,
-				       962500, 975000, 987500, 1000000, 1012500,
-				       1025000, 1037500, 1050000, 1062500,
-				       1075000, 1087500, 1100000, 1112500,
-				       1125000, 1137500, 1150000, 1162500,
-				       1175000, 1187500, 1200000, 1212500,
-				       1225000, 1237500, 1250000, 1262500,
-				       1275000, 1287500, 1300000, 1312500,
-				       1325000, 1337500, 1350000, 1362500,
-				       1375000, 1387500, 1400000, 1412500,
-				       1425000, 1437500, 1450000, 1462500,
-				       1475000 };
+static const u32 sw_val_tbl[] =  { 600000, 612500, 625000, 637500, 650000,
+				   662500, 675000, 687500, 700000, 712500,
+				   725000, 737500, 750000, 762500, 775000,
+				   787500, 800000, 812500, 825000, 837500,
+				   850000, 862500, 875000, 887500, 900000,
+				   912500, 925000, 937500, 950000, 962500,
+				   975000, 987500, 1000000, 1012500, 1025000,
+				   1037500, 1050000, 1062500, 1075000, 1087500,
+				   1100000, 1112500, 1125000, 1137500, 1150000,
+				   1162500, 1175000, 1187500, 1200000, 1212500,
+				   1225000, 1237500, 1250000, 1262500, 1275000,
+				   1287500, 1300000, 1312500, 1325000, 1337500,
+				   1350000, 1362500, 1375000, 1387500, 1400000,
+				   1412500, 1425000, 1437500, 1450000, 1462500,
+				   1475000, };
 static const u32 sw3_val_tbl[] = { 1350000, 1800000, 1850000, 1875000 };
 static const u32 sw5_val_tbl[] = { 0, 5050000 };
 static const u32 vcam_val_tbl[] = { 2600000, 2700000, 2800000, 2900000 };
@@ -361,13 +350,6 @@ struct cpcap_regulator_data {
 	u32 mode_cntr;
 	u32 volt_trans_time; /* in micro seconds */
 	u32 turn_on_time; /* in micro seconds */
-
-	/*
-	 * Bit difference between lowest value in val_tbl and start of voltage
-	 * table setting in cpcap. Use this for switchers that have many too
-	 * many voltages to list in val_tbl.
-	 */
-	u32 bit_offset_from_cpcap_lowest_voltage;
 };
 
 #endif /* _CPCAP_H_ */
-- 
2.51.0

