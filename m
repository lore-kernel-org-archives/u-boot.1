Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93183ECE589
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9E488E56;
	Tue, 10 Sep 2024 00:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DMh87SxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B1A88E84; Tue, 10 Sep 2024 00:27:54 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFE088EAC
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYwviIcrQa74PZ04CYCJXZR3Qi8pKcesaIu4VXXCBJHjGPiFkxHKu+L0sp5gisuGbSNuq1yWgMDeDTi3uEE0/pk0yWNMpDpsKW1GQcco17M+3ojXaSrh7CfB+SRVIeZNNoU60D6a+BB426h3ftLOtGw1kQGoFxmfnpYBj/3A8vH5PX4XAwQLdcFJEjKoPTU8xaVYTB47FqfcytVASLEYJBzFhY4eTzN23T35vn3gMYU9FUHkphM4PSFtAOdRbkeGVxEOUVGYdDi2t96bfoXiQSUI8xf0BAofogDKaAAHBW5ee5epYiQR6g/e7MOPDRO2FsgrHzexUVVrFcaXYhvzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SHihVFTZ01/OXnVWA7PTbJ82/LOfSO7ORy2KZQgPLs=;
 b=Wb9bNRz0Mh6/dVp9hEVGZ1+uGHeHxZ7fWmv5k8Bl2SGwQo+273tprFI7GnH84xV7s0D8H12r3Tie1diOdes60IPGgeEXHDQeaNfVjzz7axC3PhUsg1SFkFiDubj8Ao9eukjJc8PUjKLDx87e8Apq49BfXC1H+ERVkJL50WLYlz4xvSwCK1c15Oosf+giJnmhi/vxLlen5nD72ljG57F+LMcQCG9fr4j19wIQFWEMh5VjARDPPw0Jc/ca63OZlblxuGSa89qRDtIjmRmhp6eKS/IndJbHZIH8qf6JpggI6LdQNfMroCEq6mhqWfM0tgPyAIquGR60u1dIAJ5JfgvZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SHihVFTZ01/OXnVWA7PTbJ82/LOfSO7ORy2KZQgPLs=;
 b=DMh87SxKZXBHjSBfTfTVyCYijj5436xs5d4tzjO1O1FGc+e6sNReHrSQROtO2B/5XEA4UxHE8KUYm242wgstF50csJWdTagUTN3wPxXpjOrVVSJl70usNrIdlrKUkdNBF23rrOONQA1Tx0VDAPjLPeTZm+9slOfjfnl3wiUz2oT5evy/Zw43bNKNCw0WOUhkQ8Mcjm0bvgZSz8vNjDLGxjsS2LlrbYjFHP3rVdjoNlpjn/Y4iIE1hLvb/8rljZu9eCBX2HVPrHPo0n3bOL+M1dGUWzDDHENKDkMsi+TB133BGI4Ir1o6zPwMIsz0P6aDT9vdtGqXshQQkJDNWGEKQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8722.eurprd08.prod.outlook.com (2603:10a6:10:3d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:27:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:27:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v6 11/12] net/httpd: add httpd common code
