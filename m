Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C32AE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A955807A7;
	Mon, 23 Dec 2024 14:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q+C3YSJi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SnpJA5EK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80AFE80790; Mon, 23 Dec 2024 14:35:40 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F3780726
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YGzYP4Fvyz9sq6;
 Mon, 23 Dec 2024 14:35:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9X/8DrZ1arZtCZy+l4EGo6gTXd+9CvzGRbt2cm6BuY=;
 b=q+C3YSJiQL5Jdyb6TUehWukN5FfxfaloMaZ2Xk6jjpyLGTknvwOMD3CaIzPxksEUMjbbmm
 sCbwaqMS2EzWjwh227e8jLdn4PuBDByASxRpXMvkPtXX5X0LazKpLajrPNNzf6/oatum+D
 6xJUYGaJAk3C9A/1moXq7baSe4Majr9EsX3xIM0sh54BgpOyjSXcIQbovTbSW7vfPL4/Wc
 r97fHlPCxoO5pWvBENjpFDOFNdp13+3izlh/73f875au3z2dFskE8QZhDM8f8FHhhZF5j1
 K2mpiPciEoUHZ/wbmOlBAUiZQC4dBaf3Fu4MvsREGAhZQDGfTQDZxBeroboebw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9X/8DrZ1arZtCZy+l4EGo6gTXd+9CvzGRbt2cm6BuY=;
 b=SnpJA5EKpkunNQV31boA1NM4HxdE5P6i+sXjdGXcdiTcY4D4UYQTqUop99jiqhVbmNIqea
 bzN04w/EZUs3gnmbQYf8tkSFRKNbESaICTY300vt+g7Nq4iWcp5T/1Gldhc2++4aZh43E+
 Ccvv9C6Xzbwk9zcUx0N2cDJvdKB+7w7PHB2vJoFYDNqEzUlZ/BzmTzP8c6UQwqaO45Dtir
 1KVYhkkm7f+P+nMVPGW9Nw7uIXWRHxzTbDXpYKydaV4RStYCTu7YQJXXUfaaKB8qA7iPOo
 VYjTPebjIklRIr22N9daN8plLjQNaqHDaz7I54aMvpvbMT++xPNlpGow72qOZg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/16] pinctrl: renesas: Minimize R8A77990 E3 PFC tables
Date: Mon, 23 Dec 2024 14:34:15 +0100
Message-ID: <20241223133459.15748-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
References: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: eb73d4ee1783f588d64
X-MBO-RS-META: fxcngxid7cean6isawxxxrbzs7jn644i
X-Rspamd-Queue-Id: 4YGzYP4Fvyz9sq6
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
- INTC/INTC-EX
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
V2: No change
---
 drivers/pinctrl/renesas/pfc-r8a77990.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77990.c b/drivers/pinctrl/renesas/pfc-r8a77990.c
