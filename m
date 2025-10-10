Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1989CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6398424E;
	Fri, 10 Oct 2025 18:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86C084229; Fri, 10 Oct 2025 18:17:26 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3264783FF9
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 7B915227AAE; Fri, 10 Oct 2025 18:17:21 +0200 (CEST)
From: Torsten Duwe <duwe@lst.de>
To: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>
Cc: Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 1/4] macb: wrap asm/arch/clk.h with ifndef CLK
In-Reply-To: <20251010161442.410C4227AAE@verein.lst.de>
References: <20251010161442.410C4227AAE@verein.lst.de>
Message-Id: <20251010161721.7B915227AAE@verein.lst.de>
Date: Fri, 10 Oct 2025 18:17:21 +0200 (CEST)
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

macb.c includes asm/arch/clk.h solely to declare get_macb_pclk_rate().
That function is platform specific and only required if CONFIG_CLK
is not set. In case the machine does not provide it, compilation fails
even when the MACB pclk is detected via the CLK framework.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 drivers/net/macb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index cbf5f605518..a54a268036d 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -38,7 +38,9 @@
 #include <linux/mii.h>
 #include <asm/io.h>
 #include <linux/dma-mapping.h>
+#ifndef CONFIG_CLK
 #include <asm/arch/clk.h>
+#endif
 #include <linux/errno.h>
 
 #include "macb.h"
-- 
2.51.0

