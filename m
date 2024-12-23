Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893F6E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1D1480772;
	Mon, 23 Dec 2024 14:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NdgmR8Fg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iImV931n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27449806FB; Mon, 23 Dec 2024 14:35:44 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D92BE806FB
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YGzYT42Wsz9slj;
 Mon, 23 Dec 2024 14:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xl8yWTuU0PLsWFqtBfPD3ijGa44iLBavFmkJQu9uRdY=;
 b=NdgmR8FglY+shgq8gE1a6H2HJ0ymrbg9+Pdt8+NQf6vAdtFokdyvkIH5cqnPFg831TeFvY
 yFSU8AEkE1nIvpLHKUWDh6WQ5jw1q77dT4hEJerQidIu17A0aN5hZRrOdLK6bUR/prAPJe
 hYLiVs3mJsBLhqJhLgAIXGPnvEH/RPtx98p2QSoLNYfs5DG3EDLyNoV5spi3RFTNa0Zht+
 pzzqFQkN3R+u9632Ka937eXmkzpLxpCZqZUCDhaVHYG8RbPiBXzp9X7Ucvpbkw4PPKgprC
 589iYG2B+0bKSbiIt/O3cl6CrqdRL6nzQTiMJoyoLzTnDnMH17yseooEPnaeZQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xl8yWTuU0PLsWFqtBfPD3ijGa44iLBavFmkJQu9uRdY=;
 b=iImV931n1KGBUsj4SsoMkmDuXMaaQssUwdMcsPYS5PLFsPKAhTCIMxiuBvv06M4bJFnfKb
 OARyf3zJtLvrZ10gSFUU6gBiFLCSXNVOFqNIynstvbVhy74XPcV184zZ+l74YYEbOpKIBV
 f6cINBMse1z/KZsONW+qGaZVWSzaxgjNEaysRr7PNMbIJ/T2pBph9KTZS4MUwsFGJr/QzZ
 Mke5kswUbtACcwkOoR9MbqlxHxIH05HMsHhmPaoGz/QHoYOlpdWsZM8hnXDwl58WnTIA9+
 pFQil4ED16GrCZkApDKcQu2KJ8Qn2dEGdllDIaXSFdLAhFEtCWEEgGIKqIhdUQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/16] pinctrl: renesas: Minimize R8A779G0 V4H PFC tables
