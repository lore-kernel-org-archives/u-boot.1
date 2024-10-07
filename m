Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEA9CF8870
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F5F688E21;
	Mon,  7 Oct 2024 22:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nfZcLaT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54FA288E0E; Mon,  7 Oct 2024 22:56:20 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6A188DA2
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEEOikNUzluPZSP6b/OY2rm5Bllm6dlMVLL05SM6mvfCYyDd9jWHW7/5F50RyKq4g828SsueyNBdq2Gd4Vwfmw6lNjO3fJq1+3fR5Lu/UXmAvYfu9QnHRsdkzV733Z3e/6vfUyOTzKWGHEhIQN7klwLjhbSSBRiXqTo4CAKe+lQyp9kTl7RZo8laqNO13M7OdOkWqIYylUZCj2J8BDHyUbmxGs7bvmYali7yyXR13lJIuZBZKfQTDWSS1DzLXBlFHuFApkdLI0ahbemFgiLQYHbufCLUiae3CiMILMwLxOZUHDx+yYbtMgb7WKhwnIYfqdh6nPCexWrY4VwGCkpwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WwK/9FT4GvtiHWrwPPEmo7LCzglLQIUZqD2frkf680=;
 b=RRW3brd9wUCkAQeBKczocbc8Y/zqhcrjdeHUfsiyx+rK+PSH3oiG0L9teZHPfUUboEuuUK+IaAsmo5jF8GfxOR6A2glNmVDBlYcgE1AkDZZeSylHaAREBQqwRYLwauf5ihTpdSMljeIxJcBjO1KaxbmsDg+j2pJtDu5Bz+57SR2PqUjXzJxUW4nNDZx22H/8b8HKN86gWbI4zjem55C5+1nvzaVzwKQwl6qa5B9F4H4dfZP2RoQt+/PFYfmbjuPolcEIDHgq30LkTnev+J2NMfXpVsg8WW1o/d8KUpsZ/OcNg2RoAxJv4hruzVidQLeYVCsIYZ9DnHQspByy8nu+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WwK/9FT4GvtiHWrwPPEmo7LCzglLQIUZqD2frkf680=;
 b=nfZcLaT3vIiCdPBDiTCFYJ+GcLuFYJk0/gM5hfw9LxN6kwEidBgRwciteYGClfWTiXGqjNp2ic6X5cJ9vkFQGjK2MGry20F99AMH8iOlA0lV74/AYw236m6EHXtNc5PS915GU2BjyMHFd67rOUAp/BxWW4X0J5MdzQAJBAloLgk4ustwgMlK2d3cNNZGTI6EYjrM6Lb7xhtMV3ZS4HbsBuyQKAn7cNQfjfdQGHG4MM8ggKPkAN57yMIX44+H+mrosI5c5XaIv06Wh6QlCm+c87gPGxEcbqfwii9O3rS1hl5N6nYMmIAvzQscwVJUPOMHu2bumkhd49gwH44rh2fXhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:56:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:56:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v10 13/13] net/httpd-upload: an example web-server
 implementation for file uploading
