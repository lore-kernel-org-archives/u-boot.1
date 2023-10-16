Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE57CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8085086F8E;
	Mon, 16 Oct 2023 11:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9254E86F78; Mon, 16 Oct 2023 11:26:56 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 9A51B86F59
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,229,1694703600"; d="scan'208";a="179418429"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 16 Oct 2023 18:26:41 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.82])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9018041F99C3;
 Mon, 16 Oct 2023 18:26:39 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v3 15/21] mmc: renesas-sdhi: Refactor probe function
Date: Mon, 16 Oct 2023 10:25:37 +0100
Message-Id: <20231016092543.3833-16-paul.barker.ct@bp.renesas.com>
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

Move the assignment of priv->quirks earlier in the function. This allows
us to drop the quirks local variable and makes it easier to maintain
clean error handling when we add RZ/G2L support in the next patch.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v2->v3:
  * Added Marek's Reviewed-by.
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

