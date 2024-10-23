Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEBDCFA464
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 20:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECACA890AD;
	Wed, 23 Oct 2024 22:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58AC58926F; Wed, 23 Oct 2024 22:29:12 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3110889092
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 22:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1t3hyZ-001CNZ-CM;
 Wed, 23 Oct 2024 20:29:03 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/4] pinctrl: imx: Convert to use livetree API for fdt access
Date: Wed, 23 Oct 2024 13:28:52 -0700
Message-Id: <20241023202855.1571188-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Without this if livetree is enabled (OF_LIVE) the imx8mq-pinctrl
driver will (silently) fail to probe causing issues with multiple
devices.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/pinctrl/nxp/pinctrl-imx.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index ff466c491041..b1960c56b512 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -22,7 +22,7 @@ static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 {
 	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
 	struct imx_pinctrl_soc_info *info = priv->info;
-	int node = dev_of_offset(config);
+	ofnode node = dev_ofnode(config);
 	const struct fdt_property *prop;
 	u32 *pin_data;
 	int npins, size, pin_size;
@@ -40,7 +40,7 @@ static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	else
 		pin_size = FSL_PIN_SIZE;
 
-	prop = fdt_getprop(gd->fdt_blob, node, "fsl,pins", &size);
+	prop = ofnode_get_property(node, "fsl,pins", &size);
 	if (!prop) {
 		dev_err(dev, "No fsl,pins property in node %s\n", config->name);
 		return -EINVAL;
@@ -56,8 +56,8 @@ static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	if (!pin_data)
 		return -ENOMEM;
 
-	if (fdtdec_get_int_array(gd->fdt_blob, node, "fsl,pins",
-				 pin_data, size >> 2)) {
+	if (ofnode_read_u32_array(node, "fsl,pins",
+				  pin_data, size >> 2)) {
 		dev_err(dev, "Error reading pin data.\n");
 		devm_kfree(dev, pin_data);
 		return -EINVAL;
@@ -202,10 +202,11 @@ int imx_pinctrl_probe(struct udevice *dev,
 		      struct imx_pinctrl_soc_info *info)
 {
 	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
-	int node = dev_of_offset(dev), ret;
-	struct fdtdec_phandle_args arg;
+	struct ofnode_phandle_args arg;
+	ofnode node = dev_ofnode(dev);
 	fdt_addr_t addr;
 	fdt_size_t size;
+	int ret;
 
 	if (!info) {
 		dev_err(dev, "wrong pinctrl info\n");
@@ -218,7 +219,7 @@ int imx_pinctrl_probe(struct udevice *dev,
 	if (info->flags & IMX8_USE_SCU)
 		return 0;
 
-	addr = devfdt_get_addr_size_index(dev, 0, &size);
+	addr = ofnode_get_addr_size_index(dev_ofnode(dev), 0, &size);
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
@@ -227,22 +228,20 @@ int imx_pinctrl_probe(struct udevice *dev,
 		return -ENOMEM;
 	priv->info = info;
 
-	info->mux_mask = fdtdec_get_int(gd->fdt_blob, node, "fsl,mux_mask", 0);
+	info->mux_mask = ofnode_read_u32(node, "fsl,mux_mask", 0);
 	/*
 	 * Refer to linux documentation for details:
 	 * Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
 	 */
-	if (fdtdec_get_bool(gd->fdt_blob, node, "fsl,input-sel")) {
-		ret = fdtdec_parse_phandle_with_args(gd->fdt_blob,
-						     node, "fsl,input-sel",
+	if (ofnode_read_bool(node, "fsl,input-sel")) {
+		ret = ofnode_parse_phandle_with_args(node, "fsl,input-sel",
 						     NULL, 0, 0, &arg);
 		if (ret) {
 			dev_err(dev, "iomuxc fsl,input-sel property not found\n");
 			return -EINVAL;
 		}
 
-		addr = fdtdec_get_addr_size(gd->fdt_blob, arg.node, "reg",
-					    &size);
+		addr = ofnode_get_addr_size(arg.node, "reg", &size);
 		if (addr == FDT_ADDR_T_NONE)
 			return -EINVAL;
 
-- 
2.25.1

