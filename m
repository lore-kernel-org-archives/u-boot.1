Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487FECD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A9B869C3;
	Sun, 17 Sep 2023 16:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hEivzmJp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yWR68Fa+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C94C8694A; Sun, 17 Sep 2023 16:09:18 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A9B846B8
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVCw2lZwz9sTW
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOPTOQUt0RKoyMLyUWcA3BMGVf/ZBBYBXY4VYtbKhYQ=;
 b=hEivzmJpyJsfubxtbmVJP4agt1FPyPHZJtjGl7umoYRbMYc+lAvxD+fuCAGoX+SKNVY/9N
 puOjgG8MODD7yyqF57H03BItdpy4IbPEWauEvqsjdcGMSvqJ/jn6Dz7MlkINU6c/Ktcu9a
 hHNYFII6GNgw2gZ65gTSX6TL4D35LIM6WEO13W3urtp0nNDZGVgFytKLrf6UQ+SoECqEbK
 bbKLSeWpRTnSikU1EB1vlkpvK+Tzru0+3b/5puygucNx61Qd5+hsc/eQGpnoCEDQI9oUzb
 dQ8+7vSLJmlhUbmHR1fd5VV9qX1uldvdbPSR32OoJ0+DkyQinfKGNBBAkxmdmQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOPTOQUt0RKoyMLyUWcA3BMGVf/ZBBYBXY4VYtbKhYQ=;
 b=yWR68Fa+6ZgZ0wl896DcVk+ayEW6UkXs16YpYvNqfFXhxHaaNEkJ1fthnCHbY4w9fJw2I/
 jj35Qz5QHjSf48wmejUGCwIyAeFjLSjbo9vf0smzrsDbXlae5vXDmaU3uNVhNvTi/DzJaV
 U0sBfhVM9v98g7mq2GstZxBCUzbZEwinFNF0xhs9GAktl6nub3DPiCGlFv9QxK0W0DxyQI
 OEIrZhoVUYEfiBw8pOAndRVLSbz9R4WeTY8Rl2JISTTTZAgVfFufYvlXjFmUpWJYHQiFJb
 NCKEOSfC28uiBtkvsHU9kSUxNEa+zAb0HvzegnwcXKi1fx7wl/k/dZzNahDRTA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 14/18] pinctrl: renesas: Synchronize R8A77990 E3 PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:45 +0200
Message-Id: <20230917140849.379711-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 08bdc2362d39bb9e3ac
X-MBO-RS-META: xymzmqf5c6ft3gsx96xswgsx3pmnnw8u
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

Synchronize R-Car R8A77990 E3 PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a77990.c | 41 ++++++++++++++++----------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77990.c b/drivers/pinctrl/renesas/pfc-r8a77990.c
index c6c3d0988b0..215a19ef9cd 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77990.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77990.c
@@ -26,12 +26,12 @@
 	PORT_GP_CFG_18(0, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_23(1, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_26(2, fn, sfx, CFG_FLAGS), \
-	PORT_GP_CFG_12(3, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_DRIVE_STRENGTH), \
+	PORT_GP_CFG_12(3, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_DRIVE_STRENGTH), \
 	PORT_GP_CFG_1(3, 12, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_1(3, 13, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_1(3, 14, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_1(3, 15, fn, sfx, CFG_FLAGS), \
-	PORT_GP_CFG_11(4, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_DRIVE_STRENGTH), \
+	PORT_GP_CFG_11(4, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_DRIVE_STRENGTH), \
 	PORT_GP_CFG_20(5, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_9(6, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_1(6, 9, fn, sfx, SH_PFC_PIN_CFG_PULL_UP), \
@@ -60,7 +60,8 @@
 	PIN_NOGP_CFG(TCK, "TCK", fn, SH_PFC_PIN_CFG_PULL_UP),		\
 	PIN_NOGP_CFG(TDI, "TDI", fn, SH_PFC_PIN_CFG_PULL_UP),		\
 	PIN_NOGP_CFG(TMS, "TMS", fn, SH_PFC_PIN_CFG_PULL_UP),		\
-	PIN_NOGP_CFG(TRST_N, "TRST_N", fn, SH_PFC_PIN_CFG_PULL_UP)
+	PIN_NOGP_CFG(TRST_N, "TRST_N", fn, SH_PFC_PIN_CFG_PULL_UP),	\
+	PIN_NOGP_CFG(VDDQ_AVB0, "VDDQ_AVB0", fn, SH_PFC_PIN_CFG_IO_VOLTAGE_25_33)
 
 /*
  * F_() : just information
@@ -511,7 +512,8 @@ MOD_SEL0_1_0
 	FM(AVB_TD3) \
 	FM(PRESETOUT_N) FM(FSCLKST_N) FM(TRST_N) FM(TCK) FM(TMS) FM(TDI) \
 	FM(ASEBRK) \
-	FM(MLB_REF)
+	FM(MLB_REF) \
+	FM(VDDQ_AVB0)
 
 enum {
 	PINMUX_RESERVED = 0,
@@ -5006,7 +5008,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL1_4
 		/* RESERVED 3, 2, 1, 0  */ ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 static const struct pinmux_drive_reg pinmux_drive_regs[] = {
@@ -5039,33 +5041,40 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(4,  9), 17, 2 },	/* SD3_DAT7 */
 		{ RCAR_GP_PIN(4, 10), 14, 2 },	/* SD3_DS */
 	} },
-	{ },
+	{ /* sentinel */ }
 };
 
 enum ioctrl_regs {
 	POCCTRL0,
+	POCCTRL2,
 	TDSELCTRL,
 };
 
 static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL0] = { 0xe6060380, },
+	[POCCTRL2] = { 0xe6060388, },
 	[TDSELCTRL] = { 0xe60603c0, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int r8a77990_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
 {
-	int bit = -EINVAL;
+	switch (pin) {
+	case RCAR_GP_PIN(3, 0) ... RCAR_GP_PIN(3, 11):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
+		return pin & 0x1f;
 
-	*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
+	case RCAR_GP_PIN(4, 0) ... RCAR_GP_PIN(4, 10):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
+		return (pin & 0x1f) + 19;
 
-	if (pin >= RCAR_GP_PIN(3, 0) && pin <= RCAR_GP_PIN(3, 11))
-		bit = pin & 0x1f;
+	case PIN_VDDQ_AVB0:
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL2].reg;
+		return 0;
 
-	if (pin >= RCAR_GP_PIN(4, 0) && pin <= RCAR_GP_PIN(4, 10))
-		bit = (pin & 0x1f) + 19;
-
-	return bit;
+	default:
+		return -EINVAL;
+	}
 }
 
 static const struct pinmux_bias_reg pinmux_bias_regs[] = {
@@ -5273,7 +5282,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[30] = RCAR_GP_PIN(6,  9),	/* USB30_OVC */
 		[31] = RCAR_GP_PIN(6, 17),	/* USB30_PWEN */
 	} },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static const struct sh_pfc_soc_operations r8a77990_pfc_ops = {
-- 
2.40.1

