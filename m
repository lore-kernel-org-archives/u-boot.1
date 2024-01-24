Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02987C47E49
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 12:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB9987D03;
	Wed, 24 Jan 2024 13:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ny3bR0q/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB42C87BDB; Wed, 24 Jan 2024 07:50:11 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA33C87BC3
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 07:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O6nsn3046290;
 Wed, 24 Jan 2024 00:49:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706078994;
 bh=x7aY9ffWo9JhqOF3C72DnKKwvNRELhyVld2cFIeWDZI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ny3bR0q/tbT4+d/VnwPVjlDFSsI2egBDGNzax0ZonOOQbdcCsk3HnIDbDamh9x6xS
 PJRYZ4JEM0he15YSzI12PtzhV2Q8Xs7GVisEau96BuSEf6QqhOTF4ItsAV9i/91rv7
 h3h4dXLK5r/uXz3R49QBONmAgDfvreSXSCyuTpdM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O6nsRT069040
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 00:49:54 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 00:49:53 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 00:49:53 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O6nr9h098836;
 Wed, 24 Jan 2024 00:49:53 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40O6nqum010998;
 Wed, 24 Jan 2024 00:49:53 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Bryan Brattlof
 <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Martyn Welch
 <martyn.welch@collabora.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Simon
 Glass <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v3 09/15] net: ti: icssg: Enforce pinctrl state on the
 MDIO child node
Date: Wed, 24 Jan 2024 12:19:24 +0530
Message-ID: <20240124064930.1787929-10-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124064930.1787929-1-danishanwar@ti.com>
References: <20240124064930.1787929-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 24 Jan 2024 13:42:05 +0100
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
index 50af9a2bc6..225928e477 100644
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
@@ -103,9 +104,56 @@ static int icssg_phy_init(struct udevice *dev)
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
@@ -701,3 +749,14 @@ U_BOOT_DRIVER(prueth) = {
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
+	.id		= UCLASS_MDIO,
+	.of_match	= prueth_mdio_ids,
+};
-- 
2.34.1

