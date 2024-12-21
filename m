Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637F5E7718D
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F5B805FC;
	Sat, 21 Dec 2024 22:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FjHjGV99";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f81d9FPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752FF805C8; Sat, 21 Dec 2024 22:35:16 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1886A80585
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YFyHj48rMz9sTK;
 Sat, 21 Dec 2024 22:35:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+ETs5b5S3IfTD/EWXSd3lq1vX+prGhkX8iU3ejsHe8=;
 b=FjHjGV99oEHAD0cEN8JB8FMNaFFXuSGwgoecRJkeiWKFBSNT+WMWxqG3KdbOhRWIywQaAA
 DoFiCgcZlb6bm7dmGMh/YP1gHc1uINwoxSitKJQX8/B8z1HREzKX4H1hnsBKSBngbvptwa
 XlduRc4Dbj8ta8Atbuj2nuuWiNGO5Li1hSAmYCP/LNNk9rDcdC49mSEE1p0h3Pg/GbGNJ8
 jC60OOCaJZMkBCE/6WE5XLLnRPczFCaJbqUlGpZ6lwOH4n4NpSLylsD/FUR5wLPFIJA6f8
 vJjuDTDsZLuxQd1BNrf8Pt51g4Ki3OpgvLXVqBWW8k6Q3GdwXw7KAqOHByjgUg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+ETs5b5S3IfTD/EWXSd3lq1vX+prGhkX8iU3ejsHe8=;
 b=f81d9FPtbnUdwEYyLMOr4pFrXhVrmGWYgoViYXTZaouhun4/v9noorQnj+79CC947MoQau
 cQ37Q3/hJMvnqVgexXeUIMIAezbxIjGH4SvVSm+77zIWMTADiG28W2B95gRWVNZ3eApm2h
 q0vL42r7e3X6hqLJz4XEsp425ztes0nomJ5mKpQBWKxhl0LeiusEHjjrRMeWlxxe5Pbppv
 8lNM6hWNh4OhZRRfW8oUaQdcBIn50l9EG0EVZmHC7QUyhZeiCh9jeYaAXN3E36s2TT1FE2
 yhh9nlfDI6i+wblvPmM6NdAIR93WBq4vGlB1kZpmxA0VRdC+J/eNLxFmVW/IfQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/16] pinctrl: renesas: Minimize R8A7791 M2-W and R8A7793
 M2-N PFC tables
Date: Sat, 21 Dec 2024 22:34:02 +0100
Message-ID: <20241221213443.115024-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4c9ad6a8929ff759814
X-MBO-RS-META: ma8dmkq4cp4yecwdar9kiozzxdzxmecc
X-Rspamd-Queue-Id: 4YFyHj48rMz9sTK
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
 drivers/pinctrl/renesas/pfc-r8a7791.c | 53 +++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7791.c b/drivers/pinctrl/renesas/pfc-r8a7791.c
