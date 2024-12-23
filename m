Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03256E7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD7C80780;
	Mon, 23 Dec 2024 14:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N3Y+wLAE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Yoo0aaPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41D08073D; Mon, 23 Dec 2024 14:35:37 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8CC280758
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YGzYL4Cpqz9spX;
 Mon, 23 Dec 2024 14:35:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hhHUT0/kRUnxJgaBifuiUmtJMZPQeLFBdQ979bHEM8=;
 b=N3Y+wLAEB4Ny12xjlwRlqNDDHDPS/I0mmj8mRmI3S/o7x29Vhlp8mz1T8i1S5kw6jeb0lY
 fJXT48bM97eX6yFUzlVgovVnPuw7QVupz14FoStaCKVDYYxGstTEaKlP8wPBjsp9YyyME0
 BDPySABbmKhmPA651wK4bId3ZlwNTYDaTtQtnhqDFBMUp1ri60LuVpgNYVYu0nnNaGQQNx
 NQbUV9KtMM/ZAcZLGXu57isXjKCpyKm+/zJFSF0e5vRh0cDPXKNs8hpsWpxn7NhJv9lnpS
 /7L9GdzYtzpbs32T2tEcxgFMGnmYazvuaEU54phmrazGXZ/o86lzf2g6Xl2wQw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hhHUT0/kRUnxJgaBifuiUmtJMZPQeLFBdQ979bHEM8=;
 b=Yoo0aaPAQGClYeKWvNtxDStRg0H0mYnVDCrXrpXD66b+GhFgozC4fND58TgTL5Po8R+PT5
 CPwT/IzOiILp9pddE5X6lS/GohdGp2BmFIY6UGJT1bcOuM53o6EFmx+fHrvB7dvSyaZRYH
 Ugpu0omsE24vKCV2z88PfNu177pzNwT2s8Ijztso5G51mdiK/V0xR4BmpfdWezYi1TApT2
 xPGq1xXKJXyv0GpguJj1J+HnD/pZNRcGSBVs5BT8KrJCpMnioywRR501KUaSSBcqy1oofW
 07RgCWXcEri9PqDtybRpmUp9Lqy+I+XKi+cewMWZ6/FK1w3XLqqbU1sPE0wD/w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/16] pinctrl: renesas: Minimize R8A77965 M3-N PFC tables
Date: Mon, 23 Dec 2024 14:34:12 +0100
Message-ID: <20241223133459.15748-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
References: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1a60d73ef2908729dc5
X-MBO-RS-META: y5hiobun3psfd1bp8pkn96q7e59u1p6d
X-Rspamd-Queue-Id: 4YGzYL4Cpqz9spX
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
V2: No change
---
 drivers/pinctrl/renesas/pfc-r8a77965.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77965.c b/drivers/pinctrl/renesas/pfc-r8a77965.c
