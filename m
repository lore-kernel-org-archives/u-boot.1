Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382A3E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 697638060F;
	Sat, 21 Dec 2024 22:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LCMlOf/s";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="peMzMSCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9E60805C8; Sat, 21 Dec 2024 22:35:16 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 987C080516
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YFyHk2fc1z9t1B;
 Sat, 21 Dec 2024 22:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsbMC134c0XNFdpTeuKWfX9uqdWvdYeZWWrok1JjRL0=;
 b=LCMlOf/sjf24F1PmiE2EvAv9xXigeaSub6uiKy+xzqKnL7dWNsR6xiEd5InSiMfplH5PxX
 pdO7Brtu47rVvYJ1vWtd+bIp0pZWlA4p5IjfRM9z5EwndiOQwbHyLlo6gxjHhjkvxQI7fp
 HukaMK8bjx53EyP4vAFcFHkxSiz0q/c/FneVxN0uZMUq1L7MFhS7JZZjizSVXHoG6znwlN
 t1KwkI+0lQCnsaN1zhl6bLQI+SM8L7cAjypyfVbGrAYu4W6ulFpsWvw6NomzypzlGr5pe7
 tVJyyuyLlPKwqe3auVdHaRvlMA6E/l9HhQd8vanHpQhUDPadRLe9V4OxvIv1yA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsbMC134c0XNFdpTeuKWfX9uqdWvdYeZWWrok1JjRL0=;
 b=peMzMSCZBVPYTWQ6uPB/zQYuZgAaP+R5mTEEh3220L0LDQKIv1vJ+2SYBZwoUFDufuRfk/
 1LUlLGZVplnSdxlGXl8m4ggsFj55FQD7Sb6tz4t1t7whbNDhd1TuodPOKbV7swrUy6yxLJ
 4Syc8KLqsCo5o+uNW4khNB6owZ36eTwr7V0h8Ms/p7H7TEh6In222yOqqqFyvI3a6NssOD
 fs1ubIc9TTahU3PW3EUxGFxp75Yw3zyD0iZNIMNcgdHT7jY/dD9EL1bLLbou4bY+V5Kc2J
 FvhcmHtCb3I2I97hJNTiXS/we4bO37bWNJQVJJN5y7QbOzOk79PMX2iCQJA2PA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/16] pinctrl: renesas: Minimize R8A7792 V2H PFC tables
Date: Sat, 21 Dec 2024 22:34:03 +0100
Message-ID: <20241221213443.115024-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b97fcff7a96fe1e0d1c
X-MBO-RS-META: 35bnoxr4nnx6qz4c9q7khu8u5hkeu7rj
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