index fa94a51e5e7..c6d761bb378 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7791.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7791.c
@@ -1802,6 +1802,7 @@ static const unsigned int adi_chsel2_b_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A7791 || CONFIG_PINCTRL_PFC_R8A7793 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - Audio Clock ------------------------------------------------------------ */
 static const unsigned int audio_clk_a_pins[] = {
 	/* CLK */
@@ -1847,6 +1848,7 @@ static const unsigned int audio_clkout_pins[] = {
 static const unsigned int audio_clkout_mux[] = {
 	AUDIO_CLKOUT_MARK,
 };
+#endif
 
 /* - AVB -------------------------------------------------------------------- */
 static const unsigned int avb_link_pins[] = {
@@ -1924,6 +1926,7 @@ static const unsigned int avb_gmii_mux[] = {
 	AVB_COL_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CAN -------------------------------------------------------------------- */
 
 static const unsigned int can0_data_pins[] = {
@@ -2160,6 +2163,8 @@ static const unsigned int du1_clk_in_c_pins[] = {
 static const unsigned int du1_clk_in_c_mux[] = {
 	DU1_DOTCLKIN_C_MARK,
 };
+#endif
+
 /* - ETH -------------------------------------------------------------------- */
 static const unsigned int eth_link_pins[] = {
 	/* LINK */
@@ -2553,6 +2558,8 @@ static const unsigned int i2c8_c_pins[] = {
 static const unsigned int i2c8_c_mux[] = {
 	IIC1_SCL_C_MARK, IIC1_SDA_C_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC ------------------------------------------------------------------- */
 static const unsigned int intc_irq0_pins[] = {
 	/* IRQ */
@@ -2582,6 +2589,7 @@ static const unsigned int intc_irq3_pins[] = {
 static const unsigned int intc_irq3_mux[] = {
 	IRQ3_MARK,
 };
+#endif
 
 #if defined(CONFIG_PINCTRL_PFC_R8A7791) || defined(CONFIG_PINCTRL_PFC_R8A7793)
 /* - MLB+ ------------------------------------------------------------------- */
@@ -2623,6 +2631,8 @@ static const unsigned int mmc_ctrl_pins[] = {
 static const unsigned int mmc_ctrl_mux[] = {
 	MMC_CLK_MARK, MMC_CMD_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -3192,6 +3202,8 @@ static const unsigned int pwm6_pins[] = {
 static const unsigned int pwm6_mux[] = {
 	PWM6_MARK,
 };
+#endif
+
 /* - QSPI ------------------------------------------------------------------- */
 static const unsigned int qspi_ctrl_pins[] = {
 	/* SPCLK, SSL */
@@ -3872,6 +3884,7 @@ static const unsigned int sdhi2_wp_mux[] = {
 	SD2_WP_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SSI -------------------------------------------------------------------- */
 static const unsigned int ssi0_data_pins[] = {
 	/* SDATA */
@@ -4124,6 +4137,7 @@ static const unsigned int ssi9_ctrl_b_pins[] = {
 static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
+#endif
 
 /* - TPU -------------------------------------------------------------------- */
 static const unsigned int tpu_to0_pins[] = {
@@ -4169,6 +4183,8 @@ static const unsigned int usb1_mux[] = {
 	USB1_PWEN_MARK,
 	USB1_OVC_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN0 ------------------------------------------------------------------- */
 static const unsigned int vin0_data_pins[] = {
 	/* B */
@@ -4424,6 +4440,7 @@ static const unsigned int vin2_clk_pins[] = {
 static const unsigned int vin2_clk_mux[] = {
 	VI2_CLK_MARK,
 };
+#endif
 
 static const struct {
 	struct sh_pfc_pin_group common[346];
@@ -4432,17 +4449,20 @@ static const struct {
 #endif
 } pinmux_groups = {
 	.common = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(audio_clk_a),
 		SH_PFC_PIN_GROUP(audio_clk_b),
 		SH_PFC_PIN_GROUP(audio_clk_b_b),
 		SH_PFC_PIN_GROUP(audio_clk_c),
 		SH_PFC_PIN_GROUP(audio_clkout),
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
@@ -4469,6 +4489,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(du1_clk_in),
 		SH_PFC_PIN_GROUP(du1_clk_in_b),
 		SH_PFC_PIN_GROUP(du1_clk_in_c),
+#endif
 		SH_PFC_PIN_GROUP(eth_link),
 		SH_PFC_PIN_GROUP(eth_magic),
 		SH_PFC_PIN_GROUP(eth_mdio),
@@ -4524,15 +4545,18 @@ static const struct {
 		SH_PFC_PIN_GROUP(i2c8),
 		SH_PFC_PIN_GROUP(i2c8_b),
 		SH_PFC_PIN_GROUP(i2c8_c),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(intc_irq0),
 		SH_PFC_PIN_GROUP(intc_irq1),
 		SH_PFC_PIN_GROUP(intc_irq2),
 		SH_PFC_PIN_GROUP(intc_irq3),
+#endif
 		BUS_DATA_PIN_GROUP(mmc_data, 1),
 		BUS_DATA_PIN_GROUP(mmc_data, 4),
 		BUS_DATA_PIN_GROUP(mmc_data, 8),
 		BUS_DATA_PIN_GROUP(mmc_data, 8, _b),
 		SH_PFC_PIN_GROUP(mmc_ctrl),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(msiof0_clk),
 		SH_PFC_PIN_GROUP(msiof0_sync),
 		SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -4614,6 +4638,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(pwm5),
 		SH_PFC_PIN_GROUP(pwm5_b),
 		SH_PFC_PIN_GROUP(pwm6),
+#endif
 		SH_PFC_PIN_GROUP(qspi_ctrl),
 		BUS_DATA_PIN_GROUP(qspi_data, 2),
 		BUS_DATA_PIN_GROUP(qspi_data, 4),
@@ -4712,6 +4737,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(sdhi2_ctrl),
 		SH_PFC_PIN_GROUP(sdhi2_cd),
 		SH_PFC_PIN_GROUP(sdhi2_wp),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(ssi0_data),
 		SH_PFC_PIN_GROUP(ssi0_data_b),
 		SH_PFC_PIN_GROUP(ssi0129_ctrl),
@@ -4740,12 +4766,14 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi9_data_b),
 		SH_PFC_PIN_GROUP(ssi9_ctrl),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+#endif
 		SH_PFC_PIN_GROUP(tpu_to0),
 		SH_PFC_PIN_GROUP(tpu_to1),
 		SH_PFC_PIN_GROUP(tpu_to2),
 		SH_PFC_PIN_GROUP(tpu_to3),
 		SH_PFC_PIN_GROUP(usb0),
 		SH_PFC_PIN_GROUP(usb1),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		BUS_DATA_PIN_GROUP(vin0_data, 24),
 		BUS_DATA_PIN_GROUP(vin0_data, 20),
 		SH_PFC_PIN_GROUP(vin0_data18),
@@ -4778,6 +4806,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin2_field),
 		SH_PFC_PIN_GROUP(vin2_clkenb),
 		SH_PFC_PIN_GROUP(vin2_clk),
+#endif
 	},
 #if defined(CONFIG_PINCTRL_PFC_R8A7791) || defined(CONFIG_PINCTRL_PFC_R8A7793)
 	.automotive = {
@@ -4807,6 +4836,7 @@ static const char * const adi_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A7791 || CONFIG_PINCTRL_PFC_R8A7793 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const audio_clk_groups[] = {
 	"audio_clk_a",
 	"audio_clk_b",
@@ -4814,6 +4844,7 @@ static const char * const audio_clk_groups[] = {
 	"audio_clk_c",
 	"audio_clkout",
 };
+#endif
 
 static const char * const avb_groups[] = {
 	"avb_link",
@@ -4824,6 +4855,7 @@ static const char * const avb_groups[] = {
 	"avb_gmii",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const can0_groups[] = {
 	"can0_data",
 	"can0_data_b",
@@ -4887,6 +4919,7 @@ static const char * const du1_groups[] = {
 	"du1_clk_in_b",
 	"du1_clk_in_c",
 };
+#endif
 
 static const char * const eth_groups[] = {
 	"eth_link",
@@ -4976,12 +5009,14 @@ static const char * const i2c8_groups[] = {
 	"i2c8_c",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_groups[] = {
 	"intc_irq0",
 	"intc_irq1",
 	"intc_irq2",
 	"intc_irq3",
 };
+#endif
 
 #if defined(CONFIG_PINCTRL_PFC_R8A7791) || defined(CONFIG_PINCTRL_PFC_R8A7793)
 static const char * const mlb_groups[] = {
@@ -4997,6 +5032,7 @@ static const char * const mmc_groups[] = {
 	"mmc_ctrl",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -5107,6 +5143,7 @@ static const char * const pwm5_groups[] = {
 static const char * const pwm6_groups[] = {
 	"pwm6",
 };
+#endif
 
 static const char * const qspi_groups[] = {
 	"qspi_ctrl",
@@ -5254,6 +5291,7 @@ static const char * const sdhi2_groups[] = {
 	"sdhi2_wp",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const ssi_groups[] = {
 	"ssi0_data",
 	"ssi0_data_b",
@@ -5284,6 +5322,7 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl",
 	"ssi9_ctrl_b",
 };
+#endif
 
 static const char * const tpu_groups[] = {
 	"tpu_to0",
@@ -5299,6 +5338,7 @@ static const char * const usb1_groups[] = {
 	"usb1",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin0_groups[] = {
 	"vin0_data24",
 	"vin0_data20",
@@ -5339,6 +5379,7 @@ static const char * const vin2_groups[] = {
 	"vin2_clkenb",
 	"vin2_clk",
 };
+#endif
 
 static const struct {
 	struct sh_pfc_function common[58];
@@ -5347,14 +5388,18 @@ static const struct {
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
 		SH_PFC_FUNCTION(du),
 		SH_PFC_FUNCTION(du0),
 		SH_PFC_FUNCTION(du1),
+#endif
 		SH_PFC_FUNCTION(eth),
 		SH_PFC_FUNCTION(hscif0),
 		SH_PFC_FUNCTION(hscif1),
@@ -5366,8 +5411,11 @@ static const struct {
 		SH_PFC_FUNCTION(i2c4),
 		SH_PFC_FUNCTION(i2c7),
 		SH_PFC_FUNCTION(i2c8),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(intc),
+#endif
 		SH_PFC_FUNCTION(mmc),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(msiof0),
 		SH_PFC_FUNCTION(msiof1),
 		SH_PFC_FUNCTION(msiof2),
@@ -5378,6 +5426,7 @@ static const struct {
 		SH_PFC_FUNCTION(pwm4),
 		SH_PFC_FUNCTION(pwm5),
 		SH_PFC_FUNCTION(pwm6),
+#endif
 		SH_PFC_FUNCTION(qspi),
 		SH_PFC_FUNCTION(scif0),
 		SH_PFC_FUNCTION(scif1),
@@ -5398,13 +5447,17 @@ static const struct {
 		SH_PFC_FUNCTION(sdhi0),
 		SH_PFC_FUNCTION(sdhi1),
 		SH_PFC_FUNCTION(sdhi2),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(ssi),
+#endif
 		SH_PFC_FUNCTION(tpu),
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb1),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(vin0),
 		SH_PFC_FUNCTION(vin1),
 		SH_PFC_FUNCTION(vin2),
+#endif
 	},
 #if defined(CONFIG_PINCTRL_PFC_R8A7791) || defined(CONFIG_PINCTRL_PFC_R8A7793)
 	.automotive = {
-- 
2.45.2

