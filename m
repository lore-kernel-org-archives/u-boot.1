Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54625C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587A181E67;
	Sun, 23 Mar 2025 12:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1719F81E47; Sun, 23 Mar 2025 12:36:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F11BB80F0E
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C731339;
 Sun, 23 Mar 2025 04:36:31 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 728FB3F694;
 Sun, 23 Mar 2025 04:36:23 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 11/34] sunxi: clock: H6: factor out H6/H616 CPU clock setup
Date: Sun, 23 Mar 2025 11:35:21 +0000
Message-ID: <20250323113544.7933-12-andre.przywara@arm.com>
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

When we program the CPU PLL, we need to switch the CPU clock source away
from the PLL temporarily, then switch it back, once the PLL has
stabilised.

The CPU CLK register will be different on the A523, so move the current
code into a separate function, to allow using a different version of
that later for the A523.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/clock_sun50i_h6.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 9faf659f834..b205b0a0550 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -111,29 +111,37 @@ static void clock_set_pll(u32 *reg, unsigned int n)
 	}
 }
 
-void clock_set_pll1(unsigned int clk)
+static void clock_h6_set_cpu_pll(unsigned int n_factor)
 {
 	void *const ccm = (void *)SUNXI_CCM_BASE;
 	u32 val;
 
-	/* Do not support clocks < 288MHz as they need factor P */
-	if (clk < 288000000) clk = 288000000;
-
-	/* Switch to 24MHz clock while changing PLL1 */
+	/* Switch CPU clock source to 24MHz HOSC while changing the PLL */
 	val = readl(ccm + CCU_H6_CPU_AXI_CFG);
 	val &= ~CCM_CPU_AXI_MUX_MASK;
 	val |= CCM_CPU_AXI_MUX_OSC24M;
 	writel(val, ccm + CCU_H6_CPU_AXI_CFG);
 
-	clock_set_pll(ccm + CCU_H6_PLL1_CFG, clk / 24000000);
+	clock_set_pll(ccm + CCU_H6_PLL1_CFG, n_factor);
 
-	/* Switch CPU to PLL1 */
+	/* Switch CPU clock source to the CPU PLL */
 	val = readl(ccm + CCU_H6_CPU_AXI_CFG);
 	val &= ~CCM_CPU_AXI_MUX_MASK;
 	val |= CCM_CPU_AXI_MUX_PLL_CPUX;
 	writel(val, ccm + CCU_H6_CPU_AXI_CFG);
 }
 
+void clock_set_pll1(unsigned int clk)
+{
+	/* Do not support clocks < 288MHz as they need factor P */
+	if (clk < 288000000)
+		clk = 288000000;
+
+	clk /= 24000000;
+
+	clock_h6_set_cpu_pll(clk);
+}
+
 int clock_twi_onoff(int port, int state)
 {
 	void *const ccm = (void *)SUNXI_CCM_BASE;
-- 
2.46.3

