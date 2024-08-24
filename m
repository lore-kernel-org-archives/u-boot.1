Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567BDC52D6F
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 09:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F168588C7C;
	Sat, 24 Aug 2024 11:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zBmJoJjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C072888D5; Sat, 24 Aug 2024 11:27:44 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E02288C53
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 11:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO/SBvAyRXVwgsLzg0d53nLaCOFhrpatm9EQwketlc4CS3vg9LATKkHKaCtc1fSHRIFX/lr/DwrvZP9fws/798xiSiVqNckuFY3VZHGSFeXxGyKJ4yxGXd7sxhcYM+P2iPPibpoaC+tW7QI83EtsdYU7N6doYmneRnuhhpxL8mzh6JfY/V1qYIvPp/MuTU9llSXChjb5uDG8k5FDG+jdj1lGTacZIsqIt4ph2QJOYqaEKz3mB9Ez93cKfn9nj3OxW9nnGgfMH0NzMmTjfo/RyUTTcaTNgVQtj4rHoMBcYibMRUDJoFG+YlPTFihGmTcaTnpRMdt4XSHljqAWbjN9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhwOxvBlcDYM5Mlz8B4oX9N9X3P/WY70hcpc+Yw+tDw=;
 b=le6nmLVEthesJTjueV9m1zs4fLfj2ShxMpR1Kqs1Nct9dCrNf20UNlbWLmTz6qF6Ex3TI93fnDbEJ6uJJlZfiN41wk1bn5XP1DLdPXiyvDy1/9TV0fcsJWkYNwwoIAU1cVjIceLfhUMwptmnH1YvdhjnMIzh9Z8Jxu9n98pzMg2NdRt8ei544mrf4F9Tuk37/f3wXzkpL0YnjYrInQKmBADhG8b8pX9oajWRDuWUfSbiAOhVnFtd7F7/cSH9bq9Rpj9wG2knfYNI+oqiG6CbsseQcebiONB4DzDJndDxktVm00+LkBcSvu2PkBVMmqBJMoCUZEWdjsp0445fvPntXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhwOxvBlcDYM5Mlz8B4oX9N9X3P/WY70hcpc+Yw+tDw=;
 b=zBmJoJjncJJGZifFZtXB2y9xwVsIO+lkIr3qpTBxprF2QNi2WQ0Ov18TCOhrkL0g/0TP0WzZ0co1pxK+oaVGuTJrM8+hM734ltLuGK/C4+ekMk14AyMsF5X5D3eo7V7IToZPlrV7RHMrF7Ka2PCpIAX8HX6+27SqbdHMr1oFobxL6JbZtsI5ReC0lczMGLMCOb5rgUzJGEglfaowrZfnC2DKkgiy7PfpeJ1w+Syf80Ma4isTUQL6nRxSiR8w4UU7/3FgdtsJaDLBBjkQsx3NFbw5M0H8Q2pe8Qi0UNIocv6Jsytu25Zx0IizTdZcsiA4YDKSlMxDEXHpr3FqK9QaFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7445.eurprd08.prod.outlook.com (2603:10a6:10:36f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Sat, 24 Aug
 2024 09:27:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7918.011; Sat, 24 Aug 2024
 09:27:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 10/11] net/httpd: add httpd common code
