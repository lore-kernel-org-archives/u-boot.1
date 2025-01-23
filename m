Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA93C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5622D807E4;
	Thu, 23 Jan 2025 23:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IN6n+WgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2405080214; Thu, 23 Jan 2025 23:49:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FB4807A8
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737672556; bh=F/U1rkLdRGRLDXBi+jK7Fn+OQy/UPAQdvCgvFC7BEgk=;
 b=IN6n+WgT5dX1qRREO5QemFda6XfHDk40vWiwgcTWMrrVv/In5J+k4xoXtaE5dvGsVDl7T8f9A
 EvMo0pjEpEMe/8R+DI6oe/WlRBIi86Sx2T1AuAJyySi2dcDlZGz3/Rt3wmP1NfXV1XC3tLbEP+4
 NsRhxLntSyxsYPLIWDITT8XDQ8dG7sEKQWYQdGqrpLrzENpfGF7NoGMPI19RbVSGqkeMr54wyul
 qLaGJISF9hVSkI2nU3blAmu2y/QXQTMOVu/SQakww5Wpda5scSftBya9btq49bw52nU3AtZROGk
 DilJkK250GYC3fdbRGI0UHjOx2iw6Xwwv1+oOFCYUR0g==
X-Forward-Email-ID: 6792c767f07771e5c89e0171
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 06/13] mmc: rockchip_sdhci: Extend variant configuration
Date: Thu, 23 Jan 2025 22:48:18 +0000
Message-ID: <20250123224844.3104592-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123224844.3104592-1-jonas@kwiboo.se>
References: <20250123224844.3104592-1-jonas@kwiboo.se>
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
2.48.1

