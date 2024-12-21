Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF6BE7718D
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4E4805CD;
	Sat, 21 Dec 2024 22:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="L0UlWQyx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XCgkRiJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1AD805F0; Sat, 21 Dec 2024 22:35:18 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806F0803A9
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YFyHm209wz9ssM;
 Sat, 21 Dec 2024 22:35:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVjxM22Q7X6wJVHBQx+VfWk+n40jHk//5wpHDplQGOQ=;
 b=L0UlWQyxFVN90mC7JnbZji5LkN4Xqh53DgDkfO5ETEA1bifDnBDuaxU4qK1dvcO99peCWF
 GX88iVqIPDzy5e5RgSVIR8KidG0h9q3zhO7dmzj/RS6cHRB6Bg0JzJhT+gLdhpRRLGe+zn
 Dw75RuAafncHC5uFVCMgkcv1zH/t4FAYlHbSWU55Y4h5L4e0Ro9XEjDae0mZYwqtHRoUTZ
 WyKbEeuyCy6W1u4TfhUX+gfcWd9JoeBHQpV4BSfSG/YOIXbk5wEabmzWcdC6VvtTTFAYpP
 yiIChwW1Zb+n3H3jB2F+2MoNw9Xj/7o9Z30lkQ8hTP98X/J8XLbxkLt0cicWyw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVjxM22Q7X6wJVHBQx+VfWk+n40jHk//5wpHDplQGOQ=;
 b=XCgkRiJ3iOkFQmGZYVu9ee3xUfEXOm2TMdzrf4JQvxowcPh8LZOk75XhKSaaSYebh3L7mX
 jDbuArEQuCfFqecnnOdqJmrwkXgDhGY94/61q0EgAhvup+XoxDi23/9WlWjcWBmXaw6tec
 Hev9jMFlSfnF6ywsjJqFA6yJo88tebfJA87E7BLiFw7qEZUo/SStGQYuvBzGtU2O/7vzQ+
 0k4CMhu4SdUgPIONAW54H06x463dL40j72XiwD8A/WYmJLUArLesWV5UkXt8L7K+0pQXhs
 GrBKkjG6doSZ6EwneR1Lt6r8cUon3EzF9Ur/+0lkOnIvYTGXjx4neCV7hVefRA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/16] pinctrl: renesas: Minimize R8A77951 H3 PFC tables
Date: Sat, 21 Dec 2024 22:34:05 +0100
Message-ID: <20241221213443.115024-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 688c528f3fb44e4b43e
X-MBO-RS-META: ns4yssey6mxwy69w9tj8qzq1b7d8ayjq
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
 drivers/pinctrl/renesas/pfc-r8a77951.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77951.c b/drivers/pinctrl/renesas/pfc-r8a77951.c
