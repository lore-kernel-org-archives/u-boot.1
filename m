Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4E8C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E9D88C08;
	Fri, 23 Aug 2024 22:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="q99vRZgN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC6388B23; Fri, 23 Aug 2024 22:45:42 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C291488BEF
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2HYiBmkjPpgmIQRd9KjFA9L6B4eeGE/eUGU5Y8QOhdFVtt24ndnQ29GiHiQ79yJr4VcGce0iXi8QHOb6KIpCjjlnprSxLzRaZ2YRHIsCf4gNb2dPqzh1Lkx393WvEPoPZ9GfwcvAgnqLMOGtq3p/i2nE3YwWvG3NjQUilz5bbMWi1kfLROATJUsNcahUjYCqEMg4DtxLjTrBxxS+cemXWTmzwgRXys1ioBiIurQKX/zVliSaTz7WTiLYrPDvQFtIGnje++Rs/mKzvxGzvJuz58PKQaN90BUMR7s+3yNj2MHvfb4BLVy8Y/yqaojvww3YXwKolpeNkJMshYRAQMjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0hnWHn+N8axKnxMVmTpRq/PkUgWqTf0fBcoWsa7eVo=;
 b=iN/rnCheEQdh4QVcTnW/oTHixkjbP4LDbfakBXm+ss3pP2ikJSwa0JiPzGJjUJkHAZJ3AwZnZaek2UDiNumt3FV/QuXkXTrh8jAIfS0l+FYbbBJ9/Ssq1cbYRKLI257nielQEe/+iMukJ940nv/239qxKcDMfqJen3aPpvMqUtDDA6Obm5GYg2Eb4B+OgnAhgBgxLfuLVdqQaCtfRwSrE7QoH7AQZjmH9vKvfkeR5gVqoo4RKGv2Tq6zUCLXE2uGRbqSkv6gdW7mVHjFc0m84yZgeMa+U4P1ZFCxYmoB0NEXTRl7L6RRlIoFJUo6CuvQc4EHOG4QVcYbd2jn7f710g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0hnWHn+N8axKnxMVmTpRq/PkUgWqTf0fBcoWsa7eVo=;
 b=q99vRZgNBoXuDwEVI6ajuKJEJkG4AtsFXxKq2h3tOURlV5gYx1lECbh9mmqkfd21a4hgZqhd7g525CJXAYHtEULKAeHHUVLJ+kCekG/zMHvcsgvZKSgi07dF99rXn5iTDVlWu+TaDvoVuwC5is3A5s6/bCfdN9qYX6H/wHSZEwN24lqts4k1h8nvLLE0wIkulqMXElUdkcppWgaw2qeExOGo3IQ8vDsV88XfvpZs/yZrHaOE9iXidOYc3xnnjAWJOlpFgPLgvw59vEDi7WICbpUEsEWtNZnG1O/TDgh2eJi49GmQNUwghpiGhccnRRqf7VxoUBsNcUWYSVGUqWE0fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11224.eurprd08.prod.outlook.com (2603:10a6:800:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.12; Fri, 23 Aug
 2024 20:45:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.010; Fri, 23 Aug 2024
 20:45:38 +0000
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
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v4 9/9] net/netcat: add netcat over tcp support
Date: Fri, 23 Aug 2024 23:45:18 +0300
Message-ID: <20240823204518.1010194-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11224:EE_
X-MS-Office365-Filtering-Correlation-Id: 5baa221d-e476-4f43-940c-08dcc3b48b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jNeWk97OXRzD8U06IF3ZeYdp2qULrirxZJOZohO2gCE99YqOZ+0ktsq5LBoE?=
 =?us-ascii?Q?TFxTSpfXflSSeJMIRdNR3wguvBDzYNASN44hggcfcvjdUuLu9L3iX4jPGebJ?=
 =?us-ascii?Q?kyPRI4w3nCDTLXi9pimO64OdxQ4HvT/vjj3El6U7gmfS5uhJYQ8TfQ0ol4NQ?=
 =?us-ascii?Q?7c8fpXZkFtnkADWQ+pFBxgtT1Lb+D/f6YodbKROt+FeXXvMy6qmN73YU/0ms?=
 =?us-ascii?Q?ifeD2aMdTjwketizLJZI9ukg6m9bynsRSemDk3EX73RvbutqgwMUy8leqi0D?=
 =?us-ascii?Q?PIRatLABQFsoQyHrVf9MCwIJOTKYRz6oObMeMGNox3a26moxldozxF9QON1n?=
 =?us-ascii?Q?GdSbfyRtMWz/1z0XGEDyA6dHHN3Fx4ykaKuqxiTfHgRSUFV5tSlRJG90SYgs?=
 =?us-ascii?Q?cFNShbMraTAi2IqbJjpu+3mWRXk4fyXSEcguMr66FhTET05O4FMmTQHKbPmX?=
 =?us-ascii?Q?7omsA188irfO/RXBz8Fn89MPLTqVw9g4928NXRRs41+UkSuFw3Ifuw33krch?=
 =?us-ascii?Q?U4eS1e6L0U6GGEwdjADiyMbAcNgWAc1bI0ijCQY2H8/ehKssU0RliAvvjWDP?=
 =?us-ascii?Q?iq3u4gRBMg2dwg5mEIsaoDwsmgIEmmCKORN9JDx6Y97Ir5ugshlTrL3HX4ZW?=
 =?us-ascii?Q?H4+jW17AMNfdam9a1gA3f3OAkT+380H1AOwGU29h3kT4KgV6Bk8oa9ih5CRb?=
 =?us-ascii?Q?CEdBf3U72CJcADlXR/xYteSJDkHX0L3ENsHjaXJIWuYdLZF6XAl9NYTy2H6W?=
 =?us-ascii?Q?hqzyS/5NfTGcvAfgBL56aJvz05CuMFru3F+i+LybBeKiATnBOWnnyS2sNWiA?=
 =?us-ascii?Q?uqeW3XhYAf2xGMUafuGb8HoiL5crVpf50ulZUl3bzSItEOPpW1BMErmkR9E0?=
 =?us-ascii?Q?TfJz4XQRP6a48Hk5zo+zvF793AkEqMwD3jlqu5XEMjWy90+V8MPa+bjeUrX9?=
 =?us-ascii?Q?M9MrszafYLxQTrYGg9rI4DguHCUY142KByv5AQk4ImfsH7VnpeBBeaxTqZYO?=
 =?us-ascii?Q?6d8OJkZoakUlye5RAIoa6tcal2TzYM7F/6LjxGgYaEkB5NncECBrWtADYNsk?=
 =?us-ascii?Q?WC23BJVww7t5+G01TWIvbZhB/zitHGf3i+gM0OfjHboVOiSaaZnHv8rRZOil?=
 =?us-ascii?Q?K41WtyphwnBmAP8rEJfILVuNVX8+p7ye5pO319PWkzvbXb1l60TAABXyOQ3Z?=
 =?us-ascii?Q?B95M68pboYiU+0u85v+Olj9br3Sx0xAPRr7CCWf27b33Q6xMQ1Zo/vZtH3oy?=
 =?us-ascii?Q?FPhVRKM8KIybuGD6rZqJ7WdMINA8ybRW+JKyG6Nc7W0f/ABRS137P04rhjHD?=
 =?us-ascii?Q?GGWp3zn2fzCTHS9Beo42FEG+0/U9jEbpJxbRDaBWA9sv6S6S5mKTvfE4fOEc?=
 =?us-ascii?Q?SYA4zQcilTmbbtOQXJ4EEvKKqoq7ZnAPoc0vykUK+0q73eWXxLdxxRUi8cna?=
 =?us-ascii?Q?+PRN+qrd5HM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Nvfq16XVzaCW4Zkk1RpkWMj0Qgpn/o5CeK807XqdBlPXjlg9VPICHe94i+m?=
 =?us-ascii?Q?LECK64WhdMgRYdfFIa/Mdb8WkifIZ4jU5bv0oFDqdJ2p1yidM3WNkdII5L7s?=
 =?us-ascii?Q?SYqqaEreTf0+v2XUMqIyjDHoKDqkanyE4sbjve/kX43FEbTb+0RuhQeNwhZm?=
 =?us-ascii?Q?6wxlAKkTyPR+4yC3rZpY+vD1rCwP8PdHFNndTvWs6NSeU31HDk7EmyxAsHD9?=
 =?us-ascii?Q?HPwgm53o3nMq1I5mr77+2DeP7RunXZaFhJBIiciFjjcVJVDFEAtVzIIbttSf?=
 =?us-ascii?Q?9t6Xd23JpMkyBqAS7zGbrB619xk6xJ8nQ9B6og/o+C8/1GtlcoWnbjN9X62t?=
 =?us-ascii?Q?TdxcFHNILp1ApubbFa1g00A4GQ1jJqR2G9z3JQbezf8UxNcGKAtkfCojMAtQ?=
 =?us-ascii?Q?6DhX17FfyoeH07qtRfX1qs/r7SfwwDun6pH0J+8dcvtrO91gBAwZsLO/BtLO?=
 =?us-ascii?Q?hhejBWfzZZ4ngFjN9yrApK7yMqJj6xE4ewkfEUcGSqH22Zs2PgmerPmPClB0?=
 =?us-ascii?Q?cC4DcwLcnrmLxTGSeIRQVZw3N8lDhkgbGm6JxvjqWYjRzWSHJ0c8BtD1z9GZ?=
 =?us-ascii?Q?1j0bijFK82j4Y84iC3BZzfTIp9Qh+6WeNjtVWSGO8+hINqZOuY3RRtw4WUZh?=
 =?us-ascii?Q?zaJdordPTa5X6cYcqgLtvGz0kXV0UaowJYnqZGChQ3fcjQG9bAQhskVhi/B+?=
 =?us-ascii?Q?M5m1fzKPQf/Yql+X4KSQyQwW1IsXbl4nBmaRyXFAcSU4LazLGuL3dvxeYZ6F?=
 =?us-ascii?Q?jCAeCQ1Tveyd38/n5b7lf4DCl4EkS8uieNOZmnRxEu4TOkAUFCWoyo3T6Ysv?=
 =?us-ascii?Q?iHbB3Qk9KpVzgvI2rp//FqszjyFDG5b/Q9ww3w1SW3YVjsrxGmH/pmZXgR85?=
 =?us-ascii?Q?Q3w1+VOFn5GfCyaojL+iATQR4UVxgSAZ+WmwNS2R6L6P8gL/I7AwlFu1D2Mi?=
 =?us-ascii?Q?/XSH/ipOtyR2CxfPPIfCEg0IMNkKmxLVGTboEL3+W9V/5vNNVwu5sG08SI1G?=
 =?us-ascii?Q?uEZ6DQ8cCUswccDLbogWlJS0rvtV5B6cYUOLlAjK6jCXhadll++ijsJQxyjP?=
 =?us-ascii?Q?ddYud4w/Tbtrcv9B/kGW/eEOtIUVnSeTlHZiondQufp7xwgj+rfrFzy/aGyd?=
 =?us-ascii?Q?mCDQa1jMLqkw71LX5sUxiP5AA0laWm03nW9iZgAHncTRNgk4PfjpfCTuYqqG?=
 =?us-ascii?Q?aUIeB2e7P4koOJtuL3PF6m5owt2KLbJ3CyvCfhiAQLyhKUca645O0tQkqcaP?=
 =?us-ascii?Q?Rwa8QLHL7tSM8Cf9cyKhqnP5+Pm3xuio3GJjTZ9pM65q5nUnediD7Xn1cYJq?=
 =?us-ascii?Q?6wPZOLQQC8hH+1ltREjAQmCsZoODhtmliAbht0Pw4Gv3wWBaEKV3+CNDabX/?=
 =?us-ascii?Q?smrbY+2uB34HmdXiussL4Z0GkR/AQo28aqkXJX1qyoQsyRzeMeMdxlR2dctx?=
 =?us-ascii?Q?sX5b5j6TRpb3oIZYT2JHhQiXTVPZqvZzGnyUJExlZRMEeFZvs3X/1I91CcxN?=
 =?us-ascii?Q?7sQQmRJgef2zq/Pe6l85WPqPAsIonhLJxcAE/oauZDRS7peapCx8UVxxqfw+?=
 =?us-ascii?Q?h4yQweax2nhK60Uc7/00n6mbubevrkkM4eejDWiMT0h4GZ3wDgplHwpPmtXq?=
 =?us-ascii?Q?GnMIpzvO6SllRn9JZoqsUOk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baa221d-e476-4f43-940c-08dcc3b48b9a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:45:38.4755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcjkurWGje0Tqg9MKqVSswFS77L77OikdKr7kv+4ECi4xwOVwWmCY2r2aFnVAKqDRK1C0Kjh2ftfZ0Dc2uRhk2dUbaF+5EHAc9bvfApFEAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11224
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
2.43.0

