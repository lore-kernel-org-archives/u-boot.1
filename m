Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9493D3398C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 14:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9807389096;
	Mon, 28 Oct 2024 15:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="dqEenbIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7FC589110; Mon, 28 Oct 2024 15:32:19 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4F889083
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEIdDmAEvjpys0ulHXHowFpahkioXp0yrHZEc9Qf6vuNHpHjz2pyrQLbY1OM130X7FMWbcv727g+hY3aibXGNNTGz0hYWoNdSQXZl8a/xIJb4wQEUkiGRtu2JRMIZPOlqDAZCFczC6o8RalQMX9gnWaa/4C7rf32dhVMoilffRKFYNw0HRUNl0F0Tmj1k/+SM1D9mM1DaaenaMJnQhyD2fszBY1gNY7pGPluetqFKwqWeZ7Ss85gYTwJO+0x1LGkonaZ19BNTEY7qbTc7LO9wyfBoVcd5XTBSVyGWPlSW4rpDOojQ0/ACbLQjGb0dt1PQFO8RTc3AYtZ0st7YJ69sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQg1SWyPTbNzxQ+xm77B7XPyv/Xf/KMyt41u8d4+V+Y=;
 b=p3QaW0TwqKBjJT0dNZxq2hWI4L1dayg0ww0dst8vW4K4YIQDPnai8OIgjVwgQWX9RCUrK8msU5+/InQtT7Ib0nG1yewy8OdcVhjQhmxfBYvXSzh01+DZXxxqgFEetrlILX0ZLi9oLTRnYV2D/bQrbMzjY8ke8I5Xmca1B2HRLq4dndiCxCVUXR+ZY37mTwcIRoprOLQLYJVVDeYa3ywIk3wKMSd/IPPoYis/KAneptgkcc5471Zp40mE8Ms3lLosTckP7ncvFlMstY1IBUCBQI475D6vh6v5ufMUDjGspDVFS0SIOGbvP5mKYucqkiq8lneZ8xqDerBxI2twkq9mTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQg1SWyPTbNzxQ+xm77B7XPyv/Xf/KMyt41u8d4+V+Y=;
 b=dqEenbIyispju1t11U5S1vZbDA+1NGd6p95ZsYoPlm2OExdgWiBcuf5hsJCN+mwtHTN7ugXsq4/ZpgVNPPrIgIQ71CwYFTPlmOrv2groPSYpNiGT54mnaB9atKrEXImqnRBdvwypIOW3Jko6eBnko6QPqiwk7djoqb87xOF543jvm5jjgavn+GOTeB5FXpav+scRilpMVe/PE4ZreE7ppG1ah0Dnq1XwDA58SSIO2e67Hfjx4rm4Gb0UxQnlQPRFpm6UwapFVKVFiAxTjRrL8cJ1vgN0ax7/tSDLr4I+4G/SaRKxx9Hbt/p1v60tBBkuc5vRpgIxiRvaXXJlJgFa7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB9879.eurprd08.prod.outlook.com (2603:10a6:150:d2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:32:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:32:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v12 10/13] net/net: fix include ordering
