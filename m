Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE0EE77188
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 10:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAA09805FE;
	Sat, 28 Dec 2024 11:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VqtQvPQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C39180431; Sat, 28 Dec 2024 11:47:08 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3DB4805EA
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 11:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ9tMJxAPU7oGSVPthiFKEXHtBucrZHzxZLMD4msPUWSFrnH9yaDqztpMkyR2lvxM/CXNid9YOBP/D3CMzp/zEhQwgIws3Bz6EQLtd18yy6GoKIYS3tHmlqCSWnZV0W1hfwgznWCPRjWZCM+s0T2aVJ7cBDQAuozehWXBnpAvJvdde29yAfycgY9vmLP2Up+6pVbPG2YJZmme83Au8QUSOM2LkuYfp300EgKpqaimTWYGfLFaDjDNvt9/53o1X9AfbQs9voWTRVwflFNDgkmNEdJl04MHjoqyw6sTFDPdhZx5D9w5jb3wGQNsRusYcuhI28R7bUkOGl2JzzvbDix8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beJzP8vvmbi45iVc0vByTceriMxX9/zfgVtd5ovaLhA=;
 b=vc3MIGyL5HiGlhr02AQGLRzmqUm7OTr4/Be5nLlqqqJOBKfDAC4ev5dPT0j6IwF1+DJQJxl7vSJv/l+T4UWhHV7pg2eWUXWzCMkajpUgupiY5a+qO25tmYqM1cEQ2i9F5PmoVEkcHH/zstyOF31LYYScIuVOgXIxRK4wlWDRj3UnJXYFkEYv6ntiUsWFjO6uXO62iCgExuVVugnS+kvK6oku07XvZIb/WmR09+I3hi9ti2OFCnMSrz24KZLfecr87yf12+LO9Shrmtj2IzAyve95U8MgRim2YcMN5G1dd4Pt87ysBrSwL/Pd8EH/cXnIGMnUHyUAs6DgK4Mj5b/T2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beJzP8vvmbi45iVc0vByTceriMxX9/zfgVtd5ovaLhA=;
 b=VqtQvPQ81KLNuMGM7t3uARqu8Y40hkYLSLJ5UN7h9CTMF7SskzjPQkhmH5ZF5XP5Df3AmfWJ6YGzDvM+SOSTbCnf3VDICJU/KipOhJaBuYG2/VSo5FpaBvf7XqXoUq/jIlKdE3RsTdUB3vutgR31qBQZ9Ypv3JoX4iVFCEWS4isB1xbdV7959UOZugU47ikpY8w9l9eMcmlMSrRzhjjky/AKNt5Tnl9UGT2HEKLUgMTVIUg80TUZmnXJWDVww/QeQDBxnFOmbM4fqwgMQ7MaZqhCrrsPjlEO7vQwVcYcXgxQBZw4p+yjIE5qvenkqiiRh1sVYdASIiody/rP1llAvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 10:46:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:46:59 +0000
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
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v16 11/11] net/net: fix include ordering
Date: Sat, 28 Dec 2024 13:46:37 +0300
Message-ID: <20241228104637.4173913-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::316) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2e0f3e-513d-49f8-a2e7-08dd272cf4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UQSM2dcCdQM41l4pJgWDcIKQoxZhY5Ip6F9Q6k+lpgsCfAQQ/bAHbSP3Zcw5?=
 =?us-ascii?Q?HzX1zXLVSGbPiEBUtZ2w34eBw/PAHGsVGafi6sUT+5810zRCNDsf4ghm3q4t?=
 =?us-ascii?Q?kj4CWnNfqVfabKNHbfX5iWoC2zLwI0MrYGpgBRTUsWrw63Mmh7IMD27rIwN2?=
 =?us-ascii?Q?JFjbKeIJ42iWaRWhowXys6z34v2ASLJnNoVODykaiKJGOR8vFDC2zfo62Rs9?=
 =?us-ascii?Q?WSxIr+I8DT5A+R6X2/pjWDyDlHUeXZ3oaeYt6KdHFymkClp+DDO129FaGUW5?=
 =?us-ascii?Q?mJp9JYQld8AEr7WOiqScBmEK4HtdAQ/+KVWSoDd3e/Fb6kjd/XdfQmDItsVI?=
 =?us-ascii?Q?js7zYt0KZlvEnTCnHjdzUbdy9aWeo6WXTEligzax/6gZunkTRJfQgdcPy8vJ?=
 =?us-ascii?Q?gMizy7sCfzqL8jx0qCxjSDqheUxxolJMZPHb/vYChHNx05gPwG9hn/2P7CEK?=
 =?us-ascii?Q?8QrGNuZJMHd4IJxJUooFVUcmRdz+95etjwSbFq11CtQ1p/RBQ+MViasOT+KO?=
 =?us-ascii?Q?8pVa4t5ydSnPIehET9XeWFZMRVPFI+FoSYFKGXFSTO1RX1LiNlPG1uTOF7a2?=
 =?us-ascii?Q?YGtX56POn8rLqhGZJOSv+o2TboQHHDt5pPaQkdu4rTfUMLWRPxeTHE5ywSo4?=
 =?us-ascii?Q?6r98WYlTfoPQOVWZYS36X4KxMJG7WYIw8Rd5FR9OyUdKDNKxhtQNqnSZs583?=
 =?us-ascii?Q?mcTsULLx9dgrgTLC+74M5t0DpZmRh7ahGa5oYJJFnAAElDtyHO3/8KqhcxJl?=
 =?us-ascii?Q?3QndcOcSEjfZP/CT8DF1DrIqfaVKfzWn+LFLRvqWpICfxpDlRVT/NVLhAlXa?=
 =?us-ascii?Q?vQBnpvwS9TW1GjtK7v7fftE8lNNoNqPXLjxj+ZTqRx92Qh6cXnJ2YL597lER?=
 =?us-ascii?Q?9Iu+6avI9jh4snbf+vKqFx/UoBSpvwlDMLABFgSi/x0TAbSl4w5VJbg3IAmC?=
 =?us-ascii?Q?sEvHYwQznwU1jYfODGjH2ROpRco/r5ZKO+mzHjU04yZEJ1K8g0lh/xIKfLSK?=
 =?us-ascii?Q?YvpERfJqv4P2GTwuo9SZD13U+zbZ+uQ+V2zVO7CUpv1n74uU5botqrzomd+V?=
 =?us-ascii?Q?WxqbbjgGIedg5F9rd7HtHwWRKl+1r7c6YZMvWUnrQ4MSf9DhygH8vMZevgmh?=
 =?us-ascii?Q?w0saaVhaRQITKKv/dBmiD0ia9u3YIOgBtoq7cDqrvx7hrRRQ0UUMNGktT3nv?=
 =?us-ascii?Q?NpNhPpTldgeexlzlz4fYGSIxjq+ybSXvSWvWCUS2i1smWDzbPpdrYIpYpBwG?=
 =?us-ascii?Q?M+wHeB1VEYKjdbF35kz/65Ny/OXl1yGUi25lStAOqNRtqVlYpyLoxaSLNfXN?=
 =?us-ascii?Q?kVX1TKJoC/w726CAlLjR55nSzJZgQxugUY0I29hNgQnMDGMFcSajNUzlzCdf?=
 =?us-ascii?Q?cYWVtPHhmUlgy0AzIK+wouFFMIo4uB0Tuh+A5x2b7tGxikKuXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?008F8ADLJiEUbH4z6OVc5+h/Ue3R2qvCxpKfMLmYK7SANe+C+N/kcUAu2G7/?=
 =?us-ascii?Q?CiJ43Dj6+Kei/czBX16z50snE0Qq0jJx9jxiBX6Be/PWLlTVBVFDN3iSLDw0?=
 =?us-ascii?Q?6uI2Zoi9horI0riVGE27JBUwv46/aErGupyEPf1HJ5GPGHm30+yfI/g6I462?=
 =?us-ascii?Q?XMWikMHK5cD3WYbuCBXBF+YX4hCByZ018tE3soZQUBQWGkG3LMi1i/wdPIvd?=
 =?us-ascii?Q?n/MVbqs24OQNxosWwuvGuCW7c1HVDgUSf2olbwxxFW4Q8aermjn2+9HHwtNz?=
 =?us-ascii?Q?7OHCLd+Q61l65JNQJHySyQbdmc8StZiHu6kGxIastqvpuLuRpjXilaVC7lji?=
 =?us-ascii?Q?A6hH6uLN7NcCXRU3d2awMLgqZpPnCTKw5cx9+fa8cGjOk5bnQdSUlhrKeg0x?=
 =?us-ascii?Q?gQkQwBv1AzjexPWVrV6ZDffZCrG2oKoJjBgJjcbdl5zrFWPokuwU6AWdWpjD?=
 =?us-ascii?Q?Vrw4w9k1beBlktWyLqD2c1MBRM1umbzJUiabdB/nWP/TCDZVt+lqObZsM4L+?=
 =?us-ascii?Q?3zT8kyRAT9YTsJn0edNbG0wmBrYwmH8i0JX0rFyYPf7COlPfX6Vm3afdJlsE?=
 =?us-ascii?Q?bWt2dpTZl1kjplvdKotQXv0fcCHf0XcGWS6A7syGjrNYPrADCEHhjkxmOwFh?=
 =?us-ascii?Q?RTW7nGiWqSOmqj+0t8oWTtjMC3U353qe4d4SnC4YJxkrY+RfA4gY/mNAqUuB?=
 =?us-ascii?Q?EID0GkEeEoQlTvWd4dg+27iUCq6b2uq0XeusRwmfzRq+K/ZvAUCYnPL8eHaY?=
 =?us-ascii?Q?FbRQNW4lyF3hdKtFqCt0gPxevTlkp2dRSAVXRyJsCoGVcW0ZV/C27vV6yg6y?=
 =?us-ascii?Q?bTNXkjwNqfpLD3H2OPtcNDfwCUYg4JZfRjPDxGaTwtVTA4xb0HfLpkETZjbb?=
 =?us-ascii?Q?7vwH1sFL0vFX9CI0mtlPjTYB0B208qRV3Ofrh5n3HeCycFQHKdwHWpmPvQnD?=
 =?us-ascii?Q?YT8qPKybkZeXSiSnkwKpfAbl6v9Yo0pABdKH2YR4tpOJgAjpFj9HluBUp1iH?=
 =?us-ascii?Q?VvsRpqBQEYunP7IuANtXvmmjAP8zfOmvE0PH49STEUbsR53TtF70hCNnYklI?=
 =?us-ascii?Q?hKn3YgJDG5UDm6pBRa2bxGrYrE4Ql599mTnPyOXOT7Nr19RrzjbOOmgb8ia8?=
 =?us-ascii?Q?+SLbXqBzgz2k9Ft6JdgAFznjRw7H1etGiiJ/M0NsifWvIB6mi5u1W+uKLT8T?=
 =?us-ascii?Q?H3mvOMTKrNOzKiRQnPsiXNrCX3leiIPl0lqvEfTWNOUn1ZYb8rYmy8g0wbkU?=
 =?us-ascii?Q?nCls0oC3bst4WW0RuvWGae5putnk+SviOCwqUsnQJTGobYfPeKkQA+O3xTCR?=
 =?us-ascii?Q?dPjHXKGoiR/4y+PP7YGfifoviWMXg05r4Ih4qA2rjUhYkcEBwx6exQhSCwY4?=
 =?us-ascii?Q?XtpxNmt7cObz9nAcw2xNGEuHDnHeoJ5BZIg7duBgKrcFurmCbjAruwxtc7wS?=
 =?us-ascii?Q?DwmgqdNTSJ/5xc1WU25mNiLvqoYUXACIgJteI8kw9sbUYRgTX/2b0lh+c55j?=
 =?us-ascii?Q?AkEPjEKjRH2Dgtl73ikLedbqG8diiaIWWkhtJb/8vbmZ1wbuwRCP3sNFrgyU?=
 =?us-ascii?Q?km7N2IFAxYcMhOSC9oOfoNpQaWV4UO3/VBTfPzgNmwOkVK5s77SSyp+6bXVd?=
 =?us-ascii?Q?4NYY1Ib2kHZUtM31yvW9oU4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2e0f3e-513d-49f8-a2e7-08dd272cf4b1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 10:46:59.5291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uv3mhAY08z6lorpqfY62sINGk+IfjiEQg6leGv0zXx2lwpwDsZXidQzdqh5HvwYlUGMIjzmZY/fzQ8IFCwvaMWT7hFFTNaxr78cqDmsLx+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8437
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

