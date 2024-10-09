Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F4BCF044D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F7C891E9;
	Wed,  9 Oct 2024 12:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="f+Y2h75F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3277B891E1; Wed,  9 Oct 2024 12:51:22 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D95891C9
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4cF1iaUl6PAABDotYD6HKcM+ZHPzUCcbBCVi2Ed1VHtH2X1hXoIiOygp5QDTyA46dwJTKLncGp9SmSapciFqpDbNE6h8cgFnSoaoNxAaMQWwUqUUaCQJA7gUz+MLRCxFyy/a44Aqa3rG03BEZQdaVqjtOus9KZnh8ZEZHad9dkdsKhuHiFhEFOCmmF6oqevlWU1JRmjsjaEsRR5eXDWrOtiDK/Kcwy60TRBq8gg2fulKvWctvZcFMsmzcxc4Rce6YNAjAVc1zy7XhpaLbHA3d5ENN+bwthWOXPZDuRatVWzNpg6WEAEDc0+mspIImA6Ws51nqLWlg/uG6urzFsMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgcqraEHqPyykh/wlZqUjRNabygkd8IJ0z5+wTHSEng=;
 b=UZynvixu/c7W++8nBqpFFkjRwS9fgMoCVa9nrC83pHGSIO7cl7HF/TtUAiwqAroygNS/2Y4FRZOslHS4CuZSNYLwapXvxKyReOX0TflsV4A307VTWVWsgPsybsOKasNwqQTP8UXTirCLb3o5+hSlnW51Lv6cRtkbcI7Mdso6xPZ7Krux7IneWXVezu/MFL6htm1nZOuxRYGV1/eKyLvM9V6db33AlnkAM2y4gdIomAUyF0kU+HYwwY819SxZZHRcJnEhzozAdw4aOGle3AoUP7k2vohZoQsoTSJelAL57MCzq6DRcK2sqp4GKb7KhLbjg7t9mjge8SuucX+skwA/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgcqraEHqPyykh/wlZqUjRNabygkd8IJ0z5+wTHSEng=;
 b=f+Y2h75F29wz+d0yxf68RgbWhhm3R/BAblt6ffc43c3K4tvkWwHT48B+nlof2MfjPR49auNrewU3gTHBXMy2FPndEJbu4fj81YiKrV8bICnv7096zYLTRCPvvTVOXKa5XghYc8GL70E1269LZ8u+tv1iXAbpY9yBXMkqMkvRdDoitp/frrRZ13SyCOPi2ABzwShGTyiiGmuGQGGuEgnf+8zCTuuhrmAtBISuEMF8ye08gzhY9gH+k8lJQjO/wfb6+n4dbER+hS0+kFDOiYDDMR+siyDS51iubdxKWMMRCmnLiEa0VmiszE52V5YMNpMnxgxDEEbnKfYa6HF9YMtvYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10026.eurprd08.prod.outlook.com (2603:10a6:20b:632::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 10:51:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:17 +0000
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
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v11 10/13] net/net: fix include ordering
Date: Wed,  9 Oct 2024 13:50:51 +0300
Message-ID: <20241009105054.1879054-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10026:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f849ad4-d9ad-40ad-909f-08dce8504d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vfd1aSgo6FC+kVzt+NwjYyzznOZ0G9Xdnv7m9SD1TBRHv1MMfSiLNHUqI6nu?=
 =?us-ascii?Q?IbpvEzf7wbWYfISG6hQhcVHMhdCwHPC6aBg/sZlzqsbiAx36OotafxpXONpA?=
 =?us-ascii?Q?ofAbSh+tuYvPancNqi4pfXjw/XzrFnCfAXElihUDZgUgvO3znx8GlGEscH/Y?=
 =?us-ascii?Q?q+1E6fBBTFFLY4kzccHLQ/IvThBN+BGISNGQ8j6u8dTYGgt8dEx25N2tIraC?=
 =?us-ascii?Q?V4LRm987dNEgEb5Dw5Z3BIZ+JKYvjAjjZOpQw3zpfwd6ER/egaMjezTDX4VE?=
 =?us-ascii?Q?GyDDeRC3oZhv44lzbIqeEUIabqm/X2fsBaOixW9wCQFpL2cM7Ztws5lMte3I?=
 =?us-ascii?Q?L0pzEOl1LeVS2RbVEBaQkhkjEGgqY86we7WexFc3x64MbmLKz2WfcLA7V0un?=
 =?us-ascii?Q?LwIB82+vXg5zIYK2vDqT7KeXrI1xi7kCiC1ZX5qpnZGVF7IBTzwhGiOhBPO0?=
 =?us-ascii?Q?LTMDP7QPOVoMiDbkM6i/bIhbi4JYipdkAZX16wLiACU3gCClxNNih06GCFOP?=
 =?us-ascii?Q?aZzZCmoITPdBTqnQRRAgGtdv2fA77SK9ACETr8Y/WiRTw5kdl8xl5SiUts3W?=
 =?us-ascii?Q?ZTS9Gxrbl+0qNXN+G/MqEoTFjUXMS2/msYgxX2T5OKdZ/UOE5Q+MTUpfbo0/?=
 =?us-ascii?Q?AVprZPtxHYvGbaBnc8KZTsd4iirXCmEWRjOOCP9o++7wevmJQNYaB7yF5KJY?=
 =?us-ascii?Q?BXXGvPxdPeKZQUmaxZW15nEsZQ3/EhglPJjFQEDaIr6o3GoEB195IIoj5tcF?=
 =?us-ascii?Q?yTE1DOU5xAdI8d63dSDA2rc+CebzbF+SGOmKv8LAudz8+EoATUUcNcmU4tiW?=
 =?us-ascii?Q?NfOBKioIQoKmJWxfyJOtclLbUb38205ZorrHzCaKVSkXW8GNBV7wIryeCTmT?=
 =?us-ascii?Q?fYyw+xN+v9HCGZfzO7SNyLCgtA65pWmS/FmyJ2p4F0KqODXGBpXmJsDj6oSQ?=
 =?us-ascii?Q?mH6IjmaA0PHSQz2kGpvE99fVa2tzP4NFXwhGfHp2AcFfjIlqlFg+Opv5TWFO?=
 =?us-ascii?Q?c/wpN2YZ6TW5n71YTFhD9ApdRwGbREFzT5xVYtGyrjXsax7Lc76/2bHv1gu7?=
 =?us-ascii?Q?BMC4eOHEoNJPU6ev5zbsx5SUope3oVKAq3GekiBIl5CFr/bQzxTHOxtOFR+i?=
 =?us-ascii?Q?bbnaZYhWOPLFE9eWN4/yuxUTMj9Ui38TLavMirUC2KnveikJ9cceExuLEiDj?=
 =?us-ascii?Q?R6tBhO/MHFA/+MjsAtCOeGMmE90aF+idpT9zzo2J44RBwYdEMlOPhQliMr/e?=
 =?us-ascii?Q?h0u6+Bgk+22hltLu4pW9426MVcVvCPdbepGDwl3yx5CHc0kXHLLqUVRtV8kR?=
 =?us-ascii?Q?OYk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WnlMRZwA5d3wHOrrBUx7JCOxHpcg7Jldtbx7YQU8fuUoyGTqsWguCu/Yki2J?=
 =?us-ascii?Q?isNMweMNK+/lKDfrfm7/4KFnrOtPvkywt09IYLL3IB/NynSVCUHFZ+taBUSy?=
 =?us-ascii?Q?kmh+n11YZj0YIsvFaJpwLG0MJyqQk48Gg5apYyKuFyHMEvDFROzNCSxoRrmn?=
 =?us-ascii?Q?2R2qJgYyZl9jpLoTJyPuJFt2NdQkEMJe0Mxmz1PKJ0zJmGZZ0wkt5Wo1RPGZ?=
 =?us-ascii?Q?FkyWrITBnBZeom2XKmgkYOoY+N4rbiTP6+9Op82g2/saDzEj8WktsIFcDGzA?=
 =?us-ascii?Q?YCJxZvIAt88RWArIciRkxkBU+DflcICrzP0qfBLZuX15F74/ChHcJm15FZkN?=
 =?us-ascii?Q?JedSV5EnmqhDBZBmY/HfBZp23L3+kmqMOGCNYQ3t8yQYkNA+m5yWyBiolPgs?=
 =?us-ascii?Q?U1dZgNu6AXgJd6//RN+t29dvNe0yRXepD5sDeEfGpf+JmVJYhqkpA501XFhf?=
 =?us-ascii?Q?uxxzzo6ztTrkQrJvIVPmMJVkDqpQqkpuJ+Gh/i/QU5PCOlWBpnTzUrD5f175?=
 =?us-ascii?Q?Xrxfcg9nQoU7cPWlfMXSjv2/uYQji/GyRssz20qBHErnkDxCvF3HKweax9wJ?=
 =?us-ascii?Q?ZfWz1yX+oSYY1oiOgyTsHK+ehXpxBs0Okx+NLaFwx/iZEpKbzizoyQWdWXiw?=
 =?us-ascii?Q?NIKSIJEoKX5fJS6J9J7wfhwOY4xGRdOmpHzorgUtsfX+pxpTW7QjMtf92dKC?=
 =?us-ascii?Q?ZIi3CXiUdLC/GgZ/bQ7OT21L/n4smsZZpc4L4xy/BzeZrM6bCggNEoeU+HVI?=
 =?us-ascii?Q?RiNX8O1pjqUBVw/icACqmHFwyJ/RrqIEEz5lTImFoGqlukBpyDZNvShe3k2M?=
 =?us-ascii?Q?/ddPnPQm6arq3WDGlohTVgXyy7w0JxOlIf+0vqEUwYccWPnIN47OCpKdTN3U?=
 =?us-ascii?Q?ruIv8mbPq33ayTWOvhT6fKppTjksk3XRU+kaPpclRvJFfJS85k6YmPthiQVa?=
 =?us-ascii?Q?60WxvNMqDjhM+tCyg0ACYpLDwsAh/YgSXaoHoVovDQqa4AUSIaiE104IjlZg?=
 =?us-ascii?Q?79un7QgiCJZ/WZVdFDGpj7OCfZ8Tn6hEKlnUu+Ddz8OIGDDjtppJ77DocRe7?=
 =?us-ascii?Q?MSILOOlMMGp0rCfwSnI4tvX2XlTNQwZLRp8uDaIHfaikOObvu5LzKr1ZFxlf?=
 =?us-ascii?Q?7o3L3z919gCwd8cvFOq/kLag/3fmTwjXhh4BnmsQMNjViA6MXufkxn04Es/q?=
 =?us-ascii?Q?BfzIpbc2BS7iZNI/2EWhaW7S29FqyfMi1RQFbyyZDw/Z0nAN3eE3dNvNmpHL?=
 =?us-ascii?Q?2qzzNsYB8ExtTpzUeObkqLDtLvDYIxHPnXbwbJRIC6HYuZk1xVjSrheNC0gD?=
 =?us-ascii?Q?kBl1YEzfi4AVp4vRCiv/blivEVlL91zh3whniaoYJoimV2ovabNieMMFMC5P?=
 =?us-ascii?Q?og/YwuF3WUYyfOpTIH1KKEr4M5yYnyecb4R8NA5wUB/6B1vvFt8YLRfm6cZi?=
 =?us-ascii?Q?hfwCq+b4JRUQf9TYxrU5QcAe0fVdKIOkC6x+d+WkeS4G73go3q5VEWz+JT98?=
 =?us-ascii?Q?kd8d5yiGLJrXBKxzhIq4iWON6IZ+N3Cz7/09NeMc86JYxPNU+gDWQFni7EzM?=
 =?us-ascii?Q?iNBd+BxgeYQp+tpgUzOkKap+/++IQlyBJWhEIT4n9JM4PQN40Jn/v95t2F/9?=
 =?us-ascii?Q?Qh6AUWmvfC7vpNd4HXj3CRs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f849ad4-d9ad-40ad-909f-08dce8504d6c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:17.5089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juQjDA1yk89tYgCx2m3BgSrmXWp0/HilR/yWm1QksY6qYFsvVT5B2lktekjGLK46DCAHg3FIXuDc1bEvzcQtSM+Q73FIBEEekqrqKD+ugps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10026
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

