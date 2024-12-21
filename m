Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16659E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1DB806F4;
	Sat, 21 Dec 2024 22:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="inmdQIrQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xVYgxDr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93351805C3; Sat, 21 Dec 2024 22:35:27 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8D580658
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YFyHx0N5yz9t1B;
 Sat, 21 Dec 2024 22:35:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ay5kzdZtDthGGh8ly5AJFp5uY8aSIgjnrTBeIDh/vs=;
 b=inmdQIrQgYk/18KBNoEcJ/mHwUns97x5RzS4U79bMX6xJa7Ky2B5g73ylVChrwsPRxcqSt
 CoYgK1ACFGyiun6ChOp1kC8QgIImHL7qKXL1IO8vOBDQeFcCJiBtyiz6AkkV2Y4+NqWr3G
 6DqsIOXvE0FC70WZSfPkpFBB34W8hPoMiKS4TUWy0RhXHI1VaHMnNeZSdZRvv12mMVOz8Y
 39DgkdkQry4EwJpw7r4MZXVDqNoWoEZM4osIMRYTnl/TxaJx5Hpa6zGPqthvi510ULHIAo
 5pvZcoGCAdlmcZzAz3iliJ0OiogEkWIg8PfiB8WxPhuGY92ojm8HG6LC0N5jTQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ay5kzdZtDthGGh8ly5AJFp5uY8aSIgjnrTBeIDh/vs=;
 b=xVYgxDr/8FJl9fqnZ+EdXXP4ENLaWgTda2ftmGt6gQ9fK436c7Jm1eAfaaW16KMNnMjF1o
 BoRAo348yLWq9e0wlE+7jalrfoC/PTjOqe4joGQdcp2O3oVqCMkqIuNB4eBBMxPiLw3F38
 9vqDW1RcNiUsjw1n4KmFF04dJHlfufzhBXi/6AA8diZD6+PWsQC8JYxIsnu1NvCFJc8Ox9
 LNzPYnZyTxXC4edaAbPtLHQwYjQXrQZKPOaVb1oSMx4HgyIiu93sjDgcCG7uPumJ3vx/7y
 Y6lx19EcgCHBPPOUsZlcmOK7yfHQjhNJTx54S7YBV6aR9wt+BNRY2qTvdbCVLA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/16] pinctrl: renesas: Minimize R8A779H0 V4M PFC tables
Date: Sat, 21 Dec 2024 22:34:15 +0100
Message-ID: <20241221213443.115024-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jynu8ed78yr864sx5ma14twranoyzc79
X-MBO-RS-ID: 3e81e84f8225435be4c
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
- INTC/INTC-EX
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
 drivers/pinctrl/renesas/pfc-r8a779h0.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779h0.c b/drivers/pinctrl/renesas/pfc-r8a779h0.c
