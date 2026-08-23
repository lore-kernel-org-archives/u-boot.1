Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C20C5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B22BF80839;
	Sun, 23 Aug 2026 20:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5d2XWq3Zr4cd; Sun, 23 Aug 2026 20:39:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517580;
	bh=yVWFNoYUv/LUXW8daukjhuxvCqRcsvNZS0Qo3XjbWOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ME4zmLKBo/U0yTyRo2tc8vJskyPODnmLYIbeF5mCnRSEaOA2pHvYXaidfZG4k0bVa
	 KW1pddyDz1qS0Ta1XpAMpAk2m55BV6cH9iCx+Gnh7EsHgl9XDfnoYozbKtAcYKO39W
	 DGZ1V1Uy9wImium2eufFLNgyIexP8jXv99a8xypKfB2MRF9oeZ4eFkpr4GPwh1ymH2
	 TVTtQvclVd75VFpPO/CO0fccsOifDoOx9CI89w09aN94Nc9dBJF1zOHNEfFiDtC3h3
	 zP/ZGlmTvWO1+i9jspNFvdmDmBdYTb/HwqkoQYMtb4OZR0JY3OPhjj2cnGNnqxaKTV
	 OeUCeVYBUT9WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF96180D3E;
	Sun, 23 Aug 2026 20:39:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 269E23DA
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BDCC8082F
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MOBwVr5XNOor for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jXBXweiV
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17DDE8083B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 459C44064C;
 Sun, 23 Aug 2026 20:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F059F1F000E9;
 Sun, 23 Aug 2026 20:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517574;
 bh=yVWFNoYUv/LUXW8daukjhuxvCqRcsvNZS0Qo3XjbWOU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jXBXweiVUhFAYRcUxetEtN2HH6ZrSKiRYum1ouO0I9INRJHP8O8IU9X2sAeyOA9y9
 fj1zZgWCN+LwD8EHv8Lhf8LDXJqU4DkABdURB0eo/o/4P7Pvvq6IyypFzAj8gFTfZ/
 l36PL8JhE1LU9tuLAVfPBKdzqjXJhUaovFllunjCv+pYfGYuw7fx8C3T85yW4Uc0we
 5H4etWKurWjN+PbeLActnI6FBDvCLG+p7VW9+XGl/O4fH74FqWJcO7laGJCM+E831H
 H/HnGymRqdO4GxvpEuH/oUC8ukaq9sKpeypMA7Dc2FHoFu+MGBg+jzyF8kxFNQWtGG
 zMF5yjHaffIXQ==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:39:22 +0200
Subject: [PATCH v5 03/13] mmc: arm_pl180: Gate idle card clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-ux500-external-sdcard-v5-3-07ca794e2b94@kernel.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
In-Reply-To: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The MMC core uses mmc->clk_disable to request that the card clock is
stopped, but the PL180 driver leaves SDI_CLKCR_CLKEN unchanged. This can
leave inactive hosts driving their card clocks.

Honor clk_disable when programming the clock control register. Also enable
the PL180 power-save mode so the clock stops automatically while the bus is
idle.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index af21b814641e..528612359789 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -294,6 +294,11 @@ static int  host_set_ios(struct mmc *dev)
 	u32 sdi_clkcr;
 
 	sdi_clkcr = readl(&host->base->clock);
+	sdi_clkcr |= SDI_CLKCR_PWRSAV;
+	if (dev->clk_disable)
+		sdi_clkcr &= ~SDI_CLKCR_CLKEN;
+	else
+		sdi_clkcr |= SDI_CLKCR_CLKEN;
 
 	/* Ramp up the clock rate */
 	if (dev->clock) {
@@ -400,7 +405,7 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 
 	host->pwr_init = INIT_PWR;
 	host->clkdiv_init = SDI_CLKCR_CLKDIV_INIT_V1 | SDI_CLKCR_CLKEN |
-			    SDI_CLKCR_HWFC_EN;
+			    SDI_CLKCR_PWRSAV | SDI_CLKCR_HWFC_EN;
 	host->clock_in = clk_get_rate(&clk);
 
 	cfg->name = dev->name;
@@ -418,7 +423,7 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 	case UX500V2_MMCI_ID:
 		host->pwr_init = SDI_PWR_OPD | SDI_PWR_PWRCTRL_ON;
 		host->clkdiv_init = SDI_CLKCR_CLKDIV_INIT_V2 | SDI_CLKCR_CLKEN |
-				    SDI_CLKCR_HWFC_EN;
+				    SDI_CLKCR_PWRSAV | SDI_CLKCR_HWFC_EN;
 		cfg->voltages = VOLTAGE_WINDOW_MMC;
 		cfg->f_min = host->clock_in / (2 + SDI_CLKCR_CLKDIV_INIT_V2);
 		host->version2 = true;

-- 
2.55.0