index 2852ae64ec0..97fde005de6 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77965.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77965.c
@@ -1572,6 +1572,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_NOGP_ALL(),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - AUDIO CLOCK ------------------------------------------------------------ */
 static const unsigned int audio_clk_a_a_pins[] = {
 	/* CLK A */
@@ -1693,6 +1694,7 @@ static const unsigned int audio_clkout3_b_pins[] = {
 static const unsigned int audio_clkout3_b_mux[] = {
 	AUDIO_CLKOUT3_B_MARK,
 };
+#endif
 
 /* - EtherAVB --------------------------------------------------------------- */
 static const unsigned int avb_link_pins[] = {
@@ -1780,6 +1782,7 @@ static const unsigned int avb_avtp_capture_b_mux[] = {
 	AVB_AVTP_CAPTURE_B_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CAN ------------------------------------------------------------------ */
 static const unsigned int can0_data_a_pins[] = {
 	/* TX, RX */
@@ -1845,6 +1848,7 @@ static const unsigned int canfd1_data_pins[] = {
 static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK,         CANFD1_RX_MARK,
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77965
 /* - DRIF0 --------------------------------------------------------------- */
@@ -2122,6 +2126,7 @@ static const unsigned int drif3_data1_b_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77965 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -2217,6 +2222,7 @@ static const unsigned int du_disp_pins[] = {
 static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
+#endif
 
 /* - HSCIF0 ----------------------------------------------------------------- */
 static const unsigned int hscif0_data_pins[] = {
@@ -2566,6 +2572,7 @@ static const unsigned int i2c6_c_mux[] = {
 	SDA6_C_MARK, SCL6_C_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_pins[] = {
 	/* IRQ0 */
@@ -2609,6 +2616,7 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77965
 /* - MLB+ ------------------------------------------------------------------- */
@@ -2620,6 +2628,7 @@ static const unsigned int mlb_3pin_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77965 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -3416,6 +3425,7 @@ static const unsigned int pwm6_b_pins[] = {
 static const unsigned int pwm6_b_mux[] = {
 	PWM6_B_MARK,
 };
+#endif
 
 /* - QSPI0 ------------------------------------------------------------------ */
 static const unsigned int qspi0_ctrl_pins[] = {
@@ -3884,6 +3894,7 @@ static const unsigned int sdhi3_ds_mux[] = {
 	SD3_DS_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SSI -------------------------------------------------------------------- */
 static const unsigned int ssi0_data_pins[] = {
 	/* SDATA */
@@ -4060,6 +4071,7 @@ static const unsigned int ssi9_ctrl_b_pins[] = {
 static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
+#endif
 
 /* - TMU -------------------------------------------------------------------- */
 static const unsigned int tmu_tclk1_a_pins[] = {
@@ -4158,6 +4170,7 @@ static const unsigned int usb30_mux[] = {
 	USB30_PWEN_MARK, USB30_OVC_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN4 ------------------------------------------------------------------- */
 static const unsigned int vin4_data18_a_pins[] = {
 	RCAR_GP_PIN(0, 10), RCAR_GP_PIN(0, 11),
@@ -4355,6 +4368,7 @@ static const unsigned int vin5_clk_pins[] = {
 static const unsigned int vin5_clk_mux[] = {
 	VI5_CLK_MARK,
 };
+#endif
 
 static const struct {
 	struct sh_pfc_pin_group common[326];
@@ -4363,6 +4377,7 @@ static const struct {
 #endif
 } pinmux_groups = {
 	.common = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(audio_clk_a_a),
 		SH_PFC_PIN_GROUP(audio_clk_a_b),
 		SH_PFC_PIN_GROUP(audio_clk_a_c),
@@ -4380,6 +4395,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(audio_clkout2_b),
 		SH_PFC_PIN_GROUP(audio_clkout3_a),
 		SH_PFC_PIN_GROUP(audio_clkout3_b),
+#endif
 		SH_PFC_PIN_GROUP(avb_link),
 		SH_PFC_PIN_GROUP(avb_magic),
 		SH_PFC_PIN_GROUP(avb_phy_int),
@@ -4391,6 +4407,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(avb_avtp_capture_a),
 		SH_PFC_PIN_GROUP(avb_avtp_match_b),
 		SH_PFC_PIN_GROUP(avb_avtp_capture_b),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(can0_data_a),
 		SH_PFC_PIN_GROUP(can0_data_b),
 		SH_PFC_PIN_GROUP(can1_data),
@@ -4406,6 +4423,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(du_oddf),
 		SH_PFC_PIN_GROUP(du_cde),
 		SH_PFC_PIN_GROUP(du_disp),
+#endif
 		SH_PFC_PIN_GROUP(hscif0_data),
 		SH_PFC_PIN_GROUP(hscif0_clk),
 		SH_PFC_PIN_GROUP(hscif0_ctrl),
@@ -4444,6 +4462,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(i2c6_a),
 		SH_PFC_PIN_GROUP(i2c6_b),
 		SH_PFC_PIN_GROUP(i2c6_c),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(intc_ex_irq0),
 		SH_PFC_PIN_GROUP(intc_ex_irq1),
 		SH_PFC_PIN_GROUP(intc_ex_irq2),
@@ -4562,6 +4581,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(pwm5_b),
 		SH_PFC_PIN_GROUP(pwm6_a),
 		SH_PFC_PIN_GROUP(pwm6_b),
+#endif
 		SH_PFC_PIN_GROUP(qspi0_ctrl),
 		BUS_DATA_PIN_GROUP(qspi0_data, 2),
 		BUS_DATA_PIN_GROUP(qspi0_data, 4),
@@ -4625,6 +4645,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(sdhi3_cd),
 		SH_PFC_PIN_GROUP(sdhi3_wp),
 		SH_PFC_PIN_GROUP(sdhi3_ds),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(ssi0_data),
 		SH_PFC_PIN_GROUP(ssi01239_ctrl),
 		SH_PFC_PIN_GROUP(ssi1_data_a),
@@ -4650,6 +4671,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi9_data_b),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_a),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+#endif
 		SH_PFC_PIN_GROUP(tmu_tclk1_a),
 		SH_PFC_PIN_GROUP(tmu_tclk1_b),
 		SH_PFC_PIN_GROUP(tmu_tclk2_a),
@@ -4661,6 +4683,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(usb0),
 		SH_PFC_PIN_GROUP(usb1),
 		SH_PFC_PIN_GROUP(usb30),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		BUS_DATA_PIN_GROUP(vin4_data, 8, _a),
 		BUS_DATA_PIN_GROUP(vin4_data, 10, _a),
 		BUS_DATA_PIN_GROUP(vin4_data, 12, _a),
@@ -4689,6 +4712,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_field),
 		SH_PFC_PIN_GROUP(vin5_clkenb),
 		SH_PFC_PIN_GROUP(vin5_clk),
+#endif
 	},
 #ifdef CONFIG_PINCTRL_PFC_R8A77965
 	.automotive = {
@@ -4727,6 +4751,7 @@ static const struct {
 #endif /* CONFIG_PINCTRL_PFC_R8A77965 */
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const audio_clk_groups[] = {
 	"audio_clk_a_a",
 	"audio_clk_a_b",
@@ -4746,6 +4771,7 @@ static const char * const audio_clk_groups[] = {
 	"audio_clkout3_a",
 	"audio_clkout3_b",
 };
+#endif
 
 static const char * const avb_groups[] = {
 	"avb_link",
@@ -4761,6 +4787,7 @@ static const char * const avb_groups[] = {
 	"avb_avtp_capture_b",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const can0_groups[] = {
 	"can0_data_a",
 	"can0_data_b",
@@ -4782,6 +4809,7 @@ static const char * const canfd0_groups[] = {
 static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77965
 static const char * const drif0_groups[] = {
@@ -4827,6 +4855,7 @@ static const char * const drif3_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77965 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4837,6 +4866,7 @@ static const char * const du_groups[] = {
 	"du_cde",
 	"du_disp",
 };
+#endif
 
 static const char * const hscif0_groups[] = {
 	"hscif0_data",
@@ -4909,6 +4939,7 @@ static const char * const i2c6_groups[] = {
 	"i2c6_c",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0",
 	"intc_ex_irq1",
@@ -4917,6 +4948,7 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
+#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77965
 static const char * const mlb_3pin_groups[] = {
@@ -4924,6 +4956,7 @@ static const char * const mlb_3pin_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77965 */
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -5068,6 +5101,7 @@ static const char * const pwm6_groups[] = {
 	"pwm6_a",
 	"pwm6_b",
 };
+#endif
 
 static const char * const qspi0_groups[] = {
 	"qspi0_ctrl",
@@ -5173,6 +5207,7 @@ static const char * const sdhi3_groups[] = {
 	"sdhi3_ds",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const ssi_groups[] = {
 	"ssi0_data",
 	"ssi01239_ctrl",
@@ -5200,6 +5235,7 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl_a",
 	"ssi9_ctrl_b",
 };
+#endif
 
 static const char * const tmu_groups[] = {
 	"tmu_tclk1_a",
@@ -5227,6 +5263,7 @@ static const char * const usb30_groups[] = {
 	"usb30",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin4_groups[] = {
 	"vin4_data8_a",
 	"vin4_data10_a",
@@ -5260,6 +5297,7 @@ static const char * const vin5_groups[] = {
 	"vin5_clkenb",
 	"vin5_clk",
 };
+#endif
 
 static const struct {
 	struct sh_pfc_function common[53];
@@ -5268,14 +5306,18 @@ static const struct {
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
@@ -5287,6 +5329,7 @@ static const struct {
 		SH_PFC_FUNCTION(i2c3),
 		SH_PFC_FUNCTION(i2c5),
 		SH_PFC_FUNCTION(i2c6),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(intc_ex),
 		SH_PFC_FUNCTION(msiof0),
 		SH_PFC_FUNCTION(msiof1),
@@ -5299,6 +5342,7 @@ static const struct {
 		SH_PFC_FUNCTION(pwm4),
 		SH_PFC_FUNCTION(pwm5),
 		SH_PFC_FUNCTION(pwm6),
+#endif
 		SH_PFC_FUNCTION(qspi0),
 		SH_PFC_FUNCTION(qspi1),
 		SH_PFC_FUNCTION(sata0),
@@ -5313,14 +5357,18 @@ static const struct {
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
 #ifdef CONFIG_PINCTRL_PFC_R8A77965
 	.automotive = {
-- 
2.45.2

