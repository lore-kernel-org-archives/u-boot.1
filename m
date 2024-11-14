Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065CFD637DF
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F691895E3;
	Thu, 14 Nov 2024 04:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sDdrmHzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A30C895A3; Thu, 14 Nov 2024 04:37:07 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::712])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7381895CA
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm5gWjp5/zieHnUdTHV3M044G2P5wwaEPixTzxIgZPgcIB3av6pHWJlTc1lsdUsqmmI15FC2JL2qFVcoYVmdHMs/Pky2p0D1uU2cUj8/luJcy5ewosK6/nzPaAdJxcyLjKta6swaEqaP8jjPwMepzzsv0obQd5NLzrVkj2H8+WveMwP8z6pBBQII5I5QiH/VQyoHbEQN15Cz4g3Pl8gQD8oO8bkv+s8dM7vwQhhjIv8WR1XwAxtXNIJfzb2S261IrUEPT7PPd/oi3z0TPHXOel1IeOLJckTjn2MIrXUh6EaoqiyqCzfrxG7nQYIAfNdaazFJ41F5jQh7EQnEh3+vDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQg1SWyPTbNzxQ+xm77B7XPyv/Xf/KMyt41u8d4+V+Y=;
 b=bNN16Jh+YD/yRLA5kgWA4QPjNdSoTvYJRmDQLSVeAbvA+LwCZd9EwBiho+3ajJzTYZndhpmgUp0aDHzlLkGGszmZHcIHiz6kLo057vn/WYyZFDtIwVRW3X5Kt9JtPj2nzHcBwESaCkmxQqdYiJ3OT3/zDf4cmme8voAWLVn4djVkVr+aEdMzKa9aaKb1wcWluskyo/YVIlyAYpgH9OMhi1ckqZ08rbDYELKAK0uuUN/8x4RzSfD8lOp/sSeLqY2msxtu4vVFR3zVlVMjN7ssnK13yvWhGIsudN7bhLE+xfDxIivUu+e67z4C2Lj4B0mGxc4fTvbEgXCFniHapba8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQg1SWyPTbNzxQ+xm77B7XPyv/Xf/KMyt41u8d4+V+Y=;
 b=sDdrmHzmeTpKijX92kTnNNLEpTHkvAJJ/v2df7l0r869tWG3VdbZOy09mFJurw24AGKWZ43DSJreuxFOCpOSnOhXsCHlVTw5NcBi0MUGfuiL2fhFf6t5PQSFifu82wGWIzelqV//Dcu+wUqo8KFYMIiVtQNOpgqJvtvNJ9DlEuOcjexfPsGnyGmKeVjMjQKHFL/Mf9EWJZhU06kYGF2PsWurgONGfqILm93WIsWKPPOE3SUmaRpkbiTuhSZZfvN8f5YlNVLQoYCec4Wq9nenZbc4iTPzU/BZlX2tMikfEs/RXLdmABEI7yaj3LMu1gyywg/0dUkf5Tj4WBRYAvV9FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB10338.eurprd08.prod.outlook.com (2603:10a6:102:30d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 03:37:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 03:37:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v13 10/10] net/net: fix include ordering
