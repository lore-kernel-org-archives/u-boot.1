Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5242FD1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E8CE83FEE;
	Thu,  4 Dec 2025 05:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UgSTaw42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8994B8402F; Thu,  4 Dec 2025 05:15:09 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3521B8405C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibZfakH6lnmFUmj7lhOt4UB6xzSUyiDV/7/toTW3XKZeNTHargoMdU3dBw0dvHJVtt9OrF+H2rVC5gpWvnMUzwdJGGqBF5rr9iRBUtx0GoHSP/ZQeI8VH6Hluhj/rSws7IZ7MOBsXjSnrGnSxL6hfvmkbF33ahZsRl/UdWgDeqvDZspFIXzxqq5NSV7BJcGEXewx7wohrifsKWwRAnRfcH1Rd+sXSnufmgXaXKfcJYLZDkfE4T1dJdMgQdhd8CACcsehHZYl/fTnXrNJEnvzDG9iYFAaT5uSGqxaifUs/sqOWn3uPx+bsFhadSDmcVWCSFaPeZC5SlNu45IoObnpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NonnEcqCVse5I+Is+wgt48heTlYcqZN2cPOnTPxxYik=;
 b=vryjTLn2KenXtYGeMD2l9bG1hSnptMOC/g/GxjyHxbkD5EugPRETw2uc+CDC3cuz902SlykN/nt89/ONL9xGluYWXVhnM+w9Ovfqf8jrHR+IePxbShdh7RDH2161OpzZBivrOQGVFImwuL+jgq+DigUTUHqLSIahO3pQNKiOLOjfUYmwgJZFdMFfLvt3GBz7ceQYk9a/lo+lv5rpGuLK5yjBAxm02ZYc1WtCDPE9f0oc9/gEQC8O5j3umJBzF27WBKhfg3Ea1chJGW8hpil09KBo8S0mBtCYwOu+Mkh3A2yDIIHPd1TgQs+ypenCcDviIbR90gby4c0f2rR520jsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NonnEcqCVse5I+Is+wgt48heTlYcqZN2cPOnTPxxYik=;
 b=UgSTaw42NBhwSoG5iQhj/lQBpDAsKRU2PGEDESaWCKUWrUzeWVKfl6gJRtvFaVIvisoC4ysqW7O8hFpy7H20omfpU6517IUM8t0hGVs/o12CxHFmF6B3ssOHELy9eIlzpgSo88W73mWLlMEgi3PMTsbJ5iTsbm1JasDF88QP0NE2EluGtkPnz591Zph5gTDbbi11xgvsyE/FC1SK3fbwh7/hidHQXkkGhuAoyP/QNLE/GQB3zIa54fdjDUuhCH9TE5BOXcIGaBOx58tC7kdOroldhC4uKkQLOrAtx15Z2X2dDtQ8RuI4PltGSmWu55d6RCbHOFAOrP9kYaO9ZaGw9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11134.eurprd08.prod.outlook.com (2603:10a6:800:250::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 4 Dec
 2025 04:15:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:15:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 14/19] net: airoha: fill in support for PCS/PHY in Airoha
 Ethernet driver
