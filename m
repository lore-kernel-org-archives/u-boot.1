Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B3CC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF6F83277;
	Tue,  8 Apr 2025 00:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="E4rN0ZIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24ABB831B0; Tue,  8 Apr 2025 00:49:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B65D383214
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066154; bh=1Je1E8Co0ZQ39LMKYDWANOChsguFCEITD9bLFJmB2Bk=;
 b=E4rN0ZIhYPE38mjk6vZ7ODjh/CrJBU8wQDvZIXUSGo6UbjZh2bFEs+GVBhxyA9YzeSo0uOyAc
 A1A/JBGAXACxJkIAxQvlOiPhmb+VXDjEaI76ZstztLg/qlIe+/2vH3wRhCca27k48zX+gkP0aqN
 SOMu8oNfryLhOtdoiEMK71XfXHjn+O7iwuxxLNeVCG+SZhaIbIVCrrqp7IAoncmzvdkBDmZGQns
 RDln5EPtvcKcvM336wEBiAWuTWaEuzqot+JKT+qAng4QisYAUS+JLEyuv+JAW9f2mvFSF+71oNY
 JoRMXavbPNbbXJffIOkwc7/0VdyyQwegJ9wFmTXZ+Pjw==
X-Forward-Email-ID: 67f456679fd75b9b96512958
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
Subject: [PATCH v2 22/30] mmc: rockchip_sdhci: Gate clock for glitch free
 phase switching
Date: Mon,  7 Apr 2025 22:46:55 +0000
Message-ID: <20250407224743.2423921-23-jonas@kwiboo.se>
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

Enable clock stopping to gate clock during phase code change to ensure
glitch free phase switching in auto-tuning circuit. Fixes HS200 mode
on RK3528.

POST_CHANGE_DLY
Time taken for phase switching and stable clock output.
- Less than 4-cycle latency

PRE_CHANGE_DLY
Maximum Latency specification between transmit clock and receive clock.
- Less than 4-cycle latency

TUNE_CLK_STOP_EN
Clock stopping control for Tuning and auto-tuning circuit. When enabled,
clock gate control output is pulled low before changing phase select
codes. This effectively stops the receive clock. Changing phase code
when clocks are stopped ensures glitch free phase switching.
- Clocks stopped during phase code change

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/mmc/rockchip_sdhci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 2c54b8a942da..c0f986784366 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -50,6 +50,10 @@
 #define DWCMSHC_EMMC_EMMC_CTRL		0x52c
 #define DWCMSHC_CARD_IS_EMMC		BIT(0)
 #define DWCMSHC_ENHANCED_STROBE		BIT(8)
+#define DWCMSHC_EMMC_AT_CTRL		0x540
+#define EMMC_AT_CTRL_TUNE_CLK_STOP_EN	BIT(16)
+#define EMMC_AT_CTRL_PRE_CHANGE_DLY	17
+#define EMMC_AT_CTRL_POST_CHANGE_DLY	19
 #define DWCMSHC_EMMC_DLL_CTRL		0x800
 #define DWCMSHC_EMMC_DLL_CTRL_RESET	BIT(1)
 #define DWCMSHC_EMMC_DLL_RXCLK		0x804
@@ -326,6 +330,11 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
 		udelay(1);
 		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
 
+		extra = 0x3 << EMMC_AT_CTRL_POST_CHANGE_DLY |
+			0x3 << EMMC_AT_CTRL_PRE_CHANGE_DLY |
+			EMMC_AT_CTRL_TUNE_CLK_STOP_EN;
+		sdhci_writel(host, extra, DWCMSHC_EMMC_AT_CTRL);
+
 		/* Init DLL settings */
 		extra = DWCMSHC_EMMC_DLL_START_DEFAULT << DWCMSHC_EMMC_DLL_START_POINT |
 			DWCMSHC_EMMC_DLL_INC_VALUE << DWCMSHC_EMMC_DLL_INC |
-- 
2.49.0

