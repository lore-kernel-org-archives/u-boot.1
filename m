Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8C4C3600E
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39FF481EDD;
	Thu, 27 Mar 2025 05:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="LSaBlvHW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA9A8070C; Wed, 26 Mar 2025 16:01:43 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C76DD81DCC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 16:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A08AB4428D;
 Wed, 26 Mar 2025 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743001300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6RZI+9mDXbKhIcxNm+vSPg1IFuIru9TJxfaGvDjDnI=;
 b=LSaBlvHWlY9I79VYGk/4r2O9bZBzgP7uCV/2fql+w85NGcp4fwR9ikxschLQWHKHOHK64R
 J87lFD+/kwd+kEXpcoBpJu4Z0B/esx/pYILEgIbCLUn/FPMMr42MIy4ULTMnOygHbK84bF
 l6upcmlWbP68lkTT7aRHtC7G7GGsGR9wyWkZ4d8F68wONVxQrFMhSapP9oU6eWwTVtDcq0
 cvhOr3qYdBok3lANeVpSaA9EquYoFZBkEHYys8cYUPiq3mpe4KZamsMJ+VFQDE4GICGhxf
 P65UD1lj6bWbuz8RooI844+cPYX9VyLfXelQ1QoYZh38uZy2wiLJi84aZ2BeDw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 16:00:55 +0100
Subject: [PATCH v5 11/12] video: imx: Add LDB driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-ge-mainline-display-support-v5-11-ea4bc3fc9bca@bootlin.com>
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
In-Reply-To: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepmhgrrhhiohdrshhigiesghgushihshdrtggtpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuggrrhhiohdrsghinhgrtggthhhisegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhto
 hepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 27 Mar 2025 05:24:46 +0100
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

Add support for the LVDS Display Bridge (LDB) found on i.MX8MP.

When attached, the bridge driver looks for panels connected to one of
its two outputs and adapts its own configuration to use them. There is
currently no support for merged/split displays.

Note regarding the clock configuration:
The LDB output clock should be absolutely identical to the LCDIF output
clock so both blocks can talk to each other synchronously. However, the
LDB clock has an internal divisor of 7 (respectively 3.5 in dual
configuration) which means the LDB input clock must be explicitly set
once we know the configuration.

This driver was tested on i.MX8MP using a single panel connected to the
LVDS2 interface.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/video/imx/Kconfig  |   6 ++
 drivers/video/imx/Makefile |   1 +
 drivers/video/imx/ldb.c    | 251 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)

diff --git a/drivers/video/imx/Kconfig b/drivers/video/imx/Kconfig
index 34e8b640595b85678e386a3a251340031780a72e..c5cd2fecf780b62c0264b9627137517388aae1ab 100644
--- a/drivers/video/imx/Kconfig
+++ b/drivers/video/imx/Kconfig
@@ -13,3 +13,9 @@ config IMX_VIDEO_SKIP
 config IMX_HDMI
 	bool "Enable HDMI support in IPUv3"
 	depends on VIDEO_IPUV3
