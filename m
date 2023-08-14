Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351AFC04A94
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 16:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E9F867B4;
	Mon, 14 Aug 2023 18:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FCE286927; Mon, 14 Aug 2023 18:05:31 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C2E86679
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 18:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 4979467373; Mon, 14 Aug 2023 18:05:28 +0200 (CEST)
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
In-Reply-To: <20230814160404.9B2E067373@verein.lst.de>
Subject: [PATCH 1/2] riscv: allow riscv timer to be instantiated via device
 tree
Message-Id: <20230814160528.4979467373@verein.lst.de>
Date: Mon, 14 Aug 2023 18:05:28 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
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

For the architectural timer on riscv, there already is a defined
device tree binding[1]. Allow timer instances to be created from
device tree matches, but for now retain the old mechanism, which
registers the timer biggy-back with the CPU.

[1] linux/Documentation/devicetree/bindings/timer/riscv,timer.yaml

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 drivers/timer/riscv_timer.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
index 3627ed79b8..28a6a6870b 100644
--- a/drivers/timer/riscv_timer.c
+++ b/drivers/timer/riscv_timer.c
@@ -13,6 +13,7 @@
 #include <common.h>
 #include <dm.h>
 #include <errno.h>
+#include <fdt_support.h>
 #include <timer.h>
 #include <asm/csr.h>
 
@@ -53,9 +54,26 @@ u64 notrace timer_early_get_count(void)
 static int riscv_timer_probe(struct udevice *dev)
 {
 	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	u32 rate;
 
-	/* clock frequency was passed from the cpu driver as driver data */
-	uc_priv->clock_rate = dev->driver_data;
+	/*  When this function was called from the CPU driver, clock
+	 *  frequency is passed as driver data.
+	 */
+	rate = dev->driver_data;
+
+	/* When called from an FDT match, the rate needs to be looked up. */
+	if (!rate && gd->fdt_blob) {
+		rate = fdt_getprop_u32_default(gd->fdt_blob,
+					       "/cpus", "timebase-frequency", 0);
+	}
+
+	uc_priv->clock_rate = rate;
+
+	/* With rate==0, timer uclass post_probe might later fail with -EINVAL.
+	 * Give a hint at the cause for debugging.
+	 */
+	if (!rate)
+		log_err("riscv_timer_probe with invalid clock rate 0!\n");
 
 	return 0;
 }
@@ -64,9 +82,15 @@ static const struct timer_ops riscv_timer_ops = {
 	.get_count = riscv_timer_get_count,
 };
 
+static const struct udevice_id riscv_timer_ids[] = {
+	{ .compatible = "riscv,timer", },
+	{ }
+};
+
 U_BOOT_DRIVER(riscv_timer) = {
 	.name = "riscv_timer",
 	.id = UCLASS_TIMER,
+	.of_match = of_match_ptr(riscv_timer_ids),
 	.probe = riscv_timer_probe,
 	.ops = &riscv_timer_ops,
 	.flags = DM_FLAG_PRE_RELOC,
-- 
2.35.3

