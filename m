Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D80EC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14A22807F9;
	Thu, 23 Jan 2025 23:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fnaRxQxJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60D58083F; Thu, 23 Jan 2025 23:49:22 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A1C880214
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737672559; bh=FCyD5QZ01F+uZi+Dv/Kz/oeZ+49yk68vT4F5WENyRwY=;
 b=fnaRxQxJe8TED77i98v/hGIPxpiOblD/jBo1vcObXNkDtQqRuHF0GUrd1bVVCTfRlOhYhvFHV
 ntJTZv/8M7wxqdxVl1tpwORQ8Q/3FyC8PEAlqGGVes73TnOFvt6TV6fdn59d3o0tvoFcOr1pPkG
 1Q1Ajp/coNFJ7X4q0H1HhzLXqMJltkw9bvPCZqzH54C8hQosnW0wsu2fFVph4vFmhgAMS0+cd9O
 i8sQHU+ogXb+CqFjjzSWML9aVkTLSkNlEYOstrM+miBTK38kfTkTdnTNT3+uUA7yoCr9xURIU3f
 1y26IhCEB5jnUt8ibfjCtgb7ZdATLJ38do3SWxcQdbFA==
X-Forward-Email-ID: 6792c76af07771e5c89e0182
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
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
Subject: [PATCH 07/13] mmc: rockchip_sdhci: Add initial support for RK3528
Date: Thu, 23 Jan 2025 22:48:19 +0000
Message-ID: <20250123224844.3104592-8-jonas@kwiboo.se>
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

Add initial support for SDHCI controller in RK3528.

Only MMC Legacy and MMC High Speed (52MHz) mode is supported after this,
more work is needed to get the faster HS200/HS400/HS400ES modes working.

Variant tap and delay num is copied from vendor Linux tag
linux-6.1-stan-rkr5.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
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
2.48.1