Date: Mon,  7 Oct 2024 23:55:43 +0300
Message-ID: <20241007205543.1632499-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce88923-1450-4b0a-9c4d-08dce7127ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KvKLPfZWVr1J5IVjHwIDbyALRrsUk8PAFCEi87JdAylbt5uYEI03xLEzy3Ly?=
 =?us-ascii?Q?Lz5+d4jwKFXJUQImGRyU2vn4iD90U160rwjeEHvTFSostJWkauJ8EGISO8Dj?=
 =?us-ascii?Q?VVRdF20p2Rfs8j3b2az+0FqV92fa3T/MUAxCsT9n4a9PtvrYEPcIsIT3+PuM?=
 =?us-ascii?Q?VU3+eMtgtd4pOYfntjLgcM2rrCbUABvFHp3CNWrJm8RLZQC+I9xfns3YKu2B?=
 =?us-ascii?Q?TLOM/MxeCLjcj6ptjlhyW59kT5CrQgY7dbhOJkaGRYhOpuL/FAEVQfsic38k?=
 =?us-ascii?Q?Lt1cQt0b90j7dTTE07qzPDxBDgzHEBKxFACfm3zpdOrGiXbu5xZW5bixtgDp?=
 =?us-ascii?Q?FhictAmLtyzp1J1jFtT0aal0uY5LUNhLWJ26BgYJT4qlYQV+sqSdfItrD+Uq?=
 =?us-ascii?Q?MEn9Omq7VtA9M67pyayjJmLFjJsF9lcw5MXMituhJc70d1uCjdLOaHlS8qem?=
 =?us-ascii?Q?67dtCA2QdheN4fzr0Hy6yP08/CIG/RwUiUPB+SLt4m9rBt9SrlVLBiLwTy65?=
 =?us-ascii?Q?Lz6xSYJTTyBRlQehtaw2H/4kebQndO2ESMDrrbDHZbf/UA5YkiWLdulvv8WT?=
 =?us-ascii?Q?vT1IqC8vKrxO2fV/ggoyReFsdYQl0UkPsXzonApWkjY7W+dMcCVyJGAazF2+?=
 =?us-ascii?Q?6lE+8nqPBhQkX4LOxP8sa9ZqJJR4+yEmVpgDeEK49IHybyEEVxDB3wtt8gfL?=
 =?us-ascii?Q?b66XgArTAM/cj+DE3Qv8nDj9hUmjUELpf0GhW2hHJqhzwPeHnMaW3rCGEHAi?=
 =?us-ascii?Q?6ul2UNvmrPGyrsZ40KeCra4uJyOm+gGunf472dL7pFOlI3TPH+4gtgD4YvYb?=
 =?us-ascii?Q?z/EIYtHHK327IbCz4FGq4UKNlmrNdlJe96urX7/42sPLMsCAAjIMnYloTZ0k?=
 =?us-ascii?Q?Y4/nlLiei7lHPpm5vLtdjTk20mRICRzFksCdOd/xVrpuea9GpukfhBExBEEM?=
 =?us-ascii?Q?RwfUp7nqTMGSzHx26KFBV8lKtXHX6/5ROByjcewFCFS6G1B20FBhN7/rzMZj?=
 =?us-ascii?Q?lqIKoKbK+5lugBmIuL+oVs6yBjwHieyMZDZKPJiOWO/PtkA5dt2QAiDxYc51?=
 =?us-ascii?Q?UjyHh62bsiTEemnx8ePUeFFZj5fsGc9eEVj+KuG3//ItJ22Nn49cQPvgwQyh?=
 =?us-ascii?Q?safBqdLBYc5xxy7tSeROlSpM4SNXG45OQgsffueUUrIZ1HKs6PO1rGmepFWM?=
 =?us-ascii?Q?3vHItfRNptNl2AkPDX6LNOcb2w5h/2Hd6X2igdqg2pGPB7sjYR5hutQEfqzC?=
 =?us-ascii?Q?FEh9dH8vsgWZMpZiNjdJL1yw72YzUTT3GuvaUQal80vBClbag8G5K4xi3YPf?=
 =?us-ascii?Q?SHWf2/DtH7BTLIFzPSdS1Cjg+6k5p0uFfhbvTh/aVI0cHzoqTC0HNAEunpJ2?=
 =?us-ascii?Q?D7BTFSc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Dt/HgSkdSy0+q0f6nAPVbKbqXaWoluZ3f7W1ZXso+VemVPE/TKf5HxJL7iu?=
 =?us-ascii?Q?1T3vcZHcLecY0U4sbylrekm+C2MROdI7RhZ2WPGSVfwx23BLTlF0hrOp/ccr?=
 =?us-ascii?Q?ujydSa6a1Lyvxd0LVfu7Y+rjygikstSu2XYwPhEL61/GMv5ph4HsvZp1qYgs?=
 =?us-ascii?Q?f2un6H5QrQwd1uBWnWd55fZIWbHeFjjhrsqMZfPJxSm99ZGyZv8cEf66FEw0?=
 =?us-ascii?Q?kaeOPt7nEwVZknLBoTwsb0OPXGkUkJAdGz0IHB4dcGqyXWtFCXHkFBdTXbrv?=
 =?us-ascii?Q?DziX3x2ZdyYbf6rv7mZ62joT/YZE9FpMpnn/ARY1KlAj0DMHASiqwNGoP9Ae?=
 =?us-ascii?Q?yyxd3dkvmvsvM8d6nM1qAT38PosZdReBjT6Zpafm1FKnP99/RVTJLHEtF/Um?=
 =?us-ascii?Q?qNHhcbuOYkcmq8O6Qynf+EP02Gi6oOV+dAy7hXlsnpaf56w5R4+MEPlP8M5B?=
 =?us-ascii?Q?2b9Z5AYhgOHT+ChA+X5CeDFMZs5sY0ewmltXjUSFGN+DPoIYotbb8C71Y65p?=
 =?us-ascii?Q?YRU0sYyUaXF0FGTWlGfz2AFoFKgYICWEAj3mwxGqFIqKkF/MYw7MQX9yMscU?=
 =?us-ascii?Q?WpmLW5GhPKceM8VMLzLMtieDigp3URClD6a9Pa9punRODraWDNsK47P9ocOx?=
 =?us-ascii?Q?ExDwj0m9ZJoT+BEYxtKXRWBhsF+1e0h/NNckeu9X8a5q29/JhJIJvPkBwd+1?=
 =?us-ascii?Q?F26CzkJp8KVkeO8nHTNDGr8aH7/bSoNWumOac0zIqTmt6iHcic3832jXqiur?=
 =?us-ascii?Q?wteMUCZknhceQVG6cJ34Hvk4w/w8Oil3r585iuQ2urAfBwSXGKIABYFfmg+Z?=
 =?us-ascii?Q?4i363Z4IzCfukWWmr8z46XjHrb8D5CgQWk8GFvgXISraUF4JNx7gxP9NO9H+?=
 =?us-ascii?Q?AwD9ObjRaIazhbs80OsNbRzXur/76eXUO9zgwL1wwGMy8JqbuKVRcUf9I3l+?=
 =?us-ascii?Q?m+cLcZXzKI51LJLsGf3ezEd1IXERF6GawwGZVtQzJEBSFmmi/aACSgUWm3B9?=
 =?us-ascii?Q?mNGr7H0mlvQIWR5nbk2+Fxwv3pLGposiToIpU+c5Pq5bStGOAHxiEL+SKDUh?=
 =?us-ascii?Q?bO+niUWaPVKdX/AbEHtLtztqvSmwloaF08Ccoo59GMVeEOkdxOhz/cDzVSbg?=
 =?us-ascii?Q?qfiRa6QoHF7hE/AffviLYdQROnuEmctyBv0Z/WgoSPBpXw0LrUNIvwB+r2zP?=
 =?us-ascii?Q?0r1NSCjTbkgqmEzEDGXyRjWbrDiWsXN9EhDW9rxe8fZ20ohnnhn+XLhQl8QG?=
 =?us-ascii?Q?CtW+FHhTSI6U7PROhNe1z2tg9FcZRT8WCaehMbOhoqQnjnATxfQUHQRsxQq7?=
 =?us-ascii?Q?yG7nL8hwH0xm3Yx3Z6YYmRySrHccUlvz7Rn9r+WB75VmkKAI3BGJhgNt7f2Z?=
 =?us-ascii?Q?FhY7Mj2Rf8gTC+W98FbT6o01B5jT/8gqYAERszIZTR5Ts+h1zDb/UQJq32WB?=
 =?us-ascii?Q?4VxZ4a6OQjNreSbwfjhoR1ubDrdTAJ++9BMP9rGQxW9h/Ql4fAYLElXNd1Ot?=
 =?us-ascii?Q?Lu8uk5UtTHCBoQ0ulSTUR/9SY0z2YNBK9El1Feqd/q++NzuJy9WZ1cmdT+j5?=
 =?us-ascii?Q?vsm+3PcJms4C3ayFMqKiH3Kq24gigRJc2RAKrnKmPESkoNc2jIdYojnyyQpR?=
 =?us-ascii?Q?QyQBj3Mn+cW53Mqazd57haE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce88923-1450-4b0a-9c4d-08dce7127ca8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:56:16.7942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AVwcMw4qjlzuhon8Er+qxomOEEWHpZJHO22IXzg1E8yJw6sKqUpNGIYbTSMCfC8GlrNvFm9PDpN4I8CIXZSc8KfHmNLQ42dOzhgFazPhE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7644
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

