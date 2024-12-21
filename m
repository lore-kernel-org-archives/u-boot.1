Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF2FE7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BBD780658;
	Sat, 21 Dec 2024 22:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iSXDblP2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yqZPqNfB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0104180642; Sat, 21 Dec 2024 22:35:25 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 866DC805DF
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YFyHt1X5nz9ssZ;
 Sat, 21 Dec 2024 22:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KUttSQjdYj0YI3Vxy+5dkCq7JCkYWW8ax8RpCb13tPg=;
 b=iSXDblP2aFzFx1fOkbAEAgl/bm2W8oY67TfOwRRjUUM4xVyNO6vJdI4cCzqBJP+IO3bBF0
 GwdxgKYKutEW9v5ce/+RMS3kMOgHj5cbnL0Ev3StsWKzjPF1CuG/w00pCXrz8lpQ8eBNnT
 6D1m+G6ntVf36ZCnXhKyGqDfZywXkTHYsj19txN88ercxanio6Jh1iMOQMWjw4icyU4LSP
 W6oKrMRNzsFkntkBhqKf+6xOyGW9H82Bbg2QRZIy/3LN6p0s880M2SD7IFA7zM0yfES/2a
 asOr6aQiwHqXdScHfncBoA+/2m8Z2MuU65TwbR7smbivtXDaK47hf+PGYtnBOg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KUttSQjdYj0YI3Vxy+5dkCq7JCkYWW8ax8RpCb13tPg=;
 b=yqZPqNfBU1Hiqpo2c/SJgo48q6Ky052pR4Kj/z97k5zJLZMamoWHu0tShZ9vaWegROsxtg
 eB/u6UoQzh6JnWoF473p41C/vIg2ccZzVkyPPTfqEm+Kb36hRC02YX9ktr06+LxmFNEOvF
 DPC51RfIZwc/lroqxbsayk4RzXLzLoQbpHk9vQ5IcxirrqRcXHJE2QFbP1QJjn5J339NmL
 FjaJ9vImJbUb3scbsOCBtVdoH4hOQKSsDHbus9eGREGPht2IZA/KthJx/d86h6USL03ImM
 1ysPTGMGfqnEuNvXnrL3gLiiK9hYo263ipPQeAArmDOtRiY9AaOUyCQw8l33HA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/16] pinctrl: renesas: Minimize R8A779A0 V3U PFC tables
Date: Sat, 21 Dec 2024 22:34:12 +0100
Message-ID: <20241221213443.115024-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9f3c1266b255b9b3aed
X-MBO-RS-META: j1xyzpps8ot5cs4gdd6ftaozg74qzpe8
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