index bfabf0c379a..87af037a8d3 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779h0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779h0.c
@@ -1193,6 +1193,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_NOGP_ALL(),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - AUDIO CLOCK ----------------------------------------- */
 static const unsigned int audio_clkin_pins[] = {
 	/* CLK IN */
@@ -1208,6 +1209,7 @@ static const unsigned int audio_clkout_pins[] = {
 static const unsigned int audio_clkout_mux[] = {
 	AUDIO_CLKOUT_MARK,
 };
+#endif
 
 /* - AVB0 ------------------------------------------------ */
 static const unsigned int avb0_link_pins[] = {
@@ -1491,6 +1493,7 @@ static const unsigned int avb2_avtp_match_mux[] = {
 	AVB2_AVTP_MATCH_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CANFD0 ----------------------------------------------------------------- */
 static const unsigned int canfd0_data_pins[] = {
 	/* CANFD0_TX, CANFD0_RX */
@@ -1535,6 +1538,7 @@ static const unsigned int can_clk_pins[] = {
 static const unsigned int can_clk_mux[] = {
 	CAN_CLK_MARK,
 };
+#endif
 
 /* - HSCIF0 ----------------------------------------------------------------- */
 static const unsigned int hscif0_data_pins[] = {
@@ -1708,6 +1712,7 @@ static const unsigned int i2c3_mux[] = {
 	SDA3_MARK, SCL3_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_a_pins[] = {
 	/* IRQ0_A */
@@ -1791,6 +1796,7 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
+#endif
 
 /* - MMC -------------------------------------------------------------------- */
 static const unsigned int mmc_data_pins[] = {
@@ -1835,6 +1841,7 @@ static const unsigned int mmc_ds_mux[] = {
 	MMC_DS_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* MSIOF0_SCK */
@@ -2098,6 +2105,7 @@ static const unsigned int msiof5_rxd_pins[] = {
 static const unsigned int msiof5_rxd_mux[] = {
 	MSIOF5_RXD_MARK,
 };
+#endif
 
 /* - PCIE ------------------------------------------------------------------- */
 static const unsigned int pcie0_clkreq_n_pins[] = {
@@ -2109,6 +2117,7 @@ static const unsigned int pcie0_clkreq_n_mux[] = {
 	PCIE0_CLKREQ_N_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - PWM0 --------------------------------------------------------------------- */
 static const unsigned int pwm0_a_pins[] = {
 	/* PWM0_A */
@@ -2209,6 +2218,7 @@ static const unsigned int pwm4_pins[] = {
 static const unsigned int pwm4_mux[] = {
 	PWM4_MARK,
 };
+#endif
 
 /* - QSPI0 ------------------------------------------------------------------ */
 static const unsigned int qspi0_ctrl_pins[] = {
@@ -2399,6 +2409,7 @@ static const unsigned int scif_clk2_mux[] = {
 	SCIF_CLK2_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SSI ------------------------------------------------- */
 static const unsigned int ssi_data_pins[] = {
 	/* SSI_SD */
@@ -2414,6 +2425,7 @@ static const unsigned int ssi_ctrl_pins[] = {
 static const unsigned int ssi_ctrl_mux[] = {
 	SSI_SCK_MARK, SSI_WS_MARK,
 };
+#endif
 
 /* - TPU --------------------------------------------------------------------- */
 static const unsigned int tpu_to0_a_pins[] = {
@@ -2475,8 +2487,10 @@ static const unsigned int tpu_to3_b_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(audio_clkin),
 	SH_PFC_PIN_GROUP(audio_clkout),
+#endif
 
 	SH_PFC_PIN_GROUP(avb0_link),
 	SH_PFC_PIN_GROUP(avb0_magic),
@@ -2510,11 +2524,13 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb2_avtp_capture),
 	SH_PFC_PIN_GROUP(avb2_avtp_match),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(canfd0_data),
 	SH_PFC_PIN_GROUP(canfd1_data),
 	SH_PFC_PIN_GROUP(canfd2_data),
 	SH_PFC_PIN_GROUP(canfd3_data),
 	SH_PFC_PIN_GROUP(can_clk),
+#endif
 
 	SH_PFC_PIN_GROUP(hscif0_data),
 	SH_PFC_PIN_GROUP(hscif0_clk),
@@ -2540,6 +2556,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c2),
 	SH_PFC_PIN_GROUP(i2c3),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(intc_ex_irq0_a),
 	SH_PFC_PIN_GROUP(intc_ex_irq0_b),
 	SH_PFC_PIN_GROUP(intc_ex_irq1_a),
@@ -2551,6 +2568,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(intc_ex_irq4_a),
 	SH_PFC_PIN_GROUP(intc_ex_irq4_b),
 	SH_PFC_PIN_GROUP(intc_ex_irq5),
+#endif
 
 	BUS_DATA_PIN_GROUP(mmc_data, 1),
 	BUS_DATA_PIN_GROUP(mmc_data, 4),
@@ -2560,6 +2578,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(mmc_wp),
 	SH_PFC_PIN_GROUP(mmc_ds),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(msiof0_clk),
 	SH_PFC_PIN_GROUP(msiof0_sync),
 	SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -2601,9 +2620,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof5_ss2),
 	SH_PFC_PIN_GROUP(msiof5_txd),
 	SH_PFC_PIN_GROUP(msiof5_rxd),
+#endif
 
 	SH_PFC_PIN_GROUP(pcie0_clkreq_n),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(pwm0_a),
 	SH_PFC_PIN_GROUP(pwm0_b),
 	SH_PFC_PIN_GROUP(pwm1_a),
@@ -2616,6 +2637,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(pwm3_b),
 	SH_PFC_PIN_GROUP(pwm3_c),
 	SH_PFC_PIN_GROUP(pwm4),
+#endif
 
 	SH_PFC_PIN_GROUP(qspi0_ctrl),
 	BUS_DATA_PIN_GROUP(qspi0_data, 2),
@@ -2645,8 +2667,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif_clk),
 	SH_PFC_PIN_GROUP(scif_clk2),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(ssi_data),
 	SH_PFC_PIN_GROUP(ssi_ctrl),
+#endif
 
 	SH_PFC_PIN_GROUP(tpu_to0_a),
 	SH_PFC_PIN_GROUP(tpu_to0_b),
@@ -2658,10 +2682,12 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(tpu_to3_b),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const audio_clk_groups[] = {
 	"audio_clkin",
 	"audio_clkout",
 };
+#endif
 
 static const char * const avb0_groups[] = {
 	"avb0_link",
@@ -2701,6 +2727,7 @@ static const char * const avb2_groups[] = {
 	"avb2_avtp_match",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const canfd0_groups[] = {
 	"canfd0_data",
 };
@@ -2720,6 +2747,7 @@ static const char * const canfd3_groups[] = {
 static const char * const can_clk_groups[] = {
 	"can_clk",
 };
+#endif
 
 static const char * const hscif0_groups[] = {
 	"hscif0_data",
@@ -2767,6 +2795,7 @@ static const char * const i2c3_groups[] = {
 	"i2c3",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0_a",
 	"intc_ex_irq0_b",
@@ -2780,6 +2809,7 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4_b",
 	"intc_ex_irq5",
 };
+#endif
 
 static const char * const mmc_groups[] = {
 	"mmc_data1",
@@ -2791,6 +2821,7 @@ static const char * const mmc_groups[] = {
 	"mmc_ds",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -2844,11 +2875,13 @@ static const char * const msiof5_groups[] = {
 	"msiof5_txd",
 	"msiof5_rxd",
 };
+#endif
 
 static const char * const pcie_groups[] = {
 	"pcie0_clkreq_n",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const pwm0_groups[] = {
 	"pwm0_a",
 	"pwm0_b",
@@ -2875,6 +2908,7 @@ static const char * const pwm3_groups[] = {
 static const char * const pwm4_groups[] = {
 	"pwm4",
 };
+#endif
 
 static const char * const qspi0_groups[] = {
 	"qspi0_ctrl",
@@ -2926,10 +2960,12 @@ static const char * const scif_clk2_groups[] = {
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
@@ -2943,17 +2979,21 @@ static const char * const tpu_groups[] = {
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
 	SH_PFC_FUNCTION(canfd3),
 	SH_PFC_FUNCTION(can_clk),
+#endif
 
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
@@ -2965,24 +3005,30 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
 
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
 	SH_PFC_FUNCTION(pwm3),
 	SH_PFC_FUNCTION(pwm4),
+#endif
 
 	SH_PFC_FUNCTION(qspi0),
 	SH_PFC_FUNCTION(qspi1),
@@ -2994,7 +3040,9 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(scif_clk2),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(ssi),
+#endif
 
 	SH_PFC_FUNCTION(tpu),
 };
-- 
2.45.2

