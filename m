Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47953C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1175040566;
	Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndNdgXZdpTkG; Tue, 25 Aug 2026 19:04:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684657;
	bh=vsqs5J/iXj+2UPeNShCQKPOQjDKHbO9O62fdUjeJiBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O6Prx6ikzWF2BFbRkj+4PicD2jrkG7J2Ek7/niYu7iDa47JCxvpo2iXNA2KHrIr/5
	 zIwW4DHatc5sMdxw0boU2ifPwnscnt90Ml4yJhc9yHR5om/sIuerPElqx9qxJeDKBM
	 axHZpxAnjr1NXtXpeO1ptDqBKuUHy9yHvPI808q+wiSKjURycDfviUCVv90s3Id18m
	 I/QyLZN0qBrCS2b7+0mqFUUF/ic4sSureGxfTDH+rfIEA0ZlXBlNN1JgXLEEanxKmT
	 FIjWLh7F4vwIhaCrxqW2ICPXqnDtaLlIZIFCUpAEAwQ4cK24Uyxy84QE+F7S0AHTUS
	 WXJ7Pq5qHaToQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 744E4405E2;
	Tue, 25 Aug 2026 19:04:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3739B8F1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34527606F6
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DAoOFhAg5RfK for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:04:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=TkF6eLPL
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 90F8F606E5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAFF440BF1;
 Tue, 25 Aug 2026 19:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6501F000E9;
 Tue, 25 Aug 2026 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684651;
 bh=vsqs5J/iXj+2UPeNShCQKPOQjDKHbO9O62fdUjeJiBM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TkF6eLPLfvp9DN7MBAZv1GtjN+30HEt2szLSQTA8aGVwnHMbs9nPfCWalp0Xau7rt
 QffxiJSbr5W8npJE2fDGON2shBa2xP1T7qqpkPUurccgaT+QjEyc62wiiDqk/9na59
 dfcVh2FDnVSSEL9fwiALgF39J/RSCsavFErTb9QZb/ieTRTGH3q0bfxLjZgOcNqINt
 dEiw73M5bRMq+oiOq8dghHQYw9l8zUt/FMow28kPYjAW/5PT9XTb6EPRVWKiTYafGp
 8NjjU8hdePkmmAc/T7NcnR6FAByRQzgZWSpD601HnQr1Mcthi4uMJ2A45un9DdaWMd
 3y4q0X1apzI3g==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:04:03 +0200
Subject: [PATCH v6 03/13] mmc: arm_pl180: Gate idle card clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ux500-external-sdcard-v6-3-61446b6c289e@kernel.org>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
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

Honor clk_disable when programming the clock control register.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index af21b814641e..28eb367f2e0a 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -294,6 +294,10 @@ static int  host_set_ios(struct mmc *dev)
 	u32 sdi_clkcr;
 
 	sdi_clkcr = readl(&host->base->clock);
+	if (dev->clk_disable)
+		sdi_clkcr &= ~SDI_CLKCR_CLKEN;
+	else
+		sdi_clkcr |= SDI_CLKCR_CLKEN;
 
 	/* Ramp up the clock rate */
 	if (dev->clock) {

-- 
2.55.0