- CAN/CANFD
- DU
- INTC-EX
- MSIOF
- PWM

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc-r8a779a0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779a0.c b/drivers/pinctrl/renesas/pfc-r8a779a0.c
index 6f898385027..39690bd5d07 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779a0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779a0.c
@@ -1697,6 +1697,7 @@ static const unsigned int avb5_avtp_match_mux[] = {
 	AVB5_AVTP_MATCH_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CANFD0 ----------------------------------------------------------------- */
 static const unsigned int canfd0_data_pins[] = {
 	/* CANFD0_TX, CANFD0_RX */
@@ -1817,6 +1818,7 @@ static const unsigned int du_oddf_pins[] = {
 static const unsigned int du_oddf_mux[] = {
 	DU_ODDF_DISP_CDE_MARK,
 };
+#endif
 
 /* - HSCIF0 ----------------------------------------------------------------- */
 static const unsigned int hscif0_data_pins[] = {
@@ -1973,6 +1975,7 @@ static const unsigned int i2c6_mux[] = {
 	SDA6_MARK, SCL6_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_pins[] = {
 	/* IRQ0 */
@@ -2016,6 +2019,7 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
+#endif
 
 /* - MMC -------------------------------------------------------------------- */
 static const unsigned int mmc_data_pins[] = {
@@ -2060,6 +2064,7 @@ static const unsigned int mmc_ds_mux[] = {
 	MMC_DS_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* MSIOF0_SCK */
@@ -2368,6 +2373,7 @@ static const unsigned int pwm4_pins[] = {
 static const unsigned int pwm4_mux[] = {
 	PWM4_MARK,
 };
+#endif
 
 /* - QSPI0 ------------------------------------------------------------------ */
 static const unsigned int qspi0_ctrl_pins[] = {
@@ -2651,6 +2657,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb5_avtp_capture),
 	SH_PFC_PIN_GROUP(avb5_avtp_match),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(canfd0_data),
 	SH_PFC_PIN_GROUP(canfd1_data),
 	SH_PFC_PIN_GROUP(canfd2_data),
@@ -2665,6 +2672,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du_clk_out),
 	SH_PFC_PIN_GROUP(du_sync),
 	SH_PFC_PIN_GROUP(du_oddf),
+#endif
 
 	SH_PFC_PIN_GROUP(hscif0_data),
 	SH_PFC_PIN_GROUP(hscif0_clk),
@@ -2687,12 +2695,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c5),
 	SH_PFC_PIN_GROUP(i2c6),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(intc_ex_irq0),
 	SH_PFC_PIN_GROUP(intc_ex_irq1),
 	SH_PFC_PIN_GROUP(intc_ex_irq2),
 	SH_PFC_PIN_GROUP(intc_ex_irq3),
 	SH_PFC_PIN_GROUP(intc_ex_irq4),
 	SH_PFC_PIN_GROUP(intc_ex_irq5),
+#endif
 
 	BUS_DATA_PIN_GROUP(mmc_data, 1),
 	BUS_DATA_PIN_GROUP(mmc_data, 4),
@@ -2702,6 +2712,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(mmc_wp),
 	SH_PFC_PIN_GROUP(mmc_ds),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(msiof0_clk),
 	SH_PFC_PIN_GROUP(msiof0_sync),
 	SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -2744,6 +2755,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(pwm2),
 	SH_PFC_PIN_GROUP(pwm3),
 	SH_PFC_PIN_GROUP(pwm4),
+#endif
 
 	SH_PFC_PIN_GROUP(qspi0_ctrl),
 	BUS_DATA_PIN_GROUP(qspi0_data, 2),
@@ -2852,6 +2864,7 @@ static const char * const avb5_groups[] = {
 	"avb5_avtp_match",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const canfd0_groups[] = {
 	"canfd0_data",
 };
@@ -2894,6 +2907,7 @@ static const char * const du_groups[] = {
 	"du_sync",
 	"du_oddf",
 };
+#endif
 
 static const char * const hscif0_groups[] = {
 	"hscif0_data",
@@ -2947,6 +2961,7 @@ static const char * const i2c6_groups[] = {
 	"i2c6",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0",
 	"intc_ex_irq1",
@@ -2955,6 +2970,7 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
+#endif
 
 static const char * const mmc_groups[] = {
 	"mmc_data1",
@@ -2966,6 +2982,7 @@ static const char * const mmc_groups[] = {
 	"mmc_ds",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -3039,6 +3056,7 @@ static const char * const pwm3_groups[] = {
 static const char * const pwm4_groups[] = {
 	"pwm4",
 };
+#endif
 
 static const char * const qspi0_groups[] = {
 	"qspi0_ctrl",
@@ -3105,6 +3123,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb4),
 	SH_PFC_FUNCTION(avb5),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(canfd0),
 	SH_PFC_FUNCTION(canfd1),
 	SH_PFC_FUNCTION(canfd2),
@@ -3116,6 +3135,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(can_clk),
 
 	SH_PFC_FUNCTION(du),
+#endif
 
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
@@ -3130,10 +3150,13 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c5),
 	SH_PFC_FUNCTION(i2c6),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(intc_ex),
+#endif
 
 	SH_PFC_FUNCTION(mmc),
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
@@ -3146,6 +3169,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(pwm2),
 	SH_PFC_FUNCTION(pwm3),
 	SH_PFC_FUNCTION(pwm4),
+#endif
 
 	SH_PFC_FUNCTION(qspi0),
 	SH_PFC_FUNCTION(qspi1),
-- 
2.45.2