Date: Tue, 10 Sep 2024 01:27:19 +0300
Message-ID: <20240909222720.2563118-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccceb16-6c4e-4818-8565-08dcd11ea075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qxl0Kc4iDfxbWOAxNFihqbsRCVUjSVQHKOSli4aN9gXX98BoPjWFcp8yzl8Z?=
 =?us-ascii?Q?VliFwzQ59V6bRALckcfXCQw1RExqa/6aKls1gFEOqurGdqYiaPYfnZki5PRb?=
 =?us-ascii?Q?VoQwD9aJAOkJ3U/Xx0FnwzlU1Pq6Th8LSJ/KU0L7DYwWAg7XsGlwPLYwMEKa?=
 =?us-ascii?Q?CW7rmKfL3zocdKpdsADcp53XATK8Tqea7aeM/JcyEAoiOOejDw4nW9Nhpv3Q?=
 =?us-ascii?Q?RnHS49Wh9btxLimDzSZ/b+urovWRagt7R0nqLTZhZoX5/FRzNUdvGHnm2Sbq?=
 =?us-ascii?Q?psdPO5ITltlQ8lNDkt4czHWvfzbBOqlvSDzyaglrFehZjRfblavAhKbx3dqG?=
 =?us-ascii?Q?HgklLVw0XjOiEVbDAxViSA1G84iprBkx3rhbWb3xP1Da+xxBflwBr6FmrjUs?=
 =?us-ascii?Q?h7+QjQrREPE8nmNPhnhmvrFCA5XDlRPwlhvIQVKkIFKUCafcYxJ4tfvgFsTr?=
 =?us-ascii?Q?0uLe4Btw015ubthjz6nrq6hvagKTd9+s2e8xKGoqh5cLLLKnEbcuwPeV6sJc?=
 =?us-ascii?Q?nna+kkYTDQ7ru9+vHsmB+GDLazo4oDPRF/M2+Yi9GmjCLJ3oEmkEtYjyfntL?=
 =?us-ascii?Q?cyjPY0VWAZ6Jzz/mYhVVDAhD35ey0qspaNq2axC6O8zxa/xeSu1ycr+LY3ZF?=
 =?us-ascii?Q?zYbnrrfQgRVDAkq7TD7hUgkZaiMNfym5yF2I9b6ybTTnUPc3MXmI9gm19qs2?=
 =?us-ascii?Q?ha3iiJlGmb0D5n504PTWqD1+bX7dlsyl1DJVz33TeU8LHzTl48db93zaWGRN?=
 =?us-ascii?Q?4BmfCvA+YdNJUZ1hOg+GMFqC2D/lwR++oj8iJQ2smrUucWmZqctu3H+o/gvo?=
 =?us-ascii?Q?ZOwfpdA4ZpNjhEiwMmiOivPyPS4u/d+I6wlkKV6bUrDpTccQdENX5CjniYEP?=
 =?us-ascii?Q?4NsbMl7oLdLJb6L3CfEzUhQsgn2W0uWr9q9SjWlz7DJ6OZIMvFJ/YJ/IUiJQ?=
 =?us-ascii?Q?g1/M1AokaYLtq2PM5/L95hdDAHjSAVVkjWT5bd4Uw+LNboAiRp/DjpgowSmZ?=
 =?us-ascii?Q?xOwFIdpfm9qQbBb5LBJs9v1UUX4U3NM64nSG1KOyk/1oeA1HEYhfQKKHWujl?=
 =?us-ascii?Q?+RQoSl6JVILay6ckERdOI0lugQ+SnXB2PjtC3sHQwcQX2j1ArVUBFjhCyw5X?=
 =?us-ascii?Q?BLHxZDGGdQKScJ0gC+jyk4R978qAzBaN24knDhrsOnSbh8j6sEV3/sIj2/Ut?=
 =?us-ascii?Q?uXMbgQg3AaonckWkbXO9fRypMUiFhdagkiEA08avnPCJBGoF7f/dZ3K+xVFl?=
 =?us-ascii?Q?qHEQbt2/gznFSZ/O6HWJBlJyTZzv0buQx3fK+Ar6zG/EbQsPRFqMHD0YPCWg?=
 =?us-ascii?Q?I7AhkYUjSLLTSwWtol2xCJ3uC76mYUlyhZx7y0ePYdA0R0jTcRmsh4A5TmC5?=
 =?us-ascii?Q?+lkQkMxNDI8ae6St962SHjQZOsho9sD5dwp1hd8lHx2rDSTuzcDrHZaaz/W9?=
 =?us-ascii?Q?Vu+Blex/PJQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CMOSNtmTDxxQnsni+pc3IlSebfPOL6RXcSQtxbtxEN6/bI9SmZiXlFDdTrjI?=
 =?us-ascii?Q?eWmX1muE9qORz4DPpd4U4qWUglpoqYtNoDrUVBfURu/ghoyww42o2cTwGf16?=
 =?us-ascii?Q?YI7WS2hMZyddfGgr6ddXOiZkFkjuc5PFXsWpnKLkrHWI8uzkp4CD2TljkiVz?=
 =?us-ascii?Q?A11tYmaB4kOSxw4J5uOnHxJ6YZUmArQUS/FOAfpTVzFcfn0nt/1Fl5ynu8y0?=
 =?us-ascii?Q?7My33YB1I04pDF6ZA2VUSCqL8ou4GDV0OrCx1XdFKF8UpCHtq7PVjmBT/TMX?=
 =?us-ascii?Q?ndvOZtO56hkYquve/zUWDa5HX5Ng9SVMfJ77/EN8YjnE2Oetzw1SMYbC3JQr?=
 =?us-ascii?Q?ouHGoHypOu6v/BtRRwIW5Zx6q0ddTKjTt1LxcT0kfYkq6/xw/TlD8BXEyHqC?=
 =?us-ascii?Q?tZfgOpGTHqSivhXVpCQSpioHP2x86FkwmznZU0N8StgxHJRm42IPwcMVmLFJ?=
 =?us-ascii?Q?EvCgK/KKyUImr0eo3LQqV093Isd6ri4gP6VuSAFG9wT6aJuqEVM7LMp764Op?=
 =?us-ascii?Q?4Ia+X0y5P3/b9JDJH2uBWDoYIOkt5nb4r/+Z7EuA71m3IJ3nssWUTR5sDUH6?=
 =?us-ascii?Q?1m84dbOOaoXsWACraQNFaM9zXGuebEqy2MxAuEC37zR/lVCAYOpIXa4cd7FO?=
 =?us-ascii?Q?oCkv2kbaAkb3B+Ya7q+/TDRe6Z6LcMwun0TcaYeWXRag1zrNGG9NEjjs6IwN?=
 =?us-ascii?Q?2CXY7KO2erTViM1RZ+VeTFI2SOpJNlXL/vRQ18ZUhC37DGw+6syt58/6Ecw/?=
 =?us-ascii?Q?peQUt2irnSx/bNxveoh59+1IqykFAwwCDW3drA+Hu/B9vzxuqSyacHoWz/Fr?=
 =?us-ascii?Q?7xJTyuGz0ThFbzoyzjQykpYiIj9LJEvEo5NKvZc9wC17Q9EoHAsoHG4qO2pb?=
 =?us-ascii?Q?6MaNriASxEXN4vgi//2Qo4EtkUY/8xb0I/jwV2wVYOVNyMeXWfRB3VReXLmI?=
 =?us-ascii?Q?hR6jzj2/oFnTvSAo4uwlrqrcHYeTDtN/f8vSpV2XkL5+3RHz14/IgRhvKOsG?=
 =?us-ascii?Q?Vkeqj9W7TpJRwPcA/qPCRakbzU1hQICScTXcFbjiIyPMXE4E4P1VWQFaTQfr?=
 =?us-ascii?Q?7ri5w4XMIncaYLrhK1IJEYM1j34G5fJ3vbV5zbmmC70mHi7bkQ8L7WjoQR+2?=
 =?us-ascii?Q?6aFMeDUICJwJ8iGCPVVkelr2vSFeQqPD7uAFXkrijasFAat7QLBJWj6R6JQz?=
 =?us-ascii?Q?D2QCo3nOgrh+l4s5oZ7yQOlvPj3vhJ8gi4tSj7U81x5Xh4OkBOaRTu7no+dA?=
 =?us-ascii?Q?v2YkxkFMnXjw2gGlgSzl+try5H/v+mP0TqmpFRdlRGbTHb3ywnwGbG9YGGRH?=
 =?us-ascii?Q?IIsj/xwronhjELzjyO2+ffTzy45uAw7F//+L5H2Ni+5kPPsi2sHMFkzpCpiS?=
 =?us-ascii?Q?iB0x+zlavNikWmf8mpkFFAZ7RwyYM9PF1DLShdNF9gpJGNNhaa/GRBJxSGHt?=
 =?us-ascii?Q?vE2ZFjJwQ7RPMym5NHiAedkOz8PlhGpUGfc7UOQz6KKqFcPyRTJ2rvkpqVLo?=
 =?us-ascii?Q?J+K6vLDsCpl6kKeFKmYdhZ3SPCMj7QPHRnLET7GFBOd40pkoH7fhq/TqVS8F?=
 =?us-ascii?Q?c2iDSL+BW0tsOP3VkuCEXQzShtFkyLQZNxH2NZg1i5SgAkmxriwUjoNabN4F?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccceb16-6c4e-4818-8565-08dcd11ea075
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:27:45.2436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7fu7xkeKo9O8oxZtVmVE68M2FZnyM824iCoEkcBPCdR2coWzFbf8YPtYua5uQ5TIM08efdzaTUcCdZ9eMbUF5VtwqJbGMNY83i8MZ+Dl7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8722
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
2.45.2

