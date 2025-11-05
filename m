Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AB6CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1B4083957;
	Wed,  5 Nov 2025 17:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE6983AAE; Wed,  5 Nov 2025 17:44:31 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142A58334F
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 20BB1227AAA; Wed,  5 Nov 2025 17:44:26 +0100 (CET)
From: Torsten Duwe <duwe@lst.de>
To: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>,
    Elaine Zhang <zhangqing@rock-chips.com>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
    Heiko Stuebner <heiko@sntech.de>, Huan Zhou <me@per1cycle.org>,
    Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Jan Čermák" <sairon@sairon.cz>,
    Jerome Forissier <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
    Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
    Kever Yang <kever.yang@rock-chips.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
    Marek Vasut <marek.vasut+renesas@mailbox.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
    Patrick Delaunay <patrick.delaunay@foss.st.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
    Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
    Tom Rini <trini@konsulko.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
    Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Quentin Schulz <quentin.schulz@cherry.de>,
    u-boot@lists.denx.de
Subject: [RESEND PATCH 1/4] macb: wrap asm/arch/clk.h with ifndef CLK
In-Reply-To: <20251105163553.15F2A227AAC@verein.lst.de>
References: <20251105163553.15F2A227AAC@verein.lst.de>
Message-Id: <20251105164426.20BB1227AAA@verein.lst.de>
Date: Wed,  5 Nov 2025 17:44:26 +0100 (CET)
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
Reviewed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
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

