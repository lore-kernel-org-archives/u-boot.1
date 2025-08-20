Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D13CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 17:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED138309D;
	Wed, 20 Aug 2025 19:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="G6X2AjqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC1F8304A; Wed, 20 Aug 2025 18:20:23 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3492C8006D
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 18:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=03278829c7=raphael.gallais-pou@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KG9J51031339;
 Wed, 20 Aug 2025 18:20:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 SChkWK6p/jiz26r2fbCbcAcuKthRdIoxyVKbNF3FkuA=; b=G6X2AjqK6v+CqewP
 yZHyTjvHQV0N0URK93BdmBwHRJlkRJni7EsWp8nNl2Ldd8CZ/mAz/IR4iMNcIkMB
 iM9YfN3BGW7YRu75S8GtLJIMkpvv3TQWNYbFW+LqLnO1m097LFv4sZFwA4v0hV+B
 lezpvddTLifXuTNyC4qB+Fw7rBcfL9TOpFFzis0UPk8bRzxI4Xp1JPCARblwjnih
 K9UNY9QM9qxSJM4EZau80TkwzHjWkp/TerSKL5S8tUuxsrxQZSJnPIxKXpszoTFx
 syLNVQmDDhAonCLXgRyqnPrEF9QdxcUjanJcHslFMP5lxK+/xN/eqPY3LT3JLBit
 GC019Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n7w5tm9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 18:20:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 443CB40045;
 Wed, 20 Aug 2025 18:19:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92B2272B81D;
 Wed, 20 Aug 2025 18:19:00 +0200 (CEST)
Received: from localhost (10.252.7.99) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 18:19:00 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Wed, 20 Aug 2025 18:17:44 +0200
Subject: [PATCH 5/8] video: stm32: ltdc: properly search the first
 available panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250820-master-v1-5-fc76f18ab2fd@foss.st.com>
References: <20250820-master-v1-0-fc76f18ab2fd@foss.st.com>
In-Reply-To: <20250820-master-v1-0-fc76f18ab2fd@foss.st.com>
To: Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Dillon Min
 <dillon.minfei@gmail.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [10.252.7.99]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Mailman-Approved-At: Wed, 20 Aug 2025 19:14:09 +0200
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

Initially there was only one DSI bridge with one panel attached to this
device. This explained the call to uclass_first_device_err(UCLASS_PANEL,
...) which worked fine at the time.

Now that multiple bridges and panels, with different technologies, can
be plugged onto the board this way to get the panel device is outdated.

The lookup is done is two steps. First we cirle through the
UCLASS_VIDEO_BRIDGE, and once we get one, we search through its
endpoints until we get a UCLASS_PANEL device available.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 drivers/video/stm32/stm32_ltdc.c | 136 +++++++++++++++++++++++++++++++++++----
 1 file changed, 125 insertions(+), 11 deletions(-)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index d9ba5c4ef53558fe8b5565d47b022699d9e4ea0e..cdcfde678fb59ad884125e7c26f43710d76ba246 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -17,6 +17,7 @@
 #include <video_bridge.h>
 #include <asm/io.h>
 #include <dm/device-internal.h>
+#include <dm/uclass-internal.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
@@ -495,6 +496,101 @@ static void stm32_ltdc_set_layer1(struct stm32_ltdc_priv *priv, ulong fb_addr)
 	setbits_le32(priv->regs + LTDC_L1CR, LXCR_LEN);
 }
 
