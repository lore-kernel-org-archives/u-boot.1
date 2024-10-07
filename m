Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085BFCF8870
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9203D88DC1;
	Mon,  7 Oct 2024 22:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JDKR8zwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C272988DEE; Mon,  7 Oct 2024 22:56:16 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FEF188DB3
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Olet4tE5tXulbI0U0fJCrMI0vU+2c6c+dnY1f89PaSA9X64Q5pWLSu2kSG0ftLSg2YgmNxzy5xwcZmVH0YEDnzm6/QgjnjFuXGzDT63TUk/hTeEjw+KPdQJGy8MEqHNNKjhy/QiDGqF6Iw5Oe8zHZcZnkIyjlDiQ2v+nFcrSYXh05eHvyNdAoHBtxYLXiWbI4jaPlLCcuZ9UPva06CfPG0PsyhMLKh5bnGUIdjl5+a/C7QOETaqS5v6kpUJOERzGT6oVr+NyPCgqX2V9pxC5B3vPIbYQiAQYPCAg3KTvsHMtbuXCFRw7e4pn00d3BqeIJ67mybMYY+wWTjW4AFlL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTOP3XcYbGpcHn2wuSNvn16f0KawTWVf6MtARgfEF3w=;
 b=ervALupb7X2sABZuMhpILnKCehIx6mM3qx+dxOyFqRoSINtnWfs0totiqoHE285clc6jPQHmqScgAbc0/C9pdYZveQa9JygQRo86eX9F7w2bR2L0NgOp9I75T1gjVt+NU8IC0jyzpzaIRTcHxRp8gQ/kyf+79WVjTb0L9TL/kBObTIDEHQCQvuCgiOeHJKmKdWwEGInqVn9/xsjYl9SG+2Qp6lySPIa7EG4ltC9dPN1skqDGUYkX6YGkrbdLcyz37rpQ59uCRX6OPGvZ/QNEZ6eeruQykfiRDxJRf4/YMPb6jitWdjmwh3KYUUObBr555IpNWeA1mqmT0suoGVDa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTOP3XcYbGpcHn2wuSNvn16f0KawTWVf6MtARgfEF3w=;
 b=JDKR8zwuXLMhDOEAGY0tWQC6eCwn5d4bV8gBs/vp7n6aT4ns+oXNbUfqnmgPBOx+IEiBxKV0gH2LOMhTZAaHil6BK9+K+Pq3+VQ7OrMJNfB4cgJPYkKQ0t5d1R+EAMNkvRdqMF4uJcANWjqOWW+Wl3M6RRq17YLrMSxmrRBt7+EVSRJJKeoXaTS1ca5lBGkDXELO1G3u42yO+qXzwXBPCoCaqURhN8VhCwzHWIYVcw9L1J3GtVOi0om/oER1e2u3/nV5fPkCE7kEut+NVPjyajceNHNoqLWc3i8BdcJdrhLWLBI7ltA+o1GnSWarKYIaHhL6a9Htdqg/Qb5cXYql6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:56:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:56:13 +0000
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
Subject: [PATCH v10 11/13] net/netcat: add netcat over tcp support
Date: Mon,  7 Oct 2024 23:55:41 +0300
Message-ID: <20241007205543.1632499-12-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 0aa8a053-7086-4013-d67c-08dce7127a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TYd9jNTt9BP+adW4lnPNoA6l61GJjgNPHqt8Oh5TH9cm2XVedoP4QIJcBZVz?=
 =?us-ascii?Q?ycG6WGwTgQ4dl9uNGC6zZOJ6f/ZdrOkbO6LavC1ZiTOrpjg0dWn1XQ2X/HZf?=
 =?us-ascii?Q?K3EEbSOfzx+qLQCyv7Sd+CyxG0UUAlCpMwRUkaXlSCeedBxt1Ps0b04WYR1/?=
 =?us-ascii?Q?kzEPV3gE1raVAGY1smIgYfLDkfFCJ/Apqw3zDiPgo7+befVemDe6ORYhk08J?=
 =?us-ascii?Q?c19bcZmqVU66MQ04FjuerL+sGtyNvyUZWGDN2vpnspO4GJGyVPDcLAJeypBg?=
 =?us-ascii?Q?QCFu0GGvnMw8hIy0mCBeGbKr3nsKU69RzlKwkozLkqpw4UFdURJUJgxiMTnl?=
 =?us-ascii?Q?cC+EMQkmUOpLlw9c+Og/PCdDHaJ9RAJ77Vvw9Eg6ZYXkazQzP6rkqICgupw2?=
 =?us-ascii?Q?gcjDik5UqMh1nKTVeQFYQaNvUAI9fX0Q+jeVwcqjjvxfCeQq/TauLzIjbgSJ?=
 =?us-ascii?Q?niWW/DYt0jG6VhDDJezdtHIzV7f9OWM6sHWlgXK1m4mY4mx0NzyuvTpIw1Tx?=
 =?us-ascii?Q?VL1NJJAyvn1Y2+4SD1Xt6T5jGswqhkAkBMecOU8Ym3jolrbHr8j2EoGP0VxX?=
 =?us-ascii?Q?NBwxPp3aBZFk9XK2fd+dL/ziygWKXLNg/1TnbUW/cTGEWUHOXyOviKelvtRs?=
 =?us-ascii?Q?vmNC5HFJF9GovjkVbbIaCVrCeKrue0gV39yNcmoP3AehnyVq42R8UQOanhRv?=
 =?us-ascii?Q?nGLYJJkElOsFmrd8g8Mgf4/RwEms37EhFPQa43xKQggObq6JZ4Baee9x9mTX?=
 =?us-ascii?Q?AJTbN/K+/cOgR3n6pCmtIIyROeELLxbBw4F0ZGeKjY+bZKe5mluEXzgWlxq8?=
 =?us-ascii?Q?O/fihdePoywfEWbCk/HYfA9gio/a0VOKYqb0KHISe169PptcG0MWgLNo6qny?=
 =?us-ascii?Q?TFi6Lthb1Ag71zVxS9hCGeZdvtktQIgExCqeRX3BGrNjiISBebXjDz6mWWHE?=
 =?us-ascii?Q?W4AAJf1KjbwbvPxQ46OTVKVJ0YNBIdtVxtXNHQP9/3EEiF7x1oEvMDNQYGqu?=
 =?us-ascii?Q?/z7lrSgTA0r9/9S7vhK2x0tKYwXDMuy8Mi4aOnZVckiwCZmuKJcYSGIU1uNP?=
 =?us-ascii?Q?KX5AHKGYZ1soqe3a/Wm0+PTCogQntj51fNRZxvPgGhGKg+F+r3b1l7iu+k90?=
 =?us-ascii?Q?NlwqbFZydnFDutkEBQdBMw6B/I0PHxi9qYMAnXuhcTIJgiafzHWM71aHHTFU?=
 =?us-ascii?Q?g9egmoKNhk0kg1QSzu9X5lIDkzsg4iJm5jIsxOm1YUbu/ekeMyIED1sgt0cn?=
 =?us-ascii?Q?bd8b2sRutBRvHWh6s+AWYVZZCpTaUoaPjCZOEwJKPnn5eDs0IRpkkbIyI8Nf?=
 =?us-ascii?Q?MfAomenI8xFv9sLJUtg7dITMRCk2LnPBwv3m/DFCcP8KoV2nF9Jld5Vz6jTj?=
 =?us-ascii?Q?Ox0/lA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TW3GTyVp6AB4fI3pyBzrUC6Yr/Ukyqvqu3nlhPfRG5sJjBMfeU0o9hTyajoq?=
 =?us-ascii?Q?1hAX4sPxSnjRD4HrpdKrOU+6FgfIDGHu3i9EHrlFQRR4r0ExGQ8ZTUrgj0Fm?=
 =?us-ascii?Q?Lj+YwYaUWlW+miya4Bc8Uu1a+riVpnodc79PaRhi/Tnnuer8owpVhgPdsT5n?=
 =?us-ascii?Q?1eyNy1FVuAVr6KZTLAIxNN3+OZJ1x9vzLjczpQ0CifOmvRkWQum8NcpBa9e7?=
 =?us-ascii?Q?4Y3DzteRTS6GXcS+EgpAZrzwQxHfiXjHViikbuSUrLngE2GSpWcWomGmRNBn?=
 =?us-ascii?Q?0KJevoyAZ1q+S54+gNXIbVbhbXz/aLaDmBCO8W+cMx14Qx7jpjNwh7ToLPIH?=
 =?us-ascii?Q?iVnnhu5nFvA5Qx54dSdQf4Vc/DUZrSq79vYWCKRB/4tvKv9VOe3JVpaTIH/f?=
 =?us-ascii?Q?K/1fgLm+ollpjBCC+ift1V0PY9ys0D5bW0uqCF7/b2O618odfEDrt2rJ8Yph?=
 =?us-ascii?Q?Hz3ud6kGI2f1Ob+F7aFkkQHT/0cG4EbY1aFEL1lGiC/eCCKLVJfH46oW5WFe?=
 =?us-ascii?Q?LbTkl5BK8iWXDs1YKiO7xl5yAjeJwdWGXVm6xsRQ5jl37Ag5jIi3Ioasm8ar?=
 =?us-ascii?Q?eXeNFMkdOVAtXNdoF1yfNQCtDcE+XCu2Xih4yqQse2lqR3tnbPNzyQw1Q53f?=
 =?us-ascii?Q?xsQiPInC1uVKDLUFKCDsgVBi2ohX25coGDyZaXXzCDvA980kjNqarr17RCN7?=
 =?us-ascii?Q?h4aJWPC2FrpUWFp8U7BniaCIqbJlY9uV35k0ii3XArIooS+cD3DyJpylsSZv?=
 =?us-ascii?Q?/ztx1J5yk+oGc+jO6ilWg5iZjrU6SVp7RiUpkyMPoIml8OQ6wM+xCM6bwPw/?=
 =?us-ascii?Q?PVqr4v26m7yl3eP3qFNs7HEzrVCVfe9A41++9D8ZDNPziQ+LjRQYNtBfTG3t?=
 =?us-ascii?Q?6a/GsZbhNXY63uKZ1GmuCDD+QgMJm/qL5lE62NLOFBsAqPnU+D7byQKpP9Qu?=
 =?us-ascii?Q?nUxy6B39jMM/+ONaxads7hXuseLSF9xt9hQnPAVXI3TaKpW59yhFm+bPlmh3?=
 =?us-ascii?Q?IusXV0GrgASc7aIjE2V5q8sLu4T30EtaUGSJC+pqijgPaDu2jPqIY9RnZaD3?=
 =?us-ascii?Q?KStJpYKEFqiYClxniKhV3ofHFVWwxixgjyyTmiJwywbr8U57GaTptorvfxti?=
 =?us-ascii?Q?7TO2Z6T650iqk3o1FU15Hvq/gdo2TfnR+RUa04dp2Om0qmy8ZKFKaP+7mK+M?=
 =?us-ascii?Q?rNv0XYwtA/RWnTXfGYloKnetLZH4H1mCCFih1vT+f74gArPQDq3n5Ln24Nl/?=
 =?us-ascii?Q?qwubOyzJL9+6FEw+eEJZVNcTrU/3tVYHvE1LlhYg4umzggg/lN27Ll0dMRCD?=
 =?us-ascii?Q?tV9VoNlkwujkQpMtYnOYxv5r31aAAb1cw0HBUOfgOGbP/UwLfBof8VwUuBzV?=
 =?us-ascii?Q?sh5h7OQkbVjNye56Q6C4D7YxRhv84nuLMositgw+GZeQSSDrcu3DpSFGTSVu?=
 =?us-ascii?Q?EzyMYO9GjhlrqBwGIf26RuAn+6QUipGdQu7sFL1nS153gzMseJETjfJnDS5p?=
 =?us-ascii?Q?BxZehAN4zeWtMcZmMlyxOHjMnbyvUw2tpXQ0UMCMLbA2YUifufaOH0Wkf2tR?=
 =?us-ascii?Q?05EJ10Hu43MkSAF6RGKU3+hxoNKcImQfH0eqQvNG2AvElzy6SVQQUddAUUcC?=
 =?us-ascii?Q?Dfjlo87NacxJtSqMFNma/MU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa8a053-7086-4013-d67c-08dce7127a7a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:56:13.1751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCojSt8v5PX3Nk+8cPreDhxo1W+4bhi6cTD2HPHejQEgliJxQpaRju+Yr4ASwdBkvSg0xyXEsT+f2qy1x3Vp1dh+VBDD5JBhpNGC9lK6ink=
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

