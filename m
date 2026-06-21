Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7196ECDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 02:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C05F38499C;
	Sun, 21 Jun 2026 04:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MlnQ9Ho2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oEpLsZlF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3EE5849AE; Sun, 21 Jun 2026 04:39:58 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF31483FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 04:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gjbCJ3lvgz9tpM;
 Sun, 21 Jun 2026 04:39:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782009596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I4sHnPm/T4ZgYewgjD9bm2LRipipuAvjEQl0mSOMYc8=;
 b=MlnQ9Ho2kRPRfRglHYpGaswx93mu/hd5/7IZcIT5RF7P06dPe80ikxR+lAzHpyDWUqI4At
 AEWcF58OaUY2loVIbeiMgMC+Ce3dV+3nQZAOuwlSXlaDcYRaQx/HrcS99iCClcBfHQNPPs
 FCZdUmzqnJo9OM35zaWbsk6FgpAS+gIIkZUO7MYebMpDaSZJEbocAkaMSw6HjSJWDGG9ag
 jL76FIUg27VPry/Vm17VONB2ypsk3fIlfu0PXvpu1b/dAEnm+Q1CpJIgi8Rvq5LJJ0aE1x
 umedy4WddHxly9f6qhpVkKFOS+hxOiG2r7DlnlAnpjPL9MkQmY2gFXwGyQBLKA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=oEpLsZlF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782009594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I4sHnPm/T4ZgYewgjD9bm2LRipipuAvjEQl0mSOMYc8=;
 b=oEpLsZlFrcCyPJhzZwyrIamiBYDqD2vyPWTXA7YYgF7rYpCYDBqYDmQA8n8Tfkcux60Tjk
 2hwGvzPRG5O5qH3FyX8DtFwXwsPLD8ULHd736aWMk5QdrP9H93wUK0Xz7fdLkIzg7nxnRg
 sFTyyT2/P300v8r0b/QYDHl+EFEN4urUEp2gfnnF2aLpym+SxHQ9xKakp1HnGsBeR3Am4C
 dZIaqMstd/Yl+9OsdRLT7RaYBNPXALADH5NKZV/TLrk3FjsZRa/8ksKXPR4lMCcpM0BoNZ
 lIAd8BFAVr8AVZRKtUDKweoPgD29U3o5PQR4J1NxGhP2lCZklb1iGBU57eOhoQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] pinctrl: renesas: Further minimize R8A77951 H3 PFC tables
Date: Sun, 21 Jun 2026 04:38:51 +0200
Message-ID: <20260621023952.404299-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rsorrzz8r9355y9kpk8njngequfcou9s
X-MBO-RS-ID: 8e35fb7f699ec15d2ac
X-Rspamd-Queue-Id: 4gjbCJ3lvgz9tpM
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
 drivers/pinctrl/renesas/pfc-r8a77951.c | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77951.c b/drivers/pinctrl/renesas/pfc-r8a77951.c
index 99b90e6df0d..0c4e91b6df5 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77951.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77951.c
@@ -1827,7 +1827,6 @@ static const unsigned int canfd1_data_pins[] = {
 static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK,         CANFD1_RX_MARK,
 };
