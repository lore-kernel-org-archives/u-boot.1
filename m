Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD404E75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1ACC841E7;
	Wed, 24 Dec 2025 09:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Kea0X1o9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3978B841D2; Wed, 24 Dec 2025 09:24:30 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF316841DF
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ai/6nGMVgZQGrkA+H1MmS41llGlbnENnFXXdMfXyV6EZT6uq3/802ffK6Q5rO1bprXn8z12yRMYnJKKaieaWMTGE2DcuvgQq5EW8FS8eeODIihxDK81+8hUsarmAGtP32Vo1HRwcjlTholU14d9c9GDTWRza9kcO4hE3d7KWtJHBWYhEtBae+quQdzFU1rQaJDfR6QJaLXc+ws1yr/Xe8cZjr9KkPsr8eAnp+vwvqofYCeGkGMOyn8LtCaAWULo7riFZ90qPblGX78Yce4FkrBCKRgLbV7oemNyHfSrgVtc0XT6nYND+SpqtpgOSgYQyFSJktEquydrPie/RBxz2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t0sHtVv7HEqRAQzns+M1bg8W/CKn55O70Abf9esYJo=;
 b=zG9Qe7vg4ChnVm9bEDes1PMg4Pd2wm7BCMAOEB6O8hecSBo63ZRhsBeT4GdrZSDrx2tm23GuXZiQ1V0t9iPD3jnrU6xPlKZodaUZQrv+i7PkAkjE+yC3MQhl/HpL+U0L3b+ODXEPLNRfpdwO04itol8D5kfOIerqsBTsllsyGVfE8Xg4Z3deGyk2/Mrf5MmjCiss2OBOpYp3ZLwzx9rBGtNb4HPy/nIBw6xctJ5FeSstSwJ+lECkdqi4iEE5kcFwj5xh93X/SAUOdkesew9sAklTwOBq4GRMY4iR8OayqQYwR4QEnA1n/T5AOJTtHiMLaXrPYVAGiKsANJXHzg/Wzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t0sHtVv7HEqRAQzns+M1bg8W/CKn55O70Abf9esYJo=;
 b=Kea0X1o9qmuMIGyaj3FwB/ff1Rc4O6l/Rc9v80BqojUaaPefPmOwOlNBBEcnHbPS1JosjL50EtcJzI2sEZw91/jPMh1qzDGhqf+0IGUhRgmi4fM+vUaR8Pu0ntuHjPv1QfETb6kYaWepP7Qk5rB0DZw2GYmdyhKJRVsiuq0WHD58WdWwUMK9smwe5BYMst8Q0edgZ7eyCIyoP2py5EGDOHx4UiEk3svbkEa57KiyNG+6osyz7lYXWC3u9GaPLkwhzNDjutY5qmthe+kvLQgklo08lhX4aPWs3xcsEFI5ylE3ZOBiaEQq7L09CPBvG2NMbzoDiI2iMCoOvJ5DGl/+ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6721.eurprd08.prod.outlook.com (2603:10a6:20b:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 02/19] net: airoha: add initial support for multiple
 GDM port
