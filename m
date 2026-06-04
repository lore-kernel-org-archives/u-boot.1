Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28A4CD6E60
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 01:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02E74848A9;
	Thu,  4 Jun 2026 03:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pSApP/lo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 647C3848D1; Thu,  4 Jun 2026 03:08:51 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC857840ED
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 03:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFISD4XrYoePQJF2QjnA62emkdABLOoX/aA6EqM8YSpOzCMwnKsFDTAxqMp3dma3WzWQIVRwtr9jjv4GTc9zH/8fgfESyNbq5skiLJtLC3U/yjHPVlObkqFdytfC5MkAOpITsu9bPAyuPWd72TBy6PDK8Z1NY07/ul7vjFc7jAecct6klH+L4zWLFBqEPGeupe1wx8xN9/sKgNYhw7t0oryisRv2qWNvyVs5Lif3sBqO2Vbdu0YZG+G3j29l8bdWXdQCFxWZ32Ys8LPQH1nJOFzUaLbOeg7Oo9GkXS18j3mjDUGq32gkGfmsSHjknaL8F97oTPHDFLh1E6wM7VxFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCWmuH3FiA8rp9BiiYk2bBSAWCzQh1Gha35jVGWu4j4=;
 b=buAMPJZsvUMnNtgcgctHi6YpOiFAHAtYxih6Molu0Eh4j6wwvLgW+K4BH7QfdukI/Dn00iN6ZBiKvphCKHt4hX7KZbKnnRezNfA+ZuO7v7cNY9OmZVYkyrafMT2pd7rQt1gWo5NBChkxXhrY2LNivdqqdueA2uFLom9hXhnMlzNpWfiQWFV9sM66tX1UQj1KzxvZzfoTggNqoI3qETVTeYpLLlj28gIF9Aey9UxCJxvO29AL3H0r0ME7S6809MJKUOLtpnfdXkQzJVTGW6X0joGI3gUf9CR9oy/Id5kI+/RugBXNXKzLYrxJt/zIPFnRdxEDzLSR3ybG4DMwBEhjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCWmuH3FiA8rp9BiiYk2bBSAWCzQh1Gha35jVGWu4j4=;
 b=pSApP/loo+Fv1ki+3UAtElKXJQQh2Gt6QfUb6b20xOTAmD1vX2Mf3g5kTb41xvCqz7NI51a9eqX566ddGcqclRWKN1EQD9zFLcWQUcgJPGO7v8LOooPAcfPs4E7QLD33VQfpYXSucLgOFaVc17EDMeAs41NcztZmLjyl0il087YBRd94kpFchFYyl5dl24myeMJeT7FLDw8jli0V0yhYja0Sip/1ri4tey+IlLOrsP5lI2UFC87t9YEXv2siw9aQLOwzEWfgV3BqilE+0+3z2ph/NOSQwqlA47ASqgyjd3micM4cJpcrIVkURYKqADVpNm/5fJQg+j8Hkfq6HQ8z0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by DB8PR08MB5514.eurprd08.prod.outlook.com
 (2603:10a6:10:fa::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:08:46 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%3]) with mapi id 15.21.0071.011; Thu, 4 Jun 2026
 01:08:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3] net: airoha_eth: fix mt7531 mdio related initialization bug
