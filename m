Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8E3D7876B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 876D18977C;
	Thu, 21 Nov 2024 15:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="k34k13Jh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B6E89766; Thu, 21 Nov 2024 15:31:20 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E8F8977C
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/NVDSGvmNYc0TZd/8Vq2OgluRX+d0C6h3CiQMQyIElw=; b=k34k13JhYC7griUeYIoIZKLtQD
 MI3EZnt1+R/TrrJ7a1GEjZEGQ+/HJmApSDUXeNpCygKhE9wQu6iKb6f7NP5jAsxXjQrvydyriP6yO
 oZFs4At8ZTbPY6XNGlFcKKifIcjRAV/8pnp6yCw0atGXsGQjre8AfZKuDo/++5M5IpiJpq7jtQDYE
 Fdxm20VKAtJHC65kRi2SuIOcbfgTFaklIIeh7xdktxXhiXpTTy7Idb5IOSFIBXZt+bWjhRMSIa5Qz
 kFfC040Z8qw/d4MbYKmetb1yTxqnSKCQwnvDHC5ixBHMpXfdmEVbFMQQKlbaoqBn+2VOSmLobutcB
 WiXY3FwA==;
Received: from [185.156.123.69] (helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tE8A6-0007f9-JP; Thu, 21 Nov 2024 15:28:02 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH 17/20] mmc: rockchip_sdhci: Add support for RK3576
Date: Thu, 21 Nov 2024 15:27:28 +0100
Message-ID: <20241121142731.1202209-18-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142731.1202209-1-heiko@sntech.de>
References: <20241121142731.1202209-1-heiko@sntech.de>
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
---
 drivers/mmc/rockchip_sdhci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index da630b9d97a..9571e7d66c9 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -656,6 +656,14 @@ static const struct sdhci_data rk3568_data = {
 	.hs400_txclk_tapnum = 0x8,
 };
 
+static const struct sdhci_data rk3576_data = {
+	.set_ios_post = rk3568_sdhci_set_ios_post,
+	.set_clock = rk3568_sdhci_set_clock,
+	.config_dll = rk3568_sdhci_config_dll,
+	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
+	.hs400_txclk_tapnum = 0x7,
+};
+
 static const struct sdhci_data rk3588_data = {
 	.set_ios_post = rk3568_sdhci_set_ios_post,
 	.set_clock = rk3568_sdhci_set_clock,
@@ -673,6 +681,10 @@ static const struct udevice_id sdhci_ids[] = {
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
2.45.2

