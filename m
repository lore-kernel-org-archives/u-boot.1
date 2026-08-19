Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AF1C5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83F2540660;
	Wed, 19 Aug 2026 08:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id voxH6zxKCdKG; Wed, 19 Aug 2026 08:54:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129658;
	bh=yVWFNoYUv/LUXW8daukjhuxvCqRcsvNZS0Qo3XjbWOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sR+fVercuLnCbNu4qQY3UuYHrJ2KMa2W5bVPZupcmuIPzPdp2FEgLnrHR8/izgF+s
	 M1a+X+HX3P4fEsGXH0AGEeRROJOzqKbeLbLQ4wu9xehs2OgVNTQf1Z7hbY9fxAt2Sb
	 TbhXfwSXSsx1ZyRqF/k0YheTHEly/MtF1o3xHUZ2HngJ34gNKs4TsY43I/TSFrHTuA
	 AOp3bB5XM6IfNt1YKC+EsDYOnMSPPaVDaCUGnGndbxGLjQrPau232iCSzOeabzqr3a
	 5+eBqc2DK4kUSSBs8i1780jlyQhvqthl++yWP3t7OydKTIZr6PGuGDng9p8tJHXKCl
	 ayDHNumZTgcYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC81E40694;
	Wed, 19 Aug 2026 08:54:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18E60265
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A9E460618
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oVLfBg57cnEp for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LKvvnmvm
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F84A60602
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C61F60A58;
 Wed, 19 Aug 2026 08:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE811F000E9;
 Wed, 19 Aug 2026 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129654;
 bh=yVWFNoYUv/LUXW8daukjhuxvCqRcsvNZS0Qo3XjbWOU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LKvvnmvmyz2xXts7nCUzyMYfxrlrOarHzzAiN1b/7Xxm0R/3UhmGPwezIoW6L7+/k
 fKd51C5mHzhR7aLBkcbw9lSO78RHOcDs/qiCMiabE+mPLQa8qqlLO+PjAoUDAlvcN/
 jEvEfxUHoTmtlIqikz4258cQ2sA3Xt5BPKpmOE2qUiTV1+V62vX3ZUZ3nluRD+X9mT
 ahTJPtsDZlSR0A8ZnWAecTmDH4xpI4k99WD7dSaXbp7KiOVgvzLUmKk/cb0HhnIVMG
 83GL9bZi1ClrKOyzJ8Sk8gIoesFU1vtI9jKd4IYH2Gf6FOsFILSW9J0iXlGxa4Un8e
 crfZ6SpQnU1lA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:54:08 +0200
Subject: [PATCH v4 03/12] mmc: arm_pl180: Gate idle card clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-ux500-external-sdcard-v4-3-f1c8c9ffac30@kernel.org>
References: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
In-Reply-To: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
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

