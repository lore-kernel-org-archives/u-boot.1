Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D14C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D25C6831A2;
	Tue,  8 Apr 2025 00:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="E/fpUS9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF0CF831C4; Tue,  8 Apr 2025 00:49:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 417D7831D3
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066149; bh=g1bE8RpJLz0UWxq09AxBHn6FjRrzVpSoyXEgg29uELI=;
 b=E/fpUS9RLFs5lefhtp/bVAWvL/1igbXikLZtecwijgIkzBIvPVD7ojzwiicJvqpzp5y7nSWOa
 l3M+1mMJZsUJL0/QY3fxn8iygRoLJUQamD+ylmyYqQhIy2/BGxFz1V8Q0yCKceZ2iSkLiBsAxyJ
 43bnuyOAS7vFue68q9Ew2LzZUtPX78r0cFfiiJMn5HNdSqAfuHx0q10qvGp1TTYhfjQHvpNLvlh
 MF1amKls1DQGtbQ8MkTq2LmBAbzrcQweze2jhtORV8HrA20W5znlukFvDok3y7Zw+fj/tNZg6Z5
 DG4aEzwf9yW1tuFVNLedt7xl+gEHklZXagtT7a5+o5Gg==
X-Forward-Email-ID: 67f456649fd75b9b96512943
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH v2 21/30] mmc: rockchip_sdhci: Add initial support for RK3528
Date: Mon,  7 Apr 2025 22:46:54 +0000
Message-ID: <20250407224743.2423921-22-jonas@kwiboo.se>
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

Add initial support for SDHCI controller in RK3528.

Only MMC Legacy and MMC High Speed (52MHz) mode is supported after this,
more work is needed to get the faster HS200/HS400/HS400ES modes working.

Variant tap and delay num is copied from vendor Linux tag
linux-6.1-stan-rkr5.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/mmc/rockchip_sdhci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 4968404bfaed..2c54b8a942da 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -650,6 +650,17 @@ static const struct sdhci_data rk3399_data = {
 	.set_enhanced_strobe = rk3399_sdhci_set_enhanced_strobe,
 };
 
+static const struct sdhci_data rk3528_data = {
+	.set_ios_post = rk3568_sdhci_set_ios_post,
+	.set_clock = rk3568_sdhci_set_clock,
+	.config_dll = rk3568_sdhci_config_dll,
+	.hs200_txclk_tapnum = 0xc,
+	.hs400_txclk_tapnum = 0x6,
+	.hs400_cmdout_tapnum = 0x6,
+	.hs400_strbin_tapnum = 0x3,
+	.ddr50_strbin_delay_num = 0xa,
+};
+
 static const struct sdhci_data rk3568_data = {
 	.set_ios_post = rk3568_sdhci_set_ios_post,
 	.set_clock = rk3568_sdhci_set_clock,
@@ -678,6 +689,10 @@ static const struct udevice_id sdhci_ids[] = {
 		.compatible = "arasan,sdhci-5.1",
 		.data = (ulong)&rk3399_data,
 	},
+	{
+		.compatible = "rockchip,rk3528-dwcmshc",
+		.data = (ulong)&rk3528_data,
+	},
 	{
 		.compatible = "rockchip,rk3568-dwcmshc",
 		.data = (ulong)&rk3568_data,
-- 
2.49.0

