Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7060BCD4F26
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 02:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 171EC849AE;
	Sun, 21 Jun 2026 04:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yCsOhCXH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jWR2wW6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A466984844; Sun, 21 Jun 2026 04:39:59 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B5D8499C
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 04:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gjbCK2mjGz9tPF;
 Sun, 21 Jun 2026 04:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782009597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hiXrwC7e8NTMJ9IgGzML3g0nIJji2hvcxJkHsyHkzMY=;
 b=yCsOhCXHl49CZpULhrcDkzd0+l4Y8TnTpFpgCedqYQcWsrIVvW/oXTDL5W61mIcSTWXMV4
 eHXWVfMP3XHrhrvg/vADuvOY1l3gR3PW2dfCY1Av0n0M0XJBvt04PnMIqTyhE8vOxSU85u
 Nv3VLUY0eonhMrg7U1JZSjwvyk9WeMgmNdj+8jOjeDQZFAcGJPkgxAqRZY4LujnHUMM4rY
 VJ4aNl7TzKkDZaFsf0uFCKR6NRu/aMHo8dyS/QBoP2Vt5qOKE8nAEAJ/BKg0DrdqaRZVVY
 1AoU9OpPATzNItO1Ns6TDh2ReektElqBsdGwC+nD3efenzWj/d/AEJqLdc8rSA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jWR2wW6V;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782009596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hiXrwC7e8NTMJ9IgGzML3g0nIJji2hvcxJkHsyHkzMY=;
 b=jWR2wW6VaatbUqQHsJCBaXlYVhOZBfvuOTa31woazh9Fgi/C1J+nv3R3qJ10MqioOCRV/M
 z0iie0pLvJiF9RulE5nIlQ1XwKrkDBhrB72SD2L8FfheTO24C4fi/V+B2KJqAW4h5xLGB9
 brnj8Bbk7Gv0FlSHJ4AV1IfbQ3b5/6fywIvsbBZmjOMaAjLpmHBRswKH6lVAem/GovuhHa
 3YdL46plRcFyQeq72KfwjdlQ7uV3HjFcITrGLrpZm4yOGVeEj2ifOJFQAf7oghwd5u3CYT
 XdDJIkIGKbdWL873wbOp/n90tEcw+cvC4uT5WOF98o+4+S2vtWVGFcz5wqsM2A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] pinctrl: renesas: Further minimize R8A77960 M3-W and
 R8A77961 M3-W+ PFC tables
Date: Sun, 21 Jun 2026 04:38:52 +0200
Message-ID: <20260621023952.404299-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260621023952.404299-1-marek.vasut+renesas@mailbox.org>
References: <20260621023952.404299-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k1kkd9ootgmmss7ae7ectftirf7ymo5z
X-MBO-RS-ID: de1c704805fd6457d47
X-Rspamd-Queue-Id: 4gjbCK2mjGz9tPF
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

Reduce the PFC tables further by gating DRIF, MLB, TMU and TPU
behind PINCTRL_PFC_FULL, none of which are currently supported by
U-Boot. This helps reduce the size of the bootloader in 4 kiB range.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc-r8a7796.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7796.c b/drivers/pinctrl/renesas/pfc-r8a7796.c
index a587dfb89d4..ac1dbae9954 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7796.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7796.c
@@ -1833,7 +1833,6 @@ static const unsigned int canfd1_data_pins[] = {
 static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK,         CANFD1_RX_MARK,
 };
-#endif
 
 #if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
 /* - DRIF0 --------------------------------------------------------------- */
@@ -2052,7 +2051,6 @@ static const unsigned int drif3_data1_b_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77960 || CONFIG_PINCTRL_PFC_R8A77961 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -2465,7 +2463,6 @@ static const unsigned int intc_ex_irq5_pins[] = {
 static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
-#endif
 
 #if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
 /* - MLB+ ------------------------------------------------------------------- */
@@ -2477,7 +2474,6 @@ static const unsigned int mlb_3pin_mux[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77960 || CONFIG_PINCTRL_PFC_R8A77961 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -3866,7 +3862,6 @@ static const unsigned int ssi9_ctrl_b_pins[] = {
 static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
-#endif
 
 /* - TMU -------------------------------------------------------------------- */
 static const unsigned int tmu_tclk1_a_pins[] = {
@@ -3927,6 +3922,7 @@ static const unsigned int tpu_to3_pins[] = {
 static const unsigned int tpu_to3_mux[] = {
 	TPU0TO3_MARK,
 };
+#endif
 
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
@@ -4435,7 +4431,6 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi9_data_b),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_a),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
-#endif
 		SH_PFC_PIN_GROUP(tmu_tclk1_a),
 		SH_PFC_PIN_GROUP(tmu_tclk1_b),
 		SH_PFC_PIN_GROUP(tmu_tclk2_a),
@@ -4444,6 +4439,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(tpu_to1),
 		SH_PFC_PIN_GROUP(tpu_to2),
 		SH_PFC_PIN_GROUP(tpu_to3),
+#endif
 		SH_PFC_PIN_GROUP(usb0),
 		SH_PFC_PIN_GROUP(usb1),
 		SH_PFC_PIN_GROUP(usb30),
@@ -4478,7 +4474,8 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_clk),
 #endif
 	},
-#if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
+#if defined(CONFIG_PINCTRL_PFC_FULL) && \
+    (defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961))
 	.automotive = {
 		SH_PFC_PIN_GROUP(drif0_ctrl_a),
 		SH_PFC_PIN_GROUP(drif0_data0_a),
@@ -4573,7 +4570,6 @@ static const char * const canfd0_groups[] = {
 static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
-#endif
 
 #if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
 static const char * const drif0_groups[] = {
@@ -4619,7 +4615,6 @@ static const char * const drif3_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77960 || CONFIG_PINCTRL_PFC_R8A77961 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4712,7 +4707,6 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq4",
 	"intc_ex_irq5",
 };
-#endif
 
 #if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
 static const char * const mlb_3pin_groups[] = {
@@ -4720,7 +4714,6 @@ static const char * const mlb_3pin_groups[] = {
 };
 #endif /* CONFIG_PINCTRL_PFC_R8A77960 || CONFIG_PINCTRL_PFC_R8A77961 */
 
-#ifdef CONFIG_PINCTRL_PFC_FULL
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -4995,7 +4988,6 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl_a",
 	"ssi9_ctrl_b",
 };
-#endif
 
 static const char * const tmu_groups[] = {
 	"tmu_tclk1_a",
@@ -5010,6 +5002,7 @@ static const char * const tpu_groups[] = {
 	"tpu_to2",
 	"tpu_to3",
 };
+#endif
 
 static const char * const usb0_groups[] = {
 	"usb0",
@@ -5118,9 +5111,9 @@ static const struct {
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
@@ -5129,7 +5122,8 @@ static const struct {
 		SH_PFC_FUNCTION(vin5),
 #endif
 	},
-#if defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961)
+#if defined(CONFIG_PINCTRL_PFC_FULL) && \
+    (defined(CONFIG_PINCTRL_PFC_R8A77960) || defined(CONFIG_PINCTRL_PFC_R8A77961))
 	.automotive = {
 		SH_PFC_FUNCTION(drif0),
 		SH_PFC_FUNCTION(drif1),
-- 
2.53.0

