Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69574E7718D
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F5880636;
	Sat, 21 Dec 2024 22:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AQAAGUXk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lcbadbAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C429A805C8; Sat, 21 Dec 2024 22:35:17 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E019805C3
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YFyHl2lJgz9shX;
 Sat, 21 Dec 2024 22:35:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/IgXF6Y4JxtCzO3s37Ax3rnXDlk2ewcPQPexCJKgVsw=;
 b=AQAAGUXkZsaTSG51Hm0LobPkYAaj7+xE3Ebw50Fjs6ZIvupCXotXaXhOUY1xbzoIcdZ0oo
 Gpuwajy07SP7FCQ4CtRnnEgQicsObUd+Q62X2s/lvilP1vRQuxSiYKU/zLi4w0lWkQRYUl
 gufdBjTg53euqMBSfWKbcfs104hWoBC9dcb8TI/EETQF+W5eQQTrpabjzoK/QrlYc6nM3c
 cAIm5lchdDZojZtCKjK9nOABzwrRsELm3+99PBu9R5orRoFWJtDhy03TNj6zz07g48BeuM
 o5/Ay4HESQadBp8GkjRtAbX8JDRXu8xjRK3HPpeuGzVDJnZi9ZfopykWAq08rw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/IgXF6Y4JxtCzO3s37Ax3rnXDlk2ewcPQPexCJKgVsw=;
 b=lcbadbAP1kvgY0qNsz0+pQfyGlEgePt2t2NnlLpMHcmVlSgdHAus+KQnhrk6nzOJ0gOLQm
 20bHRkhNcco/gejqxKTeYbmzvDM/yiDHl84iVxeawUT6Xu1t5sQlaeaModdUSufFvr5Kxj
 CcwcRdJVWZw3Yk+6aEF3xFiEeU6Xuc3mbPXbVg/Prj91Y/9rBSiNMiEyX+Z6YW0OSLnvDx
 BIQHaq12WKrBnb2kgnLLjq1WH+r8Qq5aEqosiPShLosqryhCQsiTfXuJPEWF6NdW3uKaGJ
 UHriX3jF4RYCczxszSskbfUfRzZIlWgTVKwchWZYTrg4pJuGeZJSpHdAb1noMQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/16] pinctrl: renesas: Minimize R8A7794 E2 PFC tables
Date: Sat, 21 Dec 2024 22:34:04 +0100
Message-ID: <20241221213443.115024-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kcbn8ruq3kmcg7xcd6fsh78qf6x5o5kf
X-MBO-RS-ID: f7c5309a576ea3efaa1
X-Rspamd-Queue-Id: 4YFyHl2lJgz9shX
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
- CAN
- DU
- INTC
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
 drivers/pinctrl/renesas/pfc-r8a7794.c | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7794.c b/drivers/pinctrl/renesas/pfc-r8a7794.c
