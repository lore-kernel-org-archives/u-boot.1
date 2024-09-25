Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B589CF9C69
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3954D88BBE;
	Wed, 25 Sep 2024 03:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jJSjkE2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A7B88CEC; Wed, 25 Sep 2024 03:41:34 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4FD988C2E
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flHncJ6aGjd4WhqIYyimSQ3FvfArhVqcDdouMQI0WOqf//DKTZQmNMghrVMWdcgRqXQAoKNzs+XTGsmDQB23pmAzvbpGX2nj2BA1+lEuYWSurSaJJM0Ro1Oeu9c6guHgKNqVCa+7qwP7zDEd2gblw90G3WWQ6+Tb4Ax+b1IxStSpf7M4NNtcyWWbujJlSFBjJGU+vtsdhSvlg/0adNoAUegjoKtBhB4xsTxX4G+pkcL+/3wDcG+/+4vZzwo8H66hAUxcce8Mm0dJD7sOds0Z57Xk5W/opiP29e/03Ve1Jxakn5/2CdEoJ0ucx85NdTMHCYZEYyum5SVlAKOkDwetPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmjXGSawNZLXUktFdcznmMLK4L+4znp39pnky4x2cAc=;
 b=uU6go+SXfmv8MQib6c9jyxoGuCo2oheKyTADlEG3VqRk7i9/k3hkaoZlD955X3D3nGMC5jLxuii2jH12dps7MqUX2dWRDhsJrAieZ8YE0OxL+bXSM6BdoXD7SU712laMZ7js0ryFX0PxMgGp/RKIM5N+j4yGvwPbOM5zyAo/ilAshd0rhD/eMAjjSdgTJEeQ6EQJ024LFmv01CRCbj+8oQoq+GamODiZeGIZ6Z+od27+kFmmBEaHlLO77KInNF6+GVTqZtqO5fZLvcF1dCaHR2iwnNRVPJyAIeBpdTCJSTZYBAzayAfzdDKlMJnyGjXscnGBSi7PFl+NdkkGamvIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmjXGSawNZLXUktFdcznmMLK4L+4znp39pnky4x2cAc=;
 b=jJSjkE2iXLUIEXWcJMyYhnwtdTXO+hOccH2nszmTCis9StAXpt/W5rusUWyt/khnKCRWXyO5ItxXjzHgf1QfmHahVWqiw1g5n37YDcKPTaz94hXo7Q6o6TDS7sTeQcBI1/Hs5ZqiB/tVzZJkObguY2QOPJES4b43jnE3NrFogy6OQEZeetmp/31XQziZ12xmAGRwxAN6XPwGmfHMYRJH6NuLpXcNl6e3Cmb7XdKgFNdyYj+TBuknz47jPHmDLK1N152V4jYIONpBKyrrDjh0JFODQXL19N8J9BysPXCy6McoS/J5dSdlZ6Mve8TMPnffejAAvjkXzHOoB6Mi0kni/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5645.eurprd08.prod.outlook.com (2603:10a6:800:1a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 25 Sep
 2024 01:41:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 01:41:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v8 10/13] net/net: fix include ordering
