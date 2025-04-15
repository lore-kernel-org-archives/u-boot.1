Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF95EC369B9
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E12B82C44;
	Tue, 15 Apr 2025 23:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="Phixui7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0AA82BE3; Tue, 15 Apr 2025 23:52:16 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3658D82C67
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=xTHtSOkctv9HNQKu+sQgYtY6ckjwjw3tRjwmf2VegHY=; b=Phixui7yq4N0VUzMvHr+srXV9D
 YHsDZeXxXjfG+KE88JF+SZ8zxNxwG1gyxomB4IdfN2cN3LwE/iREPcvJreDxCSiL+pQORE4IdQwMN
 fUEkPzDziVSKVqVV8/q628fc5j7ERhxy01SJAPzHbBppNJiCchYlleho9wFKA+WlkuyIak6cf9/H3
 pq9+j4b2wcT+CJnYGWr5sA+nRGESxNiAgP0EitxDbx704OHbQp+l/DHUf8iJg29pBUD5KVxr8EN1c
 YW9nFnsiXOyI7s7Um4aLPFmVmuJNPKsUh3iq3GshFMo8y3kiDuoVfO7z43m9YulHF2Q+llee0SsV6
 +JofVBBw==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4oCI-0007Uo-Gr; Tue, 15 Apr 2025 23:52:02 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH v3 09/15] mmc: rockchip_sdhci: Add support for RK3576
Date: Tue, 15 Apr 2025 23:51:22 +0200
Message-ID: <20250415215128.1475593-10-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250415215128.1475593-1-heiko@sntech.de>
References: <20250415215128.1475593-1-heiko@sntech.de>
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

Add support for RK3576 to the rockchip sdhci driver.

It's pretty similar to its cousins found in the RK3568 and RK3588 and the
specific hs400-tx-tap number was taken from the vendor-u-boot.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/mmc/rockchip_sdhci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index c0f98678436..761e3619329 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -682,6 +682,17 @@ static const struct sdhci_data rk3568_data = {
 	.ddr50_strbin_delay_num = DLL_STRBIN_DELAY_NUM_DEFAULT,
 };
 
+static const struct sdhci_data rk3576_data = {
+	.set_ios_post = rk3568_sdhci_set_ios_post,
+	.set_clock = rk3568_sdhci_set_clock,
+	.config_dll = rk3568_sdhci_config_dll,
+	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
+	.hs400_txclk_tapnum = 0x7,
+	.hs400_cmdout_tapnum = 0x7,
+	.hs400_strbin_tapnum = 0x5,
+	.ddr50_strbin_delay_num = 0xa,
+};
+
 static const struct sdhci_data rk3588_data = {
 	.set_ios_post = rk3568_sdhci_set_ios_post,
 	.set_clock = rk3568_sdhci_set_clock,
@@ -706,6 +717,10 @@ static const struct udevice_id sdhci_ids[] = {
 		.compatible = "rockchip,rk3568-dwcmshc",
 		.data = (ulong)&rk3568_data,
 	},
+	{
+		.compatible = "rockchip,rk3576-dwcmshc",
+		.data = (ulong)&rk3576_data,
+	},
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
 		.data = (ulong)&rk3588_data,
-- 
2.47.2

