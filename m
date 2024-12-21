Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F366E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C57A805CB;
	Sat, 21 Dec 2024 22:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lZgXqJys";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ldzu2z/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C808058A; Sat, 21 Dec 2024 22:35:14 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6731480562
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YFyHh1Rs2z9sw7;
 Sat, 21 Dec 2024 22:35:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmMRJKb8WwgXjCT5CUQwd/RciBJT+nuHZHuVw+SKVmQ=;
 b=lZgXqJyspf1ayneQmUnkVr88JGRBnRO6MhJ2k7VNipzi3ej9nQIzlVVyILMetrYFotlDaO
 7n9Xm107zgxhOjW+Mul40BkPmkbHbcjDyks5ffEnE70LRrK15Sc+9b3DEufs68uMUD/aiI
 fQFNrPP/+F9MwTubby4CjZirikqv5q+YtqqyxWBXQ14aVLcC6/abz8ja9TDPsbbVR97YRD
 dXxpfmxq/yh890bOXg4qz0AFdaRZuYV9u3vkts//M2F8UpaMZfNHkB+3coRjVXRQnkKVkD
 He19lxVOZzFcYp2CHSmu0eEeRwLJoI3pRZskrcYiRE6+ZsNeULvjazZaSje+ww==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmMRJKb8WwgXjCT5CUQwd/RciBJT+nuHZHuVw+SKVmQ=;
 b=Ldzu2z/zy8cH1jTfrMQ+Hn26XlvDVvD0Esv+ipOAsJPuy4AJO8BOSfd5XOmQQJYZ7LWJK8
 Atl56Sy7DXpq68vnzAa6Z8KiD+2E492ttxYSSHfuL9OT3SpmylZbXdXkzKz1kc77bkc2wv
 3sO0L/5LMCyGJ5PIa+Mpr2mfKwoniGpwFwu3GMS5tJ2o5aqxBS1wmj6iX2tcAjsSDMbnkH
 8iZbTfEe5gSdbNWiL1QnhGkCItqT0VCL76AmUWlleotbMxGkECrC7ccsWTp5q3cdEkKyC1
 PzaTlqgh2/+FtU3rSiygEc3kDfqMbLm+8mXhdacdrvfCk1SA1LiRfO/PaDbllg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/16] pinctrl: renesas: Minimize R8A7790 H2 PFC tables
Date: Sat, 21 Dec 2024 22:34:01 +0100
Message-ID: <20241221213443.115024-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: idk5n39rhk5tqzerg9ey8khb1ry934c3
X-MBO-RS-ID: 5005b5de14fe3804d99
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

Reduce the PFC tables by ifdeffing out pinmux settings which are
unlikely to be used by U-Boot. This helps reduce the size of the
bootloader in the 10 kiB range. This includes conditional build
of these PFC additions:

