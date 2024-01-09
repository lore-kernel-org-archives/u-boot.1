Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11152C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 12:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71353878E9;
	Tue,  9 Jan 2024 13:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JNKn3BrO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F108786F; Tue,  9 Jan 2024 13:26:22 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE739878CD
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 13:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A81DA612DA;
 Tue,  9 Jan 2024 12:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0F2C433F1;
 Tue,  9 Jan 2024 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704803179;
 bh=zRRBZRtxf8IrWH+NutTpFeokUSe87bC1cnEovuBabuc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JNKn3BrOEWwta2uQhK+3T40UFEHOq0heEJkELLJB8FlWEp3h8aJRnDXVNj95omSci
 qC1hdxWtB+V/zSJNl8hhMKTXJdiM5L5F3aUDlZWYSHfyozkkVRiqRB31J77qyjnceB
 LdkFX7xgn4SvTWFaIgglGRRAqcEWmRFwxL7zcddP7sd5P5M8VZ3fTpQxKfWm5bxsQh
 CMxFNLoT0oFT8jqWaPhZfvEsTx0F6M5Nxhvvi7/KRiPeDN+5RoOYi/T51C8L/Tg/SB
 Kn/hgKLrsK8O4TFQwe+zuvWFMx/XMJxtxWh2fyAVhy8ZQIIBt+Dai4/ZJA7i8DQQNg
 3PSJIJsiru3Vg==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com
Cc: nm@ti.com, afd@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 r-gunasekaran@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/4] mtd: rawnand: omap_gpmc: Use DT provided IO address
Date: Tue,  9 Jan 2024 14:26:03 +0200
Message-Id: <20240109122605.51951-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109122605.51951-1-rogerq@kernel.org>
References: <20240109122605.51951-1-rogerq@kernel.org>
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

For DM case we can get the NAND chip's IO address from DT
so we don't need to rely on CFG_SYS_NAND_BASE.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/omap_gpmc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index 0e25bd5dc2..f827c578d9 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -8,13 +8,15 @@
 #include <log.h>
 #include <system-constants.h>
 #include <asm/io.h>
-#include <dm/uclass.h>
+#include <dm.h>
 #include <linux/errno.h>
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 #include <asm/arch/mem.h>
 #endif
 
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/mtd/omap_gpmc.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/rawnand.h>
@@ -1124,7 +1126,7 @@ int __maybe_unused omap_nand_switch_ecc(uint32_t hardware, uint32_t eccstrength)
  *   nand_scan about special functionality. See the defines for further
  *   explanation
  */
-int gpmc_nand_init(struct nand_chip *nand)
+int gpmc_nand_init(struct nand_chip *nand, void __iomem *nand_base)
 {
 	int32_t gpmc_config = 0;
 	int cs = cs_next++;
@@ -1164,7 +1166,7 @@ int gpmc_nand_init(struct nand_chip *nand)
 	info->control = NULL;
 	info->cs = cs;
 	info->ws = wscfg[cs];
-	info->fifo = (void __iomem *)CFG_SYS_NAND_BASE;
+	info->fifo = nand_base;
 	nand_set_controller_data(nand, &omap_nand_info[cs]);
 	nand->cmd_ctrl	= omap_nand_hwcontrol;
 	nand->options	|= NAND_NO_PADDING | NAND_CACHEPRG;
@@ -1214,9 +1216,16 @@ static int gpmc_nand_probe(struct udevice *dev)
 {
 	struct nand_chip *nand = dev_get_priv(dev);
 	struct mtd_info *mtd = nand_to_mtd(nand);
+	struct resource res;
+	void __iomem *base;
 	int ret;
 
-	gpmc_nand_init(nand);
+	ret = dev_read_resource(dev, 0, &res);
+	if (ret)
+		return ret;
+
+	base = devm_ioremap(dev, res.start, resource_size(&res));
+	gpmc_nand_init(nand, base);
 
 	ret = nand_scan(mtd, CONFIG_SYS_NAND_MAX_CHIPS);
 	if (ret)
@@ -1270,7 +1279,7 @@ void board_nand_init(void)
 
 int board_nand_init(struct nand_chip *nand)
 {
-	return gpmc_nand_init(nand);
+	return gpmc_nand_init(nand, (void __iomem *)CFG_SYS_NAND_BASE);
 }
 
 #endif /* CONFIG_SYS_NAND_SELF_INIT */
-- 
2.34.1