This is an example web-server implementation. It can be used for files
uploading to u-boot using a web-browser. It acts much like tftpget, but no
special servers needs to be installed by the user.

This code can be used as a base for other implementations like firmware
upgrade web-server used by some vendors.

Usage:
  u-boot: start the we-server using the "httpd_upload" command
  PC:     open the "http://your_uboot_ip" link in the browser

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig                |  25 ++++++
 cmd/net.c                  |  20 +++++
 include/net/httpd-upload.h |  12 +++
 net/Makefile               |   1 +
 net/httpd-upload.c         | 170 +++++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 net/httpd-upload.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b680cb1d93b..93fb5ba795c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2034,6 +2034,31 @@ config CMD_NETCAT
 	  will be lost or reordered. Any netcat implementation should work,
 	  but openbsd one was tested only.
 
+config CMD_HTTPD_UPLOAD
+	bool "an example HTTP server for file uploading"
+	depends on HTTPD_COMMON
+	help
+	  An example HTTP/1.1 compatible web-server implementation for file
+	  uploading. It acts much like tftpboot command: put user data to a
+	  specified memory location, but no special tools needs to be installed
+	  on the user side. The only required tool is browser.
+
+	  Start 'httpd_upload' command, open a browser, connect to the board IP,
+	  select file to upload and press 'Upload' button. This is enougth.
+
+	  There is no big profit from this code, but it can be used as a
+	  reference for other web-server implementations (ex: web-based
+	  firmware upgrade/recovery used by some router vendors)
+
+config CMD_HTTPD_UPLOAD_MAX_SIZE
+	int "Maximum uploading size"
+	depends on CMD_HTTPD_UPLOAD
+	default 209715200
+	help
+	  This option sets the resriction on the size of any uploaded file.
+	  Please reserve 2--4 Kb more space due to additional space required
+	  for storing of multipart/form-data header and footer. 
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 79bb126dbd4..f2df1eed2ef 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -21,6 +21,9 @@
 #include <net/udp.h>
 #include <net/sntp.h>
 #include <net/ncsi.h>
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+#include <net/httpd-upload.h>
+#endif
 
 static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * const []);
 
