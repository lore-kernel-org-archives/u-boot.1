Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7C1CD6E56
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 10:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E296483DA6;
	Sun, 31 May 2026 12:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ja6WyXiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15EB38405A; Sun, 31 May 2026 12:08:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A08838D7
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 12:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFbyYbgGmp0x7d6EjOkzxMI1zEAjuNzBizv74jkvljQkLStPDEG6jo9fUStCetHg+FVf8VxLdOfGDXByIQ+KTxaMgcd7An/XIgAPYhgIpLcj8dbqwKFAnv8NhBgBfIq3ypbsGR7w7ldGsMlx1/0yY0fuqplTb2V8SbdP08OS60tp/WZ0gIDl7Mc2goac9iV6bhPq1lMXNZFyFTDH+DdbG4qGYY+Cl2OYSVvU/uYrNBdECpOKwQ8ztfFiFbwqoeZg1KxxlQNlbov0yYPUDepzTSsq3au4vP2m0wQcmxTZkLb3gfMMLAoiTjAyWjZYrDSd4lTA4tr+x2FYm0bzPFWuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgiBf+t5+hWy4tYR+bKQLN6crZf6fnWz7Xt3td7dHLE=;
 b=WYM127fHlNUyOaYqt7y4nsTbdlsSbplsHppw1O6kiy7t7CCcc3MT9Plul2GH47OVS9+vdHY6+tgqIBUn2KU6vZYMreLIaKuxOI+XI9ISdXO2G7JSJD8iR8eG9D97majY8RNgWBF6FPwbCrqvhnWMEk1L5bsuJq8/70T7G8LeYwwNqJjT+6WsvZzItxBgKmonwWvZxBclOGS4jFpAxwpXGWqNUvhLIdpfU2XdpCijncJ6suwMjHBphVLx715PWa50JpF+gIMPpv8XSQXFSVrHR4yd3ulFPyZeBuvtibGonLP7fdiBFwbQCLC6KYmSMdJMkNjTB1jY6MknFjNIkGXrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgiBf+t5+hWy4tYR+bKQLN6crZf6fnWz7Xt3td7dHLE=;
 b=ja6WyXiSxjOEUHYfgAJ8YDV5rZS9qqgNWJp5yAizQCPgyDLLd3Lp0yPNw2Zp3jTYtS7Tx+ZVjoAN2fFxUwAZfoGil5cQyBhZzsNbINtoPl1RttyeyyU1YZ5hSd2uUvRgdxxw9bAu+o1hyRGTUlZ7vEmEj3HuPc8KMXRhR7cOO903Q26m79xQ4Pj7gPAuVP2fnT1yJ/nSczsMzyx+cG6iGsy83nA6Drrecx2cX1uKNOvALIvtGa1rAuKpCJbEhUij2L9jEBuZ63aei2j+94i+MPp8OoZ+kjuBrGscWOE3VppxIvm9v73nUO0WhO9rcmJaR9a718rOGv+iNDW7TEAQmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7536.eurprd08.prod.outlook.com (2603:10a6:10:304::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 10:08:16 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Sun, 31 May 2026
 10:08:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] net: airoha_eth: fix mt7531 mdio related initialization bug
