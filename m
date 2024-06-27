Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B571AC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A4C885F6;
	Thu, 27 Jun 2024 13:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="AMJpL+TU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447698862D; Thu, 27 Jun 2024 13:40:05 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71D7188619
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwBvXPC5NwwF2ZcnFzYeY0jSM7eHkkeKBz406pp8A9+OO+GfEfAYo14OXFvgV0IsdNyd57meZImkqatcmoJlRMXFGnA6XGZAcKZYI67G1QzLzzySMOLckhyl8Zq43QD1rX2JrSLUn2gj+TXa4RTvTM8m2cJjrlaNZDdD1hSGS+DEMHVTVtXQEm5c40gaDyBdDaULUl1hKwIJAWv+X1rEhkfUa+gRuBK8J5n2MOzd66dXqBmbiNY6lH28QS1nuoke3Asyd4v/xzva+9w4GpiY2/DgBm1QH45YUyoa7qFXRXlXq3DByEjSS9AwM8DyUdwrVpaoZtB0C5FKjsc3PL3i9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuZoXxas9R27ViFkmKoWwh/pF3V0Lh5Z29bXOrJ0V9c=;
 b=ANexN49Ptg04d/WvK/WyvStedvAQOuakjw3WIYvaZmH2bR2tGWDMiDjL2f5V+fiivqyA0at71g2Bf9K10kYR4Jeiock7ofSnhnomVimNznu4hA1TIRf8Mt87P7sa5UlVNzPYmJ7Pholzv4BlptqqTkeytPLp5nVgGfOgJZ3rb9B4BHW9an6xoLb/+XPoR1n2sR7gSa1AJ6G8H5NrwaanNrYmrYTdxll7VgDzOtV2ByhUeF5+HtCaDugW80EuzSQBUsEVpyBOnXmNd/ZB0901e1fN+wnRxkBKffaN1KxdpCHxS/DzBQ+FG8h6sUHMKwtdMKm73fu1m1kFrNl/taqtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuZoXxas9R27ViFkmKoWwh/pF3V0Lh5Z29bXOrJ0V9c=;
 b=AMJpL+TUokqTFdrtUDuM4mAYKy7X/xG6uqEQJC9K4DXx4Obiw9e2bOHMgB1Jgg3RW9tjNBivaFi2SZdQXK7U3zMRb2KBhoKobWt//W3dzBXy46j7pvVfCT4NzPqy3YEMWu+KrkKs89JiXLJKcqngyG0JqTCSH7RJa4rL/ODh1B9YOac5MuEbooQWS/cVqRqq0rQbtIHb0V5JJ/VTUiNuCI+cilQE7f6XuueBFxECnT0f7KfO7XJieLeCWvhN8yj+k5xZ1Il0RWo/0GSt2p+9ATsMs+xbrrQFS0hUI4RxWAMKUsbePh8cGWIpvdMEOpSlMPUt+vhHcoVJWpLpI7TEIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10427.eurprd08.prod.outlook.com (2603:10a6:800:1b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:39:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:39:58 +0000
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
Subject: [PATCH 08/12] net/httpd: add httpd common code
Date: Thu, 27 Jun 2024 14:39:35 +0300
Message-ID: <20240627113939.100620-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 86e191e3-d3ad-4d4c-585a-08dc969ddf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z0HdplPQcF9gn9Xempe3BHtVbyzW9EESuLHnw20xS8kAOFHpjyly+QBnB9V5?=
 =?us-ascii?Q?8PUE6BdYPhTMnIsv6xtz+iG6zQYyCj8fmxRZY+n+8V+b2yzsK6PjdV/p3gkf?=
 =?us-ascii?Q?hBbKRnBuWTvIqbAnk1DOl+lw6WQSi07c161OG4edZHR0Lkl4Me9MtfjbuRjN?=
 =?us-ascii?Q?MkAI2h65a6zQtfvaxW0SOZsPbCU8MtH6WP8AEXiHKsTvF7zIky913zM3O3hW?=
 =?us-ascii?Q?MJd2jRIHkzlYZWNIuPmnyvI0PtgSdKZys2U9D+padm6GxInmFmSg5hBGKKYn?=
 =?us-ascii?Q?AfC4yVfuHNBZTc6lvl8OSEGT84XNXHJQmogy0Ltge8uaH0FLAiIqImZ+ZpiV?=
 =?us-ascii?Q?p1i/WPXOvpMa8SPhh0ae2rkcyluupd/v9V6ya8QSWPN6ijsne6cjJw7ECF66?=
 =?us-ascii?Q?ckTmNxA2jz0JXZ/8lMb/6lbe/zRrYis7XaU6ndIgITTRA0QS7LDh15b/0Z+H?=
 =?us-ascii?Q?d+k96Y/U7O6LKkAoD29xLaq2r+8J9CLQ1y242Wb4YPbfHBeH7eUs3OmzhdiN?=
 =?us-ascii?Q?tsZ2kKJdhjRobbJQgeHPpxZ2KWryWJ4zw0RolqiBkeuBH0zoltqHZIc9ZjWJ?=
 =?us-ascii?Q?tXv84++t5+rto4iCdtDWeWgfS+R9+wGX1V+9ilGYco8It1MuerAWa0+7jIaq?=
 =?us-ascii?Q?vMLmt2FdkE9dBgWT48yJ+fIEfNVks08B4GxCUNTpaRY5+gmOcJSOf8duu1U1?=
 =?us-ascii?Q?iI7Qc9s/sfAaGcdQ/NHsKcd7Pt96fNCOXZWaMtZUacfisE78JKjo0oweOMLs?=
 =?us-ascii?Q?TGecOd8X1hHa7HIA1uE1NzZc800kSUAwlVK0j2EYf0WK0dHYqLVYQDwyKm7l?=
 =?us-ascii?Q?VTWR1UvRKeXT9MvkKbWAl1/mYxrnoM32UI7KR6KPO3Ewt9UVYOrQ8TgcATiB?=
 =?us-ascii?Q?22MMmKAjZ2M9CsLzfteLNgjWxhOlSfjPnNIWG/QWuNcfQgoCESAZad2tZzwR?=
 =?us-ascii?Q?GHAnV1vrMv3piA3IkuOZ3ezXC3kk0gUt/ud+PuhSkzafhPRx0D2QYyWQgLYK?=
 =?us-ascii?Q?z+JGf3qRfNSDJILGugzAjwEN0F8bL6RrbB1RZl5QhHD6Onp18PO9xQ4Dm0vm?=
 =?us-ascii?Q?NsuMg7iiUOGSpc7qofi55XQEeXzJ01ND54DH7bCQxg1k2BIO7nBpFovb/Rwh?=
 =?us-ascii?Q?o/IBAlapdiH7fADiIV819fOmisH8hhvoGCCDVKONHfa5GXAsEjH7oXqCZ2EJ?=
 =?us-ascii?Q?dOlaGsuJd00989VtMsznMBuKwRUSAsr9cVPYnaUZmz/YsdK/t37/Iydly4Sj?=
 =?us-ascii?Q?H3/iXDviZ7/wWLQdRlNX5awx/hDzHSKKz2QwFQ0/2QRPT/bEfZDm3q2oP5Oh?=
 =?us-ascii?Q?4B2xOXlQcZ9ZY/mGA448YkliNI6QwrbrjwIayDyq6bC0XvFEZaHH0D6kqfrw?=
 =?us-ascii?Q?9qyFlDpTNTWak6+Vkzpjq+hmQ37Tube09hgXQ0YhVO+CUiNFfasncP+HyKu4?=
 =?us-ascii?Q?/R+q9yDCxZQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e0qeMNav1iI4ggYcMmIgVZxJ85XPBn9MqCFDh/P+MqsXDqOW4jbr41N55uuu?=
 =?us-ascii?Q?7CswzZOoy8U7rvwzaK2dE/XwIgSDYxFoxTrZ9ucDnMtvbxPHtIZCPQMJKnhE?=
 =?us-ascii?Q?9z5wk6o9pUenuwoq4DQk6wWcGBgICWzt8u5Gn6RaO3fNWA7X9q7JyFtDJapi?=
 =?us-ascii?Q?cZBArLmen+yE/V1Oa60qEzq2/nbQxGjdSdT2BvrYcLB3h5Ogmjy5NNRpGt2f?=
 =?us-ascii?Q?sKUKxvWY/ii6xk+g+exos5cNgbD+Em4j3/YT/YkCEVnrx5tSwYebxm4iaQUm?=
 =?us-ascii?Q?40gMp4PpvdX8qEC8XzRFKQHlVz0H7zuCPU6Rl3nBtL0zpzrKciSM3P2To0a6?=
 =?us-ascii?Q?65vrTEciNftMK0652cGC5LynBKIn8sfGNYJHxR+q4/JT2OZGEAjV6px8knHU?=
 =?us-ascii?Q?ToWnwqHvsyjBlTDaWNrDJ0pw5d0WmWx155LGaTfPeF1kTEGvkuw3g0Z40jjD?=
 =?us-ascii?Q?ET8PfV06uvrtYdB31btyTB5dGpn9AIF3GYbVYyGUO1lRrYeSupDd5mooL/A+?=
 =?us-ascii?Q?V4GMGJzN3JitLphdKDK3HyA/RFdTIypg0HPCCF9OFSb1v9ldwTXCs4Ck51Uu?=
 =?us-ascii?Q?N+Y493qRSNp60lfJ2V2FYCUX3QBfP62r2B+UECsDNTtf0D+Fl+YFvNnJRPaf?=
 =?us-ascii?Q?EKnEnKxtQnpGA8qrKtGQRjkq4/fVoKWagmgCHCxYXVo0FsUWPSuSSB3R3UD1?=
 =?us-ascii?Q?chdec+LNPOWiG3AJRBR/warjlBitEJeE1tZppTNQEL8lMbPx6lhx4RQuLu6n?=
 =?us-ascii?Q?6JGwDiX4d3r5LHZ30UuWEIrQLNINoeRa+WcKVB9re4s+mUTQazjvqYAtLYMX?=
 =?us-ascii?Q?PZQZcbNp7BqeTw96WG4faK4jCuTWyiIe51rFzm4VpV4yxUzGVJ2TYkmz7Bmy?=
 =?us-ascii?Q?t6px9zBgeK4D2zDuh0ADfGIjnnFecFslVOlBrg8WMFpGC5bF2WlbGi5DrgVb?=
 =?us-ascii?Q?+uAY73RbRy/y3Cf9GkHf3LGfKc8xvXBLLSo1H6awujkpcuv/1Rs2gjeTDoIA?=
 =?us-ascii?Q?EOPHuJ6DnG80TvM2JWSO/43y9dqcDZGeu4/ih/ez1WptmIG0bqbFxgg5GFvp?=
 =?us-ascii?Q?Ay4DFDfD9gQobmOdD6C9q0JK9KnaTmbUYQJEbXI9SK2Clo5vxlnl4Nr9vz/B?=
 =?us-ascii?Q?JzOndNHMfI6k+BLqcjoOx8H+iyzgmUp6fY/WVdSsjEYAU7719PI5ujve5o8v?=
 =?us-ascii?Q?BhATY7L6ipnQ0d8Y3ptFOUNnVeoznEyvtfPjPt03oyXP+Oh13BW6+UubKpQD?=
 =?us-ascii?Q?0VByK8lpPYMnK91gjS9xecrtJ/Tl/CkBChyfZ6xfhgTAb9LpxKuTw6RUVinJ?=
 =?us-ascii?Q?K03pgkkJlzD8pLITQOPVUUBBduC71gxokBsth0IOK1IhuUqe6uIJQWXvP1PG?=
 =?us-ascii?Q?w3DLU+j3md9ZHdOz95FVToeaFVTZfCi/qL0fOxBRuqEhD4ikyR0JjqDzktm7?=
 =?us-ascii?Q?FVxhYipnyLwiQC74VXycN89Z0klaQ9KshiN8OV8+IHBpH9nr7SGOLUTEak79?=
 =?us-ascii?Q?Ww5D4JpjpU6kqucAE3rm1g0tDjZCLZzq6U53ro/cYiIqScSNk6pH6Vs7UOJb?=
 =?us-ascii?Q?VFZ28tn9DMlaybxjJnYzEoVBnompULGVTmWDN6WhaInLD7ztRLYaVkxb0lvK?=
 =?us-ascii?Q?mKTqJNGJhm8Lj899Qi3aL7w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e191e3-d3ad-4d4c-585a-08dc969ddf98
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:39:58.6663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zstV5003GTqrirrMP+N+noiZEWTGFy2JPmj3Fe1xHLz/2eTiO6S3+f8GAlfPW4cdMogX4IhWln3DwMWk1VQehDnW4m/lJkrXES9DlmcApBY=
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

