Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14355CF887C
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA0A88DE1;
	Mon,  7 Oct 2024 22:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="F3ZQwlYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7B9588DD0; Mon,  7 Oct 2024 22:56:14 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86C088D7D
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqU1zqsbfIgCgMAbW0J/gy5gs899A660p7yzNHrwmZgiYykN347Ox8wPCO8fGkpUta896yXQM7q898UYzfqRchlCUWJenqWnkvwP22pERNu+ZfZYn4yhvpUuaxcF06/GSG/M/qCxRHoJLvA2tV4SrGPt3tl9iwdOPX58ftvM95CZjyAVpw4Kt9p6gHzVkHaDmTgxsaV6LyyYBYHIKXy++KGHi77Gh1g4nQd6Yz4zjWiFuGX40jWtS+oJoCCVe0nxI+yUF+33fWow9k2ahb5Dm5pMgIsDgKLOoiLcQ27krCStjVCmo3JGh0u5KFC+5tpqF7kOuNN/HBLMU6C44Z7iMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgcqraEHqPyykh/wlZqUjRNabygkd8IJ0z5+wTHSEng=;
 b=pNJbuA7QpB/Fa7uFhhT4+GIDidtGhfC7IcJg4Zzl/mrZhprPN9vCXdqfnrJh+sqNSnJGOzelo/brWfRonQ/SzYvtHaQh+ELJjkDWqX4La7mN/jNEhGTWySN/dwqTqbDOGki+K1d+OLuRV8VmEIM9j/Gx4OKJ9XQV6TtMlrTiXnuK+W6CtuEWWoTzAmQvQycQCw4SCi6f4eZp+Q1C8ZsQ4ifL7K78sQZ8lgo/hhTolZfvwLyUBC2nyeFc2RWSv+snpoBbZH03a6ihgYM5PXXmyteeS0s/riZLUNgfg8PiGXTe4/t80L8wFfSXjDTnVMwC1L4b0EPOaOpa0MnYVhjCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgcqraEHqPyykh/wlZqUjRNabygkd8IJ0z5+wTHSEng=;
 b=F3ZQwlYe6b53w5dK+823s6unfh8i7eUViC6sYlBFmwNTSm0bzL0nkHY1fGlyzePSDG2FZRY5RJBEBYzbTgRAecV1OpZb0m2ujI+KnOWg/lMTU2bk+tcFs0VFkA7ZyFN+AMnL8qwGOtZerii+U7of3gwSd8f2h+Y19EdKB55vKXnkWUdMUkXc3FFILTmvvjXo4s65xwtwNJBcJdVzyiD7MSVFZung1+lgIr9iI2spOOiZNb08CfZJ2x2uBN1hEvjXxyk0llNxNtMnP/+CD5rtmq0MzuVfnY4oIkaF9mxS/AId08sVi9H2y39x1lvfFLmmuxJ4jpxVGTDv7LCYp+rZ0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:56:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:56:11 +0000
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
Subject: [PATCH v10 10/13] net/net: fix include ordering
Date: Mon,  7 Oct 2024 23:55:40 +0300
Message-ID: <20241007205543.1632499-11-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 308e4947-94ff-4964-2a59-08dce7127961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nhd14gV71HDgNp25VS5ScTP9rw3F3zHKt5vb3YouBL250RPGMSww+1/Bp7qA?=
 =?us-ascii?Q?19KDi7qryLunGhdMF/WbW19dp5YlVTxCihG78SPmpb+fM1i9oAym5D6gXaw1?=
 =?us-ascii?Q?zWuFnc3000Duyt5v7U0XQc8djn9SlobHl249Fz9HnCnHS3WCSBE6dEAo/bch?=
 =?us-ascii?Q?gDUW+CDkFiIVLNozbFxHL4el2oVUVSpZJyA1Q4+jUX9u3gFlou526jvLnXjw?=
 =?us-ascii?Q?m7JStHVhw4NbZUH7bj2RaeCgsvGMb41lMAhHsasA7S4ejsL5p//12M6GRA1k?=
 =?us-ascii?Q?nlPhFKeWUUlJ9afvAN6XGYh+U0H1qnY3KeH3e/XkhYZcxcks08d1GFNQ5Q4F?=
 =?us-ascii?Q?KfaBIkmxjS2M9SIUeUlU+AU6XB464MhMuf7guPA8wK+YshzAA2k2LrjqUXqs?=
 =?us-ascii?Q?Ok+zyZEUsjxuMeqEFj6LVgrXyF1n9dp/sx9H34RjfcgjUuTt+3KTSRMNM5vE?=
 =?us-ascii?Q?HXl/zrFO0rV3ZXAdx6QHkzFnub1AJpkWoNSm0QC0vk5FzP1rH1YtTojOS+tn?=
 =?us-ascii?Q?4Ogb02S6zhECuzLJcdMQW+pgJ3y8GRTFFc4LIHC72+NYBJCCEevb8ZiMNx4f?=
 =?us-ascii?Q?RBGi2/jRp0qp1sHtJgfvcp+3xlAnDlNuoPnZ7stak6RTZHf3vHCD4NyFkxGn?=
 =?us-ascii?Q?/e/Kofiyu1SU+aez6Ulsa61rmScw+PgQLdHIDRTW7vY8I4ydvzetlUtcwFIN?=
 =?us-ascii?Q?qfKH6v5W03CY45gVRsURp1o0/u+YWYboACm6uum1RkK7/sJMMUx1p9eZIqq4?=
 =?us-ascii?Q?Pp7IPEfDwTNRYnWaKdKH0K6SngkfBRqbfXpi6iXlui3tFa6QyHolNFeiGZx9?=
 =?us-ascii?Q?CIQ8vjukHyTyj59Xv565cAfXTGlcOZSeWGcWFml10fSqNnHTXfaU8ZgUoJPY?=
 =?us-ascii?Q?MRNlLAviVK4dp0mBCN+9cxlIdGmWMzqvCu5Fp3uO/7TyNAKWBxgwkwrRu+Bh?=
 =?us-ascii?Q?4ZYG8HZsgeDzE1O/LLUX+1TtymZ76BtrxgomO/lVexJoCjxwpty+wtQybdFm?=
 =?us-ascii?Q?42CB0fOTGXhEmfGiLMhABZsSNGNM1T3TAfDZX13YbLgqJAfvHrf/Tp3i4UQk?=
 =?us-ascii?Q?8LnYG7cs6ZJLk+e+L81QsRJwATH4kATQIQoC1Pn/mK6hAajQ9Uifqqbhi8gI?=
 =?us-ascii?Q?Zxh/MTkLqst69os3kwr2oiJE+7WHOGnOXDwzXY7dQDjha2cVy4vO8aq5C62c?=
 =?us-ascii?Q?hYE2unDODYOtDDqfxnpslccJr72lZPKPuo/UdcVbetCZGge3UW8yUPMIbPyn?=
 =?us-ascii?Q?7q/cV3TL4tkZKAbMTZc1+3ZilU1l9Yc6YI454ArIf1v1cCiiUihYtstQyaJX?=
 =?us-ascii?Q?0Nk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XXM1puxIZkrGjwT86VIqcgYgbEu9UljUYFDLiPp6b9rcQrq50zEqVanVkqav?=
 =?us-ascii?Q?ZPflmdJQ/6w/YhL6somVOKVI3kyHdFfIFoVMY7HyKSK3yumVTxL05C3TLV2Y?=
 =?us-ascii?Q?VZACRTo1dVQyOvUxUk7WPDMuws2tYpdBBBIV4VNJv1JrU7wUoZ2KDA0Qi5qt?=
 =?us-ascii?Q?UHbdBi5xhgndd0XQJBjAnIkDC6vih5oyIu1oNbxu7YvcZEF/tvMWQQb3dv/V?=
 =?us-ascii?Q?CVvog3lXHfBPDmP25OEp/ATpr1NboqzEYUe7vBU39JRv5lVLnMK+vh49ewQR?=
 =?us-ascii?Q?bX+OvErhsus0HHk7ZELfcN8CHaCd2KmgPBzySZhZUnPZbNxL3Ekq4xZjtXY7?=
 =?us-ascii?Q?JegyL8/1Fw+r0lAUS3GMY1MTX9nezzWkUZrXyt7RRJhMOcHiNkHt5I99OZJj?=
 =?us-ascii?Q?dqiMEgSPsIWDPLTxc/sXa6EpR3vpsYyqZH3WLLLmSyw6XJ9LSqKRVzJD1RZc?=
 =?us-ascii?Q?4fReKYWMDxbMMzHTcRiVlVwPt1q+lQ56kYFwKMwxBSoncPoq6xePN9QlvR8v?=
 =?us-ascii?Q?v2gB4YL8SZXsuYfgX4TJgmnWJmZOOGatKb90NGwy0TnXAJ730sqn7cHx9m2a?=
 =?us-ascii?Q?BT/AZfgK/8yDTjCw0Rr/+b6cFdrTekjYnToigIl8Hr8eW+mgZ5HQ2cll1K5n?=
 =?us-ascii?Q?CggKmNxsZFJYj7eM0JX36dN/qsxs4My2lNaQa6f8r9G6Fa2QDezN+LY0RIyw?=
 =?us-ascii?Q?zu8X8I3Um4bPs82VX5/VM/oj5FkpqlJ6gvCl3786XqRXOJdDQ368wCnP08Ml?=
 =?us-ascii?Q?F0q+ZWD5HSJxhxyO/u3wjMaxVui4m5CLbgjFHfQ1WWvGRsjJdtg2YgDe2m98?=
 =?us-ascii?Q?VoFUllZNPra8JjvZq6iTRHPW06aTXR292D+Fc/zenxRF5avzTIrBfAhNRa0b?=
 =?us-ascii?Q?rO1kp0mA1urco9tLOuCFIXaXhnwweJ5JDcTNDHAi/Rx/xyDsacsslze5pu7E?=
 =?us-ascii?Q?E/1e5HsOswiT8j32VxZWc3TjylIcGmpNf/nQVJ/L9tUxs6L0vn5T7OgUYmyY?=
 =?us-ascii?Q?ol4FdsG137RmpVCIvUa1BWcpr41s9wHUCC9PUWS83EHFl7/6b6btTo5ZFENk?=
 =?us-ascii?Q?08aWwq2T0qVTvn+U0DpG0mPpDXylYat5uFvbUAM8FjwAS3aPDwHWhvDfAsLt?=
 =?us-ascii?Q?b0QNvEF9DLjWe7V8RqBEgP3k0IxFyIKu2V7O+6MaE1wg2Pai9FbFHgM+zkej?=
 =?us-ascii?Q?3WBOZ3khpfBjocoNHLJxvy7VQ+Y03uF4/Ec/RKQAe33ZVuG1B4FtZoJ/mqZr?=
 =?us-ascii?Q?qpty5iFHfOwT6ZYWF6sIMbXTBnLRQsUZCD0B3Xs8LXtkon/2S1wjcf8/4FHF?=
 =?us-ascii?Q?tZ/vU9BPIP0Vi0qsHT7vPdnQd28UmC0celwhgrXOUSuOVAUPlC1RpMDvWQh0?=
 =?us-ascii?Q?OnRiuwMNQ1qCrv1VCaTkEm6znVlExHk1O+dPa4iD3KNF+N/SmSI+EXOsL312?=
 =?us-ascii?Q?bW4vYYIQvnU8I5cc0qb70KJcy30AaDZ5r19QZjjHF2kBmunO5Z3uO7wK30j5?=
 =?us-ascii?Q?whJELitYHJA+MM06vPlqshNYLkGDEiZxijSN++BPDOAO5BvKjSGIA8w1yWah?=
 =?us-ascii?Q?48EqzuUikBTMC8Kp2+HRDMwRjd91yMQV45NgrlmFs8DuHaTQqSL9MgUy5bpN?=
 =?us-ascii?Q?giUsfwu2a775XODU8s4lQwE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 308e4947-94ff-4964-2a59-08dce7127961
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:56:11.3091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSqLYt0cHt7xDHVhEE1so2PUuSfc6jSNLW050vtulEaYmlKIGD3ZVVjQVdb5NfQO3LXgtqwfIhUxICFTRv3+P3MGWc+KRDCTmzq4P8E5PSA=
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

