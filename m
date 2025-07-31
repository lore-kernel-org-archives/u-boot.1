Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C9C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 08:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A487833EC;
	Thu, 31 Jul 2025 10:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HcoK5kSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6798F833F5; Thu, 31 Jul 2025 10:00:20 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99951833EC
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 10:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V803BQ2954328;
 Thu, 31 Jul 2025 03:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753948803;
 bh=04iAjKPYkJdb1Hv/tx8acULmzwU+eRc1PLdRVJy/U7A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HcoK5kSDyETt9KKLlhl3tMuIx6mOsJAaJr2K59CNnAKII/Gz/JM3kf1JE01UvzLwu
 Q4KUa5pbkf8W82488q7RlLRpJrKucB3bPuxx7J6xC3CecWopuT7CKYQVM5m44xMeBk
 VVbrApD3NqEZ2fkLnbiBqPbQ01udk1DwNz+ATJ70=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V803jl3800376
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 03:00:03 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:00:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:00:02 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V801XG2262833;
 Thu, 31 Jul 2025 03:00:02 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Richard Genoud <richard.genoud@bootlin.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Santhosh Kumar K <s-k6@ti.com>, "Jonathan
 Humphreys" <j-humphreys@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bhavya Kapoor <b-kapoor@ti.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>, Sughosh
 Ganu <sughosh.ganu@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 "Prasanth Babu Mantena" <p-mantena@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Simon Glass" <sjg@chromium.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 01/21] net: ti: am65-cpsw-nuss: Define bind method for CPSW
 driver
Date: Thu, 31 Jul 2025 13:29:36 +0530
Message-ID: <20250731075956.605474-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731075956.605474-1-c-vankar@ti.com>
References: <20250731075956.605474-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 31 Jul 2025 10:00:51 +0200
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
driver and avoid probing CPSW driver explicitly.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v3:
https://lore.kernel.org/u-boot/20250225114903.2080616-2-c-vankar@ti.com/

Changes from v3 to v4:
- Moved initialization part from "am65_cpsw_probe_nuss()" to
  "am65_cpsw_nuss_bind()" method.

 drivers/net/ti/am65-cpsw-nuss.c | 40 +++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 9b69f36d04d..754076d807c 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -705,7 +705,6 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
 	struct am65_cpsw_common *cpsw_common = dev_get_priv(dev);
 	ofnode ports_np, node;
 	int ret, i;
-	struct udevice *port_dev;
 
 	cpsw_common->dev = dev;
 	cpsw_common->ss_base = dev_read_addr(dev);
@@ -732,6 +731,7 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
 	ports_np = dev_read_subnode(dev, "ethernet-ports");
 	if (!ofnode_valid(ports_np)) {
 		ret = -ENOENT;
+		dev_err(dev, "Invalid device tree node %d\n", ret);
 		goto out;
 	}
 
@@ -763,12 +763,6 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
 			continue;
 
 		cpsw_common->ports[port_id].disabled = disabled;
-		if (disabled)
-			continue;
-
-		ret = device_bind_driver_to_node(dev, "am65_cpsw_nuss_port", ofnode_get_name(node), node, &port_dev);
-		if (ret)
-			dev_err(dev, "Failed to bind to %s node\n", ofnode_get_name(node));
 	}
 
 	for (i = 0; i < AM65_CPSW_CPSWNU_MAX_PORTS; i++) {
@@ -798,6 +792,37 @@ out:
 	return ret;
 }
 
+static int am65_cpsw_nuss_bind(struct udevice *dev)
+{
+	struct uclass_driver *drv;
+	struct udevice *port_dev;
+	ofnode ports_np, node;
+	int ret;
+
+	drv = lists_uclass_lookup(UCLASS_ETH);
+	if (!drv) {
+		puts("Cannot find eth driver");
+		return -ENOENT;
+	}
+
+	ports_np = dev_read_subnode(dev, "ethernet-ports");
+	if (!ofnode_valid(ports_np))
+		return -ENOENT;
+
+	ofnode_for_each_subnode(node, ports_np) {
+		const char *node_name;
+
+		node_name = ofnode_get_name(node);
+
+		ret = device_bind_driver_to_node(dev, "am65_cpsw_nuss_port", node_name, node,
+						 &port_dev);
+		if (ret)
+			dev_err(dev, "Failed to bind to %s node\n", node_name);
+	}
+
+	return ret;
+}
+
 static const struct udevice_id am65_cpsw_nuss_ids[] = {
 	{ .compatible = "ti,am654-cpsw-nuss" },
 	{ .compatible = "ti,j721e-cpsw-nuss" },
@@ -809,6 +834,7 @@ U_BOOT_DRIVER(am65_cpsw_nuss) = {
 	.name	= "am65_cpsw_nuss",
 	.id	= UCLASS_MISC,
 	.of_match = am65_cpsw_nuss_ids,
+	.bind	= am65_cpsw_nuss_bind,
 	.probe	= am65_cpsw_probe_nuss,
 	.priv_auto = sizeof(struct am65_cpsw_common),
 };
-- 
2.34.1

