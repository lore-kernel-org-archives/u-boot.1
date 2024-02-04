Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CE0C48286
	for <u-boot@archiver.kernel.org>; Sun,  4 Feb 2024 20:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5246D87C3D;
	Sun,  4 Feb 2024 21:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wszjlZcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21C187C51; Sun,  4 Feb 2024 21:53:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E088787C3F
 for <u-boot@lists.denx.de>; Sun,  4 Feb 2024 21:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbd4=JO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707080011; bh=QvQ+OFe+CgpsC3HXaN85SRTMXYNIaeQbJLKF8FEqLB0=;
 b=wszjlZcB2cGMDmyygnag6of+awBycx5HLXeB403tTiz5Qf1W0vg34d7EnXFvbi/kwNJ11CsMm
 z45vt21MtSTY2kZQuS1nMeFLWIWTI9tVwJiq7P9Vt6Hdi0BQOClTkIXtPpIgrG6QRvgdrdSFo8M
 t1efZg1x66HANe/R6OQlcYEOH7J7vvkhYTFDFvBbBjRnmIMG2yjETvFpXOvtH3dAlRYWJtaZRFZ
 26jPnC8uAJd+MUyezEfwUNuVQviUVsLcVoJzB5aAt9JbgYpsVTzIny5BXWCbharX+vByNF0bOzg
 2QcRuLKdEcEr3g5OD7H85i4wAqBAs9xei46r7JSYxT4Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Weizhao Ouyang
 <o451686892@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 3/3] mmc: rockchip_sdhci: Fix HS400 mode write on RK3568
Date: Sun,  4 Feb 2024 20:53:07 +0000
Message-ID: <20240204205312.2342868-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204205312.2342868-1-jonas@kwiboo.se>
References: <20240204205312.2342868-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65bff94a6f7b756870de3912
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

Testing has shown that writing to eMMC using HS400 modes on RK3568
result in an ERROR.

Change the tap number for transmit clock to fix this.

Also stop DLL when config_dll() is called to disable DLL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- New patch to fix HS400 mode write on RK3568
---
 drivers/mmc/rockchip_sdhci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 285332d9f4fd..706fb1235796 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -71,7 +71,6 @@
 #define DLL_RXCLK_NO_INVERTER		BIT(29)
 #define DLL_RXCLK_ORI_GATE		BIT(31)
 #define DLL_TXCLK_TAPNUM_DEFAULT	0x10
-#define DLL_TXCLK_TAPNUM_90_DEGREES	0x9
 #define DLL_TXCLK_TAPNUM_FROM_SW	BIT(24)
 #define DLL_TXCLK_NO_INVERTER		BIT(29)
 #define DLL_STRBIN_TAPNUM_DEFAULT	0x4
@@ -314,8 +313,10 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
 	int val, ret;
 	u32 extra, txclk_tapnum;
 
-	if (!enable)
+	if (!enable) {
+		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
 		return 0;
+	}
 
 	if (clock >= 100 * MHz) {
 		/* reset DLL */
@@ -648,7 +649,7 @@ static const struct sdhci_data rk3568_data = {
 	.config_dll = rk3568_sdhci_config_dll,
 	.flags = FLAG_INVERTER_FLAG_IN_RXCLK,
 	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
-	.hs400_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
+	.hs400_txclk_tapnum = 0x8,
 };
 
 static const struct sdhci_data rk3588_data = {
@@ -656,7 +657,7 @@ static const struct sdhci_data rk3588_data = {
 	.set_clock = rk3568_sdhci_set_clock,
 	.config_dll = rk3568_sdhci_config_dll,
 	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
-	.hs400_txclk_tapnum = DLL_TXCLK_TAPNUM_90_DEGREES,
+	.hs400_txclk_tapnum = 0x9,
 };
 
 static const struct udevice_id sdhci_ids[] = {
-- 
2.43.0