This patch adds HTTP/1.1 compatible web-server that can be used
by other. Server supports GET, POST, and HEAD requests. On client
request it will call user specified GET/POST callback. Then results
will be transmitted to client.

The following restrictions exist on the POST request
at the moment:
  * only multipart/form-data with a single file object
  * object will be stored to a memory area specified in
    image_load_addr variable

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 include/net.h       |   2 +-
 include/net/httpd.h |  64 ++++
 net/Kconfig         |  14 +
 net/Makefile        |   1 +
 net/httpd.c         | 695 ++++++++++++++++++++++++++++++++++++++++++++
 net/net.c           |   6 +
 6 files changed, 781 insertions(+), 1 deletion(-)
 create mode 100644 include/net/httpd.h
 create mode 100644 net/httpd.c

diff --git a/include/net.h b/include/net.h
index 235396a171b..6debbf8ed2a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -516,7 +516,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_STORE, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_STORE, HTTPD, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/httpd.h b/include/net/httpd.h
new file mode 100644
index 00000000000..ff0dc93ecf5
--- /dev/null
+++ b/include/net/httpd.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * httpd support header file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ *
+ */
+#ifndef __NET_HTTPD_COMMON_H__
+#define __NET_HTTPD_COMMON_H__
+
+struct http_reply {
+	int		code;
+	const char	*code_msg;
+	const char	*data_type;
+	void		*data;
+	u32		len;
+};
+
+struct httpd_post_data {
+	const char	*name;
+	const char	*filename;
+	void		*addr;
+	u32		size;
+};
+
+enum httpd_req_check {
+	HTTPD_REQ_OK,
+	HTTPD_BAD_URL,
+	HTTPD_BAD_REQ,
+	HTTPD_CLNT_RST
+};
+
+struct httpd_config {
+	enum net_loop_state	(*on_stop)(void);
+	void			(*on_req_end)(void *req_id);
+
+	enum httpd_req_check	(*pre_get)(void *req_id, const char *url);
+	enum httpd_req_check	(*pre_post)(void *req_id, const char *url,
+					    struct httpd_post_data *post);
+
+	struct http_reply *	(*get)(void *req_id, const char *url);
+	struct http_reply *	(*post)(void *req_id, const char *url,
+					struct httpd_post_data *post);
+
+	struct http_reply	*error_400;
+	struct http_reply	*error_404;
+};
+
+/**
+ * httpd_setup() - configure the webserver
+ */
+void httpd_setup(struct httpd_config *config);
+
+/**
+ * httpd_stop() - start stopping of the webserver
+ */
+void httpd_stop(void);
+
+/**
+ * httpd_start() - start the webserver
+ */
+void httpd_start(void);
+
+#endif /* __NET_HTTPD_COMMON_H__ */
diff --git a/net/Kconfig b/net/Kconfig
index 5dff6336293..424c5f0dae8 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -243,6 +243,20 @@ config PROT_TCP_SACK
 	  This option should be turn on if you want to achieve the fastest
 	  file transfer possible.
 
