Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA12E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFFF896BE;
	Wed,  4 Dec 2024 00:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="RSdDDhZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19278966B; Wed,  4 Dec 2024 00:01:13 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B1D89696
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:01:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXW2Pj0H8CMt/UqB4VL7a6E6GggDDRurksxXBurcippvVqBjq5XbcQncwhoCU5ZezjhQJrDxI+DA/qG5N7uXrc2ipNbRiKqQHPwe3HXCduXFHsz++nHic0mNQkL5HXadn6bRh6ehx4opWCA1Tqm4lGBdZEm4dpv48oSqIWbjZi7kKiUFNcnYa1skHkrhWcvuBAsoBlC1MLcOXycZ+BJyzTKd5w/L+6Bb6ELresuoZEIiT+qIpWUbk0pmzPwNd/qPZako+2QQX0NI2jkcQWbS1Ysfu1GKgPDEKLy8KzxocaoKLVfHqvM6nsLjwc2DgvbTjLVsyZMUqcnO6rKYAe9O+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQg1SWyPTbNzxQ+xm77B7XPyv/Xf/KMyt41u8d4+V+Y=;
 b=pEePDXORkHzqIs87F5SJlkjyZ3mBwv23mj5PqHiSLxkEbdGxlCAgbT40NxyH3YyjscwJjZAVsHfOM9OwA+xpnQB2sHodh9LcQpGDApdt/mOi7HTVYKlFGiD0uCiw583BUKBdRqD8Ycocmtq15VcwBmQ1mSZ63fS16l5HMvL6szhvtQ+h/S4bZT7EidqGTd1CzCEYK6wh/Oc88LPvhwHrqciHUkxr/Q/27vSSrBhoVOOBHnBma4iM4sSXCMCkVXNnS0yjaPkLKObw37VdL3u1A8Ry0X7Jzmg3Gqkl6Q6TEudTap2yrAcoCS5FxtIGD5Dx9PnvU2soXcki2JsY0+22Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQg1SWyPTbNzxQ+xm77B7XPyv/Xf/KMyt41u8d4+V+Y=;
 b=RSdDDhZYgIFl6lsr+lffGfRFGWT0gouCLMov1O/HA2HbK73xBFb6+1oE3OwslG9NLhNPJHig7lwrdhTBrHpRq2wRJWqfe8krfzVCr6FnC9BRnVy8AWHURVTRvZRzNJL7143lOioLgk70c242w28AVHhqmJaDrJ3OGIKEoNLgDzMpGGoi7x1n05gQuWl4OkMyAAZ13rheukABE6WaidJOk6AVxSE64pWzT/sPszcGCv/2SdME1P+AOy0EPd9KbwRDrsrNhb1a1HzXw+EqnHMpOQM91JnE91Up9yH6BGV3WAjhfRvZFfHx+0+VKDgrsqGO6SSOVmobYzkikLWjZ9FE8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 23:01:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:01:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 10/10] net/net: fix include ordering