+static int stm32_ltdc_get_remote_device(struct udevice *dev, ofnode ep_node,
+					enum uclass_id id, struct udevice **remote_dev)
+{
+	u32 remote_phandle;
+	ofnode remote;
+	int ret = 0;
+
+	ret = ofnode_read_u32(ep_node, "remote-endpoint", &remote_phandle);
+	if (ret) {
+		dev_err(dev, "%s(%s): Could not find remote-endpoint property\n",
+			__func__, dev_read_name(dev));
+		return ret;
+	}
+
+	remote = ofnode_get_by_phandle(remote_phandle);
+	if (!ofnode_valid(remote))
+		return -EINVAL;
+
+	while (ofnode_valid(remote)) {
+		remote = ofnode_get_parent(remote);
+		if (!ofnode_valid(remote)) {
+			dev_dbg(dev, "%s(%s): no uclass_id %d for remote-endpoint\n",
+				__func__, dev_read_name(dev), id);
+			continue;
+		}
+
+		ret = uclass_find_device_by_ofnode(id, remote, remote_dev);
+		if (*remote_dev && !ret) {
+			ret = uclass_get_device_by_ofnode(id, remote, remote_dev);
+			if (ret)
+				dev_dbg(dev, "%s(%s): failed to get remote device %s\n",
+					__func__, dev_read_name(dev), dev_read_name(*remote_dev));
+			break;
+		}
+	};
+
+	return ret;
+}
+
+static int stm32_ltdc_get_panel(struct udevice *dev, struct udevice **panel)
+{
+	ofnode ep_node, node, ports;
+	int ret = 0;
+
+	if (!dev)
+		return -EINVAL;
+
+	ports = ofnode_find_subnode(dev_ofnode(dev), "ports");
+	if (!ofnode_valid(ports)) {
+		dev_err(dev, "Remote bridge subnode\n");
+		return ret;
+	}
+
+	for (node = ofnode_first_subnode(ports);
+	     ofnode_valid(node);
+	     node = dev_read_next_subnode(node)) {
+		ep_node = ofnode_first_subnode(node);
+		if (!ofnode_valid(ep_node))
+			continue;
+
+		ret = stm32_ltdc_get_remote_device(dev, ep_node, UCLASS_PANEL, panel);
+	}
+
+	/* Sanity check, we can get out of the loop without having a clean ofnode */
+	if (!(*panel))
+		ret = -EINVAL;
+	else
+		if (!ofnode_valid(dev_ofnode(*panel)))
+			ret = -EINVAL;
+
+	return ret;
+}
+
+static int stm32_ltdc_display_init(struct udevice *dev, ofnode *ep_node,
+				   struct udevice **panel, struct udevice **bridge)
+{
+	int ret;
+
+	if (*panel)
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
+		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_VIDEO_BRIDGE, bridge);
+		if (ret)
+			return ret;
+
+		ret = stm32_ltdc_get_panel(*bridge, panel);
+	} else {
+		/* no bridge, search a panel from display controller node */
+		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
+	}
+
+	return ret;
+}
+
 #if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
 static int stm32_ltdc_alloc_fb(struct udevice *dev)
 {
@@ -532,6 +628,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	struct display_timing timings;
 	struct clk pclk, bclk;
 	struct reset_ctl rst;
+	ofnode node, port;
 	ulong rate;
 	int ret;
 
@@ -568,7 +665,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	}
 
 	priv->hw_version = readl(priv->regs + LTDC_IDR);
-	debug("%s: LTDC hardware 0x%x\n", __func__, priv->hw_version);
+	dev_dbg(dev, "%s: LTDC hardware 0x%x\n", __func__, priv->hw_version);
 
 	switch (priv->hw_version) {
 	case HWVER_10200:
@@ -589,13 +686,35 @@ static int stm32_ltdc_probe(struct udevice *dev)
 		return -ENODEV;
 	}
 
-	ret = uclass_first_device_err(UCLASS_PANEL, &panel);
-	if (ret) {
-		if (ret != -ENODEV)
-			dev_err(dev, "panel device error %d\n", ret);
-		return ret;
+	/*
+	 * Try all the ports until one working.
+	 *
+	 * This is done in two times. First is checks for the
+	 * UCLASS_VIDEO_BRIDGE available, and then for this bridge
+	 * it scans for a UCLASS_PANEL.
+	 */
+
+	port = dev_read_subnode(dev, "port");
+	if (!ofnode_valid(port)) {
+		dev_err(dev, "%s(%s): 'port' subnode not found\n",
+			__func__, dev_read_name(dev));
+		return -EINVAL;
 	}
 
+	for (node = ofnode_first_subnode(port);
+	     ofnode_valid(node);
+	     node = dev_read_next_subnode(node)) {
+		ret = stm32_ltdc_display_init(dev, &node, &panel, &bridge);
+		if (ret)
+			dev_dbg(dev, "Device failed ret=%d\n", ret);
+		else
+			break;
+	}
+
+	/* Sanity check */
+	if (ret)
+		return ret;
+
 	ret = panel_get_display_timing(panel, &timings);
 	if (ret) {
 		ret = ofnode_decode_display_timing(dev_ofnode(panel),
@@ -624,11 +743,6 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	reset_deassert(&rst);
 
 	if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
-		ret = uclass_get_device(UCLASS_VIDEO_BRIDGE, 0, &bridge);
-		if (ret)
-			dev_dbg(dev,
-				"No video bridge, or no backlight on bridge\n");
-
 		if (bridge) {
 			ret = video_bridge_attach(bridge);
 			if (ret) {

-- 
2.25.1

