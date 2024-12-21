Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A4BE7718D
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B3080562;
	Sat, 21 Dec 2024 22:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="inBVQoHs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eKUlrq5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F821805C3; Sat, 21 Dec 2024 22:35:24 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6BA8803A9
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YFyHs2l2Bz9spq;
 Sat, 21 Dec 2024 22:35:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLbh4hAZTiJ6OKxRlSN1ITBMTqKFBUzP1mLxA4/2iE4=;
 b=inBVQoHs6H+1qJzlcyejI4pIN475voQ6OHRgnw1+udxDw1nscsOdkynYRjmvw+5wPfHNSo
 CVuV7ZAgBvwq39OqI11CBNdeNNkt1D9Lxb8TFhkLtGkLc5S/W6YucePVQrUjgin7N+XNHf
 ZoL/SR/sPbWhbhTInr/C+mZzHTOXCb/uI7mUjK3ACPhcJnRkjGPEuG1IntypuU38XQdXby
 OJt3kaaEBMORZrp/ZIYiYNQOZB6rmN+P6bDBXaZlJDRr2WMgnQVdl8pDiSyVisNW6EHssi
 qNR2FLaIBQfT1Aivnz/yAbVZxFB6bEX3RN8CS+8WxNoZ9//bjBLD5pVyocAbkw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLbh4hAZTiJ6OKxRlSN1ITBMTqKFBUzP1mLxA4/2iE4=;
 b=eKUlrq5CD7ABC85x3dJr4HSekzZ/0o1NoHhUALaXvioig9aCBVsKFqtZXwG8y/vtIi8Nxc
 3h4klAIpfTcc9eRhfMAF97WAD0SeWSocWV1GkyHXI+QEIgEJlrc5wdMGrMNByXLcuMQu2X
 y/dik6O8zFiRc3+v/SY+n5mWurANw2uABA/eSOnM6rp5VinghXYngZ8SoONg1rprzSaKTU
 /XUYK9oE2ewiSp30oCNxxpl6w9SRvTOC//gRc8Kye8+tMuMyvvMwtgcu413OAElWdgeTM9
 Q2TBNNGHW6Kf2VM9RyJgpINCUfvoWeCMyspViT+ZWeF73hixI9m2Ic5WKJREhA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/16] pinctrl: renesas: Minimize R8A77995 D3 PFC tables
Date: Sat, 21 Dec 2024 22:34:11 +0100
Message-ID: <20241221213443.115024-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 51owbtprrd1mx8ufybimcdjkijhbodkx
X-MBO-RS-ID: e24faf87b4676846f64
X-Rspamd-Queue-Id: 4YFyHs2l2Bz9spq
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
 drivers/pinctrl/renesas/pfc-r8a77995.c | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77995.c b/drivers/pinctrl/renesas/pfc-r8a77995.c
