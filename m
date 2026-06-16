Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA6CCD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 05:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B605084869;
	Tue, 16 Jun 2026 07:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Wx43XqHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2147484895; Tue, 16 Jun 2026 07:38:57 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16713846CF
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is7/bZmV4BVrRLcrRhAL7zEJGs7UCFd7lI8EfrLgWCGS6IQ2w3WJlagNs5MPseS0qbWqBFk+F4bjGuNAsJ4NvgMFbaG2tw5fm+x0/bo7baqK41IlH0NEEDIH7n7d0Z41NFyDbAg3wMwgGpoRTlvqMYIx1tAmUv3ZTvChbFa0Gv3OrDOGCj1l/pmJQZ0X/D9EqA5gRoIrp+hEt5N3JbraeUdFCAlrsrUnFkrqWjWmSQFT2ia+d4VdI/MxCubl8Z2/VqVhd1q04DqqTrKVenTX/D0QShaPrqXbYbRHoJej4Noi+LYRzWSBS/6pYlrhuScrxxuhmPb1Oh78MJv42gzz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCWmuH3FiA8rp9BiiYk2bBSAWCzQh1Gha35jVGWu4j4=;
 b=Fk28SAdRK0Z6sOhwWIzwYFb9TIiwpGFqOszI3Uj+auVJpY5nXFPJu9ayhL0arROU4HHY2w+yaXDZ1kvXZrON9ILk8XsO7QZQVy6LbMy5su4sBEPEFZzmVtcouPSc+3RwQfzlpFhNio4lw6DoUyZ8QLoeIn3UoTqVjcPXZFWjAj/cHS5blvZW7nEccy4xJzwyeKuHfzFTSuiIXSf1qHG9aV5A19Vlymnq5K6/6G7hP4p/roP9vCrr3CI2ndLGdGzt1V4rsLCPWO+TV0cPUPh/OJAOs4CgUDTqaO+W1PtqGgl8MeFaY5YueQxeCd23s/ljYrm1o/V6JF5YooO8ofDymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCWmuH3FiA8rp9BiiYk2bBSAWCzQh1Gha35jVGWu4j4=;
 b=Wx43XqHquObPcr0880tCsmc6Q+wv6o96zhjdUL9YA0mGowtqqaNmaL1/5kVr6HQVynZQbzFGGsU6KZ+ztQPh7u1KWoTPt4erlgQibJCwnXIFM9ppkX9V+d94zwAjA2+fuMk0qkM75KNr4l0nNuRmESOAXt0xjbqEuqUT0qYrp85L3FE6IfC1mdiigaWjp74aCB1ol1g/OQ1ns3jDrJc+/tO+/5dKBaPtjAwN/N6jKSshs59d41fh6XnXi/h495lLZ8UZbtd6WGRRTIBPRbrEDvD+x12IEOTd85+9etHp6pQOAfSVaHK6r8kKgCj8tgA6AzRzW7E/S5g8nve6VxjzIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PA1PR08MB11672.eurprd08.prod.outlook.com (2603:10a6:102:555::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Tue, 16 Jun
 2026 05:38:52 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:38:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v3] net: airoha_eth: fix mt7531 mdio related
 initialization bug
