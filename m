Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C428C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 07:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 271A480E65;
	Wed, 19 Aug 2026 07:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P7KsGYJ-EHNm; Wed, 19 Aug 2026 07:08:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787123299;
	bh=FL6Drxv88A28hDjeOIXo4+RQRd7/9wv28mYYcuZ0k8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SSPP6Evb+E6Njfg4IwQsUIsFqMKNhVMeKc/W343Hp6c7JLitZyAwLndJgS+Hqche3
	 aeaZYqpeBDHxpSqjBUEOoFMM4wm8iUEtqYqdEFmZE5VX0RZl0Ut9WCKTxdAlr52UEu
	 YXeZG7lbjRCwwKnJtwIKtZdvbjAI92NhjFLhsYGJqgvzXr5u/VHdIeUbNlzNdpwAUN
	 uI9jJrODMq3H6gSeylmQ+RAuy5EsIF2nvmd76E9FXPrNhoWmRjLNfHK2i0pjVdp6+E
	 pHnh4niW6sLgO6k2ILVbocHmrB9e5pkVppvihLtIQhSpzCsdw/qLqJDW341PmjUxJG
	 +XnNEqRQ4Nm1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DF7580E5C;
	Wed, 19 Aug 2026 07:08:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD7DB230
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B332740660
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6t8SDitIFGZI for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 07:08:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=Mn9L+shQ
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C3EF4065E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:08:17 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1787123295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FL6Drxv88A28hDjeOIXo4+RQRd7/9wv28mYYcuZ0k8c=;
 b=Mn9L+shQlCBull58AIscs4iQ8UvVJmUuOW6YIIQM5HycVMTauNoPXBcAdi2vrT4t4coEhZ
 ICedVZH0BAf2oBcMnEVor7jtejyqruWOzw1+9sHKiPALxLT0kk9vHZCyHisO4tUWTf4ilw
 sh2ssqRRkoMygEs+3gK8QbZDnO22XX9HJnlIhQfoG7iVmuEcUNVGK/Rg6/AvC1/FftK3PB
 YkFIu4n7HiFMr5KxwdrHupJaanAiWAvCHc38Akp0IAiYc1aiQDXQWzB0QVk7IcqTl6WE/z
 Fka3iPmccslyvoSKIETfiNOP2SjHY480llGV/V2wNfTNg9iwH+/D3m6agxjHjw==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v2 2/4] ddr: imx: Move error message for failed training to
 calling side
Date: Wed, 19 Aug 2026 09:07:53 +0200
Message-ID: <20260819070758.51350-2-frieder@fris.de>
In-Reply-To: <20260819070758.51350-1-frieder@fris.de>
References: <20260819070758.51350-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Move the error message from wait_ddrphy_training_complete() to the
calling site in ddr_cfg_phy(). This is more robust to future changes
in wait_ddrphy_training_complete() and allows us to make the message
optional.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/ddr/imx/phy/ddrphy_train.c | 4 +++-
 drivers/ddr/imx/phy/ddrphy_utils.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ddr/imx/phy/ddrphy_train.c b/drivers/ddr/imx/phy/ddrphy_train.c
index 63a6ca800a3..68468610fd6 100644
--- a/drivers/ddr/imx/phy/ddrphy_train.c
+++ b/drivers/ddr/imx/phy/ddrphy_train.c
@@ -72,8 +72,10 @@ int ddr_cfg_phy(struct dram_timing_info *dram_timing)
 
 		/* Wait for the training firmware to complete */
 		ret = wait_ddrphy_training_complete();
-		if (ret)
+		if (ret) {
+			printf("Training FAILED\n");
 			return ret;
+		}
 
 		/* Halt the microcontroller. */
 		dwc_ddrphy_apb_wr(0xd0099, 0x1);
diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index 8e350de8315..8779db01607 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -97,7 +97,6 @@ int wait_ddrphy_training_complete(void)
 			debug("Training PASS\n");
 			return 0;
 		} else if (mail == 0xff) {
-			printf("Training FAILED\n");
 			return -1;
 		}
 	}
-- 
2.55.0

