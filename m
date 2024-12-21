Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE48CE7718D
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761C1805F4;
	Sat, 21 Dec 2024 22:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Pr0upt+H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e2gnCxiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6CC48062B; Sat, 21 Dec 2024 22:35:19 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778DC80516
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YFyHn1VnCz9sbh;
 Sat, 21 Dec 2024 22:35:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfyQ2C7oa5VXFUqz02VsZdLBTBLGfL7NX6l4bRhNHI4=;
 b=Pr0upt+Hyv1xsnMzQ2VjCTBRaTpG14dnk+wfbqrZZa0QY0o1u/aIoD9KhKUHzysz1Xwo4i
 SDM2WnxI9m3XyjJdAtQLgx9fDi8gBPFK/MZ6g6/dkqRu7ROG9po92WcHL4EikZIiY2EVcu
 XugLncd3rA6cAnot6XgZAb3kePd2LD+f6/W9EjjoOPqujRNG/V4oRWOT9q77uusX/035/o
 Zp2+5MqF9O0vBssbY5IHuWBCFTvgg2CCyfY9H7LyGV5pRsYJM+FJCPkS+IQyHR1ALEGX23
 ZR4JfqPNh4hQnfh1GmlUqy3WvsgNRBdZmIcY8z9eaR3qTlS/VzCovBQd25B80w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfyQ2C7oa5VXFUqz02VsZdLBTBLGfL7NX6l4bRhNHI4=;
 b=e2gnCxivbqPy3awzJI3bvCySogWaDU1w9RhMJeiPhg1EALAzcfppod0uIpFuftF2cIacM9
 UoLKxZbCs6MT+nipCyA8W5KgO9bdx56yQcXCY+wnYwjAmih/6bDEqGcONEbM0Vao6eodKA
 ExTv7JDZEnupgQHzsbB8vz/xGBELLjYupWWdtXg4iYRjWfn2aZK7p01Kh4cm8FRm9b/eNC
 1WFl+r9a6zKgCF5Hf0vhq1AA7F9DlbE7Md1qZ/eI4wDpgRMwRUdZRYdeGwVI8vMHd4zE7f
 SKp4dbGPrWWNCFGCcbu4AOrdh3vhQ6boAzrnDL/yQ5TzsR/Uehp1W/aY+MtEcA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/16] pinctrl: renesas: Minimize R8A77960 M3-W and R8A77961
 M3-W+ PFC tables
Date: Sat, 21 Dec 2024 22:34:06 +0100
Message-ID: <20241221213443.115024-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e7696b3174bd9b79ddf
X-MBO-RS-META: edqcq1i7zb7hpwmg1g9qxkea5f393opt
X-Rspamd-Queue-Id: 4YFyHn1VnCz9sbh
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
- CAN/CANFD
- DU
- INTC-EX
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
 drivers/pinctrl/renesas/pfc-r8a7796.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7796.c b/drivers/pinctrl/renesas/pfc-r8a7796.c