Date: Tue, 16 Jun 2026 08:38:45 +0300
Message-ID: <20260616053845.2624481-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::19) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PA1PR08MB11672:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e0a185-554f-458f-6628-08decb698c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|52116014|376014|366016|11063799006|56012099006|6133799003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: lL5lzzyOp3htsb6ZBE2vE4xBp3ifXFuqNDKJrrDJSiW5CYHnwaWCWLeD0X6TePLRwVhM8MUt2t89iVUgY546y9zasaQqeTignvPBezeZOZ5Ci+JkRCjgiQT3tKc1PqF+/fgQMwxk48zONzmYflSbp8klsrE0GUGcslKCofNQSjyHEe0AIEeuyvYgjaMNWF3oV2cRM+lTmEZl/C18UuDvJJJxEnxvlrVHGLJTWPGT0X/LSRvQC7tFnmiYnfJ3h0KFM190Q14DSmsPYgxjM1LMePmDTQJPfYHfcnlnsTnAOAumqWjqGGRNb/RQjeFnRXfmunYnqDh+Im1ouB/5/NJfJLG4WOzhwauT4QScvnry5APYBMv/ZdVaC2959BpcFjNU0cNJz90FeH4gu43qaiI0v62s9z4D/PZ5asAAlTyIN8TXHzOMRJIi4qlG0ReKbQ9+Yj4d4X6PpGDDWiXXzkN5ivk0n6gsHz5CZfmu33sWYqaRg9op1c0KxavwunSSq+x0iYhYOaqlv03Nk18hDK8uufsxow14+UeTrwTud7SWy0pFTON4SVM3daWYJHYs2Cuk3lsdlY9gVICQCg6Mg0bKdkmnT3B4V//kbkA0CQ9KbatcBDeEgeyz1UUtzI7+7ScbsxpZ+j1J89V1QHJO4ftwBIR2BK/zdmHvY9EdX50ebKdN3DjODiXaBwV2CM0wCmcFOI79kIHDgrHqrnh6CNtMA4SvWbhFdvUwrYPOm0467BbJc3z80t6Ibz+IZZqcfiHu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(52116014)(376014)(366016)(11063799006)(56012099006)(6133799003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRTgWkQgVPqHrBzkKvynTs9eEgliCl1tJEztGgKrigo3AmRVGZTE3ABgk5/O?=
 =?us-ascii?Q?4VhL1gTGYctbZgi1i4g29/HeEF0plBFwek0AXjLU0qkx3UFWgPSHpKNiKnJL?=
 =?us-ascii?Q?puP7qdteMSnxNPY68G4cXaYyHmQnUKtbFP5jI1SWBUyQtaiq6Pf0j5sDSmIf?=
 =?us-ascii?Q?tp2BFCi6C5Gh3gC4IXc5nwJWBlt1+8g88mYWQxReuW+xVb4y0SiEoh/EwnpY?=
 =?us-ascii?Q?ApiXZsee5c4mNFHTHnwpUkpfOvix1eix0do/4A54n1YmOJ6/sRIc1+o1Dq5r?=
 =?us-ascii?Q?v8vs14grDgnFNOfzY3GT/KZ2VqD0D0aCG37GAYsZdLrNbcumNfrwD3luvDUx?=
 =?us-ascii?Q?7YsGYGp1b/hq7CaTJdPbbFCUr4jmmBuTJCtAVW0ZNffxpJS015+vWAd/d8ha?=
 =?us-ascii?Q?Ut/xl34O/1Ag7XHMCVXaw/PSpqL8E58kXNdVKsfIeIei78sk340oMX/iV7ax?=
 =?us-ascii?Q?b2y/OZG6brL+85d/GvQBAMVSFuM0xGEwTcUxl7/yKDZBcKHAQTwkBqsyjPtC?=
 =?us-ascii?Q?Na2SsZqfwHqLNU93FzdxMbsS+rkxWXYP9OYMmKEyxClnrPrfCJhV/lpG0fAw?=
 =?us-ascii?Q?0rXEKb9p225oD7rKyC2ZWijMKSjYAUrJRyapbYciyPUShzcGxFI8wIe4o1an?=
 =?us-ascii?Q?g8L5Bo0cAyKCgSXjapNDvUjyerw6RwiQTkzLp6mlFfKKLutEgtuWgAupLgtf?=
 =?us-ascii?Q?Hv+WTosqwR14IBS/7PFF3h+4oOLSaRx1s1Jo6WrI4etbJ+K7p+TuYw8qwoUz?=
 =?us-ascii?Q?ASVWADiIC8RktTdBCGtisCNB1HZFg0v6pUa+QJgx0hm+nb9zhoZjZp33gTXe?=
 =?us-ascii?Q?ZDHzaBuPhwxDbiseLlpcaz1k2nSYJZv1PdKHhK2ayQhcIjfqHA5bjBT92mLq?=
 =?us-ascii?Q?QeefW5m0/kPZyDRy3NrGyzuvnNM5xg8Xd7+c60uPR2gXS47yI/oQkfM3G0uQ?=
 =?us-ascii?Q?n4MhA9J5g0WPZQu0Rjv814yvfWtP4CIqT08XQ+Rvt2ptSFXM5mA6Gnk3y5vW?=
 =?us-ascii?Q?/r9DIgG04DQtd6tXJQHwptM8ww9ciZA5Kd2wWjQqMmo2PydXKjqQyg88Mpdx?=
 =?us-ascii?Q?72xeEqFn3PGM5jyvXJ4IljFrmCMqWBGpye2P4O/anUUL6WpdwZXuSMAFcloO?=
 =?us-ascii?Q?BUfNfoVrEUejlBNXD+utvErVwr85iEH+t632zGpTKn3zhP6Wr46Im1Rx19Wx?=
 =?us-ascii?Q?OFfgSzsbktKB1EgY/ZxTFt7OGPv8pktbDqU5i/jQmolQnSPG6RCm6qyvYslR?=
 =?us-ascii?Q?6eBKHlPXr3MawurjqChPV1LlPt/kQrrtR4qzWz3uo7tYI+ayRJkrxLuLdScI?=
 =?us-ascii?Q?IIoHba5EqNZVJzb2cFvrm4LdCIQR/QY83EqDsqT6Yhm/+5sjr+hnONcZh90q?=
 =?us-ascii?Q?TjQyJOa6GNmu1N3lnPyDVM9C+jqyElyGJU/NDm61P0p/tr4CyTfSfa4MTmhJ?=
 =?us-ascii?Q?BYQxUMPKf4vM9ApBwf51ixJKYsA+u0VzlhgM0t8NoPvCfY3dxElp6uhnzV8l?=
 =?us-ascii?Q?TfZCyeYOl11hyCcnjZd9j2kQ4pCvTYl6+S9NzwipF7Kq9kpINhFuzrfC56qL?=
 =?us-ascii?Q?FX/LDwpO5JPM83b3JsDPPOgB1vMxMD7S2wHL3ITh0aVLrhh7Nepa9L3NLzCO?=
 =?us-ascii?Q?uB3FKlyc7Gdj3Wxj/arRLPG1WFVuJk6FpjEiNh3ui9wLdGxrZDIMIJ2X7JY/?=
 =?us-ascii?Q?EaaPvvrwLZ1DwUVPF/Ep+cVXm5IKFuk4p9ISMzLrKXCYFcOumjueep22RVDE?=
 =?us-ascii?Q?8r1dOenDA4dm7uQeBNNFHTpfjFhUa8w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e0a185-554f-458f-6628-08decb698c4c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:38:52.0487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaKweXnktIyxcWSIcX88EwMn+POxnLdC3Q2dH0c/Qi5nOiK9+YkivalYyTYlZxsZ7b4JjZIaDw1HEhWZ+1hpeZ48WmjfAUTX4KOI61IV5ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR08MB11672
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

