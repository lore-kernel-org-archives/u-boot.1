Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A49CF9C6E
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2C73889AA;
	Sat, 21 Sep 2024 05:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="litGhO3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D4D1884DB; Sat, 21 Sep 2024 05:44:23 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F8A88AB9
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4sShYR5NA6c6GKUGslHLI1HQ0pKA0zie8picwMSP3E4mk4yK1UrUo5J/HP9WKdtLGyylyKneEbKKMVPJhf6sYwwCyJhW18cSQCpvhrc3yKWFfEqXEPQj10ufGvh3GCb5XMZZRlxod2TZ42V6xrnQlskPjAPxkMAAniA/oxV1cnQefivTwpC560OE0miBUiP/4sWgfAlGLOLleKJ++tNKhS1H75XsSr9ujIeHLURO5nVixylX9MKHusU1u3Sqx1Mq6TD+HgeLNn38RDetRnOlijegnn88S0beW3Fher3Fvk6ZuS0/L10cUOyNdznZ3ysagBWjmDHJT5QDuFZwI3aVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmjXGSawNZLXUktFdcznmMLK4L+4znp39pnky4x2cAc=;
 b=kKL5Qa/VH3o+DifNV8Mruk5UHSWQQFEiIMANygIERFSVPmi+oGBxsBKNVpTqaNzoYxVo+T1k8BX66EgQ6sP6lTSXYUmHcKwWt8AyXnS/Zxo/MQ4Tc2XJfGjV/GqfaQOdc1ojr1RizJz07PzRWGKrnSihZ+Xd8GUWALjtStnufOjJR4KWPiwYnRKfriqTZ6Z3csZdrCAO9SAnl+eMPD+B2KQLjk2IcrblIlwy+IHuGaIV2a8WUJvBilJJdBam3gD+SFA4jgIOGoDgQRw4e2ABh7/MhQfGw6bGItKNKEvtwKciZvjJ7TwxfPEYkC9bjnsMzh9c9wGUz2C3nkLAF2kDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmjXGSawNZLXUktFdcznmMLK4L+4znp39pnky4x2cAc=;
 b=litGhO3tNC0FiZBlQpfv8UoFFAU7RpnUvKynqlUK1tKNAv/nBp6HcyS4o6unospXkf8yuANNJ2GTNxF1Bx8FBpuo3H05m4j197Mm2xySoryYy4/Opog03pq+qsFA071hrPGEtePf1FBgBn04eFAJ/50oLZFjTTMFRHEtYHgKC82SypP9nx/uokeAZ5a9iaX+VrteV5l3GiNfo24+63WhJBAI34ZXzmxDc/ONVzxvk+cMHCZyAwBpHxZ8ScH9W/KwJMITNf6yaYOyHStmOfKuHgoYQiXQ4tFCoSyHp0d31aSQ8jTrhswM0fTVGSJjr2/lUHLOZOTwOOa2qEPpCS3ssQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9418.eurprd08.prod.outlook.com (2603:10a6:10:421::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Sat, 21 Sep
 2024 03:44:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 03:44:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH v7 10/13] net/net: fix include ordering
