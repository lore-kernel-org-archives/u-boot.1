Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A4BE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86E6A80759;
	Mon, 23 Dec 2024 14:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DceS1xt8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G4VsCkn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194D68073D; Mon, 23 Dec 2024 14:35:38 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D165080740
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YGzYM428Vz9stT;
 Mon, 23 Dec 2024 14:35:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkx7cfPwq69mW0efrFwqRHnwevCGYSbEFWNwI9/7FHA=;
 b=DceS1xt8IHdhJXdQG42AbhQWs+83JjCYzLkhZQQDMwFE1zvFLZpxB48X9X/ouM1alhRQ6U
 nKbTes/XQKu+AyQWOWQ9kw/wrJo5fWxulLEteyh2B7TLu+dzcF/71x+lBo9lHqNsYKMBO3
 JEb3CaE+9FdMrayl8Q8yq/XnzVMWVUjJ01bdWTwuGAJyg6YVgphmW1T0Pwjt6bBKBtT+kA
 dYT7TeZbPwb5vVniH3C1jvesuUFLrAtR8Aooub4yuW5NkxoZqT2txzbrj/28QZw+E9a087
 Hah6h6q3YJuDU0sxz9LErcIS5hbwq6mtESTB7En6kfMvBR8M2OuVt05xqfWD1A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkx7cfPwq69mW0efrFwqRHnwevCGYSbEFWNwI9/7FHA=;
 b=G4VsCkn25zTP4GH1ntHxua6gkukBkdSZdBiMXC8U78lWxRfQ5hPQnIEMAEY9HPvvKE0IDO
 RPnhq8gLOHj5tGorp6tTBFz2m3me7wkVnXMPAHAd8ksVMceiYOJaWiTjjTAKeUjP8eCUDQ
 SG/HsDQoxViFpvdAjwRakqD8O4Ymo7K8bi8jwmRAW98vG+0Rddom3ORGTbs8ysoJf+uLHe
 tfT/nBNKqIP+z3JWyZTHvhPdw2M0rsv09Dw2lYOOpVqyWKcX+lhh6I59vEdM1XXaMofkvN
 J3azIawWZmocZJMqPHZcaG+7gkVaPsVBinHqRlumRfMz1R0zd2r7Laltjir6hA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/16] pinctrl: renesas: Minimize R8A77970 V3M PFC tables
Date: Mon, 23 Dec 2024 14:34:13 +0100
Message-ID: <20241223133459.15748-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
References: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: h758ufpoyxttd7x55c5p6duw5j8dktt6
X-MBO-RS-ID: 794720fe476bfd14911
X-Rspamd-Queue-Id: 4YGzYM428Vz9stT
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

- CANFD
- DU
- INTC-EX
- MSIOF
- PWM
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
 drivers/pinctrl/renesas/pfc-r8a77970.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77970.c b/drivers/pinctrl/renesas/pfc-r8a77970.c