Private data isn't ready during bind time. The call of dev_get_priv()
function will return NULL. Thus we can't save mdio device pointer and
use it later during probe.

To solve an issue, we will move mt7531 mdio device binding to the probing
function of 'airoha-eth' driver.

All GDM ports (except of GDM1) are connected directly to their PHYs, so
corresponding mdio bus will be automatically probed during PHY setup.

GDM1 ports differ from other GDM ports. It connected to the airoha switch
device. The mt7531 mdio bus is used to manage link state of airoha switch
device ports (LAN ports 1-4 corresponds to PHYs 0x09-0x0C). Therefore,
manual probing of mt7531 mdio bus is required to be able set/query states
of corresponding LAN ports.

Fixes: 96d9e7c46425 ("net: airoha: use mt7531 mdio for GDM1")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
Changes v2:
 * small refactoring

Changes v3:
 * Move mt7531 mdio bus initialization function before it's first usage.
 * Probe mt7531 mdio bus for GDM1 port, but not for other GDM port.
 * Add an explanation why mt7531 mdio bus must be probed for GDM1 only
---
 drivers/net/airoha_eth.c | 78 ++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 84ee9b2ad76..e5d39b95cc5 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -845,11 +845,45 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 					    (ulong)eth, node, &gdm_dev);
 }
 
