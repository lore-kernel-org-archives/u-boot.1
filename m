Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3976C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 10:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324AD80F18;
	Wed, 19 Feb 2025 11:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EqXJOPEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E8080F18; Wed, 19 Feb 2025 11:48:53 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF6D480017
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 11:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51JAmcbx272191
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2025 04:48:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739962118;
 bh=YvarFhsjYOGRfS/Zp4mJTB1jx4dwFF1daMSvXFbmYJw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EqXJOPEr6yitugJCjM66J2Nv0BC0Vc/m/8zgn93a9Ja5O7KqbjAOheF9yrJt/nxPm
 iHsmv/QrW51uLRqBIcDBRpYIHTPaqXpyPLNIX5pYy2mIaqdwVrSGK7jYKok4AkccS0
 ZaJpvQs2e5cXWXhSjR3QD1exPck69ouX67GguHWU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51JAmcNh013302
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Feb 2025 04:48:38 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 04:48:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 04:48:37 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51JAma0A030181;
 Wed, 19 Feb 2025 04:48:36 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michael Walle <mwalle@kernel.org>, "Roger Quadros" <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Santhosh Kumar K <s-k6@ti.com>, "Hari Nagalla" <hnagalla@ti.com>,
 Nishanth Menon <nm@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, "Kishon Vijay
 Abraham I" <kishon@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Udit Kumar" <u-kumar1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, "Bryan Brattlof" <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 02/13] net: ti: am65-cpsw-nuss: Define and switch to bind
 method for CPSW driver
Date: Wed, 19 Feb 2025 16:18:20 +0530
Message-ID: <20250219104831.2315464-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219104831.2315464-1-c-vankar@ti.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
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

CPSW driver is defined as UCLASS_MISC driver which needs to be probed
explicitly. Define bind method for CPSW driver to scan and bind
ethernet-ports with UCLASS_ETH driver which will eventually probe CPSW
driver and avoids probing CPSW driver explicitly.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is new in this series.

 drivers/net/ti/am65-cpsw-nuss.c | 129 +++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index c70b42f6bcc..12c66095cce 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -132,6 +132,7 @@ struct am65_cpsw_priv {
 	struct am65_cpsw_common	*cpsw_common;
 	u32			port_id;
 	struct phy_device	*phydev;
+	bool			probe_done;
 };
 
 #ifdef PKTSIZE_ALIGN
@@ -667,6 +668,59 @@ static int am65_cpsw_ofdata_parse_phy(struct udevice *dev)
 	return 0;
 }
 