+
+config IMX_LDB
+	bool "Freescale i.MX8MP LDB bridge"
+	depends on VIDEO_BRIDGE
+	help
+	  Support for i.MX8MP DPI-to-LVDS on-SoC encoder.
diff --git a/drivers/video/imx/Makefile b/drivers/video/imx/Makefile
index 46cc44d64b00959fb3880c7befb04a1ebdda1143..8d106589b7544ef9694613a2284e2fbfb564cf63 100644
--- a/drivers/video/imx/Makefile
+++ b/drivers/video/imx/Makefile
@@ -4,3 +4,4 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 obj-$(CONFIG_VIDEO_IPUV3) += mxc_ipuv3_fb.o ipu_common.o ipu_disp.o
+obj-$(CONFIG_IMX_LDB) += ldb.o
diff --git a/drivers/video/imx/ldb.c b/drivers/video/imx/ldb.c
new file mode 100644
index 0000000000000000000000000000000000000000..e918341c0a32232f0fc45aba8eb77a290064590c
--- /dev/null
+++ b/drivers/video/imx/ldb.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Derived work from:
+ *   Philippe Cornu <philippe.cornu@st.com>
+ *   Yannick Fertre <yannick.fertre@st.com>
+ * Adapted by Miquel Raynal <miquel.raynal@bootlin.com>
+ */
+
+#define LOG_CATEGORY UCLASS_VIDEO_BRIDGE
+
+#include <clk.h>
+#include <dm.h>
+#include <log.h>
+#include <panel.h>
+#include <video_bridge.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+
+#define LDB_CTRL_CH0_ENABLE BIT(0)
+#define LDB_CTRL_CH1_ENABLE BIT(2)
+#define LDB_CTRL_CH0_DATA_WIDTH BIT(5)
+#define LDB_CTRL_CH0_BIT_MAPPING BIT(6)
+#define LDB_CTRL_CH1_DATA_WIDTH BIT(7)
+#define LDB_CTRL_CH1_BIT_MAPPING BIT(8)
+#define LDB_CTRL_DI0_VSYNC_POLARITY BIT(9)
+#define LDB_CTRL_DI1_VSYNC_POLARITY BIT(10)
+
+#define LVDS_CTRL_CH0_EN BIT(0)
+#define LVDS_CTRL_CH1_EN BIT(1)
+#define LVDS_CTRL_VBG_EN BIT(2)
+#define LVDS_CTRL_PRE_EMPH_EN BIT(4)
+#define LVDS_CTRL_PRE_EMPH_ADJ(n) (((n) & 0x7) << 5)
+#define LVDS_CTRL_CC_ADJ(n) (((n) & 0x7) << 11)
+
+struct imx_ldb_priv {
+	struct clk ldb_clk;
+	void __iomem *ldb_ctrl;
+	void __iomem *lvds_ctrl;
+	struct udevice *lvds1;
+	struct udevice *lvds2;
+};
+
+static int imx_ldb_set_backlight(struct udevice *dev, int percent)
+{
+	struct imx_ldb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (priv->lvds1) {
+		ret = panel_enable_backlight(priv->lvds1);
+		if (ret) {
+			debug("ldb: Cannot enable lvds1 backlight\n");
+			return ret;
+		}
+
+		ret = panel_set_backlight(priv->lvds1, percent);
+		if (ret)
+			return ret;
+	}
+
+	if (priv->lvds2) {
+		ret = panel_enable_backlight(priv->lvds2);
+		if (ret) {
+			debug("ldb: Cannot enable lvds2 backlight\n");
+			return ret;
+		}
+
+		ret = panel_set_backlight(priv->lvds2, percent);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int imx_ldb_of_to_plat(struct udevice *dev)
+{
+	struct imx_ldb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	uclass_get_device_by_endpoint(UCLASS_PANEL, dev, 1, -1, &priv->lvds1);
+	uclass_get_device_by_endpoint(UCLASS_PANEL, dev, 2, -1, &priv->lvds2);
+	if (!priv->lvds1 && !priv->lvds2) {
+		debug("ldb: No remote panel for '%s' (ret=%d)\n",
+		      dev_read_name(dev), ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* The block has a mysterious x7 internal divisor (x3.5 in dual configuration) */
+#define IMX_LDB_INTERNAL_DIVISOR(x) (((x) * 70) / 10)
+#define IMX_LDB_INTERNAL_DIVISOR_DUAL(x) (((x) * 35) / 10)
+
+static ulong imx_ldb_input_rate(struct imx_ldb_priv *priv,
+				struct display_timing *timings)
+{
+	ulong target_rate = timings->pixelclock.typ;
+
+	if (priv->lvds1 && priv->lvds2)
+		return IMX_LDB_INTERNAL_DIVISOR_DUAL(target_rate);
+
+	return IMX_LDB_INTERNAL_DIVISOR(target_rate);
+}
+
+static int imx_ldb_attach(struct udevice *dev)
+{
+	struct imx_ldb_priv *priv = dev_get_priv(dev);
+	struct display_timing timings;
+	bool format_jeida = false;
+	bool format_24bpp = true;
+	u32 ldb_ctrl = 0, lvds_ctrl;
+	ulong ldb_rate;
+	int ret;
+
+	/* TODO: update the 24bpp/jeida booleans with proper checks when they
+	 * will be supported.
+	 */
+	if (priv->lvds1) {
+		ret = panel_get_display_timing(priv->lvds1, &timings);
+		if (ret) {
+			ret = ofnode_decode_display_timing(dev_ofnode(priv->lvds1),
+							   0, &timings);
+			if (ret) {
+				printf("Cannot decode lvds1 timings (%d)\n", ret);
+				return ret;
+			}
+		}
+
+		ldb_ctrl |= LDB_CTRL_CH0_ENABLE;
+		if (format_24bpp)
+			ldb_ctrl |= LDB_CTRL_CH0_DATA_WIDTH;
+		if (format_jeida)
+			ldb_ctrl |= LDB_CTRL_CH0_BIT_MAPPING;
+		if (timings.flags & DISPLAY_FLAGS_VSYNC_HIGH)
+			ldb_ctrl |= LDB_CTRL_DI0_VSYNC_POLARITY;
+	}
+
+	if (priv->lvds2) {
+		ret = panel_get_display_timing(priv->lvds2, &timings);
+		if (ret) {
+			ret = ofnode_decode_display_timing(dev_ofnode(priv->lvds2),
+							   0, &timings);
+			if (ret) {
+				printf("Cannot decode lvds2 timings (%d)\n", ret);
+				return ret;
+			}
+		}
+
+		ldb_ctrl |= LDB_CTRL_CH1_ENABLE;
+		if (format_24bpp)
+			ldb_ctrl |= LDB_CTRL_CH1_DATA_WIDTH;
+		if (format_jeida)
+			ldb_ctrl |= LDB_CTRL_CH1_BIT_MAPPING;
+		if (timings.flags & DISPLAY_FLAGS_VSYNC_HIGH)
+			ldb_ctrl |= LDB_CTRL_DI1_VSYNC_POLARITY;
+	}
+
+	/*
+	 * Not all pixel clocks will work, as the final rate (after internal
+	 * integer division) should be identical to the LCDIF clock, otherwise
+	 * the rendering will appear resized/shimmering.
+	 */
+	ldb_rate = imx_ldb_input_rate(priv, &timings);
+	clk_set_rate(&priv->ldb_clk, ldb_rate);
+
+	writel(ldb_ctrl, priv->ldb_ctrl);
+
+	lvds_ctrl = LVDS_CTRL_CC_ADJ(2) | LVDS_CTRL_PRE_EMPH_EN |
+		    LVDS_CTRL_PRE_EMPH_ADJ(3) | LVDS_CTRL_VBG_EN;
+	writel(lvds_ctrl, priv->lvds_ctrl);
+
+	/* Wait for VBG to stabilize. */
+	udelay(15);
+
+	if (priv->lvds1)
+		lvds_ctrl |= LVDS_CTRL_CH0_EN;
+	if (priv->lvds2)
+		lvds_ctrl |= LVDS_CTRL_CH1_EN;
+
+	writel(lvds_ctrl, priv->lvds_ctrl);
+
+	return 0;
+}
+
+static int imx_ldb_probe(struct udevice *dev)
+{
+	struct imx_ldb_priv *priv = dev_get_priv(dev);
+	struct udevice *parent = dev_get_parent(dev);
+	fdt_addr_t parent_addr, child_addr;
+	int ret;
+
+	ret = clk_get_by_name(dev, "ldb", &priv->ldb_clk);
+	if (ret < 0)
+		return ret;
+
+	parent_addr = dev_read_addr(parent);
+	if (parent_addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	child_addr = dev_read_addr_name(dev, "ldb");
+	if (child_addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->ldb_ctrl = map_physmem(parent_addr + child_addr, 0, MAP_NOCACHE);
+	if (!priv->ldb_ctrl)
+		return -EINVAL;
+
+	child_addr = dev_read_addr_name(dev, "lvds");
+	if (child_addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->lvds_ctrl = map_physmem(parent_addr + child_addr, 0, MAP_NOCACHE);
+	if (!priv->lvds_ctrl)
+		return -EINVAL;
+
+	ret = clk_enable(&priv->ldb_clk);
+	if (ret)
+		return ret;
+
+	ret = video_bridge_set_active(dev, true);
+	if (ret)
+		goto dis_clk;
+
+	return 0;
+
+dis_clk:
+	clk_disable(&priv->ldb_clk);
+
+	return ret;
+}
+
+struct video_bridge_ops imx_ldb_ops = {
+	.attach = imx_ldb_attach,
+	.set_backlight	= imx_ldb_set_backlight,
+};
+
+static const struct udevice_id imx_ldb_ids[] = {
+	{ .compatible = "fsl,imx8mp-ldb"},
+	{ }
+};
+
+U_BOOT_DRIVER(imx_ldb) = {
+	.name = "imx-lvds-display-bridge",
+	.id = UCLASS_VIDEO_BRIDGE,
+	.of_match = imx_ldb_ids,
+	.probe = imx_ldb_probe,
+	.of_to_plat = imx_ldb_of_to_plat,
+	.ops = &imx_ldb_ops,
+	.priv_auto = sizeof(struct imx_ldb_priv),
+};

-- 
2.48.1

