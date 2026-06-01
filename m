Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754F4CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 21:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2A1D84894;
	Mon,  1 Jun 2026 23:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="RO+TNstQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A78DE84894; Mon,  1 Jun 2026 23:35:58 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7614C84855
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 23:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9iOAX1mBiXLfvuWbYlYh43gR/4yn9FiUexNJJ4YW06uobf3nSJYtQAXF3EDRTIcBPWcWCmpphF5FuDUUfGHq2lMbxyrv/KT+Wk1aTbJc0J1NcnMWkJE9Ylv02ciLc0nlLbQ88XXFARRAAlkcRJYQ3o2jx7/dVoQUztVyCtQ1TF6n428o6LedMTyjYD1PhL+QkTzfNVVTy7SG3tZE5DsESR6/mYwjmylD/ESRKyCxcHKgrw7gd1uYM0osgJBmwzLbFHVlIJJHA/ITJKOdkmjTUVkaUtMho4mtvBcnuKj9xdNc8hhvNiWHgS6d235SBk/s0+yaQ72MjhxNgfAK6hiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPdmh0lL3C/xAr2nuIzMQRo5e2kK+4bJGmBC0tL9v1w=;
 b=oyMCrOzVVk4vMHYdxdtqmn5yArind1sXciD1rL14E1JIDNIAFt0yv4NuF84iGOfTiB0s1ULnAF5UaxnG4H+TlvQtN6osDCveM6VFToZ+8lXDro0Z2X/jy+1yDBvUkeqWwOPidA7drzxdbARScrR0ziCjuaxpPUCr4HX2/OxIDE+qVAds4eq+N5jPmjY36D6BVn4iBv2BRtfo0+FHGfuf0ahrRhcoHGt3CPo2Cg3DJ+kwepfU0vwWvU1byOy5iS64xgJVTXeJsAdwP75YUJkcihFTIu0p2skE+FZYfaDsL/vlc/b9CCaDFrGEhqgKHBNnPf59G/L8WPJ29BWF+4L1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPdmh0lL3C/xAr2nuIzMQRo5e2kK+4bJGmBC0tL9v1w=;
 b=RO+TNstQ7iavVP3JsfZp4lXlx7wFV/7meNcnSjBxdvmSfvMntyiz6lrRyyIP8n1GKTDBJ0KqaxK9LX28duBamtXvnwqVb+yfyIDz5aOxdtvxyOx/CpJcAPcxFiJ4pFAE+WrsLfam/I09MV4Pd647xaujDGvngznsj8KiqCOgu6HK9g53Ce5Q3/Q0HBPhURkK/5YHI6SSuFVWBaDq4PGzpHum/eNcdcZAvzUSgUblv6rrua0sDIiTk6Tf/+yn7/BnpdJSXwEzaiSw4tcDhxFzLK212xSDuEa1XRJ0rFSVEMsElIIl6m+x8XQxI8b2scrUVC5hZVcjgJQEcEwCOHh5UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB5PR08MB10191.eurprd08.prod.outlook.com (2603:10a6:10:4a6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 21:35:53 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 21:35:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2] net: airoha_eth: fix mt7531 mdio related initialization bug
