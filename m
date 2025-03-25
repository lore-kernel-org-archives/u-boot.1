Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD9FC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A365B81951;
	Tue, 25 Mar 2025 15:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBCF81C84; Tue, 25 Mar 2025 15:27:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0146B80EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F27D31756;
 Tue, 25 Mar 2025 07:27:47 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 277F63F694;
 Tue, 25 Mar 2025 07:27:41 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	linux-sunxi@lists.linux.dev
Subject: FIXUP! sunxi: mmc: Improve reset procedure
Date: Tue, 25 Mar 2025 14:27:37 +0000
Message-Id: <20250325142737.1702796-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250325133953.1dab37c8@donnerap.manchester.arm.com>
References: <20250325133953.1dab37c8@donnerap.manchester.arm.com>
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

Hi Jernej,

what do you think about this solution the A10 compilation problem?
That looks like a simple change, somewhat half of the way to the proper
solution.
If you agree, I'd squash that into your patch, then push it for U-Boot
next.

Cheers,
Andre


Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mmc/sunxi_mmc.c | 10 +++++-----
 drivers/mmc/sunxi_mmc.h |  4 ++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 31dbfb10c59..951e6acd34d 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -449,23 +449,23 @@ out:
 	return error;
 }
 
-static void sunxi_mmc_reset(struct sunxi_mmc *regs)
+static void sunxi_mmc_reset(void *regs)
 {
 	/* Reset controller */
-	writel(SUNXI_MMC_GCTRL_RESET, &regs->gctrl);
+	writel(SUNXI_MMC_GCTRL_RESET, regs + SUNXI_MMC_GCTRL);
 	udelay(1000);
 
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
 		/* Reset card */
-		writel(SUNXI_MMC_HWRST_ASSERT, &regs->hwrst);
+		writel(SUNXI_MMC_HWRST_ASSERT, regs + SUNXI_MMC_HWRST);
 		udelay(10);
-		writel(SUNXI_MMC_HWRST_DEASSERT, &regs->hwrst);
+		writel(SUNXI_MMC_HWRST_DEASSERT, regs + SUNXI_MMC_HWRST);
 		udelay(300);
 
 		/* Setup FIFO R/W threshold. Needed on H616. */
 		writel(SUNXI_MMC_THLDC_READ_THLD(512) |
 		       SUNXI_MMC_THLDC_WRITE_EN |
-		       SUNXI_MMC_THLDC_READ_EN, &regs->thldc);
+		       SUNXI_MMC_THLDC_READ_EN, regs + SUNXI_MMC_THLDC);
 	}
 }
 
diff --git a/drivers/mmc/sunxi_mmc.h b/drivers/mmc/sunxi_mmc.h
index 9d55904c213..bc313dcabe0 100644
--- a/drivers/mmc/sunxi_mmc.h
+++ b/drivers/mmc/sunxi_mmc.h
@@ -12,6 +12,10 @@
 
 #include <linux/types.h>
 
+#define SUNXI_MMC_GCTRL		0x000
+#define SUNXI_MMC_HWRST		0x078
+#define SUNXI_MMC_THLDC		0x100
+
 struct sunxi_mmc {
 	u32 gctrl;		/* 0x00 global control */
 	u32 clkcr;		/* 0x04 clock control */
-- 
2.25.1