Date: Sun, 31 May 2026 13:08:08 +0300
Message-ID: <20260531100808.1817485-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::19) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a9d45a-7711-43ee-1708-08debefc87e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 34wCxmurfST26hB8QmHoJdPdl4ZWY64FUHnM37pxbKAqn9hvRNo0WkC0M7ZelFeDH0uUv/o1kP1AAL/ng+a+UfvXUMX2aNtG01Aro/TzmKeGts5IAfzBQwYl2eJZB+wxkuLqkbPdPPo8XtBNgFx9kF0Pk5C7I0NMF7VRHYv8tNGzzHLDshmjzo0NcKPbm/EwVB4bs1j54t2veS4ky5SFLvKQygc6mKk1uBk/EEdTUOMdoVmBoicH/iLuY/QKF/MOKZQM2FB1e6/E/6pVqIYeEeEWNznf6NN/QweHhIqd3SglP4SApqBDsz2TQa0P7d8ar5eCEUELjJwcMCDL36QKIQgA7XVK5Ow9pqRXfmE5Yhg3AGlkSzb7pMch/ey8+XG9Q/CAJIrkZyoRPtef/UHpxbC7rnaO0qP38uzCWEOMydTbQcV4f8i05/n+md1n+9lJ15goktQ2WHvOKcCN6+CO7Pt9VISkMWrjHMxB/pzCI9GjCwUaLfOqoom8oPJKjtNFc4d4LzTrNGJDQqhlSNPEjIaOuyHM1BUr4jjRgF1rwHMXkN4Uu1NyYH7MEhkPmZeFY4xtthDysdjbCTKR2/UUuGYTvukZwmZbR1LgMU2PkiJO5KBbMlaykXFCvwC+ionY8NfTnyKUEvsRcyOy+SAZEldtE9Kt31p5T/6CfbNrJcMPGzFFHkZ0tuOWZSxMpD/USjpoQLOhhJRB6unzk2d0QRB/nQpf3ITlLVjFCEZctZerQy0nnwm1ffKyBFlVl1z3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHkiDKziGojIagRc/m44gNZY87hZdHmoyWm3yuGD6VWfwcsOsZjuv5M/J9hx?=
 =?us-ascii?Q?BPPPEU9G6eceiz8hsNU4tBaALlOU145G3LERknqkK+kBJIWRIGlRhmrYFpUb?=
 =?us-ascii?Q?CjCKFLVenvj8/apTAmxKIAYHoqlNqBjSvlv80LePu2zUQi/Z/dOyke+wTX+B?=
 =?us-ascii?Q?IBUYdThMgzzzz3GSypBBsVZ7zuakW/mSJiWQn40CCe3DbPYwNITjhbt0YC/g?=
 =?us-ascii?Q?Mq5OMhggD7eOqeQfwaQFF0rlYgPnq0KR4x1UqU6nYop80NKSL/nL9TgwLnNJ?=
 =?us-ascii?Q?ljqCqaNoNBY0oaR8bgz3ZKt3kFK8fR3wLHAYZeQijbahp8tE+kggF5OiWsCp?=
 =?us-ascii?Q?EbVhcUT5D5hfwfWJ02eqTS1/Z96FwDBPHnWsOvTa6jZmSIKc5+uSqMBcS47w?=
 =?us-ascii?Q?JTpJXHAp+kRVEVg/8Myk3RHSaGHA6XhPJLudh4cRs/xVjNNxL6XansBJRoU/?=
 =?us-ascii?Q?Puiz+KUF6c60Ymp97n5stFQCQcBVwoGjZ4ssXrAluE2hvfDmpT91UuHBM/C4?=
 =?us-ascii?Q?2V94fofKRwh58NZLqaAZUrKcF8Y19C7NZ2C+D536sOgHyNpVsEMQdsCjrqgU?=
 =?us-ascii?Q?9E3z7o1xvYAu7uiroBMw3Tkwji6Krs+68rLmVk3kkzgUZrVil8BFkxDKoEmU?=
 =?us-ascii?Q?6HXOJEg3QWPNgCXmxkg26c24gXqa5nzslOOwf12zvS2xlwKVrNG9nl0QMgSB?=
 =?us-ascii?Q?HidcH4eKO00nMsUELh2elomVQcaSttSDCAe39/vkXb/OGh2MR+t8Vgytl1/K?=
 =?us-ascii?Q?Ycs4KQGYOhw9e/5GenaYfUtnMwiK2yVJPkCDpwnWYVFvMN9nTRLLL1Fmis5a?=
 =?us-ascii?Q?aF1g9jRY8hO9YGMVWbGQX+9nJTtVAk9iesvrRhYw5ZzNCcfL5NpVC946u3C/?=
 =?us-ascii?Q?WJbe4zOJY0eTTNEcCIZdmfJs5YeXq0oM+wUgHEwqleRhWKSJ1UjnPvst3W15?=
 =?us-ascii?Q?LHer4dqK6JAOCdgDy7rwQVZP0GDios80j2CITDWBFRthlTCXKtZOnDJXdjJ6?=
 =?us-ascii?Q?T+i+onaGAEzqnqDoxP7Rpxr97PKUzRDgOT4XzIgtOL1NOKOQJynjlGucXHSE?=
 =?us-ascii?Q?ORghE3HL/D2y3SVrV+d4YH3d2o4T/rwQxO8LNNNF2FOP6BhI4AnHVgSFcBZp?=
 =?us-ascii?Q?mcvqpV8SF1/4zsLGGjcqGYA97Dvt7+6OAHaBJqpsvjdrJnpuLDdsIWGnQLq9?=
 =?us-ascii?Q?JitFPJwrLsYTc0nOZ5O8ry+OKHjndScWSiWbiosAZbqJ0sw0EDzckbmVV5BJ?=
 =?us-ascii?Q?4wsKgrUZ/P5n/M8eQZwk85JvlL2vz7DKkUpvLEenPdVeBGFAvLZrIdo6hJzZ?=
 =?us-ascii?Q?3Xq7RW8cgLZpXGPRSGeHsaL90B2k5zzD7CoOFn43e7tk2bDL7LGURMA9Zcdd?=
 =?us-ascii?Q?YZ1DywQakDcAVqqOrgVtM3kjtZmUQYxGqqWMp1yBDnza+B1XxM1/pSseizwF?=
 =?us-ascii?Q?LRMLtLtzk1dHpJx3OIwUX00McZ7sAeOIBLL2B3hPioSi6wj01Qq4a32LX3Je?=
 =?us-ascii?Q?b0qXgtBTjvNb1f/pzk0yGlnuJZJjb66AUiMLnVKOsEk38YiRxWBc6qTLcevY?=
 =?us-ascii?Q?SCgCEUbFbnYsXpNCaRrm+73tXiF4+LDWbuMGcv6/Nucr5qWLppfWdzUeVV5t?=
 =?us-ascii?Q?xHK5vr7Slb+P17NAex2SDYG0km7PukyMmmPtNnEe4DFZPCP/akMJDFFyJ+Rx?=
 =?us-ascii?Q?DtFFwnB6caqR4AmK173fSJYUY2k1Eg4giFKm0iJiKtRx8fygZMWsMJiX2HFa?=
 =?us-ascii?Q?iWmXi0Ml0vQHVmNYl5lhWWHXhnfGKvg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a9d45a-7711-43ee-1708-08debefc87e1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 10:08:15.8215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl7hTioPnAufz/YS06fH2g+48A1IL0hPilfktI2MdUdeaQKUp1ecaS9GgBWC5rG6ad6RVTSHOEmkq6aGwEszOiGBYg86zfXCEMdouWxWuvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7536
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
 drivers/net/airoha_eth.c | 43 ++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 84ee9b2ad76..9fc09824d5b 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -365,6 +365,8 @@ static const char * const en7581_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
