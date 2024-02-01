Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A95FC4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B6A87C96;
	Thu,  1 Feb 2024 15:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oR92080T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0950E87B6C; Thu,  1 Feb 2024 15:05:49 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8E687C58
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 18087CE1E50;
 Thu,  1 Feb 2024 14:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55E5CC43390;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706796343;
 bh=JhoWLdQ5nuuZDPM1dGedof4uT+gTkKVJj00sQOIWeHo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=oR92080TUHLZJ/TQYGmBkTt6optHcGIk1bgmyeYNZlczzAFf5W1ZKCU3JR4KLbo9J
 5fc89e6YFb7x9xsaQdoTWrpJhqYAit7qqrH31RmWPDTXNCxovqfokzdjEoTB6/kWMB
 XTXhR4IIvPigU+85GsqPtMEfB16PLFgXjnEHCXIqdqPmekxPMgCzuoTT6QB97jOWcB
 k1CgDuDNOe9k6EEFCsZe0nXfP5DqhCUPJ8PyweWZV9jMnc74fQFQ+G30LSZPdtjA7/
 PH+7pTt8rkZ5VdgStCayT+2Skp3EyUE3UdSwq/olwXRtlF5yD+PF+ffvRfd2QR8wBj
 wVyg9FFEkoUjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5B7C48291;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 01 Feb 2024 22:05:42 +0800
Subject: [PATCH v2 1/3] mmc: hi6220-dwmmc: handle clocks and resets if
 CONFIG_CLK and CONFIG_DM_RESET enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-mmc-v2-1-9f09dc1335fd@outlook.com>
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
In-Reply-To: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706796342; l=3767;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=ikTybhaviPLpwL/4MV5qP49z5jgH5zt1fBMlk3sX/pU=;
 b=yPuKAhZKzlcNFci8EC4sF7TAU0l+VUy+KT/vf0nDENz18N8Ycc3VTATKP+VRjAqx6owxvvHXN
 eTKMxTZrecXDd0Thp0SW40PfaL9u/kzYnQSBPxjTHlZrJZzMhWKWcSm
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

This can avoid hardcoding a clock rate in driver. Also can enable the
clocks and deassert the resets if the pre-bootloader does not do this
for us.

Currently only enabled for Hi3798MV200.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/mmc/hi6220_dw_mmc.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
index 71962cd47e..a4b8072976 100644
--- a/drivers/mmc/hi6220_dw_mmc.c
+++ b/drivers/mmc/hi6220_dw_mmc.c
@@ -5,15 +5,24 @@
  */
 
 #include <common.h>
+#include <clk.h>
 #include <dm.h>
 #include <dwmmc.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <malloc.h>
+#include <reset.h>
 #include <asm/global_data.h>
+#include <dm/device_compat.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+enum hi6220_dwmmc_clk_type {
+	HI6220_DWMMC_CLK_BIU,
+	HI6220_DWMMC_CLK_CIU,
+	HI6220_DWMMC_CLK_CNT,
+};
+
 struct hi6220_dwmmc_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
@@ -21,6 +30,8 @@ struct hi6220_dwmmc_plat {
 
 struct hi6220_dwmmc_priv_data {
 	struct dwmci_host host;
+	struct clk *clks[HI6220_DWMMC_CLK_CNT];
+	struct reset_ctl_bulk rsts;
 };
 
 struct hisi_mmc_data {
@@ -32,7 +43,29 @@ static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
 {
 	struct hi6220_dwmmc_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
+	int ret;
 
+	if (CONFIG_IS_ENABLED(CLK) && CONFIG_IS_ENABLED(DM_RESET)) {
+		priv->clks[HI6220_DWMMC_CLK_BIU] = devm_clk_get(dev, "biu");
+		if (IS_ERR(priv->clks[HI6220_DWMMC_CLK_BIU])) {
+			ret = PTR_ERR(priv->clks[HI6220_DWMMC_CLK_BIU]);
+			dev_err(dev, "Failed to get BIU clock(ret = %d).\n", ret);
+			return log_msg_ret("clk", ret);
+		}
+
+		priv->clks[HI6220_DWMMC_CLK_CIU] = devm_clk_get(dev, "ciu");
+		if (IS_ERR(priv->clks[HI6220_DWMMC_CLK_CIU])) {
+			ret = PTR_ERR(priv->clks[HI6220_DWMMC_CLK_CIU]);
+			dev_err(dev, "Failed to get CIU clock(ret = %d).\n", ret);
+			return log_msg_ret("clk", ret);
+		}
+
+		ret = reset_get_bulk(dev, &priv->rsts);
+		if (ret) {
+			dev_err(dev, "Failed to get resets(ret = %d)", ret);
+			return log_msg_ret("rst", ret);
+		}
+	}
 	host->name = dev->name;
 	host->ioaddr = dev_read_addr_ptr(dev);
 	host->buswidth = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
@@ -56,11 +89,37 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
 	struct hi6220_dwmmc_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
 	struct hisi_mmc_data *mmc_data;
+	int ret;
 
 	mmc_data = (struct hisi_mmc_data *)dev_get_driver_data(dev);
 
-	/* Use default bus speed due to absence of clk driver */
 	host->bus_hz = mmc_data->clock;
+	if (CONFIG_IS_ENABLED(CLK) && CONFIG_IS_ENABLED(DM_RESET)) {
+		ret = clk_prepare_enable(priv->clks[HI6220_DWMMC_CLK_BIU]);
+		if (ret) {
+			dev_err(dev, "Failed to enable biu clock(ret = %d).\n", ret);
+			return log_msg_ret("clk", ret);
+		}
+
+		ret = clk_prepare_enable(priv->clks[HI6220_DWMMC_CLK_CIU]);
+		if (ret) {
+			dev_err(dev, "Failed to enable ciu clock(ret = %d).\n", ret);
+			return log_msg_ret("clk", ret);
+		}
+
+		ret = reset_deassert_bulk(&priv->rsts);
+		if (ret) {
+			dev_err(dev, "Failed to deassert resets(ret = %d).\n", ret);
+			return log_msg_ret("rst", ret);
+		}
+
+		host->bus_hz = clk_get_rate(priv->clks[HI6220_DWMMC_CLK_CIU]);
+		if (host->bus_hz <= 0) {
+			dev_err(dev, "Failed to get ciu clock rate(ret = %d).\n", ret);
+			return log_msg_ret("clk", ret);
+		}
+	}
+	dev_dbg(dev, "bus clock rate: %d.\n", host->bus_hz);
 
 	dwmci_setup_cfg(&plat->cfg, host, host->bus_hz, 400000);
 	host->mmc = &plat->mmc;

-- 
2.43.0

