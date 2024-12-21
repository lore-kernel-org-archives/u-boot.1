Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAD4E7718D
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF6F9806D8;
	Sat, 21 Dec 2024 22:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KWdinDES";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fEUvwPcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEEC8066C; Sat, 21 Dec 2024 22:35:25 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35EB8805E7
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YFyHv0DS8z9sd5;
 Sat, 21 Dec 2024 22:35:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dq6XSCw6zwdwLOdrRljIdZvdgOJNs0AYORziyzZEu4A=;
 b=KWdinDESOIi2LOEnTsaFRaVFKFBXK2PNcpTWN6shpP6B4apg4uL5FYaRpv88seLvsNXMeR
 d/dr0zb8Z7wzPZo/8cWBjD4hGn7rYODYQprxqFN0g/WG/bufISUWa9s7EhgcJO9tZrfy/J
 taAEdIsAEjMuq5HYFFmldK+0VVPMFA7y8Boljyq7JqhtehOR7PigjxLYXThnZRu3fwL6cC
 lS42Q96bTcRHOIgg56iVXetV/MOAHM1vnCCWL9JaDdZTnC0TioMYKpHzH48uZvyJ+tsuCh
 Zvclo4R21/2uFH3GDzm4sMrisiDqOyQT1pzxztZzXuD9P9CfCPkYB5I+Zgh1xA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dq6XSCw6zwdwLOdrRljIdZvdgOJNs0AYORziyzZEu4A=;
 b=fEUvwPcwFoWRDDLND3JjDAXlhP7UP++CDdf6beyqkrQKs1cF/mly5xyFhFW4tOenmUdvn3
 pnf8X/WGc4P8/gQaSgpWWZeSbCyi68XUyWGFgQfftPByU0hi4CulCnhryOFFhm2ZGK9RbS
 Nrc25t84vMFUDyBTyBqFC/XCurZnyKPoGV0tGu2D2oSymfTJZI7jX/P4ZrSH6lHvsYVHBE
 JAI1FYeojOWEt8pbuw4FMZUCEEPk9cQIedb4FLAX08SMzPJHoTDGUwUTYE/wREJtpUHY+X
 LAb1kHNKx3hQfrumTZxFWICvgtoe6xNbXLMAyuv4V6eGIU9/7PvVu75RGCJ++g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/16] pinctrl: renesas: Minimize R8A779F0 S4 PFC tables
Date: Sat, 21 Dec 2024 22:34:13 +0100
Message-ID: <20241221213443.115024-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cak4zrbsx93hfjybwura899h5curdpx5
X-MBO-RS-ID: 259702f8192fcc9dc66
X-Rspamd-Queue-Id: 4YFyHv0DS8z9sd5
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

- INTC-EX
- MSIOF

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc-r8a779f0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779f0.c b/drivers/pinctrl/renesas/pfc-r8a779f0.c
index eec50210d92..2b629135f69 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779f0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779f0.c
@@ -654,6 +654,7 @@ static const unsigned int i2c5_mux[] = {
 	SDA5_MARK, SCL5_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_pins[] = {
 	/* IRQ0 */
@@ -697,6 +698,7 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
+#endif
 
 /* - MMC -------------------------------------------------------------------- */
 static const unsigned int mmc_data_pins[] = {
@@ -741,6 +743,7 @@ static const unsigned int mmc_ds_mux[] = {
 	MMC_DS_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* MSIOF0_SCK */
@@ -916,6 +919,7 @@ static const unsigned int msiof3_rxd_pins[] = {
 static const unsigned int msiof3_rxd_mux[] = {
 	MSIOF3_RXD_MARK,
 };
+#endif
 
 /* - PCIE ------------------------------------------------------------------- */
 static const unsigned int pcie0_clkreq_n_pins[] = {
@@ -1308,12 +1312,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
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
@@ -1321,6 +1327,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(mmc_cd),
 	SH_PFC_PIN_GROUP(mmc_wp),
 	SH_PFC_PIN_GROUP(mmc_ds),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 	SH_PFC_PIN_GROUP(msiof0_clk),
 	SH_PFC_PIN_GROUP(msiof0_sync),
 	SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -1345,6 +1352,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof3_ss2),
 	SH_PFC_PIN_GROUP(msiof3_txd),
 	SH_PFC_PIN_GROUP(msiof3_rxd),
+#endif
 	SH_PFC_PIN_GROUP(pcie0_clkreq_n),
 	SH_PFC_PIN_GROUP(pcie1_clkreq_n),
 	SH_PFC_PIN_GROUP(qspi0_ctrl),
@@ -1446,6 +1454,7 @@ static const char * const i2c5_groups[] = {
 	"i2c5",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0",
 	"intc_ex_irq1",
@@ -1454,6 +1463,7 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
+#endif
 
 static const char * const mmc_groups[] = {
 	"mmc_data1",
@@ -1465,6 +1475,7 @@ static const char * const mmc_groups[] = {
 	"mmc_ds",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -1500,6 +1511,7 @@ static const char * const msiof3_groups[] = {
 	"msiof3_txd",
 	"msiof3_rxd",
 };
+#endif
 
 static const char * const pcie_groups[] = {
 	"pcie0_clkreq_n",
@@ -1596,12 +1608,16 @@ static const struct sh_pfc_function pinmux_functions[] = {
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
 	SH_PFC_FUNCTION(msiof3),
+#endif
 	SH_PFC_FUNCTION(pcie),
 	SH_PFC_FUNCTION(qspi0),
 	SH_PFC_FUNCTION(qspi1),
-- 
2.45.2