+config HTTPD_COMMON
+	bool "HTTP server common code"
+	depends on PROT_TCP
+	help
+	  HTTP/1.1 compatible web-server common code. It supports standard
+	  GET/POST requests. User MUST provide a configuration to the
+	  web-server. On client request web-server will call user specified
+	  GET/POST callback. Then results will be transmitted to the client.
+	  The following restricions on the POST request are present at the
+	  moment:
+	    * only mulipart/form-data with a single binary object
+	    * object will be stored to a memory area specified in
+	      image_load_addr variable
+
 config IPV6
 	bool "IPv6 support"
 	help
diff --git a/net/Makefile b/net/Makefile
index dac7b4859fb..c1f491fad02 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_CMD_NETCAT) += netcat.o
+obj-$(CONFIG_HTTPD_COMMON) += httpd.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/httpd.c b/net/httpd.c
new file mode 100644
index 00000000000..31c10843a44
--- /dev/null
+++ b/net/httpd.c
@@ -0,0 +1,695 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * httpd support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <version.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <mapmem.h>
+#include <malloc.h>
+#include <net.h>
+#include <net/tcp.h>
+#include <net/httpd.h>
+
+#define HTTP_PORT		80
+
+#define MAX_URL_LEN		128
+#define MAX_BOUNDARY_LEN	80
+#define MAX_MPART_NAME_LEN	80
+#define MAX_FILENAME_LEN	256
+#define BUFFER_LEN		2048
+
+enum http_req_state {
+	ST_REQ_LINE = 0,
+	ST_REQ_HDR,
+	ST_REQ_MPBOUNDARY,
+	ST_REQ_MPART,
+	ST_REQ_MPFILE,
+	ST_REQ_MPEND,
+	ST_REQ_DONE,
+};
+
+enum http_reply_state {
+	ST_REPLY_ERR = 0,
+	ST_REPLY_HDR,
+	ST_REPLY_BODY
+};
+
+enum http_method {
+	HTTP_UNKNOWN = -1,
+	HTTP_GET,
+	HTTP_POST,
+	HTTP_HEAD,
+	HTTP_OPTIONS,
+};
+
+struct httpd_priv {
+	enum http_req_state	req_state;
+	enum http_reply_state	reply_state;
+
+	struct tcp_stream	*tcp;
+
+	enum http_method	method;
+	char			url[MAX_URL_LEN];
+	u32			version_major;
+	u32			version_minor;
+	u32			hdr_len;
+
+	u32			post_fstart;
+	u32			post_flen;
+	char			post_fname[MAX_FILENAME_LEN];
+	char			post_name[MAX_MPART_NAME_LEN];
+	char			post_boundary[MAX_BOUNDARY_LEN];
+
+	int			reply_code;
+	u32			reply_fstart;
+	u32			reply_flen;
+	void			*reply_fdata;
+
+	u32			rx_processed;
+	char			buf[BUFFER_LEN];
+};
+
+static struct http_reply options_reply = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/plain",
+	.data      = NULL,
+	.len       = 0
+};
+
+static int stop_server;
+static int tsize_num_hash;
+
+static struct httpd_config *cfg;
+
+static void show_block_marker(u32 offs, u32 size)
+{
+	int cnt;
+
+	if (offs > size)
+		offs = size;
+
+	cnt = offs * 50 / size;
+	while (tsize_num_hash < cnt) {
+		putc('#');
+		tsize_num_hash++;
+	}
+
+	if (cnt == 50)
+		putc('\n');
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	struct httpd_priv *priv = tcp->priv;
+
+	if ((priv->req_state != ST_REQ_DONE) &&
+	    (priv->req_state >= ST_REQ_MPFILE)) {
+		printf("\nHTTPD: transfer was terminated\n");
+	}
+
+	if (cfg->on_req_end != NULL)
+		cfg->on_req_end(tcp->priv);
+
+	free(tcp->priv);
+
+	if (stop_server)
+		net_set_state(cfg->on_stop != NULL ?
+			      cfg->on_stop() :
+			      NETLOOP_SUCCESS);
+}
+
+static void http_make_reply(struct httpd_priv *priv, struct http_reply *reply,
+			    int head_only)
+{
+	int offs = 0;
+
+	if (priv->version_major >= 1) {
+		offs = snprintf(priv->buf, sizeof(priv->buf),
+				"HTTP/%d.%d %d %s\r\n"
+				"Server: %s\r\n"
+				"Connection: close\r\n"
+				"Cache-Control: no-store\r\n"
+				"Content-Type: %s\r\n"
+				"Content-Length: %d\r\n",
+				priv->version_major, priv->version_minor,
+				reply->code, reply->code_msg, U_BOOT_VERSION,
+				reply->data_type,
+				head_only ? 0 : reply->len);
+		if (priv->method == HTTP_OPTIONS)
+			offs += snprintf(priv->buf + offs, sizeof(priv->buf) - offs,
+					"Access-Control-Allow-Methods: GET, HEAD, OPTIONS, POST\r\n");
+		offs += snprintf(priv->buf + offs, sizeof(priv->buf) - offs,
+				"\r\n");
+	}
+
+	priv->reply_code = reply->code;
+	priv->reply_fstart = offs;
+	if (!head_only) {
+		priv->reply_flen = reply->len;
+		priv->reply_fdata = reply->data;
+	}
+}
+
+static enum httpd_req_check http_parse_line(struct httpd_priv *priv, char *line)
+{
+	char			*url, *version, *data, *end;
+	u32			len, tmp;
+	enum httpd_req_check	ret;
+	struct httpd_post_data	post;
+
+	switch (priv->req_state) {
+	case ST_REQ_LINE:
+		if (strncasecmp(line, "GET ", 4) == 0) {
+			priv->method = HTTP_GET;
+			url = line + 4;
+		} else if (strncasecmp(line, "POST ", 5) == 0) {
+			priv->method = HTTP_POST;
+			url = line + 5;
+		} else if (strncasecmp(line, "HEAD ", 5) == 0) {
+			priv->method = HTTP_HEAD;
+			url = line + 5;
+		} else if (strncasecmp(line, "OPTIONS ", 8) == 0) {
+			priv->method = HTTP_OPTIONS;
+			url = line + 8;
+		} else {
+			/* unknown request */
+			return HTTPD_CLNT_RST;
+		}
+
+		version = strstr(url, " ");
+		if (version == NULL) {
+			/* check for HTTP 0.9 */
+			if ((*url != '/') || (priv->method != HTTP_GET))
+				return HTTPD_CLNT_RST;
+
+			if (strlen(url) >= MAX_URL_LEN)
+				return HTTPD_CLNT_RST;
+
+			if (cfg->pre_get != NULL) {
+				ret = cfg->pre_get(priv, url);
+				if (ret != HTTPD_REQ_OK)
+					return ret;
+			}
+
+			priv->req_state = ST_REQ_DONE;
+			priv->hdr_len = strlen(line) + 2;
+			priv->version_major = 0;
+			priv->version_minor = 9;
+			strcpy(priv->url, url);
+			return HTTPD_REQ_OK;
+		}
+
+		if (strncasecmp(version + 1, "HTTP/", 5) != 0) {
+			/* version is required for HTTP >= 1.0 */
+			return HTTPD_CLNT_RST;
+		}
+
+		*version++ = '\0';
+		version += strlen("HTTP/");
+
+		priv->version_major = dectoul(version, &end);
+		switch (*end) {
+		case '\0':
+			priv->version_minor = 0;
+			break;
+		case '.':
+			priv->version_minor = dectoul(end + 1, &end);
+			if (*end == '\0')
+				break;
+			fallthrough;
+		default:
+			/* bad version format */
+			return HTTPD_CLNT_RST;
+		}
+
+		if (priv->version_major < 1) {
+			/* bad version */
+			return HTTPD_CLNT_RST;
+		}
+
+		if ((priv->version_major > 1) || (priv->version_minor > 1)) {
+			/* We support HTTP/1.1 or early standards only */
+			priv->version_major = 1;
+			priv->version_minor = 1;
+		}
+
+		if (*url != '/')
+			return HTTPD_CLNT_RST;
+
+		if (strlen(url) >= MAX_URL_LEN)
+			return HTTPD_CLNT_RST;
+
+		priv->req_state = ST_REQ_HDR;
+		strcpy(priv->url, url);
+		return HTTPD_REQ_OK;
+
+	case ST_REQ_HDR:
+		if (*line == '\0') {
+			priv->hdr_len = priv->rx_processed + 2;
+			switch (priv->method) {
+			case HTTP_GET:
+			case HTTP_HEAD:
+				if (cfg->pre_get != NULL) {
+					ret = cfg->pre_get(priv, priv->url);
+					if (ret != HTTPD_REQ_OK)
+						return ret;
+				}
+				fallthrough;
+
+			case HTTP_OPTIONS:
+				priv->req_state = ST_REQ_DONE;
+				return HTTPD_REQ_OK;
+
+			default:
+				break;
+			}
+
+			if (*priv->post_boundary != '\0') {
+				priv->req_state = ST_REQ_MPBOUNDARY;
+				return HTTPD_REQ_OK;
+			}
+			/* NOT multipart/form-data POST request */
+			return HTTPD_BAD_REQ;
+		}
+
+		if (priv->method != HTTP_POST)
+			return HTTPD_REQ_OK;
+
+		len = strlen("Content-Length: ");
+		if (strncasecmp(line, "Content-Length: ", len) == 0) {
+			data = line + len;
+			priv->post_flen = simple_strtol(data, &end, 10);
+			if (*end != '\0') {
+				/* bad Content-Length string */
+				return HTTPD_BAD_REQ;
+			}
+			return HTTPD_REQ_OK;
+		}
+
+		len = strlen("Content-Type: ");
+		if (strncasecmp(line, "Content-Type: ", len) == 0) {
+			data = strstr(line + len, " boundary=");
+			if (data == NULL) {
+				/* expect multipart/form-data format */
+				return HTTPD_BAD_REQ;
+			}
+
+			data += strlen(" boundary=");
+			if (strlen(data) >= sizeof(priv->post_boundary)) {
+				/* no space to keep boundary */
+				return HTTPD_BAD_REQ;
+			}
+
+			strcpy(priv->post_boundary, data);
+			return HTTPD_REQ_OK;
+		}
+
+		return HTTPD_REQ_OK;
+
+	case ST_REQ_MPBOUNDARY:
+		if (*line == '\0')
+			return HTTPD_REQ_OK;
+		if ((line[0] != '-') || (line[1] != '-') ||
+		    (strcmp(line + 2, priv->post_boundary) != 0)) {
+			/* expect boundary line */
+			return HTTPD_BAD_REQ;
+		}
+		priv->req_state = ST_REQ_MPART;
+		return HTTPD_REQ_OK;
+
+	case ST_REQ_MPART:
+		if (*line == '\0') {
+			if (*priv->post_name == '\0')
+				return HTTPD_BAD_REQ;
+
+			priv->post_fstart = priv->rx_processed + 2;
+			priv->post_flen -= priv->post_fstart - priv->hdr_len;
+			/* expect: "\r\n--${boundary}--\r\n", so strlen() + 8 */
+			priv->post_flen -= strlen(priv->post_boundary) + 8;
+
+			if (cfg->pre_post != NULL) {
+				post.addr     = NULL;
+				post.name     = priv->post_name;
+				post.filename = priv->post_fname;
+				post.size     = priv->post_flen;
+
+				ret = cfg->pre_post(priv, priv->url, &post);
+				if (ret != HTTPD_REQ_OK)
+					return ret;
+			}
+
+			tsize_num_hash = 0;
+			printf("File: %s, %u bytes\n", priv->post_fname, priv->post_flen);
+			printf("Loading: ");
+
+			priv->req_state = ST_REQ_MPFILE;
+			return HTTPD_REQ_OK;
+		}
+
+		len = strlen("Content-Disposition: ");
+		if (strncasecmp(line, "Content-Disposition: ", len) == 0) {
+			data = strstr(line + len, " name=\"");
+			if (data == NULL) {
+				/* name attribute not found */
+				return HTTPD_BAD_REQ;
+			}
+
+			data += strlen(" name=\"");
+			end = strstr(data, "\"");
+			if (end == NULL) {
+				/* bad name attribute format */
+				return HTTPD_BAD_REQ;
+			}
+
+			tmp = end - data;
+			if (tmp >= sizeof(priv->post_name)) {
+				/* multipart name is too long */
+				return HTTPD_BAD_REQ;
+			}
+			strncpy(priv->post_name, data, tmp);
+			priv->post_name[tmp] = '\0';
+
+			data = strstr(line + len, " filename=\"");
+			if (data == NULL) {
+				/* filename attribute not found */
+				return HTTPD_BAD_REQ;
+			}
+
+			data += strlen(" filename=\"");
+			end = strstr(data, "\"");
+			if (end == NULL) {
+				/* bad filename attribute format */
+				return HTTPD_BAD_REQ;
+			}
+
+			tmp = end - data;
+			if (tmp >= sizeof(priv->post_fname))
+				tmp = sizeof(priv->post_fname) - 1;
+			strncpy(priv->post_fname, data, tmp);
+			priv->post_fname[tmp] = '\0';
+			return HTTPD_REQ_OK;
+		}
+
+		return HTTPD_REQ_OK;
+
+	case ST_REQ_MPEND:
+		if (*line == '\0')
+			return HTTPD_REQ_OK;
+
+		len = strlen(priv->post_boundary);
+		if ((line[0] != '-') || (line[1] != '-') ||
+		    (strncmp(line + 2, priv->post_boundary, len) != 0) ||
+		    (line[len + 2] != '-') || (line[len + 3] != '-') ||
+		    (line[len + 4] != '\0')) {
+			/* expect final boundary line */
+			return HTTPD_BAD_REQ;
+		}
+		priv->req_state = ST_REQ_DONE;
+		return HTTPD_REQ_OK;
+
+	default:
+		return HTTPD_BAD_REQ;
+	}
+}
+
+static enum httpd_req_check http_parse_buf(struct httpd_priv *priv,
+					   char *buf, u32 size)
+{
+	char			*eol_pos;
+	u32			len;
+	enum httpd_req_check	ret;
+
+	buf[size] = '\0';
+	while (size > 0) {
+		eol_pos = strstr(buf, "\r\n");
+		if (eol_pos == NULL)
+			break;
+
+		*eol_pos = '\0';
+		len = eol_pos + 2 - buf;
+
+		ret = http_parse_line(priv, buf);
+		if (ret != HTTPD_REQ_OK) {
+			/* request processing error */
+			return ret;
+		}
+
+		priv->rx_processed += len;
+		buf += len;
+		size -= len;
+
+		if ((priv->req_state == ST_REQ_MPFILE) ||
+		    (priv->req_state == ST_REQ_DONE))
+			return HTTPD_REQ_OK;
+	}
+	/* continue when more data becomes available */
+	return HTTPD_REQ_OK;
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	struct httpd_priv	*priv;
+	void			*ptr;
+	u32			shift, size;
+	enum httpd_req_check	ret;
+	struct http_reply	*reply;
+	struct httpd_post_data	post;
+
+	priv = tcp->priv;
+
+	switch (priv->req_state) {
+	case ST_REQ_DONE:
+		return;
+
+	case ST_REQ_MPFILE:
+		show_block_marker(rx_bytes - priv->post_fstart,
+				  priv->post_flen);
+		if (rx_bytes < priv->post_fstart + priv->post_flen) {
+			priv->rx_processed = rx_bytes;
+			return;
+		}
+		priv->req_state = ST_REQ_MPEND;
+		priv->rx_processed = priv->post_fstart + priv->post_flen;
+		fallthrough;
+
+	case ST_REQ_MPEND:
+		shift = priv->rx_processed - priv->post_fstart;
+		ptr = map_sysmem(image_load_addr + shift,
+				 rx_bytes - priv->rx_processed);
+		ret = http_parse_buf(priv, ptr,
+				     rx_bytes - priv->rx_processed);
+		unmap_sysmem(ptr);
+
+		if (ret != HTTPD_REQ_OK)
+			goto error;
+		if (priv->req_state != ST_REQ_DONE)
+			return;
+		break;
+
+	default:
+		ret = http_parse_buf(priv, priv->buf + priv->rx_processed,
+				     rx_bytes - priv->rx_processed);
+		if (ret != HTTPD_REQ_OK)
+			goto error;
+
+		if (priv->req_state == ST_REQ_MPFILE) {
+			/*
+			 * We just switched from parsing of HTTP request
+			 * headers to binary data reading. Our tcp->rx
+			 * handler may put some binary data to priv->buf.
+			 * It's time to copy these data to a proper place.
+			 * It's required to copy whole buffer data starting
+			 * from priv->rx_processed position. Otherwise we
+			 * may miss data placed after the first hole.
+			 */
+			size = sizeof(priv->buf) - priv->rx_processed;
+			if (size > 0) {
+				ptr = map_sysmem(image_load_addr, size);
+				memcpy(ptr, priv->buf + priv->rx_processed, size);
+				unmap_sysmem(ptr);
+			}
+
+			show_block_marker(rx_bytes - priv->post_fstart,
+					  priv->post_flen);
+		}
+
+		if (priv->req_state != ST_REQ_DONE)
+			return;
+		break;
+	}
+
+	switch (priv->method) {
+	case HTTP_OPTIONS:
+		reply = &options_reply;
+		break;
+
+	case HTTP_GET:
+	case HTTP_HEAD:
+		if (cfg->get == NULL) {
+			ret = HTTPD_BAD_REQ;
+			goto error;
+		}
+		reply = cfg->get(priv, priv->url);
+		break;
+
+	case HTTP_POST:
+		if (cfg->post == NULL) {
+			ret = HTTPD_BAD_REQ;
+			goto error;
+		}
+		post.name     = priv->post_name;
+		post.filename = priv->post_fname;
+		post.size     = priv->post_flen;
+		post.addr     = map_sysmem(image_load_addr, post.size);
+		reply = cfg->post(priv, priv->url, &post);
+		unmap_sysmem(post.addr);
+		break;
+
+	default:
+		ret = HTTPD_BAD_REQ;
+		goto error;
+	}
+
+	http_make_reply(priv, reply, priv->method == HTTP_HEAD);
+	return;
+
+error:
+	priv->req_state = ST_REQ_DONE;
+	switch (ret) {
+	case HTTPD_BAD_URL:
+		http_make_reply(priv, cfg->error_404, 0);
+		break;
+	case HTTPD_BAD_REQ:
+		http_make_reply(priv, cfg->error_400, 0);
+		break;
+	default:
+		tcp_stream_reset(tcp);
+		break;
+	}
+}
+
+static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
+{
+	void			*ptr;
+	struct httpd_priv	*priv;
+	u32			shift;
+
+	priv = tcp->priv;
+	switch (priv->req_state) {
+	case ST_REQ_DONE:
+		return len;
+	case ST_REQ_MPFILE:
+	case ST_REQ_MPEND:
+		shift = rx_offs - priv->post_fstart;
+		ptr = map_sysmem(image_load_addr + shift, len);
+		memcpy(ptr, buf, len);
+		unmap_sysmem(ptr);
+		return len;
+	default:
+		/*
+		 * accept data that fits to buffer,
+		 * reserve space for end of line symbol
+		 */
+		if (rx_offs + len > sizeof(priv->buf) - 1)
+			len = sizeof(priv->buf) - rx_offs - 1;
+		memcpy(priv->buf + rx_offs, buf, len);
+		return len;
+	}
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	struct httpd_priv *priv;
+
+	priv = tcp->priv;
+	if ((priv->req_state == ST_REQ_DONE) &&
+	    (tx_bytes == priv->reply_fstart + priv->reply_flen))
+		tcp_stream_close(tcp);
+}
+
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
+{
+	struct httpd_priv	*priv;
+	u32			len, bytes = 0;
+	char			*ptr;
+
+	priv = tcp->priv;
+	if (priv->req_state != ST_REQ_DONE)
+		return 0;
+
+	if (tx_offs < priv->reply_fstart) {
+		len = maxlen;
+		if (len > priv->reply_fstart - tx_offs)
+			len = priv->reply_fstart - tx_offs;
+		memcpy(buf, priv->buf + tx_offs, len);
+		buf += len;
+		tx_offs += len;
+		bytes += len;
+		maxlen -= len;
+	}
+
+	if (tx_offs >= priv->reply_fstart) {
+		if (tx_offs + maxlen > priv->reply_fstart + priv->reply_flen)
+			maxlen = priv->reply_fstart + priv->reply_flen - tx_offs;
+		if (maxlen > 0) {
+			ptr = priv->reply_fdata + tx_offs - priv->reply_fstart;
+			memcpy(buf, ptr, maxlen);
+			bytes += maxlen;
+		}
+	}
+
+	return bytes;
+}
+
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	struct httpd_priv	*priv;
+
+	if ((cfg == NULL) || stop_server ||
+	    (tcp->lport != HTTP_PORT))
+		return 0;
+
+	priv = malloc(sizeof(struct httpd_priv));
+	if (priv == NULL)
+		return 0;
+
+	memset(priv, 0, sizeof(struct httpd_priv));
+	priv->tcp = tcp;
+
+	tcp->priv = priv;
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+	tcp->rx = tcp_stream_rx;
+	tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
+	tcp->tx = tcp_stream_tx;
+	return 1;
+}
+
+void httpd_setup(struct httpd_config *config)
+{
+	cfg = config;
+}
+
+void httpd_stop(void)
+{
+	stop_server = 1;
+}
+
+void httpd_start(void)
+{
+	if (cfg == NULL) {
+		net_set_state(NETLOOP_FAIL);
+		return;
+	}
+	stop_server = 0;
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+	printf("HTTPD listening on port %d...\n", HTTP_PORT);
+}
diff --git a/net/net.c b/net/net.c
index 809fe5c4792..ca761c57372 100644
--- a/net/net.c
+++ b/net/net.c
@@ -111,6 +111,7 @@
 #include <net/tcp.h>
 #include <net/wget.h>
 #include <net/netcat.h>
+#include <net/httpd.h>
 #include "arp.h"
 #include "bootp.h"
 #include "cdp.h"
@@ -575,6 +576,11 @@ restart:
 			netcat_store_start();
 			break;
 #endif
+#if defined(CONFIG_HTTPD_COMMON)
+		case HTTPD:
+			httpd_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
-- 
2.43.0

