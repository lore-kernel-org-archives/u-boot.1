Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E18CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 02:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE1A849C5;
	Sun, 21 Jun 2026 04:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xgqMqJ/n";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jSUn2EIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2995849BB; Sun, 21 Jun 2026 04:40:00 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DA883FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 04:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gjbCL5Zhbz9tsv;
 Sun, 21 Jun 2026 04:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782009598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cktG7HP5gycDxady+/3W507FOiHf+a1c5Kv1RiU601E=;
 b=xgqMqJ/nt3FNHjZSSgBTXecs+V5ZhmKKuzmXL6eRXEC9DleEw1ldsXf5auAB3OpMLNLISU
 yFWm3leYoRqLeVBbZZoHdfBbUET3gIZe8s1svv9AdNJvzQXydvSBAlvaMq9KaR3F6iTwsW
 09OHsMQWC3snFqZLAkW9K1z6VqcM94ADmBBbaLlF548u/mxmIe3p9k4fwqE9Ao/FsZt9pp
 Ah2RvaCo8m3PJOuIcri8ll7/4wFM9eY/+7ADVbZrDknHEG11JroLLHmBY+VTUQSZ3jtiEw
 PCUtEZ5mw5BCvtZMfgMfxf8prnyYK3spMPCIskkmKdfe423jUe18t2JWeI4pWg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782009597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cktG7HP5gycDxady+/3W507FOiHf+a1c5Kv1RiU601E=;
 b=jSUn2EIHg41aYKIDjmUSdwZgimb2UKny7/bwmQgGuFbIImSDjmj2nMo4VOnQybge6COnlg
 8lrGe4wZVoIW7trFFb1fBGGhCQL+PhYOBRfOq6W0kyGMweRXUSIW0Nix3L63biPur2Q6sx
 vJ8mTqzL+dPmguqdn92aPnHjURFj0i7y8ST+hOvpAqI6U4kDkVAN244vxodyG19+GfXxr1
 bzv8NQLcPV/TDoXAUgdB+thcqO71E1x3emUjyD0PsvpJrwPZmmDX8Fm1QTpD0tNfW3qiTy
 kpUqorfpqeNWNXBVTfZdKEQcWHPcFPNN9YM7m1DIytTsRrBybOKhe9+kC0L4YQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] pinctrl: renesas: Further minimize R8A77965 M3-N PFC
 tables
Date: Sun, 21 Jun 2026 04:38:53 +0200
Message-ID: <20260621023952.404299-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260621023952.404299-1-marek.vasut+renesas@mailbox.org>
References: <20260621023952.404299-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: m3njdm4b3nfcciq1thn3abnj8koz78by
X-MBO-RS-ID: d1ae32ea8b07eedae18
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

Reduce the PFC tables further by gating DRIF, MLB, TMU, TPU and SATA
behind PINCTRL_PFC_FULL, none of which are currently supported by
U-Boot. This helps reduce the size of the bootloader in 4 kiB range.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc-r8a77965.c | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77965.c b/drivers/pinctrl/renesas/pfc-r8a77965.c
index 9049d762a59..d1c1f562fca 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77965.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77965.c
@@ -1848,7 +1848,6 @@ static const unsigned int canfd1_data_pins[] = {
 static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK,         CANFD1_RX_MARK,
 };
-#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77965
 /* - DRIF0 --------------------------------------------------------------- */
@@ -2126,7 +2125,6 @@ static const unsigned int drif3_data1_b_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77965 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -2616,7 +2614,6 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
-#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77965
 /* - MLB+ ------------------------------------------------------------------- */
