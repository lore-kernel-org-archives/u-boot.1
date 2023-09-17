Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C93CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB2F846B8;
	Sun, 17 Sep 2023 16:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tKpzJrvk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sGM0lRqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 028E3866DC; Sun, 17 Sep 2023 16:09:19 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B5686611
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpVCx0TQFz9sQ8
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmQXd77bUorZhyaL+rWtIUy6EQzCfAg9xPYAdrPkIHs=;
 b=tKpzJrvkbEjCgExAiqcj4ncj4iTye3BZpIS2VBmdKOkDbMEZW7YmdrJLGvdobLo49EAemz
 yEqXkI5K0FynSTJDNWQ6oLcnZIHss6Yq/lpUNPYtTIFDpAp66n/ebQFojTchkB1MwLeK4Y
 0hh076GoNPg+IV/3o1oIjQiB/UOL9Z0bQzJXQ1ztWPlnna2ChWVbl8UKyUjGEB+HQTgSaB
 akvLAqafSz2VVUxjrlnY9HYrc4Fn4WnY6Q43QyGkuEcmohRvkTUDCQ/cKBFod2qMVdgGbk
 OKADHk33kvS5M7/iBqupD8r72J76LdWaK0ekrG/bHTGEgX09vSIrjHLhYsNtYA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmQXd77bUorZhyaL+rWtIUy6EQzCfAg9xPYAdrPkIHs=;
 b=sGM0lRqru993L/MaVxePfJthjWxTtUHuMNzhJ3pvxvUs1DZ8EVL6TWtKg9MW6F7ljdbw9Y
 WdBmKpTq/YILpTqHq57ZtLAxCT7utzsBoWFrU+OkcAwd35H6T1H5yl4GDn10Ov3WtRaq/A
 ATlJRdvczdqNJ6sLvw0snsvNHyKpdGY0uF5r1SUgzMcs9LO8em0yEfBz3eAt+hzAg5Z6H0
 5IJ0hbHkmmiJcrQ2CXb82WkMtvV+QB+lMpx2I0Du42u2z9uSa9taKqUPk3Dw5yD9jszqMJ
 byDZwKTS2NmnCTAdfkyLQSa+FGUp/vjUbv92JSd0h1ldIhSIdyYIYfK36Z/tFg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 15/18] pinctrl: renesas: Synchronize R8A77995 D3 PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:46 +0200
Message-Id: <20230917140849.379711-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: afa994fec2082a98fa7
X-MBO-RS-META: g7yksdr68hho41k5biqq5emu413ejkea
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

Synchronize R-Car R8A77995 D3 PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a77995.c | 46 ++++++++++++++++----------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77995.c b/drivers/pinctrl/renesas/pfc-r8a77995.c
index 06caf16c991..c0d69937ddb 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77995.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77995.c
@@ -23,7 +23,7 @@
 	PORT_GP_CFG_9(0,  fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PORT_GP_CFG_32(1, fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PORT_GP_CFG_32(2, fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
-	PORT_GP_CFG_10(3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
+	PORT_GP_CFG_10(3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PORT_GP_CFG_32(4, fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PORT_GP_CFG_21(5, fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PORT_GP_CFG_14(6, fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN)
@@ -36,7 +36,8 @@
 	PIN_NOGP_CFG(TCK, "TCK", fn, SH_PFC_PIN_CFG_PULL_UP),		\
 	PIN_NOGP_CFG(TDI, "TDI", fn, SH_PFC_PIN_CFG_PULL_UP),		\
 	PIN_NOGP_CFG(TMS, "TMS", fn, SH_PFC_PIN_CFG_PULL_UP),		\
-	PIN_NOGP_CFG(TRST_N, "TRST#", fn, SH_PFC_PIN_CFG_PULL_UP)
+	PIN_NOGP_CFG(TRST_N, "TRST#", fn, SH_PFC_PIN_CFG_PULL_UP),	\
+	PIN_NOGP_CFG(VDDQ_AVB0, "VDDQ_AVB0", fn, SH_PFC_PIN_CFG_IO_VOLTAGE_25_33)
 
 /*
  * F_() : just information
@@ -2854,19 +2855,37 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL1_26
 		/* RESERVED 25-0 */ ))
 	},
-	{ },
+	{ /* sentinel */ }
+};
+
+enum ioctrl_regs {
+	POCCTRL0,
+	POCCTRL2,
+	TDSELCTRL,
+};
+
+static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
+	[POCCTRL0] = { 0xe6060380, },
+	[POCCTRL2] = { 0xe6060388, },
+	[TDSELCTRL] = { 0xe60603c0, },
+	{ /* sentinel */ }
 };
 
+
 static int r8a77995_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
 {
-	int bit = -EINVAL;
-
-	*pocctrl = 0xe6060380;
+	switch (pin) {
+	case RCAR_GP_PIN(3, 0) ... RCAR_GP_PIN(3, 9):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
+		return 29 - (pin - RCAR_GP_PIN(3, 0));
 
-	if (pin >= RCAR_GP_PIN(3, 0) && pin <= RCAR_GP_PIN(3, 9))
-		bit = 29 - (pin - RCAR_GP_PIN(3, 0));
+	case PIN_VDDQ_AVB0:
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL2].reg;
+		return 0;
 
-	return bit;
+	default:
+		return -EINVAL;
+	}
 }
 
 static const struct pinmux_bias_reg pinmux_bias_regs[] = {
@@ -3077,15 +3096,6 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 	{ /* sentinel */ }
 };
 
-enum ioctrl_regs {
-	TDSELCTRL,
-};
-
-static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
-	[TDSELCTRL] = { 0xe60603c0, },
-	{ /* sentinel */ },
-};
-
 static const struct pinmux_bias_reg *
 r8a77995_pin_to_bias_reg(const struct sh_pfc *pfc, unsigned int pin,
 			 unsigned int *puen_bit, unsigned int *pud_bit)
-- 
2.40.1