- CAN
- DU
- INTC
- MSIOF
- VIN

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc-r8a7792.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7792.c b/drivers/pinctrl/renesas/pfc-r8a7792.c
index 7c1e6d40749..d2ff1d9d1a6 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7792.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7792.c
@@ -831,6 +831,8 @@ static const unsigned int avb_avtp_match_pins[] = {
 static const unsigned int avb_avtp_match_mux[] = {
 	AVB_AVTP_MATCH_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CAN -------------------------------------------------------------------- */
 static const unsigned int can0_data_pins[] = {
 	/* TX, RX */
@@ -996,6 +998,8 @@ static const unsigned int intc_irq3_pins[] = {
 static const unsigned int intc_irq3_mux[] = {
 	IRQ3_MARK,
 };
+#endif
+
 /* - LBSC ------------------------------------------------------------------- */
 static const unsigned int lbsc_cs0_pins[] = {
 	/* CS0# */
@@ -1053,6 +1057,8 @@ static const unsigned int lbsc_ex_cs5_pins[] = {
 static const unsigned int lbsc_ex_cs5_mux[] = {
 	EX_CS5_N_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -1111,6 +1117,8 @@ static const unsigned int msiof1_tx_pins[] = {
 static const unsigned int msiof1_tx_mux[] = {
 	MSIOF1_TXD_MARK,
 };
+#endif
+
 /* - QSPI ------------------------------------------------------------------- */
 static const unsigned int qspi_ctrl_pins[] = {
 	/* SPCLK, SSL */
@@ -1231,6 +1239,8 @@ static const unsigned int sdhi0_wp_pins[] = {
 static const unsigned int sdhi0_wp_mux[] = {
 	SD0_WP_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN0 ------------------------------------------------------------------- */
 static const unsigned int vin0_data_pins[] = {
 	/* B */
@@ -1645,6 +1655,7 @@ static const unsigned int vin5_clk_pins[] = {
 static const unsigned int vin5_clk_mux[] = {
 	VI5_CLK_MARK,
 };
+#endif
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_link),
@@ -1654,6 +1665,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_mii),
 	SH_PFC_PIN_GROUP(avb_gmii),
 	SH_PFC_PIN_GROUP(avb_avtp_match),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(can0_data),
 	SH_PFC_PIN_GROUP(can1_data),
 	SH_PFC_PIN_GROUP(can_clk),
@@ -1672,6 +1684,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(intc_irq1),
 	SH_PFC_PIN_GROUP(intc_irq2),
 	SH_PFC_PIN_GROUP(intc_irq3),
+#endif
 	SH_PFC_PIN_GROUP(lbsc_cs0),
 	SH_PFC_PIN_GROUP(lbsc_cs1),
 	SH_PFC_PIN_GROUP(lbsc_ex_cs0),
@@ -1680,6 +1693,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(lbsc_ex_cs3),
 	SH_PFC_PIN_GROUP(lbsc_ex_cs4),
 	SH_PFC_PIN_GROUP(lbsc_ex_cs5),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(msiof0_clk),
 	SH_PFC_PIN_GROUP(msiof0_sync),
 	SH_PFC_PIN_GROUP(msiof0_rx),
@@ -1688,6 +1702,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof1_sync),
 	SH_PFC_PIN_GROUP(msiof1_rx),
 	SH_PFC_PIN_GROUP(msiof1_tx),
+#endif
 	SH_PFC_PIN_GROUP(qspi_ctrl),
 	BUS_DATA_PIN_GROUP(qspi_data, 2),
 	BUS_DATA_PIN_GROUP(qspi_data, 4),
@@ -1706,6 +1721,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi0_ctrl),
 	SH_PFC_PIN_GROUP(sdhi0_cd),
 	SH_PFC_PIN_GROUP(sdhi0_wp),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	BUS_DATA_PIN_GROUP(vin0_data, 24),
 	BUS_DATA_PIN_GROUP(vin0_data, 20),
 	SH_PFC_PIN_GROUP(vin0_data18),
@@ -1762,6 +1778,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin5_field),
 	SH_PFC_PIN_GROUP(vin5_clkenb),
 	SH_PFC_PIN_GROUP(vin5_clk),
+#endif
 };
 
 static const char * const avb_groups[] = {
@@ -1774,6 +1791,7 @@ static const char * const avb_groups[] = {
 	"avb_avtp_match",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const can0_groups[] = {
 	"can0_data",
 	"can_clk",
@@ -1807,6 +1825,7 @@ static const char * const intc_groups[] = {
 	"intc_irq2",
 	"intc_irq3",
 };
+#endif
 
 static const char * const lbsc_groups[] = {
 	"lbsc_cs0",
@@ -1819,6 +1838,7 @@ static const char * const lbsc_groups[] = {
 	"lbsc_ex_cs5",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -1832,6 +1852,7 @@ static const char * const msiof1_groups[] = {
 	"msiof1_rx",
 	"msiof1_tx",
 };
+#endif
 
 static const char * const qspi_groups[] = {
 	"qspi_ctrl",
@@ -1869,6 +1890,7 @@ static const char * const sdhi0_groups[] = {
 	"sdhi0_wp",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin0_groups[] = {
 	"vin0_data24",
 	"vin0_data20",
@@ -1942,29 +1964,36 @@ static const char * const vin5_groups[] = {
 	"vin5_clkenb",
 	"vin5_clk",
 };
+#endif
 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(can0),
 	SH_PFC_FUNCTION(can1),
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
 	SH_PFC_FUNCTION(intc),
+#endif
 	SH_PFC_FUNCTION(lbsc),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
+#endif
 	SH_PFC_FUNCTION(qspi),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
 	SH_PFC_FUNCTION(scif3),
 	SH_PFC_FUNCTION(sdhi0),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(vin0),
 	SH_PFC_FUNCTION(vin1),
 	SH_PFC_FUNCTION(vin2),
 	SH_PFC_FUNCTION(vin3),
 	SH_PFC_FUNCTION(vin4),
 	SH_PFC_FUNCTION(vin5),
+#endif
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.45.2

