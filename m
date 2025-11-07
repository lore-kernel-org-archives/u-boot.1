Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D32DCCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCDC783DD8;
	Fri,  7 Nov 2025 17:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xF9ATCwU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eERD73P6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8250883DFF; Fri,  7 Nov 2025 17:17:25 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 427A783DD7
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 17:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d342q09Mqz9t3f;
 Fri,  7 Nov 2025 17:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762532243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MwLaWqVZs9Mb3z7jsmvOJZuZBHiijOb0uD4RDvvM0c=;
 b=xF9ATCwU7rtWidCqBxpUYUJChArt+sZrdX1u9dkaqQI3v21sSRuffX4+9xYxgKGiTCZfJg
 is+zN8zVUm4fLn/5Uc55IAQXGd70NGyocDDi3AOroev/urfSWHKUZ5YCujjcHEXXNfH3ZX
 sIE33BEvTl1pLcaiw9DpwLgCBUvngh0Xy45nE5Ye1sIWXN3LnBQ7TZxAgwHa+cqFxq13d0
 y0D3+P2b0Za31UDFDD/xp75FXAnIplUwjf5pzbg/HP6dYOdu40HseBSfpORf3POPxUIboJ
 5roJIyZ/9KCG4QibMUTtVowkqsYsyuKGb1whtLBIZT6B4i8IBkJf/+0q4anEHQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762532240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MwLaWqVZs9Mb3z7jsmvOJZuZBHiijOb0uD4RDvvM0c=;
 b=eERD73P6/J9cabn7rzgtE1NsUEqSJL2RIrzbwO59Aku+uaw0YU6amlIlDp1sDh8nnV5etc
 w+drMEQWqvf5Hx+x6qGU+1Zb6P+220XT/t+BySLinC4dtFUbewx6SMQLOGWoDeV7c6zYpg
 jdeaKY9fs/3+IY8P7rGRvDrGxrr93rAGM8JojrtQkfqfwpkmzZIW5b6zRxMVCPoCnSUmjN
 uDQjuVacY7p0opJA/ThMXZSxVOO8fqJ6MiaF8XJCtMrLtaLWAEm+VfXxHmTAevbHsKHdLP
 kclaEAsXx7kZaTB/u+l6uXx+Ysl78wK1Pt8Rc/qOL2D0VzHnrU2vxBWStzyYSg==
To: u-boot@lists.denx.de
Cc: Huy Bui <huy.bui.wm@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Thanh Quan <thanh.quan.xn@renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] pinctrl: renesas: r8a779g0: Remove STPWT_EXTFXR
Date: Fri,  7 Nov 2025 17:16:55 +0100
Message-ID: <20251107161708.37236-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251107161708.37236-1-marek.vasut+renesas@mailbox.org>
References: <20251107161708.37236-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ad3e700dfaf4f0ed6c3
X-MBO-RS-META: opgwutsg9h7owics19nzhoxnogek496z
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

From: Huy Bui <huy.bui.wm@renesas.com>

Rev.1.30 of the R-Car V4H Series Hardware User’s Manual removed the
"STPWT_EXTFXR" signal from the pin control register tables.  As this is
further unused in the pin control driver, it can be removed safely.

Signed-off-by: Huy Bui <huy.bui.wm@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Linux counterpart: https://lore.kernel.org/all/f6cfdbbc024d85e87583a1d57ea01582632f1216.1762274384.git.geert+renesas@glider.be/
---
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Thanh Quan <thanh.quan.xn@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Huy Bui <huy.bui.wm@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index f188c27f63c..c63adedd297 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -354,7 +354,7 @@
 #define IP1SR2_3_0	FM(TPU0TO0_A)		FM(CANFD6_RX)		F_(0, 0)		FM(TCLK1_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_7_4	FM(CAN_CLK)		FM(FXR_TXENA_N_B)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_11_8	FM(CANFD0_TX)		FM(FXR_TXENB_N_B)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_15_12	FM(CANFD0_RX)		FM(STPWT_EXTFXR)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_15_12	FM(CANFD0_RX)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_19_16	FM(CANFD2_TX)		FM(TPU0TO2_A)		F_(0, 0)		FM(TCLK3_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_23_20	FM(CANFD2_RX)		FM(TPU0TO3_A)		FM(PWM1_B)		FM(TCLK4_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_27_24	FM(CANFD3_TX)		F_(0, 0)		FM(PWM2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -927,7 +927,6 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP1SR2_11_8,	FXR_TXENB_N_B),
 
 	PINMUX_IPSR_GPSR(IP1SR2_15_12,	CANFD0_RX),
-	PINMUX_IPSR_GPSR(IP1SR2_15_12,	STPWT_EXTFXR),
 
 	PINMUX_IPSR_GPSR(IP1SR2_19_16,	CANFD2_TX),
 	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TPU0TO2_A),
-- 
2.51.0

