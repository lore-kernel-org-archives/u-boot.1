Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26248C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B5180F88;
	Wed, 26 Feb 2025 12:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA6E980F3F; Wed, 26 Feb 2025 12:37:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A880380977
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 141521BA8;
 Wed, 26 Feb 2025 03:37:39 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 803593F673;
 Wed, 26 Feb 2025 03:37:21 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Kuba=20Szczodrzy=C5=84ski?= <kuba@szczodrzynski.pl>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <icenowy@aosc.io>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: [PATCH 1/2] sunxi: mmc: Fix T113-s3 MMC clock divider
Date: Wed, 26 Feb 2025 11:37:11 +0000
Message-Id: <20250226113712.1257061-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226113712.1257061-1-andre.przywara@arm.com>
References: <20250226113712.1257061-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On the Allwinner D1/R528/T113-s3 SoCs the MMC clock source selected by
mux value 1 is PLL_PERIPH0(1x), not (2x), as in the other SoCs.
But we have still the hidden divisor of 2 in the MMC mod clock, so
need to explicitly compensate for that on those SoCs.

This leads to the actually programmed clock rate to be double compared
to before, which increases the MMC performance on those SoCs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reported-by: Kuba Szczodrzyński <kuba@szczodrzynski.pl>
---
 drivers/mmc/sunxi_mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 0b56d1405be..8f72d758e46 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -92,6 +92,13 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 		pll = CCM_MMC_CTRL_PLL6;
 		pll_hz = clock_get_pll6();
 #endif
+		/*
+		 * On the D1/R528/T113 mux source 1 refers to PLL_PERIPH0(1x),
+		 * like for the older SoCs. However we still have the hidden
+		 * divider of 2x, so compensate for that here.
+		 */
+		if (IS_ENABLED(CONFIG_MACH_SUN8I_R528))
+			pll_hz /= 2;
 	}
 
 	div = pll_hz / hz;
-- 
2.25.1

