Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821D3C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 16:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E77CD83653;
	Thu, 10 Jul 2025 18:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LtRVKX4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C21283666; Thu, 10 Jul 2025 18:21:28 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEBBC8362C
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 18:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5b30=ZY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1752164484;
 bh=mbDvDAZWN2/KxiC/LCn3GP1hIMVQKHjHA5D6s21+TGU=;
 b=LtRVKX4gB9o9kQNt3IFN6lEgAklYLKMywpEpaNhPYNZpvFlXaE1ynTs9O4+FvCM4KUM9syFh1
 GzN1Bck6v31FnxIEZmh7xymzTgluzPorXyS12LKL4BKUg9619s9lkB20QrBFnz8p1be+FqNRp6d
 mul+2l63A1GnsomuE2HAh5nKJ5+Cn0SyGo1xWhZc/xQMKYq7cTD7erFvNW5pybTEk2g4HUVevEq
 abAOmiTMexAMQduDpJlKtpBg5mWP/KcKMbTmMLkwgNfI+g6KDixbu6LTCJ8G+ixsCN27iP4ZA2r
 oS6UaV7FNWEPIXzzyJoweYIKM8RPfPhIDxYPgmCUVnZw==
X-Forward-Email-ID: 686fe87fea2ef028c1d81800
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528
Date: Thu, 10 Jul 2025 16:21:07 +0000
Message-ID: <20250710162110.3592089-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

eMMC erase and write support on RK3528 is somewhat unreliable, sometime
e.g. mmc erase and write commands will fail with an error.

Use the delay line lock value for half card clock cycle, DLL_LOCK_VALUE,
to set a manual xx_TAP_VALUE to fix the unreliable eMMC support.

This is only enabled for RK3528, remaining SoCs still use the automatic
tap value, (DLL_LOCK_VALUE * 2) % 256, same value we configure manually
for RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/mmc/rockchip_sdhci.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 761e3619329c..f15ea7c9c6b7 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -86,13 +86,19 @@
 #define DLL_CMDOUT_SRC_CLK_NEG		BIT(28)
 #define DLL_CMDOUT_EN_SRC_CLK_NEG	BIT(29)
 #define DLL_CMDOUT_BOTH_CLK_EDGE	BIT(30)
+#define DLL_TAP_VALUE_SEL		BIT(25)
+#define DLL_TAP_VALUE_OFFSET		8
+#define DLL_LOCK_VALUE_MASK		0xFF
 
+#define DLL_LOCK_VALUE(x) \
+	((((x) & DLL_LOCK_VALUE_MASK) * 2) & DLL_LOCK_VALUE_MASK)
 #define DLL_LOCK_WO_TMOUT(x) \
 	((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
 	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
 #define ROCKCHIP_MAX_CLKS		3
 
 #define FLAG_INVERTER_FLAG_IN_RXCLK	BIT(0)
+#define FLAG_TAP_VALUE_SEL		BIT(1)
 
 struct rockchip_sdhc_plat {
 	struct mmc_config cfg;
@@ -317,7 +323,7 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
 	struct sdhci_data *data = (struct sdhci_data *)dev_get_driver_data(priv->dev);
 	struct mmc *mmc = host->mmc;
 	int val, ret;
-	u32 extra, txclk_tapnum;
+	u32 extra, txclk_tapnum, dll_tap_value;
 
 	if (!enable) {
 		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
@@ -347,7 +353,15 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
 		if (ret)
 			return ret;
 
-		extra = DWCMSHC_EMMC_DLL_DLYENA | DLL_RXCLK_ORI_GATE;
+		if (data->flags & FLAG_TAP_VALUE_SEL)
+			dll_tap_value = DLL_TAP_VALUE_SEL |
+					DLL_LOCK_VALUE(val) << DLL_TAP_VALUE_OFFSET;
+		else
+			dll_tap_value = 0;
+
+		extra = DWCMSHC_EMMC_DLL_DLYENA |
+			DLL_RXCLK_ORI_GATE |
+			dll_tap_value;
 		if (data->flags & FLAG_INVERTER_FLAG_IN_RXCLK)
 			extra |= DLL_RXCLK_NO_INVERTER;
 		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
@@ -361,19 +375,22 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
 				DLL_CMDOUT_BOTH_CLK_EDGE |
 				DWCMSHC_EMMC_DLL_DLYENA |
 				data->hs400_cmdout_tapnum |
-				DLL_CMDOUT_TAPNUM_FROM_SW;
+				DLL_CMDOUT_TAPNUM_FROM_SW |
+				dll_tap_value;
 			sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_CMDOUT);
 		}
 
 		extra = DWCMSHC_EMMC_DLL_DLYENA |
 			DLL_TXCLK_TAPNUM_FROM_SW |
 			DLL_TXCLK_NO_INVERTER |
-			txclk_tapnum;
+			txclk_tapnum |
+			dll_tap_value;
 		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
 
 		extra = DWCMSHC_EMMC_DLL_DLYENA |
 			data->hs400_strbin_tapnum |
-			DLL_STRBIN_TAPNUM_FROM_SW;
+			DLL_STRBIN_TAPNUM_FROM_SW |
+			dll_tap_value;
 		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
 	} else {
 		/*
@@ -663,6 +680,7 @@ static const struct sdhci_data rk3528_data = {
 	.set_ios_post = rk3568_sdhci_set_ios_post,
 	.set_clock = rk3568_sdhci_set_clock,
 	.config_dll = rk3568_sdhci_config_dll,
+	.flags = FLAG_TAP_VALUE_SEL,
 	.hs200_txclk_tapnum = 0xc,
 	.hs400_txclk_tapnum = 0x6,
 	.hs400_cmdout_tapnum = 0x6,
-- 
2.49.0

