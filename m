Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80BBE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 19:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF60802EF;
	Wed, 18 Dec 2024 20:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61147802F2; Wed, 18 Dec 2024 20:42:30 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE7180291
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 20:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1tNzwA-002gK3-7X;
 Wed, 18 Dec 2024 19:42:26 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] spi: mxc_spi: use proper clock for SPI bus
Date: Wed, 18 Dec 2024 11:42:24 -0800
Message-Id: <20241218194224.1867039-1-tharvey@gateworks.com>
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

The mxc_get_clock function is around for compatibility with older
drivers that are not clock aware. In this case asking for the clk for
MXC_CSPI_CLK does not take into account there are multiple SPI busses on
modern IMX SoC's and it will return the clock for the first bus which
may not be used or configured.

In the case you are not using the first bus you will not get the proper
clock. Fix this by obtaining the clock rate from the bus clock.

This resolves an invalid SPI clock frequency configuration for SPI2 on a
board where SPI1 is not used.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/spi/mxc_spi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/mxc_spi.c b/drivers/spi/mxc_spi.c
index 9ab39a188b22..2c9b0ada87ba 100644
--- a/drivers/spi/mxc_spi.c
+++ b/drivers/spi/mxc_spi.c
@@ -114,6 +114,9 @@ struct mxc_spi_slave {
 	u32		ctrl_reg;
 #if defined(MXC_ECSPI)
 	u32		cfg_reg;
+#endif
+#if CONFIG_IS_ENABLED(CLK)
+	struct clk	clk;
 #endif
 	int		gpio;
 	int		ss_pol;
@@ -214,7 +217,11 @@ static s32 spi_cfg_mxc(struct mxc_spi_slave *mxcs, unsigned int cs)
 #ifdef MXC_ECSPI
 static s32 spi_cfg_mxc(struct mxc_spi_slave *mxcs, unsigned int cs)
 {
+#if CONFIG_IS_ENABLED(CLK)
+	u32 clk_src = clk_get_rate(&mxcs->clk);
+#else
 	u32 clk_src = mxc_get_clock(MXC_CSPI_CLK);
+#endif
 	s32 reg_ctrl, reg_config;
 	u32 ss_pol = 0, sclkpol = 0, sclkpha = 0, sclkctl = 0;
 	u32 pre_div = 0, post_div = 0;
@@ -599,14 +606,13 @@ static int mxc_spi_probe(struct udevice *bus)
 		return -ENODEV;
 
 #if CONFIG_IS_ENABLED(CLK)
-	struct clk clk;
-	ret = clk_get_by_index(bus, 0, &clk);
+	ret = clk_get_by_index(bus, 0, &mxcs->clk);
 	if (ret)
 		return ret;
 
-	clk_enable(&clk);
+	clk_enable(&mxcs->clk);
 
-	mxcs->max_hz = clk_get_rate(&clk);
+	mxcs->max_hz = clk_get_rate(&mxcs->clk);
 #else
 	int node = dev_of_offset(bus);
 	const void *blob = gd->fdt_blob;
-- 
2.25.1