Date: Sat, 21 Sep 2024 06:43:50 +0300
Message-ID: <20240921034353.1298452-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004595.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::440) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbbe481-1c48-43df-3a53-08dcd9efaa7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80BZcRAzROFFdezRYDdpmlm/RFXGL98WKtriO1V1OVsmuPAt1eCEDr8KCtsU?=
 =?us-ascii?Q?0c3irrpPQjBrFW4q9yIF9JG1/EukqR+HnyEA87F/ufFqo4yMA8ITVrFaNdyC?=
 =?us-ascii?Q?6NixZP/TTd639XYusCNi9mciTh8+9ekporouXyoQNNfT+OKysMDPwkMH3ZF2?=
 =?us-ascii?Q?/z70xQlAdN9QHdSvH0wRd+CIvdfECCqNRZvRWRE+lb28VT3y5T9upUGyWoPH?=
 =?us-ascii?Q?I7skmGHx1EfHICD61Ezl/TZfs9cNugw5LrT3YyaDWYZR4e5S4nNK2l0vQfFo?=
 =?us-ascii?Q?K/1pKLb1SU6gCLAzJQvhZi0gobSQy7IWEJGROzyckYaA+bGBqBN7/the5/WA?=
 =?us-ascii?Q?tSyHQTJibcoX8mDOlU28uENSevepM5/wYFgMvUDcpon3cjqtsl3ggdOYl8HH?=
 =?us-ascii?Q?88uXwpXmlbBCOjDCoAlLPyc6XlxOm6n4k71EeQ7whH+A0wg0eYVopin/3VlM?=
 =?us-ascii?Q?rnNGf0X7smqdpxXkaNWvrCfFVjagBi/KCtJp6/C4houwSJnoeLsF3YptENm5?=
 =?us-ascii?Q?tlRbLPFRbwAAKVtjYRYXz9zybg4h11Gp2SoyWOTQI++/WAToEesa59gTy8PA?=
 =?us-ascii?Q?AGv5SQEvlM2Iy/vLomAEO6RZX+/XnrNrtlOSRN+vl1JS7JF/JjjthmRUftTl?=
 =?us-ascii?Q?rl+fnePhneIa/ES/JfLYnAxJgDf3kc/Qy7JX4bkopNr+eDDuO2Qt3TCOkagP?=
 =?us-ascii?Q?gpJQ1DBVj39rrwbLZPq1IuXiCRry/PkU2jNgXcgogcI+/0Nw486Kd6fGfzAP?=
 =?us-ascii?Q?ev+zL99O8vtSX+Jr6FHxK4vB6IvsTbj9RYKsrSetRbnoqvDWL/rs91SsO/xK?=
 =?us-ascii?Q?EUVuRngIidXphXY2OMhm2f9pGln3LOZjVUY7qS8hMjKnWexUIPWpime7/EuM?=
 =?us-ascii?Q?gw9UR+rn3vzss1XdLu1D3rLh4aBgGPdJ0ke7mgouKfn8NLZUvfAhA4W5sYQd?=
 =?us-ascii?Q?rW48S7s+CFwi+pvuGrlbzW/5JGUJ8h3sJpksbBL7ATtCwgPFernwcpC/XaIo?=
 =?us-ascii?Q?5ZA0/b7kBgqfuF7DcpI60eg2H64asJYAB1yc+jKzyUIYz2RLCc/pjK9ot1mj?=
 =?us-ascii?Q?5LI7StBOp0rIsVX34sG6v7zXVB/w268nJ95CkXViMY0evtN/uq//EwEQTSry?=
 =?us-ascii?Q?kr+UaEXnKWqmc9T1P2cFLbrDyiRIAZxIjgor2LZjCgy0g1Q3MSxhkcIm328c?=
 =?us-ascii?Q?lZcrUHF5b6eMPkpHKwicnQcfLLrQ+XaF4F5mwrtPF7R3QaJUBw/ptapqxg93?=
 =?us-ascii?Q?x/juplPOMEk3L1SuMB8Gu1QH1/xJYnGU0ErKksDTD2dVFCNgmoNKTinBJ5Hx?=
 =?us-ascii?Q?fpA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wCfkecGMX/aELJ3zTySFXRIJGip8jWizFMnmWlCXKgoAaYZ6OVqId9zhhU6W?=
 =?us-ascii?Q?1hpu/I5/LaUuZAQ+TpcZx/Nno8fguswmvMg3dKU4zPTTXSmgk8b2lTfaSAV5?=
 =?us-ascii?Q?eyELAK2O/1huX65TKRgpRZOyelyeRzWFJTlYZYUt2+SMe2ii0ko7VyXdHjeH?=
 =?us-ascii?Q?ubdk6YU5mQHSmCvCHt5T8b8PWWbRalF/+qYBSK5J+EQY7n0YTNv8gg9whvmA?=
 =?us-ascii?Q?JXlCLkgbEQbLUWu3DxfOja3xTjqbD1uReFth1uBBVrspvRRIi51/pDlnqoF1?=
 =?us-ascii?Q?0cFfm7BJ9RSoSJs/qvVfCyb8dA8U4yw+16k9gz5ONU8ZAjIgFrnGFDHO61b6?=
 =?us-ascii?Q?s00qN9AzeDyZn0HLh0OsZmhrR27ZqTkOHAGlgv/soEimpk5p/RmA7lJlZ+Xg?=
 =?us-ascii?Q?ghP1RgaHvlJzF0GFL1Ma9TVTc7a9ZvVAbyuiuOXFM1lvNaMAxXn4gYW5XLzC?=
 =?us-ascii?Q?RQ0nUxCLNrigBDF9LImVNE5uig4TaU1BMF2trhJpQZE27h83Vss8Pgp0XUae?=
 =?us-ascii?Q?MWRY7+CRjz6cTjrzJ9e/OmCM9lU43AjF5zvlrvdn5HX7ZtaM+oA8zdDvsCJT?=
 =?us-ascii?Q?TQ3+/zxjBRlU1c3mrD6dBu4XH+Ni1jIeAZcMUe2pFPZdumH5j6YG1/e+XW3Q?=
 =?us-ascii?Q?weW4MxfldPNLru0KiyfbLMSaLyJdvDZ9RPhVVAmjXtWOJ3zklyLJmgNnWYwx?=
 =?us-ascii?Q?quJxSHoxDRFUgzJ7Fe1UeEfhapeAjou1WhVcQXAmI5kJvsqe05+acwH8qQ98?=
 =?us-ascii?Q?74YWP7iKP8bgyv8wjkfaS0Rbxt9AJ9/181jhX6PleK2O6awy7cGAMGDAK5bM?=
 =?us-ascii?Q?9XxkNGXeYI9LGPiNDIuv3xoOugMFPDG1FDf/cHRbigLbIPhawCvD/yZ5QgEm?=
 =?us-ascii?Q?M0Wq++dlhF6giOHfjOyhkkCkH8fD5s+gQa4m9LJdVmyBUUKUutXMkmgeTskq?=
 =?us-ascii?Q?2tNyVHJMpo3GlXBzoiF9QQvoHl2EYHu3a0ag3Cw4UJQ16RpebzZt4XsrUuZo?=
 =?us-ascii?Q?lCJTjyz2WiawmV7r61rwnm2x4IFKDdYr/d2/A+Xi05vrE34MR8rrxEvfG5+R?=
 =?us-ascii?Q?ojJPzuYojJY4823m+T60T2v9ptHiiyG8/25bk5H0bD7BUui+R1k0OaS/uFL6?=
 =?us-ascii?Q?7ugxQeJL/abJDD/ca4cFX4m2PQNtxOdSAOELNj/YknaLw8w58qL4rhzCcL2k?=
 =?us-ascii?Q?rScQKDMx62LUyXMqYSOol0RPV0/2uwoufF5nNel+5d6LCVsg7vrJCbcSzZqf?=
 =?us-ascii?Q?UHmqvGeMk/PQp18CSTTuwH784U33Q5HFp6t4UfW4TFTvXt3sv/b1DXFRmgAl?=
 =?us-ascii?Q?Te9pfn5w56rc2+X10syo9zKxVXsECIhYrzX0fh2dj0dURv0P8iig8ry5tHvD?=
 =?us-ascii?Q?ArePsVM6sSsuH+m9CIq707JuPjwJT/OmALvPwWMKa2xFb0Zq4ohHx2fW06DW?=
 =?us-ascii?Q?aGDmCS5oyAzk8CiMmH6pnpOLAjVC3YlLDr6tn5yhjmEQ0Yf3u7rwuvjMGrZr?=
 =?us-ascii?Q?yQbesyq+AGUK3rKBFjJXS4r18wyDbjKkh5YRYBt5SdqrlO+7YXibp98nJzze?=
 =?us-ascii?Q?vHR/vN6eKDScnL6yvIGOj/fIhBjSbcCjE0BdWF3KtCZWsOeFzmJGJSg2HBhN?=
 =?us-ascii?Q?Rcof8zfO8bnvKhd6NG2raVc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbbe481-1c48-43df-3a53-08dcd9efaa7c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:16.2094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzwmlRrKJstro1j0KmpSOCSF9ZfIdFbtXsmbUgmGgurJE8ICW6pAuYLX5iIG+oGu4hAl6k+2r398qIvjK+d6i9MxOr91Y/Hd1Ejs3AJc2j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9418
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