Date: Wed, 25 Sep 2024 04:40:55 +0300
Message-ID: <20240925014058.1679074-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a27bd4a-36c0-4c56-1095-08dcdd032888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r8ly/xYtA187BebFDsF08p+VFR8kCfyDvyWztZO4cgPfXIxtnAzeYpjoA8YW?=
 =?us-ascii?Q?MNea/ZbMoKHu4cEpxiD2QViKQHQNiSt4sGCyeUeVcntplkFv806JDWLdH/oX?=
 =?us-ascii?Q?kBGMPFt1UXD4Ub+8ujIHN6eDFqOjWIIHNmHlyORapYf4p/mmGFtNKUuW5Q/N?=
 =?us-ascii?Q?4N+PvvXhjfHnDqoI7k7kvnvIc9IoPrboE0k1+X0Pv0V4sL5VXHEk4+b02Ee3?=
 =?us-ascii?Q?X3powbSeXFE5FlPTgz6I0k225GwejoMByDARr99r1SmbXf7dIBwVwJW6MuVW?=
 =?us-ascii?Q?QmJ10cWG3avFBo++xkK/mpCuD5dOm+1Y7cR4/zd4lf9PWx4HuRroXRy56cVH?=
 =?us-ascii?Q?3iyvyXF3+nkK3s5elt0Xc9iTrFF96FYwmt1rEL6qWnTY/IcFK2f/va33M0dF?=
 =?us-ascii?Q?VhUGtPjjaSYjTY5vl5obGTGgISfY/d6GJz8191pIP+v0HfFT2BGJJ0esoDrY?=
 =?us-ascii?Q?wrg8X04xEDAFKtFHQzKGgtCSLTMJxCp2aStLAsg5PRYFtjK4cf2n7QkM1p/H?=
 =?us-ascii?Q?pP3LRtFeYK5xABxoPfMO+dzAIn4FqXg+4EmEW1OTc/eIQ/iyvVUcyr/hFfXI?=
 =?us-ascii?Q?sDSDs1yR7cE1JTzNXpjJnEsqUfR1ctO37PAvKxAzEfJU0AKQV9oivl9S/Po+?=
 =?us-ascii?Q?Fhnku+J/vGqSu/Av5rzUVwwXoKHzg8bCdcsm5lp+e0zz+3b84TN6x5/OT8z8?=
 =?us-ascii?Q?OWVyOif1nHOaAkgPfOGsyQwfTE6ZKzUCK6MOI3S/o7E8hGmeyPlyD/WO6Z4K?=
 =?us-ascii?Q?1cu3HRNL6B+YRUqty2tqtoqpCJJ4g5liadWVQd8kf4zFG2XD0qBW/o/jldBY?=
 =?us-ascii?Q?b5OSRLh1//otmt7v88vjIYeecK7OfRfBmOHDpIYUpLgeu/9bY+PfXUjuoM0m?=
 =?us-ascii?Q?Vlh4itIHcfEPqKxRvu0s7oLHxHlDMj7KhA+C/x+nVd26bk3Dt1AZ/Gbxm0SX?=
 =?us-ascii?Q?hESZDDGm2VhhE1097kVaaHYOn/ooTcv5UKRxtNkyelQH5oSzszLcICcWuTmS?=
 =?us-ascii?Q?IctCsM2iHJSawnmOzPMMyp8eo01QD2n1FoIKT9yZuDjgJayxreIMJ8YIU0VE?=
 =?us-ascii?Q?/f2ACNsBFLj45HQFtoQvjj+hX02ulmwp6KA1wnjacEGBKcn0LBv5wnuAl+/C?=
 =?us-ascii?Q?NHCBT0pnG00mk7Wf9eBJ0SKIlnj2H8tgqpPVcqcBmz3IdtONjUzxM85cTPeJ?=
 =?us-ascii?Q?qzpxD6hyQyMyLnPwrlZ7kojZUNBRlSZhQPCFmPz030HUtnCl44er8S5xzVJk?=
 =?us-ascii?Q?NUZaRbilknf2/cFEvU+ukOlG5bokTJ7zasSfwNlAW6fPd8kNDKDuPA216UVP?=
 =?us-ascii?Q?TUfZD+LQQmzFvhahs6VXieBPE+pVbAD5htKBrd+UZg2X3b88QkHQsAPi7/Yp?=
 =?us-ascii?Q?WqmPgSw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7m1oVQ+bdnHHRLzi1ixpISRKpH93mZ1RMhW/JWikQRTkmJs08Wked6t52kF7?=
 =?us-ascii?Q?H54ISBONfn+2DuK7Hy6KBCxD7n8pu9a97TSEVRbJLoL5IzyWKKBBBGyyirJD?=
 =?us-ascii?Q?8E76I6V9dFz+V0Ih6tK9GVgypN9muv7oEW+lcMTOVrzMza44GOUUiax2kgFD?=
 =?us-ascii?Q?vUpKdA/KvhLCcgZGJmc2bH5wHlc4G/pPPQqcJZkimwoNKsDAiUZvebCo/gng?=
 =?us-ascii?Q?HjL4HzEII4Noe1BzvpzoIGTzHE8aOvMF5GGhHjOhYvwsL4W8HtK6xkGOZoh4?=
 =?us-ascii?Q?FyfV6ippNV16yepXqYbO3B/NXPJgBSb/u3CitByhFK1rT2Y0Cd0TNUZox9aY?=
 =?us-ascii?Q?AxW7AtZii/Y1gHjc6/PYrSnw16z4/kdfTGApZ3vnFlyfFhJKqUuTpwc3Khla?=
 =?us-ascii?Q?e5SN/XbBV0R68d7cbyXog8ZAOCWCkS90IJOgrO+ojv/wp+WwQvoJOSKnnbS/?=
 =?us-ascii?Q?PlDxhk3OarYMxm1GYyW76FGvlV10gUhNmQjuGvAI8fZ56LaDxfe/zQAEiuc1?=
 =?us-ascii?Q?1mbpyP3lRybO1//YEx9zDU6w8GPMCJjpnBEu1JorqOFDJi4j0DXPGTtPj5Oz?=
 =?us-ascii?Q?kUINIlNX4OEiNdWe8VVUedkFKago23igYtGa9HBxEmiHifydI96GYgQyvdMx?=
 =?us-ascii?Q?K1vWLchvrRWJKPhvIRa6oGPRp4ohDletpUGdv9Q8O0F378CUEj0+fy52XafQ?=
 =?us-ascii?Q?XFK6Ypx/by+vNfLzFYYbKNPpO9Heb9iQA/jektXL8steZ8nj+leM5q0CUkC1?=
 =?us-ascii?Q?5sX8+VVO/JcIqAYm4iznGb+OKyZGaiRtXx19lp1ZXa2VIJ3iJdCo8GqQ+b0O?=
 =?us-ascii?Q?7gxlo8XUvnlZsd9GjY7c4JQGHjCxHpTu+8HDbhMtBKD38+3r8upeMcwH/ZKb?=
 =?us-ascii?Q?zyXOpl9XAMlg34eAA0d5WUc7kR6koSwqq+IwL4uPI4KPuuHge+O+hswepJe8?=
 =?us-ascii?Q?oGJw67jqYe177vSLPIVZvXzeNxG9n8MepntJSIKbOu1g7KO77gypRiF4FpHL?=
 =?us-ascii?Q?ybpmTzGp0+rE03PbISuHUH3mN+UogSv7DgMN3Bj6uoaSACpeZ1dVDGMXT6yo?=
 =?us-ascii?Q?qZKHqBt1dNLEg7LmHHFXjTe5hJxpCKZM5D09T29QEMQyZafXL+gqaJ4TNnrf?=
 =?us-ascii?Q?xopBxvSZ0dOShnfdSEFCghbShVXqTRbrstx7WvL4wWmzUbIyr5CcA34dgeJz?=
 =?us-ascii?Q?AuF0+zZhEbJHVR/6vQOUmSbs3QLe3ZGm6oGZCBOX9OE2cZomX6MYs9S6V/RH?=
 =?us-ascii?Q?sTU+tyLTZM5Rs443xJXKbHtiq23V7DH3EsLNDNwzWKnla+XtEFl46/tvVt5j?=
 =?us-ascii?Q?9DxOPU5S2lnW3nEMlq8CjzqJ5vTA1+5x6aymr/hVPwg+xsTHiRv3qJ3/8Jbm?=
 =?us-ascii?Q?ixfI/iv43jOKYS+GY74V7CunOwZ8ED796lwVSXTGBsNsueKyIyJHUpatav+l?=
 =?us-ascii?Q?u95tHPXBgj2ofSJ+TFJ5/pzjnpT0IGsKWTdZqTGNSbHy2FDcJ1XXivbqC3A3?=
 =?us-ascii?Q?tD2mtOXB7flSEIkPw2MSYzMPu2eCugOgt0gZ/QMQkRwNa6YhD56vmGvnvdjr?=
 =?us-ascii?Q?n5KoJ0CYxbvPy11GC4f4JAAyJCZdK9mX8H6lAybxNviMWfksZBB9ES9UrFlQ?=
 =?us-ascii?Q?1k+A1eWBkVCB1xRmSwdWz+s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a27bd4a-36c0-4c56-1095-08dcdd032888
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:41:21.5623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm4skzlAMnwAENwwpyd9rzudXaZ0MBWS7MO3bEQun6NXXuQcixp09roNxHa8Xc9TwUrDCIFC0ewncNbieQ8nS1DZu0HSfahS/UNn6Qlmn3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5645
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
---
 net/net.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/net.c b/net/net.c
index 86182cc504e..92156b5058b 100644
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