index d3e2d842fa5..6fe2d743418 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77995.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77995.c
@@ -955,6 +955,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_NOGP_ALL(),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - AUDIO CLOCK ------------------------------------------------------------- */
 static const unsigned int audio_clk_a_pins[] = {
 	/* CLK A */
@@ -984,6 +985,7 @@ static const unsigned int audio_clkout1_pins[] = {
 static const unsigned int audio_clkout1_mux[] = {
 	AUDIO_CLKOUT1_MARK,
 };
+#endif
 
 /* - EtherAVB --------------------------------------------------------------- */
 static const unsigned int avb0_link_pins[] = {
@@ -1078,6 +1080,7 @@ static const unsigned int avb0_avtp_capture_b_mux[] = {
 	AVB0_AVTP_CAPTURE_B_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CAN ------------------------------------------------------------------ */
 static const unsigned int can0_data_a_pins[] = {
 	/* TX, RX */
@@ -1213,6 +1216,7 @@ static const unsigned int du_disp_pins[] = {
 static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
+#endif
 
 /* - I2C -------------------------------------------------------------------- */
 static const unsigned int i2c0_pins[] = {
@@ -1288,6 +1292,7 @@ static const unsigned int mmc_ctrl_mux[] = {
 	MMC_CLK_MARK, MMC_CMD_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -1682,6 +1687,7 @@ static const unsigned int pwm3_c_pins[] = {
 static const unsigned int pwm3_c_mux[] = {
 	PWM3_C_MARK,
 };
+#endif
 
 /* - QSPI0 ------------------------------------------------------------------ */
 static const unsigned int qspi0_ctrl_pins[] = {
@@ -1929,6 +1935,7 @@ static const unsigned int scif_clk_mux[] = {
 	SCIF_CLK_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SSI ---------------------------------------------------------------*/
 static const unsigned int ssi3_data_pins[] = {
 	/* SDATA */
@@ -1972,6 +1979,7 @@ static const unsigned int ssi4_data_b_pins[] = {
 static const unsigned int ssi4_data_b_mux[] = {
 	SSI_SDATA4_B_MARK,
 };
+#endif
 
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
@@ -1982,6 +1990,7 @@ static const unsigned int usb0_mux[] = {
 	USB0_PWEN_MARK, USB0_OVC_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN4 ------------------------------------------------------------------- */
 static const unsigned int vin4_data18_pins[] = {
 	RCAR_GP_PIN(2, 3), RCAR_GP_PIN(2, 4),
@@ -2061,12 +2070,15 @@ static const unsigned int vin4_clk_pins[] = {
 static const unsigned int vin4_clk_mux[] = {
 	VI4_CLK_MARK,
 };
+#endif
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(audio_clk_a),
 	SH_PFC_PIN_GROUP(audio_clk_b),
 	SH_PFC_PIN_GROUP(audio_clkout),
 	SH_PFC_PIN_GROUP(audio_clkout1),
+#endif
 	SH_PFC_PIN_GROUP(avb0_link),
 	SH_PFC_PIN_GROUP(avb0_magic),
 	SH_PFC_PIN_GROUP(avb0_phy_int),
@@ -2079,6 +2091,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb0_avtp_pps_b),
 	SH_PFC_PIN_GROUP(avb0_avtp_match_b),
 	SH_PFC_PIN_GROUP(avb0_avtp_capture_b),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(can0_data_a),
 	SH_PFC_PIN_GROUP(can0_data_b),
 	SH_PFC_PIN_GROUP(can1_data_a),
@@ -2094,6 +2107,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du_disp_cde),
 	SH_PFC_PIN_GROUP(du_cde),
 	SH_PFC_PIN_GROUP(du_disp),
+#endif
 	SH_PFC_PIN_GROUP(i2c0),
 	SH_PFC_PIN_GROUP(i2c1),
 	SH_PFC_PIN_GROUP(i2c2_a),
@@ -2105,6 +2119,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	BUS_DATA_PIN_GROUP(mmc_data, 4),
 	BUS_DATA_PIN_GROUP(mmc_data, 8),
 	SH_PFC_PIN_GROUP(mmc_ctrl),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(msiof0_clk),
 	SH_PFC_PIN_GROUP(msiof0_sync),
 	SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -2148,6 +2163,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(pwm3_a),
 	SH_PFC_PIN_GROUP(pwm3_b),
 	SH_PFC_PIN_GROUP(pwm3_c),
+#endif
 	SH_PFC_PIN_GROUP(qspi0_ctrl),
 	SH_PFC_PIN_GROUP_SUBSET(qspi0_data2, rpc_data, 0, 2),
 	SH_PFC_PIN_GROUP_SUBSET(qspi0_data4, rpc_data, 0, 4),
@@ -2185,13 +2201,16 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif5_data_b),
 	SH_PFC_PIN_GROUP(scif5_clk_b),
 	SH_PFC_PIN_GROUP(scif_clk),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(ssi3_data),
 	SH_PFC_PIN_GROUP(ssi34_ctrl),
 	SH_PFC_PIN_GROUP(ssi4_ctrl_a),
 	SH_PFC_PIN_GROUP(ssi4_data_a),
 	SH_PFC_PIN_GROUP(ssi4_ctrl_b),
 	SH_PFC_PIN_GROUP(ssi4_data_b),
+#endif
 	SH_PFC_PIN_GROUP(usb0),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	BUS_DATA_PIN_GROUP(vin4_data, 8),
 	BUS_DATA_PIN_GROUP(vin4_data, 10),
 	BUS_DATA_PIN_GROUP(vin4_data, 12),
@@ -2203,14 +2222,17 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin4_field),
 	SH_PFC_PIN_GROUP(vin4_clkenb),
 	SH_PFC_PIN_GROUP(vin4_clk),
+#endif
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const audio_clk_groups[] = {
 	"audio_clk_a",
 	"audio_clk_b",
 	"audio_clkout",
 	"audio_clkout1",
 };
+#endif
 
 static const char * const avb0_groups[] = {
 	"avb0_link",
@@ -2227,6 +2249,7 @@ static const char * const avb0_groups[] = {
 	"avb0_avtp_capture_b",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const can0_groups[] = {
 	"can0_data_a",
 	"can0_data_b",
@@ -2256,6 +2279,7 @@ static const char * const du_groups[] = {
 	"du_cde",
 	"du_disp",
 };
+#endif
 
 static const char * const i2c0_groups[] = {
 	"i2c0",
@@ -2285,6 +2309,7 @@ static const char * const mmc_groups[] = {
 	"mmc_ctrl",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -2351,6 +2376,7 @@ static const char * const pwm3_groups[] = {
 	"pwm3_b",
 	"pwm3_c",
 };
+#endif
 
 static const char * const qspi0_groups[] = {
 	"qspi0_ctrl",
@@ -2419,6 +2445,7 @@ static const char * const scif_clk_groups[] = {
 	"scif_clk",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const ssi_groups[] = {
 	"ssi3_data",
 	"ssi34_ctrl",
@@ -2427,11 +2454,13 @@ static const char * const ssi_groups[] = {
 	"ssi4_ctrl_b",
 	"ssi4_data_b",
 };
+#endif
 
 static const char * const usb0_groups[] = {
 	"usb0",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin4_groups[] = {
 	"vin4_data8",
 	"vin4_data10",
@@ -2445,22 +2474,28 @@ static const char * const vin4_groups[] = {
 	"vin4_clkenb",
 	"vin4_clk",
 };
+#endif
 
 static const struct sh_pfc_function pinmux_functions[] = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(audio_clk),
+#endif
 	SH_PFC_FUNCTION(avb0),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(can0),
 	SH_PFC_FUNCTION(can1),
 	SH_PFC_FUNCTION(can_clk),
 	SH_PFC_FUNCTION(canfd0),
 	SH_PFC_FUNCTION(canfd1),
 	SH_PFC_FUNCTION(du),
+#endif
 	SH_PFC_FUNCTION(i2c0),
 	SH_PFC_FUNCTION(i2c1),
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(mlb_3pin),
 	SH_PFC_FUNCTION(mmc),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
@@ -2469,6 +2504,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(pwm1),
 	SH_PFC_FUNCTION(pwm2),
 	SH_PFC_FUNCTION(pwm3),
+#endif
 	SH_PFC_FUNCTION(qspi0),
 	SH_PFC_FUNCTION(qspi1),
 	SH_PFC_FUNCTION(rpc),
@@ -2479,9 +2515,13 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif5),
 	SH_PFC_FUNCTION(scif_clk),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(ssi),
+#endif
 	SH_PFC_FUNCTION(usb0),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(vin4),
+#endif
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.45.2