Date: Tue,  2 Jun 2026 00:35:46 +0300
Message-ID: <20260601213546.2436900-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0097.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::6)
 To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB5PR08MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d503dc-01f4-40f5-c252-08dec025c1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: d/36UdG59Q3CWSS09pxpfFxKd7ef0u48W4LLkZIBlaTnicLNMFUxcYo/QFAZ3yx7+KW6EU0Hzxz8xr0ik5UbZ3LQnkhcOkdX9Q5Z5FnaPcihTdjO+iD7R4+fIuiFmkm212TvLWTjZTzNbpmMjdz2tm/wMyblzb+EKKFXG3nODpsHCUVBlLcuNtCtw8JHrcbX3IUotrSGyabBb/2pffS1tGRORYfGttC5J7rX4t8Zj2urwT0dqviMFDTB46CnDVvIJlnbPwbx+mueQcyE28oAJ47OCuMrHwoXzaZUEI6zO6+1yfkwoqfRoOAEYhfqnUVGdCZlHLnObbqu2RQ2/c3L0zZopFnNBtk+Bk5ouH3sqHg41lulemBTrOtllb33oD0qO8rMhGPzvEigDjKA37t3B64tF8YbY2Slj+gGeui/Ao01omPLGXPOV8x9MvZl+EMlvFQFBvn2AQhUAOX6CwHbMoWrIKSGF7Zx26zgUqngSb0t1cmcOFTULuVU8GnBYRFEVynAJgy5o0mmCX6tQzZ1sVCCihIdtKas5awirLLxptlYlZhEEUw7z41gFzPGzNQzUu8TANViCbjm2bJcLgdpA/FlpJQrlCy9AsH6OLOWAAJxpNPCIJyS7907rfT3qadYMseXMk9zggMOEVVWJWZB+DKUiyW8ujMhbfrAYgK9eaXSew69dlqKKWGhUX9WYG4zAxGljxm3RV5kPGmk4w1hrTdHhXoDvxiejYvrq11LFXQZ8WsbYkGLL21h37GVHcs1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LYXpXkkfIbcM6+trTqF7kHHH1DM1VP9g3htup0yDcse53VkH8Gh8Z0fmS0Nh?=
 =?us-ascii?Q?rWCLIZKr4ExIj4nr/nH7sy3Vw1SjkqccmzWeX8Trqwv2gmj6z/n1ecfyi0Mq?=
 =?us-ascii?Q?2QcS16JnPLdyjkdAa18qmqoCP9lnd3xxXPMavX321bcUMGlpkGBhL2HFvpPI?=
 =?us-ascii?Q?NNstOFIORYTp9fLNDoBKpB/6J9B73CJ5B5RLkFxl+xvGFE0Oa9E5BzyPOepk?=
 =?us-ascii?Q?WY+B1oucKNVj4NceDK03QE1yBu0n7fQjsESJ7rA4rgCvznepaNx7UNIsdpZ5?=
 =?us-ascii?Q?YiM1P6AoQ310iqzqiWdP5ovy1LkIJaVjBtrFAx/M00ma9bF/bVGXhW5CR8aI?=
 =?us-ascii?Q?5IQyOJaf1XKVlcO4fUu2m4mg3wubiUcaf5uMcNZ37sKU2ijx3YaUR3UD+Ew3?=
 =?us-ascii?Q?uyQsne0zqRLQ1yvj3+JPszavGlUh01FxPqAzEvVJBGCAixOu1p8eggGNkDQS?=
 =?us-ascii?Q?/Uu51NEgia47u523nCwBqiN0TI46B5uioc+sXV++uAvXsjRg4sxbh2NuvXOU?=
 =?us-ascii?Q?vwprvNY38FayzDy1btXmYIvGrhDsPMhk55Sb8ssYfIp6d6MyBN7cHeJO/eqC?=
 =?us-ascii?Q?Rz9FnQK91rQJTBRYQkBXefbnOV/IbaLBNgvS0mi0vdy5SXFmTri5yWuWIU8i?=
 =?us-ascii?Q?onBPZVykMeX4KY6fOlPObrm7EmvgV3ydWDOP6/x8wS9uQSWFZsHwozJmfObS?=
 =?us-ascii?Q?EgqyTApe/UPeusa3N2tKM2O487EhTClnpCHgxfDWxZqPznYM8KlcOXMuGsIQ?=
 =?us-ascii?Q?TzHKuRdl7GKxkbm4FjImkbI7Uq4SICUymDlmllqqJC0M4rGXtSjdL0Nw+mWY?=
 =?us-ascii?Q?avcZ8Ax6x/Wm5ZaQGy74ckFQTBP7NZtJVhjYQWtLjs03f2hl8x7wZ223mgb0?=
 =?us-ascii?Q?Pl9MHFu2zoE8bP8mV8IvuIdalxQgH7RrVnhVR0lZsV2s773MJ2SgaBfuqBKT?=
 =?us-ascii?Q?SnO0CesA1hyod9oefgNDkvUFj2s1TmC2QSGE47q/tnzkyB27jqfKl03wCFZr?=
 =?us-ascii?Q?80CIdeQkB3Gs9EwgHroPDRADAzjnibJS7puKknK+edqWvkBpUszt05z0nvAc?=
 =?us-ascii?Q?EcNOg1MUkEaOdfpOo+K7OVRPwzcbMkSkqcS3Vvp2MNF12Wq+0nysSnah0PgN?=
 =?us-ascii?Q?d7vo0LsxXmqrwfCIs3YCUXfqi8jAoUTVU2LZJ6BwjaZIinQ57TQfBC/hL6uE?=
 =?us-ascii?Q?4dY7PJ18rviJ4Mc/Rgw3aZWvDMoAYgq9Gp3BPtqjQIce9tPkk27TExd4Hm9z?=
 =?us-ascii?Q?xSMKDq+Y0RM6c/MzFNusmRhy/m2LrRwRc1yxHbeDW5sgKSUwvgBKd+JXLets?=
 =?us-ascii?Q?hqJ84xB5cLFIT+wV/slGU9VGYL2vDYcXalWONW0+ND1pscFOqu5i89s1PA5V?=
 =?us-ascii?Q?7cj5ATWcd+1pMsWCOMU+kZEEsM0yP8985Wxnb0pcd0FsS+wVV2+TUTBuzrwr?=
 =?us-ascii?Q?Kc8TDFz4wfgzoSfa3tALhFRvPUxvA7It9FUBGBo4SbJvhBXeisQPN5XCBC2f?=
 =?us-ascii?Q?9OoXg78sCxIUrs0hXi4xQtxrnEeXjlS+dkrvKw8kbes5mezEbdE8wxA5rnN3?=
 =?us-ascii?Q?h2MuMx/nk3HI+6/Xmp75q+tARfB10KyiEbmdxfLjm9kQ5t5U7VLZK1IMhQD+?=
 =?us-ascii?Q?iQ4gB1yMFrA+3BxNc3O8N3A2jQzrsd1HGG32lvrHAU3FJEDLFlVzTfCp7BQC?=
 =?us-ascii?Q?0+pAUq8B62SPpufSy3T/sQTuiIGolZZs357exWvZ0RtWK3gcrnXMmhfMLQm9?=
 =?us-ascii?Q?+XvuKZqOUtuCxmYtZMZY13hhC8LrzAM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d503dc-01f4-40f5-c252-08dec025c1f7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 21:35:53.4985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAAKywvc/vxPSbMV49qSGfYMpLc+SNZqIvZKFrcZe5u7/367BshwM5typoOVS91Vamp8gutOG+RTMTfqZ1IWu7e3d9oO7T7+fTiHsP0iybQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10191
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