+static struct udevice *airoha_switch_mdio_init(struct udevice *dev)
+{
+	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
+	ofnode switch_node, mdio_node;
+	struct udevice *mdio_dev;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
+		return NULL;
+
+	switch_node = ofnode_by_compatible(ofnode_null(),
+					   data->switch_compatible);
+	if (!ofnode_valid(switch_node)) {
+		debug("Warning: missing airoha switch node\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	mdio_node = ofnode_find_subnode(switch_node, "mdio");
+	if (!ofnode_valid(mdio_node)) {
+		debug("Warning: missing airoha switch mdio subnode\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mt7531-mdio",
+					 mdio_node, &mdio_dev);
+	if (ret) {
+		debug("Warning: failed to bind airoha switch mdio\n");
+		return ERR_PTR(ret);
+	}
+
+	return mdio_dev;
+}
+
 static int airoha_eth_probe(struct udevice *dev)
 {
 	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
 	struct airoha_eth *eth = dev_get_priv(dev);
 	struct regmap *scu_regmap;
+	struct udevice *mdio_dev;
 	ofnode node;
 	int i, ret;
 
@@ -908,10 +942,10 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	if (eth->switch_mdio_dev) {
-		if (!device_probe(eth->switch_mdio_dev))
-			debug("Warning: failed to probe airoha switch mdio\n");
-	}
+	/* Airoha switch mdio PHYs maybe used by several GDM devices */
+	mdio_dev = airoha_switch_mdio_init(dev);
+	if (!IS_ERR_OR_NULL(mdio_dev))
+		eth->switch_mdio_dev = mdio_dev;
 
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
@@ -957,6 +991,16 @@ static int airoha_eth_port_probe(struct udevice *dev)
 #else
 		return -EINVAL;
 #endif
+	} else {
+		/*
+		 * GDM1 device connected to airoha switch. Probe airoha switch
+		 * mdio to be able set/query states of corresponding LAN ports.
+		 */
+		ret = device_probe(eth->switch_mdio_dev);
+		if (ret) {
+			debug("Warning: failed to probe airoha switch mdio\n");
+			eth->switch_mdio_dev = NULL;
+		}
 	}
 
 	return 0;
@@ -1202,38 +1246,12 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
 static int airoha_eth_bind(struct udevice *dev)
 {
-	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
-	struct airoha_eth *eth = dev_get_priv(dev);
-	ofnode switch_node, mdio_node;
-	int ret;
-
 	/*
 	 * Force Probe as we set the Main ETH driver as misc
 	 * to register multiple eth port for each GDM
 	 */
 	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
-	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
-		return 0;
-
-	switch_node = ofnode_by_compatible(ofnode_null(),
-					   data->switch_compatible);
-	if (!ofnode_valid(switch_node)) {
-		debug("Warning: missing switch node\n");
-		return 0;
-	}
-
-	mdio_node = ofnode_find_subnode(switch_node, "mdio");
-	if (!ofnode_valid(mdio_node)) {
-		debug("Warning: missing mdio node\n");
-		return 0;
-	}
-
-	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mt7531-mdio",
-					 mdio_node, &eth->switch_mdio_dev);
-	if (ret)
-		debug("Warning: failed to bind mdio controller\n");
-
 	return 0;
 }
 
-- 
2.53.0

