Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60298CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B5D8699B;
	Sun, 17 Sep 2023 16:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IS9Os6uG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sMp0A7Lw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6DC8692B; Sun, 17 Sep 2023 16:09:18 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216CC8656E
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVCv6GzWz9sTW
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/DpDqw072l9W9+WBbcTs1DVYt8w/1I0ReAlwtw3ZUk=;
 b=IS9Os6uGl0wj1BsR6JC/xWeRq6ZyByIvx4ITwnQRT24RYp3tTLSo0z2YXoXXQQ1FhlzxKA
 R/fWMEwasiaIgWHF4sOPmEtGNiUZqMk2nx+y4sCdes7ebk21MjoVfNq1PFw/IU0O3xUXm1
 Fb3rw6Hl8qMU5gV6t4KqdyhAHE2ZBOmigAhOcw04dB4hesFEMhPpG4xcaRshwAuicZ6BXM
 EXyY6wE12zD9JXg7MWNIluMUjVG1fIzj8JqCIiKwz78lQzrkUA8eO6F/ZJ9hFTld76E/A2
 ZeSgoY8ihlYhGL8IBFzdAzD1D4P4SVszN5ZkoHVjoeehGyUTGZBZ5ax99yl9RA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/DpDqw072l9W9+WBbcTs1DVYt8w/1I0ReAlwtw3ZUk=;
 b=sMp0A7Lw+krlDnzdi5lkUcsL/qii4ZkdZdAfkC2WMidm6qjN8M7KSOFXLH84PNeoAxldZ/
 7iqjVO+zo4D4ErkE9EKtAaC0b1m4PyzRqx1VdmJYgINZtjKpeFztcfkbOc5+AaW5iaE8ed
 SMdHzInkgGhJdvSK5shh3GYCZt2h+ZlS03312puiNTj6FnB6ipiLPt99zYiE3VZ0GaG/Md
 k8gP0HFxIDgJz7DGMjsTrEey1SO/kraYGqiPyUBaD8gdcvImGenx0P5hTzsr09rnn2YTSr
 F5LdB4r3Ec00nFyxPLVgeBysr9i9wJtK6oxI8VsveQqPRDxtRvSX4EGceghRtA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 13/18] pinctrl: renesas: Synchronize R8A77980 V3H PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:44 +0200
Message-Id: <20230917140849.379711-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ptw53tspdrtj4sbdgpz8ita5rp4p6a6c
X-MBO-RS-ID: f08623daf3f97ad6870
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

Synchronize R-Car R8A77980 V3H PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a77980.c | 55 +++++++++++++++++---------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77980.c b/drivers/pinctrl/renesas/pfc-r8a77980.c
index 19bd46c9e48..523faa0ac8f 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77980.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77980.c
@@ -21,10 +21,10 @@
 #include "sh_pfc.h"
 
 #define CPU_ALL_GP(fn, sfx)	\
