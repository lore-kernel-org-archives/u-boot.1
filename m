Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22C0C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B7AF88610;
	Thu, 27 Jun 2024 13:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="YyPNfWHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20CEF885FE; Thu, 27 Jun 2024 13:40:03 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89078860D
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klSO6ctFyXzlsRQiJUJlIBl+QV5Mi1vQrYydmRrujnu5CseMQ6SkF7oiGBXSfVP8fOQ2vbQOZoge5kbeBa/rvWiZEvR+tHKoC1zGhHkwOr4O7ChLd44BVZu/r/z60yrkcd0qJSGKpx9mZcX38zuqukenHY0iLHlDeD5rCIUHTptXEKmGAnnaoIbW3+O/70d9Wio75nZcCoxZea8NXBDgzQhTtqocavuw+FoKC6E3UcPSqT/MDSy3fJcQRoMo19LApiwri437W7VKxM7JyO6N1EfhrUVSYaIvFBV5T6m+crhYLmIZq1y7hqp+jm7vIujutIKbgQq0RlR9f1AHSR93hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN/n5Vl7RXfy5892P98nnf0B5IhQIrsi312dauzg8bw=;
 b=hC9RUEvD1XGdKsbME7BmGLGq3Ud0KGXoh0yBgr18YmQiqDk4MUyf4Q1cM8CPJF+M7uWDg0CVSX7EkPS6/7w2Hl1TXxhofj+a6calT3foXwM093pOXnLUoRZwKNysdDZi7Ciqz+d1/Z640qX3fEekGSSbssAGcU5xsHUg0ilXrg2rGV3Tn2VXWP2DrYHf0jLMlPTZuoElDOwXxcvRYRKh7qgBvc+JCCxOPERv9gw3Yq0iFgEt+j+SxGMZb4UOPbVn6JiQ00ckDzQNXSK2Sc9GzFFjEmn6UAxZJ7IzXf71xhYL1ZN565TBULUCbM+zPFczUz/wvojMaIHlhik7dds6Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN/n5Vl7RXfy5892P98nnf0B5IhQIrsi312dauzg8bw=;
 b=YyPNfWHH75tD7dkO1iwa5pFEPNV2rU2KHSHATT+99fJ0EkNnRcVO2vSgYzR/DIQMm/6kc+ITKR0Q3bRUhRRqL/yoqNJJ2vUN0L666t+2UYU/+Nx/vAhuwIB2JbWsf/rCik4+7aVX6Lup9K3BYrJk1FnHxD4eJ8ozX3h1IAn6RASvQVbUoQtdVyUv1sPnSaPc43FgfnposNFMg3cbsVZwoYfiZ6OAPxSf9masnfmkZcFIh3S+gloO/MUOYAWKzqwbLZIJ6yaSqzdRnY7QQhQM44UG3UMwjnSEJayu8S/jZCNdHC20Yw23VLYKqAwVGQdu+nhWQBxgkAe+Ema05PBIKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10427.eurprd08.prod.outlook.com (2603:10a6:800:1b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:39:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:39:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Baruch Siach <baruch@tkos.co.il>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH 07/12] net/netcat: add netcat over tcp support
