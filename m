Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAD6E743C9
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 21:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96FB586ECA;
	Thu, 28 Sep 2023 23:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB17586ECB; Thu, 28 Sep 2023 23:56:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AB24686EC9
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 23:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8161F1007;
 Thu, 28 Sep 2023 14:57:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A0D03F59C;
 Thu, 28 Sep 2023 14:56:34 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@arm.com, andre.przywara@foss.arm.com
Subject: [PATCH v2 18/22] sunxi: R528: add SMHC2 pin pull ups support
Date: Thu, 28 Sep 2023 22:54:51 +0100
Message-Id: <20230928215455.28094-19-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20230928215455.28094-1-andre.przywara@arm.com>
References: <20230928215455.28094-1-andre.przywara@arm.com>
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

From: Okhunjon Sobirjonov <okhunjon72@gmail.com>

Add support for eMMC (SMHC2) pin pull ups for R528 boards.

The D1 and T113s (and even R329) SoCs do not support 8-bit eMMC anymore,
so it's just four data pins to cover here.

Signed-off-by: Okhunjon Sobirjonov <Okhunjon.Sobirjonov@Mec-electronics.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
[Andre: adjust commit message]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 board/sunxi/board.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 7a1c708b9f2..39ecbe988f7 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -459,6 +459,13 @@ static void mmc_pinmux_setup(int sdc)
 			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
 			sunxi_gpio_set_drv(pin, 2);
 		}
+#elif defined(CONFIG_MACH_SUN8I_R528)
+                /* SDC2: PC2-PC7 */
+                for (pin = SUNXI_GPC(2); pin <= SUNXI_GPC(7); pin++) {
+                        sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+                        sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+                        sunxi_gpio_set_drv(pin, 2);
+                }
 #else
 		puts("ERROR: No pinmux setup defined for MMC2!\n");
 #endif
-- 
2.35.8

