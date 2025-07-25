Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818C1C83F27
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 04:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA42838F8;
	Fri, 25 Jul 2025 06:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h7C1KwEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03042838FA; Fri, 25 Jul 2025 06:30:43 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F521835A2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56P4UHmV1663059;
 Thu, 24 Jul 2025 23:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753417817;
 bh=+ouyEFOnkEpJu+SHj8e/uJNmJulQdLXEUysKHr5Y+FE=;
 h=From:To:CC:Subject:Date;
 b=h7C1KwEQ5bm2UX83nEHnCwIT+SAw/WAceFXUL5VmVbfwWv/bIMkJRgrtwqx913urn
 /gQ5mQaf1rUef9rj3ca8fKl6F54eNaYdlKA/5Ijc6lYwUi/BzDr2Rp2M2HYVqjluEa
 2HxH5XBDQ2ZJ5FPfCqw+MH817loESVh40+oECojA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56P4UH3L3998148
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 24 Jul 2025 23:30:17 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 24
 Jul 2025 23:30:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 24 Jul 2025 23:30:17 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.227.22])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56P4UCaq1190869;
 Thu, 24 Jul 2025 23:30:13 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>, <agust@denx.de>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <u-boot@lists.denx.de>, <s-jain1@ti.com>
Subject: [PATCH v2] drivers: video: tidss: Refactor tidss_drv
Date: Fri, 25 Jul 2025 10:00:12 +0530
Message-ID: <20250725043012.1186886-1-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

- Refactor tidss_drv to improve modularity, enabling support for more
  display interfaces beyond OLDI in the future
- Add detection and initialization of active OLDI panels using the DT
- Port tidss_oldi.c from the upstream Linux kernel oldi series[0] and
  derive several APIs from it to determine the dual link pixel order
- Add tidss_oldi_init() and helper routines to handle OLDI-specific
  setup and move related helper routines to tidss_oldi.c

[0]: https://lore.kernel.org/all/20250528122544.817829-1-aradhya.bhatia@linux.dev/

Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
Changes in v2:
- Iterate through all available OLDIs
- Move dss_oldi_tx_power from tidss_drv.c to tidss_oldi.c
- Rename tidss_attach_active_panel to a more generic name
- To handle all active hw video ports, add an array for active hw vps
- Iterate through all active hw vps to enable respective clks

Link to v1: https://lore.kernel.org/u-boot/20250603105735.4038240-1-s-jain1@ti.com/
---
 drivers/video/tidss/Makefile     |   2 +-
 drivers/video/tidss/tidss_drv.c  | 215 +++++++++++++-------
 drivers/video/tidss/tidss_drv.h  |  14 +-
 drivers/video/tidss/tidss_oldi.c | 332 +++++++++++++++++++++++++++++++
 drivers/video/tidss/tidss_oldi.h |  89 +++++++++
 drivers/video/tidss/tidss_regs.h |  21 --
 6 files changed, 574 insertions(+), 99 deletions(-)
 create mode 100644 drivers/video/tidss/tidss_oldi.c
 create mode 100644 drivers/video/tidss/tidss_oldi.h

diff --git a/drivers/video/tidss/Makefile b/drivers/video/tidss/Makefile
index 3381a5fec57..846c19c5a7b 100644
--- a/drivers/video/tidss/Makefile
+++ b/drivers/video/tidss/Makefile
@@ -9,4 +9,4 @@
 # Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
 
 
-obj-${CONFIG_$(PHASE_)VIDEO_TIDSS} = tidss_drv.o
+obj-${CONFIG_$(PHASE_)VIDEO_TIDSS} = tidss_drv.o tidss_oldi.o
diff --git a/drivers/video/tidss/tidss_drv.c b/drivers/video/tidss/tidss_drv.c
index 865d4bddb7f..76985931198 100644
--- a/drivers/video/tidss/tidss_drv.c
+++ b/drivers/video/tidss/tidss_drv.c
@@ -32,6 +32,7 @@
 #include <dm/of_access.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
+#include <dm/ofnode_graph.h>
 
 #include <linux/bug.h>
 #include <linux/err.h>
@@ -40,6 +41,7 @@
 
 #include "tidss_drv.h"
 #include "tidss_regs.h"
+#include "tidss_oldi.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -249,37 +251,6 @@ static void OVR_REG_FLD_MOD(struct tidss_drv_priv *priv, u32 ovr, u32 idx,
 					      val, start, end));
 }
 