Date: Wed, 24 Dec 2025 11:23:52 +0300
Message-ID: <20251224082409.1347373-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da1ec9d-604a-4cd9-4293-08de42c5d9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zc6W0+VzTZIYnfocvpyi36sEjmHP1PZAV0sz+UEpBc3ZE7jVOUMtD8qhdcIk?=
 =?us-ascii?Q?Hx2UVla019WZjv/UsdpTiIj7N/FvmPDOO7NAhc/rDnaOUzeNGVuRDNndweHx?=
 =?us-ascii?Q?SY3uiJPwjLa8Qyp152nk8QNXZ5LnUPvMhPEZOsRFtZDWrUQ/0IcRtmFcPuSX?=
 =?us-ascii?Q?4pIP2vuJwPiQiD1U2okzuvOkb+GNLyD3cM52Cpw+XUOgGtC3SO3HTEVPD2yl?=
 =?us-ascii?Q?8a0yO6/7ovXX8Wl+yfBplKvJ/NBF+8fxLFFdNlsbK32jvTo/0kKThgLTlKKN?=
 =?us-ascii?Q?sZs6Fab+6wMAMP0TfV3LQroA45b49ys2BH4DU/Mer4CRZHPaZPGh1Q/zm/1T?=
 =?us-ascii?Q?TTCdyDnG1GufXIwL2yu0Do0Q1w2ilC21ST7+4E6IqTBFHyl9EYOq91zTrGyD?=
 =?us-ascii?Q?lh10nE9HOHE4UcZIsySWIO0DnHEzm/vpi6LBCvEEQrrCIuQyJo81pNdcz3Qp?=
 =?us-ascii?Q?NCl/fY6zmGYEuVHHZUbEFAPjpxR6x7JiuoV3Kpx8B7+HC3BQ3jRHKVHGg1iI?=
 =?us-ascii?Q?csYv1TM+rWZJIGeO4+ZIuVOyJJLRvhPxS8K03+SMAau1Q3oUbI0xxUk7xkG/?=
 =?us-ascii?Q?8LlKR+A7P1olBoxRBUkS3v5QR1mPBJJxQeT+O2gqTzuPCaBI/uRG8n7sTUIt?=
 =?us-ascii?Q?JzeIkNPw0cTN7thiT5+18RfTyFPPikJpYjJySTGVOM8byyQSDFld+WgXxdNb?=
 =?us-ascii?Q?itIHEV07Dv8jl7IpKQ9STb82XDBlcMLvfQcOkiHtre+1n7LuS/DcuLFQNne1?=
 =?us-ascii?Q?RhAcyeE1+P0fU3hgl7UwFY72r4IcXCBj1zt8yPkBxxJ2bwSRmIQoQ6uK4MdL?=
 =?us-ascii?Q?2a+YPS0kMX7K/qwt4g/aDWvbEoYQA1obUiDKoGcGwdwG2LphKEmaoJP3bKRE?=
 =?us-ascii?Q?lsroJphWcfPWQTBPy54v9RA74i6/XgHo7hsRM+1qh3Shch2sJmEzPldhOK39?=
 =?us-ascii?Q?rLC54Ujq5J43ckDCYohVBQ+GyeiKDqnx3HUjorc5c2cZkfjBnjGOO4zhtA3l?=
 =?us-ascii?Q?ANNQYafOwUugxs+fUSTz4opP6xnMXmdDhPs+dN2dHUVp/ByBs4RMKvZOlLn8?=
 =?us-ascii?Q?zjD+6YYG+C8zq7auhGnd7zp/XO8eXT80lrMZiaVb1/JD4HOpGCdI9iyqeDDm?=
 =?us-ascii?Q?iJsoN2rcy3yN3HWUDxci2TC4KfFwGXJR2XMFWZpMH3AuCt/1K7FGAKyfRjm0?=
 =?us-ascii?Q?yT67Bw0Je73te6L2lA0JhUy7fi/5Lygd1Re4Mdvi3go5WfyJdKrbn9iEgjps?=
 =?us-ascii?Q?k98lKrEPYNqaj9ZwVVDYWSwvOjV4ERYCs3FqdMTFi+yuPiAijTOy8b/NHxa9?=
 =?us-ascii?Q?tclv8aM1t5jps/K+ru2ephDxTswnDM8fWy7mzLba9UBXUxIWQqnS/sDJp8tl?=
 =?us-ascii?Q?nBSbWH7DuWq3ZS9cqfnX+9jNBXhRb6iRKpmdPl2uILn0Vx0hYCfugUykvwaU?=
 =?us-ascii?Q?PMdPmwyITrY3PTSk5mquDiWjKuYi1Rz4XGsiPpQMhlYVutXSSM/m2ZqN3lEa?=
 =?us-ascii?Q?XhNfBpFSZs1FFzqb3VNCaBAtpjALkPeB9j9+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1GKtlw90E786AtCVNXcvUnr6Dd8tZUeD3AfRe+bXX47YQfuMCSOVYL5YVwPy?=
 =?us-ascii?Q?5//0l4Exu7xNlokEJicLiM71csB7qbGWhtY8WhinAVDRM9TKZccO+A7TpQSL?=
 =?us-ascii?Q?f4sRcuDOJXXOfgXcomVAnUNBQf8IBc2ueQia4netsu+hxkUKiZgE2lWmP0jk?=
 =?us-ascii?Q?4rqroHXRNPuOo2QAwgb3Bblbpw1PpA0J5pWJ4HVJTDcuS2KWa48VMTV/3YP9?=
 =?us-ascii?Q?nbWeB43Z220n4XTzE6TIKY5bvPyEbv9LAHRbnScHqPy9lD79PE449KFovlj2?=
 =?us-ascii?Q?tSO5XCwrL2YISXK/fjBmWZA1rt3HS138Tdd33BjWKEVuQtoklJGc5iY+6dN1?=
 =?us-ascii?Q?A//5KWPABgzulvcinVJU8OVYuhMe9qm3tW9kgj8OZIcSnlc5MvYU2wZ9m0b0?=
 =?us-ascii?Q?lU+Q47Nx0SDBNofliwXzvVgPgF7hB+52PkAeTwscgmIXbg99Uws+3Y3Y2oZr?=
 =?us-ascii?Q?fz7yN/tDCrPG/z/Bv5/KqAz6yyOshAPIpzqitwQ+WWiMjtqwR5nGGId2qt53?=
 =?us-ascii?Q?Qj286CUGngf3CRujhngG2E0CcZ+wg4nauL/zQE87rtHMSfagKfQOcHMN9JB4?=
 =?us-ascii?Q?R6dG2jPCaQhWs98K5FwvUKN5D6WTKkBGrE5nikXeg2/Dj/j4S7YSCeyfacn4?=
 =?us-ascii?Q?g4iKf0Z5r9NC0ordDx82Zdei4/w8O9Sb2WOaR7iqvLqTaQFl9/FmPf0bOi8r?=
 =?us-ascii?Q?cuJj8IGQjVKAKuPYdWZ8FTk+D0a1/wZq8SlvAFBbo/KrzzfEJF9sTC4kbslv?=
 =?us-ascii?Q?3Cw3uQEA9YZGsD6gyM+B+19mx/sqQzqzu6dJL7TfsM8THtM/ZYrK1WiUWibK?=
 =?us-ascii?Q?V35r/IpIbZPsSymY2QTqQDreZAw5WM4Rzt4KdyLk9B/YGbA8H3sUFjOtsawj?=
 =?us-ascii?Q?hVaeHnmAyTJW79Qg2gbAaPoN5ALDuJzgPPpyb5WIDAg3sQZn5QVrBqUZfSpb?=
 =?us-ascii?Q?ugy5pfxEkJVs5HEdLbIBqG1/g1Udr40ro6J1x0oVcsaczZXTBlMI288bsfhB?=
 =?us-ascii?Q?hZ1NEceMPVwC5zDLEkxEyVzjCd/5kKnhgKU/reUktjuHsR/e5U1WJv2RgsJf?=
 =?us-ascii?Q?1f8TwJQTY9GNeaR5sCxXmxAQ2CdIEv4d0zuEajb/Nq1qS4DyiHI/O9/K4DwE?=
 =?us-ascii?Q?jhbRuwdXEertfawxNnL1uy769E+ASghyzkd8/GBoS6HBlx1nWyMWOI+mj0Ox?=
 =?us-ascii?Q?BhQJDezG5sqlGkER6cIGATMPXSDF3XQTSrNdb+0SWN+0hcQAG+mCRM3efNZS?=
 =?us-ascii?Q?JbAXsmtEcwupXkmV2bePx/1tBHeT+R+5+5HKo7ycs40J8r9WmwqDTapmbi1s?=
 =?us-ascii?Q?PTIc4gGRf9Kez3/P9A8Rys58Rt8TDEf+OP+QX8RsT3k2R/WUysGZrSrDFOLQ?=
 =?us-ascii?Q?PA0N3EaPh1+Q3CWfP3D3PJtB0hsDSuVvyDmBAMtv4dW81Z+qdssDVusbdtZs?=
 =?us-ascii?Q?qbDKap8QH1m0R07JwWe/SFjpK0umm9pyp7t1/WL4x5UAJ+JQkQQJnzWjf5iZ?=
 =?us-ascii?Q?PoD3BBw6qCH/yOw1AfaIJfpgyebjBAsYZMhMFsUI1yUj9I00FXiusHHIrQ+2?=
 =?us-ascii?Q?E5aAA+wSpcby5DHu/3mKUn/cLkGQiPQmnNW61hz723wzD5j0vRJaf0Q5/j29?=
 =?us-ascii?Q?ccSl/I6rXunamLc8AUbNnCNOb3RQNsGjSUW7Surs6aABc/M24HezKIM2PDkl?=
 =?us-ascii?Q?UU9XC/qFrCVw70iMODNtNAx4AiqeEkuObkN+lWZ+WpzTckRgBuTemJSgVMx4?=
 =?us-ascii?Q?+9iEQ1uu5/fo2H6hNHctWqth8+uEC9Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da1ec9d-604a-4cd9-4293-08de42c5d9d7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:26.6518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAQ1a1atRzEVeby9KlS+wJyNb6u3MCGfbNx9PGizlW0wrqrBUC3EySyWb7pMWmrxNbUyukY0d4Qz7A4a2hajJo9/qVWNKZfriZB4tcEjXJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6721
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

