Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA41C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B56287859;
	Tue, 19 Dec 2023 12:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LfvR9/Sr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C94F871C7; Tue, 19 Dec 2023 11:34:58 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A8C86C68
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJAYZcb055910;
 Tue, 19 Dec 2023 04:34:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702982075;
 bh=yc74ztMDZt4ukeu6rHKY4GEBosCeNPSxAlraJdyzy1k=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LfvR9/SrE1j7CLgHs/a/74VOLoTUjiSyhcAVmBpJCHC9IIimLJdmQxdCVDf0eVpJH
 s6+fNA2SftbTNmi/ZPxbY8m5CEdC4avaMyI/kWtJoBi8ukZ89dYjN6K9HXF3kvP9o3
 wKwvF9SujgJasmrjwn144mOo7GJV00F3l12zPAtM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJAYZS7021788
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:34:35 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:34:34 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:34:35 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJAYYim007422;
 Tue, 19 Dec 2023 04:34:34 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BJAYYsj014576;
 Tue, 19 Dec 2023 04:34:34 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 07/16] net: ti: icssg: Enforce pinctrl state on the MDIO
 child node
Date: Tue, 19 Dec 2023 16:04:09 +0530
Message-ID: <20231219103418.3445886-8-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219103418.3445886-1-danishanwar@ti.com>
References: <20231219103418.3445886-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 19 Dec 2023 12:33:18 +0100
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

The binding represents the MDIO controller as a child device tree
node of the MAC device tree node.

The U-Boot driver mostly ignores that child device tree node and just
hardcodes the resources it uses to support both the MAC and MDIO in a
single driver.

However, some resources like pinctrl muxing states are thus ignored.
This has been a problem with some device trees that will put some
pinctrl states on the MDIO device tree node.

Let's rework the driver a bit to create a dummy MDIO driver that we will
then get during our initialization to force the core to select the right
muxing.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ti/Kconfig        |  1 +
 drivers/net/ti/icssg_prueth.c | 59 +++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/net/ti/Kconfig b/drivers/net/ti/Kconfig
index 9fead2c7ce..6935b70e12 100644
--- a/drivers/net/ti/Kconfig
+++ b/drivers/net/ti/Kconfig
@@ -53,6 +53,7 @@ config TI_AM65_CPSW_NUSS
 config TI_ICSSG_PRUETH
 	bool "TI Gigabit PRU Ethernet driver"
 	depends on ARCH_K3
+	imply DM_MDIO
 	select PHYLIB
 	help
 	  Support Gigabit Ethernet ports over the ICSSG PRU Subsystem
diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
index 1a7445a015..40ad827e49 100644
--- a/drivers/net/ti/icssg_prueth.c
+++ b/drivers/net/ti/icssg_prueth.c
@@ -13,6 +13,7 @@
 #include <dm/device.h>
 #include <dma-uclass.h>
 #include <dm/of_access.h>
+#include <dm/pinctrl.h>
 #include <fs_loader.h>
 #include <miiphy.h>
 #include <net.h>
@@ -100,9 +101,56 @@ static int icssg_phy_init(struct udevice *dev)
 	return ret;
 }
 
+static ofnode prueth_find_mdio(ofnode parent)
+{
+	ofnode node;
+
+	ofnode_for_each_subnode(node, parent)
+		if (ofnode_device_is_compatible(node, "ti,davinci_mdio"))
+			return node;
+
+	return ofnode_null();
+}
+
+static int prueth_mdio_setup(struct udevice *dev)
+{
+	struct prueth *priv = dev_get_priv(dev);
+	struct udevice *mdio_dev;
+	ofnode mdio;
+	int ret;
+
+	mdio = prueth_find_mdio(dev_ofnode(priv->pruss));
+	if (!ofnode_valid(mdio))
+		return 0;
+
+	/*
+	 * The MDIO controller is represented in the DT binding by a
+	 * subnode of the MAC controller.
+	 *
+	 * We don't have a DM driver for the MDIO device yet, and thus any
+	 * pinctrl setting on its node will be ignored.
+	 *
+	 * However, we do need to make sure the pins states tied to the
+	 * MDIO node are configured properly. Fortunately, the core DM
+	 * does that for use when we get a device, so we can work around
+	 * that whole issue by just requesting a dummy MDIO driver to
+	 * probe, and our pins will get muxed.
+	 */
+	ret = uclass_get_device_by_ofnode(UCLASS_MDIO, mdio, &mdio_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int icssg_mdio_init(struct udevice *dev)
 {
 	struct prueth *prueth = dev_get_priv(dev);
+	int ret;
+
+	ret = prueth_mdio_setup(dev);
+	if (ret)
+		return ret;
 
 	prueth->bus = cpsw_mdio_init(dev->name, prueth->mdio_base,
 				     prueth->mdio_freq,
@@ -593,3 +641,14 @@ U_BOOT_DRIVER(prueth) = {
 	.plat_auto = sizeof(struct eth_pdata),
 	.flags = DM_FLAG_ALLOC_PRIV_DMA,
 };
+
+static const struct udevice_id prueth_mdio_ids[] = {
+	{ .compatible = "ti,davinci_mdio" },
+	{ }
+};
+
+U_BOOT_DRIVER(prueth_mdio) = {
+	.name		= "prueth_mdio",
+	.id			= UCLASS_MDIO,
+	.of_match	= prueth_mdio_ids,
+};
-- 
2.34.1