-	PORT_GP_CFG_22(0, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
+	PORT_GP_CFG_22(0, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PORT_GP_CFG_28(1, fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
-	PORT_GP_CFG_30(2, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
-	PORT_GP_CFG_17(3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP_DOWN), \
+	PORT_GP_CFG_30(2, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
+	PORT_GP_CFG_17(3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP_DOWN), \
 	PORT_GP_CFG_25(4, fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PORT_GP_CFG_15(5, fn, sfx, SH_PFC_PIN_CFG_PULL_UP_DOWN)
 
@@ -37,7 +37,9 @@
 	PIN_NOGP_CFG(EXTALR, "EXTALR", fn, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PIN_NOGP_CFG(FSCLKST, "FSCLKST", fn, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
 	PIN_NOGP_CFG(FSCLKST_N, "FSCLKST#", fn, SH_PFC_PIN_CFG_PULL_UP_DOWN),	\
-	PIN_NOGP_CFG(PRESETOUT_N, "PRESETOUT#", fn, SH_PFC_PIN_CFG_PULL_UP_DOWN)
+	PIN_NOGP_CFG(PRESETOUT_N, "PRESETOUT#", fn, SH_PFC_PIN_CFG_PULL_UP_DOWN), \
+	PIN_NOGP_CFG(VDDQ_AVB, "VDDQ_AVB", fn, SH_PFC_PIN_CFG_IO_VOLTAGE_25_33), \
+	PIN_NOGP_CFG(VDDQ_GE, "VDDQ_GE", fn, SH_PFC_PIN_CFG_IO_VOLTAGE_25_33)
 
 /*
  * F_() : just information
@@ -99,7 +101,7 @@
 #define GPSR1_0		F_(IRQ0,		IP2_27_24)
 
 /* GPSR2 */
-#define GPSR2_29	F_(FSO_TOE_N,  		IP10_19_16)
+#define GPSR2_29	F_(FSO_TOE_N,		IP10_19_16)
 #define GPSR2_28	F_(FSO_CFE_1_N,		IP10_15_12)
 #define GPSR2_27	F_(FSO_CFE_0_N,		IP10_11_8)
 #define GPSR2_26	F_(SDA3,		IP10_7_4)
@@ -264,11 +266,11 @@
 #define IP8_11_8	FM(CANFD0_RX_A)			FM(RXDA_EXTFXR)		FM(PWM1_B)		FM(DU_CDE)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP8_15_12	FM(CANFD1_TX)			FM(FXR_TXDB)		FM(PWM2_B)		FM(TCLK1_B)	FM(TX1_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP8_19_16	FM(CANFD1_RX)			FM(RXDB_EXTFXR)		FM(PWM3_B)		FM(TCLK2_B)	FM(RX1_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP8_23_20	FM(CANFD_CLK_A) 		FM(CLK_EXTFXR)		FM(PWM4_B)		FM(SPEEDIN_B)	FM(SCIF_CLK_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP8_23_20	FM(CANFD_CLK_A)			FM(CLK_EXTFXR)		FM(PWM4_B)		FM(SPEEDIN_B)	FM(SCIF_CLK_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP8_27_24	FM(DIGRF_CLKIN)			FM(DIGRF_CLKEN_IN)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP8_31_28	FM(DIGRF_CLKOUT)		FM(DIGRF_CLKEN_OUT)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP9_3_0		FM(IRQ4)			F_(0, 0)		F_(0, 0)		FM(VI0_DATA12)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP9_7_4 	FM(IRQ5)			F_(0, 0)		F_(0, 0)		FM(VI0_DATA13)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP9_7_4		FM(IRQ5)			F_(0, 0)		F_(0, 0)		FM(VI0_DATA13)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP9_11_8	FM(MSIOF0_RXD)			FM(DU_DR0)		F_(0, 0)		FM(VI0_DATA14)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP9_15_12	FM(MSIOF0_TXD)			FM(DU_DR1)		F_(0, 0)		FM(VI0_DATA15)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP9_19_16	FM(MSIOF0_SCK)			FM(DU_DG0)		F_(0, 0)		FM(VI0_DATA16)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -2815,7 +2817,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_1
 		MOD_SEL0_0 ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 enum ioctrl_regs {
@@ -2832,31 +2834,46 @@ static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL2] = { 0xe6060388, },
 	[POCCTRL3] = { 0xe606038c, },
 	[TDSELCTRL] = { 0xe60603c0, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int r8a77980_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
 {
 	int bit = pin & 0x1f;
 
-	*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
-	if (pin >= RCAR_GP_PIN(0, 0) && pin <= RCAR_GP_PIN(0, 21))
+	switch (pin) {
+	case RCAR_GP_PIN(0, 0) ... RCAR_GP_PIN(0, 21):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
 		return bit;
-	else if (pin >= RCAR_GP_PIN(2, 0) && pin <= RCAR_GP_PIN(2, 9))
+
+	case RCAR_GP_PIN(2, 0) ... RCAR_GP_PIN(2, 9):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
 		return bit + 22;
 
-	*pocctrl = pinmux_ioctrl_regs[POCCTRL1].reg;
-	if (pin >= RCAR_GP_PIN(2, 10) && pin <= RCAR_GP_PIN(2, 16))
+	case RCAR_GP_PIN(2, 10) ... RCAR_GP_PIN(2, 16):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL1].reg;
 		return bit - 10;
-	if ((pin >= RCAR_GP_PIN(2, 17) && pin <= RCAR_GP_PIN(2, 24)) ||
-	    (pin >= RCAR_GP_PIN(3,  0) && pin <= RCAR_GP_PIN(3, 16)))
+
+	case RCAR_GP_PIN(2, 17) ... RCAR_GP_PIN(2, 24):
+	case RCAR_GP_PIN(3,  0) ... RCAR_GP_PIN(3, 16):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL1].reg;
 		return bit + 7;
 
-	*pocctrl = pinmux_ioctrl_regs[POCCTRL2].reg;
-	if (pin >= RCAR_GP_PIN(2, 25) && pin <= RCAR_GP_PIN(2, 29))
+	case RCAR_GP_PIN(2, 25) ... RCAR_GP_PIN(2, 29):
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL2].reg;
 		return pin - 25;
 
-	return -EINVAL;
+	case PIN_VDDQ_AVB:
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL3].reg;
+		return 0;
+
+	case PIN_VDDQ_GE:
+		*pocctrl = pinmux_ioctrl_regs[POCCTRL3].reg;
+		return 1;
+
+	default:
+		return -EINVAL;
+	}
 }
 
 static const struct pinmux_bias_reg pinmux_bias_regs[] = {
-- 
2.40.1