From: Christian Marangi <ansuelsmth@gmail.com>

Rework the driver to support multiple GDM port. The driver is split to
main driver as a MISC driver with forced probe (by using the
DM_FLAG_PROBE_AFTER_BIND) and each GDM port register a ETH driver.

This permit a 1:1 implementation with the linux kernel driver and permit
to use the same exact DT nodes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/airoha_eth.c | 156 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 136 insertions(+), 20 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 3234d875887..31937137d59 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -9,6 +9,7 @@
  */
 
 #include <dm.h>
+#include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <mapmem.h>
 #include <net.h>
@@ -23,7 +24,7 @@
 #include <linux/time.h>
 #include <asm/arch/scu-regmap.h>
 
-#define AIROHA_MAX_NUM_GDM_PORTS	1
+#define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_QDMA		1
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		4
@@ -37,6 +38,8 @@
 #define TX_DSCP_NUM			16
 #define RX_DSCP_NUM			PKTBUFSRX
 
+#define AIROHA_GDM_PORT_STRING_LEN	sizeof("airoha-gdmX")
+
 /* SCU */
 #define SCU_SHARE_FEMEM_SEL		0x958
 
@@ -245,6 +248,21 @@
 #define QDMA_ETH_RXMSG_CRSN_MASK	GENMASK(20, 16)
 #define QDMA_ETH_RXMSG_PPE_ENTRY_MASK	GENMASK(15, 0)
 