-#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 /* - DRIF0 --------------------------------------------------------------- */
@@ -2046,7 +2045,6 @@ static const unsigned int drif3_data1_b_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -2459,7 +2457,6 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
-#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 /* - MLB+ ------------------------------------------------------------------- */
@@ -2471,7 +2468,6 @@ static const unsigned int mlb_3pin_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -3307,6 +3303,7 @@ static const unsigned int qspi1_data_mux[] = {
 	QSPI1_IO2_MARK, QSPI1_IO3_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - SATA --------------------------------------------------------------------*/
 static const unsigned int sata0_devslp_a_pins[] = {
 	/* DEVSLP */
@@ -3322,6 +3319,7 @@ static const unsigned int sata0_devslp_b_pins[] = {
 static const unsigned int sata0_devslp_b_mux[] = {
 	SATA_DEVSLP_B_MARK,
 };
+#endif
 
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
@@ -3874,7 +3872,6 @@ static const unsigned int ssi9_ctrl_b_pins[] = {
 static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
-#endif
 
 /* - TMU -------------------------------------------------------------------- */
 static const unsigned int tmu_tclk1_a_pins[] = {
@@ -3935,6 +3932,7 @@ static const unsigned int tpu_to3_pins[] = {
 static const unsigned int tpu_to3_mux[] = {
 	TPU0TO3_MARK,
 };
+#endif
 
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
@@ -4378,8 +4376,10 @@ static const struct {
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
@@ -4461,7 +4461,6 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi9_data_b),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_a),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
-#endif
 		SH_PFC_PIN_GROUP(tmu_tclk1_a),
 		SH_PFC_PIN_GROUP(tmu_tclk1_b),
 		SH_PFC_PIN_GROUP(tmu_tclk2_a),
@@ -4470,6 +4469,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(tpu_to1),
 		SH_PFC_PIN_GROUP(tpu_to2),
 		SH_PFC_PIN_GROUP(tpu_to3),
+#endif
 		SH_PFC_PIN_GROUP(usb0),
 		SH_PFC_PIN_GROUP(usb1),
 		SH_PFC_PIN_GROUP(usb2),
@@ -4506,7 +4506,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_clk),
 #endif
 	},
-#ifdef CONFIG_PINCTRL_PFC_R8A77951
+#if defined(CONFIG_PINCTRL_PFC_FULL) && defined(CONFIG_PINCTRL_PFC_R8A77951)
 	.automotive = {
 		SH_PFC_PIN_GROUP(drif0_ctrl_a),
 		SH_PFC_PIN_GROUP(drif0_data0_a),
@@ -4601,7 +4601,6 @@ static const char * const canfd0_groups[] = {
 static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
-#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 static const char * const drif0_groups[] = {
@@ -4647,7 +4646,6 @@ static const char * const drif3_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4740,7 +4738,6 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
-#endif
 
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 static const char * const mlb_3pin_groups[] = {
@@ -4748,7 +4745,6 @@ static const char * const mlb_3pin_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -4907,10 +4903,12 @@ static const char * const qspi1_groups[] = {
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
@@ -5028,7 +5026,6 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl_a",
 	"ssi9_ctrl_b",
 };
-#endif
 
 static const char * const tmu_groups[] = {
 	"tmu_tclk1_a",
@@ -5043,6 +5040,7 @@ static const char * const tpu_groups[] = {
 	"tpu_to2",
 	"tpu_to3",
 };
+#endif
 
 static const char * const usb0_groups[] = {
 	"usb0",
@@ -5146,7 +5144,9 @@ static const struct {
 #endif
 		SH_PFC_FUNCTION(qspi0),
 		SH_PFC_FUNCTION(qspi1),
+#ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(sata0),
+#endif
 		SH_PFC_FUNCTION(scif0),
 		SH_PFC_FUNCTION(scif1),
 		SH_PFC_FUNCTION(scif2),
@@ -5160,9 +5160,9 @@ static const struct {
 		SH_PFC_FUNCTION(sdhi3),
 #ifdef CONFIG_PINCTRL_PFC_FULL
 		SH_PFC_FUNCTION(ssi),
-#endif
 		SH_PFC_FUNCTION(tmu),
 		SH_PFC_FUNCTION(tpu),
+#endif
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb1),
 		SH_PFC_FUNCTION(usb2),
@@ -5173,7 +5173,7 @@ static const struct {
 		SH_PFC_FUNCTION(vin5),
 #endif
 	},
-#ifdef CONFIG_PINCTRL_PFC_R8A77951
+#if defined(CONFIG_PINCTRL_PFC_FULL) && defined(CONFIG_PINCTRL_PFC_R8A77951)
 	.automotive = {
 		SH_PFC_FUNCTION(drif0),
 		SH_PFC_FUNCTION(drif1),
-- 
2.53.0