index 2f550218182..a1fa1776bae 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7794.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7794.c
@@ -1500,6 +1500,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_NOGP_ALL(),
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - Audio Clock ------------------------------------------------------------ */
 static const unsigned int audio_clka_pins[] = {
 	/* CLKA */
@@ -1592,6 +1593,8 @@ static const unsigned int audio_clkout_c_pins[] = {
 static const unsigned int audio_clkout_c_mux[] = {
 	AUDIO_CLKOUT_C_MARK,
 };
+#endif
+
 /* - AVB -------------------------------------------------------------------- */
 static const unsigned int avb_link_pins[] = {
 	RCAR_GP_PIN(3, 26),
@@ -1668,6 +1671,7 @@ static const unsigned int avb_gmii_mux[] = {
 	AVB_COL_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - CAN -------------------------------------------------------------------- */
 static const unsigned int can0_data_pins[] = {
 	/* TX, RX */
@@ -1950,6 +1954,8 @@ static const unsigned int du1_disp_pins[] = {
 static const unsigned int du1_disp_mux[] = {
 	DU1_DISP_MARK
 };
+#endif
+
 /* - ETH -------------------------------------------------------------------- */
 static const unsigned int eth_link_pins[] = {
 	/* LINK */
@@ -2316,6 +2322,8 @@ static const unsigned int i2c5_d_pins[] = {
 static const unsigned int i2c5_d_mux[] = {
 	I2C5_SCL_D_MARK, I2C5_SDA_D_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC ------------------------------------------------------------------- */
 static const unsigned int intc_irq0_pins[] = {
 	/* IRQ0 */
@@ -2387,6 +2395,8 @@ static const unsigned int intc_irq9_pins[] = {
 static const unsigned int intc_irq9_mux[] = {
 	IRQ9_MARK,
 };
+#endif
+
 /* - MMCIF ------------------------------------------------------------------ */
 static const unsigned int mmc_data_pins[] = {
 	/* D[0:7] */
@@ -2406,6 +2416,8 @@ static const unsigned int mmc_ctrl_pins[] = {
 static const unsigned int mmc_ctrl_mux[] = {
 	MMC_CLK_MARK, MMC_CMD_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -2722,6 +2734,8 @@ static const unsigned int pwm6_b_pins[] = {
 static const unsigned int pwm6_b_mux[] = {
 	PWM6_B_MARK,
 };
+#endif
+
 /* - QSPI ------------------------------------------------------------------- */
 static const unsigned int qspi_ctrl_pins[] = {
 	/* SPCLK, SSL */
@@ -3299,6 +3313,8 @@ static const unsigned int sdhi2_wp_pins[] = {
 static const unsigned int sdhi2_wp_mux[] = {
 	SD2_WP_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SSI -------------------------------------------------------------------- */
 static const unsigned int ssi0_data_pins[] = {
 	/* SDATA0 */
@@ -3538,6 +3554,8 @@ static const unsigned int ssi9_ctrl_b_pins[] = {
 static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
+#endif
+
 /* - TPU -------------------------------------------------------------------- */
 static const unsigned int tpu_to0_pins[] = {
 	RCAR_GP_PIN(3, 31),
@@ -3629,6 +3647,8 @@ static const unsigned int usb1_mux[] = {
 	USB1_PWEN_MARK,
 	USB1_OVC_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - VIN0 ------------------------------------------------------------------- */
 static const unsigned int vin0_data_pins[] = {
 	/* B */
@@ -3761,8 +3781,10 @@ static const unsigned int vin1_clk_pins[] = {
 static const unsigned int vin1_clk_mux[] = {
 	VI1_CLK_MARK,
 };
+#endif
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(audio_clka),
 	SH_PFC_PIN_GROUP(audio_clka_b),
 	SH_PFC_PIN_GROUP(audio_clka_c),
@@ -3776,12 +3798,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(audio_clkout),
 	SH_PFC_PIN_GROUP(audio_clkout_b),
 	SH_PFC_PIN_GROUP(audio_clkout_c),
+#endif
 	SH_PFC_PIN_GROUP(avb_link),
 	SH_PFC_PIN_GROUP(avb_magic),
 	SH_PFC_PIN_GROUP(avb_phy_int),
 	SH_PFC_PIN_GROUP(avb_mdio),
 	SH_PFC_PIN_GROUP(avb_mii),
 	SH_PFC_PIN_GROUP(avb_gmii),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(can0_data),
 	SH_PFC_PIN_GROUP(can0_data_b),
 	SH_PFC_PIN_GROUP(can0_data_c),
@@ -3812,6 +3836,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du1_oddf),
 	SH_PFC_PIN_GROUP(du1_cde),
 	SH_PFC_PIN_GROUP(du1_disp),
+#endif
 	SH_PFC_PIN_GROUP(eth_link),
 	SH_PFC_PIN_GROUP(eth_magic),
 	SH_PFC_PIN_GROUP(eth_mdio),
@@ -3862,6 +3887,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c5_b),
 	SH_PFC_PIN_GROUP(i2c5_c),
 	SH_PFC_PIN_GROUP(i2c5_d),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(intc_irq0),
 	SH_PFC_PIN_GROUP(intc_irq1),
 	SH_PFC_PIN_GROUP(intc_irq2),
@@ -3872,10 +3898,12 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(intc_irq7),
 	SH_PFC_PIN_GROUP(intc_irq8),
 	SH_PFC_PIN_GROUP(intc_irq9),
+#endif
 	BUS_DATA_PIN_GROUP(mmc_data, 1),
 	BUS_DATA_PIN_GROUP(mmc_data, 4),
 	BUS_DATA_PIN_GROUP(mmc_data, 8),
 	SH_PFC_PIN_GROUP(mmc_ctrl),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(msiof0_clk),
 	SH_PFC_PIN_GROUP(msiof0_sync),
 	SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -3923,6 +3951,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(pwm5_c),
 	SH_PFC_PIN_GROUP(pwm6),
 	SH_PFC_PIN_GROUP(pwm6_b),
+#endif
 	SH_PFC_PIN_GROUP(qspi_ctrl),
 	BUS_DATA_PIN_GROUP(qspi_data, 2),
 	BUS_DATA_PIN_GROUP(qspi_data, 4),
@@ -4006,6 +4035,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi2_ctrl),
 	SH_PFC_PIN_GROUP(sdhi2_cd),
 	SH_PFC_PIN_GROUP(sdhi2_wp),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(ssi0_data),
 	SH_PFC_PIN_GROUP(ssi0129_ctrl),
 	SH_PFC_PIN_GROUP(ssi1_data),
@@ -4040,6 +4070,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(ssi9_ctrl),
 	SH_PFC_PIN_GROUP(ssi9_data_b),
 	SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+#endif
 	SH_PFC_PIN_GROUP(tpu_to0),
 	SH_PFC_PIN_GROUP(tpu_to0_b),
 	SH_PFC_PIN_GROUP(tpu_to0_c),
@@ -4054,6 +4085,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(tpu_to3_c),
 	SH_PFC_PIN_GROUP(usb0),
 	SH_PFC_PIN_GROUP(usb1),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	BUS_DATA_PIN_GROUP(vin0_data, 24),
 	BUS_DATA_PIN_GROUP(vin0_data, 20),
 	SH_PFC_PIN_GROUP(vin0_data18),
@@ -4072,8 +4104,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin1_field),
 	SH_PFC_PIN_GROUP(vin1_clkenb),
 	SH_PFC_PIN_GROUP(vin1_clk),
+#endif
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const audio_clk_groups[] = {
 	"audio_clka",
 	"audio_clka_b",
@@ -4089,6 +4123,7 @@ static const char * const audio_clk_groups[] = {
 	"audio_clkout_b",
 	"audio_clkout_c",
 };
+#endif
 
 static const char * const avb_groups[] = {
 	"avb_link",
@@ -4099,6 +4134,7 @@ static const char * const avb_groups[] = {
 	"avb_gmii",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const can0_groups[] = {
 	"can0_data",
 	"can0_data_b",
@@ -4163,6 +4199,7 @@ static const char * const du1_groups[] = {
 	"du1_cde",
 	"du1_disp",
 };
+#endif
 
 static const char * const eth_groups[] = {
 	"eth_link",
@@ -4244,6 +4281,7 @@ static const char * const i2c5_groups[] = {
 	"i2c5_d",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_groups[] = {
 	"intc_irq0",
 	"intc_irq1",
@@ -4256,6 +4294,7 @@ static const char * const intc_groups[] = {
 	"intc_irq8",
 	"intc_irq9",
 };
+#endif
 
 static const char * const mmc_groups[] = {
 	"mmc_data1",
@@ -4264,6 +4303,7 @@ static const char * const mmc_groups[] = {
 	"mmc_ctrl",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -4340,6 +4380,7 @@ static const char * const pwm6_groups[] = {
 	"pwm6",
 	"pwm6_b",
 };
+#endif
 
 static const char * const qspi_groups[] = {
 	"qspi_ctrl",
@@ -4484,6 +4525,7 @@ static const char * const sdhi2_groups[] = {
 	"sdhi2_wp",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const ssi_groups[] = {
 	"ssi0_data",
 	"ssi0129_ctrl",
@@ -4520,6 +4562,7 @@ static const char * const ssi_groups[] = {
 	"ssi9_data_b",
 	"ssi9_ctrl_b",
 };
+#endif
 
 static const char * const tpu_groups[] = {
 	"tpu_to0",
@@ -4544,6 +4587,7 @@ static const char * const usb1_groups[] = {
 	"usb1",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const vin0_groups[] = {
 	"vin0_data24",
 	"vin0_data20",
@@ -4567,15 +4611,20 @@ static const char * const vin1_groups[] = {
 	"vin1_clkenb",
 	"vin1_clk",
 };
+#endif
 
 static const struct sh_pfc_function pinmux_functions[] = {
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(audio_clk),
+#endif
 	SH_PFC_FUNCTION(avb),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(can0),
 	SH_PFC_FUNCTION(can1),
 	SH_PFC_FUNCTION(can_clk),
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
+#endif
 	SH_PFC_FUNCTION(eth),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
@@ -4586,8 +4635,11 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(i2c4),
 	SH_PFC_FUNCTION(i2c5),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(intc),
+#endif
 	SH_PFC_FUNCTION(mmc),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
@@ -4598,6 +4650,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(pwm4),
 	SH_PFC_FUNCTION(pwm5),
 	SH_PFC_FUNCTION(pwm6),
+#endif
 	SH_PFC_FUNCTION(qspi),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
@@ -4618,12 +4671,16 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(ssi),
+#endif
 	SH_PFC_FUNCTION(tpu),
 	SH_PFC_FUNCTION(usb0),
 	SH_PFC_FUNCTION(usb1),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_FUNCTION(vin0),
 	SH_PFC_FUNCTION(vin1),
+#endif
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.45.2

