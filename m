Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C822C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 09:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F4F884AC;
	Wed, 31 Jul 2024 11:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QJ+isgRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EADE83333; Wed, 31 Jul 2024 11:21:53 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02876889E9
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 11:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuh5/vxATDlt514uLlDcEBF73Vttnqq8tp9+I2pp2pq4BuSG3zd8jvWFPF+kQOgLWF95I9EmtIaqDGEiUzBYad7fHzrxBaCTX1ee5FW2Bp60r5Srywx6r2EcNVCxyG6+QvaDmsTcFcWf+2eJ+H+ssiyj1acZ7qXmyo2Vj+dij/HyE8izxaQTWUXsNz4nKrKhxfMI7uzlBqSkAR5NGhbaIGbHQORPOlcknQdQ5C4x0l1HHpqG8XVCAJf8BVub0ijWBDZRhwzhTWx25fCOtN0Hhg3HJKCWHVU2u6eccy/zl+n1j1D8r+7gtOCXoZIAERebN0a7OrddCjkvPVT6aJQ6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwt1UxjoWc7Rg7yveFvfmlE+diEXxPenAePMRF8spy0=;
 b=bacM0ZOYWdsXUETGmknYc33MGqpB8QRjN46KwDR2XraWH56QTLt6wq7vOsLWpmqbyc9j9u0ftpH0W9fxoDb9kdnypsk44iN8WRweFDJ7Y9o+YoONmnJd41IW1vOAJKwHSVTnunHAt2BAOSrDnrqMqHsB+ErKRsU8oPDjpjgzn17CDRU5FqxNSGxEvHrk1kiIlNy9OwzYG9PcMKB+/JlfmJ2rvLINFQqjl9bTbK1sLux2o4dYMIImmnVcR55Bbr99NHyXlHUSKz/VSc1XT58jX09lgoFEPtqrkCc4inkg4lPwQtCAyYXg6OLHT7I+xIe18N1aMTZwsmAXj5tlDwscqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwt1UxjoWc7Rg7yveFvfmlE+diEXxPenAePMRF8spy0=;
 b=QJ+isgRjKm3GIV4YX2g9JJ+nIdB3f9nrR99/kmpMlgJMngU/ardqw7JYJD6IKI3kxRBl7iJsqf5Oo0vTFxLCM2Dmj/2NEOTfe0W7Z2/AiOYBIIMuhG/GNF54ot6kkqX8jBzioAsTxZM566wos+ux51/PRJViHYeOsHUe0jQlWI0+QL9EV5OgPKoLHGyPGtsyuocivpE49DyZY1AfB8JNKqUt/pA0aEwJqc3kXhqEdOxJS7NdyDWFPUFeOLRWk6x93qNYJT/I3B38dyjxSvXJx8SMzYi+GEl0Vp2Oz2E9UN4BRWdkCR9V8EmvLSGZuqKhYVYlgcmlSUB6VYiKRtv/ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6207.eurprd08.prod.outlook.com (2603:10a6:102:f2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 09:21:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 09:21:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 9/9] net/netcat: add netcat over tcp support