index 1cfdc335041..8ddcbfbbd64 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77951.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77951.c
@@ -1563,6 +1563,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_NOGP_ALL(),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - AUDIO CLOCK ------------------------------------------------------------ */
 static const unsigned int audio_clk_a_a_pins[] = {
 	/* CLK A */
@@ -1683,6 +1684,7 @@ static const unsigned int audio_clkout3_b_pins[] = {
 static const unsigned int audio_clkout3_b_mux[] = {
 	AUDIO_CLKOUT3_B_MARK,
 };
+#endif
 
 /* - EtherAVB --------------------------------------------------------------- */
 static const unsigned int avb_link_pins[] = {
@@ -1770,6 +1772,7 @@ static const unsigned int avb_avtp_capture_b_mux[] = {
 	AVB_AVTP_CAPTURE_B_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CAN ------------------------------------------------------------------ */
 static const unsigned int can0_data_a_pins[] = {
 	/* TX, RX */
@@ -1824,6 +1827,7 @@ static const unsigned int canfd1_data_pins[] = {
 static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK,         CANFD1_RX_MARK,
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 /* - DRIF0 --------------------------------------------------------------- */
@@ -2042,6 +2046,7 @@ static const unsigned int drif3_data1_b_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -2122,6 +2127,7 @@ static const unsigned int du_disp_pins[] = {
 static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
+#endif
 
 /* - HSCIF0 ----------------------------------------------------------------- */
 static const unsigned int hscif0_data_pins[] = {
@@ -2409,6 +2415,7 @@ static const unsigned int i2c6_c_mux[] = {
 	SDA6_C_MARK, SCL6_C_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_pins[] = {
 	/* IRQ0 */
@@ -2452,6 +2459,7 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 /* - MLB+ ------------------------------------------------------------------- */
@@ -2463,6 +2471,7 @@ static const unsigned int mlb_3pin_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -3259,6 +3268,7 @@ static const unsigned int pwm6_b_pins[] = {
 static const unsigned int pwm6_b_mux[] = {
 	PWM6_B_MARK,
 };
+#endif
 
 /* - QSPI0 ------------------------------------------------------------------ */
 static const unsigned int qspi0_ctrl_pins[] = {
@@ -3687,6 +3697,7 @@ static const unsigned int sdhi3_ds_mux[] = {
 	SD3_DS_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SSI -------------------------------------------------------------------- */
 static const unsigned int ssi0_data_pins[] = {
 	/* SDATA */
@@ -3863,6 +3874,7 @@ static const unsigned int ssi9_ctrl_b_pins[] = {
 static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
+#endif
 
 /* - TMU -------------------------------------------------------------------- */
 static const unsigned int tmu_tclk1_a_pins[] = {
@@ -3966,6 +3978,7 @@ static const unsigned int usb30_mux[] = {
 	USB30_PWEN_MARK, USB30_OVC_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN4 ------------------------------------------------------------------- */
 static const unsigned int vin4_data18_a_pins[] = {
 	RCAR_GP_PIN(0, 10), RCAR_GP_PIN(0, 11),
@@ -4145,6 +4158,7 @@ static const unsigned int vin5_clk_mux[] = {
 	/* CLK */
 	VI5_CLK_MARK,
 };
+#endif
 
 static const struct {
 	struct sh_pfc_pin_group common[328];
@@ -4153,6 +4167,7 @@ static const struct {
 #endif
 } pinmux_groups = {
 	.common = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(audio_clk_a_a),
 		SH_PFC_PIN_GROUP(audio_clk_a_b),
 		SH_PFC_PIN_GROUP(audio_clk_a_c),
@@ -4170,6 +4185,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(audio_clkout2_b),
 		SH_PFC_PIN_GROUP(audio_clkout3_a),
 		SH_PFC_PIN_GROUP(audio_clkout3_b),
+#endif
 		SH_PFC_PIN_GROUP(avb_link),
 		SH_PFC_PIN_GROUP(avb_magic),
 		SH_PFC_PIN_GROUP(avb_phy_int),
@@ -4181,6 +4197,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(avb_avtp_capture_a),
 		SH_PFC_PIN_GROUP(avb_avtp_match_b),
 		SH_PFC_PIN_GROUP(avb_avtp_capture_b),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(can0_data_a),
 		SH_PFC_PIN_GROUP(can0_data_b),
 		SH_PFC_PIN_GROUP(can1_data),
@@ -4196,6 +4213,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(du_oddf),
 		SH_PFC_PIN_GROUP(du_cde),
 		SH_PFC_PIN_GROUP(du_disp),
+#endif
 		SH_PFC_PIN_GROUP(hscif0_data),
 		SH_PFC_PIN_GROUP(hscif0_clk),
 		SH_PFC_PIN_GROUP(hscif0_ctrl),
@@ -4234,6 +4252,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(i2c6_a),
 		SH_PFC_PIN_GROUP(i2c6_b),
 		SH_PFC_PIN_GROUP(i2c6_c),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(intc_ex_irq0),
 		SH_PFC_PIN_GROUP(intc_ex_irq1),
 		SH_PFC_PIN_GROUP(intc_ex_irq2),
@@ -4352,6 +4371,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(pwm5_b),
 		SH_PFC_PIN_GROUP(pwm6_a),
 		SH_PFC_PIN_GROUP(pwm6_b),
+#endif
 		SH_PFC_PIN_GROUP(qspi0_ctrl),
 		BUS_DATA_PIN_GROUP(qspi0_data, 2),
 		BUS_DATA_PIN_GROUP(qspi0_data, 4),
@@ -4415,6 +4435,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(sdhi3_cd),
 		SH_PFC_PIN_GROUP(sdhi3_wp),
 		SH_PFC_PIN_GROUP(sdhi3_ds),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(ssi0_data),
 		SH_PFC_PIN_GROUP(ssi01239_ctrl),
 		SH_PFC_PIN_GROUP(ssi1_data_a),
@@ -4440,6 +4461,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi9_data_b),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_a),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+#endif
 		SH_PFC_PIN_GROUP(tmu_tclk1_a),
 		SH_PFC_PIN_GROUP(tmu_tclk1_b),
 		SH_PFC_PIN_GROUP(tmu_tclk2_a),
@@ -4453,6 +4475,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(usb2),
 		SH_PFC_PIN_GROUP(usb2_ch3),
 		SH_PFC_PIN_GROUP(usb30),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		BUS_DATA_PIN_GROUP(vin4_data, 8, _a),
 		BUS_DATA_PIN_GROUP(vin4_data, 10, _a),
 		BUS_DATA_PIN_GROUP(vin4_data, 12, _a),
@@ -4481,6 +4504,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_field),
 		SH_PFC_PIN_GROUP(vin5_clkenb),
 		SH_PFC_PIN_GROUP(vin5_clk),
+#endif
 	},
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 	.automotive = {
@@ -4519,6 +4543,7 @@ static const struct {
 #endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const audio_clk_groups[] = {
 	"audio_clk_a_a",
 	"audio_clk_a_b",
@@ -4538,6 +4563,7 @@ static const char * const audio_clk_groups[] = {
 	"audio_clkout3_a",
 	"audio_clkout3_b",
 };
+#endif
 
 static const char * const avb_groups[] = {
 	"avb_link",
@@ -4553,6 +4579,7 @@ static const char * const avb_groups[] = {
 	"avb_avtp_capture_b",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const can0_groups[] = {
 	"can0_data_a",
 	"can0_data_b",
@@ -4574,6 +4601,7 @@ static const char * const canfd0_groups[] = {
 static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 static const char * const drif0_groups[] = {
@@ -4619,6 +4647,7 @@ static const char * const drif3_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4629,6 +4658,7 @@ static const char * const du_groups[] = {
 	"du_cde",
 	"du_disp",
 };
+#endif
 
 static const char * const hscif0_groups[] = {
 	"hscif0_data",
@@ -4701,6 +4731,7 @@ static const char * const i2c6_groups[] = {
 	"i2c6_c",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0",
 	"intc_ex_irq1",
@@ -4709,6 +4740,7 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 static const char * const mlb_3pin_groups[] = {
@@ -4716,6 +4748,7 @@ static const char * const mlb_3pin_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -4860,6 +4893,7 @@ static const char * const pwm6_groups[] = {
 	"pwm6_a",
 	"pwm6_b",
 };
+#endif
 
 static const char * const qspi0_groups[] = {
 	"qspi0_ctrl",
@@ -4966,6 +5000,7 @@ static const char * const sdhi3_groups[] = {
 	"sdhi3_ds",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const ssi_groups[] = {
 	"ssi0_data",
 	"ssi01239_ctrl",
@@ -4993,6 +5028,7 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl_a",
 	"ssi9_ctrl_b",
 };
+#endif
 
 static const char * const tmu_groups[] = {
 	"tmu_tclk1_a",
@@ -5028,6 +5064,7 @@ static const char * const usb30_groups[] = {
 	"usb30",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin4_groups[] = {
 	"vin4_data8_a",
 	"vin4_data10_a",
@@ -5061,6 +5098,7 @@ static const char * const vin5_groups[] = {
 	"vin5_clkenb",
 	"vin5_clk",
 };
+#endif
 
 static const struct {
 	struct sh_pfc_function common[55];
@@ -5069,14 +5107,18 @@ static const struct {
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
@@ -5088,6 +5130,7 @@ static const struct {
 		SH_PFC_FUNCTION(i2c3),
 		SH_PFC_FUNCTION(i2c5),
 		SH_PFC_FUNCTION(i2c6),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(intc_ex),
 		SH_PFC_FUNCTION(msiof0),
 		SH_PFC_FUNCTION(msiof1),
@@ -5100,6 +5143,7 @@ static const struct {
 		SH_PFC_FUNCTION(pwm4),
 		SH_PFC_FUNCTION(pwm5),
 		SH_PFC_FUNCTION(pwm6),
+#endif
 		SH_PFC_FUNCTION(qspi0),
 		SH_PFC_FUNCTION(qspi1),
 		SH_PFC_FUNCTION(sata0),
@@ -5114,7 +5158,9 @@ static const struct {
 		SH_PFC_FUNCTION(sdhi1),
 		SH_PFC_FUNCTION(sdhi2),
 		SH_PFC_FUNCTION(sdhi3),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(ssi),
+#endif
 		SH_PFC_FUNCTION(tmu),
 		SH_PFC_FUNCTION(tpu),
 		SH_PFC_FUNCTION(usb0),
@@ -5122,8 +5168,10 @@ static const struct {
 		SH_PFC_FUNCTION(usb2),
 		SH_PFC_FUNCTION(usb2_ch3),
 		SH_PFC_FUNCTION(usb30),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(vin4),
 		SH_PFC_FUNCTION(vin5),
+#endif
 	},
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 	.automotive = {
-- 
2.45.2