@@ -2628,7 +2625,6 @@ static const unsigned int mlb_3pin_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77965 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -3464,6 +3460,7 @@ static const unsigned int qspi1_data_mux[] = {
 	QSPI1_IO2_MARK, QSPI1_IO3_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SATA --------------------------------------------------------------------*/
 static const unsigned int sata0_devslp_a_pins[] = {
 	/* DEVSLP */
@@ -3482,6 +3479,7 @@ static const unsigned int sata0_devslp_b_pins[] = {
 static const unsigned int sata0_devslp_b_mux[] = {
 	SATA_DEVSLP_B_MARK,
 };
+#endif
 
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
@@ -4071,7 +4069,6 @@ static const unsigned int ssi9_ctrl_b_pins[] = {
 static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
-#endif
 
 /* - TMU -------------------------------------------------------------------- */
 static const unsigned int tmu_tclk1_a_pins[] = {
@@ -4139,6 +4136,7 @@ static const unsigned int tpu_to3_pins[] = {
 static const unsigned int tpu_to3_mux[] = {
 	TPU0TO3_MARK,
 };
+#endif
 
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
@@ -4588,8 +4586,10 @@ static const struct {
 		SH_PFC_PIN_GROUP(qspi1_ctrl),
 		BUS_DATA_PIN_GROUP(qspi1_data, 2),
 		BUS_DATA_PIN_GROUP(qspi1_data, 4),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_PIN_GROUP(sata0_devslp_a),
 		SH_PFC_PIN_GROUP(sata0_devslp_b),
+#endif
 		SH_PFC_PIN_GROUP(scif0_data),
 		SH_PFC_PIN_GROUP(scif0_clk),
 		SH_PFC_PIN_GROUP(scif0_ctrl),
@@ -4671,7 +4671,6 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi9_data_b),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_a),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
-#endif
 		SH_PFC_PIN_GROUP(tmu_tclk1_a),
 		SH_PFC_PIN_GROUP(tmu_tclk1_b),
 		SH_PFC_PIN_GROUP(tmu_tclk2_a),
@@ -4680,6 +4679,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(tpu_to1),
 		SH_PFC_PIN_GROUP(tpu_to2),
 		SH_PFC_PIN_GROUP(tpu_to3),
+#endif
 		SH_PFC_PIN_GROUP(usb0),
 		SH_PFC_PIN_GROUP(usb1),
 		SH_PFC_PIN_GROUP(usb30),
@@ -4714,7 +4714,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_clk),
 #endif
 	},
-#ifdef CONFIG_PINCTRL_PFC_R8A77965
+#if defined(CONFIG_PINCTRL_PFC_FULL) && defined(CONFIG_PINCTRL_PFC_R8A77965)
 	.automotive = {
 		SH_PFC_PIN_GROUP(drif0_ctrl_a),
 		SH_PFC_PIN_GROUP(drif0_data0_a),
@@ -4809,7 +4809,6 @@ static const char * const canfd0_groups[] = {
 static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
-#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77965
 static const char * const drif0_groups[] = {
@@ -4855,7 +4854,6 @@ static const char * const drif3_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77965 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4948,7 +4946,6 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
-#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77965
 static const char * const mlb_3pin_groups[] = {
@@ -4956,7 +4953,6 @@ static const char * const mlb_3pin_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77965 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -5115,10 +5111,12 @@ static const char * const qspi1_groups[] = {
 	"qspi1_data4",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const sata0_groups[] = {
 	"sata0_devslp_a",
 	"sata0_devslp_b",
 };
+#endif
 
 static const char * const scif0_groups[] = {
 	"scif0_data",
@@ -5235,7 +5233,6 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl_a",
 	"ssi9_ctrl_b",
 };
-#endif
 
 static const char * const tmu_groups[] = {
 	"tmu_tclk1_a",
@@ -5250,6 +5247,7 @@ static const char * const tpu_groups[] = {
 	"tpu_to2",
 	"tpu_to3",
 };
+#endif
 
 static const char * const usb0_groups[] = {
 	"usb0",
@@ -5345,7 +5343,9 @@ static const struct {
 #endif
 		SH_PFC_FUNCTION(qspi0),
 		SH_PFC_FUNCTION(qspi1),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(sata0),
+#endif
 		SH_PFC_FUNCTION(scif0),
 		SH_PFC_FUNCTION(scif1),
 		SH_PFC_FUNCTION(scif2),
@@ -5359,9 +5359,9 @@ static const struct {
 		SH_PFC_FUNCTION(sdhi3),
 #ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(ssi),
-#endif
 		SH_PFC_FUNCTION(tmu),
 		SH_PFC_FUNCTION(tpu),
+#endif
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb1),
 		SH_PFC_FUNCTION(usb30),
@@ -5370,7 +5370,7 @@ static const struct {
 		SH_PFC_FUNCTION(vin5),
 #endif
 	},
-#ifdef CONFIG_PINCTRL_PFC_R8A77965
+#if defined(CONFIG_PINCTRL_PFC_FULL) && defined(CONFIG_PINCTRL_PFC_R8A77965)
 	.automotive = {
 		SH_PFC_FUNCTION(drif0),
 		SH_PFC_FUNCTION(drif1),
-- 
2.53.0

