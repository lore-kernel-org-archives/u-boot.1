Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60076C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC4987B18;
	Thu, 11 Jan 2024 14:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="opulHYXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E7587AE6; Thu, 11 Jan 2024 14:19:36 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCFA87AE8
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 14:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 24CE8B82022;
 Thu, 11 Jan 2024 13:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2943DC43609;
 Thu, 11 Jan 2024 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704979171;
 bh=aV5xY3svJLlzHVqM6RgZKOVFEiN7XuAcFpyXOOGRq0o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=opulHYXbc1hJcrmSprZzP5FQeYun62ihFefetYdaai1s2MyiPlzVvTyKe5eZUbPR6
 S+8Ts93kWC/93pIcsa5eJMV4L5oGoVnJjNckGNaOTIyehuJOluzpOgoEU9pva657sP
 JQrx8gEtiUhxhbdqGnGZRZwVr5ULVXfaxyeGzxqSknpWuySE91W7lChjdQ/Ih74LnX
 qXRrShSB9HGKtn4LtbkTdw/hMxIvGZit4SR8q4vYKEGJFD7zDSIagQgkv0uWEPtAdA
 z9zSYt0sw7Zzff9SlRNf+qrxFkDOyVgiYYQ9gKWO4tqlvL4nXTAAfVssQZnRyB70GR
 47VOuiCCu6Jjw==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com
Cc: vigneshr@ti.com, nm@ti.com, praneeth@ti.com, afd@ti.com, srk@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/4] mtd: rawnand: omap_gpmc: Use DT provided IO address
Date: Thu, 11 Jan 2024 15:19:18 +0200
Message-Id: <20240111131920.73691-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111131920.73691-1-rogerq@kernel.org>
References: <20240111131920.73691-1-rogerq@kernel.org>
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

Notes:
    v2: no change

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

