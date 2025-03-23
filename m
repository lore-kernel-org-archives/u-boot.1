Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD39C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E217881F32;
	Sun, 23 Mar 2025 12:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CB581DDF; Sun, 23 Mar 2025 12:36:38 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BC21781ECD
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBD621595;
 Sun, 23 Mar 2025 04:36:41 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22D943F694;
 Sun, 23 Mar 2025 04:36:34 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev, Stefan Roese <sr@denx.de>
Subject: [PATCH 19/34] watchdog: sunxi: add A523 support
Date: Sun, 23 Mar 2025 11:35:29 +0000
Message-ID: <20250323113544.7933-20-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
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

The Allwinner A523 SoC moved the watchdog into a separate MMIO frame,
and also shifted the registers a bit: the control, config, and mode
register are located four bytes earlier.

Add the new compatible string, and connect it to the new struct
describing the new register layout.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/watchdog/sunxi_wdt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index 8eeac935760..467db5fe9bf 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -153,10 +153,21 @@ static const struct sunxi_wdt_reg sun20i_wdt_reg = {
 	.wdt_key_val		= 0x16aa0000,
 };
 
+static const struct sunxi_wdt_reg sun55i_wdt_reg = {
+	.wdt_ctrl		= 0x0c,
+	.wdt_cfg		= 0x10,
+	.wdt_mode		= 0x14,
+	.wdt_timeout_shift	= 4,
+	.wdt_reset_mask		= 0x03,
+	.wdt_reset_val		= 0x01,
+	.wdt_key_val		= 0x16aa0000,
+};
+
 static const struct udevice_id sunxi_wdt_ids[] = {
 	{ .compatible = "allwinner,sun4i-a10-wdt", .data = (ulong)&sun4i_wdt_reg },
 	{ .compatible = "allwinner,sun6i-a31-wdt", .data = (ulong)&sun6i_wdt_reg },
 	{ .compatible = "allwinner,sun20i-d1-wdt", .data = (ulong)&sun20i_wdt_reg },
+	{ .compatible = "allwinner,sun55i-a523-wdt", .data = (ulong)&sun55i_wdt_reg },
 	{ /* sentinel */ }
 };
 
-- 
2.46.3