+enum {
+	FE_PSE_PORT_CDM1,
+	FE_PSE_PORT_GDM1,
+	FE_PSE_PORT_GDM2,
+	FE_PSE_PORT_GDM3,
+	FE_PSE_PORT_PPE1,
+	FE_PSE_PORT_CDM2,
+	FE_PSE_PORT_CDM3,
+	FE_PSE_PORT_CDM4,
+	FE_PSE_PORT_PPE2,
+	FE_PSE_PORT_GDM4,
+	FE_PSE_PORT_CDM5,
+	FE_PSE_PORT_DROP = 0xf,
+};
+
 struct airoha_qdma_desc {
 	__le32 rsv;
 	__le32 ctrl;
@@ -309,11 +327,14 @@ struct airoha_eth {
 	struct reset_ctl_bulk rsts;
 	struct reset_ctl_bulk xsi_rsts;
 
+	struct airoha_eth_soc_data *soc;
+
 	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
-	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
+	char gdm_port_str[AIROHA_MAX_NUM_GDM_PORTS][AIROHA_GDM_PORT_STRING_LEN];
 };
 
 struct airoha_eth_soc_data {
+	u32 version;
 	int num_xsi_rsts;
 	const char * const *xsi_rsts_names;
 	const char *switch_compatible;
@@ -375,6 +396,8 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_switch_wr(eth, offset, val)			\
 	airoha_wr((eth)->switch_regs, (offset), (val))
 
+static struct driver airoha_eth_port;
+
 static inline dma_addr_t dma_map_unaligned(void *vaddr, size_t len,
 					   enum dma_data_direction dir)
 {
@@ -396,11 +419,26 @@ static inline void dma_unmap_unaligned(dma_addr_t addr, size_t len,
 	dma_unmap_single(start, end - start, dir);
 }
 
+static int airoha_get_fe_port(struct airoha_gdm_port *port)
+{
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_eth *eth = qdma->eth;
+
+	switch (eth->soc->version) {
+	case 0x7523:
+		/* FIXME: GDM1 is the only supported port */
+		return FE_PSE_PORT_GDM1;
+	case 0x7581:
+	default:
+		return port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
+	}
+}
+
 static void airoha_fe_maccr_init(struct airoha_eth *eth)
 {
 	int p;
 
-	for (p = 1; p <= ARRAY_SIZE(eth->ports); p++) {
+	for (p = 1; p <= AIROHA_MAX_NUM_GDM_PORTS; p++) {
 		/*
 		 * Disable any kind of CRC drop or offload.
 		 * Enable padding of short TX packets to 60 bytes.
@@ -738,11 +776,35 @@ static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 	return 0;
 }
 
+static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
+{
+	struct airoha_eth *eth = dev_get_priv(dev);
+	struct udevice *gdm_dev;
+	char *str;
+	int ret;
+	u32 id;
+
+	ret = ofnode_read_u32(node, "reg", &id);
+	if (ret)
+		return ret;
+
+	if (id > AIROHA_MAX_NUM_GDM_PORTS)
+		return -EINVAL;
+
+	str = eth->gdm_port_str[id];
+	snprintf(str, AIROHA_GDM_PORT_STRING_LEN,
+		 "airoha-gdm%d", id);
+
+	return device_bind_with_driver_data(dev, &airoha_eth_port, str,
+					    (ulong)eth, node, &gdm_dev);
+}
+
 static int airoha_eth_probe(struct udevice *dev)
 {
 	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
 	struct airoha_eth *eth = dev_get_priv(dev);
 	struct regmap *scu_regmap;
+	ofnode node;
 	int i, ret;
 
 	scu_regmap = airoha_get_scu_regmap();
@@ -755,6 +817,8 @@ static int airoha_eth_probe(struct udevice *dev)
 	 */
 	regmap_write(scu_regmap, SCU_SHARE_FEMEM_SEL, 0x0);
 
+	eth->soc = data;
+
 	eth->fe_regs = dev_remap_addr_name(dev, "fe");
 	if (!eth->fe_regs)
 		return -ENOMEM;
@@ -794,13 +858,42 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
+			continue;
+
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		ret = airoha_alloc_gdm_port(dev, node);
+		if (ret)
+			return ret;
+	}
+
 	return airoha_switch_init(dev, eth);
 }
 
+static int airoha_eth_port_of_to_plat(struct udevice *dev)
+{
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+
+	return dev_read_u32(dev, "reg", &port->id);
+}
+
+static int airoha_eth_port_probe(struct udevice *dev)
+{
+	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+
+	port->qdma = &eth->qdma[0];
+
+	return 0;
+}
+
 static int airoha_eth_init(struct udevice *dev)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_queue *q;
 	int qid;
 
@@ -818,8 +911,8 @@ static int airoha_eth_init(struct udevice *dev)
 
 static void airoha_eth_stop(struct udevice *dev)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 
 	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
@@ -828,8 +921,8 @@ static void airoha_eth_stop(struct udevice *dev)
 
 static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_qdma_desc *desc;
 	struct airoha_queue *q;
 	dma_addr_t dma_addr;
@@ -851,7 +944,7 @@ static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 	desc = &q->desc[q->head];
 	index = (q->head + 1) % q->ndesc;
 
-	fport = 1;
+	fport = airoha_get_fe_port(port);
 
 	msg0 = 0;
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
@@ -893,8 +986,8 @@ static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 
 static int airoha_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_qdma_desc *desc;
 	struct airoha_queue *q;
 	u16 length;
@@ -921,8 +1014,8 @@ static int airoha_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 
 static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_queue *q;
 	int qid;
 
@@ -963,8 +1056,9 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 
 static int arht_eth_write_hwaddr(struct udevice *dev)
 {
+	struct airoha_gdm_port *port = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
-	struct airoha_eth *eth = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	unsigned char *mac = pdata->enetaddr;
 	u32 macaddr_lsb, macaddr_msb;
 
@@ -976,19 +1070,32 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 		      FIELD_PREP(SMACCR1_MAC0, mac[0]);
 
 	/* Set MAC for Switch */
-	airoha_switch_wr(eth, SWITCH_SMACCR0, macaddr_lsb);
-	airoha_switch_wr(eth, SWITCH_SMACCR1, macaddr_msb);
+	airoha_switch_wr(qdma->eth, SWITCH_SMACCR0, macaddr_lsb);
+	airoha_switch_wr(qdma->eth, SWITCH_SMACCR1, macaddr_msb);
+
+	return 0;
+}
+
+static int airoha_eth_bind(struct udevice *dev)
+{
+	/*
+	 * Force Probe as we set the Main ETH driver as misc
+	 * to register multiple eth port for each GDM
+	 */
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
 	return 0;
 }
 
 static const struct airoha_eth_soc_data en7523_data = {
+	.version = 0x7523,
 	.xsi_rsts_names = en7523_xsi_rsts_names,
 	.num_xsi_rsts = ARRAY_SIZE(en7523_xsi_rsts_names),
 	.switch_compatible = "airoha,en7523-switch",
 };
 
 static const struct airoha_eth_soc_data en7581_data = {
+	.version = 0x7581,
 	.xsi_rsts_names = en7581_xsi_rsts_names,
 	.num_xsi_rsts = ARRAY_SIZE(en7581_xsi_rsts_names),
 	.switch_compatible = "airoha,en7581-switch",
@@ -1013,12 +1120,21 @@ static const struct eth_ops airoha_eth_ops = {
 	.write_hwaddr = arht_eth_write_hwaddr,
 };
 
+static struct driver airoha_eth_port = {
+	.name = "airoha-eth-port",
+	.id = UCLASS_ETH,
+	.of_to_plat = airoha_eth_port_of_to_plat,
+	.probe = airoha_eth_port_probe,
+	.ops = &airoha_eth_ops,
+	.priv_auto = sizeof(struct airoha_gdm_port),
+	.plat_auto = sizeof(struct eth_pdata),
+};
+
 U_BOOT_DRIVER(airoha_eth) = {
 	.name = "airoha-eth",
-	.id = UCLASS_ETH,
+	.id = UCLASS_MISC,
 	.of_match = airoha_eth_ids,
 	.probe = airoha_eth_probe,
-	.ops = &airoha_eth_ops,
+	.bind = airoha_eth_bind,
 	.priv_auto = sizeof(struct airoha_eth),
-	.plat_auto = sizeof(struct eth_pdata),
 };
-- 
2.51.0

