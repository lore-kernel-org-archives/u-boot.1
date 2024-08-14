Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2902AC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3EA88A28;
	Wed, 14 Aug 2024 12:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sGZiEXF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E3188A28; Wed, 14 Aug 2024 12:32:33 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB7F88A3A
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfhK4E/NdAzltsEYRleK1j/oPVri0GkF/QhTN0UHycta/2Rmsi/cfPUD/k7Kk9FgPASBaDvxZ2h57nIIEEIoq0VcxALoYsbb6beefIZM7is6aCWliznud0+C7fIFOPbE8Q7T9qEFye8lJ2MCFUwv8kmold60iBnkGxwWZY+2aSlYi6Qf4BA7Aa3uzSIjkQR0Kl/gswAi9QNfKDqGLF5sJdz+ePImPMmcv0oNBbsNFwnsQwPa8AUkz+1X8ddbIdsdR9gsoQGqCn3DcSX37EZ2Q4n73eztCN9njA1Uko+g2hXz21/fJwV+DLkcvrDf3lNdb3eQxCELakbGKJAwz0+1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwt1UxjoWc7Rg7yveFvfmlE+diEXxPenAePMRF8spy0=;
 b=odEfKBq1wFrh6G4MNv5MJjp53qkPiKin6le/39sqIBKDp/beQCpMVAwHr77Cci920JawXFik1cjFX9YO8HnLyAdHCT6aICqKPiQQCyQvlindD2PfW4DOFWP26X8MCHc2pHNGSV5UrP7N+Kwho5Uxxu9ZMWORD1lQoWc7HDDoRgDr2IOm80e+njBKUH+09h81DzIt2/TLTuQFac/YqopQ+C67KzCUCoq1KtCCS53BGS5wz1YaKjTkWywRouvCYV24O+CL6VjPkOm3RydKtHKIqhXpJw+PQgygXUh72Ipghb8kWQtUrskdPmOR0ddV7e+bO25D/nRS587c+hAoeQI8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwt1UxjoWc7Rg7yveFvfmlE+diEXxPenAePMRF8spy0=;
 b=sGZiEXF30eikAQ5UPlkFLLTDNHDlZsctb9PtHl/TEsAAfM8oGGsKeDTEqliCOYzcUWyLawuy0G1lsHej2gxJ5PI19o7jodKtdXpaPKYuYNrO9KbgPIrTwy6Zh+Xbpf8D/KoXHismvI8F2iJ7B0lItTo/etEqn85HQWmG+TsyQWSwwdbI6s+xfl6X07BPVb5E2NecC7cExIaLDDrw9DiSHCu03tGWX5WNwtJRmZArzvo2QEgXGU87ptLgCuXnA6C62PDuSQPVzy8Oh9HVhvzWdOx8KDp0YZPY2dI8vnjaGELVXOQwG1R1/mLicNWGR1pfpu/gmvbzdgxPy2POcHgDUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Wed, 14 Aug
 2024 10:32:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:32:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v3 9/9] net/netcat: add netcat over tcp support
