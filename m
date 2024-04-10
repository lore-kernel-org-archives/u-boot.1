Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E614CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 14:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF00887F52;
	Wed, 10 Apr 2024 16:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Lob6YUXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9793D88176; Wed, 10 Apr 2024 16:31:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 090D087EEB
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 16:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=07fb=LQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1712759459;
 bh=6nJeTbVP6uBDQsK4wpIVeeLsSOsVcwx3evYxgqXijB8=;
 b=Lob6YUXsxDDxCVH7fE15ffL/n3coAxXdxCwZJIrqfCfIY2W6RkR6YhZBKobAjzLGp68L3EHHI
 HEaucGGjkuLfFPhDFiuFTzYkPFRoGRfs+DxHXkEo7y+Qnq04LANJ9hr0YcCxT/WcHvHHvR7dtSR
 S8uSTSB5c+w4hE9i+Ii2l+mnPb3XVN3kLsJw208K1Tcp5BXyEWvloTijrz3gYL7E/vtFpGjkULj
 QYDwamUrAo7MD6pw7Jf7fvrdKfpo0SgWTV9eD9U7l5eHAw4ZEpvZsqszQGPifFkMefd6m8ypz1q
 F+kNSnjAQCcl/Vae1Pf4gQR5y1CrFjJspXsD8mEhr8MQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2] mmc: rockchip_sdhci: Fix 4 blocks PIO mode read limit for
 RK35xx
Date: Wed, 10 Apr 2024 14:30:50 +0000
Message-ID: <20240410143052.227908-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6616a2a254677331f57e6f40
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

The commit 2cc6cde647e2 ("mmc: rockchip_sdhci: Limit number of blocks
read in a single command") introduced a limit of number of blocks to
read to fix a Data End Bit Error on RK3568 and RK3588. This had a side
affect of significant slowing down reading FIT from eMMC.

After the commit 6de9d7b2f13c ("rockchip: rk35xx: Enable eMMC HS200 mode
by default") the limit of number of blocks to read workaround is no
longer necessary and at HS200+ a Data End Bit Error is no longer
happening using PIO mode.

Change this limitation to allow reading more than 4 blocks with a single
CMD18 command in PIO mode at HS200+ speed, keep using the 4 blocks
limitation when loadig FIT from eMMC at lower speed than HS200.

Fixes: 2cc6cde647e2 ("mmc: rockchip_sdhci: Limit number of blocks read in a single command")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Move cfg->b_max configuration to set_ios_post() ops

This significantly speed up FIT loading from eMMC on RK3588 boards with
a mmc-hs200 prop in the sdhci node, and boards without a mmc-hs200 prop
continue to work.
---
 drivers/mmc/rockchip_sdhci.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 706fb1235796..c889c7bc9855 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -391,6 +391,8 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
 static int rk3568_sdhci_set_ios_post(struct sdhci_host *host)
 {
 	struct mmc *mmc = host->mmc;
+	struct rockchip_sdhc_plat *plat = dev_get_plat(mmc->dev);
+	struct mmc_config *cfg = &plat->cfg;
 	u32 reg;
 
 	reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
@@ -437,6 +439,20 @@ static int rk3568_sdhci_set_ios_post(struct sdhci_host *host)
 
 	sdhci_writew(host, reg, DWCMSHC_EMMC_EMMC_CTRL);
 
+	/*
+	 * Reading more than 4 blocks with a single CMD18 command in PIO mode
+	 * triggers Data End Bit Error using a slower mode than HS200. Limit to
+	 * reading max 4 blocks in one command when using PIO mode.
+	 */
+	if (!(host->flags & USE_DMA)) {
+		if (mmc->selected_mode == MMC_HS_200 ||
+		    mmc->selected_mode == MMC_HS_400 ||
+		    mmc->selected_mode == MMC_HS_400_ES)
+			cfg->b_max = CONFIG_SYS_MMC_MAX_BLK_COUNT;
+		else
+			cfg->b_max = 4;
+	}
+
 	return 0;
 }
 
@@ -598,16 +614,6 @@ static int rockchip_sdhci_probe(struct udevice *dev)
 	    dev_read_bool(dev, "u-boot,spl-fifo-mode"))
 		host->flags &= ~USE_DMA;
 
-	/*
-	 * Reading more than 4 blocks with a single CMD18 command in PIO mode
-	 * triggers Data End Bit Error on RK3568 and RK3588. Limit to reading
-	 * max 4 blocks in one command when using PIO mode.
-	 */
-	if (!(host->flags & USE_DMA) &&
-	    (device_is_compatible(dev, "rockchip,rk3568-dwcmshc") ||
-	     device_is_compatible(dev, "rockchip,rk3588-dwcmshc")))
-		cfg->b_max = 4;
-
 	return sdhci_probe(dev);
 }
 
-- 
2.43.2

