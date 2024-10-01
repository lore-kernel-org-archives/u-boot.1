Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB4CEACEE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D31BD89294;
	Tue,  1 Oct 2024 20:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BTv90GPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98565892A1; Tue,  1 Oct 2024 20:21:36 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB57892A1
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnyYWyMahZ+nfR3u+kgDI50cvDjK6liQzPxjHF2YRONfIrSMx9MG0Tcrr9yg23Mj3Rw2KPbwAgaCSZVKFMMFZYKiDrC7fim8/Qb2hHClpuAcXKQ0+GHrPzMNidBx69tpFxn6Rd8u64Ukw678EwDDKJQSVZsRIYqp1NpE/twJ422Ooj7ZeXC027FSEXkhpD5pvXg028n48T3xNc4Bqyzj56t6c8ruwCK1fhfmIHgMPvRvwMZZkKL3XWZcSZwtMiAy/W1jSHltEg5O2W9pHC8ty5Kd7NF+SIwaXs/v16gHhV0qQ+3v21/DnmaZu5zidogN8m7jtgCt5XxTRW2h6KZL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y47ejzTkjm+SCg5iYP7UHe7kwu676bcmd6GeEhrQByA=;
 b=pocvwTci+PiWZ/cG/YdtP+rUNxF3Pi9iixqKXOCGd4dnJC1ZFaSSRl1QrLnPa8YIKxCzBFJhQMjGTnUcV0uYRH7BLM7i92T2x7wTETxLSGIJ7C1TS/YMRUcXPrdzx6aZ2bUpEkq6QN7VJo3EcWnQtwMF3Nd5kz/LlnDWs1QoVkIzSEBx/kqiHeX5m/6PS/vtaCpVtYp8PkYcGYrMon7EqKeVy5INZ9zdc5gyiwbHFuaGnzXfpb1L7nTfYtwCaU10PwGvIjCHqeiww+PbAqeb+0v4k9Pi7QioWB5Qy/jbsagx2OkEw27FJDs5mDCUHdzYI/dCh+oQ6PaP/9cCQ1UJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y47ejzTkjm+SCg5iYP7UHe7kwu676bcmd6GeEhrQByA=;
 b=BTv90GPWefXQu6LZtVLyCmtCvfA7XcPQ9EaSxlKeGDcBFM07mJ2bUgwyURMVqP+VYZDsszJhBDRTZ+IveMtP8rVTpOXQMxBbdtA7VxetfTAarTmtRm76fO/q1FgzIXmEk3ZblN68J0lCqgNTdE/we7/E7nPAsdHUG1gSWw7SN89MiT8Bji0hI9brzRQu9/ZUvsvIPrZkkslgkLJk+w9+tOlfOQlk/8adA+6CLrHxu+q4NQA5Xmj8u60uIq7S6bg/KHVPWFGgwYmal5N4GY4Jou9MOCNUIcprv9GaU+kTFuUsPQAvcmu98tosx/fRYyJ1faOhmmZd5PAfd4Jd7rx93w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9153.eurprd08.prod.outlook.com (2603:10a6:10:414::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 18:21:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v9 12/13] net/httpd: add httpd common code
