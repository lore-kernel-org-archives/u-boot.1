Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2B0CD610B
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 16:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3453C86DE3;
	Mon,  9 Oct 2023 18:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A4186E01; Mon,  9 Oct 2023 18:47:43 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 9C1CA86DF2
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 18:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; d="scan'208";a="178655053"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 10 Oct 2023 01:47:40 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.229])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 244D1402A8DA;
 Tue, 10 Oct 2023 01:47:37 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v2 13/19] mmc: renesas-sdhi: Refactor probe function
Date: Mon,  9 Oct 2023 17:46:39 +0100
Message-Id: <20231009164645.164464-14-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
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

Move the assignment of priv->quirks earlier in the function. This allows
us to drop the quirks local variable and makes it easier to maintain
clean error handling when we add RZ/G2L support in the next patch.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
v1->v2:
  * New patch to support breaking out RZ/G2L-specific initialization
    into its own function.

 drivers/mmc/renesas-sdhi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 8e716f74491f..1536c9782041 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -961,14 +961,14 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 static int renesas_sdhi_probe(struct udevice *dev)
 {
 	struct tmio_sd_priv *priv = dev_get_priv(dev);
-	u32 quirks = dev_get_driver_data(dev);
 	struct fdt_resource reg_res;
 	DECLARE_GLOBAL_DATA_PTR;
 	int ret;
 
 	priv->clk_get_rate = renesas_sdhi_clk_get_rate;
 
-	if (quirks == RENESAS_GEN2_QUIRKS) {
+	priv->quirks = dev_get_driver_data(dev);
+	if (priv->quirks == RENESAS_GEN2_QUIRKS) {
 		ret = fdt_get_resource(gd->fdt_blob, dev_of_offset(dev),
 				       "reg", 0, &reg_res);
 		if (ret < 0) {
@@ -978,7 +978,7 @@ static int renesas_sdhi_probe(struct udevice *dev)
 		}
 
 		if (fdt_resource_size(&reg_res) == 0x100)
-			quirks |= TMIO_SD_CAP_16BIT;
+			priv->quirks |= TMIO_SD_CAP_16BIT;
 	}
 
 	ret = clk_get_by_index(dev, 0, &priv->clk);
@@ -1012,8 +1012,7 @@ static int renesas_sdhi_probe(struct udevice *dev)
 		goto err_clkh;
 	}
 
-	priv->quirks = quirks;
-	ret = tmio_sd_probe(dev, quirks);
+	ret = tmio_sd_probe(dev, priv->quirks);
 	if (ret)
 		goto err_tmio_probe;
 
-- 
2.39.2