Date: Wed, 14 Aug 2024 14:31:45 +0400
Message-Id: <20240814103145.1347645-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM7PR08MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8a9eb9-b445-41b8-f4e9-08dcbc4c64ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|366016|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iV7nWy80cpcOOt5YwEo3ceCdlmS8/yUiIawR9WwRphB5maikC7SzGHor+Rdr?=
 =?us-ascii?Q?5OjW0+SFwW0IUfs3SriGF7xOOdedkleDd0EOJXXhcicTQW9769agmOWonsuq?=
 =?us-ascii?Q?kUO382BxIHV1k/rZquY9mLJjId36wYU8qJg6A6kX56Ul+j57pBaFDJUODEAu?=
 =?us-ascii?Q?6TNPGxDiNcdsEP+QOYNkus7y5cSOxRn/b0k9Wtv7V3Di8DEL4y0i7sr91ZNP?=
 =?us-ascii?Q?bCqP4t9GfUru1Cz1SDjUJOQpga6MqHJ6fdCFPbJQigGFPyrxVvXD8XaT4Ade?=
 =?us-ascii?Q?wjHYkVUaRpiD/PUg1Dpq4zS9iFTnfv8Z6dimoZFH8eHZUHN8emx1OOjFe14p?=
 =?us-ascii?Q?IDFMJaTb4qla0kGO9Ig9CpckYRsaZEVqYLb24xTqLT5pQUEuEbdzPKsFagcH?=
 =?us-ascii?Q?0eHwAdSTwYnRjIeZPbDWZXnaSJEpR372wxeoH8yQ1SZ58ME87jZUwbJPK2b5?=
 =?us-ascii?Q?HwS16UYsWGedlQSJLwcXGtkfrpcUojfiQCBhHa29HkBCHkr2wfTjdxpcSWUa?=
 =?us-ascii?Q?z+TiRSHa2q7OKnYd6Vy0hg0NWnkLCsGnzaFUhsZB0GVrxvLIT1tTY5Evife8?=
 =?us-ascii?Q?Xg7doY3zU0vLY5f0UmHFjXshMUV1cGu/zn0mzuKcDlnqvOmIS+gitzPuttev?=
 =?us-ascii?Q?o80ZTu5q053K3owwEIK7HOKYvgbTsQgyZNFPJoMxb7FTayUANL6BPbY3/cbQ?=
 =?us-ascii?Q?pMcjX2jnwL+888OZP4ccDBqK1f6vm/pJRpHOcineTHuzO0pqKt0r/iVAucht?=
 =?us-ascii?Q?/QTPWsIp217nerVeZOxBp5nDzjD0lEYtm+8SFSzO6peIGE0jaQtH1Fkdtvgc?=
 =?us-ascii?Q?NH8CJXysYBW5j4yDd40VuEZmFKTXtwIASQ57b05eOgaYedC+dN746ULbxmRT?=
 =?us-ascii?Q?ZVjLGOMQCQ5bAG5xiJYdej6Z23AkmnBrK7sqUBMGTR0yjIgGfBwUYMy37jv2?=
 =?us-ascii?Q?u91b3lj63ZTBpO9NVPk++k4+T1sIZBEOBBKV9PlAy8oTkO5eBTHeaPefl4el?=
 =?us-ascii?Q?qzdwltdIRVTOPmW/1JLRo6UnTk0Vlapook36MtwHR3TRZWWa0VcI9KDZ6VxE?=
 =?us-ascii?Q?l+RO4fS+IqXQq/uYGpguJ4E8jPs8+YcQ60+8CuQs1g8fMvCF99Oq0KlHUgsx?=
 =?us-ascii?Q?0IpbTQV4n7h5Sq8wwPal1QhoVxPI5BYePvGHwLgpdE2wYGaHvF2f5CGcna3a?=
 =?us-ascii?Q?EJVP8TFb7iSnC0T6b4AUiAbZL6C14m2NTbRZPrhk4HXMIUQeqWxxTnFw0MdV?=
 =?us-ascii?Q?eQaK4odXSxvPcBQJjCnFLAywx5WPWXVv4vskiKeHXX3DsjqLx6ltc1kTywzt?=
 =?us-ascii?Q?2IgAhr9+I4Q88idYT2nB1xog03b51MNh6uGbzdmi2w0GBOcSpumdnlz2wdQ8?=
 =?us-ascii?Q?L7EmMf93ef3oVxEbhLlBCyd+Cg0l6bQPMmgeCJKlRZ2nS/Am6VkTdMVUH3vv?=
 =?us-ascii?Q?QdhM4Hu4KgU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M2RRYjfpv316VJvJWqwc2dUyUH34U9DbIsltGpKBFGSdLv6/pstMm3qgYOh8?=
 =?us-ascii?Q?qbnRdDEs4mLOuPJGCkGpzlqPtRPub6kTeRCeLVhXHQh3rd4F5bAZKNKcOUMs?=
 =?us-ascii?Q?sZsxjcFXE8xNhUbwww3oiih1a6BaEL8fKxOl0QirLjU+EFPl/eR8Jp2f7Hru?=
 =?us-ascii?Q?wF6xdppWdquB8pC7QfRWOYybw7CJ8oXZzF430/yv5m9Ay7sUUjb7+oKxEaYI?=
 =?us-ascii?Q?Yr3e6vn/pMLcc05oTaQ4aFCgsoMshb8SJFcHcZCUdsTpC0BpH9I1ZYbl2MVm?=
 =?us-ascii?Q?FJP+txeyhDRk3HKY6HGwe8pTkiUueLvGofb/61MEK2XkQ/J9rHlUixO1y6vT?=
 =?us-ascii?Q?GP2qEqEvGwhzB3JzlAp2eC/0oM8QEbc3k48fUf41/9ObQzmdTEhjWlv243ZM?=
 =?us-ascii?Q?/mdjGBwaWRs+EiJPVBMHpulb3f3EnUwiMMYk6JCgprqbMLVX9GD0p/XI0cJC?=
 =?us-ascii?Q?asATMNHTn26RNpseMD7bOPTB31caTn0aTEobdhrkXwE75srit7oWDxyQ1brc?=
 =?us-ascii?Q?SoNUCCRzLZnbfa2B+FeaTMoAd/Gd+K4ZtlZAizLgQ8oNYbQ1fL6IMCLZdCXt?=
 =?us-ascii?Q?aqQY0hsiP4xPRvyvsEnqNmqyoqUBDR3PDkeBZImUwxrl8X2hwyiP7kSCqkLA?=
 =?us-ascii?Q?gA0AWM6hYL2LsMrzisJPMn3qvywg2Y5ysGsPYr4ObWFMo6dC3Ce/IIs1qHFq?=
 =?us-ascii?Q?8fqEFijc4n3SWq4deInF2mQRQcWSAYiIpB9rEmSzCHRRXDnBXkH+EFMABMJ/?=
 =?us-ascii?Q?87JqaC2oAbpjSYDIDM7yb5BaVvU+JeM3G1GV5CHIFqx5D4B9c/VWB64CXdwS?=
 =?us-ascii?Q?OTs0AfwWj92e1ZEmaHKgK0cXtTaKaSs3pUfO9xDF6rHXZ9rb8WUl7xGvfJYa?=
 =?us-ascii?Q?7KVEDMp11GOOfCWVa/XtXtoAtkWpd314zG93MYpHxwC/EH5kZAGO/rJetkvU?=
 =?us-ascii?Q?yo2HOnzcTXtYKA1LyoI35E0GL+pKwPbuMVH3tVHQbIkALCPY4SPDQWhpnO0c?=
 =?us-ascii?Q?lvuh20J2Rp4wSMvcAtnByCSWe8pQ9p78qRLrtScDE/0Ll9+wtJzgQP5Ny+im?=
 =?us-ascii?Q?OwvfJW32sUGuwmeBdQJlmVUIpQqyaTxenlqglDV3sXSASs+O1eFDD2o0XKe3?=
 =?us-ascii?Q?nTn0q8yxRXpxkxSqVMQ8FeIKJ25yZ5b9GWym5fuJBaGSr8hSOAhj3B+0lBw3?=
 =?us-ascii?Q?GBX523MApaZC5f53eXWbkP5V6sWMoQlBssDJfwCqrFdlFqpul0rrH9TN3ppj?=
 =?us-ascii?Q?kOdWL7HQkGoN+1kB/3QusYHzwBZWcJFPqSq6dpURJWBe9jcevIjnqfiY4Lay?=
 =?us-ascii?Q?CjVY2/Did0468DP1PMQMEPNjUtsAwMfIYjY+Xwpfm/2OzC9JbD/XRf9xampL?=
 =?us-ascii?Q?jnd6pjCQ3VQ1nX/JFrywmo68Ecsjivyyr+/N/KtDvP8kJQUnXvsZ0D42WOpJ?=
 =?us-ascii?Q?C3FWUgKOP+iWlwCwd88JMgGREcwctfPTcxj/YbQ+7uTumx7rfUyrBATONBDN?=
 =?us-ascii?Q?jQMOwzCBbR0W2NztltY0Td/wz6mUKtkgCGIZ+IdNLl1Fi2bRM5XV5h6Tl20T?=
 =?us-ascii?Q?Y4HBMbx0OJabPabsCv2ErWZ/uDtHzU0D3lYplZaE3x1lRiz0K/Ig0fWIHbID?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8a9eb9-b445-41b8-f4e9-08dcbc4c64ae
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:32:27.4295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrznZiysJ7yyD0wF4bclzgYTR3xkpgtEn7AG7Qvkfs1M8BZGKtxbpOEu67MFoWGzp4RmIYHcVVTrwQvvIu8gucEXtH2ksut+Q8xXf4J77c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
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