Date: Tue,  1 Oct 2024 21:21:06 +0300
Message-ID: <20241001182107.907828-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::311) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b9ca7a-8fed-4d40-d166-08dce245e04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wfioDpu2ZXSd5jjbtVwPV6LU7AYmdNofyfD/8gOAVhI20SxPeHCPKdr2rKfu?=
 =?us-ascii?Q?2S+v1bqET6c8bzWmn7f5P1Yu6RF766+0aE/POJhMZ2prgrPzuHZ3nbLcfAEI?=
 =?us-ascii?Q?9+f6CFYQtBRBFAyVfzwAiUO1IWZrzpTrs5f+irxn5P/JcxT54/Vs3XIe8PqN?=
 =?us-ascii?Q?LwKa1aqcWoFvE8GB23eKDyOK1R+Mw/KcCXM9cJ+EFnpPsINqOVZmquPOztB1?=
 =?us-ascii?Q?RvwvUnZvAgUtKBQlyo5h7MSPPjiACy6a9hit9WaGrSfBuWJ12IioqrLYQwlm?=
 =?us-ascii?Q?RFFRY0ovFYBDKG/zJ9RVD4jxUPY2nVLYx5MNwfiPO2MZZK9xtbN/f/9vmu1j?=
 =?us-ascii?Q?qw7Dth34qfVJr8gLqQuvGvBKUmW4mulszD0TlMvCHfb/19mCue6MoauW+62W?=
 =?us-ascii?Q?E2dOZlcD+D+20bEuUgkPpNuj642yTxoYGfyxBiLwqg3lXOpdnRil36dH8pLp?=
 =?us-ascii?Q?Gaut6pGSdlwsycOwml5BhGtU/3M2mEvkYeB9D3ZsanbUIhPRE5CAk8Q4RRCF?=
 =?us-ascii?Q?BpqyD5NgAax6GazFzpbub1Wv420dvY14Hnq3fd/nI5JjGSYVIKXqmAnaNzUN?=
 =?us-ascii?Q?9nu8Ly5z6BQZuhJPh0HMGDM0zw9QeiG8fDwReektthCGZgD09WjPywtIm80H?=
 =?us-ascii?Q?YTyxMHdr5q5dbnFVEph2qHGGu6uFIVfFbOnmj+Te4AJIxTSJaD7RRvVnjjUD?=
 =?us-ascii?Q?RkZqkTBA2/O5JDBB6TjLUh+/a3WfY/OccJhaYwcgNBdtA3g08zYHZXV/8P7g?=
 =?us-ascii?Q?x7a098xeUCxBsVBDPaibZhdXGVT1nsW2+oR9aZkMEdDqpQuv9iRD0mXMet7D?=
 =?us-ascii?Q?9rSTZgdvY+0+jRyg3H9Mv+z3cM+r50GGSMZzcAwkJmZ0xKxMEafGW3x+sLD0?=
 =?us-ascii?Q?naRMoxYkZEz3Vn+eIr5r4R0MXHykc95iljsojXOmE0LTHf/+r2L3Sy0Ru3WE?=
 =?us-ascii?Q?KG7P84Jdhr9JI3BTocrqAM1ZTxEwRPj6NjBmsTaAPpXzOoM0R3Z67Gmvnr2a?=
 =?us-ascii?Q?trKzP1Pe/ClEYE6cOLmoAhOBmwNWW04hIrqifqbcBfszpnjNNmDRfOy04cme?=
 =?us-ascii?Q?qIE+HMi2iHcPBhAZeMlgBahZLjfxINwOq6sozrSlvVhdZqrZYdKCl3RvxCDI?=
 =?us-ascii?Q?Dg/qqaBxtP7c2d6obkKtrBCaH4QIL/ZQ5zm6V/+pxVzqjowoMtDr7VexQ8KF?=
 =?us-ascii?Q?glq+yi5X5Vi/HxLR3zsOSsrb+ITFt4/ypP7j3OOstuKHN7GIkHMovwtb8P8B?=
 =?us-ascii?Q?cPEZsjbBJL3UmiRQSVC1+LmuoDKU9/1pLi0SGgDHuVHU58P8Rv+EnDsbuu6Z?=
 =?us-ascii?Q?aM8VwO3DOUP6wXsgDDgtJbm8sS0fLVRtiZH9xcD/2f2iBkxyOZnQG0aFl3sE?=
 =?us-ascii?Q?BJQcc9mCJr7VL5uLy+A+fiGqVpO8dT7uULy0prT4jSkYjunsdolflDylHEnV?=
 =?us-ascii?Q?E7XBkbt2zVk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QCviHEZTsaYVjrrISr81M/vYTAM5pYeEzeNspT7ArKh+5kRf2orVkrHKpT31?=
 =?us-ascii?Q?sJWsZ7J2B2nqJUV7U3XU34YT/8V1SqN1oR/g4wUmUEboFr4wqu7ZStVI9ME5?=
 =?us-ascii?Q?QqD1RM40auOrTDiDV+XjkvNTb689HhPXEVsXBjfmHTDT2rwzA7lGdH0KR0oP?=
 =?us-ascii?Q?JVSq1DCzxaISPXJx67Ceo6IpcePZ3oyhDi5xLV43OTWilp3MGk/y5AZPssA8?=
 =?us-ascii?Q?2I0WUzsBeIzprVde61+7FqfBnM5I/Ub53ZrimmKx2e9jEBNxglABBovd65GJ?=
 =?us-ascii?Q?VDon/0niTrd57mu3be0eNXl7b6QjC82U0rmahbMWb4+GOY4MVDpMqSuHqwwU?=
 =?us-ascii?Q?GiQGriLxbUoCBFIpISW3Z7Ax6aiEFnWQoZbwnUvhYBRL62PY3XgB4kPC5Jt/?=
 =?us-ascii?Q?uJP8pUHovt4scanX2oYPqJ0Vjl2GXZIrVBkAzwZCSy8Cpj1RetGkeD9Jqs5K?=
 =?us-ascii?Q?6QYdPEgz6kgWKWWklGLz0nqiNqbE8FkD2in5/6jmGeDmHvW4rnrJe6zwdOX6?=
 =?us-ascii?Q?0vBtu6harGYehDYj0p3BxgUwK+wt2eKHJ60XIIqBJCRtaQYp4DrMuKCusFQc?=
 =?us-ascii?Q?RsVwIS+Q0aYBHMwycrhsTR4IthJZ+ogzwHKc9+bqLpjFAr9o0ucbOVxkXy+f?=
 =?us-ascii?Q?vv5+RiTKfzr5yjgr/c0t6AZB/KlcnnP74bP27qAg3IWV2ER22BPyhwWN7nKJ?=
 =?us-ascii?Q?rkU/m727xx0lR6RfA3s1mv1wb0qowUZvUnXnI3KiMY+2svL2eOged/oZbUPS?=
 =?us-ascii?Q?y8qlAKhCBC1RDM5riaGMk1kEYMO1wi83Gcc2q1rHveGiDagsKWW4vXvO6qjH?=
 =?us-ascii?Q?6hOUmlRLqZ3jm6I1jyXlSDrEbaL7chjZWFok3x7yYd0gClMjNuLAjzA83I8N?=
 =?us-ascii?Q?YE41rrysPU9HfQbe9p6CSVNtJJc41ADZr66hDVZ7EJfKO0i/TLI2/DiLK+Ir?=
 =?us-ascii?Q?6JHqHdrliLMC/DDiyllcd/nNOSMaLnzGecefk9dqJncJgi2eQBozvnm187IM?=
 =?us-ascii?Q?EpIUgpkkOIvoVuOkbQ/XlwsCakJ9fsvnWpuPkf9DQxxagUiSX184LJ4iyyf3?=
 =?us-ascii?Q?YFWknIegO6BebZj/nN10EOMShARXu6hCki3Is7TLxHH7jVWKejDMwS9ffjBU?=
 =?us-ascii?Q?upH9CP80WhZOau7A/XTxqJ9qID7H3K5Im+VNhVbfqN8rfnqF9Nf6YWyRiuGq?=
 =?us-ascii?Q?2y4SAjU45ihXXwFxB0XFPdUTMuoF7KShxXfiNxtKxQn9r/po/UQ1SHgKyC5J?=
 =?us-ascii?Q?UWtAnbe8J3bHgm8f1YtosQ07tg1TnZjQBQ1Lj4ctBjsCcZgm7BbYsVRWPa0w?=
 =?us-ascii?Q?vS8jAY27E8HmJuAICLua1mWtcw/vSCdD8jPJl8uwsEjz78V+e216HKv4+SNH?=
 =?us-ascii?Q?qYhXntHLjzCCyDuwcqmeyuYYLOt3Y61EZaGLXDLzhTt+SLgG5CV7F5BpNg5I?=
 =?us-ascii?Q?hmCZRXmbFTxX41TS3cpxD6Iw2wEfrn6G++WwnYfcDOhalAzotEQV2ncL7dCd?=
 =?us-ascii?Q?4jzHUYw9CqOpBkrlQhu23UXHlhHt/Tbj2tMl6I9ELI3Tt07SLLNp5Fp11oQz?=
 =?us-ascii?Q?EpB26UxMPizhnb2wtp3HpxfBFo/mMCc57xtk5C5l+wUf6LUJqE9QTCy5P7b7?=
 =?us-ascii?Q?PTBAjcH9jAO6zIAIYvlzTFU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b9ca7a-8fed-4d40-d166-08dce245e04a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:32.4791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hkp6P7jgw69EQ9rhETdUO+U4fgoewtJy0HLBPXVLbhnj7bIzp67Jfxd2pPDMwKrjc71MfgC74H9dboEZw4qHcWJEsCGDC6mlYz02IgA16ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9153
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/net.h       |   2 +-
 include/net/httpd.h |  71 +++++
 net/Kconfig         |  14 +
 net/Makefile        |   1 +
 net/httpd.c         | 735 ++++++++++++++++++++++++++++++++++++++++++++
 net/net.c           |   6 +
 6 files changed, 828 insertions(+), 1 deletion(-)
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
index 00000000000..ef6c37ece7c
--- /dev/null
+++ b/include/net/httpd.h
@@ -0,0 +1,71 @@
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
+struct tcp_stream;
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
+/**
+ * httpd_get_tcp_stream() - get underlying tcp stream
+ */
+struct tcp_stream *httpd_get_tcp_stream(void *req_id);
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
index 00000000000..82181e291c8
--- /dev/null
+++ b/net/httpd.c
@@ -0,0 +1,735 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * httpd support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <net.h>
+#include <version.h>
+#include <net/httpd.h>
+#include <net/tcp.h>
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
+enum http_method {
+	HTTP_UNKNOWN = -1,
+	HTTP_GET,
+	HTTP_POST,
+	HTTP_HEAD,
+	HTTP_OPTIONS,
+};
+
+/**
+ * struct httpd_priv - private data of HTTP request processing
+ * @req_state:		state of the HTTP request processing
+ * @tcp:		TCP connection of this HTTP request
+ *
+ * Data collected from the HTTP request and request header
+ * ---------------------------------------------------------------------------
+ * @method:		HTTP request method
+ * @url:		HTTP request URL
+ * @version_major:	Major version number of HTTP protocol
+ * @version_minor:	Minor version number of HTTP protocol
+ * @hdr_len:		Length of the HTTP request header
+ *
+ * Data for the multipart/form-data POST requests
+ * ---------------------------------------------------------------------------
+ * @post_fstart:	File data beginning offset (from start of tcp rx stream)
+ * @post_flen:		Length of the passed file
+ * @post_fname:		Name of the passed file (see 'filename' tag of the
+ *			  'Content-Disposition:' line of multipart/form-data
+ *			  body)
+ * @post_name:		(see 'name' tag of the 'Content-Disposition:' line
+ *			  of multipart/form-data body)
+ * @post_boundary:	The boundary of multipart/form-data body
+ *
+ * Data returned by the HTTP get/post callbacks or error handler
+ * ---------------------------------------------------------------------------
+ * @reply_code:		HTTP reply code
+ * @reply_fstart:	End of the HTTP reply header and start of the reply
+ *			  file data (offset from start of tcp tx stream).
+ * @reply_flen:		Length of reply file. Zero if no file needs to be sent
+ *			  in reply.
+ * @reply_fdata:	Pointer to reply file data. NULL if no file needs to
+ *			  sent in reply.
+ *
+ * @rx_processed:	Currect reading position in TCP stream
+ * @buf:		Buffer for HTTP request/reply headers. Incoming file
+ *			  data will be stored in the memory starting from
+ *			  ${loadaddr} address.
+ */
+struct httpd_priv {
+	enum http_req_state	req_state;
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
+struct tcp_stream *httpd_get_tcp_stream(void *req_id)
+{
+	return ((struct httpd_priv *)req_id)->tcp;
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	struct httpd_priv *priv = tcp->priv;
+
+	if (priv->req_state != ST_REQ_DONE &&
+	    priv->req_state >= ST_REQ_MPFILE) {
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
+			if (!priv->post_flen) {
+				/* do not allow zero sized uploads */
+				return HTTPD_BAD_REQ;
+			}
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
+		if (priv->req_state == ST_REQ_MPFILE ||
+		    priv->req_state == ST_REQ_DONE)
+			return HTTPD_REQ_OK;
+	}
+
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
+
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
index 978fc1978b3..83c4c57b204 100644
--- a/net/net.c
+++ b/net/net.c
@@ -101,6 +101,7 @@
 #include <linux/compiler.h>
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
+#include <net/httpd.h>
 #include <net/ncsi.h>
 #include <net/netcat.h>
 #if defined(CONFIG_CMD_PCAP)
@@ -580,6 +581,11 @@ restart:
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
2.45.2

