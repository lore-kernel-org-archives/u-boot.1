Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AE6C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 12:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80DAF82F00;
	Wed,  2 Jul 2025 14:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iEVpEAcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C7682103; Wed,  2 Jul 2025 13:35:58 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81138800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 13:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 562BZnN23906032;
 Wed, 2 Jul 2025 06:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751456149;
 bh=L+E7rEWjJhRyds/QG40WQpvdku6JHVL/tvacC4uIKLA=;
 h=From:To:CC:Subject:Date;
 b=iEVpEAcDpIXAzZGDdQibEygdzyEe485XH7752lbCPbfWeXwt4rN2dN0rQZ/U4aXny
 Si1ViCVvRpoasng79TJiamC7sgg/kof2jJeazQl47jQYRlbTK+uaVQ580ohUZRnECf
 NGUqOnHs/f/TsEDxFaPwEd2/FnmHv0yDMIRdd2rs=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 562BZnnE3503477
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 2 Jul 2025 06:35:49 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 2
 Jul 2025 06:35:48 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 2 Jul 2025 06:35:48 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 562BZmKJ1575021;
 Wed, 2 Jul 2025 06:35:48 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 562BZlCG008051;
 Wed, 2 Jul 2025 06:35:48 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, MD Danish Anwar
 <danishanwar@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] net: ti: icssg: Read firmware name from device-tree
Date: Wed, 2 Jul 2025 17:05:45 +0530
Message-ID: <20250702113545.367312-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 02 Jul 2025 14:39:59 +0200
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

Update the ICSSG PRU Ethernet driver to read PRU/RTU/TXPRU firmware names
from the Device Tree using the "firmware-name" property, instead of relying
on the hard-coded firmware names. The firmware names are parsed during
prueth_probe() and stored in the prueth->firmwares for each slice. The
driver now uses these dynamically loaded names when starting the PRU cores.

This change improves flexibility and allows firmware selection to be
controlled via the device tree, making the driver more adaptable to
different platforms and firmware configurations.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
This change is already part of the upstream Linux ICSSG driver.
Corresponding Linux commit [1]

All u-boot CI/CD checks [2] are passing for this patch. PR for this patch in u-boot is [3]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=ffe8a4909176
[2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=11536&view=results
[3] https://github.com/u-boot/u-boot/pull/793

 drivers/net/ti/icssg_prueth.c | 54 ++++++++++++++++++++++-------------
 drivers/net/ti/icssg_prueth.h |  7 +++++
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
index 2639f960631..d8df3c9afb0 100644
--- a/drivers/net/ti/icssg_prueth.c
+++ b/drivers/net/ti/icssg_prueth.c
@@ -63,6 +63,7 @@
 
 /* Number of PRU Cores per Slice */
 #define ICSSG_NUM_PRU_CORES		3
+#define ICSSG_NUM_FIRMWARES		6
 
 static int icssg_gmii_select(struct prueth_priv *priv)
 {
@@ -192,25 +193,6 @@ static int icssg_update_link(struct prueth_priv *priv)
 	return phy->link;
 }
 
-struct icssg_firmwares {
-	char *pru;
-	char *rtu;
-	char *txpru;
-};
-
-static struct icssg_firmwares icssg_emac_firmwares[] = {
-	{
-		.pru = "/lib/firmware/ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
-		.rtu = "/lib/firmware/ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
-		.txpru = "/lib/firmware/ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
-	},
-	{
-		.pru = "/lib/firmware/ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
-		.rtu = "/lib/firmware/ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
-		.txpru = "/lib/firmware/ti-pruss/am65x-sr2-txpru1-prueth-fw.elf",
-	}
-};
-
 static int icssg_start_pru_cores(struct udevice *dev)
 {
 	struct prueth_priv *priv = dev_get_priv(dev);
@@ -223,7 +205,7 @@ static int icssg_start_pru_cores(struct udevice *dev)
 
 	slice = priv->port_id;
 	index = slice * ICSSG_NUM_PRU_CORES;
-	firmwares = icssg_emac_firmwares;
+	firmwares = prueth->firmwares;
 
 	ofnode_read_u32_index(dev_ofnode(prueth->dev), "ti,prus", index, &phandle);
 	ret = uclass_get_device_by_phandle_id(UCLASS_REMOTEPROC, phandle, &rproc_dev);
@@ -476,6 +458,24 @@ static const struct eth_ops prueth_ops = {
 	.stop		= prueth_stop,
 };
 
+static char *prepend_fw_path(const char *fw_name)
+{
+	static const char fw_dir[] = "/lib/firmware/";
+	char *result;
+	int len;
+
+	if (!fw_name)
+		return NULL;
+
+	len = strlen(fw_dir) + strlen(fw_name) + 1;
+	result = malloc(len);
+	if (!result)
+		return NULL;
+
+	sprintf(result, "%s%s", fw_dir, fw_name);
+	return result;
+}
+
 static int icssg_ofdata_parse_phy(struct udevice *dev)
 {
 	struct prueth_priv *priv = dev_get_priv(dev);
@@ -534,6 +534,8 @@ static int prueth_probe(struct udevice *dev)
 	struct udevice **prussdev = NULL;
 	ofnode eth_ports_node, eth_node;
 	struct udevice *port_dev;
+	const char **fw_names;
+	int fw_count, i;
 	int ret = 0;
 
 	prueth->dev = dev;
@@ -659,6 +661,18 @@ static int prueth_probe(struct udevice *dev)
 		}
 	}
 
+	/* Parse firmware-name property from DT */
+	fw_count = dev_read_string_list(dev, "firmware-name", &fw_names);
+	if (fw_count != ICSSG_NUM_FIRMWARES) {
+		dev_err(dev, "Expected %d firmware names, got %d\n", ICSSG_NUM_FIRMWARES, fw_count);
+		return -EINVAL;
+	}
+	for (i = 0; i < 2; i++) {
+		prueth->firmwares[i].pru   = prepend_fw_path(fw_names[i * 3 + 0]);
+		prueth->firmwares[i].rtu   = prepend_fw_path(fw_names[i * 3 + 1]);
+		prueth->firmwares[i].txpru = prepend_fw_path(fw_names[i * 3 + 2]);
+	}
+
 	return 0;
 out:
 	clk_disable(&prueth->mdiofck);
diff --git a/drivers/net/ti/icssg_prueth.h b/drivers/net/ti/icssg_prueth.h
index c69cfd4f162..d88b6fa88e7 100644
--- a/drivers/net/ti/icssg_prueth.h
+++ b/drivers/net/ti/icssg_prueth.h
@@ -38,6 +38,12 @@ enum prueth_port {
 	PRUETH_PORT_MII1,	/* physical port MII 1 */
 };
 
+struct icssg_firmwares {
+	char *pru;
+	char *rtu;
+	char *txpru;
+};
+
 struct prueth {
 	struct udevice		*dev;
 	struct udevice		*pruss;
@@ -66,6 +72,7 @@ struct prueth {
 	u8			rtu_core_id;
 	u8			txpru_core_id;
 	u8			icssg_hwcmdseq;
+	struct icssg_firmwares  firmwares[PRUETH_NUM_MACS];
 };
 
 struct prueth_priv {

base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
-- 
2.34.1

