Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479ABC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3EE688BCE;
	Fri, 19 Jul 2024 12:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rxqeQauR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rswXW3je";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 581F488BA7; Fri, 19 Jul 2024 12:50:39 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF86B88BD7
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQRKR3vYqz9sTf;
 Fri, 19 Jul 2024 12:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lL1dbTIQH6MXWvbNlLkS3/Ci+jmId2zLTorR4jdoUSU=;
 b=rxqeQauRDyy9d6Wlam+BSIjgJK9ilDzSQYIPegN1B2Rwzs/nmDtYuqscCZMjVMw6ke4hUp
 29phvkB+zY190ePkYbCrOLmzf0yVpVCSuN1zqcriq6K5DdJpe0k5N/nYG7MeTmVCbveIv5
 oChaupWD3bZKDUi6uhfp43+NwrEssZWsy9O07vkOgh4FP2HESQyJX902btPwevEO8GrzoM
 Ht/m2byhBZAPYaVl2cMFudZ+g2whjDAiISy5PlF+1UZpM9qNI+o8kbyn8v5r3dohMboovt
 v3QuUkDiKQRLyGpFuIuE/d8/LfzAGQ9z6QWX+3aH1grNffhkS32EvS64fU7zQA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lL1dbTIQH6MXWvbNlLkS3/Ci+jmId2zLTorR4jdoUSU=;
 b=rswXW3jecF4opMvj2V9ZAYkTrovw+9HcXoZ/poDOk6NJ8dA4eK50h0/smmQiW/pIh6IaQf
 mCEDt0EhynEJCPLMM124mZk8CLFf3L86tIy3aMpc5yn8MRzAHMG0Pu34SZU2eGL+QM6ED/
 YtGkad03oYRSw8BbKEXL7VM9glFqcbfRr8unTLZ/BDcDaEgHLfk7xMwBOIVCYQ2dqRgpj2
 t8dPP9FnFP6dfFoF+CRqmsLHvaNctbJBlontS9aGRypCpkj0gWsKsrhdwrcvk2zri1Y/rE
 JkhaGGQO+ym81rNRWX7gPiIR3CBoo19Z8sBRf6wl+WahtRiU7XK4QHmch173Yg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 18/37] board: hisilicon: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:55 +0200
Message-ID: <20240719104948.323791-18-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ozp61ggb9znrmhfx8jbydwmqigcq6yac
X-MBO-RS-ID: 53d0d21e7b252922ded
X-Rspamd-Queue-Id: 4WQRKR3vYqz9sTf
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/hisilicon/hikey/hikey.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/hisilicon/hikey/hikey.c b/board/hisilicon/hikey/hikey.c
index 95a831efcaf..29165266630 100644
--- a/board/hisilicon/hikey/hikey.c
+++ b/board/hisilicon/hikey/hikey.c
@@ -244,7 +244,6 @@ static int config_sd_carddetect(void)
 	return 0;
 }
 
-
 static void mmc1_init_pll(void)
 {
 	uint32_t data;
@@ -339,7 +338,6 @@ static void mmc0_reset_clk(void)
 	} while (data & PERI_RST0_MMC0);
 }
 
-
 /* PMU SSI is the IP that maps the external PMU hi6553 registers as IO */
 static void hi6220_pmussi_init(void)
 {
@@ -398,7 +396,6 @@ static int init_dwmmc(void)
 	if (ret)
 		printf("%s: Error adding eMMC port (%d)\n", __func__, ret);
 
-
 	/* take mmc1 (sd slot) out of reset, configure clocks and pinmuxing */
 	mmc1_init_pll();
 	mmc1_reset_clk();
-- 
2.43.0