Date: Wed, 31 Jul 2024 13:21:10 +0400
Message-Id: <20240731092110.4027134-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731092110.4027134-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731092110.4027134-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: b67ccf60-24fe-4a38-f273-08dcb1423374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A55WJrjkxWUgXxfmVNUFH8+b6F0zqPPmWMujmg9ZeWRz9SzJhuUn3M4us1bO?=
 =?us-ascii?Q?6uaoI8n9hIfx4M+3wR4A90bt50V/DyLYo5hoD977pGHDvxN0cb2n27759cR+?=
 =?us-ascii?Q?ERAZQjnTuWYMs/OMYGfQ03pawqq6cdcCZh8Z6u+cs6+xCBG+6LyEhFAtDXl6?=
 =?us-ascii?Q?F2gfR0lwzUjMkr0Dwsj/MlwrZqvP7P5TDh2adtQNB0E2OwI+hN3coJT0GDyY?=
 =?us-ascii?Q?4GIvZWFYiAi2unUlxAonL7rGGfs3HYmIDgHEj1nc+8gVyq9QcmH0EIXmIT5t?=
 =?us-ascii?Q?cXQXndD781Q+12F/p8O8LEMnzWhYsVEuuinb7mT+GYxLC8FcphiUoY5xWjLS?=
 =?us-ascii?Q?Y0/E5HFio2cIUcosBEFMlDVLU9JErRYcl1SHHoq/BHyWeUh/s9anq4qqgstA?=
 =?us-ascii?Q?FIv+A415qFG0Ry2plINuCPAROsAiF8Lk17iHbnxGs6/M2835QTkwVkOCF5eT?=
 =?us-ascii?Q?CVTm1vxeemH3AgqaBjb7w+MDs7nrkOiPQDcUAtSIkO71ZxRXkh/ogPfq9yTP?=
 =?us-ascii?Q?+WBAEAYGZ3G/U+TBLxm3mrA0myxAVXm10yT0rgaVOVK1nxB1qJh1NjV2dsDt?=
 =?us-ascii?Q?v3FiISD4GobkaMB0GLzEmtgVhAJNdWZTCKhWgBmp/uwOmjCWFnVMYP3wWdTL?=
 =?us-ascii?Q?qAUIL0Y1WLVrXJBvOy+4phtGAtO0v2VtJwqqRnIwB8tTSpBy+wmG1HlTysCB?=
 =?us-ascii?Q?jb8xjCQjX1JvLpJ7LcuJdCbZb6Sbf/QDbU68eUio/sqVLZseU/imRMS2TIZ1?=
 =?us-ascii?Q?p0H51cQgWvLfJkJKTJ4dzbDSTSDNR0/VkDVbCXGHenDhSXgvD5VjedYpovq4?=
 =?us-ascii?Q?VRUAr/oNlVPtGVd14MfSWQFL9PxMb3PhB9okml767tHD1eSvFM3ciamV2vkK?=
 =?us-ascii?Q?z2BfSeHC47cyNQC3L1/lVVfMQx48wNfAZeDEbkWIw2taNz5l6JMZK8mFXVLi?=
 =?us-ascii?Q?SezMEWCVf8DIsuzibAMj1917KOzBCp2jqqxvUJA6p/B/ZK9CYbll4zwbr7fX?=
 =?us-ascii?Q?uKhPgA/G5Gt6za41EW6pIsuCMf4quhW1wv8FzruJ1kuZTNJXSKEp1/o+jmpQ?=
 =?us-ascii?Q?y7krI3eG0KUyITCIxKqs4cGivDXz4pRcaEM8q12BFwuTyR/o01Wq6YCz3gwu?=
 =?us-ascii?Q?hJ1iDoINb9ryfXHI0bsY8O1tN1UTn9WvezMjXmGF45LTy16S1GZMWVO/wrWi?=
 =?us-ascii?Q?GvF9apeTsW/9uZUz5Ks5HaiHZG2pVlOsXTwLtNus23c+bjDFXQNy+leqxh7T?=
 =?us-ascii?Q?PNz5ykRg+hoilX8WAeW+AA+ayxvGt6iO5t+76BE3wKX5VRplkiJTI2tfUh3k?=
 =?us-ascii?Q?mOMdQbHrTNS3VlsudcuzoMFIyTFG/oyj8A3moeir3wPTMGwOkc8oAstLS3Fd?=
 =?us-ascii?Q?0Cz/DyhBp7Yq7ELe0zu0c1IE5qAF6+0tr5N1TIlhcBGppSP+6p5IY2bcqD77?=
 =?us-ascii?Q?IDq+d2QSFWE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51Yb+71tsrQaBM/bAUhbMkDJbsQLdAkZ2QETdZefY4KMJ/gxob9cUAAvyY7b?=
 =?us-ascii?Q?npXrl0qwUntf6tUS1PSpXaryUvGbygMGCO+wntC0c+otkeaZxZol03AmelEj?=
 =?us-ascii?Q?xX2reIFHJXD2Myu0N6RZ3yAvIRr5vdegWMjqR2knGKqy6WGxy217mSy0QESd?=
 =?us-ascii?Q?p18/y0cS1csOEzdw317uyNJU2NI2GzHGcuorCjF9qWtP1wGoR8+5GtvWkDpU?=
 =?us-ascii?Q?+1ABeyE3wPFMuIAYRkrdThovjCKz8Df6iaFgBgbzi5I7LYyjuxqeuhxbW/SH?=
 =?us-ascii?Q?OQMGNwwGSxw4Jos2fHK0mY1fcXLC2gXI5hfy04l3qUqNTDTbNINdAC3n4h1+?=
 =?us-ascii?Q?ZXcehGCbD1ptTHEbF/C+qc5NvgtqNOLq9dzCwkhEJ39j24gtFTklOHyudjYv?=
 =?us-ascii?Q?DnZq9619w1hF/k+0SgWQp2mz8CbHmFFBIZatRG6i+Cx/3wOfvb/IgdWCdbCV?=
 =?us-ascii?Q?d3h7hohrgYj4zbjLDP3hMxo8C1WM+qUXORdh5P9HSRAT9l2PMVjwz7NvSwFq?=
 =?us-ascii?Q?lKMUzHrN5wVWSHki2KH3iXHgGObLshsyiIAmhiTTSMacgxxRV9Cijv1nvE6J?=
 =?us-ascii?Q?DmSTTuxweeOVOPFSMdxPpputG/j6CZIH17MR8ko6x7eGippys1hcB/ZXjvvf?=
 =?us-ascii?Q?wu3wYAxzsaDuPjO16i28hiNKNlRz2QggEodSx8O2dJkgKgkYzIbkgjmaBuL2?=
 =?us-ascii?Q?RUxjKvD2RedMDSvZt/EekCs4Nbxl69tXg8jyM4rXi/BUYi1Z/z/qkHWKk7eC?=
 =?us-ascii?Q?fP64aXEIsTt3Oz1PIbc1zquAOT9meoIMcY1QvxjbKjaULTj7c2coR8Tfgm9e?=
 =?us-ascii?Q?533ZiJYY9/Hqg5z6qTbogP3OlAT3yEeEF9Mj/tAaUlsX9JYFVYrKBngGdups?=
 =?us-ascii?Q?pBqhVV3/CSEjXmb14qMhSVe5WbIennPkN27gLqFFU/JfTid9VFJEc++XEISI?=
 =?us-ascii?Q?CuUSxADQd6tOu4hW9eYiGqssqY8kpkyh/1eIIVphS+dxPRYvUalhU+BMQRT1?=
 =?us-ascii?Q?f4+NSy+s/0SUJe63sAux5WJxhQVEkg4zbzW9sH6YnTlg4+EgSMjblkyPKHnt?=
 =?us-ascii?Q?L/5dsLwkL3z4gG2UFlyOcTQucUlDftJ52yfHyPpVSi0JsRtaZOOpc4C4zqwl?=
 =?us-ascii?Q?g3XdxPHvk2gbEpcULQgGG3qVJ99cE8BGSOYZ1zwfHqWtfjxIr5LKL5tz2xmF?=
 =?us-ascii?Q?tclqT8AB3VS+SgXXR08S8q1AxqmOOIsudx29wcgorpnlMVaFmae3oxBrPKOK?=
 =?us-ascii?Q?DuKEYcNcUVKJF1WXWdvoMQuor3GpbbZJAEC8gfnINHjbMUU1cjX1JdR74+Eg?=
 =?us-ascii?Q?g3chYlLrnfs0Ar80/jbCMU1KU6D+eT8JA4NSdQncuPw45xNEbeF75MqGbEBd?=
 =?us-ascii?Q?Aaty/4ZregdE/eXszWq2Pp2yX6zIf3y9EavXT6Z6bLXPt3mVmLCSsxdIkmQT?=
 =?us-ascii?Q?gpYbRxyckTc9t8eX2AlNq7zn4EfvZbaD6wu/eKqZE1cVXyRQUhr+EqYdxCUL?=
 =?us-ascii?Q?9wLIyRKQjYiWOcC/E60bX5cG7CR5wksQDty5L8r9r4MQ/TfTXrKGjYl83QK7?=
 =?us-ascii?Q?yqntbMpVqKqRVBlzirSY3tR5wetQVXxRQDojCYgSH5WfOWQ1ysEITUEbUSsZ?=
 =?us-ascii?Q?Ma5GjS/4uZQ5fdyhJtcscEw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b67ccf60-24fe-4a38-f273-08dcb1423374
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:21:47.0559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xLjrlBS9w0LBjQ3erEqR3LteVjg9hLBwlOaAEiT2ilbSEKKU5WZ0Dus5GqBaEybiZursS54MY8BVPzGfbUInxcunfi8A4DNICKHE1t8dKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6207
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