Date: Mon, 23 Dec 2024 14:34:19 +0100
Message-ID: <20241223133459.15748-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
References: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6352a866f82bcb1b4ae
X-MBO-RS-META: huiz14hbwap1jjszacoc1ma4bzbsbo7r
X-Rspamd-Queue-Id: 4YGzYT42Wsz9slj
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
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 49 +++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index 2a39d1c8884..f411be8b879 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -1237,6 +1237,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_NOGP_ALL(),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - AUDIO CLOCK ----------------------------------------- */
 static const unsigned int audio_clkin_pins[] = {
 	/* CLK IN */
@@ -1252,6 +1253,7 @@ static const unsigned int audio_clkout_pins[] = {
 static const unsigned int audio_clkout_mux[] = {
 	AUDIO_CLKOUT_MARK,
 };
+#endif
 
 /* - AVB0 ------------------------------------------------ */
 static const unsigned int avb0_link_pins[] = {
@@ -1487,6 +1489,7 @@ static const unsigned int avb2_avtp_match_mux[] = {
 	AVB2_AVTP_MATCH_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CANFD0 ----------------------------------------------------------------- */
 static const unsigned int canfd0_data_pins[] = {
 	/* CANFD0_TX, CANFD0_RX */
@@ -1575,6 +1578,7 @@ static const unsigned int can_clk_pins[] = {
 static const unsigned int can_clk_mux[] = {
 	CAN_CLK_MARK,
 };
+#endif
 
 /* - HSCIF0 ----------------------------------------------------------------- */
 static const unsigned int hscif0_data_pins[] = {
@@ -1766,6 +1770,7 @@ static const unsigned int i2c5_mux[] = {
 	SDA5_MARK, SCL5_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_a_pins[] = {
 	/* IRQ0_A */
@@ -1849,6 +1854,7 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
+#endif
 
 /* - MMC -------------------------------------------------------------------- */
 static const unsigned int mmc_data_pins[] = {
@@ -1893,6 +1899,7 @@ static const unsigned int mmc_ds_mux[] = {
 	MMC_DS_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* MSIOF0_SCK */
@@ -2156,6 +2163,7 @@ static const unsigned int msiof5_rxd_pins[] = {
 static const unsigned int msiof5_rxd_mux[] = {
 	MSIOF5_RXD_MARK,
 };
+#endif
 
 /* - PCIE ------------------------------------------------------------------- */
 static const unsigned int pcie0_clkreq_n_pins[] = {
@@ -2176,6 +2184,7 @@ static const unsigned int pcie1_clkreq_n_mux[] = {
 	PCIE1_CLKREQ_N_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - PWM0 ------------------------------------------------------------------- */
 static const unsigned int pwm0_pins[] = {
 	/* PWM0 */
@@ -2281,6 +2290,7 @@ static const unsigned int pwm9_pins[] = {
 static const unsigned int pwm9_mux[] = {
 	PWM9_MARK,
 };
+#endif
 
 /* - QSPI0 ------------------------------------------------------------------ */
 static const unsigned int qspi0_ctrl_pins[] = {
@@ -2471,6 +2481,7 @@ static const unsigned int scif_clk2_mux[] = {
 	SCIF_CLK2_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SSI ------------------------------------------------- */
 static const unsigned int ssi_data_pins[] = {
 	/* SSI_SD */
@@ -2486,6 +2497,7 @@ static const unsigned int ssi_ctrl_pins[] = {
 static const unsigned int ssi_ctrl_mux[] = {
 	SSI_SCK_MARK, SSI_WS_MARK,
 };
+#endif
 
 /* - TPU -------------------------------------------------------------------- */
 static const unsigned int tpu_to0_a_pins[] = {
@@ -2618,9 +2630,10 @@ static const unsigned int tsn0_avtp_match_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(audio_clkin),
 	SH_PFC_PIN_GROUP(audio_clkout),
-
+#endif
 	SH_PFC_PIN_GROUP(avb0_link),
 	SH_PFC_PIN_GROUP(avb0_magic),
 	SH_PFC_PIN_GROUP(avb0_phy_int),
@@ -2651,6 +2664,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb2_avtp_capture),
 	SH_PFC_PIN_GROUP(avb2_avtp_match),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(canfd0_data),
 	SH_PFC_PIN_GROUP(canfd1_data),
 	SH_PFC_PIN_GROUP(canfd2_data),
@@ -2661,6 +2675,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(canfd6_data),
 	SH_PFC_PIN_GROUP(canfd7_data),
 	SH_PFC_PIN_GROUP(can_clk),
+#endif
 
 	SH_PFC_PIN_GROUP(hscif0_data),
 	SH_PFC_PIN_GROUP(hscif0_clk),
@@ -2688,6 +2703,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c4),
 	SH_PFC_PIN_GROUP(i2c5),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(intc_ex_irq0_a),
 	SH_PFC_PIN_GROUP(intc_ex_irq0_b),
 	SH_PFC_PIN_GROUP(intc_ex_irq1_a),
@@ -2699,6 +2715,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(intc_ex_irq4_a),
 	SH_PFC_PIN_GROUP(intc_ex_irq4_b),
 	SH_PFC_PIN_GROUP(intc_ex_irq5),
+#endif
 
 	BUS_DATA_PIN_GROUP(mmc_data, 1),
 	BUS_DATA_PIN_GROUP(mmc_data, 4),
@@ -2708,6 +2725,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(mmc_wp),
 	SH_PFC_PIN_GROUP(mmc_ds),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(msiof0_clk),
 	SH_PFC_PIN_GROUP(msiof0_sync),
 	SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -2749,10 +2767,12 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof5_ss2),
 	SH_PFC_PIN_GROUP(msiof5_txd),
 	SH_PFC_PIN_GROUP(msiof5_rxd),
+#endif
 
 	SH_PFC_PIN_GROUP(pcie0_clkreq_n),
 	SH_PFC_PIN_GROUP(pcie1_clkreq_n),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(pwm0),
 	SH_PFC_PIN_GROUP(pwm1_a),
 	SH_PFC_PIN_GROUP(pwm1_b),
@@ -2765,6 +2785,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(pwm7),
 	SH_PFC_PIN_GROUP(pwm8),
 	SH_PFC_PIN_GROUP(pwm9),
+#endif
 
 	SH_PFC_PIN_GROUP(qspi0_ctrl),
 	BUS_DATA_PIN_GROUP(qspi0_data, 2),
@@ -2794,8 +2815,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif_clk),
 	SH_PFC_PIN_GROUP(scif_clk2),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(ssi_data),
 	SH_PFC_PIN_GROUP(ssi_ctrl),
+#endif
 
 	SH_PFC_PIN_GROUP(tpu_to0_a),
 	SH_PFC_PIN_GROUP(tpu_to0_b),
@@ -2816,10 +2839,12 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(tsn0_avtp_match),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const audio_clk_groups[] = {
 	"audio_clkin",
 	"audio_clkout",
 };
+#endif
 
 static const char * const avb0_groups[] = {
 	"avb0_link",
@@ -2857,6 +2882,7 @@ static const char * const avb2_groups[] = {
 	"avb2_avtp_match",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const canfd0_groups[] = {
 	"canfd0_data",
 };
@@ -2893,6 +2919,7 @@ static const char * const canfd7_groups[] = {
 static const char * const can_clk_groups[] = {
 	"can_clk",
 };
+#endif
 
 static const char * const hscif0_groups[] = {
 	"hscif0_data",
@@ -2948,6 +2975,7 @@ static const char * const i2c5_groups[] = {
 	"i2c5",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0_a",
 	"intc_ex_irq0_b",
@@ -2961,6 +2989,7 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4_b",
 	"intc_ex_irq5",
 };
+#endif
 
 static const char * const mmc_groups[] = {
 	"mmc_data1",
@@ -2972,6 +3001,7 @@ static const char * const mmc_groups[] = {
 	"mmc_ds",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -3025,12 +3055,14 @@ static const char * const msiof5_groups[] = {
 	"msiof5_txd",
 	"msiof5_rxd",
 };
+#endif
 
 static const char * const pcie_groups[] = {
 	"pcie0_clkreq_n",
 	"pcie1_clkreq_n",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const pwm0_groups[] = {
 	"pwm0",
 };
@@ -3072,6 +3104,7 @@ static const char * const pwm8_groups[] = {
 static const char * const pwm9_groups[] = {
 	"pwm9",
 };
+#endif
 
 static const char * const qspi0_groups[] = {
 	"qspi0_ctrl",
@@ -3123,10 +3156,12 @@ static const char * const scif_clk2_groups[] = {
 	"scif_clk2",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const ssi_groups[] = {
 	"ssi_data",
 	"ssi_ctrl",
 };
+#endif
 
 static const char * const tpu_groups[] = {
 	"tpu_to0_a",
@@ -3151,12 +3186,15 @@ static const char * const tsn0_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(audio_clk),
+#endif
 
 	SH_PFC_FUNCTION(avb0),
 	SH_PFC_FUNCTION(avb1),
 	SH_PFC_FUNCTION(avb2),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(canfd0),
 	SH_PFC_FUNCTION(canfd1),
 	SH_PFC_FUNCTION(canfd2),
@@ -3166,6 +3204,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(canfd6),
 	SH_PFC_FUNCTION(canfd7),
 	SH_PFC_FUNCTION(can_clk),
+#endif
 
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
@@ -3179,19 +3218,24 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c4),
 	SH_PFC_FUNCTION(i2c5),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(intc_ex),
+#endif
 
 	SH_PFC_FUNCTION(mmc),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
 	SH_PFC_FUNCTION(msiof3),
 	SH_PFC_FUNCTION(msiof4),
 	SH_PFC_FUNCTION(msiof5),
+#endif
 
 	SH_PFC_FUNCTION(pcie),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(pwm0),
 	SH_PFC_FUNCTION(pwm1),
 	SH_PFC_FUNCTION(pwm2),
@@ -3202,6 +3246,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(pwm7),
 	SH_PFC_FUNCTION(pwm8),
 	SH_PFC_FUNCTION(pwm9),
+#endif
 
 	SH_PFC_FUNCTION(qspi0),
 	SH_PFC_FUNCTION(qspi1),
@@ -3213,7 +3258,9 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(scif_clk2),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(ssi),
+#endif
 
 	SH_PFC_FUNCTION(tpu),
 
-- 
2.45.2