Date: Mon, 28 Oct 2024 17:31:40 +0300
Message-ID: <20241028143143.1807305-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8abd9a-4fab-407d-9b9d-08dcf75d5029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZTV4db2UYEX3BWKrZYJ5DI1bteLSmzbcb/HMgTEZgRnOgUkAorf1Sum3KL37?=
 =?us-ascii?Q?XpnAVY954Z5dzC7tkQ59IrVzciHE1xd5MSuZ2ifRFNFLYgljJFWuk+0HXu+4?=
 =?us-ascii?Q?bXq4tMkBeYy6U+bDAxUgLhoDKr9A6HxD5TjJTS60Nsepl9b7T+52BK95sp8D?=
 =?us-ascii?Q?dgd/rzpAyL964dRW7JxozCZBYK6t7pYv/9olZydpHoTNJ2Yy9iiNO585zmcf?=
 =?us-ascii?Q?wLtldwxmC3MQLqFVL57XqFaBmq3Pd9deCs8gPftAeKRZ+mfoU3Qx8/zL8m4n?=
 =?us-ascii?Q?1amNRJemUg8hOcGntyo1x+aLzsRnLxeW+MyZOwnG8lxdJK97zBdhbbKQj2YQ?=
 =?us-ascii?Q?FPHUOT/i6ntpPS3vch/I7WI1gp3IWoWPMV67Z4PsWXqiMl/6ERMqp1hWvn05?=
 =?us-ascii?Q?qePdlOT12wIQt0k5pmT+TTBT6G6fCyM0JYRzQ2JvXOlQSo8oKocPsYFPFoWe?=
 =?us-ascii?Q?Gi4GPnoixWasERyfWKrJDUjIjlVfAxMKbyG2wAsBfoUyLHEgQjR0naLLg3rj?=
 =?us-ascii?Q?ZTW0Yx8EHcutCVQiwqwY7pLhh6tX1cwvVOlIuVTRAh/4rpH9MJQXI5FEjLC/?=
 =?us-ascii?Q?1qBJGxAMdTYZz76QF9+IB2Zwhk7Tdsr6wkTsySIiCGm95FPtmX9DhyIezx9B?=
 =?us-ascii?Q?/0p3+adPXTc+kdZUkle2fhbLm7w6FhG+nd0fBynWuwaZtIayTebbWWRocY4+?=
 =?us-ascii?Q?TtivXYi9P9OeQCriNWTF/7Gbc4CH80kNYh0anpDKs/bGMCBr4aLD5aAawCsY?=
 =?us-ascii?Q?L1j3LgsP5wUELa5Fd8YpUKXWdXt/1YuggM5/sFB0LNQCAaqCZqPGTDYk3X7g?=
 =?us-ascii?Q?hjQY1OYpIGvWK10S7uY2bOmXTA44lp7mHcNQskR3cSULf9jXA49124lwVzAz?=
 =?us-ascii?Q?F7yJEL6SrTTezfk32G+2gttNiikHwLdE+xneQo6mRMLkvpXjNgVK7uoxPtZx?=
 =?us-ascii?Q?qxmAx2x60Op3ATQP+ugF+S6nyW86m2vizZ1oLYAVSQCg7inK98pPX06YMvVS?=
 =?us-ascii?Q?rCg4vnSTXEwdEFO8DC7QuJiCFTMJA7kINlEs20WEivEV6YTfyqIeOJbyoIJo?=
 =?us-ascii?Q?MPNicethfGPDKFxuaBpWqWin4CP5Hlna2j3UdZtj78AzEp3T8/2SB8rLgk0C?=
 =?us-ascii?Q?R15HDLu+7aH3TZQ2HpLW4v4i7d+N4A65UCz9jyQGEnxERjh3q2ektTqDDj/d?=
 =?us-ascii?Q?/nspt0wFAlfTfR89msE3enf+1RYw1tInrMwfqCGCBqzREOh09Oaz7KM9+ZHL?=
 =?us-ascii?Q?zkumAe9VdHNPON/MSBYEmKNFysep50AIqEe3SQMZjlYoaO7IbBd3g8tduD5K?=
 =?us-ascii?Q?b8nxBdNqfDWbMixV7ujjjYtI4r8WuX4z1plBQuDIZvH+Pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gDogTOL6G1/UyQxs8bGqDESV/cgU+3JPWE7swXHSSEtviinM1DVrtvwP/Q6a?=
 =?us-ascii?Q?/IDqd5FvLvkBVPRvDYgtUrlm5PeXVxpxEk7KCD4FR7aD/zkpNFKgj+2asdON?=
 =?us-ascii?Q?bE8G1ULzkynB6ewrhEZOqCn/i+W93lXtyGXNoikU9tlwdirWT/kPElEtoO1b?=
 =?us-ascii?Q?2g70oP3gLgkuUYN86Cj6bOSwlDcQyF2Rbip0BCIGWpzbmLzcCZs9YBSPcjO3?=
 =?us-ascii?Q?IqWmZmpru8sybrBJ7bEcMxw0p/se6xM+bRtCe/6yWMrNWMoy/rCgMIY0nPOL?=
 =?us-ascii?Q?B3mA+h8q8Wsldkn2Qtm6sbJqBBNVePL6MGBYiKY0XDm26yhR/b34I+jUA0hI?=
 =?us-ascii?Q?PJdZwonyTN0WEmeBF6ua9/L5vppzEJlFhxoPOCb7rlYYzcKgGkuZ5nkjStSJ?=
 =?us-ascii?Q?QYQvbk5Ob/aO9uk5PCH95xmzHC5uboEk+X50CgrEqXz5BfYHIBJc/N1YFWqW?=
 =?us-ascii?Q?aL3bRLRC+yAwE8aF7K6WfzPA3KvynDKWVKPmBDhezuUgliyMBnt59V8Y2yKV?=
 =?us-ascii?Q?S12aUUV7g74n26xVB61VCeyDfy90Y29YCFooRhb+i/OYs9yp0ynwV8ZjhFsj?=
 =?us-ascii?Q?wRZ/fd2qxlhTqNKY4IGQUCMKuCz4xXBvBaqDen2FGM93TcOTJxbXrz2TWtFE?=
 =?us-ascii?Q?saJow9Z+lg8A7MMV7sSV7tj5OIiOnAc60Cxna93971TLzWHSw/Z0xCLxe3jg?=
 =?us-ascii?Q?NOQbFm0J2oJVZkpgm5TABUcDcmYNRCnIpcn8hSJ+f3bGCin6GuDiJT/8S05m?=
 =?us-ascii?Q?Yh0Ny1mzNpK94vNeeYMI9N77FLb6ZW994nP/1uCap9SbXbKK36px8er4JKOt?=
 =?us-ascii?Q?aldvBP3IVljtNuaQCpJdF0Z+RQXielL3KxjQ12MYZeRIdCjK9TBIlvkG1qHs?=
 =?us-ascii?Q?enuIbWFrhStTE5C+Q0ny2uke0SH85SxiCqnH/Vd/S4qop2liC9+bo4rJKgIb?=
 =?us-ascii?Q?NgAOi8iw82lrQ58YEJRvTT5ArmA9a7cxbB2lma/hs3+gueRbfuH3KA2fcI4c?=
 =?us-ascii?Q?RUBSxVyogE7UaHwO8Dx9xDC9hlzzLgpjIzeKVbHQQvuJBPCs7/dEmUiz68Fr?=
 =?us-ascii?Q?qVMMmK0Uc8WMcBZDqWvDYABKVow1pKlbuRTRIK9MEj4Ltgfusnl00PGsf/8H?=
 =?us-ascii?Q?l0Ji982DNUuRD+r2pEn7mw3ec2j06nDNZ4xh8SFHjK0lbvyJ0m9BnfCJnp3i?=
 =?us-ascii?Q?zjsHz2ZA3GUvMD0Y5E2+4ljo94IBlzZWQ+AlRMV+XsDBlhZNvZoeC81J8vjF?=
 =?us-ascii?Q?/InmQE3cl/6Ao9k2YtaXIDA2cSWYNqpxozczZtJsh1KoETP/QYcaI5+NBvIC?=
 =?us-ascii?Q?1yQIip/tEFef6jYNfCLbv/5wyZLs/5Po39PXB3mZdAvSLEYoc6hx7Mx7dMYE?=
 =?us-ascii?Q?t8yTpw5Dl9qar1NaDD/KaLsy16R/rUz8omaN+mQ5X+eW+5/zG+46B/8X5c2H?=
 =?us-ascii?Q?ARe/OwKQRnrfC4yMRL05J4xpMgyqaH+nCUuuEHoaqee9lyIHMsGXehnKDPJQ?=
 =?us-ascii?Q?Oy4ty4QHkhnVBjlGXjNmhHsKiCoR3wMoGWr+fQWDUG0BmNqCYkRmw69VFMVp?=
 =?us-ascii?Q?IN7RCFJDxxyMYgpcd+m08ipkbIASTUyWPnPEqDIP/dhVCJ7dg/uZdipD+OwQ?=
 =?us-ascii?Q?P6zP/xOOsJZt0k/zSXGFxJI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8abd9a-4fab-407d-9b9d-08dcf75d5029
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:32:13.0124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t53Gco9W9/Wrp6GAGxQ1d1ZeWysIIBX2slHUB7Rl6jtqkfiO4yZo3c354JDY5BaS0p93UJsrebxGNb92Ub5SZR+5gRbQiwtilkuPdAXpcD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9879
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