This patch adds downloading/uploading of data with netcat.
Client/server mode both supported.

How to test:
============
  netcat-openbsd=1.219-1 from debian were used for a tests

  a) Load data from remote host.
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat load ${loadaddr} 3456
     PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb

  b) Load data from remote host.
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -q1 -l -p 3456 < image.itb
     u-boot: netcat load ${loadaddr} ${PC_IP}:3456

  c) Save data to remote host
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
     PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb

  d) Save data to remote host
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -w1 -l -p 3456 >image.itb
     u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig          |  10 +++
 cmd/net.c            |  35 ++++++--
 include/net.h        |   2 +-
 include/net/netcat.h |  20 +++++
 net/Makefile         |   1 +
 net/net.c            |   9 ++
 net/netcat.c         | 191 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 262 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index d50f6396fc7..b680cb1d93b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2024,6 +2024,16 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
+config CMD_NETCAT
+	bool "netcat"
+	select PROT_TCP
+	help
+	  netcat is a simple command to load/store kernel, or other files,
+	  using well-known netcat (nc) utility. Unlike classic netcat utility
+	  this command supports TCP-based data transfer only, thus no data
+	  will be lost or reordered. Any netcat implementation should work,
+	  but openbsd one was tested only.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 53ce2bc5d0c..79bb126dbd4 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -206,6 +206,29 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_NETCAT)
+static int do_netcat_load(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_LOAD, cmdtp, argc, argv);
+}
+
+static int do_netcat_save(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_SAVE, cmdtp, argc, argv);
+}
+
+U_BOOT_LONGHELP(netcat,
+	"load [loadAddress] [[hostIPaddr:]port]\n"
+	"save Address Size [[hostIPaddr:]port]");
+
+U_BOOT_CMD_WITH_SUBCMDS(netcat,
+	"load/store data over plain TCP via netcat utility", netcat_help_text,
+	U_BOOT_SUBCMD_MKENT(load, 1, 0, do_netcat_load),
+	U_BOOT_SUBCMD_MKENT(save, 3, 0, do_netcat_save));
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -323,16 +346,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
 	switch (argc) {
 	case 1:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
-
 		/* refresh bootfile name from env */
 		copy_filename(net_boot_file_name, env_get("bootfile"),
 			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
 		/*
 		 * Only one arg - accept two forms:
@@ -354,7 +378,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -365,7 +390,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net.h b/include/net.h
index b0ce13e0a9d..0af6493788a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -515,7 +515,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/netcat.h b/include/net/netcat.h
new file mode 100644
index 00000000000..d8e09aaaa55
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
+ * netcat_save_start() - begin netcat in data saving mode
+ */
+void netcat_save_start(void);
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
index dde6009abd2..978fc1978b3 100644
--- a/net/net.c
+++ b/net/net.c
@@ -102,6 +102,7 @@
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
 #include <net/ncsi.h>
+#include <net/netcat.h>
 #if defined(CONFIG_CMD_PCAP)
 #include <net/pcap.h>
 #endif
@@ -571,6 +572,14 @@ restart:
 			wget_start();
 			break;
 #endif
+#if defined(CONFIG_CMD_NETCAT)
+		case NETCAT_LOAD:
+			netcat_load_start();
+			break;
+		case NETCAT_SAVE:
+			netcat_save_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/netcat.c b/net/netcat.c
new file mode 100644
index 00000000000..7a450dd6405
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,191 @@
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
+#define MARKER_STEP		10
+
+static struct in_addr		server_ip;
+static u16			server_port;
+static u16			local_port;
+static int			listen;
+static int			reading;
+static int			marker, marks_in_line;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(int packets)
+{
+	for (; marker + MARKER_STEP <= packets; marker += MARKER_STEP) {
+		marks_in_line++;
+		putc('#');
+		if (marks_in_line == HASHES_PER_LINE) {
+			marks_in_line = 0;
+			puts("\n");
+		}
+	}
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	if (tcp->status != TCP_ERR_OK)
+		netcat_loop_state = NETLOOP_FAIL;
+
+	/*
+	 * The status line will be shown after the download/upload
+	 * progress (see show_block_marker() function). This progress
+	 * generally have no final "\n", so jump to new line before
+	 * output the status
+	 */
+	if (netcat_loop_state != NETLOOP_SUCCESS)
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	else
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted",
+		       reading ? tcp->rx_packets : tcp->tx_packets);
+	net_set_state(netcat_loop_state);
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	net_boot_file_size = rx_bytes;
+	show_block_marker(tcp->rx_packets);
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	show_block_marker(tcp->tx_packets);
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
+	ptr = map_sysmem(image_load_addr + rx_offs, len);
+	memcpy(ptr, buf, len);
+	unmap_sysmem(ptr);
+
+	return len;
+}
+
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (!maxlen)
+		return 0;
+
+	ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
+	memcpy(buf, ptr, maxlen);
+	unmap_sysmem(ptr);
+
+	return maxlen;
+}
+
+/*
+ * This function will be called on new connections (incoming or outgoing)
+ * It MUST:
+ *   -- setup required tcp_stream callbacks (if connection will be accepted)
+ *   -- return a connection verdict:
+ *        0: discard connection
+ *        1: accept connection
+ */
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (listen) {
+		/*
+		 * We are listening for incoming connections.
+		 * Accept connections to netcat listen port only.
+		 */
+		if (tcp->lport != local_port)
+			return 0;
+	} else {
+		/*
+		 * We are connecting to remote host.
+		 * Check remote IP:port to make sure that this is our connection
+		 */
+		if (tcp->rhost.s_addr != server_ip.s_addr ||
+		    tcp->rport != server_port)
+			return 0;
+	}
+
+	netcat_loop_state = NETLOOP_FAIL;
+	net_boot_file_size = 0;
+	marker = 0;
+	marks_in_line = 0;
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
+
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
+	if (!strchr(net_boot_file_name, ':')) {
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
+		if (!tcp) {
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
+
+	return netcat_start();
+}
+
+void netcat_save_start(void)
+{
+	reading = 0;
+
+	return netcat_start();
+}
-- 
2.45.2

