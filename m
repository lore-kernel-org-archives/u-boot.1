Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43989D1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020138403F;
	Thu,  4 Dec 2025 05:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="b7gXf7C5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C30983FAF; Thu,  4 Dec 2025 05:15:10 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55CC484011
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E28vf6cxyPiKY9CjVUiy8VPVNqf4PsjOSo1I/ib9I3vsYdqktNU9sX5jvcnsS2PvPro3HmgQ0h6Lc/p/hIiSE0pGp7ZDQ5rqb/jy+yImnHUN4dX7n31HFrM61nYTlqxA6+SUJeuuyJBm5eibSefmPlhoq/GF+jn9XXHDJXAGOP/R+iu5MWtOysL93rizdVufH2yaOhGv9F4ofP23/pUwhDup+COQlLkmajBKSJkuMx4Q2QeVyWDrnB8K+9Bba5LkTOg5mvCP7AOIAdTLhT8/I1clkxr7zf2Fo5rA4gdCTS5JB+85Np6V8YaBo4wv8z2riX8pBkPh+gRvpEZ+hS8wMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSpsCxdMKIJ1IQsJncxTLv67hANK4apnzzW0gFSOou4=;
 b=AwbFlXcgy0xkbQtLskXEss1nxlVsyVzZcNXq+9UhISroRyLWv446NmJ4PtXY9UrRAliOhV9pp8w8So3HC7Lgdu2a5yF4bzxnL97gK7z/UpMxAFxyfbjKIvKNwlmbZMJA0Rm4dSAH5wwg3tYswqwNxAwCktJCuIL8YN21q/0YL/701WKk4EU8idsmMTBNr3aqudvlRZSEDf3ayRgByCgOgoiBgiVVX9R9npEkzIqWAxCDbi8+REuwxurbRsFpp8OcwyMBovAOfkUKvJf9AXZTRfGx/WfpSAcV0nGypJzEWGmwPw/WVQkZdejDkHj0SVY9xMW0I2GSs2q3fllSWPrlnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSpsCxdMKIJ1IQsJncxTLv67hANK4apnzzW0gFSOou4=;
 b=b7gXf7C5j83kJo7aQOe+LYWsgKtBsRvw9dJMBGMpWrKmgriFgie6nX7me6rLHufAzRpgUoKA72CIWvM4QYX68Z1SH3t125A0mXuDjjkKMA/Lelj9SQgxRwZP7MVyDVdVwED3HcRZD/mJZki/UkH5YumvuRVA+CkH9CcWLoS5zB/CeU6wYVa0zWfYk2WIm01OHhbeJDqFTk4D+Zlj0YC+J8XL8AFZNz60gouKpstzZwPM1sU4+Inpz5WTzFnXGW5zOOMUH7DGW4uAgJTjpsBkpUQIozeBkqE2TlnDrZq6IvjMLsHplrdLuo+fHqFYG150dyyaQoJ7UnWvnoLoUlicwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11134.eurprd08.prod.outlook.com (2603:10a6:800:250::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 4 Dec
 2025 04:15:06 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:15:06 +0000
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
Subject: [PATCH 16/19] net: airoha: bind MDIO controller on Ethernet load
Date: Thu,  4 Dec 2025 07:14:30 +0300
Message-ID: <20251204041433.3459826-17-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 0e05be17-243b-4050-f16c-08de32ebb492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AyShvLsaWB/fcNRD+lDod5Zlnonyvu4IwVyUhcaKCYvefbFCA+/4WQPCCu34?=
 =?us-ascii?Q?wzchHhwNM6+NyownI7vTQ5sBShuMeCpgypQc7WDKTITfkypsE4umqh1XA69+?=
 =?us-ascii?Q?MoAJ1kFEjW3dn3g14jduhH37UMRoM+etNzOW+yd43b/1HyIcLUtxn85VrjZp?=
 =?us-ascii?Q?Jo3LalrImmLKELlRw/tgUdXkP3/UQYjBft5jJfEueJMarRfxWkYz1uVDB7Ue?=
 =?us-ascii?Q?jJFsebrbgpoRf7gdBFLjVH5XdDcLMKn4/TqceGIQpVNH7sMWGSOhGEMw3scP?=
 =?us-ascii?Q?eCL4RNM+q2NNIiInPFNfQhpqi+o7jKk6MKEwCqCfo25nNJsGOM4kzB9wMWvl?=
 =?us-ascii?Q?8lecRCDWpDBX70r1SF382+ikvBDfdalkdEU6xlikwIDo2+8p0/OuSVTc6W8K?=
 =?us-ascii?Q?doObge8jCCs1NuYdbvjbI7/or/FXJ98O4ar9HEnghOpBa1XVr63mYBU4rBII?=
 =?us-ascii?Q?pBiZ/zQl64iGGI/8+tG9+l34aqlKl3fRfd6KNKD9+G0bgSNJkSAhEECKqbb4?=
 =?us-ascii?Q?YR8JFl8fO/yFvh0Rrd1YXxiQgxfljM+AmkmgsQ5TqctFYjWUBU9Rw/PDiaV6?=
 =?us-ascii?Q?DDQUvkFrXM1oqUE7OeDfC8CqPKNYkkHhqDFctppkm6pQWsk3pPaHcvoWdAaX?=
 =?us-ascii?Q?KpIvxxhS8dO7lcH6e2grXlu22hCK6V5m1s6JJZtjLbvjqVuqI1jEFYQeKyrZ?=
 =?us-ascii?Q?AZK65CyZHx2QXIgLu8UfFE1iYXWzs+mVFxLUvo5Gh7RhXHe6Q/xNXhNbIDbX?=
 =?us-ascii?Q?YAorlTc8FlYu9c7FKoI8A1Bovg4h7N+ibyeNQ7mUARmBkdYBuRYNYs4rDcf4?=
 =?us-ascii?Q?Wp5GAarYrTJTNRqNhTp/Yk5HGOPsYFU4X/y8yr821cEIRDGeQBkLE09a9JgL?=
 =?us-ascii?Q?AAZuvQ3z+2VDUX6ypuM5ilKBoi8UXvntCPoTTGXxP5h/OiRvPIn7cgJE0EIq?=
 =?us-ascii?Q?P8GN4+1+pKsB0s+xYSxU5Lm87+ikjTo/6uMGP+0K1kc9TAPYK0G9XKQNywp8?=
 =?us-ascii?Q?0m4F7UqnhEEUe/jN8xGKvxz7AleSA8lfO5V9jfDFxa3NdL/FwjhmhDXwEW4J?=
 =?us-ascii?Q?5sQ3GtWEJYTNBvYL70reiBCOTXLwVqB184yQ0jAKBDuQkBnBSP1lQtIPMvri?=
 =?us-ascii?Q?e2BOEDM7/iSJ9adbuIbTMIlOfmFktr+nx56mQrYSr+0Bd0h5eJzEB6yBaFNo?=
 =?us-ascii?Q?GQnPCyvS86q+wvf11whXGxLGisCQ1v9YKm8D8DQYGYmbw6rMqjK7UCk7Y2DO?=
 =?us-ascii?Q?FkI9tI7VeGc9eLCRvO6ch03jOO3Dzuah3c0RQLckUtZyVRK13N8RsJxrFD2i?=
 =?us-ascii?Q?iLit8ljbhuy3G96SWXAxezFn/2MMDB3g9BDsDrp84gsBRhTdjgxrEermhqhJ?=
 =?us-ascii?Q?TGh/M0/M8hrZdAIDBrKFtGflBXlBH3UCMFwHKB4MStou3G+WMmUX6Aas63HK?=
 =?us-ascii?Q?21mvuCPN0+DkixIJdq+YP+kHp7qlCigCByZD9qs1LUTClDUeR6CpBLKHqtCt?=
 =?us-ascii?Q?S6YYnUz0JxL9qzCAHDWwbsfTMPEi35emPS96wblKD+ng6G++IHCs/LeSiA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IgQLk/mexZ3wPPNWS0RYRcYgKUJqgU2bBR7bRfaYwbldbLa0Wdjgk489ikvE?=
 =?us-ascii?Q?hLZABc6OW84TX7lmrrR5cIZmVRrEPd08V8uriBdrcZvdhIW/uCGMW0XFIa/O?=
 =?us-ascii?Q?6MsMqi20C8+IF6fLRN1JNjxQ5jvEKFJHz/M5fii5/ljKavO+XQcaJvAosqmK?=
 =?us-ascii?Q?O5m/lMIl4WInzLLRmvSivoSoNqq3bc/S70yW5IpBcb7nhxVNBBYITNor+XoL?=
 =?us-ascii?Q?DtoecvI04JGxRqrPS4Cv2NGgZ8GfVttXLZlFy3du83Za1/6+dm4SeX8+/SZC?=
 =?us-ascii?Q?P7bPMT+jIXy2tcOl4wkC25Tws2a27Zlr4wZOf6em/vGhjjsvjZSMDLNi/yQv?=
 =?us-ascii?Q?eOYKMjZvggkDLeAIRSF5lWplJkESU8hl7BT37mdM/vKPrDjkxC+LnP7jr+ys?=
 =?us-ascii?Q?UD+WHthmKqLPFiYwO9RMVAqXLuLrZnI6ZFWkUOw4dBsoz7TzBHhn7urLPO1d?=
 =?us-ascii?Q?hQXMr1GPA6xhj0zSLcCHcAzzMYOPq42CWNNywHbUoV0n2UlMHX27n8tho8XJ?=
 =?us-ascii?Q?jfufd3ZGngX7CVwGE0U41kFL5K5om+lUIC29Kei04W3ILmIg7EERvttZUKOC?=
 =?us-ascii?Q?b9ff30xJBfQMJKOAaTETRUHmdZzRonfgSDrv5EO3mthmJdbP2TGrb82xOzrR?=
 =?us-ascii?Q?tZDsOmVcviBqZ2UNCCPfWN7Px4T5aCAIqqQigC9ybKWwEOj0mFzyvpgCSUNZ?=
 =?us-ascii?Q?6ox4hZYlrDD0cODkM2opfUrDXmBXTZWq3WF8zYRsYgB3fI8Fopaib8Y1Iv4i?=
 =?us-ascii?Q?qJ7i+F5C1P3iyYWUS6MMJ7FTSGpmCnyRhfrCy4lQOIQEKefbn4p6q18dehGS?=
 =?us-ascii?Q?wj3YyvY0PjXt29Rj5vCp8VRArMJ8iCkAiDgipgeNxqnVC2nOnIvBMDSV6ftT?=
 =?us-ascii?Q?np+XJYppWUz5Pl27bSBjDwlyRv2PpIcROgSHoWhoxGcHG7l0PpfbbtmLfngV?=
 =?us-ascii?Q?5eYO22rLLFMg9mTRlbbpoMSAZ1Rd6tNDq/9ALOLL8aEGK0OFBygvZb9BG+Uu?=
 =?us-ascii?Q?LG/m5GKZ/xyk7vzhyVU/uMumUj7iqqfRB+O98AbWxj1dz4zXcAqEchxUuV2a?=
 =?us-ascii?Q?KP/kJlK41KSAogylivD6Goo5H0wKR2xJuD/OzOTyhIkUcB4HqmYF8aMMifBC?=
 =?us-ascii?Q?232jmtV82hxadsfHNf2oP2BTKwNvaHxSvLJbtlmRE6WxJLa0oYGXQwjhlk7I?=
 =?us-ascii?Q?2Ct3NxYvo61w9PUM35krrpzBpyxAkmGRoNdzgr8LOnWsw8Wa5RqtoKVmOrq7?=
 =?us-ascii?Q?qrKflRshkxkD5+rRW+1Rpo5cOd4IhKx6qCsAtFpFtIys1NuH45cEhWp+F1uK?=
 =?us-ascii?Q?sHv2A2pIj/cmY3sfVgwWHSn/Qw0GUGYWAWy2JmQu+Xht7qNmFhTMtqzvW/b/?=
 =?us-ascii?Q?YDu4p5q0Xfgxl9at/bs6vbTDs9QH5vJu854CJIGtCnM7vn/DLLNaFe12d+ts?=
 =?us-ascii?Q?zD4gzh+FSELMOydYnvhHXlUegFMtcdf/GSd3pnXDxob84sAE6+dZlaP/oDXi?=
 =?us-ascii?Q?0SLZot45djxQsKheUaL/P5qWygyz20TIxw81c0jGiPmmYPZc5xuYDFQynbcb?=
 =?us-ascii?Q?rHtiIlvfZqs8y/SZye1wwpmK8OtNZNwHu2IdW5uOJtCvGxroZ0xbdwPKDfDr?=
 =?us-ascii?Q?OP+UIpkdSY/CWh/MjgmJAzE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e05be17-243b-4050-f16c-08de32ebb492
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:15:06.3012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjsU0a9DfLPF1OdMwQJOOlmQoIM7Yooe+xxMbuQwkbEcXJlK4vbiZS+zIHSk03BFJFIHCJYGas53Xg66JBDhNIvw8wR0QKKm2pWOpGjr8Ew=
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

Bind MDIO controller on Ethernet Controller load. The Airoha AN7581 SoC
have an integrated Switch based on MT7531 (or more saying MT7988).

Attach it to the switch node to support scanning for MDIO devices on the
BUS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1356ca36722..943305155c4 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -130,6 +130,7 @@ config AIROHA_ETH
 	select PHYLIB
 	select DM_ETH_PHY
 	select DM_RESET
+	select MDIO_MT7531_MMIO
 	help
 	  This Driver support Airoha Ethernet QDMA Driver
 	  Say Y to enable support for the Airoha Ethernet QDMA.
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index a0644f63366..63f57d299ed 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/devres.h>
+#include <dm/lists.h>
 #include <mapmem.h>
 #include <miiphy.h>
 #include <net.h>
@@ -1203,12 +1204,38 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
 static int airoha_eth_bind(struct udevice *dev)
 {
+	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
+	ofnode switch_node, mdio_node;
+	struct udevice *mdio_dev;
+	int ret;
+
 	/*
 	 * Force Probe as we set the Main ETH driver as misc
 	 * to register multiple eth port for each GDM
 	 */
 	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
+	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
+		return 0;
+
+	switch_node = ofnode_by_compatible(ofnode_null(),
+					   data->switch_compatible);
+	if (!ofnode_valid(switch_node)) {
+		debug("Warning: missing switch node\n");
+		return 0;
+	}
+
+	mdio_node = ofnode_find_subnode(switch_node, "mdio");
+	if (!ofnode_valid(mdio_node)) {
+		debug("Warning: missing mdio node\n");
+		return 0;
+	}
+
+	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mdio",
+					 mdio_node, &mdio_dev);
+	if (ret)
+		debug("Warning: failed to bind mdio controller\n");
+
 	return 0;
 }
 
-- 
2.51.0