- Audio
- CAN
- DU
- INTC
- MSIOF
- PWM
- SSI
- VIN

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc-r8a7790.c | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7790.c b/drivers/pinctrl/renesas/pfc-r8a7790.c
index acd6b01f497..4d6ce06cf16 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7790.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7790.c
@@ -1745,6 +1745,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_NOGP_ALL(),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - AUDIO CLOCK ------------------------------------------------------------ */
 static const unsigned int audio_clk_a_pins[] = {
 	/* CLK A */
@@ -1795,6 +1796,8 @@ static const unsigned int audio_clkout_d_pins[] = {
 static const unsigned int audio_clkout_d_mux[] = {
 	AUDIO_CLKOUT_D_MARK,
 };
+#endif
+
 /* - AVB -------------------------------------------------------------------- */
 static const unsigned int avb_link_pins[] = {
 	RCAR_GP_PIN(3, 11),
@@ -1870,6 +1873,8 @@ static const unsigned int avb_gmii_mux[] = {
 	AVB_TX_EN_MARK, AVB_TX_ER_MARK, AVB_TX_CLK_MARK,
 	AVB_COL_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CAN0 ----------------------------------------------------------------- */
 static const unsigned int can0_data_pins[] = {
 	/* CAN0 RX */
@@ -2048,6 +2053,8 @@ static const unsigned int du2_clk_in_pins[] = {
 static const unsigned int du2_clk_in_mux[] = {
 	DU_DOTCLKIN2_MARK,
 };
+#endif
+
 /* - ETH -------------------------------------------------------------------- */
 static const unsigned int eth_link_pins[] = {
 	/* LINK */
@@ -2363,6 +2370,8 @@ static const unsigned int iic3_pins[] = {
 static const unsigned int iic3_mux[] = {
 	IIC3_SCL_MARK, IIC3_SDA_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC ------------------------------------------------------------------- */
 static const unsigned int intc_irq0_pins[] = {
 	/* IRQ */
@@ -2392,6 +2401,7 @@ static const unsigned int intc_irq3_pins[] = {
 static const unsigned int intc_irq3_mux[] = {
 	IRQ3_MARK,
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A7790
 /* - MLB+ ------------------------------------------------------------------- */
@@ -2441,6 +2451,8 @@ static const unsigned int mmc1_ctrl_pins[] = {
 static const unsigned int mmc1_ctrl_mux[] = {
 	MMC1_CLK_MARK, MMC1_CMD_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -2769,6 +2781,8 @@ static const unsigned int pwm6_pins[] = {
 static const unsigned int pwm6_mux[] = {
 	PWM6_MARK,
 };
+#endif
+
 /* - QSPI ------------------------------------------------------------------- */
 static const unsigned int qspi_ctrl_pins[] = {
 	/* SPCLK, SSL */
@@ -3394,6 +3408,8 @@ static const unsigned int sdhi3_wp_pins[] = {
 static const unsigned int sdhi3_wp_mux[] = {
 	SD3_WP_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SSI -------------------------------------------------------------------- */
 static const unsigned int ssi0_data_pins[] = {
 	/* SDATA0 */
@@ -3577,6 +3593,8 @@ static const unsigned int ssi9_ctrl_pins[] = {
 static const unsigned int ssi9_ctrl_mux[] = {
 	SSI_SCK9_MARK, SSI_WS9_MARK,
 };
+#endif
+
 /* - TPU0 ------------------------------------------------------------------- */
 static const unsigned int tpu0_to0_pins[] = {
 	/* TO */
@@ -3630,6 +3648,8 @@ static const unsigned int usb2_pins[] = {
 static const unsigned int usb2_mux[] = {
 	USB2_PWEN_MARK, USB2_OVC_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN0 ------------------------------------------------------------------- */
 static const unsigned int vin0_data_pins[] = {
 	/* B */
@@ -4024,6 +4044,7 @@ static const unsigned int vin3_clk_pins[] = {
 static const unsigned int vin3_clk_mux[] = {
 	VI3_CLK_MARK,
 };
+#endif
 
 static const struct {
 	struct sh_pfc_pin_group common[311];
@@ -4032,6 +4053,7 @@ static const struct {
 #endif
 } pinmux_groups = {
 	.common = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(audio_clk_a),
 		SH_PFC_PIN_GROUP(audio_clk_b),
 		SH_PFC_PIN_GROUP(audio_clk_c),
@@ -4039,12 +4061,14 @@ static const struct {
 		SH_PFC_PIN_GROUP(audio_clkout_b),
 		SH_PFC_PIN_GROUP(audio_clkout_c),
 		SH_PFC_PIN_GROUP(audio_clkout_d),
+#endif
 		SH_PFC_PIN_GROUP(avb_link),
 		SH_PFC_PIN_GROUP(avb_magic),
 		SH_PFC_PIN_GROUP(avb_phy_int),
 		SH_PFC_PIN_GROUP(avb_mdio),
 		SH_PFC_PIN_GROUP(avb_mii),
 		SH_PFC_PIN_GROUP(avb_gmii),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(can0_data),
 		SH_PFC_PIN_GROUP(can0_data_b),
 		SH_PFC_PIN_GROUP(can0_data_c),
@@ -4063,6 +4087,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(du0_clk_in),
 		SH_PFC_PIN_GROUP(du1_clk_in),
 		SH_PFC_PIN_GROUP(du2_clk_in),
+#endif
 		SH_PFC_PIN_GROUP(eth_link),
 		SH_PFC_PIN_GROUP(eth_magic),
 		SH_PFC_PIN_GROUP(eth_mdio),
@@ -4106,10 +4131,12 @@ static const struct {
 		SH_PFC_PIN_GROUP(iic2_d),
 		SH_PFC_PIN_GROUP(iic2_e),
 		SH_PFC_PIN_GROUP(iic3),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(intc_irq0),
 		SH_PFC_PIN_GROUP(intc_irq1),
 		SH_PFC_PIN_GROUP(intc_irq2),
 		SH_PFC_PIN_GROUP(intc_irq3),
+#endif
 		BUS_DATA_PIN_GROUP(mmc0_data, 1),
 		BUS_DATA_PIN_GROUP(mmc0_data, 4),
 		BUS_DATA_PIN_GROUP(mmc0_data, 8),
@@ -4118,6 +4145,7 @@ static const struct {
 		BUS_DATA_PIN_GROUP(mmc1_data, 4),
 		BUS_DATA_PIN_GROUP(mmc1_data, 8),
 		SH_PFC_PIN_GROUP(mmc1_ctrl),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(msiof0_clk),
 		SH_PFC_PIN_GROUP(msiof0_sync),
 		SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -4165,6 +4193,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(pwm4),
 		SH_PFC_PIN_GROUP(pwm5),
 		SH_PFC_PIN_GROUP(pwm6),
+#endif
 		SH_PFC_PIN_GROUP(qspi_ctrl),
 		BUS_DATA_PIN_GROUP(qspi_data, 2),
 		BUS_DATA_PIN_GROUP(qspi_data, 4),
@@ -4257,6 +4286,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(sdhi3_ctrl),
 		SH_PFC_PIN_GROUP(sdhi3_cd),
 		SH_PFC_PIN_GROUP(sdhi3_wp),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(ssi0_data),
 		SH_PFC_PIN_GROUP(ssi0129_ctrl),
 		SH_PFC_PIN_GROUP(ssi1_data),
@@ -4283,6 +4313,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi8_c_data),
 		SH_PFC_PIN_GROUP(ssi9_data),
 		SH_PFC_PIN_GROUP(ssi9_ctrl),
+#endif
 		SH_PFC_PIN_GROUP(tpu0_to0),
 		SH_PFC_PIN_GROUP(tpu0_to1),
 		SH_PFC_PIN_GROUP(tpu0_to2),
@@ -4292,6 +4323,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(usb1),
 		SH_PFC_PIN_GROUP_SUBSET(usb1_pwen, usb1, 0, 1),
 		SH_PFC_PIN_GROUP(usb2),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		BUS_DATA_PIN_GROUP(vin0_data, 24),
 		BUS_DATA_PIN_GROUP(vin0_data, 20),
 		SH_PFC_PIN_GROUP(vin0_data18),
@@ -4343,6 +4375,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin3_field),
 		SH_PFC_PIN_GROUP(vin3_clkenb),
 		SH_PFC_PIN_GROUP(vin3_clk),
+#endif
 	},
 #ifdef CONFIG_PINCTRL_PFC_R8A7790
 	.automotive = {
@@ -4351,6 +4384,7 @@ static const struct {
 #endif /* CONFIG_PINCTRL_PFC_R8A7790 */
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const audio_clk_groups[] = {
 	"audio_clk_a",
 	"audio_clk_b",
@@ -4360,6 +4394,7 @@ static const char * const audio_clk_groups[] = {
 	"audio_clkout_c",
 	"audio_clkout_d",
 };
+#endif
 
 static const char * const avb_groups[] = {
 	"avb_link",
@@ -4370,6 +4405,7 @@ static const char * const avb_groups[] = {
 	"avb_gmii",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const can0_groups[] = {
 	"can0_data",
 	"can0_data_b",
@@ -4408,6 +4444,7 @@ static const char * const du1_groups[] = {
 static const char * const du2_groups[] = {
 	"du2_clk_in",
 };
+#endif
 
 static const char * const eth_groups[] = {
 	"eth_link",
@@ -4485,12 +4522,14 @@ static const char * const iic3_groups[] = {
 	"iic3",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_groups[] = {
 	"intc_irq0",
 	"intc_irq1",
 	"intc_irq2",
 	"intc_irq3",
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A7790
 static const char * const mlb_groups[] = {
@@ -4512,6 +4551,7 @@ static const char * const mmc1_groups[] = {
 	"mmc1_ctrl",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -4591,6 +4631,7 @@ static const char * const pwm5_groups[] = {
 static const char * const pwm6_groups[] = {
 	"pwm6",
 };
+#endif
 
 static const char * const qspi_groups[] = {
 	"qspi_ctrl",
@@ -4729,6 +4770,7 @@ static const char * const sdhi3_groups[] = {
 	"sdhi3_wp",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const ssi_groups[] = {
 	"ssi0_data",
 	"ssi0129_ctrl",
@@ -4757,6 +4799,7 @@ static const char * const ssi_groups[] = {
 	"ssi9_data",
 	"ssi9_ctrl",
 };
+#endif
 
 static const char * const tpu0_groups[] = {
 	"tpu0_to0",
@@ -4779,6 +4822,7 @@ static const char * const usb2_groups[] = {
 	"usb2",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin0_groups[] = {
 	"vin0_data24",
 	"vin0_data20",
@@ -4841,6 +4885,7 @@ static const char * const vin3_groups[] = {
 	"vin3_clkenb",
 	"vin3_clk",
 };
+#endif
 
 static const struct {
 	struct sh_pfc_function common[58];
@@ -4849,8 +4894,11 @@ static const struct {
 #endif
 } pinmux_functions = {
 	.common = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(audio_clk),
+#endif
 		SH_PFC_FUNCTION(avb),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(can0),
 		SH_PFC_FUNCTION(can1),
 		SH_PFC_FUNCTION(can_clk),
@@ -4858,6 +4906,7 @@ static const struct {
 		SH_PFC_FUNCTION(du0),
 		SH_PFC_FUNCTION(du1),
 		SH_PFC_FUNCTION(du2),
+#endif
 		SH_PFC_FUNCTION(eth),
 		SH_PFC_FUNCTION(hscif0),
 		SH_PFC_FUNCTION(hscif1),
@@ -4869,9 +4918,12 @@ static const struct {
 		SH_PFC_FUNCTION(iic1),
 		SH_PFC_FUNCTION(iic2),
 		SH_PFC_FUNCTION(iic3),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(intc),
+#endif
 		SH_PFC_FUNCTION(mmc0),
 		SH_PFC_FUNCTION(mmc1),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(msiof0),
 		SH_PFC_FUNCTION(msiof1),
 		SH_PFC_FUNCTION(msiof2),
@@ -4883,6 +4935,7 @@ static const struct {
 		SH_PFC_FUNCTION(pwm4),
 		SH_PFC_FUNCTION(pwm5),
 		SH_PFC_FUNCTION(pwm6),
+#endif
 		SH_PFC_FUNCTION(qspi),
 		SH_PFC_FUNCTION(scif0),
 		SH_PFC_FUNCTION(scif1),
@@ -4898,15 +4951,19 @@ static const struct {
 		SH_PFC_FUNCTION(sdhi1),
 		SH_PFC_FUNCTION(sdhi2),
 		SH_PFC_FUNCTION(sdhi3),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(ssi),
+#endif
 		SH_PFC_FUNCTION(tpu0),
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb1),
 		SH_PFC_FUNCTION(usb2),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(vin0),
 		SH_PFC_FUNCTION(vin1),
 		SH_PFC_FUNCTION(vin2),
 		SH_PFC_FUNCTION(vin3),
+#endif
 	},
 #ifdef CONFIG_PINCTRL_PFC_R8A7790
 	.automotive = {
-- 
2.45.2

