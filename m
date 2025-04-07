Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8177FC369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281BB83211;
	Tue,  8 Apr 2025 00:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="l96/FLSn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8FBD831D3; Tue,  8 Apr 2025 00:49:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CFA1831F5
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066149; bh=v/tr0ORQozLwulz+yn0ulw8FJfSlUdiOuJRksiI1fbU=;
 b=l96/FLSn9DYhi5VVNIhCjR0h3NHFMi/NQqfS+vTrQcshSFHBI12MvR7CXhfGJegBDwANh5LTo
 g9/zCjzCK2pbaz/76xEr1SrawSa1eed0bbpGaL9fdNiIyl27Wv3gKr+UD6Cu1zdn3aYChzqqEJr
 HySjAgQfLjyxC4ShR9nqn2DP3UGdxnZ43ofnJioD895PgD5dCB1ov8jLj82bVVPOeIMOUJqHNjO
 3Zz2ZwrCGLHOkZgafdDnYnc+85txbht5/ks57Jjsh+vpFyX0dtsEI8DKn/75yqVETJEPC/smvYc
 MPMUZQu1cU7fv3TtOEyf6S1aDJwqhXM5/6mWx5zbr8VA==
X-Forward-Email-ID: 67f456609fd75b9b9651291e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 20/30] mmc: rockchip_sdhci: Extend variant configuration
Date: Mon,  7 Apr 2025 22:46:53 +0000
Message-ID: <20250407224743.2423921-21-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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

RK3528 and RK3576 use different tap and delay num for cmdout and strbin.

Move tap and delay num for cmdout and strbin to driver data to prepare
for adding new SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/mmc/rockchip_sdhci.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index da630b9d97a2..4968404bfaed 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -156,6 +156,9 @@ struct sdhci_data {
 	u32 flags;
 	u8 hs200_txclk_tapnum;
 	u8 hs400_txclk_tapnum;
+	u8 hs400_cmdout_tapnum;
+	u8 hs400_strbin_tapnum;
+	u8 ddr50_strbin_delay_num;
 };
 
 static void rk3399_emmc_phy_power_on(struct rockchip_emmc_phy *phy, u32 clock)
@@ -348,7 +351,7 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
 			extra = DLL_CMDOUT_SRC_CLK_NEG |
 				DLL_CMDOUT_BOTH_CLK_EDGE |
 				DWCMSHC_EMMC_DLL_DLYENA |
-				DLL_CMDOUT_TAPNUM_90_DEGREES |
+				data->hs400_cmdout_tapnum |
 				DLL_CMDOUT_TAPNUM_FROM_SW;
 			sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_CMDOUT);
 		}
@@ -360,7 +363,7 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
 		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
 
 		extra = DWCMSHC_EMMC_DLL_DLYENA |
-			DLL_STRBIN_TAPNUM_DEFAULT |
+			data->hs400_strbin_tapnum |
 			DLL_STRBIN_TAPNUM_FROM_SW;
 		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
 	} else {
@@ -380,7 +383,7 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
 		 */
 		extra = DWCMSHC_EMMC_DLL_DLYENA |
 			DLL_STRBIN_DELAY_NUM_SEL |
-			DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
+			data->ddr50_strbin_delay_num << DLL_STRBIN_DELAY_NUM_OFFSET;
 		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
 	}
 
@@ -654,6 +657,9 @@ static const struct sdhci_data rk3568_data = {
 	.flags = FLAG_INVERTER_FLAG_IN_RXCLK,
 	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
 	.hs400_txclk_tapnum = 0x8,
+	.hs400_cmdout_tapnum = DLL_CMDOUT_TAPNUM_90_DEGREES,
+	.hs400_strbin_tapnum = DLL_STRBIN_TAPNUM_DEFAULT,
+	.ddr50_strbin_delay_num = DLL_STRBIN_DELAY_NUM_DEFAULT,
 };
 
 static const struct sdhci_data rk3588_data = {
@@ -662,6 +668,9 @@ static const struct sdhci_data rk3588_data = {
 	.config_dll = rk3568_sdhci_config_dll,
 	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
 	.hs400_txclk_tapnum = 0x9,
+	.hs400_cmdout_tapnum = DLL_CMDOUT_TAPNUM_90_DEGREES,
+	.hs400_strbin_tapnum = DLL_STRBIN_TAPNUM_DEFAULT,
+	.ddr50_strbin_delay_num = DLL_STRBIN_DELAY_NUM_DEFAULT,
 };
 
 static const struct udevice_id sdhci_ids[] = {
-- 
2.49.0