Date: Thu, 27 Jun 2024 14:39:34 +0300
Message-ID: <20240627113939.100620-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BB3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10427:EE_
X-MS-Office365-Filtering-Correlation-Id: 435644d9-ba44-4857-5f50-08dc969ddea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J1xYnw3kcX5JX0sMP95uGkDRnNSdq9BS1NQsCkVxGJ08DqQZSQWM09RvHLjz?=
 =?us-ascii?Q?w2l1FyIDOzNP7blxXuHFx+yG9UIAMbMh6Pd7XKmP/RcGmrtm/yrmq3tExY96?=
 =?us-ascii?Q?KSZjBWXDnuL6yzQhl9JYui9HU3DuaCUqC7zQC1a8SvyM2Gq0oiijemqGbwu9?=
 =?us-ascii?Q?9DjS9XFaKpy+TyVD8xsgnO/eNeEyhatib+fRz7Kinj4KMrA/2yNpMQyGDPJL?=
 =?us-ascii?Q?Jf4+8vViRJ7LstF1YwTEZNRdEUKbrURc4FxcrO55EzaWqQbf7M/9X2CvSxjY?=
 =?us-ascii?Q?c6D/lrxZz+DYCTjLDc7hBgSffFSZFdB2+uJdSuqvlpTu4OYhcR0odajhRjcG?=
 =?us-ascii?Q?W8yHdZIAy5JFeEGfd5Fab7f8vWsCnD7DiGcFo2bY2vBJ9jOo30/aDsqtKWMr?=
 =?us-ascii?Q?WaD6uLd/MiRm0Mvy3Im57bp/X1wzlW+Z5mTK/ZXO7WURVnlShVvhjLL2MhgD?=
 =?us-ascii?Q?Skz/xgdN7JH4ZD/sXqaWu2zAEj4hX9Q22jXfvkUjXojCcfddIZOakOlLB6hk?=
 =?us-ascii?Q?y4SK+Z/Ncsgkp4agAjVrw4m3UvrYrE96S01XEUGu2Is7TQ3GY2/g1yrVe0YY?=
 =?us-ascii?Q?FAJ7H34vKxq2L24KhiU0iuvUJvlbtLZdBFntaoO7qLymo3rMmASqLctXaE8A?=
 =?us-ascii?Q?JPJVqaMQmAkOxbZ9jDECXtOyV1q7OViGYgYFZSTKBHFbAdyMz4yPaLnKLTgq?=
 =?us-ascii?Q?aaJo5yMImcEeLYP2IepxklezO2z0ktbrqa+rUpFcHIQPnWiN90FJlsaViFN9?=
 =?us-ascii?Q?54ji7NXzCy96gqGv2QWf3sZQDKtHJzxEg+HEsNth9CSdCwjjwiHiZnKH6eYx?=
 =?us-ascii?Q?sA9kMv5xqBLwBdQfgW/9uPWaWOPMFt6VX+ZmR/cczBLoVZCWBFshjXqN1jsq?=
 =?us-ascii?Q?lWVJ3+UvrZeIdxhesVql2EBJ4orbNfB/0PB3ztbYTsNAn92jygRVLjCGoTMj?=
 =?us-ascii?Q?Ej23RORpugXWw5F+rT9Q1oXMXEKND7JZns/n/EhL3yMjv+gzw5yK3TAzfW/6?=
 =?us-ascii?Q?rn89k7Jpu1+N8u0EKmw3RIepQHJHuXxSla2YcZd9Qoh8mqbAp3C/gGRsOE5j?=
 =?us-ascii?Q?n6kMeNaKrvkyUZgExOlkF4faIo9+n/xIF1jy/T2nQKYlfiBBWQSTOwSQuSxy?=
 =?us-ascii?Q?gXhIuPMbbxMbWNLR249UVaFxlrymannJPFizvsuKI80QYqYqZoN0MXbs5VKP?=
 =?us-ascii?Q?gVaZ3khWY5xPJcNjoZZz62QJBUoCPTnWtUItlE/fKxW1XqoeKYqNlhrh9tYp?=
 =?us-ascii?Q?eIPDMGZ10s139Zta3JXfAOvoRvwCPYxY/C7eBdIcrHszzeKy4DXdbHj/ZqbJ?=
 =?us-ascii?Q?cDJSSa9rUVIlHK70eBvyPy8m5hc4n7ehXZlY1P/ZoSD2xp8I+iW6RsXwqfRF?=
 =?us-ascii?Q?+g2fMPcuUNO/9uWSooseXyN3/UfV0cpG4P+AKSfDNuLZgBv4SFHb6jrxnCv6?=
 =?us-ascii?Q?JNjmhyLAQUA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ORNx/W74RcbgM4gXG/HM1SgB8uZhrJvkgxRHOSlz53T34Q0S58VChDLJ/y7M?=
 =?us-ascii?Q?j2fFLJlhB1M7liIHqs45Vb+X1YD8AREbEc6VTwsr822pvsfouRCahtVmXS8m?=
 =?us-ascii?Q?6DIRzb6U24k0ZUSzfyv6Hn8qxJbgOGrUDB6qexIWusLc/6VAdIZXUynSL6oM?=
 =?us-ascii?Q?/z2WwAF5KT2fSPCbAmeYtunkgehQ2UYy53cLFtVWMBLLLWfUClj09jqHQ6Kk?=
 =?us-ascii?Q?1O3SutdrjgViJnVbBmpQZIjnNG0Pl0nZ2m1DrxGF6N46vRIZFb3ePGi7Gex9?=
 =?us-ascii?Q?NedFpm8y7FZWj7gElucl2g0ErKkq0VzFocUbkgkTjgyRUg6Zr9wMLoPots3I?=
 =?us-ascii?Q?Suujo7qTpehcN8s/872l5kVSH1GSqiG2usIZJ0p7bXw39Pz5bs50Ah4cW+gH?=
 =?us-ascii?Q?/C5i9+oJY9CVy/hrbMN8SFrcsWtVXtLwXVIxtf5myrPtG5QrQ5LK9LmDs3N4?=
 =?us-ascii?Q?qGhoWYCPTKDuTTusk58bSzZBjTnQ6vy8IeO8zYpGRnELD9fJzzyBtVHftn+r?=
 =?us-ascii?Q?SigAzp0hdqTtqVsLyFKK69zRtgtTaQodm4qDQtCyPGXUIcdkKPK99amBi4Sb?=
 =?us-ascii?Q?uNw4m9aoYNfIFI1pVwUHj3Fn/Ym2LKh8mvmMsCKiA94d6AKEeSMhc5JBXySn?=
 =?us-ascii?Q?2nr1YDbmQWgkxmRUISdCiadAq/ZUWc/H3oPBiNQJUXqF8/Iz0A7+OJDEVwSR?=
 =?us-ascii?Q?NPp7Hq3azhpkhlN5udpVcdQZw6F6ec7aUPUlR5eaZVJbiczwo3077lEW9C1Z?=
 =?us-ascii?Q?VftKHwtsNfjtnKM+0qDM5jxzzLAn9ACV8GjM+AmX4BNmlzbVwo+yzE2r1XQI?=
 =?us-ascii?Q?OGmY7n64g7mIoVgE8aInJB468/HbcjiRyJS0I9fnwXmzhT0VBfrUF8JBN+EJ?=
 =?us-ascii?Q?Bqs6WGvwK6m8kCDYyZh5/CzOVnYH1G3Nb0lFMAA76rCKjkyk/5Zg1Vbo8hG0?=
 =?us-ascii?Q?62DN3EeHwB3efmkf286jbGQ8JwEjULWDbTkiwvGnPyBkWKOrpJc6i+BivgIb?=
 =?us-ascii?Q?0tNIvWtOtsxi92+uEIAd+Z4r5JnGLOx+8oZ9dJapti8jFoOAegLaNcc454SP?=
 =?us-ascii?Q?DbTX/NOOqotrOEHAqIOuexKjLryAK2OgXVR/l1t1cjs2Tk1if7nakl3dfVX/?=
 =?us-ascii?Q?5xPPuf9S+O/31CjzRm9xZzuTyOhMuke7yhlzMIqemi/WND3lR6+SaJhenGoD?=
 =?us-ascii?Q?viD0nTIAbzD1tTyvKJW1HMLQJMdV0QGUhaxJAo8gvCBXoxpQckX4DfSd1iKQ?=
 =?us-ascii?Q?1bJUke9iuhabgXtUpTwiK+Az+8xNfuYl5vK4bPIQGFFMBAMRXlAGH0/Mi1Gm?=
 =?us-ascii?Q?ilFHPxA17m6KPf/aqgW1oINo0uK/cOnmbDozAS5KPSGgvIE5cdP61NAimGbm?=
 =?us-ascii?Q?jFmOSd+T1vopZ3NE0P96Ove8Bdj60NqMoz9Jta0uRiKs8TLAL8afxunytcuS?=
 =?us-ascii?Q?1ltf9lxgkmtPIXwfU5xK/xkvc65VGQCfrk+CLz6Y1fJqtNy5tZafNfGcaFdY?=
 =?us-ascii?Q?pO/HTLdsl+Vm8l12cBVsG3YtHFiqtKkkkcP67HUPUHlh3qBwmZJm+KBK94IZ?=
 =?us-ascii?Q?P88YsmMuNtuGDz+z1757PolmoEPomvblxVwvFBhpZNIsPg9B89wArdD13K5w?=
 =?us-ascii?Q?8c7KpCCLJ8zp2jEdUKs3X6g=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 435644d9-ba44-4857-5f50-08dc969ddea4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:39:57.0648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBKfyOTSM0VmgXvM/afTQuwQNckCkOSei1qPd3Jl6qbzCTyb8v1iGniaEQnyrxrssoKm950SUEYFGQ356UXeOIlbVMhMLn/mg4Xi9ELOA+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10427
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
index 6834bbd82f3..00cc13e2006 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1990,6 +1990,13 @@ config CMD_WGET
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
index d407d8320a3..ecc1b49f52f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -208,6 +208,28 @@ U_BOOT_CMD(
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
@@ -325,16 +347,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
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
@@ -356,7 +379,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_STORE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -367,7 +391,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net.h b/include/net.h
index fe645245f0f..235396a171b 100644
--- a/include/net.h
+++ b/include/net.h
@@ -516,7 +516,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
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
index 0fca11d3e8c..809fe5c4792 100644
--- a/net/net.c
+++ b/net/net.c
@@ -110,6 +110,7 @@
 #include <test/test.h>
 #include <net/tcp.h>
 #include <net/wget.h>
+#include <net/netcat.h>
 #include "arp.h"
 #include "bootp.h"
 #include "cdp.h"
@@ -566,6 +567,14 @@ restart:
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
2.43.0

