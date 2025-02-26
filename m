Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E520C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A084B805C3;
	Wed, 26 Feb 2025 12:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9963180FB9; Wed, 26 Feb 2025 12:37:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 897DB8003E
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB3261516;
 Wed, 26 Feb 2025 03:37:40 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A683F673;
 Wed, 26 Feb 2025 03:37:23 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Kuba=20Szczodrzy=C5=84ski?= <kuba@szczodrzynski.pl>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <icenowy@aosc.io>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: [PATCH 2/2] sunxi: sun50i_h6: clock: fix PLL_PERIPH0 rate calculation
Date: Wed, 26 Feb 2025 11:37:12 +0000
Message-Id: <20250226113712.1257061-3-andre.przywara@arm.com>
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

On the Allwinner D1/R528/T113-s3 SoCs (NCAT2) the factors encoded in
the PLL register describe the doubled clock rate, as in the other SoCs.

Correct for that by always dividing the calculated rate by 2, except on
the H6, where we need a divisor of 4 (no change here).

This corrects the PERIPH0 clock rate as read by the MMC driver, and
actually doubles the MMC performance on those NCAT2 chips.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reported-by: Kuba Szczodrzyński <kuba@szczodrzynski.pl>
---
 arch/arm/mach-sunxi/clock_sun50i_h6.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index b424a7893ea..359513d1669 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -147,15 +147,20 @@ unsigned int clock_get_pll6(void)
 	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
 		div1 = ((rval & CCM_PLL6_CTRL_P0_MASK) >>
 			CCM_PLL6_CTRL_P0_SHIFT) + 1;
-		m = 1;
 	} else {
 		div1 = ((rval & CCM_PLL6_CTRL_DIV1_MASK) >>
 			CCM_PLL6_CTRL_DIV1_SHIFT) + 1;
-		if (IS_ENABLED(CONFIG_MACH_SUN50I_H6))
-			m = 4;
-		else
-			m = 2;
 	}
 
+	/*
+	 * The factors encoded in the register describe the doubled clock
+	 * frequency, expect for the H6, where it's the quadrupled frequency.
+	 * Compensate for that here.
+	 */
+	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6))
+		m = 4;
+	else
+		m = 2;
+
 	return 24000000U * n / m / div1 / div2;
 }
-- 
2.25.1

