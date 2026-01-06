Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243DDCEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 22:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942E683B32;
	Tue,  6 Jan 2026 23:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="GXE7Mgcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE4D83B64; Tue,  6 Jan 2026 23:17:40 +0100 (CET)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [91.218.175.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A92683942
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 23:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767737857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QypTrw6Ba2uekUxGqIcz3bMva9+vzHchkZvYZXAokMs=;
 b=GXE7MgcgrN06kQpQElqv1yGrj0rMjQQ1MVNNpN6x1Ikhhd6YuBzOPKtw7XEm9GrwWWHRyi
 bVURxVK7/QqbCbtNx9P7c72wc9LJGeOwSg4ye6q42psCKjxZf9bzd6kJH1AAmlPOpMnkKu
 znduRMewCh+peAH+1soeFAFMXe8O8Gg=
From: Sean Anderson <sean.anderson@linux.dev>
To: Marek Vasut <marex@denx.de>,
	u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] usb: dwc3: Initialize Xilinx glue registers
Date: Tue,  6 Jan 2026 17:17:28 -0500
Message-Id: <20260106221728.738219-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

These registers may have been initialized by SPL/FSBL, but program them
in case they have not. If they are left at their default values, the
controller will never exit reset.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

---

 drivers/usb/dwc3/dwc3-generic.c | 32 ++++++++++++++++++++++++++------
 drivers/usb/dwc3/dwc3-generic.h |  2 ++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index c09014aec60..ce896db9532 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -501,6 +501,27 @@ struct dwc3_glue_ops rk_ops = {
 	.glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
 };
 
+void dwc3_xlnx_glue_configure(struct udevice *dev, int index,
+			      enum usb_dr_mode mode)
+{
+/* USB glue registers */
+#define USB3_FPD_PIPE_CLK	0x7c
+#define USB3_FPD_POWER_PRSNT	0x80
+	struct dwc3_glue_data *glue = dev_get_plat(dev);
+	void *base = map_physmem(glue->regs, 0x10000, MAP_NOCACHE);
+
+	if (generic_phy_valid(&glue->phy)) {
+		writel(0, base + USB3_FPD_PIPE_CLK);
+		writel(1, base + USB3_FPD_POWER_PRSNT);
+	} else {
+		writel(1, base + USB3_FPD_PIPE_CLK);
+	}
+}
+
+struct dwc3_glue_ops xlnx_ops = {
+	.glue_configure = dwc3_xlnx_glue_configure,
+};
+
 static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 {
 	const char *name = ofnode_get_name(node);
@@ -621,11 +642,10 @@ int dwc3_glue_probe(struct udevice *dev)
 	struct udevice *child = NULL;
 	int index = 0;
 	int ret;
-	struct phy phy;
 
-	ret = generic_phy_get_by_name(dev, "usb3-phy", &phy);
+	ret = generic_phy_get_by_name(dev, "usb3-phy", &glue->phy);
 	if (!ret) {
-		ret = generic_phy_init(&phy);
+		ret = generic_phy_init(&glue->phy);
 		if (ret)
 			return ret;
 	} else if (ret != -ENOENT && ret != -ENODATA) {
@@ -643,8 +663,8 @@ int dwc3_glue_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	if (generic_phy_valid(&phy)) {
-		ret = generic_phy_power_on(&phy);
+	if (generic_phy_valid(&glue->phy)) {
+		ret = generic_phy_power_on(&glue->phy);
 		if (ret)
 			return ret;
 	}
@@ -690,7 +710,7 @@ int dwc3_glue_remove(struct udevice *dev)
 }
 
 static const struct udevice_id dwc3_glue_ids[] = {
-	{ .compatible = "xlnx,zynqmp-dwc3" },
+	{ .compatible = "xlnx,zynqmp-dwc3", .data = (ulong)&xlnx_ops },
 	{ .compatible = "xlnx,versal-dwc3" },
 	{ .compatible = "ti,keystone-dwc3"},
 	{ .compatible = "ti,dwc3", .data = (ulong)&ti_ops },
diff --git a/drivers/usb/dwc3/dwc3-generic.h b/drivers/usb/dwc3/dwc3-generic.h
index 40902c8923f..13f6391cae8 100644
--- a/drivers/usb/dwc3/dwc3-generic.h
+++ b/drivers/usb/dwc3/dwc3-generic.h
@@ -10,12 +10,14 @@
 #define __DRIVERS_USB_DWC3_GENERIC_H
 
 #include <clk.h>
+#include <generic-phy.h>
 #include <reset.h>
 #include <dwc3-uboot.h>
 
 struct dwc3_glue_data {
 	struct clk_bulk		clks;
 	struct reset_ctl_bulk	resets;
+	struct phy phy;
 	fdt_addr_t regs;
 	fdt_size_t size;
 };
-- 
2.35.1.1320.gc452695387.dirty

base-commit: beab3fe49e1e9209dd32fe2791e7ac706038460f
branch: dwc3_xlnx_glue
