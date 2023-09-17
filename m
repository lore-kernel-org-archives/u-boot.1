Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF222CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD168692F;
	Sun, 17 Sep 2023 16:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mkKD9JTJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Fy0SRnK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2860C8684C; Sun, 17 Sep 2023 16:09:17 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48BC786611
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVCv1g1Vz9sTW
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSKC1V4yzFtGLu9lb6T7kqkB9BrbYAOpEy63PVMXOSU=;
 b=mkKD9JTJS7Lf47i/XzA4ZXkKsBGlYDpQfOkn12BZNh7xAibnh1Pf39b4RD6btYXbk6MA9V
 VNout8BMmgbeJyr1y4BW1zpYGbxMhYo3ipCCZ4jzlEZHTsioScomlhUbzpB8+SDvs0RvMT
 OLqYZyeQxQXLBtqUm5dNacFT3ksScdHM6OccEKq57VqWaQsU26T8AdzHl1KKfvrGMViAQ0
 5gxx5WMx81n6FkdMVsHNV9Cat4XEL82JSzL+bkKjG7hqRG3ZI87uM1tTTLh3VtrpngQ/wr
 hcDXrYzjd33nnAQx/fRLm7k41YrBdlHMoQNKt8nUyPiVsYU1xyvWPHN5OlVi8Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSKC1V4yzFtGLu9lb6T7kqkB9BrbYAOpEy63PVMXOSU=;
 b=Fy0SRnK+lGyNxhANQbJPF1Yt5yWxPC88W1iS5TGxDn7hsNYKYphHfLZoS2X1F+hJdIpdyp
 Jh3SGdA28tniXV8krbS7wfhMKzjOfmV2wx1SpjT7Uzqu9C7/2bWbxoSgVjmAiuz+kUiOzU
 s1OPOlGXyLibTa5aodkPv73X+hjlHJQqUKfuXFT58/WrMfGAjCquLBIfFF9iykLUUauyFY
 hRNJpQCPmswLqw6LgNhjArPdJeFO1wofcaRP9paIDXLKkFP4ItUKMPp/PqQdGom2fWB4Mv
 8pdozxtC7vTdB9bN6Yn5HW0vmrs51nhq/t5fhmR5vuS/1Kl26CuAgxaC168zCw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 12/18] pinctrl: renesas: Synchronize R8A77970 V3M PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:43 +0200
Message-Id: <20230917140849.379711-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 535eeeb83cc64fc0eb9
X-MBO-RS-META: jxgwgmmumt7jneroqw4ewmbnxptwwdwg
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

Synchronize R-Car R8A77970 V3M PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a77970.c | 40 +++++++++++++++++---------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77970.c b/drivers/pinctrl/renesas/pfc-r8a77970.c
index 04f03452336..1cc6fa4f3fc 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77970.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77970.c
@@ -21,10 +21,10 @@
 #include "sh_pfc.h"
 
 #define CPU_ALL_GP(fn, sfx)						\
-	PORT_GP_CFG_22(0, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
+	PORT_GP_CFG_22(0, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PORT_GP_CFG_28(1, fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
-	PORT_GP_CFG_17(2, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
-	PORT_GP_CFG_17(3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
+	PORT_GP_CFG_17(2, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
+	PORT_GP_CFG_17(3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PORT_GP_CFG_6(4,  fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PORT_GP_CFG_15(5, fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN)
 
@@ -36,7 +36,8 @@
 	PIN_NOGP_CFG(TCK, "TCK", fn, SH_PFC_PIN_CFG_PULL_UP),		\
 	PIN_NOGP_CFG(TDI, "TDI", fn, SH_PFC_PIN_CFG_PULL_UP),		\
 	PIN_NOGP_CFG(TMS, "TMS", fn, SH_PFC_PIN_CFG_PULL_UP),		\
-	PIN_NOGP_CFG(TRST_N, "TRST#", fn, SH_PFC_PIN_CFG_PULL_UP)
+	PIN_NOGP_CFG(TRST_N, "TRST#", fn, SH_PFC_PIN_CFG_PULL_UP),	\
+	PIN_NOGP_CFG(VDDQ_AVB0, "VDDQ_AVB0", fn, SH_PFC_PIN_CFG_IO_VOLTAGE_25_33)
 
 /*
  * F_() : just information
@@ -172,7 +173,7 @@
 #define IP0_31_28	FM(DU_DG3)			FM(MSIOF3_SS2)		F_(0, 0)	FM(A7)		FM(PWMFSW0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1_3_0		FM(DU_DG4)			F_(0, 0)		F_(0, 0)	FM(A8)		FM(FSO_CFE_0_N_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1_7_4		FM(DU_DG5)			F_(0, 0)		F_(0, 0)	FM(A9)		FM(FSO_CFE_1_N_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1_11_8	FM(DU_DG6)			F_(0, 0)		F_(0, 0)	FM(A10)		FM(FSO_TOE_N_A) 	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1_11_8	FM(DU_DG6)			F_(0, 0)		F_(0, 0)	FM(A10)		FM(FSO_TOE_N_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1_15_12	FM(DU_DG7)			F_(0, 0)		F_(0, 0)	FM(A11)		FM(IRQ1)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1_19_16	FM(DU_DB2)			F_(0, 0)		F_(0, 0)	FM(A12)		FM(IRQ2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1_23_20	FM(DU_DB3)			F_(0, 0)		F_(0, 0)	FM(A13)		FM(FXR_CLKOUT1)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -2344,7 +2345,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_1
 		MOD_SEL0_0 ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 enum ioctrl_regs {
@@ -2359,26 +2360,37 @@ static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL1] = { 0xe6060384 },
 	[POCCTRL2] = { 0xe6060388 },
 	[TDSELCTRL] = { 0xe60603c0, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int r8a77970_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
 {
 	int bit = pin & 0x1f;
 
-	*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
-	if (pin >= RCAR_GP_PIN(0, 0) && pin <= RCAR_GP_PIN(0, 21))
+	switch (pin) {
+	case RCAR_GP_PIN(0, 0) ... RCAR_GP_PIN(0, 21):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
 		return bit;
-	if (pin >= RCAR_GP_PIN(2, 0) && pin <= RCAR_GP_PIN(2, 9))
+
+	case RCAR_GP_PIN(2, 0) ... RCAR_GP_PIN(2, 9):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
 		return bit + 22;
 
-	*pocctrl = pinmux_ioctrl_regs[POCCTRL1].reg;
-	if (pin >= RCAR_GP_PIN(2, 10) && pin <= RCAR_GP_PIN(2, 16))
+	case RCAR_GP_PIN(2, 10) ... RCAR_GP_PIN(2, 16):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL1].reg;
 		return bit - 10;
-	if (pin >= RCAR_GP_PIN(3, 0) && pin <= RCAR_GP_PIN(3, 16))
+
+	case RCAR_GP_PIN(3, 0) ... RCAR_GP_PIN(3, 16):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL1].reg;
 		return bit + 7;
 
-	return -EINVAL;
+	case PIN_VDDQ_AVB0:
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL2].reg;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
 }
 
 static const struct pinmux_bias_reg pinmux_bias_regs[] = {
-- 
2.40.1

