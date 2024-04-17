Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2996C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 20:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E584884C4;
	Wed, 17 Apr 2024 22:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE1F88456; Wed, 17 Apr 2024 22:09:32 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F7D2884DB
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 22:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from [68.189.91.139] (helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rxBav-006lwU-JK;
 Wed, 17 Apr 2024 20:09:25 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/3] pci: dw_imx: add support for IMX8MM
Date: Wed, 17 Apr 2024 13:09:21 -0700
Message-Id: <20240417200922.3749671-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417200922.3749671-1-tharvey@gateworks.com>
References: <20240417200922.3749671-1-tharvey@gateworks.com>
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

Add support for the IMX8MM SoC by adding driver data with the compatible
string of the GPR controller.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/pci/pcie_dw_imx.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
index a2ee228224b5..10d926c30645 100644
--- a/drivers/pci/pcie_dw_imx.c
+++ b/drivers/pci/pcie_dw_imx.c
@@ -45,6 +45,10 @@
 #define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
 #define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE		BIT(11)
 
+struct pcie_chip_info {
+	const char *gpr;
+};
+
 struct pcie_dw_imx {
 	/* Must be first member of the struct */
 	struct pcie_dw			dw;
@@ -54,6 +58,15 @@ struct pcie_dw_imx {
 	struct reset_ctl		apps_reset;
 	struct phy			phy;
 	struct udevice			*vpcie;
+	struct pcie_chip_info		*info;
+};
+
+static const struct pcie_chip_info imx8mm_chip_info = {
+	.gpr = "fsl,imx8mm-iomuxc-gpr",
+};
+
+static const struct pcie_chip_info imx8mp_chip_info = {
+	.gpr = "fsl,imx8mp-iomuxc-gpr",
 };
 
 static void pcie_dw_configure(struct pcie_dw_imx *priv, u32 cap_speed)
@@ -246,6 +259,8 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
 	ofnode gpr;
 	int ret;
 
+	priv->info = (void *)dev_get_driver_data(dev);
+
 	/* Get the controller base address */
 	priv->dw.dbi_base = (void *)dev_read_addr_name(dev, "dbi");
 	if ((fdt_addr_t)priv->dw.dbi_base == FDT_ADDR_T_NONE) {
@@ -287,7 +302,7 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
 		goto err_phy;
 	}
 
-	gpr = ofnode_by_compatible(ofnode_null(), "fsl,imx8mp-iomuxc-gpr");
+	gpr = ofnode_by_compatible(ofnode_null(), priv->info->gpr);
 	if (ofnode_equal(gpr, ofnode_null())) {
 		dev_err(dev, "unable to find GPR node\n");
 		ret = -ENODEV;
@@ -322,7 +337,8 @@ static const struct dm_pci_ops pcie_dw_imx_ops = {
 };
 
 static const struct udevice_id pcie_dw_imx_ids[] = {
-	{ .compatible = "fsl,imx8mp-pcie" },
+	{ .compatible = "fsl,imx8mm-pcie", .data = (ulong)&imx8mm_chip_info, },
+	{ .compatible = "fsl,imx8mp-pcie", .data = (ulong)&imx8mp_chip_info, },
 	{ }
 };
 
-- 
2.25.1