Date: Thu,  4 Dec 2025 07:14:28 +0300
Message-ID: <20251204041433.3459826-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11134:EE_
X-MS-Office365-Filtering-Correlation-Id: b73fb697-342a-4c34-5a78-08de32ebb2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GNIwjvLwnrIQHXXCeICV17QIpaYfR14ao0WSdnygzmMGWraJ32QJCAWECxGA?=
 =?us-ascii?Q?HIc9ZBvDONan1Lxh+kSZ03ythpQ9tLyAF7txLmhwbms+tj7l6ZoUjnz8odTE?=
 =?us-ascii?Q?F1m1uo9Z85RcBPHqneuAAniKwaoiEo/DIWIO3DeEJR3RL6YP2LkboYeR+BLY?=
 =?us-ascii?Q?ZtJKQU8Neq8DZUYFDdKqIR257rwsBhSiwpmsk/MLCrLfEFjIhF2ZF9wrUNEV?=
 =?us-ascii?Q?XDEup6mT4ko3tz3NrkezBZBaf7bCNzbQOB0LeaYc3ut8ls814jrDu/YiO5N1?=
 =?us-ascii?Q?D72JSkEkfwIC+1liYOkuDAuHFe98pYqBo57f8wRGykpWMJSW+duHiN5k07O9?=
 =?us-ascii?Q?SUD2oerss/XVKy2Qy0DJYc2AHLQoVf3aakoAVNmoDtNLQWLGd1DGVQMjTc15?=
 =?us-ascii?Q?62I74xtDdrHC3EYMNwHJegB+uOBTxgP4rRR7/QodafACA00aktmOQUxgYJrx?=
 =?us-ascii?Q?sawhdSVMN3GAtLEX0p7w3b+k+XBrbKRh4dZ/xNcOw4fUJ9O5hsPTPVWOwlCf?=
 =?us-ascii?Q?d1iIL8SNrEWohkFEUkmO8iHGxPFdSs7TvmIeTi6dweu9PGT0WKXNFLmypNyf?=
 =?us-ascii?Q?fJTsmCc/DJ0iNnqHOeE6kj9yN1Lr6fV4FvH1nKDnWmmtPFNB4oOktHoXpA9V?=
 =?us-ascii?Q?lgAjFeF807eSqoRloHupOHcOLKJn3kZIdTgwNP8eYNoeso98TSCG4pQPQEye?=
 =?us-ascii?Q?VpUa3jEDg71PBMuxQkKsZa5UanmqpgqLyJ2vd66UgIbwwqR5PejMurlA5b82?=
 =?us-ascii?Q?nECJtG+pRZKIb+Ls8UlX6cb7BX8ndMSG7RAWrD0jDJ4oeMBh9Fjp+JY9xO1l?=
 =?us-ascii?Q?0ceccWTTAlgnFxxe7Z4/6FjU/LRs0pkGah7lRCsmkjfKpRO+/pPgCQ5mwH2h?=
 =?us-ascii?Q?VuDq1yPrkORXOUX2pp75nvMz6h/w8MkB4zJSAdph8+TGumhq9/ZlJU+VyD/i?=
 =?us-ascii?Q?5xdB1W3vIVJzZRmOSFRc2YedG0IHRhXM2v9Sj648i6mDdtyr6lO4uK0RVE86?=
 =?us-ascii?Q?au5/nCvvH3VVLkqzbbnL1MGIHMsWgkxPriDXui1InWCWQYHWHHQ5aUp0Oyhl?=
 =?us-ascii?Q?o1U+udl7tA4Z+U4Xc/Jdxbj9UTQ1G6xLxkuAz9jfw7KyUNXgMOGaSCUr/0C6?=
 =?us-ascii?Q?NuAdaclz5WmaLpzuj59i7SSBxDNNtHNOAnmhjhPilVddrSOe3gFZ2OBShNOc?=
 =?us-ascii?Q?EuaK74tfw7Xn+3i49upLgw2C0vG/CunkLjoFh96lqswFeXksuz9AY7x/IH5G?=
 =?us-ascii?Q?PKT0ZX1jysSDxQhtqymo1YatpPslHJHYF76OoqjNA8W3jlRvF0+08b/lZG+I?=
 =?us-ascii?Q?1EcrUeqTNaQ7OpQQC4Fyhj/qOZEQFaftLrnP35fvTwD0zrBEC2FpYNTNig83?=
 =?us-ascii?Q?AXsB7f37UuNCE8N9KuVubur6Inj1W2Qn+9qWtf5R/TrK4tlCDoYGEKjIG1Xm?=
 =?us-ascii?Q?2lAp1aLrmN4MbbVInuzYHYHu3kEHUhbfk229fN+JzxWypWcvQeFP1q3XNzv9?=
 =?us-ascii?Q?7yjSMWxGnaIoH7Gym7B2086qmwrAlRkNyJQcnxz/F28atf2j4eU6cC+ZLg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KIurwjfynfHuu52EKKipOBKnEyKS3w19VUqjnomgLmajs2UlzYSaLQknszKQ?=
 =?us-ascii?Q?XoStz4fUj8yhWPkKdW4KyO7fl0jSV6LVPxq43pWngYL1uDUS/XQs9UcEGKQg?=
 =?us-ascii?Q?QSLVRBbdKQWyaHfd6fGzGu1eGY+71VnYRF85WfXeZ6nTce3aWomIKtjmYBmz?=
 =?us-ascii?Q?lFHZ4u7I2ND58m2RvpiQqsRiWgq6BjCWCM6JG2Pz4Zzcxm2kVX6nw+qo/OXt?=
 =?us-ascii?Q?f3FfaKHIstMNLbJnZIoM2crwd3XFUZxbQyxbcRPnfH1TKLgZgxpfqPFAyjao?=
 =?us-ascii?Q?1OCiZuo3DjIj/0He4muDiaN4cY2GLl9i/KF0viSztLwWy1Ag33pqN//j7+vS?=
 =?us-ascii?Q?cduoCleTQYOfgAfeeybmncDojY6VGoTRzDoCB7qJ0K9T5z4JG3MRE1BEMohv?=
 =?us-ascii?Q?WQi/S+oArD9AS3erH1tzvMirDhmxqzWjKnpxi1jPEKnjpvjU03lmiUdkJfI6?=
 =?us-ascii?Q?qLghlsLZOyupIgBcWdhuV6281594Zj3seuRU7ZIfgZ5uNr5taQ6V1nkb+SwR?=
 =?us-ascii?Q?iv25fWCTKUBXbLQI5Ymd3xiZeUQJ9CvFAfJ8yYvdBuPwMlu1U+Ga7Sapmq96?=
 =?us-ascii?Q?itoXTW9n7WlT1RdYD38R46kJRpFTIyF3i5PQKflWxdm12M+GDVRHj4Eqz5ey?=
 =?us-ascii?Q?aiPPMmOGNKVmmSgbqWMoO/gaQWnvIQQXcRx5kqCdeXK6hjmOnnJhmD0Wvw4P?=
 =?us-ascii?Q?s/dAFLNpt0uL8CSpthycH0/f4ysX3D77Lp1sQ7jR6uvaOgaWrk6O4YtWm6ma?=
 =?us-ascii?Q?DSZlBAhnlG1jAQBSC2Yfi+1JWiBSjYM3C1AC1YFM8HzPll4LcRnH2RYtHnux?=
 =?us-ascii?Q?mTuM8Yg1gp23OjcxfXnWlCqfa2cv8gfM89q64CowwkuyeL4drxO0BywrVNTz?=
 =?us-ascii?Q?r4Ej/Yg7gxEZXfOZsEJ1lNMn/gK0uWabiIg3Kmo/vsUYXhr10wUTWRzkmea9?=
 =?us-ascii?Q?JZ+cOciCjpEFIEGzFK5o43asRaNGn5UEdgciqOVJ5KtGbY6uaXdIjJ7tS5cU?=
 =?us-ascii?Q?XecTzr3rAMehPMtYcuzqY38trcQ1MeFaBdsQ1KyDbfaCp3K/9pg7z37oqe5A?=
 =?us-ascii?Q?QjVrpxot1Na13+LJ9Gv/M8qCVtVj4bFa15ehAQqie1gbQXqLb0aG9ackldqU?=
 =?us-ascii?Q?e+deUAqHnXIHOft0kqZ1OXd1d+qJ53cHDP79Hasnf4wFjDOnvBXPPQcFBMQ9?=
 =?us-ascii?Q?lRjZNzRN/ldTIfhkWdcvyIQs2f/RmKjDKaF5G48jo7DdZTkM6I338OSEN1ta?=
 =?us-ascii?Q?dC9clomiz/DmagfwwgTtBHjpU9mxnJlOhYVfkRzPTlha12LtHBy6/gnbs2dg?=
 =?us-ascii?Q?8bq6QngHyOMLcdk7pPp5RNsXgPUVdLiDqv9QJeDpojgUSRQOXJ4CKq0HJZhd?=
 =?us-ascii?Q?t7yuv1padFrAvIs+kEwJKMdkE1+ihMd22bbLg06me1NLnDwfF/gXfq7QVKMt?=
 =?us-ascii?Q?XgjAqB8sy3BFIp5boaAVn5kL9KVV1UgX/ZJqg3MmS8DqoIH557Q5NK4x9bu8?=
 =?us-ascii?Q?hY1qBYfieufwyK5MYsYG1qpb2JaKtTfXOyioHB6HcS7LjBRo6qPG76O7dwao?=
 =?us-ascii?Q?ImJEbp6HQ5a5hax41LYqEnBi/5KyL/KoYKv5MtRBobmgbBRiPIg91uf/0wWU?=
 =?us-ascii?Q?XZj260ZypEXc9thL16wI+W0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b73fb697-342a-4c34-5a78-08de32ebb2e9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:15:03.5210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3V0snlLQBMWlJidHNRGbaniv8LOsa6jhdQDJpT3LqDOEdG//Glb03or0zz+kutxCK5fHHjsqIr9VqCo1RpTnD9+k3dlSaWx6/WIzSEa8iBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11134
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