index 00ebbbc7120..3a0a310c5fe 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77970.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77970.c
@@ -817,6 +817,7 @@ static const unsigned int avb0_avtp_match_mux[] = {
 	AVB0_AVTP_MATCH_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CANFD Clock ------------------------------------------------------------ */
 static const unsigned int canfd_clk_a_pins[] = {
 	/* CANFD_CLK */
@@ -911,6 +912,7 @@ static const unsigned int du_disp_pins[] = {
 static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
+#endif
 
 /* - HSCIF0 ----------------------------------------------------------------- */
 static const unsigned int hscif0_data_pins[] = {
@@ -1056,6 +1058,7 @@ static const unsigned int i2c4_mux[] = {
 	SDA4_MARK, SCL4_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_pins[] = {
 	/* IRQ0 */
@@ -1099,6 +1102,7 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
+#endif
 
 /* - MMC -------------------------------------------------------------------- */
 static const unsigned int mmc_data_pins[] = {
@@ -1122,6 +1126,7 @@ static const unsigned int mmc_ctrl_mux[] = {
 	MMC_CLK_MARK, MMC_CMD_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -1367,6 +1372,7 @@ static const unsigned int pwm4_b_pins[] = {
 static const unsigned int pwm4_b_mux[] = {
 	PWM4_B_MARK,
 };
+#endif
 
 /* - QSPI0 ------------------------------------------------------------------ */
 static const unsigned int qspi0_ctrl_pins[] = {
@@ -1583,6 +1589,7 @@ static const unsigned int tmu_tclk2_b_mux[] = {
 	TCLK2_B_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN0 ------------------------------------------------------------------- */
 static const unsigned int vin0_data_pins[] = {
 	RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 5),
@@ -1674,6 +1681,7 @@ static const unsigned int vin1_clk_mux[] = {
 	/* CLK */
 	VI1_CLK_MARK,
 };
+#endif
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb0_link),
@@ -1685,6 +1693,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb0_avtp_pps),
 	SH_PFC_PIN_GROUP(avb0_avtp_capture),
 	SH_PFC_PIN_GROUP(avb0_avtp_match),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(canfd_clk_a),
 	SH_PFC_PIN_GROUP(canfd_clk_b),
 	SH_PFC_PIN_GROUP(canfd0_data_a),
@@ -1696,6 +1705,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du_oddf),
 	SH_PFC_PIN_GROUP(du_cde),
 	SH_PFC_PIN_GROUP(du_disp),
+#endif
 	SH_PFC_PIN_GROUP(hscif0_data),
 	SH_PFC_PIN_GROUP(hscif0_clk),
 	SH_PFC_PIN_GROUP(hscif0_ctrl),
@@ -1714,16 +1724,19 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c3_a),
 	SH_PFC_PIN_GROUP(i2c3_b),
 	SH_PFC_PIN_GROUP(i2c4),
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
 	BUS_DATA_PIN_GROUP(mmc_data, 8),
 	SH_PFC_PIN_GROUP(mmc_ctrl),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(msiof0_clk),
 	SH_PFC_PIN_GROUP(msiof0_sync),
 	SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -1758,6 +1771,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(pwm3_b),
 	SH_PFC_PIN_GROUP(pwm4_a),
 	SH_PFC_PIN_GROUP(pwm4_b),
+#endif
 	SH_PFC_PIN_GROUP(qspi0_ctrl),
 	SH_PFC_PIN_GROUP_SUBSET(qspi0_data2, rpc_data, 0, 2),
 	SH_PFC_PIN_GROUP_SUBSET(qspi0_data4, rpc_data, 0, 4),
@@ -1790,6 +1804,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(tmu_tclk1_b),
 	SH_PFC_PIN_GROUP(tmu_tclk2_a),
 	SH_PFC_PIN_GROUP(tmu_tclk2_b),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	BUS_DATA_PIN_GROUP(vin0_data, 8),
 	BUS_DATA_PIN_GROUP(vin0_data, 10),
 	BUS_DATA_PIN_GROUP(vin0_data, 12),
@@ -1804,6 +1819,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin1_field),
 	SH_PFC_PIN_GROUP(vin1_clkenb),
 	SH_PFC_PIN_GROUP(vin1_clk),
+#endif
 };
 
 static const char * const avb0_groups[] = {
@@ -1818,6 +1834,7 @@ static const char * const avb0_groups[] = {
 	"avb0_avtp_match",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const canfd_clk_groups[] = {
 	"canfd_clk_a",
 	"canfd_clk_b",
@@ -1840,6 +1857,7 @@ static const char * const du_groups[] = {
 	"du_cde",
 	"du_disp",
 };
+#endif
 
 static const char * const hscif0_groups[] = {
 	"hscif0_data",
@@ -1886,6 +1904,7 @@ static const char * const i2c4_groups[] = {
 	"i2c4",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0",
 	"intc_ex_irq1",
@@ -1894,6 +1913,7 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
+#endif
 
 static const char * const mmc_groups[] = {
 	"mmc_data1",
@@ -1902,6 +1922,7 @@ static const char * const mmc_groups[] = {
 	"mmc_ctrl",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -1962,6 +1983,7 @@ static const char * const pwm4_groups[] = {
 	"pwm4_a",
 	"pwm4_b",
 };
+#endif
 
 static const char * const qspi0_groups[] = {
 	"qspi0_ctrl",
@@ -2022,6 +2044,7 @@ static const char * const tmu_groups[] = {
 	"tmu_tclk2_b",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin0_groups[] = {
 	"vin0_data8",
 	"vin0_data10",
@@ -2041,13 +2064,16 @@ static const char * const vin1_groups[] = {
 	"vin1_clkenb",
 	"vin1_clk",
 };
+#endif
 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb0),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(canfd_clk),
 	SH_PFC_FUNCTION(canfd0),
 	SH_PFC_FUNCTION(canfd1),
 	SH_PFC_FUNCTION(du),
+#endif
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
 	SH_PFC_FUNCTION(hscif2),
@@ -2057,8 +2083,11 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(i2c4),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(intc_ex),
+#endif
 	SH_PFC_FUNCTION(mmc),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
@@ -2068,6 +2097,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(pwm2),
 	SH_PFC_FUNCTION(pwm3),
 	SH_PFC_FUNCTION(pwm4),
+#endif
 	SH_PFC_FUNCTION(qspi0),
 	SH_PFC_FUNCTION(qspi1),
 	SH_PFC_FUNCTION(rpc),
@@ -2077,8 +2107,10 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif3),
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(tmu),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(vin0),
 	SH_PFC_FUNCTION(vin1),
+#endif
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.45.2