@@ -229,6 +232,23 @@ U_BOOT_CMD_WITH_SUBCMDS(netcat,
 	U_BOOT_SUBCMD_MKENT(save, 3, 0, do_netcat_save));
 #endif
 
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+static int do_httpd_upload(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return 1;
+
+	httpd_upload_prepare();
+	return netboot_common(HTTPD, cmdtp, argc, argv);
+}
+
+U_BOOT_CMD(
+	httpd_upload,   2,      1,      do_httpd_upload,
+	"starts httpd server for file uploading",
+	"[loadAddress]\n"
+);
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
diff --git a/include/net/httpd-upload.h b/include/net/httpd-upload.h
new file mode 100644
index 00000000000..a80df214668
--- /dev/null
+++ b/include/net/httpd-upload.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * httpd-upload include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_HTTPD_UPLOAD_TCP_H__
+#define __NET_HTTPD_UPLOAD_TCP_H__
+
+void httpd_upload_prepare(void);
+
+#endif /* __NET_HTTPD_UPLOAD_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index c1f491fad02..c1b41240aab 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_CMD_NETCAT) += netcat.o
 obj-$(CONFIG_HTTPD_COMMON) += httpd.o
+obj-$(CONFIG_CMD_HTTPD_UPLOAD) += httpd-upload.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/httpd-upload.c b/net/httpd-upload.c
new file mode 100644
index 00000000000..8e43860fa74
--- /dev/null
+++ b/net/httpd-upload.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * httpd-upload support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <net.h>
+#include <net/httpd.h>
+#include <net/httpd-upload.h>
+
+#define MAX_FILE_SIZE	CONFIG_CMD_HTTPD_UPLOAD_MAX_SIZE
+
+static enum net_loop_state  httpd_on_stop(void);
+
+static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
+					   struct httpd_post_data *post);
+static struct http_reply    *httpd_get(void *req_id, const char *url);
+static struct http_reply    *httpd_post(void *req_id, const char *url,
+					struct httpd_post_data *post);
+static void		     httpd_on_req_end(void *req_id);
+
+static unsigned char error_400_html[] =
+	"<html>\n"
+	"  <head><title>Bad request</title></head>\n"
+	"  <body>\n"
+	"    <h1>400 - Bad Request</h1>\n"
+	"    <p>The request you are trying to do is wrong!</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char error_404_html[] =
+	"<html>\n"
+	"  <head><title>Page not found</title></head>\n"
+	"  <body>\n"
+	"    <h1>404 - Page not found</h1>\n"
+	"    <p>The page you were looking for doesn't exist!</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char index_html[] =
+	"<html>\n"
+	"  <head><title>Upload File</title></head>\n"
+	"  <body>\n"
+	"    <h1>Upload File.</h1>\n"
+	"    <p>\n"
+	"      This will write the uploaded file to the memory area pointed\n"
+	"      by ${loadaddr}.\n"
+	"      <form method=\"post\"\n"
+	"            enctype=\"multipart/form-data\"\n"
+	"            action=\"file_upload\">\n"
+	"        File to upload:\n"
+	"        <input type=\"file\" name=\"fileID\" size=\"500\" />\n"
+	"        <p>\n"
+	"          &nbsp;&nbsp;<input type=\"submit\" value=\"upload\" />\n"
+	"        </p>\n"
+	"        <p>\n"
+	"          It takes no more than a second after the file has been\n"
+	"          uploaded until status OK is shown.\n"
+	"        </p>\n"
+	"      </form>\n"
+	"    </p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char upload_ok_html[] =
+	"<html>\n"
+	"  <head><title>OK</title></head>\n"
+	"  <body>\n"
+	"    <h1>Upload OK</h1>\n"
+	"    <p>The file was uploaded.</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static struct http_reply error_400 = {
+	.code      = 400,
+	.code_msg  = "Bad Request",
+	.data_type = "text/html; charset=utf-8",
+	.data      = error_400_html,
+	.len       = sizeof(error_400_html)
+};
+
+static struct http_reply error_404 = {
+	.code      = 404,
+	.code_msg  = "Not Found",
+	.data_type = "text/html; charset=utf-8",
+	.data      = error_404_html,
+	.len       = sizeof(error_404_html)
+};
+
+static struct http_reply index = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/html; charset=utf-8",
+	.data      = index_html,
+	.len       = sizeof(index_html)
+};
+
+static struct http_reply upload_ok = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/html; charset=utf-8",
+	.data      = upload_ok_html,
+	.len       = sizeof(upload_ok_html)
+};
+
+static struct httpd_config cfg = {
+	.on_stop    = httpd_on_stop,
+	.on_req_end = httpd_on_req_end,
+	.get        = httpd_get,
+	.post       = httpd_post,
+	.pre_post   = httpd_pre_post,
+	.error_400  = &error_400,
+	.error_404  = &error_404,
+};
+
+static enum net_loop_state	httpd_loop_state;
+static void			*post_req_id;
+
+void httpd_upload_prepare(void)
+{
+	httpd_setup(&cfg);
+	httpd_loop_state = NETLOOP_FAIL;
+}
+
+static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
+					   struct httpd_post_data *post)
+{
+	if (post->size > MAX_FILE_SIZE) {
+		printf("HTTPD: reset connection, upload file is too large\n");
+		return HTTPD_CLNT_RST;
+	}
+
+	post_req_id = req_id;
+	return HTTPD_REQ_OK;
+}
+
+static struct http_reply *httpd_post(void *req_id, const char *url,
+				     struct httpd_post_data *post)
+{
+	if (strcmp(url, "/file_upload"))
+		return &error_404;
+
+	httpd_loop_state = NETLOOP_SUCCESS;
+	printf("HTTPD: upload OK\n");
+	return &upload_ok;
+}
+
+static struct http_reply *httpd_get(void *req_id, const char *url)
+{
+	if (!strcmp(url, "/"))
+		return &index;
+	if (!strcmp(url, "/index.html"))
+		return &index;
+	return &error_404;
+}
+
+static void httpd_on_req_end(void *req_id)
+{
+	if (req_id == post_req_id) {
+		post_req_id = NULL;
+		httpd_stop();
+	}
+}
+
+static enum net_loop_state httpd_on_stop(void)
+{
+	return httpd_loop_state;
+}
-- 
2.45.2