From: Christian Marangi <ansuelsmth@gmail.com>

Add required changes to call PCS function to configure the Serdes Port.
The Ethernet driver is adapted following Upstream Kernel node structure.

Function calling order is the same of Phylink upstream kernel.

With the PCS support, also add support for attaching PHY. With
"in-band-status" set in DT for the managed property, a rudimental
support for SFP module is present.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 99 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 26a292362c0..e300ff3bd52 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -127,6 +127,7 @@ config AIROHA_ETH
 	bool "Airoha Ethernet QDMA Driver"
 	depends on ARCH_AIROHA
 	select PHYLIB
+	select DM_ETH_PHY
 	select DM_RESET
 	help
 	  This Driver support Airoha Ethernet QDMA Driver
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 7f984f56dc8..f773318fe14 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -12,6 +12,7 @@
 #include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <mapmem.h>
+#include <miiphy.h>
 #include <net.h>
 #include <regmap.h>
 #include <reset.h>
@@ -19,11 +20,14 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/time.h>
 #include <asm/arch/scu-regmap.h>
 
+#include "airoha/pcs-airoha.h"
+
 #define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_QDMA		1
 #define AIROHA_MAX_NUM_RSTS		3
@@ -318,6 +322,12 @@ struct airoha_qdma {
 struct airoha_gdm_port {
 	struct airoha_qdma *qdma;
 	int id;
+
+	struct udevice *pcs_dev;
+	phy_interface_t mode;
+	bool neg_mode;
+
+	struct phy_device *phydev;
 };
 
 struct airoha_eth {
@@ -692,6 +702,34 @@ static int airoha_qdma_init(struct udevice *dev,
 	return airoha_qdma_hw_init(qdma);
 }
 
+static int airoha_pcs_init(struct udevice *dev)
+{
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct udevice *pcs_dev;
+	const char *managed;
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_MISC, dev, "pcs",
+					   &pcs_dev);
+	if (ret || !pcs_dev)
+		return ret;
+
+	port->pcs_dev = pcs_dev;
+	port->mode = dev_read_phy_mode(dev);
+	managed = dev_read_string(dev, "managed");
+	port->neg_mode = !strncmp(managed, "in-band-status",
+				  sizeof("in-band-status"));
+
+	airoha_pcs_pre_config(pcs_dev, port->mode);
+
+	ret = airoha_pcs_post_config(pcs_dev, port->mode);
+	if (ret)
+		return ret;
+
+	return airoha_pcs_config(pcs_dev, port->neg_mode,
+				 port->mode, NULL, true);
+}
+
 static int airoha_hw_init(struct udevice *dev,
 			  struct airoha_eth *eth)
 {
@@ -712,6 +750,10 @@ static int airoha_hw_init(struct udevice *dev,
 	if (ret)
 		return ret;
 
+	ret = reset_deassert_bulk(&eth->xsi_rsts);
+	if (ret)
+		return ret;
+
 	mdelay(20);
 
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
@@ -891,6 +933,7 @@ static int airoha_eth_port_probe(struct udevice *dev)
 {
 	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
 	struct airoha_gdm_port *port = dev_get_priv(dev);
+	int ret;
 
 	port->qdma = &eth->qdma[0];
 
@@ -898,6 +941,14 @@ static int airoha_eth_port_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (port->id > 1) {
+		ret = airoha_pcs_init(dev);
+		if (ret)
+			return ret;
+
+		port->phydev = dm_eth_phy_connect(dev);
+	}
+
 	return 0;
 }
 
@@ -917,6 +968,47 @@ static int airoha_eth_init(struct udevice *dev)
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
 
+	if (port->id > 1) {
+		struct phy_device *phydev = port->phydev;
+		int speed, duplex;
+		int ret;
+
+		if (phydev) {
+			ret = phy_config(phydev);
+			if (ret)
+				return ret;
+
+			ret = phy_startup(phydev);
+			if (ret)
+				return ret;
+
+			speed = phydev->speed;
+			duplex = phydev->duplex;
+		} else {
+			duplex = DUPLEX_FULL;
+
+			/* Hardcode speed for linkup */
+			switch (port->mode) {
+			case PHY_INTERFACE_MODE_USXGMII:
+			case PHY_INTERFACE_MODE_10GBASER:
+				speed = SPEED_10000;
+				break;
+			case PHY_INTERFACE_MODE_2500BASEX:
+				speed = SPEED_2500;
+				break;
+			case PHY_INTERFACE_MODE_SGMII:
+			case PHY_INTERFACE_MODE_1000BASEX:
+				speed = SPEED_1000;
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+
+		airoha_pcs_link_up(port->pcs_dev, port->neg_mode, port->mode,
+				   speed, duplex);
+	}
+
 	return 0;
 }
 
@@ -925,6 +1017,13 @@ static void airoha_eth_stop(struct udevice *dev)
 	struct airoha_gdm_port *port = dev_get_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 
+	if (port->id > 1) {
+		if (port->phydev)
+			phy_shutdown(port->phydev);
+
+		airoha_pcs_link_down(port->pcs_dev);
+	}
+
 	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
 			  GLOBAL_CFG_RX_DMA_EN_MASK);
-- 
2.51.0