This patch adds downloading/uploading of data with netcat.
Client/server mode both supported.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig          |   7 ++
 cmd/net.c            |  34 +++++++--
 include/net.h        |   2 +-
 include/net/netcat.h |  20 ++++++
 net/Makefile         |   1 +
 net/net.c            |   9 +++
 net/netcat.c         | 159 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 226 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..abcd003f7f1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2007,6 +2007,13 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
+config CMD_NETCAT
+	bool "netcat"
+	select PROT_TCP
+	help
+	  netcat is a simple command to load/store kernel, or other files,
+	  using netcat like manner over TCP.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 53ce2bc5d0c..6ac81415f8a 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -206,6 +206,28 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_NETCAT)
+static int do_netcat(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return 1;
+
+	if (strcmp(argv[1], "load") == 0)
+		return netboot_common(NETCAT_LOAD, cmdtp, argc - 1, argv + 1);
+	else if (strcmp(argv[1], "store") == 0)
+		return netboot_common(NETCAT_STORE, cmdtp, argc - 1, argv + 1);
+	else
+		return 1;
+}
+
+U_BOOT_CMD(
+	netcat,   5,      1,      do_netcat,
+	"load/store data via tcp netcat utility",
+	"load [loadAddress] [[hostIPaddr:]port]\n"
+	"store Address Size [[hostIPaddr:]port]\n"
+);
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -323,16 +345,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
 	switch (argc) {
 	case 1:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_STORE))
 			return 1;