fix include ordering to follow
  https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/net.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/net.c b/net/net.c
index 4b0b0061ba7..dde6009abd2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -88,41 +88,43 @@
 #include <errno.h>
 #include <image.h>
 #include <log.h>
+#if defined(CONFIG_LED_STATUS)
+#include <miiphy.h>
+#endif
 #include <net.h>
 #include <net6.h>
 #include <ndisc.h>
+#if defined(CONFIG_LED_STATUS)
+#include <status_led.h>
+#endif
+#include <watchdog.h>
+#include <linux/compiler.h>
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
-#include <net/tftp.h>
 #include <net/ncsi.h>
 #if defined(CONFIG_CMD_PCAP)
 #include <net/pcap.h>
 #endif
-#include <net/udp.h>
-#if defined(CONFIG_LED_STATUS)
-#include <miiphy.h>
-#include <status_led.h>
-#endif
-#include <watchdog.h>
-#include <linux/compiler.h>
-#include <test/test.h>
 #include <net/tcp.h>
+#include <net/tftp.h>
+#include <net/udp.h>
 #include <net/wget.h>
+#include <test/test.h>
 #include "arp.h"
 #include "bootp.h"
 #include "cdp.h"
+#include "dhcpv6.h"
 #if defined(CONFIG_CMD_DNS)
 #include "dns.h"
 #endif
 #include "link_local.h"
+#include "net_rand.h"
 #include "nfs.h"
 #include "ping.h"
 #include "rarp.h"
 #if defined(CONFIG_CMD_WOL)
 #include "wol.h"
 #endif
-#include "dhcpv6.h"
-#include "net_rand.h"
 
 /** BOOTP EXTENTIONS **/
 
-- 
2.45.2

