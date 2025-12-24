Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA9BE75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 472E884280;
	Wed, 24 Dec 2025 09:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="N0LPc/jJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB296841D2; Wed, 24 Dec 2025 09:25:13 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FFB84272
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovliBNPAkNg3G+joubkUH43iLe4Ofmql6oVMAlfetYPeyARI1FAp4+FQHHQYvxPVdAWIttlKb+as/ODgtzqC4XYo5pdWqtQX4bAvLJ8riFgYxBibtwvlPtC9NHYDZOK0c0utAg9d4bkHnFwddENRwSvtg5/5sEudLcSmr+uBhNyNU5aY168PUTcOh5fvxVO2IHMkElKSpK9yw9ftaQoldWuYDC7qabpvYBFDeZtDqZEOoW2Yv4+itsxVcCBqTQc2yzB4T4RwIpT1jjSmZNmDk+SjkOTzqfcBZ2cMzQDHWFEz+ZStzOOU/i6e4J72n2qV20maPmVCnMYLpZFx4xvdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv7MgZ5oe8DX1rJh6M3fGaUoUIpCjeZpNFWB3JT0WpI=;
 b=idaG3AV9rpYIpOvwi08nVEkxWkuu0hqC7631qIP8VDo+HEKVlR2Tm3GL/5tVYoAfV6Gx7bX9vHLn8KW5FT+P51yui9bM3517nRg+xM2iRa5S/WnhOMsattotmtQvt8LSjEGyiD917VkrFG2cKkOca7Fgf0nU9NQg+hlltU5r/RvCNAMgIhRzPtMppFsVt2PcSTqfeVa+5W7wcp+GYqHv1B3JsQhQ6cHONbGYGvL2MjuMiYPEi3kxND0AKQFQ/uy/KrNVkY7K2uH/3YVj7DGcBHcKwNcA/8rtq6PN1FZNc8YirFIcX9fHYRvmhN2hEDBK5mVNBV4RI4LPMVXVa8wbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv7MgZ5oe8DX1rJh6M3fGaUoUIpCjeZpNFWB3JT0WpI=;
 b=N0LPc/jJNe6OVCYzm5S9qCRithRC8r5yZkPUcNA5gcYO7FBdJzw6R12h/nXCIr7veAV/Ehfnb1OPEDxvTsYjH4J6g85/4urZkrxXFOTH9QbOof4X2j8as3sj9O4JABzS2VHPXN7ea3c/pL5/8oUr8s/GV2EMyk5f0ItckvZigV7ZDhAMsnbki18s3yoTIFmwOuf1OD8zc5LA/Zu6zmKyRjkLBCmLjnX14kwOvAdkxRfjIqlUkEGRFfBtqLBNwox76jK//5zviTD9pyBHj+DNxFcQC0kB5USDY5ntJ6xMyawIO8mhbyL0vw12/2u6DXYWd7/Xgg/dBeUK2j/d0Ahxyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6562.eurprd08.prod.outlook.com (2603:10a6:20b:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:25:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:25:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 17/19] net: airoha: use mt7531 mdio for GDM1