-
 		/* refresh bootfile name from env */
 		copy_filename(net_boot_file_name, env_get("bootfile"),
 			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_STORE))
 			return 1;
 		/*
 		 * Only one arg - accept two forms:
@@ -354,7 +377,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_STORE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -365,7 +389,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net.h b/include/net.h
index b0ce13e0a9d..5ec826209f0 100644
--- a/include/net.h
+++ b/include/net.h
@@ -515,7 +515,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_STORE, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/netcat.h b/include/net/netcat.h
new file mode 100644
index 00000000000..09470e7f0ce
--- /dev/null
+++ b/include/net/netcat.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * netcat include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_NETCAT_TCP_H__
+#define __NET_NETCAT_TCP_H__
+
+/**
+ * netcat_load_start() - begin netcat in loading mode
+ */
+void netcat_load_start(void);
+
+/**
+ * netcat_store_start() - begin netcat in data storing mode
+ */
+void netcat_store_start(void);
+
+#endif /* __NET_NETCAT_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index 64ab7ec740a..dac7b4859fb 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_CMD_NETCAT) += netcat.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/net.c b/net/net.c
index 86182cc504e..0e05a8f2336 100644
--- a/net/net.c
+++ b/net/net.c
@@ -108,6 +108,7 @@
 #include <test/test.h>
 #include <net/tcp.h>
 #include <net/wget.h>
