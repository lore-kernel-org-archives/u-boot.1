Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7529EC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 22:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD57187DDF;
	Fri, 21 Jun 2024 00:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BB587F19; Fri, 21 Jun 2024 00:24:49 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9499087D87
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 00:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sKQCz-00FoKl-PA;
 Thu, 20 Jun 2024 22:24:45 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] board: gateworks: venice: Simplify Ethernet initialization
Date: Thu, 20 Jun 2024 15:24:44 -0700
Message-Id: <20240620222444.2447798-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

With DM enabled, there is no need for board code to initialize
the Ethernet interfaces.

Specifically board_interface_eth_init will handle the configuration of
GPR1.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/venice.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/board/gateworks/venice/venice.c b/board/gateworks/venice/venice.c
index 3080ff20cb02..d4c22121497b 100644
--- a/board/gateworks/venice/venice.c
+++ b/board/gateworks/venice/venice.c
@@ -45,22 +45,6 @@ int board_fit_config_name_match(const char *path)
 	return -1;
 }
 
-static int __maybe_unused setup_fec(void)
-{
-	struct iomuxc_gpr_base_regs *gpr =
-		(struct iomuxc_gpr_base_regs *)IOMUXC_GPR_BASE_ADDR;
-
-#ifndef CONFIG_IMX8MP
-	/* Use 125M anatop REF_CLK1 for ENET1, not from external */
-	clrsetbits_le32(&gpr->gpr[1], 0x2000, 0);
-#else
-	/* Enable RGMII TX clk output */
-	setbits_le32(&gpr->gpr[1], BIT(22));
-#endif
-
-	return 0;
-}
-
 #if (IS_ENABLED(CONFIG_NET))
 int board_phy_config(struct phy_device *phydev)
 {
@@ -91,9 +75,6 @@ int board_init(void)
 {
 	venice_eeprom_init(1);
 
-	if (IS_ENABLED(CONFIG_FEC_MXC))
-		setup_fec();
-
 	return 0;
 }
 
-- 
2.25.1