Date: Thu,  4 Jun 2026 04:08:37 +0300
Message-ID: <20260604010837.400528-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|DB8PR08MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 9241e646-bf17-46aa-221d-08dec1d5d35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|11063799006|6133799003|56012099006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: G/rNY3VaYkxT8Ql16W31ybjAroi7ZyWRNllR+gY4jYdCG7i0PKiW2hiIt/dX+sqSPOhtuhqamXHnXdNdEsWA3SWe0uu5iirVMU/OMeC3eAQ7sTyOUhFsmwan2PxDBfYqPSS31V5o6rrmMby4O+KRps9gnQZf02njg2gafdO6n1mEqryp3i4c1c1HRJiD7xWW23Nww/Kq3vH37EDlrBd1Deoj8sxCaJmk4IMgKvkOXEZx/qI9nFiFp1HeFvP3LvqSrVyr3yMVQq1xnrpnQSCD0ylzScfjkCyqvdrsCGob72D/obEm6zthdLzEcE0RWas6xpIDw6cn8AJhM4M5y96WHIjqYjQpEjo8st72nkUhVPQg1j0lg07hYCCFvoSiNIS1weBjVD2ENdGIujCZbcPCcuRMQmEbO+PY40Rx+FJm8EjBmMumV/k6TsFNCOT2wAeo8FD2SzflavQbsqYALfRUMX3/8Ruv32bKnLM7DpXkhQL64pBrFCZ0Gy110QRewEMoBwawwbG0Hs+pDZGLZ5gB7joLBXS4ng3ZmrF6cVLf9g9DJyRLe0boZ6mmHvmPceMUtVQFbpOC0MAJpGIFegzs8JhL+RyfeZuocMpDhBiEtqhx3/ZzAmYExpxPEg7QUPZKeprulKCFHmJOb5zntm3c95JIEjOnvI9IeiIXzmpSO1hHTvFK4cWmo+Qo/HwIPH57AI6Hfe4FeIRdADwHdzEG3udJuH2H1iAPMfYsiPRsRJtmJjZdnZ1Ft1D50RikpqEn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(11063799006)(6133799003)(56012099006)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05SXm2C3RIUUtyGS4axOwpBMw3DPUWUZGX594MvSHrhGIQgkeomtbsCQ3tgD?=
 =?us-ascii?Q?MFbQPU72y3bt0YR/sA1piEb1DLRlRV1AhxbLZB7ORVGNCFGAGCNtPgnixiUh?=
 =?us-ascii?Q?eT0L4wRkpLYIZuV9so6+Kzby8afmGL8oKg5LeyuYxj06qlNBAoyf+RMD+CNQ?=
 =?us-ascii?Q?qOoScwQBPNpBwBAYCMwq/+zS+42NgjwF0x5bYq3wQes0LKeK27NAcpmjxyV2?=
 =?us-ascii?Q?af0xxmCu1Ik1QqULVwZZ67qKNLjIZOZWk6YCZcZc7IskXon43SIahbxIDf6J?=
 =?us-ascii?Q?6u+baI8wcww59NuoQ/XUo57OUdrXE9gkKKyoQHQkXGyEK6ua5gocLWgF0iyr?=
 =?us-ascii?Q?n5f8GIgxzGDmigR+R33mxhb9dq7xd2pG6Xil43vUNVuGPwchjohabqJpu5Xc?=
 =?us-ascii?Q?NjtJXG476S5JO7WzHE0w8NN+ivgq/PyImGVN+ImWMXVZjzPXoEA1aVYu8sm4?=
 =?us-ascii?Q?ufUU+3NlI9amp/KEZYfaZqGYHtEi2YYhPf+el56sjqgxTm1H5xouoxXkj54s?=
 =?us-ascii?Q?WDYFoDTPzZWRltgCRRhpP5BQHpaF4cHNBh0lv/76RKL5/gcTYqflV5ZypVmy?=
 =?us-ascii?Q?5xYveK08erDRuaDwyWxfyZ8bEMOWKYSVHsIpfa1M42h7icDyW2ze5fzwL2xA?=
 =?us-ascii?Q?4VHQvMKSthvTjiNl0LsdaYb06lT1tP/SSdxUAYtQqBzlwICV/mntdk51Vhd1?=
 =?us-ascii?Q?Rf7o89Iupd1k8WVh+j4qZOnzbUcESr3JrvBGZszzynpjQzwwvdpC7fgYExKV?=
 =?us-ascii?Q?nligGcPr7tldcIBvHkm7KG9AzBbkPFIOdPbeYryGcOiQWW1wHWUXzvyAVGKg?=
 =?us-ascii?Q?tydSVeQiHQV8iDby3Zq9QzLw0OoH6ThL/V9TXga/+TKA5gWu4XWLWnIKBntJ?=
 =?us-ascii?Q?gf2YzF+L7CBrGCLd3NEbOFzj3T/vl1+NQiE85Obdg9iXC2oP16XybjSGgF2y?=
 =?us-ascii?Q?9AloKTjk8dsdjhjBmDAUqYGbBU/kuHgRtOabPQn9K38QVwZhvo3p3gfgSIUZ?=
 =?us-ascii?Q?i9e/kfJCVSKQaHDU+40+PkDkm4seb17i7Zp6lPOGoNT8QHiBZPsdudTCsthe?=
 =?us-ascii?Q?yX0QcSzXcr9rv9QRfLYAYPDSCJjjtESNqs8BxZus2RNqnUsx3rY8vhXSc1HR?=
 =?us-ascii?Q?uXcQK9qtGXy9cY0wnNdMkqM+x7zQ/bGFGaia6iUqYcH0oEDuUVJ/HouxtQD+?=
 =?us-ascii?Q?BzPw1h7itD2B/NH/S0jk7Aillm7luDm4Q9+IVwe89w8OXuQFx6r+Y3gbluuA?=
 =?us-ascii?Q?/ulYY97yBMXMWx5nql8af4buSITJwpS7kanBhflDVxaUEu7PPSRb25EZ3EM9?=
 =?us-ascii?Q?HSDd2PXAJ9cM/K//HFgZQZu684gnXC8ZSHEKSQajKQphD36mDIVBHKY7PqA3?=
 =?us-ascii?Q?GuQkbYs889132Z/uAIXZkKR6cM1H0j3mnLMVMifvcrY6D42W2V9mQFb/QOFX?=
 =?us-ascii?Q?rRslZfa+a5V0LX3o4rdpFuPM9trcFJgeB2uMMjOuXlu0oQh3iGlZlScYJY6z?=
 =?us-ascii?Q?e85rAWcXV3ogo/LgT4PFbwuqWcF3XZMpwEy+fjnKG16ay843iSja9wTNODv0?=
 =?us-ascii?Q?IJre51cyMIadagx9MwgxwD2tvlTzy3u0CnmU/Ong02uY2BO1pJRWsVjrrzkl?=
 =?us-ascii?Q?W3vKndSkmUjuj2s8AzV02uEYOxl9n2exJtVQHCpPjilvDOGHmdd6r9C68FOp?=
 =?us-ascii?Q?cKVlE21EAFSwvPFn6C3DYJ5vr5Uio69I0zCT/Tim4KoqxKExR7fVIz3TPQQr?=
 =?us-ascii?Q?vQYZCBf9vo/jjEx5yw2A/jWKELGQoYk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9241e646-bf17-46aa-221d-08dec1d5d35f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:08:45.7810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfCCVnDLa9G1fO6FDl8uI3busG0PZyCwBLnJOhBGvgM0PszcWYDWoSey6sxvL3WX/qFKNmMjJnChV/P2pnFt35Fpg5H3Qvy+12UW1huFVI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5514
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

