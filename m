Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8897CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A5EC86F6A;
	Mon, 16 Oct 2023 11:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0786C86F7C; Mon, 16 Oct 2023 11:26:48 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 9A5E386F6D
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,228,1694703600"; d="scan'208";a="183211938"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 16 Oct 2023 18:26:44 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.82])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 291B341F99C3;
 Mon, 16 Oct 2023 18:26:41 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 16/21] mmc: renesas-sdhi: Initialize module on RZ/G2L
Date: Mon, 16 Oct 2023 10:25:38 +0100
Message-Id: <20231016092543.3833-17-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
References: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
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
v2->v3:
  * Check the device's compatible string instead of checking for
    CONFIG_RZG2L to determine whether to call rzg2l_sdhi_setup().
  * Simplify error handling.
v1->v2:
  * Move RZ/G2L specific setup to its own function.

 drivers/mmc/renesas-sdhi.c | 74 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 1536c9782041..1ea6e1066f2b 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/sizes.h>
 #include <power/regulator.h>
+#include <reset.h>
 #include <asm/unaligned.h>
 #include "tmio-common.h"
 
@@ -958,6 +959,74 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 		priv->needs_clkh_fallback = false;
 }
 
+static int rzg2l_sdhi_setup(struct udevice *dev)
+{
+	struct tmio_sd_priv *priv = dev_get_priv(dev);
+	struct clk imclk2, aclk;
+	struct reset_ctl rst;
+	int ret;
+
+	/*
+	 * On members of the RZ/G2L SoC family, we need to enable
+	 * additional chip detect and bus clocks, then release the SDHI
+	 * module from reset.
+	 */
+	ret = clk_get_by_name(dev, "cd", &imclk2);
+	if (ret < 0) {
+		dev_err(dev, "failed to get imclk2 (chip detect clk)\n");
+		goto err_get_imclk2;
+	}
+
+	ret = clk_get_by_name(dev, "aclk", &aclk);
+	if (ret < 0) {
+		dev_err(dev, "failed to get aclk\n");
+		goto err_get_aclk;
+	}
+
+	ret = clk_enable(&imclk2);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable imclk2 (chip detect clk)\n");
+		goto err_imclk2;
+	}
+
+	ret = clk_enable(&aclk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable aclk\n");
+		goto err_aclk;
+	}
+
+	ret = reset_get_by_index(dev, 0, &rst);
+	if (ret < 0) {
+		dev_err(dev, "failed to get reset line\n");
+		goto err_reset;
+	}
+
+	ret = reset_deassert(&rst);
+	if (ret < 0) {
+		dev_err(dev, "failed to de-assert reset line\n");
+		goto err_reset;
+	}
+
+	ret = tmio_sd_probe(dev, priv->quirks);
+	if (ret)
+		goto err_tmio_probe;
+
+	return 0;
+
+err_tmio_probe:
+	reset_assert(&rst);
+err_reset:
+	clk_disable(&aclk);
+err_aclk:
+	clk_disable(&imclk2);
+err_imclk2:
+	clk_free(&aclk);
+err_get_aclk:
+	clk_free(&imclk2);
+err_get_imclk2:
+	return ret;
+}
+
 static int renesas_sdhi_probe(struct udevice *dev)
 {
 	struct tmio_sd_priv *priv = dev_get_priv(dev);
@@ -1012,7 +1081,10 @@ static int renesas_sdhi_probe(struct udevice *dev)
 		goto err_clkh;
 	}
 
-	ret = tmio_sd_probe(dev, priv->quirks);
+	if (device_is_compatible(dev, "renesas,sdhi-r9a07g044"))
+		ret = rzg2l_sdhi_setup(dev);
+	else
+		ret = tmio_sd_probe(dev, priv->quirks);
 	if (ret)
 		goto err_tmio_probe;
 
-- 
2.39.2