index a289397fb8f..7bc9fb709ea 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7796.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7796.c
@@ -1568,6 +1568,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_NOGP_ALL(),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - AUDIO CLOCK ------------------------------------------------------------ */
 static const unsigned int audio_clk_a_a_pins[] = {
 	/* CLK A */
@@ -1689,6 +1690,7 @@ static const unsigned int audio_clkout3_b_pins[] = {
 static const unsigned int audio_clkout3_b_mux[] = {
 	AUDIO_CLKOUT3_B_MARK,
 };
+#endif
 
 /* - EtherAVB --------------------------------------------------------------- */
 static const unsigned int avb_link_pins[] = {
@@ -1776,6 +1778,7 @@ static const unsigned int avb_avtp_capture_b_mux[] = {
 	AVB_AVTP_CAPTURE_B_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CAN ------------------------------------------------------------------ */
 static const unsigned int can0_data_a_pins[] = {
 	/* TX, RX */
@@ -1830,6 +1833,7 @@ static const unsigned int canfd1_data_pins[] = {
 static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK,         CANFD1_RX_MARK,
 };
+#endif
 
 #if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
 /* - DRIF0 --------------------------------------------------------------- */
@@ -2048,6 +2052,7 @@ static const unsigned int drif3_data1_b_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77960 || CONFIG_PINCTRL_PFC_R8A77961 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -2128,6 +2133,7 @@ static const unsigned int du_disp_pins[] = {
 static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
+#endif
 
 /* - HSCIF0 ----------------------------------------------------------------- */
 static const unsigned int hscif0_data_pins[] = {
@@ -2415,6 +2421,7 @@ static const unsigned int i2c6_c_mux[] = {
 	SDA6_C_MARK, SCL6_C_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_pins[] = {
 	/* IRQ0 */
@@ -2458,6 +2465,7 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
+#endif
 
 #if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
 /* - MLB+ ------------------------------------------------------------------- */
@@ -2469,6 +2477,7 @@ static const unsigned int mlb_3pin_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77960 || CONFIG_PINCTRL_PFC_R8A77961 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -3266,6 +3275,7 @@ static const unsigned int pwm6_b_pins[] = {
 static const unsigned int pwm6_b_mux[] = {
 	PWM6_B_MARK,
 };
+#endif
 
 /* - QSPI0 ------------------------------------------------------------------ */
 static const unsigned int qspi0_ctrl_pins[] = {
@@ -3679,6 +3689,7 @@ static const unsigned int sdhi3_ds_mux[] = {
 	SD3_DS_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SSI -------------------------------------------------------------------- */
 static const unsigned int ssi0_data_pins[] = {
 	/* SDATA */
@@ -3855,6 +3866,7 @@ static const unsigned int ssi9_ctrl_b_pins[] = {
 static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
+#endif
 
 /* - TMU -------------------------------------------------------------------- */
 static const unsigned int tmu_tclk1_a_pins[] = {
@@ -3942,6 +3954,7 @@ static const unsigned int usb30_mux[] = {
 	USB30_PWEN_MARK, USB30_OVC_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN4 ------------------------------------------------------------------- */
 static const unsigned int vin4_data18_a_pins[] = {
 	RCAR_GP_PIN(0, 10), RCAR_GP_PIN(0, 11),
@@ -4121,6 +4134,7 @@ static const unsigned int vin5_clk_mux[] = {
 	/* CLK */
 	VI5_CLK_MARK,
 };
+#endif
 
 static const struct {
 	struct sh_pfc_pin_group common[324];
@@ -4129,6 +4143,7 @@ static const struct {
 #endif
 } pinmux_groups = {
 	.common = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(audio_clk_a_a),
 		SH_PFC_PIN_GROUP(audio_clk_a_b),
 		SH_PFC_PIN_GROUP(audio_clk_a_c),
@@ -4146,6 +4161,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(audio_clkout2_b),
 		SH_PFC_PIN_GROUP(audio_clkout3_a),
 		SH_PFC_PIN_GROUP(audio_clkout3_b),
+#endif
 		SH_PFC_PIN_GROUP(avb_link),
 		SH_PFC_PIN_GROUP(avb_magic),
 		SH_PFC_PIN_GROUP(avb_phy_int),
@@ -4157,6 +4173,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(avb_avtp_capture_a),
 		SH_PFC_PIN_GROUP(avb_avtp_match_b),
 		SH_PFC_PIN_GROUP(avb_avtp_capture_b),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(can0_data_a),
 		SH_PFC_PIN_GROUP(can0_data_b),
 		SH_PFC_PIN_GROUP(can1_data),
@@ -4172,6 +4189,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(du_oddf),
 		SH_PFC_PIN_GROUP(du_cde),
 		SH_PFC_PIN_GROUP(du_disp),
+#endif
 		SH_PFC_PIN_GROUP(hscif0_data),
 		SH_PFC_PIN_GROUP(hscif0_clk),
 		SH_PFC_PIN_GROUP(hscif0_ctrl),
@@ -4210,6 +4228,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(i2c6_a),
 		SH_PFC_PIN_GROUP(i2c6_b),
 		SH_PFC_PIN_GROUP(i2c6_c),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(intc_ex_irq0),
 		SH_PFC_PIN_GROUP(intc_ex_irq1),
 		SH_PFC_PIN_GROUP(intc_ex_irq2),
@@ -4328,6 +4347,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(pwm5_b),
 		SH_PFC_PIN_GROUP(pwm6_a),
 		SH_PFC_PIN_GROUP(pwm6_b),
+#endif
 		SH_PFC_PIN_GROUP(qspi0_ctrl),
 		BUS_DATA_PIN_GROUP(qspi0_data, 2),
 		BUS_DATA_PIN_GROUP(qspi0_data, 4),
@@ -4389,6 +4409,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(sdhi3_cd),
 		SH_PFC_PIN_GROUP(sdhi3_wp),
 		SH_PFC_PIN_GROUP(sdhi3_ds),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(ssi0_data),
 		SH_PFC_PIN_GROUP(ssi01239_ctrl),
 		SH_PFC_PIN_GROUP(ssi1_data_a),
@@ -4414,6 +4435,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi9_data_b),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_a),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+#endif
 		SH_PFC_PIN_GROUP(tmu_tclk1_a),
 		SH_PFC_PIN_GROUP(tmu_tclk1_b),
 		SH_PFC_PIN_GROUP(tmu_tclk2_a),
@@ -4425,6 +4447,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(usb0),
 		SH_PFC_PIN_GROUP(usb1),
 		SH_PFC_PIN_GROUP(usb30),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		BUS_DATA_PIN_GROUP(vin4_data, 8, _a),
 		BUS_DATA_PIN_GROUP(vin4_data, 10, _a),
 		BUS_DATA_PIN_GROUP(vin4_data, 12, _a),
@@ -4453,6 +4476,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_field),
 		SH_PFC_PIN_GROUP(vin5_clkenb),
 		SH_PFC_PIN_GROUP(vin5_clk),
+#endif
 	},
 #if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
 	.automotive = {
@@ -4491,6 +4515,7 @@ static const struct {
 #endif /* CONFIG_PINCTRL_PFC_R8A77960 || CONFIG_PINCTRL_PFC_R8A77961 */
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const audio_clk_groups[] = {
 	"audio_clk_a_a",
 	"audio_clk_a_b",
@@ -4510,6 +4535,7 @@ static const char * const audio_clk_groups[] = {
 	"audio_clkout3_a",
 	"audio_clkout3_b",
 };
+#endif
 
 static const char * const avb_groups[] = {
 	"avb_link",
@@ -4525,6 +4551,7 @@ static const char * const avb_groups[] = {
 	"avb_avtp_capture_b",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const can0_groups[] = {
 	"can0_data_a",
 	"can0_data_b",
@@ -4546,6 +4573,7 @@ static const char * const canfd0_groups[] = {
 static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
+#endif
 
 #if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
 static const char * const drif0_groups[] = {
@@ -4591,6 +4619,7 @@ static const char * const drif3_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77960 || CONFIG_PINCTRL_PFC_R8A77961 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4601,6 +4630,7 @@ static const char * const du_groups[] = {
 	"du_cde",
 	"du_disp",
 };
+#endif
 
 static const char * const hscif0_groups[] = {
 	"hscif0_data",
@@ -4673,6 +4703,7 @@ static const char * const i2c6_groups[] = {
 	"i2c6_c",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0",
 	"intc_ex_irq1",
@@ -4681,6 +4712,7 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
+#endif
 
 #if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
 static const char * const mlb_3pin_groups[] = {
@@ -4688,6 +4720,7 @@ static const char * const mlb_3pin_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77960 || CONFIG_PINCTRL_PFC_R8A77961 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -4832,6 +4865,7 @@ static const char * const pwm6_groups[] = {
 	"pwm6_a",
 	"pwm6_b",
 };
+#endif
 
 static const char * const qspi0_groups[] = {
 	"qspi0_ctrl",
@@ -4933,6 +4967,7 @@ static const char * const sdhi3_groups[] = {
 	"sdhi3_ds",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const ssi_groups[] = {
 	"ssi0_data",
 	"ssi01239_ctrl",
@@ -4960,6 +4995,7 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl_a",
 	"ssi9_ctrl_b",
 };
+#endif
 
 static const char * const tmu_groups[] = {
 	"tmu_tclk1_a",
@@ -4987,6 +5023,7 @@ static const char * const usb30_groups[] = {
 	"usb30",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin4_groups[] = {
 	"vin4_data8_a",
 	"vin4_data10_a",
@@ -5020,6 +5057,7 @@ static const char * const vin5_groups[] = {
 	"vin5_clkenb",
 	"vin5_clk",
 };
+#endif
 
 static const struct {
 	struct sh_pfc_function common[52];
@@ -5028,14 +5066,18 @@ static const struct {
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
 		SH_PFC_FUNCTION(canfd0),
 		SH_PFC_FUNCTION(canfd1),
 		SH_PFC_FUNCTION(du),
+#endif
 		SH_PFC_FUNCTION(hscif0),
 		SH_PFC_FUNCTION(hscif1),
 		SH_PFC_FUNCTION(hscif2),
@@ -5047,6 +5089,7 @@ static const struct {
 		SH_PFC_FUNCTION(i2c3),
 		SH_PFC_FUNCTION(i2c5),
 		SH_PFC_FUNCTION(i2c6),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(intc_ex),
 		SH_PFC_FUNCTION(msiof0),
 		SH_PFC_FUNCTION(msiof1),
@@ -5059,6 +5102,7 @@ static const struct {
 		SH_PFC_FUNCTION(pwm4),
 		SH_PFC_FUNCTION(pwm5),
 		SH_PFC_FUNCTION(pwm6),
+#endif
 		SH_PFC_FUNCTION(qspi0),
 		SH_PFC_FUNCTION(qspi1),
 		SH_PFC_FUNCTION(scif0),
@@ -5072,14 +5116,18 @@ static const struct {
 		SH_PFC_FUNCTION(sdhi1),
 		SH_PFC_FUNCTION(sdhi2),
 		SH_PFC_FUNCTION(sdhi3),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(ssi),
+#endif
 		SH_PFC_FUNCTION(tmu),
 		SH_PFC_FUNCTION(tpu),
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb1),
 		SH_PFC_FUNCTION(usb30),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(vin4),
 		SH_PFC_FUNCTION(vin5),
+#endif
 	},
 #if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
 	.automotive = {
-- 
2.45.2