index e3a9c5e053d..75b7429bc0d 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77990.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77990.c
@@ -1314,6 +1314,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_NOGP_ALL(),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - AUDIO CLOCK ------------------------------------------------------------ */
 static const unsigned int audio_clk_a_pins[] = {
 	/* CLK A */
@@ -1476,6 +1477,7 @@ static const unsigned int audio_clkout3_c_pins[] = {
 static const unsigned int audio_clkout3_c_mux[] = {
 	AUDIO_CLKOUT3_C_MARK,
 };
+#endif
 
 /* - EtherAVB --------------------------------------------------------------- */
 static const unsigned int avb_link_pins[] = {
@@ -1549,6 +1551,7 @@ static const unsigned int avb_avtp_capture_mux[] = {
 	AVB_AVTP_CAPTURE_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CAN ------------------------------------------------------------------ */
 static const unsigned int can0_data_pins[] = {
 	/* TX, RX */
@@ -1596,6 +1599,7 @@ static const unsigned int canfd1_data_pins[] = {
 static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK, CANFD1_RX_MARK,
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77990
 /* - DRIF0 --------------------------------------------------------------- */
@@ -1792,6 +1796,7 @@ static const unsigned int drif3_data1_b_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77990 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -1879,6 +1884,7 @@ static const unsigned int du_disp_pins[] = {
 static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
+#endif
 
 /* - HSCIF0 --------------------------------------------------*/
 static const unsigned int hscif0_data_a_pins[] = {
@@ -2300,6 +2306,7 @@ static const unsigned int i2c7_b_mux[] = {
 	SCL7_B_MARK, SDA7_B_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_pins[] = {
 	/* IRQ0 */
@@ -2343,6 +2350,7 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77990
 /* - MLB+ ------------------------------------------------------------------- */
@@ -2354,6 +2362,7 @@ static const unsigned int mlb_3pin_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77990 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -2823,6 +2832,7 @@ static const unsigned int pwm6_b_pins[] = {
 static const unsigned int pwm6_b_mux[] = {
 	PWM6_B_MARK,
 };
+#endif
 
 /* - QSPI0 ------------------------------------------------------------------ */
 static const unsigned int qspi0_ctrl_pins[] = {
@@ -3293,6 +3303,7 @@ static const unsigned int sdhi3_ds_mux[] = {
 	SD3_DS_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SSI -------------------------------------------------------------------- */
 static const unsigned int ssi0_data_pins[] = {
 	/* SDATA */
@@ -3482,6 +3493,7 @@ static const unsigned int ssi9_ctrl_b_pins[] = {
 static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
+#endif
 
 /* - TMU -------------------------------------------------------------------- */
 static const unsigned int tmu_tclk1_a_pins[] = {
@@ -3567,6 +3579,7 @@ static const unsigned int usb30_id_mux[] = {
 	USB3HS0_ID_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN4 ------------------------------------------------------------------- */
 static const unsigned int vin4_data18_a_pins[] = {
 	RCAR_GP_PIN(2, 8),  RCAR_GP_PIN(2, 9),
@@ -3786,6 +3799,7 @@ static const unsigned int vin5_clk_b_pins[] = {
 static const unsigned int vin5_clk_b_mux[] = {
 	VI5_CLK_B_MARK,
 };
+#endif
 
 static const struct {
 	struct sh_pfc_pin_group common[261];
@@ -3794,6 +3808,7 @@ static const struct {
 #endif
 } pinmux_groups = {
 	.common = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(audio_clk_a),
 		SH_PFC_PIN_GROUP(audio_clk_b_a),
 		SH_PFC_PIN_GROUP(audio_clk_b_b),
@@ -3812,6 +3827,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(audio_clkout3_a),
 		SH_PFC_PIN_GROUP(audio_clkout3_b),
 		SH_PFC_PIN_GROUP(audio_clkout3_c),
+#endif
 		SH_PFC_PIN_GROUP(avb_link),
 		SH_PFC_PIN_GROUP(avb_magic),
 		SH_PFC_PIN_GROUP(avb_phy_int),
@@ -3819,6 +3835,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(avb_avtp_pps),
 		SH_PFC_PIN_GROUP(avb_avtp_match),
 		SH_PFC_PIN_GROUP(avb_avtp_capture),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(can0_data),
 		SH_PFC_PIN_GROUP(can1_data),
 		SH_PFC_PIN_GROUP(can_clk),
@@ -3833,6 +3850,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(du_disp_cde),
 		SH_PFC_PIN_GROUP(du_cde),
 		SH_PFC_PIN_GROUP(du_disp),
+#endif
 		SH_PFC_PIN_GROUP(hscif0_data_a),
 		SH_PFC_PIN_GROUP(hscif0_clk_a),
 		SH_PFC_PIN_GROUP(hscif0_ctrl_a),
@@ -3879,6 +3897,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(i2c6_b),
 		SH_PFC_PIN_GROUP(i2c7_a),
 		SH_PFC_PIN_GROUP(i2c7_b),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(intc_ex_irq0),
 		SH_PFC_PIN_GROUP(intc_ex_irq1),
 		SH_PFC_PIN_GROUP(intc_ex_irq2),
@@ -3936,6 +3955,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(pwm5_b),
 		SH_PFC_PIN_GROUP(pwm6_a),
 		SH_PFC_PIN_GROUP(pwm6_b),
+#endif
 		SH_PFC_PIN_GROUP(qspi0_ctrl),
 		SH_PFC_PIN_GROUP_SUBSET(qspi0_data2, rpc_data, 0, 2),
 		SH_PFC_PIN_GROUP_SUBSET(qspi0_data4, rpc_data, 0, 4),
@@ -3995,6 +4015,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(sdhi3_cd),
 		SH_PFC_PIN_GROUP(sdhi3_wp),
 		SH_PFC_PIN_GROUP(sdhi3_ds),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(ssi0_data),
 		SH_PFC_PIN_GROUP(ssi01239_ctrl),
 		SH_PFC_PIN_GROUP(ssi1_data),
@@ -4016,6 +4037,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi9_data),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_a),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+#endif
 		SH_PFC_PIN_GROUP(tmu_tclk1_a),
 		SH_PFC_PIN_GROUP(tmu_tclk1_b),
 		SH_PFC_PIN_GROUP(tmu_tclk2_a),
@@ -4025,6 +4047,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(usb0_id),
 		SH_PFC_PIN_GROUP(usb30),
 		SH_PFC_PIN_GROUP(usb30_id),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		BUS_DATA_PIN_GROUP(vin4_data, 8, _a),
 		BUS_DATA_PIN_GROUP(vin4_data, 10, _a),
 		BUS_DATA_PIN_GROUP(vin4_data, 12, _a),
@@ -4055,6 +4078,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_clkenb_a),
 		SH_PFC_PIN_GROUP(vin5_clk_a),
 		SH_PFC_PIN_GROUP(vin5_clk_b),
+#endif
 	},
 #ifdef CONFIG_PINCTRL_PFC_R8A77990
 	.automotive = {
@@ -4084,6 +4108,7 @@ static const struct {
 #endif /* CONFIG_PINCTRL_PFC_R8A77990 */
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const audio_clk_groups[] = {
 	"audio_clk_a",
 	"audio_clk_b_a",
@@ -4104,6 +4129,7 @@ static const char * const audio_clk_groups[] = {
 	"audio_clkout3_b",
 	"audio_clkout3_c",
 };
+#endif
 
 static const char * const avb_groups[] = {
 	"avb_link",
@@ -4115,6 +4141,7 @@ static const char * const avb_groups[] = {
 	"avb_avtp_capture",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const can0_groups[] = {
 	"can0_data",
 };
@@ -4134,6 +4161,7 @@ static const char * const canfd0_groups[] = {
 static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77990
 static const char * const drif0_groups[] = {
@@ -4170,6 +4198,7 @@ static const char * const drif3_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77990 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4181,6 +4210,7 @@ static const char * const du_groups[] = {
 	"du_cde",
 	"du_disp",
 };
+#endif
 
 static const char * const hscif0_groups[] = {
 	"hscif0_data_a",
@@ -4261,6 +4291,7 @@ static const char * const i2c7_groups[] = {
 	"i2c7_b",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0",
 	"intc_ex_irq1",
@@ -4269,6 +4300,7 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77990
 static const char * const mlb_3pin_groups[] = {
@@ -4276,6 +4308,7 @@ static const char * const mlb_3pin_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77990 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -4359,6 +4392,7 @@ static const char * const pwm6_groups[] = {
 	"pwm6_a",
 	"pwm6_b",
 };
+#endif
 
 static const char * const qspi0_groups[] = {
 	"qspi0_ctrl",
@@ -4458,6 +4492,7 @@ static const char * const sdhi3_groups[] = {
 	"sdhi3_ds",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const ssi_groups[] = {
 	"ssi0_data",
 	"ssi01239_ctrl",
@@ -4481,6 +4516,7 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl_a",
 	"ssi9_ctrl_b",
 };
+#endif
 
 static const char * const tmu_groups[] = {
 	"tmu_tclk1_a",
@@ -4500,6 +4536,7 @@ static const char * const usb30_groups[] = {
 	"usb30_id",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin4_groups[] = {
 	"vin4_data8_a",
 	"vin4_data10_a",
@@ -4535,6 +4572,7 @@ static const char * const vin5_groups[] = {
 	"vin5_clk_a",
 	"vin5_clk_b",
 };
+#endif
 
 static const struct {
 	struct sh_pfc_function common[50];
@@ -4543,14 +4581,18 @@ static const struct {
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
@@ -4562,6 +4604,7 @@ static const struct {
 		SH_PFC_FUNCTION(i2c5),
 		SH_PFC_FUNCTION(i2c6),
 		SH_PFC_FUNCTION(i2c7),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(intc_ex),
 		SH_PFC_FUNCTION(msiof0),
 		SH_PFC_FUNCTION(msiof1),
@@ -4574,6 +4617,7 @@ static const struct {
 		SH_PFC_FUNCTION(pwm4),
 		SH_PFC_FUNCTION(pwm5),
 		SH_PFC_FUNCTION(pwm6),
+#endif
 		SH_PFC_FUNCTION(qspi0),
 		SH_PFC_FUNCTION(qspi1),
 		SH_PFC_FUNCTION(rpc),
@@ -4587,12 +4631,16 @@ static const struct {
 		SH_PFC_FUNCTION(sdhi0),
 		SH_PFC_FUNCTION(sdhi1),
 		SH_PFC_FUNCTION(sdhi3),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(ssi),
+#endif
 		SH_PFC_FUNCTION(tmu),
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb30),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(vin4),
 		SH_PFC_FUNCTION(vin5),
+#endif
 	},
 #ifdef CONFIG_PINCTRL_PFC_R8A77990
 	.automotive = {
-- 
2.45.2