+static int airoha_switch_mdio_init(struct udevice *dev);
+
 static u32 airoha_rr(void __iomem *base, u32 offset)
 {
 	return readl(base + offset);
@@ -908,10 +910,7 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	if (eth->switch_mdio_dev) {
-		if (!device_probe(eth->switch_mdio_dev))
-			debug("Warning: failed to probe airoha switch mdio\n");
-	}
+	airoha_switch_mdio_init(dev);
 
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
@@ -1202,37 +1201,51 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
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
+static int airoha_switch_mdio_init(struct udevice *dev)
+{
+	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
+	struct airoha_eth *eth = dev_get_priv(dev);
+	ofnode switch_node, mdio_node;
+	int ret;
+
 	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
 		return 0;
 
 	switch_node = ofnode_by_compatible(ofnode_null(),
 					   data->switch_compatible);
 	if (!ofnode_valid(switch_node)) {
-		debug("Warning: missing switch node\n");
-		return 0;
+		debug("Warning: missing airoha switch node\n");
+		return -EINVAL;
 	}
 
 	mdio_node = ofnode_find_subnode(switch_node, "mdio");
 	if (!ofnode_valid(mdio_node)) {
-		debug("Warning: missing mdio node\n");
-		return 0;
+		debug("Warning: missing airoha switch mdio subnode\n");
+		return -EINVAL;
 	}
 
 	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mt7531-mdio",
 					 mdio_node, &eth->switch_mdio_dev);
-	if (ret)
-		debug("Warning: failed to bind mdio controller\n");
+	if (ret) {
+		debug("Warning: failed to bind airoha switch mdio\n");
+		return ret;
+	}
+
+	ret = device_probe(eth->switch_mdio_dev);
+	if (ret) {
+		eth->switch_mdio_dev = NULL;
+		debug("Warning: failed to probe airoha switch mdio\n");
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.53.0

