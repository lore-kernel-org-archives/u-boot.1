Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1902FE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 11:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24ED38069C;
	Mon, 23 Dec 2024 11:59:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ZBLGWyzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8027680714; Mon, 23 Dec 2024 11:59:21 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3025D806E5
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 11:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e78D8OK3F6y3XVcKbTz4WnE3LXjrEnyNsnR0BD9lgL51xUAeRt3CpX8vKjXOmr/qKVNlyuAm+HCmGUPQtp2f4f8nP5p401JTulViAngmKHVgyyGn0Cjwh8/C5d1LWs8nwCPazSBPWEp1LyP9SFSEJz+dvnOliSy/7P2EN+4RAWPNA6T0awgwWbqqhf9EERimRwgCBEiGCPSnDng1Gtf2b+/ZCXJFVPYzLtMa9WgHff3DxirY3lYgZI6TE5+Q1tMsBKFIsXMpOd9utiS0z3JEtHEZzgmH5GEECwh63o4pONCVBO67jzIPorikCTRczFXv1dQ1mJaYcmfrJLJCvkcHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beJzP8vvmbi45iVc0vByTceriMxX9/zfgVtd5ovaLhA=;
 b=fEcMqYRISeDGBkZAfYwyMvkDadRHNAGL72KhX/SUQRCAQLpdEtE4h1bN8yAWchJ/wJLfFPC+AtGh/e5XNirICDU6ADacUewRkqWHJKyDofzkYB/Ak9npCVMkE0GxOgOE9XH1DFH9y7Dq7DM9yC1uAOS7jjkt/wi/y3SKT3cRPtTowOWh7Sa1rcsqTHRrO57B3UwrXh09T1sWhD19BuNJJfCnZzHRABfl00MX++UBvjSjQFP2Qq/4KSA28S5lHaBkw8+xTYqtwvuBKWfhEDFKycV5QubOoQ+0plJfL9OZoEv5eWKp2p0aMiPK8hplIVgWvvjXD+PmwrtyrLGtCMbpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beJzP8vvmbi45iVc0vByTceriMxX9/zfgVtd5ovaLhA=;
 b=ZBLGWyzEwol5PQ1N6FvkIQamzX0ucc6/UVmo6+YYpNOng2OUINn3PlWlI77oZwGEgNBtEoIToz7tTde6jqKlFx/PXv2vbOggOnMVLjv+9apAQeiRP4bbq1W4JaSQ3D8UqdRHMh+WDYc7VNstixu4XSSUKZ8WyTUV2X0Cx1QLEZXVFUZ+RcuzzaUU/QgXqbPNCW9oi9Cpm/6hUh8nVk7VBa3GmqRF2wUlor6JvgjvrK1LZKVdNDG0NzEFnledu6LNIpiT/nJicLwnqmzMZVRWCJMYKQUU8lns5kMao1eN/LOrGLi1VRn6c6FX5JWJQg1V44FySnhE1lJjpyYT6aGR8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6676.eurprd08.prod.outlook.com (2603:10a6:20b:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 10:59:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 10:59:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 11/11] net/net: fix include ordering