-static void dss_oldi_tx_power(struct tidss_drv_priv *priv, bool power)
-{
-	u32 val;
-
-	if (WARN_ON(!priv->oldi_io_ctrl))
-		return;
-
-	if (priv->feat->subrev == DSS_AM625) {
-		if (power) {
-			switch (priv->oldi_mode) {
-			case OLDI_SINGLE_LINK_SINGLE_MODE:
-				/* Power down OLDI TX 1 */
-				val = OLDI1_PWRDN_TX;
-				break;
-			case OLDI_DUAL_LINK:
-				/* No Power down */
-				val = 0;
-			break;
-			default:
-				/* Power down both the OLDI TXes */
-				val = OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX;
-				break;
-			}
-		} else {
-			val = OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX;
-		}
-		regmap_update_bits(priv->oldi_io_ctrl, OLDI_PD_CTRL,
-				   OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX, val);
-	}
-}
-
 static void dss_set_num_datalines(struct tidss_drv_priv *priv,
 				  u32 hw_videoport)
 {
@@ -562,7 +533,7 @@ int dss_vp_enable_clk(struct tidss_drv_priv *priv, u32 hw_videoport)
 void dss_vp_prepare(struct tidss_drv_priv *priv, u32 hw_videoport)
 {
 	dss_vp_set_gamma(priv, hw_videoport, NULL, 0);
-	dss_vp_set_default_color(priv, 0, 0);
+	dss_vp_set_default_color(priv, hw_videoport, 0);
 
 	if (priv->feat->vp_bus_type[hw_videoport] == DSS_VP_OLDI) {
 		dss_oldi_tx_power(priv, true);
@@ -734,27 +705,111 @@ static void dss_vp_init(struct tidss_drv_priv *priv)
 		VP_REG_FLD_MOD(priv, i, DSS_VP_CONFIG, 1, 2, 2);
 }
 
-static int dss_init_am65x_oldi_io_ctrl(struct udevice *dev,
-				       struct tidss_drv_priv *priv)
+bool is_pipeline_components_enabled(ofnode endpoint, ofnode prev)
 {
-	struct udevice *syscon;
-	struct regmap *regmap;
-	int ret = 0;
+	ofnode ports_parent = ofnode_graph_get_port_parent(endpoint);
+	ofnode ports = ofnode_find_subnode(ports_parent, "ports");
+	ofnode port, local_endpoint, remote_endpoint;
 
-	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "ti,am65x-oldi-io-ctrl",
-					   &syscon);
-	if (ret) {
-		debug("unable to find ti,am65x-oldi-io-ctrl syscon device (%d)\n", ret);
-		return ret;
+	if (!ofnode_valid(ports) || !ofnode_valid(ports_parent))
+		return false;
+
+	if (strstr(ofnode_get_name(ports_parent), "dss"))
+		/*
+		 * If we reach dss again, return true. In the case of a dual-link OLDI,
+		 * we have 2 ports. While traversing oldi@0, this API also traverses oldi@1
+		 * and hence it will reach dss_ports again. If it reaches dss_ports,
+		 * that means every element in the pipeline is enabled already, and hence
+		 * if dss is reached, return true.
+		 */
+		return true;
+
+	/*
+	 *Traverse all endpoints of the ports node.
+	 */
+	ofnode_for_each_subnode(port, ports) {
+		if (strncmp(ofnode_get_name(port), "port", 4))
+			continue;
+		ofnode_for_each_subnode(local_endpoint, port) {
+			if (strncmp(ofnode_get_name(local_endpoint), "endpoint", 8))
+				continue;
+			remote_endpoint = ofnode_graph_get_remote_endpoint(local_endpoint);
+			if (prev.np == remote_endpoint.np)
+				continue;
+			return ofnode_is_enabled(remote_endpoint) &&
+			       is_pipeline_components_enabled(remote_endpoint, local_endpoint);
+		}
 	}
+	return true;
+}
+
+static bool is_bridge_and_panel_enabled(ofnode endpoint)
+{
+	ofnode remote_endpoint = ofnode_graph_get_remote_endpoint(endpoint);
+	ofnode prev_endpoint = endpoint;
 
-	/* get grf-reg base address */
-	regmap = syscon_get_regmap(syscon);
-	if (!regmap) {
-		debug("unable to find rockchip grf regmap\n");
-		return -ENODEV;
+	return is_pipeline_components_enabled(remote_endpoint, prev_endpoint);
+}
+
+static int tidss_enable_pipeline_components(struct tidss_drv_priv *priv)
+{
+	/*
+	 * Check if any bridge is present in the pipeline and initialize it.
+	 * Pipeline here refer to DSS=>bridges=>panel. If we find all elements
+	 * of a pipeline enabled in DT then only pipeline is enabled.
+	 * This function returns active panels count with all bridges with sink
+	 * are enabled in DT.
+	 */
+	ofnode dss_node = dev_ofnode(priv->dev);
+	ofnode dss_ports = ofnode_find_subnode(dss_node, "ports");
+	ofnode port, remote_port, local_endpoint;
+	int hw_videoport;
+	int active_pipelines = 0;
+	int ret;
+
+	ofnode_for_each_subnode(port, dss_ports) {
+		if (strncmp(ofnode_get_name(port), "port", 4))
+			continue;
+
+		ofnode_for_each_subnode(local_endpoint, port) {
+			if (strncmp(ofnode_get_name(local_endpoint), "endpoint", 8))
+				continue;
+
+			if (!is_bridge_and_panel_enabled(local_endpoint))
+				continue;
+
+			/* Get videoport id*/
+			ret = ofnode_read_u32(port, "reg", &hw_videoport);
+			if (ret) {
+				dev_warn(priv->dev,
+					 "Failed to read videoport id, reg property not found for node: %s\n",
+					 ofnode_get_name(local_endpoint));
+				/* Check for other video ports */
+				continue;
+			}
+
+			remote_port = ofnode_graph_get_remote_port_parent(local_endpoint);
+			if (strstr(ofnode_get_name(remote_port), "oldi")) {
+				/* Initialize oldi */
+				ret = tidss_oldi_init(priv->dev);
+				if (ret) {
+					if (ret != -ENODEV)
+						dev_warn(priv->dev, "oldi panel error %d\n", ret);
+					break;
+				}
+
+				priv->active_hw_vps[active_pipelines++] = hw_videoport;
+				/*
+				 * Only one dual-link oldi panel supported at a time so
+				 * initialize it only and then check for other videoports
+				 */
+				break;
+			}
+		}
 	}
-	priv->oldi_io_ctrl = regmap;
+	priv->active_pipelines = active_pipelines;
+	if (active_pipelines == 0)
+		return -1;
 	return 0;
 }
 
@@ -772,7 +827,6 @@ static int tidss_drv_probe(struct udevice *dev)
 	priv->dev = dev;
 
 	priv->feat = &dss_am625_feats;
-
     /*
      * set your plane format based on your bmp image
      * Supported 24bpp and 32bpp bmpimages
@@ -782,6 +836,18 @@ static int tidss_drv_probe(struct udevice *dev)
 
 	dss_common_regmap = priv->feat->common_regs;
 
+	/*
+	 * Check for all components present in the pipeline. Pipeline here refers
+	 * to: DSS_HW_VP*=>bridge[0]=>....=>bridge[n]=>panel. Enable all
+	 * components in the pipeline.
+	 */
+	ret = tidss_enable_pipeline_components(priv);
+	if (ret) {
+		if (ret == -1)
+			dev_warn(priv->dev, "NO active panels detected, check status of panel nodes\n");
+		return ret;
+	}
+
 	ret = uclass_first_device_err(UCLASS_PANEL, &panel);
 	if (ret) {
 		if (ret != -ENODEV)
@@ -829,10 +895,12 @@ static int tidss_drv_probe(struct udevice *dev)
 	dss_vid_write(priv, 0, DSS_VID_BA_1, uc_plat->base & 0xffffffff);
 	dss_vid_write(priv, 0, DSS_VID_BA_EXT_1, (u64)uc_plat->base >> 32);
 
-	ret = dss_plane_setup(priv, 0, 0);
-	if (ret) {
-		dss_plane_enable(priv, 0, false);
-			return ret;
+	for (i = 0; i < priv->active_pipelines; i++) {
+		ret = dss_plane_setup(priv, 0, priv->active_hw_vps[i]);
+		if (ret) {
+			dss_plane_enable(priv, 0, false);
+				return ret;
+		}
 	}
 
 	dss_plane_enable(priv, 0, true);
@@ -844,34 +912,31 @@ static int tidss_drv_probe(struct udevice *dev)
 		priv->base_vp[i] = dev_remap_addr_name(dev, priv->feat->vp_name[i]);
 	}
 
-	ret = clk_get_by_name(dev, "vp1", &priv->vp_clk[0]);
-	if (ret) {
-		dev_err(dev, "video port %d clock enable error %d\n", i, ret);
-		return ret;
-	}
+	uc_priv->xsize = timings.hactive.typ;
+	uc_priv->ysize = timings.vactive.typ;
 
-	dss_ovr_set_plane(priv, 1, 0, 0, 0, 0);
-	dss_ovr_enable_layer(priv, 0, 0, true);
+	for (i = 0; i < priv->active_pipelines; i++) {
 
-	/* Video Port cloks */
-	dss_vp_enable_clk(priv, 0);
+		ret = clk_get_by_name(dev,
+				      dss_am625_feats.vpclk_name[priv->active_hw_vps[i]],
+				      &priv->vp_clk[priv->active_hw_vps[i]]);
+		if (ret) {
+			dev_err(dev, "video port %d clock enable error %d\n", i, ret);
+			return ret;
+		}
 
-	dss_vp_set_clk_rate(priv, 0, timings.pixelclock.typ * 1000);
+		dss_ovr_set_plane(priv, 1, priv->active_hw_vps[i], 0, 0, 0);
+		dss_ovr_enable_layer(priv, priv->active_hw_vps[i], 0, true);
 
-	priv->oldi_mode = OLDI_MODE_OFF;
-	uc_priv->xsize = timings.hactive.typ;
-	uc_priv->ysize = timings.vactive.typ;
-	if (priv->feat->subrev == DSS_AM65X || priv->feat->subrev == DSS_AM625) {
-		priv->oldi_mode = OLDI_DUAL_LINK;
-		if (priv->oldi_mode) {
-			ret = dss_init_am65x_oldi_io_ctrl(dev, priv);
-			if (ret)
-				return ret;
-		}
+		/* Video Port cloks */
+		dss_vp_enable_clk(priv, priv->active_hw_vps[i]);
+
+		dss_vp_set_clk_rate(priv, priv->active_hw_vps[i], timings.pixelclock.typ * 1000);
+
+		dss_vp_prepare(priv, priv->active_hw_vps[i]);
+		dss_vp_enable(priv, priv->active_hw_vps[i], &timings);
 	}
 
-	dss_vp_prepare(priv, 0);
-	dss_vp_enable(priv, 0, &timings);
 	dss_vp_init(priv);
 
 	ret = clk_get_by_name(dev, "fck", &priv->fclk);
diff --git a/drivers/video/tidss/tidss_drv.h b/drivers/video/tidss/tidss_drv.h
index e229d975ff4..04f124f4d27 100644
--- a/drivers/video/tidss/tidss_drv.h
+++ b/drivers/video/tidss/tidss_drv.h
@@ -13,9 +13,12 @@
 #define __TIDSS_DRV_H__
 
 #include <media_bus_format.h>
+#include <syscon.h>
+#include <regmap.h>
 
 #define TIDSS_MAX_PORTS 4
 #define TIDSS_MAX_PLANES 4
+#define TIDSS_MAX_OLDI_TXES 2
 
 enum dss_vp_bus_type {
 	DSS_VP_DPI,		/* DPI output */
@@ -31,6 +34,8 @@ enum dss_oldi_modes {
 	OLDI_DUAL_LINK,				/* Combined Output over OLDI 0 and 1. */
 };
 
+enum oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
+
 struct dss_features_scaling {
 	u32 in_width_max_5tap_rgb;
 	u32 in_width_max_3tap_rgb;
@@ -96,13 +101,13 @@ struct dss_features {
 	u32 vid_order[TIDSS_MAX_PLANES];
 };
 
-enum dss_oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
+// enum dss_oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
 
 struct dss_bus_format {
 	u32 bus_fmt;
 	u32 data_width;
 	bool is_oldi_fmt;
-	enum dss_oldi_mode_reg_val oldi_mode_reg_val;
+	enum oldi_mode_reg_val oldi_mode_reg_val;
 };
 
 static struct dss_bus_format dss_bus_formats[] = {
@@ -132,6 +137,11 @@ struct tidss_drv_priv {
 	struct dss_bus_format *bus_format;
 	u32 pixel_format;
 	u32 memory_bandwidth_limit;
+	unsigned int num_oldis;
+	struct tidss_oldi *oldis[TIDSS_MAX_OLDI_TXES];
+	u8 active_hw_vps[TIDSS_MAX_PORTS];
+	u8 active_pipelines;
 };
 
+struct tidss_oldi;
 #endif
diff --git a/drivers/video/tidss/tidss_oldi.c b/drivers/video/tidss/tidss_oldi.c
new file mode 100644
index 00000000000..700ad966129
--- /dev/null
+++ b/drivers/video/tidss/tidss_oldi.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Swamil Jain <s-jain1@ti.com>
+ *
+ * based on the linux tidss_oldi.c, which is
+ *
+ * Copyright (C) 2024 - Texas Instruments Incorporated
+ * Author: Aradhya Bhatia <a-bhatia1@ti.com>
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <syscon.h>
+#include <clk.h>
+#include <regmap.h>
+
+#include <dm/ofnode_graph.h>
+#include <dm/ofnode.h>
+#include <dm/device_compat.h>
+
+#include <linux/bug.h>
+
+#include "tidss_oldi.h"
+
+enum tidss_oldi_pixels {
+	OLDI_PIXELS_EVEN = BIT(0),
+	OLDI_PIXELS_ODD = BIT(1),
+};
+
+/**
+ * enum tidss_oldi_dual_link_pixels - Pixel order of an OLDI dual-link connection
+ * @TIDSS_OLDI_DUAL_LINK_EVEN_ODD_PIXELS: Even pixels are expected to be generated
+ *    from the first port, odd pixels from the second port
+ * @TIDSS_OLDI_DUAL_LINK_ODD_EVEN_PIXELS: Odd pixels are expected to be generated
+ *    from the first port, even pixels from the second port
+ */
+enum tidss_oldi_dual_link_pixels {
+	TIDSS_OLDI_DUAL_LINK_EVEN_ODD_PIXELS = 0,
+	TIDSS_OLDI_DUAL_LINK_ODD_EVEN_PIXELS = 1,
+};
+
+static const struct oldi_bus_format oldi_bus_formats[] = {
+	{ MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,	18, SPWG_18,	MEDIA_BUS_FMT_RGB666_1X18 },
+	{ MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,	24, SPWG_24,	MEDIA_BUS_FMT_RGB888_1X24 },
+	{ MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,	24, JEIDA_24,	MEDIA_BUS_FMT_RGB888_1X24 },
+};
+
+static int tidss_oldi_get_port_pixels_type(ofnode port_node)
+{
+	bool even_pixels =
+		ofnode_has_property(port_node, "dual-lvds-even-pixels");
+	bool odd_pixels =
+		ofnode_has_property(port_node, "dual-lvds-odd-pixels");
+	return (even_pixels ? OLDI_PIXELS_EVEN : 0) |
+	       (odd_pixels ? OLDI_PIXELS_ODD : 0);
+}
+
+static int tidss_oldi_get_remote_pixels_type(ofnode port_node)
+{
+	ofnode endpoint = ofnode_null();
+	int pixels_type = -EPIPE;
+
+	ofnode_for_each_subnode(endpoint, port_node) {
+		ofnode remote_port;
+		int current_pt;
+
+		if (!ofnode_name_eq(endpoint, "endpoint"))
+			continue;
+
+		remote_port = ofnode_graph_get_remote_port(endpoint);
+		if (!ofnode_valid(remote_port))
+			return -EPIPE;
+
+		current_pt = tidss_oldi_get_port_pixels_type(remote_port);
+		if (pixels_type < 0)
+			pixels_type = current_pt;
+
+		if (!current_pt || pixels_type != current_pt)
+			return -EINVAL;
+	}
+
+	return pixels_type;
+}
+
+int tidss_oldi_get_dual_link_pixel_order(ofnode port1, ofnode port2)
+{
+	int remote_p1_pt, remote_p2_pt;
+
+	if (!ofnode_valid(port1) || !ofnode_valid(port2))
+		return -EINVAL;
+
+	remote_p1_pt = tidss_oldi_get_remote_pixels_type(port1);
+	if (remote_p1_pt < 0)
+		return remote_p1_pt;
+
+	remote_p2_pt = tidss_oldi_get_remote_pixels_type(port2);
+	if (remote_p2_pt < 0)
+		return remote_p2_pt;
+
+	/*
+	 * A valid dual-lVDS bus is found when one remote port is marked with
+	 * "dual-lvds-even-pixels", and the other remote port is marked with
+	 * "dual-lvds-odd-pixels", bail out if the markers are not right.
+	 */
+	if (remote_p1_pt + remote_p2_pt != OLDI_PIXELS_EVEN + OLDI_PIXELS_ODD)
+		return -EINVAL;
+
+	return remote_p1_pt == OLDI_PIXELS_EVEN ?
+		TIDSS_OLDI_DUAL_LINK_EVEN_ODD_PIXELS :
+		TIDSS_OLDI_DUAL_LINK_ODD_EVEN_PIXELS;
+}
+
+static int get_oldi_mode(ofnode oldi_tx, u32 *companion_instance)
+{
+	ofnode companion;
+	ofnode port0, port1;
+	int pixel_order;
+	int ret;
+	/*
+	 * Find if the OLDI is paired with another OLDI for combined OLDI
+	 * operation (dual-lvds or clone).
+	 */
+	companion = ofnode_parse_phandle(oldi_tx, "ti,companion-oldi", 0);
+	if (!ofnode_valid(companion)) {
+		/*
+		 * OLDI TXes in Single Link mode do not have companion
+		 * OLDI TXes and, Secondary OLDI nodes don't need this
+		 * information.
+		 */
+		if (ofnode_has_property(oldi_tx, "ti,secondary-oldi"))
+			return OLDI_MODE_SECONDARY;
+
+		/*
+		 * The OLDI TX does not have a companion, nor is it a
+		 * secondary OLDI. It will operate independently.
+		 */
+		return OLDI_MODE_SINGLE_LINK;
+	}
+
+	ret = ofnode_read_u32(companion, "reg", companion_instance);
+	if (ret)
+		return OLDI_MODE_UNSUPPORTED;
+
+	/*
+	 * We need to work out if the sink is expecting us to function in
+	 * dual-link mode. We do this by looking at the DT port nodes we are
+	 * connected to, if they are marked as expecting even pixels and
+	 * odd pixels than we need to enable vertical stripe output.
+	 */
+	port0 = ofnode_graph_get_port_by_id(oldi_tx, 1);
+	port1 = ofnode_graph_get_port_by_id(companion, 1);
+	pixel_order = tidss_oldi_get_dual_link_pixel_order(port0, port1);
+	switch (pixel_order) {
+	case -EINVAL:
+		/*
+		 * The dual link properties were not found in at least
+		 * one of the sink nodes. Since 2 OLDI ports are present
+		 * in the DT, it can be safely assumed that the required
+		 * configuration is Clone Mode.
+		 */
+		return OLDI_MODE_CLONE_SINGLE_LINK;
+
+	case TIDSS_OLDI_DUAL_LINK_ODD_EVEN_PIXELS:
+		return OLDI_MODE_DUAL_LINK;
+
+	/* Unsupported OLDI Modes */
+	case TIDSS_OLDI_DUAL_LINK_EVEN_ODD_PIXELS:
+	default:
+		return OLDI_MODE_UNSUPPORTED;
+	}
+}
+
+static int get_parent_dss_vp(ofnode oldi_tx, u32 *parent_vp)
+{
+	ofnode ep, dss_port;
+	int ret;
+
+	ep = ofnode_graph_get_endpoint_by_regs(oldi_tx, 0, -1);
+	if (ofnode_valid(ep)) {
+		dss_port = ofnode_graph_get_remote_port(ep);
+		if (!ofnode_valid(dss_port))
+			ret = -ENODEV;
+
+		ret = ofnode_read_u32(dss_port, "reg", parent_vp);
+		if (ret)
+			return -ENODEV;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static int tidss_init_oldi_io_ctrl(struct udevice *dev, struct tidss_oldi *tidss_oldi)
+{
+	struct udevice *syscon;
+	struct regmap *regmap = NULL;
+	int ret = 0;
+
+	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "ti,am65x-oldi-io-ctrl",
+					   &syscon);
+	if (ret) {
+		debug("unable to find ti,am65x-oldi-io-ctrl syscon device (%d)\n", ret);
+		return ret;
+	}
+
+	/* get grf-reg base address */
+	regmap = syscon_get_regmap(syscon);
+	if (!regmap) {
+		debug("unable to find rockchip grf regmap\n");
+		return -ENODEV;
+	}
+	tidss_oldi->io_ctrl = regmap;
+	return 0;
+}
+
+int tidss_oldi_init(struct udevice *dev)
+{
+	struct tidss_drv_priv *priv = dev_get_priv(dev);
+	u32 parent_vp, oldi_instance, companion_instance;
+	int ret, tidss_oldi_panel_count = 0;
+	enum tidss_oldi_link_type link_type;
+	struct tidss_oldi *tidss_oldi;
+	struct clk *serial;
+	ofnode child;
+	ofnode oldi_parent = ofnode_find_subnode(dev_ofnode(dev), "oldi-transmitters");
+
+	if (!ofnode_valid(oldi_parent))
+		/* Return gracefully */
+		return 0;
+
+	ofnode_for_each_subnode(child, oldi_parent) {
+		priv->oldis[tidss_oldi_panel_count] = NULL;
+
+		ret = get_parent_dss_vp(child, &parent_vp);
+		if (ret == -ENODEV) {
+			/*
+			 * ENODEV means that this particular OLDI node
+			 * is not connected with the DSS, which is not
+			 * a harmful case. There could be another OLDI
+			 * which may still be connected.
+			 * Continue to search for that.
+			 */
+			ret = 0;
+			continue;
+		}
+
+		ret = ofnode_read_u32(child, "reg", &oldi_instance);
+		if (ret) {
+			ret = -ENODEV;
+			break;
+		}
+
+		link_type = get_oldi_mode(child, &companion_instance);
+		if (link_type == OLDI_MODE_UNSUPPORTED) {
+			dev_warn(dev, "OLDI%u: Unsupported OLDI connection.\n", oldi_instance);
+
+			ret = OLDI_MODE_UNSUPPORTED;
+			/* Return gracefully, no supported OLDI panel found */
+			break;
+		} else if (link_type == OLDI_MODE_SECONDARY) {
+			/*
+			 * This is the secondary OLDI node, which serves as a
+			 * companinon to the primary OLDI, when it is configured
+			 * for the dual-lvds mode. Since the primary OLDI will
+			 * be a part of bridge chain, no need to put this one
+			 * too. Continue onto the next OLDI node.
+			 */
+			continue;
+		}
+
+		serial = malloc(sizeof(struct clk));
+		ret = clk_get_by_name_nodev(child, "serial", serial);
+		if (ret) {
+			dev_err(dev, "video port %d clock enable error %d\n", parent_vp, ret);
+			free(serial);
+			return ret;
+		}
+
+		tidss_oldi = malloc(sizeof(struct tidss_oldi));
+		ret = tidss_init_oldi_io_ctrl(dev, tidss_oldi);
+		if (ret) {
+			debug("tidss could not initialize oldi_io_ctrl\n");
+			free(serial);
+			free(tidss_oldi);
+			return ret;
+		}
+
+		tidss_oldi->dev = dev;
+		tidss_oldi->parent_vp = parent_vp;
+		tidss_oldi->oldi_instance = oldi_instance;
+		tidss_oldi->companion_instance = companion_instance;
+		tidss_oldi->link_type = link_type;
+		tidss_oldi->serial = serial;
+		priv->oldis[tidss_oldi_panel_count] = tidss_oldi;
+		priv->oldi_mode = link_type;
+		tidss_oldi_panel_count++;
+	}
+	priv->num_oldis = tidss_oldi_panel_count;
+	return 0;
+}
+
+void dss_oldi_tx_power(struct tidss_drv_priv *priv, bool power)
+{
+	u32 val;
+
+	if (WARN_ON(!priv->oldis[0]->io_ctrl))
+		return;
+
+	if (priv->feat->subrev == DSS_AM625) {
+		if (power) {
+			switch (priv->oldi_mode) {
+			case OLDI_SINGLE_LINK_SINGLE_MODE:
+				/* Power down OLDI TX 1 */
+				val = OLDI1_PWRDN_TX;
+				break;
+			case OLDI_DUAL_LINK:
+				/* No Power down */
+				val = 0;
+			break;
+			default:
+				/* Power down both the OLDI TXes */
+				val = OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX;
+				break;
+			}
+		} else {
+			val = OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX;
+		}
+		regmap_update_bits(priv->oldis[0]->io_ctrl, OLDI_PD_CTRL,
+				   OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX, val);
+	}
+}
diff --git a/drivers/video/tidss/tidss_oldi.h b/drivers/video/tidss/tidss_oldi.h
new file mode 100644
index 00000000000..aa38c6d9fdb
--- /dev/null
+++ b/drivers/video/tidss/tidss_oldi.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Swamil Jain <s-jain1@ti.com>
+ *
+ * based on the linux tidss_oldi.c, which is
+ *
+ * Copyright (C) 2024 - Texas Instruments Incorporated
+ * Author: Aradhya Bhatia <a-bhatia1@ti.com>
+ */
+
+#ifndef __TIDSS_OLDI_H__
+#define __TIDSS_OLDI_H__
+
+#include <dm/ofnode.h>
+#include <dm/of_access.h>
+#include <media_bus_format.h>
+
+#include "tidss_drv.h"
+
+/* OLDI PORTS */
+#define OLDI_INPUT_PORT    0
+#define OLDI_OURPUT_PORT   1
+
+/* Control MMR Registers */
+
+/* Register offsets */
+#define OLDI_PD_CTRL            0x100
+#define OLDI_LB_CTRL            0x104
+
+/* Power control bits */
+#define OLDI_PWRDOWN_TX(n)	BIT(n)
+
+/* LVDS Bandgap reference Enable/Disable */
+#define OLDI_PWRDN_BG		BIT(8)
+
+/*
+ * OLDI IO_CTRL register offsets. On AM654 the registers are found
+ * from CTRL_MMR0, there the syscon regmap should map 0x14 bytes from
+ * CTRLMMR0P1_OLDI_DAT0_IO_CTRL to CTRLMMR0P1_OLDI_CLK_IO_CTRL
+ * register range.
+ */
+#define OLDI_DAT0_IO_CTRL			0x00
+#define OLDI_DAT1_IO_CTRL			0x04
+#define OLDI_DAT2_IO_CTRL			0x08
+#define OLDI_DAT3_IO_CTRL			0x0C
+#define OLDI_CLK_IO_CTRL			0x10
+
+/* Only for AM625 OLDI TX */
+#define OLDI_PD_CTRL				0x100
+#define OLDI_LB_CTRL				0x104
+
+#define OLDI_BANDGAP_PWR			BIT(8)
+#define OLDI_PWRDN_TX				BIT(8)
+#define OLDI0_PWRDN_TX				BIT(0)
+#define OLDI1_PWRDN_TX				BIT(1)
+
+enum tidss_oldi_link_type {
+	OLDI_MODE_UNSUPPORTED,
+	OLDI_MODE_SINGLE_LINK,
+	OLDI_MODE_CLONE_SINGLE_LINK,
+	OLDI_MODE_DUAL_LINK,
+	OLDI_MODE_SECONDARY,
+};
+
+struct oldi_bus_format {
+	u32 bus_fmt;
+	u32 data_width;
+	enum oldi_mode_reg_val oldi_mode_reg_val;
+	u32 input_bus_fmt;
+};
+
+struct tidss_oldi {
+	struct udevice *dev;
+
+	enum tidss_oldi_link_type link_type;
+	const struct oldi_bus_format *bus_format;
+	u32 oldi_instance;
+	u32 companion_instance;
+	u32 parent_vp;
+
+	struct clk *serial;
+	struct regmap *io_ctrl;
+};
+
+int tidss_oldi_init(struct udevice *dev);
+void dss_oldi_tx_power(struct tidss_drv_priv *priv, bool power);
+
+#endif /* __TIDSS_OLDI_H__ */
diff --git a/drivers/video/tidss/tidss_regs.h b/drivers/video/tidss/tidss_regs.h
index 440db8d1c7a..4ee8b330a20 100644
--- a/drivers/video/tidss/tidss_regs.h
+++ b/drivers/video/tidss/tidss_regs.h
@@ -231,27 +231,6 @@ enum dss_common_regs {
 #define DSS_VP_DSS_DMA_THREADSIZE		0x170 /* J721E */
 #define DSS_VP_DSS_DMA_THREADSIZE_STATUS	0x174 /* J721E */
 
-/*
- * OLDI IO_CTRL register offsets. On AM654 the registers are found
- * from CTRL_MMR0, there the syscon regmap should map 0x14 bytes from
- * CTRLMMR0P1_OLDI_DAT0_IO_CTRL to CTRLMMR0P1_OLDI_CLK_IO_CTRL
- * register range.
- */
-#define OLDI_DAT0_IO_CTRL			0x00
-#define OLDI_DAT1_IO_CTRL			0x04
-#define OLDI_DAT2_IO_CTRL			0x08
-#define OLDI_DAT3_IO_CTRL			0x0C
-#define OLDI_CLK_IO_CTRL			0x10
-
-/* Only for AM625 OLDI TX */
-#define OLDI_PD_CTRL				0x100
-#define OLDI_LB_CTRL				0x104
-
-#define OLDI_BANDGAP_PWR			BIT(8)
-#define OLDI_PWRDN_TX				BIT(8)
-#define OLDI0_PWRDN_TX				BIT(0)
-#define OLDI1_PWRDN_TX				BIT(1)
-
 /* Supported plane formats */
 #define DSS_FORMAT_ARGB4444 0x0
 #define DSS_FORMAT_ABGR4444 0x1
