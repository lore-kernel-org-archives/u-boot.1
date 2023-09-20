Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EB1CE79CE
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 12:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE7486BEE;
	Wed, 20 Sep 2023 14:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427D1867D6; Wed, 20 Sep 2023 14:43:10 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id EF90F86BEE
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 14:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,162,1694703600"; d="scan'208";a="180389802"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 20 Sep 2023 21:43:06 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.83])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2FEE7433CFB5;
 Wed, 20 Sep 2023 21:43:03 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 11/16] mmc: renesas-sdhi: Initialize module on RZ/G2L
Date: Wed, 20 Sep 2023 13:42:07 +0100
Message-Id: <20230920124212.63535-12-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
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

On the Renesas RZ/G2L SoC family, we must ensure that the required clock
signals are enabled and the reset signal is de-asserted before we try to
communicate with the SDHI module.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/renesas-sdhi.c | 61 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 8e716f74491f..170c5dcc2ebe 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/sizes.h>
 #include <power/regulator.h>
+#include <reset.h>
 #include <asm/unaligned.h>
 #include "tmio-common.h"
 
@@ -964,6 +965,8 @@ static int renesas_sdhi_probe(struct udevice *dev)
 	u32 quirks = dev_get_driver_data(dev);
 	struct fdt_resource reg_res;
 	DECLARE_GLOBAL_DATA_PTR;
+	struct clk imclk2, aclk;
+	struct reset_ctl rst;
 	int ret;
 
 	priv->clk_get_rate = renesas_sdhi_clk_get_rate;
@@ -1012,6 +1015,49 @@ static int renesas_sdhi_probe(struct udevice *dev)
 		goto err_clkh;
 	}
 
+	if (IS_ENABLED(CONFIG_RZG2L)) {
+		/*
+		 * On members of the RZ/G2L SoC family, we need to enable
+		 * additional chip detect and bus clocks, then release the SDHI
+		 * module from reset.
+		 */
+		ret = clk_get_by_name(dev, "cd", &imclk2);
+		if (ret < 0) {
+			dev_err(dev, "failed to get imclk2 (chip detect clk)\n");
+			goto err_get_imclk2;
+		}
+
+		ret = clk_get_by_name(dev, "aclk", &aclk);
+		if (ret < 0) {
+			dev_err(dev, "failed to get aclk\n");
+			goto err_get_aclk;
+		}
+
+		ret = clk_enable(&imclk2);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable imclk2 (chip detect clk)\n");
+			goto err_imclk2;
+		}
+
+		ret = clk_enable(&aclk);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable aclk\n");
+			goto err_aclk;
+		}
+
+		ret = reset_get_by_index(dev, 0, &rst);
+		if (ret < 0) {
+			dev_err(dev, "failed to get reset line\n");
+			goto err_reset;
+		}
+
+		ret = reset_deassert(&rst);
+		if (ret < 0) {
+			dev_err(dev, "failed to de-assert reset line\n");
+			goto err_reset;
+		}
+	}
+
 	priv->quirks = quirks;
 	ret = tmio_sd_probe(dev, quirks);
 	if (ret)
@@ -1028,6 +1074,21 @@ static int renesas_sdhi_probe(struct udevice *dev)
 	return 0;
 
 err_tmio_probe:
+	if (IS_ENABLED(CONFIG_RZG2L))
+		reset_assert(&rst);
+err_reset:
+	if (IS_ENABLED(CONFIG_RZG2L))
+		clk_disable(&aclk);
+err_aclk:
+	if (IS_ENABLED(CONFIG_RZG2L))
+		clk_disable(&imclk2);
+err_imclk2:
+	if (IS_ENABLED(CONFIG_RZG2L))
+		clk_free(&aclk);
+err_get_aclk:
+	if (IS_ENABLED(CONFIG_RZG2L))
+		clk_free(&imclk2);
+err_get_imclk2:
 	clk_disable(&priv->clk);
 err_clkh:
 	clk_free(&priv->clkh);
-- 
2.34.1

