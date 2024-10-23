Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D791CFA466
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 20:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CDFD891A3;
	Wed, 23 Oct 2024 22:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD64892D5; Wed, 23 Oct 2024 22:29:13 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E3788B4B
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 22:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1t3hyb-001CNZ-6x;
 Wed, 23 Oct 2024 20:29:05 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 4/4] mmc: fsl_esdhc: Convert to use livetree API for fdt access
Date: Wed, 23 Oct 2024 13:28:55 -0700
Message-Id: <20241023202855.1571188-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023202855.1571188-1-tharvey@gateworks.com>
References: <20241023202855.1571188-1-tharvey@gateworks.com>
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

Convert to using livetree API functions.

Without this if livetree is enabled (OF_LIVE) the fsl_esdhc_imx
driver will fail to read vendor-specific properties from the dt.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/mmc/fsl_esdhc_imx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index fb410104c1fc..d7a45ef0ad0d 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1398,8 +1398,7 @@ static int fsl_esdhc_of_to_plat(struct udevice *dev)
 	struct udevice *vqmmc_dev;
 	int ret;
 
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(dev);
+	ofnode node = dev_ofnode(dev);
 	fdt_addr_t addr;
 	unsigned int val;
 
@@ -1413,15 +1412,15 @@ static int fsl_esdhc_of_to_plat(struct udevice *dev)
 	priv->dev = dev;
 	priv->mode = -1;
 
-	val = fdtdec_get_int(fdt, node, "fsl,tuning-step", 1);
+	val = ofnode_read_u32_default(node, "fsl,tuning-step", 1);
 	priv->tuning_step = val;
-	val = fdtdec_get_int(fdt, node, "fsl,tuning-start-tap",
-			     ESDHC_TUNING_START_TAP_DEFAULT);
+	val = ofnode_read_u32_default(node, "fsl,tuning-start-tap",
+				      ESDHC_TUNING_START_TAP_DEFAULT);
 	priv->tuning_start_tap = val;
-	val = fdtdec_get_int(fdt, node, "fsl,strobe-dll-delay-target",
-			     ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT);
+	val = ofnode_read_u32_default(node, "fsl,strobe-dll-delay-target",
+				      ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT);
 	priv->strobe_dll_delay_target = val;
-	val = fdtdec_get_int(fdt, node, "fsl,signal-voltage-switch-extra-delay-ms", 0);
+	val = ofnode_read_u32_default(node, "fsl,signal-voltage-switch-extra-delay-ms", 0);
 	priv->signal_voltage_switch_extra_delay_ms = val;
 
 	if (dev_read_bool(dev, "broken-cd"))
-- 
2.25.1