Date: Wed, 24 Dec 2025 11:24:07 +0300
Message-ID: <20251224082409.1347373-18-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 362c40fb-f40f-4a37-c43c-08de42c5f420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kasKijzGlzo+OSJAjNDLgooMq411u0ZloGWGIeuFxweu8YmPpyxQpViVpBOm?=
 =?us-ascii?Q?4tIh2NHz5FfH5cw9MJC9R2PFwOqQpAC+lRTDg6MiNjsJFyA0LhysfHwsiz0P?=
 =?us-ascii?Q?GJQz5ltU119I4aAfsxuSOQ3u/p1s9+VhxJ9Ql0unBbos0pAaKl5RtvtwT0HT?=
 =?us-ascii?Q?OVt809Zt6HfnwD6PuQoJcLCkLTON4e4DNrxOuUhIzr+/+NVmRjF/uQ+NN4oG?=
 =?us-ascii?Q?j79cINpzwLHFBrOVz3+Pt7vUoSQxutyfLSN2+FPnowAfz2m9A/UEgtFsBcb0?=
 =?us-ascii?Q?tqrVkyxQVsySdgze5kUY8j4wZtU9/NsHSu68l2ssqTIYlNK7VzCvrCkF1tfA?=
 =?us-ascii?Q?SB6/Ks4arZpnm3seAvnkpMKzlygNzF/ff+QAmTtZXpAyOL9FaoAahuH0BoIW?=
 =?us-ascii?Q?Et++k8nh3MzyZaaz+bHuRd828sxNAr6vrv85bH67QRqhCrYg32SjitQf+m3o?=
 =?us-ascii?Q?Ypjaj5Xj5nCdF3o8wOQD+Z4odgNASY/VwI+fhkYdO5gPbn7VQRmyEQjSAcIg?=
 =?us-ascii?Q?Br6kAy44Sn29x/2wYXBrJpPUtBURanUA/30oApz9KE12ZK6NyIXCKQypARuV?=
 =?us-ascii?Q?c9bzmgUFIvfTy4akijpL8QpUrQfHXXeT7jdBPhQBQoAxh3H0PhS/aO/fRCJV?=
 =?us-ascii?Q?WcCPZxjWG3hSd3ksu4JXbiBVOJwV1jiOYaXdd2EzGLNnzl4TIldBalTEBGDp?=
 =?us-ascii?Q?VyeFyqK+O3AlSK4WzAzeMC5tb2FrNPWY6GaUYDURoW5J5PiKobJmUa6/E+RF?=
 =?us-ascii?Q?LTpt++QmnQ2vgXfgR8z4YBUbSWzwoycDCJ9O3rdMbcJzG4d7Hl8FAlUkAn2P?=
 =?us-ascii?Q?wlSxr+jJGwhVFGDNjnEVjFE8ygJ5f0O382oHZiuvormJzrMxd7WhgSG6mo/b?=
 =?us-ascii?Q?AbQkug8d5dHoEfdo0s5dvOcFzoMuMpWdoTA7kEQygoUX8BqNd1QDzWU+xxL6?=
 =?us-ascii?Q?4VuzV81CblHSPXQMDvHizw4aj8dkbcl0QO5c86PP8PO7HlTyMaxF3bmbW7k6?=
 =?us-ascii?Q?xansd4JXt6+xG4iJcE9ZgZriPQhViFU4dJUwxCApZy1MVw/aX7FVwrdQaAr0?=
 =?us-ascii?Q?mPDPfNHQjLcbWGfdxnPBvclkpkHijPK0z1QMUxkId95xM5ReFG+0MMaaGb3d?=
 =?us-ascii?Q?JeSsm4cqizFIVE+cj+PobTu8f+IlZE+mlNgfpdsdVDBq7/nCoHAYCi9QcPr5?=
 =?us-ascii?Q?E+zhoQOTRDdog6vK0C7OIEZRGthoahxKSFV5kok+yTKaXNSUrznnwk/kkCwi?=
 =?us-ascii?Q?OGPfZ5TNfB1Kq2l8q9xd7r1/lk3GvYmo74RxmgAcX/0GsbB2INLPdq6xcq5S?=
 =?us-ascii?Q?vu6u7xNeH1N0liq0HYsGOMAEI5FRmJ/Kk997zkalMCEpQPiwek2T5ztNw8Df?=
 =?us-ascii?Q?MFuu0Tioztm2oh7Cqm77On1x23u+aEY7Yb8AEcopm/mamCQTGPwwqzLZRxv+?=
 =?us-ascii?Q?1dZrKmUwBfZjTm/ZOj1vjgoEhyJmpL2YIZsiwDFp8qk5YcD9r+v6Zy7ZXbgS?=
 =?us-ascii?Q?kQHQ8Qpp7siMypsGyJ3/qgMtOezpDYqEDPLEOvkj5CZS21GlI4X9Fa7mhQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qTJ9Pofs0ySwqBsJnvj2V3PaxsR/+nqJY9reS6Vvfipx5VfV0+Qcnn1w6LSh?=
 =?us-ascii?Q?/fx8PpiIuY0yCEVl+iDKtUik4R/sELoSpcjsrd/Oy0kKALBmEZVass6jqQOV?=
 =?us-ascii?Q?+x8kE/fodZwvzwOMf/wI1b5aDpeTm8sQa4VEic2WLuN19SsNAzFjB0Yhhlsb?=
 =?us-ascii?Q?q7MbsIzy7+G/1XKH2yj53iQ7JAHvHzfIa3kwOc30h9qoTk4zrlhCGdEMjnkO?=
 =?us-ascii?Q?Gl7XtYeV9zxAnZUmuF4tH9Y1aI5+r/HiGHZtYCkTX1dkSAVfdu44Op++nWK8?=
 =?us-ascii?Q?sSUR4/3W+FQtdj4uSE24rB/cLQ5xjlGMdWhvHrkBSPv4BvdS0vYObhkpx6xE?=
 =?us-ascii?Q?stPmfBhasQB/Hw/xWvQfNY+xvZK0BCga5iFuttGHsmbE+XJNZEn7ESK1GHqm?=
 =?us-ascii?Q?87Ru6PwkVjodss3Igon5PckTRM6ZE6P9o5iOr+NYZbZz5x4LDM5u/pVgSwJP?=
 =?us-ascii?Q?Q4ZeVTYWyCcdYoy1IX2ucIToiidZUKtnh8I9jdTosHp5fWEx1jFIF1ZcYcNF?=
 =?us-ascii?Q?1D0kUnAatAf6KXcpaXNlHrrVx3XrHyxtA5dWa8YKtSZv0ngtSd2gbSkwWM9f?=
 =?us-ascii?Q?1AsSCs7dKr9Xf45zAZ0Nw+rz8nPMJYFW3JnCNtzz9QK3YMQyInKBzNlSAWiv?=
 =?us-ascii?Q?/x+UxRF6couJlRRa6kG28gfV3LXwAv57+oyNGZv37S/4s3quvMIolD7sWGPe?=
 =?us-ascii?Q?dfvvB1ifgrraLd8QlRDJqvOUBq3LwSWgpoO52pNENI8fGrj5eBUKvDEmyI6e?=
 =?us-ascii?Q?hgPV6X7SRzZAM6sIiZAgt4ScAPNTFYClUQWmgEArw1BJnbwlWYrry+AoULvW?=
 =?us-ascii?Q?zkbjCtvTw4gGQOYYHXWfks1iAGPxDmf0fhaiTJKqHH2uNpHjW+iuWrwmfyK8?=
 =?us-ascii?Q?H129JLxmkIzIpYeDssvXCD31s8WoJtZDVLYcf+jFZ+A6jyqpUj6u7xnZFOmK?=
 =?us-ascii?Q?sleju2dyaL6NhlZXOzClJdH2/QzoWFqyNsf07PfQoRDzgyg0tL5R4tC980+y?=
 =?us-ascii?Q?P6+DjjWyU9kLfSjHKvvD8Lsba0hAwKCg1i/YwMA3KtJJucZKVsF7kMMMO5yW?=
 =?us-ascii?Q?eLPVVv/yKkdhwDXMUeJ2o45T0wvQHNYvT89GN0G9byrqRPgr6BHdq3QYgUte?=
 =?us-ascii?Q?2olKB5JU0+2WE4Jz1RXxjdr5VU+uHvZxa6VMzdICQ2M3fKf2SY66zyqxmaZT?=
 =?us-ascii?Q?dR6ltcNYiWk0FtuKf+/CjRFdQCElZKlrIHChXVdQhSWln4BW2hne1aTp+O9t?=
 =?us-ascii?Q?5GzF0W46FWXdKjghT9rr05viPJSs4HP6AxuN3L0qVQ22zQb4woyCI5eM7GZO?=
 =?us-ascii?Q?3PxdiCqFFF8JP/7+WU7qZOzIJfeSq43kBB+scey36QQkpYgZpts+NgQI13sA?=
 =?us-ascii?Q?aqP8IHYOZd+VA+pDX1o+eSPVPJvq486Bwe5BdrDHlCG/pU8oWmkLF+lOaoXS?=
 =?us-ascii?Q?NlyYRPZrg4iyuqWBEY7oGbT0v1M4ujbrmgPoe8G+qP5Pkb3Ho0DHI4LMGiIq?=
 =?us-ascii?Q?U9NCTQa8dg9Po/mHMiH7LjcS+yjMWy56WiQWGEDtQg3TzynusrUn55+3RC0Z?=
 =?us-ascii?Q?xQ5w2S4/nepOhVy1O+PT5bRHrKairUAL3T76GJG98jRKGxrzsBLOrrUwhACr?=
 =?us-ascii?Q?CICcK66PMpOOgKN0hzoYjS43KywwRyadfRSLpXMjXM0unC7uTYOWLQ1GksYP?=
 =?us-ascii?Q?03lD/2gzTitsKnbsUsFYxQN1+P5fYdrVZnHepOFrp0wtPJGQz5UUnKaR+2u1?=
 =?us-ascii?Q?+93/Ia9BiEDbazCGEprCFfYyswmkgyM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 362c40fb-f40f-4a37-c43c-08de42c5f420
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:25:10.7337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzbHLFHf0OXDO5AL9rfPZDBVCBgTiAruOesyaqEFXmTh8ZVRnBLFQtdmL1UNLP3YjSkdlrFrFPTT8kcGAq8AeArNaJE9/SvdugxKEzhhO1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6562
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