Date: Sat, 24 Aug 2024 12:27:15 +0300
Message-ID: <20240824092716.1042696-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: f68e9572-0322-4e85-6a39-08dcc41efedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nWIQhAw4Ql5aKadT9Z6bnic8P50Sg46pGPs6drvHkqWgeDfLYgdE3z1mwiUn?=
 =?us-ascii?Q?1EC4EUhB4TB/f1kIEsftCqmMkRDUeeCSX5zxGuC9tDKeTSNs/E2m6FiLc/UO?=
 =?us-ascii?Q?v4jfkOReLMm8BvBcAHyndIpsOKuIUP9mrom0WOlGz+nNAxtkD4Q6bBmsVryy?=
 =?us-ascii?Q?ulNJ/8SoIhRjY0vQoP5K1pmiRToMkpy3G8KMyB9hvC6ziYcsgQeKrcFQpJZR?=
 =?us-ascii?Q?jWPZTv8r41XdtzynvYzRgoOZSU8Exp5puT84w5a8avcI9DBB6Ef3d5T1IiYo?=
 =?us-ascii?Q?K1+GuFQhOgPQDPgIEabFEVEMHDzZMp+H6ch74WtMOGuM57lxYD+dVO/zM2YP?=
 =?us-ascii?Q?GPBmdr/VVZYx39dWrUsy1Hp18Fr5IBSB38A3/FBe0n7OBwadb20J1p0ryN12?=
 =?us-ascii?Q?f2p2lh5Ma9f2hWeDBIM7HolahY8L3SEA47OoyWXI05fPg8J0qQjpfD7WKboI?=
 =?us-ascii?Q?FcyjMhX6ubVKDU3Imy29V6fBzrD3ZMRlcR7Pnv5DLD3wGHIqxrcrb4DxRU0T?=
 =?us-ascii?Q?xCYTrO4BqgpNj/bSv5HVPlX9QDeXXYnOV60vD5jDZ6ErdZ3zfFmuFbpNYPQj?=
 =?us-ascii?Q?pS1OwqrJLtKYFmVyTCHZzv9Jkn5eegZi+O3MnFhOI46LxU1hRA89z6ZDjgyS?=
 =?us-ascii?Q?UyQOefBed6CLSyiUwf7jdBykqNDFI2o6ijhIWe0KXMFgWsICGf9xYaCmXgFP?=
 =?us-ascii?Q?DOwcoDlEei6QNnioDf7Dv5sgjmlownS0Q1wrg4U7d9R1Jk24ed3uvSf7oKn8?=
 =?us-ascii?Q?R9OzzK3wEnDLfjwEisnNa3wuXBPc+dTLKvIfPdCydwDw/6jCc3BnRHaqqLHL?=
 =?us-ascii?Q?kMHVmiValmHfnGkawx4TDvoEAZAcNtTQUhznv3XLrwWuQ5syT9xgutxegX/6?=
 =?us-ascii?Q?vV3sYrrUpPDapUKqn1mWY7xIGV8zFktaLbDbkSoy8nMfV8QmMKe34HCU3DKE?=
 =?us-ascii?Q?xe+6pqGZyJnuWGtQrrHgIi790vDHdFCqrAwMdPa0Sgq5MKCJlvcEiwWZzAkC?=
 =?us-ascii?Q?4IogWxzCUCkepfm7HSi336LWdjx1ptQqz2Ulmo7uyhlGfvC4bCC9GqrOHIAK?=
 =?us-ascii?Q?aXQtztLHWSoQpAjqhOxcG4zNa+06TfLrUGlOVoXcrGmbPbcHgLAELMseaLHl?=
 =?us-ascii?Q?43r3c+ArUaqws7fN0wXIdWNHtCXjjNM75cUAsKL4owCXBRY00Fsgmhvgdgqg?=
 =?us-ascii?Q?FfKxVZzlVH+hN8aaDsRHO5ClqktEjbr8DUoE9RTIp9xMtKXTPv8ememSyNFJ?=
 =?us-ascii?Q?sza5ezO9if6/1il+r7K+vljVo/KtHQ5SzaTZdsqz5dlpG94v3UWV1w3Kd3mK?=
 =?us-ascii?Q?jgeO9iHbV4XWDsVqXaH5SosEEwz+nkexGUnW2eR8yvm7odkVxCkZdni3Ze2+?=
 =?us-ascii?Q?nhoWOJDrMkbahV+QVoqSAoUrPXbzcLSZcYdbV00SNxHgD3c2ke0abtQU0qi4?=
 =?us-ascii?Q?ELdY0UWUh6Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EabD80awRGLdWpzCl60mXNdaH1R3oopJRTy/JkuhQ92yLyZP7SbI+D9p35Ei?=
 =?us-ascii?Q?ZbJJiKTNJ3cRFINxszh3nGP7e/88H/HMB9EvLB3QlxdUYtKayBzYqO+buM2F?=
 =?us-ascii?Q?uYA2sosEks1EJkXCwMVcGpYFixrCuWTmBLw40N9oUohcvTJ0rau5ikp7QLfU?=
 =?us-ascii?Q?gRpHEpG7G39t9bi+N+CtP4ErxBAcBBT5B0hxI2Kpnsk+LTG5I5VHY1f//jZp?=
 =?us-ascii?Q?FxsIj5Zd1foGLrqvSeHeCqBa1yanzrtply5/uEHBmwcd7itTLQlXiuKJrjfw?=
 =?us-ascii?Q?gAWaDWEOhI2xiT5pxK9xf33mo8gTSq+ePOjCswYzKBCdlwN2FF2Z30snhOuz?=
 =?us-ascii?Q?7UoQu4t6nIgTsF7BWtsMzSjFib0tJjGjAX91BAdAQ3cHUALKTmRunH/Tt2nH?=
 =?us-ascii?Q?Q6lm6Nuhg69ULQcdSSEJgvkWppDljn3pIULhLHGCGH+NEDtIUouL5b4ne8Bb?=
 =?us-ascii?Q?183aNzgJz9viWqBtuoEyGpfW3G0ss0FXkYzhNBaj2DEJ0YXglgems3NaQo7u?=
 =?us-ascii?Q?FrJEvMOW9r7eHYY6ssJk67bSB2uELjPJoDtHcH917f8kZDmVXc9ZlaFg6Rqu?=
 =?us-ascii?Q?Tq+IyEgATXjsHrGGN9lebmK3c99C+ZAuySUqBZzEAKjC5YRkueG4AWSadV6N?=
 =?us-ascii?Q?n0EAHxdpcB7a5ZyghYIbsWtFFpyodWDQebgdd/rd1ouiAjBd3Qj/6eKNhtz3?=
 =?us-ascii?Q?H+UF95x6dQcCdMfUBB8KcskSbwj1HnUBZYl2i8ovuZUA2tyBBaaqF+bXzvdS?=
 =?us-ascii?Q?Wmm0F9s7AsaY35L7SVxx9tyEXNp8fpvuUwoTtvazZsqPsndF/KVzgt54ZOg5?=
 =?us-ascii?Q?M3pLQ/NLTRpKP3E68k0bzhZsdW8hrYFLrtRrRI+CSTAV8qfnBsk6J0jd3z/K?=
 =?us-ascii?Q?MwIc8MXl0zAJ4dyTaMKnZgIjQA8o58q0j7KXXot+/Z14GE8omwfGyP+88jNd?=
 =?us-ascii?Q?h832HaEsSfSj//gfqBmfunXcGDfLKR/6UlXsNnbGL7W6qDBkd8ksjITqEZu6?=
 =?us-ascii?Q?yuvT4BturVsfBWrsabsLOxIQR5k3tmLqwUCHmojHgONG9IO5YwCopnvhuWX6?=
 =?us-ascii?Q?cIpydzQN7bK2oI8bLXClC6RP09ecg7djOJCWqQ/rJH/YpWujutap0XjBPFPb?=
 =?us-ascii?Q?zw68SuAXT5+GTcXxMm7TkSkni5aR+hgFFgk2yVWO65eqNf4gb+dR9QpOnLUN?=
 =?us-ascii?Q?3Ekm3OMJkv5PfY309bMnIGKeikhN8ulEp52ZXZbucnJNy7qTuicBCIf4Clfi?=
 =?us-ascii?Q?6+HJgLFeG1vsqbX+J/3Y6c+RDD+9/7uWHxviQ5VwHOs20t1XYtRPQKEpl5w+?=
 =?us-ascii?Q?mxoEj/HW909Sl8MYuzI6c+2FcASbhtkJ2HmdcE702Tebskc5qaoZXzW7hO4L?=
 =?us-ascii?Q?7r7ArXHkECcAjZtG9aRPYgk7kG7mgcN1chS54Vo83rUJKxhoVsSSVsvtSdT7?=
 =?us-ascii?Q?zwpHT7qe8hZO7yFunH5G0Lyk9gYdOfLOcy9uFPT4pEYxpLAvtHNiuwRTCncv?=
 =?us-ascii?Q?ddiUA5zL76sZUoqbKBApQrnTo0ZJ4z5ZcGzncaCyTHF+V+yVO7OLwUvmYJQd?=
 =?us-ascii?Q?lDpq3lnwYuzw3WCyVI4Ael2e183RTmGwJ/7k1Il/FiA3wixE/1q8NHX6K9Xf?=
 =?us-ascii?Q?C4cyYuZeCyTTjJczVNBAOZQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f68e9572-0322-4e85-6a39-08dcc41efedd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 09:27:38.5221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQBAtQJn1T89zBFVPacwYxj9a4cXuamt34UM/jhyTEY4VJcDRvVZOL1vrOUHqfUH/ECr6/C+Jq+frrfeqh791sVzBjxiT7wr3OvR6vDwWBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7445
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
 net/httpd.c         | 692 ++++++++++++++++++++++++++++++++++++++++++++
 net/net.c           |   6 +
 6 files changed, 778 insertions(+), 1 deletion(-)
 create mode 100644 include/net/httpd.h
 create mode 100644 net/httpd.c

