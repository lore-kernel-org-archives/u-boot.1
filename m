Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D00FE7718D
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843CE805EC;
	Sat, 21 Dec 2024 22:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iwVZ27qL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XzJMM1BO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7122E805EB; Sat, 21 Dec 2024 22:35:23 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33E18062B
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YFyHq5Fk6z9spL;
 Sat, 21 Dec 2024 22:35:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrukjGpWrJGCAlRg3sIAUf5RoEa8I7n7dHYEcQtaAro=;
 b=iwVZ27qLDyhF0rzjnAjMoUZpVstsyX4+tNSkQBGwQiPNAq2+o+3eDScavWWRvSaZzDlA1w
 38kZOLAwdLeABi0MZs0rRE1in1GZQZwQzdR8nKW+QG3LEg3EegOVHfxTjGrBKo5YbDXeau
 B/IkjCcn9a8X6m3GU24Iswbo/oMPkXrt6VXjxihAyAr/RkkliL1BJ14OZgiDqZ/zP3sE+g
 8US80u8YQq+lxH3uA6vr6sgk62n/fdGK7FPFprb6rZpuS/X/bq9WDg5VSgE3SCmqMA6J+I
 QV76TPteArvfgFAa2h2wGYcgA7VJs7fisBQBCFisIKf9vVXUGt6T/n2eoip1ww==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrukjGpWrJGCAlRg3sIAUf5RoEa8I7n7dHYEcQtaAro=;
 b=XzJMM1BOVGQCrug40JTJNOZuOiRBwFjT0KgV1D+QhMDt+OUrdMxwQJC5GxqcaCXYpvx7bq
 ivxFoG2IXJj7IbUl3GSJwS303vPfVUpHg+Qd4ncO3tb8aaPXC31Kd5uwdu/IIOD2DENuiQ
 UvWqrswYMLFx1vT+4eAktnu1w/1+7WqVB51zemK1gqnXgDMdQqVHI+YiZC/p5TxSZubHEj
 O7D6pLocBY2goijCJ76Iuarljscjo1+CT/WRJKwGNqUiQN30K9tKAv1PrxD4TSANIdRoQZ
 Ddot683xOZwu6SjhuuUDzj0A2NGEkRq/h0smFcSwOBm5X/31wImz2TmDcdRjXg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/16] pinctrl: renesas: Minimize R8A77980 V3H PFC tables
Date: Sat, 21 Dec 2024 22:34:09 +0100
Message-ID: <20241221213443.115024-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 99te1b8dwtmbg4uuhc494wphry593b65
X-MBO-RS-ID: 829ee2be2b5c2fa052e
X-Rspamd-Queue-Id: 4YFyHq5Fk6z9spL
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
 drivers/pinctrl/renesas/pfc-r8a77980.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77980.c b/drivers/pinctrl/renesas/pfc-r8a77980.c
