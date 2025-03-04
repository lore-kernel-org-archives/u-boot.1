Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DF1C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B928128D;
	Tue,  4 Mar 2025 17:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE408004F; Tue,  4 Mar 2025 17:38:01 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 3703D80F92
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: l/rRgpGdQuWS6KV994aJRg==
X-CSE-MsgGUID: Gogz3cAbSzGHLbHS3LIykA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 05 Mar 2025 01:37:58 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.7])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 633F94024115;
 Wed,  5 Mar 2025 01:37:55 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 3/5] reset: rzg2l-usbphy-ctrl: Connect up vbus regulator
Date: Tue,  4 Mar 2025 16:37:33 +0000
Message-ID: <20250304163736.89326-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
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

Bind the USB VBUS regulator driver under the USB PHY reset driver for
the Renesas RZ/G2L and related SoCs. This additional bind is needed as
the corresponding device tree node does not contain a compatible string.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/reset/Kconfig                   |  1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 28 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 80e83a40bdff..5edbb3c25b41 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -239,6 +239,7 @@ config RESET_AT91
 config RESET_RZG2L_USBPHY_CTRL
 	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
 	depends on DM_RESET
+	select REGULATOR_RZG2L_USBPHY
 	help
 	  Enable support for controlling USB 2.0 PHY resets on the Renesas
 	  RZ/G2L SoC. This is required for USB 2.0 functionality to work on this
diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index b1492631b97c..d0c97ffffcd2 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -107,10 +107,38 @@ static const struct udevice_id rzg2l_usbphy_ctrl_ids[] = {
 	{ /* sentinel */ }
 };
 
+static int rzg2l_usbphy_ctrl_bind(struct udevice *dev)
+{
+	struct driver *drv;
+	ofnode node;
+	int ret;
+
+	node = ofnode_find_subnode(dev_ofnode(dev), "regulator-vbus");
+	if (!ofnode_valid(node)) {
+		dev_err(dev, "Failed to find vbus regulator devicetree node\n");
+		return -ENOENT;
+	}
+
+	drv = lists_driver_lookup_name("rzg2l_usbphy_regulator");
+	if (!drv) {
+		dev_err(dev, "Failed to find vbus regulator driver\n");
+		return -ENOENT;
+	}
+
+	ret = device_bind(dev, drv, dev->name, NULL, node, NULL);
+	if (ret) {
+		dev_err(dev, "Failed to bind vbus regulator: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 U_BOOT_DRIVER(rzg2l_usbphy_ctrl) = {
 	.name           = "rzg2l_usbphy_ctrl",
 	.id             = UCLASS_RESET,
 	.of_match       = rzg2l_usbphy_ctrl_ids,
+	.bind           = rzg2l_usbphy_ctrl_bind,
 	.probe          = rzg2l_usbphy_ctrl_probe,
 	.ops            = &rzg2l_usbphy_ctrl_ops,
 	.priv_auto      = sizeof(struct rzg2l_usbphy_ctrl_priv),
-- 
2.43.0

