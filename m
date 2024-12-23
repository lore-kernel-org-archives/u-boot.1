Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D36E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A488180763;
	Mon, 23 Dec 2024 14:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DAmSRA7L";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Uqpe5PbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30038073F; Mon, 23 Dec 2024 14:35:32 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DA6806FB
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YGzYF62P8z9sW5;
 Mon, 23 Dec 2024 14:35:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5zXE4kRDqeqmd1LChQgWLnN8iSN+oEBRuj0oATjf3w=;
 b=DAmSRA7Lt5jEL3IH0nhuRdk0YDfD1AHfGhnivC+8bNSxc9JQaIvPvAa/+wMibfIeJJtqOZ
 Ru5mNym/GEA6FsZmN/5ntnAUxwec9u50aZuWE0xJQOLckALtuPoNN5wUye4lWyM65JV3W1
 h4sVv9LUIJfccQOkX/J7Xr373x581nJOcQ2Zvw1+pROr3Jg5D24bkIIEOXqoq3wODWGqVP
 Jay28YCLLqwmHaQ3iUhVf6P0dreVYDCrTuHhJ8bFNVG13gKQojTp8pzU1b6VjAGL/buC7S
 3nI/TYCCdH+r1puz4QxFU2IDs+wNv94LLH3Qb7hQ00P3bcup9WmqTqWObETkCg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5zXE4kRDqeqmd1LChQgWLnN8iSN+oEBRuj0oATjf3w=;
 b=Uqpe5PbUjH9Hced5IJAlYCxK2F0p6x2Ouq+GLsNvc4ATMjpjE26+oUDPM/AQhHt2kHuQQt
 pQJ0xdfhrQHVO03oEASPKPiQpjFhWFOAc+blSl+ZDtc2UmRkdYpsZ+SdKnqohRAVn6QpDE
 lhClDTQawuPcHC44WswFkrt6onrb0pve6b948q+VSBOTbocR1Go3M/GJ8TlpoYhnsl2iwc
 3ldsn7rQyyvrKBjG3B0EZfqR3W1JgQEhOl3u4F0mFCF2SGvLQYjh4wt0aSG5IHSXRISA1H
 D+mvRM8pYYuK7INP/WHqWUsbjWDB2354vrnqWQCi6/NUuo89bAFAybMT3mADqQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/16] pinctrl: renesas: Minimize R8A7792 V2H PFC tables
Date: Mon, 23 Dec 2024 14:34:08 +0100
Message-ID: <20241223133459.15748-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
References: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: w4jikdghioyg1qyeig8zhj47y76fdgk5
X-MBO-RS-ID: 7f541f47f13d2d508fa
X-Rspamd-Queue-Id: 4YGzYF62P8z9sW5
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
V2: No change
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

