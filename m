Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE7CC5DF81
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 09:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCA3B80DEF;
	Tue, 18 Aug 2026 09:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GuhHGYxIseKz; Tue, 18 Aug 2026 09:00:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A1C480D89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787043641;
	bh=yVWFNoYUv/LUXW8daukjhuxvCqRcsvNZS0Qo3XjbWOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bUtokNMQcMkefj9pYNBTs11m3R2VEynQ46V88wbqPts0KSfd7rpxD0TDkmITxZZ76
	 FGaeeBU8yEoNBwWu88kQRy8hHmvZVDJfU+PoUypzet0VQY6mPXMD/cEYkhN1phuT2p
	 pN3C0qeyV4Ust6Uay51b5sATea1V+KBrZvmIvhE8Y4qgqkVJrDkWIfyjlz2JDQHNhh
	 PC+8b9hVPedJADc26x/HsVMA+kWKx5ELcnDa0xTa4DJkqsBiKCucZeI5EuZeFmgFCT
	 y0lwJ/5iCY/454G5Uj4haFIRpMFpyYSLQlea9MNKFuEYduRm5vfs7iXycCvWXVfY0a
	 +euvr4EOT6R0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A1C480D89;
	Tue, 18 Aug 2026 09:00:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE564237
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D52B1607ED
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXP5y3bQXTdw for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 09:00:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 218F0607DA
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 218F0607DA
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AjJq6dwi
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 218F0607DA
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 088FC4143C;
 Tue, 18 Aug 2026 09:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37101F000E9;
 Tue, 18 Aug 2026 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787043635;
 bh=yVWFNoYUv/LUXW8daukjhuxvCqRcsvNZS0Qo3XjbWOU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=AjJq6dwiOhGpLexO3YTVHWDbsPH6ItOE+HaIYqptvBMI5s9kz37YFbKfQ+HgCAnfU
 PrPV4XOQALefLJ0jZ/NMAgxQlpdzJe11xJq0xpPOOkNVlAD3XDbLWDsC2UVWOppY0X
 NkrVAyKwfA2e57oPxKcsfE3+E9uy+TBdQITUIhdLJ+QIfpGnBnzPuKkN6MK41sGeDS
 OCRJ8XOaFWcoIJGXHbhdCsN7Iw+qqIGr2fP6QTijy5+qhwH2YB3dXu15jq8xfgg/2o
 lD0CN78UULlMZSnUaJ53ae+uTr4sB1AIMpH/9TWGJHWZ3EUe0YeuiNMJJMdPNtJr1U
 VXTWiQWx/O0BA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 18 Aug 2026 11:00:27 +0200
Subject: [PATCH v3 03/11] mmc: arm_pl180: Gate idle card clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ux500-external-sdcard-v3-3-a5d94930f3bb@kernel.org>
References: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
In-Reply-To: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
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

