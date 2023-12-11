Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52470C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 13:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A292087682;
	Mon, 11 Dec 2023 14:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE1487716; Mon, 11 Dec 2023 03:23:11 +0100 (CET)
Received: from mdcsw (unknown [202.188.176.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9C69876F2
 for <U-Boot@lists.denx.de>; Mon, 11 Dec 2023 03:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom="junliang.tan@sw_buildbot"@starfivetech.com
Received: by mdcsw (Postfix, from userid 5274)
 id AC0CD2C841ED; Mon, 11 Dec 2023 10:23:04 +0800 (CST)
From: Jun Liang Tan <junliang.tan@starfivetech.com>
To: U-Boot@lists.denx.de
Cc: cheehong.ang@starfivetech.com, junliang.tan@starfivetech.com,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>
Subject: [PATCH v2] timer: starfive: Add Starfive timer support
Date: Mon, 11 Dec 2023 10:22:10 +0800
Message-Id: <20231211022210.3880678-1-junliang.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Dec 2023 14:47:26 +0100
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

From: Kuan Lim Lee <kuanlim.lee@starfivetech.com>

Add timer driver in Starfive SoC. It is an timer that outside
of CPU core and inside Starfive SoC.

Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
Signed-off-by: Wei Liang Lim <weiliang.lim@starfivetech.com>

Changes for v2:
- correct driver name, comment, variable
---
 drivers/timer/starfive-timer.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/timer/starfive-timer.c b/drivers/timer/starfive-timer.c
index 816402fdbf..6ac7d7f1d0 100644
--- a/drivers/timer/starfive-timer.c
+++ b/drivers/timer/starfive-timer.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2022 StarFive, Inc. All rights reserved.
- *   Author: Lee Kuan Lim <kuanlim.lee@starfivetech.com>
+ *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
  */
 
 #include <common.h>
@@ -48,8 +48,8 @@ static int starfive_probe(struct udevice *dev)
 	int ret;
 
 	priv->base = dev_read_addr_ptr(dev);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	if (!priv->base)
+		return -EINVAL;
 
 	timer_channel = dev_read_u32_default(dev, "channel", 0);
 	priv->base = priv->base + (0x40 * timer_channel);
@@ -64,14 +64,16 @@ static int starfive_probe(struct udevice *dev)
 		return ret;
 	uc_priv->clock_rate = clk_get_rate(&clk);
 
-	/* Initiate timer, channel 0 */
-	/* Unmask Interrupt Mask */
+	/*
+	 * Initiate timer, channel 0
+	 * Unmask Interrupt Mask
+	 */
 	writel(0, priv->base + STF_TIMER_INT_MASK);
 	/* Single run mode Setting */
 	if (dev_read_bool(dev, "single-run"))
 		writel(1, priv->base + STF_TIMER_CTL);
 	/* Set Reload value */
-	priv->timer_size = dev_read_u32_default(dev, "timer-size", 0xffffffff);
+	priv->timer_size = dev_read_u32_default(dev, "timer-size", -1U);
 	writel(priv->timer_size, priv->base + STF_TIMER_LOAD);
 	/* Enable to start timer */
 	writel(1, priv->base + STF_TIMER_ENABLE);
@@ -85,7 +87,7 @@ static const struct udevice_id starfive_ids[] = {
 };
 
 U_BOOT_DRIVER(jh8100_starfive_timer) = {
-	.name		= "jh8100_starfive_timer",
+	.name		= "starfive_timer",
 	.id		= UCLASS_TIMER,
 	.of_match	= starfive_ids,
 	.probe		= starfive_probe,
-- 
2.25.1