diff --git a/include/net.h b/include/net.h
index 0af6493788a..154885a2b7e 100644
--- a/include/net.h
+++ b/include/net.h
@@ -515,7 +515,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, HTTPD, RS
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
index 7cb80b880a9..55739b9bc98 100644
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
index 00000000000..052fae9ced0
--- /dev/null
+++ b/net/httpd.c
@@ -0,0 +1,692 @@
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
+	if (cfg->on_req_end)
+		cfg->on_req_end(tcp->priv);
+
+	free(tcp->priv);
+
+	if (stop_server)
+		net_set_state(cfg->on_stop ? cfg->on_stop() : NETLOOP_SUCCESS);
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
+		if (!strncasecmp(line, "GET ", 4)) {
+			priv->method = HTTP_GET;
+			url = line + 4;
+		} else if (!strncasecmp(line, "POST ", 5)) {
+			priv->method = HTTP_POST;
+			url = line + 5;
+		} else if (!strncasecmp(line, "HEAD ", 5)) {
+			priv->method = HTTP_HEAD;
+			url = line + 5;
+		} else if (!strncasecmp(line, "OPTIONS ", 8)) {
+			priv->method = HTTP_OPTIONS;
+			url = line + 8;
+		} else {
+			/* unknown request */
+			return HTTPD_CLNT_RST;
+		}
+
+		version = strstr(url, " ");
+		if (!version) {
+			/* check for HTTP 0.9 */
+			if (*url != '/' || priv->method != HTTP_GET)
+				return HTTPD_CLNT_RST;
+
+			if (strlen(url) >= MAX_URL_LEN)
+				return HTTPD_CLNT_RST;
+
+			if (cfg->pre_get) {
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
+		if (strncasecmp(version + 1, "HTTP/", 5)) {
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
+		if (priv->version_major > 1 || priv->version_minor > 1) {
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
+				if (cfg->pre_get) {
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
+		if (!strncasecmp(line, "Content-Length: ", len)) {
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
+		if (!strncasecmp(line, "Content-Type: ", len)) {
+			data = strstr(line + len, " boundary=");
+			if (!data) {
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
+		if (line[0] != '-' || line[1] != '-' ||
+		    strcmp(line + 2, priv->post_boundary)) {
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
+			if (cfg->pre_post) {
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
+		if (!strncasecmp(line, "Content-Disposition: ", len)) {
+			data = strstr(line + len, " name=\"");
+			if (!data) {
+				/* name attribute not found */
+				return HTTPD_BAD_REQ;
+			}
+
+			data += strlen(" name=\"");
+			end = strstr(data, "\"");
+			if (!end) {
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
+			if (!data) {
+				/* filename attribute not found */
+				return HTTPD_BAD_REQ;
+			}
+
+			data += strlen(" filename=\"");
+			end = strstr(data, "\"");
+			if (!end) {
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
+		if (line[0] != '-' || line[1] != '-' ||
+		    strncmp(line + 2, priv->post_boundary, len) ||
+		    line[len + 2] != '-' || line[len + 3] != '-' ||
+		    line[len + 4] != '\0') {
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
+		if (!eol_pos)
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
+		if (!cfg->get) {
+			ret = HTTPD_BAD_REQ;
+			goto error;
+		}
+		reply = cfg->get(priv, priv->url);
+		break;
+
+	case HTTP_POST:
+		if (!cfg->post) {
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
+	if (!cfg || stop_server || tcp->lport != HTTP_PORT)
+		return 0;
+
+	priv = malloc(sizeof(struct httpd_priv));
+	if (!priv)
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
+	if (!cfg) {
+		net_set_state(NETLOOP_FAIL);
+		return;
+	}
+	stop_server = 0;
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+	printf("HTTPD listening on port %d...\n", HTTP_PORT);
+}
diff --git a/net/net.c b/net/net.c
index d81604a57ce..0b6cf4ef45c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -109,6 +109,7 @@
 #include <net/tcp.h>
 #include <net/wget.h>
 #include <net/netcat.h>
+#include <net/httpd.h>
 #include "arp.h"
 #include "bootp.h"
 #include "cdp.h"
@@ -573,6 +574,11 @@ restart:
 			netcat_save_start();
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