+#include <net/netcat.h>
 #include "arp.h"
 #include "bootp.h"
 #include "cdp.h"
@@ -564,6 +565,14 @@ restart:
 			wget_start();
 			break;
 #endif
+#if defined(CONFIG_CMD_NETCAT)
+		case NETCAT_LOAD:
+			netcat_load_start();
+			break;
+		case NETCAT_STORE:
+			netcat_store_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/netcat.c b/net/netcat.c
new file mode 100644
index 00000000000..ea225c68c87
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * netcat support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <mapmem.h>
+#include <net.h>
+#include <net/tcp.h>
+#include <net/netcat.h>
+
+#define HASHES_PER_LINE		65
+
+static struct in_addr		server_ip;
+static u16			server_port;
+static u16			local_port;
+static int			listen;
+static int			reading;
+static unsigned int		packets;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(void)
+{
+	if ((packets % 10) == 0)
+		putc('#');
+	else if (((packets + 1) % (10 * HASHES_PER_LINE)) == 0)
+		puts("\n");
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	if (tcp->status != TCP_ERR_OK)
+		netcat_loop_state = NETLOOP_FAIL;
+
+	if (netcat_loop_state != NETLOOP_SUCCESS)
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	else
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted", packets);
+	net_set_state(netcat_loop_state);
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	net_boot_file_size = rx_bytes;
+	show_block_marker();
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	show_block_marker();
+	if (tx_bytes == image_save_size)
+		tcp_stream_close(tcp);
+}
+
+static void tcp_stream_on_established(struct tcp_stream *tcp)
+{
+	netcat_loop_state = NETLOOP_SUCCESS;
+}
+
+static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
+{
+	void *ptr;
+
+	packets++;
+	ptr = map_sysmem(image_load_addr + rx_offs, len);
+	memcpy(ptr, buf, len);
+	unmap_sysmem(ptr);
+	return len;
+}
+
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (maxlen == 0)
+		return 0;
+
+	packets++;
+	ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
+	memcpy(buf, ptr, maxlen);
+	unmap_sysmem(ptr);
+	return maxlen;
+}
+
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (listen) {
+		if (tcp->lport != local_port)
+			return 0;
+	} else {
+		if ((tcp->rhost.s_addr != server_ip.s_addr) ||
+		    (tcp->rport != server_port))
+			return 0;
+	}
+
+	netcat_loop_state = NETLOOP_FAIL;
+	net_boot_file_size = 0;
+	packets = 0;
+
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_established = tcp_stream_on_established;
+	if (reading) {
+		tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+		tcp->rx = tcp_stream_rx;
+	} else {
+		tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
+		tcp->tx = tcp_stream_tx;
+	}
+	return 1;
+}
+
+static void netcat_start(void)
+{
+	struct tcp_stream *tcp;
+
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+
+	if (strchr(net_boot_file_name, ':') == NULL) {
+		listen = 1;
+		printf("Listening on port %s...\n", net_boot_file_name);
+
+		local_port = dectoul(net_boot_file_name, NULL);
+	} else {
+		listen = 0;
+		printf("Connecting to %s...\n", net_boot_file_name);
+
+		server_ip = string_to_ip(net_boot_file_name);
+		server_port = dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
+
+		tcp = tcp_stream_connect(server_ip, server_port);
+		if (tcp == NULL) {
+			printf("No free tcp streams\n");
+			net_set_state(NETLOOP_FAIL);
+			return;
+		}
+		tcp_stream_put(tcp);
+	}
+}
+
+void netcat_load_start(void)
+{
+	reading = 1;
+	return netcat_start();
+}
+
+void netcat_store_start(void)
+{
+	reading = 0;
+	return netcat_start();
+}
-- 
2.39.2