Date: Thu, 14 Nov 2024 06:36:43 +0300
Message-ID: <20241114033643.623355-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: 01da85da-2302-4620-4efb-08dd045d9ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2WLqU3Iut9uqWp6Sh7TPRTjR3BbQuc4srl5ytRKCaoi7PxP9fJgdzgkh76Zu?=
 =?us-ascii?Q?2J2ETOu2SBMhyYV6bzktnUWzbbPGQkAh7Qx7m+IZfglbJikJJUqruKwUyDT/?=
 =?us-ascii?Q?2uJqyot1ImWYnkiI9Zlv9pLJJ6rJD1LWccWCiV+ekFjAVgDjP+t8g9N993Sb?=
 =?us-ascii?Q?1ausEPnEWXkvVRIqCApHEF+aU/xgfyDZ3nKJHCdt6FkP6s8SfaHAlVVzVPXX?=
 =?us-ascii?Q?5Kc+XmYIeOfON0YxZv3KXxgz4oxtZiekb/S25GarrZhE1Rs2pp51J1zl0+xi?=
 =?us-ascii?Q?bEZ5ldkS1eA9o/KnCKjqR8F17uLMGGZ4oBq/YhhnYjqdvLPWFXMzPlvqs2Jp?=
 =?us-ascii?Q?8nWLSjQee8P0iwsleY4fn2ggaW1CB10gZhwwlGEmzTspa6smZ4mQwKSkWxwt?=
 =?us-ascii?Q?svwdJX7vljWO6Ps8+izLVThSTimQEO8V+Q6Jp83fR6uuyzeVh5aosh7tJY4Z?=
 =?us-ascii?Q?lkhVzMSuqQtWPB7yd3wfQ54AL7Xn8eJkJ3bScaQhbQNnglr1WvuqBvA6hrOJ?=
 =?us-ascii?Q?DH4diLbv7crN216gxs8Q1mHbtiPVj+qB3Umn737VgXkQHRZ67OAagaTUkTb9?=
 =?us-ascii?Q?lYh7PB/5juMFIiIC5LQG6WWdzbFXeA7GlsOjezovL3xv9QilcwPVVeIxRpn1?=
 =?us-ascii?Q?fiHNTeEp6yXU2b+IMj2gRc2y8LRBD6yJQXG7pguiB55qFGpRBeRkEfT/2sHL?=
 =?us-ascii?Q?TDR4sBoK9LHtjCtRKQc0bA/IDfW4ymPpcMBfaSfOHYcjKKm72BKKqno00lAs?=
 =?us-ascii?Q?eP4yOyL4KXCdYMR4KDBN2cHgVh7qBd4/0eS18bWW2yAzuNUwBkEg8v43ZPcC?=
 =?us-ascii?Q?NRK65+MdYLIG+OLBfpV6hy+iD0u2N3dAJCAqW74RPyElgRHcy1/+Zj1aKzWh?=
 =?us-ascii?Q?rBjnKVref/FTIOIdlEA73KaNvnM30GhldN/r7SdupF15/SBH9HEiAWF1ug+a?=
 =?us-ascii?Q?7LKpgKFi6GzMJG3Px7zFZ4Cyr1kDUtK+pkZbXNST42NjTo+8gD1GFRpfNIQR?=
 =?us-ascii?Q?AF/TUk6jaAbyPbrRcRVymrFT/H7Luu/ICO6hojR0981ugJSzdJ2Igz5wv4zO?=
 =?us-ascii?Q?7P1P7HkZkvVSACPFZatAU2P6j5hwWNTZTMRXsHJcPDVDmB1OLDEU0jCWwX1l?=
 =?us-ascii?Q?wqjAnBP+zuAbzKH0woCpSYq8HZ2Q7RWw3nBcHVichJ5chlE7++d2O5SgTeP6?=
 =?us-ascii?Q?eSYQhxMyZE5/rLO5Cu3k1j5Eh9PpE8n8tJvMmBitCLigJeMB7geB0pY0EEkX?=
 =?us-ascii?Q?PYa3VEkyl8C2MMomyRETj0nX+2lARyHZ9zMVv4qMS4M/BHbuHFkJvAbWZqs9?=
 =?us-ascii?Q?7VhAT5UOjoIgPy1IVGeGdDLTbIvAERmrr1+LB5QB+1AnTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8KxLa30/7lo9q70KWaxbJCzInYIzLrgCVlwdto66j366+Uf4QHG5ea4Qj/OI?=
 =?us-ascii?Q?wx+2uK9NuR0zjasGLGj3Zp1v7RI8e5LNr2R8+QWHVGOOu1VBw16tK5nQwPv1?=
 =?us-ascii?Q?K9rR60HSueykEbFtZylLcMVI2QTirU+iWy8l38i/4BSvZ4CtI4O//4ajYpkL?=
 =?us-ascii?Q?6gAVy/4AemzaDSG9XgiatkmlbDqXJNC/KbvaPJSo6oqgDrSozKY5+YxERgHu?=
 =?us-ascii?Q?Jx/yJgSqiF542wSYowySyntArxbU3jS9PJnQRu+zKv+q1bkMpgu0lRUWGu9S?=
 =?us-ascii?Q?5wVou0Pg/3pF5SFHSRlP1uxiqWBrZDHToC2FuGj67+ZRwbDQj0hP56kAAtjy?=
 =?us-ascii?Q?rmI5WryWX0GSyY4ez70xIWKs3PabA68d6+R91jDRScmJypV3VXWXKYSw5m39?=
 =?us-ascii?Q?TYy9TFvUbkzUF3EGSbCOllSy1sjdqpS+w1kDzFneZ0AUTiqfs65wm+l0JPUe?=
 =?us-ascii?Q?FsRKSOkz0ZqfqvJW7TSgsQgtWNqBAUhPE7Bpn9Az3JsloNJ1Td/AjAr6AmuP?=
 =?us-ascii?Q?cMgR0JRaEoly4hn6FYdcVqnKkX2tWFst1UBVCNLbZIoRUShLqhEx5zUcHeNt?=
 =?us-ascii?Q?f1DPye0zTBy433hCXuUvt1wZh4Gcc5QGI3PkK/oDhK968YIHgUyOljoMbBan?=
 =?us-ascii?Q?n0aVi223QLhfFYtEuNTitf5b9DZ2UgTpyXeQiA9ze2ojwuJsMHRBCafha+sk?=
 =?us-ascii?Q?b9DTS2sBQyaCAhI9B5onCUVg9Tl5FfIbr5zq28zDpAe6p4WiDBlpgIDYNpLJ?=
 =?us-ascii?Q?/gSJbOUDtWg2uLOk9GXd8OnHLjLolPDkIoGCHFRHiBNKD6MeJBhpblxN9i9Z?=
 =?us-ascii?Q?cxw9wbjS1sC50xrzF7WKdDobKZh6VgH3mjY9Iyo9btwE+SUWPXfGaMIgneH0?=
 =?us-ascii?Q?ctGyES80BRp7r2Qqaw2rNxhTQEgcExyuE4Ww+IZr/tigF+gjiEcvaTv2u/Gg?=
 =?us-ascii?Q?8kjc/uL551yIyVbnsRng/o+e5IfZtHhcFrYSB2l0Yx+d2ekg93LEI4UgUDUC?=
 =?us-ascii?Q?RqMb4u7FLcl28gN6FAOwr/f5Yb5Njfbpu6+you9pbC+FYdyFu8HGZvXrAR0M?=
 =?us-ascii?Q?FSwbBcOBOXpxpc2/LXjC/Uj8cebovgxWMDzmcEWhihh25YxT6Hcs0VdqxGWC?=
 =?us-ascii?Q?Vnu3Ijq71HGvgo4xFVIJXPSpWzxIxKShDhpSQQ4LZs1U6TW/YR3oMDM7mN7y?=
 =?us-ascii?Q?sAbJD1sjNyOY9+0sj0h70JvQ6q8g4ibHRl0MXS907iuVZPz0iNZePv/s3JEf?=
 =?us-ascii?Q?VI978VAPOV6YikqbM6t9K/uf2lsCs2iaPyqc3P8x4l3hcy1thg8ETJx2SvPx?=
 =?us-ascii?Q?XKKXJwCqoLDtQwFAud6cuo4cKXsAJ++6XuXKcqMbCuXvTKOlV3IH4L7cZSS8?=
 =?us-ascii?Q?A3CIBZfYuux78hqnbwJYmzPWGYnxVCp+U8ctr9N+17o5TeNQMkhwxnJJfgB4?=
 =?us-ascii?Q?DE799y7/Kio87LudB80d4ffRqVE5D6gcaV6+pW/2xKVr/ag75PbJbVpRqOE1?=
 =?us-ascii?Q?5nXm4GeIa83uNxvxM+t4zfv3QKGlX7kdBfXvzdBgaAoKWu9B3RRerjhH4FZz?=
 =?us-ascii?Q?Eldm9ci6rnTWkM2oVFKMgp2g/tn/PGne+Px0F0Pw5Lfu7+7uWdcOzim9cXlr?=
 =?us-ascii?Q?02Js9c71RemjQpINtrdVqyE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 01da85da-2302-4620-4efb-08dd045d9ad9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:37:03.4253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWVRIT2KEolkHcrjp+YEcII+Soz0SgbZnn0WMRws1kM8wQR5DVJNAjq9dj3zcJNgMnKLKl8OOrTaIHRgG/ZtRaNYFRdLGWklxr0iT2vYLqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB10338
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