Date: Wed,  4 Dec 2024 02:00:49 +0300
Message-ID: <20241203230049.2677155-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bee63c-5c20-4bb5-e6a5-08dd13ee607a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e3tyOARnYmzZuCFFg8lQXAszpMiu0h161NdVPdcd74HaMJ3s2xMMrVZukHKM?=
 =?us-ascii?Q?ff/cJruvuQNhYCYo+qxHpMQE6ofbBTFkvjgDO8QKL/njO6tOEMIVH8lHDeLn?=
 =?us-ascii?Q?Aw45/VvHecPd9Bx5aZd08OLh7WnH8kvxGQjV8YN5MyG5CIaF9lQAbFcynXVV?=
 =?us-ascii?Q?t6Xip6/XxWBsRPjsIyk/F9/s0LszlpzYTPTlkUsoUydOq3WC0MzMF5JdaHk1?=
 =?us-ascii?Q?A6A8m1UyQXM9M4fKBx+CdTPI+BfPqzf49XtB5wdtyHACFncFkpHWwD+W2COj?=
 =?us-ascii?Q?S+RoqHS0A9+vkQSw/wRTY9ET5Jmi9RY1fnU7Bg65Hkd5HD32U+BrcO0hZyLt?=
 =?us-ascii?Q?DzuFA3eur3NZTt0gV8ZuDK6QoWugqtsQJY7CvkaOqDFNE1/Ua6oIwdUj+kJF?=
 =?us-ascii?Q?CoAtLS2SFO0sfwc3yzndl9gkPtzraXmMQrVjjkHVGXt0Xeq3vNMMMGu0vdts?=
 =?us-ascii?Q?2OWMoYpioe1DWkebxgZRTAXrjfZtl0fCBx55iBzvNp1QH8cpzHO3Da47Q80A?=
 =?us-ascii?Q?ZLFujJSb2dE7G6RkaFVFQ9a+pug08k2ppzflwCi5NqSRUZEVHZLhMlugKKf5?=
 =?us-ascii?Q?o81OSWSCb1vJxCLw+v5KkeMYJbZql9wCAbzA8JRAvUU5CkrYjX5yztCkSI0/?=
 =?us-ascii?Q?ql15PbSWMW9TGmH+j0nnQJ22LkTnJbnSsPCUp65zJydvTC9slcbTdgvjG6QA?=
 =?us-ascii?Q?FlpRmNORPjB1ZPPcbATLX7Mu3zh+LMx4mehkQthUuRw9iFsPm7+8awpSA2ps?=
 =?us-ascii?Q?HijsfeSPaVsYPmD4xgTjwybY2kMiLJF3c5a1y0qR6hviaEzlON62ywwpa1Pm?=
 =?us-ascii?Q?Zo/Z1Jtet6iPKmwd8W9nMOHzeCGraDayFZNqDFsSfr3G6EBO3qnJ3qS14ntS?=
 =?us-ascii?Q?/s3l4xAfgkaTAc6ff15mLJMkTsMssoEFnyuV3tLRhMzMpx1go9mlTsdvIium?=
 =?us-ascii?Q?/jtw84GggUo9BnJ37TXEiKGqK2LCeM2z78VKMmCMIKW13FZ4EWfabTUOHRdH?=
 =?us-ascii?Q?GU0qR3Xs4r/1crX1pQtPhtvkYq5tFooegoALWy6HtqMWta18a7AvV4dHQ//w?=
 =?us-ascii?Q?tmIBDYi0CsF/nzikW0gxxLJR/EhsaVBx3CJgrNViCsO/PPh0Zyyze7wk0urb?=
 =?us-ascii?Q?3uQB9qFjc/prolbxWNi2CoEYbeBANmrrNQqUbZtEw0hCeBk9CyBZ27vgW0tq?=
 =?us-ascii?Q?ONNsn1fmh0SvETB6fFF786Q6Af0CypVWISbymeQ8bqvhYt7pn97QGgM6H6z8?=
 =?us-ascii?Q?WutKAbOt0WtriO1oBfSUN01NzcVESOcOLia5A1irX+ZGVxD4Z3xv9UxDuR+z?=
 =?us-ascii?Q?epAXHgLT5Nz9z51zHfleRCGEuI/6QwttlCT5Q+L2w5OlkQK8DMPo5rJLB9dc?=
 =?us-ascii?Q?yQUqy2c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qhj2EehwP885e69wzoST8BxvbDivOUkP7ZVk4RXGIDj8jcjMWfd2WptSRlJg?=
 =?us-ascii?Q?us9hrkRDrM6cLBmEzJzvFm673uOdbmKe8lZ7LE3XRIpPO0CFU3wAegTB8ReT?=
 =?us-ascii?Q?18xsj2hknE810U17+kcR6G5JvOeyFLp00Bu9i5lXvx1P2ogYLZB19TIpfaN9?=
 =?us-ascii?Q?Z442tCRmIx+TEggZXTxAhZsZZolebHxCqmCt5JuyiPrTC62dI+dLolv04HF+?=
 =?us-ascii?Q?0r+RUNNuQDTGskMpEr4VoUhDLtooG5tdNtcxDHUXlVEtFhQIshM6NhSfGzyJ?=
 =?us-ascii?Q?zRSAOb1f0QtN1QEtQIBbzLEuNiPztwAxtoX0cFKgiJkeGV4W4NJ+EGEW3t6a?=
 =?us-ascii?Q?2cXRbNoB4fLHSX/657nMFlNdMapLljWTd1Fk1jwr1+aMFBTCfCzZTmsx5DWj?=
 =?us-ascii?Q?lgyO0P7jfAg0EUk9z8j/48sZ5+1JRp8OwdUU0ZOPsT+jLJBwUSGXa2hRXeeq?=
 =?us-ascii?Q?zN8Ldp0WGrkiJi+pPIo94aQFsreNTTJSAHTdAh5N4NRrkq1zx4GNPC8GSya0?=
 =?us-ascii?Q?tVD97h1UN8n0Iq2tEWSLFekdSs2NCfVDdWsxayzzDbUkLEqq9LtY4vmTqtL+?=
 =?us-ascii?Q?ztgCQ/pnnI7dKya2R/QLUTa6PYpKivE/Kimg5kEA3KhPvOTuVsUGlGmUAiaQ?=
 =?us-ascii?Q?xMK+lrVa0MjJBFSLJq5e35B13M2ydYdRvZCPT+KExGGiR+Ja1EjZmvasVIfq?=
 =?us-ascii?Q?qU6lrT+Lj2sTzNy8l4YUd1Ay9e2Sl/KLqYjd8HSEqzWgWpK6O0E+kAqkcB8d?=
 =?us-ascii?Q?JsCzLMgjuxClI4jVGrv2IKW9DFebkUJqeG53dPDhTqspHMYtxSfiYFQma+15?=
 =?us-ascii?Q?7CnK2KV2/b+9lEXov20fab8v957bkAXd4PH6P43gzqAeESyCd+g2oqTYj3En?=
 =?us-ascii?Q?TlnrznvJLGx2wNPV/bFvKreFMZ6BL7Ks3QJexukSWkrChiuMQN0rJVay7DkI?=
 =?us-ascii?Q?jd20Pwf5XrMZWrIB699oiLC8wwyQOFrFR35M3FSZThHX+F7hPwiLddep+U44?=
 =?us-ascii?Q?JHSY2/GIg6iTjfdzUcrsA8mdh2Sm4MAux6nqriOXjBOkLrdUKHlG2v3K4qdn?=
 =?us-ascii?Q?M5Pj/caTViOST3cGS4fr1v1FiBJ3vlB+PiOSzlborSZFOKC3CJhDgyFuKXRN?=
 =?us-ascii?Q?ybO8FMPW6ryfPlZCNWoAdl5X8RyDCI7n33xpZyQJgI6hkPAvdw3P9+HR+0bJ?=
 =?us-ascii?Q?kCbg/84fvvMLH9N1k9JLbQhP1VTtmfqUcSGc0Aey0oHvb8B3AS3FDpGRRjB/?=
 =?us-ascii?Q?TkPHMiSqBFNabolItf1DM+kvom0VYBgb2qt4eI39DRNnXlHKqYCEKaqKNzGU?=
 =?us-ascii?Q?G9CapXl2WVXEYMQ4GhA3XMIvmkniABUvrFYV3fa9NkrGQsab8ERELHBYNXFj?=
 =?us-ascii?Q?Ydmp/0e5H9UP/sBwnV4tqLqsJEyxVL5LXWCt3+N6zgpgyvUl86GRvwaMJUd+?=
 =?us-ascii?Q?g8CUgg6EQK5/GYSaOYMlRKx/9Qa2+a8d4ELjwhHFHCHIc4K+YFPOisJeqdil?=
 =?us-ascii?Q?fuyLuDmYHe28CdJ+N7YOyB5vrKr8ZXOjwUE0WmJ/kmwZpUfL69S/doh+3KuX?=
 =?us-ascii?Q?Ya7qJlzobcdLQFxD9Fgyx4JWFHBrg6wvEI2Ta4mkSMNs8Rz/Dlngwpu6KCro?=
 =?us-ascii?Q?TKS+lz7KaM027W18MD6b8NA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bee63c-5c20-4bb5-e6a5-08dd13ee607a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:01:09.9669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1doPy9hh9eLEiqr/mvyx30DwfQIljtigCDVCfiaUyf4lwFSgOt1U9XLmvsmzijVsmfX4IfTKt4yFL/XhahD4UCPCc4lUunoXKQC85+qtsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7611
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
index aa1cb0b51cb..39bc3ce8903 100644
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