Date: Mon, 23 Dec 2024 13:58:52 +0300
Message-ID: <20241223105852.1074404-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 30394dc9-96fe-40d0-f860-08dd2340d695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dJX+VLkc5TClt5CxX12MxtJNEC2uvzb2g3+ECbryi9dB5EAlyOl0ZYuegplW?=
 =?us-ascii?Q?HqEjUzYAlND4RWKESiwOr8i6OmKBVzeIp4NHCb+XF7ZZnPynVMJGy3XzjcTD?=
 =?us-ascii?Q?gY3meDTiLfdEb3B39nIyDvaNPQ6Sq0a4RVZ6YkXrHtOEnrCfHSpiRejp0GBI?=
 =?us-ascii?Q?4dIU4uiPUGaPvKEUgLQX4qBoBJ2yhIieJ3XIPicVD4Rvuhu4DDteFbcrZPu1?=
 =?us-ascii?Q?iiPWFI0Rn6iuMwr3RHI0wE873+7u/DFyv2Ya9sVSgX4mhww6On2u8cKRVV19?=
 =?us-ascii?Q?Idn8YYynoX3OqYO4RlsLdb5O4tTwNXbUuhTtu5bVIMuh4f9GUjLS5ee8nB8F?=
 =?us-ascii?Q?TeI4UhTFXJ0dqcxxwDrsBkm2goMz8gRPj5MXtHyxi9hx1XQvg3zfhZm+BJqa?=
 =?us-ascii?Q?/4RJqvuK7DvA1QYjBrmgKpPAw5Lb/sv2VobXTpiwthAGYwwcWknQ2bU6G18m?=
 =?us-ascii?Q?aVhpYa5l4q9IWJ/cB0b5pbenV90RFKZ8xk//mxpsG0qGyyUqqSd97iQ/besO?=
 =?us-ascii?Q?g22Ah6qxbkOhMk2k3JJ01UV5AB95BxD74OvCpdGYOmRXfnAbTY1Mgw92PUsh?=
 =?us-ascii?Q?LTqr204fF2c6RZD9AONFRt9r/4MSRu30Sgft/BVyuMVyqQ5top33MBEDpX0m?=
 =?us-ascii?Q?MMkjKCCIohwXZUk/e0RBHwmdzTQxC1/NxNm41wXvUL2klaq/oAaytoGbJuVW?=
 =?us-ascii?Q?g1/mD1TF5yJ8Bk3vsKLQKPnLt9m+XJC37uo2QR3VjUITmKd8mYZodTHuguFG?=
 =?us-ascii?Q?TqygOg1tGjC0riW5lEHhJJLSscF7i53ZIzbwVJSln01RmcOfRc69DhvuGQzG?=
 =?us-ascii?Q?Cg2kwUsBOaD4ANm8Bjfdt5R+/n7WMPWBD6rjaQ56TSGlZ/VG9yFaTw9gMDli?=
 =?us-ascii?Q?507MWHrZ8l8/tIxN70+oDOKbm7bfxbHGMNmusBBTd4VIvaXWYS3lOkIY45hv?=
 =?us-ascii?Q?hH6s5mV4FJZyMBDAzMsLmQgzF8SqCZo5kkkdWAZ+qRsGlB+wzdqWSUQpr7q/?=
 =?us-ascii?Q?plAWZegp6NfyLSGaXXRu5Qab9SE/X7oGFfKJPd5CMWFlJt2HNKRIZ+ECJKwK?=
 =?us-ascii?Q?McO3UUQDIuKy/SQH/6KPP2SHToVJJJCesMCihd68Ka8HrgvjTM3t73qxHpY8?=
 =?us-ascii?Q?AWAcaX7uuChBUcqp6Inp3TJut0yQoES2d4fuwkkIr9fTX7DRSfJuB0JkuuNS?=
 =?us-ascii?Q?m5L4bSF1AdVM2v5lALIQ7AMXhDkTUOdrpDHTesoiGwH0JgRG8e9AqCBbw3ny?=
 =?us-ascii?Q?S3anUnc4r7mPhN/lAl/3KYOb9QiMBTPYzoE/EMBoGIIc+Sb3lE8mxTqHvsqh?=
 =?us-ascii?Q?AamSd4/SQaCI7QTLAN6HZdD7NSu9ROFmnkFA54hyEk/aQKloyfJTUKsr0/Db?=
 =?us-ascii?Q?2RgX6QBB6FPt34taYgT63gCSosa/Do5gwYqcKeFKKIuycc69TA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QcerOJnuiiDgWohV2QMus30nCuUE6bzOEArZB0KBitdiY2q/YCulklncLIck?=
 =?us-ascii?Q?uaNeCydee66Q7k+Yfk+edEaBhy2Zd0in0bUnA+9hzBDsCOTLerJLSa8AvWCS?=
 =?us-ascii?Q?QcZEP3SWjd6GGt87s5KDs/An53tN+1NvI71gx4Mu6FS1txSwz9e3zc91NPfa?=
 =?us-ascii?Q?42ejkOtzLfSLapLRiJVyjC132UKCcvz3y2fadQu8rDnqNJvpQe+JoxHCoq/W?=
 =?us-ascii?Q?HGsnHAM1a+IdtQqNATjjysGsfhm3h9Wzo//fpfCNQqjU9VKxEVtIW9rayZG2?=
 =?us-ascii?Q?jgt5FrRXiP6nAnGGxSs7VkUO3y17iyWHtRHhWep+zaku5n76p1qshBHQLDLo?=
 =?us-ascii?Q?gwleV+a1gosNxH3rRUeuuv4xq96EScUXUgAVyWPNwpYBwgoLE/+yjPS/lRPe?=
 =?us-ascii?Q?Ztw898zgJoq6oi/wp1zy8Vhe4wSWib54LbHuhw8Z8VN4xDqf2i5SMPAQLKJT?=
 =?us-ascii?Q?iSrVUo6NB5AA7j01ObiIHQRGw++uw/HN1KeEva6T+Z8SQrTPw8Wn4cekyXJv?=
 =?us-ascii?Q?1M8LeLZziYwG9AiKf4K0BwvvueN1r5H9xYLFgEHtQn9CTSPIGvf8/gk+rLjI?=
 =?us-ascii?Q?9jLZ6ai2BNORv3lhV8Ht0bwT8PNfOR2i0i3UkDFO7AZ6d9TW31sAxt3Pjbdn?=
 =?us-ascii?Q?iJf00t5eIuMGJ9lAxRaRxHLhy2IrmEt9uIAMzxVj01m/7BqXxPOYaESueCbp?=
 =?us-ascii?Q?c7ArHo2QN3UkbagYV6uAX9ZOow4jmkkoWasaiNLsoAwQrdJ4HATtl/WToP2U?=
 =?us-ascii?Q?1CTVlBGGQBWVGwnFyaLXY+DWR0bzPNuQ3ua60+34yiMcNUx0YqGetz5iEC8q?=
 =?us-ascii?Q?nUwpnR8wqc9su/HI/YQ6Tw1/D4opxKtPJKeHImaQ5kX910BqG2ikMdn+odi6?=
 =?us-ascii?Q?jYw85zmITlqOg44vYJzx1o1Tw+9kqAsVqWtJcAC34SQGq+R+ZQzZhE8jk2V8?=
 =?us-ascii?Q?KVeZ/5hCvPQJC+PCYGL/GzV4Io5mFBWsAGF/HzK/G2a2VJycLW+JBEeF0yJ7?=
 =?us-ascii?Q?+Rn5fY/MIrjxmf24kuhF9CcQY+UMQu6kIAjyUilY/as53PnSiX7McQci8CTX?=
 =?us-ascii?Q?Jm+7+GhDeMyhspAD2WFH990Ebyzuci5XrIGazNOo6EbLP1+B5wf33f0vcyfF?=
 =?us-ascii?Q?74QnMHxMiGFniP8jJFHA5c/ygWRVTzrW2S3UawHXT7iA7eF0u+whZBwwaf6m?=
 =?us-ascii?Q?GDGrBaNYrJxykpxtZUfzMR8W1Wxm2SKtDRWxn2bb8daVJuwP/qhBFmnvOhX3?=
 =?us-ascii?Q?piJ29bzt/lQSkVCgKJLmAnBTSqjfGUVjr+F3/QR0mxTB+hRoS2FHmrUeiG2u?=
 =?us-ascii?Q?0McYMcnx+SQDOsWL20caOvw59gqNDpqwuKB+ugLRosshzSBbQu11QqX2cBNZ?=
 =?us-ascii?Q?Z7tuHdbTB1XJnrqbt5KCTVTgm5+r7WvMMbwZ1G+xd8ANKKayBahvtckLP/Xs?=
 =?us-ascii?Q?ZwsGrFAipkUyukOYso3Wz6r+l1dKULudWlnDmRoFPHCvR6/VnWEdgkx/KOGw?=
 =?us-ascii?Q?0LTeW/2nApDng7XvcDaE30IPWLHDhlHOrJurEsZk05NTKDvSVxNo5zrT0WhC?=
 =?us-ascii?Q?HBEoyiAatmtps826U3CTDfmXy/TS7jGMHOxDgy4A/h3cS9U8fMELoH6ZzLZQ?=
 =?us-ascii?Q?S9wLZLNdeqBcawPNQ/JFj04=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 30394dc9-96fe-40d0-f860-08dd2340d695
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 10:59:14.3040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4grHD30m/MB0dC56jmer5cr8PdVIodiTDfONIngdnmkkMpIrKByuIOFozpVzJbU0ImPlNw/A4v3tfffW4iOAGQD5j9GUMs/mNi5Lgl6klU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6676
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
index fd634405e8a..1828f1cca36 100644
--- a/net/net.c
+++ b/net/net.c
@@ -89,41 +89,43 @@
 #include <image.h>
 #include <led.h>
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

