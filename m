Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388E9C48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 18:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80FE187887;
	Mon,  5 Feb 2024 19:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JujC0LZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E30C8791C; Mon,  5 Feb 2024 19:27:56 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E9D86DBD
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 19:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4887=JP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1707157661;
 bh=cYFXsyFEqF53D/u4TL7QDgoJT1Uz/KgWluCAF8FBvP4=;
 b=JujC0LZYd+IBNCowtNsNj6dU3lSxroHUpw5sCa0X0eib9OeL9ZnEvmLEp5CfWj6PoBEV20HVK
 6JnpfK5hCZEt/obloQVAauoUPl44WxI0btx1gLqiRiv4FAAc0P7/s6v7wUviS3emqpGoChFHgWC
 GByYNHF9nqlYxrDpGEETOYePUUIstaNHj8/fumQuGUpn6J6GZ8EJPOKYh6UVGQEoMRxnLYVNoc2
 OgkFzCX7QizMQgstaqvdN6FWCBfzCihB3lt56BxG/HlVU1y/kFZjV9NsAcPRbOjvbCjlIUqeSHb
 uG9yr93vG0FcetE/79OBGAo/Yk2kCa9ujZFBxJR/AotA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Jonas Karlman
 <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] mmc: rockchip_sdhci: Use bounce buffer in SPL to fix read
 performance
Date: Mon,  5 Feb 2024 18:27:33 +0000
Message-ID: <20240205182736.2770679-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c1289d42f435b07bc4d9fe
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

The commit 3b804b370dd8 ("mmc: rockchip_sdhci: Disable DMA mode using a
device tree property") and commit 2cc6cde647e2 ("mmc: rockchip_sdhci:
Limit number of blocks read in a single command") implemented a
workaround to fix loading a part of TF-A into SRAM from eMMC in SPL.

This has resulted in very slow read performance of FIT from eMMC in SPL
on RK3588.

Change to make use of a bounce buffer to significantly improve the read
performance when malloc_limit is large enough and use PIO mode as fall
back.

Also update the size of align_buffer to use SDHCI_DEFAULT_BOUNDARY_SIZE
instead of a hardcoded 512 * 1024.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
- This has been tested on RK3588 boards with malloc_limit above 512 KiB
  and on RK3399 boards with less than 512 KiB malloc_limit.
- Together with HS200 mode [1] and D-cache [2] enabled in SPL loading of
  FIT can be very fast on RK3588.

[1] https://patchwork.ozlabs.org/patch/1895043/
[2] https://patchwork.ozlabs.org/patch/1891025/
---
 drivers/mmc/rockchip_sdhci.c | 20 ++++++++++++++++----
 drivers/mmc/sdhci.c          |  2 +-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 706fb1235796..528544b1eff8 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -21,6 +21,9 @@
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 /* DWCMSHC specific Mode Select value */
 #define DWCMSHC_CTRL_HS400		0x7
@@ -591,12 +594,21 @@ static int rockchip_sdhci_probe(struct udevice *dev)
 		return ret;
 
 	/*
-	 * Disable use of DMA and force use of PIO mode in SPL to fix an issue
-	 * where loading part of TF-A into SRAM using DMA silently fails.
+	 * Use a bounce buffer or PIO mode in SPL to fix an issue where loading
+	 * part of TF-A directly into SRAM using DMA silently fails.
 	 */
 	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
-	    dev_read_bool(dev, "u-boot,spl-fifo-mode"))
-		host->flags &= ~USE_DMA;
+	    dev_read_bool(dev, "u-boot,spl-fifo-mode")) {
+		if (CONFIG_IS_ENABLED(SYS_MALLOC_F) &&
+		    gd->malloc_limit > SDHCI_DEFAULT_BOUNDARY_SIZE) {
+			cfg->b_max = SDHCI_DEFAULT_BOUNDARY_SIZE /
+				     MMC_MAX_BLOCK_LEN;
+			host->force_align_buffer = true;
+			host->quirks |= SDHCI_QUIRK_32BIT_DMA_ADDR;
+		} else {
+			host->flags &= ~USE_DMA;
+		}
+	}
 
 	/*
 	 * Reading more than 4 blocks with a single CMD18 command in PIO mode
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 0178ed8a11e1..cc855dc7ba3d 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -736,7 +736,7 @@ static int sdhci_init(struct mmc *mmc)
 	host->force_align_buffer = true;
 #else
 	if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR) {
-		host->align_buffer = memalign(8, 512 * 1024);
+		host->align_buffer = memalign(8, SDHCI_DEFAULT_BOUNDARY_SIZE);
 		if (!host->align_buffer) {
 			printf("%s: Aligned buffer alloc failed!!!\n",
 			       __func__);
-- 
2.43.0