Current code just bind mt7531 mdio with it's driver, so mdio device may
not be probed and hense not usable.

This patch
 * use mt7531 mdio for GDM1 port
 * set mdio bus for the GDM port (if corresponding mdio/phydev is available)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 63f57d299ed..d31e44b652d 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -12,6 +12,7 @@
 #include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <dm/lists.h>
+#include <eth_phy.h>
 #include <mapmem.h>
 #include <miiphy.h>
 #include <net.h>
@@ -334,6 +335,7 @@ struct airoha_gdm_port {
 struct airoha_eth {
 	void __iomem *fe_regs;
 	void __iomem *switch_regs;
+	struct udevice *switch_mdio_dev;
 
 	struct reset_ctl_bulk rsts;
 	struct reset_ctl_bulk xsi_rsts;
@@ -941,6 +943,8 @@ static int airoha_eth_port_probe(struct udevice *dev)
 {
 	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
 	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct mdio_perdev_priv *pdata;
+	struct mii_dev *mdio_bus;
 	int ret;
 
 	port->qdma = &eth->qdma[0];
@@ -949,6 +953,7 @@ static int airoha_eth_port_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	mdio_bus = NULL;
 	if (port->id > 1) {
 #if defined(CONFIG_PCS_AIROHA)
 		ret = airoha_pcs_init(dev);
@@ -956,11 +961,24 @@ static int airoha_eth_port_probe(struct udevice *dev)
 			return ret;
 
 		port->phydev = dm_eth_phy_connect(dev);
+		if (port->phydev)
+			mdio_bus = port->phydev->bus;
 #else
 		return -EINVAL;
 #endif
+	} else {
+		if (eth->switch_mdio_dev &&
+		    !device_probe(eth->switch_mdio_dev)) {
+			pdata = dev_get_uclass_priv(eth->switch_mdio_dev);
+			mdio_bus = pdata->mii_bus;
+		}
 	}
 
+#ifdef CONFIG_DM_ETH_PHY
+	if (!IS_ERR_OR_NULL(mdio_bus))
+		eth_phy_set_mdio_bus(dev, mdio_bus);
+#endif
+
 	return 0;
 }
 
@@ -1205,8 +1223,10 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 static int airoha_eth_bind(struct udevice *dev)
 {
 	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
+	struct airoha_eth *eth = dev_get_priv(dev);
 	ofnode switch_node, mdio_node;
-	struct udevice *mdio_dev;
+	const char *name;
+	char *mdio_name;
 	int ret;
 
 	/*
@@ -1231,10 +1251,22 @@ static int airoha_eth_bind(struct udevice *dev)
 		return 0;
 	}
 
-	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mdio",
-					 mdio_node, &mdio_dev);
-	if (ret)
+	name = strchr(data->switch_compatible, ',');
+	name = name ? name + 1 : data->switch_compatible;
+	mdio_name = malloc(strlen(name) + strlen("-mdio") + 1);
+	if (!mdio_name) {
+		debug("Warning: no memory for mdio bus name\n");
+		return 0;
+	}
+
+	sprintf(mdio_name, "%s-mdio", name);
+	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", mdio_name,
+					 mdio_node, &eth->switch_mdio_dev);
+	if (ret) {
 		debug("Warning: failed to bind mdio controller\n");
+		free(mdio_name);
+		return 0;
+	}
 
 	return 0;
 }
-- 
2.51.0