+static int am65_cpsw_probe_nuss(struct udevice *dev)
+{
+	struct am65_cpsw_common *cpsw_common = dev_get_priv(dev);
+	int ret, i;
+
+	cpsw_common->dev = dev;
+	cpsw_common->ss_base = dev_read_addr(dev);
+	if (cpsw_common->ss_base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	ret = power_domain_get_by_index(dev, &cpsw_common->pwrdmn, 0);
+	if (ret) {
+		dev_err(dev, "failed to get pwrdmn: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_by_name(dev, "fck", &cpsw_common->fclk);
+	if (ret) {
+		power_domain_free(&cpsw_common->pwrdmn);
+		dev_err(dev, "failed to get clock %d\n", ret);
+		return ret;
+	}
+
+	cpsw_common->cpsw_base = cpsw_common->ss_base + AM65_CPSW_CPSW_NU_BASE;
+	cpsw_common->ale_base = cpsw_common->cpsw_base +
+				AM65_CPSW_CPSW_NU_ALE_BASE;
+
+	for (i = 0; i < AM65_CPSW_CPSWNU_MAX_PORTS; i++) {
+		struct am65_cpsw_port *port = &cpsw_common->ports[i];
+
+		port->port_base = cpsw_common->cpsw_base +
+				  AM65_CPSW_CPSW_NU_PORTS_OFFSET +
+				  (i * AM65_CPSW_CPSW_NU_PORTS_OFFSET);
+		port->port_sgmii_base = cpsw_common->ss_base +
+					(i * AM65_CPSW_SGMII_BASE);
+		port->macsl_base = port->port_base +
+				   AM65_CPSW_CPSW_NU_PORT_MACSL_OFFSET;
+	}
+
+	cpsw_common->bus_freq =
+			dev_read_u32_default(dev, "bus_freq",
+					     AM65_CPSW_MDIO_BUS_FREQ_DEF);
+
+	dev_info(dev, "K3 CPSW: nuss_ver: 0x%08X cpsw_ver: 0x%08X ale_ver: 0x%08X Ports:%u\n",
+		 readl(cpsw_common->ss_base),
+		 readl(cpsw_common->cpsw_base),
+		 readl(cpsw_common->ale_base),
+		 cpsw_common->port_num);
+
+	power_domain_free(&cpsw_common->pwrdmn);
+	return ret;
+}
+
 static int am65_cpsw_port_probe(struct udevice *dev)
 {
 	struct am65_cpsw_priv *priv = dev_get_priv(dev);
@@ -675,6 +729,13 @@ static int am65_cpsw_port_probe(struct udevice *dev)
 	char portname[32];
 	int ret;
 
+	if (!priv->probe_done) {
+		ret = am65_cpsw_probe_nuss(dev->parent);
+		if (ret < 0)
+			return ret;
+		priv->probe_done = true;
+	}
+
 	priv->dev = dev;
 
 	cpsw_common = dev_get_priv(dev->parent);
@@ -697,45 +758,30 @@ out:
 	return ret;
 }
 
-static int am65_cpsw_probe_nuss(struct udevice *dev)
+static int am65_cpsw_nuss_bind(struct udevice *dev)
 {
 	struct am65_cpsw_common *cpsw_common = dev_get_priv(dev);
-	ofnode ports_np, node;
-	int ret, i;
+	struct uclass_driver *drv;
 	struct udevice *port_dev;
+	ofnode ports_np, node;
+	int ret;
 
-	cpsw_common->dev = dev;
-	cpsw_common->ss_base = dev_read_addr(dev);
-	if (cpsw_common->ss_base == FDT_ADDR_T_NONE)
-		return -EINVAL;
-
-	ret = power_domain_get_by_index(dev, &cpsw_common->pwrdmn, 0);
-	if (ret) {
-		dev_err(dev, "failed to get pwrdmn: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_get_by_name(dev, "fck", &cpsw_common->fclk);
-	if (ret) {
-		power_domain_free(&cpsw_common->pwrdmn);
-		dev_err(dev, "failed to get clock %d\n", ret);
-		return ret;
+	drv = lists_uclass_lookup(UCLASS_ETH);
+	if (!drv) {
+		puts("Cannot find eth driver");
+		return -ENOENT;
 	}
 
-	cpsw_common->cpsw_base = cpsw_common->ss_base + AM65_CPSW_CPSW_NU_BASE;
-	cpsw_common->ale_base = cpsw_common->cpsw_base +
-				AM65_CPSW_CPSW_NU_ALE_BASE;
-
+	cpsw_common->dev = dev;
 	ports_np = dev_read_subnode(dev, "ethernet-ports");
 	if (!ofnode_valid(ports_np)) {
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 
 	ofnode_for_each_subnode(node, ports_np) {
 		const char *node_name;
-		u32 port_id;
 		bool disabled;
+		u32 port_id;
 
 		node_name = ofnode_get_name(node);
 
@@ -745,14 +791,13 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
 		if (ret) {
 			dev_err(dev, "%s: failed to get port_id (%d)\n",
 				node_name, ret);
-			goto out;
+			return ret;
 		}
 
 		if (port_id >= AM65_CPSW_CPSWNU_MAX_PORTS) {
 			dev_err(dev, "%s: invalid port_id (%d)\n",
 				node_name, port_id);
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 		cpsw_common->port_num++;
 
@@ -768,30 +813,6 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
 			dev_err(dev, "Failed to bind to %s node\n", ofnode_get_name(node));
 	}
 
-	for (i = 0; i < AM65_CPSW_CPSWNU_MAX_PORTS; i++) {
-		struct am65_cpsw_port *port = &cpsw_common->ports[i];
-
-		port->port_base = cpsw_common->cpsw_base +
-				  AM65_CPSW_CPSW_NU_PORTS_OFFSET +
-				  (i * AM65_CPSW_CPSW_NU_PORTS_OFFSET);
-		port->port_sgmii_base = cpsw_common->ss_base +
-					(i * AM65_CPSW_SGMII_BASE);
-		port->macsl_base = port->port_base +
-				   AM65_CPSW_CPSW_NU_PORT_MACSL_OFFSET;
-	}
-
-	cpsw_common->bus_freq =
-			dev_read_u32_default(dev, "bus_freq",
-					     AM65_CPSW_MDIO_BUS_FREQ_DEF);
-
-	dev_info(dev, "K3 CPSW: nuss_ver: 0x%08X cpsw_ver: 0x%08X ale_ver: 0x%08X Ports:%u\n",
-		 readl(cpsw_common->ss_base),
-		 readl(cpsw_common->cpsw_base),
-		 readl(cpsw_common->ale_base),
-		 cpsw_common->port_num);
-
-out:
-	power_domain_free(&cpsw_common->pwrdmn);
 	return ret;
 }
 
@@ -806,7 +827,7 @@ U_BOOT_DRIVER(am65_cpsw_nuss) = {
 	.name	= "am65_cpsw_nuss",
 	.id	= UCLASS_MISC,
 	.of_match = am65_cpsw_nuss_ids,
-	.probe	= am65_cpsw_probe_nuss,
+	.bind	= am65_cpsw_nuss_bind,
 	.priv_auto = sizeof(struct am65_cpsw_common),
 };
 
-- 
2.34.1

