Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506FAC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 11:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3547A80FA6;
	Tue, 25 Feb 2025 12:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OBPrnq7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28CF80FF4; Tue, 25 Feb 2025 12:49:28 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B9080FC9
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51PBn8f41796057
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 05:49:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740484148;
 bh=kAKaJnaLz95o+M7CRnC/iDemUqTAgZIVVaH0i4xqSnw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OBPrnq7lUGKC6LWCWXIRQgR+g8iTmC37B3qpqsUlweFn+c1lRjdDI0nFcyK/wY35F
 kxArVU1bZlam4kmr2/KJ8fMYv7IApZpchBpZKLlh3dxZGrLxFX0+zH8/5UYWwTaHJQ
 PAcX6G7WHeCBoYsScn8qBT973sb6tR1bFol2b514=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51PBn80L026170
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 25 Feb 2025 05:49:08 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Feb 2025 05:49:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Feb 2025 05:49:07 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51PBn6cG026471;
 Tue, 25 Feb 2025 05:49:07 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Michael Walle <mwalle@kernel.org>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, MD Danish Anwar <danishanwar@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Andrew Davis <afd@ti.com>,
 "Alexander Sverdlin" <alexander.sverdlin@siemens.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Chintan Vankar" <c-vankar@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Jayesh Choudhary" <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, "Bryan Brattlof" <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <s-vadapalli@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 01/15] net: ti: am65-cpsw-nuss: Define bind method for CPSW
 driver
Date: Tue, 25 Feb 2025 17:18:49 +0530
Message-ID: <20250225114903.2080616-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225114903.2080616-1-c-vankar@ti.com>
References: <20250225114903.2080616-1-c-vankar@ti.com>
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

Link to v2:
https://lore.kernel.org/r/20250219104831.2315464-3-c-vankar@ti.com/

Changes from v2 to v3:
- Removed if condition not required in CPSW driver as suggested by
  Alexander Sverdlin.

 drivers/net/ti/am65-cpsw-nuss.c | 120 ++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index c70b42f6bcc..10513cf92f2 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -667,6 +667,59 @@ static int am65_cpsw_ofdata_parse_phy(struct udevice *dev)
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
@@ -697,45 +750,30 @@ out:
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
 
@@ -745,14 +783,13 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
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
 
@@ -768,30 +805,6 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
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
 
@@ -806,6 +819,7 @@ U_BOOT_DRIVER(am65_cpsw_nuss) = {
 	.name	= "am65_cpsw_nuss",
 	.id	= UCLASS_MISC,
 	.of_match = am65_cpsw_nuss_ids,
+	.bind	= am65_cpsw_nuss_bind,
 	.probe	= am65_cpsw_probe_nuss,
 	.priv_auto = sizeof(struct am65_cpsw_common),
 };
-- 
2.34.1