index e3fc4045741..59f4bdde202 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77980.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77980.c
@@ -929,6 +929,7 @@ static const unsigned int avb_avtp_match_mux[] = {
 	AVB_AVTP_MATCH_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CANFD0 ----------------------------------------------------------------- */
 static const unsigned int canfd0_data_a_pins[] = {
 	/* CANFD0_TX, CANFD0_RX */
@@ -1046,6 +1047,7 @@ static const unsigned int du_disp_pins[] = {
 static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
+#endif
 
 /* - GETHER ----------------------------------------------------------------- */
 static const unsigned int gether_link_a_pins[] = {
@@ -1319,6 +1321,7 @@ static const unsigned int i2c5_mux[] = {
 	SDA5_MARK, SCL5_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_pins[] = {
 	/* IRQ0 */
@@ -1362,6 +1365,7 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
+#endif
 
 /* - MMC -------------------------------------------------------------------- */
 static const unsigned int mmc_data_pins[] = {
@@ -1406,6 +1410,7 @@ static const unsigned int mmc_ds_mux[] = {
 	MMC_DS_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* MSIOF0_SCK */
@@ -1661,6 +1666,7 @@ static const unsigned int pwm4_b_pins[] = {
 static const unsigned int pwm4_b_mux[] = {
 	PWM4_B_MARK,
 };
+#endif
 
 /* - QSPI0 ------------------------------------------------------------------ */
 static const unsigned int qspi0_ctrl_pins[] = {
@@ -1907,6 +1913,7 @@ static const unsigned int tpu_to3_mux[] = {
 	TPU0TO3_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN0 ------------------------------------------------------------------- */
 static const unsigned int vin0_data_pins[] = {
 	RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 5),
@@ -2032,6 +2039,7 @@ static const unsigned int vin1_clk_pins[] = {
 static const unsigned int vin1_clk_mux[] = {
 	VI1_CLK_MARK,
 };
+#endif
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_link),
@@ -2043,6 +2051,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_avtp_pps),
 	SH_PFC_PIN_GROUP(avb_avtp_capture),
 	SH_PFC_PIN_GROUP(avb_avtp_match),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(canfd0_data_a),
 	SH_PFC_PIN_GROUP(canfd0_data_b),
 	SH_PFC_PIN_GROUP(canfd1_data),
@@ -2055,6 +2064,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du_oddf),
 	SH_PFC_PIN_GROUP(du_cde),
 	SH_PFC_PIN_GROUP(du_disp),
+#endif
 	SH_PFC_PIN_GROUP(gether_link_a),
 	SH_PFC_PIN_GROUP(gether_phy_int_a),
 	SH_PFC_PIN_GROUP(gether_mdio_a),
@@ -2087,12 +2097,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c3),
 	SH_PFC_PIN_GROUP(i2c4),
 	SH_PFC_PIN_GROUP(i2c5),
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
@@ -2100,6 +2112,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(mmc_cd),
 	SH_PFC_PIN_GROUP(mmc_wp),
 	SH_PFC_PIN_GROUP(mmc_ds),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(msiof0_clk),
 	SH_PFC_PIN_GROUP(msiof0_sync),
 	SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -2134,6 +2147,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(pwm3_b),
 	SH_PFC_PIN_GROUP(pwm4_a),
 	SH_PFC_PIN_GROUP(pwm4_b),
+#endif
 	SH_PFC_PIN_GROUP(qspi0_ctrl),
 	SH_PFC_PIN_GROUP_SUBSET(qspi0_data2, rpc_data, 0, 2),
 	SH_PFC_PIN_GROUP_SUBSET(qspi0_data4, rpc_data, 0, 4),
@@ -2170,6 +2184,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(tpu_to1),
 	SH_PFC_PIN_GROUP(tpu_to2),
 	SH_PFC_PIN_GROUP(tpu_to3),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	BUS_DATA_PIN_GROUP(vin0_data, 8),
 	BUS_DATA_PIN_GROUP(vin0_data, 10),
 	BUS_DATA_PIN_GROUP(vin0_data, 12),
@@ -2188,6 +2203,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin1_field),
 	SH_PFC_PIN_GROUP(vin1_clkenb),
 	SH_PFC_PIN_GROUP(vin1_clk),
+#endif
 };
 
 static const char * const avb_groups[] = {
@@ -2202,6 +2218,7 @@ static const char * const avb_groups[] = {
 	"avb_avtp_match",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const canfd0_groups[] = {
 	"canfd0_data_a",
 	"canfd0_data_b",
@@ -2225,6 +2242,7 @@ static const char * const du_groups[] = {
 	"du_cde",
 	"du_disp",
 };
+#endif
 
 static const char * const gether_groups[] = {
 	"gether_link_a",
@@ -2291,6 +2309,7 @@ static const char * const i2c5_groups[] = {
 	"i2c5",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0",
 	"intc_ex_irq1",
@@ -2299,6 +2318,7 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
+#endif
 
 static const char * const mmc_groups[] = {
 	"mmc_data1",
@@ -2310,6 +2330,7 @@ static const char * const mmc_groups[] = {
 	"mmc_ds",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -2370,6 +2391,7 @@ static const char * const pwm4_groups[] = {
 	"pwm4_a",
 	"pwm4_b",
 };
+#endif
 
 static const char * const qspi0_groups[] = {
 	"qspi0_ctrl",
@@ -2437,6 +2459,7 @@ static const char * const tpu_groups[] = {
 	"tpu_to3",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin0_groups[] = {
 	"vin0_data8",
 	"vin0_data10",
@@ -2460,13 +2483,16 @@ static const char * const vin1_groups[] = {
 	"vin1_clkenb",
 	"vin1_clk",
 };
+#endif
 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(canfd0),
 	SH_PFC_FUNCTION(canfd1),
 	SH_PFC_FUNCTION(canfd_clk),
 	SH_PFC_FUNCTION(du),
+#endif
 	SH_PFC_FUNCTION(gether),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
@@ -2478,8 +2504,11 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c3),
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
@@ -2489,6 +2518,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(pwm2),
 	SH_PFC_FUNCTION(pwm3),
 	SH_PFC_FUNCTION(pwm4),
+#endif
 	SH_PFC_FUNCTION(qspi0),
 	SH_PFC_FUNCTION(qspi1),
 	SH_PFC_FUNCTION(rpc),
@@ -2499,8 +2529,10 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(tmu),
 	SH_PFC_FUNCTION(tpu),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(vin0),
 	SH_PFC_FUNCTION(vin1),
+#endif
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.45.2