To solve an issue, we will move the mdio initialization to the probe
function.

Fixes: 96d9e7c46425 ("net: airoha: use mt7531 mdio for GDM1")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---

Changes v2:
 * small refactoring

---
 drivers/net/airoha_eth.c | 51 ++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 84ee9b2ad76..0a1bcb87104 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -365,6 +365,8 @@ static const char * const en7581_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
+static struct udevice *airoha_switch_mdio_init(struct udevice *dev);
+
 static u32 airoha_rr(void __iomem *base, u32 offset)
 {
 	return readl(base + offset);
@@ -850,6 +852,7 @@ static int airoha_eth_probe(struct udevice *dev)
 	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
 	struct airoha_eth *eth = dev_get_priv(dev);
 	struct regmap *scu_regmap;
+	struct udevice *mdio_dev;
 	ofnode node;
 	int i, ret;
 
@@ -908,10 +911,9 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	if (eth->switch_mdio_dev) {
-		if (!device_probe(eth->switch_mdio_dev))
-			debug("Warning: failed to probe airoha switch mdio\n");
-	}
+	mdio_dev = airoha_switch_mdio_init(dev);
+	if (!IS_ERR_OR_NULL(mdio_dev))
+		eth->switch_mdio_dev = mdio_dev;
 
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
@@ -1202,39 +1204,52 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
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
 
+	return 0;
+}
+
+static struct udevice *airoha_switch_mdio_init(struct udevice *dev)
+{
+	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
+	ofnode switch_node, mdio_node;
+	struct udevice *mdio_dev;
+	int ret;
+
 	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
-		return 0;
+		return NULL;
 
 	switch_node = ofnode_by_compatible(ofnode_null(),
 					   data->switch_compatible);
 	if (!ofnode_valid(switch_node)) {
-		debug("Warning: missing switch node\n");
-		return 0;
+		debug("Warning: missing airoha switch node\n");
+		return ERR_PTR(-EINVAL);
 	}
 
 	mdio_node = ofnode_find_subnode(switch_node, "mdio");
 	if (!ofnode_valid(mdio_node)) {
-		debug("Warning: missing mdio node\n");
-		return 0;
+		debug("Warning: missing airoha switch mdio subnode\n");
+		return ERR_PTR(-EINVAL);
 	}
 
 	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mt7531-mdio",
-					 mdio_node, &eth->switch_mdio_dev);
-	if (ret)
-		debug("Warning: failed to bind mdio controller\n");
+					 mdio_node, &mdio_dev);
+	if (ret) {
+		debug("Warning: failed to bind airoha switch mdio\n");
+		return ERR_PTR(ret);
+	}
 
-	return 0;
+	ret = device_probe(mdio_dev);
+	if (ret) {
+		debug("Warning: failed to probe airoha switch mdio\n");
+		return ERR_PTR(ret);
+	}
+
+	return mdio_dev;
 }
 
 static const struct airoha_eth_soc_data en7523_data = {
-- 
2.53.0

